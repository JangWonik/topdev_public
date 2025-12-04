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
			
			if(('${mbrAuthVo_Session.user_no}' == null) || ('${mbrAuthVo_Session.mbr_pms_9}' == 0)){
				window.location.assign("./logout");
			}
			
			/* 보험사 추가 화면에서 넘어 올 경우 추가한 페이지 탭 클릭 */
			if('${fromPage}' != null){				
				if('${fromPage}' == '1'){
					$("#loss").click();
				}else if('${fromPage}' == '2' ){
					$("#life").click();
				}else if('${fromPage}' == '3' ){
					$("#orga").click();
				}else if('${fromPage}' == '4' ){
					$("#gongjea").click();
				}else if('${fromPage}' == '5' ){
					$("#other").click();
				}
			}
	
		});
		
		function addPartner(ptnr_level, ptnr_type, ptnr_group_order, ptnr_order){
			
			location.href = "ptnrAddPage?level="+ptnr_level+"&type="+ptnr_type+"&gOrder="+ptnr_group_order+"&order="+ptnr_order;
			
		}
		
		function delPartner(ptnr_id, ptnr_type){
			
			$.post("./ptnrDel",
					{	
						ptnr_id : ptnr_id,
						ptnr_type : ptnr_type
					},
					function(data,status){
						if(data != 0){
							alert("보험사 상태가 변경 되었습니다.");
							location.href = "topPtrMng?fromPage="+ptnr_type;
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}
			);//post			
		}
		
		function goDeptDtl(ptnr_id, ptnr_type){
			
			location.href = "ptnrDeptPage?ptnr_id="+ptnr_id+"&type="+ptnr_type;
			
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
								<li class="on" ><a href="#" id = "loss">손해 보험</a></li>
								<li ><a href="#" id = "life">생명 보험</a></li>
								<li ><a href="#" id = "orga">협회</a></li>
								<li ><a href="#" id = "gongjea">공제</a></li>
								<li ><a href="#" id = "other">기타</a></li>
							</ul>
						</div>
						<div class="guestcnt4" style="display:block;">
							<div class= "tableStyle2">
								<table>
									<thead>
										<tr>
											<th width="5%">번호</th>
											<th width="35%">사명</th>
											<th width="6%">통계적용</th>
											<th width="6%">심사표시</th>
											<th width="10%">로고</th>
											<!-- <th width="8%">인원</th> -->
											<th width="6%">자료</th>
											<th width="10%">문자발송항목</th>
											<th width="6%">계산서</th>
											<th width="6%">입금은행</th>
											<th width="10%">비고</th>
										</tr>
									</thead>
									<tbody>
										<!-- 출력 시작 -->
										<c:forEach items="${ptnrtList}" var="ptVo">
										<c:if test="${ptVo.ptnr_type eq 1}">
											<c:choose>
												<c:when  test="${ptVo.ptnr_level eq 0}">
													<tr style = "background:#E5EBFF;">
														<td>${ptVo.ptnr_id}</td>
														<td>
															<c:choose>
																<c:when test="${fromPage ne 'dept'}">
																	<a href="topPtrUdt?id=${ptVo.ptnr_id}"><b>${ptVo.ptnr_name}</b></a>
																</c:when>
																<c:otherwise>
																	<b>${ptVo.ptnr_name}</b>
																</c:otherwise>
															</c:choose>
														</td>
														<td></td>
														<td></td>
														<td></td>
														<!-- <td></td> -->
														<td></td>
														<td></td>
														<td></td>
														<td></td>
														<td>
															<c:choose>
																<c:when test="${fromPage ne 'dept'}">
																	<img src="./resources/ls_img/btn_add.gif"  style="cursor:pointer;" onclick="addPartner('${ptVo.ptnr_level}',1,'${ptVo.ptnr_group_order}','${ptVo.ptnr_order}');"/>
																</c:when>
																<c:otherwise>
																	<!-- todo -->
																</c:otherwise>
															</c:choose>
														</td>
													</tr>
												</c:when>
												<c:when  test="${ptVo.ptnr_level ne 0}">
													<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
														<td>${ptVo.ptnr_id}</td>
														<td>
															<c:choose>
																<c:when test="${fromPage ne 'dept'}">
																	<a href="topPtrUdt?id=${ptVo.ptnr_id}"><b>${ptVo.ptnr_name}</b></a>
																</c:when>
																<c:otherwise>
																	<b>${ptVo.ptnr_name}</b>
																</c:otherwise>
															</c:choose>
														</td>
														<td>${ptVo.statistics_yn}</td>
														<td>${ptVo.statistics_written_yn}</td>
														<td>
															<c:choose>
																<c:when test="${ptVo.ptnr_img_small != ''}">
																	<img src="${ptVo.imgStream_s}" width="50" height="16" alt="보험사 로고사진" />
																</c:when>
																<c:otherwise>
																	-
																</c:otherwise>
															</c:choose>
														</td>
														<!-- <td>인원</td> -->
														<td>자료</td>
														<td>
															<c:if test="${ptVo.ptnr_sms1 eq 1}">
																보험사
															</c:if>
															<c:if test="${ptVo.ptnr_sms2 eq 1}">
																조사자
															</c:if>
															<c:if test="${ptVo.ptnr_sms3 eq 1}">
																피보험자
															</c:if>
														</td>
														<td>
															<c:if test="${ptVo.issue_tax_invoice eq 0}">
																<font ><b>-</b></font>
															</c:if>
															<c:if test="${ptVo.issue_tax_invoice eq 1}">
																<font color="blue"><b>발행</b></font>
															</c:if>
														</td>
														<td>
															${ptVo.bank_title}
														</td>
														<td>
															<c:choose>
																<c:when test="${fromPage ne 'dept'}">
																	<%-- <img src="./resources/ls_img/btn_add.gif" style="cursor:pointer;" onclick="addPartner('${ptVo.ptnr_level}',1,'${ptVo.ptnr_group_order}','${ptVo.ptnr_order}');" /> --%>
																	<img src="./resources/ls_img/btn_del.gif"  style="cursor:pointer;" onclick="delPartner('${ptVo.ptnr_id}','${ptVo.ptnr_type}');"/>
																</c:when>
																<c:otherwise>
																	<img src="./resources/ls_img/member/btn_view.gif"  style="cursor:pointer;" onclick="goDeptDtl('${ptVo.ptnr_id}','${ptVo.ptnr_type}');"/>
																</c:otherwise>
															</c:choose>
															
														</td>
													</tr>
													
												</c:when>
											</c:choose>
											</c:if>
										</c:forEach>
										<!-- 출력 끝 -->
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
						</div><!-- //guestcnt4 -->
						<div class="guestcnt4" style="display:none;">
							<div class= "tableStyle2">
								<table>
									<thead>
										<tr>
											<th width="5%">번호</th>
											<th width="35%">사명</th>
											<th width="6%">통계적용</th>
											<th width="6%">심사표시</th>
											<th width="10%">로고</th>
											<!-- <th width="8%">인원</th> -->
											<th width="6%">자료</th>
											<th width="10%">문자발송항목</th>
											<th width="6%">계산서</th>
											<th width="6%">입금은행</th>
											<th width="10%">비고</th>
										</tr>
									</thead>
									<tbody>
										<!-- 출력 시작 -->
										<c:forEach items="${ptnrtList}" var="ptVo">
										<c:if test="${ptVo.ptnr_type eq 2}">
											<c:choose>
												<c:when  test="${ptVo.ptnr_level eq 0}">
													<tr style = "background:#E5EBFF;">
														<td>${ptVo.ptnr_id}</td>
														<td>
															<c:choose>
																<c:when test="${fromPage ne 'dept'}">
																	<a href="topPtrUdt?id=${ptVo.ptnr_id}"><b>${ptVo.ptnr_name}</b></a>
																</c:when>
																<c:otherwise>
																	<b>${ptVo.ptnr_name}</b>
																</c:otherwise>
															</c:choose>
														</td>
														<td></td>
														<td></td>
														<td></td>
														<!-- <td></td> -->
														<td></td>
														<td></td>
														<td></td>
														<td></td>
														<td>
															<c:choose>
																<c:when test="${fromPage ne 'dept'}">
																	<img src="./resources/ls_img/btn_add.gif" style="cursor:pointer;" onclick="addPartner('${ptVo.ptnr_level}',2,'${ptVo.ptnr_group_order}','${ptVo.ptnr_order}');"/>
																</c:when>
																<c:otherwise>
																	<!-- todo -->
																</c:otherwise>
															</c:choose>
														</td>
													</tr>
												</c:when>
												<c:when  test="${ptVo.ptnr_level ne 0}">
													<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
														<td>${ptVo.ptnr_id}</td>
														<td>
															<c:choose>
																<c:when test="${fromPage ne 'dept'}">
																	<a href="topPtrUdt?id=${ptVo.ptnr_id}"><b>${ptVo.ptnr_name}</b></a>
																</c:when>
																<c:otherwise>
																	<b>${ptVo.ptnr_name}</b>
																</c:otherwise>
															</c:choose>
														</td>
														<td>${ptVo.statistics_yn}</td>
														<td>${ptVo.statistics_written_yn}</td>
														<td>
															<c:choose>
																<c:when test="${ptVo.ptnr_img_small != ''}">
																	<img src="${ptVo.imgStream_s}" width="50" height="16" alt="보험사 로고사진" />
																</c:when>
																<c:otherwise>
																	-
																</c:otherwise>
															</c:choose>
														</td>
														<!-- <td>인원</td> -->
														<td>자료</td>
														<td>
															<c:if test="${ptVo.ptnr_sms1 eq 1}">
																보험사
															</c:if>
															<c:if test="${ptVo.ptnr_sms2 eq 1}">
																조사자
															</c:if>
															<c:if test="${ptVo.ptnr_sms3 eq 1}">
																피보험자
															</c:if>
														</td>
														<td>
															<c:if test="${ptVo.issue_tax_invoice eq 0}">
																<font ><b>-</b></font>
															</c:if>
															<c:if test="${ptVo.issue_tax_invoice eq 1}">
																<font color="blue"><b>발행</b></font>
															</c:if>
														</td>
														<td>
															${ptVo.bank_title}
														</td>
														<td>
															<c:choose>
																<c:when test="${fromPage ne 'dept'}">
																	<%-- <img src="./resources/ls_img/btn_add.gif" style="cursor:pointer;" onclick="addPartner('${ptVo.ptnr_level}',2,'${ptVo.ptnr_group_order}','${ptVo.ptnr_order}');"/> --%>
																	<img src="./resources/ls_img/btn_del.gif"  style="cursor:pointer;" onclick="delPartner('${ptVo.ptnr_id}','${ptVo.ptnr_type}');"/>
																</c:when>
																<c:otherwise>
																	<img src="./resources/ls_img/member/btn_view.gif"  style="cursor:pointer;" onclick="goDeptDtl('${ptVo.ptnr_id}','${ptVo.ptnr_type}');"/>
																</c:otherwise>
															</c:choose>
															
														</td>
													</tr>
													
												</c:when>
											</c:choose>
											</c:if>
										</c:forEach>
										<!-- 출력 끝 -->
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
						</div>
						<div class="guestcnt4" style="display:none;">
							<div class= "tableStyle2">
								<table>
									<thead>
										<tr>
											<th width="5%">번호</th>
											<th width="35%">사명</th>
											<th width="6%">통계적용</th>
											<th width="6%">심사표시</th>
											<th width="10%">로고</th>
											<!-- <th width="8%">인원</th> -->
											<th width="6%">자료</th>
											<th width="10%">문자발송항목</th>
											<th width="6%">계산서</th>
											<th width="6%">입금은행</th>
											<th width="10%">비고</th>
										</tr>
									</thead>
									<tbody>
										<!-- 출력 시작 -->
										<c:forEach items="${ptnrtList}" var="ptVo">
										<c:if test="${ptVo.ptnr_type eq 3}">
											<c:choose>
												<c:when  test="${ptVo.ptnr_level eq 0}">
													<tr style = "background:#E5EBFF;">
														<td>${ptVo.ptnr_id}</td>
														<td>
															<c:choose>
																<c:when test="${fromPage ne 'dept'}">
																	<a href="topPtrUdt?id=${ptVo.ptnr_id}"><b>${ptVo.ptnr_name}</b></a>
																</c:when>
																<c:otherwise>
																	<b>${ptVo.ptnr_name}</b>
																</c:otherwise>
															</c:choose>
														</td>
														<td></td>
														<td></td>
														<td></td>
														<!-- <td></td> -->
														<td></td>
														<td></td>
														<td></td>
														<td></td>
														<td>
															<c:choose>
																<c:when test="${fromPage ne 'dept'}">
																	<img src="./resources/ls_img/btn_add.gif" style="cursor:pointer;" onclick="addPartner('${ptVo.ptnr_level}',3,'${ptVo.ptnr_group_order}','${ptVo.ptnr_order}');"/>
																</c:when>
																<c:otherwise>
																	<!-- todo -->
																</c:otherwise>
															</c:choose>
														</td>
													</tr>
												</c:when>
												<c:when  test="${ptVo.ptnr_level ne 0}">
													<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
														<td>${ptVo.ptnr_id}</td>
														<td>
															<c:choose>
																<c:when test="${fromPage ne 'dept'}">
																	<a href="topPtrUdt?id=${ptVo.ptnr_id}"><b>${ptVo.ptnr_name}</b></a>
																</c:when>
																<c:otherwise>
																	<b>${ptVo.ptnr_name}</b>
																</c:otherwise>
															</c:choose>
														</td>
														<td>${ptVo.statistics_yn}</td>
														<td>${ptVo.statistics_written_yn}</td>
														<td>
															<c:choose>
																<c:when test="${ptVo.ptnr_img_small != ''}">
																	<img src="${ptVo.imgStream_s}" width="50" height="16" alt="보험사 로고사진" />
																</c:when>
																<c:otherwise>
																	-
																</c:otherwise>
															</c:choose>
														</td>
														<!-- <td>인원</td> -->
														<td>자료</td>
														<td>
															<c:if test="${ptVo.ptnr_sms1 eq 1}">
																보험사
															</c:if>
															<c:if test="${ptVo.ptnr_sms2 eq 1}">
																조사자
															</c:if>
															<c:if test="${ptVo.ptnr_sms3 eq 1}">
																피보험자
															</c:if>
														</td>
														<td>
															<c:if test="${ptVo.issue_tax_invoice eq 0}">
																<font ><b>-</b></font>
															</c:if>
															<c:if test="${ptVo.issue_tax_invoice eq 1}">
																<font color="blue"><b>발행</b></font>
															</c:if>
														</td>
														<td>
															${ptVo.bank_title}
														</td>
														<td>
															<c:choose>
																<c:when test="${fromPage ne 'dept'}">
																	<%-- <img src="./resources/ls_img/btn_add.gif" style="cursor:pointer;" onclick="addPartner('${ptVo.ptnr_level}',3,'${ptVo.ptnr_group_order}','${ptVo.ptnr_order}');"/> --%>
																	<img src="./resources/ls_img/btn_del.gif"  style="cursor:pointer;" onclick="delPartner('${ptVo.ptnr_id}','${ptVo.ptnr_type}');"/>
																</c:when>
																<c:otherwise>
																	<img src="./resources/ls_img/member/btn_view.gif"  style="cursor:pointer;" onclick="goDeptDtl('${ptVo.ptnr_id}','${ptVo.ptnr_type}');"/>
																</c:otherwise>
															</c:choose>
															
														</td>
													</tr>
													
												</c:when>
											</c:choose>
											</c:if>
										</c:forEach>
										<!-- 출력 끝 -->
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
						</div>
						<div class="guestcnt4" style="display:none;">
							<div class= "tableStyle2">
								<table>
									<thead>
										<tr>
											<th width="5%">번호</th>
											<th width="35%">사명</th>
											<th width="6%">통계적용</th>
											<th width="6%">심사표시</th>
											<th width="10%">로고</th>
											<!-- <th width="8%">인원</th> -->
											<th width="6%">자료</th>
											<th width="10%">문자발송항목</th>
											<th width="6%">계산서</th>
											<th width="6%">입금은행</th>
											<th width="10%">비고</th>
										</tr>
									</thead>
									<tbody>
										<!-- 출력 시작 -->
										<c:forEach items="${ptnrtList}" var="ptVo">
										<c:if test="${ptVo.ptnr_type eq 4}">
											<c:choose>
												<c:when  test="${ptVo.ptnr_level eq 0}">
													<tr style = "background:#E5EBFF;">
														<td>${ptVo.ptnr_id}</td>
														<td>
															<c:choose>
																<c:when test="${fromPage ne 'dept'}">
																	<a href="topPtrUdt?id=${ptVo.ptnr_id}"><b>${ptVo.ptnr_name}</b></a>
																</c:when>
																<c:otherwise>
																	<b>${ptVo.ptnr_name}</b>
																</c:otherwise>
															</c:choose>
														</td>
														<td></td>
														<td></td>
														<td></td>
														<!-- <td></td> -->
														<td></td>
														<td></td>
														<td></td>
														<td></td>
														<td>
															<c:choose>
																<c:when test="${fromPage ne 'dept'}">
																	<img src="./resources/ls_img/btn_add.gif" style="cursor:pointer;" onclick="addPartner('${ptVo.ptnr_level}',4,'${ptVo.ptnr_group_order}','${ptVo.ptnr_order}');"/>
																</c:when>
																<c:otherwise>
																	<!-- todo -->
																</c:otherwise>
															</c:choose>
														</td>
													</tr>
												</c:when>
												<c:when  test="${ptVo.ptnr_level ne 0}">
													<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
														<td>${ptVo.ptnr_id}</td>
														<td>
															<c:choose>
																<c:when test="${fromPage ne 'dept'}">
																	<a href="topPtrUdt?id=${ptVo.ptnr_id}"><b>${ptVo.ptnr_name}</b></a>
																</c:when>
																<c:otherwise>
																	<b>${ptVo.ptnr_name}</b>
																</c:otherwise>
															</c:choose>
														</td>
														<td>${ptVo.statistics_yn}</td>
														<td>${ptVo.statistics_written_yn}</td>
														<td>
															<c:choose>
																<c:when test="${ptVo.ptnr_img_small != ''}">
																	<img src="${ptVo.imgStream_s}" width="50" height="16" alt="보험사 로고사진" />
																</c:when>
																<c:otherwise>
																	-
																</c:otherwise>
															</c:choose>
														</td>
														<!-- <td>인원</td> -->
														<td>자료</td>
														<td>
															<c:if test="${ptVo.ptnr_sms1 eq 1}">
																보험사
															</c:if>
															<c:if test="${ptVo.ptnr_sms2 eq 1}">
																조사자
															</c:if>
															<c:if test="${ptVo.ptnr_sms3 eq 1}">
																피보험자
															</c:if>
														</td>
														<td>
															<c:if test="${ptVo.issue_tax_invoice eq 0}">
																<font ><b>-</b></font>
															</c:if>
															<c:if test="${ptVo.issue_tax_invoice eq 1}">
																<font color="blue"><b>발행</b></font>
															</c:if>
														</td>
														<td>
															${ptVo.bank_title}
														</td>
														<td>
															<c:choose>
																<c:when test="${fromPage ne 'dept'}">
																	<%-- <img src="./resources/ls_img/btn_add.gif" style="cursor:pointer;" onclick="addPartner('${ptVo.ptnr_level}',4,'${ptVo.ptnr_group_order}','${ptVo.ptnr_order}');" /> --%>
																	<img src="./resources/ls_img/btn_del.gif"  style="cursor:pointer;" onclick="delPartner('${ptVo.ptnr_id}','${ptVo.ptnr_type}');"/>																	
																</c:when>
																<c:otherwise>
																	<img src="./resources/ls_img/member/btn_view.gif"  style="cursor:pointer;" onclick="goDeptDtl('${ptVo.ptnr_id}','${ptVo.ptnr_type}');"/>
																</c:otherwise>
															</c:choose>
															
														</td>
													</tr>
													
												</c:when>
											</c:choose>
											</c:if>
										</c:forEach>
										<!-- 출력 끝 -->
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
						</div>
						
						<div class="guestcnt4" style="display:none;">
							<div class= "tableStyle2">
								<table>
									<thead>
										<tr>
											<th width="5%">번호</th>
											<th width="35%">사명</th>
											<th width="6%">통계적용</th>
											<th width="6%">심사표시</th>
											<th width="10%">로고</th>
											<!-- <th width="8%">인원</th> -->
											<th width="6%">자료</th>
											<th width="10%">문자발송항목</th>
											<th width="6%">계산서</th>
											<th width="6%">입금은행</th>
											<th width="10%">비고</th>
										</tr>
									</thead>
									<tbody>
										<!-- 출력 시작 -->
										<c:forEach items="${ptnrtList}" var="ptVo">
										<c:if test="${ptVo.ptnr_type eq 5}">
											<c:choose>
												<c:when  test="${ptVo.ptnr_level eq 0}">
													<tr style = "background:#E5EBFF;">
														<td>${ptVo.ptnr_id}</td>
														<td>
															<c:choose>
																<c:when test="${fromPage ne 'dept'}">
																	<a href="topPtrUdt?id=${ptVo.ptnr_id}"><b>${ptVo.ptnr_name}</b></a>
																</c:when>
																<c:otherwise>
																	<b>${ptVo.ptnr_name}</b>
																</c:otherwise>
															</c:choose>
														</td>
														<td></td>
														<td></td>
														<td></td>
														<!-- <td></td> -->
														<td></td>
														<td></td>
														<td></td>
														<td></td>
														<td>
															<c:choose>
																<c:when test="${fromPage ne 'dept'}">
																	<img src="./resources/ls_img/btn_add.gif" style="cursor:pointer;" onclick="addPartner('${ptVo.ptnr_level}',5,'${ptVo.ptnr_group_order}','${ptVo.ptnr_order}');" />
																</c:when>
																<c:otherwise>
																	<!-- todo -->
																</c:otherwise>
															</c:choose>
															
														</td>
													</tr>
												</c:when>
												<c:when  test="${ptVo.ptnr_level ne 0}">
													<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
														<td>${ptVo.ptnr_id}</td>
														<td>
															<c:choose>
																<c:when test="${fromPage ne 'dept'}">
																	<a href="topPtrUdt?id=${ptVo.ptnr_id}"><b>${ptVo.ptnr_name}</b></a>
																</c:when>
																<c:otherwise>
																	<b>${ptVo.ptnr_name}</b>
																</c:otherwise>
															</c:choose>
														</td>
														<td>${ptVo.statistics_yn}</td>
														<td>${ptVo.statistics_written_yn}</td>
														<td>
															<c:choose>
																<c:when test="${ptVo.ptnr_img_small != ''}">
																	<img src="${ptVo.imgStream_s}" width="50" height="16" alt="보험사 로고사진" />
																</c:when>
																<c:otherwise>
																	-
																</c:otherwise>
															</c:choose>
														</td>
														<!-- <td>인원</td> -->
														<td>자료</td>
														<td>
															<c:if test="${ptVo.ptnr_sms1 eq 1}">
																보험사
															</c:if>
															<c:if test="${ptVo.ptnr_sms2 eq 1}">
																조사자
															</c:if>
															<c:if test="${ptVo.ptnr_sms3 eq 1}">
																피보험자
															</c:if>
														</td>
														<td>
															<c:if test="${ptVo.issue_tax_invoice eq 0}">
																<font ><b>-</b></font>
															</c:if>
															<c:if test="${ptVo.issue_tax_invoice eq 1}">
																<font color="blue"><b>발행</b></font>
															</c:if>
														</td>
														<td>
															${ptVo.bank_title}
														</td>
														<td>
															<c:choose>
																<c:when test="${fromPage ne 'dept'}">
																	<%-- <img src="./resources/ls_img/btn_add.gif" style="cursor:pointer;" onclick="addPartner('${ptVo.ptnr_level}',5,'${ptVo.ptnr_group_order}','${ptVo.ptnr_order}');" /> --%>
																	<img src="./resources/ls_img/btn_del.gif"  style="cursor:pointer;" onclick="delPartner('${ptVo.ptnr_id}','${ptVo.ptnr_type}');"/>
																</c:when>
																<c:otherwise>
																	<img src="./resources/ls_img/member/btn_view.gif"  style="cursor:pointer;" onclick="goDeptDtl('${ptVo.ptnr_id}','${ptVo.ptnr_type}');"/>
																</c:otherwise>
															</c:choose>
														</td>
													</tr>
												</c:when>
											</c:choose>
											</c:if>
										</c:forEach>
										<!-- 출력 끝 -->
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
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
