<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css?v=2" />
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	<script src="./resources/tooltipsy/tooltipsy.min.js"></script>
	
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>
	
	<script defer src="./resources/fontawesome_5.0/svg-with-js/js/fontawesome-all.js"></script>
	
	<script src="./resources/ckeditor/ckeditor.js"></script>	
	
</head>
<style>
	.ui-button-text-only {
		height:2.1em !important;
	}
</style>

<script type="text/javascript">
	$(document).ready(function(){
		
		$("#windowClose").click(function(){			
			$("#popup-code-dialog").dialog('close');
		});
		
		$("input:radio[name=repeat_chk]").click(function(){
			var chkVal = $("input:radio[name=repeat_chk]:checked").val();		
			
			if( chkVal == '2' ){		//매월로 체크한경우
				$("#repeat_flag").val("2");
				$("#month_val").show();
				$("#week_val").hide();
				$("#day_val").hide();
			}else if( chkVal == '1' ){
				$("#repeat_flag").val("1");
				$("#month_val").hide();
				$("#week_val").show();
				$("#day_val").hide();				
			}else{
				$("#repeat_flag").val("0");
				$("#month_val").hide();
				$("#week_val").hide();
				$("#day_val").show();				
			}
						
		});
		
		//반복여부값에 따라 보여주는 selectbox 변경		
		var vRepeat_flag = '${popupData.repeat_flag}';
		
		if( vRepeat_flag == '2' ){
			$("#repeat_flag").val("2");
			$("#month_flag").val('${popupData.month_flag}');
			
			$("#month_val").show();						
			$("#week_val").hide();
			$("#day_val").hide();
		}else if( vRepeat_flag == '1' ){
			$("#repeat_flag").val("1");
			$("#week_flag").val('${popupData.week_flag}');
			
			$("#month_val").hide();
			$("#week_val").show();
			$("#day_val").hide();
		}else{
			$("#repeat_flag").val("0");
			$("#month_val").hide();
			$("#week_val").hide();
			$("#day_val").show();
		}
		
	
		CKEDITOR.replace('contents',
							{
								filebrowserUploadUrl : './ckeditorUpload?tmpNo=${mbrVo_Session.user_no}',
								height : '450'
							});	
		});
		
	
	function modPopup( param ){
		
		$("#actionType").val('mod');		//actionType이 add 추가, mod 수정 del 삭제
		
		//입력 값 체크 시작		
		if( $("#subject").val() == '' ){
			alert('팝업명 을 입력 해 주세요.');
			$("#subject").focus();
			return;
		}
		
		if( $("#sdate").val() == '' ){
			alert("시작일자를 입력해주세요.");
			$("sdate").focus();
			return;
		}
		
		if( $("#edate").val() == '' ){
			alert("종료일자를 입력해주세요.");
			$("edate").focus();
			return;
		}
		
		//매주반복인경우 요일을 선택했는지 체크
		var chkVal = $("input:radio[name=repeat_chk]:checked").val();
				
		if( chkVal == '1' ){		//매주 반복을 선택한 경우			
			if( $("#week_flag").val() == '0' ){		//요일을 선택하지 않은 경우
				alert("반복여부를 매 주로 선택하였습니다. \n반복 할 요일을 선택해주세요.");
				return;
			}		
		}else if( chkVal == '2' ){			
			if( $("#month_flag").val() == '0' ){		//요일을 선택하지 않은 경우
				alert("반복여부를 매 월로 선택하였습니다. \n반복 할 날짜를 선택해주세요.");
				return;
			}			
		}else{				//매일 반복으로 선택된 경우 flag 값을 clear 하고 값을 넘겨준다.
			$("#week_flag").val('0');
			$("#month_flag").val('0');
		}
		
		//팝업크기 체크
		var p_height = $("#popup_height").val();
		var p_width = $("#popup_width").val();
		
		if( p_height == '' ){
			alert('팝업창의 높이를 입력해 주세요.');
			$("#popup_height").focus();
			return;
		}
		
		if( p_width == '' ){
			alert('팝업창의 너비를 입력해 주세요.');
			$("#popup_width").focus();
			return;
		}
		
		//본문 내용 확인
		var data = CKEDITOR.instances.contents.getData();
		
		if( data == '' ){
			alert('팝업의 내용을 입력해주세요.');			
			CKEDITOR.instances.contents.focus();
			return;
		}
		
		alert('팝업을 수정하였습니다.');
		
		$("#addForm").submit();		
	}
	
	function delPopup( param ){
		if( confirm('팝업을 삭제 하시겠습니까?\n삭제된 팝업은 복구할 수 없습니다.') ){
			$("#actionType").val('del');		//actionType이 add 추가, mod 수정 del 삭제
			
			alert('팝업을 삭제하였습니다.');
			
			$("#addForm").submit();
		}
	}
	
		
	function cancelPopup(){
		if( confirm('작성을 취소하고 목록을 돌아가시겠습니까?\n작성하던 내용은 사라집니다.') ){			
			location.href = "./divPopupManager";
		}
	}
	
	function previewPopup(){
		var p_height = $("#popup_height").val();
		var p_width = $("#popup_width").val();
		var preSubject = $("#subject").val();
		var preContent = CKEDITOR.instances.contents.getData();
		$("#previewContent").html(preContent);
		
		if( p_height  == "" || p_width == "" ){
			alert('팝업을 미리보려면 팝업크기를 입력해야합니다.');
			return;
		}
		
		if( preSubject == "" ){
			preSubject = "제목없음";
		}
		
		if( preContent == "" ){
			preContent = "내용없음";
		}
		
		$("#popup-code-dialog").dialog({
			height: p_height,
			width: p_width,
			closeOnEscape : true,
			draggable : true,					
			title: preSubject,
			buttons:{
				/* "오늘하루열지않음" : function(){
					$(this).dialog("close");
					alert('안열어!!');
				}, */
				
				/* "닫기" : function(){
					$(this).dialog("close");
				} */
			},
			modal: true,
			overlay:{ opacity: 0., background: '#000000'}
		});
	}
