<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
<style>	
	.tableModal table{width:100%;}
	.tableModal th, .tableModal td {font-family:'굴림'; text-align:center;}
	.tableModal th {		
		background:#e7ecf1;
		border:1px solid #e5e5e5;
		border-bottom:1px solid #cfcfcf;
		vertical-align: middle;
		color:#666;
		font-size:12px;
		padding:4px 0 4px 0;
		font-weight:bold;
	}
	
	.tableModal td {border:1px solid #e5e5e5;  border-bottom:1px solid #cfcfcf; color:#666; font-size:12px; font-weight:normal;line-height:20px;padding:4px 0 4px 0; letter-spacing:-1px;}
	
	.buttonEduView{
			width:80px;
			height:30px;
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

<div id="login_auth_dialog" title="인증번호 입력하기" style="font-size: 12px;" align="center">
	<br/>
	<form id="authLoginForm" method="post">	
	<input type="hidden" id="user_no" name="user_no" value="${user_no}"/>
	<input type="hidden" id="resid_no" name="resid_no" value="${resid_no}"/>
	<input type="hidden" id="channelSel" name="channelSel" value="2"/>
	<div class="tableModal" style="width: 350px;">
		<table>
			<tr>
				<td colspan="3" style="text-align:left;padding-left:5px;">
					<div><b>${user_name}</b> 님 핸드폰으로 인증번호가 전송되었습니다.</div>					
				</td>					
			</tr>
			<tr>
				<th width="30%">인증번호</th>
				<td width="35%"><input type="text" id="auth_no" maxlength="6" style="width:90px;"/></td>
				<th width="35%"><div id="ViewTimer">03분 00초</div></th>
			</tr>
			<tr>
				<td colspan="3" style="text-align:left;padding-left:5px;">
					<div id="info_text">&#8251; 발송 된 인증번호는 3분동안 유효합니다.</div>															
				</td>
			</tr>
		</table>
		<br/>
		<input class="buttonEduView" onclick="javascript:doAuthLogin();" type="button" value="인증하기">												
	</div>
	</form>	
</div>
<script>
$(document).ready(function () {	
	
	$("#auth_no").focus();
	
	$("#auth_no").keypress(function(e) {
		 if (e.which == 13) {
			 doAuthLogin();
		 }
	});
	
	start_timer();
});

var timerID;
var time = 180;

/* 타이머를 시작하는 함수 */
function start_timer() {
	timerID = setInterval("decrementTime()", 1000);
}

/* 남은 시간을 감소시키는 함수 */
function decrementTime() {
	var tempTime;
	
	if(time > 0){
		time--;
		tempTime = toHourMinSec(time);
		$("#ViewTimer").html("<font color='blue'>"+tempTime+"</font>")

	}else{ 
		// 시간이 0이 되었으므로 타이머를 중지함
		clearInterval(timerID);		
		$("#ViewTimer").html("<font color='red'>유효시간 만료</font>")
		$("#info_text").html("<font color='red'>&#8251; 유효시간이 만료되었습니다. (재 로그인하세요.)</font>")
	}

}

/* 정수형 숫자(초 단위)를 "시:분:초" 형태로 표현하는 함수 */
function toHourMinSec(t) {
	var hour;
	var min;
	var sec;

	// 정수로부터 남은 시, 분, 초 단위 계산
	hour = Math.floor(t / 3600);
	min = Math.floor( (t-(hour*3600)) / 60 );
	sec = t - (hour*3600) - (min*60);

	// hh:mm:ss 형태를 유지하기 위해 한자리 수일 때 0 추가
	if(hour < 10) hour = "0" + hour;
	if(min < 10) min = "0" + min;
	if(sec < 10) sec = "0" + sec;

	//return(hour + ":" + min + ":" + sec);
	return(min + "분 " + sec+"초");
}

function doAuthLogin(){
	
	var authUserNo = $("#user_no").val();
	var authPw = $("#auth_no").val();
	
	if( authPw == '' ){
		alert('인증번호를 입력해주세요.');
		$("#auth_no").focus();
		return;
	}
	
	var param = {};
    param.user_no = authUserNo;
    param.auth_no = authPw;
    
    var url = "/loginIdAuthChk";

    $.ajax({
        type: "POST",
        url: url,
        data: param,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "json",
        timeout: 20000,
        success: function(data){
           //alert("data.RSLT_CODE : "+data.RSLT_CODE);
           if( data.RSLT_CODE == 000 ){
        	   $("#authLoginForm").attr("action","Main");
        	   $("#authLoginForm").submit();        	   
        	   $("#login_auth_dialog").dialog("close");
           }else if( data.RSLT_CODE == 111 ){
        	   alert("인증번호가 틀립니다.");
        	   $("#auth_no").focus();        	   
           }else if( data.RSLT_CODE == 999 ){
        	   alert("사용자 정보가 없습니다.");
        	   $("#login_auth_dialog").dialog("close");
           }           
        },
        error: function(xhr, status, error){
            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.!!!!!");
        }
    });	
	
	//$("#authLoginForm").submit();
}
</script>