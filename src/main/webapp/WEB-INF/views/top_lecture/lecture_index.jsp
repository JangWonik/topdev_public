<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE HTML>
<html lang="ko">

<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css">
	<!--<link rel="stylesheet" type="text/css" href="./resources/ne_css/style2.css">-->
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/><!-- calendar -->
	<script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
	<script src="./resources/ne_js/calendar.js"></script><!-- calendar -->
	<script src="./resources/wm_js/common.js"></script>
</head>
<script>
$(document).ready(function(){
	//진행중인 교육과정 목록을 불러온다.
	getProcessList('Ing');
	
	//진도율 동적체크
	$("#myProgress").val(${allProgressPer});
});

//교육전 후 알림 팝업
function doShowEduInfo( p_sdate, p_edate ){
	alert( "시청가능 기간은 ("+p_sdate+" ~ "+p_edate+") 입니다" );	
}

//동영상 플레이 팝업
function doShowEdu( p_ekey ){
	
	//교육키 설정
	$("#ekey").val(p_ekey);
	
	var viewForm = document.eduViewForm;
	
	var url = 'lectureClassView';
	window.open('', 'popEduView','width=1920,height=1080,scrollbars=no,resizable=no,status=yes,menubar=no,toolbar=no,top=50,left=50');		
	viewForm.action = url;
	viewForm.method = 'post';
	viewForm.target = 'popEduView';
	viewForm.submit();			
}

//미리보기 동영상 플래이 팝업
function doPrevewEdu( p_ekey ){
	
	//교육키 설정
	$("#ekey").val(p_ekey);
	
	var viewForm = document.eduViewForm;
	
	var url = 'lectureClassPreView';
	window.open('', 'popEduPreView','width=1024,height=768,scrollbars=no,resizable=no,status=yes,menubar=no,toolbar=no,top=50,left=50');		
	viewForm.action = url;
	viewForm.method = 'post';
	viewForm.target = 'popEduPreView';
	viewForm.submit();
}

