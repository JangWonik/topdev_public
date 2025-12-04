<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar-rptinv.js"></script>
	<script>
		$(document).ready(function(){
			if('${mbrVo_Session.user_no}' == null || '${mbrVo_Session.user_no}'.trim() == ''){
				alert("로그아웃 상태입니다. 재로그인 하십시오.");
				window.location.assign("./logout");
			}
		});//ready
		
		function noSiteMngTmMbrList(tmNo,UsrNo){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1505; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('myNoSiteListPop?tmNo='+tmNo+'&UsrNo='+UsrNo,'noSiteMngTmMbrList','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=no');
		}

		function windowSet(win) { 
	        var winBody = win.document.body;
	        var wid = winBody.scrollWidth + 16;
	        var hei = winBody.clientHeight + 70;
	        
	        win.resizeTo(wid, hei);
	    }
	</script>
</head>

<body OnLoad="windowSet(this)">

<!-- wrapper -->
	<!-- contents -->
	<div id="container">
		<div class="noSitePop">
			<!-- nosite_mng_pop_cnt -->
			<div class="nosite_mng_pop_cnt">
				<div class="tArea">
					<p class="suttl">${noSiteMngTmList.get(0).teamName}</p>
					<div class="tableStyle3">
						<table cellpadding="0" cellspacing="0" summary="team조사" width="900">
							<colgroup>
								<col width="100"></col>
								<col width="90"></col>
								<col width="90"></col>
								<col width="90"></col>
								<col width="90"></col>
								<col width="90"></col>
								<col width="90"></col>
								<col width="90"></col>
								<col width="90"></col>
								<col width="90"></col>
								<col width="90"></col>
							</colgroup>
							<thead>
								<tr>
									<th>이름</th>
									<th>현장제출<br/>3일전</th>
									<th>중간제출<br/>5일전</th>
									<th>진행경과제출<br/>5일전</th>
									<th>현장제출<br/>3일초과</th>
									<th>중간제출<br/>초과</th>
									<th>진행경과제출<br/>초과</th>
									<th>사고처리</th>
									<th>미결사유</th>
									<th>문제점</th>
									<th>향후처리방안</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${noSiteMngTmList}" var="noSiteMngTmVO" varStatus="status" > <!-- begin="1" end="20" step="1" -->
								<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
									style ="cursor:pointer;" onclick="noSiteMngTmMbrList('${noSiteMngTmVO.teamId}','${noSiteMngTmVO.userNo}')">
									<td>${noSiteMngTmVO.userName}</td>
									<!-- 현장제출 3일전 -->
									<td>${noSiteMngTmVO.fieldNotCnt}</td>
									<!-- 중간제출 5일전 -->
									<td>${noSiteMngTmVO.middle5dayNotCnt}</td>
									<!-- 진행경과 5일전 -->
									<td>${noSiteMngTmVO.middle5dayCnt}</td>
									<!-- 현장제출 3일 초과 -->
									<td>${noSiteMngTmVO.fieldOverCnt}</td>
									<!-- 중간제출 초과 -->
									<td>${noSiteMngTmVO.middleNotCnt}</td>
									<!-- 진행경과 초과 -->
									<td>${noSiteMngTmVO.middleCnt}</td>
									<!-- 사고처리과정 -->
									<td>${noSiteMngTmVO.sagoNotCnt}</td>
									<!-- 미결사유 -->
									<td>${noSiteMngTmVO.nowNotCnt}</td>
									<!-- 문제점 -->
									<td>${noSiteMngTmVO.prbNotCnt}</td>
									<!-- 향후처리방안 -->
									<td>${noSiteMngTmVO.plnNotCnt}</td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div><!-- //tableStyle3 -->
				</div><!-- //tArea -->
			</div>
			<!-- //left_cnt -->

		</div>
	</div>
	<!-- //contents -->
</body>
</html>
