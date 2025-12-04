<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
			<style>
				input::-webkit-input-placeholder { color: #c1c1c1; }
				input:-ms-input-placeholder { color: #c1c1c1; }
			</style>
			<b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;"/> 클레임 교통비내역 추가</b>
			<div class= "tableStyle2">
				<table>
					<colgroup>
						<col width="8%"> <!-- 일자 -->
						<col width="8%"> <!-- 계정명 -->
						<col width="5%"> <!-- 구분 -->
						<col width="5%"> <!-- 영수증 수  -->
						<col width="6%"> <!-- 금액 -->
						<col width="6%"> <!-- 관련회사 -->
						<col width="8%"> <!-- 계약자명 -->
						<col width="10%"> <!-- 접수번호 -->
						<col width="5%"> <!-- 총 이동거리 -->
						<col width="8%"> <!-- 비고 -->
						<col width="5%"> <!-- 상태 -->
						<col width="7%"> <!-- 확정금액 -->
						<col width="5%"> <!-- - -->
					</colgroup>
					<tr>
						<th>종결일자</th>
						<th>계정명</th>
						<th>구분</th>
						<th>영수증 수</th>
						<th>금액</th>
						<th>관련회사</th>
						<th>계약자명</th>
						<th>접수번호</th>
						<th>총 이동거리</th>
						<th>비고</th>
						<th>상태</th>
						<th>확정금액</th>
						<th>비고</th>
					</tr>
					<tr>
						<td><input type="text" class="classCalendar" id="cost_occur_date_2" name="cost_occur_date_2" style="width:70px;"/></td>
						<td>
							<select id="cost_class_no_claim_2">
								<option value="">-선택-</option>
								<option value="11">유류대</option>
								<option value="21">통행료</option>
								<option value="31">대중교통비</option>
								
							</select>
						</td>
						<td style="width:;">
							<select id="cost_pay_type_2">
								<option value="1">카드</option>
								<option value="0">현금</option>
							</select>
						</td>
						<td><input type="text" id="cost_bill_ea_2" name="cost_bill_ea_2" style="width:20px"/>ea</td>
						<td>
							<input  type="text" name="cost_pay_amt_2" id="cost_pay_amt_2" class="endContents"
									value="<fmt:formatNumber value="" pattern="###,###,##0.##"/>"
									ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);" style="IME-MODE: disabled;width:75px;" /> 
						</td>	
						
											
						<td>
							<select id="cost_involved_com_2">
								<option value="메리츠">메리츠</option>
								<option value="새마을">새마을</option>
								<option value="농협">농협</option>
							</select>
<!-- 						<input type="text" id="cost_involved_com" name="cost_involved_com" style="width:85px"/> -->
						</td>
						
						<td><input type="text" id="cost_involved_man_2" name="cost_involved_man_2" style="width:85px"/></td>
						<td><input type="text" id="cost_suim_accept_no_2" name="cost_suim_accept_no_2" style="width:100px" placeholder="ex)TL1701-1234"/></td>
						<td><input type="text" id="cost_distance_2" name="cost_distance_2" style="width:45px"/></td>
						<td><input type="text" id="cost_memo_2" name="cost_memo_2" style="width:85px"/></td>
						<td></td>
						<td></td>
						<td>
							<img src="./resources/ls_img/btn_add.gif" id="addMyCostIns_2" alt="추가" style ="cursor:pointer" />
							<input type="hidden" id="cost_deposit_no" name="cost_deposit_no" value="${getMyCostDepositInfo.cost_deposit_no}"/>
						</td>
					</tr>
				</table>
			</div><!-- //tableStyle -->
			<br />
			<b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;"/> 클레임 교통비내역 수정/삭제</b>
			<div class= "tableStyle2">
				<table>
					<colgroup>
						<col width="8%"> <!-- 일자 -->
						<col width="8%"> <!-- 계정명 -->
						<col width="5%"> <!-- 구분 -->
						<col width="5%"> <!-- 영수증 수  -->
						<col width="6%"> <!-- 금액 -->
						<col width="6%"> <!-- 관련회사 -->
						<col width="8%"> <!-- 계약자명 -->
						<col width="10%"> <!-- 접수번호 -->
						<col width="5%"> <!-- 총 이동거리 -->
						<col width="8%"> <!-- 비고 -->
						<col width="5%"> <!-- 상태 -->
						<col width="7%"> <!-- 확정금액 -->
						<col width="5%"> <!-- - -->
					</colgroup>
					<tr>
						<th>종결일자</th>
						<th>계정명</th>
						<th>구분</th>
						<th>영수증 수</th>
						<th>금액</th>
						<th>관련회사</th>
						<th>계약자명</th>
						<th>접수번호</th>
						<th>총 이동거리</th>
						<th>비고</th>
						<th>상태</th>
						<th>확정금액</th>
						<th>비고</th>
					</tr>
					<c:forEach items="${getMyCostInsClaimList}" var="vo" varStatus="sub2_status" >
					<tr>
						<td><input type="text" id="cost_occur_date_2${sub2_status.index}" class="classCalendar" name="cost_occur_dateUDT" value="${vo.getCost_occur_date_fmt()}" style="width:70px;"/></td>
						<td>
							<select id="cost_class_no_claim_2${sub2_status.index}">
<%-- 								<option value="0" <c:if test="${vo.getCost_class_no_claim() eq '0'}"> selected="selected" </c:if>>-전체-</option> --%>
								<option value="11" <c:if test="${vo.getCost_class_no_claim() eq '11'}"> selected="selected" </c:if>>유류대</option>
								<option value="21" <c:if test="${vo.getCost_class_no_claim() eq '21'}"> selected="selected" </c:if>>통행료</option>
								<option value="31" <c:if test="${vo.getCost_class_no_claim() eq '31'}"> selected="selected" </c:if>>대중교통비</option>
							</select>
						</td>
						<td style="width:;">
							<select id="cost_pay_type_2${sub2_status.index}">
								<option value="1" <c:if test="${vo.getCost_pay_type() eq '1'}"> selected="selected" </c:if>>카드</option>
								<option value="0" <c:if test="${vo.getCost_pay_type() eq '0'}"> selected="selected" </c:if>>현금</option>
							</select>
						</td>
						<td><input type="text" id="cost_bill_ea_2${sub2_status.index}" name="cost_bill_ea_2" value="${vo.getCost_bill_ea()}" style="width:20px"/>ea</td>
						<td>
							<input type="text" name="cost_pay_amt_2" id="cost_pay_amt_2${sub2_status.index}" class="endContents"
									value="<fmt:formatNumber value="${vo.getCost_pay_amt()}" pattern="###,###,##0.##"/>"
									ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);" style="IME-MODE: disabled;width:63px;" />
							
						</td>
						<td>
							<select id="cost_involved_com_2${sub2_status.index}">
								<option value="메리츠" <c:if test="${vo.getCost_involved_com() eq '메리츠'}">selected="selected"</c:if>>메리츠</option>
								<option value="새마을" <c:if test="${vo.getCost_involved_com() eq '새마을'}">selected="selected"</c:if>>새마을</option>
								<option value="농협" <c:if test="${vo.getCost_involved_com() eq '농협'}">selected="selected"</c:if>>농협</option>
							</select>
						<td><input type="text" id="cost_involved_man_2${sub2_status.index}" name="cost_involved_man_2" value="${vo.getCost_involved_man()}"style="width:85px"/></td>
						<td><input type="text" id="cost_suim_accept_no_2${sub2_status.index}" name="cost_suim_accept_no_2" value="${vo.getCost_suim_accept_no()}"style="width:100px"/></td>
						<td><input type="text" id="cost_distance_2${sub2_status.index}" name="cost_distance_2" value="${vo.getCost_distance()}"style="width:45px"/></td>
						<td><input type="text" id="cost_memo_2${sub2_status.index}" name="cost_memo_2" value="${vo.getCost_memo()}"style="width:85px"/></td>
						<td>${vo.cost_aprv_state_nm}</td>
						<td>${vo.cost_deposit_amt}</td>
						<td>
							<input type="hidden" id="cost_no_2${sub2_status.index}" name="cost_no_2" value="${vo.getCost_no()}"/>
							<input type="image" src="./resources/ls_img/btn_edit_s.gif" value="${sub2_status.index}" class="udtMyCost2" alt="수정" style ="cursor:pointer" />
							<input type="image" src="./resources/ls_img/btn_del_s.gif" value="${sub2_status.index}" class="delMyCost2" alt="삭제" style ="cursor:pointer" />
							<input type="hidden" id="cost_aprv_state_2${sub2_status.index}" name="cost_aprv_state" value="${vo.cost_aprv_state}"/>
						</td>
					</tr>
						<c:set var="sum_cost_bill_ea" value="${vo.cost_bill_ea + sum_cost_bill_ea}" />
						<c:set var="sum_cost_pay_amt" value="${vo.cost_pay_amt + sum_cost_pay_amt}" />
					</c:forEach>
					<tr>
						<td colspan="3"><b>합계</b></td>
						<td><c:out value="${sum_cost_bill_ea}"/>ea</td>
						<td style="letter-spacing:0px;">
							<fmt:formatNumber value="${sum_cost_pay_amt}" pattern="###,###,##0.##"/>원
						</td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</table>
				<b><font color="red">※ 현금관련 영수증은 한장당 3만원 이상 불가 (병원영수증제외)</font></b>
			</div><!-- //tableStyle -->
			<br />
			<b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;" /> 영수증 업로드</b>
			<div class= "tableStyle2">
				<table>
					<colgroup>
						<col width="60%">
						<col width="40%">
					</colgroup>
					<tr>
						<th>파일명</th>
						<th>등록일</th>
					</tr>
					<c:if test="${getMyCostInsClaimList.size() ne 0}">
						<tbody align="center" id = "MyCostBillFileList2">
							<c:forEach items="${myCostBillFileList}" var="orgFileVo">
							<tr id = "MyCostBillFileOrgTr_${orgFileVo.getSerialNo()}">
								<td>
									<a href="myCostBillFileDownload?key=${orgFileVo.getSerialNo()}&type=rptOrigin&cost_deposit_no=${orgFileVo.getCost_deposit_no()}">
										<font color="blue"> ${orgFileVo.getFileName()} </font>
						  			</a>
								</td>
								<td>
									${orgFileVo.getRegDate()}
									<img src='./resources/ls_img/btn_del_s.gif' onclick="MyCostBillOrgFileDel('${orgFileVo.getSerialNo()}');" style='cursor:pointer; margin-left:5px;'/>
								</td>
							</tr>
							</c:forEach>
						</tbody>
						<tr>
							<td colspan="2" align="center">
								<%@include file="../include/uploadform_myCostBillFile2.jsp"%>
							</td>
						</tr>
					</c:if>
				</table>
			</div><!-- //tableStyle -->
			<br />

