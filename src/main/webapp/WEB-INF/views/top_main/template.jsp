<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
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
				<!-- centercnt_top -->
				<div class="centercnt_top">
					<div class="nociteA nocite notice01">
						<div class="notice_top">
							<h3>중요공지</h3>
						</div>
						<div class="notice_bot">
							<div class="tableStyle1">
								<table cellpadding="0" cellspacing="0" summary="공지사항">
									<caption>공지사항</caption>
									<colgroup>
										<col width="*">
										<col width="80" />
									</colgroup>
									<tbody>
										<tr>
											<td>
												<span class="alarm alarm01">공지</span><a href="#;" class="txt">[1종] 메리츠 소액 위탁 보고서 전산화 오픈[1종] 메리츠 소액 위탁 보고서 전산화 오픈</a><span class="ico_new"><img src="./resources/wm_img/common/ico_new.png" alt="new" /></span>
											</td>
											<td class="day">2015-12-01</td>
										</tr>
										<tr>
											<td>
												<span class="alarm alarm02">보험</span><a href="#;" class="txt">[전체] 흥국 계약적부 계약서 및 보수가 변경되었습니다.[전체] 흥국 계약적부 계약서 및 보수가 변경되었습니다.</a></span>
											</td>
											<td class="day">2015-12-01</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<a href="#;" class="btn_more"><img src="./resources/wm_img/common/btn_more.gif" alt="더보기" /></a>
					</div>
					<div class="nociteA nocite notice02">
						<div class="notice_top">
							<h3>자유게시판</h3>
						</div>
						<div class="notice_bot">
							<div class="tableStyle1">
								<table cellpadding="0" cellspacing="0" summary="공지사항">
									<caption>공지사항</caption>
									<colgroup>
										<col width="*">
										<col width="80" />
									</colgroup>
									<tbody>
										<tr>
											<td>
												<span class="middot"></span><a href="#;" class="txt">[전체] 앞서 남북 종교대표자는 "최근 일촉즉발의 앞서 남북 종교대표자는 "최근 일촉즉발의 ..</a><span class="ico_new"><img src="./resources/wm_img/common/ico_new.png" alt="new" /></span>
											</td>
											<td class="day">2015-12-01</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<a href="#;" class="btn_more"><img src="./resources/wm_img/common/btn_more.gif" alt="더보기" /></a>
					</div>
				</div>
				<!-- //centercnt_top -->
				<!-- centercnt_bot -->
				<div class="centercnt_bot">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">조사건(1)</a></li>
								<li><a href="#">삼성계약적부(0)</a></li>
								<li><a href="#">LIG계약적부(0)</a></li>
								<li><a href="#">한화 계약적부(0)</a></li>
								<li><a href="#">흥국 계약적부(0)</a></li>
							</ul>
						</div>
						<div class="guestcnt" style="display:block;">
							<div class="tableStyle2">
								<table cellpadding="0" cellspacing="0" summary="고객리스트 현황">
									<caption>고객리스트 현황</caption>
									<colgroup>
										<col width="53">
										<col width="142" />
										<col width="94" />
										<col width="165" />
										<col width="91" />
										<col width="123" />
										<col width="79" />
										<col width="79" />
										<col width="111" />
									</colgroup>
									<thead>
										<tr>
											<th>구분</th>
											<th>접수번호</th>
											<th>보험사</th>
											<th>보험담당</th>
											<th>계약자</th>
											<th>피보험자</th>
											<th>상태</th>
											<th>DAY</th>
											<th>수임일자</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>질병</td>
											<td>TL1509-1045</td>
											<td>한화손해</td>
											<td>김용길</td>
											<td>김혜자</td>
											<td>이상배</td>
											<td>미결</td>
											<td>74</td>
											<td>2015-09-04</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<div class="guestcnt">
						</div>
						<div class="guestcnt">
						</div>
						<div class="guestcnt">
						</div>
						<div class="guestcnt">
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
