<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
			
			if('${mbrVo_Session.user_state}' == null || ('${mbrVo_Session.user_state}' != 9)){
				alert("권한이 없습니다.");
				window.self.close();
			}
			
			$("#endDateUdtOkBtn").click(function(){
				
				$.post("./endDateUdtOk",
					{
						suimRptNo : $("#suimRptNo").val(),
						end_date1 : $("#end_date1").val(),
						end_date2 : $("#end_date2").val(),
						end_date3 : $("#end_date3").val()
						
					},
					function(data,status){
						if(status=='success'){
							if(data == 1){
								alert("수정완료.");
								window.opener.location.reload();
							}else{
								alert("시스템 오류, 관리자에게 문의하세요.");
							}
						}
						window.self.close();
					}
				);
			});
			
			
		});//ready
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
				<font color="white"><b><span style="font-size:11pt;"> 종결일 수정</span></b></font>
			</div>
		</div>
	</div>
	<!-- //header -->
	<div style="margin:10px 5px 0px 5px;">

			<input type="hidden" name="suimRptNo" id="suimRptNo" value="${suimRptNo }" />

			<div class="tableStyle4"><!--tableStyle4--><!--2016.01.14.rjh.수정.삽입.-->

				<table cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" width="100%" bgcolor="#4B6AA8">
                    <tr>
	                    <td bgcolor="#DAECF7" class="td" width="91">
							<p>ㆍ보고서 NO.</p>
	                    </td>
	                    <td class="td" bgcolor="#F1F1F1" width="215">
	                        <p><b>${accNo}</b></p>
	                    </td>
                    </tr>
                    <tr>
	                    <td bgcolor="#DAECF7" class="td" width="91">
							<p>ㆍ종결일</p>
	                    </td>
	                    <td class="td" bgcolor="#F1F1F1" width="215">
							<p>
								<input type=text id="end_date1" class=input value="${fn:split(endDate,'-')[0]}" size="4" onKeyup="autotab(this, document.write.end_date2)" maxlength="4" onKeyPress="if ((event.keyCode<46)||(event.keyCode>57)||(event.keyCode==47)) event.returnValue=false;" style="ime-mode:disabled">년 
	                           	<input type=text id="end_date2" class=input value="${fn:split(endDate,'-')[1]}" size="2" onKeyup="autotab(this, document.write.end_date3)" maxlength="2" onKeyPress="if ((event.keyCode<46)||(event.keyCode>57)||(event.keyCode==47)) event.returnValue=false;" style="ime-mode:disabled">월 
	                           	<input type=text id="end_date3" class=input value="${fn:split(endDate,'-')[2]}" size="2" onKeyup="autotab(this, document.write.ig_subject)" maxlength="2" onKeyPress="if ((event.keyCode<46)||(event.keyCode>57)||(event.keyCode==47)) event.returnValue=false;" style="ime-mode:disabled">일
	                        </p>
	                    </td>
                    </tr>
            	</table>
                <p>&nbsp;</p>
                <p align="center"><img src="./resources/ls_img/icon_write.gif" width="75" height="23" id="endDateUdtOkBtn" style="cursor:pointer;"></p>
			</div><!--//tableStyle4--><!--2016.01.14.rjh.수정.삽입.-->
		<p>&nbsp;</p>
	</div>

	<table cellpadding="0" cellspacing="0" width="100%" background="./resources/ne_img/pop/bg_f_rjh.gif">
        <tr>
            <td width="80"><p>&nbsp;</p></td>
            <td height="35"><p align="center">&nbsp;</p></td>
            <td width="80"><p align="center"><A href="javascript:window.close();"><img src="./resources/ls_img/btn_close.gif" width="35" height="18" border="0"></A></p></td>
        </tr>
    </table>

</body>

</html>
