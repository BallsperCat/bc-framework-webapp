bc.templateSelectDialog = {
	/** 点击确认按钮后的处理函数 */
	clickOk : function() {
		var $page = $(this);
		
		// 获取选中的行的id单元格
		var $tds = $page.find(".bc-grid>.data>.left tr.ui-state-highlight>td.id");
		if($tds.length == 0){
			bc.msg.alert("请先选择！");
			return false;
		}
		
		//var $trs = $grid.find(">.data>.left tr.ui-state-highlight");
		var data=[];
		var $right = $($tds[0]).closest(".left").siblings();
		$tds.each(function(i){
			var $this = $(this);
			var index = $this.parent().index();
			var $row = $right.find("tr.row:eq("+index+")");
			var id=$this.attr("data-id");
			var $tdright =$row.find("td.first");
			var	type = $row.find("td:eq(1)").text();
			var subject = $row.find("td:eq(2)").text();
			var path = $row.find("td:eq(5)").text();
			var code = $row.find("td:eq(3)").text();
			var version = $row.find("td:eq(4)").text();
			var desc = $row.find("td:eq(6)").text();
			//模板类型编码
			var typeCode = $row.data("hidden").typeCode;
			data.push({
				id: id,
				type:type,
				subject:subject,
				path:path,
				code:code,
				version:version,
				desc:desc,
				typeCode:typeCode
			});
			
		});
		
		logger.info($.toJSON(data));
		// 返回
		$page.data("data-status", data);
		$page.dialog("close");
	}
};