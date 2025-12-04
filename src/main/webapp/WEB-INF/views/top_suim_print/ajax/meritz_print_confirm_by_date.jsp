<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
				<table>
       				<colgroup>
       					<col width="20%" />
       					<col width="51%" />
       					<col width="20%" />
       					<col width="9%" />
       				</colgroup>
       				<thead>
       					<tr>
	       					<th>일자</th>
	       					<th>확인내용</th>
	       					<th>관련기관</th>
	       					<th>비고</th>
       					</tr>
       				</thead>
       				<tbody>
       					<tr>
       						<th colspan="4">
       							계약전
       							<img src="./resources/ls_img/btn_add_s.gif" title="계약 전 사항 추가" style="cursor:pointer; vertical-align:middle;" id="bef_confirm_add_btn" onclick="fnConfirmAdd('bef');"/>  
     						</th>
       					</tr>
       					
       					<tr id="bef_add_tr" style="display:none;border:2px solid #8a8a8a;">
       						<td style="text-align: center">
      							<input type="text" class="calendar" id="bef_to_date_add" /> ~ <br/>
      							&nbsp;&nbsp;&nbsp;<input type="text" class="calendar" id="bef_from_date_add" /><br/>
      							<input type="radio" name="bef_confirm_date_gubun_add" onclick="fnSetConfirmDateDtl('bef',1,'add')" id="bef_confirm_date_gubun1_add" value="1">입원
      							<input type="radio" name="bef_confirm_date_gubun_add" onclick="fnSetConfirmDateDtl('bef',2,'add')" id="bef_confirm_date_gubun2_add" value="2">통원
      							<input type="text" id="bef_date_dtl_add" value=""/> 
       						</td>
       						<td>
       						    <%
		                            String preTextAreaAddText = "- 내원경위 : \n- 검사사항 : \n- 진단병명 : \n- 치료사항 : \n";
		                        %>
       							<textarea rows="8" id="bef_confirm_dtl_add"><%=preTextAreaAddText %></textarea>	
       						</td>
       						<td style="text-align: center">
       							<textarea rows="8" id="bef_relative_organ_add" ></textarea>
       						</td>
       						<td>
                       			<a id="btn_bef_confirm_save_add" href="#noloc" onclick="fnConfirmSave('bef','add','C');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                        		<a id="btn_bef_confirm_close_add" href="#noloc" onclick="fnConfirmClose('bef');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
       						</td>
       					</tr>
       					
       					<c:forEach items="${rptConfirm}" var="confirmList" varStatus="rcStatus">
	       					<c:if test="${confirmList.contractBa == 1}">
		       					<tr id="bef_confirm_view_${rcStatus.index}" >
		       						<!-- 일자 -->
									<td style="text-align: center">
										${confirmList.confirmToDate}
										<c:if test="${confirmList.confirmFromDate ne NULL and confirmList.confirmFromDate ne ''}">
											<br/>~
											${confirmList.confirmFromDate}
										</c:if>
										<c:if test="${confirmList.confirmGubunTxt ne NULL and confirmList.confirmGubunTxt ne ''}">
											<br/>
											(${confirmList.confirmGubunTxt})
										</c:if>									
									</td>
									<!-- 확인내용 -->
									<td>
										${fn:replace(fn:replace(confirmList.confirmDtl , CRLF , '<br>'), ' ', '&nbsp;')}
									</td>
									<!-- 관련기관 -->
									<td style="text-align: center">
										${fn:replace(fn:replace(confirmList.relativeOrgan , CRLF , '<br>'), ' ', '&nbsp;')}
									</td>
									<!-- 비고 - 버튼 -->
									<td>
										<a id="btn_bef_confirm_edit_${rcStatus.index}" href="#noloc" onclick="fnConfirmEdit('bef',${rcStatus.index});"><img src="./resources/ls_img/btn_edite.gif"/></a>
									</td>
		       					</tr>
		       					
		       					<tr id="bef_confirm_edit_${rcStatus.index}" style="display:none;">
		       						<td style="text-align: center">
		      							<input type="text" class="calendar" id="bef_to_date_${rcStatus.index}" value="${confirmList.confirmToDate}" /> ~ <br/>
		      							&nbsp;&nbsp;&nbsp;<input type="text" class="calendar" id="bef_from_date_${rcStatus.index}" value="${confirmList.confirmFromDate}"/><br/>
		      							<input type="radio" name="bef_confirm_date_gubun_${rcStatus.index}" onclick="fnSetConfirmDateDtl('bef',1,${rcStatus.index})" id="bef_confirm_date_gubun1_${rcStatus.index}"  <c:if test="${confirmList.confirmGubun eq '1'}">checked="checked"</c:if> value="1">입원
		      							<input type="radio" name="bef_confirm_date_gubun_${rcStatus.index}" onclick="fnSetConfirmDateDtl('bef',2,${rcStatus.index})" id="bef_confirm_date_gubun2_${rcStatus.index}"  <c:if test="${confirmList.confirmGubun eq '2'}">checked="checked"</c:if> value="2">통원
		      							<input type="text" id="bef_date_dtl_${rcStatus.index}" value="${confirmList.confirmGubunTxt}"/> 
		       						</td>
		       						
		       						<td>
		       							<textarea rows="8" id="bef_confirm_dtl_${rcStatus.index}">${fn:replace(fn:replace(confirmList.confirmDtl , '<br>', CRLF), ' ', '&nbsp;')}</textarea>	
		       						</td>
		       						
		       						<td style="text-align: center">
		       							<textarea rows="8" id="bef_relative_organ_${rcStatus.index}">${fn:replace(fn:replace(confirmList.relativeOrgan , '<br>', CRLF), ' ', '&nbsp;')}</textarea>	
		       						</td>
		       						
		       						<td>
		       							<input type="hidden" id="bef_c_serial_no_${rcStatus.index}" value="${confirmList.serialNo}" />
		                       			<a id="btn_bef_confirm_save_${rcStatus.index}" href="#noloc" onclick="fnConfirmSave('bef',${rcStatus.index},'U');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
										<a id="btn_bef_confirm_del_${rcStatus.index}" href="#noloc" onclick="fnConfirmDelete('bef',${rcStatus.index},'D');"><img src='./resources/ls_img/btn_del.gif' style="margin-top: 5px;"></a>		                       			
		                        		<a id="btn_bef_confirm_close_${rcStatus.index}" href="#noloc" onclick="fnConfirmCancel('bef',${rcStatus.index});"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
		       						</td>								       						
		       					</tr>
	       					</c:if>
       					</c:forEach>
       				</tbody>
       				
       				<tbody>
       					<tr>
       						<th colspan="4">
       							계약일
       							<img src="./resources/ls_img/btn_add_s.gif" title="계약 일 사항 추가" style="cursor:pointer; vertical-align:middle;" id="day_confirm_add_btn" onclick="fnConfirmAdd('day');"/>  
     						</th>
       					</tr>
       					
       					<tr id="day_add_tr" style="display:none;border:2px solid #8a8a8a;">
       						<td style="text-align: center">
      							<input type="text" class="calendar" id="day_to_date_add" />
      							
       						</td>
       						<td>
       							<textarea rows="8" id="day_confirm_dtl_add"></textarea>	
       						</td>
       						<td style="text-align: center">
       							메리츠 화재보험
       							<input type="hidden" id="bef_relative_organ_add" value="메리츠 화재보험" />
       						</td>
       						<td>
       							<input type="hidden" id="day_relative_organ_add" value="메리츠 화재보험" />
                       			<a id="btn_day_confirm_save_add" href="#noloc" onclick="fnConfirmSave('day','add','C');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                        		<a id="btn_day_confirm_close_add" href="#noloc" onclick="fnConfirmClose('day');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
       						</td>
       					</tr>
       					
       					<c:forEach items="${rptConfirm}" var="confirmList" varStatus="rcStatus">
       						<c:if test="${confirmList.contractBa == 2}">
		       					<tr id="day_confirm_view_${rcStatus.index}" >
		       						<!-- 일자 -->
									<td style="text-align: center">
										${confirmList.confirmToDate}
									</td>
									<!-- 확인내용 -->
									<td style="text-align: center;">
										${fn:replace(fn:replace(confirmList.confirmDtl , CRLF , '<br>'), ' ', '&nbsp;')}
									</td>
									<!-- 관련기관 -->
									<td style="text-align: center">
										${confirmList.relativeOrgan}
									</td>									
									<!-- 비고 - 버튼 -->
									<td>
										<a id="btn_day_confirm_edit_${rcStatus.index}" href="#noloc" onclick="fnConfirmEdit('day',${rcStatus.index});"><img src="./resources/ls_img/btn_edite.gif"/></a>
									</td>
		       					</tr>
		       					
		       					<tr id="day_confirm_edit_${rcStatus.index}" style="display:none;">
		       						<td style="text-align: center">
		      							<input type="text" class="calendar" id="day_to_date_${rcStatus.index}" value="${confirmList.confirmToDate}" />
		       						</td>
		       						<td>
		       							<textarea rows="8" id="day_confirm_dtl_${rcStatus.index}">${confirmList.confirmDtl}</textarea>	
		       						</td>
		       						<td style="text-align: center">
		       							메리츠 화재보험
		       							<input type="hidden" id="day_relative_organ_${rcStatus.index}" value="${confirmList.relativeOrgan}" />
		       						</td>		       						
		       						<td>
		       							<input type="hidden" id="day_c_serial_no_${rcStatus.index}" value="${confirmList.serialNo}" />
		       							<input type="hidden" id="day_relative_organ_${rcStatus.index}" value="메리츠 화재보험" />
		                       			<a id="btn_day_confirm_save_${rcStatus.index}" href="#noloc" onclick="fnConfirmSave('day',${rcStatus.index},'U');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
		                       			<a id="btn_day_confirm_del_${rcStatus.index}" href="#noloc" onclick="fnConfirmDelete('day',${rcStatus.index},'D');"><img src='./resources/ls_img/btn_del.gif' style="margin-top: 5px;"></a>
		                        		<a id="btn_day_confirm_close_${rcStatus.index}" href="#noloc" onclick="fnConfirmCancel('day',${rcStatus.index});"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
		       						</td>								       						
		       					</tr>
		       				</c:if>
       					</c:forEach>
       				</tbody>
       				<tbody>
       					<tr>
       						<th colspan="4">
       							계약후
       							<img src="./resources/ls_img/btn_add_s.gif" title="계약 후 사항 추가" style="cursor:pointer; vertical-align:middle;" id="aft_confirm_add_btn" onclick="fnConfirmAdd('aft');"/>  
     						</th>
       					</tr>
       					
       					<tr id="aft_add_tr" style="display:none;border:2px solid #8a8a8a;">
       						<td style="text-align: center">
      							<input type="text" class="calendar" id="aft_to_date_add" /> ~ <br/>
      							&nbsp;&nbsp;&nbsp;<input type="text" class="calendar" id="aft_from_date_add" /><br/>
      							<input type="radio" name="aft_confirm_date_gubun_add" onclick="fnSetConfirmDateDtl('aft',1,'add')" id="aft_confirm_date_gubun1_add" value="1">입원
      							<input type="radio" name="aft_confirm_date_gubun_add" onclick="fnSetConfirmDateDtl('aft',2,'add')" id="aft_confirm_date_gubun2_add" value="2">통원
      							<input type="text" id="aft_date_dtl_add" value=""/> 
       						</td>
       						<td>
       							<textarea rows="8" id="aft_confirm_dtl_add"><%=preTextAreaAddText %></textarea>	
       						</td>
       						<td style="text-align: center">
       							<textarea rows="8" id="aft_relative_organ_add"></textarea>	
       						</td>
       						<td>
                       			<a id="btn_aft_confirm_save_add" href="#noloc" onclick="fnConfirmSave('aft','add','C');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                        		<a id="btn_aft_confirm_close_add" href="#noloc" onclick="fnConfirmClose('aft');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
       						</td>
       					</tr>
       					
       					<c:forEach items="${rptConfirm}" var="confirmList" varStatus="rcStatus">
       						<c:if test="${confirmList.contractBa == 3}">
		       					<tr id="aft_confirm_view_${rcStatus.index}" >
		       						<!-- 일자 -->
									<td style="text-align: center">
										${confirmList.confirmToDate}
										<c:if test="${confirmList.confirmFromDate ne NULL and confirmList.confirmFromDate ne ''}">
											<br/>~
											${confirmList.confirmFromDate}
										</c:if>
										<c:if test="${confirmList.confirmGubunTxt ne NULL and confirmList.confirmGubunTxt ne ''}">
											<br/>
											(${confirmList.confirmGubunTxt})
										</c:if>									
									</td>
									<!-- 확인내용 -->
									<td>
										${fn:replace(fn:replace(confirmList.confirmDtl , CRLF , '<br>'), ' ', '&nbsp;')}
									</td>
									<!-- 관련기관 -->
									<td style="text-align: center">
										${fn:replace(fn:replace(confirmList.relativeOrgan , CRLF , '<br>'), ' ', '&nbsp;')}
									</td>
									<!-- 비고 - 버튼 -->
									<td>
										<a id="btn_aft_confirm_edit_${rcStatus.index}" href="#noloc" onclick="fnConfirmEdit('aft',${rcStatus.index});"><img src="./resources/ls_img/btn_edite.gif"/></a>
									</td>
		       					</tr>
		       					
		       					<tr id="aft_confirm_edit_${rcStatus.index}" style="display:none;">
		       						<td style="text-align: center">
		      							<input type="text" class="calendar" id="aft_to_date_${rcStatus.index}" value="${confirmList.confirmToDate}" /> ~ <br/>
		      							&nbsp;&nbsp;&nbsp;<input type="text" class="calendar" id="aft_from_date_${rcStatus.index}" value="${confirmList.confirmFromDate}"/><br/>
		      							<input type="radio" name="aft_confirm_date_gubun_${rcStatus.index}" onclick="fnSetConfirmDateDtl('aft',1,${rcStatus.index})" id="aft_confirm_date_gubun1_${rcStatus.index}"  <c:if test="${confirmList.confirmGubun eq '1'}">checked="checked"</c:if> value="1">입원
		      							<input type="radio" name="aft_confirm_date_gubun_${rcStatus.index}" onclick="fnSetConfirmDateDtl('aft',2,${rcStatus.index})" id="aft_confirm_date_gubun2_${rcStatus.index}"  <c:if test="${confirmList.confirmGubun eq '2'}">checked="checked"</c:if> value="2">통원
		      							<input type="text" id="aft_date_dtl_${rcStatus.index}" value="${confirmList.confirmGubunTxt}"/> 
		       						</td>
		       						<td>
		       							<textarea rows="8" id="aft_confirm_dtl_${rcStatus.index}">${fn:replace(fn:replace(confirmList.confirmDtl, '<br>', CRLF), ' ', '&nbsp;')}</textarea>	
		       						</td>
		       						<td style="text-align: center">
		       							<textarea rows="8" id="aft_relative_organ_${rcStatus.index}">${fn:replace(fn:replace(confirmList.relativeOrgan, '<br>', CRLF), ' ', '&nbsp;')}</textarea>	
		       						</td>
		       						<td>
		       							<input type="hidden" id="aft_c_serial_no_${rcStatus.index}" value="${confirmList.serialNo}" />
		                       			<a id="btn_aft_confirm_save_${rcStatus.index}" href="#noloc" onclick="fnConfirmSave('aft',${rcStatus.index},'U');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
		                       			<a id="btn_aft_confirm_del_${rcStatus.index}" href="#noloc" onclick="fnConfirmDelete('aft',${rcStatus.index},'D');"><img src='./resources/ls_img/btn_del.gif' style="margin-top: 5px;"></a>
		                        		<a id="btn_aft_confirm_close_${rcStatus.index}" href="#noloc" onclick="fnConfirmCancel('aft',${rcStatus.index});"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
		       						</td>								       						
		       					</tr>
		       				</c:if>
       					</c:forEach>
       				</tbody>
       			</table>