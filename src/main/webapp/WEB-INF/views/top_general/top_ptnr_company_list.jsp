<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<script src="./resources/daum/postcode.v2.js"></script>
<script src='https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js'></script>	
	<style>
		.tableStyle2 td{
			letter-spacing : 0px;
		}
		
		.td-overflow-none{
			text-overflow : ellipsis;
			overflow : hidden;
			white-space : nowrap;
			word-wrap:normal;
		}
		
		.btn-vacation-aprv {
			font-weight:bold;
			text-decoration:none;
			font-family:Arial;
			text-indent:0px;
			line-height:0px;
			-moz-border-radius:5px;
			-webkit-border-radius:5px;
			border-radius:5px;
			text-align:center;
			vertical-align:middle;
			display:inline-block;
			font-size:12px;
			color:#ffffff  !important;
			width:60px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #2E7EE8;			
		}
		
		.buttonMini{
			width:40px;
			height:20px;
		    background-color:#CEE3F6;
		    color:#666;
		    text-align: center;
			border-radius:5px;
		    font-size: 11px;
		    font-weight: bold;
		    cursor: pointer;
		    text-decoration:none;
		    border: solid 0px grey;		    
		}

		.btn-vacation-aprv:active {
			position:relative;
			top:4px
		}
		
		.buttonMiniView{
			width:100px;
			height:20px;
		    background-color:#F7F7F7;
		    color:#666;
		    text-align: center;
			border-radius:5px;
		    font-size: 12px;
		    cursor: pointer;
		    text-decoration:none;
		    border: solid 1px grey;		    
		}
		
		/* 모달 버튼 */
		.ui-button-text-only {
			height:2.1em !important;
		}
	</style>
	<script>
		function enterKeyCompany(){
			if(event.keyCode == 13){				
				doCompanySearch();
			}
		}
		
		function fnGoSearchCompanyPage(pageIdx) {			
		    $("#pageIdxCompanySearch").val(pageIdx);
		    doCompanySearch();
		}
	
		function doCompanySearch(){
			
			var formData = $("#searchCompanyFrm").serialize();
			$.ajax({
				type : "post",				
				url : "topPtnrCompanyListAjax",
				data : formData,
				success : function(result){					
					$("#ptnrCompanyList").html(result);				
				},
				error: function (request, status, error) {			
					console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
				}
			});
		}
		
		//회사 세부정보 보기
		function openCompanyDetailView( p_ptnr_id ){			
			
			var sUrl = "ptnrCompanyDetailModal";
			
			var param = {};
			param.ptnr_id = p_ptnr_id;			
			
			$.ajax({
				type: "POST",
				url: sUrl,
				data: param,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				timeout: 20000,
				dataType: "HTML", 
				success: function(data){
					$("#ptnr-company-detail-dialog").html();
					$("#ptnr-company-detail-dialog").html(data);
						$("#ptnr-company-detail-dialog").dialog({
							height: 350,
							width: 800,
							closeOnEscape : true,
							draggable : true,
							title: "관련업체 회사정보",							
							modal: true,
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
		}
		
		//보험사 문서서식 모달창
		function openTemplateView( p_ptnr_id ){
			
			var sUrl = "ptnrTemplateDetailModal";
			
			var param = {};
			param.ptnr_id = p_ptnr_id;			
			
			$.ajax({
				type: "POST",
				url: sUrl,
				data: param,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				timeout: 20000,
				dataType: "HTML", 
				success: function(data){					
					$("#template-action-dialog").html();
					$("#template-action-dialog").html(data);					
						$("#template-action-dialog").dialog({
							height: 450,
							width: 800,
							closeOnEscape : true,
							draggable : true,
							title: "관련업체 문서서식",							
							modal: true,
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
		}
		
		//서식다운로드
		function fnTemplateDown(p_tkey){			
			$('#filedownForm [name="tkey"]').val(p_tkey);
			$('#filedownForm').submit();			
		}
		
		//보험사 공지사항
		function doShowInsuNoti( p_type, p_id ){			
			
			var url = "./suimPtnrNoticePopAjax";
			
			var param = {};
			param.type = p_type;
			param.id = p_id;
			
			$.ajax({
				type: "POST",
				url: url,
				data: param,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				timeout: 20000,
				dataType: "HTML", 
				success: function(data){			
					$("#popup-insu-notice").html();
					$("#popup-insu-notice").html(data);					
						$("#popup-insu-notice").dialog({
							height: 700,
							width: 600,
							closeOnEscape : true,
							draggable : true,
							title: "보험사공지사항",					
							modal: true,												
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
			
		}
	</script>				
		<div class= "tableStyle2" style="border-top: 0px;">
			<!-- search-box -->
			<form id="searchCompanyFrm" name="searchCompanyFrm" method="POST">				
				<input type="hidden" id="pageIdxCompanySearch" name="pageIdxCompanySearch" />									
				<div id="search-box"  align="center" style="padding-bottom:5px;">
					<table style="width: 100%;">											
						<tr>
							<th width="10%">회사구분</th>
							<td width="20%">
								<select id="srchPtnrType" name="srchPtnrType" style="width:90%;">
									<option value="0" selected>전체</option>
									<option value="1">손해보험</option>
									<option value="2">생명보험</option>
									<option value="3">협회</option>
									<option value="4">공제</option>
									<option value="5">기타</option>
								</select>													
							</td>
							<th width="10%">회사명</th>
							<td width="20%">
								<input type="text" name="srchPtnrName" id="srchPtnrName" value="${paramMap.srchPtnrName}" style="width:90%;" onkeypress="JavaScript:enterKeyCompany();"/>											
							</td>
							<th width="10%">고객센터</th>
							<td width="20%">
								<input type="text" name="srchPtnrTel" id="srchPtnrTel" value="${paramMap.srchPtnrTel}"  style="width:90%;" onkeypress="JavaScript:enterKeyCompany();"/>												
							</td>
							<td width="10%">								
								<a href="#noloc" class="btn-vacation-aprv" id="approval-all-btn-search" onclick="javascript:doCompanySearch();">검 색</a>
							</td>												
						</tr>
					</table>					
				</div> 
			</form>															
			<table>
					<tr>											
						<th width="5%">No.</th>
						<th width="9%">회사구분</th>
						<th width="10%">로고</th>
						<th width="20%">회사명</th>
						<th width="10%">고객센터</th>
						<th width="9%">공지사항</th>
						<th width="9%">문서서식</th>
						<th width="9%">PRM</th>
						<th width="9%">홈페이지</th>
						<th width="10%">-</th>											
					</tr>
			</table>
			<div id="ptnrCompanyList"></div>
		</div>
		<div id="ptnr-company-detail-dialog" title="상세 보기" style="font-size: 15px;display:none;" align="center"></div>
		<div id="template-action-dialog" title="상세 보기" style="font-size: 15px;display:none;" align="center"></div>
		<div id="popup-insu-notice" title="보험사 공지사항" style="font-size: 15px;display:none;" align="center"></div>		
		<form id="filedownForm" name="filedownForm" action="insuTemplateFiledown">
			<input type="hidden" id="tkey" name="tkey"/>
		</form>