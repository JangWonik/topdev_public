<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
						<td><input type="text" id="cost_occur_date_addition" class="classCalendar" name="cost_occur_date" style="width:70px;"/></td>
						<td><input type="text" id="cost_apply_date_addition" class="classCalendar" name="cost_apply_date" value="${inVO.cost_apply_date}" style="width:70px;"/></td>
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
									ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);" style="IME-MODE: disabled;width:63px;" />
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
						<c:set value="0" var="tmpAddFlag1"/>
						<c:set value="0" var="tmpAddFlag2"/>
						<c:set value="0" var="tmpAddFlag3"/>
						<c:forEach items="${getMyCostInsAddList}" var="vo" varStatus="sub2_status" >
							<c:if test="${sub2_status.index == 0}">
								<c:set var="tmpAddFlag1" value="${vo.getCost_class_no()}" />
							</c:if>
							<c:set var="tmpAddFlag2" value="${vo.getCost_class_no()}" />
							<c:set var="tmpAddFlag3" value="${vo.getCost_class_no()}" />
							<c:if test="${(tmpAddFlag1 != tmpAddFlag2)}">
								<tr bgcolor="#E7ECF1">
									<td colspan="4"><b>소계</b></td>
									<td style="letter-spacing:0px;" ><fmt:formatNumber value="${tmpSum1_addition}" pattern="###,###,##0.##"/> ea</td>
									<td style="letter-spacing:0px;" ><fmt:formatNumber value="${tmpSum2_addition}" pattern="###,###,##0.##"/> 원</td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td style="letter-spacing:0px;" ><fmt:formatNumber value="${tmpSum3_addition}" pattern="###,###,##0.##"/> 원</td>
									<td></td>
								</tr>
								<c:set var="tmpAddFlag1" value="${vo.getCost_class_no()}" />
								<c:set var="tmpAddFlag2" value="${vo.getCost_class_no()}" />
								<c:set var="tmpSum1_addition" value="0" />
								<c:set var="tmpSum2_addition" value="0" />
								<c:set var="tmpSum3_addition" value="0" />
							</c:if>
					<tr>
						<td><input type="text" id="cost_occur_date_addition${sub2_status.index}" class="cost_occur_date" name="cost_occur_dateUDT" value="${vo.getCost_occur_date_fmt()}" style="width:70px;"/></td>
						<td><input type="text" id="cost_apply_date_addition${sub2_status.index}" class="cost_apply_date" name="cost_apply_dateUDT" value="${vo.cost_reg_date_fmt}" style="width:70px;"/></td>
						<td>
							<select id="cost_class_no_addition${sub2_status.index}">
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
							<select id="cost_pay_type_addition${sub2_status.index}">
								<option value="1" <c:if test="${vo.getCost_pay_type() eq '1'}"> selected="selected" </c:if>>카드</option>
								<option value="0" <c:if test="${vo.getCost_pay_type() eq '0'}"> selected="selected" </c:if>>현금</option>
							</select>
						</td>
						<td><input type="text" id="cost_bill_ea_addition${sub2_status.index}" name="cost_bill_ea" value="${vo.getCost_bill_ea()}" style="width:20px"/>ea</td>
						<td style="letter-spacing:0px;" >
							<input  type="text" name="cost_pay_amt" id="cost_pay_amt_addition${sub2_status.index}" class="endContents"
									value="<fmt:formatNumber value="${vo.cost_pay_amt}" pattern="###,###,##0.##"/>"
									ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);" style="IME-MODE: disabled;width:63px;" />
							
						</td>
						<td><input type="text" id="cost_pay_place_addition${sub2_status.index}" name="cost_pay_place" value="${vo.getCost_pay_place()}"style="width:85px"/></td>
						<td><input type="text" id="cost_involved_com_addition${sub2_status.index}" name="cost_involved_com" value="${vo.getCost_involved_com()}"style="width:85px"/></td>
						<td><input type="text" id="cost_involved_man_addition${sub2_status.index}" name="cost_involved_man" value="${vo.getCost_involved_man()}"style="width:85px"/></td>
						<td><input type="text" id="cost_memo_addition${sub2_status.index}" name="cost_memo" value="${vo.getCost_memo()}"style="width:85px"/></td>
						<td>${vo.cost_aprv_state_nm}</td>
						<td style="letter-spacing:0px;">
							<input  type="text" name="cost_deposit_amt" id="cost_deposit_amt_addition${sub2_status.index}" class="endContents"
									value="<fmt:formatNumber value="${vo.cost_deposit_amt}" pattern="###,###,##0.##"/>"
									ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);" style="IME-MODE: disabled;width:63px;" />
						</td>
						<td>
							<input type="image" src="./resources/ls_img/btn_edit_s.gif" value="${sub2_status.index}" class="udtMyCostAddition" alt="수정" style ="cursor:pointer" />
							<input type="image" src="./resources/ls_img/btn_del_s.gif" value="${sub2_status.index}" class="delMyCostAddition" alt="삭제" style ="cursor:pointer" />
							<input type="hidden" id="cost_no_addition${sub2_status.index}" name="cost_no" value="${vo.getCost_no()}"/>
							<input type="hidden" id="hid_cost_aprv_state_addition${sub2_status.index}" name="hid_cost_aprv_state" value="${vo.cost_aprv_state}" />
						</td>
					</tr>
						<c:set var="sum_cost_bill_ea_addition" value="${vo.cost_bill_ea + sum_cost_bill_ea_addition}" />
						<c:set var="sum_cost_pay_amt_addition" value="${vo.cost_pay_amt + sum_cost_pay_amt_addition}" />
						<c:set var="sum_cost_deposit_amt_addition" value="${vo.cost_deposit_amt + sum_cost_deposit_amt_addition}" />
						<c:set var="var_cost_aprv_state_addition" value="${vo.cost_aprv_state}" />
							<c:set var="tmpSum1_addition" value="${tmpSum1_addition + vo.getCost_bill_ea()}" />
							<c:set var="tmpSum2_addition" value="${tmpSum2_addition + vo.getCost_pay_amt()}" />
							<c:set var="tmpSum3_addition" value="${tmpSum3_addition + vo.cost_deposit_amt}" />
					</c:forEach>
							<tr bgcolor="#E7ECF1">
								<td colspan="4"><b>소계</b></td>
								<td style="letter-spacing:0px;"><fmt:formatNumber value="${tmpSum1_addition}" pattern="###,###,##0.##"/> ea</td>
								<td style="letter-spacing:0px;"><fmt:formatNumber value="${tmpSum2_addition}" pattern="###,###,##0.##"/> 원</td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td style="letter-spacing:0px;"><fmt:formatNumber value="${tmpSum3_addition}" pattern="###,###,##0.##"/> 원</td>
								<td>
