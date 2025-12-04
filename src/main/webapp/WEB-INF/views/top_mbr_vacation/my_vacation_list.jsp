<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
	<style>
		
		.btn-vacation-list-ins {
			font-weight:bold;
			text-decoration:none;
			font-family:Arial;
			box-shadow:inset #fafafa 0px 5px 8px -1px;
			o-box-shadow:inset #fafafa 0px 5px 8px -1px;
			-moz-box-shadow:inset #fafafa 0px 5px 8px -1px;
			-webkit-box-shadow:inset #fafafa 0px 5px 8px -1px;
			text-indent:0px;
			line-height:0px;
			-moz-border-radius:3px;
			-webkit-border-radius:3px;
			border-radius:3px;
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

		.btn-vacation-list-ins:active {
			position:relative;
			top:4px
		}
		
		
		.btn-vacation-mod {
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

		.btn-vacation-mod:active {
			position:relative;
			top:4px
		}
		
	</style>	
		
							<div style="float: left; height: 25px;" >
					       		<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0">&nbsp;
					       		<b>${mbrVo_Session.team_name} ${mbrVo_Session.user_name}</b>
							</div>
							<div style="float: right;">
								<div style="text-align: right;">
									<a href="#noloc" class="btn-vacation-list-ins" id="btn-vacation-list-ins">휴가 신청</a>
								</div>
							</div>
							<div id="vacationListTable" class= "tableStyle2" style="border-top: 0px;">
								<form id="listFrm" action="myVacationMain" method="POST">
									<input type="hidden" id="pageIdx" name="pageIdx" />
									<input type="hidden" id="tab" name="tab" value="list" />
								</form>
								<br style="clear: both;"/>
								
								<div align="center">
									<table style="width:80%;">
										<tr>
											<th>년도</th>
											<td>
												<select id="srchYear">
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
												<select id="srchKind">
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
												<select id="srchState">
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
											<td>
												<a href="#noloc" class="btn-vacation-list-ins" id="btn-search">검색</a>
											</td>
										</tr>
									</table>
									<br/>
								</div> 
								
								<table style="width:100%">
									<colgroup>
										<col width="4%" />
										<col width="8%" />
										<col width="8%" /> 
										<col width="30%" />
										<col width="15%" />
										<col width="13%" />
										<col width="13%" />
										<col width="9%" />
									</colgroup>
									<thead>
										<tr>
											<th>No.</th>
											<th>년도</th>
											<th>종류</th>
											<th>사유</th>
											<th>기간</th>
											<th>사용 일수</th>
											<th>상태</th>
											<th>비고</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${vacationList}" var="item" varStatus="status">
											<tr>
												<td>${pageInfo.totalRecordCount - (pageInfo.recordCountPerPage * (pageInfo.currentPageNo-1)) - status.index}</td>
												<td>${item.year} 년</td>
												<td>${item.vacationKindValue}</td>
												<td>${item.vacationComment}</td>
												<td style="letter-spacing: 0px;">${item.vacationStartDate} ~ ${item.vacationEndDate}</td>
												<td>${item.vacationUseCnt} 일</td>
												<td>${item.vacationStateValue}</td>
												<td>
													<a href="#noloc" class="btn-vacation-mod" data-vacation-no="${item.vacationNo}">상세보기</a>
													<input type="hidden" id="vacationStartDate_${item.vacationNo}" value="${item.vacationStartDate}"/>
													<input type="hidden" id="vacationEndDate_${item.vacationNo}" value="${item.vacationEndDate}"/>
													<input type="hidden" id="vacationKind_${item.vacationNo}" value="${item.vacationKind}"/>
													<input type="hidden" id="vacationComment_${item.vacationNo}" value="${item.vacationComment}"/>
													<input type="hidden" id="vacationState_${item.vacationNo}" value="${item.vacationState}"/>
													<input type="hidden" id="vacationStateValue_${item.vacationNo}" value="${item.vacationStateValue}"/>
													<input type="hidden" id="vacationReturnComment_${item.vacationNo}" value="${item.returnComment}"/>
													
													<input type="hidden" id="vacationEncFile_${item.vacationNo}" value="${item.vacationEncFile}"/>
													<input type="hidden" id="vacationOrgFile_${item.vacationNo}" value="${item.vacationOrgFile}"/>
													
													<input type="hidden" id="currPageIdx" value="${pageInfo.currentPageNo}"/>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<div class="pagingWrap">
						    	<%--<div class="pageContent">--%>
						        	<c:import url="/page_navi">
						            	<c:param name="beginIdx" value="${pageInfo.firstPageNoOnPageList}"/>
						                <c:param name="endIdx" value="${pageInfo.lastPageNoOnPageList}"/>
						                <c:param name="currentIdx" value="${pageInfo.currentPageNo}"/>
						                <c:param name="totalPageCnt" value="${pageInfo.totalPageCount}"/>
									</c:import>
								<%--</div>--%>
						      	</div>	
							</div><!-- //tableStyle2 -->
							
						<script>
							$(document).ready(function(){
								_initBtn();
							});
							
							
							/* 페이지 이동 */
							function fnGoPage(pageIdx) {
								/*
						        var frm = document.getElementById("listFrm");
						        $("#pageIdx").val(pageIdx);
						        frm.submit();
						        */
						        
						        var param = {};
						        param.pageIdx 	= pageIdx;
						        param.srchYear 	= $("#srchYear option:selected").val();
					        	param.srchKind 	= $("#srchKind option:selected").val();
				        		param.srchState = $("#srchState option:selected").val();
						        	
				        		fnAction(param);				        
						    }
							
							/* 검색 */
							function fnSearch(){
						        var param = {};
						        param.pageIdx 	= $("#currPageIdx").val();
						        param.srchYear 	= $("#srchYear option:selected").val();
					        	param.srchKind 	= $("#srchKind option:selected").val();
				        		param.srchState = $("#srchState option:selected").val();
								
				        		fnAction(param);
							}
							
							/* 페이지 Reload Ajax (검색, 페이지이동) */
							function fnAction(param){
								var url = "/myVacationList";
								
							    $.ajax({
							        type: "POST",
							        url: url,
							        data: param,
							        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
							        timeout: 20000,
							        dataType: "HTML", 
							        success: function(data){
							        	$("#listCnt").html();
							        	$("#listCnt").html(data);
							        },
							        error: function(e){
							            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
							        }
							    });			
							}
							
							function _initBtn(){
						        $("#btn-vacation-list-ins").on("click", function () {
									fnVacationIns();
						        });
						        
						        $("#btn-search").on("click", function () {
						        	fnSearch();
						        });
						        
						        $(".btn-vacation-mod").on("click", function () {
						        	var no = $(this).attr("data-vacation-no");
						        	var startDate = $("#vacationStartDate_"+no).val();
						        	var endDate = $("#vacationEndDate_"+no).val();
						        	var comment = $("#vacationComment_"+no).val();
						        	var returnComment = $("#vacationReturnComment_"+no).val();
						        	var kind = $("#vacationKind_"+no).val();
						        	var state = $("#vacationState_"+no).val();
						        	var stateValue = $("#vacationStateValue_"+no).val();
						        	var orgFile = $("#vacationOrgFile_"+no).val();
						        	var encFile = $("#vacationEncFile_"+no).val();
						        	
						        	if (state != 0){
						        		var msg = "<font color='red'> ※신청 상태가 아니므로 수정이 불가합니다.</font>";
						        		stateValue += msg;
							        	$("#vacation_start_date").prop("disabled",true);
							        	$("#vacation_end_date").prop("disabled",true);
							        	$("#vacation_comment").prop("disabled",true);
							        	$("input:radio[name='vacation_kind']").prop("disabled",true);
							        	$(".btn_file_del").hide();
							        	
						        	}else{
							        	$("#vacation_start_date").prop("disabled",false);
							        	$("#vacation_end_date").prop("disabled",false);
							        	$("#vacation_comment").prop("disabled",false);
							        	$("input:radio[name='vacation_kind']").prop("disabled",false);
							        	$(".btn_file_del").show(); 
						        	}
						        	
						        	if (state == 91 || state == 92){
						        		$("#return_comment_tr").show();
						        		$("#return_comment").html(returnComment);
						        	}else{
						        		$("#return_comment_tr").hide();
						        	}

						        	
						        	//예비군(민방위) 파일 업로드 활성화
									if (kind == 30){
										$("#tr_vacation_file").show();
									}else{
										$("#tr_vacation_file").hide();
									}     
									
						        	//파일 존재 여부에 따라 upload, donwload 확인
						        	$("#file_name").html("");
						        	$("#file_up_span").hide();
									$("#file_down_span").hide();									
									if (orgFile != ""){
										$("#file_down_span").show();
										var href= "/vacationFileDown?vacationNo="+no;
										$("#file_name").closest("a").attr("href",href);
										$("#file_name").html(orgFile);
									}else{
										$("#file_up_span").show();
									}
									
						        	$("#vacation_state").show();
						        	$("#vacation_state td").html(stateValue);
						        	$("#vacation_start_date").val(startDate);
						        	$("#vacation_end_date").val(endDate);
						        	$("#vacation_comment").val(comment);
						        	$("input:radio[name='vacation_kind']:input[value="+kind+"]").prop('checked', true);
						        	$("#vacation_mod_no").val(no);
						        	$("#vacation_mod_state").val(state);
						        	
						        	fnVacationMod();
						        });
							}
							
						</script>
