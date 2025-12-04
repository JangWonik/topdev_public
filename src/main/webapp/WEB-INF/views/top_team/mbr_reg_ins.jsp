<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE HTML>
<html lang="ko">

<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" /><!--2016.01.14.rjh.수정.교체.-->
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css">
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script>
		$(document).ready(function(){
			if('${mbrAuthVo_Session.user_no}' == null || '${mbrAuthVo_Session.mbr_pms_14}' == 0){
				window.opener.location.assign("./logout");
				window.self.close();
			}
		});//ready
	</script>
	<script>
		function juminCheck(){
			var ju1 = document.formtag.jumin_no1.value;
			var ju2 = document.formtag.jumin_no2.value;

			//if( (ju1.length == 1) && (ju2.length == 1)){
			if( (ju1.length == 6) && (ju2.length == 7)){
				$.ajax({
			           type:"post",
			           url:"juminAndIdCheck",
			           data: {action : "juminCheck", ju1 : ju1, ju2: ju2 },
			           success : function(data) {
			        	   
			        	   if(data != 0){
								$("#chkJumin").html("중복되는 주민번호입니다.");
								$("#juminBlockFlag").val("block");
								//document.formtag.juminBlockFlag.value = "block";
								
							}else{
								$("#chkJumin").html("");
								$("#juminBlockFlag").val("");
								//document.formtag.juminBlockFlag.value = "";
							}
			           }
			     }); 	
			}else{
				$("#chkJumin").html("주민번호 자리수를 확인해주세요.");
			}
		}
	
		function memberIdCheck(){
			var memberId = document.formtag.user_id.value;
			
			$.ajax({
		           type:"post",
		           url:"juminAndIdCheck",
		           data: {action : "memberIdCheck", memberId: memberId },
		           success : function(data) {
		        	   
		        	   if(data != 0){
							$("#chkID").html("중복되는 ID 입니다.");
							//document.formtag.idBlockFlag.value = "block";
							$("#idBlockFlag").val("block");
						}else{
							$("#chkID").html("");
							$("#idBlockFlag").val("");
							//document.formtag.idBlockFlag.value = "";
						}
		           }
		     }); 	
		}
		
 		function memberNameCheck(){
			 var memberName = document.formtag.user_name.value;
			
			$.ajax({
		           type:"post",
		           url:"juminAndIdCheck",
		           data: {action : "memberNameCheck", memberName: memberName },
		           success : function(data) {
		        	   
		        	   if(data != 0){
							$("#chkName").html("중복되는 이름 입니다.");
							//document.formtag.idBlockFlag.value = "block";
							$("#nameBlockFlag").val("block");
						}else{
							$("#chkName").html("");
							$("#nameBlockFlag").val("");
							//document.formtag.idBlockFlag.value = ""; 
						}
		           }
		     }); 	
		}	
