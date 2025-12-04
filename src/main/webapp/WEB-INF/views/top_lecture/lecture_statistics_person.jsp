<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link href="./resources/select2/select2.min.css" rel="stylesheet" />
<script src="./resources/select2/select2.min.js"></script>
<script src="./resources/ne_js/calendar.js"></script>
<script src="./resources/jquery/jquery.mask.min.js"></script>
<script>
$(document).ready(function(){
	//검색 누르면 나오도록 수정 by top3009
	//doSearchPersonList();
	$("#srchGubun").select2();
	$("#srchTeamId").select2();
	$("#srchUserName").focus();
	
	//엔터키 눌렀을때 검색
	$("#srchUserName").keydown(function(key){
		if( key.keyCode == 13 ){
			doSearchPersonList();
		}			
	});
	
	_initCalendar();
	_initMask();
});

/**
 * 엑셀다운로드
 */
function doDownPersonList(){
	
	$("#exelGubun").val($("#srchGubun").val());
	$("#exelTeamId").val($("#srchTeamId").val());
	$("#exelUserName").val($("#srchUserName").val());
	$("#exelShowDate").val($("#search_show_date").val());	
	$("#personExcelDown").submit();
	
}

function doSearchPersonList(){
	
	var param = {};
	param.srchGubun = $("#srchGubun").val();
	param.srchTeamId = $("#srchTeamId").val();
	param.srchUserName = $("#srchUserName").val();
	param.srchShowDate = $("#search_show_date").val();	
	
	var sUrl = "./getLectureStatisticsPerson";			//개인별 교육 통계 가져오기
	
	$.ajax({
		type: "POST",
		url: sUrl,
		data: param,
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		dataType: "html",
		timeout: 20000,
		success: function(data){    			
			$("#lectureStatisticsPersonList").html(data);    			
		},            		
		error: function (request, status, error) {
			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		}            		
	});
}

function _initCalendar(){    	 
	$('.calendar').datepicker({
		showOn: 'button',
		buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		buttonImageOnly: true,
		buttonText: "달력", 
		changeMonth: true,
		changeYear: true,	    	   
		showButtonPanel: false,
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		dateFormat: 'yy-mm-dd',
		firstDay: 0,
		isRTL: false,
		showMonthAfterYear: true
    });  		
}

/* mask 처리 */
function _initMask(){
    var options = {
        onKeyPress : function(cep, event, currentField, options){
            var tid = event.currentTarget.id;
            var tidx = tid.substr(tid.length - 1, 1);            
        },
        reverse : true
    };
    
    $('input.calendar').mask('0000-00-00',options);    

}


function goPersonDetail( p_user_no, p_flag ){
	
	//alert( p_user_no+ " : " +p_flag );
	
	//var url = "./lectureShowUserModal";
	var url = "./lecturePersonStatisticsModal";
	
	var param = {};
	param.user_no  = p_user_no;
	param.type_flag = p_flag;
	param.srchShowDate = $("#search_show_date").val();	
	
	//모달창 불러오기
	$.ajax({
        type: "POST",
        url: url,
        data: param,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        timeout: 20000,
        dataType: "HTML", 
        success: function(data){
        	$("#person-detail-dialog").html();
        	$("#person-detail-dialog").html(data);
			$("#person-detail-dialog").dialog({
				height: 600,
				width: 1024,
				closeOnEscape : true,
				draggable : true,
				title: "개인별 통계 상세보기",
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
			<th width="8%">구분</th>
			<td width="12%">
				<select id="srchGubun" name="srchGubun" style="width:140px;">
					<option value="5">전체</option>
					<option value="1">물보험본부</option>
					<option value="4">인보험본부</option>
				</select>				
			</td>
			<th width="8%">부서</th>
			<td width="15%">
				<select id="srchTeamId" name="srchTeamId" style="width: 180px;">
					<option value="0">- 전체 -</option>
					<c:forEach items="${teamList}" var="teamVo">
						<c:choose>
							<c:when test="${srchParam.srchTeamId == teamVo.team_id}">
								<option value="${teamVo.team_id}" selected="selected">
							</c:when>
							<c:otherwise>
								<option value="${teamVo.team_id}">
							</c:otherwise>
						</c:choose>																
							<c:if test="${teamVo.team_level == 1}">&nbsp;└</c:if>
							<c:if test="${teamVo.team_level == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
							${teamVo.team_name}																
					</c:forEach>
				</select>
			</td>
			<th width="8%" title="기준일자가 교육기간 내 포함된 경우조회 / 미입력시 전체조회">기준일자</th>
			<td width="13%" title="기준일자가 교육기간 내 포함된 경우조회 / 미입력시 전체조회">
				<input type="text" class="calendar" id="search_show_date" name="search_show_date" style="width:90px;"/>				
			</td>
			<th width="8%">이름</th>
			<td width="10%">
				<input type="text" id="srchUserName" name="srchUserName" value="${srchParam.srchUserName}" style="width:120px;"/>
			</td>
			<td width="10%">
				<a href="#noloc" class="btn-vacation-aprv" id="btn-search" onclick='javascript:doSearchPersonList();'>검색</a>
			</td>
		</tr>
	</table>
</div>
<!-- 검색창 끝 -->
<!-- 엑셀 다운로드 시작-->
<div style="text-align:right;padding:5px 5px 5px 0;"><img src="/resources/ls_img/ls_invoice/btn_excel.gif" style="cursor:pointer;" onclick="javascript:doDownPersonList();"></img></div>
<!-- 엑셀 다운로드 끝-->
<!-- 개인별 통계조회 시작 -->
<div class="tableStyle99">															
	<table>
		<tr>
			<th width="10%">No</th>
			<th width="17%">센터명</th>
			<th width="17%">부서명</th>
			<th width="16%">이름</th>
			<th width="10%">신청중</th>
			<th width="10%">교육중</th>
			<th width="10%">교육완료</th>
			<th width="10%">완료율</th>						
		</tr>
	</table>
	<div id="lectureStatisticsPersonList"></div>	
</div>
<!-- 개인별 통계조회 끝 -->
<!-- 개인별 통계 Modal -->
<div id="person-detail-dialog" title="개인별 통계 상세보기" style="font-size: 12px;" align="center"></div>
<!-- 개인별 통계 엑셀다운로드 폼 -->
<form id="personExcelDown" name="personExcelDown" method="post" action="getLectureStatisticsPersonExcel">
	<input type="hidden" id="exelGubun" name="exelGubun">
	<input type="hidden" id="exelTeamId" name="exelTeamId">
	<input type="hidden" id="exelUserName" name="exelUserName">
	<input type="hidden" id="exelShowDate" name="exelShowDate">
</form>