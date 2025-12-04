<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link href="./resources/select2/select2.min.css" rel="stylesheet" />
<script src="./resources/select2/select2.min.js"></script>
<script>
$(document).ready(function(){		
	//doSearchProcessList();
	$("#srchLectureType").select2();
	$("#srchPgubun").select2();	
	
	//엔터키 눌렀을때 검색
	$("#srchPtitle").keydown(function(key){
		if( key.keyCode == 13 ){
			doSearchProcessList();
		}			
	});
});

function doDownProcessList(){	
	$("#exelLectureType").val($("#srchLectureType").val());
	$("#exelPgubun").val($("#srchPgubun").val());
	$("#exelPtitle").val($("#srchPtitle").val());
	$("#exel_pro_show_date").val($("#search_pro_show_date").val());	
	$("#processExcelDown").submit();
}

function doSearchProcessList(){
	
	var param = {};
	param.srchLectureType = $("#srchLectureType").val();
	param.srchPgubun = $("#srchPgubun").val();
	param.srchPtitle = $("#srchPtitle").val();	
	param.srchShowProDate = $("#search_pro_show_date").val();		//기준일자
	
	var sUrl = "./getLectureStatisticsProcess";			//과정별 교육 통계 가져오기
	
	$.ajax({
		type: "POST",
		url: sUrl,
		data: param,
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		dataType: "html",
		timeout: 20000,
		success: function(data){
			$("#lectureStatisticsProcessList").html(data);    			
		},            		
		error: function (request, status, error) {
			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		}            		
	});
}

function goProcessDetail( p_pkey, p_flag ){	
	
	var url = "./lectureProcessStatisticsModal"
	
	var param = {};
	param.pkey  = p_pkey;
	param.type_flag = p_flag;
	param.srchProShowDate = $("#search_pro_show_date").val();	
	
	//모달창 불러오기
	$.ajax({
        type: "POST",
        url: url,
        data: param,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        timeout: 20000,
        dataType: "HTML", 
        success: function(data){
        	$("#process-detail-dialog").html();
        	$("#process-detail-dialog").html(data);
			$("#process-detail-dialog").dialog({
				height: 850,
				width: 1024,
				closeOnEscape : true,
				draggable : true,
				title: "교육과정별 통계 상세보기",
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
<!-- 검색창 시작 -->
<div class="tableStyle2">															
	<table>
		<tr>
			<th width="8%">교육구분</th>
			<td width="12%">
				<select id="srchLectureType" name="srchLectureType" style="width: 140px;">
					<option value="9">전체</option>
					<option value="1">의무교육</option>
					<option value="0">상시교육</option>
				</select>
			</td>
			<th width="8%">구분</th>
			<td width="12%">
				<select id="srchPgubun" name="srchPgubun" style="width:140px;">
					<option value="5">전체</option>
					<option value="1">물보험본부</option>
					<option value="4">인보험본부</option>
				</select>				
			</td>
			<th width="8%" title="기준일자가 교육기간 내 포함된 경우조회 / 미입력시 전체조회">기준일자</th>
			<td width="12%" title="기준일자가 교육기간 내 포함된 경우조회 / 미입력시 전체조회">
				<input type="text" class="calendar" id="search_pro_show_date" name="search_pro_show_date" style="width:80px;"/>				
			</td>
			<th width="8%">과정명</th>
			<td width="22%">
				<input type="text" id="srchPtitle" name="srchPtitle" value="${srchParam.srchPtitle}" style="width:250px;"/>
			</td>
			<td width="10%">
				<a href="#noloc" class="btn-vacation-aprv" id="btn-search" onclick='javascript:doSearchProcessList();'>검색</a>
			</td>
		</tr>
	</table>
</div>
<!-- 검색창 끝 -->
<!-- 엑셀 다운로드 시작-->
<div style="text-align:right;padding:5px 5px 5px 0;"><img src="/resources/ls_img/ls_invoice/btn_excel.gif" style="cursor:pointer;" onclick="javascript:doDownProcessList();"></img></div>
<!-- 엑셀 다운로드 끝-->
<!-- 교육과정 통계 조회 시작 -->
<div class="tableStyle99">															
	<table>
		<tr>
			<th width="5%">No</th>
			<th width="8%">교육구분</th>
			<th width="8%">구분</th>
			<th width="21%">과정명</th>
			<th width="15%">신청기간</th>
			<th width="15%">교육기간</th>
			<th width="7%" title="교육 신청인원 중 결재완료가 된 인원수">신청인원</th>
			<th width="7%" title="교육진도율이 99%미만 인원수">교육중</th>
			<th width="7%" title="교육진도율이 99%이상 인원수">교육완료</th>
			<th width="7%" title="교육신청인원 대비 완료인원 비율">완료율</th>						
		</tr>
	</table>
	<div id="lectureStatisticsProcessList"></div>
</div>	
<!-- 교육과정 통계 조회 끝 -->
<!-- 교육과정별 통계 Modal -->
<div id="process-detail-dialog" title="교육과정별 통계 상세보기" style="font-size: 12px;" align="center"></div>
<!-- 개인별 통계 엑셀다운로드 폼 -->
<form id="processExcelDown" name="processExcelDown" method="post" action="getLectureStatisticsProcessExcel">
	<input type="hidden" id="exelLectureType" name="exelLectureType">
	<input type="hidden" id="exelPgubun" name="exelPgubun">
	<input type="hidden" id="exelPtitle" name="exelPtitle">
	<input type="hidden" id="exel_pro_show_date" name="exel_pro_show_date">
</form>