/*
		function memberPwCheck(){
			if($("#user_pw").val() != $("#user_pwRe").val()){
				document.formtag.idBlockFlag.value = "block";
				$("#chkPW").html("패스워드가 일치하지 않습니다.");
			}else{
				document.formtag.idBlockFlag.value = "";
				$("#chkPW").html("");
			}
		}
		
		function checkPwChar(key){
			var keyVal = key.keyCode;
			
			if(!(keyVal >=48 && keyVal <= 57)){
				keyVal.returnValue = false;
			}else{
				keyVal.returnValue = true;
			}
			
		}
*/

		$(document).ready(function(){
			
			if('${mbrAuthVo_Session.user_no}' == null || ('${mbrAuthVo_Session.mbr_pms_14}' == 0 && '${mbrAuthVo_Session.mbr_pms_15}' == 0)){
				window.opener.location.assign("./logout");
				window.self.close();
			}
			
			$("#addMember").click(function(){
				if($("#user_id").val() == ''){
					alert("ID를 입력하세요.");
					$("#user_id").focus();
					return;
				}
				if($("#user_name").val() == ''){
					alert("이름을 입력하세요.");
					$("#user_name").focus();
					return;
				}
				if($("#jumin_no1").val().length != 6){ //if($("#jumin_no1").val().length != 6){
					alert("올바른 주민번호 앞자리를 입력하세요.");
					$("#jumin_no1").focus();
					return;
				}
				if($("#jumin_no2").val().length != 7){ //if($("#jumin_no2").val().length != 7){
					alert("올바른 주민번호 뒷자리를 입력하세요.");
					$("#jumin_no2").focus();
					return;
				}
				
				/* if($("#juminBlockFlag").val()=="block" || $("#idBlockFlag").val()=="block"){
					alert("시스템 오류 입니다. 관리자에게 문의하세요.");
					return;
				} */
				
				//에러에 따른 알림으로 변경 by top3009
				if($("#juminBlockFlag").val()=="block"){
					alert("중복되는 주민번호 입니다.");
					return;
				}
				
				if($("#idBlockFlag").val()=="block"){
					alert("중복되는 아이디 입니다.");
					return;
				}
				
				if($("#nameBlockFlag").val()=="block"){
					alert("중복되는 이름 입니다.");
					return;
				}
				
				$.post("./memberAddOk",
						{	user_id:$("#user_id").val()
							,user_name:$("#user_name").val()
							,jumin_no1:$("#jumin_no1").val()
							,jumin_no2:$("#jumin_no2").val()
//							,user_pw  :$("#user_pw").val()
						},
						function(data,status){
							if(data > 0){
								alert("사원 등록이 완료 되었습니다.");
// 								$("#user_id").val("");
// 								$("#user_name").val("");
// 								$("#jumin_no1").val("");
// 								$("#jumin_no2").val("");
								$("#juminBlockFlag").val("block");
								$("#idBlockFlag").val("block");
								popMbrDetail(data);
//								$("#user_pw").val("");
//								$("#user_pwRe").val("");
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post

			});//click
		});//ready

		function popMbrDetail(user_no){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1500; //띄울 창의 넓이
			var sh=900;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
// 			window.open('popMemberDetail?user_no='+user_no,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			window.open('popMbrDetail?user_no='+user_no+'&presentPage=mbrDocTab','tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=yes,scrollbars=yes');
		}
	</script>

</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">

	<!-- header --><!--2016.01.14.rjh.수정.교체.-->
	<div id="headerpop">
		<div class="inner clear_v2">
			<h1>
				<img src="./resources/wm_img/common/logo.gif" height="39" alt="top - TRUST OBLIGATION PASSION" />
			</h1>
			<div style="text-align:center;padding-top:10px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
				<font color="white"><b><span style="font-size:11pt;"> 사 원 등 록</span></b></font>
			</div>
		</div>
	</div>
	<!-- //header -->
	<div style="margin:10px 5px 0px 5px;">

		<form name="formtag" method="post">
			<input type="hidden" name="juminBlockFlag" id="juminBlockFlag" value="block" />
			<input type="hidden" name="idBlockFlag" id="idBlockFlag" value="block" />
			<input type="hidden" name="nameBlockFlag" id="nameBlockFlag" value="block" />

			<div class="tableStyle4"><!--tableStyle4-->

				<table>
					<tr>
						<td width="30%" bgcolor='#eaeaea'>
							<p align="center">ㆍ아이디</p>
						</td>
						<td width="70%">
							<p align="left"><input onblur="memberIdCheck();" type="text" name="user_id" id="user_id" maxlength="20" size="20" style="ime-mode:disabled;"> <!-- style="ime-mode:inactive;" -->
							<span id = "chkID"></span>
							</p>
						</td>
					</tr>
					<!--김두현차장님요청-유저패스워드제거
					<tr>
						<td width="30%" bgcolor='#eaeaea'>
							<p align="center">ㆍ비밀번호</p>
						</td>
						<td width="70%">
							<p align="left">
								<input type="password" name="user_pw" id="user_pw" maxlength="20" size="20" style="ime-mode:disabled;" onKeyPress="checkPwChar(event);">
							</p>
						</td>
					</tr>
					<tr>
						<td width="30%" bgcolor='#eaeaea'>
							<p align="center">ㆍ비밀번호 확인</p>
						</td>
						<td width="70%">
							<p align="left">
								<input type="password" name="user_pwRe" id="user_pwRe" maxlength="20" size="20" onkeyup="memberPwCheck();" style="ime-mode:disabled;">
								<span id = "chkPW"></span>
							</p>
						</td>
					</tr>
					-->
					<tr>
						<td width="30%" bgcolor='#eaeaea'>
							<p align="center">ㆍ이름</p>
						</td>
						<td width="70%">
							<!-- <p align="left"><input type="text" name="user_name" id="user_name" maxlength="20" size="20" style="ime-mode:active;" ></p> -->
 							<p align="left"><input onblur="memberNameCheck();" type="text" name="user_name" id="user_name" maxlength="20" size="20">
						<span id = "chkName"></span>
						</td>
					</tr>
					<tr>
						<td width="30%" bgcolor='#eaeaea'>
							<p align="center">ㆍ주민등록번호</p>
						</td>
						<td width="70%">
							<p align="left">
								<input type="text" name="jumin_no1" id="jumin_no1" maxlength="6" size="6" ONKEYPRESS="if((event.keyCode<46)||(event.keyCode>57)||(event.keyCode==47)) event.returnValue=false;" style="ime-mode:disabled;"/>
								-
								<input type="text" name="jumin_no2" id="jumin_no2" maxlength="7" size="7" onblur="juminCheck();" ONKEYPRESS="if((event.keyCode<46)||(event.keyCode>57)||(event.keyCode==47)) event.returnValue=false;" style="ime-mode:disabled;"/>
								<span id = "chkJumin"></span>
							</p>
						</td>
					</tr>
				</table>
			</div><!--//tableStyle4-->
		<p>&nbsp;</p>
		<p align="center">
			<img id="addMember" src="./resources/ls_img/member/btn_ok.gif" style = "cursor:pointer;" border="0"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="javascript:history.go(0);"><img src="./resources/ls_img/member/btn_cancel.gif" border="0"></a>
		</p>
		</form>
	</div>

	<p>&nbsp;</p>

	<table cellpadding="0" cellspacing="0" width="100%" background="./resources/ne_img/pop/bg_f_rjh.gif">
        <tr>
            <td width="80"><p>&nbsp;</p></td>
            <td height="35"><p align="center">&nbsp;</p></td>
            <td width="80"><p align="center"><A href="javascript:window.close();"><img src="./resources/ls_img/btn_close.gif" width="35" height="18" border="0"></A></p></td>
        </tr>
    </table>

</body>

</html>