function doProcessView( p_pkey, p_enable ){
	
	if( p_enable == 1 ){
		alert("교육예정입니다.");
		return;
	}else if( p_enable == 2 ){
		alert("종료된 교육입니다.");
		return;
	}else{
		var url = "./lectureShowUserModal";
		
		var param = {};
		param.pkey = p_pkey;
		param.view_type = 'info';			//정보보기
		
		$.ajax({
	        type: "POST",
	        url: url,
	        data: param,
	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	        timeout: 20000,
	        dataType: "HTML", 
	        success: function(data){
	        	$("#lecture-room-dialog").html();
	        	$("#lecture-room-dialog").html(data);
				$("#lecture-room-dialog").dialog({
					height: 600,
					width: 1024,
					closeOnEscape : true,
					draggable : true,
					title: "교육과정",
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
}

//수강신청 내역 보기
function doUserApplyView( p_pkey, ap_state ){		//결재상태 포함
	
	var url = "./lectureProcessUserModal";
			
	var param = {};
	param.pkey = p_pkey;
	param.ap_state = ap_state;		
	
	param.view_type = 'view';			//신청
	
	$.ajax({
        type: "POST",
        url: url,
        data: param,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        timeout: 20000,
        dataType: "HTML", 
        success: function(data){
        	$("#lecture-user-dialog").html();
        	$("#lecture-user-dialog").html(data);
			$("#lecture-user-dialog").dialog({
				height: 600,
				width: 900,
				closeOnEscape : true,
				draggable : true,
				title: "교육신청 및 조회하기",
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

function doUserApply( p_pkey, p_title ){
	
	var url = "./lectureProcessUserModal";
	
	var param = {};
	param.pkey = p_pkey;
	param.view_type = 'add';			//신청		
	
	$.ajax({
        type: "POST",
        url: url,
        data: param,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        timeout: 20000,
        dataType: "HTML", 
        success: function(data){
        	$("#lecture-user-dialog").html();
        	$("#lecture-user-dialog").html(data);
			$("#lecture-user-dialog").dialog({
				height: 600,
				width: 900,
				closeOnEscape : true,
				draggable : true,
				title: "교육신청",
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

//사용자 수강신청
function userApplyAction(){
	
	var infoMsg = "수강신청 하시겠습니까?";
	
	if( $("#actionType").val() == 'cancel' ){
		infoMsg = "수강신청을 취소하시겠습니까??";
	}
	
	if( !confirm( infoMsg ) ){			
		return;
	}

	var sUrl = "./lectureUserAction";			//수강신청하기
	
	var param = {};
	
	var action_type = $("#actionType").val();
	
	param.pkey = $("#applyPkey").val();
	param.user_comment = $("#user_comment").val();
	param.action_type = $("#actionType").val();		
	
	$.ajax({
			type : "post",
			url : sUrl,
			data : param, 			
			success : function(result){
				if( action_type == 'apply' ){
					alert("수강신청하였습니다.");	
				}else if( action_type = 'cancel' ){
					alert("수강신청을 취소하였습니다.");
				}
				
				$("#lecture-user-dialog").dialog("close");
				location.href = "TopLecture";
			},
			error: function (request, status, error) {			
				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
			}
		});
}

function lectureRelationView( p_pkey ){
	
	var url = "./lectureProcessUserModal";
	
	var param = {};
	param.pkey = p_pkey;
	param.view_type = 'info';			//정보보기
	
	$.ajax({
        type: "POST",
        url: url,
        data: param,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        timeout: 20000,
        dataType: "HTML", 
        success: function(data){
        	$("#lecture-user-dialog").html();
        	$("#lecture-user-dialog").html(data);
			$("#lecture-user-dialog").dialog({
				height: 600,
				width: 900,
				closeOnEscape : true,
				draggable : true,
				title: "교육과정 확인",
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

//교육과정 진도율 가져오기
function getProcessList(p_type){	
	
	var url = "./getProcessListFront";
	
	var param = {};
	param.ptype = p_type;			//All, Ing, Done, End 플래그	
	
	$.ajax({
        type: "POST",
        url: url,
        data: param,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        timeout: 20000,
        dataType: "HTML", 
        success: function(data){        	
        	$("#divProcessList").html(data);        	
        },
        error: function(e){
            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
        }
    });
}
</script>
<body>

<!-- wrapper -->
<div id="wrapper">

	<!-- header -->	
	<c:import url="../top_lecture/lecture_menu.jsp"></c:import>
	<!-- //header -->
	<!-- contents -->
	<div id="container">
		<div class="contetns">
		<!-- centercnt_top -->			
			<div class="center_cnt_vacation" >					
				<table>
					<tr>
						<td width="288px;" height="400px;">
							<!-- 1번 섹션-->
							<table>
								<tr>
									<td>
										<!-- 시작 -->
										<div class="centercnt_top"><!-- centercnt_top -->
										<table>
											<tbody>
											<tr>
												<td>
													<div class="nociteA nocite" style="height: 400px;width: 286px;">
													<div class="notice_top" style="height: 170px;width: 286px;">														
														<div class="notice" style="height: 35px;width: 286px;padding:10px 5px 0 5px;">
															<input class="buttonMenuLec" type="button" value="전체 교육과정 : ${allCnt} 개" onclick="javascript:getProcessList('All')">														
														</div>
														<div class="notice" style="height: 35px;width: 286px;padding:5px 5px 0 5px;">
															<input class="buttonMenuLec" type="button" value="진행중인 교육과정 : ${ingCnt} 개" onclick="javascript:getProcessList('Ing')">														
														</div>
														<div class="notice" style="height: 35px;width: 286px;padding:5px 5px 0 5px;">
															<input class="buttonMenuLec" type="button" value="완료된 교육과정 : ${doneCnt} 개" onclick="javascript:getProcessList('Done')">														
														</div>
														<div class="notice" style="height: 35px;width: 286px;padding:5px 5px 0 5px;">
															<input class="buttonMenuLec" type="button" value="종료된 교육과정 : ${endCnt} 개" onclick="javascript:getProcessList('End')">														
														</div>
														<div class="tableStyle99" style="padding:10px 5px 5px 5px;">
														<h3>나의 교육정보</h3>
															<table>
																<tr>
																	<th height="25">교육과정 진도율</th>
																	<th title="교육기간 내 포함된 교육과정에 대한 교육진도율 입니다."><font color="blue" size="3">${allProgressPer} %</font></th>																
																</tr>
																<tr>
																	<td style="padding-top:10px;" colspan="2">	
																		<progress value="0" max="100" id="myProgress" style="height:20px;width:100%;valign:middle;"></progress>
																	</td>
																</tr>
																<tr>
																	<th>총 교육받은 시간</th>
																	<td align="center">
																		<c:choose>
																			<c:when test="${MyDetailInfo.total_time > 0 }">
																				${MyDetailInfo.total_time_fmt}
																			</c:when>
																			<c:otherwise> 0 시간</c:otherwise>
																		</c:choose>
																	</td>
																</tr>
																<tr>
																	<th>시청중 / 전체</th>
																	<td align="center">${MyDetailInfo.info_ing_cnt} / ${MyDetailInfo.info_total_cnt}</td>
																</tr>
																<tr>
																	<th>시청완료 / 전체</th>
																	<td align="center">${MyDetailInfo.info_end_cnt} / ${MyDetailInfo.info_total_cnt}</td>
																</tr>
															</table>
														</div>
													</div>													
												</div>
												</td>
											</tr>						
										</tbody>
										</table>
									</div>
										<!-- 끝 -->
									</td>
								</tr>
							</table>	
						</td>
						<td width="990px;" height="400px;">
							<table>
								<tr>
									<td>
										<!-- 시작 -->
										<div class="centercnt_top"><!-- centercnt_top -->
											<table>
												<tbody><tr>
													<td>
														<div id="divProcessList"></div>														
													</td>
												</tr>						
											</tbody>
											</table>
										</div>
										<!-- 끝 -->
									</td>
								</tr>
							</table>
						</td>
					</tr>
					</table>
					<table>
						<tr>
							<td width="450px;" height="450px;">								
								<table>
									<tr>
										<td>
											<!-- 시작 -->
											<div class="centercnt_top"><!-- centercnt_top -->
												<table>
													<tbody>
													<tr>
														<td>
															<div class="nociteA nocite" style="height: 450px;width: 650px;">
															<div class="notice_top" title="현재 수강신청이 가능한 교육과정목록입니다.(최근등록된 목록 기준 상위10개이며, 결재완료된 교육과정은 제외)">
																<h3>교육과정 안내/신청</h3>
															</div>					
															<div class="notice_bot">
																<div class="tableStyle2">
																	<table summary="교육과정 안내/신청">
																		<caption>교육과정 안내/신청</caption>																	
																		<tbody>
																			<tr>
																				<th width="50%">교육과정 정보</th>																				
																				<th width="27%">교육신청 기간</th>
																				<th width="18%">주제</th>
																				<th width="18%">상태</th>
																			</tr>												
																			<c:choose>
																			<c:when test="${myLectureApplyList.size() eq 0}">
																				<tr>
																					<td colspan="5">																		
																						수강 신청이 가능한 교육과정이 없습니다.																				
																					</td>																				
																				</tr>
																			</c:when>
																			<c:otherwise>
																				<c:forEach var="items" items="${myLectureApplyList}" varStatus="status">
																					<tr>
																						<!--제목-->
																						<td width="50%" style="text-align:left;padding-left:10px;">
																							<div style="width:250px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">																		
																							<span class="middot"></span>
																								<a class="txt" style="width:500px;">																											
																									 [${items.category_name}] ${items.p_title}																									 
																								</a>
																							</div> 																				
																						</td>																						
																						<td width="27%">
																							${items.apply_sdate_fmt} ~ ${items.apply_edate_fmt}
																						</td>
																						<td width="18%">
																							${items.lecture_cnt} 개 &nbsp;&nbsp;
																							<img title="교육과정보기" style="cursor: pointer;" onclick="lectureRelationView('${items.pkey}')" src="./resources/ls_img/btns_view.gif">																							
																						</td>
																						<td>
																							<c:choose>																									
																								<c:when test="${items.ap_state eq 00 and items.apply_enable eq 1}">
																									<input class="buttonIngFlag" type="button" onclick="javascript:doUserApply('${items.pkey}','${items.p_title}');" value="수강신청">
																								</c:when>
																								<c:when test="${items.ap_state eq 00 and items.apply_enable eq 0}">
																									<font color="orange">[기간만료]</font>
																								</c:when>
																								<c:when test="${items.ap_state eq 10}">
																									<input class="buttonDoneFlag" type="button" onclick="javascript:doUserApplyView('${items.pkey}','${items.ap_state}');" value="결재대기">																								
																								</c:when>
																								<c:when test="${items.ap_state eq 11}">
																									[결재완료]
																								</c:when>
																								<c:when test="${items.ap_state eq 12}">
																									<input class="buttonRejectFlag" type="button" onclick="javascript:doUserApplyView('${items.pkey}','${items.ap_state}');" value="반려">
																								</c:when>
																							</c:choose>
																						</td>																			
																					</tr>	
																				</c:forEach>
																			</c:otherwise>
																		</c:choose>
																		</tbody>
																	</table>
																</div>
															</div>	
															<a class="btn_more" href="./lectureUserApplyList?tabView=2"><input type="button" class="buttonMini" value="더보기"/></a>	
														</div>
														</td>
													</tr>						
												</tbody>
												</table>
											</div>
											<!-- 끝 -->
										</td>
									</tr>
								</table>						
							</td>
							<!-- 공개강의실 시작 -->
							<td width="450px;" height="450px;">
								<table>
									<tr>
										<td>
											<!-- 시작 -->
											<div class="centercnt_top"><!-- centercnt_top -->
												<table>
													<tbody>
													<tr>
														<td>
															<div class="nociteA nocite" style="height: 450px;width: 650px;">
															<div class="notice_top" title="현재 공개된 강의목록입니다.(최근등록된 목록 기준 상위10개)">
																<h3>공개 강의실</h3>
															</div>					
															<div class="notice_bot">
																<div class="tableStyle2">
																	<table summary="공개교육목록">
																		<caption>공개 강의실</caption>																	
																		<tbody>
																			<tr>
																				<th width="16%">교육분류</th>																				
																				<th width="43%">강의명</th>
																				<th width="6%">자료</th>																																								
																				<th width="14%">강사명</th>
																				<th width="7%">조회수</th>
																				<th width="14%">-</th>
																			</tr>												
																			<c:choose>
																			<c:when test="${myLectureOpenList.size() eq 0}">
																				<tr>
																					<td colspan="6">																		
																						등록된 공개강의가 없습니다.																				
																					</td>																				
																				</tr>
																			</c:when>
																			<c:otherwise>
																				<c:forEach var="items" items="${myLectureOpenList}" varStatus="status">
																					<tr>
																						<td>${items.category_name}</td>
																						<!--제목-->
																						<td style="text-align:left;padding-left:10px;">
																							<div style="width:250px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;cursor:pointer;" onclick="javascript:doOpenLectureView(${items.okey});">
																								<a class="txt" style="width:500px;">																																																			
																									 ${items.subject}
																								<c:if test="${items.day_cnt < 2}">
																									<img src="./resources/wm_img/common/ico_new.png" alt="new" />
																								</c:if>
																								</a>																								
																							</div> 																				
																						</td>
																						<td>
																							<c:if test="${!empty items.file_org_name}">
																								<a href="oOpenFileDownload?okey=${items.okey}">
																									<img src="./resources/ls_img/icon_disket.gif" title="${items.file_org_name}">
																								</a>
																							</c:if>
																						</td>																																												
																						<td style="text-align:left;padding-left:10px;">
																							<div style="width:70px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
																							${items.manager_name}
																							</div>
																						</td>
																						<td>
																							<c:choose>
																								<c:when test="${mbrVo_Session.user_state eq 9 || mbrVo_Session.user_no == 966 || mbrVo_Session.user_no == 215  || mbrVo_Session.user_no == 1265}">
																									<a href="#" onclick="javascript:doOpenLectureLogView(${items.okey})">
																										<font color="blue">${items.view_cnt}</font>
																									</a>
																								</c:when>
																								<c:otherwise>${brd.view_cnt}</c:otherwise>
																							</c:choose>
																						</td>
																						<td>
																							<input class="buttonDoneFlag" type="button" onclick="javascript:doOpenClassView('${items.okey}');" value="강의시청">
																						</td>																			
																					</tr>	
																				</c:forEach>
																			</c:otherwise>
																		</c:choose>
																		</tbody>
																	</table>
																</div>
															</div>	
															<a class="btn_more" href="./lectureOpenList"><input type="button" class="buttonMini" value="더보기"/></a>	
														</div>
														</td>
													</tr>						
												</tbody>
												</table>
											</div>
											<!-- 끝 -->
										</td>
									</tr>
								</table>
							</td>
							<!-- 공개강의실 끝 -->
						</tr>
					</table>
					<%-- <tr>
						<td width="500px;" height="450px;">
							<table>
								<tr>
									<td>
										<!-- 시작 -->
										<div class="centercnt_top"><!-- centercnt_top -->
											<table>
												<tbody>
												<tr>
													<td>
														<div class="nociteA nocite" style="height: 450px;width: 1294px;">
														<div class="notice_top" title="현재 수강신청이 가능한 교육과정목록입니다.(최근등록된 목록 기준 상위10개이며, 결재완료된 교육과정은 제외)">
															<h3>교육과정 안내/신청</h3>
														</div>					
														<div class="notice_bot" style="margin: 5px 13px 10px;">
															<div class="tableStyle2">
																<table summary="교육과정 안내/신청">
																	<caption>교육과정 안내/신청</caption>																	
																	<tbody>
																		<tr>
																			<th width="55%">교육과정 정보</th>
																			<th width="15%">교육과정 기간</th>
																			<th width="15%">교육신청 기간</th>
																			<th width="15%">주제</th>
																			<th width="10%">상태</th>
																		</tr>												
																		<c:choose>
																		<c:when test="${myLectureApplyList.size() eq 0}">
																			<tr>
																				<td colspan="5">																		
																					수강 신청이 가능한 교육과정이 없습니다.																				
																				</td>																				
																			</tr>
																		</c:when>
																		<c:otherwise>
																			<c:forEach var="items" items="${myLectureApplyList}" varStatus="status">
																				<tr>
																					<!--제목-->
																					<td width="55%" style="text-align:left;padding-left:10px;">																		
																						<span class="middot"></span>
																							<a class="txt" style="width:500px;">																																							
																								 [${items.category_name}] ${items.p_title} 
																							</a>																				
																					</td>
																					<td width="15%">
																						${items.show_sdate_fmt} ~ ${items.show_edate_fmt}
																					</td>
																					<td width="15%">
																						${items.apply_sdate_fmt} ~ ${items.apply_edate_fmt}
																					</td>
																					<td width="15%">
																						${items.lecture_cnt} 개 &nbsp;&nbsp;
																						<img title="교육과정보기" style="cursor: pointer;" onclick="lectureRelationView('${items.pkey}')" src="./resources/ls_img/btns_view.gif">
																						<input class="buttonMiniView" type="button" onclick="lectureRelationView('${items.pkey}')" value="교육과정 확인">
																					</td>
																					<td>
																						<c:choose>																									
																							<c:when test="${items.ap_state eq 00 and items.apply_enable eq 1}">
																								<input class="buttonIngFlag" type="button" onclick="javascript:doUserApply('${items.pkey}','${items.p_title}');" value="수강신청">
																							</c:when>
																							<c:when test="${items.ap_state eq 00 and items.apply_enable eq 0}">
																								<font color="orange">[기간만료]</font>
																							</c:when>
																							<c:when test="${items.ap_state eq 10}">
																								<input class="buttonDoneFlag" type="button" onclick="javascript:doUserApplyView('${items.pkey}','${items.ap_state}');" value="결재대기">																								
																							</c:when>
																							<c:when test="${items.ap_state eq 11}">
																								[결재완료]
																							</c:when>
																							<c:when test="${items.ap_state eq 12}">
																								<input class="buttonRejectFlag" type="button" onclick="javascript:doUserApplyView('${items.pkey}','${items.ap_state}');" value="반려">
																							</c:when>
																						</c:choose>
																					</td>																			
																				</tr>	
																			</c:forEach>
																		</c:otherwise>
																	</c:choose>
																	</tbody>
																</table>
															</div>
														</div>	
														<a class="btn_more" href="./lectureUserApplyList?tabView=2"><img alt="더보기" src="./resources/wm_img/common/btn_more.gif" title="수강신청내역 더보기"></a>	
													</div>
													</td>
												</tr>						
											</tbody>
											</table>
										</div>
										<!-- 끝 -->
									</td>
								</tr>
							</table>
						</td>
					</tr> 					
				</table>--%>					
			</div>
		</div>
	</div>
	<!-- //contents -->
</div>
<!-- //wrapper -->
<!-- 교육과정 입장 Modal -->
<div id="lecture-room-dialog" title="강의실 입장하기" style="font-size: 12px;" align="center"></div>
<!-- 수강신청 결재 상태 보기 -->
<div id="lecture-user-dialog" title="수강신청 상세보기" style="font-size: 12px;" align="center"></div>
<!-- 공개강의실 강의정보 조회 -->
<div id="open-user-dialog" title="공개강의실 정보조회" style="font-size: 12px;" align="center"></div>
</body>
</html>