<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE HTML>
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<link rel="stylesheet" type="text/css" href="./resources/sms/nstyle.css">
	<script language="javascript" src="./resources/sms/nscript.js"></script>
	<script type="text/javascript">
	
		/* function mySMSSend(flag){
			//document.charset = "EUC-KR";
			
			//LMS변환여부확인
            var chkLMS = $("#lblByte0").val();
            
            if( chkLMS > 80 ){
            	alert('LMS로 변환되어 발송됩니다.');
            }
			
			smsForm.phone_no.value = smsForm.receiver.value;
			formSend(document.smsForm, flag);
			//formSend(document.smsForm,1);//즉시
			//formSend(document.smsForm,2);//예약
			window.close();
		} */
		
		function mySMSSend(flag){
			//LMS변환여부확인
            var chkLMS = $("#lblByte0").val();
            
            if( chkLMS > 80 ){
            	alert('LMS로 변환되어 발송됩니다.');
            }
            
            var phone_no_val = $("#receiver").val();
            var callback_no_val = $("#callback_no").val();
            var message_val = $("#message").val();
                        
            if( phone_no_val == '' ){
            	alert('받는번호를 입력해 주세요.');
            	smsForm.phone_no.focus();
            	return false;
            }
            
            if( callback_no_val == '' ){
            	alert('보낸번호를 입력해 주세요');
            	smsForm.sender.focus();
            	return false;
            }
            
            if( message_val == '' ){
            	alert('문자내용을 입력해 주세요');
            	smsForm.message.focus();
            	return false;
            }
            
			var param = {};
            
			param.api_key = $("#api_key").val();
			param.m_user_id = $("#m_user_id").val();
			param.phone_no = $("#receiver").val();
			param.name_replace = $("#name_replace").val();
			param.DATE = $("#DATE").val();
			param.return_url = $("#return_url").val();
			param.end_alert = $("#end_alert").val();
			param.msgfocus = $("#msgfocus").val();
			param.userid = $("#userid").val();
			param.passwd = $("#passwd").val();
			param.message = $("#message").val();
			param.callback_no = $("#callback_no").val();
			
			if( flag=="1" ){		//일반발송            	
            	
            	param.SEND_TYPE = "N";
            	param.send_time = "";

        		if ( confirm("발송 하시겠습니까?") ) { 
        			
        			$("#top_loading").show();
        			
        			$.ajax({
						type: "POST",
						url: "https://api.munjamoa.co.kr/message/toplac/sendMsg",
						data: param,
						success: function(){},
						dataType: "json",
						contentType : "application/x-www-form-urlencoded",
						success: function(data){
							if(data.result == "success"){
								alert("발송에 성공하였습니다.");
								$("#top_loading").hide();
								window.open('','_self').close();
							}else{
								alert("발송에 실패하였습니다.\nIT정보보호파트로 연락하세요. (ERROR : "+data.code+")");								
							}
						},
						error: function(e){
							alert("발송에 성공하였습니다.");
							$("#top_loading").hide();
							window.open('','_self').close();
						}
						
					});
        			
        		} else {
        			return false;
        		}
        		
        	}else if( flag=="2" ) {				//예약발송
        	
           		param.SEND_TYPE = "R";            	
           		
           		if(smsForm.days.value==""){ 
           			alert('예약날짜를 입력해 주세요');
           			smsForm.days.focus();
           			return false;
           		}
           		
           		if(smsForm.days.value.length != 8) { 
           			alert('예약날짜를 잘못입력하셨습니다.');
           			smsForm.days.value = "";
           			smsForm.days.focus();
           			return false;
           		}
           		
           		days1 = smsForm.days.value;            		
           		days2 = days1.substring(0,4)+"-"+days1.substring(4,6)+"-"+days1.substring(6,8);		//날짜 패턴수정
           		
           		param.DATE = days2+" "+smsForm.dhour.value+":"+smsForm.dmin.value;		//예약발송시 사용 날짜           		           		
           		
           		if( confirm("발송예약 하시겠습니까?") ){
           			
           			$("#top_loading").show();
           			
           			$.ajax({
						type: "POST",
						url: "https://api.munjamoa.co.kr/message/toplac/sendMsg",
						data: param,
						success: function(){},
						dataType: "json",
						contentType : "application/x-www-form-urlencoded",
						success: function(data){
							if(data.result == "success"){
								alert("발송 예약에 성공하였습니다.");
								$("#top_loading").hide();
								window.open('','_self').close();
							}else{
								alert("발송 예약에 실패하였습니다.\nIT정보보호파트로 연락하세요. (ERROR : "+data.code+")");								
							}               	
						},
						error: function(){
							alert("발송 예약에 성공하였습니다.");
							$("#top_loading").hide();
							window.open('','_self').close();
						}
						
					});
           			
           			
           		}else{
           			return false;
           		}
           	}            
            
		}
		
		
	</script>
