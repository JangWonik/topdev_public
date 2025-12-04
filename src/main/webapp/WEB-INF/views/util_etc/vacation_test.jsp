<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
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
	
    <style type="text/css">
        .tableStyle2 tr:hover { background-color:#ffecec; } /* hovering */
        th.right {
            text-align: right;
            padding-right: 3px;
        }
        th.left {
            text-align: left;
            padding-left: 1em;
        }
        td.right {
            text-align: right;
            padding-right: 3px;
        }
        td.left {
            text-align: left;
            padding-left: 1em;
        }
        
    </style>

</head>
<script type='text/javascript'>
	$(document).ready( function(){
		//날짜 조회
		$("#doSearch").click( function(){
			$("#sExceldown").val('0');
			$("#searchForm").submit();
		});
		
		doSearchSet();
	});
	
	//기본 날짜 셋팅
	function doSearchSet(){
		$("#sExceldown").val('0');
		var sYear = ${selectYear};
		var sMonth = ${selectMonth};
		var sDay = ${selectDay};
		
		$("#selectYear").val(sYear);				
		$("#selectMonth").val(sMonth);		
		$("#selectDay").val(sDay);
	}
	
	function doDownload(){
		$("#sExceldown").val('1');
		$("#searchForm").submit();
	}
	
	
	function doScheduler(){			
		if( confirm("오늘날짜 기준 연차계산 스케줄러를 실행시키시겠습니까?") ){
			
			//스케줄러 실행			
			var param = {};
			param.authkey = ${mbrVo_Session.user_state};
			
			$.ajax({
				type : "post",
				url : "/VacationScheduleAction",					
				data : param,
				success : function(result){			
					if( result == "success" ){
						alert("연차계산 스케줄러가 정상작동하였습니다.")
					}else{
						alert("작동실패 : "+result);	
					}									
					
				},
				error: function (request, status, error) {			
					console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
				}
			});
			
		}
	}	
</script>

<body>
    <div id="wrapper">        
        <div id="container">
            <div class="contetns2">
                <div class="center_cnt2">
                    <%--검색 영역--%>
                    <div class="centercnt_top">
                        <div class="nociteA log_top">
                            <div class="search_bar">
                            	* 1종 연차 휴가 계산 테스트 페이지 
                            </div>
                        </div>
                    </div>
                    <%--본문 영역--%>
                    <div class="centercnt_bot2">
                        <div class="guest">
                            <div class="guestTap">                                
                            	<!-- 내용 테이블 시작 -->
								<div class="tableStyle2" style="width:1560px;overflow:auto;">
								<form id="searchForm" name="searchForm" method="post" action="./VacationTest">
									<input type="hidden" id="sExceldown" name="sExceldown" value="0"/>
									<table>
										<tr>
											<td style="text-align:left;padding-left:15px;" colspan="10" bgcolor="#FFFFFF">
												연차 유급 휴가 사용내역 (기준일자 : 2019. 11. 01)을 아래와 같이 안내합니다.
											</td>
											<td>
												<img alt="Exceldownload" src="/resources/ls_img/ls_invoice/btn_excel.gif" onclick="javascript:doDownload();" style="cursor:pointer;">												
											</td>
											<td>
												<input type="button" id="vacationSchedule" value="연차계산스케줄러실행" onclick="javascript:doScheduler();"/>
											</td>											
										</tr>
										
										<tr>
											<th rowspan="2">이름</th>
											<th rowspan="2">입사일자</th>
											<th colspan="4">2018년 (2018년 입사일 ~ 2019년 입사전일)</th>
											<th colspan="6">2019년 (2019년 입사일 ~ 2020년 입사전일)</th>
										</tr>
										
										<tr>																				
											<th>2018년<br/>발생연차</th>
											<th>2018년<br/>대체사용연차</th>
											<th>휴가신청<br/>사용연차</th>
											<th>2018년<br/>잔여연차</th>
											
											<th>2018년<br/>이월연차</th>
											<th>2019년<br/>연차</th>
											<th>사용가능<br/>연차 유급휴가</th>
											<th>공휴일 대체<br/>사용연차</th>
											<th>휴가신청<br/>사용연차</th>
											<th>2019년<br/>잔여연차</th>											
											<!-- <th><font color="blue">근무년수 발생<br/>연&middot;월차</font></th>
											<th><font color="red">공휴일 차감<br/>연차</font></th>									
											<th><font color="green">실사용 연차</font></th>
											<th><font color="purple">사용가능 연차</font></th> -->																				
										</tr>
									</table>
								</form>
								</div>
								<div class="tableStyle2" style="width:1560px;height:700px;overflow:auto;">								
									<table>															
										<c:forEach items="${userInfoList}" var="item" varStatus="status">																				
											<tr>
												<td>${item.user_name}</td>
												<td>${item.join_date}</td>										
												<td>${item.n2018Yearset}</td>
												<td>${item.n2018Holiday}</td>
												<td>${item.n2018_vacation_work_use}</td>
												<td>${item.n2018Extraset}</td>
												<td>${item.n2018Overset}</td>
												<td>${item.nYearset}</td>
												<td>${item.nTotalYearset}</td>
												<td>${item.nHoliday}</td>
												<td>${item.n2019_vacation_work_use}</td>
												<td>${item.n2019Extraset}</td>
												<%-- <td>${item.user_name}</td>
												<td>${item.join_date}</td>
												<td><font color="blue">${item.nYearset}</font></td>										
												<td><font color="red">${item.nHoliday}</font></td>
												<td><font color="green">${item.n2019_vacation_work_use}</font></td>
												<td>${item.org_year_cal}</td> --%>															
											</tr>									
										</c:forEach>								
									</table>
								</div>
							</div>
						</div>
					</div>
                    
                    <%--기존백업 
                    <div class="centercnt_bot2">
                        <div class="guest">
                            <div class="guestTap">                                
                            	<!-- 내용 테이블 시작 -->
								<div class="tableStyle2" style="width:1560px;overflow:auto;">
								<form id="searchForm" name="searchForm" method="post" action="./VacationTest">
									<input type="hidden" id="sExceldown" name="sExceldown" value="0"/>
									<table>
										<tr>
											<td style="text-align:left;padding-left:15px;" colspan="5" bgcolor="#FFFFFF">
											<!-- <input type="hidden" id="selectYear" name="selectYear" value="2020">		 -->																		
												대상일 : 
												<select id="selectYear" name="selectYear">
													<option value="2019">2019</option>
													<option value="2020">2020</option>
												</select>     
												년 
												<select id="selectMonth" name="selectMonth">
													<c:forEach var="i" begin="1" end="12">
														<option value="${i}">${i}</option>														
													</c:forEach>
												</select>
												월 
												<select id="selectDay" name="selectDay">
													<c:forEach var="k" begin="1" end="31">
														<option value="${k}">${k}</option>
													</c:forEach>
												</select>
												일 
												&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" id="doSearch" name="doSearch" value="조회" style="width:100px;">
											</td>
											<td>
												<img alt="Exceldownload" src="/resources/ls_img/ls_invoice/btn_excel.gif" onclick="javascript:doDownload();" style="cursor:pointer;">
											</td>								
										</tr>
										<tr>									
											<th>이름</th>
											<th>입사일자</th>
											<th><font color="blue">근무년수 발생<br/>연&middot;월차</font></th>
											<th><font color="red">공휴일 차감<br/>연차</font></th>									
											<th><font color="green">실사용 연차</font></th>
											<th><font color="purple">사용가능 연차</font></th>																				
										</tr>
									</table>
								</form>
								</div>
								<div class="tableStyle2" style="width:1560px;height:700px;overflow:auto;">								
									<table>															
										<c:forEach items="${userInfoList}" var="item" varStatus="status">																				
											<tr>										
												<td>${item.user_name}</td>
												<td>${item.join_date}</td>
												<td><font color="blue">${item.nYearset}</font></td>										
												<td><font color="red">${item.nHoliday}</font></td>
												<td><font color="green">${item.n2019_vacation_work_use}</font></td>
												<td>${item.org_year_cal}</td>															
											</tr>									
										</c:forEach>								
									</table>
								</div>
							</div>
						</div>
					</div>
					--%>					
				</div>
			</div>
		</div>
	</div>
</body>
</html>