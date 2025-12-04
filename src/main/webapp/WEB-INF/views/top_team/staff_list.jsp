<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<script>
		$(document).ready(function(){
		});//$(document).ready
		
		function popStaffDetail(user_no){
			
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			
			var sw=860; //띄울 창의 넓이
			var sh=670;  //띄울 창의 높이

			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			
			window.open('topStaffDetail?user_no='+user_no,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}
	</script>
	
	<style>
		.tableStyle2 td {letter-spacing: 0;}
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

			<!-- left_cnt -->
<%-- 			<c:import url="../top_main/top_main_left.jsp"></c:import> --%>
			<!-- //left_cnt -->

			<!-- centercnt_top -->
			<div class="center_cnt_1300_ds">

				<!-- centercnt_bot -->
				<div class="centercnt_1300_bot1-2_ds">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">입/퇴사 확인</a></li>
							</ul>
						</div>
						
						<%-- <c:import url="../include/top_mbr_state_search.jsp"></c:import> --%>
						
						<div class="guestcnt_1300_ds" style="display:block;">
							<!-- 검색 테이블 시작-->
							<div class= "tableStyle2">
								<form id="staffListFrm" name="staffListFrm" method="POST" action="">
									<table>
										<thead>
											<tr>
												<th width="25%">재직상태</th>
												<th width="25%">팀명</th>
												<th width="35%">검색어 (이름 or 전화번호 or 아이디)</th>
												<th width="15%">검색</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>
													
													<select id="staffState" name="staffState">
														<option value="10" <c:if test="${srchArg.staffState == 10}">selected</c:if> >전체(근무자/발령대기자/퇴사자)</option>
														<option value="0"  <c:if test="${srchArg.staffState == 0}">selected</c:if> >근무자</option>
														<option value="3"  <c:if test="${srchArg.staffState == 3}">selected</c:if> >휴직자</option>
														<option value="2"  <c:if test="${srchArg.staffState == 2}">selected</c:if> >발령대기자</option>
														<option value="1"  <c:if test="${srchArg.staffState == 1}">selected</c:if> >퇴사자</option>
													</select>
												</td>
												<td>
													<select id="teamId" name="teamId">
														<option value="0" selected>전체</option>
														<c:forEach items="${teamList}" var = "teamVo">
															<c:choose>
																<c:when test="${srchArg.teamId == teamVo.team_id}" >
																	<option value="${teamVo.team_id}" selected="selected">
																</c:when>
																<c:otherwise>
																	<option value="${teamVo.team_id}">
																</c:otherwise>
															</c:choose>
															
															<c:if test="${teamVo.team_level == 1}">&nbsp;└</c:if>
															<c:if test="${teamVo.team_level == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
															${teamVo.team_name}
														
														</c:forEach>
													</select>
												</td>
												<td>
													<input type="text" id="searchStr" name="searchStr" size="50" value="${srchArg.searchStr}"/>
												</td>
												<td>
													<input type="image" src="./resources/ls_img/btn_src.gif" onclick="submit();" />
												</td>
											</tr>
										</tbody>
									</table>
								</form>
								<!-- 검색 테이블 끝-->
							</div><!-- //tableStyle2 -->
							<br />
							<div class= "tableStyle2">
								<!-- 검색 결과 테이블 시작-->
								<table>
									<thead>
										<tr>
											<th width="5%">No</th>
											<th width="20%">팀명</th>
											<!-- 180108 직급/직책 에서 직위/직급으로 변경 -->
											<th>직위</th>
											<th>직책</th>
											<th>이름</th>
											<th>아이디</th>
											<th>입사일</th>
											<th>퇴사일</th>
											<th>현재상태</th>
											<th>비고</th>
										</tr>
									</thead>
									<tbody id="searchTbody">
									<c:forEach items="${staffList}" var="item" varStatus="status">
										<tr>
											<td>${status.count}</td>
											<td>${item.team_name}</td>
											<td>${item.work_level}</td>
											<td>${item.work_type}</td>
											<td>${item.user_name}</td>
											<td>${item.user_id}</td>
											<td>${item.join_date}</td>
											<td>${item.out_date}</td>
											<td>${item.user_state}</td>
											<td>
												<img src='./resources/ls_img/member/btn_view.gif'  onclick="popStaffDetail(${item.user_no})" style='cursor:pointer;' />
											</td>
										</tr>
									</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
						
					</div>
				</div>
				<!-- //centercnt_bot -->
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
