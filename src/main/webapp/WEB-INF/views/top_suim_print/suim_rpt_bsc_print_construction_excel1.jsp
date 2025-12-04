<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<c:set var="suim_accept_no" value="${reportBscInfo.suimAcceptNo}"/>
<%
    String suim_accept_no = (String)pageContext.getAttribute("suim_accept_no");
	String fileName = "청구공제금";
	fileName = java.net.URLEncoder.encode(fileName,"UTF-8");
	
	response.setContentType("application/octer-stream");
	response.setHeader("Content-Transper-Encoding", "binary");
	
    response.setHeader("Content-Disposition", "attachment; filename=" + suim_accept_no + fileName + ".xls");
    response.setHeader("Content-Description", "JSP Generated Data");
    response.setContentType("application/vnd.ms-excel");
%>

<!DOCTYPE html>
<html>
<head>
    <title>2. 청구공제금</title>
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
     <%--2. 청구공제금(추산)--%>
     <p style="">&nbsp;</p>
     <p class="title" style="font-size: 15pt;font-weight:bold;">&nbsp;청구공제금(추산)</p>
     <table cellpadding="0" cellspacing="0" align="center" width="800" border="1">
 		<tr style="font-size:13px;">
 			<th width="100">재해근로자</th>
 			<th width="100">구분</th>
 			<th width="100">생년월일</th>
 			<th width="100">현장명</th>
 			<th width="100">손해액</th>
 			<th width="60">단위</th>
 			<th width="120">적용환율 <br />(전신환매도율)</th>
 			<th width="120">청구공제금</th>
 		</tr>
 		<c:forEach var="item" items="${reportOtherWorkerList}" varStatus="status" >
 			 <c:choose>
  			<c:when test="${item.workerType == 1}">
  				<c:set var="fontStyle" value='' />
 				 </c:when>
  			<c:when test="${item.workerType == 2}"> 
  				<c:set var="fontStyle" value='style="color:red;font-weight: bold;"' />
 				</c:when>
  			<c:otherwise>
  				<c:set var="fontStyle" value='' />
 				</c:otherwise>
  		 </c:choose>
 			<tr style="font-size:15px;">
 				<td style="padding: 0px 5px;" class="c"><span ${fontStyle}> ${item.workerName}</span></td>
 				<td style="padding: 0px 5px;" class="c">
 					<span ${fontStyle}>
 						<c:choose>
  						<c:when test="${item.workerType == 1}">부책</c:when>
  						<c:when test="${item.workerType == 2}">면책</c:when>
  						<c:when test="${item.workerType == 3}">보완</c:when>
  						<c:when test="${item.workerType == 4}">일부보완</c:when>
  					</c:choose>
 					 </span>
 				</td>
 				<td style="padding: 0px 5px;" class="c"><span ${fontStyle}> ${item.ssn}</span></td>
 				<td style="padding: 0px 5px;" class="c"><span ${fontStyle}> ${item.country}</span></td>
 				<td style="padding: 0px 5px; text-align: right;"><span ${fontStyle}>
 				<fmt:formatNumber value="${item.damageAmount}" pattern="###,###,###.###"/></span></td>
 				<td style="padding: 0px 5px;" class="c"><span ${fontStyle}> ${item.countryUnit}</span></td>
 				<td style="padding: 0px 5px;text-align: right;"><span ${fontStyle}><fmt:formatNumber value="${item.exchangeRate}" pattern="###,###,###.##"/></span></td>
 				<td style="padding: 0px 5px;text-align: right;" style="mso-number-format:\#\,\#\#0\"><span >=E${status.index+5}*G${status.index+5}</span></td>
 			</tr>
 		</c:forEach>
 			<tr>
  			<td style="text-align:center;">합계</td>
  			<td></td>
  			<td></td>
  			<td></td>	        			
  			<td></td>	        			
  			<td></td>	        			
  			<td></td>	        			
  			<td style="text-align:right;"><fmt:formatNumber value="${deductionSum}" pattern="###,###,###"/>원&nbsp;</td>
     		</tr>
    	</table>
	<div>
	<p style="margin-top: 0px; padding: 0px 5px;">
	&nbsp;&nbsp;※상기 환율은 ${reportPrint30.exchangeRateDate}일자 외환은행 국가별 최초고시 환율을 적용함 &nbsp;&nbsp;&nbsp;(단위 : 원)
	</p>
</div>
<!-- <div class="display-cell text-right">&nbsp;&nbsp;(단위 : 원) </div> -->
</html>







































