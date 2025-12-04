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
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/vertical.css" />
	
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<script>
			
 		$(document).ready(function(){
 			
 			if('${mbrAuthVo_Session}'== null || '${mbrAuthVo_Session.mbr_pms_16}' == 0){
 				window.location.assign("./logout");
 			}
 			
 			$.ajaxSetup({cache:false});
 			
 			/* 일괄승인 시작*/
 			$("#appBtn").bind("click", function(){
 			
	 				var checkboxValues = [];
	
	 			    $("input[name='checkUdt']:checked").each(function(i) {
	 			        checkboxValues.push($(this).val());
	
	 			    });
	 				
	 			    if(checkboxValues.length != 0){
	 			    	if(confirm("선택된 항목들을 일괄 승인처리 하시겠습니까?")){
	 	 					
	 			    		var allData = {"checkArray": checkboxValues };
	 	 			   
	 		 			    $.post(
 		 			    		"CertUdtTbApp",
	 		 					allData,
	 							function(data,status){
	 								if(data == 1){
	 									alert("수정 되었습니다.");
	 									window.location.reload();
	 								}else{
	 									alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
	 								}
 								}
	 						);//post
	 			    	}
	 			    }else{
	 			    	alert("하나 이상 체크해 주세요.");
	 			    } // if
 	
 			});
 			/* 일괄승인 끝*/
 			
 			
 			/* 일괄반려 시작*/
 			$("#denBtn").bind("click", function(){
 				
 				var checkboxValues = [];
 				
 			    $("input[name='checkUdt']:checked").each(function(i) {
 			        checkboxValues.push($(this).val());

 			    });
 				
 			    if(checkboxValues.length != 0){
 			    	if(confirm("선택된 항목들을 일괄 반려처리 하시겠습니까?")){
 	 					
 			    		var allData = {"checkArray": checkboxValues };
 	 			   
 		 			    $.post(
		 			    	"CertUdtTbDen",
 		 					allData,
 							function(data,status){
 								if(data == 1){
 									window.location.reload();
 								}else{
 									alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
 								}
							}
 						);//post
 			    	}
 			    }else{
 			    	alert("하나 이상 체크해 주세요.");
 			    } // if
 			});
 			/* 일괄반려 끝*/
 			
 			
 			/* 검색 동작 시작 */
 			$("#certSearchBtn").click(function(){
 				$.post("./certSearch",
 						{	issue_state:$("#issue_state").val()
 							,tid:$("#tid").val()
 							,searchStr:$("#searchStr").val()
 							,gid:$("#tid option:selected").text().indexOf("└")
 						},
 						function(data,status){
 							$("#certList").empty();
 							$("#paging").empty();
 							if(status == "success"){
 								
 								
 								if(data.length == 0){
 									
 									$("#certList").append(
 										"<tr>"
 											+"<td colspan='9'> 검색 결과 없음</td>"
 										+"</tr>"
 												
 									);
 									
 									$("#searchStr").focus();
 									
 								}else{
 				                    $.each(data, function(index, entry) {
 				                    	
 				                    	if(entry.issue_state == '신청'){
 				                    		
 				                    		$("#certList").append("<tr onMouseOver='this.style.backgroundColor=\"#FFECEC\"' onMouseOut='this.style.backgroundColor=\"\"'>"
 													
 													+ "<td><input type='checkbox' name = 'checkUdt' value = '"+entry.serial_no+"'/></td>"
 													+ "<td style= 'cursor:pointer;' onclick=\"showThisPop('"+entry.serial_no+"','"+entry.user_no+"');\">"+entry.ROWNUM+"</td>"
 													+ "<td style= 'cursor:pointer;' onclick=\"showThisPop('"+entry.serial_no+"','"+entry.user_no+"');\">"+entry.user_name+"</td>"
 													+ "<td style= 'cursor:pointer;' onclick=\"showThisPop('"+entry.serial_no+"','"+entry.user_no+"');\">"+entry.center_name+"</td>"
 													+ "<td style= 'cursor:pointer;' onclick=\"showThisPop('"+entry.serial_no+"','"+entry.user_no+"');\">"+entry.team_name+"</td>"
 													+ "<td style= 'cursor:pointer;' onclick=\"showThisPop('"+entry.serial_no+"','"+entry.user_no+"');\">"+entry.work_level+"</td>"
 													+ "<td style= 'cursor:pointer;' onclick=\"showThisPop('"+entry.serial_no+"','"+entry.user_no+"');\">"+entry.reg_date+"</td>"
 													+ "<td style= 'cursor:pointer;' onclick=\"showThisPop('"+entry.serial_no+"','"+entry.user_no+"');\">"+entry.issue_reason+"</td>"
 													+ "<td style= 'cursor:pointer;' onclick=\"showThisPop('"+entry.serial_no+"','"+entry.user_no+"');\">"+entry.expiry_date+"</td>"
 													+ "<td style= 'cursor:pointer;' onclick=\"showThisPop('"+entry.serial_no+"','"+entry.user_no+"');\"><font color='blue'><b>"+entry.issue_state+"</b></font></td>"
 													
 			                                		+ "</tr>"
 				   							);
 				                    		
 				                    	}else if(entry.issue_state == '승인'){
 				                    		
											$("#certList").append("<tr onMouseOver='this.style.backgroundColor=\"#FFECEC\"' onMouseOut='this.style.backgroundColor=\"\"'>"
 													
 													+ "<td><input type='checkbox' disabled='disabled'/></td>"
 													+ "<td >"+entry.ROWNUM+"</td>"
 													+ "<td >"+entry.user_name+"</td>"
 													+ "<td >"+entry.center_name+"</td>" 													
 													+ "<td >"+entry.team_name+"</td>"
 													+ "<td >"+entry.work_level+"</td>"
 													+ "<td >"+entry.reg_date+"</td>"
 													+ "<td >"+entry.issue_reason+"</td>"
 													+ "<td >"+entry.expiry_date+"</td>"
 													+ "<td ><font color='green'><b>"+entry.issue_state+"</b></font></td>"
 													
 			                                		+ "</tr>"
 				   							);
 				                    	}else if(entry.issue_state == '취소'){
 				                    		
											$("#certList").append("<tr onMouseOver='this.style.backgroundColor=\"#FFECEC\"' onMouseOut='this.style.backgroundColor=\"\"'>"
 													
 													+ "<td><input type='checkbox' disabled='disabled'/></td>"
 													+ "<td >"+entry.ROWNUM+"</td>"
 													+ "<td >"+entry.user_name+"</td>"
 													+ "<td >"+entry.center_name+"</td>"
 													+ "<td >"+entry.team_name+"</td>"
 													+ "<td >"+entry.work_level+"</td>"
 													+ "<td >"+entry.reg_date+"</td>"
 													+ "<td >"+entry.issue_reason+"</td>"
 													+ "<td >"+entry.expiry_date+"</td>"
 													+ "<td ><b>"+entry.issue_state+"</b></td>"
 													
 			                                		+ "</tr>"
 				   							);
 				                    	}else if(entry.issue_state == '반려'){
 				                    		
											$("#certList").append("<tr onMouseOver='this.style.backgroundColor=\"#FFECEC\"' onMouseOut='this.style.backgroundColor=\"\"'>"
 													
 													+ "<td><input type='checkbox' disabled='disabled'/></td>"
 													+ "<td >"+entry.ROWNUM+"</td>"
 													+ "<td >"+entry.user_name+"</td>"
 													+ "<td >"+entry.center_name+"</td>"
 													+ "<td >"+entry.team_name+"</td>"
 													+ "<td >"+entry.work_level+"</td>"
 													+ "<td >"+entry.reg_date+"</td>"
 													+ "<td >"+entry.issue_reason+"</td>"
 													+ "<td >"+entry.expiry_date+"</td>"
 													+ "<td ><font color='red'><b>"+entry.issue_state+"</b></font></td>"
 													
 			                                		+ "</tr>"
 				   							);
 				                    	}
 				                    	
 		                        		
 									});//each
 									
 				                   $("#searchStr").focus();
 								}
 							}else{
 								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
 							}
 						},"json"
 				);//post
 				
 			});//$("#certSearchBtn").click
 			/* 검색 동작 끝*/
 			
 			/* 전체 체크 하기 */
 			$('#checkAll').click(function() {
 		         if( $(this).is(":checked") ) {
 		        	$("input[name='checkUdt']").prop("checked",true);
 		         }
 		         else {
 		        	$("input[name='checkUdt']").prop("checked",false);
 		         }
 	     	});
			
		}); // document.ready 
 		 
		/* 재직증명 팝업 띄우기 */	
		function showThisPop(serial_no,user_no){
			
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			
			var sw=600;
			var sh=370; 

			var ml=(cw-sw)/2;   
			var mt=(ch-sh)/2;   
			
			window.open("CertUdt?serial_no="+serial_no+"&user_no="+user_no,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
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
<%-- 			<c:import url="../top_main/top_main_left.jsp"></c:import> --%>
			<!-- //left_cnt -->

			<!-- centercnt_top -->
			<div class="center_cnt_1300_ds">

				<!-- centercnt_bot -->
				<div class="centercnt_1300_bot1-2_ds">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">재직증명서 관리</a></li>
							</ul>
						</div>
						
						<div style ="text-align:right; margin-top:5px;">
							<%-- <img src="./resources/ls_img/btn_issue.gif" alt="재증발급요청버튼" style="cursor:pointer;" onclick="gocertReq('${CertList}');"/> --%>
						</div>
						
						<div class="guestcnt_1300_ds" style="display:block;">
							
							<div class= "tableStyle2" style = "margin-bottom:20px;">

								<table>
									<thead>
										<tr>
											<th width="25%">상태</th>
											<th width="25%">팀 선택</th>
											<th width="35%">검색어(이름)</th>
											<th width="15%">검색</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>
												<select id="issue_state">
													<option value="10" selected>전체</option>
													<option value="0">신청</option>
													<option value="1">취소</option>
													<option value="2">승인</option>
													<option value="3">반려</option>
												</select>
											</td>
											<td>
												<select id="tid">
													<option value="0" selected>전체</option>
													<c:forEach items="${teamList}" var = "teamVo">
														<option value="${teamVo.team_id}">
															<c:if test="${teamVo.team_level == 1}">&nbsp;└</c:if>
															<c:if test="${teamVo.team_level == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
															${teamVo.team_name}
														</option>
													</c:forEach>
												</select>
											</td>
											<td>
												<input type="text" id="searchStr" name="searchStr" size="50" onfocus = "this.select()"/>
											</td>
											<td>
												<input type="image" src="./resources/ls_img/btn_src.gif" id="certSearchBtn" />
											</td>
										</tr>
									</tbody>
								</table>
								<!-- 검색 테이블 끝-->
								
							</div><!-- //tableStyle2 -->
							
						
							<div class= "tableStyle2">
								<table>
									<thead>
										<tr>
											<th width="50px;"><input type="checkbox" id = "checkAll"/></th>
											<th width="30px;">no</th>
											<th width="100px;">이름</th>
											<th width="120px;">센터명</th>
											<th width="120px;">부서명</th>
											<th width="70px;">직급</th>
											<th width="110px;">신청일시</th>
											<th>용도</th>
											<th width="80px;">발급유효일</th>
											<th width="50px;">상태</th>
											
										</tr>
									</thead>
									<tbody id = "certList">
									<c:forEach items="${CertList}" var="certVo">
									<c:choose>
										<c:when test="${certVo.issue_state eq '신청'}">
											<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
												<td><input type="checkbox" name = "checkUdt" value = "${certVo.serial_no }"/></td>
												<td style= "cursor:pointer;" onclick="showThisPop('${certVo.serial_no}','${certVo.user_no}');">${certVo.ROWNUM}</td>
												<td style= "cursor:pointer;" onclick="showThisPop('${certVo.serial_no}','${certVo.user_no}');">${certVo.user_name}</td>
												<td style= "cursor:pointer;" onclick="showThisPop('${certVo.serial_no}','${certVo.user_no}');">${certVo.center_name}</td>
												<td style= "cursor:pointer;" onclick="showThisPop('${certVo.serial_no}','${certVo.user_no}');">${certVo.team_name}</td>
												<td style= "cursor:pointer;" onclick="showThisPop('${certVo.serial_no}','${certVo.user_no}');">${certVo.work_level}</td>
												<td style= "cursor:pointer;" onclick="showThisPop('${certVo.serial_no}','${certVo.user_no}');">${certVo.reg_date}</td>
												<td style= "cursor:pointer;" onclick="showThisPop('${certVo.serial_no}','${certVo.user_no}');">${certVo.issue_reason}</td>
												<td style= "cursor:pointer;" onclick="showThisPop('${certVo.serial_no}','${certVo.user_no}');">${certVo.expiry_date}</td>
												<td style= "cursor:pointer;" onclick="showThisPop('${certVo.serial_no}','${certVo.user_no}');"><font color="blue"><b>${certVo.issue_state}</b></font></td>
											</tr>
										</c:when>
										<c:when test="${certVo.issue_state eq '취소'}">
											<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
												<td><input type="checkbox" disabled="disabled"/></td>
												<td>${certVo.ROWNUM}</td>
												<td>${certVo.user_name}</td>
												<td>${certVo.center_name}</td>
												<td>${certVo.team_name}</td>
												<td>${certVo.work_level}</td>
												<td>${certVo.reg_date}</td>
												<td>${certVo.issue_reason}</td>
												<td>${certVo.expiry_date}</td>
												<td>${certVo.issue_state}</td>
												
											</tr>
										</c:when>
										<c:when test="${certVo.issue_state eq '승인'}">
											<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
												<td><input type="checkbox" disabled="disabled" /></td>
												<td>${certVo.ROWNUM}</td>
												<td>${certVo.user_name}</td>
												<td>${certVo.center_name}</td>
												<td>${certVo.team_name}</td>
												<td>${certVo.work_level}</td>
												<td>${certVo.reg_date}</td>
												<td>${certVo.issue_reason}</td>
												<td>${certVo.expiry_date}</td>
												<td><font color="green"><b>${certVo.issue_state}</b></font></td>
												
											</tr>
										</c:when>
										<c:otherwise>
											<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
												<td><input type="checkbox" disabled="disabled" /></td>
												<td>${certVo.ROWNUM}</td>
												<td>${certVo.user_name}</td>
												<td>${certVo.center_name}</td>
												<td>${certVo.team_name}</td>
												<td>${certVo.work_level}</td>
												<td>${certVo.reg_date}</td>
												<td>${certVo.issue_reason}</td>
												<td>${certVo.expiry_date}</td>
												<td><font color="red"><b>${certVo.issue_state}</b></font></td>
												
											</tr>
										</c:otherwise>
									</c:choose>
									</c:forEach>
									</tbody>
								</table>
								<div style = "text-align:center; margin-top:10px;">
									<input type="button" id = "appBtn" value = "선택항목 일괄 승인" />
									<input type="button" id = "denBtn" value = "선택항목 일괄 반려" />
								</div>
								<br/>
							</div><!-- //tableStyle2 -->
							
							<!-- page start -->
							<div id = "paging">
								<c:if test="${fromCertList eq 'fromCertList' }">
									<c:import url="../util_page/page_bsc_1.jsp" charEncoding="UTF-8">
										<c:param name="totPgCntInt1" value="${totPgCntInt}"></c:param>
										<c:param name="reqPgNoInt1" value="${reqPgNoInt}"></c:param>
										<c:param name="startPgNoInt1" value="${startPgNoInt}"></c:param>
										<c:param name="endPgNoInt1" value="${endPgNoInt}"></c:param>
										<c:param name="pgNm1" value="${pgNm}"></c:param>
									</c:import>
								</c:if>
							</div>
							<!-- //page end -->
						</div><!-- //guestcnt4 -->
					
					</div>

				
				</div>
				<!-- //centercnt_bot -->

				<!-- banner -->
<%-- 				<c:import url="../top_main/top_main_banner.jsp"></c:import> --%>
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

	<script>
		$(document).ready(function(){
			if('${fromMainLeftStr}'== 'on'){
				$('#issue_state option[value="0"]').attr('selected', 'selected');
				$("#certSearchBtn").click();
			}
		});
	</script>

</body>

</html>
