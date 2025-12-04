<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	<script>
		$(document).ready(function(){
// 			if( "${mbrVo_Session.user_no}" != "6" || "${mbrVo_Session.user_no}" != "38" || "${mbrVo_Session.user_no}" != "670" || "${mbrVo_Session.user_no}" != "270" ||){
// 				alert("잘못된 접근입니다");
// 				history.back(-1);
// 				return;
// 			}
			
			if("${tab}" == "aprvTab" ){
				$("#aprvTab").click();
			}else if ("${tab}" == "endAprvTab"){
				$("#endAprvTab").click();
			}else if ("${tab}" == "internTab"){
				$("#internTab").click();
			}
			
			//일괄승인
			$("#allAprvBtn").click(function(){
				var tab = $(this).attr("tab");
				var r = confirm("현재까지 책정한 모든 직원의 연봉을 승인하시겠습니까?");
				if(!r){
					return;
				}
				$.post("./udtFinalBoardAprv",
						{ 
							flag : "all"
						 },
						function(data,status){
							if( data > 0 && status == "success" ){
								alert("최종 승인에 성공하셨습니다.");
								location.href="BoardMemSalList?tab="+tab;
							}else if (status == "success"){
								alert("승인 데이터가 없습니다");
								return;
							}
						}
				);		
			});
			
			
			$(".editFormBtn").click(function(){
				$(this).closest("span").css({"display": "none"}); //가장 가까운 span(printSal) 안보이게	
				$(this).closest("span").next().css({"display": "block"}); //가까운 곳의 다음 span(editSal) 보이게
			});//${".editBtn"}
			
			$(".editCancelBtn").click(function(){
				$(this).closest("span").css({"display": "none"}); //가장 가까운 span(editSal) 안보이게	
				$(this).closest("span").prev().css({"display": "block"}); //가까운 곳의 이전 span(editSal) 보이게	
			});
			
			$(".editConfirmBtn").click(function(){
 				var r = confirm("해당 직원의 연봉을 수정하시겠습니까?");
 				var user_no = $(this).attr("no");  
 				var salary = $(this).parent().find(".salary").val();
 				var tab =  $(this).attr("tab"); 
				$.post("./udtSalary",
						{ 
							user_no : user_no,
							sal_amt : salary
						 },
						function(data,status){
							if( data == 1 && status == "success" ){
								alert("수정에 성공하셨습니다.");
								location.href="BoardMemSalList?tab="+tab;
							}
						}
				);				
			});//editConfirmBtn
			
		});//ready
		
		function popMbrDetail(user_no){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			
			var sw=1010; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이

			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			
			window.open('popBoardSalDetail?user_no='+user_no,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}
		
		function boardFinalAgree(user_no,tab){
			var r = confirm("해당 직원의 연봉을 최종승인 하시겠습니까?");
			if(!r){
				return;
			}
			var user_no = user_no;
			$.post("./udtFinalBoardAprv",
					{ 
						user_no : user_no,
						flag : "one"
					 },
					function(data,status){
						if( data == 1 && status == "success" ){
							alert("최종 승인에 성공하셨습니다.");
							location.href="BoardMemSalList?tab="+tab;
						}
					}
			);				
		}
		
		function internAgree(user_no,tab){
			var r = confirm("해당 직원의 인턴 근로계약서 작성을 승인하시겠습니까?");			
			if(!r){
				return;
			}
			$.post("./insInternSal",
					{ 
						user_no : user_no,
						
					 },
					function(data,status){
						if( data == 1 && status == "success" ){
							alert("작성 승인 완료했습니다..");
							location.href="BoardMemSalList?tab="+tab;
						}
					}
			);	
				
		}
		
		function printContract(user_no, internFlag){
			var r = confirm("해당 직원의 연봉계약서를 인쇄 하시겠습니까?");
			if(!r){
				return false;
			}
			
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1050; //띄울 창의 넓이
			var sh=800;  //띄울 창의 높이

			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			if (internFlag != "intern"){
				window.open('memberSalAprv?user_no='+user_no,'','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			}else{
				window.open('internContract?user_no='+user_no,'','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			}
		} 
		
		/* 170711 하명호이사님 요청 - 미리보기 */
		function priviewContract(user_no,internFlag){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1050; //띄울 창의 넓이
			var sh=800;  //띄울 창의 높이

			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			if(internFlag != 'intern'){
				window.open('memberSalAprv?flag=priview&user_no='+user_no,'','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			}else{
				window.open('internContract?flag=priview&user_no='+user_no,'','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			}
			
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

			<!-- centercnt_top -->
			<div class="center_cnt_1300">

				<!-- centercnt_bot -->
				<div class="center_cnt_1300_bot">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">1종 직원리스트</a></li>
								<li id="aprvTab"><a href="#">승인 완료</a></li>
								<li><a href="#">승인 미완료</a></li>
								<li id="endAprvTab"><a href="#">최종 승인</a></li>
								<li id="internTab"><a href="#">수습 직원리스트</a></li>
								
							</ul>
						</div>
						<!-- 1종 직원리스트 -->
						<div class="guestcnt4" style="display:block;">
							<div class= "tableStyle2">
								<table>
									<thead>
										<tr>
											<th width="5%">순번</th>
											<th>팀명</th>
											<th>직급</th>
											<th>직책</th>
											<th>이름</th>
											<th>입사일</th>
											<th>17년 연봉</th>
											<th>비고</th>
										</tr>
									</thead>
									<tbody>
									<c:set value="0" var="List1Sum"/>
									<c:forEach var="memList" items="${kind1MemList}" varStatus="memIndex">
										<tr>
											<td>${memIndex.count}</td>
											<td>${memList.team_name}</td>
											<td>${memList.work_level}</td>
											<td>${memList.work_type}</td>
											<td>${memList.user_name}</td>
											<td>${memList.join_date}</td>
											<td>
												<span>
													<c:if test="${memList.sal_amt ne null}">
														<c:set value="${memList.sal_amt+List1Sum}" var="List1Sum"/>
														<fmt:formatNumber value="${memList.sal_amt}" type="number"/> 만원
													</c:if>
												</span>
											<!-- 
												<input type="text" id="${memList.user_no}Sal" size="10" maxlength="5" />
												<img src="./resources/ls_img/btn_edit_s.gif" class="editBtn" id="kind1Edit${memList.user_no}" value="${memList.user_no}" style="cursor:pointer;" />
											 -->
											</td>
											<td><img src="./resources/ls_img/member/btn_view.gif" id="kind1Mem${memList.user_no}" style="cursor:pointer;" onclick="popMbrDetail(${memList.user_no})"/></td>
										</tr>
										
									</c:forEach>
										<tr style="background-color: lightgray">
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td>17년 연봉 총합</td>
											<td><fmt:formatNumber value="${List1Sum}" type="number"/> 만원</td>
											<td></td>	
										</tr>
										
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
						</div><!-- //guestcnt4 -->
						
						<!-- 승인 완료 -->						
						<div class="guestcnt4" style="display:none;">
							<div class= "tableStyle2">
								<table>
									<thead>
										<tr>
											<th width="5%">순번</th>
											<th>팀명</th>
											<th>직급</th>
											<th>직책</th>
											<th>이름</th>
											<th>입사일</th>
											<th>17년 연봉</th>
											<th>비고</th>
										</tr>
									</thead>
									<tbody> 
									<c:set value="0" var="AprvSum"/>
									<c:forEach var="memList" items="${AprvMemList}" varStatus="memIndex">
										<tr>
											<td>${memIndex.count}</td>
											<td>${memList.team_name}</td>
											<td>${memList.work_level}</td>
											<td>${memList.work_type}</td>
											<td>${memList.user_name}</td>
											<td>${memList.join_date}</td>
											<td>
												<span id="AprvPrintSal">
													<c:set value="${memList.sal_amt+AprvSum}" var="AprvSum"/>
													<fmt:formatNumber value="${memList.sal_amt}" type="number"/> 만원
													<c:if test="${memList.sal_state ne '2'}">
														<img src="./resources/ls_img/btn_edit_s.gif" class="editFormBtn" style="cursor:pointer;" />
													</c:if>
												</span>
												
												<span id="AprvEditSal" style="display: none;">
													<input type="text" class="salary" id="${memList.user_no}Sal" size="10" maxlength="5" />
													<img src="./resources/ls_img/btn_end_s.gif" class="editConfirmBtn" no="${memList.user_no}" tab="aprvTab" style="cursor:pointer;" />
													<img src="./resources/ls_img/btn_del_s.gif" class="editCancelBtn" style="cursor:pointer;" />
												</span>
											</td>
											<td><img src="./resources/ls_img/member/btn_view.gif" id="kind1Mem${memList.user_no}" style="cursor:pointer;" onclick="popMbrDetail(${memList.user_no})"/></td>
										</tr>
									</c:forEach>
										<tr style="background-color: lightgray">
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td>17년 연봉 총합</td>
											<td><fmt:formatNumber value="${AprvSum}" type="number"/> 만원</td>
											<td></td>	
										</tr>
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
						</div>
						
						<!-- 승인 미완료 -->
						<div class="guestcnt4" style="display:none;">
							<div class= "tableStyle2">
								<table>
									<thead>
										<tr>
											<th width="5%">순번</th>
											<th>팀명</th>
											<th>직급</th>
											<th>직책</th>
											<th>이름</th>
											<th>입사일</th>
											<th>비고</th>
										</tr>
									</thead>
									<tbody>
									<c:forEach var="memList" items="${unAprvMemList}" varStatus="memIndex">
										<tr>
											<td>${memIndex.count}</td>
											<td>${memList.team_name}</td>
											<td>${memList.work_level}</td>
											<td>${memList.work_type}</td>
											<td>${memList.user_name}</td>
											<td>${memList.join_date}</td>
											<td><img src="./resources/ls_img/member/btn_view.gif" id="kind1Mem${memList.user_no}" style="cursor:pointer;" onclick="popMbrDetail(${memList.user_no})"/></td>
										</tr>
									</c:forEach>
										
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
						
						</div>
						
						<div class="guestcnt4" style="display:none;">
							<div class= "tableStyle2">
								<div style="text-align:right; margin:5px;">
									<input id="allAprvBtn" type="button" tab="endAprvTab" value="일괄승인"/>
								</div>
								<table>
									<thead>
										<tr>
											<th width="5%">순번</th>
											<th>팀명</th>
											<th>직급</th>
											<th>직책</th>
											<th>이름</th>
											<th>입사일</th>
											<th>17년 연봉</th>
											<th>비고</th>
										</tr>
									</thead>
									<tbody> 
									<c:set value="0" var="FinalAprvSum"/>
									<c:forEach var="memList" items="${AprvMemList}" varStatus="memIndex">
										<tr>
											<td>${memIndex.count}</td>
											<td>${memList.team_name}</td>
											<td>${memList.work_level}</td>
											<td>${memList.work_type}</td>
											<td>${memList.user_name}</td>
											<td>${memList.join_date}</td>
											<td>
												<span id="AprvPrintSal">
													<c:set value="${memList.sal_amt+FinalAprvSum}" var="FinalAprvSum"/>
													<fmt:formatNumber value="${memList.sal_amt}" type="number"/> 만원
													<c:if test="${memList.sal_state ne '2'}">
														<img src="./resources/ls_img/btn_edit_s.gif" class="editFormBtn" style="cursor:pointer;" />
													</c:if>
												</span>
												
												<span id="AprvEditSal" style="display: none;">
													<input type="text" class="salary" id="${memList.user_no}Sal" size="10" maxlength="5" />
													<img src="./resources/ls_img/btn_end_s.gif" class="editConfirmBtn" no="${memList.user_no}" tab="endAprvTab" style="cursor:pointer;" />
													<img src="./resources/ls_img/btn_del_s.gif" class="editCancelBtn" style="cursor:pointer;" />
												</span>
											</td>
											<td>
												<c:if test="${memList.sal_state eq '0'}">				
													<img src="./resources/ne_img/btn/btn_submit.gif" style="cursor:pointer;" onclick="boardFinalAgree(${memList.user_no},'endAprvTab')"/>
													<!-- 170711 하명호이사님 요청 - 미리보기  -->
													<img src="./resources/ne_img/btn/btn_preview.gif" style="cursor:pointer" onclick="priviewContract(${memList.user_no})"/>
												</c:if>
												<c:if test="${memList.sal_state eq '1'}">
													<span class="mark_alarm" style="cursor:default;"><font color="blue">승인 대기</font></span>
													<!-- 170711 하명호이사님 요청 - 미리보기  -->
													<img src="./resources/ne_img/btn/btn_preview.gif" style="cursor:pointer" onclick="priviewContract(${memList.user_no})"/>
												</c:if>
												<c:if test="${memList.sal_state eq '2' or memList.sal_state eq '3'}">
													<span class="mark_alarm" style="cursor:default;"><font color="red">승인 완료</font></span>
													<img src="./resources/ls_img/icon_print.gif" style="cursor:pointer" onclick="printContract(${memList.user_no})"/>
												</c:if>
											</td>
										</tr>
									</c:forEach>
										<tr style="background-color: lightgray">
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td>17년 연봉 총합</td>
											<td><fmt:formatNumber value="${FinalAprvSum}" type="number"/> 만원</td>
											<td></td>	
										</tr>
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
						</div>
						
						<!-- 수습 직원리스트 -->
						<div class="guestcnt4" style="display:none;">
							<div class= "tableStyle2">
								<table>
									<thead>
										<tr>
											<th width="5%">순번</th>
											<th>팀명</th>
											<th>직급</th>
											<th>직책</th>
											<th>이름</th>
											<th>입사일</th>
											<th>비고</th>
										</tr>
									</thead>
									<tbody>
									<c:set value="0" var="List1Sum"/>
									<c:forEach var="memList" items="${internMemList}" varStatus="memIndex">
										<tr>
											<td>${memIndex.count}</td>
											<td>${memList.team_name}</td>
											<td>${memList.work_level}</td>
											<td>${memList.work_type}</td>
											<td>${memList.user_name}</td>
											<td>${memList.join_date}</td>
											<td>
												<c:choose>
													<c:when test="${memList.sal_state eq null}">
														<span class="mark_alarm" style="cursor:pointer;" onclick="internAgree(${memList.user_no},'internTab')"><font>직원 전송</font></span>
														<!-- 170711 하명호이사님 요청 - 미리보기  -->
														<img src="./resources/ne_img/btn/btn_preview.gif" style="cursor:pointer" onclick="priviewContract(${memList.user_no},'intern')"/>
														
													</c:when>
													<c:when test="${memList.sal_state eq 1}">
														<span class="mark_alarm" style="cursor:default;"><font color="blue">승인 대기</font></span>
														<!-- 170711 하명호이사님 요청 - 미리보기  -->
														<img src="./resources/ne_img/btn/btn_preview.gif" style="cursor:pointer" onclick="priviewContract(${memList.user_no},'intern')"/>
														
													</c:when>
													<c:otherwise>
														<span class="mark_alarm" style="cursor:default;"><font color="red">승인 완료</font></span>
														<img src="./resources/ls_img/icon_print.gif" style="cursor:pointer" onclick="printContract(${memList.user_no},'intern')"/>
													</c:otherwise>
												</c:choose>
											</td>
										</tr>
									</c:forEach>
										
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
						</div><!-- //guestcnt4 -->
						
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
