<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<c:set var="suim_accept_no" value="${reportBscInfo.suimAcceptNo}"/>
<%
    String suim_accept_no = (String)pageContext.getAttribute("suim_accept_no");

	String fileName = "지급공제금_지급처";
	fileName = java.net.URLEncoder.encode(fileName,"UTF-8");
	
	response.setContentType("application/octer-stream");
	response.setHeader("Content-Transper-Encoding", "binary");

    response.setHeader("Content-Disposition", "attachment; filename="+suim_accept_no+ fileName + ".xls");
    response.setHeader("Content-Description", "JSP Generated Data");
    response.setContentType("application/vnd.ms-excel");
%>

<!DOCTYPE html>
<html>
<head>
    <title>3. 지급공제금 지급처</title>
    <style>
        /*기본태그 정의*/
        html, body{padding:0;margin:0;}

        /* 모바일 가로모드 폰트확대 방지 */
        body{-webkit-text-size-adjust:none;}

        /*body,table,input,textarea,select{font-size:12px;font-family:'돋움','Dotum', 'verdana';color:#666;}*/
        body,table {font-size:11pt;font-family:'굴림','굴림체','돋움','Nanum Gothic', 'verdana'; color:#000;}

        /* 마진과 패딩의 초기화 */
        body, div, p, th, td, textarea {margin:0;padding:0;}

        /* 테이블 스타일 초기화 */
        table {border-collapse:collapse;border-spacing:0; table-layout:fixed;width:800px;}
        table th td {border: 1px solid black;}
        tr {height: 42px;}
        th {background-color: #ECECEC; font-weight: bold; text-align: center; word-wrap:break-word}
        td {font-weight: normal; word-break: break-all; word-wrap:break-word;}
        td .title{font-weight: bold}


        #receive_table tr {height: 30px;}
        #receive_table td {font-weight: bold;}

        #approval_table td {text-align: center;}

        table tr td {padding: 0px 5px;}

        /* 이미지 및 필드셋에서 보더 표시 초기화 */
        img {border:0;}
        img {vertical-align:middle;}

        body {width:100%;}
        p {line-height:150%;}
        p .title{font-size:14pt; font-weight: bold; line-height:200%;}

        .l {text-align: left;}
        .r {text-align: right;}
        .c {text-align: center;}
    </style>
</head>
<%--3. 지급공제금 지급처--%>
<p style="">&nbsp;</p>
<p class="title" style="font-size: 15pt;font-weight:bold;">&nbsp;지급공제금 지급처</p>
  <table cellpadding="0" cellspacing="0" align="center" width="700" border="1">
	<tr style="font-size:13px;">
		<th width="120">지급처</th>
		<th width="100">대상자</th>
		<th width="100">은행명</th>
		<th width="150">계좌번호</th>
		<th width="150">지급액</th>
		<th width="80">비고</th>
	</tr>
	<c:forEach var="item" items="${reportOtherWorkerList}" varStatus="status" >
		<c:if test="${item.workerType == 1 || item.workerType == 4}">
			<tr>
				<td class="c"> ${item.paymentPlace}</td>
				<td class="c">	${item.workerName}</td>
				<td class="c"> ${item.bank}</td>
				<td class="c"> ${item.accountNumber}</td>
				<td style="text-align: right;"><fmt:formatNumber value="${item.paymentAmount}" pattern="###,###,###"/>원&nbsp;</td>
				<td class="c"> ${item.paymentRemarks}</td>
			</tr>
		</c:if>
	</c:forEach>
	<tr>
		<td style="text-align:center;">합계</td>
		<td>=5+5</td>
		<td></td>
		<td></td>
		<td style="text-align:right;"><fmt:formatNumber value="${paymentSum}" pattern="###,###,###"/>원&nbsp;</td>
		<td></td>
	</tr>       		
</table>
</html>








































