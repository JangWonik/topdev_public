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
			<b> ${mbrVo_Session.user_name} 님 안녕하세요.</b> 탑손해사정 주식회사 <font color="blue">동영상 미리보기 서비스</font> 입니다. <font color="red">(2분간 시청이 가능합니다.)</font></td>
		</tr>
	</table>
	<table>
		<tbody>		
			<tr>
				<th width="10%">교육명</th>
				<td width="50%">${eduInfo.subject}</td>
				<th width="10%">강사명</th>
				<td width="10%">${eduInfo.manager_name}</td>
				<th width="10%">등록일</th>
				<td width="10%">${eduInfo.reg_date_fmt}</td>				
			</tr>
		</tbody>
	</table>
	<table>
		<tr>
			<td>
				<div id="player" style="position:relative;z-index:2;"></div>								
				<div id="cover1" style="position:absolute;top:64px;z-index:9999;background-color:#00FF0000;width:100%;height:728px;">
					모든 컨텐츠의 무단복제를 금지합니다. Copyright(c) 탑손해사정주식회사 All Rights Reserved.
				</div>				
			</td>
		</tr>
	</table>	
	</div>	
    <script>
    $(document).ready(function(){
    	//5초에 한번씩 진도체크를 실행한다.
    	//setInterval(chkProgress,5000);
	});
    
    function stopVideo() {
		player.stopVideo();
    }
    
	var tag = document.createElement('script');

    tag.src = "https://www.youtube.com/iframe_api";
    var firstScriptTag = document.getElementsByTagName('script')[0];
    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
      
    var player;
    function onYouTubeIframeAPIReady() {
			player = new YT.Player('player', {			
			height: '760',
			width: '1024',
			videoId: '${eduInfo.link_path}',
			playerVars:{ 'rel':0,'autoplay':1,'fs':0,'modestbranding':1,'start':0,'end':120},
			events: {
				'onReady': onPlayerReady,					//페이지가 로딩되면 실행한다.
				//'onStateChange': onPlayerStateChange		//플레이어 상태변화시 이벤트 실행 
			}
		});
	}

	function onPlayerReady(event) {
		alert("미리보기 강의로 2분간만 시청이 가능합니다.");
		player.playVideo();		//시작
	}
    
	/* function onPlayerStateChange(event) {			//동영상 시작, 정지 등의 이벤트 발생시 실행되는 함수		
		if (event.data == YT.PlayerState.PLAYING && !done) {
          setTimeout(stopVideo, 10);
          done = true;
        }
	} */
    </script>
  </body>
</html>