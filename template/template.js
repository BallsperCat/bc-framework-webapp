/**
 * 选择模板信息
 * @param {Object} option 配置参数
 * @option {String} category [可选]模板分类，默认为空，可设置单个或多个，单个：例如'经济合同',多个：逗号连接 如'经济合同,劳动合同'					
 * @option {Boolean} multiple [可选]是否允许多选，默认false
 * @option {Boolean} paging [可选]是否分页，默认false
 * @option {String} status [可选]模板的状态，默认正常，设为空则代表所有状态
 * @option {Function} onOk 选择完毕后的回调函数，
 * 单选返回一个对象 格式为{
 * 					id:[id],				--模板id
 * 					typeName:[typeName],	--模板类型名称
 * 					subject:[subject],		--模板标题
 * 					path:[path],			--模板附件
 * 					code:[code],			--模板编码
 * 					version:[version],		--模板版本号
 * 					desc:[desc],			--描述
 * 					typeCode:[typeCode]		--模板类型编码
 * 					}
 * 如果为多选则返回的是对象集合，[对象1,对象2]。
 */
bc.selectTemplate = function(option) {
	// 构建默认参数
	option = jQuery.extend({
		mid: 'selectTemplate',
		paging: false,
		title: '选择模板信息'
	},option);
	
	// 将一些配置参数放到data参数内(这些参数是提交到服务器的参数)
	option.data = jQuery.extend({
		status: '0',
		multiple: false,
		category:option.category||''
	},option.data);
	if (option.title)
		option.data.title = option.title;
	if (option.multiple === true)
		option.data.multiple = true;
	
	//弹出选择对话框
	bc.page.newWin(jQuery.extend({
		url: bc.root + "/bc/selectTemplate/"+ (option.paging ? "paging" : "list"),
		name: option.title,
		mid: option.mid,
		afterClose: function(status){
			if(status && typeof(option.onOk) == "function"){
				option.onOk(status);
			}
		}
	},option));
}