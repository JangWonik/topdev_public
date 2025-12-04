<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--@ include file="../util_nice/nice.nuguya.oivs.jsp" --%>
<%@ page import="kr.co.toplac.util.nice.OivsObject" %>
<%@ page import="java.util.Date" %>
<%

	//#######################################################################################
	//#####
	//#####	온라인본인확인 서비스 샘플 페이지 소스				
	//#####
	//#####	================================================================================
	//#####
	//#######################################################################################


	// popup창과 opener와의 권한 오류를 막기 위해 opener의 host명으로 return URL 세팅
	String reqUrl = new String(request.getRequestURL());
	String hostName = reqUrl.substring(0, (reqUrl.substring(10, reqUrl.length()).indexOf("/") < 0 ? reqUrl.length() : reqUrl.substring(10, reqUrl.length()).indexOf("/") + 10));


	//========================================================================================
	//=====	▣ 계약시에 발급 받은 데이터 설정 : 계약시에 발급된 회원사 ID 및 KeyString값을 설정하십시오. ▣
	//========================================================================================
	String NiceId = "Ntoplac1";			//회원사 아이디 ex: Nxxx~
	String KeyString = "NfiZBJy60TfS7ElDqywREU8NeVnAvFvI1MsLLHCHCwz2sNBafo7TRnMLh1YUZg2uWKEXLm7xOYRD7sE3"; //키스트링(80자리)를 넣어주세요.

	//========================================================================================
	//=====	▣ 서비스이용시 필요한 데이터 설정 ▣
	//========================================================================================
	// 응답결과를 받아서 처리할 URL을 설정해주세요.
	String ReturnURL = "https://www.toplac.co.kr/NiceCertPopup";
 	//String ReturnURL = "http://10.50.50.235:8080/NiceCertPopup";
	// 휴대폰인증 시 인증번호를 직접 지정하고 싶을 때 설정할 수 있습니다.
	// 특수한 경우에 사용되는 사항이니 설정하지 않고, 사용하시면 자동으로 전송됩니다.
	String ConfirmMsg = "";	// 전송할 인증번호 (6자리 숫자로 입력해주세요.)
	// #######################################################################################
	String ResidNo = request.getParameter("resid_no"); // 주민번호
	String MobileNo0 = request.getParameter("mobile_no0"); // 휴대폰번호0
	String MobileNo1 = request.getParameter("mobile_no1"); // 휴대폰번호1
	String MobileNo2 = request.getParameter("mobile_no2"); // 휴대폰번호2
	String MobileNo3 = request.getParameter("mobile_no3"); // 휴대폰번호3
	String MobileNo = MobileNo0 + "-" + MobileNo1 + "-" + MobileNo2 + "-" + MobileNo3;
	//========================================================================================


	OivsObject oivsObject = new OivsObject();
	oivsObject.athKeyStr = KeyString;
	oivsObject.niceId = NiceId;

	String strSendInfo = oivsObject.makeSendInfo(ResidNo, ReturnURL, MobileNo, ConfirmMsg); //인증요청시 필요한 암호화 데이터 수정금지
	String strOrderNo = "" ;		//주문번호.. 매 요청마다 중복되지 않도록 유의
	String strProcessType = "5";	//서비스코드 수정하지 마세요.
	
	//주문번호 생성예시
	Date d = new Date();
	strOrderNo =  (d.getYear()+1900) + ""
		+ ((d.getMonth() + 1) <10 ? "0" : "") + (d.getMonth() + 1) + ""
		+ (d.getDate() <10 ? "0" : "") + d.getDate() + ""
		+ Math.round(Math.random()*1000000000) + "";

	// 해킹방지를 위해 요청정보 세션에 저장
	session.setAttribute("niceRsdNo" , ResidNo);
	session.setAttribute("niceOrderNo" , strOrderNo);
	%>
	
<html>
<head>
	<title>나이스평가정보 본인확인 서비스</title>
	<link href="./resources/nice_img/style_pop.css" rel="stylesheet" type="text/css">
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
</head>
<body onload='javascript:resFrom.submit();'>
	
<!-- 	<input type="hidden" id="confrimBtn" onClick="javascript:jsf_chkValid(document.resFrom);"> -->

<form name="resFrom" method="post" action="https://secure.nuguya.com/nuguya/NiceCert.do" onsubmit="wait()">
	<input type="hidden" name="SendInfo" value="<%=strSendInfo%>">
	<input type="hidden" name="ProcessType" value="<%=strProcessType%>">
	<input type="hidden" name="OrderNo" value="<%=strOrderNo%>">
	<input type="hidden" name="CertMethod" value="CA"><!-- 공인인증서로 고정 -->
	<input type="hidden" name="user_no" value="${user_no}" />
</form>
