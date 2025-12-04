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
		
		$("#loading").hide();
		
		$("#doCal").click( function(){
			if( confirm("아래 목록의 계산서를 자동등록처리하시겠습니까?") ){
				$("#loading").show();
				$("#doTaxCal").submit();
			}
		});
		
	});	
	
	function goModForm(param){
		/* $("#actionType").val('modForm');
		$("#popup_no").val(param);
		$("#popupForm").prop('action','divPopupAction').submit();	 */	
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
							<input type="button" style="width:50px;" value="계산실행" id="doCal" style="cursor:pointer"/>
						</div>						
						<!-- 탭메뉴 시작 -->
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">세금계산서자동등록 (${taxCalList.size()} 건)</a></li>
							</ul>
						</div>
						<form id="doTaxCal" name="doTaxCal" method="post" action="taxCalInvoiceProcess">
						</form>
						<div class="guestcnt4" style="display:block;">
							<!-- 팝업목록 시작 -->
							<div class= "tableStyle2">
								<table>
									<thead>
										<tr>
											<th width="5%">no.</th>
											<th width="10%">작업번호</th>
											<th width="10%">접수번호</th>											
											<th width="10%">계산서발행일</th>
											<th width="10%">발행금액</th>
											<th width="10%">입금일자</th>
											<th width="10%">입금금액</th>
											<th width="10%">완료여부</th>
											<th width="10%">작업일자</th>
										</tr>
									</thead>
									<tbody>										
										<c:choose>
											<c:when test="${taxCalList.size() == 0}">
												<tr>
													<td colspan="9">작업 할 내역이 없습니다.</td>
												</tr>
											</c:when>
											<c:otherwise>
												<c:forEach items="${taxCalList}" var="item" varStatus="status">
													<tr onmouseover="this.style.background='yellow'" onmouseout="this.style.background='white'" style="cursor:pointer;">
														<td>${status.index}</td>
														<td>${item.temp_no}</td>
														<td>${item.suim_accept_no}</td>
														<td>${item.publish_date_fmt}</td>
														<td>${item.publish_amount}</td>
														<td>${item.deposit_date_fmt}</td>
														<td>${item.deposit_amount}</td>
														<td>${item.end_flag}</td>
														<td>${item.reg_date}</td>
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
