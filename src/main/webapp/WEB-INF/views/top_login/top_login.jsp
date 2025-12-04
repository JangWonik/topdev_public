<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/jquery/jquery-ui.min.js"></script>		
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script>
		$(document).ready(function(){						
			//아이디 입력 창으로 포커스 이동
			$("#user_id").focus();
			
			$("#loginBtn").click(function(){
				doLogin();
			});
			
			//Enter Key 클릭시 진행
			$("#user_pw").keypress(function(e) {
				 if (e.which == 13) {
					 doLogin();
				 }
			});
			
			if('${loginFail}' != null){
				if('${loginFail}' == 'loginFail'){
					alert('로그인 실패');
					$("#user_id").focus();
					
				}else if('${loginFail}' == 'duplication'){
					alert('현재 로그인 된 사용자 입니다.\nIT정보보호파트로 문의하세요.');
					location.href="./top_login";
				}
			};
			
		});
		
		
		//로그인 시작
		function doLogin(){
			var sUserId = $("#user_id").val();
			var sUserPw = $("#user_pw").val();
			
			//입력값 유효성 체크 시작
			if( sUserId == '' ){
				alert('User ID 를 입력해주세요.');
				$("#user_id").focus();
				return;
			}
			
			if( sUserPw == '' ){
				alert('Password 를 입력해주세요.');
				$("#user_pw").focus();
				return;
			}
			
			var param = {};
            param.user_id = sUserId;
            param.user_pw = sUserPw;
            
            var url = "/loginIdPwChk";

            $.ajax({
                type: "POST",
                url: url,
                data: param,
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                dataType: "json",
                timeout: 20000,
                success: function(data){
                    if(data.RSLT_CODE == 0){
                        //$("#resid_no").val(data.RSLT_RESID_NO);                        
                      	//console.log("result :"+data.RSLT_CODE+" : "+data.RSLT_RESID_NO+" : "+data.RSLT_MOBILE_NO+" : "+data.RSLT_USER_NO+" : "+data.RSLT_SEND_RESLUT); 
                        
                      	doAuthModal( data.RSLT_USER_NO , data.RSLT_RESID_NO, data.RSLT_USER_NAME );                        
                    }else if(data.RSLT_CODE == 911){		//핸드폰 번호가 사용자 정보에 등록되어있지 않은 경우
                    	alert("사원정보에 등록된 핸드폰 번호가 없습니다. IT정보보호파트에 문의 해 주세요.");
                    }else if(data.RSLT_CODE == 777){		//2차 인증 사용안하는 경우
                    	location.href="./succLoginByPass";
                    }else if(data.RSLT_CODE == 901){
                    	alert("비밀번호가 틀렸습니다.\n틀린 횟수 :  "+data.INVALID_PWD_CNT+" / 5");
                    }else if(data.RSLT_CODE == 905){    
                    	//alert("비밀번호가 5번 이상 틀렸습니다. IT정보보호파트에 문의 해 주세요..");
                    	//비밀번호 초기화 팝업
                    	doPassResetModal( data.RSLT_USER_NO, data.RSLT_USER_NAME, data.RSLT_MOBILE_NO );
                    }else if (data.RSLT_CODE == 910){
                    	$("#hid_user_no").val(data.USER_NO);
                    	$("#resid_no").val(data.RSLT_RESID_NO);
                    	fnPwdChgModalOpen();
                    }else{
                        alert("아이디가 존재하지 않거나 비밀번호가 다릅니다.");
                    }
                },
                error: function(xhr, status, error){
                    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.!!!!!");
                }
            });
		}
		
		//비밀번호 초기화 Modal
		function doPassResetModal( p_pkey,  p_user_name, p_mobile ){			

			var url = "./loginPassResetModal";			
			
			var param = {};
			param.user_no = p_pkey;			
			param.user_name = p_user_name;
			param.user_mobile = p_mobile;
			
			$.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        dataType: "HTML", 
		        success: function(data){
		        	$("#pass_reset_dialog").html();
		        	$("#pass_reset_dialog").html(data);
					$("#pass_reset_dialog").dialog({
						height: 300,
						width: 400,
						closeOnEscape : true,
						draggable : true,
						title: "비밀번호 초기화하기",
						modal: true,
						buttons:{						
							"닫기" : function(){
								$(this).dialog("close");
							}
						},
						overlay:{ opacity: 0., background: '#000000'}
					});		
		        },
		        error: function(e){
		            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		        }
		    });
			
		}
		
		
		//AuthModal 
		function doAuthModal( p_pkey , p_rkey , p_user_name ){
			
			var url = "./loginAuthUserModal";
			
			var param = {};
			param.user_no = p_pkey;
			param.resid_no = p_rkey;
			param.user_name = p_user_name;
			
			$.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        dataType: "HTML", 
		        success: function(data){
		        	$("#login_auth_dialog").html();
		        	$("#login_auth_dialog").html(data);
					$("#login_auth_dialog").dialog({
						height: 230,
						width: 400,
						closeOnEscape : true,
						draggable : true,
						title: "인증번호 입력하기",
						modal: true,
						/* buttons:{						
							"닫기" : function(){
								$(this).dialog("close");
							}
						}, */
						overlay:{ opacity: 0., background: '#000000'}
					});		
		        },
		        error: function(e){
		            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		        }
		    });	
		}
	</script>
	<style>
		.buttonLogin{
			width:100px;
			height:50px;
		    background-color:#013469;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 15px;
		    font-weight: bold;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		    display:inline-block;
		    padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;		    
		    }
	</style>
