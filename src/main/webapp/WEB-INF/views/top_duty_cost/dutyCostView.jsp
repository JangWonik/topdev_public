<%--
  Created by IntelliJ IDEA.
  User: hongkihun
  Date: 2017. 08. 11.
  Time:  오후 2:25
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>당직비 화면</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
		
	<%--<script src="./resources/daum/161109.js"></script>--%>
	<script src="./resources/daum/postcode.v2.js"></script>
	<script src='https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js'></script>
	


	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	
	<script src="./resources/ne_js/ne_number.js"></script>
	
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>	
		<style>
		.dutylist, th, td {
		 border: 1px solid black;
    	 border-collapse: collapse;
 	  	 padding: 5px;
   		 text-align: center;
   		 margin-top: 2%;
 	
		}			
		
		.head1{
			/*width:15%;*/
			/*text-align:left;*/
			padding: 4px 0 4px 5px;
			background-color:#EDEDED;
		}
		.ClassButton {
			font-weight:bold;
			text-decoration:none;
			font-family:Arial;
			box-shadow:inset #d1d1d1 0px 5px 4px -1px,#cccccc 0px 2px 4px;
			o-box-shadow:inset #d1d1d1 0px 5px 4px -1px,#cccccc 0px 2px 4px;
			-moz-box-shadow:inset #d1d1d1 0px 5px 4px -1px,#cccccc 0px 2px 4px;
			-webkit-box-shadow:inset #d1d1d1 0px 5px 4px -1px,#cccccc 0px 2px 4px;
			background:#ffffff;
			background:-o-linear-gradient(90deg, #ffffff, #adadad);
			background:-moz-linear-gradient( center top, #ffffff 5%, #adadad 100% );
			background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #ffffff), color-stop(1, #adadad) );
			filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff', endColorstr='#adadad');
			background:-webkit-linear-gradient(#ffffff, #adadad);
			background:-ms-linear-gradient(#ffffff, #adadad);
			background:linear-gradient(#ffffff, #adadad);
			text-indent:0px;
			line-height:20px;
			-moz-border-radius:3px;
			-webkit-border-radius:3px;
			border-radius:3px;
			text-align:center;
			vertical-align:middle;
			display:inline-block;
			font-size:11px;
			color:#303030;
			width:56px;
			height:18px;
			padding:0px;
			border-color:#b8b8b8;
			border-width:1px;
			border-style:solid;
		}
		
		.ClassButton:active {
			box-shadow:inset #d1d1d1 0px 5px 4px -1px,#cccccc 0px 0 4px;
			o-box-shadow:inset #d1d1d1 0px 5px 4px -1px,#cccccc 0px 0 4px;
			-moz-box-shadow:inset #d1d1d1 0px 5px 4px -1px,#cccccc 0px 0 4px;
			-webkit-box-shadow:inset #d1d1d1 0px 5px 4px -1px,#cccccc 0px 0 4px;
			position:relative;
			top:2px
		}
		
		.ClassButton:hover {
			background:#adadad;
			background:-o-linear-gradient(90deg, #adadad, #ffffff);
			background:-moz-linear-gradient( center top, #adadad 5%, #ffffff 100% );
			background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #adadad), color-stop(1, #ffffff) );
			filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#adadad', endColorstr='#ffffff');
			background:-webkit-linear-gradient(#adadad, #ffffff);
			background:-ms-linear-gradient(#adadad, #ffffff);
			background:linear-gradient(#adadad, #ffffff);
		}		
	</style>		
</head>
<body>
<div id="wrapper">
	<!-- skipnavi --><!-- header -->
	<c:import url="../top_main/top_main_menu.jsp"></c:import>
	<!-- //skipnavi --><!-- //header -->

	<!-- contents -->
	<div id="container">
		<div class="contetns">
			<form id=dutyCostList name="dutyCostList" method="get" action="/dutyCostList" onsubmit="return fnSearch();">
				<input type="hidden" id="yearMonth" name="yearMonth" value="${srchArg.yearMonth}">
              	<input type="hidden" id="pageIdx" name="pageIdx"/>
              	<input type="hidden" id="dutyId" name="dutyId"/>
              	<input type="hidden" id="dutyStatus" name="dutyStatus"/>
              	<input type="hidden" id="dutyCmd" name="cmd"/>
              	<input type="hidden" id="excelYN" name="excelYN"/>
              	<input type="hidden" id="retType" name="retType" value="<%=request.getParameter("retType") %>"/>	
              	<input type="hidden" id="status" value="${dutyVo.dutyStatus}"/>	
			</form>	
			<!-- centercnt_top -->
			<div class="center_cnt_1300">
				<div class="center_cnt_1300_bot">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on" style="width: 90%;"><a href="#">당직비 화면</a></li>
							</ul>			
						</div>
						<form id="dutyCostform" name="dutyCostform" method=post action="dutyCostInsert">		
							<div class= "tableStyle6">
								<table align="center" style = "margin-top:10px;" >
									<colgroup>
										<col width="15%">
										<col width="30%">
										<col width="15%">
										<col width="30%">
									</colgroup>
									<tbody>
						                <tr id = "reportType2Tr">
										
										<tr>
											<td class="head1">ㆍ고유번호</td>
											<td colspan="3" >
												${fn:substring(dutyVo.dutyId,0,7)}-${fn:substring(dutyVo.dutyId,7,9)}
											</td>
										</tr>
										<tr>
											<td class="head1">ㆍ당직일</td>
											<td colspan="3">
												${dutyVo.dutyDe}
											</td>
										</tr>				
										<tr>
											<td class="head1">ㆍ당직자</td>
											<td colspan="3" >
												${dutyVo.userName}
											</td>
										</tr>		
										<tr>					                
						                    <td class="head1">ㆍ보험사</td>
						                    <td colspan="3">
						                    	${dutyVo.ptnrNick}	
											</td>
										</tr>
										<tr>
						                    <td class="head1">ㆍ당직 구분</td>
						                    <td colspan="3">
												<c:choose>
													<c:when test="${dutyVo.dutyType == '1'}">전화당직(평일)</c:when>
													<c:when test="${dutyVo.dutyType == '2'}">전화당직(휴일)</c:when>
													<c:when test="${dutyVo.dutyType == '3'}">출동대기</c:when>
													<c:when test="${dutyVo.dutyType == '4'}">출동</c:when>
													<c:when test="${dutyVo.dutyType == '5'}">출동대기+ 출동</c:when>
												</c:choose>
											</td>
										</tr>										
										<tr>
											<td class="head1">ㆍ건수(콜접수/출동)</td>
											<td colspan="3" >
												${dutyVo.processCnt}건
											</td>
										</tr>
										<tr class="rptInsBodyNoneSpeed">
											<td class="head1">ㆍ출동내용(계약자명)</td>
											<td colspan="3">
												<%-- ${dutyVo.gutCn} --%>
												${fn:replace(dutyVo.gutCn , CRLF , '<br>')}
											</td>
										</tr>
										<tr>
											<td class="head1">ㆍ당직비용</td>
											<td colspan="3" >
												<fmt:formatNumber value="${dutyVo.dutyCost}" pattern="###,###,###"/>
											</td>
										</tr>
	                                    <tr>
	                                        <th>첨부파일</th>
	                                        <td colspan="3" style="text-align: left; padding-left: 5px;">
	                                            <c:forEach  var="item" items="${fileList}" varStatus="status">
	                                                <p id="p_file${status.index}">
	                                                    <a href="/duty_cost_file_down?file_no=${item.fileNo}">${item.orignlFileNm}</a>&nbsp;&nbsp;&nbsp;
	                                                </p>
	                                            </c:forEach>
	                                        </td>
	                                    </tr>																																									
									</tbody>
								</table>	
							</div>
						</form>	
						<div style ="text-align:center; margin-top:10px;">
							<c:if test="${mbrAuthVo_Session.mbr_pms_22 == '1' && dutyVo.dutyStatus == '10'}">
								<a href="#" class='ClassButton' onclick="fnAprvUpdate('${dutyVo.dutyId}','20', 'A');">결재하기</a>
							</c:if>
<!-- 							<a href="#" onclick="history.back();"><img src="./resources/ls_img/btnOk.png" style = "cursor:pointer; width: 100%; max-width: 65px;" /></a> -->
							<a href="#" class='ClassButton' onclick="history.back();">확인</a>
							<c:if test="${dutyVo.dutyStatus < 20}">
<%-- 								<a href="dutyCostRegister?dutyId=${dutyVo.dutyId}"><img src="./resources/ls_img/btnMod.png" style = "cursor:pointer; width: 100%; max-width: 65px;" /></a> --%>
								<a href="dutyCostRegister?dutyId=${dutyVo.dutyId}&tabFlag=<%=request.getParameter("tabFlag") %>" class='ClassButton'>수정</a>
							</c:if>
						</div>
					</div><!-- guest -->
				</div><!-- center_cnt_1300_bot -->
			</div><!-- center_cnt_1300 -->
		</div><!-- contetns -->
	</div><!-- container	 -->
	<!-- footer -->
	<c:import url="../top_main/top_main_footer.jsp"></c:import>
	<!-- //footer -->
</div><!-- //wrapper -->		
<script type="text/javascript">
	function fnAprvUpdate(id, status, cmd){
		var msg ="";
		if(cmd == 'A'){
			if(status == '20'){
				msg = "결재하시겠습니까?";
			}
		
		if(confirm(msg)){
	    	var frm = document.getElementById("dutyCostList");    	
	    	frm.method = "post";
	        frm.action = "./dutyCostStatusUpdate";
	        $("#dutyId").val(id);
	        $("#dutyStatus").val(status);
	        $("#dutyCmd").val(cmd);
	        
	        frm.submit();   		
			}
		}
	}
</script>		
</body>
</html>