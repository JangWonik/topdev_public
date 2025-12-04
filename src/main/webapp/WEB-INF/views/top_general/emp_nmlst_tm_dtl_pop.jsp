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
			if('${mbrVo_Session.user_no}' == null || '${mbrVo_Session.user_no}'.trim() == ''){
				window.location.assign("./logout");
			}
		});//ready

		function openSMS(hpNo){

			var cw=screen.availWidth;
			var ch=screen.availHeight;

			var sw=380; //띄울 창의 넓이
			var sh=533;  //띄울 창의 높이

			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치

			window.open('simpleSMSForm?hpNo='+hpNo,'simpleSMS','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}

		function popMbrDetail(user_no){

			var cw=screen.availWidth;
			var ch=screen.availHeight;

			var sw=1010; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이

			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치

			window.open('PopEmpNmlstDtl?user_no='+user_no,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}
	</script>
</head>

<body>

<!-- wrapper -->
<div id="wrapper">
<%-- 
	<!-- skipnavi --><!-- header -->
	<c:import url="../top_main/top_main_menu.jsp"></c:import>
	<!-- //skipnavi --><!-- //header -->
 --%>
	<!-- contents -->
	<div id="container">
		<div class="contetnsPop">

<%-- 			<!-- left_cnt -->
			<c:import url="../top_main/top_main_left.jsp"></c:import>
			<!-- //left_cnt -->

			<!-- centercnt_top -->
			<div class="center_cnt">

 --%>				<!-- centercnt_bot -->
				<div class="centercnt_bot1-2">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">직원명부</a></li>
							</ul>
						</div>
						<!-- 직원명부 해당 팀현황 시작 -->
						<div class="guestcnt4" style="display:block;">
							<div class= "tableStyle2">
								<table>
										<tr>
											<td bgcolor="#e7ecf1">부서명</td>
											<td style="letter-spacing: 0px;"><c:out value="${team_info.get(0).getTeam_name()}"/></td>
											<td bgcolor="#e7ecf1">구성원</td>
											<td style="border-right:0;letter-spacing: 0px;"><c:out value="${memberList.size()}"/>명</td>
											<td style="border-left:0;border-right:0;"></td>
											<td style="border-left:0;"></td>
										</tr>
										<tr>
											<td bgcolor="#e7ecf1">전   화</td>
											<td style="letter-spacing: 0px;"><c:out value="${team_info.get(0).getTeam_telephone()}"/></td>
											<td bgcolor="#e7ecf1">팩   스</td>
											<td style="letter-spacing: 0px;"><c:out value="${team_info.get(0).getTeam_fax()}"/></td>
											<td bgcolor="#e7ecf1">인터폰</td>
											<td style="letter-spacing: 0px;"><c:out value="${team_info.get(0).getTeam_interphone()}"/></td>
										</tr>
										<tr>
											<td bgcolor="#e7ecf1">주   소</td>
											<td colspan="5" style="text-align:left;padding-left:5%;"><c:out value="${team_info.get(0).getTeam_addr()}"/></td>
										</tr>
								</table>
							</div><!-- //tableStyle2 -->
							<!-- 직원명부 해당팀현황 종료 -->
							<br>
							<br>
							<div class= "tableStyle2">
								<table>
										<!-- 본부 출력 끝 -->
										<thead>
										<tr>
											<!-- 180108 직급/직책 에서 직위/직급으로 변경 -->
											<th width="10%">직위</th>
											<!-- <th width="20%">직급</th> -->
											<th width="20%">직책</th>
											<th width="10%">이름</th>
											<th width="10%">문자</th>
											<th width="10%">H.P</th>
											<th width="10%">직통번호</th>
											<th width="10%">비고</th>
										</tr>
									</thead>
									<c:forEach items="${memberList}" var="vo">
										<tr>
											<td style="letter-spacing: 0px"><c:out value="${vo.getWork_level()}"/></td>
											<td style="letter-spacing: 0px"><c:out value="${vo.getWork_type()}"/></td>
											<td style="letter-spacing: 0px"><c:out value="${vo.getUser_name()}"/></td>
											<td style="letter-spacing: 0px"><img src="./resources/ls_img/top_team/icon_hp.gif" style="cursor:pointer;" onclick="openSMS('${vo.getHandphone()}');"/></td>
											<td style="letter-spacing: 0px"><c:out value="${vo.getHandphone()}"/></td>
											<td style="letter-spacing: 0px"><c:out value="${vo.getOffice_tel()}"/></td>
											<td style="letter-spacing: 0px"><img src="./resources/ls_img/member/btn_view.gif" style="cursor:pointer;" onclick="popMbrDetail('${vo.user_no}')"/></td>
										</tr>
									</c:forEach>
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
						</div><!-- //guestcnt4 -->
						<div class="guestcnt4" style="display:none;">
						</div>
						<div class="guestcnt4" style="display:none;">
						</div>
						<div class="guestcnt4" style="display:none;">
						</div>
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
<%-- 
	<!-- footer -->
	<c:import url="../top_main/top_main_footer.jsp"></c:import>
	<!-- //footer -->
 --%>
</div>
<!-- //wrapper -->

</body>
</html>
	