<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
</head>

<script type="text/javascript">
	$(document).ready(function(){
		
		//팝업 추가 페이지로 이동
		$("#popupAdd").click( function(){			
			$("#actionType").val('addForm');
			$("#popup_no").val('0');
			$("#popupForm").prop('action','divPopupAction').submit();	
		});		
		
	});	
	
	function goModForm(param){
		$("#actionType").val('modForm');
		$("#popup_no").val(param);
		$("#popupForm").prop('action','divPopupAction').submit();		
	}
</script>

<body>
<!-- wrapper -->
<div id="wrapper">
	<!-- skipnavi --><!-- header -->
	<c:import url="../top_main/top_sysadm_menu.jsp"></c:import>
	<!-- //skipnavi --><!-- //header -->

	<!-- contents -->
	<div id="container">
		<div class="contetns">
			<!-- centercnt_top -->
			<div class="center_cnt_1300">

				<!-- centercnt_bot -->
				<div class="center_cnt_1300_bot">
					<div class="guest">
						<!-- 상단버튼시작 -->
						<div style="text-align:right;">
							<!-- <input type="image" src="/resources/ls_img/btn_add.gif" id="popupAdd" style="cursor:pointer;"/> -->
							<input type="button" style="width:50px;" value="추가" id="popupAdd" style="cursor:pointer"/>
						</div>
						<form id="popupForm" name="popupForm" method="post" action="divPopupAction">
							<input type="hidden" id="actionType" name="actionType"/>
							<input type="hidden" id="popup_no" name="popup_no" />							
						</form>
						<!-- 탭메뉴 시작 -->
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">DIV팝업관리</a></li>
							</ul>
						</div>
						<div class="guestcnt4" style="display:block;">
							<!-- 팝업목록 시작 -->
							<div class= "tableStyle2">
								<table>
									<thead>
										<tr>
											<th width="5%">no.</th>
											<th width="30%">팝업명</th>
											<th width="20%">팝업노출기간</th>											
											<th width="15%">반복여부</th>
											<th width="15%">사용여부</th>
											<th width="15%">등록일자</th>										
										</tr>
									</thead>
									<tbody>										
										<c:choose>
											<c:when test="${divPopupList.size() == 0}">
												<tr>
													<td colspan="6">등록된 팝업이 없습니다.</td>
												</tr>
											</c:when>
											<c:otherwise>
												<c:forEach items="${divPopupList}" var="popup" varStatus="status">
													<tr onmouseover="this.style.background='yellow'" onmouseout="this.style.background='white'" onclick="javascript:goModForm('${popup.popup_no}');" style="cursor:pointer;">
														<td>${divPopupList.size()+1 - status.count}</td>
														<td>${popup.subject}</td>
														<td>${fn:substring(popup.sdate,0,10)} ~ ${fn:substring(popup.edate,0,10)}</td>
														<td>
															<c:choose>
																<c:when test="${popup.repeat_flag eq 2}"> (매월)
																	${popup.month_flag} 일
																</c:when>
																<c:when test="${popup.repeat_flag eq 1}"> (매주)
																	<c:choose>
																		<c:when test="${popup.week_flag eq 1}">일요일</c:when>
																		<c:when test="${popup.week_flag eq 2}">월요일</c:when>
																		<c:when test="${popup.week_flag eq 3}">화요일</c:when>
																		<c:when test="${popup.week_flag eq 4}">수요일</c:when>
																		<c:when test="${popup.week_flag eq 5}">목요일</c:when>
																		<c:when test="${popup.week_flag eq 6}">금요일</c:when>
																		<c:when test="${popup.week_flag eq 7}">토요일</c:when>
																		<c:otherwise>지정안됨</c:otherwise>																		
																	</c:choose>
																</c:when>
																<c:otherwise>매일</c:otherwise>																
															</c:choose>															
														</td>
														<td>
															<c:choose>
																<c:when test="${popup.is_use eq 2}">로그인 후</c:when>
																<c:when test="${popup.is_use eq 1}">로그인 전</c:when>
																<c:otherwise>사용안함</c:otherwise>
															</c:choose>														
														</td>
														<td>${fn:substring(popup.reg_date,0,10)}</td>
													</tr>
												</c:forEach>
											</c:otherwise>
										</c:choose>						
									</tbody>
								</table>
							</div>
							<!-- 팝업목록 끝 -->
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
