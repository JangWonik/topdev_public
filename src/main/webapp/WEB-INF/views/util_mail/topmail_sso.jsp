<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<title>탑 메일 연결페이지</title>
<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
<link rel="stylesheet" type="text/css" href="./resources/wm_css/vertical.css" />
<script src="./resources/jquery/jquery.min_1_12.js"></script>
<script src="./resources/wm_js/common.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	$("#top_loading").show();
	
	//session_uid 값을 가져온다.
	getMailUid();
	
	//authKey 를 가져온다.
	getAuthKey();
	
	//메일 페이지로 이동한다.
	goMailSSO();
    
});//ready

function goMailSSO(){
	var url = "https://mail.toplac.co.kr/login_direct.php";
	
	var param = "";
	
	param = "?login_id="+$("#login_id").val();
	param +="&session_uid="+$("#session_uid").val();
	param +="&auth_key="+$("#auth_key").val();	
	url += param;	
	
	location.href=url;	
}

function goMailSSOFail(){
	
	alert('인트라넷에 등록된 이메일 주소 또는 이메일 비밀번호가 틀립니다. \n[My Menu] [정보수정] 메뉴를 확인해주세요.');
	
	var url = "https://mail.toplac.co.kr";
	location.href=url;
}

function getMailUid(){
	
	var url = "http://mail.toplac.co.kr/admin/xml_user_control.php";	
	
	var param = "";
	
	param = "?cmd=get_session_uid";
	param +="&userinfo[id]="+$("#userid").val();
	param +="&userinfo[mbox_host]="+$("#domain").val();	
	url += param;

	    $.ajax({
	        type: "POST",
	        url: url,	        
	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	        dataType: "html",	        
	        timeout: 20000,
	        async:false,
	        success: function(xml){
	        	
	            var result_code = $(xml).find('result_code').text();
	            var uid = $(xml).find('uid').text();
	            
	            if( result_code == 1 ){	            	
	            	$("#session_uid").val(uid);
	            }else{
	            	goMailSSOFail();
	            }
	        },
	        error: function(xhr, status, error){	        	
	        	goMailSSOFail();	            
	        },
	        beforeSend : function(xmlHttpRequest){
	            xmlHttpRequest.setRequestHeader("AJAX", "true");
	        }
	});
}

function getAuthKey(){
var url = "http://mail.toplac.co.kr/admin/xml_user_control.php";	
	
	var param = "";
	
	param = "?cmd=get_auth_key";
	param +="&userinfo[id]="+$("#userid").val();
	param +="&userinfo[mbox_host]="+$("#domain").val();
	param +="&userinfo[passwd]="+$("#email_pwd").val();
	param +="&session_uid="+$("#session_uid").val();
	url += param;
	
	//console.log("url="+url);

	    $.ajax({
	        type: "POST",
	        url: url,	        
	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	        dataType: "html",	        
	        timeout: 20000,
	        async:false,
	        success: function(xml){
	        	
	            var result_code = $(xml).find('result_code').text();
	            var auth_key = $(xml).find('auth_key').text();
	            
	            //console.log("xml="+xml);
	            
	            if( result_code == 1 ){	            	
	            	$("#auth_key").val(auth_key);
	            }else{
	            	goMailSSOFail();
	            }
	        },
	        error: function(xhr, status, error){	        	
	        	goMailSSOFail();	            
	        },
	        beforeSend : function(xmlHttpRequest){
	            xmlHttpRequest.setRequestHeader("AJAX", "true");
	        }
	});
}

</script>
</head>
<body>

<!-- //통합로딩바 -->
<div id="top_loading" style="display: none;">
	<img id="loading-image" src="/resources/cmm/images/spinner.gif" alt="Loading..." />
</div>

<!-- //통합로딩바끝 -->
<form id="emailSsoForm" action="http://mail.toplac.co.kr/login_direct.php" method="POST">
	<input type="hidden" id="login_id" value="${email}"/>
	<input type="hidden" id="session_uid" />
	<input type="hidden" id="auth_key" />
	<input type="hidden" id="userid" value="${userid}" />
	<input type="hidden" id="email" value="${email}" />
	<input type="hidden" id="domain" value="${domain}" />
	<input type="hidden" id="email_pwd" value="${email_pwd}" />	
</form>
</html>