<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

			<b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;"/> 
				<c:choose>
					<c:when test="${costKind eq '1'}">경비내역 입력</c:when>
					<c:when test="${costKind eq '2'}">추가 경비내역 입력</c:when>
					<c:otherwise>클레임 교통비내역 입력</c:otherwise>
				</c:choose> 
			</b>
			
			<div class="tableStyle2">
				<c:choose>
					<c:when test="${costKind ne '3' }">
						<table class="cost_detail_tbl">
							<colgroup>
								<col style="width:8%;" />
								<col style="width:8%;" />
								<col style="width:5%;" />
								<col style="width:5%;" />
								<col style="width:8%;" />
								
								<col style="width:14%;" />
								<col style="width:14%;" />
								<col style="width:14%;" />
								<col style="width:19%;" />
								
								<col style="width:5%;" />
							</colgroup>
							<tr>
								<th>발생일자</th>
								<th>계정명</th>
								<th>구분</th>
								<th>영수증 수</th>
								<th>금액(원)</th>
								
								<th>지급처</th>
								<th>관련회사</th>
								<th>면담자</th>
								<th>비고</th>
								<th>-</th>
							</tr>
							
							<tr>
								<td><input type="text" id="cost_occur_date_insert" name="cost_occur_date_insert" class="calendar" style="width:70px;"/></td>
								<td>
									<select id="cost_class_no_insert">
										<option value="" data-cost_kind="0">- 선택 -</option>
										<c:forEach items="${costClassNoList}" var="item" varStatus="status">
											<c:if test="${item.col_cd1 eq costKind}">
												<option value="${item.col_cd2}" data-cost_kind="${item.col_cd1}">${item.col_val}</option>
											</c:if>
										</c:forEach>							
									</select>
								</td>
								<td>
									<select id="cost_pay_type_insert">
										<option value="1">카드</option>
										<option value="0">현금</option>
									</select>
								</td>
								<td><input type="text" id="cost_bill_ea_insert" name="cost_bill_ea" style="width: 30px;"/> ea</td>
								<td><input type="text" id="cost_pay_amt_insert" name="cost_pay_amt" class="money" /> </td>						
								<td><input type="text" id="cost_pay_place_insert" name="cost_pay_place" /></td>
								<td><input type="text" id="cost_involved_com_insert" name="cost_involved_com" /></td>
								<td><input type="text" id="cost_involved_man_insert" name="cost_involved_man" /></td>
								<td><input type="text" id="cost_memo_insert" name="cost_memo" /></td>
								
								<td>
									<img src="./resources/ls_img/btn_add.gif"  onclick="fnCostItemInsert(${costKind})"  alt="추가" style ="cursor:pointer" />
		<%-- 							<input type="hidden" id="cost_deposit_no" name="cost_deposit_no" value="${getMyCostDepositInfo.cost_deposit_no}"/> --%>
								</td>
							</tr>
						</table>					
					</c:when>
					<c:otherwise>
						<table class="cost_detail_tbl">
							<colgroup>
								<col style="width:8%;" />
								<col style="width:8%;" />
								<col style="width:5%;" />
								<col style="width:5%;" />
								<col style="width:8%;" />
								
								<col style="width:6%;" />
								
								<col style="width:10%;" />
								<col style="width:15%;" />
								<col style="width:15%;" />
								<col style="width:15%;" />
								
								<col style="width:5%;" />
							</colgroup>				
							<tr>
								<th>종결일자</th>
								<th>계정명</th>
								<th>구분</th>
								<th>영수증 수</th>
								<th>금액(원)</th>
								
								<th>관련회사</th>
								<th>계약자명</th>
								<th>접수번호</th>
								<th>총 이동거리</th>
								<th>비고</th>
								<th>-</th>
							</tr>		
									
							<tr>
								<td><input type="text" id="cost_occur_date_insert" name="cost_occur_date_insert" class="calendar" style="width:70px;"/></td>
								<td>
									<select id="cost_class_no_insert">
										<option value="" data-cost_kind="0">- 선택 -</option>
										<c:forEach items="${costClassNoList}" var="item" varStatus="status">
											<c:if test="${item.col_cd1 eq costKind}">
												<option value="${item.col_cd2}" data-cost_kind="${item.col_cd1}">${item.col_val}</option>
											</c:if>
										</c:forEach>							
									</select>
								</td>
								<td>
									<select id="cost_pay_type_insert">
										<option value="1">카드</option>
										<option value="0">현금</option>
									</select>
								</td>
								<td><input type="text" id="cost_bill_ea_insert" name="cost_bill_ea" style="width: 30px;"/> ea</td>
								<td><input type="text" id="cost_pay_amt_insert" name="cost_pay_amt" class="money" /> </td>		
								<td>
									<select id="cost_involved_com_insert">
										<option value="메리츠">메리츠</option>
										<option value="농협">농협</option>
										<option value="새마을">새마을</option>
									</select>
								</td>
								
								<td><input type="text" id="cost_involved_man_insert" name="cost_involved_man_insert" /></td>
								<td><input type="text" id="cost_suim_accept_no_insert" name="cost_suim_accept_no_insert" placeholder="ex)TL1701-1234" /></td>
								<td><input type="text" id="cost_distance_insert" name="cost_distance_insert" /></td>
								<td><input type="text" id="cost_memo_insert" name="cost_memo_insert" placeholder="ex)서울지역 왕복1회"/></td>		
								<td>
									<img src="./resources/ls_img/btn_add.gif"  onclick="fnCostItemInsert(${costKind})"  alt="추가" style ="cursor:pointer" />
		<%-- 							<input type="hidden" id="cost_deposit_no" name="cost_deposit_no" value="${getMyCostDepositInfo.cost_deposit_no}"/> --%>
								</td>
							</tr>
						</table>					
					
					</c:otherwise>
				</c:choose>
				
			</div><!-- //tableStyle -->
			

