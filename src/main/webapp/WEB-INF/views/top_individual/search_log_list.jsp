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
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>
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
		
		$.ajaxSetup({cache:false});
		_initCalendar();	
		$("#srchSearchPage").select2();
	});
	
	function fnGoSearchPage(pageIdx) {		
	    $("#pageIdxSearch").val(pageIdx);
	    $("#searchListFrm").attr('action','searchLogList');
		$("#searchListFrm").submit();				        
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
  			dateFormat: 'yy-mm-dd',
  			firstDay: 0,
  			isRTL: false,
  			showMonthAfterYear: true
  	    }); 		
  		
  	}
	
	function doSearch(){
		$("#searchListFrm").attr('action','searchLogList');
		$("#searchListFrm").submit();
	}
</script>

<!-- wrapper -->
<div id="wrapper">
	<!-- skipnavi --><!-- header -->
	<c:import url="../top_main/top_sysadm_menu.jsp"></c:import>
	<!-- //skipnavi --><!-- //header -->

	<!-- contents -->
	<div id="container">
		<div class="contetns">

			<!-- left_cnt -->
			<c:import url="../top_main/top_sysadm_left.jsp"></c:import>
			<!-- //left_cnt -->

			<!-- centercnt_top -->
			<div class="center_cnt">

				<!-- centercnt_bot -->
				<div class="centercnt_bot1-2">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">검색 및 통계 조회기록</a></li>
							</ul>							
						</div> 
						<form id="searchListFrm" action="searchLogList" method="POST">
						<input type="hidden" id="pageIdxSearch" name="pageIdxSearch" />						
						<div class="guestcnt4" style="display:block; height:555px;">
							<div class= "tableStyle2">
							<div id="search-box"  align="center" style="padding-bottom:10px;">
								<table style="width: 100%;" align="center">
									<tr>
										<th width="8%">직원명</th>
										<td width="15%">
											<input type="text" id="srchUserName" name="srchUserName" value="${srchParam.srchUserName}"/>
										</td>
										<th width="8%">로그내용</th>
										<td width="20%">
											<span style="text-align: left !important;">
												<select id="srchSearchPage" name="srchSearchPage" style="width: 200px;">
													<option value="0">- 전체 -</option>
													<c:forEach items="${searchPageList}" var="pageVo">
														<c:choose>
															<c:when test="${srchParam.srchSearchPage == pageVo.search_page}">
																<option value="${pageVo.search_page}" selected="selected">
															</c:when>
															<c:otherwise>
																<option value="${pageVo.search_page}">
															</c:otherwise>
														</c:choose>
															${pageVo.search_page}																
													</c:forEach>
												</select>
											</span>
										</td>
										<th width="10%">조회기간</th>
										<td width="20%">
											<input type="text" class="calendar" id="srchSdate" name="srchSdate" size="10" value="${srchParam.srchSdate}" maxlength="8" /> ~ 
											<input type="text" class="calendar" id="srchEdate" name="srchEdate" size="10" value="${srchParam.srchEdate}" maxlength="8" />
										</td>
										<td width="9%">											
											<input title="검색" class="buttonAssistanceDocu" type="button" value="검색" id="searchBtn" onclick="javascript:doSearch();">
										</td>
									</tr>
								</table>
							</div>							
								<table>
									<thead>
										<tr>
											<th width="10%">순번</th>
											<th width="25%">이름</th>
											<th width="25%">로그내용</th>
											<th width="20%">접근 아이피</th>
											<th width="20%">로그 시간</th>											
										</tr>
									</thead>
									<tbody>
										<c:choose>
											<c:when test="${searchLogList.size() == 0 }">
												<tr>
													<td colspan="8">조회 된 검색 통계로그가 없습니다.</td>
												</tr>
											</c:when>
											<c:otherwise>
												<c:forEach items="${searchLogList}" var="item" varStatus="status">
												<tr>
													<td>${totalCnt - (pageInfo.recordCountPerPage * (pageInfo.currentPageNo - 1)) - status.index}</td>
													<td>${item.user_name}</td>
													<td>${item.search_page}</td>
													<td>${item.user_ip}</td>
													<td>${item.reg_date}</td>
												</tr>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
							
							<input type="hidden" id="currPageIdx" value="${pageInfo.currentPageNo}"/>
							<div class="pagingWrap">
					        	<c:import url="/page_navi_search_list">
					            	<c:param name="beginIdx" value="${pageInfo.firstPageNoOnPageList}"/>
					                <c:param name="endIdx" value="${pageInfo.lastPageNoOnPageList}"/>
					                <c:param name="currentIdx" value="${pageInfo.currentPageNo}"/>
					                <c:param name="totalPageCnt" value="${pageInfo.totalPageCount}"/>					                					                
								</c:import>
							</div>
						</div><!-- //guestcnt4 -->
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
