<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="placeOrigin.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc/placeOrigin/save" />'
	data-js='<s:url value="/bc/placeOrigin/form.js" />'
	data-initMethod='bc.placeOriginForm.init'
	data-option='<s:property value="formPageOption"/>' style="overflow-y:auto;">
	<s:form name="placeOriginForm" theme="simple">
		<table class="formTable2 ui-widget-content" cellspacing="2" cellpadding="0" style="width:385px;" >
			<tbody>
				<tr class="widthMarker">
					<td style="width: 80px;"></td>
					<td >&nbsp;</td>
				</tr>
				<tr>
					<td class="label">*<s:text name="placeorigin.type"/>:</td>
					<td class="value"><s:radio name="e.type" list="#{'1':'省级','2':'地级','3':'县级'}" cssStyle="width:auto;"/></td>
				</tr>
				<tr>
					<td class="label">*<s:text name="placeorigin.name"/>:</td>
					<td class="value"><s:textfield name="e.name" cssClass="ui-widget-content" data-validate="required"/></td>
				</tr>
				<tr>
					<td class="label"><s:text name="placeorigin.core"/>:</td>
					<td class="value"><s:textfield name="e.core" cssClass="ui-widget-content" data-validate='{"minLen": 6,"maxLen": 6,"type":"number"}'/></td>
				</tr>
				<tr>
					<td class="label"><s:text name="placeorigin.higherlevel"/>:</td>
					<td class="value relative"><s:textfield name="pname" readonly="true" cssClass="ui-widget-content" />
						<ul class="inputIcons">
							<li id="selectPname" class="inputIcon ui-icon ui-icon-circle-plus"
								title='<s:text name="title.click2select"/>'></li>
							<li id="clearPname" class="clearSelect inputIcon ui-icon ui-icon-circle-close" 
								data-cfg='e.pid,pname,pfullname'
								title='<s:text name="title.click2clear"/>'></li>
						</ul>
					</td>
				</tr>
				<tr>
					<td class="label"><s:text name="placeorigin.fullcore"/>:</td>
					<td class="value"><s:textfield name="e.fullcore" readonly="true" cssClass="ui-widget-content" /></td>
				</tr>
				<tr>
					<td class="topLabel" ><s:text name="placeorigin.fullname"/>:</td>
					<td class="value" colspan="3" ><s:textarea name="e.fullname" rows="3" readonly="true" cssClass="ui-widget-content noresize"/></td>
				</tr>
				<tr>
					<td class="topLabel" ><s:text name="placeorigin.desc"/>:</td>
					<td class="value" colspan="3" ><s:textarea name="e.desc" rows="3"  cssClass="ui-widget-content noresize"/></td>
				</tr>
				<tr>
					<td class="label"><s:text name="placeorigin.status"/>:</td>
					<td><s:radio name="e.status" list="#{'0':'在案','1':'禁用'}" cssStyle="width:auto;"/></td>
				</tr>
				<tr>
					<td class="label" colspan="2" rowspan="2">
						<div class="formTopInfo">
							登记：<s:property value="e.author.name" />(<s:date name="e.fileDate" format="yyyy-MM-dd HH:mm:ss"/>)
							<s:if test="%{e.modifier != null}">
							<br/>最后修改：<s:property value="e.modifier.name" />(<s:date name="e.modifiedDate" format="yyyy-MM-dd HH:mm:ss"/>)
							</s:if>
						</div>
					</td>
				</tr>		
			</tbody>
		</table>
		<s:hidden name="e.id" />
		<s:hidden name="e.pid" />
		<!-- 上级的全名 -->
		<s:hidden name="pfullname" />
		<s:hidden name="e.author.id" />
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
	</s:form>
</div>