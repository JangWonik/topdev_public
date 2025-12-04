<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" --%>
<%--     pageEncoding="UTF-8"%> --%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	<script>
	
	function popupReturnReason(serial_no,state){
		var currentIdx = ${pageInfo.currentPageNo}
		<c:choose>
			<c:when test="${srchArg.state == 0}">
				var url = "./popReturnReason?serial_no=" + serial_no + "&currentIdx=" + currentIdx +"&state=0";
			</c:when>
			<c:otherwise>
				var url = "./popReturnReason?serial_no=" + serial_no + "&currentIdx=" + currentIdx;
			</c:otherwise>
		</c:choose>		
		
		var winWidth = 1000;
		var winHeight = 400;
		var popupOption = "width=" + winWidth + ", height=" + winHeight;
		window.open(url,"",popupOption);
	}	
	
    function fnGoPage(pageIdx) {
        var frm = document.getElementById("srchFrm");
        frm.method = "get";
        frm.action = "./lectureRoomApproveList";
        $("#pageIdx").val(pageIdx);
        frm.submit();
    }
    
    function fnLectureRoomApprove(serial_no){
    	if(confirm("승인하시겠습니까?")){
			alert("승인되었습니다.");
	    	$("#serial_no").val(serial_no);
	    	$("#approve").submit();
    	}
    }
    
    function fnApproveCancel(serial_no){
    	if(confirm("취소하시겠습니까?")){
    		alert("취소되었습니다.");
    		$("#serialNo").val(serial_no);    		
    		$("#approveCancel").submit();
    	}
    }
    	
	/*	
	function fnReturnReason(){
    	$("#returnReason-modal").dialog({
    		height: 700,
    		width: 500,
    		closeOnEscape : true,
    		draggable : false,
    		buttons:{
    			"닫기" : function(){
    				$(this).dialog("close");
    			}
    		},
    		modal: true,
    		overlay:{ opacity: 0., background: '#000000'}
    	});
    */
	</script>
</head>
<!-- wrapper -->
<div id="wrapper">
	<!-- skipnavi --><!-- header -->
	<c:import url="../top_main/top_main_menu.jsp"></c:import>
	<!-- //skipnavi --><!-- //header -->
	<!-- contents -->
	<div id="container">
		<div class="contetns">
			
			<!-- centercnt_top -->
			<div class="center_cnt_1300">
				<!-- centercnt_bot -->
				<div class="center_cnt_1300_bot">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">강의실 사용 결재 내역</a></li>
								<li style="text-align:right;float:right;padding:0px 5px 0px 5px;width:50px;"><input type="button" value=" 반려 " class="button" onclick="window.location.href='/lectureRoomApproveList?state=2'"></li>
								<li style="text-align:right;float:right;padding:0px 5px 0px 5px;width:50px;"><input type="button" value=" 결재 " class="button" onclick="window.location.href='/lectureRoomApproveList?state=1'"></li>
								<li style="text-align:center;float:right;padding:0px 5px 0px 5px;width:50px;"><input type="button" value=" 미결재 " class="button" onclick="window.location.href='/lectureRoomApproveList?state=0'"></li>
								<li style="text-align:right;float:right;padding:0px 5px 0px 5px;width:50px;"><input type="button" value=" 전체 " class="button" onclick="window.location.href='/lectureRoomApproveList'"></li>
