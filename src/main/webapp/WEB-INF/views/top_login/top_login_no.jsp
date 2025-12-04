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
<!-- 	<script src="./resources/jquery/jquery.min_1_12.js"></script> -->
	<script>
		$(document).ready(function(){
			$("#resid_no").focus();
			
			$('div').removeClass('ui-widget-overlay ui-front');			
			
			/* 채널 인증 방식 라디오 버튼 선택 시 동작 */
			$("input:radio[name='channelSel']").click(function(){
				if($("input:radio[name='channelSel']:checked").val() == 1){
					$("#oneChannel").show();
					$("#twoChannel").hide();
					$("#resid_no").focus();
				}else{
					$("#oneChannel").hide();
					$("#twoChannel").show();
					$("#residNoForTwoChannel").focus();
				}	
			});
			
			if('${loginFail}' != null){
				if('${loginFail}' == 'loginFail'){
					alert('로그인 실패');
					$("#resid_no").focus();
					
				}else if('${loginFail}' == 'duplication'){
					alert('현재 로그인 된 사용자 입니다.\nIT정보보호파트로 문의하세요.');
					$("#resid_no").focus();
				}
			};
			
			/* 1채널 방식에서 엔터(코드 :13) 눌렸을 시 동작 */
			$("#user_id, #user_pw").keypress(function(e) {
				 if (e.which == 13) {
					 //loginIdChk();
					 loginIdPwChk();
				 }
			});
			
			/* 2채널 방식에서 패스워드 인풋 태그에서 엔터(코드 :13) 눌렸을 시 동작 */
			$("#passWdForTwoChannel").keypress(function(e) {
				 if (e.which == 13) {
					 memberPassCheck();
				 }
			});			
			
			/* 1채널 방식에서 버튼 수동으로 눌렀을 시 동작 */
			$("#loginSubmitBtn").click(function(){
				//주민등록번호
				//loginIdChk();
				
				//ID PWD
				loginIdPwChk();
			});
			
			/* 2채널 방식에서 버튼 수동으로 눌렀을 시 동작 */
			$("#loginSubmitBtnForTwoChannel").click(function(){
				memberPassCheck();
			});
			
			/* $("#resid_no").keypress(function(e) {
				 
				 if (e.which == 13) {
					 loginForm.submit();
				 }
				 
			}); */			
						
		});
		function loginIdChk(){
			if ( $("#resid_no").val().length == 13 ){
				$.post("./loginIdChk",
						{ resid_no : $("#resid_no").val() },
						function(data,status){
							if(data != "0" && status == "success"){
								//공인인증서 호출
								//popCert();
								//window.open('about:blank', '_self').close();
								
								//공인인증 우회
		                        loginForm.action = "Main";
		                        loginForm.submit();
								
							}else{
								alert("로그인 실패");
								return false;
							}
							
						}
				);
			}else{
				alert("주민등록번호를 입력해주세요.");
				return false;
			}
		}


		function loginIdPwChk(){
            if ($("#user_id").val() == ""){
                alert("아이디를 입력해 주세요.");
                $("#user_id").focus();
                return;
            }

            if ($("#user_pw").val() == ""){
                alert("비밀번호를 입력해 주세요.");
                $("#user_pw").focus();
                return;
            }

            var param = {};
            param.user_id = $("#user_id").val();
            param.user_pw = $("#user_pw").val();

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
                        $("#resid_no").val(data.RSLT_RESID_NO);
                        //공인인증서 호출			
						//popCert();			//개발인 경우 주석처리
						//window.open('about:blank', '_self').close();		//개발인 경우 주석처리

                        //공인인증 우회
                        loginForm.action = "Main";		//개발인경우 적용
                        loginForm.submit();				//개발인경우 적용
                    }else if(data.RSLT_CODE == 901){
                    	alert("비밀번호가 틀렸습니다.\n틀린 횟수 :  "+data.INVALID_PWD_CNT+" / 5");
                    }else if(data.RSLT_CODE == 905){    
                    	alert("비밀번호가 5번 이상 틀렸습니다. IT정보보호파트에 문의 해 주세요..");
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

		
		function popCert(){
			var w="433";
			var h="540";
		    var x=window.screenLeft;
		    var y=window.screenTop;
		    var l=x+((document.body.offsetWidth-w)/2);
		    var t=y+((document.body.offsetHeight-h)/2);
		    
			var certWin = window.open("","niceCert","toolbars=0,resizable=0,scrolling=0,width="+w+",height="+h+",statusbar=1,top="+t+",left="+l);
			loginForm.target = "niceCert";
			loginForm.submit();
			certWin.focus();
		}
		
		/* 2채널 인증 방식에서 ID,PW,주민번호로 1차 검증 : count 결과 값으로*/
		function memberPassCheck(){
			$.post("./loginPassWordCheck",
					{	
						 residNoForTwoChannel	:$("#residNoForTwoChannel").val()
						,passWdForTwoChannel  	:$("#passWdForTwoChannel").val()
						,topIdForTwoChannel  	:$("#topIdForTwoChannel").val()
					},
					function(data,status){
						
						if(status == "success"){
							if(data == 0){
								alert("주민번호 혹은 비밀번호를 확인 후 다시 시도해주세요.");
							}else if(data == 1){
								loginForm.submit();
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}
			);//post
		}
		
		function checkResNoLength(){
			if($("#residNoForTwoChannel").val().length == 2){
				$("#topIdForTwoChannel").focus();
			}
		}
		
		function checkTopIdLength(){
			if($("#topIdForTwoChannel").val().length == 7){
				$("#passWdForTwoChannel").focus();
			}
		}
		
	</script>
<head>
	<title>${title_Session}</title>
</head>
<body>
	<%-- <form name="loginForm" method="post" action="Main">
		<div style = "margin-top:15%;">
			<table cellpadding="0" cellspacing="0" width="510" height="270" background="./resources/ls_img/login/login_bg.jpg" align="center">
		        <tr>
		            <td width="100%" valign="top">
		                <table cellpadding="0" cellspacing="0" width="100%">
		                    <tr>
		                        <td width="100%" height="130">
		                            <p>&nbsp;</p>
		                        </td>
		                    </tr>
		                </table>
		                <table cellpadding="3" cellspacing="0" width="510">
		                    <tr>
		                        <td width="210"><p align="right"><input type="password" value="88" size="15" id = "resid_no" name="resid_no" maxlength="15" onKeyPress="if ((event.keyCode<46)||(event.keyCode>57)||(event.keyCode==47)) event.returnValue=false;" onKeydown="javascript:if(event.keyCode == 13) jsf_chkValid(document.inputForm);" style="ime-mode:disabled; width:120px;"></p>
		                        </td>
		                        <td width="288"><p><input type=image src="./resources/ls_img/login/btn_login.gif" width="50" height="18" border="0"></p>
		                        </td>
		                    </tr>
		                </table>
		            </td>
		        </tr>
			</table>
		</div>
	</form> --%>
	
	<!-- <form name="loginForm" method="post" action="NiceCert"> -->
	<form name="loginForm" method="post" action="NewNiceCert">
        <input type="hidden" id="resid_no" name="resid_no"/>
		<div style = "margin-top:15%;">
			<table align="center" style="display:none">
				<tr>
					<td> 테스트용 : 
						<input type="radio" name = "channelSel" checked="checked" value = "1"/>1채널
						<input type="radio" name = "channelSel" value = "2"/>2채널
					</td>
				</tr>
			</table>
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
		                <div id = "twoChannel" style="display:none;">
			                <table cellpadding="3" cellspacing="0" width="510">
			                    <tr>
			                        <td width="210">
			                        	<p align="right">
			                        		<input type="password" size="15" id = "residNoForTwoChannel" name="residNoForTwoChannel" maxlength="15" onKeyPress="if ((event.keyCode<46)||(event.keyCode>57)||(event.keyCode==47)) event.returnValue=false;" onKeydown="javascript:if(event.keyCode == 13) jsf_chkValid(document.inputForm);" 
			                        			style="ime-mode:disabled; width:120px;" onkeyup="checkResNoLength();" >
			                        		<input type="text" size="15" id = "topIdForTwoChannel" name="topIdForTwoChannel" maxlength="15" style="ime-mode:disabled; width:120px;" onkeyup="checkTopIdLength();">
			                        		<input type="password" size="15" id = "passWdForTwoChannel" name="passWdForTwoChannel" maxlength="15" style="ime-mode:disabled; width:120px;">
			                        	</p>
			                        </td>
			                        <td width="288">
			                        	<p>
			                        		<!-- <input type=image src="./resources/ls_img/login/btn_login.gif" width="50" height="18" border="0"> -->
			                        		<img src="./resources/ls_img/login/btn_login.gif" id = "loginSubmitBtnForTwoChannel" style="cursor:pointer;" />
			                        	</p>
			                        </td>
			                    </tr>
			                </table>
		                </div>
		                <div id = "oneChannel">
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
                                        <p>
                                            <!-- <input type=image src="./resources/ls_img/login/btn_login.gif" width="50" height="18" borders="0"> -->
                                            <img src="./resources/ls_img/login/btn_login.gif" id = "loginSubmitBtn" style="cursor:pointer;" tabindex="3"/>
                                        </p>
                                    </td>
                                </tr>
                           </table>
						
						<%--
							<table cellpadding="3" cellspacing="0" width="510"> 
			                    <tr>
			                        <td width="210">
			                        	<p align="right">
			                        		<input type="password" size="15" id = "resid_no" name="resid_no" maxlength="15" onKeyPress="if ((event.keyCode<46)||(event.keyCode>57)||(event.keyCode==47)) event.returnValue=false;" onKeydown="javascript:if(event.keyCode == 13) ;" 
			                        			style="ime-mode:disabled; width:120px;" value ="" >
			                        	</p>
			                        </td>
			                        <td width="288">
			                        	<p>
			                        		<!-- <input type=image src="./resources/ls_img/login/btn_login.gif" width="50" height="18" border="0"> -->
			                        		<img src="./resources/ls_img/login/btn_login.gif" id = "loginSubmitBtn" style="cursor:pointer;" />
			                        	</p>
			                        </td>
			                    </tr>
			                </table> 
				 --%>
			                

		                </div>
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
</body>
</html>