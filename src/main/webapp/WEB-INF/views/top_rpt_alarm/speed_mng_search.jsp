<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


   	<%--검색 영역--%>
	<div class="nociteA log_top" style="margin-bottom: 20px;">
       	<div class="search_bar">
			<div style="margin-bottom: 5px;">
	       		<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0">&nbsp;
	       		<c:choose>
	       			<c:when test="${srchParam.flag eq 'user'}"><b>나의 보고서 알림</b></c:when>
	       			<c:when test="${srchParam.flag eq 'team'}"><b>팀 보고서 알림</b></c:when>
	       			<c:when test="${srchParam.flag eq 'admin'}"><b>보고서 알림(관리자)</b></c:when>
	       		</c:choose>
			</div>
		
			
			<form id="srchFrm" name="srchFrm" method="post" action="/speedMngList" >
				
				<input type="hidden" id="pageIdx" name="pageIdx"/>
				<input type="hidden" id="code" name="code" value="${srchParam.code}"/>
				<input type="hidden" id="flag" name="flag" value="${srchParam.flag}"/>
								
				<div class= "tableStyle21">
					<table>
						<colgroup>
							<col width="6%" />
							<col width="18%" />
							<col width="6%" />
							<col width="18%" />
							<col width="6%" />
							<col width="18%" />
							<col width="6%" />
							<col width="18%" />
						</colgroup>
						
						<tr height="38">
							<th bgcolor="#e7ecf1">진행현황</th>
							<td>
								<select id="rptState" name="rptState" style="width:150px;">
			         	       		<option value="999">-- 전체 --</option>
					            	<option value="0">미결</option>
					            	<option value="1">결재</option>
					            	<option value="2">종결</option>
					            	<option value="3">위임취소</option>
					            	<option value="31">위임취소 중</option>
					            </select>
				            </td>
				           
							<th bgcolor="#e7ecf1" >사고 유형</th>
							<td>
					            <select id="speedType" name="speedType" style="width:150px;">
					            	<option value="999">-- 전체 --</option>
					            		<c:forEach items="${speedCodeList}" var="speedCodeList" varStatus="speedCodeListStatus">
					            			<c:if test="${!speedCodeListStatus.first}">
						            			<option value="${speedCodeList.col_cd}">${speedCodeList.col_val}</option>
					            			</c:if>
					            		</c:forEach>
					            </select>
					            <input type="checkbox" id="chkOneStop" name="chkOneStop" <c:if test="${srchParam.chkOneStop eq '1'}">checked</c:if> value="1">OneStop
							</td>
							
							<th bgcolor="#e7ecf1" >접수일</th>
							<td>
								<input type="text" class="calendar srchInput2" id="suimStartDate" name="suimStartDate" size="10"  value="${srchParam.suimStartDate}" maxlength="10" /> ~ 
								<input type="text" class="calendar srchInput2" id="suimEndDate"  name="suimEndDate" size="10"  value="${srchParam.suimEndDate}" maxlength="10"/>
							</td>
							
							<th bgcolor="#e7ecf1" >알림일</th>
							<td>
								<input type="text" class="calendar srchInput2" id="alarmStartDate" name="alarmStartDate" size="10"  value="${srchParam.alarmStartDate}" maxlength="10" /> ~ 
								<input type="text" class="calendar srchInput2" id="alarmEndDate"  name="alarmEndDate" size="10"  value="${srchParam.alarmEndDate}" maxlength="10"/>
							</td>
						</tr>

						<tr height="38">
							<th bgcolor="#e7ecf1" >접수번호</th>
							<td>
								<input class="srchInput" type="text" size="20" id="srchAcceptNo" name="srchAcceptNo" value="${srchParam.srchAcceptNo}" maxlength="10"/>
							</td>			
						
							<th bgcolor="#e7ecf1" >사고번호</th> 
							<td>
								<input class="srchInput" type="text" size="20" id="srchAccidentNo" name="srchAccidentNo" value="${srchParam.srchAccidentNo}" maxlength="10"/>
							</td>			
						
							<th bgcolor="#e7ecf1" >증권번호</th>
							<td>
								<input class="srchInput" type="text" size="20" id="srchPolicyNo" name="srchPolicyNo" value="${srchParam.srchPolicyNo}" maxlength="10"/>
							</td>			
						
							<th bgcolor="#e7ecf1" >계약자 이름</th>
							<td>
								<input class="srchInput" type="text" size="20" id="srchPolicyNm" name="srchPolicyNm" value="${srchParam.srchPolicyNm}" maxlength="10"/>
							</td>			
						</tr>

						<tr height="38">
							<th bgcolor="#e7ecf1" >담당 부서</th>
							<td>
								<select id="srchTmId" name="srchTmId" style="width:150px;">
									<option value="999" selected>-- 전체 --</option>
									<c:forEach items="${topTeamList}" var = "teamVo">
										<option value="${teamVo.team_id}">
											<c:if test="${teamVo.team_level == 1}">&nbsp;└</c:if>
											<c:if test="${teamVo.team_level == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
											${teamVo.team_name}
										</option>
									</c:forEach>
								</select>
							</td>	
						
							<th bgcolor="#e7ecf1" >담당자</th>
							<td>
								<input class="srchInput" type="text" size="20" id="srchUserNm" name="srchUserNm" value="${srchParam.srchUserNm}" maxlength="10"/>
							</td>			
						
							<th bgcolor="#e7ecf1" >알림 내용</th>
							<td>
								<input class="srchInput" type="text" size="20" id="srchAlarm" name="srchAlarm" value="${srchParam.srchAlarm}" maxlength="10"/>
							</td>			
						
							<th bgcolor="#e7ecf1" >메모 내용</th>
							<td>
								<input class="srchInput" type="text" size="20" id="srchMemo" name="srchMemo" value="${srchParam.srchMemo}" maxlength="10"/>
							</td>			
						</tr>						
						<tr>
							<td colspan="8" align="right" > 
<!-- 								<img src="./resources/ls_img/btn_excel.gif" style="cursor:pointer;" onclick="fnExcelDown();"> -->
								<img src="./resources/ne_img/btn/btn_src.gif" style="cursor:pointer;" onclick="fnSearch();" />
							</td>
						</tr>
					</table>
				</div>	
			
			
			
			</form>
			
		</div>
	</div>
