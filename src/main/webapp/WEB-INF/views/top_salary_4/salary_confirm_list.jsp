<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
<script src="./resources/ne_js/calendar.js?v=20170321111520"></script><!-- calendar -->
<script src="./resources/ne_js/ne_number.js"></script>

<script>
	$(document).ready(function () {
		$("#srchConfirmTeamId").select2();
		$("#srchPayFlag").select2();
		
		//폼에서 엔터 입력시 검색버튼 클릭
		$("form input").keydown(function(e) {
			if( e.keyCode == 13 ){
				doConfirmSearch();
			}
		});
		
		//페이지 로딩 후 검색
		doConfirmSearch();	
	});
	
	function doConfirmSearch(){
		
		var formData = $("#searchConfirmFrm").serialize();
		
		$.ajax({
			type : "post",
			url : "salaryConfirmListAjax",
			data : formData,
			success : function(result){
				$("#salaryConfirmList").html(result);	 				
			},
			error: function (request, status, error) {			
				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
			}
		});
	}
	
	//기본급 확정 취소
	function doBaseConfirmCancel( p_bkey, p_user_name, p_sales_date ){
		
		var msg = p_user_name + "님의 기본급 (정산일자 : "+p_sales_date+")을 확정 취소하시겠습니까?";
		
		if( !confirm(msg) ){
			return;
		}
		
		var sUrl = "confirmSalary4BasePayCancel";
		
		var param = {};
		param.bkey = p_bkey;
		
		$.ajax({
	        type: "POST",
	        url: sUrl,
	        data: param,		         
	        dataType: "JSON", 
	        success: function(data){
	        	alert("확정정보를 취소(삭제) 하였습니다.");
	        	doConfirmSearch();
	        	doSearch();
	        },	        
	        error: function(e){
	            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
	        }
	        
		});
		
	}
	
</script>

<!-- 기본급 확정 검색창 -->
<form id=searchConfirmFrm name="searchConfirmFrm" method="post">
<div class="tableStyle99">
	<table>											
		<tr>			
			<th width="7%">
				기준일자
			</th>
			<td align="center" width="15%">
				<input type="text" id="base_sdate_confirm" name="base_sdate_confirm" value="${srchParam.base_sdate}" readonly style="width:70px;"/> ~ 
				<input type="text" id="base_edate_confirm" name="base_edate_confirm" value="${srchParam.base_edate}" readonly style="width:70px;"/>				
			</td>
			<th width="7%">부서</th>
			<td width="17%" style="text-align:left;padding-left:10px;">
				<span style="text-align: left !important;">
					<select id="srchConfirmTeamId" name="srchConfirmTeamId" style="width: 195px;">
						<option value="0">- 전체 -</option>
						<c:forEach items="${teamList}" var="teamVo">
							<c:choose>
								<c:when test="${srchTeamId == teamVo.team_id}">
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
				</span>
			</td>
			<th width="7%">이름</th>
			<td width="15%" style="text-align:left;padding-left:10px;">
				<input type="text" style="width: 160px;" id="srchConfirmUserName" name="srchConfirmUserName" value="${srchParam.srchUserName }"/>	
			</td>
			<th width="7%">정산방식</th>
			<td width="12%" style="text-align:left;padding-left:10px;">
				<select id="srchPayFlag" name="srchPayFlag" style="width: 130px;">
					<option value="9" <c:if test="${srchParam.srchPayFlag eq '0'}">selected</c:if>>- 전체 -</option>
					<option value="0" <c:if test="${srchParam.srchPayFlag eq '1'}">selected</c:if>>월급제</option>
					<option value="1"<c:if test="${srchParam.srchPayFlag eq '2'}">selected</c:if>>연봉제</option>																		
				</select>													
			</td>
			<td align="center" width="13%">
				<a href="#noloc" class="btn-vacation-aprv" id="btn-search" onclick='doConfirmSearch();'>검색</a>&nbsp;				
			</td>
		</tr>
	</table>
</div>	
</form>
<br/>
<div class="tableStyle99">
	<table>
		<tr>
			<th width="4%">No</th>			
			<th width="11%">팀명</th>
			<th width="5%">직급</th>
			<th width="11%">이름</th>			
			<th width="7%">입사일자</th>			
			<th width="6%">방식</th>
			<th width="8%">기본급</th>
			<th width="8%">근속수당</th>
			<th width="8%">팀장수당</th>
			<th width="9%">합계</th>
			<th width="7%">작업일자</th>
			<th width="8%">작업자</th>
			<th width="8%">-</th>
		</tr>
	</table>
	<div id="salaryConfirmList"></div>
</div>	
<div id="confirm-detail-dialog" title="기본급 확정내역 상세 보기" style="font-size: 15px;display:none;" align="center"></div>
<!-- 기본급 확정목록 끝 -->