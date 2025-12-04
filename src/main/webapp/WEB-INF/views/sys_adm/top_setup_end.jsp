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
			/* if('${mbrAuthVo_Session.user_no}' == null || '${mbrAuthVo_Session.mbr_pms_14}' == 0){
				window.opener.location.assign("./logout");
				window.self.close();
			} */
			$("input:radio[name='apvEndFor1']:radio[value='${topEndSetupVo.closeRptYn1}']").prop('checked', true);
			$("input:radio[name='apvEndFor4']:radio[value='${topEndSetupVo.closeRptYn4}']").prop('checked', true);
			
		});//ready
		
		function setEndState(){
			$.post("udtSetupEnd",
					{	
						closeRptYn1 : $("input:radio[name='apvEndFor1']:checked").val(),
						closeRptYn4 : $("input:radio[name='apvEndFor4']:checked").val()
					},
					function(data,status){

						if(status == "success"){

							if(data != 0){
								
								if(confirm("저장 완료. 창을 닫으시겠습니까?")){
									window.close();
								}
								
							}else{
								alert("시스템 오류 입니다.");
							}
							
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}
			);//post
		} //setEndState
		
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
				<font color="white"><b><span style="font-size:11pt;"> 종결 허용 관리</span></b></font>
			</div>
		</div>
	</div>
	<!-- //header -->
	<div style="margin:10px 5px 0px 5px;">

		<form name="formtag" method="post">
			<input type="hidden" name="juminBlockFlag" id="juminBlockFlag" value="block" />
			<input type="hidden" name="idBlockFlag" id="idBlockFlag" value="block" />

			<div class="tableStyle4"><!--tableStyle4--><!--2016.01.14.rjh.수정.삽입.-->
				
				<table>
					<tr>
						<td bgcolor="#EDEDED" width="20%" align="center">1종</td>
						<td >
							<input type="radio" name= "apvEndFor1" value = "0"/> 종결 허용
							<input type="radio" name= "apvEndFor1" value = "1"/> 종결 금지
						</td>
					</tr>
					<tr>
						<td bgcolor="#EDEDED" width="20%" align="center">4종</td>
						<td>
							<input type="radio" name= "apvEndFor4" value = "0"/> 종결 허용
							<input type="radio" name= "apvEndFor4" value = "1"/> 종결 금지
						</td>
					</tr>
				</table>

			</div><!--//tableStyle4--><!--2016.01.14.rjh.수정.삽입.-->
		<p>&nbsp;</p>
		<p align="center">
			<img src="./resources/ls_img/member/btn_ok.gif" style = "cursor:pointer;" onclick="setEndState();"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="javascript:window.close();"><img src="./resources/ls_img/member/btn_cancel.gif" border="0"></a>
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
