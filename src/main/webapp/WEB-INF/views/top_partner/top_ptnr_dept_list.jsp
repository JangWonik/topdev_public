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
	<%--<script src="./resources/daum/161109.js"></script>--%>
	<script src="./resources/daum/postcode.v2.js"></script>
	<script src='https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js'></script>
	
	<script>
		$(document).ready(function(){
			
			/* 권한 세션 체크 : 9번은 보험사 관리 */
			if(('${mbrAuthVo_Session.user_no}' == null) || ('${mbrAuthVo_Session.mbr_pms_9}' == 0)){
				window.location.assign("./logout");
			}
		
			$("#postCodeBtn2").click(function(){
				var themeObj = {
						   bgColor: "#C00C0C", //바탕 배경색
						   //searchBgColor: "", //검색창 배경색
						   //contentBgColor: "", //본문 배경색(검색결과,결과없음,첫화면,검색서제스트)
						   //pageBgColor: "", //페이지 배경색
						   //textColor: "", //기본 글자색
						   //queryTextColor: "", //검색창 글자색
						   //postcodeTextColor: "", //우편번호 글자색
						   emphTextColor: "#C01160" //강조 글자색
						   //outlineColor: "", //테두리
						};
				new daum.Postcode({
					theme: themeObj,
					oncomplete: function(data) {
						$("#ptnr_dept_office_postcode").val(data.zonecode);
						$("#ptnr_dept_office_addr1").val(data.roadAddress);
					}
				}).open();
			});//$("#postCodeBtn2").click
	
		});
		
		function postCodeBtn1(id){
			var themeObj = {
					   bgColor: "#C00C0C", //바탕 배경색
					   //searchBgColor: "", //검색창 배경색
					   //contentBgColor: "", //본문 배경색(검색결과,결과없음,첫화면,검색서제스트)
					   //pageBgColor: "", //페이지 배경색
					   //textColor: "", //기본 글자색
					   //queryTextColor: "", //검색창 글자색
					   //postcodeTextColor: "", //우편번호 글자색
					   emphTextColor: "#C01160" //강조 글자색
					   //outlineColor: "", //테두리
					};
			new daum.Postcode({
				theme: themeObj,
				oncomplete: function(data) {
					$("#"+id+"_postcode").val(data.zonecode);
					$("#"+id+"_addr1").val(data.roadAddress);
				}
			}).open();
		}
		
		/* 보험사 부서 삭제 상태 값 변경 */
		function delDept(ptnr_dept_id, ptnr_id){
			
			$.post(
					"ptnrDeptDel",
					{	
						ptnr_dept_id : ptnr_dept_id
					},
					function(data,status){
						
						if(status == "success"){
							
							if(data == 0){
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}else{
								alert("변경 완료");
			                	location.href = "ptnrDeptPage?ptnr_id="+ptnr_id;
							}
							
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}
			);//post
		}
		
		
		/* 보험사 부서 추가  */
		function addDept(ptnr_id){
			/*
			if($("#ptnr_dept_nm").val() == ''){
				
				alert("부서명은 필수 입력사항입니다.");
				$("#ptnr_dept_nm").focus();
				return;
			}
			
			if($("#ptnr_dept_office_tel").val() == ''){
				
				alert("전화번호는 필수 입력사항입니다.");
				$("#ptnr_dept_office_tel").focus();
				return;
			}
			
			if($("#ptnr_dept_office_fax").val() == ''){
				
				alert("팩스 번호는 필수 입력사항입니다.");
				$("#ptnr_dept_office_fax").focus();
				return;
			}
			
			if($("#ptnr_dept_office_postcode").val() == ''){
				
				alert("주소는 필수 입력사항입니다.");
				$("#ptnr_dept_office_postcode").focus();
				return;
			}
			*/
			
			
			var ptnr_id = ptnr_id;
			
			$.post(
					"ptnrDeptIns",
					{	
						ptnr_id : ptnr_id,
						ptnr_dept_nm : $("#ptnr_dept_nm").val(),
						ptnr_dept_office_tel : $("#ptnr_dept_office_tel").val(),
						ptnr_dept_office_fax : $("#ptnr_dept_office_fax").val(),
						ptnr_dept_office_postcode : $("#ptnr_dept_office_postcode").val(),
						ptnr_dept_office_addr1 : $("#ptnr_dept_office_addr1").val(),
						ptnr_dept_office_addr2 : $("#ptnr_dept_office_addr2").val()
					},
					function(data,status){
						
						if(status == "success"){
							
							if(data == 0){
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}else{
								alert("입력 완료");
			                	location.href = "ptnrDeptPage?ptnr_id="+ptnr_id;
							}
							
							
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}
			);//post
			
		}
		
		function udtDept(ptnr_dept_id, ptnr_id){
			
			if(confirm("수정하시겠습니까?")){
				
				if($("#"+ptnr_dept_id+"_nm").val() == ''){
					
					alert("부서명은 필수 입력사항입니다.");
					$("#"+ptnr_dept_id+"_nm").focus();
					return;
				}
				
				
// 				if($("#"+ptnr_dept_id+"_tel").val() == ''){
// 					alert("전화번호는 필수 입력사항입니다.");
// 					$("#"+ptnr_dept_id+"_tel").focus();
// 					return;
// 				}
				
// 				if($("#"+ptnr_dept_id+"_fax").val() == ''){
// 					alert("팩스 번호는 필수 입력사항입니다.");
// 					$("#"+ptnr_dept_id+"_fax").focus();
// 					return;
// 				}
				
// 				if($("#"+ptnr_dept_id+"_postcode").val() == ''){
// 					alert("주소는 필수 입력사항입니다.");
// 					$("#"+ptnr_dept_id+"_postcode").focus();
// 					return;
// 				}
				
				$.post(
						"ptnrDeptUdt",
						{	
							ptnr_id : ptnr_id,
							ptnr_dept_id : ptnr_dept_id,
							ptnr_dept_nm : $("#"+ptnr_dept_id+"_nm").val(),
							ptnr_dept_office_tel : $("#"+ptnr_dept_id+"_tel").val(),
							ptnr_dept_office_fax : $("#"+ptnr_dept_id+"_fax").val(),
							ptnr_dept_office_postcode : $("#"+ptnr_dept_id+"_postcode").val(),
							ptnr_dept_office_addr1 : $("#"+ptnr_dept_id+"_addr1").val(),
							ptnr_dept_office_addr2 : $("#"+ptnr_dept_id+"_addr2").val()
						},
						function(data,status){
							
							if(status == "success"){
								
								if(data.length == 0){
									alert("시스템 오류입니다. 잠시 후 다시 시도해주세요.");
									
								}else{
									
				                    $.each(data, function(index, entry) {
				                    	alert("수정완료");
					                 	$("#"+ptnr_dept_id+"_nm").val(entry.ptnr_dept_nm);
					                 	$("#"+ptnr_dept_id+"_tel").val(entry.ptnr_dept_office_tel);
					                 	$("#"+ptnr_dept_id+"_fax").val(entry.ptnr_dept_office_fax);
					                 	$("#"+ptnr_dept_id+"_postcode").val(entry.ptnr_dept_office_postcode);
					                 	$("#"+ptnr_dept_id+"_addr1").val(entry.ptnr_dept_office_addr1);
					                 	$("#"+ptnr_dept_id+"_addr2").val(entry.ptnr_dept_office_addr2);
					                 	
					                 	
									});//each
									
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						},"json"
						
				);//post
			}
			
			
		}
		
	</script>
</head>

<body>

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
								<li class="on" ><a href="">보험사 부서 목록</a></li>
								<li ><a href="">보험사 부서 추가</a></li>
							</ul>
						</div>
						<div class="guestcnt4" style="display:block;">
							<div class= "tableStyle2">
								<table>
									<tbody>
										<tr>
											
											<c:choose>
												<c:when test="${ptnrVo.imgStream_b eq ''}">
													<td rowspan="7" width="25%"> 이미지 없음 </td>
												</c:when>
												<c:otherwise>
												<td rowspan="7" width="25%">
													<img src="${ptnrVo.imgStream_b}" alt="보험사 큰 사진" />
												</td>	
												</c:otherwise>
											</c:choose>
												
											
											<td > 구분 : 
												<c:if test="${ptnrVo.ptnr_type eq 1}">
													<b>손해보험</b>
												</c:if>
												<c:if test="${ptnrVo.ptnr_type eq 2}">
													<b>생명보험</b>
												</c:if>
												<c:if test="${ptnrVo.ptnr_type eq 3}">
													<b>협회</b>
												</c:if>
												<c:if test="${ptnrVo.ptnr_type eq 4}">
													<b>공제</b>
												</c:if>
												<c:if test="${ptnrVo.ptnr_type eq 5}">
													<b>기타</b>
												</c:if>
												
											</td>
										</tr>
										<tr>
											<c:choose>
												<c:when test="${ptnrVo.ptnr_name eq '' }">
													<td>사명 : 정보 없음 </td>
												</c:when>
												<c:otherwise>
													<td>사명 : <b>${ptnrVo.ptnr_name}</b> </td>	
												</c:otherwise>
											</c:choose> 
										</tr>
										
										<tr>
											<c:choose>
												<c:when test="${ptnrVo.ptnr_biz_type1 eq '' }">
													<td>업태(업종) : 정보 없음 </td>
												</c:when>
												<c:otherwise>
													<td>업태(업종) : <b> ${ptnrVo.ptnr_biz_type1} ( ${ptnrVo.ptnr_biz_type2} ) </b> </td>	
												</c:otherwise>
											</c:choose>  
										</tr>
										<tr>
											<c:choose>
												<c:when test="${ptnrVo.ptnr_biz_reg_no eq '' }">
													<td>사업자 번호 : 정보 없음 </td>
												</c:when>
												<c:otherwise>
													<td>사업자 번호 : <b> ${ptnrVo.ptnr_biz_reg_no} </b> </td>	
												</c:otherwise>
											</c:choose> 	
										</tr>
										<tr>
											<c:choose>
												<c:when test="${ptnrVo.ptnr_tel eq '' }">
													<td>사업자 연락처 : 정보 없음 </td>
												</c:when>
												<c:otherwise>
													<td>사업자 연락처 :  <b> ${ptnrVo.ptnr_tel} </b> </td>
												</c:otherwise>
											</c:choose> 
										</tr>
										<tr>
											<c:choose>
												<c:when test="${ptnrVo.ptnr_url eq '' }">
													<td>사업자 홈페이지 : 정보 없음 </td>
												</c:when>
												<c:otherwise>
													<td>사업자 홈페이지 :  <b> ${ptnrVo.ptnr_url} </b> </td>
												</c:otherwise>
											</c:choose> 
										</tr>
										<tr>
											<c:choose>
												<c:when test="${ptnrVo.ptnr_addr eq '' }">
													<td>사업자 주소 : 정보 없음 </td>
												</c:when>
												<c:otherwise>
													<td>사업자 주소 : <b> ${ptnrVo.ptnr_addr} </b> </td>
												</c:otherwise>
											</c:choose> 
										</tr>
									</tbody>
								</table>
								
								<table style = "border-top:1px solid blue; margin-top : 10px;">
									<thead>
										<tr>
											<th width="5%">No</th>
											<th >부서명</th>
											<th >대표 전화</th>
											<th >팩스 번호</th>
											<th >등록일</th>
											<th >수정/삭제(일)</th>
										</tr>
									</thead>
									<tbody id = "deptList">
									
									<c:choose>
										<c:when test="${ptnrtDeptList.size() != 0 }">
											<c:forEach items="${ptnrtDeptList}" var="pVo">
												<tr id = "${pVo.ptnr_dept_id}" >
													<c:choose>
														<c:when test="${pVo.del_state eq 1 }">
															<td rowspan="2">${pVo.rownum}</td>
															<td >${pVo.ptnr_dept_nm }</td>
															<td >${pVo.ptnr_dept_office_tel }</td>
															<td >${pVo.ptnr_dept_office_fax }</td>
														</c:when>
														<c:otherwise>
															<td rowspan="2">${pVo.rownum}</td>
															<td ><input type="text" style = "text-align:center;" id = "${pVo.ptnr_dept_id}_nm" value = "${pVo.ptnr_dept_nm }"/></td>
															<td ><input type="text" style = "text-align:center;" id = "${pVo.ptnr_dept_id}_tel" value = "${pVo.ptnr_dept_office_tel }"/></td>
															<td ><input type="text" style = "text-align:center;" id = "${pVo.ptnr_dept_id}_fax" value ="${pVo.ptnr_dept_office_fax }"/></td>
														</c:otherwise>
													</c:choose> <!--  // 이름, 전화, 팩스 버튼 -->
													<td>${pVo.reg_date }</td> <!--  //등록일 -->
													<c:choose>
														<c:when test="${pVo.del_state eq 0 }">
															<td rowspan="2">
																<img src="./resources/ls_img/btn_edit_s.gif" style = "cursor:pointer;" onclick = "udtDept('${pVo.ptnr_dept_id}','${pVo.ptnr_id }')" alt="부서 수정 버튼" />
																/ <img src="./resources/ls_img/btn_del_s.gif" style = "cursor:pointer;" onclick = "delDept('${pVo.ptnr_dept_id}','${pVo.ptnr_id }')" alt="부서 삭제 버튼" />
															</td>
														</c:when>							
														<c:otherwise>
															<td rowspan="2">${pVo.del_date }</td>
														</c:otherwise>						
													</c:choose><!--  //수정 삭제 버튼 -->
												</tr>
												<tr >
													<c:choose>
														<c:when test="${pVo.del_state eq 1 }">
															<td colspan="4">주소 : <b>${pVo.ptnr_dept_office_addr1} ${pVo.ptnr_dept_office_addr2}</b> </td>
															
														</c:when>
														<c:otherwise>
															<td colspan="4" >주소 : 
																<%-- <b><input type="text" size="100" style = "text-align:center;"  id = "${pVo.ptnr_dept_id}_addr" value ="${pVo.ptnr_dept_office_addr }"/></b> --%> 
																<input type="text" name="${pVo.ptnr_dept_id}_postcode" id="${pVo.ptnr_dept_id}_postcode" size="10" value = "${pVo.ptnr_dept_office_postcode }" readonly style="background-color:lightgrey;" />
																<input type="button" id="postCodeBtn1" value="우편번호 찾기" onclick = "postCodeBtn1('${pVo.ptnr_dept_id}');">
																
																<input type="text" name="${pVo.ptnr_dept_id}_addr1" id="${pVo.ptnr_dept_id}_addr1"  size="50" value = "${pVo.ptnr_dept_office_addr1 }" readonly style="background-color:lightgrey;" />
																
																<c:choose>
																	<c:when test="${pVo.ptnr_dept_office_postcode eq '' }">
																		<input type="text" name="${pVo.ptnr_dept_id}_addr2" id="${pVo.ptnr_dept_id}_addr2" value = "${pVo.ptnr_dept_office_addr}" value = "${pVo.ptnr_dept_office_addr2 }" size="30" />		
																	</c:when>
																	<c:otherwise>
																		<input type="text" name="${pVo.ptnr_dept_id}_addr2" id="${pVo.ptnr_dept_id}_addr2" value = "${pVo.ptnr_dept_office_addr2}" size="30" value = "${pVo.ptnr_dept_office_addr2 }" />
																	</c:otherwise>
																</c:choose>
																
															</td>
															
															
														</c:otherwise>
													</c:choose><!--  //주소 -->
												</tr>
											</c:forEach> <!--  //목록 출력 -->
										</c:when>
										<c:otherwise>
											<!-- todo -->
											<tr>
												<td colspan="6">
													부서 없음
												</td>
											</tr>
										</c:otherwise>
									</c:choose>
									</tbody>
								</table>
								
							</div><!-- //tableStyle2 -->
						</div><!-- //guestcnt4 -->
						<div class="guestcnt4" style="display:none;">
							<div class= "tableStyle2">
								<table >
									<thead>
										<tr>
											<th >부서명</th>
											<th >대표 전화</th>
											<th >팩스 번호</th>
											<th >추가</th>
										</tr>
									</thead>
									<tbody>
										
										<tr>
											<td>
												<input type="text" id = "ptnr_dept_nm"/>
											</td>
											<td>
												<input type="text" id = "ptnr_dept_office_tel"/>
											</td>
											<td>
												<input type="text" id = "ptnr_dept_office_fax"/>
											</td>
											
											<td rowspan="2" >
												추가 : <img src="./resources/ls_img/btn_add_s.gif" style ="cursor:pointer;" onclick ="addDept('${ptnrVo.ptnr_id}');" alt="부서 추가 버튼" />
											</td>
										</tr>
										<tr>
											<td colspan="3" >
												주소  : <input type="text" name="ptnr_dept_office_postcode" id="ptnr_dept_office_postcode" size="10" readonly style="background-color:lightgrey;" />
													  <input type="button" id="postCodeBtn2" value="우편번호 찾기">
												      <input type="text" name="ptnr_dept_office_addr1" id="ptnr_dept_office_addr1"  size="50" readonly style="background-color:lightgrey;" />
												      <input type="text" name="ptnr_dept_office_addr2" id="ptnr_dept_office_addr2"  size="30" />
																
											</td>
										</tr>
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
						</div><!-- //guestcnt4 -->
						
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
