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
		
							<div class= "tableStyle2" style="border-top: 0px;">
								<!-- search-box -->
								<form id="aprvFrm" action="vacationAprvList" method="POST">
									<div id="search-box"  align="center">
										<table style="width: 80%;" align="center">
											<colgroup>
												<col width="70px" />
												<col width="200px" />
												<col width="70px" />
												<col width="200px" />
												<col width="70px" />
												<col width="200px" />
												<col width="300px" />
											</colgroup>
											<tr>
												<th>년도</th>
												<td>
													<select id="srchYear" name="srchYear">
														<option value="99">- 전체 -</option>
														<c:forEach items="${yearList}" var="item" varStatus="status">
															<c:choose>
																<c:when test="${srchParam.srchYear == item}">
																	<option value="${item}" selected="selected">${item} 년</option>
																</c:when>
																<c:otherwise>
																	<option value="${item}">${item} 년</option>
																</c:otherwise>
															</c:choose>
														</c:forEach>
													</select>
												</td>
												<th>종류</th>
												<td>
													<select id="srchKind" name="srchKind">
														<option value="99">- 전체 -</option>
														<c:forEach items="${vacationKindList}" var="item" varStatus="status">
															<c:choose>
																<c:when test="${srchParam.srchKind == item.col_cd}">
																	<option value="${item.col_cd}" selected="selected">${item.col_val}</option>
																</c:when>
																<c:otherwise>
																	<option value="${item.col_cd}">${item.col_val}</option>
																</c:otherwise>
															</c:choose>													
														</c:forEach>
													</select>											
												</td>
												<th>상태</th>
												<td>
													<select id="srchState" name="srchState">
														<option value="99">- 전체 -</option>
														<c:forEach items="${vacationStateList}" var="item" varStatus="status">
															<c:choose>
																<c:when test="${srchParam.srchState == item.col_cd}">
																	<option value="${item.col_cd}" selected="selected">${item.col_val}</option>
																</c:when>
																<c:otherwise>
																	<option value="${item.col_cd}">${item.col_val}</option>
																</c:otherwise>
															</c:choose>		
														</c:forEach>	
													</select>												
												</td>
												<td rowspan="2" style="border: 1px;" align="right">
													<a href="#noloc" class="btn-vacation-aprv" id="btn-aprv" style="background:#5792c2;color:#ffffff !important;">승인</a>
													&nbsp;&nbsp;&nbsp;
													<a href="#noloc" class="btn-vacation-aprv" id="btn-return" style="background:#c25757;color:#ffffff !important;">반려</a>
												</td>
											</tr>
											<tr>
												<th>부서</th>
												<td>
													<span style="text-align: left !important;">
														<select id="srchTeamId" name="srchTeamId" style="width: 156px;">
															<option value="0">- 전체 -</option>
															<c:forEach items="${teamList}" var = "teamVo">
																<c:choose>
																	<c:when test="${srchParam.srchTeamId == item.team_id}">
																		<option value="${teamVo.team_id}" selected="selected">
																	</c:when>
																	<c:otherwise>
																		<option value="${teamVo.team_id}">
																	</c:otherwise>
																</c:choose>																
																	<c:if test="${teamVo.team_level == 1}">&nbsp;└</c:if>
																	<c:if test="${teamVo.team_level == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
																	${teamVo.team_name}																
															</c:forEach>
														</select>
													</span>
												</td>
												<th>이름</th>
												<td>
													<input type="text" id="srchUserName" name="srchUserName" value="${srchParam.srchUserName }"/>
												</td>
												<td colspan="2">
													<a href="#noloc" class="btn-vacation-aprv" id="btn-search" onclick='$("#aprvFrm").submit();'>검색</a>
												</td>
											</tr>
										</table>
										<br/>
									</div> 
								</form>
									
								<table>
									<colgroup>
										<col width="2%"/>
										<col width="4%"/>
										<col width="8%"/>
										<col width="8%"/>
										<col width="7%"/>
										<col width="3%"/>
										<col width="6%"/>
										<col width="6%"/>
										<col width="8%"/>
										<col width="12%"/>
										<col width="5%"/>
										<col width="18%"/>
										<col width="6%"/>
										<col width="7%"/>
									</colgroup>
									<thead>
										<tr>
											<th><input type="checkbox" id="chkAll" /></th>
											<th>No.</th>
											<th>센터명</th>
											<th>부서명</th>
											<th>이름</th>
											<th>직급</th>
											<th>입사일</th>
											<th>신청일</th>
											<th>종류</th>
											<th>기간</th>
											<th>사용 일수</th>
											<th>사유</th>
											<th>상태</th>
											<th>비고</th>
										</tr>
									</thead>
									<tbody>
										<c:choose>
											<c:when test="${vacationAprvList.size() != 0}">
												<c:forEach items="${vacationAprvList}" var="item" varStatus="status">
													<tr class="aprvTr" id="aprvTr${item.vacationNo}" style ="cursor:pointer;">
														<td> <input type="checkbox" class="vacationChk" name="vacationChk" id="vacationChk${item.vacationNo}" value="${item.vacationNo}"/> </td>
														<td class="td-overflow-none">${item.vacationNo}</td>
														<td class="td-overflow-none">${item.centerNm}</td>
														<td class="td-overflow-none">${item.teamNm}</td>
														<td class="td-overflow-none">${item.userNm}</td>
														<td class="td-overflow-none">${item.workLevelNm}</td>
														<td class="td-overflow-none">${item.joinDate}</td>
														<td class="td-overflow-none">${item.regDate}</td>
														<td class="td-overflow-none">${item.vacationKindValue}</td>
														<td class="td-overflow-none" style="letter-spacing: 0px;">${item.vacationStartDate} ~ ${item.vacationEndDate}</td>
														<td class="td-overflow-none">
															<fmt:formatNumber value="${item.vacationUseCnt}" pattern="##.#"/> 일
														</td>
														<td class="td-overflow-none">${item.vacationComment}</td>
														<td class="td-overflow-none">${item.vacationStateValue}</td>
														<td class="td-overflow-none">
															<a href="#noloc" class="btn-vacation-aprv" id="btn-detail" onclick="openDetail(${item.vacationNo})" style="width: 58px;">상세보기</a>
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
							
							function openDetail(vacationNo){
								var url = "/vacationDetailModal";
								var param = {};
								param.vacationNo = vacationNo;
								
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
											height: 870,
											width: 800,
											closeOnEscape : true,
											draggable : false,
											title: "휴가 신청 내역 상세",
											//buttons : modalButtons,
											modal: true,
											overlay:{ opacity: 0., background: '#000000'}
										});		
							        },
							        error: function(e){
							            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
							        }
							    });	
							}
						</script>
