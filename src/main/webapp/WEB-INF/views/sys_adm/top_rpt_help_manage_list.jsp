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
				url : "sysRptHelpManageAjax",
				data : formData,
				success : function(result){					
					$("#closeReportList").html(result);				
				},
				error: function (request, status, error) {			
					console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
				}
			});
		}
		
		function doHelpEdit( p_serial_no, p_client_id ){		
			$("#rptListView_"+p_serial_no).hide();
			$("#rptListEdit_"+p_serial_no).show();
			$("#editHelpListSel_"+p_serial_no).select2();
			$("#editHelpListSel_"+p_serial_no).val(p_client_id).trigger('change');
		}
		
		function doHelpCancel( p_serial_no ){
			$("#rptListEdit_"+p_serial_no).hide();
			$("#rptListView_"+p_serial_no).show();			
		}
		
		function doHelpSave( p_serial_no ){
			
			var editHelpUserNo = $("#editHelpListSel_"+p_serial_no).val();						
			
			if( editHelpUserNo == '0' ){
				alert("수정 할 의뢰인을 선택 해 주세요.");
				$("#editHelpListSel_"+p_serial_no).focus();
				return;
			}
			
			var param = {};
			param.serial_no = p_serial_no;
			param.edit_user_no = editHelpUserNo;
			param.action_flag = "U";

			var url = "/rptHelpUserAction";				//의뢰인 정보 갱신
			
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
						alert("의뢰인 정보를 수정 하였습니다.");
						doAcceptNoSearch();
       	        	}else{
       	        		alert("의뢰인 정보 수정에 실패하였습니다.");
       	        	}       	        	
       	        }
       	    });
		}
		
		function doHelpDel( p_serial_no, p_accept_no, p_accept_name ){
			
			var msg = "접수번호 : "+p_accept_no+"의 (협조인 : "+p_accept_name+") 협조건을 삭제하시겠습니까?";
			
			if( !confirm(msg) ){
				alert("삭제가 취소 되었습니다.");
				return;
			}
			
			var param = {};
			param.serial_no = p_serial_no;			
			param.action_flag = "D";

			var url = "/rptHelpUserAction";				//의뢰인 정보 갱신
			
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
						alert("협조건을 삭제 하였습니다.");
						doAcceptNoSearch();
       	        	}else{
       	        		alert("협조건 삭제를 실패하였습니다.");
       	        	}       	        	
       	        }
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
								<li class="on" id="mainTab"><a href="#">보고서 협조건 의뢰인 수정</a></li>																								
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
											<th width="10%">접수번호</th>
											<th width="10%">협조인 이름</th>
											<th width="10%">수임팀 이름</th>
											<th width="25%">협조 메모</th>
											<th width="10%">의뢰인 부서명</th>
											<th width="10%">의뢰인 이름</th>																						
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