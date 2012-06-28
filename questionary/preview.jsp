<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div title='<s:text name="questionary.title"/>' data-type='form' class="bc-page"
	data-saveUrl='<s:url value="/bc/questionary/save" />'
	data-js='js:bc_identity,<s:url value="/bc/questionary/form.js"/>'
	data-initMethod='bc.questionaryForm.init'
	data-option='<s:property value="formPageOption"/>' style="overflow-y:auto;">
	<s:form name="questionaryForm" theme="simple" cssStyle="width:630px;">
		<div id="div1">
			<table class="formFields" cellspacing="2" cellpadding="0">
				<tbody>
					<tr>
						<td style="text-align: center;font-size: 30px;position: relative;left: 250px;display: inline-block;width: 160px;"><s:text name="e.subject"/></td>
					</tr>
					<tr>
					<td style="position: relative;right: -390px;">答卷期限：<s:date name="e.startDate" format="yyyy-MM-dd"/>~<s:date name="e.endDate" format="yyyy-MM-dd"/> </td>
					</tr>
				</tbody>
			</table>
		</div>
		<div id="testArea">
			<s:iterator var="b" value="e.questions">
			<!-- 单选题 -->
			<s:if test="type==0">
				<table class="ui-widget-content" cellspacing="2" cellpadding="0" style="width:100%;border-width: 1px 0 0 0;">
					<tbody>
						<tr class="widthMarker">
							<td style="width: 10px;">&nbsp;</td>
							<td >&nbsp;</td>
						</tr>
						<tr>
							<td style="font-weight: normal;text-align: left;"><span style="color: red;"><s:text name="orderNo"/>.</span></td>
			               	<td style="font-weight: normal;text-align: left;"width="140xp;"><s:text name="subject"/>
			               		&nbsp;<s:if test="required==true"><span style="color: red;">(必选)</span></s:if>
		               		</td>
						</tr>
						<s:iterator var="c" value="items" >
							<tr class="option">
								<td>&nbsp;</td>
								<td class="value" >
									<div style="position:relative;margin: 0;padding: 1px 0;min-height:19px;margin: 0;display: inline-block;">
										<s:radio cssClass="standard" name="%{'standard'+#b.orderNo}"  list="#{'true':''}" cssStyle="width:auto;width:1em;"/>
										<s:text name="subject"/>
									</div>
								</td>
							</tr>
						</s:iterator>
						</tbody>
					</table>
				</s:if><s:elseif test="type==1">
				<!-- 多选 -->
				<table class="ui-widget-content" cellspacing="2" cellpadding="0" style="width:100%;border-width: 1px 0 0 0;">
					<tbody>
						<tr class="widthMarker">
							<td style="width: 10px;">&nbsp;</td>
							<td >&nbsp;</td>
						</tr>
						<tr>
							<td style="font-weight: normal;text-align: left;"><span style="color: red;"><s:text name="orderNo"/>.</span></td>
			               	<td style="font-weight: normal;text-align: left;"width="140xp;"><s:text name="subject"/>
			               		&nbsp;<s:if test="required==true"><span style="color: red;">(必选)</span></s:if>
		               		</td>
						</tr>
						<s:iterator var="c" value="items">
						<tr class="option">
							<td>&nbsp;</td>
							<td class="value" >
								<div style="position:relative;margin: 0;padding: 1px 0;min-height:19px;margin: 0;display: inline-block;">
									<s:checkbox cssClass="standard" name="%{'standard'+#b.orderNo}" cssStyle="width:1em;"/>
									<s:text name="subject" />
								</div>
							</td>
						</tr>
						</s:iterator>
						</tbody>
					</table>
				</s:elseif><s:elseif test="type==2">
				<!-- 填空 -->
				<table class="ui-widget-content" cellspacing="2" cellpadding="0" style="width:100%;border-width: 1px 0 0 0;" data-type="<s:property value='type'/>">
					<tbody>
						<tr class="widthMarker">
							<td style="width: 10px;">&nbsp;</td>
							<td >&nbsp;</td>
						</tr>
						<tr>
							<td style="font-weight: normal;text-align: left;"><span style="color: red;"><s:text name="orderNo"/>.</span></td>
			               	<td style="font-weight: normal;text-align: left;"width="140xp;"><s:text name="subject"/>
			               		&nbsp;<s:if test="required==true"><span style="color: red;">(必答)</span></s:if>
		               		</td>
						</tr>
						<tr class="option">
							<td>&nbsp;</td>
							<td class="value" >
							<s:property value="%{formatCompletion(items.iterator().next().subject)}" escapeHtml="false"/>
							</td>
						</tr>
						</tbody>
					</table>
				</s:elseif><s:elseif test="type==3">
				<!-- 简答 -->
				<table class="ui-widget-content" cellspacing="2" cellpadding="0" style="width:100%;border-width: 1px 0 0 0;">
					<tbody>
						<tr class="widthMarker">
							<td style="width: 10px;">&nbsp;</td>
							<td >&nbsp;</td>
						</tr>
						<tr>
							<td style="font-weight: normal;text-align: left;"><span style="color: red;"><s:text name="orderNo"/>.</span></td>
			               	<td style="font-weight: normal;text-align: left;"width="140xp;"><s:text name="subject"/>
			               		&nbsp;<s:if test="required==true"><span style="color: red;">(必答)</span></s:if>
			               	</td>
						</tr>
						<tr class="option">
							<td>&nbsp;</td>
							<td class="value" >
								<textarea name="subject" placeholder='<s:property value="%{items.iterator().next().subject}"/>' rows="3" class="ui-widget-content noresize"></textarea>
							</td>
						</tr>
						</tbody>
					</table>
				</s:elseif>
				</s:iterator>
			</div>
			<div class="formTopInfo">
				状态：<s:property value="%{statusesValue[e.status]}" />&nbsp;&nbsp;&nbsp;&nbsp;登记：<s:property value="e.author.name" />(<s:date name="e.fileDate" format="yyyy-MM-dd HH:mm:ss"/>)
				<s:if test="%{e.modifier != null}">
				，最后修改：<s:property value="e.modifier.name" />(<s:date name="e.modifiedDate" format="yyyy-MM-dd HH:mm:ss"/>)
				</s:if>
			</div>
		<s:hidden name="e.id" />
		<s:hidden name="e.author.id" />
		<s:hidden name="e.type" />
		<s:hidden name="topics" />
		<input type="hidden" name="e.fileDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.fileDate" />'/>
		
	</s:form>
</div>