<%-- 									<input type="hidden" id="hid_cost_aprv_state_addition" name="hid_cost_aprv_state" value="${var_cost_aprv_state}" /> --%>
								</td>
							</tr>
					<tr>
						<td colspan="4"><b>합계</b></td>
						<td style="letter-spacing:0px;">
							<c:out value="${sum_cost_bill_ea_addition}"/> ea
						</td>
						<td style="letter-spacing:0px;">
							<fmt:formatNumber value="${sum_cost_pay_amt_addition}" pattern="###,###,##0.##"/> 원
						</td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td style="letter-spacing:0px;">
<%-- 							<c:if test="${var_cost_aprv_state ne '0'}"> --%>
								<fmt:formatNumber value="${sum_cost_deposit_amt_addition}" pattern="###,###,##0.##"/>원
<%-- 							</c:if> --%>
						</td>
						<td>
							<c:if test="${var_cost_aprv_state_addition eq 0}">
								<img src="./resources/ls_img/top_cost/btn_rch_1.gif" style="cursor:pointer;"
									onclick="javascript:goCostTmAprv3('tmAprv',0,1);" />
							</c:if>
							<c:if test="${var_cost_aprv_state_addition eq 1}">
								<img src="./resources/ls_img/top_cost/btn_rch_1x.gif" style="cursor:pointer;"
									onclick="javascript:goCostTmAprv3('tmAprvX',1,0);" />
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
					<c:if test="${getMyCostInsAddList.size() ne 0}">
						<tbody align="center" id = "MyCostBillFileList3">
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
				
