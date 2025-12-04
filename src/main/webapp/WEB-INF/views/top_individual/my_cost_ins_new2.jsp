<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;"/> 경비내역 추가</b>		
			<div class= "tableStyle2">
				<table>
					<colgroup>
						<col width="8%">
						<col width="8%">
						<col width="8%">
						<col width="5%">
						<col width="5%">
						<col width="6%">
						<col width="8%">
						<col width="8%">
						<col width="8%">
						<col width="8%">
						<col width="5%">
						<col width="7%">
						<col width="5%">
					</colgroup>
					<tr>
						<th>일자</th>
						<th>신청일자</th>
						<th>계정명</th>
						<th>구분</th>
						<th>영수증 수</th>
						<th>금액</th>
						<th>지급처</th>
						<th>관련회사</th>
						<th>면담자</th>
						<th>비고</th>
						<th>상태</th>
						<th>확정금액</th>
						<th>비고</th>
					</tr>
					<tr>
						<td><input type="text"  id="cost_occur_date_addition" class="classCalendar" name="cost_occur_date" style="width:70px;"/></td>
						<td><input type="text" id="cost_apply_date_addition"  class="classCalendar" value="${inVO.cost_apply_date}"style="width:70px;"/></td>
						<td>
							<select id="cost_class_no_addition">
								<option value="">-선택-</option>
								<option value="11">대중교통비</option>
								<option value="21">유류대</option>
								<option value="31">주차비</option>
								<option value="41">통행료</option>
								<option value="51">숙박비</option>
								<option value="61">회식대</option>
								<option value="71">식대</option>
								<option value="81">업무협의비</option>
								<option value="91">물품구입비</option>
								<option value="101">우편요금</option>
								<option value="111">통신료</option>
								<option value="121">문서발급비</option>
								<option value="131">수도광열비</option>
							</select>
						</td>
						<td style="width:;">
							<select id="cost_pay_type_addition">
								<option value="1">카드</option>
								<option value="0">현금</option>
							</select>
						</td>
						<td><input type="text" id="cost_bill_ea_addition" name="cost_bill_ea" style="width:20px"/>ea</td>
						<td>
							<input  type="text" name="cost_pay_amt" id="cost_pay_amt_addition" class="endContents"
									value="<fmt:formatNumber value="" pattern="###,###,##0.##"/>"
									ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);" style="IME-MODE: disabled;width:75px;" /> 
						</td>						
						
						<td><input type="text" id="cost_pay_place_addition" name="cost_pay_place" style="width:85px"/></td>
						<td><input type="text" id="cost_involved_com_addition" name="cost_involved_com" style="width:85px"/></td>
						<td><input type="text" id="cost_involved_man_addition" name="cost_involved_man" style="width:85px"/></td>
						<td><input type="text" id="cost_memo_addition" name="cost_memo" style="width:85px"/></td>
						<td></td>
						<td></td>
						<td>
							<img src="./resources/ls_img/btn_add.gif" id="addMyCostIns_addition" alt="추가" style ="cursor:pointer" />
							<input type="hidden" id="cost_deposit_no_addition" name="cost_deposit_no" value="${getMyCostDepositInfo.cost_deposit_no}"/>
						</td>
					</tr>
				</table>
			</div><!-- //tableStyle -->
			<br />
			<b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;"/> 경비내역 수정/삭제</b>
			<div class= "tableStyle2">
				<table>
					<colgroup>
						<col width="8%">
						<col width="8%">
						<col width="8%">
						<col width="5%">
						<col width="5%">
						<col width="6%">
						<col width="8%">
						<col width="8%">
						<col width="8%">
						<col width="8%">
						<col width="5%">
						<col width="7%">
						<col width="5%">
					</colgroup>
					<tr>
						<th>일자</th>
						<th>신청일자</th>
						<th>계정명</th>
						<th>구분</th>
						<th>영수증 수</th>
						<th>금액</th>
						<th>지급처</th>
						<th>관련회사</th>
						<th>면담자</th>
						<th>비고</th>
						<th>상태</th>
						<th>확정금액</th>
						<th>비고</th>
					</tr>
					
					<c:forEach items="${getMyCostInsAddList}" var="vo" varStatus="subStatus" >
					<tr>
						<td><input type="text" id="cost_occur_date_addition${subStatus.index}" class="cost_occur_date" name="cost_occur_dateUDT" value="${vo.getCost_occur_date_fmt()}" style="width:70px;"/></td>
						<td><input type="text" id="cost_apply_date_addition${subStatus.index}" class="cost_apply_date" name="cost_apply_dateUDT" value="${vo.cost_reg_date_fmt}" style="width:70px;"/></td>
						<td>
							<select id="cost_class_no_addition${subStatus.index}">
								<option value="0" <c:if test="${vo.getCost_class_no() eq '0'}"> selected="selected" </c:if>>-전체-</option>
								<option value="11" <c:if test="${vo.getCost_class_no() eq '11'}"> selected="selected" </c:if>>대중교통비</option>
								<option value="21" <c:if test="${vo.getCost_class_no() eq '21'}"> selected="selected" </c:if>>유류대</option>
								<option value="31" <c:if test="${vo.getCost_class_no() eq '31'}"> selected="selected" </c:if>>주차비</option>
								<option value="41" <c:if test="${vo.getCost_class_no() eq '41'}"> selected="selected" </c:if>>통행료</option>
								<option value="51" <c:if test="${vo.getCost_class_no() eq '51'}"> selected="selected" </c:if>>숙박비</option>
								<option value="61" <c:if test="${vo.getCost_class_no() eq '61'}"> selected="selected" </c:if>>회식대</option>
								<option value="71" <c:if test="${vo.getCost_class_no() eq '71'}"> selected="selected" </c:if>>식대</option>
								<option value="81" <c:if test="${vo.getCost_class_no() eq '81'}"> selected="selected" </c:if>>업무협의비</option>
								<option value="91" <c:if test="${vo.getCost_class_no() eq '91'}"> selected="selected" </c:if>>물품구입비</option>
								<option value="101" <c:if test="${vo.getCost_class_no() eq '101'}"> selected="selected" </c:if>>우편요금</option>
								<option value="111" <c:if test="${vo.getCost_class_no() eq '111'}"> selected="selected" </c:if>>통신료</option>
								<option value="121" <c:if test="${vo.getCost_class_no() eq '121'}"> selected="selected" </c:if>>문서발급비</option>
								<option value="131" <c:if test="${vo.getCost_class_no() eq '131'}"> selected="selected" </c:if>>수도광열비</option>
							</select>
						</td>
						<td style="width:;">
							<select id="cost_pay_type_addition${subStatus.index}">
								<option value="1" <c:if test="${vo.getCost_pay_type() eq '1'}"> selected="selected" </c:if>>카드</option>
								<option value="0" <c:if test="${vo.getCost_pay_type() eq '0'}"> selected="selected" </c:if>>현금</option>
							</select>
						</td>
						<td><input type="text" id="cost_bill_ea_addition${subStatus.index}" name="cost_bill_ea" value="${vo.getCost_bill_ea()}" style="width:20px"/>ea</td>
						<td>
							<input type="text" name="cost_pay_amt" id="cost_pay_amt_addition${subStatus.index}" class="endContents"
									value="<fmt:formatNumber value="${vo.getCost_pay_amt()}" pattern="###,###,##0.##"/>"
									ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);" style="IME-MODE: disabled;width:63px;" />
							
						</td>
						<td><input type="text" id="cost_pay_place_addition${subStatus.index}" name="cost_pay_place" value="${vo.getCost_pay_place()}"style="width:85px"/></td>
						<td><input type="text" id="cost_involved_com_addition${subStatus.index}" name="cost_involved_com" value="${vo.getCost_involved_com()}"style="width:85px"/></td>
						<td><input type="text" id="cost_involved_man_addition${subStatus.index}" name="cost_involved_man" value="${vo.getCost_involved_man()}"style="width:85px"/></td>
						<td><input type="text" id="cost_memo_addition${subStatus.index}" name="cost_memo" value="${vo.getCost_memo()}"style="width:85px"/></td>
						<td>${vo.cost_aprv_state_nm}</td>
						<td>${vo.cost_deposit_amt}</td>
						<td>
							<input type="image" src="./resources/ls_img/btn_edit_s.gif" value="${subStatus.index}" class="udtMyCostAddition" alt="수정" style ="cursor:pointer" />
							<input type="image" src="./resources/ls_img/btn_del_s.gif" value="${subStatus.index}" class="delMyCostAddition" alt="삭제" style ="cursor:pointer" />
							<input type="hidden" id="cost_no_addition${subStatus.index}" name="cost_no" value="${vo.getCost_no()}"/>
							<input type="hidden" id="cost_aprv_state_addition${subStatus.index}" name="cost_aprv_state" value="${vo.cost_aprv_state}"/>
						</td>
					</tr>
						<c:set var="sum_cost_bill_ea" value="${vo.cost_bill_ea + sum_cost_bill_ea}" />
						<c:set var="sum_cost_pay_amt" value="${vo.cost_pay_amt + sum_cost_pay_amt}" />
<%-- 					</c:if> --%>
					</c:forEach>
					<tr>
						<td colspan="4"><b>합계</b></td>
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
					<c:if test="${getMyCostInsAddList.size() ne 0}">
						<tbody align="center" id = "myCostBillFileList3">
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
								<%@include file="../include/uploadform_myCostBillFile_addition.jsp"%>			
							</td>
						</tr>
					</c:if>
					</table>
				</div><!-- //tableStyle -->
				<br />
	

