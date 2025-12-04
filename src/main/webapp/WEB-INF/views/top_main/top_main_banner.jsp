<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>
	<div class="banner">
		<ul>
			<!-- <li><a href="./helpDeskBoardList"><img src="./resources/ne_img/main/logo_helpdesk.jpg" title="전산지원요청" /></a></li> -->
			<li><a href="https://www.eais.go.kr" target="_blank"><img src="./resources/ne_img/main/eais.png" width="99px" height="20px" title="세움터" /></a></li>
			<li><a href="http://www.petroleum.or.kr/" target="_blank"><img src="./resources/ne_img/main/logo_kpa.jpg" title="대한석유협회" /></a></li>
			<!-- <li><a href="http://www.knoc.co.kr/" target="_blank"><img src="./resources/ne_img/main/logo_knoc2.png" title="한국석유공사" /></a></li> -->			
			<li><a href="http://www.opinet.co.kr/" target="_blank"><img src="./resources/ne_img/main/logo_opinet.png" title="오피넷" /></a></li>
			<li><a href="https://www.samsungebiz.com/welfare/familymall/" target="_blank"><img src="./resources/ne_img/main/logo_samsung.jpg" title="삼성전자 패밀리몰" width="100px" height="28px"/></a></li>
			<li><a href="http://mail.toplac.co.kr/" target="_blank"><img src="./resources/ne_img/main/logo_topmail.jpg" title="Topmail" /></a></li>
			<!-- <li><img src="./resources/ne_img/main/logo_topmail.jpg" title="Topmail" style="cursor:pointer;" onclick="javascript:goMail();"/></li> -->
			<li><a href="http://map.naver.com/index.nhn?menu=route" target="_blank"><img src="./resources/ne_img/main/logo_navermap.png" title="네이버 길찾기" /></a></li>
		</ul>
	</div>
</body>
<form id="emailForm" name="emailForm" method="post" action="topMailSSO" target="_blank">
</form>
<script>
function goMail(){
	$("#emailForm").submit();
}
</script>
</html>