<head>
	<title>탑손해사정 주식회사</title>
</head>
<body>	
	<form name="loginForm" method="post" action="NewNiceCert">        
		<div style = "margin-top:15%;">			
			<table cellpadding="0" cellspacing="0" width="510" height="270" background="./resources/ls_img/login/login_bg.jpg" align="center">
		        <tr>
		            <td width="100%" valign="top">
		                <table cellpadding="0" cellspacing="0" width="100%">
		                    <tr>
		                        <td width="100%" height="114">
		                            <p>&nbsp;</p>
		                        </td>
		                    </tr>
		                </table>		                
		                
						<table cellpadding="3" cellspacing="0" width="510">
                             <tr>
                                 <td width="210">
                                     <p align="right" style="font-family:sans-serif; font-size:0.8em; color:black;">
                                        User ID <input type="text" size="15" id = "user_id" name="user_id" maxlength="15" style="ime-mode:disabled; width:120px;" value ="" tabindex="1"><br/>
                                        Password <input type="password" size="15" id = "user_pw" name="user_pw" maxlength="15" 
                                         style="ime-mode:disabled; width:120px; margin-top: 5px;" value ="" tabindex="2">
                                     </p>
                                 </td>
                                 <td width="288">
										<input title="검색" class="buttonLogin" type="button" value="로그인" id="loginBtn" tabindex="3">
                                 </td>
                             </tr>
                        </table>		                
		            </td>
		        </tr>
			</table>
		</div>
	</form>
	<!-- 로그인전 팝업 시작 -->
	<c:forEach items="${divPopupList}" var="popup" varStatus="status">
	
		<div id="popup-${popup.popup_no}" title="미리보기" style="font-size: 10px;">
			<span id="previewContent">${popup.contents}</span>				 
		</div>
		
		<script>
			var p_height = '${popup.popup_width}';
			var p_width = '${popup.popup_height}';
			var preSubject = '${popup.subject}';			
			
			$("#popup-${popup.popup_no}").dialog({
				height: p_height,
				width: p_width,
				closeOnEscape : true,
				draggable : true,					
				title: preSubject,				
				modal: true,
				position: { 'at' : 'right top' }
			
			});
		</script>		
		
	</c:forEach>	
	<!-- 로그인전 팝업 끝 -->
	<!-- 비밀번호 변경 MODAL -->
    <c:import url="./top_login_pwd_modal.jsp"></c:import>
    <!-- 로그인 인증번호 체크 모듈 시작-->
    <div id="login_auth_dialog" title="인증번호 입력하기" style="font-size: 10px;" align="center"></div>
    <!-- 로그인 인증번호 체크 모듈 끝-->    
    <!-- 비밀번호 초기화 모듈 시작 -->
    <div id="pass_reset_dialog" title="비밀번호 초기화 하기" style="font-size: 10px;" align="center"></div>
    <!-- 비밀번호 초기화 모듈 끝 -->
</body>
</html>