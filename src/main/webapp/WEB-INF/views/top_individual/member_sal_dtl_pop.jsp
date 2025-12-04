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
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	
	<script>
		$(document).ready(function(){
// 			if( "${mbrVo_Session.user_no}" != "6"){
// 				alert("잘못된 접근입니다");
// 				window.close();
// 				return;
// 			}
		    
			$("#salAprvBtn").click(function(){
				var sal_amt = $("#sal_amt").val();
				var r = confirm("2017년도 ${memberDtl.user_name}의 최종연봉은 " +sal_amt+ " 만원 입니다.\n최종 승인 하시겠습니까?");
				if (!r){
					return false;
				}
				document.Kind1SalForm.submit();
				window.close();
				window.opener.location.reload();
			});
			
			$("#cancelBtn").click(function(){
				window.close();
			});
			
			$("#confirmBtn").click(function(){
				var cw=screen.availWidth;
				var ch=screen.availHeight;
				var sw=1050; //띄울 창의 넓이
				var sh=800;  //띄울 창의 높이

				var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
				var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
				
				window.open('memberSalAprv','','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
				window.close();
			});
			
			$("#printBtn").click(function(){
				var cw=screen.availWidth;
				var ch=screen.availHeight;
				var sw=1050; //띄울 창의 넓이
				var sh=800;  //띄울 창의 높이

				var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
				var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
				
				window.open('memberSalAprv','','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
				window.close();
			});
			
		});
		
	</script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	<style>
		#initialPw {
			border:1x solid #ff0080;    /*---테두리 정의---*/
			background-Color:#ffe6f2;   /*--백그라운드 정의---*/
			font:12px 굴림;      /*--폰트 정의---*/
			font-weight:bold;   /*--폰트 굵기---*/
			color:#ff0080;    /*--폰트 색깔---*/
			width:130;height:30;  /*--버튼 크기---*/
			margin-left:10px;
		}
	</style>
</head>

<body>
	<!-- header --><!--2016.01.14.rjh.수정.교체.-->
	<div id="headerpop_mbr" style="width:800px;">
		<div class="inner clear_v2">
			<h1>
				<img src="./resources/wm_img/common/logo.gif" height="40" alt="top - TRUST OBLIGATION PASSION" />
			</h1>
			<div style="text-align:center;padding-top:10px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
				<font color="white"><b><span style="font-size:11pt;"> 연 봉 관 리</span></b></font>
			</div>
		</div>
	</div>
	<!-- //header -->
	
	<!-- center -->
	<div id ="container">
		<div class="contetnsPop">
			<div class="center_cnt">
				<div class="centercnt_bot1-3" style="width:800px;">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">사원 정보</a></li>
							</ul>
						</div>
						
						<!-- 사원 정보 컨텐츠 탭 -->
						<div class="guestcnt5" style="display:block;">
						<div class= "tableStyle5">
						<form id = "Kind1SalForm" name="Kind1SalForm" method="post" action="salaryAprv"> 
							<input type="hidden" id="user_no" name="user_no" value="${memberDtl.user_no}"/>
							<input type="hidden" id="reg_user_no" name="reg_user_no" value="${mbrVo_Session.user_no}"/>
							<input type="hidden" id="sal_amt_flag" name="sal_amt_flag" value="${memberDtl.sal_amt}"/>
							<input type="text" value="" style="display:none"/>
						</form>
						
						<table style = "float:left; width:760px;" border="0" cellpadding="0" cellspacing="0" align="center">
							<tr>
								<td width="20%" class = "tdHead" bgcolor="#efefef" height="20px">이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름</td>
								<td width="50%" colspan="4" style="text-align:left; padding-left:10px;">
									<span>${memberDtl.user_name}</span>
								</td>
								<td width="20%" rowspan="8" style="text-align:center;">
									<img id="myimage" src="/home/hosting_users/toplac/www/ls_data/member/${memberDtl.picture}"  width="120" height="150" alt="사원사진" />
								</td>
							</tr>
							
							<tr>
								<td width="20%" class = "tdHead" bgcolor="#efefef" height="18px">부&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;서&nbsp;</td>
								<td width="60%" colspan="4" style="text-align:left; padding-left:10px;">
									<span>${memberDtl.team_name}</span>
								</td>
							</tr>
							
							<tr>
								<td class = "tdHead" bgcolor="#efefef" height="18px">직&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;책&nbsp;/&nbsp;직&nbsp;&nbsp;위</td>
								<td colspan="4" style="text-align:left; padding-left:10px;">
										<span>${memberDtl.work_type} / ${memberDtl.work_level} </span>
								</td>
								
							</tr>
							<tr>
								<td class = "tdHead" bgcolor="#efefef" height="18px">입&nbsp;사&nbsp;일</td>
								<td colspan="4" style="text-align:left; padding-left:10px;">
									<span>${memberDtl.join_date}</span>
								</td>
							</tr>
							<tr>
								<td class = "tdHead" bgcolor="#efefef" height="18px">주&nbsp;소</td>
								<td colspan="4" style="text-align:left; padding-left:10px;">
									<span>${memberDtl.home_address}</span>
								</td>
							</tr>
							
							
							<tr>
								<td class = "tdHead"  bgcolor="#efefef" height="18px">직통 전화번호&nbsp;</td>
								<td colspan="4" style="text-align:left; padding-left:10px;">
									<span>${memberDtl.office_tel}</span>
								</td> 
							</tr>
							<tr>
								<td class = "tdHead" bgcolor="#efefef" height="18px">핸 드 폰&nbsp;</td>
								<td colspan="4" style="text-align:left; padding-left:10px;">
									<span>${memberDtl.handphone}</span>	
								</td>
							</tr>
							<tr>
								<td class = "tdHead"  bgcolor="#efefef" height="18px">E - mail</td>
								<td colspan="4" style="text-align:left; padding-left:10px;">
									<span>${memberDtl.email}</span>
								</td>
							</tr>
							<tr>
								<td colspan="6">
									<table align="center">
										<tr>
											<th align="center">년도</th>
											<th align="center">목표금액</th>
											<th align="center">매출현황</th>
											<th align="center">달성률</th>
											<th align="center">연봉</th>
										</tr>
										
									<c:forEach items="${bef3YearSal}" var="bef3YearVO">
										<tr align="center">
											<!-- 년도 -->
											<td>
												${bef3YearVO.getYear()}년
											</td>
											<!-- 목표금액 -->
											<td>
												<c:choose>
													<c:when test="${bef3YearVO.getTarget_sales() ne null and bef3YearVO.getTarget_sales() ne '0' }">
														<fmt:formatNumber value="${bef3YearVO.getTarget_sales()}" type="number" /> 원
													</c:when>
													<c:otherwise>
														- 원
													</c:otherwise>
												</c:choose>
											</td>
											<!-- 매출현황 -->
											<td>
												<c:choose>
													<c:when test="${bef3YearVO.getReal_sales() ne null and bef3YearVO.getReal_sales() ne '0' }">
														<fmt:formatNumber value="${bef3YearVO.getReal_sales()}" type="number" /> 원
													</c:when>
													<c:otherwise>
														- 원
													</c:otherwise>
												</c:choose>
											</td>
											<!-- 달성률 -->
											<td>
												<c:choose>
													<c:when test="${bef3YearVO.getTarget_sales() eq null or bef3YearVO.getTarget_sales() eq '0' }">
														- %
													</c:when>
													<c:otherwise>
														<fmt:formatNumber value="${bef3YearVO.getReal_sales()/bef3YearVO.getTarget_sales()*100}" pattern="#.#"  type="number"/> %
													</c:otherwise>
												</c:choose>
											</td>
											<!-- 연봉 -->
											<td>
												<c:choose>
													<c:when test="${bef3YearVO.getSalary() ne null}">
														<fmt:formatNumber value="${bef3YearVO.getSalary()}" type="number" /> 원
													</c:when>
													<c:otherwise>
														- 원
													</c:otherwise>
												</c:choose>
											</td>
										</tr>
									</c:forEach>
										
									</table>
								</td>
							</tr>
							
							<tr>
								<td colspan="6">
									<center style="margin-top:10px;">
										<font size="3">
											<b> 
												탑손해사정 ${memberDtl.sal_year}년 ${memberDtl.user_name}님의 최종 연봉금액은  
												${memberDtl.sal_amt} 만원 입니다. 
												<br/>
												<font size="2">
												※상기 개인정보와 현 개인정보가 다를 시, My Menu에서 수정 부탁드립니다.
												</font>
												<br/>
												<c:choose>
													<c:when test="${memberDtl.sal_state eq 2}">
														<input type="button" id="printBtn" value="인쇄하기" style="margin:15px 0 15px;"/>
													</c:when>
													<c:otherwise>
														<input type="button" id="confirmBtn" value="연봉계약서 작성하기" />
														&nbsp;&nbsp;
														<input type="button" id="cancelBtn" value="나중에 작성하기" style="margin:15px 0 15px;"/>
													</c:otherwise>
												
												
												</c:choose>
													
											</b> 
										</font>
										<br/>
									</center>
								</td>
							</tr>
	
						</table>
						</div><!-- //tableStyle4 -->
						</div><!-- //guestcnt5 -->


					</div><!-- //guest -->
				</div><!-- //bot1-3 -->
			</div>
		</div>
	</div>
	<!--//center -->
</body>