</head>

<body topmargin=10 leftmargin=10>

	<!-- <form action=" http://munjamadang.co.kr/smsasp/smsasp.html " method="post" name="smsForm"> -->
	<form action="https://api.munjamoa.co.kr/message/toplac/sendMsg" method="post" name="smsForm">
		<!-- 신규정보 추가 시작-->
		<input type="hidden" id="api_key" name="api_key" value="SYhfQxLgaANtMSfdH93staNmfM6ybDQcMsdXdFhkTQMIiYZ9Y8KNZRM2jlfBmLhKAWAumahJh1m0joPiOg04BPgIedOW4FnN7JfV">
		<input type="hidden" id="m_user_id" name="m_user_id" value="toplac">
		<input type="hidden" id="phone_no" name="phone_no" />
		<input type="hidden" id="name_replace" name="name_replace" value="N"/>
		<input type="hidden" id="SEND_TYPE" name="SEND_TYPE" />
		<input type="hidden" id="DATE" name="DATE" />
		<!-- 신규정보 추가 끝-->				
		<input type="hidden" name="send_time" value="">
		<input type="hidden" name="return_url" value="https://www.toplac.co.kr/smsClose">		
		<input type="hidden" id="end_alert" name="end_alert" value="1">
		<input type="hidden" id="msgfocus" name="msgfocus"  value="0"/>
		<input type="hidden" id="userid" name="userid" value="toplac">
		<input type="hidden" id="passwd" name="passwd" value="toplac3000">
		<div style="padding-left:100px;text-align:center;">
		<table style="width:218px;border:0;">
			<tr>
				<td><img src="./resources/sms/phone_01.gif" width="218" height="93" /></td>
			</tr>
			<tr>
				<td height="117" align=center valign=top  background="./resources/sms/phone_02.gif"><!-- height:91px; -->
					<textarea name="message" id="message" rows="6" style="FONT-SIZE:9pt;width:98px;height:91px;font-family:돋움체;background-color:Transparent;border-width:1;border-style:none;overflow: hidden; color:#CCC" onKeyUp="javascript:funStringByteCheck(this.form.lblByte0, this);" onFocus="javascript:funMsgFocus('0');"></textarea>
				</td>
			</tr>
			<tr>
				<td height="20" align=center  background="./resources/sms/phone_02.gif" alt="">
					<font color="#CCCCCC"><input name="lblByte0" type="text" id="lblByte0" maxlength="3" readonly="readonly" size="3" style="border: #ffffff 0px solid; height: 12pt; background-color: transparent; text-align: right; colorvc_resdate: #000000; color:#CCC; width:15px" value="0" /> / <input name="smssizelenght" type="text" id="smssizelenght" maxlength="3" readonly="readonly" size="3" style="border: #ffffff 0px solid; height: 12pt; background-color: transparent; text-align: right; colorvc_resdate: #000000; color: #CCC; width:15px" value="80" /> byte</font>
				</td>
			</tr>
			<tr>
				<td style="line-height:1px;"><img src="./resources/sms/phone_03.gif" width="218" height="4" /></td>
			</tr>
			<tr>
				<td background="./resources/sms/phone_04.gif" height="25" align=center><a href="javascript:funEmotiWin_View2();"><img src="./resources/sms/ptxt02.gif" alt="" border=0></a> <a href="javascript:funEmotiWin_View();"><img src="./resources/sms/ptxt01.gif" alt="" border=0></a></td>
			</tr>
			<tr>
				<td  background="./resources/sms/phone_05.gif" align=center>
					<table width="180" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td colspan=2 height=5></td>
						</tr>
						<tr>
							<td  colspan=2 align=center>받는번호 <input type="text" id="receiver" name="receiver" size=17  maxlength=12 onKeyDown="OnlyNumber();" value='${toHpNo}'></td>
						<tr>
						<tr>
							<td colspan=2 height=5></td>
						</tr>	
						<tr>
							<%-- <td  colspan=2 align=center>보낸번호 <input type="text" name="sender" size=17   maxlength=12 onKeyDown="OnlyNumber();" value='${fromHpNo}'></td> --%>
							<!-- 대표번호로 수정 -->
							<td  colspan=2 align=center>보낸번호 <input type="text" id="callback_no" name="callback_no" size=17   maxlength=12 onKeyDown="OnlyNumber();" value='0260774600'></td>
						</tr>
						<tr>
							<td colspan=2 height=5></td>
						</tr>
						<tr>
							<td colspan=2 align=center>
								<a href="#">
									<img src="./resources/sms/phone_icon4.gif" alt="" border=0 onclick="mySMSSend(1);" style='border:0;cursor:hand;'>
								</a>
								<a href="#">
									<img src="./resources/sms/phone_icon5.gif" alt="" onClick="mySMSSend(2);" style='border:0;cursor:hand;'>
								</a>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td><img src="./resources/sms/phone_06.gif" alt="" width="218" height="42" /></td>
			</tr>
		</table>
		</div>
		<table  border="0" cellpadding="0" cellspacing="0" bgcolor="#F2F2F2" width=218>
			<tr>
				<td colspan=3 height=1 bgcolor="#D0D0D0"></td>
			</tr>
			<tr height=30>
				<td colspan=3 align=center valign=middle><B>예약날짜</B>  ( <FONT COLOR="#FF0000"><B>예 : 20110123</B></FONT> ) </td>
			</tr>
			<tr>
				<td colspan=3 width="100" align=center valign=middle>
					<input name="days" type="text" style="width:82px; height:17px;" onKeyDown="OnlyNumber();" maxlength=8>
					<select name="dhour" id="dhour" size="1">
						<option value="00">00</option>
						<option value="01">01</option>
						<option value="02">02</option>
						<option value="03">03</option>
						<option value="04">04</option>
						<option value="05">05</option>
						<option value="06">06</option>
						<option value="07">07</option>
						<option value="08">08</option>
						<option value="09" selected>09</option>
						<option value="10">10</option>
						<option value="11">11</option>
						<option value="12">12</option>
						<option value="13">13</option>
						<option value="14">14</option>
						<option value="15">15</option>
						<option value="16">16</option>
						<option value="17">17</option>
						<option value="18">18</option>
						<option value="19">19</option>
						<option value="20">20</option>
						<option value="21">21</option>
						<option value="22">22</option>
						<option value="23">23</option>
					</select>시
					<select name="dmin" id="dmin" size="1">
						<option value="00">00</option>
						<option value="05">05</option>
						<option value="10">10</option>
						<option value="15">15</option>
						<option value="20">20</option>
						<option value="25">25</option>
						<option value="30">30</option>
						<option value="35">35</option>
						<option value="40">40</option>
						<option value="45">45</option>
						<option value="50">50</option>
						<option value="55">55</option>
					</select>분&nbsp;&nbsp;
				</td>
			</tr>
			<tr>
				<td colspan=3 align=center>예약전송시 날짜를 선택하세요</td>
			</tr>
			<tr>
				<td colspan=3 height=1 bgcolor="#D0D0D0"></td>
			</tr>
		</table>
	</form>

