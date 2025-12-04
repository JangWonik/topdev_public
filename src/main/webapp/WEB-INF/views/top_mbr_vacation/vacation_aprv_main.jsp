<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/vertical.css" />
	
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>
	
	<script src="./resources/tooltipsy/tooltipsy.min.js"></script>
	
	<%--spiner start--%>
    <script src="/resources/jquery/spin.js"></script>
    <script src="/resources/jquery/jquery.spin.js"></script>
    <%--spiner end --%>
	
	<style>
		.td-overflow-none{
			text-overflow : ellipsis;
			overflow : hidden;
			white-space : nowrap;
			word-wrap:normal;
		}
		
		.btn-vacation-aprv {
			font-weight:bold;
			text-decoration:none;
			font-family:Arial;
			text-indent:0px;
			line-height:0px;
			-moz-border-radius:5px;
			-webkit-border-radius:5px;
			border-radius:5px;
			text-align:center;
			vertical-align:middle;
			display:inline-block;
			font-size:12px;
			color:#696969  !important;
			width:60px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #eeeeee;
		}

		.btn-vacation-aprv:active {
			position:relative;
			top:4px
		}
		
		/* 모달 버튼 */
		.ui-button-text-only {
			height:2.1em !important;
		}
	</style>	
		
		
	
</head>

<body>

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
				<div class="center_cnt_vacation" >
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on" id="mainTab"><a href="#">휴가 결재 대상건 (${vacationAprvList.size()} 건)</a></li>
								<c:choose>
									<c:when test="${srchParam.pms28 == 4}">
										<li><a href="#">휴가 전체 내역</a></li>
										<li><a href="#">휴가 정보 확인</a></li>
									</c:when>
									<c:when test="${srchParam.pms28 == 1}">
										<li><a href="#">휴가 전체 내역</a></li>
									</c:when>
									<c:when test="${srchParam.workType == 3}">
										<li><a href="#">팀 휴가 내역</a></li>
									</c:when>
									<c:when test="${srchParam.workType == 14}">
										<li><a href="#">센터 휴가 내역</a></li>
									</c:when>
								</c:choose>
							</ul>
						</div>
						
						<div class="guestcnt8" id="aprvCnt" style="display:block;" >
							<c:import url="./vacation_aprv_list.jsp"></c:import>
						</div>
						
						
						<div class="guestcnt8" id="logCnt" style="display:block;" >
							<c:import url="/vacationLogList" ></c:import>
						</div>
						
						<div class="guestcnt8" id="infoCnt" style="display:block;" >
							<c:import url="/vacationInfoList" ></c:import>
						</div>
						
						
						<div id="vacation-detail-dialog" title="상세 보기" style="font-size: 15px;display:none;" align="center">
						</div>
							
						<div id="return-dialog" title="반려 하기" style="font-size: 15px;display:none;" align="center">	
							<br/>
							<table>
								<colgroup>
									<col width="30%"/>
									<col width="70%"/>
								</colgroup>
								<tr>
									<th>반려 사유</th>
									<td style="padding: 5px;"> <input type="text" id="return_comment" style="width: 100%"/> </td>
								</tr>
							</table>
						</div>
						
						<script>
							$(document).ready(function(){
								$("#logCnt").hide();
								$("#infoCnt").hide();
								
							});
						</script>
					</div>
				</div>
				<!-- //centercnt_bot -->

			<!-- //center_cnt -->
			</div>
		</div>
		<!-- //contents -->
	</div>
</div>
<!-- //wrapper -->

</body>
</html>
