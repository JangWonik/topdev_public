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
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/vertical.css" />
	
	<script src="./resources/jquery/jquery.min_1_12.js"></script>	
	<script src="./resources/wm_js/common.js"></script>
	
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	
	<script>
		/* function goMmrState(team_id){
			location.href = "topMemberState?team_id="+team_id;
		} */
		$(document).ready(function(){
			//직원명부 - 직원검색 탭눌렀을때 처리
			$("#searchTab").click(function(){
				$("#searchStr").focus();
			});			
		});
		
		function excMemberTel(gubun){
			$("#gubun").val(gubun);
			excelTelForm.submit();
		}		
		
		//1종 부문 Modal
		function sectorList1Modal(){
			
			$("#sector-1-dialog").dialog({
				height: 300,
				width: 500,
				closeOnEscape : true,
				draggable : false,					
				title: "1종 부문 목록",
				buttons:{						
					"닫기" : function(){
						$(this).dialog("close");
					}
				},
				modal: true,
				overlay:{ opacity: 0., background: '#000000'}
			});
			
		}
		
		//1종 센터 Modal
		function centerList1Modal(){
			
			$("#center-1-dialog").dialog({
				height: 620,
				width: 500,
				closeOnEscape : true,
				draggable : false,					
				title: "1종 센터 목록",
				buttons:{						
					"닫기" : function(){
						$(this).dialog("close");
					}
				},
				modal: true,
				overlay:{ opacity: 0., background: '#000000'}
			});
			
		}
		
		//1종 실무팀 Modal
		function part1List1Modal(){
			
			$("#part1-1-dialog").dialog({
				height: 620,
				width: 500,
				closeOnEscape : true,
				draggable : false,					
				title: "1종 실무팀 목록",
				buttons:{						
					"닫기" : function(){
						$(this).dialog("close");
					}
				},
				modal: true,
				overlay:{ opacity: 0., background: '#000000'}
			});
			
		}
		
		//1종 지원팀 Modal
		function part2List1Modal(){
			
			$("#part2-1-dialog").dialog({
				height: 300,
				width: 500,
				closeOnEscape : true,
				draggable : false,					
				title: "1종 지원(파트)팀 목록",
				buttons:{						
					"닫기" : function(){
						$(this).dialog("close");
					}
				},
				modal: true,
				overlay:{ opacity: 0., background: '#000000'}
			});
			
		}
		
		//4종 부문 Modal
		function sectorList4Modal(){
			
			$("#sector-4-dialog").dialog({
				height: 300,
				width: 500,
				closeOnEscape : true,
				draggable : false,					
				title: "4종 부문 목록",
				buttons:{						
					"닫기" : function(){
						$(this).dialog("close");
					}
				},
				modal: true,
				overlay:{ opacity: 0., background: '#000000'}
			});
			
		}
		
		//4종 센터 Modal
		function centerList4Modal(){
			
			$("#center-4-dialog").dialog({
				height: 350,
				width: 500,
				closeOnEscape : true,
				draggable : false,					
				title: "4종 센터 목록",
				buttons:{						
					"닫기" : function(){
						$(this).dialog("close");
					}
				},
				modal: true,
				overlay:{ opacity: 0., background: '#000000'}
			});
			
		}
		
		//4종 실무팀 Modal
		function part1List4Modal(){
			
			$("#part1-4-dialog").dialog({
				height: 620,
				width: 500,
				closeOnEscape : true,
				draggable : false,					
				title: "4종 실무팀 목록",
				buttons:{						
					"닫기" : function(){
						$(this).dialog("close");
					}
				},
				modal: true,
				overlay:{ opacity: 0., background: '#000000'}
			});
			
		}
		
		//4종 지원팀 Modal
		function part2List4Modal(){
			
			$("#part2-4-dialog").dialog({
				height: 300,
				width: 500,
				closeOnEscape : true,
				draggable : false,					
				title: "4종 지원(파트)팀 목록",
				buttons:{						
					"닫기" : function(){
						$(this).dialog("close");
					}
				},
				modal: true,
				overlay:{ opacity: 0., background: '#000000'}
			});
			
		}
		
	</script>
	<style>
		.tableStyle2 td {letter-spacing: 0;}
	</style>
</head>

<body>
<!-- 모달창 시작 -->
<div id="sector-1-dialog" title="1종 부문목록" style="font-size: 15px;display:none;" align="center">
	<br/>
	<div class="tableStyle2" style="width: 450px;">
		<table class="vacation-ins-table">									
			<tbody>													
				<tr>
					<th width="30%">순번</th>
					<th width="70%">부문 명</th>											
				</tr>
			</tbody>
			<c:forEach items="${sectorList1}" var="tm1SectorVo" varStatus="status">
				<tr>
					<td>${status.count}</td>
					<td>${tm1SectorVo.sector_name}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>

