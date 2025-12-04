<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<%
//     response.setHeader("Content-Disposition", "attachment; filename=test.doc");
//     response.setHeader("Content-Description", "JSP Generated Data");
//     response.setContentType("application/vnd.ms-word");
%>
<meta http-equiv="X-UA-Compatible" content="IE=edge;text/html; charset=UTF-8">	
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/rpt_issue.css?v=20181204?v=2018"/>
	<script src="./resources/jquery/jquery.js"></script>		
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script type="text/javascript">
$(document).ready(function() {
	
	var sTempSel = '${tempSel}'; 
	
	if( sTempSel == 'email' ){
		$('.sSubject').html('메일 첨부파일 관리대장');
		$('.sContent').html('메일함(첨부파일)삭제 확인');		
	}else if( sTempSel == 'fax' ){
		$('.sSubject').html('웹 팩스 삭제 관리대장');
		$('.sContent').html('웹 팩스 삭제 확인');
	}else if( sTempSel == 'mobile' ){
		$('.sSubject').html('핸드폰 사진 삭제 관리대장');
		$('.sContent').html('핸드폰 사진 삭제 확인');
	}else if( sTempSel == 'scan' ){
		$('.sSubject').html('스캔파일 삭제 관리대장');
		$('.sContent').html('스캔파일 삭제 확인');
	}else{
		alert('잘못된 접근입니다.');
		return;
	}
	
	printPage();
});

function printPage(){
	var initBody;
	window.onbeforeprint = function(){
		initBody = document.body.innerHTML;
		document.body.innerHTML =  document.getElementById('print').innerHTML;
	};
	window.onafterprint = function(){
		document.body.innerHTML = initBody;
	};
	window.print();
	return false;
}
</script>
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
		
		.sSubject{font-size:25px;font-weight:bold;}
    </style>
</head>
<body>
<div id="print">
	<c:forEach items="${teamList}" var="item" varStatus="status">
	<div class="reportWrap" style="border: none; width:700px; height:700px;display: table-cell; vertical-align: top;" >
	    <div class="reportContent"> 
	        <div>
	        	<table>
					<tr>
						<td width="500" rowspan="2">
							<div id="sTitle" class="sSubject"></div>
						</td>
						<td width="70">담당자</td>
						<td width="70">팀장</td>
						<td width="70">관리자</td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
					</tr>
	        	</table>
	        	<div class="display-table" style="margin-top: 10px;">	        	
	        	<table>
		        	<colgroup>
						<col width="15%">
						<col width="17%">
						<col width="15%">
						<col width="18%">
						<col width="2%">
						<col width="15%">
						<col width="18%">
					</colgroup>				                
					<tbody>	
		        		<tr style="height:30px;">
		        			<th>작성일자</th>
		        			<td>${writeDate}</td>
		        			<th>담당자</th>
		        			<td>${writer}</td>
		        			<td style="border-top:0px;border-bottom:0px;">&nbsp;</td>
		        			<th>비고</th>
		        			<td>&nbsp;</td>
		        		</tr>
	        		</tbody>
	        	</table>
	        	<div class="display-table" style="margin-top: 10px;">	        	
		        	<table>
			        	<colgroup>
							<col width="10%">
							<col width="18%">
							<col width="14%">
							<col width="28%">
							<col width="20%">												
						</colgroup>                
						<tbody>
			        		<tr style="height:30px;">
				        			<th>확인일자</th>
				        			<th>팀명</th>
				        			<th>이름</th>
				        			<th>내용</th>			        			
				        			<th>확인</th>
				        		</tr>			        		
				        		<c:forEach items="${memberList}" var="member" varStatus="mstatus">			        			  			        			
					        		<c:if test="${item.team_id == member.team_id_main}">
						        		<tr style="height:35px;">
						        			<td></td>
						        			<td>${item.team_name}</td>
						        			<td>${member.user_name}</td>
						        			<td><div id="sCont" class="sContent"></div></td>
						        			<td></td>					        			
						        		</tr>
					        		</c:if>
				        		</c:forEach>
			        		</tbody>
			        	</table>
		        	</div>
		        </div>
			</div>
		</div>
	</div>
	<div style="page-break-before: always;">
		&nbsp;
	</div>
	</c:forEach>
</div>	
</body>
</html>
