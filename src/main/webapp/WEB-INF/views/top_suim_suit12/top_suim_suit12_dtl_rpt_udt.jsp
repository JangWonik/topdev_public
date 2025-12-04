<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	<%--<script src="./resources/daum/161109.js"></script>--%>
	<script src="./resources/daum/postcode.v2.js"></script>
	<script src='https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js'></script>
	
</head>

<script>
	$(document).ready(function(){
		$.ajaxSetup({cache:false});
		if ( "${getSuimSuit12DtlBsc.editYN2}" < 1 ){
			alert("접근 권한이 없습니다.");
			window.close();
			return false;
		}
		
		$("#suimTmMbrPopBtn").click(function(){//담당 팀, 담당 직원 바꾸기 팝업
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=500; //띄울 창의 넓이
			var sh=550;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('suimTmMbrPop?gbNo='+$("#gbNoForPop").val()+'&smNo='+$("#smNoForPop").val()+'&tmNo='+$("#tmNoForPop").val(),'SuimTmMbrPop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		});//$("#suimTmMbrPopBtn").click

		$("#suimPtnrMbrPopBtn").click(function(){//담당 팀, 담당 직원 바꾸기 팝업
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=500; //띄울 창의 넓이
			var sh=550;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('suimPtnrMbrPop?gbNo='+$("#gbNoForPop").val()+'&smNo='+$("#smNoForPop").val()+'&ptnrNo='+$("#ptnrNoForPop").val(),'SuimTmMbrPop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		});//$("#suimPtnrMbrPopBtn").click

	});//$(document).ready

	function openSMS(hpNo){
		var cw=screen.availWidth;
		var ch=screen.availHeight;
		var sw=380; //띄울 창의 넓이
		var sh=533;  //띄울 창의 높이
		var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
		var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
		window.open('simpleSMSForm?hpNo='+hpNo,'simpleSMS','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
	}//openSMS

	function openBrdRefPtnr(ptnrSearch){
		var cw=screen.availWidth;
		var ch=screen.availHeight;
		var sw=1010; //띄울 창의 넓이
		var sh=740;  //띄울 창의 높이
		var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
		var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
		window.open('referencePtnrBoardListPop?ptnrSearch='+ptnrSearch,'simpleSMS','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
	}//openSMS
	
	
	$(document).ready(function(){
		/* 취소 버튼 동작 */
		$("#cancel").click(function(){
			history.back();
		});
		/* 수정 확인 버튼 동작 */
		$("#edite").click(function(){
			alert("확인되었습니다");
			history.back();
		});
	});//$(document).ready
	
	
</script>

<!-- 파일 다운로드 후 새로고침용 form -->
<form id="suimSuit12DtlRptDelForm" action="suimSuit12DtlRptUdt" method="POST" id="fileDelsubmit">
	<input type="hidden" name="suimRptNo" value="${suimRptNo}" />
</form>

<c:set var="suimRptNo" value="${suimRptNo}"/>
<body>

	<!-- header -->
	<div id="headerpop_mbr">
		<div class="inner clear_v2">
			<h1>
				<img src="./resources/wm_img/common/logo.gif" height="40" alt="top - TRUST OBLIGATION PASSION" />
			</h1>
			<div style="text-align:center;padding-top:10px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
				<font color="white"><b><span style="font-size:11pt;"> 장기 물보험 적부 시스템</span></b></font>
			</div>
		</div>
	</div>
	<!-- //header -->

	<!-- center -->
	<div id ="container">
		<div class="contetnsPop">
			<div class="center_cnt">
				<div class="centercnt_bot1-3">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">적부(한화) 기본정보</a></li>
							</ul>
						</div>

						<div class="guestcnt5" style="display:block;">
						<b>1. 보험계약사항</b>
						<div class= "tableStyle4">
							<table>
								<colgroup>
									<col width="15%">
									<col width="35%">
									<col width="15%">
									<col width="35%">
								</colgroup>
								<tr>
									<td bgcolor="#E7ECF1" align="center"><b>계약자</b></td>
									<td>${getSuimSuit12DtlBsc.rqCrtNm}</td>
									<td bgcolor="#E7ECF1" align="center"><b>계약일</b></td>
									<td>${getSuimSuit12DtlBsc.rqCnrDt}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1" align="center"><b>설계번호</b></td>
									<td>${getSuimSuit12DtlBsc.rqPlNo}</td>
									<td bgcolor="#E7ECF1" align="center"><b>증권번호</b></td>
									<td>${getSuimSuit12DtlBsc.rqPlyNo}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1" align="center"><b>증권명</b></td>
									<td colspan="3">${getSuimSuit12DtlBsc.rqGdNm}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1" align="center"><b>위임일자</b></td>
									<td>${getSuimSuit12DtlBsc.rqPptyRqDt}</td>
									<td bgcolor="#E7ECF1" align="center"><b>처리구분</b></td>
									<td>
										<c:if test="${getSuimSuit12DtlBsc.rqDlFlgCd eq '01'}">사전의뢰</c:if>
										<c:if test="${getSuimSuit12DtlBsc.rqDlFlgCd eq '02'}">사후의뢰</c:if>
										<c:if test="${getSuimSuit12DtlBsc.rqDlFlgCd eq '03'}">취소</c:if>
										<c:if test="${getSuimSuit12DtlBsc.rqDlFlgCd eq '' || getSuimSuit12DtlBsc.rqDlFlgCd eq '0'}"></c:if>
									</td>
								</tr>
							</table>
						</div>
						<br>
						<b>2. 조사결과</b>
						<div class= "tableStyle4">
							<table>
								<colgroup>
									<col width="40%">
									<col width="10%">
									<col width="40%">
									<col width="10%">
								</colgroup>
								<tr>
									<td bgcolor="#E7ECF1" align="center"><b>완료여부</b></td>
									<td>
										<c:if test="${getSuimSuit12DtlBsc.rstPptyNvCpltYn eq '1'}">완료</c:if>
										<c:if test="${getSuimSuit12DtlBsc.rstPptyNvCpltYn eq '2'}">미수검</c:if>
										<c:if test="${getSuimSuit12DtlBsc.rstPptyNvCpltYn eq '' || getSuimSuit12DtlBsc.rstPptyNvCpltYn eq '0'}"></c:if>
									</td>
									<td bgcolor="#E7ECF1" align="center"><b>조사결과</b></td>
									<td>
										<c:if test="${getSuimSuit12DtlBsc.rstNvRst eq '01'}">양호(일치)</c:if>
										<c:if test="${getSuimSuit12DtlBsc.rstNvRst eq '02'}">수정필요(불일치)</c:if>
										<c:if test="${getSuimSuit12DtlBsc.rstNvRst eq '' || getSuimSuit12DtlBsc.rstNvRst eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1" align="center"><b>조사자의견</b></td>
									<td colspan="3">${getSuimSuit12DtlBsc.rstNvRstCtn}</td>
									
								</tr>
							</table>
						</div>
						<br>
						<b>3. 건물계약확인사항</b>
						<c:forEach items="${getSuimSuit12DtlBldList}" var="getSuimSuit12DtlBld" varStatus="status">
						<div class= "tableStyle4">
							<table>
								<colgroup>
									<col width="12%">
									<col width="12%">
									<col width="12%">
									<col width="31%">
									<col width="13%">
								</colgroup>
								<tr><p>${status.index + 1}) 건물 ${status.index + 1} 확인사항</p></tr>
								<tr>
									<td bgcolor="#E7ECF1" align="center"><b>실사자</b></td>
									<td bgcolor="#E7ECF1" align="center"><b>실사일</b></td>
									<td bgcolor="#E7ECF1" align="center"><b>면담자</b></td>
									<td bgcolor="#E7ECF1" align="center"><b>계약자와의관계</b></td>
									<td bgcolor="#E7ECF1" align="center"><b>연락처</b></td>
								</tr>
								<tr>
									<td>${getSuimSuit12DtlBsc.userName}</td>
									<td>${getSuimSuit12DtlBld.getRstBld_RcnDt()}</td>
									<td>${getSuimSuit12DtlBld.getRstBld_InvpsNm()}</td>
									<td>${getSuimSuit12DtlBld.getRstBld_CrRelpcRel()}</td>
									<td>${getSuimSuit12DtlBld.getRstBld_InvpsCntAd()}</td>
								</tr>
							</table>
						</div>
						<br>
						<div class= "tableStyle4">
							<table>
							<colgroup>
									<col width="15%">
									<col width="55%">
									<col width="15%">
									<col width="15%">
								</colgroup>
								<tr>
									<td bgcolor="#E7ECF1"><b>구분</b></td>
									<td bgcolor="#E7ECF1"><b>계약내용</b></td>
									<td bgcolor="#E7ECF1"><b>일치여부</b></td>
									<td bgcolor="#E7ECF1"><b>기타의견</b></td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>실소유자</b></td>
									<td>${getSuimSuit12DtlBld.getRqBld_RlOwrNm()}</td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_RlOwrNm() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_RlOwrNm() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_RlOwrNm() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_RlOwrNm() eq '0'}"></c:if>
									</td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_RlOwrNmEtMtt() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>소재지</b></td>
									<td>${getSuimSuit12DtlBld.getRqBld_CtnAdr()}</td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_CtnAdr() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_CtnAdr() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_CtnAdr() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_CtnAdr() eq '0'}"></c:if>
									</td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_CtnAdr() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>건물 급수</b></td>
									<td>${getSuimSuit12DtlBld.getRqBld_BldRnkCd()}</td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_BldRnkCd() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_BldRnkCd() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_BldRnkCd() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_BldRnkCd() eq '0'}"></c:if>
									</td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_BldRnkcdEtMtt() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>영위업종</b></td>
									<td>${getSuimSuit12DtlBld.getRqBld_MngmBnNm()}</td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_MngmBnNm() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_MngmBnNm() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_MngmBnNm() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_MngmBnNm() eq '0'}"></c:if>
									</td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_MngmBnnmEtMtt() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>건물 기둥</b></td>
									<td>${getSuimSuit12DtlBld.getRqBld_PleNm()}</td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_PleNm() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_PleNm() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_PleNm() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_PleNm() eq '0'}"></c:if>
									</td>
									<td></td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>건물 지붕</b></td>
									<td>${getSuimSuit12DtlBld.getRqBld_RofNm()}</td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_RofNm() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_RofNm() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_RofNm() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_RofNm() eq '0'}"></c:if>
									</td>
									<td></td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>건물 외벽</b></td>
									<td>${getSuimSuit12DtlBld.getRqBld_WllNm()}</td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_WllNm() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_WllNm() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_WllNm() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_WllNm() eq '0'}"></c:if>
									</td>
									<td></td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>지상(층)</b></td>
									<td>${getSuimSuit12DtlBld.getRqBld_Grod()}</td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_GrodEqalYn() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_GrodEqalYn() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_GrodEqalYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_GrodEqalYn() eq '0'}"></c:if>
									</td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_GrodEtMtt() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>지하(층)</b></td>
									<td>${getSuimSuit12DtlBld.getRqBld_Undg()}</td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_UndgEqalYn() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_UndgEqalYn() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_UndgEqalYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_UndgEqalYn() eq '0'}"></c:if>
									</td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_UndgEtMtt() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>연면적</b></td>
									<td>${getSuimSuit12DtlBld.getRqBld_Ttare()}</td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_TtareEqalYn() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_TtareEqalYn() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_TtareEqalYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_TtareEqalYn() eq '0'}"></c:if>
									</td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_TtareEtMtt() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>가입면적</b></td>
									<td>${getSuimSuit12DtlBld.getRqBld_IsAre()}</td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_IsAreEqalYn() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_IsAreEqalYn() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_IsAreEqalYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_IsAreEqalYn() eq '0'}"></c:if>
									</td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_IsAreEtMtt() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>가입유형</b></td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRqBld_IsTp() eq '01'}">전치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRqBld_IsTp() eq '02'}">일부</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRqBld_IsTp() eq '' || getSuimSuit12DtlBld.getRqBld_IsTp() eq '0'}"></c:if>
									</td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_IsTpEqalYn() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_IsTpEqalYn() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_IsTpEqalYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_IsTpEqalYn() eq '0'}"></c:if>
									</td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_IsTpEqalYn() eq '0'}"></c:if>
									</td>
								</tr>
								
								<tr>
									<td bgcolor="#DCFFDC"><b>판넬 유무</b></td>
									<td></td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_PanlYn() eq '1'}">유</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_PanlYn() eq '2'}">무</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_PanlYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_PanlYn() eq '0'}"></c:if>
									</td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_PanlPst() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>천막 유무</b></td>
									<td></td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_TntYn() eq '1'}">유</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_TntYn() eq '2'}">무</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_TntYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_TntYn() eq '0'}"></c:if>
									</td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_TntPst() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>방화구획</b></td>
									<td></td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_FlrFirZoneYn() eq '1'}">유</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_FlrFirZoneYn() eq '2'}">무</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_FlrFirZoneYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_FlrFirZoneYn() eq '0'}"></c:if>
									</td>
									<td></td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>확인의견</b></td>
									<td colspan="3">${getSuimSuit12DtlBld.getRstBld_EtMtt1()}</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>상설할인</b></td>
									<td></td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_SlEqmtDcYn() eq '1'}">유</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_SlEqmtDcYn() eq '2'}">무</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_SlEqmtDcYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_SlEqmtDcYn() eq '0'}"></c:if>
									</td>
									<td></td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>재래시장</b></td>
									<td></td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_MrkYn() eq '1'}">유</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_MrkYn() eq '2'}">무</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_MrkYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_MrkYn() eq '0'}"></c:if>
									</td>
									<td></td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>층별업종</b></td>
									<td colspan="3">
									<b>지하 :</b>
									${getSuimSuit12DtlBld.getRstBld_FlrBtpUndg()}<br>
									<b>1층 :</b>
									${getSuimSuit12DtlBld.getRstBld_FlrBtpFloor1()}<br>
									<b>2층 :</b>
									${getSuimSuit12DtlBld.getRstBld_FlrBtpFloor2()}<br>
									<b>3층 :</b>
									${getSuimSuit12DtlBld.getRstBld_FlrBtpFloor3()}
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>종합의견</b></td>
									<td colspan="3">${getSuimSuit12DtlBld.getRstBld_EtMtt2()}</td>
								</tr>
							</table>
						</div>
						</c:forEach>
						<br>
						<b>4. 목적물 확인사항</b>
						<div class= "tableStyle4">
							<table>
								<colgroup>
									<col width="10%">
									<col width="10%">
									<col width="40%">
									<col width="40%">
								</colgroup>
								<tr>
									<td bgcolor="#E7ECF1" align="center"><b>목적물</b></td>
									<td bgcolor="#E7ECF1" colspan="3" align="center"><b>확인사항</b></td>
								</tr>
								<c:forEach items="${getSuimSuit12DtlOjList}" var="getSuimSuit12DtlOj" varStatus="status">
								<tr>
									<td rowspan="7"><b>목적물 ${status.index + 1} </b></td>
									<td>유형</td>
									<td>${getSuimSuit12DtlOj.getRqOj_OjTp()}</td>
									<td>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_OjTpEqalYn() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_OjTpEqalYn() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_OjTpEqalYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_OjTpEqalYn() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td>급수</td>
									<td>${getSuimSuit12DtlOj.getRqOj_Rnk()}</td>
									<td>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_RnkEqalYn() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_RnkEqalYn() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_RnkEqalYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_RnkEqalYn() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td>수용구분</td>
									<td>
										<c:if test="${getSuimSuit12DtlOj.getRqOj_AccptPlcFlgCd() eq '01'}">건물내</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRqOj_AccptPlcFlgCd() eq '02'}">건물밖(야적)</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRqOj_AccptPlcFlgCd() eq ''}"></c:if>
									</td>
									<td>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_AccptPlcFlgcdEqalYn() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_AccptPlcFlgcdEqalYn() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_AccptPlcFlgcdEqalYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_AccptPlcFlgcdEqalYn() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td>야적물건</td>
									<td>
										<c:if test="${getSuimSuit12DtlOj.getRqOj_FldstObjFlgCd() eq '01'}">가연성</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRqOj_FldstObjFlgCd() eq '02'}">불연성</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRqOj_FldstObjFlgCd() eq ''}"></c:if>
									</td>
									<td>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_FldstObjFlgcdEqalYn() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_FldstObjFlgcdEqalYn() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_FldstObjFlgcdEqalYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_FldstObjFlgcdEqalYn() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td>지하수용</td>
									<td>
										<c:if test="${getSuimSuit12DtlOj.getRqOj_UndgAccptYn() eq '01'}">수용</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRqOj_UndgAccptYn() eq '02'}">수용안함</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRqOj_UndgAccptYn() eq ''}"></c:if>
									</td>
									<td>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_UndgAccptYnEqalYn() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_UndgAccptYnEqalYn() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_UndgAccptYnEqalYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_UndgAccptYnEqalYn() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td>세부사항</td>
									<td>${getSuimSuit12DtlOj.getRqOj_Dt_Mtt()}</td>
									<td>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_Dt_MttEqalYn() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_Dt_MttEqalYn() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_Dt_MttEqalYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_Dt_MttEqalYn() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td>수용장소</td>
									<td>${getSuimSuit12DtlOj.getRqOj_Dt_AccptPlc()}</td>
									<td>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_Dt_AccptPlcEqalYn() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_Dt_AccptPlcEqalYn() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_Dt_AccptPlcEqalYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_Dt_AccptPlcEqalYn() eq '0'}"></c:if>
									</td>
								</tr>
								</c:forEach>
							</table>
						</div>
						<br>
						
						<b>5. 실사 사진 </b>
						<div class= "tableStyle4">
							<table align="center" cellpadding="0" cellspacing="0" class="suitRptTable">
								<tr>
									<td width="30%" align="center">
										<b>※ 파일 선택</b>
									</td>
									<td>
										<%@include file="../include/uploadform_suimSuit12RptFile.jsp"%>
									</td>
								</tr>
							</table>
							<table  align="center" cellpadding="0" cellspacing="0" class="suitRptTable">
								<colgroup>
									<col width="70%">
									<col width="30%">
								</colgroup>
								<tr>
									<td colspan="2" align="center"><font color="blue">사진 목록</font></td>
								</tr>
								<input type="hidden" id="fileListSize" value="${fileListSize}" />		
								<tbody id = "suit12FileListBody" style="margin-bottom:20px;">
									<c:forEach items="${suimSuit12FileList}" var="suit12FileVo">
										<tr id = "suit12ImgTr_${suit12FileVo.serialNo}">
											<td align="center" class="suit12Preview"> 
												${suit12FileVo.fileName}
											</td>
											<td align="center">
	 											<img src='./resources/ls_img/btn_del.gif' id = 'suit12ImgDelBtn_${suit12FileVo.serialNo}' 
	 												onclick="suit12ImgSubDel('${suit12FileVo.serialNo}','${suit12FileVo.suimRptNo}','${suit12FileVo.fileName}');" style='cursor:pointer;'/>
											</td>
										</tr>
									</c:forEach>												
								</tbody>
							</table>
						</div>
						
						
						<!-- 맞지않는 파일 다운로드 모듈 NotUsed 170117.LDS 
						<div class= "tableStyle4">
							<table align="center" style="margin-top:10px;">
								<colgroup>
									<col width="60%">
									<col width="40%">
								</colgroup>
								<thead>
									<tr>
										<td colspan="4" align="center">
											<b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;" /> 실사 사진</b>
										</td>
									</tr>
									<tr>
										<th>파일명</th>
										<th>등록일</th>
									</tr>
								</thead>
								<tbody align="center" id = "rptOrgFileList">
									<input type="hidden" id="fileListSize" value="${fileListSize}"/>
									<c:forEach items="${suimSuit12FileList}" var="orgFileVo">
										<tr id = "rptFileOrgTr_${orgFileVo.serialNo}">
											<td>
												<c:choose>
													<c:when test="${getSuimSuit12DtlBsc.editYN2 > 0}">
														<a href="suimSuit12RptFileDownload?key=${orgFileVo.serialNo}&type=rptOrigin&suimRptNo=${getSuimSuit12DtlBsc.suimRptNo}">
								        				   <font color="blue"> ${orgFileVo.fileName} </font>
								  					    </a>
													</c:when>
													<c:otherwise>
														${orgFileVo.fileName}
													</c:otherwise>
												</c:choose>
											</td>
											<td>
												${orgFileVo.regDate}
												<c:if test="${getSuimSuit12DtlBsc.suimRptState eq '0' and getSuimSuit12DtlBsc.editYN2 > 0}">
													<img src='./resources/ls_img/btn_del_s.gif' onclick="SuimSuit12RptFileDel('${orgFileVo.serialNo}');" style='cursor:pointer; margin-left:5px;'/>
												</c:if>
											</td>
										</tr>
									</c:forEach>
								</tbody>
								<tr>
									<td colspan="2" align="center">
									<c:choose>
										<c:when test="${getSuimSuit12DtlBsc.suimRptState eq '0' and getSuimSuit12DtlBsc.editYN2 >0}">
										</c:when>
										<c:otherwise>
											<font color="red">
												※ 담당건이 아니거나 상신 이후에는 원본 파일 업로드를 할 수 없습니다.
											</font>
										</c:otherwise>
									</c:choose>
									</td>
								</tr>
									
							</table>
						</div>
						-->
						<br>
						<p align="center">
							<img id="edite" src="./resources/ls_img/btn_ok.gif" alt="저장" style ="cursor:pointer" />
							<img id="cancel" src="./resources/ls_img/btn_cancel.gif" alt="취소" style ="cursor:pointer" />
						</p>
						</div><!-- //guestcnt5 -->

					</div><!-- //guest -->
				</div><!-- //bot1-3 -->
			</div><!-- //center_cnt -->
		</div><!-- //contetnsPop -->
	</div>
	<!--//center -->

	<!-- footer -->
	<c:import url="../top_main/top_pop_footer.jsp"></c:import>
	<!-- //footer -->

</body>

</html>
