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
	
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css?v=20170411111520" />
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/><!-- calendar -->
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/><!-- calendar -->
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/><!-- calendar -->
	
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
    <script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
    <script src="./resources/ne_js/calendar.js?v=20170321111520"></script><!-- calendar -->

    <script src="./resources/wm_js/common.js"></script>
    <script src="./resources/cmm/js/common.js"></script>

	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>
	
	<script>
		$(document).ready(function(){
			if('${mbrAuthVo_Session.user_no}' == null || ('${mbrAuthVo_Session.mbr_pms_14}' == 0 && '${mbrAuthVo_Session.mbr_pms_15}' == 0)){
				window.location.assign("./logout");
			}

			$.ajaxSetup({cache:false});
			
			//지역별 카운트 내 보험사 호출시작 (지역 : 본사(0) ~ 제주(13), 신설동(3)이 추가되어 지역코드가 한개씩 밀림)
			var zoneVals;
			var temps_1;
			var temps_1_val;
			var temps_4;
			var temps_4_val;
			var temps_4_2_val;
			var temps_4_3_val;
			var temps_4_4_val;
			
			for( zoneVals = 0; zoneVals < 15; zoneVals++ ){
				temps_1 = "teamZone_"+zoneVals+"_1";			  
				temps_1_val = $("#"+temps_1).val();				//지역별 물보험 심사자 수 (합계값)
				
				if( temps_1_val > 0 ){										//지역별 물보험 심사자 수가 0이 아닌경우 보험사별 테이블을 불러온다.
					
					getZonePtnr1Table( zoneVals, temps_1, temps_1_val );						//물보험심사 보험사 테이블을 불러온다.
					
				}
				
			}
			
			for( zoneVals = 0; zoneVals < 15; zoneVals++ ){
				temps_4 = "teamZone_"+zoneVals+"_4";			  
				temps_4_val = $("#"+temps_4).val();				//지역별 인보험 심사자 수 (합계값)
				
				temps_4_2_val = $("#"+temps_4+"_2").val();				//지역별 인보험 일반 심사자 수
				temps_4_3_val = $("#"+temps_4+"_3").val();				//지역별 인보험 일반 심사자 수
				temps_4_4_val = $("#"+temps_4+"_4").val();				//지역별 인보험 일반 심사자 수
				
				if( temps_4_val > 0 ){										//지역별 인보험 심사자 수가 0이 아닌경우 보험사별 테이블을 불러온다.
					
					getZonePtnr4Table( zoneVals, temps_4, temps_4_val, temps_4_2_val, temps_4_3_val, temps_4_4_val );						//인보험심사 보험사 테이블을 불러온다.
					
				}
				
			}
			
			//보험사별 지역 심사자 통계 시작
			var ptnrVals;
			var temps_ptnr_id;											//보험사 아이디
			var temps_ptnr_id_1_2_val;
			var temps_ptnr_id_4_2_val;
			var temps_ptnr_id_4_3_val;
			var temps_ptnr_id_4_4_val;
			var temps_ptnr_id_sum_val;
			
			var ptnr_id_cnt = ${ptnrStatCalList.size()};
			
			for( ptnrVals = 0; ptnrVals < ptnr_id_cnt; ptnrVals++ ){
				temps_ptnr_id = $("#ptnrId_"+ptnrVals).val();
				temps_ptnr_id_1_2_val = $("#ptnrId_"+ptnrVals+"_1_2").val();
				temps_ptnr_id_4_2_val = $("#ptnrId_"+ptnrVals+"_4_2").val();
				temps_ptnr_id_4_3_val = $("#ptnrId_"+ptnrVals+"_4_3").val();
				temps_ptnr_id_4_4_val = $("#ptnrId_"+ptnrVals+"_4_4").val();
				temps_ptnr_id_sum_val = $("#ptnrId_"+ptnrVals+"_sum").val();
				//console.log( temps_ptnr_id + " : "+ temps_ptnr_id_1_2_val + " : "+ temps_ptnr_id_4_2_val + " : " +temps_ptnr_id_4_3_val + " : "+ temps_ptnr_id_4_4_val + " : " + temps_ptnr_id_sum_val);
				
				if( temps_ptnr_id_sum_val > 0 ){
					//보험사 별 지역 심사자 통계를 불러온다. 
					getPtnrToZoneTable( ptnrVals, temps_ptnr_id, temps_ptnr_id_1_2_val, temps_ptnr_id_4_2_val, temps_ptnr_id_4_3_val, temps_ptnr_id_4_4_val );
					
				}
				
			}
			

		});//$(document).ready
		
		function getPtnrToZoneTable( p_index, p_ptnr_id, p_ptnr_1_2, p_ptnr_4_2, p_ptnr_4_3, p_ptnr_4_4 ){
			
			var url = "./insaInsuZoneStatTable";		//보험사별 지역 심사자 테이블
			
			var param = {};
			param.ptnr_id = p_ptnr_id;
			param.member_1_2_sum = p_ptnr_1_2;
			param.member_4_2_sum = p_ptnr_4_2;
			param.member_4_3_sum = p_ptnr_4_3;
			param.member_4_4_sum = p_ptnr_4_4;
			
			$.ajax({
				type: "POST",
				url: url,
				data: param,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				timeout: 20000,
				dataType: "HTML",				
				success: function(data){						
						$("#div_ptnrId_"+p_index).html(data);						
					},
					error: function(e){
					    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
					}
					
			    });			
			
		}
		
		function getZonePtnr1Table( p_zone, p_div, p_member_sum ){			

			var url = "./insaZoneInsu1StatTable";		//물보험 지역별 보험사 테이블
			
			var param = {};			
			param.team_zone = p_zone;
			param.member_sum = p_member_sum;
			
			$.ajax({
				type: "POST",
				url: url,
				data: param,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				timeout: 20000,
				dataType: "HTML",				
				success: function(data){						
						$("#div_"+p_div).html(data);						
					},
					error: function(e){
					    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
					}
					
			    });
			
		}
		
		function getZonePtnr4Table( p_zone, p_div, p_member_sum, p_member_2_sum, p_member_3_sum, p_member_4_sum ){
			
			var url = "./insaZoneInsu4StatTable";		//인보험 지역별 보험사 테이블
			
			var param = {};			
			param.team_zone = p_zone;
			param.member_sum = p_member_sum;
			param.member_2_sum = p_member_2_sum;
			param.member_3_sum = p_member_3_sum;
			param.member_4_sum = p_member_4_sum;
			
			$.ajax({
				type: "POST",
				url: url,
				data: param,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				timeout: 20000,
				dataType: "HTML",				
				success: function(data){						
						$("#div_"+p_div).html(data);						
					},
					error: function(e){
					    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
					}
					
			    });			
			
		}
		
		//직무별 통계 모달창 열기
		function openModalWorkjob( p_type, p_workjob, p_title ){
			
			var url = "./insaMemberStatModal";
			
			var param = {};
			param.teamType = p_type;	
			param.workJob = p_workjob;
			param.modalTitle = p_title;
			
			$.ajax({
			type: "POST",
			url: url,
			data: param,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			timeout: 20000,
			dataType: "HTML", 
			success: function(data){
				$("#workjob-modal-dialog").html();
				$("#workjob-modal-dialog").html(data);
					$("#workjob-modal-dialog").dialog({
						height: 600,
						width: 900,
						closeOnEscape : true,
						draggable : true,
						title: "직무별 세부인원 조회",
						modal: true,
						buttons:{							
							"닫기" : function(){
								$(this).dialog("close");
							}
						},
						overlay:{ opacity: 0., background: '#000000'}
					});		
				},
				error: function(e){
				    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
				}
				
		    });
			
		}
		
		//지역별, 보험사별 인원 Modal
		function openModalDetail( p_type, p_zone, p_ptnr_id, p_total_cnt , p_work_type){
			
			var url = "./insaMemberDetailStatModal";
			
			var param = {};
			param.teamType = p_type;
			param.teamZone = p_zone;
			param.teamPtnrId = p_ptnr_id;
			param.totalCnt = p_total_cnt;
			param.workJob = p_work_type;
			
			$.ajax({
				type: "POST",
				url: url,
				data: param,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				timeout: 20000,
				dataType: "HTML", 
				success: function(data){
					$("#workjob-modal-dialog").html();
					$("#workjob-modal-dialog").html(data);
						$("#workjob-modal-dialog").dialog({
							height: 600,
							width: 900,
							closeOnEscape : true,
							draggable : true,
							title: "세부인원 조회",
							modal: true,
							buttons:{							
								"닫기" : function(){
									$(this).dialog("close");
								}
							},
							overlay:{ opacity: 0., background: '#000000'}
						});		
					},
					error: function(e){
					    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
					}					
			});
			
		}
		
		//현황통계 엑셀 다운로드
		function fnInsaMemberTotalExcel(){
			location.href="topInsaStatMain?doExcel=1";	
		}
		
	</script>
	
	<style>
		.tableStyle2 td {letter-spacing: 0;}
		.btn-vacation-aprv {
			font-weight:bold;
			text-decoration:none;
			font-family:Arial;
			text-indent:0px;
			line-height:0px;
			-moz-border-radius:5px;
			-webkit-border-radius:5px;
			border-radius:5px;
			text-align:center;
			vertical-align:middle;
			display:inline-block;
			font-size:12px;
			color:#696969  !important;
			width:60px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #eeeeee;
		}
		
		/* 모달창 셀렉트 박스 */
		.select2-container--default{
			text-align : left;
			font-color:#444;
			font-size:12px;
		}
		
		.buttonDiaAll{
			width:150px;
			height:23px;
		    background-color:#4a6b86;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 12px;
		    cursor: pointer;
		    font-weight: bold;
		    text-decoration:none;
		    border: none;
		    }
		    
		.buttonDiaAll:hover{
			background-color:#FFA500;
			}
		
		.tableStyle2.tableStyle2 th, .tableStyle2 td {height:35px;padding:0 0 0 0;line-height:18px;}		
		
		.guest .guestcnt_1300_dx {display:block;margin-top:10px;padding:0 0 10px 0;} 
	</style>
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
			<div class="center_cnt_1300_ds">
				<!-- centercnt_bot -->
				<div class="centercnt_1300_bot1-2_ds">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on" id="workjobTab"><a href="#">직무별 (전체)</a></li>
								<li id="zoneTab"><a href="#">지역별 (조사+심사)</a></li>
								<li id="ptnrTab"><a href="#">보험사별 (심사)</a></li>																
							</ul>
						</div>
						<!-- <div style="position:absolute;right:20px;top:15px;">
							<input title="현황통계통합다운로드" class="buttonDiaAll" id="allNonBtn" onclick="fnInsaMemberTotalExcel()" type="button" value="현황통계 통합 다운로드">
						</div> -->
						<!-- 검색 탭 -->
						<div class="guestcnt0" id="workjobView" style="display:block;padding-top:10px;">							
							<c:set var="sum_work_job_cnt_1" value="${workjobStatMap.work_job_cnt_1_1 + workjobStatMap.work_job_cnt_1_2 + workjobStatMap.work_job_cnt_1_5}"></c:set>
							<c:set var="sum_work_job_cnt_4" value="${workjobStatMap.work_job_cnt_4_1 + workjobStatMap.work_job_cnt_4_2 + workjobStatMap.work_job_cnt_4_3 + workjobStatMap.work_job_cnt_4_4 + workjobStatMap.work_job_cnt_4_5}"></c:set>							
							<div class= "tableStyle2">								
								<table>
									<thead>
										<tr>
											<th>구분</th>
											<th style="border-right:2px solid #cfcfcf;">물보험</th>
											<th>인보험</th>
											<th><font color="green">합계<br/>(물보험+인보험)</font></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<th>조사</th>
											<td style="border-right:2px solid #cfcfcf;">
												<c:choose>
													<c:when test="${workjobStatMap.work_job_cnt_1_1 > 0}">
														<a href="#" onclick="javascript:openModalWorkjob(1,1,'물보험 조사')">
															${workjobStatMap.work_job_cnt_1_1}
														</a>
													</c:when>
													<c:otherwise>0</c:otherwise>
												</c:choose>												
											</td>
											<td>
												<c:choose>
													<c:when test="${workjobStatMap.work_job_cnt_4_1 > 0}">
														<a href="#" onclick="javascript:openModalWorkjob(4,1,'인보험 조사')">
															${workjobStatMap.work_job_cnt_4_1}
														</a>
													</c:when>
													<c:otherwise>0</c:otherwise>
												</c:choose>												
											</td>
											<th>
												<font color="green">
													${workjobStatMap.work_job_cnt_1_1 + workjobStatMap.work_job_cnt_4_1}
												</font>
											</th>
										</tr>
										<tr>
											<th>심사 (일반)</th>
											<td style="border-right:2px solid #cfcfcf;">
												<c:choose>
													<c:when test="${workjobStatMap.work_job_cnt_1_2 > 0}">
														<a href="#" onclick="javascript:openModalWorkjob(1,2,'물보험 심사 (일반)')">
															${workjobStatMap.work_job_cnt_1_2}
														</a>
													</c:when>
													<c:otherwise>0</c:otherwise>
												</c:choose>												
											</td>
											<td>
												<c:choose>
													<c:when test="${workjobStatMap.work_job_cnt_4_2 > 0}">
														<a href="#" onclick="javascript:openModalWorkjob(4,2,'인보험 심사 (일반)')">
															${workjobStatMap.work_job_cnt_4_2}
														</a>
													</c:when>
													<c:otherwise>0</c:otherwise>
												</c:choose>												
											</td>
											<th>
												<font color="green">
													${workjobStatMap.work_job_cnt_1_2 + workjobStatMap.work_job_cnt_4_2}
												</font>
											</th>
										</tr>
										<tr>
											<th>심사 (간편)</th>
											<td style="border-right:2px solid #cfcfcf;">0</td>
											<td>
												<c:choose>
													<c:when test="${workjobStatMap.work_job_cnt_4_3 > 0}">
														<a href="#" onclick="javascript:openModalWorkjob(4,3,'인보험 심사 (간편)')">
															${workjobStatMap.work_job_cnt_4_3}
														</a>
													</c:when>
													<c:otherwise>0</c:otherwise>
												</c:choose>												
											</td>
											<th>
												<font color="green">
													${workjobStatMap.work_job_cnt_4_3}
												</font>
											</th>
										</tr>
										<tr>
											<th>심사 (정보입력)</th>
											<td style="border-right:2px solid #cfcfcf;">0</td>
											<td>
												<c:choose>
													<c:when test="${workjobStatMap.work_job_cnt_4_4 > 0}">
														<a href="#" onclick="javascript:openModalWorkjob(4,4,'인보험 심사 (정보입력)')">
															${workjobStatMap.work_job_cnt_4_4}
														</a>
													</c:when>
													<c:otherwise>0</c:otherwise>
												</c:choose>												
											</td>
											<th>
												<font color="green">
													${workjobStatMap.work_job_cnt_4_4}
												</font>
											</th>
										</tr>
										<tr>
											<th>업무지원</th>
											<td style="border-right:2px solid #cfcfcf;">
												<c:choose>
													<c:when test="${workjobStatMap.work_job_cnt_1_5 > 0}">
														<a href="#" onclick="javascript:openModalWorkjob(1,5,'물보험 업무지원')">
															${workjobStatMap.work_job_cnt_1_5}
														</a>
													</c:when>
													<c:otherwise>0</c:otherwise>
												</c:choose>
											</td>
											<td>
												<c:choose>
													<c:when test="${workjobStatMap.work_job_cnt_4_5 > 0}">
														<a href="#" onclick="javascript:openModalWorkjob(4,5,'인보험 업무지원')">
															${workjobStatMap.work_job_cnt_4_5}
														</a>
													</c:when>
													<c:otherwise>0</c:otherwise>
												</c:choose>
											</td>
											<th>
												<font color="green">
													${workjobStatMap.work_job_cnt_1_5 + workjobStatMap.work_job_cnt_4_5}
												</font>
											</th>
										</tr>
										<tr>
											<th>임원</th>
											<td colspan="2"></td>
											<%-- <td style="border-right:2px solid #cfcfcf;">
												<c:choose>
													<c:when test="${workjobStatMap.work_job_cnt_1_6 > 0}">
														<a href="#" onclick="javascript:openModalWorkjob(1,6,'물보험 임원')">
															${workjobStatMap.work_job_cnt_1_6}
														</a>
													</c:when>
													<c:otherwise>0</c:otherwise>
												</c:choose>
											</td>
											<td>
												<c:choose>
													<c:when test="${workjobStatMap.work_job_cnt_4_6 > 0}">
														<a href="#" onclick="javascript:openModalWorkjob(4,6,'인보험 임원')">
															${workjobStatMap.work_job_cnt_4_6}
														</a>
													</c:when>
													<c:otherwise>0</c:otherwise>
												</c:choose>
											</td>
											--%>
											<th>
												<font color="green">
													${workjobStatMap.work_job_cnt_1_6 + workjobStatMap.work_job_cnt_4_6}
												</font>
											</th> 
										</tr>										
										<tr>
											<th><font color="blue">구분 합계</font></th>
											<th style="border-right:2px solid #cfcfcf;"><font color="blue">${sum_work_job_cnt_1}</font></th>
											<th><font color="blue">${sum_work_job_cnt_4}</font></th>
											<th><font color="green">${sum_work_job_cnt_1 + workjobStatMap.work_job_cnt_1_6 + sum_work_job_cnt_4 + workjobStatMap.work_job_cnt_4_6}</font></th>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						
						<!-- 지역 별 탭 -->
						<div class="guestcnt0" id="zoneView" style="display:none;padding-top:10px;">
							<div class= "tableStyle2">
								<table>
									<thead>
										<tr>
											<th rowspan="3">지역</th>
											<th style="border-right:2px solid #cfcfcf;" colspan="4">물보험</th>
											<th colspan="7">인보험</th>
											<th rowspan="3"><font color="green">합계<br/>(물보험<br/>+인보험)</font></th>
											<th width="16px;" rowspan="3"></th>
										</tr>
										<tr>
											<th rowspan="2">조사</th>
											<th colspan="2">심사</th>
											<th rowspan="2" style="border-right:2px solid #cfcfcf;"><font color="blue">합계<br/>(물보험)</font></th>
											<th rowspan="2">조사</th>
											<th colspan="5">심사</th>
											<th rowspan="2" style="line-height:18px;"><font color="blue">합계<br/>(인보험)</font></th>											
										</tr>
										<tr>
											<th>보험사</th>											
											<th>일반</th>											
											<th>보험사</th>																
											<th>일반</th>
											<th>간편</th>
											<th>정보입력</th>
											<th>합계<br/>(심사)</th>
										</tr>
									</thead>
								</table>
								<div style="height: 600px; -ms-overflow-x: hidden !important; overflow-y: auto;">
									<table>
										<tbody>
											<c:forEach items="${zoneStatCalList}" var = "teamZone" varStatus="teamZoneStatus">											
												<tr>												
													<th>${teamZone.team_zone_val}</th>
													<td>	
														<c:choose>
															<c:when test="${teamZone.work_job_cnt_1_1 eq 0}"><b>0</b></c:when>
															<c:otherwise>
																<a href="#" onclick="javascript:openModalDetail( 1, ${teamZone.team_zone} , '' , ${teamZone.work_job_cnt_1_1}, 1 );">											
																	<b>${teamZone.work_job_cnt_1_1}</b>
																</a>		
															</c:otherwise>
														</c:choose>
													</td>													
													<c:choose>
														<c:when test="${teamZone.work_job_cnt_1_2 eq 0}">
															<td>-</td>
															<td>0</td>
														</c:when>
														<c:otherwise>
															<td colspan="2" valign="top">
																<div id="div_teamZone_${teamZone.team_zone}_1"></div>
																<input type="hidden" id="teamZone_${teamZone.team_zone}_1" value="${teamZone.work_job_cnt_1_2}"/>			
															</td>
														</c:otherwise>
													</c:choose>
													<td style="border-right:2px solid #cfcfcf;"><font color="blue">${teamZone.work_job_cnt_1_sum}</font></td>
													<td>
														<a href="#" onclick="javascript:openModalDetail( 4, ${teamZone.team_zone} , '' , ${teamZone.work_job_cnt_4_1}, 1 );">
															<b>${teamZone.work_job_cnt_4_1}</b>
														</a>
													</td>
													<c:choose>
														<c:when test="${teamZone.work_job_cnt_4_2+teamZone.work_job_cnt_4_3+teamZone.work_job_cnt_4_4 eq 0}">
															<td>-</td>
															<td>0</td>
															<td>0</td>
															<td>0</td>
															<td>0</td>															
														</c:when>														
														<c:otherwise>
															<td width="480px" colspan="5" valign="top">
																<div id="div_teamZone_${teamZone.team_zone}_4"></div>
																<input type="hidden" id="teamZone_${teamZone.team_zone}_4" value="${teamZone.work_job_cnt_4_2+teamZone.work_job_cnt_4_3+teamZone.work_job_cnt_4_4}"/>
																<input type="hidden" id="teamZone_${teamZone.team_zone}_4_2" value="${teamZone.work_job_cnt_4_2}">
																<input type="hidden" id="teamZone_${teamZone.team_zone}_4_3" value="${teamZone.work_job_cnt_4_3}">
																<input type="hidden" id="teamZone_${teamZone.team_zone}_4_4" value="${teamZone.work_job_cnt_4_4}">																												
															</td>															
														</c:otherwise>
													</c:choose>
													<td><font color="blue">${teamZone.work_job_cnt_4_sum}</font></td>
													<td><font color="green">${teamZone.work_job_cnt_1_sum + teamZone.work_job_cnt_4_sum}</font></td>													
												</tr>
												<c:set var="sum_zone_work_job_cnt_1_1" value="${sum_zone_work_job_cnt_1_1 + teamZone.work_job_cnt_1_1}"></c:set>
												<c:set var="sum_zone_work_job_cnt_1_2" value="${sum_zone_work_job_cnt_1_2 + teamZone.work_job_cnt_1_2}"></c:set>
												<c:set var="sum_zone_work_job_cnt_4_1" value="${sum_zone_work_job_cnt_4_1 + teamZone.work_job_cnt_4_1}"></c:set>
												<c:set var="sum_zone_work_job_cnt_4_2" value="${sum_zone_work_job_cnt_4_2 + teamZone.work_job_cnt_4_2}"></c:set>
												<c:set var="sum_zone_work_job_cnt_4_3" value="${sum_zone_work_job_cnt_4_3 + teamZone.work_job_cnt_4_3}"></c:set>
												<c:set var="sum_zone_work_job_cnt_4_4" value="${sum_zone_work_job_cnt_4_4 + teamZone.work_job_cnt_4_4}"></c:set>
												
												<c:set var="sum_zone_work_job_cnt_1" value="${sum_zone_work_job_cnt_1 + teamZone.work_job_cnt_1_sum}"></c:set>
												<c:set var="sum_zone_work_job_cnt_4" value="${sum_zone_work_job_cnt_4 + teamZone.work_job_cnt_4_sum}"></c:set>																								
											</c:forEach>
												<tr>
													<th><font color="blue">합계</font></th>
													<th><font color="blue">${sum_zone_work_job_cnt_1_1}</font></th>
													<th></th>
													<th><font color="blue">${sum_zone_work_job_cnt_1_2}</font></th>
													<th style="border-right:2px solid #cfcfcf;"><font color="blue">${sum_zone_work_job_cnt_1}</font></th>												
													<th><font color="blue">${sum_zone_work_job_cnt_4_1}</font></th>
													<th></th>
													<th><font color="blue">${sum_zone_work_job_cnt_4_2}</font></th>
													<th><font color="blue">${sum_zone_work_job_cnt_4_3}</font></th>
													<th><font color="blue">${sum_zone_work_job_cnt_4_4}</font></th>
													<th><font color="blue">${sum_zone_work_job_cnt_4_2 + sum_zone_work_job_cnt_3_4 + sum_zone_work_job_cnt_4_4}</font></th>
													<th><font color="blue">${sum_zone_work_job_cnt_4}</font></th>
													<th><font color="green">${sum_zone_work_job_cnt_1+sum_zone_work_job_cnt_4}</font></th>												
												</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						
						<!-- 보험사 별 탭 -->
						<div class="guestcnt0" id="ptnrView" style="display:none;padding-top:10px;">
							<div class= "tableStyle2">
								<table>
									<thead>
										<tr>
											<th rowspan="2">보험사</th>
											<th rowspan="2" style="border-right:2px solid #cfcfcf;">지역</th>
											<th rowspan="2" style="border-right:2px solid #cfcfcf;">물보험(심사)</th>
											<th colspan="4" style="border-right:2px solid #cfcfcf;">인보험(심사)</th>
											<th rowspan="3"><font color="green">합계<br/>(물보험(심사)<br/>+인보험(심사))</font></th>
											<th width="15px" rowspan="3"></th>
										</tr>
										<tr>
											<th>일반</th>
											<th>간편</th>
											<th>정보입력</th>
											<th style="border-right:2px solid #cfcfcf;">합계<br/>(심사)</th>											
										</tr>
									</thead>
								</table>							
								<div style="height: 600px; -ms-overflow-x: hidden !important; overflow-y: auto;">								
									<table>
										<tbody>
											<c:forEach items="${ptnrStatCalList}" var = "teamPtnr" varStatus="teamPtnrStatus">											
												<tr>												
													<th>${teamPtnr.team_ptnr_id_val}</th>
													<c:choose>
														<c:when test="${teamPtnr.work_job_cnt_1_2 + teamPtnr.work_job_cnt_4_2 + teamPtnr.work_job_cnt_4_3 +teamPtnr.work_job_cnt_4_4 eq 0}">
															<td>-</td>
															<td>0</td>
															<td>0</td>
															<td>0</td>
															<td>0</td>
															<td>0</td>
															<td><font color="green">0</font></td>
														</c:when>
														<c:otherwise>
															<td colspan="6" valign="top">
																<div id="div_ptnrId_${teamPtnrStatus.index}"></div>
																<input type="hidden" id="ptnrId_${teamPtnrStatus.index}" value="${teamPtnr.team_ptnr_id}"/>
																<input type="hidden" id="ptnrId_${teamPtnrStatus.index}_sum" value="${teamPtnr.work_job_cnt_1_2 + teamPtnr.work_job_cnt_4_2 + teamPtnr.work_job_cnt_4_3 +teamPtnr.work_job_cnt_4_4}"/>															
																<input type="hidden" id="ptnrId_${teamPtnrStatus.index}_1_2" value="${teamPtnr.work_job_cnt_1_2}">
																<input type="hidden" id="ptnrId_${teamPtnrStatus.index}_4_2" value="${teamPtnr.work_job_cnt_4_2}">
																<input type="hidden" id="ptnrId_${teamPtnrStatus.index}_4_3" value="${teamPtnr.work_job_cnt_4_3}">
																<input type="hidden" id="ptnrId_${teamPtnrStatus.index}_4_4" value="${teamPtnr.work_job_cnt_4_4}">															
															</td>
														</c:otherwise>
													</c:choose>													
												</tr>											
												<c:set var="sum_ptnr_work_job_cnt_1_2" value="${sum_ptnr_work_job_cnt_1_2 + teamPtnr.work_job_cnt_1_2}"></c:set>											
												<c:set var="sum_ptnr_work_job_cnt_4_2" value="${sum_ptnr_work_job_cnt_4_2 + teamPtnr.work_job_cnt_4_2}"></c:set>
												<c:set var="sum_ptnr_work_job_cnt_4_3" value="${sum_ptnr_work_job_cnt_4_3 + teamPtnr.work_job_cnt_4_3}"></c:set>
												<c:set var="sum_ptnr_work_job_cnt_4_4" value="${sum_ptnr_work_job_cnt_4_4 + teamPtnr.work_job_cnt_4_4}"></c:set>											
											</c:forEach>
												<tr>
													<th colspan="2" style="border-right:2px solid #cfcfcf;"><font color="blue">보험사 합계</font></th>																									
													<th style="border-right:2px solid #cfcfcf;"><font color="blue">${sum_ptnr_work_job_cnt_1_2}</font></th>												
													<th><font color="blue">${sum_ptnr_work_job_cnt_4_2}</font></th>
													<th><font color="blue">${sum_ptnr_work_job_cnt_4_3}</font></th>
													<th><font color="blue">${sum_ptnr_work_job_cnt_4_4}</font></th>
													<th style="border-right:2px solid #cfcfcf;"><font color="blue">${sum_ptnr_work_job_cnt_4_2 + sum_ptnr_work_job_cnt_4_3 + sum_ptnr_work_job_cnt_4_4}</font></th>
													<th><font color="green">${sum_ptnr_work_job_cnt_1_2 + sum_ptnr_work_job_cnt_4_2 +sum_ptnr_work_job_cnt_4_3 + sum_ptnr_work_job_cnt_4_4}</font></th>												
												</tr>
										</tbody>
									</table>								
								</div>
							</div>
					</div>
				</div>
				
				<!-- 카드 Action Modal 시작 -->
				<%-- <c:import url="/card_manage_modal"></c:import> --%>
				<!-- 카드 Action Modal 끝 -->
				
				<!-- <div id="card-detail-dialog" title="상세 보기" style="font-size: 15px;display:none;" align="center"></div> -->
				<!-- //centercnt_bot -->
				
				<!-- 직무별 세부인원 조회 Modal -->
				<div id="workjob-modal-dialog" title="직무별 세부인원 조회" style="font-size: 12px;" align="center"></div>

			</div>
			<!-- //center_cnt -->
		</div>
	</div>	
	<!-- //contents -->

	<!-- footer -->
	<c:import url="../top_main/top_main_footer.jsp"></c:import>
	<!-- //footer -->

</div>
</div>
<!-- //wrapper -->

</body>
</html>
