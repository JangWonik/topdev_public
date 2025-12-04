<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

	<form id="loginPwdFrm">
		<div id="login-pwd-dialog" title="비밀번호 변경 기간 초과" style="font-size: 15px;display:none;" align="center">
			<br/>
			<div style="width: 650px;">
				<h3>
					비밀번호를 변경한지 90일이 지났습니다.
					<br/><br/>
					인트라넷 이용을 위해 비밀번호 변경이 필요합니다!
					<br/><br/>
				</h3>
				<table>
					<tr>
						<th align="right">변경 비밀번호</th>
						<td> : <input type="password" id="toPw" /></td>
					</tr>
					<tr>
						<th align="right">변경 비밀번호 확인</th>
						<td> : <input type="password" id="toPwRe" /></td>
					</tr>					
				</table>
				<input type="hidden" id="hid_user_no" value=""/>
			
			</div>
		</div>
	</form>									
	
	<script>
		function fnPwdChgModalOpen(){
			$("#login-pwd-dialog").dialog({
				height: 400,
				width: 680,
				closeOnEscape : true,
				draggable : false,
				appendTo : "#loginPwdFrm",
				title: "비밀번호 변경 기간 초과",
				buttons:{
					"비밀번호 변경" : function(){
						fnPwdChg();
					}
				},
				modal: true,
				overlay:{ opacity: 0., background: '#000000'},
		     	close: function(event, ui) {		     		
		     		alert("변경한 비밀번호로 다시 로그인 해 주세요.");
		     		$("#user_pw").val('');
		     		$("#user_pw").focus();
			    }				
			});
		}
		
		function fnPwdChg(){
			
			if($("#toPw").val() != $("#toPwRe").val()){
				alert("변경할 비밀번호를 확인해주세요.");
				$("#toPw").focus();
				return;
			}
			
			var check = /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{8,10}$/;
			
			if(!check.test($("#toPw").val())){
				alert("비밀번호는 8~10자리의 영문,숫자,특수문자의 조합으로 입력해주세요.")
				$("#toPw").focus();
				return;
			}
			
			var url = "/myPwEdite";
			var param = {};
			param.user_no = $("#hid_user_no").val();
			param.user_pwNow = $("#user_pw").val();
			param.user_pwNew = $("#toPw").val();
			
		    $.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        dataType: "JSON", 
		        success: function(data){
		        	if (data == 1){
						alert("비밀번호 변경이 완료 되었습니다.");
						$("#login-pwd-dialog").dialog('close');
						//핸드폰 인증 시작
						
		        	}else if (data == 0){
		        		alert("비밀번호 변경에 실패 하였습니다.\n잠시 후 다시 시도 해 주세요..");
		        	}else if(data == 3){
						alert("기존에 사용한 비밀번호입니다.\n(변경 2회전까지 사용했던 비밀번호를 확인합니다.)");
					}else{
		        		alert("비밀번호 변경에 실패 하였습니다.\nIT정보보호파트에 문의 해 주세요.");
		        	}
		        },
		        error: function(e){
		            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		        }
		    });
			
			
		}
		
	
	
	</script>
