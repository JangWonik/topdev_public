<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="realURL" value="https://old.toplac.co.kr/salary/regular/authorization/${salaryInfo.salaryUrl}.do"/>
<c:set var="testURL" value="http://localhost:8080/salary/regular/authorization/${salaryInfo.salaryUrl}.do"/>

<html>
<head>
    <title>${title_Session}</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="format-detection" content="telephone=no" />
    <meta http-equiv="Cache-Control" content="no-cache"/>
    <meta http-equiv="Expires" content="0"/>
    <meta http-equiv="Pragma" content="no-cache"/>
</head>
<body>
<p align="center"> 연봉정보 화면을 호출 중입니다....</p>
<%-- <form id="salaryFrm" name="salaryFrm" method="post" action="${realURL}"> --%>
<form id="salaryFrm" name="salaryFrm" method="post" action="${testURL}">
    <input type="hidden" name="user_no"				value="${mbrVo_Session.user_no}"/>
    <input type="hidden" name="salary_auth"			value="${salaryInfo.salaryAuth}"/>
    <input type="hidden" name="salary_type"		    value="${salaryInfo.salaryType}"/>
</form>
<script>
    document.salaryFrm.submit();
</script>
</body>
</html>