<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
			
		});
		
		function myInfoClose(){
			window.close();
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
				<font color="white"><b><span style="font-size:11pt;"> 인 사 관 리</span></b></font>
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
								<li class="on"><a href="#">직원 정보</a></li>
							</ul>
						</div>
						
						<div class="guestcnt2" style="display:block;">
							
						<div class= "tableStyle2">
							
							<%-- <div style = "width:29%; float:right; text-align:center; ">
								<div style = "width:100%;  height:250px; margin-top:30px;">
									<img id="myimage" src="${imageBase64}"  width="120" height="150" alt="사원사진" />
									<br /><br />
								</div>
							</div>	 --%>
							<table width="100%"  border="0" cellpadding="0" cellspacing="0">
							<c:set var="member_Dtl" value="${member_Dtl}" />
								<tr>
									<td width="20%" align="center" bgcolor="#efefef">센터명</td>
									<td width="50%" style="letter-spacing: 0px;"><span><c:out value="${member_Dtl.get(0).getCenter_name()}"/></span></td>
								</tr>								
								<tr>
									<td width="20%" align="center" bgcolor="#efefef">부서명</td>
									<td width="50%" style="letter-spacing: 0px;"><span><c:out value="${member_Dtl.get(0).getTeam_name()}"/></span></td>
									<td width="30%" align="center" rowspan="5">
										<img id="myimage" src="${imageBase64}"  width="120" height="150" alt="사원사진" />
										<%-- <%@include file="../include/uploadform.jsp"%> --%>
									</td>
								</tr>
								<!-- 180108 직급/직책 에서 직위/직급으로 변경 -->
								<tr>
									<td align="center" width="100" bgcolor="#efefef">직위</td>
									<td width="600" style="letter-spacing: 0px;"><span><c:out value="${member_Dtl.get(0).getWork_level()}"/></span></td>
								</tr>
								<tr>
									<td align="center" bgcolor="#efefef">직책</td>
									<td style="letter-spacing: 0px;"><span><c:out value="${member_Dtl.get(0).getWork_type()}"/></span></td>
								</tr>								
								<tr>
									<td align="center" bgcolor="#efefef">직급</td>									
									<td style="letter-spacing: 0px;"><span><c:out value="${member_Dtl.get(0).getWork_rank()}"/></span></td>
								</tr>
								<!-- 겸직표시 추가 -->
								<c:if test="${subJobList.size() > 0 }">
									<c:set var="rowCnt" value="${subJobList.size()}"/>									
									<c:forEach items="${subJobList}" var="subJob"  varStatus="status">
										<tr>
											<c:if test="${status.index == 0}">											
												<td align="center" bgcolor="#efefef" rowspan="${rowCnt}">겸직 부서 / 직책</td>
											</c:if>									
											<td style="letter-spacing: 0px;"><span><c:out value="${subJob.teamName}"/> / <c:out value="${subJob.workType}"/></span></td>
										</tr>
									</c:forEach>
								</c:if>
								<!-- 겸직표시 끝 -->
								<tr>
									<td align="center" bgcolor="#efefef">이름</td>
									<td style="letter-spacing: 0px;"><span><c:out value="${member_Dtl.get(0).getUser_name()}"/></span></td>
								</tr>
								<%-- <tr>
									<td align="center" bgcolor="#efefef">입사일</td>
									<td style="letter-spacing: 0px;"><span><c:out value="${member_Dtl.get(0).getJoin_date()}"/></span></td>
								</tr> --%>
								<tr>
									<td align="center" bgcolor="#efefef">휴대전화</td>
									<td style="letter-spacing: 0px;"><span><c:out value="${member_Dtl.get(0).getHandphone()}"/></span></td>
								</tr>
								<tr>
									<td align="center" bgcolor="#efefef">직통번호</td>
									<td style="letter-spacing: 0px;"><span><c:out value="${member_Dtl.get(0).getOffice_tel()}"/></span></td>
								</tr>
								<tr>
									<td align="center" bgcolor="#efefef">개인팩스</td>
									<td style="letter-spacing: 0px;"><span><c:out value="${member_Dtl.get(0).getOffice_fax()}"/></span></td>
								</tr>
								<tr>
									<td align="center" bgcolor="#efefef">E-mail</td>
									<td style="letter-spacing: 0px;"><span><c:out value="${member_Dtl.get(0).getEmail()}"/></span></td>
								</tr>
								<tr>
									<td align="center" bgcolor="#efefef">현재위치</td>
									<td style="letter-spacing: 0px;"><span><c:out value="${member_Dtl.get(0).getTeam_addr()}"/></span></td>
								</tr>
								
							</table>
					
							
					
										
							<div id= "button" style ="text-align:center;">	
								<br />
								<input type="image" src="./resources/ls_img/icon_close.gif" onclick="myInfoClose()"/>
							</div>
					
						</div><!-- //tableStyle2 -->
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
	<!--//center -->

	<!-- footer -->
	<c:import url="../top_main/top_pop_footer.jsp"></c:import>
	<!-- //footer -->
   
</body>