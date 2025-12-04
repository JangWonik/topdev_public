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
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	<script>
		$(document).ready(function(){
			
			if("${authFlag}" == 'no'){
				alert("권한이 없습니다.");
				window.close();
			}
			
			
			
		});//ready
		
		function deljuk(obj){
			
			
			
			if(confirm("삭제하시겠습니까?")){	
				
				var date = ""; 
				
				if( obj == 10){
					if($("#calKb").val() == ''){
						alert("날짜를 선택하세요.");
						return;
					}
					date = $("#calKb").val();
				}else{
					if($("#calHan").val() == ''){
						alert("날짜를 선택하세요.");
						return;
					}
					date = $("#calHan").val();
				}
				
				$.post("./deljuk",
						{
							ptnrId : obj,
							date : date
						},
						function(data, status) {
							
							if(status == "success"){
								
								if(data == 1){
									alert("삭제 되었습니다.");
								}else if(data == 2){
									alert("권한이 없습니다.");
								}else if(data == 0){
									alert("오류, 시스템 관리자에게 문의 하세요.");
									
								}
								
							}else{
								alert("오류, 시스템 관리자에게 문의 하세요.");
							}
						
						} 
				
				);
			}
			
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
				<font color="white"><b><span style="font-size:11pt;"> 적부 데이터 관리</span></b></font>
			</div>
		</div>
	</div>
	<!-- //header -->
	<div style="margin:10px 5px 0px 5px;">

			<div class="tableStyle4"><!--tableStyle4--><!--2016.01.14.rjh.수정.삽입.-->
				
				<p>&nbsp;</p>
				<!-- KB 시작 -->
				<table align="center" cellpadding="0" cellspacing="0" width="350">
					<tr>
						<td bgcolor="#EFEFEF" class="td" height="50" width="20%">
							<p align="center"><font color="black">KB</font></td>
						<td class="td" width="60%">                                        
							<p align="center">
							<input type="text" id = "calKb" size ="10"/>
							까지 수임건</p>
						</td>
						<td class="td" width="20%">                                        
							<p align="center"><img src="./resources/ls_img/btn_del.gif" width="45" height="18" onclick="deljuk(10);" style="cursor:pointer;"></p>
						</td>
					</tr>
				</table>
				<!-- KB 끝 -->
				<p>&nbsp;</p>
				<!-- 한화 시작 -->
				<table align="center" cellpadding="0" cellspacing="0" width="350">
					<tr>
						<td bgcolor="#EFEFEF" class="td" height="50" width="20%">
							<p align="center"><font color="black">한화</font></td>
						<td class="td" width="60%">                                        
							<p align="center">
							<input type="text" id = "calHan" size ="10"/>
							까지 수임건</p>
						</td>
						<td class="td" width="20%">                                        
							<p align="center"><img src="./resources/ls_img/btn_del.gif" width="45" height="18" onclick="deljuk(12);" style="cursor:pointer;"></p>
						</td>
					</tr>
				</table>
			</div><!--//tableStyle4--><!--2016.01.14.rjh.수정.삽입.-->
		<p>&nbsp;</p>
		<p align="center">
			<img src="./resources/ls_img/member/btn_ok.gif" style = "cursor:pointer;" onclick=""/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="javascript:window.close();"><img src="./resources/ls_img/member/btn_cancel.gif" border="0"></a>
		</p>
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
