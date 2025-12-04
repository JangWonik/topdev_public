<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css?v=2" />
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
			var sw=1305; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('myNoSiteListPop?tmNo='+tmNo+'&UsrNo='+UsrNo,'noSiteMngTmMbrList','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=no');
		}
	</script>
</head>

<body>

<!-- wrapper -->
<div id="wrapper">

	<!-- contents -->
	<div id="container">
		<div class="contetns">


			<!-- left_cnt -->
			<div class="left_cnt">
				<div class="tArea4Pop" style="-ms-overflow-style: none;">

						<p class="suttl">팀별 미결보고 누락자 확인</p>
						<div class="tableStyle3">
							<table cellpadding="0" cellspacing="0" summary="team조사">
								<thead>
									<tr>
										<th width="85px">팀명</th>
										<th>조사담당자</th>
										<th>미결보고<br />누락건</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${kind4MiMngList}" var="kind4MiMngVO" varStatus="status" > <!-- begin="1" end="20" step="1" -->
									<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
										style ="cursor:pointer;" onclick="noSiteMngTmMbrList('${kind4MiMngVO.team_id}','${kind4MiMngVO.user_no}')">
										<td>${kind4MiMngVO.team_name}</td>
										<td>${kind4MiMngVO.user_name}</td>
										<td>${kind4MiMngVO.miCnt}</td>
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

</div>
<!-- //wrapper -->

</body>
</html>
