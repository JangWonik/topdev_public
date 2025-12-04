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
			
			$("#addUserListSel").select2();
			searchUserList();
			
		});
		
		function enterKey(){			
			if(event.keyCode == 13){				
				doAcceptNoSearch();
			}
		}
	
		function searchUserList(){
			
			var formData = $("#searchFrm").serialize();
			
			$.ajax({
				type : "post",				
				url : "topSuitWordAuthListAjax",
				data : formData,
				success : function(result){					
					$("#authUserList").html(result);				
				},
				error: function (request, status, error) {			
					console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
				}
			});
		}
		
		//권한 대상자 등록
		function doAddUserInfo(){
			
			var selUserNoVal = $("#addUserListSel").val();
			
			if( "0" ==  selUserNoVal ){
				alert("신규 권한 대상자를 선택해주세요.");
				$("#addUserListSel").focus();
				return;
			}
			
			var param = {};
			
			param.action_flag = "I";
			param.user_no = selUserNoVal;
			
			var url = "/suitWorkAuthAction";
			
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
						alert("대상자 등록에 성공 했습니다. ");
						searchUserList();
       	        	}else if(data == 9){
       	        		alert("기존 등록된 대상자가 있습니다.");
       	        		searchUserList();
       	        	}else{
       	        		alert("대상자 등록에 실패하였습니다.");
       	        	}
       	        	
       	        }
       	    });			
		}
		
		//대상자 삭제
		function doDelUserInfo( p_user_no, p_user_name ){
			
			var selUserNoVal = p_user_no;
			var userNameVal = p_user_name;
			
			if(!confirm( p_user_name + "을 삭제하시겠습니까?" )){				
				return;
			}
			
			var param = {};
			
			param.action_flag = "D";
			param.user_no = selUserNoVal;
			
			var url = "/suitWorkAuthAction";
			
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
						alert("대상자를 삭제하였습니다. ");
						searchUserList();
       	        	}else{
       	        		alert("대상자 삭제에 실패하였습니다.");
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
								<li class="on" id="mainTab"><a href="#">적부 워드전환 권한 대상자</a></li>																								
							</ul>
						</div>
						
						<div class="guestcnt8" id="ptnrMember" style="display:block;margin-top:0px;" >							
								<!-- search-box -->
								<form id="searchFrm" name="searchFrm" method="POST" onsubmit="return false;">									
								</form>								
								<div class= "tableStyle2" style="border-top: 0px;">
									<table style="width: 100%;">											
										<tr>					
											<td width="50%"> </td>							
											<th width="15%">신규 권한 대상자 등록</th>
											<td width="25%">
												<select id="addUserListSel" name="addUserListSel" style="width:90%;text-align:left;">
													<option value="0">- 선택 -</option>
													<c:forEach items="${userList}" var="member" varStatus="status">
														<option value="${member.userNo}">${member.teamName} / ${member.userName}</option>
													</c:forEach>
												</select>												
											</td>
											<td width="10%">								
												<a href="#noloc" class="btn-vacation-aprv" id="approval-all-btn-search" style="background:#CEE3F6;" onclick="javascript:doAddUserInfo();">등 록</a>
											</td>												
										</tr>
									</table>
								</div>																
								<div class= "tableStyle2" style="border-top: 0px;">															
									<table>
											<tr>											
												<th width="10%">No.</th>
												<th width="20%">팀명</th>
												<th width="25%">이름</th>
												<th width="15%">재직상태</th>
												<th width="20%">등록일</th>											
												<th width="10%">-</th>											
											</tr>
									</table>								
								<div id="authUserList"></div>
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