<div id="center-1-dialog" title="1종 센터목록" style="font-size: 15px;display:none;" align="center">
	<br/>
	<div class="tableStyle2" style="width: 450px;">
		<table class="vacation-ins-table">									
			<tbody>													
				<tr>
					<th width="30%">순번</th>
					<th width="70%">센터 명</th>											
				</tr>
			</tbody>
			<c:forEach items="${centerList1}" var="tm1CenterVo" varStatus="status">
				<tr>
					<td>${status.count}</td>
					<td>${tm1CenterVo.center_name}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>

<div id="part1-1-dialog" title="1종 실무팀 목록" style="font-size: 15px;display:none;" align="center">
	<br/>
	<div class="tableStyle2" style="width: 450px;">
		<table class="vacation-ins-table">									
			<tbody>													
				<tr>
					<th width="30%">순번</th>
					<th width="70%">팀 명</th>											
				</tr>
			</tbody>
			<c:forEach items="${partBy1List1}" var="tm1Part1Vo" varStatus="status">
				<tr>
					<td>${status.count}</td>
					<td>${tm1Part1Vo.team_name}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>

<div id="part2-1-dialog" title="1종 지원팀(파트) 목록" style="font-size: 15px;display:none;" align="center">
	<br/>
	<div class="tableStyle2" style="width: 450px;">
		<table class="vacation-ins-table">									
			<tbody>													
				<tr>
					<th width="30%">순번</th>
					<th width="70%">팀(파트) 명</th>											
				</tr>
			</tbody>
			<c:forEach items="${partBy2List1}" var="tm1Part2Vo" varStatus="status">
				<tr>
					<td>${status.count}</td>
					<td>${tm1Part2Vo.team_name}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>

<div id="sector-4-dialog" title="4종 부문목록" style="font-size: 15px;display:none;" align="center">
	<br/>
	<div class="tableStyle2" style="width: 450px;">
		<table class="vacation-ins-table">									
			<tbody>													
				<tr>
					<th width="30%">순번</th>
					<th width="70%">부문 명</th>											
				</tr>
			</tbody>
			<c:forEach items="${sectorList4}" var="tm4SectorVo" varStatus="status">
				<tr>
					<td>${status.count}</td>
					<td>${tm4SectorVo.sector_name}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>

<div id="center-4-dialog" title="4종 센터목록" style="font-size: 15px;display:none;" align="center">
	<br/>
	<div class="tableStyle2" style="width: 450px;">
		<table class="vacation-ins-table">									
			<tbody>													
				<tr>
					<th width="30%">순번</th>
					<th width="70%">센터 명</th>											
				</tr>
			</tbody>
			<c:forEach items="${centerList4}" var="tm4CenterVo" varStatus="status">
				<tr>
					<td>${status.count}</td>
					<td>${tm4CenterVo.center_name}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>

<div id="part1-4-dialog" title="4종 실무팀 목록" style="font-size: 15px;display:none;" align="center">
	<br/>
	<div class="tableStyle2" style="width: 450px;">
		<table class="vacation-ins-table">									
			<tbody>													
				<tr>
					<th width="30%">순번</th>
					<th width="70%">팀 명</th>											
				</tr>
			</tbody>
			<c:forEach items="${partBy1List4}" var="tm4Part1Vo" varStatus="status">
				<tr>
					<td>${status.count}</td>
					<td>${tm4Part1Vo.team_name}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>

<div id="part2-4-dialog" title="4종 지원팀(파트) 목록" style="font-size: 15px;display:none;" align="center">
	<br/>
	<div class="tableStyle2" style="width: 450px;">
		<table class="vacation-ins-table">									
			<tbody>													
				<tr>
					<th width="30%">순번</th>
					<th width="70%">팀(파트) 명</th>											
				</tr>
			</tbody>
			<c:forEach items="${partBy2List4}" var="tm4Part2Vo" varStatus="status">
				<tr>
					<td>${status.count}</td>
					<td>${tm4Part2Vo.team_name}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>
