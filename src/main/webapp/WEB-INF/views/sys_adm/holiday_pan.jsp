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
	<link rel="stylesheet" href="./resources/jquery/themes/smoothness/jquery-ui.css">
	<script src="./resources/jquery/jquery.js"></script>
	<script src="./resources/jquery/jquery-ui.js"></script>
	<script>
		$(document).ready(function(){
			if('${mbrVo_Session.user_no}' == null || '${mbrVo_Session.user_state}' != 9){
				window.location.assign("./logout");
			}
		});//ready
		$(document).ready(function(){

			$.ajaxSetup({cache:false});

			$("#selectMonth").change(function(){
				searchMonthForm.submit();
			});

		});//ready
	</script>
</head>

<body>

	<script>
		var dialog;
		var dayNo;
		$(document).ready(function(){

			$.ajaxSetup({cache:false});

			//form start
			dialog = $("#holidayDialogForm").dialog({
				autoOpen: false,
				height: 300,
				width: 500,
				modal: true
			});
			//form end

			$(".holidayDialogOpenBtn").click(function(){
				dayNo = $(this).text();
				if(dayNo.length < 2){
					$("#updateDay").val("0"+dayNo);
					$("#dayNoSpan").text("0"+dayNo);
				}else{
					$("#updateDay").val(dayNo);
					$("#dayNoSpan").text(dayNo);
				}

				$.post("./holidaySearch",
						{	searchString:$("#updateYear").val()+"-"+$("#updateMonth").val()+"-"+$("#updateDay").val()
						},
						function(data,status){
							$("#updateBasis").val("");
							if(status == "success"){
								if(data.length == 0){
									//alert("검색 결과가 없습니다.");
								}else{
				                    $.each(data, function(index, entry) {
										$("#updateBasis").val(entry.basis);
									});//each
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						},"json"
				);//post

				dialog.dialog( "open" );
			});//$(".holidayDialogOpenBtn").click

			$("#storeHolidayBtn").click(function(){
				if($("#updateBasis").val().trim() == ""){
					alert("공휴일 지정 사유 내용을 확인 후 저장해주세요.");
					$("#updateBasis").focus();
					return;
				}
				var tmp = window.confirm("공휴일을 지정 하시겠습니까?");
				if(tmp == false){
					return;
				}
				$.post("./holidayUpdate",
						{	searchString:$("#updateYear").val()+"-"+$("#updateMonth").val()+"-"+$("#updateDay").val()
							,selectBasis:$("#updateBasis").val()
						},
						function(data,status){
							if(status == "success"){
								if(data.length == 0){
									alert("공휴일 지정을 실패 하였습니다.");
								}else{
									$("#updateBasis").val("");
									searchMonthForm.submit();
								}//if(data.length == 0){
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			});//$("#storeHolidayBtn").click

			$("#restoreHolidayBtn").click(function(){
				var tmp = window.confirm("공휴일 지정을 해지 하시겠습니까?");
				if(tmp == false){
					return;
				}
				$.post("./restoreHolidayUpdate",
						{	searchString:$("#updateYear").val()+"-"+$("#updateMonth").val()+"-"+$("#updateDay").val()
						},
						function(data,status){
							if(status == "success"){
								if(data.length == 0){
									alert("공휴일 지정 해지를 실패 하였습니다.");
								}else{
									searchMonthForm.submit();
								}//if(data.length == 0){
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			});//$("#restoreHolidayBtn").click

		});//$(document).ready
	</script>

	<div id="holidayDialogForm" title="Make Holiday">
		<br />
		<p style="text-align:center;"><b>선택하신 날자를 공휴일로 지정 / 해제 합니다.</b></p>
		<br />
		<div class= "tableStyle2">
			<table>
				<tr>
					<td width="40%" bgcolor="#e7ecf1">선택 일자</td>
					<td>${selectedYear}년 ${selectedMonth}월 <span id="dayNoSpan"></span>일</td>
				</tr>
				<tr>
					<td bgcolor="#e7ecf1">공휴일 지정 사유 (한글 10자 이내)</td>
					<td>
						<input type="text" id="updateBasis" name="updateBasis" maxlength="10" style="width:96%;" />
						<input type="hidden" id="updateYear" name="updateYear" value="${selectedYear}" />
						<input type="hidden" id="updateMonth" name="updateMonth" value="${selectedMonth}" />
						<input type="hidden" id="updateDay" name="updateDay" />
					</td>
				</tr>
			</table>
		</div>
		<br />
		<p style="text-align:center;">
			<input type="button" id="restoreHolidayBtn" name="restoreHolidayBtn" value="공휴일 지정 해제" />
			<input type="button" id="storeHolidayBtn" name="storeHolidayBtn" value="공휴일 지정" />
		</p>
	</div>

<!-- wrapper -->
<div id="wrapper">
	<!-- skipnavi --><!-- header -->
	<c:import url="../top_main/top_sysadm_menu.jsp"></c:import>
	<!-- //skipnavi --><!-- //header -->

	<!-- contents -->
	<div id="container">
		<div class="contetns">

			<!-- left_cnt -->
			<c:import url="../top_main/top_sysadm_left.jsp"></c:import>
			<!-- //left_cnt -->

			<!-- centercnt_top -->
			<div class="center_cnt">

				<!-- centercnt_bot -->
				<div class="centercnt_bot1-2">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">휴일 관리</a></li>
							</ul>
						</div>

						<div class="guestcnt4" style="display:block;">

							<p style="margin-bottom:5px;text-align:right;">
								<form id="searchMonthForm" name="searchMonthForm" action="./holidayPan">
									${selectedYear}년 ${selectedMonth}월
									<select id="selectYear" name="selectYear">
										<c:forEach items="${yearList}" var = "yearVo">
											<option value="${yearVo}"
												<c:if test="${yearVo == selectedYear}">selected</c:if> >
												${yearVo}
											</option>
										</c:forEach>
									</select>
									<select id="selectMonth" name="selectMonth">
										<c:forEach begin="1" end="12" step="1" var="monthVo">
											<option value="${monthVo}"
												<c:if test="${monthVo == selectedMonth}">selected</c:if> >
												${monthVo}
											</option>
										</c:forEach>
									</select>
								</form>
							</p>

							<div class= "tableStyle2">
								<table>
									<tr>
										<th><font color="red">일</font></th>
										<th>월</th>
										<th>화</th>
										<th>수</th>
										<th>목</th>
										<th>금</th>
										<th><font color="blue">토</font></th>
									</tr>
									<tr>
										<c:forEach var="blankTdVar" begin="1" end="7" step="1">
											<c:if test="${blankTdVar < startYoil}">
												<td style="height:70px;"></td>
											</c:if>
										</c:forEach><!-- //make blank td -->
										<c:forEach items="${oneMonthList}" var="oneMonthVo" varStatus="status">
											<td style="height:70px;">
												<c:choose>
													<c:when test="${oneMonthVo.holiday_code == 0}">
														<font color="red">
															<b><span class="holidayDialogOpenBtn">${status.index + 1}</span>
																<br />${oneMonthVo.holiday_basis}</b>
														</font>
													</c:when>
													<c:when test="${oneMonthVo.holiday_yoil == 1}">
														<font color="red">
															<b><span class="holidayDialogOpenBtn">${status.index + 1}</span></b>
														</font>
													</c:when>
													<c:when test="${oneMonthVo.holiday_yoil == 7}">
														<font color="blue">
															<b><span class="holidayDialogOpenBtn">${status.index + 1}</span></b>
														</font>
													</c:when>
													<c:otherwise>
														<b><span class="holidayDialogOpenBtn">${status.index + 1}</span></b>
													</c:otherwise>
												</c:choose>
											</td>
											<c:if test="${oneMonthVo.holiday_yoil == 7}">
												</tr>
												<tr>
											</c:if>
										</c:forEach><!-- //oneMonthList -->
									</tr>
								</table>
							</div><!-- //tableStyle2 -->
							<br />
							<p style="text-align:left;">*** 일자를 클릭하시면 공휴일 편집 창이 열립니다.</p>
						</div><!-- //guestcnt4 -->

					</div><!-- //guest -->
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
