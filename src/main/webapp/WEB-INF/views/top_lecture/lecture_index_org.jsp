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
<style>
	.buttonEduView{
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
			color:#FFFFFF  !important;
			width:60px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #3232FF;
		    }
		    
		.buttonEduDown{
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
			color:#FFFFFF  !important;
			width:60px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #FF0099;
		    }
		    
		/*보기 회색 버튼*/
		.btn-equipment-gray {
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
			color:#FFFFFF  !important;
			width:70px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #666666;
		}
		
		/*수정 버튼*/
		.btn-equipment-mod {
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
			color:#FFFFFF  !important;
			width:70px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #0033FF;
		}
</style>
<script>
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
	
	if( !confirm( "수강신청 하시겠습니까?") ){			
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
						<td width="450px;" height="400px;">
							<!-- 1번 섹션-->
							<table>
								<tr>
									<td>
										<!-- 시작 -->
										<div class="centercnt_top"><!-- centercnt_top -->
										<table>
											<tbody><tr>
												<td>
													<div class="nociteA nocite" style="height: 400px;width: 646px;">
													<div class="notice_top">
														<h3>주제별 수강 내역 현황</h3>
													</div>					
													<div class="notice_bot" style="margin: 5px 13px 10px;">
														<div class="tableStyle1">
															<table summary="주제별 수강 내역 현황">
																<caption>주제별 수강 내역 현황</caption>																
																<tbody>
																	<c:choose>
																		<c:when test="${myLectureList.size() eq 0}">
																			<tr>
																				<td colspan="2">																		
																					주제별 수강 내역 현황이 없습니다. 수강신청 후 사용하세요.																				
																				</td>																				
																			</tr>
																		</c:when>
																		<c:otherwise>
																			<c:forEach var="items" items="${myLectureList}" varStatus="status">																				
																					<c:choose>
																						<c:when test="${items.show_enable eq 1}">
																							<tr>
																								<!--제목-->
																								<td width="83%">
																									<span class="middot"></span>
																									<a class="txt">
																										<font color="green">[교육예정]</font>																												
																										 ${items.subject}
																									</a>
																								</td>
																								<!-- 진행률 -->
																								<td class="day" width="17%" align="right" onclick="javascript:doShowEduInfo('${items.show_sdate_fmt}','${items.show_edate_fmt}');" style="cursor:pointer;">																																				
																									- [시청하기]																						
																								</td>
																							</tr>
																						</c:when>
																						<c:when test="${items.show_enable eq 2}">
																							<tr>
																								<!--제목-->
																								<td width="83%">
																									<span class="middot"></span>
																									<a class="txt">
																										[교육종료] ${items.subject}
																									</a>
																								</td>
																								<!-- 진행률 -->
																								<td class="day" width="17%" align="right" onclick="javascript:doShowEduInfo('${items.show_sdate_fmt}','${items.show_edate_fmt}');" style="cursor:pointer;">																																				
																									- [시청하기]																						
																								</td>
																							</tr>
																						</c:when>
																						<c:otherwise>
																							<tr>
																								<!--제목-->
																								<td width="83%">
																									<span class="middot"></span>
																									<a class="txt">
																										<c:choose>
																											<c:when test="${items.end_flag eq 2}">
																												<font color="red">[교육완료]</font>
																											</c:when>
																											<c:otherwise>
																												<font color="blue">[교육진행]</font>
																											</c:otherwise>
																										</c:choose>
																										 ${items.subject}
																									</a>																				
																								</td>
																								<!-- 진행률 -->
																								<td class="day" width="17%" align="right" onclick="javascript:doShowEdu('${items.ekey}');" style="cursor:pointer;">																																				
																									${items.progress_per}% [시청하기]																						
																								</td>
																							</tr>												
																						</c:otherwise>
																					</c:choose>		
																			</c:forEach>
																		</c:otherwise>
																	</c:choose>																	
																</tbody>
															</table>
														</div>
													</div>	
													<a class="btn_more" href="./lectureUserApplyList"><img alt="나의강의" src="./resources/wm_img/common/btn_more.gif"></a>	
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
						<td width="450px;" height="400px;">
							<table>
								<tr>
									<td>
										<!-- 시작 -->
										<div class="centercnt_top"><!-- centercnt_top -->
											<table>
												<tbody><tr>
													<td>
														<div class="nociteA nocite" style="height: 400px;width: 646px;">
														<div class="notice_top">
															<h3>교육 과정 진도율</h3>
														</div>					
														<div class="notice_bot" style="margin: 5px 13px 10px;">
															<div class="tableStyle1">
																<table summary="교육 과정 진도율">
																	<caption>교육 과정 진도율</caption>																	
																	<tbody>
																	<c:choose>
																		<c:when test="${myLectureProcessList.size() eq 0}">
																			<tr>
																				<td colspan="2">																		
																					수강 내역이 없습니다. 수강신청 후 사용하세요.																				
																				</td>																				
																			</tr>
																		</c:when>
																		<c:otherwise>
																			<c:forEach var="items" items="${myLectureProcessList}" varStatus="status">
																				<tr>
																					<!--제목-->
																					<td width="81%">																		
																						<span class="middot"></span>
																							<a class="txt">
																								<c:choose>
																									<c:when test="${items.show_enable eq 1}">
																										<font color="green">[교육예정]</font>
																									</c:when>
																									<c:when test="${items.show_enable eq 2}">
																										[교육종료]
																									</c:when>
																									<c:otherwise>
																										<font color="blue">[교육진행]</font>
																									</c:otherwise>
																								</c:choose>																								
																								 ${items.p_title}
																							</a>																				
																					</td>
																					<!-- 진행률 -->
																					<td class="day" width="19%" align="right" onclick="javascript:doProcessView('${items.pkey}','${items.show_enable}');" style="cursor:pointer;">																																				
																						${items.progress_per}% [과정보기]																						
																					</td>
																				</tr>	
																			</c:forEach>
																		</c:otherwise>
																	</c:choose>																	
																</tbody>
																</table>
															</div>
														</div>	
														<a class="btn_more" href="./lectureUserApplyList"><img alt="더보기" src="./resources/wm_img/common/btn_more.gif"></a>	
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
					<tr>
						<td width="900px;" height="450px;" colspan="2">
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
														<div class="notice_top">
															<h3>과정 안내/신청</h3>
														</div>					
														<div class="notice_bot" style="margin: 5px 13px 10px;">
															<div class="tableStyle2">
																<table summary="과정 안내/신청">
																	<caption>과정 안내/신청</caption>																	
																	<tbody>
																		<tr>
																			<th width="50%">과정정보</th>
																			<th width="15%">과정기간</th>
																			<th width="15%">신청기간</th>
																			<th width="10%">주제</th>
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
																					<td width="60%" style="text-align:left;padding-left:10px;">																		
																						<span class="middot"></span>
																							<a class="txt" style="width:500px;">
																								<c:choose>																									
																									<c:when test="${items.ap_state eq 00 and items.apply_enable eq 1}">
																										<font color="blue">[수강신청]</font>
																									</c:when>
																									<c:when test="${items.ap_state eq 00 and items.apply_enable eq 0}">
																										<font color="orange">[기간만료]</font>
																									</c:when>
																									<c:when test="${items.ap_state eq 10}">
																										<font color="green">[결재대기]</font>
																									</c:when>
																									<c:when test="${items.ap_state eq 11}">
																										[결재완료]
																									</c:when>
																									<c:when test="${items.ap_state eq 1}">
																										<font color="red">[반 려]</font>
																									</c:when>
																								</c:choose>																								
																								 [${items.category_name}] ${items.p_title} 
																							</a>																				
																					</td>
																					<td width="15%">
																						${items.show_sdate_fmt} ~ ${items.show_edate_fmt}
																					</td>
																					<td width="15%">
																						${items.apply_sdate_fmt} ~ ${items.apply_edate_fmt}
																					</td>
																					<td width="10%">
																						${items.lecture_cnt} 개 
																						<img title="교육과정보기" style="cursor: pointer;" onclick="lectureRelationView('${items.pkey}')" src="./resources/ls_img/btns_view.gif">
																					</td>																					
																					<c:choose>																									
																						<c:when test="${items.ap_state eq 00 and items.apply_enable eq 1}">
																							<td width="10%">
																								<a class="btn-equipment-mod" id="btn-search" onclick="javascript:doUserApply('${items.pkey}','${items.p_title}');" href="#noloc">수강신청</a>																								
																							</td>		
																						</c:when>
																						<c:when test="${items.ap_state eq 00 and items.apply_enable eq 0}">
																							<td width="10%">																																																										
																								<a class="btn-equipment-gray" id="btn-search" onclick="javascript:alert('수강신청기간이 만료되었습니다.');" href="#noloc">기간만료</a>
																							</td>
																						</c:when>
																						<c:otherwise>
																							<td width="10%">																																																										
																								<a class="btn-equipment-gray" id="btn-search" onclick="javascript:doUserApplyView('${items.pkey}','${items.ap_state}');" href="#noloc">조회</a>
																							</td>
																						</c:otherwise>
																					</c:choose>																					
																				</tr>	
																			</c:forEach>
																		</c:otherwise>
																	</c:choose>
																	</tbody>
																</table>
															</div>
														</div>	
														<a class="btn_more" href="./lectureUserApplyList?tabView=2"><img alt="더보기" src="./resources/wm_img/common/btn_more.gif"></a>	
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
				</table>					
			</div>
		</div>
	</div>
	<!-- //contents -->
</div>
<!-- //wrapper -->
<!-- 교육시청하기 폼 -->
<form id="eduViewForm" name="eduViewForm">
	<input type="hidden" id="ekey" name="ekey"/>
</form>
<!-- 교육과정 입장 Modal -->
<div id="lecture-room-dialog" title="강의실 입장하기" style="font-size: 12px;" align="center"></div>
<!-- 수강신청 결재 상태 보기 -->
<div id="lecture-user-dialog" title="수강신청 상세보기" style="font-size: 12px;" align="center"></div>
</body>
</html>