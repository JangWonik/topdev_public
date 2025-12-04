<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/ne_js/ne_number.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/><!-- calendar -->
	<script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
	<script src="./resources/ne_js/calendar.js"></script><!-- calendar -->
	<script src="./resources/wm_js/common.js"></script>
	
	<script defer src="./resources/fontawesome_5.0/svg-with-js/js/fontawesome-all.js"></script>
	
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>
	
	
	<script>
		$(document).ready(function(){
		});
	</script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	<style>
		.staffDeatilTable tr td{
			 letter-spacing: 0px;
			 height:25px; 
		}
		
		.ui-button-text-only {
			height:2.1em !important;
		}
		
	</style>
</head>
<body>
	<!-- header --><!--2016.01.14.rjh.수정.교체.-->
	<div id="headerpop_mbr">
		<div class="inner clear_v2">
			<h1>
				<img src="./resources/wm_img/common/logo.gif" height="40" alt="top - TRUST OBLIGATION PASSION" />
			</h1>
			<div style="text-align:center;padding-top:10px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
				<font color="white"><b><span style="font-size:11pt;">직 원 상 세</span></b></font>
			</div>
		</div>
	</div>
	<!-- //header -->
	
	<!-- center -->
	<div id ="container" style="height: 100% !important; width:860px; overflow-Y:hidden;">
		<div class="contetnsPop" style="width: 830px;">
			<div class="center_cnt" style="width: 830px;" >
				<div class="centercnt_bot1-3" style="width:830px; height:630px;">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">사원 정보</a></li>
							</ul>
						</div>
						<form action="./popMbrDetail" name="popMbrDetail" method="get">
							<input type="hidden" name="user_no" id="user_no" value="${memberVo.user_no}" />
						</form>
						
						<!-- 사원 정보 컨텐츠 탭 -->	
							<div class= "tableStyle5" style="padding-top:5px;">
								<table class="staffDeatilTable" style="float:left; width:100% !important;" border="0" cellpadding="0" cellspacing="0">
									<colgroup>
										<col style="width:10%;" />
										<col style="width:25%;" />
										<col style="width:10%;" />
										<col style="width:25%;" />
										<col style="width:30%;" />										
									</colgroup>
									<tr>
										<td class="tdHead" bgcolor="#efefef">이름</td>
										<td style="text-align:left; padding-left:10px;"><span>${memberVo.user_name}</span></td>
										<td class="tdHead" bgcolor="#efefef">상태</td>
										<td style="text-align:left; padding-left:10px;"><span>${memberVo.user_state}</span></td>
										<td rowspan="8" style="text-align: center;" >
											<img id="myimage" src="${imageBase64}"  width="140" height="175" alt="사원사진" /> 
										</td>
									</tr>									
									<tr>
										<td class="tdHead" bgcolor="#efefef">직위</td>
										<td style="text-align:left; padding-left:10px;"><span>${memberVo.work_level}</span></td>
										<td class="tdHead" bgcolor="#efefef">주민번호</td>
										<td style="text-align:left; padding-left:10px;"><span>${memberVo.jumin_no1}</span> - <span>${memberVo.jumin_no2}</span></td>
									</tr>
									<tr>
										<td class="tdHead" bgcolor="#efefef">센터명</td>
										<td style="text-align:left; padding-left:10px;">${memberVo.center_name}</td>
										<td class="tdHead" bgcolor="#efefef">부서명</td>
										<td style="text-align:left; padding-left:10px;">${memberVo.team_name}</td>
									</tr>
									<tr>
										<td class = "tdHead" bgcolor="#efefef">이메일</td>
										<td style="text-align:left; padding-left:10px;">${memberVo.email}</td>
										<td class = "tdHead" bgcolor="#efefef">직급</td>
										<td style="text-align:left; padding-left:10px;">${memberVo.work_rank}</td>
									</tr>
									<tr>
										<td class = "tdHead" bgcolor="#efefef">입사일자</td>
										<td style="text-align:left; padding-left:10px;">${memberVo.join_date}</td>
										<td class = "tdHead" bgcolor="#efefef">직책</td>
										<td style="text-align:left; padding-left:10px;">${memberVo.work_type}</td>
									</tr>
									<tr>										
										<td class = "tdHead" bgcolor="#efefef">퇴사일자</td>
										<td style="text-align:left; padding-left:10px;">${memberVo.out_date}</td>
										<td class = "tdHead" bgcolor="#efefef">직무</td>
										<td style="text-align:left; padding-left:10px;">${memberVo.work_job}</td>
									</tr>									
									<tr>										
										<td class = "tdHead" bgcolor="#efefef">면수습일자</td>
										<td style="text-align:left; padding-left:10px;">${memberVo.probation_date}</td>
										<td class = "tdHead" bgcolor="#efefef">직무코드</td>
										<td style="text-align:left; padding-left:10px;">${memberVo.work_job_code}</td>
									</tr>
									<tr>
										<td class = "tdHead"  bgcolor="#efefef">자택번호</td>
										<td style="text-align:left; padding-left:10px;">${memberVo.home_tel}</td>
										<td class = "tdHead"  bgcolor="#efefef">직통번호</td>
										<td style="text-align:left; padding-left:10px;">${memberVo.office_tel}</td>
									</tr>									
									<tr>
										<td class = "tdHead" bgcolor="#efefef">핸드폰</td>
										<td style="text-align:left; padding-left:10px;">${memberVo.handphone}</td>
										<td class = "tdHead"  bgcolor="#efefef">팩스번호</td>
										<td style="text-align:left; padding-left:10px;" colspan="2">${memberVo.office_fax}</td>																														 
									</tr>									
									<tr>
										<td class = "tdHead" bgcolor="#efefef">주소</td>
										<td style="text-align:left; padding-left:10px;" colspan="4">
											${memberVo.home_address}
										</td>
									</tr>
								</table>
							</div>							
							<div class= "tableStyle5">
								<table class="staffDeatilTable" style="float:left; width:100% !important;">
									<tr>
										<td class = "tdHead" bgcolor="#efefef" colspan="5">휴직정보</td>
									</tr>
									<tr>
										<td class = "tdHead" bgcolor="#efefef">휴직시작일</td>
										<td class = "tdHead" bgcolor="#efefef">휴직종료일</td>
										<td class = "tdHead" bgcolor="#efefef">휴직일수</td>
										<td class = "tdHead" bgcolor="#efefef">휴직유형</td>
										<td class = "tdHead" bgcolor="#efefef">휴직사유</td>
									</tr>									
									<c:forEach items="${workList}" var = "workVo">
										<tr>											
											<td style="text-align:center;">${workVo.work_sdate_fmt}</td>
											<td style="text-align:center;">${workVo.work_edate_fmt}</td>
											<td style="text-align:center;">${workVo.leave_interval}</td>											
											<td style="text-align:center;">${workVo.leave_type_val}</td>
											<td style="text-align:left;padding-left:10px;">${workVo.work_comment}</td>																			 
										</tr>										
									</c:forEach>
								</table>
							</div><!-- //tableStyle5 -->								
					</div><!-- //guest -->
				</div><!-- //bot1-3 -->
			</div>
		</div>
	</div>
	<!--//center -->

	<!-- footer -->
<%-- 	<c:import url="../top_main/top_pop_footer.jsp"></c:import> --%>
	<!-- //footer -->
	
<script type="text/javascript">

</script>

</body>
