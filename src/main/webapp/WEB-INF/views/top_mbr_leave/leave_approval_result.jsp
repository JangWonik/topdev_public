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
						<form id="resultFrm" action="leaveApproval" method="POST">
						<input type="hidden" id="pageIdxResult" name="pageIdxResult" />
						<input type="hidden" id="view_type" name="view_type" value="result"/>						
							<div class= "tableStyle2" style="border-top: 0px;">																
								<table>									
									<thead>
										<tr>											
											<th width="4%">No.</th>
											<th width="9%">센터명</th>
											<th width="9%">부서명</th>
											<th width="9%">이름</th>
											<th width="8%">신청일</th>
											<th width="8%">종류</th>
											<th width="10%">기간</th>											
											<th width="5%">사용일</th>											
											<th width="10%">사유</th>
											<th width="10%">상태</th>
											<th width="8%">비고</th>											
										</tr>
									</thead>
									<tbody>
										<c:choose>
											<c:when test="${approvalList.size() != 0}">
												<c:forEach items="${approvalList}" var="item" varStatus="status">
													<tr>														
														<td class="td-overflow-none">${pageInfo.totalRecordCount - (pageInfo.recordCountPerPage * (pageInfo.currentPageNo-1)) - status.index}</td>														
														<td class="td-overflow-none">${item.center_name}</td>
														<td class="td-overflow-none">${item.team_name}</td>
														<td class="td-overflow-none">${item.user_name}</td>
														<td class="td-overflow-none">${item.regdate}</td>
														<td class="td-overflow-none">${item.leave_type_val}</td>
														<td class="td-overflow-none">${item.sdate} ~ ${item.edate}</td>														
														<td class="td-overflow-none">${item.leave_interval} 일</td>																												
														<td class="td-overflow-none">${item.leave_content}</td>
														<td class="td-overflow-none">${item.approval_state_val}</td>
														<td class="td-overflow-none">
															<a href="#noloc" class="btn-vacation-aprv" id="btn-detail" onclick="openDetailView(${item.serial_no})" style="width: 58px;">상세보기</a>
														</td>
													</tr>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<tr>
													<td colspan="11">
														휴직 결재 내역이 없습니다.
													</td>
												</tr>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
														
							<input type="hidden" id="currPageIdx" value="${pageInfo.currentPageNo}"/>
							<div class="pagingWrap">					    	
					        	<%-- <c:import url="/page_navi_vacation_result"> --%>
					        	<c:import url="/page_navi_leave_result">
					            	<c:param name="beginIdx" value="${pageInfo.firstPageNoOnPageList}"/>
					                <c:param name="endIdx" value="${pageInfo.lastPageNoOnPageList}"/>
					                <c:param name="currentIdx" value="${pageInfo.currentPageNo}"/>
					                <c:param name="totalPageCnt" value="${pageInfo.totalPageCount}"/>					                					                
								</c:import>							
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
							
							function openDetailView(serial_no){
								
								//var url = "/vacationDetailNewModal";		//상세내역페이지
								var url = "/leaveDetailModal";		//상세내역페이지
								var param = {};
								param.serial_no = serial_no;	
								param.view_type = 'view';
																
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
											height: 500,
											width: 800,
											closeOnEscape : true,
											draggable : true,
											title: "휴직 결재 내역 상세",											
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
