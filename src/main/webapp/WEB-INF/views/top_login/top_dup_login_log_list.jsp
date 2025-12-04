<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<title>${title_Session}</title>	
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<script>
		$(document).ready(function(){
			if('${mbrVo_Session.user_no}' == null || '${mbrVo_Session.user_state}' != 9){
				window.location.assign("./logout");
			}
			
			$("#boardSrcBtn").click(function(){								
				getDupList();
			});
			
			$("#srchUserName").focus();
		});//ready
		
		//로그아웃 처리하기
		function doDupUpdate( p_user_no , p_action){
			
			var param = {};
			param.user_no = p_user_no;
			param.p_action = p_action;
			
			if( p_action == 'D' ){				
				if( !confirm("로그인 정보를 삭제하시겠습니까? \n삭제 후 복구는 불가능합니다.") ){
					return;
				}				
			}else if( p_action == 'ALL' ){
				if( !confirm("전체계정의 중복 로그인 상태를 로그아웃하시겠습니까?") ){
					return;
				}
			}
			
			var url = "./dupManagerAction";

		    $.ajax({
				type: "POST",
				url: url,
				data: param,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				dataType: "html",			
				timeout: 20000,
				success: function(data){
					if( p_action == 'ALL' ){
						alert("전체 계정의 중복 로그인 상태를 로그아웃 처리하였습니다.");
					}else 	if( data ){		//1인 경우 성공 
						alert("중복 로그인 정보를 수정(삭제)하였습니다.");						
					}
					getDupList();
				}                
		    });
			
		}
		
		//목록 불러오기
		function getDupList(){
			
			var formData = $("#boardSrcForm").serialize();
			
			$.ajax({
				type : "post",
				url : "dupListAjax",
				data : formData,
				success : function(result){			
					//날짜수정 페이지를 가져온다.				
					$("#boardBody").html(result);	 				
				},
				error: function (request, status, error) {			
					console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
				}
			});
			
		}
	</script>
	<style>
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
			color:#696969;
			width:50px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #eeeeee;
		}		
		
		.buttonMini{
			width:60px;
			height:20px;
		    background-color:#e1e1e1;
		    color:#666;
		    text-align: center;
			border-radius:5px;
		    font-size: 11px;
		    cursor: pointer;
		    text-decoration:none;
		    border: solid 1px grey;		    
		}
	</style>
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

			<!-- left_cnt -->
			<c:import url="../top_main/top_sysadm_left.jsp"></c:import>
			<!-- //left_cnt -->

			<!-- centercnt_top -->
			<div class="center_cnt">

				<!-- centercnt_bot -->
				<div class="centercnt_bot1-2">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">중복 로그인 Log</a></li>
							</ul>
						</div>
						<!-- 검색창 시작 -->
						<div style="border-top:0px;padding-top:10px;">
							<table>															
								<tr>
									<td style="text-align:left;">
										<input type="button" class="btn-vacation-aprv" onclick="javascript:doDupUpdate('','ALL');" style="width:120px;background-color:#CEE3F6;cursor:pointer;" value="전체 로그아웃" title="전체 계정의 중복 로그인 정보를 로그아웃 처리합니다."/>
									</td>																		
									<td style="text-align:right;">
										<form method="post" name="boardSrcForm" id="boardSrcForm" action="javascript:getDupList();">
											<input type="text" id="srchUserName" name="srchUserName" value="${srchUserName}" size="30" />&nbsp;
											&nbsp;<a class="btn-vacation-aprv" id="boardSrcBtn" href="#noloc">검색</a>
										</form>											
									</td>									
								</tr>
							</table>						
						</div>
						<!-- 검색창 끝 -->
						<div class="guestcnt4" style="display:block;" id="tab_topLogInLog">
							<div class="tableStyle2">								
								<table>
									<tr>
										<th width="10%">No</th>
										<th width="20%">팀명</th>
										<th width="15%">이름</th>
										<th width="12%">IP</th>
										<th width="12%">접속시간</th>
										<th width="12%">현재상태</th>
										<th>-</th>
									</tr>									
								</table>
							</div><!-- //tableStyle2 -->
							<div id="boardBody"></div>
						</div><!-- //guestcnt4 -->
					</div><!-- //guest -->
				</div>
				<!-- //centercnt_bot -->

				<!-- banner -->
				<c:import url="../top_main/top_main_banner.jsp"></c:import>
				<!-- //banner -->
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
