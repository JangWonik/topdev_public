<%@ page	language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css">
	<!--<link rel="stylesheet" type="text/css" href="./resources/ne_css/style2.css">-->
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/><!-- calendar -->
	<script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
	<script src="./resources/ne_js/calendar.js"></script><!-- calendar -->
	<script src="./resources/wm_js/common.js"></script>
<style>
	.buttonMenuSalary{
		width:275px;
		height:30px;
	    /* background-color:#2E7EE8; */
	    background-color:#21610B;
	    color:#FFFFFF;
	    text-align: center;
		border-radius:5px;
	    font-size: 14px;
	    font-weight:bold;
	    cursor: pointer;
	    text-decoration:none;
	    border: none;
	    }
	.buttonMenuSalary:hover{		
		background-color:#01DFD7;
	}
</style>
<script>
	$(document).ready(function(){
		//급여관리 메인호출 완료
		//alert("ready");
	});
</script>
</head>
<body>
<!-- wrapper -->
<div id="wrapper">

	<!-- header -->	
	<c:import url="../top_salary_4/salary_menu.jsp"></c:import>
	<!-- //header -->
	<!-- contents -->
	<div id="container">
		<div class="contetns">
		<!-- centercnt_top -->			
			<div class="center_cnt_vacation" >					
				<table border="1">
					<tr>
						<td width="288px;" height="400px;">
							<!-- 1번 섹션-->
							<table>
								<tr>
									<td>
										<!-- 시작 -->
										<div class="centercnt_top"><!-- centercnt_top -->
										<table>
											<tbody>
											<tr>
												<td>
													<div class="nociteA nocite" style="height: 400px;width: 286px;">
														<div class="notice" style="height: 35px;width: 286px;padding:10px 5px 0 5px;">
															<input class="buttonMenuSalary" type="button" value="급여 통합조회" onclick="javascript:doMasterList();"/>														
														</div>																											
														<div class="notice" style="height: 35px;width: 286px;padding:5px 5px 0 5px;">
															<input class="buttonMenuSalary" type="button" value="기본급 및 직무설정" onclick="javascript:doMemberList();"/>														
														</div>
														<div class="notice" style="height: 35px;width: 286px;padding:5px 5px 0 5px;">
															<input class="buttonMenuSalary" type="button" value="월별 실적등록" onclick="javascript:doSalesRegist();"/>														
														</div>
														<div class="notice" style="height: 35px;width: 286px;padding:5px 5px 0 5px;">
															<input class="buttonMenuSalary" type="button" value="기본급 환경설정" onclick="javascript:doSalarySetup();"/>
														</div>
														<div class="notice" style="height: 35px;width: 286px;padding:5px 5px 0 5px;">
															<input class="buttonMenuSalary" type="button" value="성과급 환경설정" onclick="javascript:doSalaryIncentiveSetup();"/>
														</div>
													</div>
												</td>
											</tr>						
										</tbody>
										</table>
									</div>
										<!-- 끝 -->
									</td>
								</tr>
							</table>	
						</td>
						<td width="990px;" height="400px;">
							<table>
								<tr>
									<td>
										<!-- 시작 -->
										<div class="centercnt_top"><!-- centercnt_top -->
											<table>
												<tbody><tr>
													<td>
														<div id="summary_zone">급여관리 요약 정보 부분</div>														
													</td>
												</tr>						
											</tbody>
											</table>
										</div>
										<!-- 끝 -->
									</td>
								</tr>
							</table>
						</td>
					</tr>										
				</table>
				<table border="1">
					<tr>
						<td height="450px;">
							<table>
								<tr>
									<td>
										<!-- 시작 -->
										<div class="centercnt_top">
											월간 급여정보 요약
										</div>
									</td>
								</tr>
							</table>
						</td>
						<td>
							<table>
								<tr>
									<td>
										<!-- 시작 -->
										<div class="centercnt_top">
											년간 급여정보 요약
										</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- //contents -->
</div>
<!-- //wrapper -->
</body>
</html>