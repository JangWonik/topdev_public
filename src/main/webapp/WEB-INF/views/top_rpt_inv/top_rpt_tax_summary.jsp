<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link href="./resources/select2/select2.min.css" rel="stylesheet" />
<script src="./resources/select2/select2.min.js"></script>
	<style>
		.search-td {
			padding-left:20px;
			text-align: left;
		}
		
		.invoiceResultTable tr td{
			letter-spacing: 0px;
			text-overflow : ellipsis;
			overflow : hidden;
			white-space : nowrap;
			word-wrap:normal;
		}
		
		.td-overflow-none{

		}
	</style>
	<script>
		$(document).ready(function(){
			if('${mbrAuthVo_Session.user_no}' == null || '${mbrAuthVo_Session.mbr_pms_7}' == 0){
				window.location.assign("./logout");
			}
		});//ready

		$(document).ready(function(){
			
			_initMask();
			
			//보험사별 계산서 합계
			$("#summaryBtn").click(function(){
				
				var summary_date_from_val = $("#summary_date_from").val();
				var summary_date_to_val = $("#summary_date_to").val();
				
				if( summary_date_from_val == '' ){
					alert("계산서 발행 검색 시작일을 입력해주세요.");
					$("#summary_date_from").focus();
					return;
				}
				
				if( summary_date_to_val == '' ){
					alert("계산서 발행 검색 종료일을 입력해주세요.");
					$("#summary_date_to").focus();
					return;
				}
				
				var param = {};
				param.summary_date_from = summary_date_from_val;
				param.summary_date_to = summary_date_to_val;
				
				$.ajax({
					type : "post",			
					url : "topRptTaxSummaryAjax",
					data : param,
					success : function(result){				
						$("#ptnrSummaryListDiv").html(result);
					},
					error: function (request, status, error) {			
						console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
					}
				});
			});
			
			
			//검색결과 다운로드
			$("#summaryDownBtn").click(function(){
				
				var summary_date_from_val = $("#summary_date_from").val();
				var summary_date_to_val = $("#summary_date_to").val();
				
				if( summary_date_from_val == '' ){
					alert("계산서 발행 검색 시작일을 입력해주세요.");
					$("#summary_date_from").focus();
					return;
				}
				
				if( summary_date_to_val == '' ){
					alert("계산서 발행 검색 종료일을 입력해주세요.");
					$("#summary_date_to").focus();
					return;
				}
				
				$("#summarySearchForm").submit();
				
			});
			

		});//$(document).ready

	    /* mask 처리 */
	    function _initMask(){
	        var options = {
	            onKeyPress : function(cep, event, currentField, options){
	                var tid = event.currentTarget.id;
	                var tidx = tid.substr(tid.length - 1, 1);	                
	            },
	            reverse : true
	        };

	        $('input.money').mask('#,###,###',options);
	        $('div.money').mask('999,999,999',{reverse:true});
	    }
	</script>

	<!-- 검색 조건 테이블 -->
	<form id="summarySearchForm" name="summarySearchForm" method="post" action="topRptTaxSummaryExcel">
	<div class= "tableStyle21" style="width: 100%;text-align: center; margin: 0 auto;" align="center">		
		<table>				
			<tr>
				<th width="10%">계산서 발행일</th>
				<td class="search-td">
					<input	type="text" class="classCalendar" id="summary_date_from" name="summary_date_from"
							value='<c:out value="${searchVO.summary_date_from}" />' size="10" maxlength="10" />
					~ &nbsp;<input	type="text" class="classCalendar" id="summary_date_to" name="summary_date_to"
							value='<c:out value="${searchVO.summary_date_to}" />' size="10" maxlength="10" />&nbsp;&nbsp;								
					<input title="보험사별 합계계산" class="buttonAssistanceEmail" style="width:140px;" type="button" value="보험사별 합계계산" id="summaryBtn">&nbsp;
					<input title="검색결과 다운로드" class="buttonAssistance" style="width:140px;" type="button" value="검색결과 다운로드" id="summaryDownBtn">
				</td>																	
			</tr>				
		</table>				
	</div><!-- //tableStyle21 -->
	</form>
	
	<!-- //검색 조건 테이블 -->
	<br />
	<!-- 검색 결과 테이블 -->
	<div class= "tableStyle2">
		<table class="invoiceResultTable">				
			<tr>
				<th style="width:4%">no</th>
				<th style="width:24%">보험사명</th>
				<th style="width:24%">계산서 합계</th>
				<th style="width:24%">입금액 합계</th>
				<th style="width:24%">미수금액 합계</th>						
			</tr>
		</table>
	</div>
	<div id="ptnrSummaryListDiv"></div>				