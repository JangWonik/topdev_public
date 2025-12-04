<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/vertical.css" />
	<!-- <script src="./resources/jquery/jquery.min_1_12.js"></script> -->
	<script src="./resources/wm_js/common.js?v=4"></script>
    <script src="./resources/cmm/js/common.js"></script>
    
    <script src="./resources/jquery/jquery-ui.min.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	
	<!-- chart 추가 -->	
	<script src="./resources/chart/Chart.min.js"></script>	
	<script src="./resources/chart/utils.js"></script>
	
	<style>
	
	::-webkit-scrollbar {
		display:none;
	} 
	
	.tableStyle2 td{letter-spacing: 0px;}
	
	.tableStyle3 td {letter-spacing: 0;}	
	
	.buttonMiniView{
		width:80px;
		height:20px;
	    background-color:#F7F7F7;
	    color:#666;
	    text-align: center;
		border-radius:5px;
	    font-size: 11px;
	    cursor: pointer;
	    text-decoration:none;
	    border: solid 1px grey;		    
	}
	
	.buttonMiniView:hover{
		background-color:#FFA500;		
	}
	
	.buttonMenuLec{
		width:250px;
		height:27px;
	    /* background-color:#2E7EE8; */
	    /* background-color:#013469; */
	    background-color:#4a6b86;	    
	    color:#FFFFFF;
	    text-align: center;
		border-radius:5px;
	    font-size: 12px;
	    font-weight:bold;
	    cursor: pointer;
	    text-decoration:none;
	    border: none;
	    }
	.buttonMenuLec:hover{
		background-color:#FFA500;
	}
	
	.ui-widget-overlay { position: absolute; top: 0; left: 0; width: 100%; height: 100%; background: #AAA; opacity: .90; filter:Alpha(Opacity=30); }
	</style>
</head>

<body>

	<script>
		function mainLeftTmNoUserSearchFunc(presentPage,stateSearch,noUserSearch){
			
			//searchMainPagingForm.tmSearch.value = '${mbrVo_Session.team_id_main}';
			
			//팀미배당건 카운트
			if( '14' ==  '${mbrVo_Session.work_type_cd}'){
				searchMainPagingForm.tmSearch.value = '${mbrVo_Session.center_team_id}';
				searchMainPagingForm.tmGubun.value = '-1';
			}else{
				searchMainPagingForm.tmSearch.value = '${mbrVo_Session.team_id_main}';	
			}
			
			searchMainPagingForm.stateSearch.value = stateSearch;
			searchMainPagingForm.noUserSearch.value = noUserSearch;
			$("#presentPage").val(presentPage);
			searchMainPagingForm.submit();
		}		
		function mainLeftMySearchFunc(presentPage,stateSearch){
			
			if( stateSearch != '9999' && stateSearch != '0' && stateSearch != '2' && stateSearch != '3' ){
				searchMainPagingForm.tmSearch.value = '${mbrVo_Session.team_id_main}';
			}			
			
			searchMainPagingForm.userNmSearch.value = '${mbrVo_Session.user_name}';			
			searchMainPagingForm.stateSearch.value = stateSearch;
			$("#presentPage").val(presentPage);
			
			if(presentPage == "suimrpttab"){
				searchMainPagingForm.minwonSearch.value = "3";	
			}			
			
			searchMainPagingForm.submit();
		}
		function mainLeftTmSearchFunc(presentPage,stateSearch){			
			//searchMainPagingForm.tmSearch.value = '${mbrVo_Session.team_id_main}';
						
			//센터장은 센터 그룹으로 검색한다.
			if( '14' ==  '${mbrVo_Session.work_type_cd}' && stateSearch == '1' ){
				searchMainPagingForm.tmSearch.value = '${mbrVo_Session.center_team_id}';
				searchMainPagingForm.tmGubun.value = '-1';
			}else{
				searchMainPagingForm.tmSearch.value = '${mbrVo_Session.team_id_main}';	
			}
			
			//stateSearch 가 91인경우는 현장보고서 결재 상태로 변경한다.
			if( stateSearch == 91){
				searchMainPagingForm.siteStateSearch.value = "1";
				searchMainPagingForm.processStateSearch.value = "5";
			}else{
				searchMainPagingForm.stateSearch.value = stateSearch;	
			}
			
			$("#presentPage").val(presentPage);
			
			if(presentPage == "suimrpttab"){
				searchMainPagingForm.minwonSearch.value = "3";	
			}			
			
			searchMainPagingForm.submit();
		}
		function mainLeftSuitAllTmSearchFunc(presentPage,stateSearch){
			searchMainPagingForm.stateSearch.value = stateSearch;
			$("#presentPage").val(presentPage);
			searchMainPagingForm.submit();
		}
		function mainLeftPtnrSearchFunc(presentPage,stateSearch,ptnrID){
			searchMainPagingForm.ptnrSearch.value = ptnrID;
			searchMainPagingForm.stateSearch.value = stateSearch;
			$("#presentPage").val(presentPage);
			searchMainPagingForm.submit();
		}
		function mainLeftMyHelpSearchFunc(flag,stateSearch){
			if(flag == 'accept'){
				helpSearchPagingForm.acceptNmSearch.value = '${mbrVo_Session.user_name}';
				helpSearchPagingForm.tmSearchAccept.value = '${mbrVo_Session.team_id_main}';
			}else if(flag == 'client'){
				helpSearchPagingForm.clientNmSearch.value = '${mbrVo_Session.user_name}';
				helpSearchPagingForm.tmSearchClient.value = '${mbrVo_Session.team_id_main}';
			}
			helpSearchPagingForm.stateSearch.value = stateSearch;
			helpSearchPagingForm.submit();
		}
		function mainLeftTmHelpSearchFunc(flag,stateSearch){
			if(flag == 'accept'){
				helpSearchPagingForm.tmSearchAccept.value = '${mbrVo_Session.team_id_main}';
			}else if(flag == 'client'){
				helpSearchPagingForm.tmSearchClient.value = '${mbrVo_Session.team_id_main}';
			}
			helpSearchPagingForm.stateSearch.value = stateSearch;
			helpSearchPagingForm.submit();
		}
		
		function btnOn(obj){
			obj.src=obj.src.replace('off.gif','on.gif');
		}
			 

		function btnOff(obj){
			obj.src=obj.src.replace('on.gif','off.gif');
		}
		
		//현장보고서 개인 보고서 조회 팝업창
		function openSiteMemberReport( p_userno, p_menutype, p_end_average){
			
			var pop_title = "memberSiteReport";
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1505; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			
			$("#pop_userno").val(p_userno);
			$("#pop_menutype").val(p_menutype);
			$("#pop_end_average").val(p_end_average);
			
			window.open("","memberSiteRportPopup",'width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=yes,scrollbars=no');
			
			$("#frmPopData").attr("action","memberNoSiteListPop");
			$("#frmPopData").attr("target","memberSiteRportPopup");
			$("#frmPopData").submit();			
		}
		
		//현장보고서 결재 요청목록
		function openSiteApprovalList(){
			
			var url = "./siteApprovalListModal";				
			
			$.ajax({
		        type: "POST",
		        url: url,		        
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        dataType: "HTML", 
		        success: function(data){
		        	$("#site-user-dialog").html();
		        	$("#site-user-dialog").html(data);
					$("#site-user-dialog").dialog({						
						height: 800,
						width: 1000,
						closeOnEscape : true,
						draggable : false,
						title: "현장보고서 결재요청 내역",
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
		
		//오늘 휴가자 불러오기 모달창
		function openSiteTodayVacation(){
			
			var url = "./siteTodayVacationModal";			//오늘 휴가자 불러오기 모달창
			var param = {};						
			
			$.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        dataType: "HTML", 
		        success: function(data){
		        	$("#site-user-dialog").html();
		        	$("#site-user-dialog").html(data);
					$("#site-user-dialog").dialog({						
						height: 600,
						width: 600,
						closeOnEscape : true,
						draggable : false,
						title: "오늘 휴가자 알림",
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
		
		//현장보고서 센터 모달창
		function openSiteReportCenter( p_center ){
			
			var url = "./siteReportCenterModal";
			var param = {};
			param.team_center = p_center;			
			
			$.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        dataType: "HTML", 
		        success: function(data){
		        	$("#site-user-dialog").html();
		        	$("#site-user-dialog").html(data);
					$("#site-user-dialog").dialog({						
						height: 800,
						width: 1000,
						closeOnEscape : true,
						draggable : false,
						title: "현장보고서 제출현황",
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
		
		//현장보고서 팀 모달창
		function openSiteReportTeam( p_team ){
			
			//alert("p_team : "+p_team);
			
			var url = "./siteReportTeamModal";
			var param = {};
			param.team_id = p_team;
			
			$.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        dataType: "HTML", 
		        success: function(data){
		        	$("#site-user-dialog").html();
		        	$("#site-user-dialog").html(data);
					$("#site-user-dialog").dialog({						
						height: 800,
						width: 1000,
						closeOnEscape : true,
						draggable : false,
						title: "현장보고서 제출현황",
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
		
		//현장보고서 개인 모달창
		function openSiteReportUser( p_userno ){
			
			var url = "./siteReportUserModal";
			//alert("개인 현장보고서 팝업 : "+ p_userno);
			var param = {};
			param.user_no = p_userno;
			
			$.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        dataType: "HTML", 
		        success: function(data){
		        	$("#site-user-dialog").html();
		        	$("#site-user-dialog").html(data);
					$("#site-user-dialog").dialog({						
						height: 700,
						width: 900,
						closeOnEscape : true,
						draggable : false,
						title: "개인현장보고서 제출현황",
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
		
		//현장 보고서 그래프 창 띄우기
		function openSiteChartDetail( p_type, p_key, p_date ){	//창타입, 키, 기준일자
			
			var url = "./siteChartDetailModal";
			var param = {};
			param.modalType = p_type;
			param.modalKey = p_key;
			param.modalDate = p_date;
			
			$.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        dataType: "HTML", 
		        success: function(data){		        	
		        	$("#site-chart-dialog").html();
		        	$("#site-chart-dialog").html(data);
					$("#site-chart-dialog").dialog({						
						height: 800,
						width: 1000,
						closeOnEscape : true,
						draggable : true,
						title: "최근 30일간 현장보고서 제출현황 그래프",
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
	</script>	

	<form action="./helpSearchQuery" name="helpSearchPagingForm" method="post">
		<input type="hidden" id="reqPgNo" name="reqPgNo" value="1" >
		<input type="hidden" id="tmSearchClient" name="tmSearchClient" value="0" >
		<input type="hidden" id="tmGubunClient" name="tmGubunClient" value="" >
		<input type="hidden" id="clientNmSearch" name="clientNmSearch" value="" >
		<input type="hidden" id="regDateFromSearch" name="regDateFromSearch" value="" >
		<input type="hidden" id="regDateToSearch" name="regDateToSearch" value="" >
		<input type="hidden" id="endDateFromSearch" name="endDateFromSearch" value="" >
		<input type="hidden" id="endDateToSearch" name="endDateToSearch" value="" >
		<input type="hidden" id="tmSearchAccept" name="tmSearchAccept" value="0" >
		<input type="hidden" id="tmGubunAccept" name="tmGubunAccept" value="" >
		<input type="hidden" id="acceptNmSearch" name="acceptNmSearch" value="" >
		<input type="hidden" id="stateSearch" name="stateSearch" value="-1" >
	</form>

	<form action="./searchMainQuery" name="searchMainPagingForm" method="post">
		<input type="hidden" id="reqPgNo" name="reqPgNo" value="1" >
		<input type="hidden" id="presentPage" name="presentPage" value="" >
		<input type="hidden" id="stateSearch" name="stateSearch" value="9999" >
		<input type="hidden" id="siteStateSearch" name="siteStateSearch" value="9999" >
		<input type="hidden" id="processStateSearch" name="processStateSearch" value="9999" >
		<input type="hidden" id="noUserSearch" name="noUserSearch" value="" >
		<input type="hidden" id="type1Search" name="type1Search" value="0" >
		<input type="hidden" id="regDateFromSearch" name="regDateFromSearch" value="" >
		<input type="hidden" id="regDateToSearch" name="regDateToSearch" value="" >
		<input type="hidden" id="cancelDateFromSearch" name="cancelDateFromSearch" value="" >
		<input type="hidden" id="cancelDateToSearch" name="cancelDateToSearch" value="" >
		<input type="hidden" id="tmSearch" name="tmSearch" value="0" >
		<input type="hidden" id="tmGubun" name="tmGubun" value="" >
		<input type="hidden" id="userNmSearch" name="userNmSearch" value="" >
		<input type="hidden" id="aprvDateFromSearch" name="aprvDateFromSearch" value="" >
		<input type="hidden" id="aprvDateToSearch" name="aprvDateToSearch" value="" >
		<input type="hidden" id="closeDateFromSearch" name="closeDateFromSearch" value="" >
		<input type="hidden" id="closeDateToSearch" name="closeDateToSearch" value="" >
		<input type="hidden" id="ptnrSearch" name="ptnrSearch" value="0" >
		<input type="hidden" id="ptnrGubun" name="ptnrGubun" value="" >
		<input type="hidden" id="ptnrDeptNmSearch" name="ptnrDeptNmSearch" value="" >
		<input type="hidden" id="ptnrUserNmSearch" name="ptnrUserNmSearch" value="" >
		<input type="hidden" id="insuNmSearch" name="insuNmSearch" value="" >
		<input type="hidden" id="policyhNmSearch" name="policyhNmSearch" value="" >
		<input type="hidden" id="policySsn1Search" name="policySsn1Search" value="" >
		<input type="hidden" id="policySsn2Search" name="policySsn2Search" value="" >
		<input type="hidden" id="benefiNmSearch" name="benefiNmSearch" value="" >
		<input type="hidden" id="benefiSsn1Search" name="benefiSsn1Search" value="" >
		<input type="hidden" id="benefiSsn2Search" name="benefiSsn2Search" value="" >
		<input type="hidden" id="damagedNmSearch" name="damagedNmSearch" value="" >
		<input type="hidden" id="accidentNoSearch" name="accidentNoSearch" value="" >
		<input type="hidden" id="policyNoSearch" name="policyNoSearch" value="" >
		<input type="hidden" id="accidentFactsSearch" name="accidentFactsSearch" value="" >
		<input type="hidden" id="acceptNoSearch" name="acceptNoSearch" value="" >
		<input type="hidden" id="moralSearch" name="moralSearch" value="" >
		<input type="hidden" id="minwonSearch" name="minwonSearch" value="3" >
		<input type="hidden" id="searchMainSimpleQueryTxt" name="searchMainSimpleQueryTxt" value="" >
		 
		<input type="hidden" id="minwonDateFromSearch" name="minwonDateFromSearch" value="" >
		<input type="hidden" id="minwonDateToSearch" name="minwonDateToSearch" value="" >
		
		<input type="hidden" id="moralDateFromSearch" name="moralDateFromSearch" value="" >
		<input type="hidden" id="moralDateToSearch" name="moralDateToSearch" value="" >
		
		
	</form>

			<!-- left_cnt -->
			<div class="left_cnt" style="padding-top:5px;">				
				<c:if test="${mbrVo_Session.user_state == 9 && mainLeftTmSuimVO.reqHelpDesk > 0}">					
					<div style="text-align:center;padding-top:5px;">
						<a href="./helpDeskBoardList">
							<input class="buttonMenuLec" type="button" value="전산지원요청 : ${mainLeftTmSuimVO.reqHelpDesk} 건">
						</a>
					</div>
				</c:if>
				<c:if test="${(mbrVo_Session.user_no == 1997 || mbrVo_Session.user_no == 215 || mbrVo_Session.user_no == 966 || mbrVo_Session.user_no == 1265 || mbrVo_Session.user_no == 1923) && mainLeftTmSuimVO.reqEmpCert > 0  }">					
					<div style="text-align:center;padding-top:5px;">
						<a href="./topCertMng?fromMainLeftStr=on">
							<input class="buttonMenuLec" type="button" value="재직증명서신청 : ${mainLeftTmSuimVO.reqEmpCert} 건">
						</a>
					</div>
				</c:if>
				<c:if test="${mainLeftTmSuimVO.suimNoUserCnt != 0}">					
					<div style="text-align:center;padding-top:5px;">
						<a href="javascript:mainLeftTmNoUserSearchFunc('suimrpttab',0,'on');">
							<input class="buttonMenuLec" type="button" value="팀 미배당건 : ${mainLeftTmSuimVO.suimNoUserCnt} 건">
						</a>
					</div>
				</c:if>
				
				<!-- 신규휴가 신청 시작 -->
				<c:if test="${mainLeftTmSuimVO.vacationApprovalCnt != 0}">				
					<div style="text-align:center;padding-top:5px;">
						<a href="vacationApproval">
							<input class="buttonMenuLec" type="button" value="휴가신청 : 신청 ${mainLeftTmSuimVO.vacationApprovalCnt} 건">
						</a>					
					</div>
				</c:if>
				<%--
				<c:if test="${mainLeftTmSuimVO.vacationLastChkCnt != 0}">
				 <div class="topinfo">
					<p><!-- (신규) -->휴가최종확인 : 신청 <span><a href="vacationApproval">${mainLeftTmSuimVO.vacationLastChkCnt}</a></span> 건</p>
				</div> --%>
				
				<%--
					<div style="text-align:center;padding-top:5px;">
						<a href="vacationApproval">
							<input class="buttonMenuLec" type="button" value="휴가최종확인 : 신청 ${mainLeftTmSuimVO.vacationLastChkCnt} 건">
						</a>
					</div>
				</c:if>
				<!-- 신규휴가 신청 끝 -->
				--%>
				<!-- 신규 휴직 신청 시작 -->
				<c:if test="${mainLeftTmSuimVO.leaveApprovalCnt != 0}">					
					<div style="text-align:center;padding-top:5px;">
						<a href="leaveApproval">
							<input class="buttonMenuLec" type="button" value="휴직신청 : 신청 ${mainLeftTmSuimVO.leaveApprovalCnt} 건">
						</a>
					</div>
				</c:if>				
				<c:if test="${mainLeftTmSuimVO.leaveLastChkCnt != 0}">					
					<div style="text-align:center;padding-top:5px;">
						<a href="leaveApproval">
							<input class="buttonMenuLec" type="button" value="휴직최종확인 : 신청 ${mainLeftTmSuimVO.leaveLastChkCnt} 건">
						</a>
					</div>
				</c:if>
				<!-- 신규 휴직 신청 끝 -->
				
				<!-- 전산권한 결재요청 시작 -->
				<c:if test="${mbrAuthVo_Session.mbr_pms_30 != 0 && mainLeftTmSuimVO.approvalCnt != 0}">				
				<div style="text-align:center;padding-top:5px;">
					<a href="javascript:document.helpDeskForm.submit();">
						<input class="buttonMenuLec" type="button" value="전산권한 결재요청 : ${mainLeftTmSuimVO.approvalCnt} 건">
					</a>
				</div>
				</c:if>				
				<!-- 전산권한 결재요청 끝 -->
				
				<c:if test="${mbrAuthVo_Session.mbr_pms_27 == 1}">
					<%-- <div class="topinfo">
					<p>강의실신청 : 신청&nbsp;<span><a href="./lectureRoomApproveList">${mainLeftMySuimVO.lectureRoomCnt}</a></span> 건</p>
					</div> --%>
					<!-- 강의실 신청 기능 주석처리 20231122 (홍기헌 부장요청사항) -->
					<%-- <div style="text-align:center;padding-top:5px;">
						<a href="./lectureRoomApproveList">
							<input class="buttonMenuLec" type="button" value="강의실신청 : 신청 ${mainLeftMySuimVO.lectureRoomCnt} 건">
						</a>
					</div> --%>
				</c:if>
				<c:if test="${mbrAuthVo_Session.mbr_pms_22 == 1}">
					<div style="text-align:center;padding-top:5px;">
						<a href="./dutyAppList">
							<input class="buttonMenuLec" type="button" value="당직결재 : 신청 ${mainLeftMySuimVO.dutyCostAppCnt} 건">
						</a>
					</div>
				</c:if>	
				<c:if test="${mbrAuthVo_Session.mbr_pms_18 == 1}">
					<div style="text-align:center;padding-top:5px;">
						<a href="./dutyDepList">
							<input class="buttonMenuLec" type="button" value="당직입금 : 신청 ${mainLeftMySuimVO.dutyCostDepCnt} 건">
						</a>
					</div>
				</c:if>					
				
				<%-- 종결권한이 아닌 별도의 위임취소 결재권한으로 조회도록 기능 수정 by top3009 (20240725) --%>
				<c:if test="${mainLeftTmSuimVO.rptCancelApproval != 0 }">				
					<div style="text-align:center;padding-top:5px;">
						<a href="#noloc" onclick="fnRptCancelApprovList();">
							<%-- <input class="buttonMenuLec" type="button" value="위임취소 신청 : ${mainLeftTmSuimVO.rptCancelReqCnt} 건"> --%>
							<input class="buttonMenuLec" type="button" value="위임취소 신청 : ${mainLeftTmSuimVO.rptCancelApproval} 건">
						</a>
					</div>
				</c:if>
				
				<c:if test="${mbrAuthVo_Session.mbr_pms_24 == 1 or mbrAuthVo_Session.mbr_pms_24 == 2}"> 
					<c:if test="${mainLeftMySuimVO.rptAlarmCnt != 0}">
						<%-- <div class="topinfo">
							<p>
								오늘 할 일 : <span><a href="./speedMngList?flag=user&code=3" >${mainLeftMySuimVO.rptAlarmCnt}</a></span> 건
								<c:if test="${mbrAuthVo_Session.mbr_pms_24 == 2}"> 
									&nbsp;/팀 누적 : <span><a href="./speedMngList?flag=team&code=3" >${mainLeftTmSuimVO.rptAlarmCnt}</a></span> 건
								</c:if>
							</p>
						</div> --%>
						<div style="text-align:center;padding-top:5px;">
							<a href="./speedMngList?flag=user&code=3" >
								<input class="buttonMenuLec" type="button" value="오늘 할 일 : ${mainLeftMySuimVO.rptAlarmCnt} 건">
							</a>
						</div>
						<c:if test="${mbrAuthVo_Session.mbr_pms_24 == 2}"> 
							<div style="text-align:center;padding-top:5px;">
								<a href="./speedMngList?flag=team&code=3" >
									<input class="buttonMenuLec" type="button" value="팀 누적 : ${mainLeftTmSuimVO.rptAlarmCnt} 건">
								</a>
							</div>
						</c:if>
					</c:if>
				</c:if>
				
				<c:if test="${mbrAuthVo_Session.mbr_pms_29 == 1}">
					<div style="text-align:center;padding-top:5px;">
						<a href="./quickApprovalList">
							<input class="buttonMenuLec" type="button" value="빠른 결재요청 건 : ${mainLeftTmSuimVO.quickApprovalCnt} 건">
						</a>
					</div>
				</c:if>
				
				<!-- 겸직부서 결재요청건 시작 -->
				<c:if test="${mainLeftTmSuimVO.subTeamApprovalCnt > 0}">				
					<div style="text-align:center;padding-top:5px;">
						<a href="./mySubListPop" target="_blank">
							<input class="buttonMenuLec" type="button" value="겸직부서 결재요청 건 : ${mainLeftTmSuimVO.subTeamApprovalCnt} 건">
						</a>
					</div>
				</c:if>
				<!-- 겸직부서 결재요청건 끝 -->
				
				<!-- 수강신청 결재요청 건 시작 -->
				<c:if test="${mainLeftTmSuimVO.nLectureApproval > 0}">				
					<div style="text-align:center;padding-top:5px;">
						<a href="./lectureManagerApprovalList">
							<input class="buttonMenuLec" type="button" value="수강신청 결재요청 건 : ${mainLeftTmSuimVO.nLectureApproval} 건">
						</a>
					</div>
				</c:if>
				<!-- 수강신청 결재요청 건 끝 -->
				
				<c:if test="${mbrAuthVo_Session.mbr_pms_25 == 1 or mbrAuthVo_Session.mbr_pms_25 == 2 or mbrAuthVo_Session.mbr_pms_25 == 3 or mbrAuthVo_Session.mbr_pms_25 == 4}"> 
					<c:if test="${mainLeftMySuimVO.rptMbrchgOutCnt != 0 or mainLeftMySuimVO.rptMbrchgInCnt != 0}" >						
						<c:if test="${mainLeftMySuimVO.rptMbrchgOutCnt != 0}">
							<div style="text-align:center;padding-top:5px;">
								<a href="./rptMbrchgList?flag=${mbrAuthVo_Session.pms25Val}&code=1" >
									<input class="buttonMenuLec" type="button" value="이첩 : ${mainLeftMySuimVO.rptMbrchgOutCnt} 건">
								</a>
							</div>
						</c:if>
						<c:if test="${mainLeftMySuimVO.rptMbrchgInCnt != 0}">
							<div style="text-align:center;padding-top:5px;">
								<a href="./rptMbrchgList?flag=${mbrAuthVo_Session.pms25Val}&code=2" >
									<input class="buttonMenuLec" type="button" value="내첩 : ${mainLeftMySuimVO.rptMbrchgInCnt} 건">
								</a>
							</div>
						</c:if>
					</c:if>
				</c:if>
				
				<!-- 현장보고서 결재요청건 시작 by top3009 -->
				<c:choose>
					<c:when test="${approvalSiteExcept eq 1}">
						<c:if test="${mainLeftTmSuimVO.siteApprovalCnt > 0 && (sitePopAuth eq 3 || sitePopAuth eq 2)}">					
							<div style="text-align:center;padding-top:5px;">
								<a href="javascript:openSiteApprovalList()">
									<input class="buttonMenuLec" type="button" value="현장보고서 결재요청 건 : ${mainLeftTmSuimVO.siteApprovalCnt} 건">
								</a>
							</div>
						</c:if>
					</c:when>
					<c:otherwise>
						<c:if test="${mainLeftTmSuimVO.siteApprovalCnt > 0 && (sitePopAuth eq 3 || sitePopAuth eq 2)}">					
							<div style="text-align:center;padding-top:5px;">
								<a href="javascript:mainLeftTmSearchFunc('suimrpttab',91);">
									<input class="buttonMenuLec" type="button" value="현장보고서 결재요청 건 : ${mainLeftTmSuimVO.siteApprovalCnt} 건">
								</a>
							</div>
						</c:if>
					</c:otherwise>
				</c:choose>				
								
				<!-- 현장보고서 결재요청건 끝-->
				<!-- 현장보고서 바로가기 시작-->
				<c:if test="${mbrAuthVo_Session.mbr_pms_38 != 0 || mbrVo_Session.user_state == 9}">
					<!-- <div class="topinfo">
						<p>현장보고서 관리 : <span><a href="javascript:openSiteReportCenter( 0 )">바로가기</a></span></p>
					</div> -->
					<div style="text-align:center;padding-top:5px;">
						<a href="javascript:openSiteReportCenter( 0 )">
							<input class="buttonMenuLec" type="button" value="현장보고서 제출현황">
						</a>
					</div>
				</c:if>
				<!-- 현장보고서 바로가기 끝 -->
				<!-- 오늘 휴가자 조회 시작 -->
				<c:if test="${not empty sTodayVacationTeams}">
					<div style="text-align:center;padding-top:5px;">
						<a href="javascript:openSiteTodayVacation()">
							<input class="buttonMenuLec" type="button" value="오늘의 휴가자 알림">
						</a>
					</div>
				</c:if>
				<!-- 오늘 휴가자 조회 끝 -->						
				<div class="tArea" style="-ms-overflow-style: none;">
					<%--|| mbrVo_Session.user_state == 9 --%>
					<c:if test="${(mbrVo_Session.work_job_cd == 10  
								  || mbrVo_Session.work_job_cd == 13
								  || mbrVo_Session.work_job_cd == 15
								  || mbrVo_Session.work_job_cd == 20
								  || mbrVo_Session.work_job_cd == 25
								  || mbrVo_Session.work_job_cd == 30
								  || mbrVo_Session.work_job_cd == 35) 
								  && mbrVo_Session.team_type != 4
								  && mbrVo_Session.work_level_cd != 5 
								  }">
								  
						<div class="suttl">
							평가기준 달성도 
							<img src="./resources/ne_img/btn/rptWorkload_off.gif" id="rptWorkloadPop" onmouseover="btnOn(this);" onmouseout="btnOff(this);" onclick="alertWorkloadPop();"  align="right" style="margin-right: 8px;cursor:pointer;" width="78" height="20"/>
						</div>
						<div>
							
						</div>
						<div class="tableStyle3" >
							<table cellpadding="0" cellspacing="0" summary="team조사">
								<caption>평가기준 달성도</caption>
								<colgroup>
									<col width="50px" />
									<col width="55px" />
									<col width="55px" />
								</colgroup>
								<thead>
									<tr>
										<th>구분</th>
										<th colspan="2">MY</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td rowspan="4">기준업무량</td>
										<td>목표건수</td>
										<td>
											<fmt:formatNumber value="${mainLeftMySuimVO.purposeWorkload}" pattern="0.0##"/> 
										</td>
									</tr>
									
									<tr>
										<td>종결건수</td>
										<td>
											<fmt:formatNumber value="${mainLeftMySuimVO.calcWorkload}" pattern="0.0##"/> 
										</td>
									</tr>
									<tr>
										<td>달성률</td>
										<td>
											<c:choose>
												<c:when test="${mainLeftMySuimVO.calcWorkload != '0.0' && mainLeftMySuimVO.purposeWorkload != '0.0'}">
													<fmt:formatNumber value="${mainLeftMySuimVO.calcWorkload / mainLeftMySuimVO.purposeWorkload * 100}" pattern="0.0#"/> %
												</c:when>
												<c:otherwise>
													0.0%
												</c:otherwise>
											</c:choose>										
										</td>
									</tr>
									<tr>
										<td>백분위(상위)</td>
										<td>
											<c:choose>
												<c:when test="${mainLeftMySuimVO.rankWorkload != '0' && mainLeftMySuimVO.workloadCnt != '0'}">
													<fmt:formatNumber value="${mainLeftMySuimVO.rankWorkload / mainLeftMySuimVO.workloadCnt * 100}" pattern="0.0"/> %
												</c:when>
												<c:otherwise>
													0.0%
												</c:otherwise>
											</c:choose>
										</td>
									</tr>		
																																		
								</tbody>
							</table>
						</div>
					</c:if>	
					<c:if test="${mainLeftMySuimVO.suimTotalCnt != 0 || mainLeftTmSuimVO.suimTotalCnt != 0}">
						<table>
							<tr>
								<td width="20%">
									<div class="suttl">조사</div>
								</td>
								<td width="80%" style="text-align:right;padding-right:10px;">
									<c:if test="${sitePopAuth > 0}">
										<!-- 개인현장보고서 그래프 시작 -->
										<%-- <c:set var="now" value="<%=new java.util.Date()%>" />									
										<a href="javascript:openSiteChartDetail('M','${mbrVo_Session.user_no}','<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" />');">
											<img src="./resources/chart/chart_icon.png" title="최근 30일간 현장보고서 제출 초과율을 조회 합니다."/>
										</a> --%>
									</c:if>
									<!-- 현장보고서 관리 시작 -->
									<c:choose>
										<c:when test="${sitePopAuth eq 1}">
											<input class="buttonMiniView"  style="font-size:11px;" onclick="openSiteReportCenter( 0 )" type="button" value="현장보고서관리">
										</c:when>
										<c:when test="${sitePopAuth eq 2}">
											<input class="buttonMiniView"  style="font-size:11px;" onclick="openSiteReportCenter( 0 )" type="button" value="현장보고서관리">
										</c:when>
										<c:when test="${sitePopAuth eq 3}">
											<!-- <input class="buttonMiniView" onclick="openSiteReportTeam( 0 )" type="button" value="현장보고서관리"> -->
											<input class="buttonMiniView"  style="font-size:11px;" onclick="openSiteReportCenter( ${mbrVo_Session.team_center} )" type="button" value="현장보고서관리">
										</c:when>
										<c:when test="${sitePopAuth eq 4}">
											<input class="buttonMiniView"  style="font-size:11px;" onclick="openSiteReportUser( ${mbrVo_Session.user_no} )" type="button" value="현장보고서관리">
										</c:when>
									</c:choose>
									<!-- 현장보고서 관리 끝 -->									
									<!-- 개인현장보고서 그래프 끝 -->
									<c:if test="${mbrVo_Session.work_type_cd == 1 || mbrVo_Session.work_type_cd == 2 || mbrVo_Session.work_type_cd == 3 
									|| mbrVo_Session.work_type_cd == 6 || mbrVo_Session.work_type_cd == 7 || mbrVo_Session.work_type_cd == 14 
									|| mbrVo_Session.user_no == 966 || mbrVo_Session.user_no == 215 || mbrVo_Session.user_no == 1117 
									|| mbrVo_Session.user_no == 882 || mbrVo_Session.user_no == 670 || mbrVo_Session.user_no == 975 
									|| mbrVo_Session.user_no == 1786}">
										<c:if test="${mbrVo_Session.team_type ne 4}">
											<input class="buttonMiniView" style="font-size:11px;" onclick="alertNoSiteMngList();" type="button" value="제출현황관리">
										</c:if>
									</c:if>
								</td>
							</tr>
						</table>
						<div class="tableStyle3" >
							<table cellpadding="0" cellspacing="0" summary="team조사">
								<caption>team조사</caption>
								<colgroup>
									<col width="60px">
									<col width="50px" />
									<col width="50px" />
								</colgroup>
								<thead>
									<tr>
										<th>&nbsp;</th>
										<th>My</th>
										<th>Team</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>접수건</td>
										<td><a href="javascript:mainLeftMySearchFunc('suimrpttab',9999);">${mainLeftMySuimVO.suimTotalCnt}</a></td>
										<td><a href="javascript:mainLeftTmSearchFunc('suimrpttab',9999);">${mainLeftTmSuimVO.suimTotalCnt}</a></td>
									</tr>
									<c:if test="${mainLeftMySuimVO.suimState0Cnt != 0 || mainLeftTmSuimVO.suimState0Cnt != 0}">
										<tr>
											<td>미결건</td>
											<td><a href="javascript:mainLeftMySearchFunc('suimrpttab',0);">${mainLeftMySuimVO.suimState0Cnt}</a></td>
											<td><a href="javascript:mainLeftTmSearchFunc('suimrpttab',0);">${mainLeftTmSuimVO.suimState0Cnt}</a></td>
										</tr>
									</c:if>
									
									
									
									<c:if test="${mainLeftMySuimVO.site3DayCnt != 0 || mainLeftTmSuimVO.site3DayCnt != 0}">
										<tr>
											<td style="letter-spacing: -1px;">현장제출 3일 전</td>
											<td><a href="./myNoSiteList?presentPage=mynositetab">${mainLeftMySuimVO.site3DayCnt}</a></td>
											<td><a href="./myNoSiteList?presentPage=tmnositetab">${mainLeftTmSuimVO.site3DayCnt}</a></td>
										</tr>
									</c:if>
									
									<c:if test="${mainLeftMySuimVO.siteOverCnt != 0 || mainLeftTmSuimVO.siteOverCnt != 0}">
										<tr>
											<td style="letter-spacing: -1px;">현장제출 3일 초과</td>
											<td><a href="./myNoSiteList?presentPage=mynositeovertab">${mainLeftMySuimVO.siteOverCnt}</a></td>
											<td><a href="./myNoSiteList?presentPage=tmnositeovertab">${mainLeftTmSuimVO.siteOverCnt}</a></td>
										</tr>
									</c:if>
									
									<c:if test="${mainLeftMySuimVO.interim5DayCnt != 0 || mainLeftTmSuimVO.interim5DayCnt != 0}">
										<tr>
											<td style="letter-spacing: -1px;">중간제출 5일 전</td>
											<td><a href="./myNoSiteList?presentPage=mynointerim5daytab">${mainLeftMySuimVO.interim5DayCnt}</a></td>
											<td><a href="./myNoSiteList?presentPage=tmnointerim5daytab">${mainLeftTmSuimVO.interim5DayCnt}</a></td>
										</tr>
									</c:if>
									
									<c:if test="${mainLeftMySuimVO.interimOverCnt != 0 || mainLeftTmSuimVO.interimOverCnt != 0}">
										<tr>
											<td style="letter-spacing: -1px;">중간제출 초과</td>
											<td><a href="./myNoSiteList?presentPage=mynointerimtab">${mainLeftMySuimVO.interimOverCnt}</a></td>
											<td><a href="./myNoSiteList?presentPage=tmnointerimtab">${mainLeftTmSuimVO.interimOverCnt}</a></td>
										</tr>
									</c:if>
									
									
									
									<c:if test="${mainLeftMySuimVO.suimState1Cnt != 0 || mainLeftTmSuimVO.suimState1Cnt != 0}">
										<tr>
											<td>상신건</td>
											<td><a href="javascript:mainLeftMySearchFunc('suimrpttab',1);">${mainLeftMySuimVO.suimState1Cnt}</a></td>
											<td><a href="javascript:mainLeftTmSearchFunc('suimrpttab',1);">${mainLeftTmSuimVO.suimState1Cnt}</a></td>
										</tr>
									</c:if>
									<c:if test="${mainLeftMySuimVO.suimState11Cnt != 0 || mainLeftTmSuimVO.suimState11Cnt != 0}">
										<tr>
											<td class="colorRed01">반려건</td>
											<td><a href="javascript:mainLeftMySearchFunc('suimrpttab',11);">${mainLeftMySuimVO.suimState11Cnt}</a></td>
											<td><a href="javascript:mainLeftTmSearchFunc('suimrpttab',11);">${mainLeftTmSuimVO.suimState11Cnt}</a></td>
										</tr>
									</c:if>
									<c:if test="${mainLeftMySuimVO.aIACnt != 0 || mainLeftTmSuimVO.aIACnt != 0}">
										<tr>
											<td>AIA보완건</td>
											<td><a href="./aiaSearch?fromMainLeftStr=mycnt">${mainLeftMySuimVO.aIACnt}</a></td>
											<td><a href="./aiaSearch?fromMainLeftStr=tmcnt">${mainLeftTmSuimVO.aIACnt}</a></td>
										</tr>
									</c:if>
									<c:if test="${mbrVo_Session.user_id == 'top6905' || mbrVo_Session.user_id == 'top0906'}">
										<tr>
											<td>AIA상신(ALL)</td>
											<td colspan="2"><a href="./aiaSearch?fromMainLeftStr=tm1cntall">${mainLeftTmSuimVO.aIACntState1AllTm}</a></td>
										</tr>
										<tr>
											<td class="colorRed01">AIA반려(ALL)</td>
											<td colspan="2"><a href="./aiaSearch?fromMainLeftStr=tm11cntall">${mainLeftTmSuimVO.aIACntState11AllTm}</a></td>
										</tr>
										<tr>
											<td>AIA보완(ALL)</td>
											<td colspan="2"><a href="./aiaSearch?fromMainLeftStr=tmcntall">${mainLeftTmSuimVO.aIACntAllTm}</a></td>
										</tr>
									</c:if>
									<tr>
										<td>종결건</td>
										<td><a href="javascript:mainLeftMySearchFunc('suimrpttab',2);">${mainLeftMySuimVO.suimState2Cnt}</a></td>
										<td><a href="javascript:mainLeftTmSearchFunc('suimrpttab',2);">${mainLeftTmSuimVO.suimState2Cnt}</a></td>
									</tr>
									<c:if test="${mainLeftMySuimVO.suimState3Cnt != 0 || mainLeftTmSuimVO.suimState3Cnt != 0}">
										<tr>
											<td>위임취소</td>
											<td><a href="javascript:mainLeftMySearchFunc('suimrpttab',3);">${mainLeftMySuimVO.suimState3Cnt}</a></td>
											<td><a href="javascript:mainLeftTmSearchFunc('suimrpttab',3);">${mainLeftTmSuimVO.suimState3Cnt}</a></td>
										</tr>
									</c:if>
								</tbody>
							</table>
						</div><!-- //tableStyle3 -->
					</c:if><!-- //suim -->
					<c:if test="${mainLeftMySuimVO.aHelpState0Cnt != 0 || mainLeftTmSuimVO.aHelpState0Cnt != 0
									|| mainLeftMySuimVO.aHelpState1Cnt != 0 || mainLeftTmSuimVO.aHelpState1Cnt != 0
									|| mainLeftMySuimVO.aHelpState2Cnt != 0 || mainLeftTmSuimVO.aHelpState2Cnt != 0
									|| mainLeftMySuimVO.aHelpState3Cnt != 0 || mainLeftTmSuimVO.aHelpState3Cnt != 0
									|| mainLeftMySuimVO.cHelpState0Cnt != 0 || mainLeftTmSuimVO.cHelpState0Cnt != 0
									|| mainLeftMySuimVO.cHelpState1Cnt != 0 || mainLeftTmSuimVO.cHelpState1Cnt != 0
									|| mainLeftMySuimVO.cHelpState2Cnt != 0 || mainLeftTmSuimVO.cHelpState2Cnt != 0
									|| mainLeftMySuimVO.cHelpState3Cnt != 0 || mainLeftTmSuimVO.cHelpState3Cnt != 0}">
						<p class="suttl">협조건</p>
						<c:if test="${mainLeftMySuimVO.aHelpState0Cnt != 0 || mainLeftTmSuimVO.aHelpState0Cnt != 0
										|| mainLeftMySuimVO.aHelpState1Cnt != 0 || mainLeftTmSuimVO.aHelpState1Cnt != 0
										|| mainLeftMySuimVO.aHelpState2Cnt != 0 || mainLeftTmSuimVO.aHelpState2Cnt != 0
										|| mainLeftMySuimVO.aHelpState3Cnt != 0 || mainLeftTmSuimVO.aHelpState3Cnt != 0}">
							<div class="tableStyle3">
								<table cellpadding="0" cellspacing="0" summary="협조건">
									<caption>협조건 기재</caption>
									<colgroup>
										<col width="60px">
										<col width="50px" />
										<col width="50px" />
									</colgroup>
									<thead>
										<tr>
											<th>수임</th>
											<th>My</th>
											<th>Team</th>
										</tr>
									</thead>
									<tbody>
										<c:if test="${mainLeftMySuimVO.aHelpState0Cnt != 0 || mainLeftTmSuimVO.aHelpState0Cnt != 0}">
											<tr>
												<td>대기</td>
												<td><a href="javascript:mainLeftMyHelpSearchFunc('accept',0);">${mainLeftMySuimVO.aHelpState0Cnt}</a></td>
												<td><a href="javascript:mainLeftTmHelpSearchFunc('accept',0);">${mainLeftTmSuimVO.aHelpState0Cnt}</a></td>
											</tr>
										</c:if>
										<c:if test="${mainLeftMySuimVO.aHelpState1Cnt != 0 || mainLeftTmSuimVO.aHelpState1Cnt != 0}">
											<tr>
												<td>진행</td>
												<td><a href="javascript:mainLeftMyHelpSearchFunc('accept',1);">${mainLeftMySuimVO.aHelpState1Cnt}</a></td>
												<td><a href="javascript:mainLeftTmHelpSearchFunc('accept',1);">${mainLeftTmSuimVO.aHelpState1Cnt}</a></td>
											</tr>
										</c:if>
										<c:if test="${mainLeftMySuimVO.aHelpState2Cnt != 0 || mainLeftTmSuimVO.aHelpState2Cnt != 0}">
											<tr>
												<td>결재</td>
												<td><a href="javascript:mainLeftMyHelpSearchFunc('accept',2);">${mainLeftMySuimVO.aHelpState2Cnt}</a></td>
												<td><a href="javascript:mainLeftTmHelpSearchFunc('accept',2);">${mainLeftTmSuimVO.aHelpState2Cnt}</a></td>
											</tr>
										</c:if>
										<c:if test="${mainLeftMySuimVO.aHelpState3Cnt != 0 || mainLeftTmSuimVO.aHelpState3Cnt != 0}">
											<tr>
												<td>완료</td>
												<td><a href="javascript:mainLeftMyHelpSearchFunc('accept',3);">${mainLeftMySuimVO.aHelpState3Cnt}</a></td>
												<td><a href="javascript:mainLeftTmHelpSearchFunc('accept',3);">${mainLeftTmSuimVO.aHelpState3Cnt}</a></td>
											</tr>
										</c:if>
									</tbody>
								</table>
							</div><!-- //tableStyle3 -->
						</c:if>
						<c:if test="${mainLeftMySuimVO.cHelpState0Cnt != 0 || mainLeftTmSuimVO.cHelpState0Cnt != 0
										|| mainLeftMySuimVO.cHelpState1Cnt != 0 || mainLeftTmSuimVO.cHelpState1Cnt != 0
										|| mainLeftMySuimVO.cHelpState2Cnt != 0 || mainLeftTmSuimVO.cHelpState2Cnt != 0
										|| mainLeftMySuimVO.cHelpState3Cnt != 0 || mainLeftTmSuimVO.cHelpState3Cnt != 0}">
							<div class="tableStyle3">
								<table cellpadding="0" cellspacing="0" summary="협조건">
									<caption>협조건 기재</caption>
									<colgroup>
										<col width="60px">
										<col width="50px" />
										<col width="50px" />
									</colgroup>
									<thead>
										<tr>
											<th>의뢰</th>
											<th>My</th>
											<th>Team</th>
										</tr>
									</thead>
									<tbody>
										<c:if test="${mainLeftMySuimVO.cHelpState0Cnt != 0 || mainLeftTmSuimVO.cHelpState0Cnt != 0}">
											<tr>
												<td>대기</td>
												<td><a href="javascript:mainLeftMyHelpSearchFunc('client',0);">${mainLeftMySuimVO.cHelpState0Cnt}</a></td>
												<td><a href="javascript:mainLeftTmHelpSearchFunc('client',0);">${mainLeftTmSuimVO.cHelpState0Cnt}</a></td>
											</tr>
										</c:if>
										<c:if test="${mainLeftMySuimVO.cHelpState1Cnt != 0 || mainLeftTmSuimVO.cHelpState1Cnt != 0}">
											<tr>
												<td>진행</td>
												<td><a href="javascript:mainLeftMyHelpSearchFunc('client',1);">${mainLeftMySuimVO.cHelpState1Cnt}</a></td>
												<td><a href="javascript:mainLeftTmHelpSearchFunc('client',1);">${mainLeftTmSuimVO.cHelpState1Cnt}</a></td>
											</tr>
										</c:if>
										<c:if test="${mainLeftMySuimVO.cHelpState2Cnt != 0 || mainLeftTmSuimVO.cHelpState2Cnt != 0}">
											<tr>
												<td>결재</td>
												<td><a href="javascript:mainLeftMyHelpSearchFunc('client',2);">${mainLeftMySuimVO.cHelpState2Cnt}</a></td>
												<td><a href="javascript:mainLeftTmHelpSearchFunc('client',2);">${mainLeftTmSuimVO.cHelpState2Cnt}</a></td>
											</tr>
										</c:if>
										<c:if test="${mainLeftMySuimVO.cHelpState3Cnt != 0 || mainLeftTmSuimVO.cHelpState3Cnt != 0}">
											<tr>
												<td>완료</td>
												<td><a href="javascript:mainLeftMyHelpSearchFunc('client',3);">${mainLeftMySuimVO.cHelpState3Cnt}</a></td>
												<td><a href="javascript:mainLeftTmHelpSearchFunc('client',3);">${mainLeftTmSuimVO.cHelpState3Cnt}</a></td>
											</tr>
										</c:if>
									</tbody>
								</table>
							</div><!-- //tableStyle3 -->
						</c:if>
					</c:if><!-- //help -->
					<c:if test="${mainLeftMySuimVO.suit18TotalCnt != 0 || mainLeftMySuimVO.suit10TotalCnt != 0
									|| mainLeftMySuimVO.suit12TotalCnt != 0 || mainLeftMySuimVO.suit17TotalCnt != 0
									|| mainLeftTmSuimVO.suit18TotalCnt != 0 || mainLeftTmSuimVO.suit10TotalCnt != 0
									|| mainLeftTmSuimVO.suit12TotalCnt != 0 || mainLeftTmSuimVO.suit17TotalCnt != 0}">
						<p class="suttl">계약적부</p>
						<div class="tableStyle3">
							<table cellpadding="0" cellspacing="0" summary="계약적부">
								<caption>계약적부</caption>
								<colgroup>
									<col width="60px">
									<col width="50px" />
									<col width="50px" />
								</colgroup>
								<thead>
									<tr>
										<th>삼/K/한/흥</th>
										<th>My</th>
										<th>Team</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>접수건</td>
										<td>
											<a href="javascript:mainLeftMySearchFunc('suit18rpttab',9999);">${mainLeftMySuimVO.suit18TotalCnt}</a>
											/<a href="javascript:mainLeftMySearchFunc('suit10rpttab',9999);">${mainLeftMySuimVO.suit10TotalCnt}</a>
											/<a href="javascript:mainLeftMySearchFunc('suit12rpttab',9999);">${mainLeftMySuimVO.suit12TotalCnt}</a>
											/<a href="javascript:mainLeftMySearchFunc('suit17rpttab',9999);">${mainLeftMySuimVO.suit17TotalCnt}</a>
										</td>
										<td>
											<a href="javascript:mainLeftTmSearchFunc('suit18rpttab',9999);">${mainLeftTmSuimVO.suit18TotalCnt}</a>
											/<a href="javascript:mainLeftTmSearchFunc('suit10rpttab',9999);">${mainLeftTmSuimVO.suit10TotalCnt}</a>
											/<a href="javascript:mainLeftTmSearchFunc('suit12rpttab',9999);">${mainLeftTmSuimVO.suit12TotalCnt}</a>
											/<a href="javascript:mainLeftTmSearchFunc('suit17rpttab',9999);">${mainLeftTmSuimVO.suit17TotalCnt}</a>
										</td>
									</tr>
									<c:if test="${mainLeftMySuimVO.suit18State0Cnt != 0 || mainLeftMySuimVO.suit10State0Cnt != 0 || mainLeftMySuimVO.suit12State0Cnt != 0 || mainLeftMySuimVO.suit17State0Cnt != 0
													|| mainLeftTmSuimVO.suit18State0Cnt != 0 || mainLeftTmSuimVO.suit10State0Cnt != 0 || mainLeftTmSuimVO.suit12State0Cnt != 0 || mainLeftTmSuimVO.suit17State0Cnt != 0}">
										<tr>
											<td>미결건</td>
											<td>
												<a href="javascript:mainLeftMySearchFunc('suit18rpttab',0);">${mainLeftMySuimVO.suit18State0Cnt}</a>
												/<a href="javascript:mainLeftMySearchFunc('suit10rpttab',0);">${mainLeftMySuimVO.suit10State0Cnt}</a>
												/<a href="javascript:mainLeftMySearchFunc('suit12rpttab',0);">${mainLeftMySuimVO.suit12State0Cnt}</a>
												/<a href="javascript:mainLeftMySearchFunc('suit17rpttab',0);">${mainLeftMySuimVO.suit17State0Cnt}</a>
											</td>
											<td>
												<a href="javascript:mainLeftTmSearchFunc('suit18rpttab',0);">${mainLeftTmSuimVO.suit18State0Cnt}</a>
												/<a href="javascript:mainLeftTmSearchFunc('suit10rpttab',0);">${mainLeftTmSuimVO.suit10State0Cnt}</a>
												/<a href="javascript:mainLeftTmSearchFunc('suit12rpttab',0);">${mainLeftTmSuimVO.suit12State0Cnt}</a>
												/<a href="javascript:mainLeftTmSearchFunc('suit17rpttab',0);">${mainLeftTmSuimVO.suit17State0Cnt}</a>
											</td>
										</tr>
									</c:if>
									<c:if test="${mainLeftMySuimVO.suit18State1Cnt != 0 || mainLeftMySuimVO.suit10State1Cnt != 0 || mainLeftMySuimVO.suit12State1Cnt != 0 || mainLeftMySuimVO.suit17State1Cnt != 0
													|| mainLeftTmSuimVO.suit18State1Cnt != 0 || mainLeftTmSuimVO.suit10State1Cnt != 0 || mainLeftTmSuimVO.suit12State1Cnt != 0 || mainLeftTmSuimVO.suit17State1Cnt != 0}">
										<tr>
											<td>상신건</td>
											<td>
												<a href="javascript:mainLeftMySearchFunc('suit18rpttab',1);">${mainLeftMySuimVO.suit18State1Cnt}</a>
												/<a href="javascript:mainLeftMySearchFunc('suit10rpttab',1);">${mainLeftMySuimVO.suit10State1Cnt}</a>
												/<a href="javascript:mainLeftMySearchFunc('suit12rpttab',1);">${mainLeftMySuimVO.suit12State1Cnt}</a>
												/<a href="javascript:mainLeftMySearchFunc('suit17rpttab',1);">${mainLeftMySuimVO.suit17State1Cnt}</a>
											</td>
											<td>
												<a href="javascript:mainLeftTmSearchFunc('suit18rpttab',1);">${mainLeftTmSuimVO.suit18State1Cnt}</a>
												/<a href="javascript:mainLeftTmSearchFunc('suit10rpttab',1);">${mainLeftTmSuimVO.suit10State1Cnt}</a>
												/<a href="javascript:mainLeftTmSearchFunc('suit12rpttab',1);">${mainLeftTmSuimVO.suit12State1Cnt}</a>
												/<a href="javascript:mainLeftTmSearchFunc('suit17rpttab',1);">${mainLeftTmSuimVO.suit17State1Cnt}</a>
											</td>
										</tr>
									</c:if>
									<c:if test="${mainLeftMySuimVO.suit18State11Cnt != 0 || mainLeftMySuimVO.suit10State11Cnt != 0 || mainLeftMySuimVO.suit12State11Cnt != 0 || mainLeftMySuimVO.suit17State11Cnt != 0
													|| mainLeftTmSuimVO.suit18State11Cnt != 0 || mainLeftTmSuimVO.suit10State11Cnt != 0 || mainLeftTmSuimVO.suit12State11Cnt != 0 || mainLeftTmSuimVO.suit17State11Cnt != 0}">
										<tr>
											<td class="colorRed01">반려건</td>
											<td>
												<a href="javascript:mainLeftMySearchFunc('suit18rpttab',11);">${mainLeftMySuimVO.suit18State11Cnt}</a>
												/<a href="javascript:mainLeftMySearchFunc('suit10rpttab',11);">${mainLeftMySuimVO.suit10State11Cnt}</a>
												/<a href="javascript:mainLeftMySearchFunc('suit12rpttab',11);">${mainLeftMySuimVO.suit12State11Cnt}</a>
												/<a href="javascript:mainLeftMySearchFunc('suit17rpttab',11);">${mainLeftMySuimVO.suit17State11Cnt}</a>
											</td>
											<td>
												<a href="javascript:mainLeftTmSearchFunc('suit18rpttab',11);">${mainLeftTmSuimVO.suit18State11Cnt}</a>
												/<a href="javascript:mainLeftTmSearchFunc('suit10rpttab',11);">${mainLeftTmSuimVO.suit10State11Cnt}</a>
												/<a href="javascript:mainLeftTmSearchFunc('suit12rpttab',11);">${mainLeftTmSuimVO.suit12State11Cnt}</a>
												/<a href="javascript:mainLeftTmSearchFunc('suit17rpttab',11);">${mainLeftTmSuimVO.suit17State11Cnt}</a>
											</td>
										</tr>
									</c:if>
									<tr>
										<td>종결건</td>
										<td>
											<a href="javascript:mainLeftMySearchFunc('suit18rpttab',2);">${mainLeftMySuimVO.suit18State2Cnt}</a>
											/<a href="javascript:mainLeftMySearchFunc('suit10rpttab',2);">${mainLeftMySuimVO.suit10State2Cnt}</a>
											/<a href="javascript:mainLeftMySearchFunc('suit12rpttab',2);">${mainLeftMySuimVO.suit12State2Cnt}</a>
											/<a href="javascript:mainLeftMySearchFunc('suit17rpttab',2);">${mainLeftMySuimVO.suit17State2Cnt}</a>
										</td>
										<td>
											<a href="javascript:mainLeftTmSearchFunc('suit18rpttab',2);">${mainLeftTmSuimVO.suit18State2Cnt}</a>
											/<a href="javascript:mainLeftTmSearchFunc('suit10rpttab',2);">${mainLeftTmSuimVO.suit10State2Cnt}</a>
											/<a href="javascript:mainLeftTmSearchFunc('suit12rpttab',2);">${mainLeftTmSuimVO.suit12State2Cnt}</a>
											/<a href="javascript:mainLeftTmSearchFunc('suit17rpttab',2);">${mainLeftTmSuimVO.suit17State2Cnt}</a>
										</td>
									</tr>
									<c:if test="${mainLeftMySuimVO.suit18State3Cnt != 0 || mainLeftMySuimVO.suit10State3Cnt != 0 || mainLeftMySuimVO.suit12State3Cnt != 0 || mainLeftMySuimVO.suit17State3Cnt != 0
													|| mainLeftTmSuimVO.suit18State3Cnt != 0 || mainLeftTmSuimVO.suit10State3Cnt != 0 || mainLeftTmSuimVO.suit12State3Cnt != 0 || mainLeftTmSuimVO.suit17State3Cnt != 0}">
										<tr>
											<td>위임취소</td>
											<td>
												<a href="javascript:mainLeftMySearchFunc('suit18rpttab',3);">${mainLeftMySuimVO.suit18State3Cnt}</a>
												/<a href="javascript:mainLeftMySearchFunc('suit10rpttab',3);">${mainLeftMySuimVO.suit10State3Cnt}</a>
												/<a href="javascript:mainLeftMySearchFunc('suit12rpttab',3);">${mainLeftMySuimVO.suit12State3Cnt}</a>
												/<a href="javascript:mainLeftMySearchFunc('suit17rpttab',3);">${mainLeftMySuimVO.suit17State3Cnt}</a>
											</td>
											<td>
												<a href="javascript:mainLeftTmSearchFunc('suit18rpttab',3);">${mainLeftTmSuimVO.suit18State3Cnt}</a>
												/<a href="javascript:mainLeftTmSearchFunc('suit10rpttab',3);">${mainLeftTmSuimVO.suit10State3Cnt}</a>
												/<a href="javascript:mainLeftTmSearchFunc('suit12rpttab',3);">${mainLeftTmSuimVO.suit12State3Cnt}</a>
												/<a href="javascript:mainLeftTmSearchFunc('suit17rpttab',3);">${mainLeftTmSuimVO.suit17State3Cnt}</a>
											</td>
										</tr>
									</c:if>
									<c:if test="${mbrVo_Session.user_id == 'top6905' || mbrVo_Session.user_id == 'top0906'}">
										<tr>
											<td class="colorRed01">결재건</td>
											<td colspan="2">
												<a href="javascript:mainLeftSuitAllTmSearchFunc('suit18rpttab',1);">${mainLeftTmSuimVO.suit18State1CntAllTm}</a>
												/<a href="javascript:mainLeftSuitAllTmSearchFunc('suit10rpttab',1);">${mainLeftTmSuimVO.suit10State1CntAllTm}</a>
												/<a href="javascript:mainLeftSuitAllTmSearchFunc('suit12rpttab',1);">${mainLeftTmSuimVO.suit12State1CntAllTm}</a>
												/<a href="javascript:mainLeftSuitAllTmSearchFunc('suit17rpttab',1);">${mainLeftTmSuimVO.suit17State1CntAllTm}</a>
											</td>
										</tr>
									</c:if>
								</tbody>
							</table>
						</div><!-- //tableStyle3 -->
					</c:if><!-- //suit -->
					<c:if test="${mainLeftMySuimVO.primTotalCnt != 0 || mainLeftTmSuimVO.primTotalCnt != 0}">
						<p class="suttl">농작물</p>
						<div class="tableStyle3">
							<table cellpadding="0" cellspacing="0" summary="농작물">
								<caption>농작물</caption>
								<colgroup>
									<col width="60px">
									<col width="50px" />
									<col width="50px" />
								</colgroup>
								<thead>
									<tr>
										<th>&nbsp;</th>
										<th>My</th>
										<th>Team</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>접수건</td>
										<td><a href="javascript:mainLeftMySearchFunc('primbizrpttab',9999);">${mainLeftMySuimVO.primTotalCnt}</a></td>
										<td><a href="javascript:mainLeftTmSearchFunc('primbizrpttab',9999);">${mainLeftTmSuimVO.primTotalCnt}</a></td>
									</tr>
									<c:if test="${mainLeftMySuimVO.primState0Cnt != 0 || mainLeftTmSuimVO.primState0Cnt != 0}">
										<tr>
											<td>미결건</td>
											<td><a href="javascript:mainLeftMySearchFunc('primbizrpttab',0);">${mainLeftMySuimVO.primState0Cnt}</a></td>
											<td><a href="javascript:mainLeftTmSearchFunc('primbizrpttab',0);">${mainLeftTmSuimVO.primState0Cnt}</a></td>
										</tr>
									</c:if>
									<c:if test="${mainLeftMySuimVO.primState1Cnt != 0 || mainLeftTmSuimVO.primState1Cnt != 0}">
										<tr>
											<td>상신건</td>
											<td><a href="javascript:mainLeftMySearchFunc('primbizrpttab',1);">${mainLeftMySuimVO.primState1Cnt}</a></td>
											<td><a href="javascript:mainLeftTmSearchFunc('primbizrpttab',1);">${mainLeftTmSuimVO.primState1Cnt}</a></td>
										</tr>
									</c:if>
									<c:if test="${mainLeftMySuimVO.primState11Cnt != 0 || mainLeftTmSuimVO.primState11Cnt != 0}">
										<tr>
											<td class="colorRed01">반려건</td>
											<td><a href="javascript:mainLeftMySearchFunc('primbizrpttab',11);">${mainLeftMySuimVO.primState11Cnt}</a></td>
											<td><a href="javascript:mainLeftTmSearchFunc('primbizrpttab',11);">${mainLeftTmSuimVO.primState11Cnt}</a></td>
										</tr>
									</c:if>
									<tr>
										<td>종결건</td>
										<td><a href="javascript:mainLeftMySearchFunc('primbizrpttab',2);">${mainLeftMySuimVO.primState2Cnt}</a></td>
										<td><a href="javascript:mainLeftTmSearchFunc('primbizrpttab',2);">${mainLeftTmSuimVO.primState2Cnt}</a></td>
									</tr>
									<c:if test="${mainLeftMySuimVO.primState3Cnt != 0 || mainLeftTmSuimVO.primState3Cnt != 0}">
										<tr>
											<td>위임취소</td>
											<td><a href="javascript:mainLeftMySearchFunc('primbizrpttab',3);">${mainLeftMySuimVO.primState3Cnt}</a></td>
											<td><a href="javascript:mainLeftTmSearchFunc('primbizrpttab',3);">${mainLeftTmSuimVO.primState3Cnt}</a></td>
										</tr>
									</c:if>
								</tbody>
							</table>
						</div><!-- //tableStyle3 -->
					</c:if><!-- //primbiz -->
					<c:if test="${mbrVo_Session.user_id == 'top0906'}">
						<p class="suttl"></p>
						<div class="tableStyle3">
							<table cellpadding="0" cellspacing="0" summary="AIA/흥국생명/새마을금고/KB생명">
								<caption>AIA/흥국생명/새마을금고/KB생명</caption>
								<colgroup>
									<col width="60px">
									<col width="50px" />
									<col width="50px" />
								</colgroup>
								<thead>
									<tr>
										<th class="colorblue01">미결확인</th>
										<th>My</th>
										<th>Team</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>AIA</td>
										<td><a href="javascript:mainLeftPtnrSearchFunc('suimrpttab',0,19);">${mainLeftTmSuimVO.ptnr19State0CntAllTm}</a></td>
										<td><a href="javascript:mainLeftPtnrSearchFunc('suimrpttab',1,19);">${mainLeftTmSuimVO.ptnr19State1CntAllTm}</a></td>
									</tr>
									<tr>
										<td>흥국생명</td>
										<td><a href="javascript:mainLeftPtnrSearchFunc('suimrpttab',0,27);">${mainLeftTmSuimVO.ptnr27State0CntAllTm}</a></td>
										<td><a href="javascript:mainLeftPtnrSearchFunc('suimrpttab',1,27);">${mainLeftTmSuimVO.ptnr27State1CntAllTm}</a></td>
									</tr>
									<tr>
										<td>새마을금고</td>
										<td><a href="javascript:mainLeftPtnrSearchFunc('suimrpttab',0,26);">${mainLeftTmSuimVO.ptnr26State0CntAllTm}</a></td>
										<td><a href="javascript:mainLeftPtnrSearchFunc('suimrpttab',1,26);">${mainLeftTmSuimVO.ptnr26State1CntAllTm}</a></td>
									</tr>
									<tr>
										<td>KB생명</td>
										<td><a href="javascript:mainLeftPtnrSearchFunc('suimrpttab',0,29);">${mainLeftTmSuimVO.ptnr29State0CntAllTm}</a></td>
										<td><a href="javascript:mainLeftPtnrSearchFunc('suimrpttab',1,29);">${mainLeftTmSuimVO.ptnr29State1CntAllTm}</a></td>
									</tr>
								</tbody>
							</table>
						</div><!-- //tableStyle3 -->
					</c:if><!-- //aia/hk/mg/kb -->
				</div><!-- //tArea -->
			</div>
			<!-- //left_cnt -->
			<!-- 전산권한 결재요청 페이지이동 -->
			<form id="helpDeskForm" name="helpDeskForm" action="helpDeskBoardList" method="GET">
				<input type="hidden" id="currentTab" name="currentTab" value="auth"/>
			</form>
			
			<!-- 현장 보고서 그래프 보기 모달 -->
			<div id="site-chart-dialog" title="최근 30일간 현장보고서 제출현황 그래프" style="font-size: 12px;" align="center"></div>
			
			<!-- 개인 현장보고서 제출현황보기 -->
			<div id="site-user-dialog" title="개인현장보고서 현황 상세보기" style="font-size: 12px;" align="center"></div>
			<!-- 개인 현장보고서 팝업 띄우기 -->
			<form name="frmPopData" id="frmPopData" method="post" >
			<input type="hidden" id="pop_userno" name="pop_userno" />
			<input type="hidden" id="pop_menutype" name="pop_menutype" />
			<input type="hidden" id="pop_end_average" name="pop_end_average" />
			</form>
</body>

</html>
