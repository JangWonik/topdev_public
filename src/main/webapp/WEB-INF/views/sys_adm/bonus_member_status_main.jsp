<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
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
	<style>
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
			background: #E0F2F7;			
		}
		
		.tableStyle2 td{
			letter-spacing:0px;
		}		
	</style>
	<script language="javascript">
		$(document).ready( function(){
			
			$("#srchStatus").select2();
			$("#srchCenterList").select2();
			$("#tmSearchMain").select2();
			$("#srchBonusStatus").select2();
			$("#srchCareerStatus").select2();
			
			$("#srchStatus").val(0).trigger('change');			
			$("#srchUserName").focus();	
			
			var viewTypeVal = '${viewType}';
			
			if( 'Manager' == viewTypeVal ){		//관리자 탭 선택 실행
				doManagerTab();				
			}else if( 'Career' == viewTypeVal ){		//신입/경력 탭 선택 실행
				doCareerTab();				
			}else{											//직원 탭 선택 실행
				doMemberTab();				
			}
		});
		
		//직원 탭 선택시 실행
		function doMemberTab(){
			$("#memberTab").attr("class","on");
			$("#memberView").show();
			$("#mangerTab").attr("class","");
			$("#managerView").hide();
			$("#careerTab").attr("class","");
			$("#careerView").hide();
			
			$("#selCareerState").hide();
			$("#selBonusState").show();
			
			$("#viewType").val("Member");
		}
		
		//관리자 탭 선택시 실행 
		function doManagerTab(){			
			$("#managerTab").attr("class","on");
			$("#managerView").show();
			
			$("#memberTab").attr("class","");
			$("#memberView").hide();
			$("#careerTab").attr("class","");
			$("#careerView").hide();
			
			$("#selCareerState").hide();
			$("#selBonusState").show();
			
			$("#viewType").val("Manager");
		}
		
		//신입/경력 탭 선택시 실행
		function doCareerTab(){
			$("#careerTab").attr("class","on");
			$("#careerView").show();
			
			$("#memberTab").attr("class","");
			$("#memberView").hide();
			$("#mangerTab").attr("class","");
			$("#managerView").hide();	
			
			$("#selCareerState").show();
			$("#selBonusState").hide();						
			
			$("#viewType").val("Career");
		}
		
		//직원 설정값 수정
		function doStateChange( p_user_no, p_bonus_state ){			
			
			var param = {};
			param.user_no = p_user_no;
			param.bonus_state = p_bonus_state;

			var url = "/updateBonusMemberState";
			
			$.ajax({
       	        type: "POST",
       	        url: url,
       	        data: param,
       	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
       	        timeout: 20000,
       	        async: false,
       	        dataType: "html", 
       	        success: function(data){       	        	       	        	
       	        	fnSearch();
       	        }
       	    });
			
		}
		
		//관리자 설정값 수정
		function doManagerStateChange( p_user_no, p_bonus_manager_state ){
			
			var param = {};
			param.user_no = p_user_no;
			param.bonus_manager_state = p_bonus_manager_state;
			
			var url = "/updateBonusManagerState";
			
			$.ajax({
       	        type: "POST",
       	        url: url,
       	        data: param,
       	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
       	        timeout: 20000,
       	        async: false,
       	        dataType: "html", 
       	        success: function(data){       	        	       	        	
       	        	fnSearch();
       	        }
       	    });	
		}
		
		//관리자 설정값 수정
		function doCareerStateChange( p_user_no, p_bonus_career_state ){
			
			var param = {};
			param.user_no = p_user_no;
			param.bonus_career_state = p_bonus_career_state;
			
			var url = "/updateBonusCareerState";			
			
			$.ajax({
       	        type: "POST",
       	        url: url,
       	        data: param,
       	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
       	        timeout: 20000,
       	        async: false,
       	        dataType: "html", 
       	        success: function(data){       	        	       	        	
       	        	fnSearch();
       	        }
       	    });	
		}
		
		function enterKey(){
			if( event.keyCode == 13 ){			
				fnSearch();			
			}
		}
		
		//검색
		function fnSearch(){
			
			var searchViewType = $("#viewType").val();
			
			if( searchViewType == 'Manager' ){			//관리자 목록 불러오기
				getManagerListAjax();
			}else if( searchViewType == 'Career' ){		//경력직 설정 불러오기
				getCareerListAjax();
			}else{													//직원목록 불러오기
				getMemberListAjax();	
			}		
			
		}
		
		//직원검색 Ajax
		function getMemberListAjax(){
			
			var formData = $("#searchFrm").serialize();
			
			$.ajax({
	 			type : "post",
	 			url : "/getBonusMemberStatusListAjax",
	 			data : formData,
	 			success : function(result){
	 				$("#divMemberList").html(result);	 				
	 			},
	 			error: function (request, status, error) {			
	 				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
	 			}
	 		});			
		}
		
		//관리자 검색 Ajax
		function getManagerListAjax(){
			
			var formData = $("#searchFrm").serialize();
			
			$.ajax({
	 			type : "post",
	 			url : "/getBonusManagerStatusListAjax",
	 			data : formData,
	 			success : function(result){
	 				$("#divManagerList").html(result);	 				
	 			},
	 			error: function (request, status, error) {			
	 				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
	 			}
	 		});
			
		}
		
		//관리자 검색 Ajax
		function getCareerListAjax(){
			
			var formData = $("#searchFrm").serialize();
			
			$.ajax({
	 			type : "post",	 			
	 			url : "/getBonusCareerStatusListAjax",
	 			data : formData,
	 			success : function(result){
	 				$("#divCareerList").html(result);	 				
	 			},
	 			error: function (request, status, error) {			
	 				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
	 			}
	 		});
			
		}
		
		//엑셀다운로드
		function doDownload(){
			$("#searchFrm").attr("action","schBonusListExcel");
			$("#searchFrm").submit();
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
			<!-- centercnt_top -->
			<div class="center_cnt_1300">
				<!-- centercnt_bot -->
				<div class="center_cnt_vacation" >
					<div class="guest">
						<div class="guestTap">
							<ul>								
								<li id="memberTab" onclick="javascript:doMemberTab();"><a href="#">성과급 직원 조회상태</a></li>
								<li id="managerTab" onclick="javascript:doManagerTab();"><a href="#">성과급 관리자 조회상태</a></li>
								<li id="careerTab" onclick="javascript:doCareerTab();"><a href="#">성과급 신입/경력 설정조회</a></li>																								
							</ul>
						</div>
						<!-- 검색창 시작 -->
						<form id="searchFrm">
							<input type="hidden" id="viewType" name="viewType" value="${viewType}"/>					
								<div id="search-box"  align="center">
									<div class="tableStyle2" style="padding-top:10px;">
										<table style="width: 100%;height:30px;" align="center">
											<tr>
												<th width="100px">재직상태</th>
												<td width="100px">
													<select id="srchStatus" name="srchStatus" style="width:80px;text-align:left;">
														<option value="9999"> - 전체 - </option>
														<option value="0">재직자</option>
														<option value="1">퇴사자</option>
													</select>												
												</td>
												<th width="80px">센터명</th>
												<td width="190px">
													<select id="srchCenterList" name="srchCenterList" style="width:170px;text-align:left;">
														<option value=""> - 전체 - </option>													
														<c:forEach items="${centerList}" var="centerVo">
															<option value="${centerVo.teamCenter}">${centerVo.centerName}</option>
														</c:forEach>
													</select>
												</td>
												<th width="80px">팀명</th>
												<td width="190px">
													<select id="tmSearchMain" name="tmSearchMain" style="width:170px;text-align:left;">
														<option value="" <c:if test="${empty tmSearchMain}">selected</c:if> > - 전체 - </option>													
														<c:forEach items="${teamList}" var = "teamVo">
															<option value="${teamVo.teamId}"
																<c:if test="${tmSearchMain eq teamVo.teamId}">selected</c:if>>
																<c:if test="${teamVo.teamLevel == 1}">&nbsp;└</c:if>
																<c:if test="${teamVo.teamLevel == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
																${teamVo.teamName}
															</option>
														</c:forEach>
													</select>
												</td>
												<th width="80px">이름</th>
												<td width="150px">
													<input type="text" id="srchUserName" name="srchUserName" onkeydown="javascript:enterKey();" style="width:130px;"/>
													<input type="text" style="display:none;"/>												
												</td>
												<th width="80px">현재상태</th>
												<td>
													<div id="selCareerState">
														<select id="srchCareerStatus" name="srchCareerStatus" style="width:80px;text-align:left;display:block;">
														<option value="9999"> - 전체 - </option>
														<option value="0">신입직</option>
														<option value="1">경력직</option>
														<option value="2">일반직</option>															
													</select>	
													</div>
													<div id="selBonusState">
														<select id="srchBonusStatus" name="srchBonusStatus" style="width:80px;text-align:left;display:block;">
															<option value="9999"> - 전체 - </option>
															<option value="0">대상</option>
															<option value="1">비대상</option>
															<option value="2">제외</option>
														</select>						
													</div>																
												</td>										
												<td>
													<a href="#noloc" class="btn-vacation-aprv" id="btn-search" onclick='javascript:fnSearch();'>검 색</a>
												</td>
											</tr>
										</table>
									</div>
								</div>
						</form>
						<!-- 검색창 끝 -->
						<!-- 성과급 직원조회 시작 -->
						<div id="memberView">
							<!-- 직원 목록 시작 -->
							<div class="guestcnt4" style="display:block;height:750px;">
								<div class="tableStyle2">
									<table>									
										<tr>
											<th width="50px;">순번</th>
											<th width="100px;">센터명</th>
											<th width="100px;">팀명</th>
											<th width="100px;">성명</th>
											<th width="50px;">직위</th>
											<th width="100px;">직책</th>
											<th width="100px;">입사일자</th>
											<th width="200px;">설정</th>
											<th width="100px;">현재상태</th>
											<th width="10px;"></th>													
										</tr>
									</table>
									<div id="divMemberList" style="overflow:auto;width:100%; height:660px;"></div>
								</div><!-- //tableStyle2 -->							
							</div>
							<!-- 직원 목록 끝 -->													
						</div>
						<!-- 성과급 직원조회 끝 -->
						<!-- 성과급 관리자 조회 시작 -->
						<div id="managerView">							
							<!-- 관리자 목록 시작 -->
							<div class="guestcnt4" style="display:block;height:750px;">
								<div class="tableStyle2">
									<table>									
										<tr>
											<th width="50px;">순번</th>
											<th width="100px;">센터명</th>
											<th width="100px;">팀명</th>
											<th width="100px;">성명</th>
											<th width="50px;">직위</th>
											<th width="100px;">직책</th>
											<th width="100px;">입사일자</th>
											<th width="200px;">설정</th>
											<th width="100px;">현재상태</th>
											<th width="10px;"></th>													
										</tr>
									</table>
									<div id="divManagerList" style="overflow:auto;width:100%; height:660px;"></div>
								</div><!-- //tableStyle2 -->							
							</div>
							<!-- 관리자 목록 끝 -->
						</div>
						<!-- 신입/경력 여부 조회 시작 -->
						<div id="careerView">							
							<!-- 신입/경력 여부 목록 시작 -->
							<div class="guestcnt4" style="display:block;height:750px;">
								<div class="tableStyle2">
									<table>									
										<tr>
											<th width="50px;">순번</th>
											<th width="100px;">센터명</th>
											<th width="100px;">팀명</th>
											<th width="100px;">성명</th>
											<th width="50px;">직위</th>
											<th width="100px;">직책</th>
											<th width="100px;">입사일자</th>
											<th width="200px;">설정</th>
											<th width="100px;">현재상태</th>
											<th width="10px;"></th>													
										</tr>
									</table>
									<div id="divCareerList" style="overflow:auto;width:100%; height:660px;"></div>
								</div><!-- //tableStyle2 -->							
							</div>
							<!-- 관리자 목록 끝 -->
						</div>
						<!-- 신입/경력 여부 조회 끝 -->																		
					</div>
				</div>
				<!-- //centercnt_bot -->
			<!-- //center_cnt -->
			</div>
		</div>
		<!-- //contents -->
	</div>
</div>
<!-- //wrapper -->
</body>
</html>
