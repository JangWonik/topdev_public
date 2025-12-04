<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
	<script type="text/javascript">
		function openGroupSMS(){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=700; //띄울 창의 넓이
			var sh=533;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('groupSMSForm','groupSMS','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}
		
		function setupEnd(){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=300; //띄울 창의 넓이
			var sh=205;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('setupEnd','setupEnd','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}

		function goSearchMain(){
			$("#searchMainForm").attr("action","searchMain");
		}

		function goSearchMainQuery(){
			$("#searchMainForm").attr("action","searchMainQuery");
		}
		
		function topRptDelPrivateInfo(){
			
			if(confirm("종결건(위임 취소 포함) 들이 *기한일* 설정에 따라 모두 삭제 됩니다.\n삭제 하시겠습니까? \n( 기한일 설정은 시스템 관리자에게 문의 하세요. )")){
				
				$.post("./topRptDelPrivateInfo",
					
					function(data,status){
						if(status=="success"){
							if(data == 1){
								alert("완료되었습니다.");
							}else{
								alert("삭제 실패 , 시스템 관리자에게 문의하세요.");
							}
						}
					}
				
				);
			} 
			
		}
		
		function topRptDelJukbu(){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=400; //띄울 창의 넓이
			var sh=300;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('delJukbuPop','delJukbuPop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}
		
		function goVacation(){
			window.open('VacationTest','VacationTest','width=1600,height=850','resizable=yes,scrollbars=yes');
		}
		
		function goVacation4(){
			window.open('VacationTest4','VacationTest4','width=1600,height=850','resizable=yes,scrollbars=yes');
		}
		
		function doTaxCal(){
			location.href="taxCalInvoice";
			$("#loading").show();
		}
		
	</script>
	
	<!-- skipnavi -->
	<div id="sknavi">
		<ul>
			<li><a href="#container">본문 바로가기</a></li>
			<li><a href="#gnb">주 메뉴 바로가기</a></li>
		</ul>
	</div>
	<!-- //skipnavi -->

	<!-- header -->
	<div id="header">
		<div class="inner clear_v2">
			<h1>
				<a href="./"><img src="./resources/wm_img/common/logo.gif" alt="top - TRUST OBLIGATION PASSION" /></a>
				<div class="logobg"></div>
			</h1>
			<div class="hcont">
				<div class="header_top">
					<!-- 검색하기 -->
					<div class="h_schA">
						<form id="searchMainForm" name="searchMainForm" method="post">
							<fieldset>
								<legend>검색하기</legend>
								<ul>
									<li><input type="image" src="./resources/wm_img/common/btn_sch.gif" alt="상세검색" onclick="goSearchMain()" /></li>
									<li class="ipt"><input type="text" id="searchMainSimpleQueryTxt" name="searchMainSimpleQueryTxt" value="${searchMainSimpleQueryTxt}" /></li>
									<li><input type="image" src="./resources/wm_img/common/bg_btnbg01.gif" alt="검색하기" onclick="goSearchMainQuery()" /></li>
								</ul>
							</fieldset>
						</form>
					</div>
					<!-- //검색하기 -->
					<ul class="logArea">
						<li class="team">${mbrVo_Session.user_name} @ ${mbrVo_Session.team_name}</li>
						<li><a href="javascript:openGroupSMS();"><img src="./resources/wm_img/common/ico_mobile.gif" alt="" /></a></li>
						<li class="bgbt"><a href="./logout">Logout</a></li>
					</ul>
				</div>
				<!-- gnb -->
				<div id="gnb">
					<ul>
						<li class="depth1" style="width:140px;">
							<a href="#;">BusinessSettings</a>
							<ul style="width:140px;">
								<c:if test="${mbrVo_Session.user_no != null && mbrVo_Session.user_state == 9 }">
									<li style="width:140px;"><a href="./topSysAdmAprvUser">결재자관리</a></li>
									<li style="width:140px;"><a href="./topPtrMng">보험사 관리</a></li>
									<li style="width:140px;"><a href="./topPtrMng?fromPage=dept">보험사 부서 관리</a></li>
									<li style="width:140px;"><a href="./topPtnrListOrder">보험사 통계순서 관리</a></li>
									<li style="width:140px;"><a href="./suimRptTypeSetup">보고서 코드분류 관리</a></li>
									<li style="width:140px;"><a href="./ptnrPeriodSetup">보험사 계약기간 관리</a></li>
								</c:if>
							</ul>
						</li>
						<li class="depth1">
							<a href="#;">시스템관리</a>
							<c:if test="${mbrVo_Session.user_no != null && mbrVo_Session.user_state == 9 }">
								<ul>
									<li><a href="javascript:setupEnd();">종결허용 관리</a></li>
									<li><a href="./topSysAdmCode">시스템코드관리</a></li>
									<li><a href="./sysAdmCode">시스템코드관리2</a></li>
									<li><a href="./holidayPan">휴일관리</a></li>
									<li><a href="./closeRptMgmt">종결파일삭제대장</a></li>
									<li><a href="./delFileReport">삭제파일관리대장</a></li>
									<li><a href="./divPopupManager">DIV팝업관리</a></li>
									<li><a href="javascript:doTaxCal();">세금계산서자동등록</a></li>									
								</ul>
							</c:if>
						</li>
						<li class="depth1">
							<a href="#;">DailyProcedure</a>
							<c:if test="${mbrVo_Session.user_no != null && mbrVo_Session.user_state == 9 }">
								<ul style="width:150px;">
									<li style="width:150px;"><a href="./rptLockMngMain">수임 lock 관리</a></li>
									<li style="width:150px;"><a href="./rptPrimLockMngMain">농작물 lock 관리</a></li>
									<li style="width:150px;"><a href="javascript:topRptDelPrivateInfo();">종결건 개인정보 삭제</a></li>
									<li style="width:150px;"><a href="javascript:topRptDelJukbu();">적부데이터 관리</a></li>
								</ul>
							</c:if>
						</li>
						<li class="depth1">
							<a href="#;">로그조회</a>
							<c:if test="${mbrVo_Session.user_no != null && mbrVo_Session.user_state == 9 }">
								<ul style="width:150px;">
									<!-- <li><a href="./topLogInLogList">웹 로그인 Log</a></li> -->
									<li style="width:150px;"><a href="./loginLogList">웹 로그인 Log</a></li>
									<li style="width:150px;"><a href="./topDupLogInLogList">중복 로그인 Log</a></li>
									<li style="width:150px;"><a href="./searchLogList">검색 통계 조회 Log</a></li>
									<li style="width:150px;"><a href="./topPmsLogList">권한 변경 Log</a></li>
									<li style="width:150px;"><a href="./topReportLogList">보고서 변경 Log</a></li>
								</ul>
							</c:if>
						</li>
						<li class="depth1">
							<a href="#;">코드관리</a>
							<c:if test="${mbrVo_Session.user_no != null && mbrVo_Session.user_state == 9 }">
								<ul>
									<li><a href="./sampleMemoPan">한줄메모예제</a></li>
									<li><a href="./sampleMbrPopPan">직원검색PopUp예제</a></li>
									<!-- <li><a href="./VacationTest">연차계산(신규1종)</a></li> -->
									<li><a href="javascript:goVacation();">연차계산(신규1종)</a></li>
									<li><a href="javascript:goVacation4();">연차계산(신규4종)</a></li>
									<li><a href="./sampleInsaOniku">인사정보(별도조회)</a></li>
									<!-- <li><a href="./expenseMain">이재조사비작업</a></li>
									<li><a href="./expenseList">이재조사비조회</a></li> -->
								</ul>
							</c:if>
						</li>
						<li class="depth1">
							<a href="#;">보고서관리</a>
							<c:if test="${mbrVo_Session.user_no != null && mbrVo_Session.user_state == 9 }">
								<ul>
									<!-- <li><a href="/rpt_close_date_update">종결일 수정</a></li> -->
									<li><a href="/sysRptCloseDateUpdate">종결일 수정</a></li>
									<li><a href="/sysSuitWorkAuthMain">적부워드전환관리</a></li>
									<li><a href="/sysRptHelpManageMain">협조건의뢰인수정</a></li>
									<!-- 
									<li><a href="./pc_mgmt_list">재직자 장비 확인</a></li>
									<li><a href="./sampleMbrPopPan">IP관리 </a></li>
									 -->
								</ul>
							</c:if>
						</li>
						<li class="depth1">
							<a href="#;">자산관리</a>
							<c:if test="${mbrVo_Session.user_no != null && mbrVo_Session.user_state == 9 }">
								<ul>
									<li><a href="/equipment_manage_main">장비관리</a></li>
									<li><a href="/equipment_manage_stat">장비통계</a></li>									
									<li><a href="/card_manage_main">카드관리</a></li>
								</ul>
							</c:if>
						</li>
						<li class="depth1">
							<a href="#;">성과급 관리</a>
							<c:if test="${mbrVo_Session.user_no != null && mbrVo_Session.user_state == 9 }">
								<ul style="width:150px;">
									<li style="width:150px;"><a href="./bonusMemberStatus?viewType=Member">직원 조회상태관리</a></li>
									<li style="width:150px;"><a href="./bonusMemberStatus?viewType=Manager">관리자 조회상태관리</a></li>
									<li style="width:150px;"><a href="./bonusMemberStatus?viewType=Career">신입/경력 설정조회관리</a></li>
									<li style="width:150px;"><a href="./bonusMemberYearTarget">직원 연간목표관리</a></li>
									<li style="width:150px;"><a href="./schBonusLogList">개인기준 분기 스케줄러 </a></li>
									<li style="width:150px;"><a href="./schBonusYearLogList">개인기준 연간 스케줄러</a></li>
									<li style="width:150px;"><a href="./schBonusTeamLogList">팀기준 스케줄러 Log</a></li>
									<li style="width:150px;"><a href="./schBonusTeamQuarterLogList">팀기준 분기별 스케줄러</a></li>
									<li style="width:150px;"><a href="./schBonusManagerQuarterSetup">분기별 팀(센터)장 설정</a></li>
									<li style="width:150px;"><a href="./schBonusManagerQuarterLogList">분기별 팀(센터)장 로그</a></li>
								</ul>
							</c:if>
						</li>
						<!-- 
						<li class="depth1">
							<a href="#;">AutoMigration</a>
							<c:if test="${mbrVo_Session.user_no != null && mbrVo_Session.user_state == 9 }">
								<ul>
									<li><a href="./migrationReport">MigrationReport</a></li>
									<li><a href="./migrationPrint1Pan">MigrationPrint</a></li>
									<li><a href="./migPrimBiz">MigrationPrimBiz</a></li>
									<li><a href="./migSuitability">MigrationSuitability</a></li>
								</ul>
							</c:if>
						</li>
						 -->
					</ul>
				</div>
				<!-- //gnb -->
			</div>
		</div>
		<div class="h_leftbg">
		</div>
	</div>
	<!-- 모래시계 로딩바 -->
	<div id="top_loading" style="display:none;z-index:1000;margin-top:300px;margin-left:900px;position:fixed;">
		<img id="loading-image" src="./resources/cmm/images/salary_loading.gif" alt="Loading..." />
	</div>
	<!-- //header -->
