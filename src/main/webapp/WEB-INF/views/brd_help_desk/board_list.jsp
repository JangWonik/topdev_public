<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>	
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/wm_js/common.js"></script>	
	<script src="./resources/ne_js/calendar.js?v=20170321111520"></script><!-- calendar -->	
	<script src="./resources/select2/select2.min.js"></script>		
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
<script>
		$(document).ready(function(){
			if('${mbrVo_Session.user_no}' == null || '${mbrVo_Session.user_no}'.trim() == ''){
				window.location.assign("./logout");
			}			
			
			//문자 발송 부분
			/* if('${boardWriteSuccess}' == '1'){
				alert("게시글 저장에 성공 하였습니다.");
			    var smsContents = encodeURI(encodeURIComponent("${smsContents}"));
				window.open('./helpDeskBoardSMS?smsContents='+smsContents,'sms');
			} */

			if('${boardUpdateSuccess}' == '1'){
				alert("게시글 수정에 성공 하였습니다.");
			}
			
			
			
			if ('${currentTab}' == 'help'){
				$("#help").click();
			}else if ('${currentTab}' == 'intra'){
				$("#intra").click();
			}else if ('${currentTab}' == 'pc'){
				$("#pc").click();
			}else if ('${currentTab}' == 'tel'){
				$("#tel").click();
			}else if ('${currentTab}' == 'secu'){
				$("#secu").click();
			}else if ('${currentTab}' == 'etc'){
				$("#etc").click();
			}else if('${currentTab}' == 'mail'){
				$("#mail").click();
			}else if('${currentTab}' == 'auth'){
				$("#auth").click();
			}else if('${currentTab}' == 'equip'){
				$("#equip").click();
			}else if('${currentTab}' == ''){
				$("#help").click();
			}

		});//ready

		$(document).ready(function(){

			$.ajaxSetup({cache:false});

			$("#boardSrcBtn").click(function(){
				if($(":radio[name=boardSrcType]:checked").val() != '1'
					&& $(":radio[name=boardSrcType]:checked").val() != '2'
					&& $(":radio[name=boardSrcType]:checked").val() != '3'){
						alert("검색 대상을 입력해주세요.");
						return;
				}
				if($("#boardSrcWord").val().trim() == ''){
					alert("검색어를 입력해주세요.");
					$("#boardSrcWord").focus();
					return;
				}
				boardSrcForm.submit();
			});
			
			$("#btn_excel").click(function(){
				if(confirm("전산권한 내역을 엑셀로 다운로드 하시겠습니까?")){					
					excelDownForm.submit();	
				}
			});

		});//ready
		
		function equipAddModal(){
			
			//모달 초기화 시작
			$("#tmSearchAll option:eq(0)").prop('selected', true);
			$("#eq_user_name").val('');
			$("#apply_eq_name").val('');
			$("#eq_memo").val('');
			$("#reg_date").val('');
			
			//모달 초기화 끝
			
			$("#equip-action-dialog").dialog({
				height: 350,
				width: 650,
				closeOnEscape : true,
				draggable : true,
				appendTo : "#equipActionFrm",
				title: "장비 신청",
				buttons:{
					"장비 신청" : function(){
						fnEquipAction('I');		//신청						
					},
					"취소" : function(){
						$(this).dialog("close");
					}
				},
				modal: true,
				overlay:{ opacity: 0., background: '#000000'}
				
			});
			
			
			$("#tmSearchAll").select2({
				dropdownParent: $("#equip-action-dialog")	
			});
			
		}
		
		function fnEquipAction( p_flag ){
			
			if( p_flag == 'I' ){			//장비신청 저장
				
				//var sUrl = "equipment_action_all";
				var sUrl = "equip_apply_save";
				
				var applyUserNo = $("#apply_user_no").val();			//신청자 사번
				var applyTeamId = $("#apply_team_id").val();
				
				//글 본문에 들어갈 값 시작
				var teamNameVal = $("#tmSearchAll").val();				//장비 사용 팀이름				
				var eqUserNameVal = $("#eq_user_name").val();		//장비 사용 직원이름				
				var applyEqNameVal =$("#apply_eq_name").val();		//신청 장비명
				var eqMemoVal = $("#eq_memo").val();					//신청사유
				var regDateVal = $("#reg_date").val();
				//글 본문에 들어갈 값 끝
				
				//유효성 체크시작
				if( teamNameVal == "0" ){
					alert("사용자 부서를 선택 해 주세요.");
					$("#tmSearchAll").focus();
					return false;
				}
				
				if( eqUserNameVal == "" ){
					alert("사용자 이름을 입력 해 주세요.");
					$("#eq_user_name").focus();
					return false;
				}
				
				if( applyEqNameVal == "" ){
					alert("신청 장비명을 입력 해 주세요.");
					$("#apply_eq_name").focus();
					return false;
				}
				
				if( eqMemoVal == "" ){
					alert("신청 사유를 입력 해 주세요.");
					$("#eq_memo").focus();
					return false;
				}
				
				if( regDateVal == "" ){
					alert("사용 예정일을 입력 해 주세요.");
					$("#reg_date").focus();
					return false;
				}
				//유효성 체크 끝
				
				var param = {};
				
				param.team_id = applyTeamId;
				param.user_no = applyUserNo;
				param.body_team_name = teamNameVal;
				param.body_user_name = eqUserNameVal;
				param.body_eq_name = applyEqNameVal;
				param.body_eq_memo = eqMemoVal;
				param.body_reg_date = regDateVal;
				param.body_subject = "[전산장비 신청] "+teamNameVal+" "+eqUserNameVal;				
				
				$.ajax({
					type: "POST",
	       	        url: sUrl,
	       	        data: param,
	       	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	       	        timeout: 20000,
	       	        async: false,
	       	        dataType: "html", 
	       	        success: function(data){		       	        	
	       	        	if (data > 0){
	       	        		alert("장비신청이 완료되었습니다.");
							$("#equip-action-dialog").dialog("close");							
							location.href="./helpDeskBoardList";
	       	        	}else{
	       	        		alert("장비신청에 실패하였습니다.\nIT정보보호파트로 연락주십시오.");
	       	        		return;
	       	        	}
	       	        },
					error: function(e){
					    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
					}
				});
				
			}else{
				alert("잘못된 접근입니다.");
			}
		}

	</script>
	<style>
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
			color:#000000  !important;
			width:120px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #FFA500;
		}
		
		.btn-equip-aprv {
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
			width:120px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #013469;
		}
		
		.guest .guestTap>ul>li {width:120px;}
		.guest .guestTap>ul>li>a {
			width:120px;
		}
		
		/* 모달창 셀렉트 박스 */
		.select2-container--default{		
		    text-align : left;		
		    font-color:#444;		
		    font-size:12px;		
		}
	</style>