<!-- 모달창 끝 -->

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
								<li id="searchTab"><a href="#">직원명부 - 직원검색</a></li>
								<li class="on"><a href="#">직원명부 - 전체</a></li>
								<li><a href="#">직원명부 - 본사사업부</a></li>
								<li><a href="#">직원명부 - 1종사업부</a></li>
								<li><a href="#">직원명부 - 4종사업부</a></li>
							</ul>
						</div>
						
						<!-- search -->
						<div class="guestcnt_1300_ds" style="display:none;">
							<c:import url="../top_general/emp_nmlst_search.jsp"></c:import>
						</div>
						<!-- //search -->
						
						<div class="guestcnt_1300_ds" style="display:block;">
							<c:import url="./emp_nmlst_tm_list_all.jsp"></c:import>
						</div>
						
						
						<div class="guestcnt_1300_ds" style="display:none;">
							<div class= "tableStyle2">
								<!-- 엑셀 다운 -->
								<div style="margin-top:5px">
									<img src="./resources/ls_img/ls_invoice/btn_excel.gif" style='cursor:pointer;' onclick="excMemberTel('kind0')" align="right" />
								</div>
								<!-- //엑셀 다운 -->
								<table style="margin-top:30px">
									<c:forEach items="${teamList_head}" var="tmVo">
										<c:choose>
									
											<c:when  test="${tmVo.team_level eq 0}">
												<tr style = "background:#E5EBFF;">
													<td width="15%"><b>${tmVo.team_name}</b></td>
													<td width="15%"></td>
													<td width="50%"></td>
													<td width="10%">
														<c:choose>
															<c:when test="${tmVo.cnt ne '-'}">
																${tmVo.cnt - tmVo.sub_cnt} 명
															</c:when>
															<c:otherwise> - 명</c:otherwise>
														</c:choose>
														<c:if test="${tmVo.sub_cnt > 0}"> (${tmVo.cnt} 명)</c:if>
													</td>
													<td width="10%"></td>
												</tr>
											</c:when>
											<c:when  test="${tmVo.team_level ne 0}">
												<c:if test="${tmVo.cnt ne '-'}">
													<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
														<td>
														<c:if test="${tmVo.team_level eq 2}">└</c:if>
														${tmVo.team_name}</td>
														<td>${tmVo.team_telephone}</td>
														<td>${tmVo.team_addr}</td>
														<td>
															<c:choose>
																<c:when test="${tmVo.cnt ne '-'}">
																	${tmVo.cnt - tmVo.sub_cnt} 명
																</c:when>
																<c:otherwise> - 명</c:otherwise>
															</c:choose>
															<c:if test="${tmVo.sub_cnt > 0}"> (${tmVo.cnt} 명)</c:if>
														</td>
														<td><a href="./empNmlstTmDtl?team_id=${tmVo.team_id}"><img src="./resources/ls_img/member/btn_view.gif"/></a></td>
													</tr>
												</c:if>
											</c:when>
										</c:choose>
									</c:forEach>
								</table>
							</div><!-- //tableStyle2 -->
						</div><!-- //guestcnt4 -->

						<!-- 1종사업부 -->
						<div class="guestcnt_1300_ds" style="display:none;">
							<div class= "tableStyle2">
								<!-- 엑셀 다운 -->
								<div style="margin-top:5px">
									<img src="./resources/ls_img/ls_invoice/btn_excel.gif" style='cursor:pointer;' onclick="excMemberTel('kind1')" align="right" />
								</div>
								<!-- //엑셀 다운 -->
								
								<!-- 1종 팀 요약 시작 -->
								<div id="teamSummary1"  style="margin-top:30px">
									<table>
										<tr>
											<th>부문 수</th>
											<th>센터 수</th>
											<th>실무팀 수</th>
											<th>지원팀(파트) 수</th>
										</tr>
										<tr>
											<td onclick="javascript:sectorList1Modal();" style="cursor:pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${sectorList1.size()}</td>
											<td onclick="javascript:centerList1Modal();" style="cursor:pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${centerList1.size()}</td>
											<td onclick="javascript:part1List1Modal();" style="cursor:pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${partBy1List1.size()}</td>
											<td onclick="javascript:part2List1Modal();" style="cursor:pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${partBy2List1.size()}</td>											
										</tr>
									</table>
								</div>
								<!-- 1종 팀 요약 끝 -->
								
								<table style="margin-top:10px">
										<c:forEach items="${teamList_1}" var="tmVo">
											<c:choose>
												<c:when  test="${tmVo.team_level eq 0}">
													<tr style = "background:#E5EBFF;">
														<td width="15%"><b>${tmVo.team_name}</b></td>
														<td width="15%"></td>
														<td width="50%"></td>
														<td width="10%">
															<c:choose>
																<c:when test="${tmVo.cnt ne '-'}">
																	${tmVo.cnt - tmVo.sub_cnt} 명
																</c:when>
																<c:otherwise> - 명</c:otherwise>
															</c:choose>
															<c:if test="${tmVo.sub_cnt > 0}"> (${tmVo.cnt} 명)</c:if>
														</td>
														<td width="10%"></td>
													</tr>
												</c:when>
												<c:when  test="${tmVo.team_level ne 0}">
													<c:if test="${tmVo.cnt ne '-'}">
														<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
															<td>
															<c:if test="${tmVo.team_level eq 2}">└</c:if>
															${tmVo.team_name}</td>
															<td>${tmVo.team_telephone}</td>
															<td>${tmVo.team_addr}</td>
															<td>
																<c:choose>
																	<c:when test="${tmVo.cnt ne '-'}">
																		${tmVo.cnt - tmVo.sub_cnt} 명
																	</c:when>
																	<c:otherwise> - 명</c:otherwise>
																</c:choose>
																<c:if test="${tmVo.sub_cnt > 0}"> (${tmVo.cnt} 명)</c:if>
															</td>
															<td><a href="./empNmlstTmDtl?team_id=${tmVo.team_id}"><img src="./resources/ls_img/member/btn_view.gif" style="cursor:pointer;"/></a></td>
														</tr>
													</c:if>
												</c:when>
											</c:choose>
										</c:forEach>
									</table>
							</div><!-- //tableStyle2 -->
						</div><!-- //guestcnt4 -->
						<!-- //1종사업부 -->

						<!-- 4종사업부 -->
						<div class="guestcnt_1300_ds" style="display:none;">
							<div class= "tableStyle2">
								<!-- 엑셀 다운 -->
								<div style="margin-top:5px">
									<img src="./resources/ls_img/ls_invoice/btn_excel.gif" style='cursor:pointer;' onclick="excMemberTel('kind4')" align="right" />
								</div>
								<!-- //엑셀 다운 -->
								
								<!-- 4종 팀 요약 시작 -->
								<div id="teamSummary4"  style="margin-top:30px">
									<table>
										<tr>
											<th>부문 수</th>
											<th>센터 수</th>
											<th>실무팀 수</th>
											<th>지원팀(파트) 수</th>
										</tr>
										<tr>
											<td onclick="javascript:sectorList4Modal();" style="cursor:pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${sectorList4.size()}</td>
											<td onclick="javascript:centerList4Modal();" style="cursor:pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${centerList4.size()}</td>
											<td onclick="javascript:part1List4Modal();" style="cursor:pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${partBy1List4.size()}</td>
											<td onclick="javascript:part2List4Modal();" style="cursor:pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${partBy2List4.size()}</td>
										</tr>
									</table>
								</div>
								<!-- 4종 팀 요약 끝 -->
								
								<table style="margin-top:10px">
										<c:forEach items="${teamList_4}" var="tmVo">
											<c:choose>
												<c:when  test="${tmVo.team_level eq 0}">
													<tr style = "background:#F7E6CF;">
														<td width="15%"><b>${tmVo.team_name}</b></td>
														<td width="15%"></td>
														<td width="50%"></td>
														<td width="10%">
														<c:choose>
															<c:when test="${tmVo.cnt ne '-'}">
																${tmVo.cnt - tmVo.sub_cnt} 명
															</c:when>
															<c:otherwise> - 명</c:otherwise>
														</c:choose>
														<c:if test="${tmVo.sub_cnt > 0}"> (${tmVo.cnt} 명)</c:if>
														</td>
														<td width="10%"></td>
													</tr>
												</c:when>
												<c:when  test="${tmVo.team_level ne 0}">
													<c:if test="${tmVo.cnt ne '-'}">
														<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
															<td>
															<c:if test="${tmVo.team_level eq 2}">└</c:if>
															${tmVo.team_name}</td>
															<td>${tmVo.team_telephone}</td>
															<td>${tmVo.team_addr}</td>
															<td>
																<c:choose>
																	<c:when test="${tmVo.cnt ne '-'}">
																		${tmVo.cnt - tmVo.sub_cnt} 명
																	</c:when>
																	<c:otherwise> - 명</c:otherwise>
																</c:choose>
																<c:if test="${tmVo.sub_cnt > 0}"> (${tmVo.cnt} 명)</c:if>
															</td>
															<td><a href="./empNmlstTmDtl?team_id=${tmVo.team_id}"><img src="./resources/ls_img/member/btn_view.gif" style="cursor:pointer;"/></a></td>
														</tr>
													</c:if>
												</c:when>
											</c:choose>
										</c:forEach>

									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
						</div><!-- //guestcnt4 -->
						<!-- //4종사업부 -->


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
