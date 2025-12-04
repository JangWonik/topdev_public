<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>		
<script>
$(document).ready(function(){
	//검색 버튼 클릭시 조회
	//doSearchType();
	
	//검색 셀렉트 박스 셋팅
	$("#srchConType").select2();
	$("#srchTeamType").select2();
	$("#srchConArea").select2();	
	$("#srchConState").select2();
	
	$("#searchBtn").click(function(){
		doSearchMain(1);
	});
	
	//엔터키 눌렀을때 검색
	$("#srch_t_subject").keydown(function(key){
		if( key.keyCode == 13 ){
			$("#searchBtn").click();
		}			
	});
});

//계약서 다운로드
function fnFileDown( p_tkey ){
	$('#filedownForm [name="fkey"]').val(p_tkey);
	$('#filedownForm').submit();
}

//검색 대상 목록 페이징
function fnGoPageList( pageIdx ){
	doSearchMain(pageIdx);
}

//엑셀 다운
function doSearchExcel(){	
	$("#exelConType").val($("#srchConType").val());
	$("#exelTeamType").val($("#srchTeamType").val());
	$("#exelConArea").val($("#srchConArea").val());
	$("#exelConState").val($("#srchConState").val());
	$("#exelTSubject").val($("#srch_t_subject").val());
	$("#contractExcelDown").submit();
}

//검색
function doSearchMain( pageIdx ){
	var param = {};
	
	param.srchConType = $("#srchConType").val();
	param.srchTeamType = $("#srchTeamType").val();
	param.srchConArea = $("#srchConArea").val();
	param.srchConState = $("#srchConState").val();
	param.srchTSubject = $("#srch_t_subject").val();	
	
	param.pageIdx = pageIdx;						//페이징
	
	var sUrl = "./getContractMainList";			//계약서 목록 가져오기
	
	$.ajax({
		type: "POST",
		url: sUrl,
		data: param,
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		dataType: "html",
		timeout: 20000,
		success: function(data){			
			$("#contractMainList").html(data);			
		},            		
		error: function (request, status, error) {
			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		}            		
	});
}

</script>
<style>
	/*저장 버튼*/
		.btn-contract-save {			
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
			color:#FFFFFF  !important;
			width:90px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #013469;
		}
		
		.buttonAssistanceSearch{
			font-weight:bold;
			width:110px;
			height:30px;
		    background-color:darkCyan;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		    }
		    
		.buttonMiniEdit{
			width:40px;
			height:20px;
		    background-color:#F7F7F7;
		    color:#666;
		    text-align: center;
			border-radius:5px;
		    font-size: 11px;
		    cursor: pointer;
		    text-decoration:none;
		    border: solid 1px grey;		    
		}
		.buttonMiniDel{
			width:40px;
			height:20px;
		    background-color:#F6CECE;
		    color:#666;
		    text-align: center;
			border-radius:5px;
		    font-size: 11px;
		    cursor: pointer;
		    text-decoration:none;
		    border: solid 1px grey;		    
		}
</style>
<!-- 계약서 검색 창 시작 -->
<div class="tableStyle99">
	<table>
		<tr>
			<th width="7%">계약서 종류</th>
			<td width="15%" align="center">
				<select id="srchConType" name="srchConType" style="width:170px;text-align:left;">
					<option value="0"> - 전체 - </option>			
					<c:forEach items="${srchConTypeList}" var="item" >
						<option value="${item.ckey}">${item.code_name}</option>									
					</c:forEach>										
				</select>
			</td>
			<th width="7%">본부구분</th>
			<td width="8%" align="center">
				<select id="srchTeamType" name="srchTeamType" style="width:80px;text-align:center">
					<option value="9"> - 전체 - </option>
					<option value="0">공통</option>
					<c:choose>								
						<c:when test="${sContractAuth eq 1}">
							<option value="1">1종</option>
						</c:when>
						<c:when test="${sContractAuth eq 4}">
							<option value="4">4종</option>
						</c:when>
						<c:otherwise>
							<option value="1">1종</option>
							<option value="4">4종</option>
						</c:otherwise>
					</c:choose>			
				</select>
			</td>
			<th width="7%">지점구분</th>
			<td width="12%" align="center">
				<select id="srchConArea" name="srchConArea" style="width:130px;text-align:left;">
					<option value="0"> - 선택 - </option>			
					<c:forEach items="${srchConAreaList}" var="item" >
						<option value="${item.ckey}">${item.code_name}</option>									
					</c:forEach>
				</select>
			</td>
			<th width="7%">계약상태</th>
			<td width="8%" align="center">
				<select id="srchConState" name="srchConState" style="width:80px;text-align:center">
					<option value="0">전체</option>
					<option value="1">기간중</option>
					<option value="2">기간만료</option>
				</select>
			</td>
			<th width="7%">계약명</th>
			<td width="12%" align="center">
				<input type="text" id="srch_t_subject" name="srch_t_subject" maxlength="50" style="width:140px;text-align:left;">
			</td>
			<td width="10%" align="center">
				<input title="검색" class="buttonAssistanceSearch" id="searchBtn" type="button" value="검 색">
			</td>
		</tr>		
	</table>
</div>
<!-- 계약서 검색 창 끝 -->
<!-- 계약서 시작 -->
<div style="text-align:right;padding:7px 0 5px 7px;float:left;">
	<img src="/resources/ls_img/ls_invoice/btn_excel.gif" style="cursor:pointer;" onclick="javascript:doSearchExcel();"></img>
</div>
<div id="addMainButton" style="text-align:right;padding:5px 7px 5px 0;float:right;">
	<a href="#noloc" class="btn-contract-save" id="btn-search" onclick='javascript:fnContractIns();'>계약서 등록</a>
</div>
<div class="tableStyle99">															
	<table>
		<tr>
			<th width="5%">No</th>
			<th width="12%">계약서 종류</th>
			<th width="15%">계약명</th>
			<th width="10%">계약자명</th>
			<th width="7%">계약시기</th>
			<th width="7%">계약종기</th>			
			<th width="10%">지점구분</th>
			<th width="7%">등록일</th>
			<th width="8%">등록자</th>
			<th width="11%">비고</th>
			<th width="2%" title="첨부파일 다운로드"><img src="./resources/ls_img/icon_disket.gif"></th>
			<th width="8%">-</th>
		</tr>		
	</table>
	<div id="contractMainList"></div>
</div>
<!-- 계약서 끝 -->
<!-- 계약정보 Action Modal 시작 -->
<c:import url="/contract_main_modal"></c:import>
<!-- 계약정보 Action Modal 끝 -->
<!-- 계약서 첨부파일 다운로드 폼 시작 -->
<form id="filedownForm" name="filedownForm" action="contractFiledown">
	<!-- <input type="hidden" id="tkey" name="tkey"/> -->
	<input type="hidden" id="fkey" name="fkey"/>
</form>
<!-- 계약서 첨부파일 다운로드 폼 끝 -->
<!-- 개인별 통계 엑셀다운로드 폼 -->
<form id="contractExcelDown" name="contractExcelDown" method="post" action="getContractSearchListExcel">
	<input type="hidden" id="exelConType" name="exelConType">
	<input type="hidden" id="exelTeamType" name="exelTeamType">
	<input type="hidden" id="exelConArea" name="exelConArea">	
	<input type="hidden" id="exelConState" name="exelConState">
	<input type="hidden" id="exelTSubject" name="exelTSubject">
</form>