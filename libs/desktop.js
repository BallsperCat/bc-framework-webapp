/**
 * desktop
 * 
 * @author rongjihuang@gmail.com
 * @date 2011-09-29
 */
(function($, undefined) {

	$.widget("ui.bcdesktop", {
		version : "1.0",
		options : {
			loadingText : "正在加载 ......"
		},

		_create : function() {
			var self = this;

			// 初始化顶部的系统菜单
			var $top = this.element.find(">#top");
			var $sysmenu = $top.find(">#sysmenu");
			$sysmenu.show().menubar({
				position : {
					within : $(window)
				},
				select : function(event, ui) {
					$li = ui.item;
					$a = $li.children("a");
					if(logger.infoEnabled)
						logger.info("click:name=" + $li.text() + ";href=" + $a.attr("href"));
					var option = $li.attr("data-option");
					if(!option || option.length == 0) option="{}";
					option = eval("("+option+")");
					option.mid=$li.attr("data-mid");
					option.name=$a.text();
					option.type=$li.attr("data-type");
					option.url=$a.attr("href");
					option.standalone=$li.attr("data-standalone")=="true";
					if(option.url && option.url.length>0 && option.url.indexOf("#")!=0)
						bc.page.newWin(option);

					//避免a的#跳转
					event.preventDefault();
				}
			});
			
			// 双击打开桌面快捷方式
			var $middle = this.element.find(">#middle");
			var $center = $middle.find(">#center");
			var $shortcuts = $center.find(">a.shortcut");
			
			//对ie，所有没有定义href属性的a，自动设置该属性为"#"，避免css中的:hover等没有效果
			if($.browser.msie){
				this.element.find("a[href=''],a:not([href])").each(function(){
					this.setAttribute("href","#");
				});
			}
			this.element.delegate("a.shortcut","dblclick",this.openModule);
			
			// 禁用桌面快捷方式的默认链接打开功能
			this.element.delegate("a.shortcut","click",function(){return false;});
			
			// 允许拖动桌面快捷方式
			$shortcuts.draggable({containment: '#center',distance: 20});
			//$shortcuts.draggable({containment: '#desktop',grid: [20, 20]});
			//$("#shortcuts" ).selectable();
			
			// 允许拖动菜单项到桌面添加快捷方式的处理
			$sysmenu.find('li.ui-menu-item[data-type!=1]').draggable({
				containment: '#center',
				distance: 20,
				cursor: "move",
				helper: function(){
					var $this = $(this);
					var tpl = '<a class="shortcut ui-state-highlight"';
					tpl += '<a class="shortcut"';
					tpl += ' data-mid="' + $this.attr("data-mid") + '"';
					tpl += ' data-type="' + $this.attr("data-type") + '"';
					tpl += ' data-standalone="' + $this.attr("data-standalone") + '"';
					tpl += ' data-order="' + $this.attr("data-order") + '"';
					tpl += ' data-iconClass="' + $this.attr("data-iconClass") + '"';
					tpl += ' data-name="' + $this.attr("data-name") + '"';
					tpl += ' data-url="' + $this.attr("data-url") + '"';
					if($this.attr("data-option"))tpl += ' data-option="' + $this.attr("data-option") + '"';
					tpl += '><span class="icon ' + $this.attr("data-iconClass") + '">';
					tpl += '</span><span class="text">' + $this.attr("data-name") + '</span></a>';
					tpl += '</a>';
					return $(tpl).appendTo("#top");
				}
			});
			$center.droppable({
				accept: 'li.ui-menu-item[data-type!=1]',
				activeClass: "ui-state-highlight",
				drop: function( event, ui ) {
					//$(this).addClass( "ui-state-highlight" );
					var $cur = $center.find("a.shortcut[data-mid='" + ui.helper.attr('data-mid') + "']");
					logger.info("$cur.size()=" + $cur.size());
					if($cur.size() == 0){
						var $shortcut = ui.helper.clone().css("top",(ui.helper.position().top - $middle.position().top) + "px")
						.removeClass("ui-state-highlight").hide().appendTo($center)
						.fadeIn().draggable({containment: '#center'});
						
						//通过ajax保存该快捷方式
						bc.ajax({
							url: bc.root + "/bc/shortcut/save4drag", 
							data: {mid:$shortcut.attr("data-mid")}, 
							dataType: "json",
							success:function(json){
								bc.msg.slide(json.msg);
							}
						});
					}else{
						//以动画显示已经存在的快捷方式
						$cur.addClass("hoverShortcut").fadeOut(function(){
							$cur.fadeIn(function(){
								$cur.removeClass("hoverShortcut");
							});
						});
					}
				}
			});

			// 快速工具条中条目的鼠标控制
			var $bottom = this.element.find(">#bottom");
			$bottom.delegate(".quickButton","mouseover", function() {
				$(this).addClass("ui-state-hover");
			});
			$bottom.delegate(".quickButton","mouseout", function() {
				$(this).removeClass("ui-state-hover");
			});
			$bottom.delegate(".quickButton","click", function() {
				$this = $(this);
				var mid = $this.attr("data-mid");
				var $dialogContainer = $middle.find(">.ui-dialog>.ui-dialog-content[data-mid='" + mid + "']").parent();
				if ($this.hasClass("ui-state-active")) {
					$this.removeClass("ui-state-active")
					.find(">span.ui-icon").removeClass("ui-icon-folder-open").addClass("ui-icon-folder-collapsed");
					$dialogContainer.hide();
				} else {
					$this.addClass("ui-state-active")
					.find(">span.ui-icon").removeClass("ui-icon-folder-collapsed").addClass("ui-icon-folder-open")
					.end().siblings().toggleClass("ui-state-active",false);
					$dialogContainer.show().end().dialog("moveToTop");
				}
				// $this.toggleClass("ui-state-active")
				return false;
			});

			// 显示隐藏桌面的控制
			$bottom.find("#quickShowHide").click(function() {
				var $this = $(this);
				var $dialogContainer = $middle.find(">.ui-dialog");
				if ($this.attr("data-hide") == "true") {
					$this.attr("data-hide","false");
					$dialogContainer.show();
				} else {
					$this.attr("data-hide","true");
					$dialogContainer.hide();
				}
				return false;
			});

			// 注销的控制
			$top.find("#quickLogout").click(function() {
				window.open(bc.root + "/logout","_self");
				return false;
			});
			
			// 桌面日历
			var $right = this.element.find(">#middle>#right");
			$right.find("#indexCalendar").datepicker({
				showWeek: true,
				//showButtonPanel: true,//显示今天按钮
				firstDay: 7,
				showOtherMonths: true,
				selectOtherMonths: true
			});
			
			$center.show();
		},

		_destroy : function() {
			this.element.undelegate().unbind();
		},
		
		/**双击打开桌面快捷方式*/
		openModule: function() {
			$this = $(this);
			logger.info("openModule:" + $this.attr("class"));
			var type = $this.attr("data-type");
			var option = $this.attr("data-option");
			if(!option || option.length == 0) option="{}";
			option = eval("("+option+")");
			option.mid=$this.attr("data-mid");
			option.iconClass=$this.attr("data-iconClass");
			option.name=$this.attr("data-name");
			option.order=$this.attr("data-order");
			option.type=$this.attr("data-type");
			option.url=$this.attr("data-url");
			option.standalone=$this.attr("data-standalone")=="true";
			if(logger.debugEnabled)
				logger.debug("a:dblclick,type=" + type);
			bc.page.newWin(option);
			//if(type == "2"){//打开内部链接
			//}
		}
	});

})(jQuery);