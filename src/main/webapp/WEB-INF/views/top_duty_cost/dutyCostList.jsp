<%--
  Created by IntelliJ IDEA.
  User: hongkihun
  Date: 2017. 08. 04.
  Time: 오후 5:53
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css">
	<!--<link rel="stylesheet" type="text/css" href="./resources/ne_css/style2.css">-->
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/ne_js/ne_number.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/><!-- calendar -->		
	<script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
	<script src="./resources/ne_js/calendar.js"></script><!-- calendar -->
	<script src="./resources/wm_js/common.js"></script>
	<script type="text/javascript">
	
	$(document).ready(function(){
	    



	});//$(document).ready
	
	</script>
<style type="text/css">
	.dutylist, th, td {
		 border: 1px solid black;
    	 border-collapse: collapse;
 	  	 padding: 5px;
   		 text-align: center;
   		 margin-top: 2%;
 	
	}	
	
/* 	.tableStyle2 */
</style>
<style type="text/css">
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
<!-- wrapper -->
<div id="wrapper">

	<!-- header -->
	<c:import url="../top_main/top_main_menu.jsp"></c:import>
	<!-- //header -->

	<!-- contents -->
	<div id="container">
		<div class="contetns">
			<div class="center_cnt_1300">
			
				<div class="centercnt_top">
					<div class="nociteA log_top">
						<div class="search_bar" style="height:25px;">	
						
							<div style="float: left;">
								<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0">
								&nbsp;<b>당직비 신청 리스트</b>
							</div>												
							<div style="text-align: right;">
								<a id="btn_excel" href="#noloc">									
									<img src="./resources/ls_img/btn_excel.gif">
								</a>&nbsp;	
								<a id="yearprev" href="#noloc">			
									<img src="./resources/ne_img/icon_prev.gif" width="17" height="13" border="0">
								</a>
								<span id="yeartxt">${srchArg.yearMonth.substring(0,4)}</span>
								<a id="yearnext" href="#noloc">
									<img  src="./resources/ne_img/icon_next.gif" width="17" height="13" border="0">
								</a>	
								<c:forEach var="i" begin="1" end="12" step="1" varStatus="">
									<input id="${i}" class="monthbtn" type="button" value="${i}월" />
								</c:forEach>
							</div>
						    <form id=dutyCostList name="dutyCostList" method="get" action="/dutyCostList" onsubmit="return fnSearch();">
								<input type="hidden" id="yearMonth" name="yearMonth" value="${srchArg.yearMonth}">
	                            <input type="hidden" id="pageIdx" name="pageIdx"/>
	                            <input type="hidden" id="dutyId" name="dutyId"/>
	                            <input type="hidden" id="dutyStatus" name="dutyStatus"/>
	                            <input type="hidden" id="dutyCmd" name="cmd"/>
	                            <input type="hidden" id="excelYN" name="excelYN"/>
                            </form>															
																						
						</div>
					</div>
				</div>
				
				<div class="center_cnt_1300_bot">
					<div class="guest">
											                                                                 
						<div class="guestTap">
							<ul>								
								<li><a href="#noloc" onclick="location.href='./dutyList'">당직자 현황</a></li>
								<li class="on"><a href="#">당직비 신청 리스트</a></li>
								<c:if test="${mbrAuthVo_Session.mbr_pms_22 == 1}">
									<li><a href="#noloc" onclick="location.href='./dutyAppList'">당직비 신청 결재</a></li>
								</c:if>
								<c:if test="${mbrAuthVo_Session.mbr_pms_18 == 1}">
									<li><a href="#noloc" onclick="location.href='./dutyDepList?type=wait'">당직비 지급</a></li>	
									<li><a href="#noloc" onclick="location.href='./dutyDepList?type=complete'">당직비 입금완료</a></li>	
								</c:if>							
							</ul>							
						</div>
						
						<div id="div_duty" style="margin-top: 10px;">
							<div class="tableStyle2">
									<table>
										<colgroup>
												<col width="3%">
												<col width="7%">
												<col width="7%">
												<col width="9%">
												<col width="10%">
												<col width="10%">
												<col width="7%">
												<col width="10%">
												<col width="10%">
												<col width="9%">
												<col width="12%">		
										</colgroup>		
										<tr>
											<th>no</th>
											<th>접수번호</th>
											<th>당직날짜</th>
											<th>처리센터</th>
											<th>처리팀</th>
											<th>담당자</th>
											<th>보험사</th>
											<th>구  분</th>
											<th>당직금액</th>
											<th>건수(콜접수/출동)</th>
											<th>결재상태</th>
										</tr>
									<c:forEach var="item" items="${list}" varStatus="status">
										
										<tr>
										<%-- 	<td id="list">${status.count}</td> --%>
											<td>${pageInfo.totalRecordCount - (pageInfo.recordCountPerPage * (pageInfo.currentPageNo-1)) - status.index}</td>
											<td><a href="/dutyCostView?dutyId=${item.dutyId}&tabFlag=1">${fn:substring(item.dutyId,0,7)}-${fn:substring(item.dutyId,7,9)}</a></td>
											<td>${fn:substring(item.caDe,0,4)}-${fn:substring(item.caDe,4,6)}-${fn:substring(item.caDe,6,8)}</td>
											<td>${item.parentTeamName}</td>
											<td>${item.teamName}</td>
											<td>${item.userName}</td>
											<td>${item.ptnrNick}</td>
											<td>
												<c:choose>
													<c:when test="${item.dutyType == '1'}">전화당직(평일)</c:when>
													<c:when test="${item.dutyType == '2'}">전화당직(휴일)</c:when>
													<c:when test="${item.dutyType == '3'}">출동대기</c:when>
													<c:when test="${item.dutyType == '4'}">출동</c:when>
													<c:when test="${item.dutyType == '5'}">출동대기+ 출동</c:when>
												</c:choose>
											</td>
											<td><fmt:formatNumber value="${item.dutyCost}" pattern="###,###,###"/></td>
											<td>${item.processCnt}</td>											
											<td>
												<c:choose>
													<c:when test="${item.dutyStatus == '0'}">
														<c:if test="${mbrVo_Session.user_no == item.userNo}">
															<%-- <a href="#" onclick="fnAprvUpdate('${item.dutyId}','20', 'A');"><img alt="결재대기" src="/resources/ls_img/appwait.png" style = "width: 100%; max-width: 54px;"></a> --%>
															<a href="/dutyCostRegister?dutyId=${item.dutyId}" class='ClassButton'>신청하기</a>
														</c:if>
														<c:if test="${mbrAuthVo_Session.mbr_pms_22 == '1'}">
															<%-- <a href="#" onclick="fnAprvUpdate('${item.dutyId}','20', 'A');"><img alt="결재대기" src="/resources/ls_img/appwait.png" style = "width: 100%; max-width: 54px;"></a> --%>
																<a href='/dutyCostRegister?dutyId=${item.dutyId}' class='ClassButton'>미신청</a>
														</c:if>		
														<c:if test="${mbrAuthVo_Session.mbr_pms_23 == '1' && mbrAuthVo_Session.mbr_pms_22 != '1'}">
																<a href='#' class='ClassButton'>미신청</a>
														</c:if>																											
													</c:when>												
													<c:when test="${item.dutyStatus == '10'}">
														<c:if test="${mbrVo_Session.user_no == item.userNo || (mbrAuthVo_Session.mbr_pms_23 == '1' && mbrAuthVo_Session.mbr_pms_22 != '1')}">
															<%-- <a href="#" onclick="fnAprvUpdate('${item.dutyId}','20', 'A');"><img alt="결재대기" src="/resources/ls_img/appwait.png" style = "width: 100%; max-width: 54px;"></a> --%>
															<a href="#" class='ClassButton' style="cursor:default;">결재대기</a>
														</c:if>													
														<%-- <c:if test="${mbrAuthVo_Session.mbr_pms_22 == '1'}">
															<a href="#" onclick="fnAprvUpdate('${item.dutyId}','20', 'A');"><img alt="결재대기" src="/resources/ls_img/appwait.png" style = "width: 100%; max-width: 54px;"></a>
															<a href="#" class='ClassButton' onclick="fnAprvUpdate('${item.dutyId}','20', 'A');">결재대기</a>
														</c:if> --%>
														<c:if test="${mbrAuthVo_Session.mbr_pms_22 == '1' ||  mbrVo_Session.user_no == item.userNo}">
															<%-- <a href="#" onclick="fnAprvUpdate('${item.dutyId}','0', 'C');"><img alt="취소하기" src="/resources/ls_img/duty_cancle.png" style = "width: 100%; max-width: 54px;"></a> --%>	
													 		<a href="#" class='ClassButton' onclick="fnAprvUpdate('${item.dutyId}','0', 'C');">취소하기</a>
													 	</c:if>
													</c:when>
													<c:when test="${item.dutyStatus == '20'}">
														<c:if test="${mbrVo_Session.user_no == item.userNo || mbrAuthVo_Session.mbr_pms_18 != '1'}">
															<!-- <img alt="입금대기" src="/resources/ls_img/depwait1.png" style = "width: 100%; max-width: 54px;"> -->
															<a href='#' class='ClassButton' style="cursor:default;">입금대기</a>
														</c:if>
														<%-- <c:if test="${mbrAuthVo_Session.mbr_pms_18 == '1'}">
															<a href="#" onclick="fnAprvUpdate('${item.dutyId}','30','A');"><img alt="입금대기" src="/resources/ls_img/depwait.png" style = "width: 100%; max-width: 54px;"></a>
															<a href="#" class='ClassButton' onclick="fnAprvUpdate('${item.dutyId}','30','A');">입금대기</a>
														</c:if> --%>
														<c:if test="${mbrAuthVo_Session.mbr_pms_22 == '1'}">
															<%-- <a href="#" onclick="fnAprvUpdate('${item.dutyId}','10','C');"><img alt="취소하기" src="/resources/ls_img/duty_cancle.png" style = "width: 100%; max-width: 54px;"></a> --%>
															<a href="#" class='ClassButton' onclick="fnAprvUpdate('${item.dutyId}','10','C');">취소하기</a>
														</c:if>
													</c:when>
													<c:when test="${item.dutyStatus == '30'}">
														<!-- <img alt="입금완료" src="/resources/ls_img/depcomple.png" style = "width: 100%; max-width: 54px;"> -->
															<a href='#' class='ClassButton'  style="cursor:default;">입금완료</a>
														<c:if test="${mbrAuthVo_Session.mbr_pms_18 == '1'}">
															<%-- <a href="#" onclick="fnAprvUpdate('${item.dutyId}','20','C');"><img alt="취소하기" src="/resources/ls_img/duty_cancle.png" style = "cursor:pointer; width: 100%; max-width: 54px;"></a> --%>
															<a href="#" class='ClassButton' onclick="fnAprvUpdate('${item.dutyId}','20','C');">취소하기</a>
														</c:if>
													</c:when>													
												</c:choose>
											</td>									
										</tr>
									</c:forEach>	
								
									</table>
									<div class="pagingWrap">
                                    <%--<div class="pageContent">--%>
                                        <c:import url="/page_navi">
                                            <c:param name="beginIdx" value="${pageInfo.firstPageNoOnPageList}"/>
                                            <c:param name="endIdx" value="${pageInfo.lastPageNoOnPageList}"/>
                                            <c:param name="currentIdx" value="${pageInfo.currentPageNo}"/>
                                            <c:param name="totalPageCnt" value="${pageInfo.totalPageCount}"/>
                                        </c:import>
                                    <%--</div>--%>
                                </div>
							</div>
						</div>	
					</div><!-- //guest -->
				</div><!-- centercnt_bot2 -->
			</div><!-- //center_cnt -->
		</div><!-- //contents -->
	</div><!-- //container -->

	<!-- footer -->
	<c:import url="../top_statistics/statistics_footer.jsp"></c:import>
	<!-- //footer -->

