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
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>	
	<script src="./resources/wm_js/common.js"></script>
	
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
</head>
<style>
	.tableStyle2 td {letter-spacing: 0;}

	.btn-search-aprv {
	    font-weight: bold;
	    text-decoration: none;
	    font-family: Arial;
	    text-indent: 0px;
	    line-height: 0px;
	    -moz-border-radius: 5px;
	    -webkit-border-radius: 5px;
	    border-radius: 5px;
	    text-align: center;
	    vertical-align: middle;
	    display: inline-block;
	    font-size: 12px;
	    color: #696969 !important;
	    width: 60px;
	    height: 0px;
	    padding: 10px;
	    border-color: #e1e1e1;
	    border-width: 1px;
	    border-style: solid;
	    background: #CEE3F6;
	}	
</style>
<script type="text/javascript">
	$(document).ready(function(){
		
	});//$(document).ready
	
	function fnSearch(){		
		
		var regSdateVal = $("#regSdate").val();
		var regEdateVal = $("#regEdate").val();
		var suimRptNoVal = $("#srchSuimRptNo").val();
		
		//검색일자는 필수값으로 넣어야함
		if( regSdateVal == '' ){
			alert("검색 시작일자를 넣어주세요.");
			$("#regSdate").focus();
			return;
		}
		
		if( regEdateVal == '' ){
			alert("검색 종료일자를 넣어주세요.");
			$("#regEdate").focus();
			return;
		}
		
		var param = {};		
		 
		param.regSdate = regSdateVal;
		param.regEdate = regEdateVal;
		param.srchSuimRptNo = suimRptNoVal;
		
		var url = "./topReportLogListAjax";				

        $.ajax({
            type: "POST",
            url: url,
            data: param,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",            
            dataType: "html",
            timeout: 20000,
            success: function(data){            	
     			$("#reportLogList").html(data);                
            },
            error: function(e){
                alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
            }
        });
		
	}
	
	function doDownload(){
		$("#excelDown").val(1);
		$("#searchFrm").attr("action","topReportLogListAjax");
		$("#searchFrm").submit();
	}

</script>

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
				<div class="center_cnt_1300_bot">
					<div class="guest">
						
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">보고서 활동 로그조회</a></li>
							</ul>
						</div>
						<!-- 검색창 시작 -->
						<div class= "tableStyle2">
							<form id="searchFrm" method="post">
								<input type="hidden" id="excelDown" name="excelDown">
								<div style="float: right;padding:5px 0 5px 0;">
									<div style="text-align: right;">
										<img alt="Exceldownload" src="/resources/ls_img/ls_invoice/btn_excel.gif" onclick="javascript:doDownload();" style="cursor:pointer;">&nbsp;
									</div>
								</div>												
								<div id="search-box"  align="center">													
									<table style="width: 100%;">
										<tr>
											<th width="150px;">로그 기준일</th>
											<td width="250px;">
												<input type="text" class="classCalendar" id="regSdate" name="regSdate" style="width:70px;" value="${srchParam.regSdate}"/> ~
												<input type="text" class="classCalendar" id="regEdate" name="regEdate" style="width:70px;" value="${srchParam.regEdate}"/>
											</td>											
											<th width="150px;">보고서 접수번호</th>
											<td width="160px;"><input type="text" id="srchSuimRptNo" name="srchSuimRptNo" maxlength="30" style="width:140px;" value="${srchParam.SuimRptNo}"></td>						
											<td width="100px;">
												<a href="#noloc" class="btn-search-aprv" id="btn-search" onclick='javascript:fnSearch();'>검 색</a>							
											</td>
											<td></td>
										</tr>										
									</table>									
								</div> 
							</form>
						</div>
						<!-- 검색창 끝 -->
						<!-- 검색 결과 목록 시작 -->
						<div style="padding-top:10px;">
							<div class= "tableStyle2">
								<table>
									<tr>
										<th width="10%">순번</th>
										<th width="20%">접수번호</th>
										<th width="20%">이름</th>
										<th width="15%">로그 아이피</th>
										<th width="20%">활동내용</th>
										<th width="15%">접근일자</th>
									</tr>
								</table>							
								<div id="reportLogList"></div>
							</div>
						</div>
						<!-- 검색 결과 목록 끝 -->						
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
