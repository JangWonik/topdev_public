<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css?v=20170411111520" />
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/><!-- calendar -->
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/><!-- calendar -->
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/><!-- calendar -->    
    <script src="./resources/ne_js/calendar.js?v=20170321111520"></script>
    <style>
    	.tableModal td {border:1px solid #e5e5e5;  border-bottom:1px solid #cfcfcf; color:#666; font-size:12px; font-weight:normal;line-height:20px;padding:4px 0 4px 0; letter-spacing:-1px;}
    </style>
    
	<script>
	$(document).ready(function(){			
		
		$("#uploadFile").click(function(){
			
			var income_file = $('#attchFileForIncome')[0].files[0];					//첨부파일 추가
			
			var param = new FormData();
			param.append("incomeFile",income_file);						//파일추가
			
			//var sUrl = "./incomeFileUpdate";
			var sUrl = "./incomeFilePrimBizUpdate";

			$.ajax({
				
				type: "POST",				
				url: sUrl,
				data: param,
				timeout: 20000,
				processData: false,
				contentType: false,
				cache: false,
				dataType: "JSON",
				success: function(data){
					var result = data.result;
					var work_no = data.work_no;
					if( result == "empty" ){
						alert("업로드 할 파일을 선택 해 주세요.");
						return;
					}else if( result == "9" ){
						alert("업로드 할 파일형식이 틀립니다. (.csv 파일)");
						return;
					}else if( result == "90" ){
						alert("파일을 읽는 중 오류가 발생하였습니다.");
						return;
					}else if( result == "Secure" ){
						alert("업로드 할 파일을 암호화 해제 후 업로드 해주세요.");
						return;
					}else{
						$("#work_no").val(work_no);
						alert(result);
						$("#logSearch").click();
						$("#logSearchBtn").click
					}
					
				}
				,error: function(e){
				    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
				}
			});			
			
		});
		
		$("#attchFileForIncome").change(function(){
			
			var income_file = $('#attchFileForIncome')[0].files[0];					//첨부파일 추가
			
			var param = new FormData();
			param.append("incomeFile",income_file);						//파일추가
			
			var sUrl = "./incomeFileListPrimBizView";

			$.ajax({
				
				type: "POST",				
				url: sUrl,
				data: param,
				timeout: 20000,
				processData: false,
				contentType: false,
				cache: false,
				dataType: "HTML",
				success: function(data){
					$("#loadFileList").html(data);					
				}
				,error: function(e){
				    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
				}
			});
			
			
		});
		
		
		//파일 등록로그 조회
		$("#logSearch").click(function(){
			
			var param = {};
			param.work_no = $("#work_no").val();			
			
			//var url = "incomeWorkLogView";
			var url = "incomeWorkLogPrimBizView";
			
			$.ajax({
				type: "POST",
				url: url,
				data: param,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				dataType: "html",				
				timeout: 20000,
				success: function(data){
					$("#income-detail-dialog").html();
					$("#income-detail-dialog").html(data);			
						$("#income-detail-dialog").dialog({
							height: 600,
							width: 1010,
							closeOnEscape : true,
							draggable : true,
							title: "농작물 입금일 파일등록 로그조회",					
							modal: true,
							position: { 'at' : 'center' },					
							buttons:{						
								"닫기" : function(){
									$(this).dialog("close");
								}
							},
							overlay:{ opacity: 0., background: '#000000'}
						});		
				},
				error: function(e){
				    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
				}
				
			});
			
		});
		
		
	});	
	
	</script>
	<div id="income-detail-dialog" title="농작물 입금일 파일등록" style="font-size: 12px;text-align:left;">
		<table class="tableModal">
			<tr>
				<td style="width:250px;text-align:center;">
					<a href="https://www.toplac.co.kr/resources/chart/income_prim_upload.csv">
						<input title="농작물 입금일 등록 예제파일" class="buttonAssistance" type="button" value="농작물 입금일 등록 예제파일 다운로드" style="width:230px;heigth:30px;">
					</a>			
				</td>
				<td style="text-align:left;padding-left:5px;">
					좌측 입금일 등록 예제파일을 다운로드 후 접수 번호와 등록 할 입금일을 입력 저장<br/> (CSV 형식 쉼표로 분리) 
				</td>
			</tr>			
		</table>
		<br/>
		<form id="incomeFileForm" name="incomeFileForm" method="post">
			<input type="hidden" id="work_no" name="work_no" />		
			<table class="tableModal">
				<tr>
					<td style="width:150px;text-align:center;background-color:#e7ecf1;height:30px;font-weight:bold;">
						파일 업로드							
					</td>
					<td style="text-align:left;padding-left:5px;">
						<input type="file" name="attchFileForIncome" id="attchFileForIncome" style="width:280px;"/>						
						<input title="파일등록" class="buttonAssistance" type="button" value="파일등록" style="width:80px;heigth:30px;" id="uploadFile">&nbsp;&nbsp;
						<input title="등록로그조회" class="buttonAssistance" type="button" value="등록로그조회" style="width:120px;heigth:30px;background-color:darkCyan;" id="logSearch">
					</td>
				</tr>	
				<tr>
					<td colspan="2" style="text-align:left;padding-left:5px;color:blue;font-weight:bold;">
						 &#8251; 업로드 할 파일은 .csv 형식으로 반드시 암호화 해제 후 업로드 해야 합니다.
					</td>					
				</tr>		
			</table>
		</form>
	</div>
	<div id="loadFileList"></div>	
	