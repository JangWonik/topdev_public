<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.*" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<%
//     response.setHeader("Content-Disposition", "attachment; filename=test.doc");
//     response.setHeader("Content-Description", "JSP Generated Data");
//     response.setContentType("application/vnd.ms-word");
%>
<html>
<head>
    <title>보고서 상세</title>
    <link rel="stylesheet" type="text/css" href="https://toplac.co.kr/resources/wm_css/meritz_report_word.css?v=20171214"/>
    <style>
    
		table {border-spacing:0; width: 100%; padding:0 !important; }
 		th{padding:0 !important; }
		td{padding:0 !important; text-align: center !important; vertical-align: middle;}

 		.td {border:1px solid #999999; padding:3px; line-height:120%;} 
 		.wordTd{word-break:break-all;}
		p {color:#000000; font-size:11pt; line-height:120%; margin-top:0; margin-bottom:0; font-family:굴림;}
		
 		.leftTd{ padding-left: 5px !important;  text-align:left !important; word-break:break-all;}
		.confirmTh{text-align: left !important; padding: 0px 5px !important;}
		.confirmTd{text-align: left !important; padding: 5px 5px !important;}
		
		.inquiryTh{width: 20% !important;}
		.inquiryTd{width: 80% !important; text-align:left !important; word-break:break-all; padding-left: 5px !important; }
		
		.lossTh{width: 10% !important;}
    </style>
</head>
<body>
<%
	String sStart = request.getParameter("startDate");
	String sEnd = request.getParameter("endDate");
	
	Calendar cal = Calendar.getInstance();
    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");    
    String sToday = df.format(cal.getTime());
	if( sStart.equals("") ){
		sStart = sToday;
	}
	
	if( sEnd.equals("") ){
		sEnd = sToday;
	}
	
	String sMonth = sStart.substring(5, 7);
	String eMonth = sEnd.substring(5, 7);
	String viewMonth = "";
	
	if(sMonth.equals(eMonth)){
		viewMonth = sMonth+"월";
	}else{
		viewMonth = sMonth+"월 ~ "+eMonth+"월";
	}
	
	viewMonth = viewMonth.replaceAll("0", "");
%>
<script type="text/javascript">
function goBack(){	
	history.back();
}
</script>
<c:set var="teamFlag" value="0"/>
<c:set var="userFlag" value="0"/>
<c:set var="accidentNo" value="" />
<c:if test="${fn:length(rptList) == 0}">검색결과가 없습니다.<a href="javascript:goBack();">[돌아가기]</a></c:if>
<div class="reportWrap" style="border: none; width:700px; height:900px;display: table-cell; vertical-align: top;" >
<c:forEach items="${rptList}" var="item" varStatus="status">	
	<c:if test="${status.first or teamFlag == 1}">				
		<div class="reportWrap" style="border: none; width:700px; height:1000px;display: table-cell; vertical-align: top;" >
		    <div class="reportContent"> 
		        <div>
		        	<table>
						<tr>
							<td width="500" rowspan="2">
								<p style="font-size:25px;font-weight:bold;">종결 파일 삭제 관리대장 ( <%=viewMonth %> )</p>
							</td>
							<td width="70">팀장</td>
							<td width="70">담당자</td>
						</tr>
						<tr>
							<td></td>
							<td></td>
						</tr>
		        	</table>
		        	<br/>
		        	<table>
		        		<tr>
		        			<th width="80">작성일자</th>
		        			<td width="133"><%=sEnd %></td>
		        			<th width="80">담당자</th>
		        			<td width="133">홍기헌</td>
		        			<th width="80">보험사</th>
		        			<td width="133">${item.ptnrNm}</td>
		        		</tr>
		        	</table>
		        	<br/>
		        	<table>
						<tr>
							<th width="90">확인일자</th>
							<th width="100">부서명</th>
							<th width="100">이름</th>
							<th width="300">사고번호(접수번호)</th>
							<th width="90">서명(본인)</th>
						</tr>
	</c:if>
	
	<c:set var="tmp" value="${accidentNo}" />
	<c:set var="accidentNo" value="${tmp}${rptList[status.index].accidentNo} ${rptList[status.index].suimAcceptNo}<br/>" />
	<c:choose>
		<c:when test="${rptList[status.index].userNo != rptList[status.index+1].userNo}">
			<c:set var="userFlag" value="1"/>
		</c:when>
		<c:otherwise>
			<c:set var="userFlag" value="0"/>
		</c:otherwise>
	</c:choose>	
	<c:if test="${userFlag == 1}">
		<tr>
			<td></td>
			<td>
			<c:choose>
				<c:when test="${item.centerNm eq item.teamNm}">
					${item.teamNm}
				</c:when>
				<c:otherwise>
					${item.centerNm}<br/>${item.teamNm}
				</c:otherwise>
			</c:choose>
			</td>
			<td>${item.userNm}</td>
			<td style="font-size: 15px !important;">${accidentNo}</td>
			<td></td>
		</tr>
		<c:set var="accidentNo" value="" />
	</c:if>	
	<c:choose>
		<c:when test="${rptList[status.index].teamId != rptList[status.index+1].teamId}">
			<c:set var="teamFlag" value="1"/>
		</c:when>
		<c:otherwise>
			<c:set var="teamFlag" value="0"/>
		</c:otherwise>
	</c:choose>	
	<c:if test="${teamFlag == 1}" >
		        	</table>
		       	</div>
			</div>
		</div>  
		
		<div style="page-break-before: always;">
			&nbsp;
		</div>     
	</c:if>
</c:forEach>
</div>
<br/>
<c:if test="${emailList.size() > 0 }">
<div class="reportWrap" style="border: none; width:700px; height:1000px;display: table-cell; " >
    <div class="reportContent"> 
        <div>
        	<table>
				<tr>
					<td colspan="4">	
						<p style="font-size:25px;font-weight:bold;">이메일 수신 대상자 목록</p>
					</td>
				</tr>				
				<tr>
					<td width="70">파일명</td>				
					<td width="70">센터 / 팀</td>
					<td width="70">수신자 이름</td>
					<td width="70">수신자 이메일</td>										
				</tr>
				<c:forEach items="${emailList}" var="item" varStatus="status">
				<tr>
					<td><%=viewMonth %>_종결파일삭제대장_${item.centerNm}_${item.teamNm}.pdf	</td>
					<td>${item.centerNm}_${item.teamNm}</td>
					<td>${item.toName}</td>
					<td>${item.toEmail}</td>					
				</tr>
				</c:forEach>
        	</table>
       	</div>
    </div>
</div>
</c:if>
</body>
</html>
