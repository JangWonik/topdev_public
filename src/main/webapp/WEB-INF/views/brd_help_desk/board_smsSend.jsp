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
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<script>
		$(document).ready(function(){
			//document.charset = "EUC-KR";
			var contents = $("#tmpContents").val();
			var encContents = contents.replace(/<br>/g,"\n").replace(/&nbsp;/g,"\u0020");
			$("#message").val(encContents);
			$("#smsForm").submit();			
// 			formSend(document.smsForm, 1);
			window.close();
		});//ready

		function formSend(fm,stype){    
			var oj1=fm.receiver.value;
			var stype;

			if(stype=="1"){
				fm.send_time.value="";
				Chk2 = confirm("발송 하시겠습니까?");

				if (Chk2==true) {
					fm.submit();
					return true;
				} else {
					return false;
				}
			} 
		}//formSend
		
		
	</script>
</head>

<body>

<!-- <form action=" http://munjamadang.co.kr/smsasp/smsasp.html " method="post" name="smsForm" id="smsForm"> -->
<form action="https://api.munjamoa.co.kr/message/toplac/sendMsg" method="post" name="smsForm" id="smsForm">
	<!-- 신규정보 추가 시작-->
	<input type="hidden" id="api_key" name="api_key" value="SYhfQxLgaANtMSfdH93staNmfM6ybDQcMsdXdFhkTQMIiYZ9Y8KNZRM2jlfBmLhKAWAumahJh1m0joPiOg04BPgIedOW4FnN7JfV">
	<input type="hidden" id="m_user_id" name="m_user_id" value="toplac">
	<!-- <input type="hidden" id="phone_no" name="phone_no" /> -->
	<input type="hidden" id="name_replace" name="name_replace" value="N"/>
	<input type="hidden" id="SEND_TYPE" name="SEND_TYPE" value="N"/>
	<input type="hidden" id="DATE" name="DATE" />
	<!-- 신규정보 추가 끝-->
	<input type="hidden" name="tmpContents" id="tmpContents" value="${smsContents}" />
	<input type="hidden" name="send_time" value="">
	<input type="hidden" name="return_url" value="https://www.toplac.co.kr/smsClose">
	<input type="hidden" name="end_alert" value="1">
	<input id="msgfocus" name="msgfocus" type="hidden" value="0"/>
	<input type="hidden" name="userid" value="toplac">
	<input type="hidden" name="passwd" value="toplac3000">
	<!-- 문자알림 목록 -->
	<input type="hidden" name="phone_no" value="01046035991,01053333009,01045644443,01050484182">
	<input type="hidden" name="callback_no" value="0260774600">
<!-- 	<input type="hidden" name="message" value="새로운 전산지원요청이 발생 했습니다."> -->
	<input type="hidden" name="message" id="message" value="">
	
</form>

</body>
</html>
