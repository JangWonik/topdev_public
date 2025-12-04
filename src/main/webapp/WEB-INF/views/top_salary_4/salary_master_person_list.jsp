<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
<script src="./resources/ne_js/calendar.js?v=20170321111520"></script><!-- calendar -->
<script src="./resources/ne_js/ne_number.js"></script>
<script src="./resources/ne_js/jquery.printElement.js"></script><!-- id print -->
<script src="./resources/ne_js/jquery.mb.browser.min.js"></script><!-- id print -->
<style>
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
			color:#696969  !important;
			width:50px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #CEE3F6;
		}
		
		.btn-vacation-detail {
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
			color:#696969  !important;
			width:60px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #CEE3F6;
		}

		.btn-vacation-aprv:active {
			position:relative;
			top:4px
		}
		
		/* 모달 버튼 */
		.ui-button-text-only {
			height:2.1em !important;
		}
		
		.buttonMini{
			width:40px;
			height:20px;
		    background-color:#CEE3F6;
		    color:#666;
		    text-align: center;
			border-radius:5px;
		    font-size: 10px;
		    cursor: pointer;
		    text-decoration:none;
		    border: solid 1px grey;		    
		}
</style>
<script>
	$(document).ready(function () {
		
		$("#srchTeamId").select2();
		$("#srchInsuId").select2();
		$("#srchUserState").select2();
				
		//폼에서 엔터 입력시 검색버튼 클릭
		$("form input").keydown(function(e) {
			if( e.keyCode == 13 ){
				doMasterSearch();
			}
		});		
		
		doMasterSearch();		
	});
	
	function doMasterSearch(){
		var formData = $("#searchMasterFrm").serialize();
		
		$.ajax({
			type : "post",			
			url : "salaryMasterListAjax",
			data : formData,
			success : function(result){
				$("#salaryMemberList").html(result);	 				
			},
			error: function (request, status, error) {			
				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
			}
		});
	}
	
	function doMasterMemberDetail( p_user_no ){
		
		var url = "./salaryMasterDetailModal";
		var param = {};
		param.user_no = p_user_no;
		param.sales_date = $("#sales_date").val();		
		param.base_sdate = $("#base_sdate").val();
		param.base_edate = $("#base_edate").val();
		param.chk_sdate = $("#chk_sdate").val();
		param.chk_edate = $("#chk_edate").val();
		
		$.ajax({
			type: "POST",
			url: url,
			data: param,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			timeout: 20000,
			dataType: "HTML", 
			success: function(data){
				$("#salary-master-detail-dialog").html();
				$("#salary-master-detail-dialog").html(data);
					$("#salary-master-detail-dialog").dialog({						
						height: 880,
						width: 780,
						closeOnEscape : true,
						draggable : true,
						title: "급여통합조회 상세보기",
						modal: true,
						buttons:{
							"인쇄하기" : function(){
								fnModalPrint();		//기본급확정								
							},
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
	
	function fnModalPrint(){
		$("#salary-master-detail-dialog").printElement({
			printMode: 'popup',
			overrideElementCSS: ['http://www.toplac.co.kr/resources/wm_css/style.css']
		});
	}
	
	//엑셀 다운
	function doExcelDown(){		
		
		$("#searchMasterFrm").attr("action","salaryMasterListExcel").submit();		
		
	}
</script>
<!-- 검색창 추가시 사용 -->
<form id="searchMasterFrm" name="searchMasterFrm" method="post">
<div class="tableStyle99">
	<table>
		<tr>
			<th width="6%">기본급 정산기간</th>
			<td width="11%" style="text-align:left;padding-left:10px;">
				<input type="text" id="base_sdate" name="base_sdate" value="${srchParam.base_sdate}" style="width:80px;text-align:center;" readonly/> ~
				<input type="text" id="base_edate" name="base_edate" value="${srchParam.base_edate}" style="width:80px;text-align:center;" readonly/>
			</td>
			<th width="6%">성과급 정산기간</th>
			<td width="11%" style="text-align:left;padding-left:10px;">
				<input type="text" id="chk_sdate" name="chk_sdate" value="${srchParam.chk_sdate}" style="width:80px;text-align:center;" readonly/> ~
				<input type="text" id="chk_edate" name="chk_edate" value="${srchParam.chk_edate}" style="width:80px;text-align:center;" readonly/>
			</td>
			<th width="4%">정산일자</th>
			<td width="6%" style="text-align:left;padding-left:10px;">
				<input type="text" id="sales_date" name="sales_date" value="${srchParam.sales_date}" style="width:80px;text-align:center;" readonly/>				
			</td>			
			<th width="4%">부서</th>
			<td width="11%" style="text-align:left;padding-left:10px;">
				<span style="text-align: left !important;">
					<select id="srchTeamId" name="srchTeamId" style="width: 180px;">
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
			<th width="4%">보험사</th>
			<td width="10%" style="text-align:left;padding-left:10px;">
				<span style="text-align: left !important;">
					<select id="srchInsuId" name="srchInsuId" style="width: 160px;">
						<option value="0">- 전체 -</option>
						<c:forEach items="${selInsuList}" var="insuVo">
							<c:choose>
								<c:when test="${srchInsuId == insuVo.ikey}">
									<option value="${insuVo.ikey}" selected="selected">
								</c:when>
								<c:otherwise>
									<option value="${insuVo.ikey}">
								</c:otherwise>
							</c:choose>
							${insuVo.insu_name}
						</c:forEach>
					</select>
				</span>
			</td>
			<th width="4%">이름</th>
			<td width="7%" style="text-align:left;padding-left:10px;">
				<input type="text" style="width: 100px;" id="srchUserName" name="srchUserName" value="${srchParam.srchUserName }"/>	
			</td>
			<th width="4%">재직상태</th>
			<td width="6%" style="text-align:left;padding-left:10px;">
				<select id="srchUserState" name="srchUserState" style="width: 80px;">																											
					<option value="99" <c:if test="${srchParam.srchUserState eq '99'}">selected</c:if> >- 전체 -</option>
					<option value="0" <c:if test="${srchParam.srchUserState eq '0'}">selected</c:if>>근무자</option>
					<option value="2" <c:if test="${srchParam.srchUserState eq '2'}">selected</c:if>>대기자</option>
					<option value="1"<c:if test="${srchParam.srchUserState eq '1'}">selected</c:if>>퇴사자</option>
					<option value="9" <c:if test="${srchParam.srchUserState eq '9'}">selected</c:if>>SA</option>													
				</select>													
			</td>			
			<td width="6%" align="center">
				<a href="#noloc" class="btn-vacation-aprv" id="btn-search" onclick='doMasterSearch();'>검 색</a>&nbsp;				
			</td>
		</tr>		
	</table>
</div>
<div style="text-align:right;padding:5px 0 5px 0;">
	<img id="exceldown" src="/resources/ls_img/btn_excel.gif" alt="엑셀다운로드" onclick="javascript:doExcelDown();" style="cursor:pointer;"/>
</div>	
</form>
<div class="tableStyle99">
	<table>
		<tr>
			<th width="4%">No</th>
			<th width="10%">팀명</th>
			<th width="7%">보험사</th>
			<th width="7%">직무</th>
			<th width="7%">이름</th>
			<th width="6%">입사일자</th>
			<th width="6%">경력일수</th>
			<th width="4%">손감</th>			
			<th width="4%">민원</th>
			<th width="6%">기준 매출액</th>
			<th width="6%">직원 매출액</th>
			<th width="4%">기본급<br/>정산구분</th>
			<th width="6%">기본급 합계</th>
			<th width="4%">성과급<br/>정산구분</th>
			<th width="6%">성과급 합계</th>			
			<th width="7%">급여 합계</th>
			<th width="6%"> - </th>
		</tr>		
	</table>
	<div id="salaryMemberList"></div>
</div>
<div id="salary-master-detail-dialog" title="급여통합조회 상세보기" style="font-size: 12px;" align="center"></div>	
<!-- 기본급 설정 분류 끝 -->