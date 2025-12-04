<%--
  Created by IntelliJ IDEA.
  User: hongkihun
  Date: 2017. 08. 11.
  Time:  오후 2:25
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>당직비 수정</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
		
	<%--<script src="./resources/daum/161109.js"></script>--%>
	<script src="./resources/daum/postcode.v2.js"></script>
	<script src='https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js'></script>
	


	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	
	<script src="./resources/ne_js/ne_number.js"></script>
	
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>	
		<style>
		.head1{
			/*width:15%;*/
			/*text-align:left;*/
			padding: 4px 0 4px 5px;
			background-color:#EDEDED;
		}
		
	</style>	
<script type="text/javascript">

	function dutyCost_save(){
		var form = document.dutyCostform;

		form.submit();
	}
</script>	
</head>
<body>
<div id="wrapper">
	<!-- skipnavi --><!-- header -->
	<c:import url="../top_main/top_main_menu.jsp"></c:import>
	<!-- //skipnavi --><!-- //header -->

	<!-- contents -->
	<div id="container">
		<div class="contetns">

			<!-- centercnt_top -->
			<div class="center_cnt_1300">
				<div class="center_cnt_1300_bot">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on" style="width: 90%;"><a href="#">당직비 수정</a></li>
							</ul>			
						</div>
						<form id="dutyCostform" name="dutyCostform" method=post action="dutyCostInsert">
						<input type="hidden" id="duty_no" name="duty_no" value="">		
							<div class= "tableStyle6">
								<table align="center" style = "margin-top:10px;" >
									<colgroup>
										<col width="15%">
										<col width="30%">
										<col width="15%">
										<col width="30%">
									</colgroup>
									<tbody>
						                <tr id = "reportType2Tr">
										
										<tr>
											<td class="head1">ㆍ사고번호</td>
											<td colspan="3" >
												<input type="text" id="accNo"  name="accNo"size="30" onkeyup="checkAccNum();"/>
												<span id = "accNoWarn"></span>
											</td>
										</tr>
										<tr>
											<td class="head1">ㆍ당직일</td>
											<td colspan="3">
												<input type="text" class="classCalendar" size="15" id="duty_time" name="duty_time" value="" maxlength="10" />
											</td>
										</tr>				
										<tr>
											<td class="head1">ㆍ당직자</td>
											<td colspan="3" >
												<input type="text" id="dyty_name"  name="duty_name"size="30"/>
												<span id = "accNoWarn"></span>
											</td>
										</tr>	
										<tr>					                
						                    <td class="head1">ㆍ보험사</td>
						                    <td colspan="3">
												<span id="ptnrNormal">
													<input type="radio" id="ptnr_rpt23" name = "dutyIns" value = "3"/> <label for='ptnr_rpt23'><b>농협</b></label>
													<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
													<input type="radio" id="ptnr_rpt21" name = "dutyIns" value = "1"/> <label for='ptnr_rpt21'><b>동부</b></label>
													<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
													<input type="radio" id="ptnr_rpt22" name = "dutyIns" value = "2"/> <label for='ptnr_rpt22'><b>삼성</b></label>				
												</span>
											</td>
										</tr>
										<tr>
						                    <td class="head1">ㆍ당직 구분</td>
						                    <td colspan="3">
												<span id="ptnrNormal">
													<input type="radio" id="gubun_rpt1" name = "duty_div" value = "1"/> <label for='gubun_rpt1'><b>전화당직(평일)</b></label>
													<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
													<input type="radio" id="gubun_rpt2" name = "duty_div" value = "2"/> <label for='gubun_rpt2'><b>전화당직(휴일)</b></label>
													<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
													<input type="radio" id="gubun_rpt3" name = "duty_div" value = "3"/> <label for='gubun_rpt3'><b>출동대기</b></label>
													<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
													<input type="radio" id="gubun_rpt5" name = "duty_div" value = "5"/> <label for='gubun_rpt5'><b>출동대기+출동</b></label>
													<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
													<input type="radio" id="gubun_rpt4" name = "duty_div" value = "4"/> <label for='gubun_rpt4'><b>출동</b></label>																																									
												</span>
											</td>
										</tr>
										<tr>
											<td class="head1">ㆍ건수</td>
											<td colspan="3" >
												<input type="text" id="duty_num"  name="duty_num"size="10"/>건
												<span id = "duty_number"></span>
											</td>
										</tr>										
										<tr class="rptInsBodyNoneSpeed">
											<td class="head1">ㆍ출동내용(계약자명)</td>
											<td colspan="3">
												<textarea rows="3" style="width:560px;" id = "dutyContent" name="dutyContent" cols="1" ></textarea>
											</td>
										</tr>	
										<tr>
											<td class="head1">ㆍ당직비용</td>
											<td colspan="3" >
												<input type="text" id="duty_num"  name="duty_num"size="10"/>원
												<span id = "duty_number"></span>
											</td>
										</tr>
										<tr>
											<th style="vertical-align:top;">
												 <input type="button" id="btn_add_file" value="첨부파일추가" />
											</th>
											<td id="addFileFormDiv" colspan="3"></td>
										</tr>																																										
									</tbody>
								</table>	
							</div>
						</form>	
						<div style ="text-align:center; margin-top:10px;">
							<a id="dutyCost_save" href="#noloc"><img src="./resources/ls_img/btn_ok.gif" style = "cursor:pointer;" /></a>
							<a href="./dutyList"><img src="./resources/ls_img/btn_cancel.gif" style = "cursor:pointer;" /></a> 
						</div>
					</div><!-- guest -->
				</div><!-- center_cnt_1300_bot -->
			</div><!-- center_cnt_1300 -->
		</div><!-- contetns -->
	</div><!-- container	 -->
	<!-- footer -->
	<c:import url="../top_main/top_main_footer.jsp"></c:import>
	<!-- //footer -->
</div><!-- //wrapper -->				
</body>
</html>