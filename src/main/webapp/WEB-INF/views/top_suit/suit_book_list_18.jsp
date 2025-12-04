<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
	<script>
		$(document).ready(function(){
			$.ajaxSetup({cache:false});
			
			if('${authFlag}' == 'logout'){
				alert("로그아웃 상태입니다. 재로그인 하십시오.");
				//window.close();
				window.location.assign("./logout");
			}
			
			$("#endDateForSuit18SrcS").datepicker({ 
		    	   showOn: 'button',
		    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		    	   buttonImageOnly: true,
		    	   buttonText: "달력", 
		    	   changeMonth: true,
		    	   changeYear: true,
		    	   showButtonPanel: false
		    });
			
			$("#endDateForSuit18SrcE").datepicker({ 
		    	   showOn: 'button',
		    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		    	   buttonImageOnly: true,
		    	   buttonText: "달력", 
		    	   changeMonth: true,
		    	   changeYear: true,
		    	   showButtonPanel: false
		    });
			
			$("#Suit18ListSrced").click(function(){
				$("#Suit18ListSrcFormId").submit();
			});
			
			/* 응답전문 */
			$("#Suit18ListRs").click(function(){
				$.get("./suit18RsList",
						{
							sDay : $("#endDateForSuit18SrcS").val(),
							eDay : $("#endDateForSuit18SrcE").val()
							
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("전문 전송 완료.");
								}
							}
						}
				
				);
			}); // suit18ListRs
			
			
			/* 문자로그 */
			$("#Suit18ListSmsExc").click(function(){
				
				var cw=screen.availWidth;
				var ch=screen.availHeight;
				var sw=1010; //띄울 창의 넓이
				var sh=740;  //띄울 창의 높이
				var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
				var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
				window.open('Suit18ListSmsExc?sDay='+$("#endDateForSuit18SrcS").val()+'&eDay='+$("#endDateForSuit18SrcE").val(),'rptEditePop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			}); //
		});
		
		
	</script>
	<script>
		function popSuit18Dtl(suim_rpt_no){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1010; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('popSuit18Dtl?suim_rpt_no='+suim_rpt_no,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}
	</script>
	
	<style>
		.tableStyle2 td{
			letter-spacing: 0px !important;
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

			<!-- centercnt_top -->
			<div class="center_cnt_1300">
				
				<!-- centercnt_bot -->
				<div class="center_cnt_1300_bot">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">적부 - 삼성 (총 ${rowNum} 건)</a></li>
							</ul>
							<p align="right" style="margin-top:5px;">
								<form action="suit18ListSrced" id="Suit18ListSrcFormId" method="get">
									종결일 : <input type="text" id="endDateForSuit18SrcS" size="10" name = "sDay" value="${sDay}"/>
									~ <input type="text" id="endDateForSuit18SrcE" size="10"  name = "eDay" value="${eDay}"/>
									<img src="./resources/ls_img/report/btn_src.gif" id="Suit18ListSrced" style="cursor:pointer;"/>
									<c:if test="${mbrAuthVo.mbr_pms_20 == 1}">
										<img src="./resources/ls_img/report/icon_contract_rs.gif" id="Suit18ListRs" style="cursor:pointer;"/>
										<img src="./resources/ls_img/btn_excel_sms.gif" id="Suit18ListSmsExc" style="cursor:pointer;"/>
									</c:if>
								</form>
							</p>
						</div>
						<div class="guestcnt4" style="display:block;">
							<div class= "tableStyle2" style="margin-bottom:12px;">
								<table>
									<thead >
										<tr > <!-- #E7ECF1 -->
											<th  rowspan="2" width="2%" >no.</th>
											<th  rowspan="2" width="2%">Lock</th>
											<th  rowspan="2" width="5%">접수번호</th>
											<th  rowspan="2" width="5%">종결번호</th>
											<th  rowspan="2" width="4%">보험사</th>
											<th  rowspan="2" width="5%">처리팀</th>
											<th  rowspan="2" width="4%">담당자</th>
											<th  rowspan="2" width="2%">건물구분</th>
											<th  rowspan="2" width="5%">계약자</th>
											<th  colspan="2" width="4%">SMS</th>
											<th  rowspan="2" width="4%">수임</th>
											<th  rowspan="2" width="4%">종결</th>
										</tr>
										<tr>
											<th>모집인</th>
											<th>계약자</th>
										</tr>
									</thead>
									<tbody>
										
										<c:forEach items="${suitList18}" var="suitVO" > 
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" style ="cursor:pointer;" onclick="popSuit18Dtl('${suitVO.suimRptNo}');">
											<!-- no -->
											<td>${suitVO.ROWNUM}</td>
											<!-- lock -->
											<td>
												<c:if test="${suitVO.lockFlag eq 1}">
													<img src="./resources/ne_img/icon_lock.png" width="20px" height="20px" alt="보고서 잠금" />
												</c:if>
												<c:if test="${suitVO.lockFlag eq 0}">
													<img src="./resources/ne_img/icon_unlock.png" width="20px" height="20px" alt="보고서 열람가능" />
												</c:if>
											</td>
											<!-- suim_accept_no -->
											<td title="${suitVO.suimAcceptNo}">
												${suitVO.suimAcceptNo}
											</td>
											<!-- suim_close_no -->
											<td title="${suitVO.suimCloseNo}" >
												<c:choose>
													<c:when test="${suitVO.suimCloseNo != ''}">${suitVO.suimCloseNo}</c:when>
													
													<c:otherwise>
														<c:choose>
															<c:when test="${suitVO.suimRptState  eq 3}">반송</c:when>
															<c:when test="${suitVO.suimRptState  eq 4}">소송</c:when>
															<c:otherwise>
																<font color="red">미결</font>
															</c:otherwise>
														</c:choose>
													</c:otherwise>
												</c:choose>
											</td>
											<!-- 보험사 -->
											<td title="${suitVO.ptnrName}" >${suitVO.ptnrNick}</td>
											<!-- 처리팀 -->
											<td title="${suitVO.teamName}" >
												<c:if test="${not empty suitVO.teamMark}">
													<span class="mark_alarm">${suitVO.teamMark}</span>
												</c:if>
											</td>
											<!-- 담당자 -->
											<td title="${suitVO.userName}" >
												<c:choose>
													<c:when test="${suitVO.userNo > 0}">
														<c:choose>
															<c:when test="${fn:length(suitVO.userName) > 3}">
																${fn:substring(suitVO.userName,0,3)}...
															</c:when>
															<c:otherwise>${suitVO.userName}</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise><font color="red">미배당</font></c:otherwise>
												</c:choose>
											</td>
											<!-- 건물 -->
											<td title="${suitVO.bdType}" >
												<c:choose>
													<c:when test="${suitVO.bdType eq '1'}">일반</c:when>
													<c:otherwise>
														공장
													</c:otherwise>
												</c:choose>
											</td>
											<!-- 계약자 -->
											<td title="${suitVO.policyholderNm}">
												<c:choose>
													<c:when test="${suitVO.policyholderNm != ''}">
														<c:choose>
															<c:when test="${fn:length(suitVO.policyholderNm) > 8}">
																${fn:substring(suitVO.policyholderNm,0,8)}...
															</c:when>
															<c:otherwise>${suitVO.policyholderNm}</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>-</c:otherwise>
												</c:choose>
											</td>
											<td>
												<c:choose>
													<c:when test="${suitVO.suimRptState >1 }">
														-
													</c:when>
													<c:otherwise>
														<c:choose>
															<c:when test="${suitVO.conCnt1 > 0}">
																발송
															</c:when>
															<c:otherwise>
																<c:choose>
																	<c:when test="${suitVO.clerkHndPhoneNo ne '' 
															and (
																(fn:substring(suitVO.clerkHndPhoneNo,0,3) eq '010') or 
																(fn:substring(suitVO.clerkHndPhoneNo,0,3) eq '011') or 
																(fn:substring(suitVO.clerkHndPhoneNo,0,3) eq '016') or
																(fn:substring(suitVO.clerkHndPhoneNo,0,3) eq '017') or
																(fn:substring(suitVO.clerkHndPhoneNo,0,3) eq '018') or
																(fn:substring(suitVO.clerkHndPhoneNo,0,3) eq '019')
															)
															}">
																		<font color='#CC3300'>미발송</font>
																	</c:when>
																	<c:otherwise>
																		<font color='#cccccc'>해당無</font>
																	</c:otherwise>
																</c:choose>
															</c:otherwise>
														</c:choose>
													</c:otherwise>
												</c:choose>
											</td>
											<td>
												<c:choose>
													<c:when test="${suitVO.suimRptState >1 }">
														-
													</c:when>
													<c:otherwise>
														<c:choose>
															<c:when test="${suitVO.conCnt2 > 0}">
																발송
															</c:when>
															<c:otherwise>
																<c:choose>
																	<c:when test="${suitVO.conHndPhoneNo ne '' 
															and (
																(fn:substring(suitVO.conHndPhoneNo,0,3) eq '010') or 
																(fn:substring(suitVO.conHndPhoneNo,0,3) eq '011') or 
																(fn:substring(suitVO.conHndPhoneNo,0,3) eq '016') or
																(fn:substring(suitVO.conHndPhoneNo,0,3) eq '017') or
																(fn:substring(suitVO.conHndPhoneNo,0,3) eq '018') or
																(fn:substring(suitVO.conHndPhoneNo,0,3) eq '019')
															)
															}">
																		<font color='#CC3300'>미발송</font>
																	</c:when>
																	<c:otherwise>
																		<font color='#cccccc'>해당無</font>
																	</c:otherwise>
																</c:choose>
															</c:otherwise>
														</c:choose>
													</c:otherwise>
												</c:choose>
											</td>
											
											<td>
												${suitVO.regDate}
											</td>
											<td>
												<p <c:if test="${suitVO.suimRptState  eq 3}">title="${suitVO.suimCancelDateFmt}"</c:if> >
													<c:choose>
														<c:when test="${suitVO.delDate != 0}"><font color="red"><b>삭제</b></font></c:when>
														<c:otherwise>
															<c:choose>
																<c:when test="${suitVO.suimRptState  eq 1}"><font color="#0066ff">결재</font></c:when>
																<c:when test="${suitVO.suimRptState  eq 11}"><font color="#CC3300">반려</font></c:when>
																<c:when test="${suitVO.suimRptState  eq 2}">${suitVO.closeDate}</c:when>
																<c:when test="${suitVO.suimRptState  eq 3}">반송</c:when>
																<c:when test="${suitVO.suimRptState  eq 4}">소송</c:when>
																<c:when test="${suitVO.pastDateOld > 15}"><font color="fuchsia">${suitVO.pastDateOld}일</font></c:when>
																<c:otherwise>${suitVO.pastDateOld}일</c:otherwise>
															</c:choose>
														</c:otherwise>
													</c:choose>
												</p>
											</td>
										</tr>
										</c:forEach>
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
							
							<c:import url="../util_page/page_bsc_suit.jsp" charEncoding="UTF-8"></c:import>

						</div><!-- //guestcnt4 -->

					</div>
				</div>
				<!-- //centercnt_bot -->

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
