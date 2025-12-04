<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>	
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<!-- modal용 css 시작 -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>	
	<style type="text/css">
		.buttonEduView{
			width:80px;
			height:23px;
		    background-color:#3232FF;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		    }
		.buttonEduStop{
			width:80px;
			height:23px;
		    background-color:#FF0099;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		    }		    
	 .buttonEduQuiz{
			width:80px;
			height:23px;
		    background-color:#FF8000;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		    }
	</style>		    
	<!-- modal용 css 끝 -->
	
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>
	<script src="./resources/jquery/jquery-ui.min.js"></script>	
</head>
<body oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
	<div class="tableStyle2">
	<table>
		<tr>
			<td colspan="6" style="text-align:left;padding-left:10px;">
			<img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">&nbsp;
			<b> ${mbrVo_Session.user_name} 님 안녕하세요.</b> 탑손해사정 주식회사 동영상 교육 페이지 입니다.</td>
		</tr>
	</table>
	<table>
		<tbody>		
			<tr>
				<th width="10%">교육명</th>
				<td width="30%">${eduInfo.subject}</td>
				<th width="10%">강사명</th>
				<td width="10%">${eduInfo.manager_name}</td>
				<th width="10%">등록일</th>
				<td width="10%">${eduInfo.reg_date_fmt}</td>
				<th width="10%">진행률</th>
				<td width="10%"><span id="progress_per">${progress_per}</span> %</td>
			</tr>
		</tbody>
	</table>
	<table>
		<tr>
			<td>
				<div id="player" style="position:relative;z-index:2;"></div>
				<!--  배속옵션 추가시 <div id="cover" style="position:absolute;top:64px;z-index:9999;background-color:#00FF0000;width:100%;height:100px;"> -->				
				<div id="cover1" style="position:absolute;top:64px;z-index:9999;background-color:#00FF0000;width:100%;height:730px;">
					모든 컨텐츠의 무단복제를 금지합니다. Copyright(c) 탑손해사정주식회사 All Rights Reserved.
				</div>
				<!-- 배속옵션 추가시 <div id="cover2" style="position:absolute;top:414px;z-index:9999;background-color:#00FF0000;width:1500px;height:380px;"> 
				</div>-->
			</td>
		</tr>
	</table>
	<table>
		<tr>
			<td>
				<input class="buttonEduView" onclick="javascript:doPlay();" type="button" value="시작하기">&nbsp;
				<input class="buttonEduStop" onclick="javascript:doStop();" type="button" value="일시정지">				
				<input class="buttonEduQuiz" onclick="javascript:doQuiz();" type="button" value="Quiz풀기">
			</td>
		</tr>
	</table>
	<table>
		<tr>
			<td>
				<c:choose>
					<c:when test="${quizCnt > 0 && eduProgress.end_flag eq 1}">
						<span id="quiz_info_text"><font style="color:blue;font-weight:bold;">&#8251; 교육시청 완료 후 ${quizCnt}개의 Quiz 를 완료해야 교육이 완료됩니다.</font></span>
					</c:when>
					<c:when test="${eduProgress.end_flag eq 2}">
						<font style='font-weight:bold;''>&#8251; 교육이 완료되었습니다.</font>
					</c:when>
				</c:choose>
			</td>
		</tr>
	</table>
	</div>
	<form id="eduProgressFrm" name="eduProgressFrm">
		<input type="hidden" id="ekey" name="ekey" value="${eduInfo.ekey}"/>
		<input type="hidden" id="lectureTime" name="lectureTime" value="${eduInfo.time_second}"/>
		<input type="hidden" id="viewSecond" name="viewSecond" value="${eduProgress.view_second}" />
		<input type="hidden" id="quizOrder" name="quizOrder" value="0"/>		
	</form>
    <script>    
    $(document).ready(function(){
    	//5초에 한번씩 진도체크를 실행한다.
    	setInterval(chkProgress,5000);
    	$(".buttonEduQuiz").hide();
    	
    	//Quiz 버튼 활성화 여부를 체크한다.
    	if( ${progress_per} == 100 &&  ${quizCnt} > 0 && ${eduProgress.end_flag} == 1){
    		$(".buttonEduQuiz").show();
			$(".buttonEduView").hide();
			$(".buttonEduStop").hide();			
    	}else{
    		$(".buttonEduQuiz").hide();
			$(".buttonEduView").show();
			$(".buttonEduStop").show();
    	}
	});
    
    function doPlay(){
    	player.playVideo();		//시작
    }
    
    function doStop(){
    	player.pauseVideo();		//정지    	
    }
    
    /* function doEnd(){
    	player.stopVideo();		//완료
    } */
    
	var tag = document.createElement('script');

    tag.src = "https://www.youtube.com/iframe_api";
    var firstScriptTag = document.getElementsByTagName('script')[0];
    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
      
    var player;
    function onYouTubeIframeAPIReady() {
			player = new YT.Player('player', {			
			height: '780',
			width: '1620',
			videoId: '${eduInfo.link_path}',
			playerVars:{ 'rel':0,'autoplay':0,'fs':0,'modestbranding':1,'start':$("#viewSecond").val() },
			events: {
				'onReady': onPlayerReady,					//페이지가 로딩되면 실행한다.
				'onStateChange': onPlayerStateChange		//플레이어 상태변화시 이벤트 실행 
			}
		});
	}

	function onPlayerReady(event) {
		//event.target.setPlaybackQuality('hd720');		
		//event.target.playVideo();
	}
    
	function onPlayerStateChange(event) {			//동영상 시작, 정지 등의 이벤트 발생시 실행되는 함수		
		//player.setPlaybackQuality('hd720');
		//alert("test : "+player.getPlaybackQuality());
	}
	
	//진도율 체크 프로세스
	function chkProgress(){		
		
		var progressState = player.getPlayerState();
		
		//시청중인경우 진행률을 갱신한다.
		if( progressState == 1 ){
			
			var param = {};
			param.ekey = $("#ekey").val();			
			param.view_second = $("#viewSecond").val();			//진행시간
			param.lecture_time = $("#lectureTime").val();			//기준교육시간
			
			var sUrl = "./updateLectureProgress";
			
			$.ajax({
	 			type : "post",
	 			url : sUrl,
	 			data : param, 			
	 			success : function(data){
	 				//갱신후 진행시간
	 				var sRet = data.result_second;
	 				var sPer = data.progress_per;
	 				var sQuiz = data.quiz_cnt;
	 				
	 				$("#viewSecond").val(sRet);
	 				$("#progress_per").text(sPer);
	 				
	 				//퀴즈 활성화
	 				if( sPer == 100 && sQuiz > 0 ){
	 					$(".buttonEduQuiz").show();
	 					$(".buttonEduView").hide();
	 					$(".buttonEduStop").hide();	 					
	 					player.stopVideo();
	 				}
	 				
	 			},
	 			error: function (request, status, error) {
	 				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
	 			}
	 		});
			
			
		}
	}
	
	//퀴즈 풀기
	function doQuiz(){
		
		var p_ekey = $("#ekey").val();
		var quiz_order = $("#quizOrder").val();
		
		var sUrl = "lecture_quiz_user_modal";
		
		var param = {};
		param.ekey = p_ekey;
		param.reg_ord = quiz_order;
		
		//동영상 차단 커버 감추기
		$("#cover1").hide();
		
		$.ajax({
			type: "POST",
			url: sUrl,
			data: param,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			timeout: 20000,
			dataType: "HTML", 
			success: function(data){
				$("#lecture-quiz-user-dialog").html();				
				$("#lecture-quiz-user-dialog").html(data);
					$("#lecture-quiz-user-dialog").dialog({
						height: 650,
						width: 800,
						closeOnEscape : true,
						draggable : true,
						title: "Quiz 풀기",
						buttons:{							
							"닫기" : function(){
								$("#cover1").show();
								$(this).dialog("close");
							}
						},
						modal: true,
						overlay:{ opacity: 0., background: '#000000'}
					});		
			},
			error: function(e){
			    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
			}
		});
		
		
	}
	
	function fnQuizNext(){
		alert('다음문제');
	}
	
	//정답 제출시 체크 
	function doQuizConfirm(){
		var exVal = $('input[name="ex"]:checked').val();
		var answerVal = $("#quiz_answer").val();
		var nextVal = $("#quiz_next").val();
		
		if( typeof exVal == "undefined" ){
			alert("정답을 선택해주세요.");
			$("#ex1").focus();
			return;
		}
		
		//오답을 선택한경우
		if( exVal !=  answerVal){			
			$("#quiz_comment").show();
		}else{
			
			if( nextVal > 0 ){
				//다음 문제 셋팅하고 모달창을 띄운다.
				$("#quizOrder").val(nextVal);				
				$("#lecture-quiz-user-dialog").dialog("close");
				doQuiz();
			}else{
				//다음문제가 없으므로 주제의 진행사항을 종료로 처리한다.
				
				//var sUrl = "lecture_quiz_action";
				var sUrl = "lecture_quiz_end";
				
				var param = {};
				
				param.ekey = $("#ekey").val();
				
				$.ajax({
					type: "POST",
		   	        url: sUrl,
		   	        data: param,
		   	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		   	        timeout: 20000,
		   	        async: false,
		   	        dataType: "html", 
		   	        success: function(data){
		   	        	if (data == 1){
							alert("교육이 완료되었습니다.");
							$("#lecture-quiz-user-dialog").dialog("close");
							$("#cover1").show();
							$(".buttonEduQuiz").hide();
							$(".buttonEduView").show();
							$(".buttonEduStop").show();
							$("#quiz_info_text").html("<font style='font-weight:bold;''>&#8251; 교육이 완료되었습니다.</font>");
		   	        	}
		   	        	
		   	        },
					error: function(e){
					    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
					}
				});
				
			}
			
		}
		
	}
    </script>
    <div id="lecture-quiz-user-dialog" title="Quiz 풀기" style="font-size: 15px;display:none;" align="center"></div>
  </body>
</html>