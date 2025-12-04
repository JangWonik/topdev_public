<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
<script>
$(document).ready(function () {	
		
});

function doPassResetAction(){
	
	var sUser_name = $("#user_name").val();
	var sUser_no = $("#user_no").val();
	var sHandphone = $("#user_mobile").val();	
	
	var url = "/refleshPwKakaoSelf";
	
	var param = {};
    param.user_name = sUser_name;
    param.user_no = sUser_no;
    param.mobile = sHandphone;
    
    $.ajax({
    	type: "POST",
    	url: url,
    	data: param,
    	contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    	dataType: "json",
    	timeout: 20000,
    	success: function(data){ 		                	
    		var reCode = data.RSLT_CODE; 		                	
    		if( reCode == "K" ){
    			alert("비밀번호 초기화 정보를 카카오톡으로 발송요청 하였습니다");
    		}else if( reCode == "M" ){
    			alert("비밀번호 초기화 정보를 SMS로 발송요청 하였습니다");
    		}else if( reCode == "L" ){
    			alert("비밀번호 초기화 정보를 카카오톡(문자) 발송요청 하였습니다");
    		}else{
    			alert( reCode );
    		}
    		location.href="/top_login";
    	},
    	error: function(xhr, status, error){
    	    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.!!!!!");
    	}        
    });
}
</script>
<style>
#ui-id-1{
	font-size:15px;
}

.tableStyle2 table{width:100%;}
.tableStyle2 th, .tableStyle2 td {font-family:'굴림'; text-align:center;}
.tableStyle2 th {	
	background:#e7ecf1;
	border:1px solid #e5e5e5;
	border-bottom:1px solid #cfcfcf;
	vertical-align: middle;
	color:#666;
	font-size:12px;
	padding:4px 0 4px 0;
	font-weight:bold;
}

.tableStyle2 td {border:1px solid #e5e5e5;  border-bottom:1px solid #cfcfcf; color:#666; font-size:12px; font-weight:normal;line-height:20px;padding:4px 0 4px 0; letter-spacing:-1px;}

.buttonResetView{
		width:200px;
		height:23px;
	    background-color:#3232FF;
	    color:#FFFFFF;
	    text-align: center;
		border-radius:5px;
	    font-size: 13px;
	    cursor: pointer;
	    text-decoration:none;
	    border: none;
}	
</style>
<div id="pass_reset_dialog" title="비밀번호 초기화하기" style="font-size: 10px;" align="center">
	<br/>	
	<c:choose>
		<c:when test="${empty user_mobile}">
			<div class="tableStyle2" style="width: 360px;">
				<table>
					<tr>				
						<th style="text-align:left;padding-left:10px;height:70px;">
							<font color="blue">${user_name}</font> 님의 비밀번호가 <font color="red">5회 이상</font> 틀렸습니다.<br/>
							휴대폰 정보가 없어 비밀번호 초기화가 불가합니다. <br/>
							아래 IT정보보호파트에 문의 해 주세요
						</th>
					</tr>
					<tr>
						<td  style="height:40px;">
							<b>IT정보보호파트 : 02-6077-4608, 4611</b>
						</td>
					</tr>
				</table>
				<br/>														
			</div>
		</c:when>
		<c:otherwise>
			<div class="tableStyle2" style="width: 360px;">
				<table>
					<tr>				
						<th style="text-align:left;padding-left:10px;height:70px;">
							<font color="blue">${user_name}</font> 님의 비밀번호가 <font color="red">5회 이상</font> 틀렸습니다.<br/>
							아래 비밀번호 초기화 하기를 클릭하면 <br/>
							휴대폰으로 초기화 비밀번호가 전송됩니다.
						</th>
					</tr>
					<tr>
						<td  style="height:40px;">
							<input class="buttonResetView" onclick="javascript:doPassResetAction();" type="button" value="비밀번호 초기화 하기">
						</td>
					</tr>
				</table>
				<br/>														
			</div>
		</c:otherwise>
	</c:choose>
</div>
<input type="hidden" id="user_name" name="user_name" value="${user_name}">
<input type="hidden" id="user_no" name="user_no" value="${user_no}">
<input type="hidden" id="user_mobile" name="user_mobile" value="${user_mobile}">