</div><!-- //wrapper -->
<script type="text/javascript">
    $(document).ready(function () {
        _initButton();
    });
    //버튼 이벤트
	function _initButton(){
		$("#yearprev").click(function(){
	        var imsiyeartxt = $("#yeartxt").text();
	        imsiyeartxt--;
	        $("#yearMonth").val(imsiyeartxt + "12");  //201612
	        $("#excelYN").val("N");
	        dutyCostList.submit();
	    });
	    
	    $("#yearnext").click(function(){
	        var imsiyeartxt = $("#yeartxt").text();
	        imsiyeartxt++;
	        $("#yearMonth").val(imsiyeartxt + "01");  //201801
	        $("#excelYN").val("N");
	        dutyCostList.submit();
	    });


	    //월별 선택 버튼 클릭시 해당월에 해당하는 날짜 text 입력  imsimonth = 10 imsiMonthStart = 10
	    $(".monthbtn").click(function(){
	    	var imsimonth = $(this).attr("id");
	    	if(imsimonth.length < 2){
	    		imsimonth = "0" + imsimonth;
	    	}
	    		    	
        	$("#yearMonth").val($("#yeartxt").text() + imsimonth);  //2017-10
        	$("#excelYN").val("N");
        	dutyCostList.submit();
	    });//monthbtn.click
	    
		$("#btn_excel").on("click", function(){
			fnExcel();
		});	    
	    
	}
    
    function fnGoPage(pageIdx) {
        var frm = document.getElementById("dutyCostList");
        frm.method = "get";
        frm.action = "./dutyCostList";
        $("#pageIdx").val(pageIdx);
        $("#excelYN").val("N");
        frm.submit();
    }
    
    function fnAprvUpdate(id, status, cmd){
    	var msg ="";
    	if(cmd == 'A'){
    		if(status == '20'){
    			msg = "결재하시겠습니까?";
    		}else if(status == '30'){
    			msg = "입금 완료 하시겠습니까?";
    		}
    	}else if(cmd == 'C'){
    		msg = "취소하시겠습니까?";
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
    
    function fnExcel(){
        var frm = document.getElementById("dutyCostList");
        frm.method = "post";
        frm.action = "./dutyCostList";
        $("#pageIdx").val(1);
        $("#excelYN").val("Y");
        frm.submit();    	
    } 

</script>
<%
    //============================================================
    //  에러 메시지 처리
    //============================================================
    if(session.getAttribute("sERRORMSG") != null){
        out.println("<script type=\"text/javascript\">alert('"+session.getAttribute("sERRORMSG")+"');</script>");
        session.removeAttribute("sERRORMSG");
    }
%>	
</body>
</html>