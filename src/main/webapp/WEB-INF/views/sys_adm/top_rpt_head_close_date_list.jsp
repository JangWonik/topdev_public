<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/vertical.css" />
	
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	<script src="./resources/jquery/jquery.mask.min.js"></script>
	
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>
	
	<script src="./resources/tooltipsy/tooltipsy.min.js"></script>	
	
	<style>
		.tableStyle2 td{
			letter-spacing : 0px;
		}
	
		.td-overflow-none{
			text-overflow : ellipsis;
			overflow : hidden;
			white-space : nowrap;
			word-wrap:normal;
		}
		
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
		
		.buttonAssistanceDocu{
			width:70px;
			height:23px;
		    background-color:#9900CC;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		}

		.btn-vacation-aprv:active {
			position:relative;
			top:4px
		}
		
		/* 모달 버튼 */
		.ui-button-text-only {
			height:2.1em !important;
		}
	</style>
	<script>
		$(document).ready( function(){	
			$("#srchSuimAcceptNo").focus();
			//날짜입력 패턴 추가 시작
			var options = {
				onKeyPress : function(cep, event, currentField, options){
				
			    var tid = event.currentTarget.id;
			    var tidx = tid.substr(tid.length - 1, 1);
			    
				},
				reverse : true
		    };		    
		    
		    $('input.hasDatepicker').mask('0000-00-00',options);		    
		  	//날짜입력 패턴 추가 끝
		});
		
		function enterKey(){			
			if(event.keyCode == 13){				
				doAcceptNoSearch();
			}
		}
	
		function doAcceptNoSearch(){
			
			var formData = $("#searchFrm").serialize();
			$.ajax({
				type : "post",
				url : "sysRptCloseDateUpdateAjax",
				data : formData,
				success : function(result){					
					$("#closeReportList").html(result);				
				},
				error: function (request, status, error) {			
					console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
				}
			});
		}
		
		function doCloseDateEdit( p_suim_rpt_no){		
			$("#rptListView_"+p_suim_rpt_no).hide();
			$("#rptListEdit_"+p_suim_rpt_no).show();			
			_initCalendar();
		}
		
		function doCloseDateCancel( p_suim_rpt_no){		
			$("#rptListEdit_"+p_suim_rpt_no).hide();
			$("#rptListView_"+p_suim_rpt_no).show();
		}
		
		function doCloseDateSave( p_suim_rpt_no){
			
			var close_date_val = $("#close_date_edit_"+p_suim_rpt_no).val(); 
			
			if( close_date_val == '' ){
				alert("종결일을 입력해주세요.");
				$("#close_date_edit_"+p_suim_rpt_no).focus();
				return;
			}
			
			if( close_date_val.length != 10 ){
				alert("날짜 형식에 맞추어 입력해주세요.\n예 : (2021-01-01)");
				$("#close_date_edit_"+p_suim_rpt_no).focus();
				return;
			}			
			
			var param = {};
			param.suim_rpt_no = p_suim_rpt_no;
			param.close_date = close_date_val;			
			
			var url = "/update_rpt_close_date";
			
       	    $.ajax({
       	        type: "POST",
       	        url: url,
       	        data: param,
       	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
       	        timeout: 20000,
       	        async: false,
       	        dataType: "html", 
       	        success: function(data){
       	        	if (data == 1){
						alert("종결일 변경 성공 했습니다. ");
						doAcceptNoSearch();
       	        	}else{
       	        		alert("종결일 변경에 실패하였습니다.");
       	        	}       	        	
       	        }
       	    });
		}
		
		function _initCalendar(){    	 
	  		$('.calendar').datepicker({
	  			showOn: 'button',
	  			buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
	  			buttonImageOnly: true,
	  			buttonText: "달력", 
	  			changeMonth: true,
	  			changeYear: true,	    	   
	  			showButtonPanel: false,
	  			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	  			dayNamesMin: ['일','월','화','수','목','금','토'],
	  			dateFormat: 'yy-mm-dd',
	  			firstDay: 0,
	  			isRTL: false,
	  			showMonthAfterYear: true
	  	    });  		
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
								<li class="on" id="mainTab"><a href="#">보고서 종결일 수정</a></li>
								<!-- <li id="subTab"><a href="#">관련업체 회사정보</a></li> -->																
							</ul>
						</div>
						
						<div class="guestcnt8" id="ptnrMember" style="display:block;margin-top:0px;" >
							<div class= "tableStyle2" style="border-top: 0px;">
								<!-- search-box -->
								<form id="searchFrm" name="searchFrm" method="POST" onsubmit="return false;">																		
									<div id="search-box"  align="center" style="padding-bottom:5px;">
										<table style="width: 100%;">											
											<tr>												
												<th width="20%">보고서 접수번호</th>
												<td width="70%">
													<input type="text" name="srchSuimAcceptNo" id="srchSuimAcceptNo" value="${paramMap.srchSuimAcceptNo}"  style="width:90%;" onkeypress="JavaScript:enterKey();"/>												
												</td>
												<td width="10%">								
													<a href="#noloc" class="btn-vacation-aprv" id="approval-all-btn-search" onclick="javascript:doAcceptNoSearch();">검 색</a>
												</td>												
											</tr>
										</table>					
									</div> 
								</form>															
								<table>
										<tr>											
											<th width="10%">No.</th>
											<th width="25%">접수번호</th>
											<th width="25%">보험사</th>
											<th width="25%">현재 종결일</th>											
											<th width="15%">-</th>											
										</tr>
								</table>
								<div id="closeReportList"></div>
							</div>
						</div>				
					</div>
				</div>
				<!-- //centercnt_bot -->
			<!-- //center_cnt -->
			</div>
		</div>
	</div>
</div>
<!-- //wrapper -->
</body>
</html>