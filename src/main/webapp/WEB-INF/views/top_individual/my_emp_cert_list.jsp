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
	
		function gocertReq(user_no){
			
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			
			var sw=470; //띄울 창의 넓이
			var sh=320;  //띄울 창의 높이

			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			
			window.open("myCertIns?user_no="+user_no,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}
		
		function showThisPop(serial_no,user_no){
			
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			
			var sw=470;
			var sh=320; 

			var ml=(cw-sw)/2;   
			var mt=(ch-sh)/2;   
			
			window.open("myCertUdt?serial_no="+serial_no+"&user_no="+user_no,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}
		
		function print(serial_no){
			
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			
			var sw=700;
			var sh=600; 

			var ml=(cw-sw)/2;   
			var mt=(ch-sh)/2; 
			
			window.open("myCertPrint?serial_no="+serial_no,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}
		
		
	</script>
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
			<c:import url="../top_main/top_main_left.jsp"></c:import>
			<!-- //left_cnt -->

			<!-- centercnt_top -->
			<div class="center_cnt">

				<!-- centercnt_bot -->
				<div class="centercnt_bot1-2">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">재직증명서 요청</a></li>
							</ul>
							
						</div>
						
						<div style ="text-align:right; margin-top:5px;">
							<img src="./resources/ls_img/btn_issue.gif" alt="재증발급요청버튼" style="cursor:pointer;" onclick="gocertReq('${user_no}');"/>
						</div>
						 
						<div class="guestcnt4" style="display:block; height:555px;">
							<div class= "tableStyle2">
								<table>
									<thead>
										<tr>
											<th>no</th>
											<th>신청일시</th>
											<th>용도</th>
											<th>발급유효일</th>
											<th>상태</th>
											<th>비고</th>
										</tr>
									</thead>
									<tbody>
									
										<c:forEach items="${myCertList}" var="certVo">
											<c:choose>
												<c:when test="${certVo.issue_state eq '신청'}">
													<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" 
													style= "cursor:pointer;" onclick="showThisPop('${certVo.serial_no}','${user_no}');">
														<td>${certVo.ROWNUM}</td>
														<td>${certVo.reg_date}</td>
														<td>${certVo.issue_reason}</td>
														<td>${certVo.expiry_date}</td>
														<td><font color="blue"><b>${certVo.issue_state}</b></font></td>
														<td>-</td>
													</tr>
												</c:when>
												<c:when test="${certVo.issue_state eq '취소'}">
													<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
														<td>${certVo.ROWNUM}</td>
														<td>${certVo.reg_date}</td>
														<td>${certVo.issue_reason}</td>
														<td>${certVo.expiry_date}</td>
														<td>${certVo.issue_state}</td>
														<td>-</td>
													</tr>
												</c:when>
												<c:when test="${certVo.issue_state eq '승인'}">
													<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
														<td>${certVo.ROWNUM}</td>
														<td>${certVo.reg_date}</td>
														<td>${certVo.issue_reason}</td>
														<td>${certVo.expiry_date}</td>
														<td><font color="green"><b>${certVo.issue_state}</b></font></td>
														<c:choose>
															<c:when test="${certVo.expire_yn eq 0}">
																<td><img style = "cursor:pointer;"src="./resources/ls_img/icon_print.gif" alt="재직증명서 인쇄" onclick="print('${certVo.serial_no}')" /></td>
															</c:when>
															<c:when test="${certVo.expire_yn eq 1}">
																<td>기간만료</td>
															</c:when>
														</c:choose>
													</tr>
												</c:when>
												<c:otherwise>
													<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
														<td>${certVo.ROWNUM}</td>
														<td>${certVo.reg_date}</td>
														<td>${certVo.issue_reason}</td>
														<td>${certVo.expiry_date}</td>
														<td><font color="red"><b>${certVo.issue_state}</b></font></td>
														<td>-</td>
													</tr>
												</c:otherwise>
											</c:choose>
									</c:forEach>
										
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
							
							<!-- page start -->
							<div id = "paging">
								<c:if test="${fromMyCertList eq 'fromMyCertList' }">
									<c:import url="../util_page/page_bsc_1.jsp" charEncoding="UTF-8">
										<c:param name="totPgCntInt1" value="${totPgCntInt}"></c:param>
										<c:param name="reqPgNoInt1" value="${reqPgNoInt}"></c:param>
										<c:param name="startPgNoInt1" value="${startPgNoInt}"></c:param>
										<c:param name="endPgNoInt1" value="${endPgNoInt}"></c:param>
										<c:param name="pgNm1" value="${pgNm}"></c:param>
									</c:import>
								</c:if>
							</div>
							<!-- //page end -->
							
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

	<!-- footer -->
	<c:import url="../top_main/top_main_footer.jsp"></c:import>
	<!-- //footer -->

</div>
<!-- //wrapper -->

</body>
</html>
