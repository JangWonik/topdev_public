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
	
		function goDocinsert(user_no){
			
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			
			var sw=470; //띄울 창의 넓이
			var sh=320;  //띄울 창의 높이

			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			
			window.open("myDocInsForm?user_no="+user_no,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}
		
		function delRequest(serial_no,flag){
			if (flag == "del"){
				var r = confirm("삭제요청 하시겠습니까?");	
			}else{
				var r = confirm("삭제요청을 취소 하시겠습니까?");
			}
			
			if (r == false){
				return;
			}
			
			$.post( "./delRequest"
					, {serial_no : serial_no
					  ,flag : flag}
					,function(data,status){
						if(status == "success" && data == 2){ //삭제 요청
							alert("삭제요청이 완료되었습니다.");
							location.reload();
						}else if(status == "success" && data == 3){ //삭제 요청 취소
							alert("삭제요청이 취소되었습니다.");
							location.reload();
						}else{
							alert("잠시 후 다시 시도해 주세요.");
						}
					}
			);
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
								<li class="on"><a href="#">나의 품의서</a></li>
							</ul>
						</div>
						
						<div style ="margin-top:5px;">
							<div style="float:left;">
								※ 개인적인 삭제는 불가능 합니다. 삭제요청을 이용 해 주세요.
							</div>
							
							<div style="text-align:right" >
								<img src="./resources/ls_img/btn_add.gif" alt="품의서 추가 버튼" style="cursor:pointer;" onclick="goDocinsert('${user_no}');"/>
							</div>
						</div>
						 
						<div class="guestcnt4" style="display:block; height:555px;">
							<div class= "tableStyle2">
								<table>
									<thead>
										<tr>
											<th width="15%">구분</th>
											<th width="50%">품의제목</th>
											<th width="10%">확인상태</th>
											<th width="10%">다운로드</th>
											<th width="10%">비고</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${myDocList}" var="docVo">
											<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" style= "cursor:pointer;">
												<!-- 구분 -->
												<td>${docVo.col_val}</td>
												
												<!-- 품의제목-->
												<td>${docVo.doc_title}</td>
												
												<!-- 확인상태 -->
												<c:choose>
													<c:when test="${docVo.doc_state == 0}" >
														<td>미확인</td>
													</c:when>
													<c:when test="${docVo.doc_state == 8}" >
														<td>삭제요청</td>
													</c:when>
													<c:otherwise>
														<td>확인 완료</td>
													</c:otherwise>
												</c:choose>
												
												<!-- 다운로드 -->
												<td>
												<!-- 												
 													<a href="./docFileDownload?path=${docVo.file_path}&fname=${docVo.file_name}&docno=${docVo.serial_no}"> 
														<span class="mark_alarm">다운로드</span>
 													</a>
 												 --> 
												</td>
												
												<!-- 비고 -->
												<td>
													<c:choose>
														<c:when test="${docVo.doc_state == 0 or docVo.doc_state == 1}" >
															<span class="mark_alarm" id="delReqestBtn" onclick="delRequest(${docVo.serial_no},'del')">
																<font color="#DB0000">삭제요청</font>
															</span>
														</c:when>
														<c:when test="${docVo.doc_state == 8}" >
															<span class="mark_alarm" id="delReqestBtn" onclick="delRequest(${docVo.serial_no},'cancel')">
																<font color="#0000DB">요청취소</font>
															</span>
														</c:when>
														<c:otherwise>
															<td>확인 완료</td>
														</c:otherwise>
													</c:choose>
													
												
												

												</td>
											</tr>
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
