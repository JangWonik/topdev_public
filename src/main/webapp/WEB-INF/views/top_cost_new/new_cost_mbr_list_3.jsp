<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

			<b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;"/> 클레임 교통비내역 추가</b>
			<div class= "tableStyle2">
				<table>
					<colgroup>
						<col width="8%">
						<col width="8%">
						<col width="5%">
						<col width="5%">
						<col width="6%">
						<col width="8%">
						<col width="8%">
						<col width="8%">
						<col width="5%">
						<col width="8%">
						<col width="5%">
						<col width="7%">
						<col width="5%">
					</colgroup>
					<tr>
						<th>종결일자</th>
						<th>계정명</th>
						<th>구분</th>
						<th>영수증 수</th>
						<th>금액</th>
						<th>관련회사</th>
						<th>면담자</th>
						<th>접수번호</th>
						<th>거리</th>
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
									ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);" style="IME-MODE: disabled;width:63px;" />
						</td>
						<td>
							<select id="cost_involved_com2">
								<option value="메리츠">메리츠</option>
								<option value="새마을">새마을</option>
								<option value="농협">농협</option>
							</select>
						<td><input type="text" id="cost_involved_man_2" name="cost_involved_man_2" style="width:85px"/></td>
						<td><input type="text" id="cost_suim_accept_no_2" name="cost_suim_accept_no_2" style="width:85px"/></td>
						<td><input type="text" id="cost_distance_2" name="cost_distance_2" style="width:45px"/></td>
						<td><input type="text" id="cost_memo_2" name="cost_memo_2" style="width:85px"/></td>
						<td></td>
						<td></td>
						<td>
							<img src="./resources/ls_img/btn_add.gif" id="addMyCostIns2" alt="추가" style ="cursor:pointer" />
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
						<col width="8%">
						<col width="8%">
						<col width="5%">
						<col width="5%">
						<col width="6%">
						<col width="8%">
						<col width="8%">
						<col width="8%">
						<col width="5%">
						<col width="8%">
						<col width="5%">
						<col width="7%">
						<col width="5%">
					</colgroup>
					<tr>
						<th>종결일자</th>
						<th>계정명</th>
						<th>구분</th>
						<th>영수증 수</th>
						<th>금액</th>
						<th>관련회사</th>
						<th>면담자</th>
						<th>접수번호</th>
						<th>거리</th>
						<th>비고</th>
						<th>상태</th>
						<th>확정금액</th>
						<th>비고</th>
					</tr>
					<c:set value="0" var="tmpClaimFlag1"/>
					<c:set value="0" var="tmpClaimFlag2"/>
					<c:set value="0" var="tmpClaimFlag3"/>
					
					<c:forEach items="${getMyCostInsClaimList}" var="vo" varStatus="substatus" >
						<c:if test="${substatus.index == 0}">
							<c:set var="tmpClaimFlag1" value="${vo.getCost_class_no_claim()}" />
						</c:if>
						<c:set var="tmpClaimFlag2" value="${vo.getCost_class_no_claim()}" />
						<c:set var="tmpClaimFlag3" value="${vo.getCost_class_no_claim()}" />
						<c:if test="${(tmpClaimFlag1 != tmpClaimFlag2)}">
							<tr bgcolor="#E7ECF1">
								<td colspan="3"><b>소계</b></td>
								<td style="letter-spacing:0px;" ><fmt:formatNumber value="${tmpClaimSum1}" pattern="###,###,##0.##"/> ea</td>
								<td style="letter-spacing:0px;" ><fmt:formatNumber value="${tmpClaimSum2}" pattern="###,###,##0.##"/> 원</td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td style="letter-spacing:0px;" ><fmt:formatNumber value="${tmpClaimSum3}" pattern="###,###,##0.##"/> 원</td>
								<td></td>
							</tr>
							<c:set var="tmpClaimFlag1" value="${vo.getCost_class_no_claim()}" />
							<c:set var="tmpClaimFlag2" value="${vo.getCost_class_no_claim()}" />
							<c:set var="tmpClaimSum1" value="0" />
							<c:set var="tmpClaimSum2" value="0" />
							<c:set var="tmpClaimSum3" value="0" />
						</c:if>
						<tr>
							<td><input type="text" id="cost_occur_date_2_${substatus.index}" class="classCalendar" name="cost_occur_dateUDT" value="${vo.getCost_occur_date_fmt()}" style="width:70px;"/></td>
							<td>
								<select id="cost_class_no_claim_2_${substatus.index}">
									<option value="0" <c:if test="${vo.getCost_class_no_claim() eq '0'}"> selected="selected" </c:if>>-전체-</option>
									<option value="11" <c:if test="${vo.getCost_class_no_claim() eq '11'}"> selected="selected" </c:if>>유류대</option>
									<option value="21" <c:if test="${vo.getCost_class_no_claim() eq '21'}"> selected="selected" </c:if>>통행료</option>
									<option value="31" <c:if test="${vo.getCost_class_no_claim() eq '31'}"> selected="selected" </c:if>>대중교통비</option>
								</select>
							</td>
							<td style="width:;">
								<select id="cost_pay_type_2_${substatus.index}">
									<option value="1" <c:if test="${vo.getCost_pay_type() eq '1'}"> selected="selected" </c:if>>카드</option>
									<option value="0" <c:if test="${vo.getCost_pay_type() eq '0'}"> selected="selected" </c:if>>현금</option>
								</select>
							</td>
							<td><input type="text" id="cost_bill_ea_2_${substatus.index}" name="cost_bill_ea_2" value="${vo.getCost_bill_ea()}" style="width:20px"/>ea</td>
							<td style="letter-spacing:0px;" >
								<input  type="text" name="cost_pay_amt_2" id="cost_pay_amt_2_${substatus.index}" class="endContents"
										value="<fmt:formatNumber value="${vo.cost_pay_amt}" pattern="###,###,##0.##"/>"
										ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);" style="IME-MODE: disabled;width:63px;" />
								
							</td>
							<td>
								<select id="cost_involved_com_2_${substatus.index}">
									<option value="메리츠" <c:if test="${vo.getCost_involved_com() eq '메리츠'}">selected="selected"</c:if>>메리츠</option>
									<option value="새마을" <c:if test="${vo.getCost_involved_com() eq '새마을'}">selected="selected"</c:if>>새마을</option>
									<option value="농협" <c:if test="${vo.getCost_involved_com() eq '농협'}">selected="selected"</c:if>>농협</option>
								</select>
							<td><input type="text" id="cost_involved_man_2_${substatus.index}" name="cost_involved_man_2" value="${vo.getCost_involved_man()}"style="width:85px"/></td>
							<td><input type="text" id="cost_suim_accept_no_2_${substatus.index}" name="cost_suim_accept_no_2" value="${vo.getCost_suim_accept_no()}"style="width:85px"/></td>
							<td><input type="text" id="cost_distance_2_${substatus.index}" name="cost_distance_2" value="${vo.getCost_distance()}"style="width:45px"/></td>
							<td><input type="text" id="cost_memo_2_${substatus.index}" name="cost_memo_2" value="${vo.getCost_memo()}"style="width:85px"/></td>
							<td>${vo.cost_aprv_state_nm}</td>
							<td style="letter-spacing:0px;">
								<input  type="text" name="cost_deposit_amt_2" id="cost_deposit_amt_2_${substatus.index}" class="endContents"
										value="<fmt:formatNumber value="${vo.cost_deposit_amt}" pattern="###,###,##0.##"/>"
										ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);" style="IME-MODE: disabled;width:63px;" />
							</td>
							<td>
								<input type="image" src="./resources/ls_img/btn_edit_s.gif" value="${substatus.index}" class="udtMyCost2" alt="수정" style ="cursor:pointer" />
								<input type="image" src="./resources/ls_img/btn_del_s.gif" value="${substatus.index}" class="delMyCost2" alt="삭제" style ="cursor:pointer" />
								<input type="hidden" id="cost_no_2_${substatus.index}" name="cost_no_2" value="${vo.getCost_no()}"/>
								<input type="hidden" id="hid_cost_claim_aprv_state${substatus.index}" name="hid_cost_aprv_state" value="${vo.cost_aprv_state}" />
							</td>
						</tr>
						<c:set var="claim_sum_cost_bill_ea" value="${vo.cost_bill_ea + claim_sum_cost_bill_ea}" />
						<c:set var="claim_sum_cost_pay_amt" value="${vo.cost_pay_amt + claim_sum_cost_pay_amt}" />
						<c:set var="claim_sum_cost_deposit_amt" value="${vo.cost_deposit_amt + claim_sum_cost_deposit_amt}" />
						<c:set var="var_cost_claim_aprv_state" value="${vo.cost_aprv_state}" />
						
						<c:set var="tmpClaimSum1" value="${tmpClaimSum1 + vo.getCost_bill_ea()}" />
						<c:set var="tmpClaimSum2" value="${tmpClaimSum2 + vo.getCost_pay_amt()}" />
						<c:set var="tmpClaimSum3" value="${tmpClaimSum3 + vo.cost_deposit_amt}" />
					</c:forEach>
			
			
					<tr bgcolor="#E7ECF1">
						<td colspan="3"><b>소계</b></td>
						<td style="letter-spacing:0px;"><fmt:formatNumber value="${tmpClaimSum1}" pattern="###,###,##0.##"/> ea</td>
						<td style="letter-spacing:0px;"><fmt:formatNumber value="${tmpClaimSum2}" pattern="###,###,##0.##"/> 원</td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td style="letter-spacing:0px;"><fmt:formatNumber value="${tmpClaimSum3}" pattern="###,###,##0.##"/> 원</td>
						<td>
