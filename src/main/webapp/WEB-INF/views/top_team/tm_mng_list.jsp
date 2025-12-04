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
			
			if('${mbrAuthVo_Session.user_no}' == null || '${mbrAuthVo_Session.mbr_pms_13}' == 0){
				window.location.assign("./logout");
			}
			
			//탭 선택
			if( ${selTab} == 1 ){				//1종
				$("#selTab_0").attr("class","");
				$("#selTab_1").attr("class","on");
				$("#selTab_4").attr("class","");
				
				$("#selTab_0_table").hide();
				$("#selTab_1_table").show();
				$("#selTab_4_table").hide();				
			}else if( ${selTab} == 4 ){		//4종
				$("#selTab_0").attr("class","");
				$("#selTab_1").attr("class","");
				$("#selTab_4").attr("class","on");
				
				$("#selTab_0_table").hide();
				$("#selTab_1_table").hide();
				$("#selTab_4_table").show();
			}else{		//본사
				$("#selTab_0").attr("class","on");
				$("#selTab_1").attr("class","");
				$("#selTab_4").attr("class","");
				
				$("#selTab_0_table").show();
				$("#selTab_1_table").hide();
				$("#selTab_4_table").hide();
			}
			
		});//ready
	</script>
</head>

<body>

<c:set var="teamlist0" value="${teamlist0}" />
<c:set var="teamlist1" value="${teamlist1}" />
<c:set var="teamlist4" value="${teamlist4}" />

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
								<li id="selTab_0"><a href="#">팀관리 - 본사사업부</a></li>
								<li id="selTab_1"><a href="#">팀관리 - 1종사업부</a></li>
								<li id="selTab_4"><a href="#">팀관리 - 4종사업부</a></li>
							</ul>
						</div>

						<div id="selTab_0_table" class="guestcnt4">
							<div class="tableStyle2">

								<table>
									<tr bgcolor='#f8f8f8' align=center>
										<td>구분</td>
										<td width = "120px;">부문</td>
										<td width = "120px;">센터</td>
										<td width = "30px;">code</td>
										<td width = "120px;">분류명</td>
										<td width = "70px;">마크</td>
										<td>수임코드</td>
										<td>종결코드</td>
										<td>인원</td>
										<td>그룹순서</td>
										<td width = "30px;">통계</td>
										<td>우선순위</td>
										<td width = "100px;"><a href="teamamd?action=add&tt=0&selTab=0"><img src="./resources/ls_img/btn_add.gif" border=0 width="45" height="18"></a></td>
									</tr>
										<c:forEach items="${teamlist0}" var = "ListDto">
											<tr align=center class=st_bgc_list>
												<td >
													<c:if test="${ListDto.team_type eq 0}">본사총괄</c:if>
													<c:if test="${ListDto.team_type eq 1}">1종</c:if>
													<c:if test="${ListDto.team_type eq 4}">4종</c:if>
												</td>
												<td>
													${ListDto.team_sector_val}
												</td>
												<td>
													${ListDto.team_center_val}
												</td>
												<td>${ListDto.team_id}</td>
												<%-- <td><c:out value ="${ListDto.team_type}"/></td> --%>
												<td style="text-align:left;"><p style="margin-left:5;">
													<c:choose >
														<c:when test="${ListDto.team_level eq 0}">
															<a href="teamamd?action=modify&tt=0&team_id=${ListDto.team_id}&selTab=0"><b>${ListDto.team_name}</b></a>
														</c:when>
														<c:when test="${ListDto.team_level eq 1}">
															<a href="teamamd?action=modify&tt=0&team_id=${ListDto.team_id}&selTab=0">&nbsp;&nbsp;└ ${ListDto.team_name}</a>
														</c:when>
														<c:when test="${ListDto.team_level eq 2}">
															<a href="teamamd?action=modify&tt=0&team_id=${ListDto.team_id}&selTab=0"><font color='#003399'>&nbsp;&nbsp;&nbsp;&nbsp;└ ${ListDto.team_name}</font></a>
														</c:when>
													</c:choose>
												</p></td>
												<td style="text-align:center;">
													<c:if test="${not empty ListDto.team_mark}">
														<span class="mark_alarm">${ListDto.team_mark}</span>
													</c:if>
												</td>
												<td>${ListDto.suim_scode}</td>
												<td>${ListDto.suim_ecode}</td>

												<td>인원</td>
												<td>${ListDto.team_group_order}</td>
												<td>
													<c:if test="${ListDto.team_type eq 1}">
														<c:if test="${ListDto.team_statistics1 eq 0}">O</c:if>
														<c:if test="${ListDto.team_statistics1 eq 1}">X</c:if>
													</c:if>
													<c:if test="${ListDto.team_type eq 4}">
														<c:if test="${ListDto.team_statistics4 eq 0}">O</c:if>
														<c:if test="${ListDto.team_statistics4 eq 1}">X</c:if>
													</c:if>
												</td>
												<td>${ListDto.team_order}</td>
												<td>
													<a href="teamamd?action=add&tt=0&parent=${ListDto.team_level}&order=${ListDto.team_group_order}&selTab=0">
														<img src="./resources/ls_img/btn_add.gif" border=0 width="45" height="18">
													</a>
												</td>
											</tr>
										</c:forEach>

								</table>

							</div>
						</div><!-- //guestcnt4 -->

						<div id="selTab_1_table" class="guestcnt4">
							<div class="tableStyle2">

								<table>
									<tr bgcolor='#f8f8f8' align=center>
										<td>구분</td>
										<td width = "120px;">부문</td>
										<td width = "120px;">센터</td>
										<td width = "30px;">code</td>
										<td width = "120px;">분류명</td>
										<td width = "70px;">마크</td>
										<td>수임코드</td>
										<td>종결코드</td>
										<td>인원</td>
										<td>그룹순서</td>
										<td width = "30px;">통계</td>
										<td>우선순위</td>
										<td width = "100px;"><a href="teamamd?action=add&tt=1&selTab=1"><img src="./resources/ls_img/btn_add.gif" border=0 width="45" height="18"></a></td>
									</tr>
										<c:forEach items="${teamlist1}" var = "ListDto">
											<tr align=center class=st_bgc_list>
												<td >
													<c:if test="${ListDto.team_type eq 0}">본사총괄</c:if>
													<c:if test="${ListDto.team_type eq 1}">1종</c:if>
													<c:if test="${ListDto.team_type eq 4}">4종</c:if>
												</td>
												<td>
													${ListDto.team_sector_val}
												</td>
												<td>
													${ListDto.team_center_val}
												</td>
												<td>${ListDto.team_id}</td>
												<%-- <td><c:out value ="${ListDto.team_type}"/></td> --%>
												<td style="text-align:left;"><p style="margin-left:5;">
													<c:choose >
														<c:when test="${ListDto.team_level eq 0}">
															<a href="teamamd?action=modify&tt=1&team_id=${ListDto.team_id}&selTab=1"><b>${ListDto.team_name}</b></a>
														</c:when>
														<c:when test="${ListDto.team_level eq 1}">
															<a href="teamamd?action=modify&tt=1&team_id=${ListDto.team_id}&selTab=1">&nbsp;&nbsp;└ ${ListDto.team_name}</a>
														</c:when>
														<c:when test="${ListDto.team_level eq 2}">
															<a href="teamamd?action=modify&tt=1&team_id=${ListDto.team_id}&selTab=1"><font color='#003399'>&nbsp;&nbsp;&nbsp;&nbsp;└ ${ListDto.team_name}</font></a>
														</c:when>
													</c:choose>
												</p></td>
												<td style="text-align:center;">
													<c:if test="${not empty ListDto.team_mark}">
														<span class="mark_alarm">${ListDto.team_mark}</span>
													</c:if>
												</td>
												<td>${ListDto.suim_scode}</td>
												<td>${ListDto.suim_ecode}</td>

												<td>인원</td>
												<td>${ListDto.team_group_order}</td>
												<td>
													<c:if test="${ListDto.team_type eq 1}">
														<c:if test="${ListDto.team_statistics1 eq 0}">O</c:if>
														<c:if test="${ListDto.team_statistics1 eq 1}">X</c:if>
													</c:if>
													<c:if test="${ListDto.team_type eq 4}">
														<c:if test="${ListDto.team_statistics4 eq 0}">O</c:if>
														<c:if test="${ListDto.team_statistics4 eq 1}">X</c:if>
													</c:if>
												</td>
												<td>${ListDto.team_order}</td>
												<td>
													<a href="teamamd?action=add&tt=1&parent=${ListDto.team_level}&order=${ListDto.team_group_order}&selTab=1">
														<img src="./resources/ls_img/btn_add.gif" border=0 width="45" height="18">
													</a>
												</td>
											</tr>
										</c:forEach>

								</table>

							</div>
						</div><!-- //guestcnt4 -->

						<div id="selTab_4_table" class="guestcnt4">
							<div class="tableStyle2">

								<table>
									<tr bgcolor='#f8f8f8' align=center>
										<td>구분</td>
										<td width = "120px;">부문</td>
										<td width = "120px;">센터</td>
										<td width = "30px;">code</td>
										<td width = "120px;">분류명</td>
										<td width = "70px;">마크</td>
										<td>수임코드</td>
										<td>종결코드</td>
										<td>인원</td>
										<td>그룹순서</td>
										<td width = "30px;">통계</td>
										<td>우선순위</td>
										<td width = "100px;"><a href="teamamd?action=add&tt=4&selTab=4"><img src="./resources/ls_img/btn_add.gif" border=0 width="45" height="18"></a></td>
									</tr>
										<c:forEach items="${teamlist4}" var = "ListDto">
											<tr align=center class=st_bgc_list>
												<td >
													<c:if test="${ListDto.team_type eq 0}">본사총괄</c:if>
													<c:if test="${ListDto.team_type eq 1}">1종</c:if>
													<c:if test="${ListDto.team_type eq 4}">4종</c:if>
												</td>
												<td>
													${ListDto.team_sector_val}
												</td>
												<td>
													${ListDto.team_center_val}
												</td>
												<td>${ListDto.team_id}</td>
												<%-- <td><c:out value ="${ListDto.team_type}"/></td> --%>
												<td style="text-align:left;"><p style="margin-left:5;">
													<c:choose >
														<c:when test="${ListDto.team_level eq 0}">
															<a href="teamamd?action=modify&tt=4&team_id=${ListDto.team_id}&selTab=4"><b>${ListDto.team_name}</b></a>
														</c:when>
														<c:when test="${ListDto.team_level eq 1}">
															<a href="teamamd?action=modify&tt=4&team_id=${ListDto.team_id}&selTab=4">&nbsp;&nbsp;└ ${ListDto.team_name}</a>
														</c:when>
														<c:when test="${ListDto.team_level eq 2}">
															<a href="teamamd?action=modify&tt=4&team_id=${ListDto.team_id}&selTab=4"><font color='#003399'>&nbsp;&nbsp;&nbsp;&nbsp;└ ${ListDto.team_name}</font></a>
														</c:when>
													</c:choose>
												</p></td>
												<td style="text-align:center;">
													<c:if test="${not empty ListDto.team_mark}">
														<span class="mark_alarm">${ListDto.team_mark}</span>
													</c:if>
												</td>
												<td>${ListDto.suim_scode}</td>
												<td>${ListDto.suim_ecode}</td>

												<td>인원</td>
												<td>${ListDto.team_group_order}</td>
												<td>
													<c:if test="${ListDto.team_type eq 1}">
														<c:if test="${ListDto.team_statistics1 eq 0}">O</c:if>
														<c:if test="${ListDto.team_statistics1 eq 1}">X</c:if>
													</c:if>
													<c:if test="${ListDto.team_type eq 4}">
														<c:if test="${ListDto.team_statistics4 eq 0}">O</c:if>
														<c:if test="${ListDto.team_statistics4 eq 1}">X</c:if>
													</c:if>
												</td>
												<td>${ListDto.team_order}</td>
												<td>
													<a href="teamamd?action=add&tt=4&parent=${ListDto.team_level}&order=${ListDto.team_group_order}&selTab=4">
														<img src="./resources/ls_img/btn_add.gif" border=0 width="45" height="18">
													</a>
												</td>
											</tr>
										</c:forEach>

								</table>

							</div>
						</div><!-- //guestcnt4 -->

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
