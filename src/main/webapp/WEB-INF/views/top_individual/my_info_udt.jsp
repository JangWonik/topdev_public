<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
			
			$.ajaxSetup({cache:false});
			$("#myInfoEdit").click(function(){
				$.post("./myInfoEdite",
						{	user_no:$("#user_no").val()
							,home_address:$("#home_address").val()
							,home_tel_1:$("#home_tel_1").val()
							,home_tel_2:$("#home_tel_2").val()
							,home_tel_3:$("#home_tel_3").val()
							,officetel_1:$("#officetel_1").val()
							,officetel_2:$("#officetel_2").val()
							,officetel_3:$("#officetel_3").val()
							,officefax_1:$("#officefax_1").val()
							,officefax_2:$("#officefax_2").val()
							,officefax_3:$("#officefax_3").val()
							,handphone_1:$("#handphone_1").val()
							,handphone_2:$("#handphone_2").val()
							,handphone_3:$("#handphone_3").val()
							,comment:$("#comment").val()
							,email_pwd:$("#email_pwd").val()
						},
						function(data,status){
							if(data == 1){
								alert("사원 정보 변경이 완료 되었습니다.");
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post

			});//click
			
			$("#myPwEdit").click(function(){
				

				if($("#toPw").val() != $("#toPwRe").val()){
					alert("변경할 비밀번호를 확인해주세요.");
					$("#toPw").focus();
					return;
				}
				
				if($("#toPw").val() == $("#pastPw").val()){
					alert("현재 비밀번호와 변경할 비밀번호가 동일합니다.");
					$("#toPw").focus();
					return;
				}
				
				/* if($("#toPw").val().lenght < 8 || $("#toPw").val().lenght > 10){
					alert("비밀번호는 8자리 이상 10자리 이하입니다.")
					$("#toPw").focus();
					return;
				}; */
				
				var check = /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{8,10}$/;
				
				if(!check.test($("#toPw").val())){
					alert("비밀번호는 8~10자리의 영문,숫자,특수문자의 조합으로 입력해주세요.")
					$("#toPw").focus();
					return;
				}
				
				var kin4Chk = false;
				
				kin4Chk = kin4($("#toPw").val(), 4);		//연속된 4글자가 있는지 체크한다.
				
				if( kin4Chk ){
					alert("변경 할 비밀번호에 연속된 4개의 문자 또는 숫자가 존재합니다.");
					return;
				}
				
				
				$.post("./myPwEdite",
						{	 user_no:"${user_no_Session}"
							,user_pwNow:$("#pastPw").val()
							,user_pwNew:$("#toPw").val()
						},
						function(data,status){
							if(data == 1){
								alert("비밀번호 변경이 완료 되었습니다.");
							}else if(data == 0) {
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}else if(data == 2) {
								alert("현재 비밀번호를 확인해주세요.");
							}else if(data == 3){
								alert("기존에 사용한 비밀번호입니다.\n(변경 2회전까지 사용했던 비밀번호를 확인합니다.)");
							}							
						}
				);//post
			});
			
			if("${fromPage}" == "login"){
				$("#editePwTab").click();
			}
			
			$("#chk_view").click(function(){
				if( $("#chk_view").val() == '보기' ){
					$("#email_pwd").attr("type","text");	
					$("#chk_view").val('가리기');
				}else{
					$("#email_pwd").attr("type","password");	
					$("#chk_view").val('보기');
				}
				
			});
			
		});//ready	
		
		//연속글자가 있으면 true, 없으면 false
		function kin4(str, max){
		    if(!max) max = 4; // 글자수를 지정하지 않으면 4로 지정
		    var i, j, k, x, y;
		    var buff = ["0123456789", "abcdefghijklmnopqrstuvwxyz", "ABCDEFGHIJKLMNOPQRSTUVWXYZ"];
		    var src, src2, ptn="";
		
		    for(i=0; i<buff.length; i++){
		        src = buff[i]; // 0123456789
		        src2 = buff[i] + buff[i]; // 01234567890123456789
		        for(j=0; j<src.length; j++){
		            x = src.substr(j, 1); // 0
		            y = src2.substr(j, max); // 0123
		            ptn += "["+x+"]{"+max+",}|"; // [0]{4,}|0123|[1]{4,}|1234|...
		            ptn += y+"|";
		        }
		    }
		    ptn = new RegExp(ptn.replace(/.$/, "")); // 맨마지막의 글자를 하나 없애고 정규식으로 만든다.
		    
		    if(ptn.test(str)) return true;
		    return false;
		}
	</script>
</head>

<body>

<!-- wrapper -->
<div id="wrapper">
	<!-- skipnavi --><!-- header -->
	<c:import url="../top_main/top_main_menu.jsp"></c:import>
	<!-- //skipnavi --><!-- //header -->

	<!-- contents -->
	<div id="container">
		<div class="contetns">

			<!-- left_cnt -->
			<c:import url="../top_main/top_main_left.jsp"></c:import>
			<!-- //left_cnt -->

			<!-- centercnt_top -->
			<div class="center_cnt">

				<!-- centercnt_bot -->
				<div class="centercnt_bot1-2">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">내 정보 수정</a></li>
								<li ><a href="#">인트라넷 비밀번호 변경</a></li>
								<!-- 신규조회기능 추가 by top3009 -->
								<li ><a href="#">발령, 진급 및 휴직,상/별</a></li>
								<li ><a href="#">경력 및 자격</a></li>
								<li ><a href="#">교육 및 강의이력</a></li>
								<li ><a href="#">학력 및 가족관계</a></li>
								<!-- 신규조회기능 추가 by top3009 -->
							</ul>
						</div>
						<div class="guestcnt4" style="display:block;">

							<div class= "tableStyle2">
								<table width="100%"  border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td width="20%" align="center" bgcolor="#efefef">이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름</td>
										<td width="50%"><span>${memberVo.user_name}</span></td>
										<td width="30%" align="center" rowspan="5">
											<img id="myimage" src="${imageBase64}"  width="120" height="150" alt="내사진" />
											<%@include file="../include/uploadform.jsp"%>
										</td>
									</tr>
									<tr>
										<td align="center" width="100" bgcolor="#efefef">아&nbsp;이&nbsp;디&nbsp;</td>
										<td width="600"><span>${memberVo.user_id}</span></td>
									</tr>
									<tr>
										<td align="center" bgcolor="#efefef">부&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;서&nbsp;</td>
										<td><span>${memberVo.team_name}</span></td>
									</tr>
									<tr>
										<td align="center" bgcolor="#efefef">직&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;책&nbsp;</td>
										<td><span>${memberVo.work_level}</span></td>
									</tr>
									<tr>
										<td align="center" bgcolor="#efefef">입&nbsp;사&nbsp;일&nbsp;</td>
										<td><span>${memberVo.join_date}</span></td>
									</tr>
								</table>
					
								<form id = "mbrDetailFrm" name = "mbrDetailFrm" method="post"> 
									<input type="hidden" name ="user_no" id ="user_no" value = "${memberVo.user_no}"/>
									<table  style ="margin-top:0px; border-top:0;" width="300"  border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td width="20%" bgcolor="#efefef">주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소&nbsp;</td>
											<td width="80%" style="text-align:left; padding-left:10px;">
												<input type="text" name="home_address" id="home_address" size="70" value ="${memberVo.home_address}">
												<span></span>
											</td>
										</tr>
										<tr>
											<td align="center" bgcolor="#efefef">자택 전화번호&nbsp;</td>
											<td style="text-align:left; padding-left:10px;">
												<input type="text" name="home_tel_1" id="home_tel_1" size="5" maxlength="4" value ="${home_tel_1}">
												-
												<input type="text" name="home_tel_2" id="home_tel_2" size="5" maxlength="4" value ="${home_tel_2}">
												-
												<input type="text" name="home_tel_3" id="home_tel_3" size="5" maxlength="4" value ="${home_tel_3}"> 
											</td>
										</tr>
										<tr>
											<td align="center" bgcolor="#efefef">직통 전화번호&nbsp;</td>
											<td style="text-align:left; padding-left:10px;">
												<input type="text" name="officetel_1" id="officetel_1" size="5" maxlength="4" value = "${officetel_1}">
												-
												<input type="text" name="officetel_2" id="officetel_2" size="5" maxlength="4" value = "${officetel_2}">
												-
												<input type="text" name="officetel_3" id="officetel_3" size="5" maxlength="4" value = "${officetel_3}"> 
											</td> 
										</tr>
										<tr>
											<td align="center" bgcolor="#efefef">팩스번호&nbsp;</td>
											<td style="text-align:left; padding-left:10px;">
												<input type="text" name="officefax_1" id="officefax_1" size="5" maxlength="4" value = "${officefax_1}">
												-
												<input type="text" name="officefax_2" id="officefax_2" size="5" maxlength="4" value = "${officefax_2}">
												-
												<input type="text" name="officefax_3" id="officefax_3" size="5" maxlength="4" value = "${officefax_3}"> 
											</td> 
										</tr>
										<tr>
											<td align="center" bgcolor="#efefef">핸 드 폰&nbsp;</td>
											<td style="text-align:left; padding-left:10px;">
												<input type="text" name="handphone_1" id="handphone_1" size="5" maxlength="4" value ="${handphone_1}" >
												-
												<input type="text" name="handphone_2" id="handphone_2" size="5" maxlength="4" value = "${handphone_2}">
												-
												<input type="text" name="handphone_3" id="handphone_3" size="5" maxlength="4" value = "${handphone_3}"> 
											</td>
										</tr>
										<tr>
											<td align="center" bgcolor="#efefef">E - mail</td>
											<td style="text-align:left; padding-left:10px;"><span>${memberVo.email}</span></td>
										</tr>										
										<tr>
											<td align="center" bgcolor="#efefef">TOPMAIL 비밀번호</td>
											<td style="text-align:left; padding-left:10px;">
											<input type="password" id="email_pwd" name="email_pwd" value="${email_pwd}">&nbsp;<input type="button" id="chk_view" value="보기" /> &nbsp;
											<font color="blue"><b>※TOPMAIL 에서 사용하는 비밀번로와 일치해야 로그인 연동 사용이 가능합니다.</b></font>
											</td>
										</tr>
										<tr>
											<td align="center" bgcolor="#efefef">자기소개</td>
											<td style="text-align:left; padding-left:10px;">
												<textarea name="comment" id="comment" rows="4" cols="80">${memberVo.comment}</textarea>
											</td>
										</tr>
									</table>
								</form>

								<table>
									<tr>
										<td width="20%" align="center" bgcolor="#efefef">도장 및 사인</td>
										<td style="text-align:left; padding-left:10px;">
											<%@include file="../include/uploadform_sign.jsp"%>
										</td>
									</tr>
									<tr>
										<td width="20%" align="center" bgcolor="#efefef">MMS 이미지<br>(220 X 180)</td>
										<td style="text-align:left; padding-left:10px;">
											<c:import url="../include/uploadform_mms.jsp"/>
											<%--<%@include file="../include/uploadform_sign.jsp"%>--%>
										</td>
									</tr>
								</table>

								<div id= "button" style ="text-align:center;">	
									<br />
									<input type="image" src="./resources/ne_img/btn_edite.gif" id="myInfoEdit"/>
								</div>

							</div><!-- //tableStyle2 -->

						</div><!-- //guestcnt4 -->
						<div class="guestcnt4" style="display:none;">
							<div class= "tableStyle2">
								<table >
									<tbody>
										<tr>
											<td bgcolor="#eaeaea">현재 비밀번호</td>
											<td >
												<input type="password" id = "pastPw" size="50" style="ime-mode:disabled;"/>
											</td>
										</tr>
										<tr>
											<td bgcolor="#eaeaea">변경할 비밀번호</td>
											<td>
												<input type="password" id = "toPw" size="50" style="ime-mode:disabled;"/>
											</td>
										</tr>
										<tr>
											<td bgcolor="#eaeaea">변경할 비밀번호 확인</td>
											<td>
												<input type="password" id = "toPwRe" size="50" style="ime-mode:disabled;"/>
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<img src="./resources/ne_img/btn_edite.gif" id="myPwEdit" style="cursor:pointer;"/>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<!-- 발령 , 진급 및 휴직 시작-->
						<div class="guestcnt4" style="display:none;">
							<div class= "tableStyle2">
								<!-- 발령사항 -->							
								<table>									
									<tr>
										<th colspan="8">
											발령사항
										</th>
									</tr>										
									<tr>
										<th>발령일자</th>
										<th>부서</th>
										<th>직위</th>
										<th>직급</th>
										<th>직책</th>
										<th>직무</th>
										<th>근무지</th>
										<th>발령내용</th>
										<!-- <th>비고</th>	 -->										
									</tr>														 
									<c:forEach items="${getMbrAppoint}" var="item" varStatus="status">
										<tr id="appoint_view_${item.appoint_no}">
											<td style="letter-spacing: 0px;">${item.appoint_date}</td> <!-- 발령일자 -->
											<td>${item.appoint_depart}</td>		<!-- 부서 -->
											<td>${item.appoint_work_level}</td>		<!-- 직위 -->
											<td style="letter-spacing: 0;">${item.appoint_work_rank}</td>		<!-- 직급 -->
											<td>${item.appoint_work_type}</td>		<!-- 직책 -->
											<td>${item.appoint_work_job}</td>	<!-- 직무 -->
											<td>${item.appoint_place}</td>		<!-- 근무지 -->
											<td>${item.appoint_comment}</td>	<!-- 발령내용 -->
											<%-- <td>${item.appoint_etc}</td>		<!-- 비고 --> --%>												
										</tr>
									</c:forEach>
								</table>
								<br/>
								<!-- 진급사항 -->
								<table>									
									<tr>
										<th colspan="7">
											진급사항
										</th>
									</tr>
									
									<tr>
										<th>발령일자</th>
										<th>부서</th>
										<th>직위</th>
										<th>직급	</th>
										<th>직책</th>
										<th>근무지</th>
										<th>발령내용</th>
										<!-- <th>비고</th> -->											
									</tr>									 
									<c:forEach items="${getMbrPosition}" var="item" varStatus="status">
										<tr id="position_view_${item.position_no}">
											<td style="letter-spacing: 0px;">${item.position_date}</td> <!-- 발령일자 -->
											<td>${item.position_depart}</td>		<!-- 부서 -->
											<td>${item.position_work_level}</td>		<!-- 직위 -->
											<td style="letter-spacing: 0px;">${item.position_work_rank}</td>		<!-- 직급 -->
											<td>${item.position_work_type}</td>		<!-- 직책 -->
											<td>${item.position_place}</td>		<!-- 근무지 -->
											<td>${item.position_comment}</td>	<!-- 발령내용 -->
											<%-- <td>${item.position_etc}</td>		<!-- 비고 --> --%>												
										</tr>
									</c:forEach>
								</table>
								<br/>
								
								<!-- 휴직사항 -->
								<table>
									<colgroup>
										<col width="20%">
										<col width="15%">
										<col width="10%">
										<col width="15%">
										<col width="10%">
										<col width="10%">
										<col width="20%">
									</colgroup>
									<tr>
										<th colspan="7">
											휴직사항
										</th>
									</tr>
									
									<tr>
										<th>휴직기간</th>
										<th>부서</th>
										<th>직위</th>
										<th>휴직유형</th>
										<th>휴직일수</th>
										<th>소정근로일수</th>
										<th>사유</th>
										<!-- <th>비고</th> -->						
									</tr>
									 
									<c:forEach items="${getMbrWork}" var="item" varStatus="status">
										<tr id="work_view_${item.work_no}">
											<td style="letter-spacing: 0px;">
											${item.work_sdate_fmt} ~
											<c:choose>
												<c:when test="${empty item.work_edate_fmt}">오늘까지</c:when>
												<c:otherwise>${item.work_edate_fmt}</c:otherwise>
											</c:choose>
											</td> 
											<!-- 휴복직 일자 -->
											<td>${item.work_team_id_val}</td>		<!-- 부서 -->
											<td>${item.work_level_val}</td>		<!-- 직위 -->
											<td>${item.leave_type_val}</td>		<!-- 휴직유형 -->
											<td>${item.leave_interval} 일</td>		<!-- 휴직일수 -->
											<td>${item.work_interval} 일</td>		<!-- 휴직일수 -->
											<td>${item.work_comment}</td>		<!-- 사유 -->						
											<%-- <td>${item.work_etc}</td>		<!-- 비고 --> --%>
											<!-- 버튼 -->												
										</tr>
									</c:forEach>
								</table>
								<br/>								
								<!-- 상/벌 사항 시작 -->
								<table>
									<colgroup>
										<col width="10%">
										<col width="10%">
										<col width="15%">
										<col width="10%">
										<col width="30%">
										<col width="25%">					
									</colgroup>
									<thead>
									<tr>
										<th colspan="6">상/벌사항</th>
									</tr>
									<tr>
										<th>상/벌 유형</th>
										<th>상/벌 일자</th>
										<th>부서</th>
										<th>직위</th>										
										<th>상/벌 내용</th>
										<th>첨부파일</th>										
									</tr>
									<c:forEach items="${getAwardList}" var="award" varStatus="status">
										<tr>
											<td>
												<c:if test="${award.award_flag eq 1}">상</c:if>
												<c:if test="${award.award_flag eq 2}">벌</c:if>
											</td>
											<td style="letter-spacing: 0px;">${award.award_date_fmt}</td>
											<td>${award.team_name}</td>
											<td>${award.work_level_nm}</td>											
											<td style="text-align:left;padding-left:10px;">${award.award_content}</td>
											<td>
												<c:choose>
													<c:when test="${empty award.award_org_file}"> - </c:when>
													<c:otherwise>
														<a href="/awardFileDown?akey=${award.akey}">${award.award_org_file}&nbsp;<img src='./resources/ls_img/icon_disket.gif'/></a>
													</c:otherwise>
												</c:choose>
											</td>											
										</tr>
									</c:forEach>
								</table>
								<!-- 상/벌 사항 끝 -->
							</div>
						</div>
						<!-- 발령 , 진급 및 휴직 끝-->
						
						<!-- 경력 및 자격-->
						<div class="guestcnt4" style="display:none;">
							<div class= "tableStyle2">
								<!-- 경력사항(보험) -->
								<table>
									<colgroup>
										<col width="23%">
										<col width="17%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="15%">
										<col width="5%">
									</colgroup>
									<thead>
										<tr>
											<th colspan="7">경력사항(보험)</th>
										</tr>
										<tr>
											<th rowspan="2">회사명</th>
											<th rowspan="2">부서</th>
											<th rowspan="2">직위</th>
											<th colspan="2">근무기간</th>
											<th rowspan="2">근속년수</th>
											<th rowspan="2">담당업무</th>											
										</tr>
										<tr>
											<th>입사일자</th>
											<th>퇴사일자</th>
										</tr>
										<c:forEach items="${getMbrCareer}" var="items" varStatus="status">
											<tr>
												<td>${items.getCareer_corporate_name()}</td>
												<td>${items.getCareer_depart()}"</td>
												<td>${items.getCareer_rank()}</td>
												<td>${items.getCareer_start_date()}</td>
												<td>${items.getCareer_end_date()}</td>
												<td>
													${items.getCareer_year()} 년&nbsp;
													${items.getCareer_month()} 개월
												</td>
												<td>${items.getCareer_work()}</td>												
											</tr>
										</c:forEach>										
										<tr>
											<th colspan="5">근속누계</th>
											<td>
												<c:out value="${getMbrCareerSum.getCareer_year_sum()}"/> 년&nbsp;
												<c:out value="${getMbrCareerSum.getCareer_month_sum()}"/> 개월
											</td>
											<td></td>											
										</tr>
									</thead>
								</table>
								<br/>
								
								<!-- 경력사항(신설) -->
								<table>
									<colgroup>
										<col width="23%">
										<col width="17%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="15%">										
									</colgroup>
									<thead>
										<tr>
											<th colspan="7">경력사항(건설)</th>
										</tr>
										<tr>
											<th rowspan="2">회사명</th>
											<th rowspan="2">부서</th>
											<th rowspan="2">직위</th>
											<th colspan="2">근무기간</th>
											<th rowspan="2">근속년수</th>
											<th rowspan="2">담당업무</th>											
										</tr>
										<tr>
											<th>입사일자</th>
											<th>퇴사일자</th>
										</tr>
										<c:forEach items="${getMbrCareerCst}" var="items" varStatus="status">
											<tr>
												<td>${items.getCareer_corporate_name()}</td>
												<td>${items.getCareer_depart()}</td>
												<td>${items.getCareer_rank()}</td>
												<td>${items.getCareer_start_date()}</td>
												<td>${items.getCareer_end_date()}</td>
												<td>
													${items.getCareer_year()} 년&nbsp;
													${items.getCareer_month()} 개월
												</td>
												<td>${items.getCareer_work()}</td>												
											</tr>
										</c:forEach>										
										<tr>
											<th colspan="5">근속누계</th>
											<td>
												<c:out value="${getMbrCareerConstructSum.getCareer_year_sum()}"/> 년&nbsp;
												<c:out value="${getMbrCareerConstructSum.getCareer_month_sum()}"/> 개월
											</td>
											<td></td>											
										</tr>
									</thead>
								</table>
								<br/>
								
								<!-- 경력사항(일반) -->
								<table>
									<colgroup>
										<col width="23%">
										<col width="17%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="15%">										
									</colgroup>
									<thead>
										<tr>
											<th colspan="7">경력사항(일반)</th>
										</tr>
										<tr>
											<th rowspan="2">회사명</th>
											<th rowspan="2">부서</th>
											<th rowspan="2">직위</th>
											<th colspan="2">근무기간</th>
											<th rowspan="2">근속년수</th>
											<th rowspan="2">담당업무</th>											
										</tr>
										<tr>
											<th>입사일자</th>
											<th>퇴사일자</th>
										</tr>
										<c:forEach items="${getMbrCareerGnl}" var="items" varStatus="status">
											<tr>
												<td>${items.getCareer_corporate_name()}</td>
												<td>${items.getCareer_depart()}</td>
												<td>${items.getCareer_rank()}</td>
												<td>${items.getCareer_start_date()}</td>
												<td>${items.getCareer_end_date()}</td>
												<td>
													${items.getCareer_year()} 년&nbsp;
													${items.getCareer_month()} 개월
												</td>
												<td>${items.getCareer_work()}</td>												
											</tr>
										</c:forEach>										
										<tr>
											<th colspan="5">근속누계</th>
											<td>
												<c:out value="${getMbrCareerGeneralSum.getCareer_year_sum()}"/> 년&nbsp;
												<c:out value="${getMbrCareerGeneralSum.getCareer_month_sum()}"/> 개월
											</td>
											<td></td>																
										</tr>
										<tr>
											<th colspan="5">총근속누계</th>
											<td>
												<c:choose>
												<c:when test="${getMbrCareerSum.getCareer_month_sum() + getMbrCareerConstructSum.getCareer_month_sum() + getMbrCareerGeneralSum.getCareer_month_sum() > 23 }">
												${getMbrCareerSum.getCareer_year_sum()+ getMbrCareerConstructSum.getCareer_year_sum() + getMbrCareerGeneralSum.getCareer_year_sum()+2}년&nbsp;
												${getMbrCareerSum.getCareer_month_sum() + getMbrCareerConstructSum.getCareer_month_sum() + getMbrCareerGeneralSum.getCareer_month_sum()-24 }개월
												</c:when>
												<c:when test="${getMbrCareerSum.getCareer_month_sum() + getMbrCareerConstructSum.getCareer_month_sum() + getMbrCareerGeneralSum.getCareer_month_sum() > 11 }">
												${getMbrCareerSum.getCareer_year_sum()+ getMbrCareerConstructSum.getCareer_year_sum() + getMbrCareerGeneralSum.getCareer_year_sum()+1}년&nbsp;
												${getMbrCareerSum.getCareer_month_sum() + getMbrCareerConstructSum.getCareer_month_sum() + getMbrCareerGeneralSum.getCareer_month_sum()-12 }개월						
												</c:when>
												<c:otherwise>
												${getMbrCareerSum.getCareer_year_sum()+ getMbrCareerConstructSum.getCareer_year_sum() + getMbrCareerGeneralSum.getCareer_year_sum()}년&nbsp;
												${getMbrCareerSum.getCareer_month_sum() + getMbrCareerConstructSum.getCareer_month_sum() + getMbrCareerGeneralSum.getCareer_month_sum()}개월
												</c:otherwise>
												</c:choose>
											</td>
											<td></td>
										</tr>
									</thead>
								</table>
								<br/>
								
								<!-- 자격사항 -->
								<table>
									<colgroup>
										<col width="27%">
										<col width="12%">
										<col width="20%">
										<col width="20%">
										<col width="15%">										
									</colgroup>
									<thead>
										<tr>
											<th colspan="5"><b>자격사항</b></th>
										</tr>
										<tr>
											<th>자격면허 명칭</th>
											<th>취득일</th>
											<th>등록번호</th>
											<th>발행기관</th>
											<th>비고</th>											
										</tr>
										<c:forEach items="${getMbrLicense}" var="getMbrLicense" varStatus="status">
											<tr>
												<td>${getMbrLicense.getLicense_name()}</td>
												<td>${getMbrLicense.getLicense_acquire_date()}</td>
												<td>${getMbrLicense.getLicense_register_no()}</td>
												<td>${getMbrLicense.getLicense_publishing_office()}</td>
												<td>${getMbrLicense.getLicense_etc()}</td>												
											</tr>
										</c:forEach>										
									</thead>
								</table>								
							</div>
						</div>
						
						<!-- 교육 및 강의이력-->
						<div class="guestcnt4" style="display:none;">
							<div class= "tableStyle2">
								<!-- 교육사항 -->
								<table>
									<colgroup>
											<col width="10%">
											<col width="23%">
											<col width="20%">
											<col width="20%">
											<col width="10%">
											<col width="12%">											
									</colgroup>
									<thead>
										<tr>
											<th colspan="6">교육사항</th>
										</tr>
										<tr>
											<th>교육구분</th>
											<th>교육과정명</th>
											<th>교육기관</th>
											<th>교육기간</th>
											<th>교육비용</th>
											<th>비고</th>											
										</tr>
										<c:forEach items="${getMbrEducation}" var="getMbrEducation" varStatus="status">
											<tr>
												<td>${getMbrEducation.getEducation_gubun()}</td>
												<td>${getMbrEducation.getEducation_name()}</td>
												<td>${getMbrEducation.getEducation_office()}</td>
												<td>${getMbrEducation.getEducation_start_date()} ~ ${getMbrEducation.getEducation_end_date()}</td>
												<td><fmt:formatNumber value="${getMbrEducation.getEducation_price()}" pattern="###,###,##0.##"/> 원</td>
												<td>${getMbrEducation.getEducation_etc()}</td>												
											</tr>
										</c:forEach>										
									</thead>
								</table>
								<br/>
								
								<!-- 교육사항 -->
								<table>
									<colgroup>
										<col width="30%">
										<col width="20%">
										<col width="20%">
										<col width="10%">
										<col width="20%">										
									</colgroup>
									<thead>
										<tr>
											<th colspan="5"><b>강의이력</b></th>
										</tr>
										<tr>
											<th>교육과정명</th>
											<th>교육기관</th>
											<th>교육기간</th>
											<th>교육시간</th>
											<th>비고</th>											
										</tr>
										<c:forEach items="${getMbrClass}" var="getMbrClass" varStatus="status">
											<tr>
												<td>${getMbrClass.getClass_name()}</td>
												<td>${getMbrClass.getClass_office()}</td>
												<td>${getMbrClass.getClass_start_date()} ~ ${getMbrClass.getClass_end_date()}</td>
												<td>${getMbrClass.getClass_time()}&nbsp; (h)</td>
												<td>${getMbrClass.getClass_etc()}</td>												
											</tr>
										</c:forEach>										
										<tr>
											<th colspan="3">교육시간 누계</th>
											<td><c:out value="${getMbrClassTimeSum.class_time_sum}"/>&nbsp; (h)</td>
											<td></td>											
										</tr>
									</thead>
								</table>
							</div>
						</div>
						
						<!-- 학력 및 가족관계 -->
						<div class="guestcnt4" style="display:none;">
							<div class= "tableStyle2">
								<!-- 학력 -->
								<table>
									<colgroup>
										<col width="15%">
										<col width="20%">
										<col width="15%">
										<col width="15%">
										<col width="15%">
										<col width="15%">										
									</colgroup>
									<tr>
										<th colspan="6">학력사항</th>
									</tr>
									<tr>
										<th>구분</th>
										<th>학교명</th>
										<th>학과</th>
										<th>졸업여부</th>
										<th>졸업년월</th>
										<th>비고</th>										
									</tr>
									<c:forEach var="item" items="${academiclist}" varStatus="status">
										<tr>					
											<td>
												<c:choose>
													<c:when test="${item.acadmicType == '10'}">고등학교</c:when>
													<c:when test="${item.acadmicType == '20'}">대학교</c:when>
													<c:when test="${item.acadmicType == '30'}">대학원</c:when>
												</c:choose>																		
											</td>											
											<td>${item.acadmicSchool}</td>											
											<td>${item.acadmicDepartment}</td>											
											<td>
												<c:choose>
													<c:when test="${item.acadmicGraduation  == 'Y'}">졸업</c:when>
													<c:when test="${item.acadmicGraduation  == 'N'}">중퇴</c:when>
												</c:choose>												
											</td>
											
											<td>${item.graduationDate}</td>
											<td>${item.acadmicMemo}</td>														
										</tr>
									</c:forEach>
								</table>
								<br/>
								
								<!-- 가족관계 -->
								<table>
									<colgroup>
										<col width="40%">
										<col width="60%">										
									</colgroup>
									<thead>
										<tr>
											<th colspan="2">가족사항</th>
										</tr>
										<tr>
											<th>관계</th>
											<th>이름</th>											
										</tr>
										<c:forEach items="${getMbrFamily}" var="getMbrFamily" varStatus="status">
											<tr>
												<td>${getMbrFamily.getFamily_relationship()}</td>
												<td>${getMbrFamily.getFamily_name()}</td>
											</tr>
										</c:forEach>
									</thead>
								</table>
							</div>
						</div>
					</div>
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
