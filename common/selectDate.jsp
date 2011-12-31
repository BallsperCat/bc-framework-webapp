<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:property value="title"/>' data-type='form'
	class="bc-page" data-js='<s:url value="/bc/common/selectDate.js" />'
	data-initMethod='bc.selectDateFrom.init'
	data-option='{
		"buttons":[{"text":"<s:text name="label.ok"/>","click":"bc.selectDateFrom.clickOk"}],
		"width":330,height:130,modal:true
	}'
	style="overflow-y: hidden;">
	<s:form name="selectDateFrom" theme="simple"
		cssStyle="margin:8px;position: relative;">
		<input type="text" name="curDate"
			data-validate='{"type":"date","required":true}'
			data-cfg='{"changeYear":true}'
			value='<s:date format="yyyy-MM-dd" name="curDate" />'
			style="width: 100%;" class="bc-date ui-widget-content" />
		<ul class="inputIcons" style="right: 0px;">
			<li class="selectCalendar inputIcon ui-icon ui-icon-calendar"
				data-cfg='curDate'></li>
		</ul>
	</s:form>
</div>