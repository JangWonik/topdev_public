<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="true" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="topMainToYear" value="${now}" pattern="yyyy" />
	<script >
	/*
		$(document).ready(function(){
			$("#prmList").mouseover(function(){
				$.post("./prmListDownMenu",
						function(data,status){
							if(status =="success"){
								if(data != null){
									$("#prmListUlId").html("");
									$.each(data, 
											function(index,entry) {
												$("#prmListUlId").append(
													"<li>"
													+"<a href='"+entry.pllink+"' target='_blank'>"+entry.plname+"</a>"
													+"</li>"	
												);
											});								
								}
							}
						},"json"
				);				
			});//$("#prmList").mouseover")
			
			$("#rptStats").click(function(){
				alert("점검 중 입니다.");
			});
			
		});//$(document)
		*/
	</script>
	<script type="text/javascript">
		function openGroupSMS(){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=790; //띄울 창의 넓이
			var sh=553;  //띄울 창의 높이
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
		
		function prmEdite(){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=600; //띄울 창의 넓이
			var sh=185;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('prmEdite','_blank','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}

		function goSearchMain(){
			$("#searchMainForm").attr("action","searchMain");
			$("#searchMainForm").submit();
		}

		function goSearchMainQuery(){
			$("#searchMainSimpleQueryTxt").val( sqlRemoveText( $("#mainQueryTxt").val() ) );
			$("#searchMainForm").attr("action","searchMainQuery");
			$("#searchMainForm").submit();
		}
		
		//검색 Text 특수문자(') 입력시 SQL 오류 방지 by top3009
		function sqlRemoveText( p_input ){			
			var resultVal;
			
			if( p_input == '' ){				
				p_input = resultVal;				
			}else{
				resultVal = p_input.replace(/\'/g,""); 
			}			
			return resultVal;
			
		}
		
		//입력된 금액의 콤마를 제거하는 함수
		function removeMoneyComma( p_input ){
			var resultVal;
			
			if( p_input == '' ){				
				p_input = resultVal;				
			}else{
				resultVal = p_input.replace(/\,/g,""); 
			}			
			return resultVal;
		}
		
		//날짜 패턴을 (yyyy-mm-dd) 인지 확인하는 함수
		function datePatternChk( p_input ){
			
			var datePattern = /^\d{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/;
			
			if( !datePattern.test(p_input) ){
				return false;
			}
			
			return true;
		}
		
		//검색 Text 특수문자(') 입력시 자동으로 콤마제거 by top3009
		function changeSqlRemoveText( obj ){			
			var regExp = /[`]/gi;
			obj.value = obj.value.replace(/\'/g,""); 	//입력한 콤마를 제거			
		}
		
		
		function memberSalDtlPop(){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			
			var sw=1040; //띄울 창의 넓이
			var sh=800;  //띄울 창의 높이

			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			
			window.open('member_request_salary','tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no');
			//window.open('memberSalDtlPop','tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no');
		}
		
		function internContractPop(){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1040; //띄울 창의 넓이
			var sh=800;  //띄울 창의 높이

			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			
			window.open('member_request_intern','','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			//window.open('internContract','','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}
		
		function fnTopWinOpenDayOff(){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			
			var sw=1010; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이

			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			
			window.open('myDayoffPop?toServerYear=${topMainToYear}','tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}
		
		function fnRptCancelApprovList(){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			
			var sw=1300; //띄울 창의 넓이
			var sh=ch;  //띄울 창의 높이

			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			
			window.open('rptCancelApprovList','approvList','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}
		
		function goMail(){
			$("#emailForm").submit();
		}
		
		function goEduClass(){
			$("#eduForm").submit();
		}
		
		function goLecClass(){
			$("#lecForm").submit();
		}
		
		function goSalary4(){			
			$("#salary4Form").submit();
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

	<form id="searchMainForm" name="searchMainForm" method="post">
		<input type="hidden" id="searchMainSimpleQueryTxt" name="searchMainSimpleQueryTxt" value="${searchMainSimpleQueryTxt}" />
	</form>

	<form id="emailForm" name="emailForm" method="post" action="topMailSSO" target="_blank">
	</form>
	<form id="eduForm" name="eduForm" method="post" action="eduClass">
	</form>
	<form id="lecForm" name="lecForm" method="post" action="TopLecture">
	</form>
	<form id="salary4Form" name="salary4Form" method="post" action="TopSalay4Main">
	</form>
	<!-- header -->
	<div id="header">
		<div class="inner clear_v2">
		
			<h1 id="menuLogo">
				<a href="./"><img id="menuLogoImg" src="./resources/wm_img/common/logo.gif" alt="top - TRUST OBLIGATION PASSION" /></a>
				<div class="logobg"></div>
			</h1>
			
			<div class="hcont">
				<div class="header_top">
					<!-- 검색하기 -->
					<div class="h_schA">
						<ul>
							<li><a href="javascript:goSearchMain()">
									<img src="./resources/wm_img/common/btn_sch.gif" alt="상세검색" />
							</a></li>
							<li class="ipt">
								<input type="text" id="mainQueryTxt" name="mainQueryTxt" value="${searchMainSimpleQueryTxt}"
										onKeydown="javascript:if(event.keyCode == 13){goSearchMainQuery();}" />
							</li>
							<li><a href="javascript:goSearchMainQuery()">
								<img src="./resources/wm_img/common/bg_btnbg01.gif" alt="검색하기" />
							</a></li>
						</ul>
					</div>
					<!-- //검색하기 -->
					<ul class="logArea">
						<!-- 교육(신규) 바로가기, 전산팀, 신경혜, 김두현-->						
						<%-- <c:if test="${mbrVo_Session.user_state == 9 || mbrVo_Session.user_no == 215 || mbrVo_Session.user_no == 1265 }"> --%>
						<li><input type="button" value="TOP Edu" class="buttonAssistanceLec" onclick="javascript:goLecClass();"></li>
						<%-- </c:if> --%>
						<!-- 교육(동영상) 바로가기-->						
						<%-- <c:if test="${mbrAuthVo_Session.mbr_pms_36 != 0}">						
						<li><input type="button" value="교육바로가기" class="buttonAssistanceEdu" onclick="javascript:goEduClass();"></li>
						</c:if> --%>
						<li><a href="https://939.co.kr/tophelp"><input type="button" value="원격지원" class="buttonAssistance"></a></li>
						<!-- <li><a href="#"><input type="button" value="탑 메일" class="buttonAssistanceEmail" onclick="javascript:goMail();"></a></li> -->
						<li class="team">${mbrVo_Session.user_name} @ ${mbrVo_Session.team_name}</li>						
						<li><a href="javascript:openGroupSMS();"><img src="./resources/wm_img/common/ico_mobile.gif" alt="" /></a></li>						
						<li class="bgbt"><a href="./logout">Logout</a></li>
					</ul>
				</div>
				<!-- gnb -->
				<div id="gnb">
					<ul>
						<li class="depth1">
							<a href="#;" style="letter-spacing:-1.8px;">직원명부/관련업체</a>
							<ul>
								<li><a href="./empNmlstTmList">직원명부</a></li>
								<!-- <li><a href="./topPtnrList">관련업체(구버전)</a></li> -->
								<li><a href="./topPtnrListNew">관련업체</a></li>
							</ul>
						</li>
						<li class="depth1">
							<a href="#;">수임 / 적부</a>
							<ul>
								<c:if test="${mbrAuthVo_Session.user_no != null && mbrAuthVo_Session.mbr_pms_1 == 1}">
									<li><a href="./topSuimPage">수임등록</a></li>
								</c:if>
								<li><a href="./suimBookList">수임대장</a></li>
								<li><a href="./primbizRptList">농작물수임대장</a></li>
								<li><a href="./helpBookList">협조건</a></li>
								<li><a href="./helpSearch">협조건 검색</a></li>
								<!--<li><a href="./primbizSuimList">농작물수임대장(동익)</a></li>-->
								<li><a href="./suitList10">KB 적부</a></li>
								<li><a href="./suitList18">삼성 적부</a></li>
								<li><a href="./topSuimSuit17List">흥국 적부</a></li>
								<li><a href="./topSuimSuit12List">한화 적부</a></li>
							</ul>
						</li>
						<li class="depth1">
							<a href="#;" style="letter-spacing:-1.5px;">중요공지 / 자료실</a>
							<ul>
								<li><a href="./noticeTopBoardList">중요공지</a></li>
								<!-- <li><a href="./brd_guide_list">사내규정·지침</a></li> -->
								<li><a href="./brdGuideBoardList">사내규정·지침</a></li>
								<!-- <li><a href="./referenceTopBoardList">자료실</a></li> -->
								<li><a href="./freeBoardList">자유게시판</a></li>																
								<!-- <li><a href="/brd_faq_list">전산지원FAQ(옛날꺼)</a></li> -->
								<li><a href="./supportTopBoardList">전산지원FAQ</a></li>
								
								<li><a href="./referencePtnrBoardList">- 보험사 자료실 -</a></li>
								<li><a href="./referencePtnrBoardList">보험사 공지·자료실</a></li>
								<li><a href="./referencePtnrBoardList?cateSearch=1">보험사 평가기준</a></li>
								<li><a href="./referencePtnrBoardList?cateSearch=1">보험사 평가결과</a></li>								
								<!-- 자료실 내 인사총무서식 추가 -->
								<li><a href="./referenceTopBoardListNew">---- 자료실 ----</a></li>
								<li><a href="./referenceTopBoardListNew">탑 자료실</a></li>
								<c:if test="${mbrVo_Session.team_type != 4}">
									<li><a href="./referenceTopBoardListNew?cateSearch=1">법률자문 등</a></li>
									<li><a href="./referenceTopBoardListNew?cateSearch=2">우수보고서</a></li>
								</c:if>
								<li><a href="./referenceTopBoardListNew?cateSearch=3">인사총무서식</a></li>
								<!-- 기존 자료실에 물보험 자료실을 탭형태로 추가함 -->
								<!-- <li><a href="./refReportBoardList">물보험자료실</a></li> -->
<!-- 								<li><a href="helpDeskBoardList">전산지원요청</a></li> -->
							</ul>
						</li>
						
						<c:choose>
							<c:when test="${mbrAuthVo_Session.user_no != null && mbrAuthVo_Session.mbr_pms_21 == 1}">
								<!-- <li><a href="./statisticsIndex">보고서통계</a></li> -->
								<li><a href="./statisticsIndex">통계</a></li>
							</c:when>
							<c:otherwise>
								<!-- <li><a href="#">보고서통계</a></li> -->
								<li><a href="#">통계</a></li>
							</c:otherwise>
						</c:choose>
						
						<li class="depth1">
							<a href="#;">인사 / 기획</a>
							<ul>
								<%-- <c:if test="${mbrVo_Session.work_type_cd == 3 or mbrVo_Session.work_type_cd == 14 
											  or mbrAuthVo_Session.mbr_pms_28 == 1 or mbrAuthVo_Session.mbr_pms_28 == 4
											  or mbrVo_Session.user_no == 1117 or mbrVo_Session.user_no == 670}">
									<li><a href="vacationAprvList">휴가결재</a></li>							
								</c:if> --%>
								
								<!-- 휴가결재 신규(1종) 시작 20191111 해제 -->																
								<c:if test="${mbrAuthVo_Session.mbr_pms_28 == 1 or mbrAuthVo_Session.mbr_pms_28 == 4 or mbrAuthVo_Session.mbr_pms_28 == 5}">
									<li><a href="vacationApproval">휴가결재</a></li>
									<li><a href="leaveApproval">휴직결재</a></li>
								</c:if>
								<!-- 휴가결재 신규(1종) 끝 -->																
								<%--
								<c:choose>
									<c:when test="${mbrVo_Session.user_state == 9}">
										<li><a href="./topDayoffList">휴가결재(1종)</a></li>
										<li><a href="vacationAprvList">휴가결재(4종)</a></li>
									</c:when>
									<c:when test="${(mbrVo_Session.work_type_cd == 3  || mbrVo_Session.work_type_cd == 4 
												  || mbrVo_Session.work_type_cd == 7  || mbrVo_Session.work_type_cd == 8 
												  || mbrVo_Session.work_type_cd == 14 || mbrVo_Session.work_type_cd == 15 ) 
												  && (mbrVo_Session.team_type == 1 || mbrVo_Session.team_type == 0) }">
										<li><a href="./topDayoffList">휴가결재</a></li>
									</c:when>
									<c:when test="${mbrAuthVo_Session.mbr_pms_28 == 4}">
										<li><a href="vacationAprvList">휴가결재</a></li>
									</c:when>
								</c:choose>
							 	--%>
							 	
								<c:if test="${mbrAuthVo_Session.user_no != null && (mbrAuthVo_Session.mbr_pms_14 == 1 || mbrAuthVo_Session.mbr_pms_15 == 1)}">
									<!-- <li><a href="./topMemberState">(구)인사관리(개인)</a></li> -->									
									<li><a href="./topMemberStateNew">인사관리(개인)</a></li>									
									<li><a href="./topTeamState">인사관리(팀)</a></li>
									<li><a href="./topInsaStatMain">인사관리(현황통계)</a></li>
									<li><a href="./topInsaCertiMain">인사관리(자격현황)</a></li>
									<%-- 장비관리 메뉴 추가 --%>
									<li><a href="./equipment_manage_main_view">장비관리</a></li>
								</c:if>
								<!-- 계약관리 메뉴 추가 -->
								<c:if test="${mbrAuthVo_Session.mbr_pms_37 != 0}">
									<li><a href="./contract_manage_index">계약(서)관리</a></li>
								</c:if>
								
								<%-- <c:if test="${mbrAuthVo_Session.user_no eq '989' or mbrAuthVo_Session.user_no eq '1620' or mbrAuthVo_Session.user_no eq '1117'}">
									<li><a href="./equipment_manage_main">입/퇴사 확인</a></li>
								</c:if> --%>
								
								<c:if test="${mbrAuthVo_Session.user_no != null && mbrAuthVo_Session.mbr_pms_14 == 1}">
									<li><a href="#" onclick ="window.open('topMemberAdd','_blank','width=540,height=230,scrollbars=no');">사원등록</a></li>
								</c:if>
								<c:if test="${mbrAuthVo_Session.user_no != null && mbrAuthVo_Session.mbr_pms_16 == 1}">
									<li><a href="./topCertMng">재직증명서관리</a></li>
									<li><a href="./topDocMng">인사서식관리</a></li>
								</c:if>
								<c:if test="${mbrAuthVo_Session.user_no != null && mbrAuthVo_Session.mbr_pms_11 == 1}">
									<li><a href="./noticePtnr1Board">보험사공지(1종)</a></li>
								</c:if>
								<c:if test="${mbrAuthVo_Session.user_no != null && mbrAuthVo_Session.mbr_pms_12 == 1}">
									<li><a href="./noticePtnr4Board">보험사공지(4종)</a></li>
								</c:if>
								<c:if test="${mbrAuthVo_Session.user_no != null && mbrAuthVo_Session.mbr_pms_13 == 1}">
									<li><a href="./teamlist">팀 관 리</a></li>
								</c:if>
								<!-- 보고서 보험사 양식시작 -->
								<c:if test="${mbrAuthVo_Session.mbr_pms_31 != 0}">
									<li><a href="./insuTemplist">보험사서식관리</a></li>
								</c:if>
								<!-- 성과급 실적로그 조회시작 -->
								<c:if test="${mbrAuthVo_Session.mbr_pms_45 != 0}">
									<li><a href="schBonusLogListView">- 성과급 로그조회 -</a></li>
									<li><a href="schBonusLogListView">개인기준 스케줄러</a></li>
									<li><a href="schBonusTeamLogListView">팀기준 스케줄러</a></li>
									<li><a href="schBonusTeamQuarterLogListView">팀기준 분기별 스케줄러</a></li>
								</c:if>
							</ul>
						</li>
						
						<%--
							<ul>
								<c:if test="${mbrAuthVo_Session.user_no != null && mbrAuthVo_Session.mbr_pms_7 > 0}">
									<li><a href="./rptInvList">Invoice</a></li>
									<li><a href="./primBizInvList">Invoice농작물</a></li>
								</c:if>
								<c:if test="${mbrAuthVo_Session.user_no != null && mbrAuthVo_Session.mbr_pms_13 == 1}">
									<li><a href="./teamlist">팀 관 리</a></li>
								</c:if>
								<c:if test="${mbrAuthVo_Session.user_no != null && mbrAuthVo_Session.mbr_pms_14 == 1}">
									<li><a href="#" onclick ="window.open('topMemberAdd','_blank','width=540,height=230,scrollbars=no');">사원등록</a></li>
								</c:if>
								<c:if test="${mbrAuthVo_Session.user_no != null && (mbrAuthVo_Session.mbr_pms_14 == 1 || mbrAuthVo_Session.mbr_pms_15 == 1)}">
									<li><a href="./topTeamState">팀별 인사 관리</a></li>
									<li><a href="./topMemberState">인사 및 평가 관리</a></li>
								</c:if>
								<c:if test="${mbrAuthVo_Session.user_no != null && mbrAuthVo_Session.mbr_pms_16 == 1}">
									<li><a href="./topCertMng">재직증명서관리</a></li>
									<li><a href="./topDocMng">품의서 확인 관리</a></li>
								</c:if>
								<c:if test="${mbrAuthVo_Session.user_no != null && (mbrVo_Session.team_id_main == 7 || mbrAuthVo_Session.mbr_pms_17 eq '1' || mbrAuthVo_Session.mbr_pms_18 eq '1')}">
<!-- 									<li><a href="./topCostList">경비내역(동익)</a></li> -->
									<li><a href="./newCostList">경비내역</a></li>
									<li><a href="./topCostStatistics">경비통계</a></li>
								</c:if>
								<c:if test="${mbrAuthVo_Session.user_no != null && mbrAuthVo_Session.mbr_pms_11 == 1}">
									<li><a href="./noticePtnr1Board">보험사공지(1종)</a></li>
								</c:if>
								<c:if test="${mbrAuthVo_Session.user_no != null && mbrAuthVo_Session.mbr_pms_12 == 1}">
									<li><a href="./noticePtnr4Board">보험사공지(4종)</a></li>
								</c:if>
							</ul>						
						 --%>
						
						<li class="depth1">
							<a href="#;">재무</a>
							<ul>
								<c:if test="${mbrAuthVo_Session.user_no != null && mbrAuthVo_Session.mbr_pms_7 > 0}">
									<li><a href="./rptInvList">Invoice</a></li>
									<li><a href="./primBizInvList">Invoice농작물</a></li>
									<li><a href="./rptTaxList">세금계산서</a></li>
									<li><a href="./sDepositManage">소액입금관리</a></li>
								</c:if>								
								<c:if test="${mbrAuthVo_Session.user_no != null && (mbrVo_Session.team_id_main == 7 || mbrAuthVo_Session.mbr_pms_17 eq '1' || mbrAuthVo_Session.mbr_pms_18 eq '1')}">
<!-- 									<li><a href="./topCostList">경비내역(동익)</a></li> -->
									<!--
									<li><a href="./newCostList">경비내역</a></li>
									<li><a href="./topCostStatistics">경비통계</a></li>
									-->
																	
									<li><a href="./cost_tm_list">경비내역</a></li>
									<li><a href="./cost_statistics">경비통계</a></li>
									
								</c:if>
								<c:if test="${mbrAuthVo_Session.user_no != null && mbrAuthVo_Session.mbr_pms_7 > 0}">
									<!-- <li><a href="./topStaffList">입/퇴사 확인</a></li> -->
									<!-- 신규 입 /퇴사확인 2023-04-19 -->
									<li><a href="./topStaffListNew">입/퇴사 확인</a></li>
								</c:if>
								<!-- 인보험 급여관리 (민감정보로 특정 아이디만 열어준다.) -->
								<c:if test="${mbrAuthVo_Session.user_no == 1786 || mbrAuthVo_Session.user_no == 670 || mbrAuthVo_Session.user_no == 474 || mbrAuthVo_Session.user_no == 2079}">
									<li><a href="javascript:goSalary4();">인보험 급여관리</a></li>
								</c:if>
							</ul>
						</li>						
						
						
						<li class="depth1">
							<a href="#;">My Menu</a>
							<ul>
								<li><a href="myInfo">정보수정</a></li>
								
<!-- 								<li><a href="myCostInsList">나의경비내역(동익)</a></li> -->
<!-- 								<li><a href="dutyList">당직 현황/비용 입력</a></li> -->
<!-- 								<li><a href="myCostInsListNew">나의경비내역</a></li> -->
<!-- 								<li><a href="#noloc" onclick="fnTopWinOpenDayOff();">나의휴가신청</a></li> -->
<!-- 								<li><a href="myDayoffInsList">나의휴가내역</a></li> -->
								<li><a href="myReportExcel">나의미결내역</a></li>
								<li><a href="./myStatistics">나의통계</a></li>
								<li><a href="myDocList">나의품의서</a></li>
								<li><a href="./myNoSiteList">나의 미결 미제출 </a></li>
								
								<!-- 		
								29 : 서면심사1팀
								65 : 서면심사2팀
								134: 서면심사3팀
								80 : 서면심사4팀
								61 : 서면심사5팀
								 -->
								<c:if test="${ mbrAuthVo_Session.mbr_pms_24 == 1 
											or mbrAuthVo_Session.mbr_pms_24 == 2 }">
									<li><a href="./speedMngList?flag=user&code=0">나의 보고서 알림</a></li>
								</c:if>
								
								<c:if test="${ mbrAuthVo_Session.mbr_pms_24 == 2 }">
 									<li><a href="./speedMngList?flag=team&code=0">팀 보고서 알림</a></li>
								</c:if>
								
								<c:if test="${ mbrAuthVo_Session.mbr_pms_24 == 3 }">
									<li><a href="./speedMngList?flag=admin&code=0">보고서 알림</a></li>
								</c:if>
								
								<c:if test="${mbrAuthVo_Session.mbr_pms_25 == 1 or  mbrAuthVo_Session.mbr_pms_25 == 2 or mbrAuthVo_Session.mbr_pms_25 == 3 or mbrAuthVo_Session.mbr_pms_25 == 4}">
									<li><a href="./rptMbrchgList?flag=${mbrAuthVo_Session.pms25Val}&code=0">보고서 이첩</a></li>
								</c:if>
								<!-- 통화내역 조회 -->
								<c:if test="${mbrAuthVo_Session.mbr_pms_35 != 0}">
									<li><a href="nilinkRecordList">통화내역조회</a></li>
								</c:if>								
<%-- 								<c:if test="${mbrVo_Session.user_no == 6 || mbrVo_Session.user_no == 966 || mbrVo_Session.user_no == 670 || mbrVo_Session.user_no == 1117 || mbrVo_Session.user_no == 215 || mbrVo_Session.user_no == 1}">
									<li><a href="BoardMemSalList">직원연봉</a></li>
								</c:if> --%>
								<c:if test="${salFlag == 1 || salFlag == 2}">
									<li style="cursor:pointer;">
										<a onclick="memberSalDtlPop()">연봉 계약</a>
									</li>
								</c:if>
								
								<c:if test="${internSalFlag == 1 || internSalFlag == 2}" >
									<li style="cursor:pointer;">
										<a onclick="internContractPop()">인턴사원 근로계약</a>
									</li>
								</c:if>
							</ul>
						</li>
						<li class="depth1">
							<a href="#;">신청 (내역)</a>
							<ul>
								<li><a href="myCertList">재직증명서</a></li>
								<li><a href="dutyList">당직신청</a></li>
								<!-- <li><a href="myVacationMain">휴가신청&middot;내역</a></li> -->
								<!-- 휴가신청 신규 시작 by top3009-->
								<li><a href="myVacationMainNew">휴가신청&middot;내역</a></li>
								<!-- 휴가신청 신규 끝 by top3009-->								
								<!-- 휴가결재 신규(1종) 시작-->																
								<c:if test="${vacationApprovalAuth == 1 or mbrAuthVo_Session.mbr_pms_28 == 1 or mbrAuthVo_Session.mbr_pms_28 == 4 or mbrAuthVo_Session.mbr_pms_28 == 5}">
									<li><a href="vacationApproval"><!-- (신규) -->휴가결재</a></li>
								</c:if>
								<!-- 휴가결재 신규(1종) 끝 -->
								<c:if test="${mbrAuthVo_Session.mbr_pms_34 != 0}">
									<li><a href="vacationManager">관리자휴가신청</a></li>
								</c:if>
								
								<!-- 휴직신청 신규 시작 by top3009-->
								<li><a href="myLeaveMain">휴직신청&middot;내역</a></li>
								<!-- 휴직신청 신규 끝 by top3009-->
								
								<!-- 휴직결재 신규 시작 by top3009-->
								<c:if test="${vacationApprovalAuth == 1 or mbrAuthVo_Session.mbr_pms_28 == 1 or mbrAuthVo_Session.mbr_pms_28 == 4 or mbrAuthVo_Session.mbr_pms_28 == 5}">
									<li><a href="leaveApproval">휴직결재</a></li>
								</c:if>
								<!-- 휴직결재 신규 시작 by top3009-->
								
								<!-- 관리자 휴직 결재 -->
								<c:if test="${mbrAuthVo_Session.mbr_pms_34 != 0}">
									<li><a href="leaveManager">관리자휴직신청</a></li>
								</c:if>
								
								<!-- 인보험 자료실 -->
								<c:if test="${mbrAuthVo_Session.mbr_pms_34 == 4 or mbrVo_Session.user_no == 1786}">
									<li><a href="insu4Templist">(인)보험자료실</a></li>
								</c:if>
								<%--
								<c:choose>
									<c:when test="${mbrVo_Session.user_state == 9}">
										<li><a href="#noloc" onclick="fnTopWinOpenDayOff();">휴가신청</a></li>
										<li><a href="myDayoffInsList">휴가내역(1종)</a></li>									
										<li><a href="myVacationMain">휴가내역(4종)</a></li>
									</c:when>
									<c:when test="${mbrVo_Session.team_type == 4}">
										<li><a href="myVacationMain">휴가내역</a></li>
									</c:when>
									<c:otherwise>
										<li><a href="#noloc" onclick="fnTopWinOpenDayOff();">휴가신청</a></li>
										<li><a href="myDayoffInsList">휴가내역</a></li>
									</c:otherwise>
								</c:choose>
								 --%>
								<%--								 
								<li><a href="myCostInsListNew">경비신청(내역)</a></li>
								--%>
								<li><a href="/cost_detail">경비신청(내역)</a></li>
								<!-- 강의실 신청 기능 주석처리 20231122 (홍기헌 부장요청사항) -->
								<!-- <li><a href="./lectureRoomCalendar">강의실사용신청</a></li> -->
								<!-- <li><a href="./lectureRoomApplicationList">강의실신청내역</a></li> -->
								<li><a href="helpDeskBoardList">전산지원신청</a></li>
<!-- 								<li><a href="https://939.co.kr/tophelp">원격지원</a></li> -->
								<c:if test="${mbrAuthVo_Session.mbr_pms_47 != 0}">
									<li><a href="getSuimReportPtnr">손해사정서교부현황</a></li>
								</c:if>
							</ul>
						</li>
						 
<!-- 							<ul id = "prmListUlId"></ul> -->
<!-- 								<li><a href="https://939.co.kr/tophelp" id="prmList">원격지원</a></li> -->
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
	<style type="text/css">
		.buttonAssistanceLec{
			width:80px;
			height:23px;
		    background-color:#FFA500;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		    }		
		.buttonAssistanceEdu{
			width:100px;
			height:23px;
		    background-color:#FF0099;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		    }
		.buttonAssistance{
			width:70px;
			height:23px;
		    background-color:#2E7EE8;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		    }
		
		.buttonAssistanceEmail{
			width:60px;
			height:23px;
		    background-color:darkCyan;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		    }
	</style>