<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>휴가 신청</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	
	<script src="./resources/ne_js/calendar.js"></script>
	<script>
		$(document).ready(function(){
			if('${mbrAuthVo_Session.user_no}' == null){
// 				 || '${mbrAuthVo_Session.mbr_pms_9}' == 0
				window.opener.location.assign("./logout");
				window.self.close();
			}
		});//ready
	</script>
	<c:set var="rpt_invoice_no" value="${invoiceDtl.getRpt_invoice_no()}"/>
	<script>
	$(document).ready(function(){
		$.ajaxSetup({cache:false});
		if('${mbrVo_Session.user_no}' == null){
			window.location.assign("./logout");
		}
		
		
		$(".dayoffReturnBtn").click(function(){
			$.post("./topDayoffReturn",
					{
						serial_no					:$("#serial_no").val(),
						cancel_memo					:$("#cancel_memo").val()
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("반려 및 취소사유 등록이 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{
								alert("반려하였습니다.");
								window.self.close();
								window.opener.location.assign("./topDayoffList");
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}//function
					
			);//post

		});/* $("#popptnrsave").click */
	});//ready
	
	function fnGoPage(n) {
		var frm = document.misUserListForm;
		frm.reqPgNo.value = n;
		frm.submit();
	}

	</script>
</head>
<body>
	<!-- header --><!--2016.01.14.rjh.수정.교체.-->
	<div id="headerpop_mbr">
		<div class="inner clear_v2">
			<h1>
				<img src="./resources/wm_img/common/logo.gif" height="40" alt="top - TRUST OBLIGATION PASSION" />
			</h1>
			<div style="text-align:center;padding-top:10px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
				<font color="white"><b><span style="font-size:11pt;"> 휴가 이력 </span></b></font>
			</div>
		</div>
	</div>
	<!-- //header -->
	
	<!-- center -->
	<div id ="container">
		<div class="contetnsPop">
			<div class="center_cnt">
				<div class="centercnt_bot1-3">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">휴가 이력</a></li>
							</ul>
						</div>
						
						<!-- 관련업체 멤버 정보 컨텐츠 탭 -->
						<div class="guestcnt5" style="display:block;">
						<form name="misUserListForm" id="misUserListForm" method="GET" action="./DayoffUserListPop">
								<input type="hidden" id="reqPgNo" name="reqPgNo" value="">
								<input type="hidden" id="user_no" name="user_no" value="${user_no}">
						<div class= "tableStyle2">
								<table>
									<colgroup>
										<col width="3%">
										<col width="5%">
										<col width="8%">
										<col width="5%">
										<col width="8%">
										<col width="8%">
										<col width="13%">
										<col width="3%">
										<col width="25%">
										<col width="10%">
									</colgroup>
									<tr>
										<th>no</th>
										<th>이름</th>
										<th>팀명</th>
										<th>직급</th>
										<th>입사일</th>
										<th>신청일</th>
										<th>사용기간</th>
										<th>일수</th>
										<th>사유 간략히 기재, 단 "월차","정기휴가" 라고 입력하지 말 것</th>
										<th>상태</th>
									</tr>
									<c:forEach items="${getTopDayoffUserList}" var="getTopDayoff" varStatus="status" >
										<tr>
											<td>${totCntIntForListNo1 - (18 * (reqPgNoInt1 - 1)) - status.index}</td>
											<td>${getTopDayoff.getUser_name()}</td>
											<td>${getTopDayoff.getTeam_name()}</td>
											<td>${getTopDayoff.getWork_level_Nm()}</td>
											<td>${getTopDayoff.getJoin_date()}</td>
											<td>${getTopDayoff.getReg_date()}</td>
											<td>${getTopDayoff.getDayoff_start_date()} ~ ${getTopDayoff.getDayoff_end_date()}</td>
											<td>${getTopDayoff.getDayoff_count()}</td>
											<td>${getTopDayoff.getTitle()}</td>
											<td>
												<c:if test="${getTopDayoff.getState() eq '1'}">신청</c:if>
												<c:if test="${getTopDayoff.getState() eq '5'}">팀장승인</c:if>
												<c:if test="${getTopDayoff.getState() eq '10'}">인사총무팀승인</c:if>
												<c:if test="${getTopDayoff.getState() eq '2'}">반려</c:if>
											</td>
										</tr>
									</c:forEach>
								</table>
									
								</div>
								</form>
								<div class= "tableStyle2">
								<c:import url="../util_page/page_bsc_3.jsp" charEncoding="UTF-8"></c:import>
								</div>
								<br>
						</div>
					</div><!-- //guest -->
				</div><!-- //bot1-3 -->
			</div>
		</div>
	</div>
	<!--//center -->

	<!-- footer -->
	<c:import url="../top_main/top_pop_footer.jsp"></c:import>
	<!-- //footer -->

</body>