</head>

<body>

<!-- wrapper -->
<div id="wrapper">
	<!-- skipnavi --><!-- header -->
	<c:import url="../top_main/top_main_menu.jsp"></c:import>
	<!-- //skipnavi --><!-- //header -->
	
	<%-- 장비등록 폼 --%>
	<form id="equipActionFrm">				
		<div id="equip-action-dialog" title="장비신청" style="font-size: 15px;display:none;" align="center">
			<br/>
			<div class="tableStyle2" style="width: 600px;">
				<table class="vacation-ins-table">				
										
						<tr>
							<th width="20%" height="25px;">사용자 부서</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">							
								<select id="tmSearchAll" name="tmSearchAll" style="width:160px;text-align:left;">
									<option value="0" selected>미선택</option>
									<c:forEach items="${teamList}" var = "teamVo">
										<option value="${teamVo.teamName}">
											<c:if test="${teamVo.teamLevel == 1}">&nbsp;└</c:if>
											<c:if test="${teamVo.teamLevel == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
											${teamVo.teamName}
										</option>
									</c:forEach>
								</select>
							</td>
							<th width="20%" height="25px;">사용자 이름</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">							
								<input type="text" id="eq_user_name" name="eq_user_name" style="width:150px;" placeholder="공용PC는 공용PC로 입력"/>
							</td>							
						</tr>
						<tr>						
							<th width="20%" height="25px;">신청자 부서</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">
								${mbrVo_Session.team_name}
								<input type="hidden" id="apply_team_id" name="apply_team_id" value="${mbrVo_Session.team_id_main}"/>
							</td>
							<th width="20%" height="25px;">신청자 이름</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">
								${mbrVo_Session.user_name}
								<input type="hidden" id="apply_user_no" name="apply_user_no" value="${mbrVo_Session.user_no}"/>
							</td>											
						</tr>
						<tr>
							<th width="20%" height="25px;">신청 장비명</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;" colspan="3">
								<input type="text" id="apply_eq_name" name="apply_eq_name" style="width:450px;" placeholder="모니터2대, PC1대, 전화기1대 등 (구체적으로 작성)"/>
							</td>
						</tr>						
						<tr>
							<th width="20%" height="30">신청사유</th>
							<td style="text-align:left;padding-left:5px;" colspan="3">
								<textarea rows="5" cols="57" id="eq_memo" name="eq_memo" placeholder="신입사원입사, 장비고장으로 인한 교체요청 (구체적으로 작성)&#13;&#10;신청일로부터 3일 이내 사용해야하는 경우 사유작성 필요"></textarea>
							</td>
						</tr>
						<tr>
							<th width="20%" height="25px;">사용 예정일</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">
								<input type="text" class="classCalendar" id="reg_date" name="reg_date" style="width:100px;"/>
							</td>
							<td colspan="2">
								<font color="red">*</font> 장비 신청은 사용 예정일로 부터 3일 전 신청 바랍니다.
							</td>
						</tr>						
				</table>				
			</div>
		</div>
	</form>
	<!-- //통합로딩바 -->
	<div id="top_loading" style="display: none;">
		<img id="loading-image" src="/resources/cmm/images/spinner.gif" alt="Loading..." />
	</div>
	<!-- //통합로딩바끝 -->
	<%-- 장비등록폼 끝 --%>

	<!-- contents -->
	<div id="container">
		<div class="contetns">

			<!-- centercnt_top -->
			<div class="center_cnt_1300">

				<!-- centercnt_bot -->
				<div class="center_cnt_1300_bot">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li id="help" style="width:120px;"><a href="#" style="width:120px;">Help Desk</a></li>
								<li id="intra" style="width:120px;"><a href="#" style="width:120px;">인 트 라 넷</a></li>
								<li id="pc" style="width:120px;"><a href="#" style="width:120px;">P&nbsp;&nbsp;&nbsp;C</a></li>
								<li id="tel" style="width:120px;"><a href="#" style="width:120px;">전 화</a></li>
								<li id="secu" style="width:120px;"><a href="#" style="width:120px;">보 안</a></li>
 								<li id="mail" style="width:120px;"><a href="#" style="width:120px;">이 메 일</a></li>
								<li id="etc" style="width:120px;"><a href="#" style="width:120px;">기 타</a></li>
								<li id="auth" style="width:120px;"><a href="#" style="width:120px;">전 산 권 한</a></li>
								<li id="equip" style="width:120px;"><a href="#" style="width:120px;">장 비 신 청</a></li>
							</ul>
						</div>
						<div class="guestcnt4" style="display:block;">
							<table>
								<tr>									
									<td style="text-align:right;padding-bottom:5px;">
										<input type="button" class="btn-equip-aprv" value="전산장비 신청" style="cursor:pointer;" onclick="equipAddModal();"/>
										<a href="./helpDeskBoardWriteForm">
											<input type="button" class="btn-vacation-aprv" value="전산지원 요청" style="cursor:pointer;"/>
										</a>
									</td>
								</tr>
							</table>
							<div class="tableStyle2">
								<table>
									<thead>
										<tr>
											<th width="5%">번호</th>
											<th width="5%">상태</th>
											<th width="10%">구분</th>
											<th>제목</th>
											<th width="5%">첨부</th>
											<th width="10%">요청부서</th>
											<th width="10%">요청자</th>
											<th width="10%">요청일</th>
											<th width="10%">접수일</th>
											<th width="10%">완료일</th>
											<th width="5%">조회</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${boardList}" var="boardList">
											<tr>
													<!--번호-->
													<td>${boardList.board_no}</td>
													<!--상태-->
													<td>${boardList.solve_state_nm}</td>
													<!--구분-->
													<td>${boardList.accept_classify_nm}</td>
													<!--제목-->
													<td style="text-align:left;padding-left:7px;">
														<div style="width:230px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;cursor:pointer;">
															<a href="./helpDeskBoardDetail?boardNo=${boardList.board_no}&boardSrcType=${searchVO.boardSrcType}&boardSrcWord=${searchVO.boardSrcWord}&reqPgNo=${reqPgNoInt1}">
																${boardList.title}
															</a>														
														<c:if test="${boardList.memo_cnt > 0}"> [ ${boardList.memo_cnt} ] </c:if>
														</div>
													</td>
													<!--첨부-->
													<td>
														<c:if test="${boardList.file_cnt > 0}">
															<img alt="" src="./resources/ls_img/ls_board/icon_disket.gif">
														</c:if>
													</td>
													<!--요청부서-->
													<td><a href="./popEmpNmlstTmDtl?team_id=${boardList.team_id }" target="_blank">${boardList.team_name}</a></td>
													<!--요청자-->
													<td><a href="./PopEmpNmlstDtl?user_no=${boardList.user_no }" target="_blank">${boardList.user_nm}</a></td>
													<!--작성일-->
													<td>${boardList.reg_date_fmt}</td>
													<!--접수일-->
													<td>${boardList.accept_date_fmt}</td>
													<!--완료일-->
													<td>${boardList.solve_date_fmt}</td>
													<!--조회-->
													<td>${boardList.view_cnt}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							<table border="0" style="margin-top:7px;">
								<tr>
									<td width="50%">
										<form method="get" name="boardSrcForm" action="./helpDeskBoardList">
											<input type="radio" name="boardSrcType" value="1"
												<c:if test="${searchVO.boardSrcType == ''}">checked</c:if>
												<c:if test="${searchVO.boardSrcType == '1'}">checked</c:if> />제목&nbsp;
											<input type="radio" name="boardSrcType" value="2"
												<c:if test="${searchVO.boardSrcType == '2'}">checked</c:if> />제목+내용&nbsp;
											<input type="radio" name="boardSrcType" value="3"
												<c:if test="${searchVO.boardSrcType == '3'}">checked</c:if> />이름&nbsp;
											<input type="text" id="boardSrcWord" name="boardSrcWord" value="${searchVO.boardSrcWord}" size="30" onchange="changeSqlRemoveText(this);" />&nbsp;
											<img src="./resources/ls_img/ls_board/btn_src.gif" id="boardSrcBtn" name="boardSrcBtn" />&nbsp;
											<a href="./helpDeskBoardList"><img src="./resources/ls_img/ls_board/btn_src_cancel.gif" /></a>
											<input type="hidden" id="reqPgNo" name="reqPgNo" />
											<input type="hidden" id="currentTab" name="currentTab" />											
										</form>
										<form method="post" name="excelDownForm" action="./helpDeskBoardListExcel">
										</form>
									</td>
									<td align="center" colspan="2">
										<!-- page -->
										<c:import url="../brd_common/board_page_help.jsp"></c:import>
										<!-- //page -->
									</td>
									<!-- <td width="10%">
										<p style="text-align:right;">
											<a href="./helpDeskBoardWriteForm">
												<input type="button" class="btn-vacation-aprv" value="기술지원 요청" style="cursor:pointer;"/>
											</a>
										</p>
									</td> -->
								</tr>
							</table>
						</div><!-- //guestcnt4 -->

						<div class="guestcnt4" style="display:none;">
							<c:import url="../brd_help_desk/board_list_intra.jsp"></c:import>
						</div>
						<div class="guestcnt4" style="display:none;">
							<c:import url="../brd_help_desk/board_list_pc.jsp"></c:import>
						</div>
						<div class="guestcnt4" style="display:none;">
							<c:import url="../brd_help_desk/board_list_tel.jsp"></c:import>
						</div>
						<div class="guestcnt4" style="display:none;">
							<c:import url="../brd_help_desk/board_list_secu.jsp"></c:import>
						</div>						
						<div class="guestcnt4" style="display:none;">
							<c:import url="../brd_help_desk/board_list_mail.jsp"></c:import>
						</div>
						<div class="guestcnt4" style="display:none;">
							<c:import url="../brd_help_desk/board_list_etc.jsp"></c:import>
						</div>						
						<div class="guestcnt4" style="display:none;">														
							<c:import url="../brd_help_desk/board_list_auth.jsp"></c:import>
						</div>						
						<div class="guestcnt4" style="display:none;">														
							<c:import url="../brd_help_desk/board_list_equip.jsp"></c:import>
						</div>

					</div><!-- //guest -->					
				</div>
				<!-- //centercnt_bot -->
			</div>
			<!-- //center_cnt -->
		</div>		
	</div>
	<!-- //contents -->	
	<!-- footer -->
	<c:import url="../top_main/top_main_footer.jsp"></c:import>
	<!-- //footer -->
</div>
<!-- //wrapper -->

</body>
</html>
