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
	
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>
	<script src="./resources/jquery/jquery-ui.min.js"></script>	
</head>
<body oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
	<div class="tableStyle2">
	<c:if test="${openInfo.day_cnt < 2}">
		<div class="new-label" title="등록일 기준 2일 이내 신규강의입니다.">new</div>
	</c:if>
	<table>
		<tr>
			<td colspan="6" style="text-align:left;padding-left:50px;">
			<img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">&nbsp;
			<b> ${mbrVo_Session.user_name} 님 안녕하세요.</b> 탑손해사정 주식회사 <font color="blue">공개 강의실</font> 입니다.</td>
		</tr>
	</table>
	<table>
		<tbody>		
			<tr>
				<th width="10%">교육명</th>
				<td width="30%">${openInfo.subject}</td>
				<th width="10%">강사명</th>
				<td width="10%">${openInfo.manager_name}</td>
				<th width="10%">등록일</th>
				<td width="10%">${openInfo.reg_date_fmt}</td>
				<th width="10%">조회수</th>
				<td width="10%">${openInfo.view_cnt}</td>				
			</tr>
		</tbody>
	</table>
	<table>
		<tr>
			<td>
				<div id="player" style="position:relative;z-index:2;"></div>								
				<div id="cover1" style="position:absolute;top:64px;z-index:9999;background-color:#00FF0000;width:100%;height:730px;">
					모든 컨텐츠의 무단복제를 금지합니다. Copyright(c) 탑손해사정주식회사 All Rights Reserved.
				</div>				
			</td>
		</tr>
	</table>	
	</div>	
    <script>
    $(document).ready(function(){
    	
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
			height: '780',
			width: '1620',
			videoId: '${openInfo.link_path}',
			playerVars:{ 'rel':0,'autoplay':1,'fs':0,'modestbranding':1 },			
		});
	}
    </script>
  </body>
</html>