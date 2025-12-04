<%@ page language="java" contentType="text/html;charset=UTF-8" %>

<%@ page import="kr.co.toplac.util.nice.OivsObject" %>
<%

	//========================================================================================
	//=====	▣ 계약시에 발급 받은 데이터 설정 : 계약시에 발급된 KeyString값을 설정하십시오. ▣
	//========================================================================================

	String KeyString = "NfiZBJy60TfS7ElDqyrREU8NeVnAvFvI1MsLLHCHCwz2sNBafo7TRnMLh1YUZg2uWKEXLm7xOYRD7sE3"; //키스트링(80자리)를 넣어주세요.


	OivsObject oivsObject = new OivsObject();
	oivsObject.athKeyStr = KeyString;

	// 전달받은 데이터 복호화
	String strRecvData 	= request.getParameter( "SendInfo" );
	boolean blProc	= oivsObject.resolveDatas( strRecvData );
	
	// 해킹방지를 위해 세션에 저장된 값과 비교 .. 
	String ssResidNo = session.getAttribute("niceRsdNo") == null ? "" : (String) session.getAttribute("niceRsdNo");
	String ssOrderNo = session.getAttribute("niceOrderNo") == null ? "" : (String) session.getAttribute("niceOrderNo");
	if(! ssResidNo.equals(oivsObject.residNo)
		|| !ssOrderNo.equals(oivsObject.ordNo)){
			out.println("세션정보가 존재하지 않습니다.");
	}

	String certCheck = oivsObject.retCd;
// 	out.println("<BR>주문번호 : " + oivsObject.ordNo);
// 	out.println("<BR>본인인증 성공여부 : " + oivsObject.retCd + "(1:성공 / 0:실패)");
// 	out.println("<BR>인증코드 : " + oivsObject.resCd);
// 	out.println("<BR>응답 메시지 : " + oivsObject.message);
// 	out.println("<BR>회원사 ID : " + oivsObject.niceId);
// 	out.println("<BR>주민번호 : " + oivsObject.residNo);
// 	out.println("<BR>휴대폰번호 : " + oivsObject.phoneNo);
%>
<html>
	<head>
		<title>나이스평가정보 본인확인 서비스</title>
		<link href="./resources/nice_img/style_pop.css" rel="stylesheet" type="text/css">
		<script src="./resources/jquery/jquery.min.js"></script>
	</head>
	<script>
		$(document).ready(function(){
			if ( <%=certCheck %> == 0 ){ //공인인증 실패면
				window.opener.location.href="./failLogin";
				window.close();
			}else{
				window.opener.location.href="./succLogin";
				window.close();
			}
			
		});
		
// 		$(document).ready(function(){
<%-- 			if ( <%=certCheck %> == 0 ){ //공인인증 실패면 --%>
// 				window.opener.location.href="./failLogin";
// 				window.close();
// 			}else{
<%-- 				window.opener.location.href="./succLogin?juminNo="+<%=(String) session.getAttribute("niceRsdNo")%>  --%>
// 				window.close();
// 			}
			
// 		});
		
	</script>
	<body>
		
		<%=certCheck %>
	</body>
</html>



