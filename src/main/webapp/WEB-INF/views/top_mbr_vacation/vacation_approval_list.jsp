<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
	<style>
		.td-overflow-none{
			text-overflow : ellipsis;
			overflow : hidden;
			white-space : nowrap;
			word-wrap:normal;
		}
		
		.btn-vacation-aprv {
			font-weight:bold;
			text-decoration:none;
			font-family:Arial;
			text-indent:0px;
			line-height:0px;
			-moz-border-radius:5px;
			-webkit-border-radius:5px;
			border-radius:5px;
			text-align:center;
			vertical-align:middle;
			display:inline-block;
			font-size:12px;
			color:#696969  !important;
			width:60px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #eeeeee;
		}

		.btn-vacation-aprv:active {
			position:relative;
			top:4px
		}
		
		/* 모달 버튼 */
		.ui-button-text-only {
			height:2.1em !important;
		}
	</style>		
						<form id="listFrm" action="vacationApproval" method="POST">
						<input type="hidden" id="pageIdx" name="pageIdx" />
						<input type="hidden" id="view_type" name="view_type" value="action"/>
						<%-- 최종결재 권한이 있는 경우만 표시 --%>
						<c:if test="${lastApAuth eq 1}">
							<div style="padding-bottom:5px;text-align:right;">
								<input title="휴가일괄결재" class="buttonAssistance" style="width:140px;font-weight:bold;" type="button" value="휴가일괄결재" id="vacationBtn">
							</div>
						</c:if>	
							<div class= "tableStyle2" style="border-top: 0px;">																
								<table>									
									<thead>
										<tr>
											<%-- 최종결재 권한이 있는 경우만 표시 --%>
											<c:if test="${lastApAuth eq 1}">
												<th width="2%">
													<!-- 전체 체크 -->
													<input type="checkbox" id="chkAll" onclick="fnAllChk();" name="chkAll" >
												</th>										
											</c:if>	
											<th width="4%">No.</th>
											<th width="9%">센터명</th>
											<th width="9%">부서명</th>
											<th width="9%">이름</th>
											<th width="6%">신청일</th>
											<th width="8%">종류</th>
											<th width="10%">기간</th>
											<th width="5%">결재 전<br/>잔여일</th>
											<th width="5%">사용일</th>
											<th width="5%">차감일</th>
											<th width="10%">사유</th>
											<th width="10%">상태</th>
											<th width="8%">비고</th>											
										</tr>
									</thead>
									<tbody>
										<c:set var="chkIdx" value="0"></c:set>
										<c:choose>
											<c:when test="${approvalList.size() != 0}">
												<c:forEach items="${approvalList}" var="item" varStatus="status">
													<tr>
														<c:if test="${lastApAuth eq 1}">
															<td class="td-overflow-none">
																<%-- <input type="checkbox" id="chkInvoiceNo_${status.index}" name="chkInvoiceNo" value="${invVO.rpt_invoice_no}" tabindex="1"/> --%>
																<%-- 최종결재 상태인 경우만 체크박스 활성화 --%>																															
																<c:choose>
																	<c:when test="${item.approval_state eq 30}">
																		<input type="checkbox" id="chkVacationNo_${chkIdx}" name="chkVacationNo" value="${item.serial_no}"/>
																		<c:set var="chkIdx" value="${chkIdx+1}"></c:set>
																	</c:when>
																	<c:otherwise>
																		<input type="checkbox" disabled/>
																	</c:otherwise>
																</c:choose>															
															</td>
														</c:if>				
														<td class="td-overflow-none">${pageInfo.totalRecordCount - (pageInfo.recordCountPerPage * (pageInfo.currentPageNo-1)) - status.index}</td>														
														<td class="td-overflow-none">${item.center_name}</td>
														<td class="td-overflow-none">${item.team_name}</td>
														<td class="td-overflow-none">${item.user_name}</td>
														<td class="td-overflow-none">${item.regdate}</td>														
														<td class="td-overflow-none">${item.vacation_type_val}</td>														
														<td class="td-overflow-none">${item.sdate} ~ ${item.edate}</td>
														<%-- <td class="td-overflow-none"><fmt:formatNumber value="${item.annual_set}" pattern="0.00"/> 일</td> --%>
														<td class="td-overflow-none"><fmt:formatNumber value="${item.remain_vacation_use}" pattern="0.00"/> 일</td>
														<td class="td-overflow-none">${item.vacation_interval} 일</td>
														<td class="td-overflow-none">
															<c:choose>
																<c:when test="${item.vacation_type eq 100 or item.vacation_type eq 200 or item.vacation_type eq 210}">
																	${item.vacation_interval} 일
																</c:when>
																<c:otherwise>
																	0 일
															</c:otherwise>
															</c:choose>															
														</td>														
														<td class="td-overflow-none">${item.vacation_content}</td>
														<td class="td-overflow-none">${item.approval_state_val}</td>
														<td class="td-overflow-none">
															<a href="#noloc" class="btn-vacation-aprv" id="btn-detail" onclick="openDetail(${item.serial_no})" style="width: 58px;">결재</a>
														</td>
													</tr>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<tr>
													<td colspan="14">
														결재 할 휴가가 없습니다.
													</td>
												</tr>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
														
							<input type="hidden" id="currPageIdx" value="${pageInfo.currentPageNo}"/>
							<div class="pagingWrap">
					    	<%--<div class="pageContent">--%>
					        	<c:import url="/page_navi_vacation_list">
					            	<c:param name="beginIdx" value="${pageInfo.firstPageNoOnPageList}"/>
					                <c:param name="endIdx" value="${pageInfo.lastPageNoOnPageList}"/>
					                <c:param name="currentIdx" value="${pageInfo.currentPageNo}"/>
					                <c:param name="totalPageCnt" value="${pageInfo.totalPageCount}"/>					                
								</c:import>
							<%--</div>--%>
					      	</div>
					      	</form>
						
						<script>
							var vacationNoArr = new Array();	
						
							$(document).ready(function(){
								_initBtn();
								$("#srchTeamId").select2();
								$("#srchYear").select2();
								$("#srchKind").select2();
								$("#srchState").select2();
							});
							
							function _initBtn(){
								$(".vacationChk").on("click",function(){
									var vacationNo = $(this).val();
									var selectFlag = $(this).is(":checked");
									if (selectFlag){
										$("#aprvTr"+vacationNo).attr("style","background-color:#FFECEC;cursor:pointer;");
									}else{
										$("#aprvTr"+vacationNo).attr("style","background-color:'';cursor:pointer;");
									}
								});
								
								$("#chkAll").on("click",function(){
									var checked = $(this).is(":checked");
									fnAllChk(checked);
								});
								
								$("#btn-aprv").on("click",function(){
									setVacationNo();
									if ( $('input:checkbox[name="vacationChk"]:checked').length == 0){
										alert("선택된 휴가가 없습니다.");
										return;
									}
									if (!confirm("선택한 휴가를 승인 하시겠습니까?")){
										return;
									}
									fnVacationArpvAction("A");
								});
								
								$("#btn-return").on("click",function(){
									setVacationNo();
									if ( $('input:checkbox[name="vacationChk"]:checked').length == 0){
										alert("선택된 휴가가 없습니다.");
										return;
									}
									$("#return-dialog").dialog({
										height: 180,
										width: 600,
										closeOnEscape : true,
										draggable : false,
										title: "반려하기",
										buttons:{
											"반려하기" : function(){
												if (!confirm("선택한 휴가를 반려 하시겠습니까?")){
													return;
												}
												
												fnVacationArpvAction("R");
												$(this).dialog("close");
											},
											"취소" : function(){
												$(this).dialog("close");
											}
										},
										modal: true,
										overlay:{ opacity: 0., background: '#000000'}
									});	
								});
								
								
							}
							
							
							function fnAllChk(checked){
								$('input:checkbox[name="vacationChk"]').each(function() {
									if ( checked != this.checked ){
										this.click();
									}
								 });
							}
							
							
							function setVacationNo(){
								vacationNoArr = [];
								$('input:checkbox[name="vacationChk"]').each(function() {
									if ( this.checked ){
										vacationNoArr.push(this.value);
									}
							 	});
							}
							
							
							function fnVacationArpvAction(action){
								var url = "actionVacationAprv";
								var param = {};
								param.action = action;
								param.vacationNo = vacationNoArr;
								param.returnComment = $("#return_comment").val();
								
								$.ajaxSettings.traditional = true;
								
							    $.ajax({
							        type: "POST",
							        url: url,
							        data: param,
							        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
							        timeout: 20000,
							        dataType: "JSON", 
							        success: function(data){
						        		alert(data.msg);
						        		if (data.result == "0000" ){//
							        		location.reload();
							        	}
						        		
						        		return;
							        },
							        error: function(e){
							            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
							        }
							    });
							}
							
							function openDetail(serial_no){
								var url = "/vacationDetailNewModal";
								var param = {};
								param.serial_no = serial_no;	
								param.view_type = "action";								
																
							    $.ajax({
							        type: "POST",
							        url: url,
							        data: param,
							        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
							        timeout: 20000,
							        dataType: "HTML", 
							        success: function(data){
							        	$("#vacation-detail-dialog").html();
							        	$("#vacation-detail-dialog").html(data);
										$("#vacation-detail-dialog").dialog({
											height: 630,
											width: 800,
											closeOnEscape : true,
											draggable : true,
											title: "휴가 신청 내역 상세",
											//buttons : modalButtons,
											modal: true,
											buttons:{						
												"닫기" : function(){
													$(this).dialog("close");
												}
											},
											overlay:{ opacity: 0., background: '#000000'}
										});		
							        },
							        error: function(e){
							            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
							        }
							    });	
							}							
						</script>
