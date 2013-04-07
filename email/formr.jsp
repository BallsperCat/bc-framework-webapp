<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div data-type='form' class="bc-page"
	data-js='<s:url value="/bc/email/formr.js" />,js:redactor_css'
	data-initMethod='bc.emailFormr.init'
	data-option='<s:property value="formPageOption"/>' style="overflow-y:auto;cursor: default;">
	<s:form name="emailFormr" theme="simple" style="margin:10px;" >
		<div tabindex="-1" class="email-subject" style='text-align:left;font-size:20px;outline:0;color:black;margin-bottom:8px;position:relative;'>
			<s:property value="e.subject" escapeHtml="false"/>
			<ul class="inputIcons email-open">
				<li class="emailFormr-fromNow inputIcon" style="width:auto;height:atuo;font-size:14px;cursor:default;font-weight:normal;margin-right:3px;"></li>
				<s:if test="%{openType == 2}">
				 	<li class="emailFormr-reply inputIcon ui-state-default ui-corner-all"  title='点击回复邮件'>
				 		<span class="ui-icon ui-icon-arrowreturnthick-1-w"></span>
				 	</li>
			 	</s:if>
				<s:if test="%{openType == 1 || openType == 2}">
				 	<li class="emailFormr-forward inputIcon ui-state-default ui-corner-all" title='点击转发邮件'>
				 		<span class="ui-icon ui-icon-arrowthick-1-e"></span>
				 	</li>
			 	</s:if>
			</ul>
		</div>
		
		<!-- 发件人 -->
		<div class="email-history" style="text-align:left;font-weight:normal;position:relative;width:150px;">
			<div style="width:60px;text-align:right;display: inline-block;"><s:text name="email.sender"/>：</div>
			<s:property value="e.sender.name" />
			<ul class="inputIcons email-open">
			 	<li class="emailFormr-show inputIcon ui-state-default ui-corner-all" >
			 		<span class="ui-icon ui-icon-triangle-1-s" title="点击显示详细信息"></span>
			 		<span class="ui-icon ui-icon-triangle-1-n" title="点击隐藏详细信息" style="display:none;"></span>
			 	</li>
			</ul>
		</div>

		<s:if test="%{receiverList != null}">
			<div class="email-history" style="text-align:left;font-weight:normal;display:none;">
				<div style="width:60px;text-align:right;display: inline-block;"><s:text name="email.receiver"/>：</div>
				<s:iterator var="t" value="receiverList" status="st">
					<s:if test="%{#st.index > 0}">、</s:if>
					<s:if test="%{type == 4}">
						<s:property value="name" />
					</s:if><s:else>
						<s:set name="owen_user_index" value='0' />
						<s:set name="owen_group_users" value='""' />
						<s:iterator var="map" value="owenGroupUserMap">
							<s:if test="%{id == key}">
								<s:iterator var="list" value="value">
									<s:if test="%{#owen_user_index > 0}">
										<s:set name="owen_group_users" value='%{#owen_group_users+"、"}' />
									</s:if>
									<s:set name="owen_group_users" value='%{#owen_group_users+name}' />
									<s:set name="owen_user_index" value="%{#owen_user_index+1}" />
								</s:iterator>
							</s:if>
						</s:iterator>
						<span title="<s:property value="#owen_group_users"/>">
							<s:property value="name" />
						</span>
					</s:else>
				</s:iterator>
			</div>
		</s:if>
		<s:if test="%{ccList != null}">
			<div class="email-history" style="text-align:left;font-weight:normal;display:none;">
				<div style="width:60px;text-align:right;display: inline-block;">抄&nbsp;&nbsp;&nbsp;送：</div>
				<s:iterator var="t" value="ccList" status="st">
					<s:if test="%{#st.index > 0}">、</s:if>
					<s:if test="%{type == 4}">
						<s:property value="name" />
					</s:if><s:else>
						<s:set name="owen_user_index" value='0' />
						<s:set name="owen_group_users" value='""' />
						<s:iterator var="map" value="owenGroupUserMap">
							<s:if test="%{id == key}">
								<s:iterator var="list" value="value">
									<s:if test="%{#owen_user_index > 0}">
										<s:set name="owen_group_users" value='%{#owen_group_users+"、"}' />
									</s:if>
									<s:set name="owen_group_users" value='%{#owen_group_users+name}' />
									<s:set name="owen_user_index" value="%{#owen_user_index+1}" />
								</s:iterator>
							</s:if>
						</s:iterator>
						<span title="<s:property value="#owen_group_users"/>">
							<s:property value="name" />
						</span>
					</s:else>
				</s:iterator>
			</div>
		</s:if>
		<s:if test="%{bccList != null && openType == 1}">
			<div class="email-history" style="text-align:left;font-weight:normal;display:none;">
				<div style="width:60px;text-align:right;display: inline-block;">密&nbsp;&nbsp;&nbsp;送：</div>
				<s:iterator var="t" value="bccList" status="st">
					<s:if test="%{#st.index > 0}">、</s:if>
					<s:if test="%{type == 4}">
						<s:property value="name" />
					</s:if><s:else>
						<s:set name="owen_user_index" value='0' />
						<s:set name="owen_group_users" value='""' />
						<s:iterator var="map" value="owenGroupUserMap">
							<s:if test="%{id == key}">
								<s:iterator var="list" value="value">
									<s:if test="%{#owen_user_index > 0}">
										<s:set name="owen_group_users" value='%{#owen_group_users+"、"}' />
									</s:if>
									<s:set name="owen_group_users" value='%{#owen_group_users+name}' />
									<s:set name="owen_user_index" value="%{#owen_user_index+1}" />
								</s:iterator>
							</s:if>
						</s:iterator>
						<span title="<s:property value="#owen_group_users"/>">
							<s:property value="name" />
						</span>
					</s:else>
				</s:iterator>
			</div>
		</s:if>
		
		<!-- 日期 -->
		<div class="email-history" style="text-align:left;font-weight:normal;display:none;">
			<div style="width:60px;text-align:right;display: inline-block;">日&nbsp;&nbsp;&nbsp;期：</div>
			<s:date format="yyyy-MM-dd HH:mm" name="e.sendDate" />&nbsp;&nbsp;(<s:property value="week4cn" />)
		</div>
		
		<s:if test="%{e.content.length() > 0}">
			<div class="ui-widget-content" style="border-width: 0 0 1px 0;height:1px;margin-top:10px;"></div>
			<div class="email-content redactor_editor unselectable" unselectable="on" style='font-weight: normal;'>
				<s:property value="e.content" escapeHtml="false"/>
			</div>
		</s:if>
		
		<div class="ui-widget-content " style="border-width: 0 0 1px 0;height:1px;"></div>
		<s:property value="attachsUI" escapeHtml="false"/>
		<s:hidden name="e.id" />
		<input type="hidden" name="e.sendDate" value='<s:date format="yyyy-MM-dd HH:mm:ss" name="e.sendDate" />'/>
	</s:form>
</div>