</script>

<body>
<!-- wrapper -->
<%-- oniku : ${popupData.popup_no} --%>
<%-- oniku : ${actionType} --%>
<div id="wrapper">
	<!-- skipnavi --><!-- header -->
	<c:import url="../top_main/top_sysadm_menu.jsp"></c:import>
	<!-- //skipnavi --><!-- //header -->

	<!-- contents -->
	<div id="container">
		<div class="contetns">
			<!-- centercnt_top -->
			<div class="center_cnt_1300">

				<!-- centercnt_bot -->
				<div class="center_cnt_1300_bot">
					<div class="guest">						
						<!-- 탭메뉴 시작 -->
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">DIV팝업관리(수정)</a></li>
							</ul>
						</div>
						<div class="guestcnt4" style="display:block;">
							<!-- 팝업입력폼 시작 -->
							<form name="addForm" id="addForm" method="post" action="divPopupAction">
							<input type="hidden" id="repeat_flag" name="repeat_flag" value="${popupData.repeat_flag}"/>
							<input type="hidden" id="actionType" name="actionType" />
							<input type="hidden" id="popup_no" name="popup_no" value="${popupData.popup_no}"/>
							<div class= "tableStyle2">
								<table>									
									<tr>
										<th width="10%">팝업명</th>
										<td width="30%" style="text-align:left;padding-left: 10px;">
											<input type="text" id="subject" name="subject" size="50%" value="${popupData.subject}">
										</td>
										<th width="10%">시작일자</th>
										<td>
											<input name="sdate" class="classCalendar" id="sdate" style="width: 70px;" type="text" value="${fn:substring(popupData.sdate,0,10)}">											
										</td>
										<th width="10%">종료일자</th>
										<td>
											<input name="edate" class="classCalendar" id="edate" style="width: 70px;" type="text" value="${fn:substring(popupData.edate,0,10)}">											
										</td>										
									</tr>
									<tr>
										<th width="10%">반복여부</th>
										<td style="text-align:left;padding-left: 10px;">											
											<input type="radio" name="repeat_chk" id="repeat_day" value="0" <c:if test="${popupData.repeat_flag eq 0 || empty popupData.repeat_flag}">checked</c:if>> &nbsp; 매일 &nbsp;
											<input type="radio" name="repeat_chk" id="repeat_week" value="1" <c:if test="${popupData.repeat_flag eq 1}">checked</c:if>> &nbsp; 매주 &nbsp;
											<input type="radio" name="repeat_chk" id="repeat_month" value="2" <c:if test="${popupData.repeat_flag eq 2}">checked</c:if>> &nbsp; 매월 &nbsp;
											<font color="blue">
											<span id="day_val" style="display:">팝업은 매일 표시됩니다.</span>
											<span id="week_val" style="display:none;">
												팝업은 매주 &nbsp;
												<select id="week_flag" name="week_flag">
													<option value="0">선택</option>
													<option value="1">일요일</option>
													<option value="2">월요일</option>
													<option value="3">화요일</option>
													<option value="4">수요일</option>
													<option value="5">목요일</option>
													<option value="6">금요일</option>
													<option value="7">토요일</option>
												</select>											
											 	&nbsp; 표시됩니다.
											 </span>
											<span id="month_val" style="display:none;">
												팝업은 매월 &nbsp;
												<select id="month_flag" name="month_flag">
													<option value="0">선택</option>
													<c:forEach var="cnt" begin="1" end="31" step="1">
														<option value="${cnt}">${cnt}</option>
													</c:forEach>												
												</select> 
												일 표시됩니다.
											</span>
											</font>
										</td>
										<th width="10%">사용여부</th>
										<td style="text-align:left;padding-left: 10px;">
											<input type="radio" name="is_use" value="0" <c:if test="${popupData.is_use eq 0 || empty popupData.repeat_flag}">checked</c:if>> &nbsp; 사용안함 &nbsp;
											<input type="radio" name="is_use" value="1" <c:if test="${popupData.is_use eq 1}">checked</c:if>> &nbsp; 로그인 전 &nbsp;
											<input type="radio" name="is_use" value="2" <c:if test="${popupData.is_use eq 2}">checked</c:if>> &nbsp; 로그인 후 &nbsp;
										</td>
										<th width="10%">팝업크기</th>
										<td style="text-align:left;padding-left: 10px;">
											H : <input type="text" id="popup_height" name="popup_height" size="10%" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" value="${popupData.popup_height}"> px, 
											W : <input type="text" id="popup_width" name="popup_width" size="10%" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" value="${popupData.popup_width}"> px
										</td>										
									</tr>
									<tr>
										<th width="5%" height="500">내 용</th>
										<td colspan="5">
											<textarea id="contents" name="contents">${popupData.contents}</textarea>											
										</td>
									</tr>
								</table>
							</div>
							</form>
							<!-- 팝업목록 끝 -->
							
						</div>
						<!-- 하단버튼시작 -->
							<div style="text-align:left;;float:left;">
								<input type="button" style="width:80px;" value="미리보기" id="popupPreview" onClick="javascript:previewPopup();"/>
							</div>						
							<div style="text-align:right;float:right;">								
								<input type="button" style="width:50px;" value="목록" id="popupCancel" onClick="javascript:cancelPopup();"/>								
								<input type="button" style="width:50px;" value="수정" id="popupMod" onClick="javascript:modPopup('${popupData.popup_no}');"/>
								<input type="button" style="width:50px;" value="삭제" id="popupDel" onClick="javascript:delPopup('${popupData.popup_no}');"/>								
							</div>
						<!-- 하단버튼끝 -->
						</div>
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

<!-- 미리보기 div 팝업 시작 -->
<div id="popup-code-dialog" title="미리보기" style="font-size: 12px;display:none;">
	<span id="previewContent"></span>
	<!-- <div id="todayEnd" style="float:left;position:absolute;left:5px;bottom:0px;">
	<input type="button" style="width:120px;height:25px;background-color: #e7e7e7; color: black;" value="오늘하루열지않기" id="todayClose" onClick="javascript:alert('하루동안 열리지 않습니다.');"/>
	</div>	
	<div id="close" style="float:right;position:absolute;right:5px;bottom:0px;">
	<input type="button" style="width:50px;height:25px;background-color: #e7e7e7; color: black;" value="닫기" id="windowClose"/>
	</div> -->	 
</div>
<!-- 미리보기 div 팝업 끝 -->
</body>
</html>
