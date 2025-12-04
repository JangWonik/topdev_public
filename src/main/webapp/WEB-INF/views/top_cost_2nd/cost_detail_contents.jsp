<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
		
		
			<c:import url="./cost_detail_insert.jsp" />	
			
			<br />
			<b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;"/>
				<c:choose>
					<c:when test="${costKind eq '1'}">경비내역 수정/삭제</c:when>
					<c:otherwise>추가 경비내역 수정/삭제</c:otherwise>
				</c:choose> 
				
			</b>
			<div class= "tableStyle2">
				<table class="cost_detail_tbl">
					<colgroup>
						<col style="width:8%;" />
						<col style="width:8%;" />
						<col style="width:5%;" />
						<col style="width:5%;" />
						<col style="width:8%;" />
						
						<col style="width:10%;" />
						<col style="width:10%;" />
						<col style="width:10%;" />
						<col style="width:15%;" />
						
						<col style="width:6%;" />
						<col style="width:8%;" />								
						
						<col style="width:7%;" />
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
						<th>상태</th>
						<th>확정금액</th>
						<th>비고</th>
					</tr>
					
					
					<c:set var="item_aprv_state" value="1"/>
					<c:forEach items="${costDetailContents}" var="item" varStatus="status" >
						<tr>
							<td>
								<input type="text" id="cost_occur_date_${status.index}" class="calendar" name="cost_occur_date_${status.index}" value="${item.cost_occur_date_fmt}" style="width:70px;"/>
							</td>
							
							<td>
								<c:set var="costClassNo" value="${item.cost_class_no}" />
								<select id="cost_class_no_${status.index}">
									<c:forEach items="${costClassNoList}" var="costClassItem">
										<c:if test="${costClassItem.col_cd1 eq item.cost_kind}">
											<c:choose>
												<c:when test="${costClassItem.col_cd2 eq costClassNo}">
													<option value="${costClassItem.col_cd2}" selected="selected" data-cost_kind="${costClassItem.col_cd1}">${costClassItem.col_val}</option>
												</c:when>
												<c:otherwise>
													<option value="${costClassItem.col_cd2}" data-cost_kind="${costClassItem.col_cd1}">${costClassItem.col_val}</option>
												</c:otherwise>
											</c:choose>
										</c:if>
										
									</c:forEach>				
								</select>
							</td>
							
							<td>
								<select id="cost_pay_type_${status.index}">
									<option value="1" <c:if test="${item.cost_pay_type eq '1'}"> selected="selected" </c:if>>카드</option>
									<option value="0" <c:if test="${item.cost_pay_type eq '0'}"> selected="selected" </c:if>>현금</option>
								</select>
							</td>
							
							<td>
								<input type="text" id="cost_bill_ea_${status.index}" name="cost_bill_ea_${status.index}" value="${item.cost_bill_ea}" style="width:20px"/>ea
							</td>
							
							<td>
								<input type="text" name="cost_pay_amt_${status.index}" id="cost_pay_amt_${status.index}" class="money" value="${item.cost_pay_amt}" style="IME-MODE: disabled;width:63px;" />
							</td> 
							
							<td><input type="text" id="cost_pay_place_${status.index}" name="cost_pay_place_${status.index}" value="${item.cost_pay_place}" /></td>
							<td><input type="text" id="cost_involved_com_${status.index}" name="cost_involved_com_${status.index}" value="${item.cost_involved_com}"/></td>
							<td><input type="text" id="cost_involved_man_${status.index}" name="cost_involved_man_${status.index}" value="${item.cost_involved_man}"/></td>
							<td><input type="text" id="cost_memo_${status.index}" name="cost_memo_${status.index}" value="${item.cost_memo}"/></td>
							
							<td>${item.cost_item_state_nm}</td>
							<td>
								<c:choose>
									<c:when test="${item.cost_item_state ne '0'}"><span class="money">${item.cost_pay_amt}</span></c:when>
									<c:otherwise>0 원</c:otherwise>
								</c:choose>
							</td>
							
							<td>
								<c:choose>
									<c:when test="${item.cost_item_state ne '4'}">
										<img src="./resources/ls_img/btn_edit_s.gif" data-idx="${status.index}" data-cost_no="${item.cost_no}" class="btn_cost_detail_mod" alt="수정" style ="cursor:pointer" />
										<img src="./resources/ls_img/btn_del_s.gif"  data-cost_no="${item.cost_no}" class="btn_cost_detail_del" alt="삭제" style ="cursor:pointer" />
									</c:when>
									<c:otherwise>
										-
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						
						
						<c:set var="tmp_bill_ea" value="${tmp_bill_ea + item.cost_bill_ea}"/>
						<c:set var="tmp_pay_amt" value="${tmp_pay_amt + item.cost_pay_amt}"/>
						
						<c:choose>
							<c:when test="${item.cost_item_state eq '0'}">
								<c:set var="tmp_deposit_amt" value="${tmp_deposit_amt + 0}"/>
								<c:set var="item_aprv_state" value="0" />
							</c:when>
							<c:when test="${item.cost_item_state eq '1'}">
								<c:set var="tmp_deposit_amt" value="${tmp_deposit_amt + item.cost_pay_amt}"/>
								<c:set var="item_aprv_state" value="1" />
							</c:when>							
							<c:otherwise>
								<c:set var="item_aprv_state" value="2" />
								<c:set var="tmp_deposit_amt" value="${tmp_deposit_amt + item.cost_pay_amt}"/>
							</c:otherwise>
						</c:choose>
						
												
						<c:if test="${item.cost_class_no != costDetailContents[status.count].cost_class_no}">
							<tr bgcolor="#E7ECF1">
								<td colspan="3"><b>소계</b></td>
								<td><span class="money">${tmp_bill_ea}</span> ea</td>
								<td><span class="money">${tmp_pay_amt}</span> 원</td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td><span class="money">${tmp_deposit_amt}</span> 원</td>
								<td></td>
							</tr>
							<c:set var="sum_cost_deposit_amt" value="${tmp_deposit_amt + sum_cost_deposit_amt}" />
							
							<c:set var="tmp_bill_ea" value="0"/>
							<c:set var="tmp_pay_amt" value="0"/>
							<c:set var="tmp_deposit_amt" value="0"/>
						</c:if>
						
						<c:set var="sum_cost_bill_ea" value="${item.cost_bill_ea + sum_cost_bill_ea}" />
						<c:set var="sum_cost_pay_amt" value="${item.cost_pay_amt + sum_cost_pay_amt}" />
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
						<td><span class="money">${sum_cost_deposit_amt}</span> 원</td>
						<td>
							
							<c:if test="${costDetailContents.size() != 0 and (mbrAuthVo_Session.mbr_pms_17 eq '1' or mbrAuthVo_Session.mbr_pms_18 eq '1')}">			
								<c:choose>
									<c:when test="${item_aprv_state eq '0'}">
										<img class="btn_tm_aprv" data-aprv_state="1" data-cost_kind="${costKind}" src="./resources/ls_img/top_cost/btn_rch_1.gif" style="cursor:pointer;" />
									</c:when>
									<c:when test="${item_aprv_state eq '1'}">
										<img class="btn_tm_aprv" data-aprv_state="0" data-cost_kind="${costKind}" src="./resources/ls_img/top_cost/btn_rch_1x.gif" style="cursor:pointer;" />			
									</c:when>
								</c:choose>
							</c:if>
							
						</td>
					</tr>
				</table>
				<b><font color="red">※ 현금관련 영수증은 한장당 3만원 이상 불가 (병원영수증제외)</font></b>
			</div><!-- //tableStyle -->
			<br />
			
			<b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;" /> 영수증 업로드</b>
			<div id="file_div">
			<c:import url="/cost_detail_file" >
				<c:param name="cost_deposit_no" value="${costDeposit.cost_deposit_no}" />
				<c:param name="cost_deposit_state" value="${costDeposit.cost_deposit_state}"/>
			</c:import>
			</div>
			
			<c:if test="${costKind eq '1' and srchArg.team_type eq '4' }">
				<b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;"/> 협조건 내역</b>
				<div class= "tableStyle2">
					<table id="helpTable">
					 	<tbody>
							<tr>
								<th>구분</th>
								<th>의뢰팀</th>
								<th>의뢰인</th>
								<th>수임팀</th>
								<th>수임인</th>
								<th>보고서번호</th>
								<th>피보험자</th>
								<th>의뢰일</th>
								<th>완료일</th>
								<th>상태</th>
								<th>금액</th>
								<th>상세보기</th>
							</tr>
							<c:set var="clientPriceSum" value="0"/>
							<c:forEach items="${rptHelpClientList}" var="clientItem">
								<tr>
									<td style="color: red;">의뢰</td>
									<td>${clientItem.client_team_nm}</td>
									<td>${clientItem.client_id_nm}</td>
									<td>${clientItem.accept_team_nm}</td>
									<td>${clientItem.accept_id_nm}</td>
									<td>${clientItem.suim_accept_no}</td>
									<td>${clientItem.beneficiary_nm}</td>
									<td>${clientItem.reg_date_fmt}</td>
									<td>${clientItem.end_date_fmt}</td>
									<td>${clientItem.help_state_val}</td>
									<td style="color:red;"><span class="money">${clientItem.price_total}</span> 원</td>
									<td><input type="image" src="./resources/ls_img/top_cost/btn_view.gif" onclick="viewhelpbtn(${clientItem.serial_no})" /></td>
								</tr>
								
								<c:set var="clientPriceSum" value="${clientPriceSum + clientItem.price_total}"/>
							</c:forEach>
							<tr>
								<td colspan="10">합계</td>
								<td style="font-weight: bold;">
									<span class="money">${clientPriceSum}</span>원
								</td>
								<td></td> 
							</tr>
						</tbody>
					</table>
				</div><!-- //tableStyle -->
				<br />
				<b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;"/> 의뢰건 내역</b>
				<div class= "tableStyle2">
					<table id="helpTable">
					 	<tbody>
							<tr>
								<th>구분</th>
								<th>의뢰팀</th>                                                                      
								<th>의뢰인</th>
								<th>수임팀</th>
								<th>수임인</th>
								<th>보고서번호</th>
								<th>피보험자</th>
								<th>의뢰일</th>
								<th>완료일</th>
								<th>상태</th>
								<th>금액</th>
								<th>상세보기</th>
							</tr>
							<c:set var="acceptPriceSum" value="0"/>
							<c:forEach items="${rptHelpAcceptList}" var="acceptItem">
								<tr>
									<td style="color: blue;">수임</td>
									<td>${acceptItem.client_team_nm}</td>
									<td>${acceptItem.client_id_nm}</td>
									<td>${acceptItem.accept_team_nm}</td>
									<td>${acceptItem.accept_id_nm}</td>
									<td>${acceptItem.suim_accept_no}</td>
									<td>${acceptItem.beneficiary_nm}</td>
									<td>${acceptItem.reg_date_fmt}</td>
									<td>${acceptItem.end_date_fmt}</td>
									<td>${acceptItem.help_state_val}</td>
									<td style="color: blue;"><span class="money"  >${acceptItem.price_total}</span> 원</td>
									<td><input type="image" src="./resources/ls_img/top_cost/btn_view.gif" onclick="viewhelpbtn(${acceptItem.serial_no})" /></td>
								</tr>  
								<c:set var="acceptPriceSum" value="${acceptPriceSum + acceptItem.price_total}"/>
							</c:forEach>
							<tr>
								<td colspan="10">합계</td>
								<td style="font-weight: bold;">
									<span class="money">${acceptPriceSum}</span> 원
								</td>
								<td></td>
							</tr>
						</tbody>
					</table>
				</div><!-- //tableStyle -->
				
			</c:if>
				
			<!-- memo -->
			<c:if test="${costDeposit.cost_deposit_state eq '4' and srchArg.gubun eq 'finance' }">
				<input type="hidden" id="targetStr" value="costDetail" />
				<input type="hidden" id="linkNo" value="${costDeposit.cost_deposit_no}" />
				<script>
					var dialog;
					$(document).ready(function(){
				
						$.ajaxSetup({cache:false});
			
						$("#searchResultTable").hide();
			
						//update form start
						dialog = $("#dialog-form").dialog({
							autoOpen: false,
							height: 300,
							width: 350,
							modal: true
						});
						//update form end
			
						//최초 조회 시작
						$.post("./boardMemoList",
								{	targetStr:$("#targetStr").val()
									,linkNo:$("#linkNo").val()
								},
								function(data,status){
									if(status == "success"){
										if(data.length > 0){
											$("#searchResultTable").show();
						                    $.each(data, function(index, entry) {
				                        		$("#memoTbody").append('<tr>'
														+"<td stlye='text-align:center;'>"+entry.userNm+"</td>"
														+"<td style='text-align:left;padding-left:5px;'>"+entry.mContents+"</td>"
														+"<td stlye='text-align:center;'>"+entry.regDate+"</td>"
														+"<td stlye='text-align:center;'><img src='./resources/ls_img/ls_memo/btn_s_edite.gif' id='editBtn"+index+"' style='cursor:pointer;' /></td>"
														+"<td stlye='text-align:center;'><img src='./resources/ls_img/ls_memo/btn_s_del.gif' id='delBtn"+index+"' style='cursor:pointer;' /></td>"
				                                		+ '</tr>'
					   							);
				                        		$("#editBtn"+index).bind("click",function(){
				                        			memoUpdateForm(entry.userNo, entry.memoNo, entry.userNm, $(this).parent().parent().children().eq(1).html(), entry.regDate, $(this).parent().parent().index());
				                        		});
				                        		$("#delBtn"+index).bind("click",function(){
				                        			memoDelete(entry.userNo, entry.memoNo, $(this).parent().parent().index());
				                        		});
											});//each
										}//if(data.length > 0){
									}else{
										alert("메모를 불러오기를 실패하였습니다. 잠시 후 다시 시도해 주세요.");
									}
								},"json"
						);//post
						//최초 조회 끝
			
						//메모 등록 시작
						$("#memoWrite").click(function(){
							if($("#memoArea").val().trim() == ""){
								return;
							}
							$.post("./boardMemoWrite",
									{	targetStr:$("#targetStr").val()
										,linkNo:$("#linkNo").val()
										,mContents:$("#memoArea").val()
									},
									function(data,status){
										if(status == "success"){
											if(data.length == 0){
												alert("메모 등록을 실패 하였습니다.");
											}else{
												$("#searchResultTable").show();
												var tmpVar = $("#memoTbody").children().last().index()+1;
							                    $.each(data, function(index, entry) {
					                        		$("#memoTbody").append('<tr>'
															+"<td>"+entry.userNm+"</td>"
															+"<td style='text-align:left;padding-left:5px;'>"+entry.mContents+"</td>"
															+"<td>"+entry.regDate+"</td>"
															+"<td><img src='./resources/ls_img/ls_memo/btn_s_edite.gif' id='editBtn"+tmpVar+"' style='cursor:pointer;' /></td>"
															+"<td><img src='./resources/ls_img/ls_memo/btn_s_del.gif' id='delBtn"+tmpVar+"' style='cursor:pointer;' /></td>"
					                                		+ '</tr>'
						   							);
					                        		$("#editBtn"+tmpVar).bind("click",function(){
					                        			memoUpdateForm(entry.userNo, entry.memoNo, entry.userNm, $(this).parent().parent().children().eq(1).html(), entry.regDate, $(this).parent().parent().index());
					                        		});
					                        		$("#delBtn"+tmpVar).bind("click",function(){
					                        			memoDelete(entry.userNo, entry.memoNo, $(this).parent().parent().index());
					                        		});
												});//each
												$("#memoArea").val("");
												alert("나도한마디가 등록되었습니다.");
											}//if(data.length == 0){
										}else{
											alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
										}
									},"json"
							);//post
			
						});//$("#memoWrite").click
						//메모 등록 끝
			
						//메모 수정 start
						$("#memoUpdateBtn").click(function(){
							if($("#mcon").val().trim() == ""){
								alert("메모 내용을 확인 후 저장해주세요.");
								$("#mcon").focus();
								return;
							}
							$.post("./boardMemoUpdate",
									{	targetStr:$("#targetStr").val()
										,memoNo:$("#mno").val()
										,mContents:$("#mcon").val()
									},
									function(data,status){
										if(status == "success"){
											if(data.length == 0){
												alert("메모 수정을 실패 하였습니다.");
											}else{
												$("#memoTbody").children().eq($("#idx").val()).children().eq(1).html($("#mcon").text().replace(/\n/g,'<br>'));
												$("#idx").val('');
												$("#mno").val('');
												$("#unm").text('');
												$("#rdate").text('');
												$("#mcon").text('');
												dialog.dialog("close");
											}//if(data.length == 0){
										}else{
											alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
										}
									}
							);//post
						});
						//메모 수정 end
			
					});//$(document).ready
			
					//메모 삭제 start
					function memoDelete(userNo, memoNo, index){
						if('${mbrVo_Session.user_no}' != userNo){
							alert("메모는 작성하신 당사자만이 삭제 가능합니다.");
							return;
						}
			
						var tmp = window.confirm("메모를 삭제 하시겠습니까?");
						if(tmp == false){
							return;
						}else if(tmp == true){
							$.post("./boardMemoDelete",
									{	targetStr:$("#targetStr").val()
										,memoNo:memoNo
									},
									function(data,status){
										if(status == "success"){
											if(data.length == 0){
												alert("메모 삭제를 실패 하였습니다.");
											}else{
												$("#memoTbody").children().eq(index).remove();
											}//if(data.length == 0){
										}else{
											alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
										}
									}
							);//post
						}
					}
					//메모 삭제 end
			
					//update form open start
					function memoUpdateForm(userNo, memoNo, userNm, mContents, regDate, index){
						if('${mbrVo_Session.user_no}' != userNo){
							alert("메모는 작성하신 당사자만이 수정 가능합니다.");
							return;
						}
			
						$("#idx").val(index);
						$("#mno").val(memoNo);
						$("#unm").text(userNm);
						$("#rdate").text(regDate);
						$("#mcon").val(mContents.replace(/<br>/g,'\r'));
						dialog.dialog("open");
					}
					//update form open end
				</script>
			
				<div id="dialog-form" title="메모 수정">
					<form>
						<input type="hidden" id="idx">
						<input type="hidden" name="mno" id="mno">
						작성자 : <span id="unm"></span>
						<br />
						작성일 : <span id="rdate"></span>
						<br />
						내 용
						<br />
						<textarea rows="8" cols="45" id="mcon" wrap="hard"></textarea>
						<br /><br />
						<div style="text-align: center">
							<img src='./resources/ls_img/btn_edite.gif' id='memoUpdateBtn' style='cursor:pointer;' />
						</div>
					</form>
				</div>
			
				<!-- 검색 조건 테이블 -->
				
				<!-- //검색 조건 테이블 -->
				<br />
				<!-- 검색 결과 테이블 -->
				<div class= "tableStyle4" id="searchResultTable">
					<table>
						<thead>
							<tr>
								<th width="10%">작성자</th>
								<th width="55%">한 줄 메모</th>
								<th width="15%">작성일</th>
								<th width="10%">수정</th>
								<th width="10%">삭제</th>
							</tr>
						</thead>
						<tbody id="memoTbody">
							<tr>
							</tr>
						</tbody>
					</table>
				</div><!-- //tableStyle2 -->
				<!-- //검색 결과 테이블 -->
				<br>
				<div class= "tableStyle4">
					<table>
						<tbody>
							<tr>
								<td width="15%">
									<input type="image" src="./resources/ls_img/ls_memo/t_memo.gif" />
								</td>
								<td width="60%">
									<textarea style="width:99%" rows="3" cols="" id="memoArea"></textarea>
								</td>
								<td width="10%">
									<input type="image" src="./resources/ls_img/ls_memo/btn_write.gif" id="memoWrite" />
								</td>
							</tr>
						</tbody>
					</table>
				</div><!-- //tableStyle2 -->
			</c:if>
			<!-- //memo -->
				
