<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script> 
	<script src="./resources/ne_js/jquery.form.js"></script>
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>
	<script>
		$(document).ready(function(){			
			
			//보험사 자동완성
			$("#igId").select2();
			//처리팀 자동완성
			$("#topTeamIdForSuit").select2();			
			//처리담당자 자동완성
			$("#topMbrForSuit").select2();
			
			/* 처리팀 지정 */
			$("#topTeamIdForSuit").change(function(){ 

				var team_id = $("#topTeamIdForSuit option:selected").val().split("+")[0];
				
				$.post("topMbrForSelectedTeam",
							{	
								team_id : team_id
							},
							function(data,status){

								if(status == "success"){
									$("#topMbrForSuit").empty();
									if(data.length == 0){
										
										$("#topMbrForSuit").append(
											"<option value='0'>"
												+"직원 없음"
											+"</option>"
										);
										
									}else{
										$("#topMbrForSuit").append(
		                    				
			                    			"<option value = '0'>담당자 미지정</option>"
			   						);
										
					                    $.each(data, function(index, entry) {
					                    	
					                    		$("#topMbrForSuit").append(
					                    				
					                    				"<option value = '"+entry.user_no+"'>"
														
														+entry.user_name
														
				                                		+ "</option>"
					   							);
					                    		
										});//each										
									}
								}else{
									alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
								}
							},"json"
					);//post
							
			}); //처리팀 지정
			
			/* 전문파일 입력 동작 */
			$("#attchFileForSuit").change(function (){
				/* 흥국 선택 시 */
				/*
				if($("#igId option:selected").val() == 17){
					if($("#attchFileForSuit").val().split(".")[1] == "xlsx" || $("#attchFileForSuit").val().split(".")[1] == "XLSX"){
						alert(".xls 파일만 입력 가능합니다.");
						return;
					}					
				}
				*/
				
				$("#SuitInsOkMsg").hide();
				$("#SuitInsBtn").show();
				
			}); //전문파일 입력 동작
			

			/* 적부 데이터 등록 시작 */
			$("#SuitInsBtn").click(function(){
				if($("#attchFileForSuit").val() != '' || $("#igId").val() == 18 ){
					if(confirm("불러온 파일을 적부 등록 하시겠습니까?")){
						//if($("#igId").val() != 17){ // 흥국은 조사자 정보가 파일에 담겨옮
	
							if($("#topTeamIdForSuit").val() == 0){
								alert("처리팀을 선택 하세요.(권역 제외)");
								$("#topTeamIdForSuit").focus();
								return;
							}
							
							if($("#topMbrForSuit").val() == 0){
								alert("처리 담당자를 선택 하세요.");
								$("#topMbrForSuit").focus();
								return;
							}
						//}
						
						if($("#igId").val() == 17) {
							if($("#attchFileForSuit").val().split(".")[1] != 'txt'){
								alert("흥국 적부용 파일은 .txt 형식 입니다.");
								return;
							}
						}else if($("#igId").val() == 12) {
							if($("#attchFileForSuit").val().split(".")[1] != 'dat'){
								alert("한화 적부용 파일은 .dat 형식 입니다.");
								return;
							}
						}else if($("#igId").val() == 10) {
							if($("#attchFileForSuit").val().split(".")[1] != 'txt'){
								alert("KB 적부용 파일은 .txt 형식 입니다.");
								return;
							}
						}
						
						/* 입력 동작 시작 */
// 						/* 적부 데이터 등록 시작 Form submit*/
// 						$("#readSuit").ajaxForm({
// 							  /* "dataType" : "json", */
// 							  dataType : 'text',
// 							  "success"  : function(data,status) {
// 							  	if(status == "success"){
// 									if(data == 0){
// 										alert("권역 선택 에러입니다.");
// 									}else if(data == 1){
// 										alert("입력 완료!");
										
// 										$("#SuitInsOkMsg").show();
// 										$("#SuitInsBtn").hide();
// 								    }else if(data == 3){
// 										alert("입력 권한이 없습니다.");
										
// 								    }
// 							  	}
// 							}
// 						});
						$("#readSuit").submit();
						
					}else{
						return;
					}					
				}else{
					alert("전문 파일을 입력하세요.");
					
				}
				
			});

			$("#igId").change(function(){
				
				//if($("#igId").val() == 17){
				//	$("#topMbrForSuitTr").hide();
				//	$("#topTeamForSuitTr").hide();
				//}else{
				//	$("#topMbrForSuitTr").show();
				//	$("#topTeamForSuitTr").show();
				//}
				
				if($("#igId").val() == 18){
					$("#attchFileForSuit").hide();
					$("#samsunFileList").show();
					/* ftp 폴더 접근 후 파일 목록 존재 여부 확인해서 반환 */
					$.post("getSamsungFtpFileCount",
							{
								downFlag : 0
							},
							function(data,status){
	
								if(status == "success"){
									if(data.length == 0){
										
										$("#ssFtpMsg").html("");
										$("#ssFtpMsg").append(
											"<font color='blue'> 수임 등록 할 삼성 적부파일이 없습니다. </font>"		
										);
										
										$("#SuitInsBtn").hide();
									}else{
										
										$("#ssFtpMsg").html("");
										$("#ssFtpMsg").append(
										 	"<font color='red'> 수임 등록 할 삼성 적부파일이 존재합니다. </font>"		
										);
										
										$("#SuitInsBtn").show();
					                    $("#samsunFileList").html("");
										$.each(data, function(index, entry) {
					                    	
					                    	$("#samsunFileList").append(
					                    		entry.file +"</br>"
					                    	);
										}); 										
									}
									
									if(data == 'fail'){
										alert("FTP 시스템을 확인해 주세요.");
									}
									
								}else{
									alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
								}
							},"json" 
					);//post					
				}else{
					$("#ssFtpMsg").html("");
					$("#attchFileForSuit").show();
					$("#samsunFileList").hide();
				}
				
				$("#SuitInsOkMsg").hide();
				$("#SuitInsBtn").show();
				
			});
			
			
		}); //ready
		
		/* 적부 데이터 등록 시작 Form submit*/
		$("#readSuit").ajaxForm({
			  /* "dataType" : "json", */
			  dataType : 'text',
			  "success"  : function(data,status) {
			  	if(status == "success"){
					if(data == 0){
						alert("권역 선택 에러입니다.");
					}else if(data == 1){
						alert("입력 완료!");
						
						$("#SuitInsOkMsg").show();
						$("#SuitInsBtn").hide();
				    }else if(data == 3){
						alert("입력 권한이 없습니다.");
						
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
		<form name="readSuit" id="readSuit" method="POST" action="readSuit" enctype="multipart/form-data">
		<input type="hidden" name ="actionFlagForSuit" id= "actionFlagForSuit" />
			<table align="center" style = "margin-top:10px;" >

                <colgroup>
                    <col width="30%">
                    <col width="70%">
                </colgroup>
				<tbody >
					<tr>
						<td class="head">보험사</td>
						<td >
							<select name="igId" id="igId" style="width:200px;">
								<option value="10">KB손해</option>
								<option value="18">삼성화재</option>
								<option value="12">한화손해</option>
								<option value="17">흥국화재</option>
							</select>
							<span id = "ssFtpMsg"></span>
						</td>
					</tr>
					<tr id = "topTeamForSuitTr">
						<td class="head">처리팀</td>
						<td >
							<select id="topTeamIdForSuit" name = "topTeamIdForSuit" style="width:200px;">
								<option value="0" selected>담당부서 미지정</option>
								<c:forEach items="${topTeamList}" var = "topTeamVo">
									<option value="${topTeamVo.team_id}">
									<c:if test="${topTeamVo.team_level eq 1}">&nbsp;&nbsp;└</c:if>
									<c:if test="${topTeamVo.team_level eq 2}">&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
									${topTeamVo.team_name}
									</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr id = "topMbrForSuitTr">
						<td class="head">처리담당자</td>
						<td >
							<select id="topMbrForSuit" name="topMbrForSuit" style="width:200px;">
								<option value="0">담당부서 미지정</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="head">전문파일</td>
						<td>
							<input type="file" name="attchFileForSuit" id="attchFileForSuit"/>
							<span id ="samsunFileList"></span>
						</td>
					</tr>
					<tr>
						<td colspan="13" style="border:0px;" >
							<p>&nbsp;</p>
							<p align="center">
								<img id = "SuitInsBtn" src="./resources/ls_img/icon_write.gif" border="0" style="cursor:pointer;">
								<span id = "SuitInsOkMsg" style="display:none;">등록 완료하였습니다.</span>
							</p>
						</td>
					</tr>
				</tbody>
			</table>
			<input style ="display:none; visibility:hidden;" type="submit" id ="goSuitIns" class="btn" />
		</form>
	</div>
	<p>&nbsp;</p>
</body>

</html>
