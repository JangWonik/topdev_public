<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>

<html lang="en">
	<head>
		<meta charset="UTF-8">
		<title>인트라넷 공지 </title>
		<script src="./resources/jquery/jquery.js"></script>
        <script src="./resources/cmm/js/common.js"></script>
		<script>
			$(document).ready(function(){
				$("#checkTmpPop").click(function(){
                    fnSetCookie('evapop', '1', 1);
					window.close();
				});
			});
		</script>
	</head>
	<body>	
	<span style="color:#000093; font-size:18px;"> <b>탑인트라넷 로그인 방식 변경 안내</b></span><br /><br />
	 <b>일시:&ensp;</b>2018년 03월 12일(월요일) 오전  9:00<br /><br />
	 <b>내용:&ensp;</b><br />
	 <div>&ensp;- 기존방식</div>
	 	&ensp;1차: 주민등록번호<br />
	 	&ensp;2차: 범용공인인증서<br /><br />
	 <div>&ensp;- 변경방식</div>
	 	<b>&ensp;1차 : 아이디 + 비밀번호 </b><br />
	 	&ensp;2차: 범용공인인증서<br /><br />
	 
	<div>자세한 내용은 공지사항을 확인해 주시기 바랍니다.	
<a href="javascript:window.close();"><img src="./resources/sms/btn_close2.gif" border="0"></a></div><br />	
<!-- 			<img src="./resources/ne_img/appraisal.png" usemap="#imgmap2017103110958" border="0" />  -->
<!-- 		<img src="./resources/ne_img/repop1.jpg" />  -->
<!-- 		<img src="./resources/ne_img/repop2.jpg" /> -->
 		<form name="frameTmpPop"> 
			<input type="checkbox" id="checkTmpPop" name="checkTmpPop" /> <font size="2">오늘 하루 창 닫기</font>
		</form>
			<%--<c:set var="imgurl" value="" />--%>
			<%--<c:choose>--%>
				<%--<c:when test="${mbrVo_Session.user_no == '670'  --%>
								<%--|| mbrVo_Session.user_no == '670'}">   --%>
					<%--<c:set var="imgurl" value="http://naver.me/5cHYVS28" />		--%>
				<%--</c:when>--%>
				<%--<c:when test="${mbrVo_Session.user_no == '999'}">--%>
					<%--<c:set var="imgurl" value="http://naver.me/GQFVuM2x" />--%>
				<%--</c:when>--%>
				<%--<c:when test="${mbrVo_Session.user_no == '111'}">--%>
					<%--<c:set var="imgurl" value="http://naver.me/xsraCDNP" />--%>
				<%--</c:when>--%>
				<%--<c:when test="${mbrVo_Session.user_no == '222'}">--%>
					<%--<c:set var="imgurl" value="http://naver.me/GdxZItVL" />--%>
				<%--</c:when>--%>
				<%--<c:when test="${mbrVo_Session.user_no == '333'}">--%>
					<%--<c:set var="imgurl" value="http://naver.me/x8dojvUj" />--%>
				<%--</c:when>				--%>
			<%--</c:choose>	--%>

			<c:if test="${evUrlInfo != null and evUrlInfo.url != null}">
                <map id="imgmap2017103110958" name="imgmap2017103110958"><area shape="rect" alt="" title="" coords="226,474,358,492" href="${evUrlInfo.url}" target="_blank" /></map>
            </c:if>

	</body>
	
</html>
