<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<!-- <script type='text/javascript' src='http://malsup.github.com/jquery.form.js'></script> -->
	<script type='text/javascript' src='https://malsup.github.io/jquery.form.js'></script>
	<script src="./resources/wm_js/common.js"></script>
	
	<script>
		$(document).ready(function(){
			$("#myDocInsBtn").click(function(){
				if( $("#doc_title").val() != "" ){
					AjaxSubmit();
				}else{					
					alert("제목은 필수 입력사항입니다.");
				}
			});//click
			
			function AjaxSubmit(){
				options = {
					beforeSubmit 	: submitBefore,
					success			: submitAfter,
					dataType 		: 'JSON'
				};
				$("#myDocInsForm").ajaxSubmit(options);
			}
			function submitBefore(formData, jqForm, options){
				return true;
			}
			function submitAfter(objResponse, statusText, xhr, $form){
				if (statusText == "success"){
					if (objResponse == 1){
						alert("입력에 성공 했습니다.");			
						window.opener.location.reload();
						window.self.close();
					}
				}else{
					alert("입력에 실패했습니다.\n잠시 후, 다시 시도 해주세요.");
				}
			}
		});
		
	</script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
</head>
<body>
	<!-- header --><!--2016.01.14.rjh.수정.교체.-->
	<div id="headerpop">
		<div class="inner clear_v2">
			<h1>
				<img src="./resources/wm_img/common/logo.gif" height="39" alt="top - TRUST OBLIGATION PASSION" />
			</h1>
			<div style="text-align:center;padding-top:10px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
				<font color="white"><b><span style="font-size:11pt;"> 품의서 입력</span></b></font>
			</div>
		</div>
	</div>
	<!-- //header -->
	<div style="margin:10px 5px 0px 5px;">

		<form id="myDocInsForm" name="myDocInsForm" method="post" action="myDocInsert" enctype="multipart/form-data">
			<input type="hidden" name="user_no" id="user_no" value="${user_no}" />
			

			<div class="tableStyle4"><!--tableStyle4-->

				<table align="center" cellpadding="0" cellspacing="0" width="400">
                <tr>
                    <td width="18%" height="15" bgcolor="#EDEDED" >
                        <p align="center">분 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;류</p>
                    </td>
                    <td width="78%" height="15" >
						<p>
							<select id="doc_type" name="doc_type">
								<c:forEach items="${docClass}" var="docType">
									<option value="${docType.col_cd}">${docType.col_val}</option>	
								</c:forEach>
  							</select>
						</p>
                    </td>
                </tr>
                
                <tr>
                    <td width="18%" height="15" bgcolor="#EDEDED" >
                        <p align="center">제 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</p>
                    </td>
                    <td width="78%" height="15" >
						<p><input type="text" id = "doc_title" name="doc_title" size="10" style="width:300px;" value=""></p>
                    </td>
                </tr>
                
                <tr>
                    <td width="18%" height="15" bgcolor="#EDEDED" >
                        <p align="center">첨 부 파 일</p>
                    </td>
                    <td width="78%" height="15" >
						<p>
							<input type="file" id="file" name="file" />
<%-- 							<%@include file="../include/uploadform_myDoc.jsp"%> --%>
						</p>
                    </td>
                </tr>
                
			</table>
			</div><!--//tableStyle4-->
		<p>&nbsp;</p>
		
		<p align="center"><img id = "myDocInsBtn" style="cursor:pointer;" src="./resources/ls_img/btn_write_ok.gif" /></p>
		
		</form>
	</div>

	<p>&nbsp;</p>
</body>