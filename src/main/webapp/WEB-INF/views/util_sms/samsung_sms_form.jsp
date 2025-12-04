<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE HTML>
<html>

<head>
<title>${title_Session}</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" /><!--2016.01.14.rjh.수정.교체.-->
<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
<script src="./resources/jquery/jquery.min_1_12.js"></script>
<script src="./resources/wm_js/common.js"></script>
<script>
	$(document).ready(function(){
		
		$("#submitBtn").click(function(){
			$.post("./smsSend",
				{
					smsType : $("#smsType").val(),
					suimRptNo : $("#suimRptNo").val(),
					receiveTel : $("#receiveTel").html().trim(),
					sendTel : $("#sendTel").html().trim()
					
				},
				function(data, status){
					if(status == "success"){
						if(data == 1){
							alert("발송 완료되었습니다!!");
							window.opener.location.reload();
							window.close();
						}else{
							alert("발송에 실패하였습니다. \n 관리자에게 문의하세요.");
						}
					}
				}
			);
		});
		
	});
</script>
</head>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>
<input type='hidden' name='action' value='go'>
<input type='hidden' id="smsType" name='smsType' value='${suimSuit_18_SmsVo.smsType}'>
<input type='hidden' id="suimRptNo" name='suimRptNo' value='${suimSuit_18Vo.suimRptNo}'>
<table >
	<tbody>
		<tr>
        <td width="90%" height="200">
            <table >
                <tr>
                    <td width="20%" class="td" bgcolor='#efefef' align='center' nowrap>
                        <p>수신인</p>
                    </td>
                    <td width="80%" class="td">
                        <p>
                        	<c:choose>
								<c:when test="${suimSuit_18_SmsVo.smsType eq 1 }">
									취급자
								</c:when>
								<c:otherwise>
									계약자
								</c:otherwise>
							</c:choose>
                        </p>
                    </td>
                </tr>
                <tr>
                    <td class="td" bgcolor='#efefef' align='center' nowrap>
                        <p>수신번호</p>
                    </td>
                    <td class="td">
                        <p id="receiveTel">
							<c:choose>
								<c:when test="${suimSuit_18_SmsVo.smsType eq 1 }">
									${suimSuit_18Vo.clerkHndPhoneNo }
								</c:when>
								<c:otherwise>
									${suimSuit_18Vo.conHndPhoneNo } 
								</c:otherwise>
							</c:choose>
							
						</p>
                    </td>
                </tr>
                <tr>
                    <td class="td" bgcolor='#efefef' align='center' nowrap>
                        <p>송신번호</p>
                    </td>
                    <td class="td">
                        <p id="sendTel">
                        	<%-- ${suimSuit_18Vo.handphone} --%> 
                        	${suimSuit_18Vo.keyOfficeNumber}
                        </p>
                    </td>
                </tr>
                <tr>
                    <td class="td" bgcolor='#efefef' align='center' nowrap>
                        <p>내 용</p>
                    </td>
                    <td class="td">
                        <p>
                        	${suimSuit_18_SmsVo.rMsg}
                        </p>
                    </td>
                </tr>
            </table>
			<p>&nbsp;</p>
			<p align='center'>
			<img src="./resources/ls_img/btn_sms_s.gif" id="submitBtn" class="btn">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="javascript:window.close();"><img src="./resources/ls_img/report/btn_cancel.gif" border="0"></a>
			</p>
        </td>
    </tr>
	</tbody>    
</table>
</body>

</html>