<!--------------------------------------------------------------------[이모티콘 / 특수문자 레이어] start-------------------------------------------->
    <div id="oEmotiStringForm" style="position: absolute;border:2pt solid #99CC66; left:100px; top:120px; width:270px; z-index:1000; background-image: none; background-color: white; display: none;">
		<table border="0" width="100%" id="table2" bgcolor="#FFFFFF">
			<tr>
				<td style="padding-left:10px;"><b>특수문자</b></td>
				<td align="right"><a href="javascript:funEmotiWin_Hidden();"><img src="./resources/sms/btn_close2.gif" border="0"></a></td>
			</tr>
			<tr>
				<td colspan="2">
				<div id="oMTData_1" style="OVERFLOW-X: hidden; OVERFLOW: auto; HEIGHT: 200px" onscroll="">
					<table align="center" cellpadding="0" cellspacing="1" bgcolor="#E7F4D7">
						<tr height="20">
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onmouseout="this.style.color=''; this.style.fontWeight='normal'"><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">☆</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">★</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">♡</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">♥</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">♧</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">♣</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">◁</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">◀</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">▷</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">▶</div></td>
						</tr>
						<tr height="20">
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">♤</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">♠</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">♧</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">♣</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">⊙</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">○</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">●</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">◎</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">◇</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">◆</div></td>
						</tr>
						<tr height="20">
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">⇔</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">△</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">▲</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">▽</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">▼</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">▒</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">▤</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">▥</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">▦</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">▩</div></td>
						</tr>
						<tr height="20">
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">◈</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">▣</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">◐</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">◑</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">♨</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">☏</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">☎</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">☜</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">☞</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">♭</div></td>
						</tr>
						<tr height="20">
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">♩</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">♪</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">♬</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">㉿</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">㈜</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">℡</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">㏇</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">&#8482;</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">㏂</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">㏘</div></td>
						</tr>
						<tr height="20">
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">€</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">&reg;</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">↗</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">↙</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">↖</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">↘</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">↕</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">↔</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">↑</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">↓</div></td>
						</tr>
						<tr height="20">
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">∀</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">∃</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">∮</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">∑</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">∏</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">℉</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">‰</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">￥</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">￡</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">￠</div></td>
						</tr>
						<tr height="20">
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">Å</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">℃</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">♂</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">♀</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">∴</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">《</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">》</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">『</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">』</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">【</div></td>
						</tr>
						<tr height="20">
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">】</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">&plusmn;</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">&times;</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">&divide;</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">∥</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">＼</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">&copy;</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">√</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">∽</div></td>
							<td width="20" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"   onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;" ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">∵</div></td>
						</tr>
					</table>
				</div>
				</td>
			</tr>
		</table>
	</div><!-- //oEmotiStringForm -->

	<div id="oEmotiStringForm2" style="position: absolute;border:2pt solid #99CC66; left:100px; top:120px; width:270px; z-index:1000; background-image: none; background-color: white; display: none;">
		<table border="0" width="100%" id="table2" bgcolor="#FFFFFF">
			<tr>
				<td style="padding-left:10px;"><b>이모티콘</b></td>
				<td align="right"><a href="javascript:funEmotiWin_Hidden2();"><img src="./resources/sms/btn_close2.gif" border="0"></a></td>
			</tr>
			<tr>
				<td colspan=2>
					<div id="oMTData_2" style="OVERFLOW-X: hidden; OVERFLOW: auto; HEIGHT: 250px" >
					<div style="DISPLAY: block" >
						<table align="center" cellpadding="0" cellspacing="1" bgcolor="#E7F4D7">
							<tr height="20">
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">^.^</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">^_^</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">^0^</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">^^;</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">*^^*</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">(^-^)</div></td>
							</tr>
							<tr height="20">
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">*^_^*</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">^m^</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">(X_X)</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">*.-)</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">^.~</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">^_+</div></td>
							</tr>
							<tr height="20">
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">(@.@)</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">-_-ㆀ</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">☞_☜</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">★.★</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">⊙.⊙</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">(Z_Z)</div></td>
							</tr>
							<tr height="20">
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">TmT</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">ㅠ.ㅠ</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">T.T</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">(&gt;_&lt;)</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">(=_=)</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">♡.♡</div></td>
							</tr>
							<tr height="20">
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">♥o♥</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">(*_*)</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">($_$)</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">●⊙</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">@_O</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">(^)(^)</div></td>
							</tr>
							<tr height="20">
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">|:-)</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">(-@-)</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">^@^</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">^U^</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">.ooo0</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">0ooo.</div></td>
							</tr>
							<tr height="20">
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">7=^&gt;</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">:-D</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">{8-}</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">:-)</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">(:&gt;</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">:-P</div></td>
							</tr>
							<tr height="20">
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">8-)</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">;)</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">^Δ^</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">Θ_ Θ</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">=.=</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">(_o_)</div></td>
							</tr>
							<tr height="20">
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">(_!_)</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">^v^</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">(^|^)</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">! . !</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">O_O</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">Y.Y</div></td>
							</tr>
							<tr height="20">
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">=^.^=  </div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">^*_*^</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">(^y^)</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">:-(*)</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">(8-)</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">(-.-+)</div></td>
							</tr>
							<tr height="20">
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">:-()</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">:-Q~</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">(^^)y</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">+_+;</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">'ㅁ'a</div></td>
								<td width="35" bgcolor="white" align="center" onMouseOver="this.style.backgroundColor='#FFF5DE'" onMouseOut="this.style.backgroundColor=''"  onclick="javascript:funAnyshot_Emoti_OnClick(this);" style="cursor:hand;"  ><DIV  onmouseover="this.style.color='#FF6600';" onMouseOut="this.style.color=''; this.style.fontWeight='normal'">T∩T</div></td>
							</tr>
						</table>	
					</div>
					</div><!-- //oMTData_2 -->
				</td>
			</tr>
		</table>
	</div><!-- //oEmotiStringForm2 -->
	<!-- //통합로딩바 -->
	<div id="top_loading" style="display: none;">
		<img id="loading-image" src="/resources/cmm/images/spinner.gif" alt="Loading..." />
	</div>
	<!-- //통합로딩바끝 -->
<!--------------------------------------------------------------------[이모티콘 / 특수문자 레이어] end-------------------------------------------->

</body>

</html>