<%-- 							<input type="hidden" id="hid_cost_claim_aprv_state" name="hid_cost_claim_aprv_state" value="${var_cost_claim_aprv_state}" /> --%>
						</td>
					</tr>
					
					<tr>
						<td colspan="3"><b>합계</b></td>
						<td style="letter-spacing:0px;">
							<c:out value="${claim_sum_cost_bill_ea}"/> ea
						</td>
						<td style="letter-spacing:0px;">
							<fmt:formatNumber value="${claim_sum_cost_pay_amt}" pattern="###,###,##0.##"/> 원
						</td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td style="letter-spacing:0px;">
<%-- 							<c:if test="${var_cost_aprv_state ne '0'}"> --%>
								<fmt:formatNumber value="${claim_sum_cost_deposit_amt}" pattern="###,###,##0.##"/>원
<%-- 							</c:if> --%>
						</td>
						<td>
							<c:if test="${var_cost_claim_aprv_state eq 0}">
								<img src="./resources/ls_img/top_cost/btn_rch_1.gif" style="cursor:pointer;"
									onclick="javascript:goCostTmAprv2('tmAprv',0,1);" />
							</c:if>
							<c:if test="${var_cost_claim_aprv_state eq 1}">
								<img src="./resources/ls_img/top_cost/btn_rch_1x.gif" style="cursor:pointer;"
									onclick="javascript:goCostTmAprv2('tmAprvX',1,0);" />
							</c:if>
						</td>
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

