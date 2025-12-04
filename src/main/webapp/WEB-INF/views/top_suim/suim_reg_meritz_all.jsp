<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<!-- <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<%--<script src="./resources/daum/161109.js"></script>--%>
	<script src="./resources/daum/postcode.v2.js"></script>
	<script src='https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js'></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script> -->
	<script src="./resources/ne_js/jquery.form.js"></script>
	<script>
		$(document).ready(function(){

			$("#meritzInputFile").change(function (){
				if($("#meritzInputFile").val().split(".")[1] == "xlsx" || $("#meritzInputFile").val().split(".")[1] == "XLSX"){
					alert(".xls 파일만 입력 가능합니다.");
					return;
				}else{
					$("#actionFlag").val("print");
					$("#goMeritzIns").click();					
				}
			});
			
			$("#meritzInsBtn").click(function(){
				
				if($("#meritzInputFile").val() == ''){
					alert("파일을 불러온 후 수행해주세요.");
					return;
				}else{
					$("#actionFlag").val("insert");
					$("#goMeritzIns").click();
				}
			});
			
		}); //ready
		
		$("#readMeritz").ajaxForm({
			  "dataType" : "json",
			  "success"  : function(data,status) {
			  	if(status == "success"){
					
					if(data.length == 0){
						alert("시스템 오류입니다.");
					}else{
					
						if($("#actionFlag").val() == "insert"){
							 $.each(data, function(index, entry) {
								 
								if(entry.insOk != "yes"){
									alert(entry.data1+"번 건 입력 실패하였습니다.");
									
									$("#meritzStatus"+entry.data1).html("등록실패");
								}else{
									$("#meritzStatus"+entry.data1).html("완료");									
								} 
							 });
							 
							 
							 $("#meritzInsOkMsg").show();
							 $("#meritzInsBtn").hide();
							 
						}else{
							 $("#meritzFileInfo").html("");
							 $.each(data, function(index, entry) {
								 
								  $("#meritzFileInfo").append(
											 "<tr>"
											+	"<td class='td' align= 'center' nowrap>"+entry.data1+"</td>"
											+	"<td class='td' nowrap>"+entry.data2+"</td>"
											+	"<td class='td' nowrap>"+entry.data3+"</td>"
											+	"<td class='td' align= 'center'>"+entry.data4+"</td>"
											+	"<td class='td'>"+entry.data5+"</td>"
											+	"<td class='td' nowrap>"+entry.data6+"</td>"
											+	"<td class='td' nowrap align='center'>"+entry.data7+"</td>"
											+	"<td class='td' nowrap>"+entry.data8+"</td>"
											+	"<td class='td' nowrap>"+entry.data9+"</td>"
											+	"<td class='td' nowrap>"+entry.data10+"</td>"
											+	"<td class='td' nowrap>"+entry.data11+"</td>"
											+	"<td class='td' align= 'center' nowrap>"+entry.data12+"</td>"
											+	"<td class='td' align= 'center' id = 'meritzStatus"+entry.data1+"'nowrap>"+"대기"+"</td>"
											+"</tr>"
											  
									  );
							  }); //each
							  
							 $("#meritzInsOkMsg").hide();
							 $("#meritzInsBtn").show();
						}
				  }
			  }
			}
		});
	</script>
	<style>
		.head{ 
			width:15%;
			text-align:center;
			background-color:#EDEDED;
		}
		
	</style>
</head>

<body>
	<div class= "tableStyle6">
		<form name="readMeritz" id="readMeritz" method="POST" action="readXls" enctype="multipart/form-data">
		<input type="hidden" name ="actionFlag" id= "actionFlag" />

			<table align="center" style = "margin-top:10px;" >
				<tbody >
					<tr>
						<td class="head">알림</td>
						<td >
							<font color="red">.xls만 가능합니다.</font>
						</td>
					</tr>
					<tr>
						<td class="head">수임파일</td>
						<td >
							<input type="file" name = "attchFile" id="meritzInputFile"/>
						</td>
					</tr>
				</tbody>
			</table>
			<input style ="display:none; visibility:hidden;" type="submit" id ="goMeritzIns" class="btn" />
		</form>
	</div>
	<p>&nbsp;</p>
	<table class= "tableStyle6" align="center" cellpadding="0" cellspacing="0" width="100%" height="200">
	<%-- <input type="hidden" name="action" value="add">
	<input type="hidden" name="ig_id" value="16">
	<input type="hidden" name="report_type" value="1">
	<input type="hidden" name="price_a" value="1">
	<input type="hidden" name="tmp_file_url" value="<?=$tmp_file_url?>">
	<input type="hidden" name="accept_check" value="ok"> --%>
		<tr>
			<td colspan="13">
				※ 불러온 파일 정보
			</td>
		</tr>
		<tr align="center" bgcolor="#efefef">
			<td class="td" nowrap>순번</td>
			<td class="td" nowrap>사고번호</td>
			<td class="td" nowrap>증권번호</td>
			<td class="td" nowrap>계약자명</td>
			<td class="td" nowrap>피보험자</td>
			<td class="td" nowrap>수임일자</td>
			<td class="td" nowrap>추정<br>손해액</td>
			<td class="td" nowrap>처리팀</td>
			<td class="td" nowrap>처리자</td>
			<td class="td" nowrap>처리자id</td>
			<td class="td" nowrap>담당자</td>
			<td class="td" nowrap>수수료</td>
			<td class="td" nowrap>상태</td>
		</tr>
		<tbody id ="meritzFileInfo">
			
		</tbody>
		<tr>
			<td colspan="13" style="border:0px;" >
				<p>&nbsp;</p>
				<p align="center">
					<img id = "meritzInsBtn" src="./resources/ls_img/icon_write.gif" border="0" style="cursor:pointer;">
					<span id = "meritzInsOkMsg" style="display:none;">등록 완료하였습니다.</span>
				</p>
			</td>
		</tr>
	</table>
</body>

</html>
