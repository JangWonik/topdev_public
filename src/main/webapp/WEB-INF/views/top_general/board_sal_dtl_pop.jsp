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
			
		    $('form input').keydown(function(e) {
			    if (e.keyCode == 13) {
			        $("#salAprvBtn").click();
			    }
			});
			
		    
			$("#salAprvBtn").click(function(){
				var sal_amt = $("#sal_amt").val();
				var r = confirm("2017년도 ${kind1MemDetail.user_name}의 최종연봉은 " +sal_amt+ " 만원 입니다.\n최종 승인 하시겠습니까?");
				if (!r){
					return false;
				}
				document.Kind1SalForm.submit();
				window.close();
				window.opener.location.reload();
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
	<div id="headerpop_mbr">
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
				<div class="centercnt_bot1-3" style="width:1000px;">
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
							<input type="hidden" id="user_no" name="user_no" value="${kind1MemDetail.user_no}"/>
							<input type="hidden" id="reg_user_no" name="reg_user_no" value="${mbrVo_Session.user_no}"/>
							<input type="hidden" id="sal_amt_flag" name="sal_amt_flag" value="${kind1MemDetail.sal_amt}"/>
							<input type="text" value="" style="display:none"/>
							
							<div style = "width:29%; float:right; text-align:center; ">
								<!-- 사원 이미지 -->
								<div style = "width:100%;  height:200px; margin-top:30px;">
									<img id="myimage" src="/home/hosting_users/toplac/www/ls_data/member/${kind1MemDetail.picture}"  width="120" height="150" alt="사원사진" />
								</div>
								<!-- 연봉 멘트 -->
								<div>
									<font size="4">
										<b> 
											${kind1MemDetail.user_name}님의 최종 연봉은  
											<br/> <input type="text" id="sal_amt" name="sal_amt" value="${kind1MemDetail.sal_amt}" size="5" maxlength="5" style="font-size:18px;"/> 만원 입니다. 
											<br/><br/> 
											<img src="./resources/ls_img/icon_write.gif" id="salAprvBtn" style = "cursor:pointer;"/>
										</b> 
									</font>
								</div>
							</div>	
						</form>
						<table style = "float:left;" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="20%" class = "tdHead" bgcolor="#efefef" height="25px">이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름</td>
								<td width="80%" colspan="5" style="text-align:left; padding-left:10px;">
									<span>${kind1MemDetail.user_name}</span>
								</td>
							</tr>
							
							<tr>
								<td width="20%" class = "tdHead" bgcolor="#efefef" height="25px">부&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;서&nbsp;</td>
								<td width="80%" colspan="5" style="text-align:left; padding-left:10px;">
									<span>${kind1MemDetail.team_name}</span>
								</td>
							</tr>
							
							<tr>
								<td class = "tdHead" bgcolor="#efefef" height="25px">직&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;책&nbsp;/&nbsp;직&nbsp;&nbsp;위</td>
								<td colspan="5" style="text-align:left; padding-left:10px;">
										<span>${kind1MemDetail.work_type} / ${kind1MemDetail.work_level} </span>
								</td>
								
							</tr>
							<tr>
								<td class = "tdHead" bgcolor="#efefef" height="25px">입&nbsp;사&nbsp;일</td>
								<td colspan="5" style="text-align:left; padding-left:10px;">
									<span>${kind1MemDetail.join_date}</span>
								</td>
								
							</tr>
							<tr>
								<td class = "tdHead"  bgcolor="#efefef" height="25px">직통 전화번호&nbsp;</td>
								<td colspan="5" style="text-align:left; padding-left:10px;">
									<span>${kind1MemDetail.office_tel}</span>
								</td> 
							</tr>
							<tr>
								<td class = "tdHead" bgcolor="#efefef" height="25px">핸 드 폰&nbsp;</td>
								<td colspan="5" style="text-align:left; padding-left:10px;">
									<span>${kind1MemDetail.handphone}</span>	
								</td>
							</tr>
							<tr>
								<td class = "tdHead"  bgcolor="#efefef" height="25px">E - mail</td>
								<td colspan="5" style="text-align:left; padding-left:10px;">
									<span>${kind1MemDetail.email}</span>
								</td>
							</tr>
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
												<fmt:formatNumber value="${bef3YearVO.getReal_sales()/bef3YearVO.getTarget_sales()*100}" pattern="#"  type="number"/> %
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
							
							
							
							<tr align="center">
								<td class = "tdHead" bgcolor="#efefef">인사평가</td>
								<td colspan="5" style="text-align:left; padding-left:10px;">
									<textarea name="comment" id="comment" rows="4" cols="80" readonly="readonly"></textarea>
								</td>
							</tr>
<!-- 									<tr> -->
<!-- 										<td colspan="5" style = "border:0; text-align:center;"> -->
<!-- 											<img src="./resources/ne_img/btn_edite.gif" id="mbrInfoEdit" style = "cursor:pointer;"/> -->
<!-- 										</td> -->
<!-- 									</tr> -->
						</table>
						</div><!-- //tableStyle4 -->
						</div><!-- //guestcnt5 -->


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