<!-- 								<input type="button" value=" 결재 " class="button" style="text-align:right;float:right;padding:0px 5px 0px 5px;width:50px;" onclick="window.location.href='/lectureRoomApproveList?state=1'"> -->
<!-- 								<input type="button" value=" 미결재 " class="button" style="text-align:right;float:right;padding:0px 5px 0px 5px;width:50px;" onclick="window.location.href='/lectureRoomApproveList?state=0'"> -->
<!-- 								<input type="button" value=" 전체 " class="button" style="text-align:right;float:right;padding:0px 5px 0px 5px;width:50px;" onclick="window.location.href='/lectureRoomApproveList'"> -->
							</ul>
						</div>
						<div style ="text-align:left; margin-top:5px;">
							<input type="hidden" id="viewFromDate" name="fromdate" value="${fromdate}"/>
							<input type="hidden" id="viewToDate" name="todate" value="${todate}"/>
						</div>
						<div class="guestcnt0" style="display:block;">
						 	<b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;"/> 강의실 사용 결재 내역 </b>
								<br>
								<div class= "tableStyle2">
									<table>
										<thead>
											<colgroup>
												<col width="3%">
												<col width="5%">
												<col width="5%">
												<col width="7%">
												<col width="5%">
												<col width="8%">
												<col width="12%">
												<col width="25%">
												<col width="5%">
												<col width="10%">
											</colgroup>
											<tr>
												<th>no</th>
												<th>신청자</th>
												<th>참여인원</th>
												<th>부서</th>
												<th>직급</th>
												<th>신청일</th>
												<th>사용기간</th>
												<th>내용</th>
												<th>상태</th>
												<th>비고</th>
											</tr>
											
											<c:forEach  var="item" items="${lectureRoomList}" varStatus="status" >
												<tr>
													<td>${count - ((pageInfo.currentPageNo-1) * 15) - status.index}</td>
													<td>${item.userName}</td>
													<td>${item.participationPersonnel}</td>
													<td>${item.teamName}</td>
													<td>${item.workLevelNm}</td>
													<td>${item.applicationDate}</td>
													<td>${item.lectureRoomDate} &nbsp;&nbsp;${item.startTime} ~ ${item.endTime}</td>
													<td>${item.content}</td>
													<td>
														<c:if test="${item.state == 0}">결재대기</c:if>
														<c:if test="${item.state == 1}">결재승인</c:if>
														<c:if test="${item.state == 2}">반려</c:if>
													</td>
													<td> 
														<c:choose>
															<c:when test="${item.state == 0}">
																<img src="./resources/ls_img/ls_report/btn_rch_2.gif" onclick="fnLectureRoomApprove('${item.serialNo}')" style="cursor:pointer;">
																<img class="returnReasonForm" src="./resources/ls_img/ls_report/btn_rch_return.gif" onclick="popupReturnReason('${item.serialNo}','${srchArg.state}');" style="cursor:pointer;">
															</c:when>
															<c:when test="${item.state == 1}">
																<img class="btnApproveCancel" src="./resources/ls_img/top_cost/btn_rch_1x.gif" onclick="fnApproveCancel('${item.serialNo}');" style="cursor:pointer;">
															</c:when>
															<c:otherwise>
																<input type="button" class="buttonCancel" value="취소하기" onclick="fnApproveCancel('${item.serialNo}');">
<%-- 																<img class="btnApproveCancel" src="./resources/ls_img/cancel.png" onclick="fnApproveCancel('${item.serialNo}');" style="cursor:pointer;width:69px;height:20px;"> --%>
															</c:otherwise>
														</c:choose>
													</td>	
												</tr>
											</c:forEach>	
										</tbody>
									</table>
									
									<form id="approve" action="./lectureRoomApproveOK">
										<input type="hidden" id="serial_no" name="serial_no" value="" />
										<input type="hidden" id="currentIdx" name="currentIdx" value="${pageInfo.currentPageNo}" />
                                        <input type="hidden"  name="fnState" value="${srchArg.state}"/>
									</form>
									
									<form id="approveCancel" action="./lectureRoomApproveCancel">
										<input type="hidden" id="serialNo" name="serial_no" value="" />
										<input type="hidden" name="currentIdx" value="${pageInfo.currentPageNo}" />
                                        <input type="hidden"  name="fnState" value="${srchArg.state}"/>
									</form>
									
									<form id="srchFrm" name="srchFrm" method="get" action="/lectureRoomApproveList" >
                                        <input type="hidden" id="pageIdx" name="pageIdx"/>
                                        	<c:if test="${srchArg.state != null}">
                                        		<input type="hidden" id="state" name="state" value="${srchArg.state}"/>
                                        	</c:if>
                                    </form>
	                                <div class="pagingWrap">
                                        <c:import url="/page_navi">
                                            <c:param name="beginIdx" value="${pageInfo.firstPageNoOnPageList}"/>
                                            <c:param name="endIdx" value="${pageInfo.lastPageNoOnPageList}"/>
                                            <c:param name="currentIdx" value="${pageInfo.currentPageNo}"/>
                                            <c:param name="totalPageCnt" value="${pageInfo.totalPageCount}"/>
                                        </c:import>
	                                </div>									
							</div><!-- //tableStyle2 -->
						</div>
					</div>
				</div>
				<!-- //centercnt_bot -->
			<!-- //center_cnt -->
		</div>
	</div>
	<!-- //contents -->
	<!-- footer -->
	<c:import url="../top_main/top_main_footer.jsp"></c:import>
	<!-- //footer -->
</div>
</div>
<!-- //wrapper -->
</body>
</html>
<style type="text/css">
.button{
	width:50px;
	height:23px;
    background-color: #D7F1FA;
    color:#4C4C4C;
	border-radius:5px;
    font-size: 13px;
    cursor: pointer;
    text-decoration:none;
    border: 1px solid #A6A6A6;
    float:right;
    }
    
.buttonCancel{
	width:66px;
	height:18px;
    background-color: #FFFFFF;
    color:#4C4C4C;
    text-align: center;
	border-radius:3px;
    font-size: 11px;
    cursor: pointer;
    text-decoration:none;
    border: 1px solid #A6A6A6;
}    
</style>





