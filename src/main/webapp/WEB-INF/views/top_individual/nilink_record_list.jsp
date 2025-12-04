<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/ne_js/ne_number.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/><!-- calendar -->
	<script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
	<script src="./resources/ne_js/calendar.js"></script><!-- calendar -->
	<script src="./resources/wm_js/common.js"></script>
</head>
<style>
	.tableStyle2 td{
		letter-spacing: 0px;
	}
	
	.buttonAssistanceDocu{
			width:70px;
			height:25px;
		    background-color:#9900CC;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		    }
	.buttonAssistance{
			width:120px;
			height:25px;
		    background-color:#2E7EE8;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		    }	    
</style>
<body>
<script>
	$(document).ready(function(){
		_initCalendar();		
	});
	
	function fnGoNilinkPage(pageIdx) {		
	    $("#pageIdxNilink").val(pageIdx);    
		$("#nilinkFrm").submit();				        
	}
	
	function doDownload(param){
		$("#downKey").val(param);
		$("#nilinkDownFrm").submit();
	}
	
	function doSearch(){
		$("#nilinkFrm").submit();
	}
	
	function _initCalendar(){    	 
  		$('.calendar').datepicker({
  			showOn: 'button',
  			buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
  			buttonImageOnly: true,
  			buttonText: "달력", 
  			changeMonth: true,
  			changeYear: true,	    	   
  			showButtonPanel: false,
  			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
  			dayNamesMin: ['일','월','화','수','목','금','토'],
  			dateFormat: 'yymmdd',
  			firstDay: 0,
  			isRTL: false,
  			showMonthAfterYear: true
  	    }); 		
  		
  	}
</script>

<!-- wrapper -->
<div id="wrapper">
	<!-- skipnavi --><!-- header -->
	<c:import url="../top_main/top_main_menu.jsp"></c:import>
	<!-- //skipnavi --><!-- //header -->

	<!-- contents -->
	<div id="container">
		<div class="contetns">

			<!-- left_cnt -->
			<c:import url="../top_main/top_main_left.jsp"></c:import>
			<!-- //left_cnt -->

			<!-- centercnt_top -->
			<div class="center_cnt">

				<!-- centercnt_bot -->
				<div class="centercnt_bot1-2">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">통화내역 조회</a></li>
							</ul>							
						</div> 
						<form id="nilinkFrm" action="nilinkRecordList" method="POST">
						<input type="hidden" id="pageIdxNilink" name="pageIdxNilink" />						
						<div class="guestcnt4" style="display:block; height:555px;">
							<div class= "tableStyle2">
							<div id="search-box"  align="center" style="padding-bottom:10px;">
								<table style="width: 100%;" align="center">
									<tr>
										<th width="10%">송신번호</th>
										<td width="15%">
											<input type="text" id="search_send_num" name="search_send_num" value="${paramMap.search_send_num}" placeholder=" - 는 입력하지 마세요."/>
										</td>
										<th width="10%">수신번호</th>
										<td width="15%">
											<input type="text" id="search_receive_num" name="search_receive_num" value="${paramMap.search_receive_num}" placeholder=" - 는 입력하지 마세요."/>
										</td>
										<th width="10%">조회기간</th>
										<td width="20%">
											<input type="text" class="calendar" id="search_sdate" name="search_sdate" size="10" value="${paramMap.search_sdate}" maxlength="8" /> ~ 
											<input type="text" class="calendar" id="search_edate" name="search_edate" size="10" value="${paramMap.search_edate}" maxlength="8" />
										</td>
										<td width="10%">											
											<input title="검색" class="buttonAssistanceDocu" type="button" value="검색" id="searchBtn" onclick="javascript:doSearch();">
										</td>
									</tr>
								</table>
							</div>
								<table>
									<thead>
										<tr>
											<th width="10%">순번</th>
											<th width="10%">구분</th>
											<th width="15%">송신번호</th>
											<th width="15%">수신번호</th>
											<th width="11%">날짜</th>
											<th width="11%">시간</th>
											<th width="17%">파일명</th>
											<th width="11%">기능</th>
										</tr>
									</thead>
									<tbody>
										<c:choose>
											<c:when test="${nilinkList.size() == 0 }">
												<tr>
													<td colspan="8">조회 된 통화내역이 없습니다.</td>
												</tr>
											</c:when>
											<c:otherwise>
												<c:forEach items="${nilinkList}" var="item" varStatus="status">
												<tr>
													<td>${totalCnt - (pageInfo.recordCountPerPage * (pageInfo.currentPageNo - 1)) - status.index}</td>
													<td>
														<c:set var="rType" value="${item.rtype}"/>
														<c:choose>
															<c:when test="${rType == 'external' }">
																<font color="blue">외부수신</font>
															</c:when>
															<c:when test="${rType == 'out' }">
																<font color="red">외부송신</font>
															</c:when>
															<c:when test="${rType == 'internal' }">
																<font color="green">내부송수신</font>
															</c:when>
															<c:otherwise>기타</c:otherwise>
														</c:choose>
													</td>
													<td>${item.send_num}</td>
													<td>${item.receive_num}</td>
													<td>
														<c:choose>
															<c:when test="${fn:length(item.folder_date) eq 8}">
																<fmt:parseDate value="${item.folder_date}" var="noticePostDate" pattern="yyyyMMdd"/>
															</c:when>
															<c:otherwise>
																<fmt:parseDate value="${item.record_time}" var="noticePostDate" pattern="yyyyMMdd"/>
															</c:otherwise>
														</c:choose>
														<fmt:formatDate value="${noticePostDate}" pattern="yyyy-MM-dd"/>
													</td>
													<td>
														<c:set var="recordTime" value="${item.record_time}"/>
														${fn:substring(recordTime,0,2)}:${fn:substring(recordTime,2,4)}:${fn:substring(recordTime,4,6)}
													</td>
													<td>${item.file_name_fmt}</td>
													<td>														
														<input title="파일다운로드" class="buttonAssistance" type="button" value="다운로드" id="downBtn" onclick="javascript:doDownload('${item.rkey}');">
													</td>
												</tr>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
							
							<input type="hidden" id="currPageIdx" value="${pageInfo.currentPageNo}"/>
							<div class="pagingWrap">
					        	<c:import url="/page_navi_nilink_list">
					            	<c:param name="beginIdx" value="${pageInfo.firstPageNoOnPageList}"/>
					                <c:param name="endIdx" value="${pageInfo.lastPageNoOnPageList}"/>
					                <c:param name="currentIdx" value="${pageInfo.currentPageNo}"/>
					                <c:param name="totalPageCnt" value="${pageInfo.totalPageCount}"/>					                					                
								</c:import>
							</div>
						</div><!-- //guestcnt4 -->
						</form>	
						<form id="nilinkDownFrm" action="nilinkRecordDownload" method="POST">
							<input type="hidden" id="downKey" name="downKey"/>
						</form>						
					</div>
				</div>
				<!-- //centercnt_bot -->
				<!-- banner -->
				<c:import url="../top_main/top_main_banner.jsp"></c:import>
				<!-- //banner -->
			</div>
			<!-- //center_cnt -->
		</div>
	</div>
	<!-- //contents -->
	<!-- footer -->
	<c:import url="../top_main/top_main_footer.jsp"></c:import>
	<!-- //footer -->
</div>
<!-- //wrapper -->
</body>
</html>
