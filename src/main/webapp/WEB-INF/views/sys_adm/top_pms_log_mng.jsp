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
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>	
	<script src="./resources/wm_js/common.js"></script>
	
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
</head>

<script type="text/javascript">

	$(document).ready(function(){
	
		$.ajaxSetup({cache:false});
		$("#pmsLogSearch").click(function(){
			var toDate = $("#selectorTo").val();
			var fromDate = $("#selectorFrom").val();
			location.href("/topPmsLogList?toDate="+toDate+"&fromDate="+fromDate);
		});
		
		$("#pmsLogExcel").click(function(){
			var toDate = $("#selectorTo").val();
			var fromDate = $("#selectorFrom").val();
			location.href("/topPmsLogExcel?toDate="+toDate+"&fromDate="+fromDate);
		});
		
	});//$(document).ready

	


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

						<div style="text-align:right;">
							<!-- <input type="image" src="./resources/ls_img/btn_excel.gif" id="btn_excel"/> -->
							<input type='text' id="selectorTo" class="classCalendar" size="10"  id='toDate' maxlength='10' value='' />
							~ <input type='text' id="selectorFrom" class="classCalendar" size="10"  id='fromDate' maxlength='10' value=''/>
							<input type="button" id="pmsLogSearch" name="pmsLogSearch" value="조회"/>
							<img src="./resources/ls_img/btn_excel.gif" id="pmsLogExcel" style="cursor:pointer"/>
<!-- 							<input type="button" id="lockallbtn" name="lockallbtn" value="전체 lock 설정"/> -->
						</div>
						
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">권한 변경 Log</a></li>
							</ul>
						</div>
						<div class="tableStyle2" style="overflow:hidden;border-top:0px;">
							<table>								
								<tr>
									<th width="50px" bgcolor="#efefef">이름</th>
									<th width="50px" bgcolor="#efefef">보고서<br />접수<br />(수임)</th>
									<th width="50px" bgcolor="#efefef">보고서<br />삭제</th>
									<th width="50px" bgcolor="#efefef">보고서<br />종결<br />(결재)<br />취소</th>
									<th width="50px" bgcolor="#efefef">보고서<br />잠금<br />해재</th>
									<th width="50px" bgcolor="#efefef">조사<br />보고서<br />엑셀<br />다운</th>
									<th width="50px" bgcolor="#efefef">총무<br />경리<br />열람</th>
									<th width="50px" bgcolor="#efefef">총무<br />경리<br />수정</th>
									<th width="50px" bgcolor="#efefef">보험사<br />정보<br />수정</th>
									<th width="50px" bgcolor="#efefef">관련<br />업체<br />엑셀<br />다운</th>
									<th width="50px" bgcolor="#efefef">보험사<br />공지<br />관리<br />(1종)</th>
									<th width="50px" bgcolor="#efefef">보험사<br />공지<br />관리<br />(4종)</th>
									<th width="50px" bgcolor="#efefef">팀관리</th>
									<th width="50px" bgcolor="#efefef">인사<br />기록</th>
									<th width="50px" bgcolor="#efefef">인사<br />평가<br />관리<br />권한</th>
									<th width="50px" bgcolor="#efefef">재직<br />증명서<br />승인</th>
									<th width="50px" bgcolor="#efefef">경비<br />내역<br />결재<br />&<br />취소</th>
									<th width="50px" bgcolor="#efefef">경비<br />내역<br />승인<br 6/>&<br />취소</th>
									<th width="50px" bgcolor="#efefef">적<br />부<br />워<br />드</th>
									<th width="50px" bgcolor="#efefef">응<br />답<br />전<br />문</th>
									<th width="50px" bgcolor="#efefef">통<br />계</th>
									<th width="50px" bgcolor="#efefef">수<br />정<br />자</th>
									<th width="50px" bgcolor="#efefef">변경일</th>
									<th width="15px"></th>				
								</tr>								
							</table>												
						</div>
						<div class= "tableStyle2" style="border-top:0px;overflow-x:hidden;overflow-y:scroll;height:600px;">
							<table>	
								<c:forEach items="${pmsList}" var="pmsList" varStatus="">
									<tr>
										<td>${pmsList.user_name}</td>
										<td>${pmsList.mbr_pms_1}</td>
										<td>${pmsList.mbr_pms_3}</td>
										<td>${pmsList.mbr_pms_4}</td>
										<td>${pmsList.mbr_pms_5}</td>
										<td>${pmsList.mbr_pms_6}</td>
										<td>${pmsList.mbr_pms_7}</td>
										<td>${pmsList.mbr_pms_8}</td>
										<td>${pmsList.mbr_pms_9}</td>
										<td>${pmsList.mbr_pms_10}</td>
										<td>${pmsList.mbr_pms_11}</td>
										<td>${pmsList.mbr_pms_12}</td>
										<td>${pmsList.mbr_pms_13}</td>
										<td>${pmsList.mbr_pms_14}</td>
										<td>${pmsList.mbr_pms_15}</td>
										<td>${pmsList.mbr_pms_16}</td>
										<td>${pmsList.mbr_pms_17}</td>
										<td>${pmsList.mbr_pms_18}</td>
										<td>${pmsList.mbr_pms_19}</td>
										<td>${pmsList.mbr_pms_20}</td>
										<td>${pmsList.mbr_pms_21}</td>
										<td>${pmsList.reg_user}</td>
										<td>${pmsList.reg_date}</td>
									</tr>
								</c:forEach>					
							</table>
						</div>
						<%-- <div class="guestcnt4" style="display:block;margin-top:0px;">
							<c:import url="../sys_adm/top_pms_log_list.jsp"></c:import>
						</div> --%>

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
