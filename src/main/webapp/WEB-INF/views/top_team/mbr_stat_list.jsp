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

// 			if('${action}' == 'fromTmState'){
//				$("#workTab").click();
// 			}
// 			if('${tab}' == '1'){
// 				$("#workTab").click();
// 			}
			if('${tab}' == '3'){
				$("#retireTab").click();
			}
			
			//사원검색 탭눌렀을때 처리
			$("#searchTab").click(function(){
				$("#searchStr").focus();
			});

			$("#memberSearchBtn").click(function(){
				
				//특수기호(') 콤마제거
				var paramSearchVal =  sqlRemoveText( $("#searchStr").val() );
				
				$.post("./topMemberSearch",
						{	ustat:$("#ustat").val()
							,tid:$("#tid").val()
							,searchStr:paramSearchVal
							,gid:$("#tid option:selected").text().indexOf("└")
						},
						function(data,status){
							$("#searchTbody").empty();
							if(status == "success"){
								if(data.length == 0){
									alert("검색 결과가 없습니다.");
								}else{
				                    $.each(data, function(index, entry) {
		                        		$("#searchTbody").append('<tr>'
												+"<td>"+entry.rownum+"</td>"
												+"<td>"+entry.center_name+"</td>"												
												+"<td>"+entry.team_name+"</td>"
												+"<td>"+entry.work_level+"</td>"
												+"<td>"+entry.work_rank+"</td>"
												+"<td>"+entry.work_type+"</td>"												
												+"<td title='"+entry.user_no+"'>"+entry.user_name+"</td>"												
												+"<td>"+entry.user_id+"</td>"
												+"<td>"+entry.join_date+"</td>"
												+"<td>"+entry.user_state+"</td>"
												+"<td>"+"<img src='./resources/ls_img/member/btn_view.gif' id='afterSearchBtn"+index+"' style='cursor:pointer;' /></td>"
		                                		+ '</tr>'
			   							);
		                        		$("#afterSearchBtn"+index).bind("click",function(){
		                        			popMbrDetail(entry.user_no);
		                        		});
									});//each
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						},"json"
				);//post
				
			});//$("#memberSearchBtn").click
		});//$(document).ready
		
		//사원검색입력창에 엔터키눌렀을때 action
		function enterKey(){
			if(event.keyCode == 13){				
				$("#memberSearchBtn").click();
			}
		}
				
		function popMbrDetail(user_no){
			
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			
			var sw=1500; //띄울 창의 넓이
			var sh=900;  //띄울 창의 높이

			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			
			
// 			window.open('popMemberDetail?user_no='+user_no,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			window.open('popMbrDetail?user_no='+user_no,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',scrollbars=yes,resizable=yes');
			
		}
		
		function excelTopMember(gubun){
			$("#gubun").val(gubun);
			$("#excelTopMemberForm").submit();
		}
		
		//카드 등록
		function popCardAdd( p_user_no, p_team_id ){						
			
			//등록폼 초기화
			$("#srchUserNo option:eq(0)").prop('selected', true);
			$("#tmSearch option:eq(0)").prop('selected', true);
			$("#srchCardType option:eq(0)").prop('selected', true);
			$("#srchCardState option:eq(0)").prop('selected', true);
			$("#srchCardZone option:eq(0)").prop('selected', true);
			$("#reg_date").val('');
			$("#card_number").val('');
			$("#card_uid").val('');
			$("#card_memo").val('');
			
			$("#srchUserNo").val(p_user_no);
			$("#srchUserNo").trigger("change");
			
			$("#tmSearch").val(p_team_id);
			$("#tmSearch").trigger("change");
			
			$("#card-action-dialog").dialog({
				height: 550,
				width: 800,
				closeOnEscape : true,
				draggable : true,
				appendTo : "#cardActionFrm",
				title: "카드 등록",
				buttons:{
					"카드 등록" : function(){
						var action = popCardAction('I');		//등록
						if (action){
							$(this).dialog("close");
						}						
					},
					"취소" : function(){
						$(this).dialog("close");
					}
				},
				modal: true,
				overlay:{ opacity: 0., background: '#000000'}
			});
			
			$("#srchUserNo").select2({
				dropdownParent: $("#card-action-dialog")	
			});
			
			$("#tmSearch").select2({
				dropdownParent: $("#card-action-dialog")	
			});
			
			$("#srchCardType").select2({
				dropdownParent: $("#card-action-dialog")	
			});
			
			$("#srchCardState").select2({
				dropdownParent: $("#card-action-dialog")	
			});
			
			$("#srchCardZone").select2({
				dropdownParent: $("#card-action-dialog")	
			});			
			
		}
		
		//퇴사자 카드 수정폼
		function popCardMod( p_ckey ){
			
			var sUrl = "get_card_info";
			
			var param = {};
			param.ckey = p_ckey;
			
			$.ajax({
		        type: "POST",
		        url: sUrl,
		        data: param,		         
		        dataType: "JSON", 
		        success: function(data){
	        		
	        		//수정폼 설정
	        		$("#ckey_val").val(data.ckey);
	    			$("#srchUserNo").val(data.user_no);
	    			$("#tmSearch").val(data.team_id);
	    			$("#srchCardType").val(data.card_type);
	    			$("#srchCardState").val(data.card_state);
	    			$("#srchCardZone").val(data.card_zone);
	    			$("#reg_date").val(data.reg_date);	    			
	    			$("#card_number").val(data.card_number);	    			
	    			$("#card_memo").val(data.card_memo);
	    			$("#card_uid").val(data.card_uid);
	        		
	    			$("#card-action-dialog").dialog({
	    				height: 550,
	    				width: 800,
	    				closeOnEscape : true,
	    				draggable : true,
	    				appendTo : "#cardActionFrm",
	    				title: "카드 수정",
	    				buttons:{
	    					"카드 삭제" : function(){
	    						var action = popCardAction('D');		//삭제
	    						if (action){
	    							$(this).dialog("close");
	    						}
	    					},
	    					"카드 수정" : function(){
	    						var action = popCardAction('U');		//수정
	    						if (action){
	    							$(this).dialog("close");
	    						}
	    					},
	    					"취소" : function(){
	    						$(this).dialog("close");
	    					}
	    				},
	    				modal: true,
	    				overlay:{ opacity: 0., background: '#000000'}
	    			});
	    			
	    			$("#srchUserNo").select2({
	    				dropdownParent: $("#card-action-dialog")	
	    			});
	    			
	    			$("#tmSearch").select2({
	    				dropdownParent: $("#card-action-dialog")	
	    			});
	    			
	    			$("#srchCardType").select2({
	    				dropdownParent: $("#card-action-dialog")	
	    			});
	    			
	    			$("#srchCardState").select2({
	    				dropdownParent: $("#card-action-dialog")	
	    			});
	    			
	    			$("#srchCardZone").select2({
	    				dropdownParent: $("#card-action-dialog")	
	    			});
	    			
		        },
		        error: function(e){
		            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		        }
		    });
		}
		
		//카드 정보조회
		function popCardDetail( p_ckey ){			
			
			var sUrl = "card_manage_modal_detail";
			
			var ckey = p_ckey;
			var param = {};
			param.ckey = ckey;		
			
			$.ajax({
				type: "POST",
				url: sUrl,
				data: param,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				timeout: 20000,
				dataType: "HTML", 
				success: function(data){
					$("#card-detail-dialog").html();				
					$("#card-detail-dialog").html(data);					
						$("#card-detail-dialog").dialog({
							height: 650,
							width: 800,
							closeOnEscape : true,
							draggable : true,
							title: "카드 정보 상세",
							buttons:{							
								"닫기" : function(){
									$(this).dialog("close");
								}
							},
							modal: true,
							overlay:{ opacity: 0., background: '#000000'}
						});		
				},
				error: function(e){
				    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
				}
			});
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
								<li id="searchTab"><a href="#">사원 검색</a></li>
								<li class="on" id="workTab"><a href="#">근무자</a></li>
								<li><a href="#">발령대기자</a></li>
								<li id="retireTab"><a href="#">퇴사자</a></li>
							</ul>
							
							<!-- 엑셀 다운을 위한 폼 -->
							<form name="excelTopMemberForm" id="excelTopMemberForm" action="excelTopMember" method="GET">
								<input type="hidden" id="gubun" name="gubun" />
							</form>
						</div>
						
						<%-- <c:import url="../include/top_mbr_state_search.jsp"></c:import> --%>
						
						<!-- 검색 탭 -->
						<div class="guestcnt_1300_ds" style="display:none;">
							<!-- 검색 테이블 시작-->
							<div class= "tableStyle2">
								<table>
									<thead>
										<tr>
											<th width="25%">재직상태</th>
											<th width="25%">팀명</th>
											<th width="35%">검색어 (이름 or 전화번호 or 아이디)</th>
											<th width="15%">검색</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>
												<select id="ustat">
													<option value="10" selected>전체(근무자/발령대기자/퇴사자)</option>
													<option value="0">근무자</option>
													<option value="3">휴직자</option>
													<option value="2">발령대기자</option>
													<option value="1">퇴사자</option>
													<option value="9">SA</option>
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
												<input type="text" id="searchStr" name="searchStr" size="50" onkeydown="javascript:enterKey();"/>
											</td>
											<td>
												<input type="image" src="./resources/ls_img/btn_src.gif" id="memberSearchBtn" />
											</td>
										</tr>
									</tbody>
								</table>
								<!-- 검색 테이블 끝-->
								
							</div><!-- //tableStyle2 -->
							<br />
							<div class= "tableStyle2">
								<!-- 검색 결과 테이블 시작-->
								<table>
									<thead>
										<tr>
											<th width="5%">No</th>
											<th width="12%">센터명</th>
											<th width="12%">부서명</th>
											<!-- 180108 직급/직책 에서 직위/직급으로 변경 -->
											<!-- 180108 직위/직급 에서 직위/직책으로 변경 -->
											<th>직위</th>
											<th>직급</th>
											<th>직책</th>
											<th>이름</th>
											<th>아이디</th>
											<th>입사일</th>
											<th>현재상태</th>
											<th>비고</th>
										</tr>
									</thead>
									<tbody id="searchTbody">
										<tr>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						
						<!-- 근무자 탭 -->
						<div  class="guestcnt_1300_ds" style="display:block;">							
							<span style="float:right; margin:5px;">
								<img src="./resources/ls_img/btn_excel.gif" style="cursor:pointer;" onclick="excelTopMember('work')"   />
							</span>
							<div class= "tableStyle2">
								<table>
									<thead>
										<tr>
											<th width="5%">No</th>
											<th width="12%">센터명</th>
											<c:choose>
												<c:when test="${orderFlag2 == null || orderFlag2 == '' || orderFlag2 == 1}">
													<th width="12%"><a href="./topMemberState?tab=1&team_id=${team_id}&orderFlag2=2">부서명</a></th>
												</c:when>
												<c:when test="${orderFlag2 == 2}">
													<th  width="12%"><a href="./topMemberState?tab=1&team_id=${team_id}&orderFlag2=1">부서명</a></th>
												</c:when>
											</c:choose>
											<!-- 180108 직급/직책 에서 직위/직급으로 변경 -->
											<c:choose>
												<c:when test="${orderFlag3 == null || orderFlag3 == '' || orderFlag3 == 1}">
													<th><a href="./topMemberState?tab=1&team_id=${team_id}&orderFlag3=2">직위</a></th>
												</c:when>
												<c:when test="${orderFlag3 == 2}">
													<th><a href="./topMemberState?tab=1&team_id=${team_id}&orderFlag3=1">직위</a></th>
												</c:when>
											</c:choose>
											
											<th>직급</th>
											
											<c:choose>
												<c:when test="${orderFlag4 == null || orderFlag4 == '' || orderFlag4 == 1}">
													<th><a href="./topMemberState?tab=1&team_id=${team_id}&orderFlag4=2">직책</a></th>
												</c:when>
												<c:when test="${orderFlag4 == 2}">
													<th><a href="./topMemberState?tab=1&team_id=${team_id}&orderFlag4=1">직책</a></th>
												</c:when>
											</c:choose>
											
											<c:choose>
												<c:when test="${orderFlag5 == null || orderFlag5 == '' || orderFlag5 == 1}">
													<th><a href="./topMemberState?tab=1&team_id=${team_id}&orderFlag5=2">이름</a></th>
												</c:when>
												<c:when test="${orderFlag5 == 2}">
													<th><a href="./topMemberState?tab=1&team_id=${team_id}&orderFlag5=1">이름</a></th>
												</c:when>
											</c:choose>
											<th>아이디</th>
											<c:choose>
												<c:when test="${orderFlag6 == null || orderFlag6 == '' || orderFlag6 == 1}">
													<th><a href="./topMemberState?tab=1&team_id=${team_id}&orderFlag6=2">입사일</a></th>
												</c:when>
												<c:when test="${orderFlag6 == 2}">
													<th><a href="./topMemberState?tab=1&team_id=${team_id}&orderFlag6=1">입사일</a></th>
												</c:when>
											</c:choose>
											<c:if test="${mbrVo_Session.user_state == 9}">
												<th>출입카드</th>
											</c:if>											
											<th>직원정보</th>
										</tr>
									</thead>
									<tbody>
									<c:choose>
										<c:when test="${workMemberList.size() ne 0 }">
											<c:forEach items="${workMemberList}" var = "memberVo" varStatus="workStatus">
												<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
													<td>${workMemberList.size() - workStatus.index}</td>
													<td>${memberVo.center_name}</td>
													<td>${memberVo.team_name}</td>
													<td>${memberVo.work_level}</td>
													<td>${memberVo.work_rank}</td>
													<td>${memberVo.work_type}</td>
													<td title="${memberVo.user_no}">${memberVo.user_name}</td>
													<td>${memberVo.user_id }</td>
													<td>${memberVo.join_date}</td>
													<c:if test="${mbrVo_Session.user_state == 9}">
														<td>															
															<c:choose>
																<c:when test="${memberVo.card_key eq 0}">
																	<a class="btn-vacation-aprv" id="btn-detail" style="background:#F3E2A9;width: 58px;" onclick="popCardAdd('${memberVo.user_no}','${memberVo.team_id_main}')" href="#noloc">카드등록</a>
																</c:when>
																<c:otherwise>
																	<a class="btn-vacation-aprv" id="btn-detail" style="background:#CEE3F6;width: 58px;" onclick="popCardDetail('${memberVo.card_key}')" href="#noloc">정보조회</a>
																</c:otherwise>
															</c:choose>
														</td>
													</c:if>
													<td>
														<c:choose>
															<c:when test="${(mbrAuthVo.mbr_pms_14 ne '0') && (mbrAuthVo.mbr_pms_15 ne '0')}">
																<%-- <img src="./resources/ls_img/member/btn_view.gif" style="cursor:pointer;" onclick="popMbrDetail('${memberVo.user_no}')"/> --%>
																<a class="btn-vacation-aprv" id="btn-detail" style="width: 58px;" onclick="popMbrDetail('${memberVo.user_no}')" href="#noloc">상세보기</a>
															</c:when>
															<c:otherwise>
																-
															</c:otherwise>
														</c:choose>
													</td>
												</tr>
											</c:forEach>
										</c:when>
										<c:otherwise>
												<tr>
													<td colspan="10"><b>근무자 없음</b></td>
												</tr>	
										</c:otherwise>
									</c:choose>
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->

							<!-- page start -->
							<!--<c:if test="${action != 'fromTmState'}">
								<p style="text-align:center;">
									<c:if test="${startPgNoInt1 > 10}">
										<a href="./${pgNm1}?reqPgNo=${startPgNoInt1 - 1}&tab=1">&lt;</a>
									</c:if>
									<c:forEach var="pageNo" begin="${startPgNoInt1}" end="${endPgNoInt1}" step="1">
										<c:choose>
											<c:when test="${reqPgNoInt1 != pageNo}">
												<a href="./${pgNm1}?reqPgNo=${pageNo}&tab=1"><c:out value="${pageNo}" /></a>
												&nbsp;&nbsp;
											</c:when>
											<c:otherwise>
												<font color="red"><c:out value="${pageNo}" /></font>
												&nbsp;&nbsp;
											</c:otherwise>
										</c:choose>
									</c:forEach>
									<c:if test="${totPgCntInt1 >= endPgNoInt1 + 1}">
										<a href="./${pgNm1}?reqPgNo=${endPgNoInt1 + 1}&tab=1">&gt;</a>
									</c:if>
								</p>
							</c:if>
							-->
							<!-- //page end -->
						</div><!-- //guestcnt4 -->
						
						<!-- 발령대기자 탭 -->
						<div class="guestcnt_1300_ds" style="display:none;">
							<span style="float:right; margin:5px;">
								<img src="./resources/ls_img/btn_excel.gif" style="cursor:pointer;" onclick="excelTopMember('standby')"   />
							</span>
							<div class= "tableStyle2">
								<table>
									<thead>
										<tr>
											<th width="5%">No</th>
											<th width="12%">센터명</th>
											<th width="12%">부서명</th>
											<!-- 180108 직급/직책 에서 직위/직급으로 변경 -->
											<!-- 180108 직위/직급 에서 직위/직책으로 변경 -->
											<th>직위</th>
											<th>직급</th>
											<th>직책</th>
											<th>이름</th>
											<th>아이디</th>
											<th>입사일</th>											
											<th>비고</th>
										</tr>
									</thead>
									<tbody>
									
									<c:choose>
										<c:when test="${pendingMemberList.size() ne 0 }">
											<c:forEach items="${pendingMemberList}" var = "memberVo">
												<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
													<td>${memberVo.rownum}</td>
													<td>${memberVo.center_name}</td>
													<td>${memberVo.team_name}</td>
													<td>${memberVo.work_level}</td>
													<td>${memberVo.work_rank}</td>
													<td>${memberVo.work_type}</td>																										
													<td>${memberVo.user_name}</td>
													<td>${memberVo.user_id }</td>
													<td>${memberVo.join_date}</td>													
													<td>
														<c:if test="${(mbrAuthVo.mbr_pms_14 ne '0') && (mbrAuthVo.mbr_pms_15 ne '0')}">
															<%-- <img src="./resources/ls_img/member/btn_view.gif" style="cursor:pointer;" onclick="popMbrDetail('${memberVo.user_no}')"/> --%>
															<a class="btn-vacation-aprv" id="btn-detail" style="width: 58px;" onclick="popMbrDetail('${memberVo.user_no}')" href="#noloc">상세보기</a>
														</c:if>
													</td>
												</tr>
											</c:forEach>
										</c:when>
										
										<c:otherwise>
												<tr>
													<td colspan="10"><b>발령대기자 없음</b></td>
												</tr>	
										</c:otherwise>
									</c:choose>
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
						</div>

						<!-- 퇴사자 탭 -->
						<div class="guestcnt_1300_ds" style="display:none;">
							<span style="float:right; margin:5px;">
								<img src="./resources/ls_img/btn_excel.gif" style="cursor:pointer;" onclick="excelTopMember('out')"   />
							</span>
							<div class= "tableStyle2">
								<table>
									<thead>
										<tr>
											<th width="5%">No</th>
											<th width="12%">센터명</th>
											<th width="12%">부서명</th>
											<!-- 180108 직급/직책 에서 직위/직급으로 변경 -->
											<!-- 180108 직위/직급 에서 직위/직책으로 변경 -->
											<th>직위</th>
											<th>직급</th>
											<th>직책</th>
											<th>이름</th>
											<th>아이디</th>
											<c:choose>
												<c:when test="${orderFlag == 1 || orderFlag == 2}">
													<th><a href="./topMemberState?tab=3&team_id=${team_id}&orderFlag=${orderFlag}">입사일</a></th>
													<th><a href="./topMemberState?tab=3&team_id=${team_id}&orderFlag=3">퇴사일</a></th>
												</c:when>
												<c:when test="${orderFlag == 3 || orderFlag == 4}">
													<th><a href="./topMemberState?tab=3&team_id=${team_id}&orderFlag=1">입사일</a></th>
													<th><a href="./topMemberState?tab=3&team_id=${team_id}&orderFlag=${orderFlag}">퇴사일</a></th>
												</c:when>
											</c:choose>
											<c:if test="${mbrVo_Session.user_state == 9}">
												<th>출입카드</th>
											</c:if>
											<th>비고</th>
										</tr>
									</thead>
									<tbody id="outTbody">
									<c:choose>
										<c:when test="${retireMemberList.size() ne 0 }">
											<c:forEach items="${retireMemberList}" var = "memberVo" varStatus="retireStatus">
												<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
													<td>${retireMemberList.size() - retireStatus.index}</td>
													<td>${memberVo.center_name}</td>
													<td>${memberVo.team_name}</td>
													<td>${memberVo.work_level}</td>
													<td>${memberVo.work_rank}</td>
													<td>${memberVo.work_type}</td>
													<td>${memberVo.user_name}</td>
													<td>${memberVo.user_id }</td>
													<td>${memberVo.join_date}</td>
													<td>${memberVo.out_date}</td>
													<c:if test="${mbrVo_Session.user_state == 9}">
														<td>															
															<c:choose>
																<c:when test="${memberVo.card_key eq 0}">
																	-
																</c:when>
																<c:otherwise>
																	<a class="btn-vacation-aprv" id="btn-detail" style="background:#F8E0F1;width: 58px;" onclick="popCardMod('${memberVo.card_key}')" href="#noloc">정보수정</a>
																</c:otherwise>
															</c:choose>
														</td>
													</c:if>
													<td>
														<c:if test="${(mbrAuthVo.mbr_pms_14 ne '0') && (mbrAuthVo.mbr_pms_15 ne '0')}">
															<%-- <img src="./resources/ls_img/member/btn_view.gif" style="cursor:pointer;" onclick="popMbrDetail('${memberVo.user_no}')"/> --%>
															<a class="btn-vacation-aprv" id="btn-detail" style="width: 58px;" onclick="popMbrDetail('${memberVo.user_no}')" href="#noloc">상세보기</a>
														</c:if>
													</td>
												</tr>
											</c:forEach>
										</c:when>
										<c:otherwise>
												<tr>
													<td colspan="11"><b>퇴사자 없음</b></td>
												</tr>
										</c:otherwise>
									</c:choose>
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
							
							<!-- page start -->
							<!-- 
							<c:if test="${action != 'fromTmState'}">
								<p style="text-align:center;">
									<c:if test="${startPgNoInt2 > 10}">
										<a href="./${pgNm2}?reqPgNo=${startPgNoInt2 - 1}&tab=3&orderFlag=${orderFlagToPaging}">&lt;</a>
									</c:if>
									<c:forEach var="pageNo" begin="${startPgNoInt2}" end="${endPgNoInt2}" step="1">
										<c:choose>
											<c:when test="${reqPgNoInt2 != pageNo}">
												<a href="./${pgNm2}?reqPgNo=${pageNo}&tab=3&orderFlag=${orderFlagToPaging}"><c:out value="${pageNo}" /></a>
												&nbsp;&nbsp;
											</c:when>
											<c:otherwise>
												<font color="red"><c:out value="${pageNo}" /></font>
												&nbsp;&nbsp;
											</c:otherwise>
										</c:choose>
									</c:forEach>
									<c:if test="${totPgCntInt2 >= endPgNoInt2 + 1}">
										<a href="./${pgNm2}?reqPgNo=${endPgNoInt2 + 1}&tab=3&orderFlag=${orderFlagToPaging}">&gt;</a>
									</c:if>
								</p>
							</c:if>
							 -->
							<!-- //page end -->
						</div><!-- //guestcnt4 -->
						
					</div>
				</div>
				
				<!-- 카드 Action Modal 시작 -->
				<c:import url="/card_manage_modal"></c:import>
				<!-- 카드 Action Modal 끝 -->
				
				<div id="card-detail-dialog" title="상세 보기" style="font-size: 15px;display:none;" align="center"></div>
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

</body>
</html>
