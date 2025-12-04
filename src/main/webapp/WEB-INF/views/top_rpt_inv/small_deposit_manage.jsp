<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery.mask.min.js"></script>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar-rptinv.js"></script>
	<script src="./resources/cmm/js/common.js?v=201707311012"></script>
	
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>	
	<style type="text/css">
		.buttonAssistanceMember{
			width:100px;
			height:25px;
		    background-color:#2E7EE8;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		    font-weight:bold;
	    }
		
		/* 모달창 셀렉트 박스 */
		.select2-container--default{
			text-align : left;
			font-color:#444;
			font-size:12px;
		}
		
		.tableStyle2 td {letter-spacing: 0;}
	</style>
	<script>
		$(document).ready(function(){
			if('${mbrAuthVo_Session.user_no}' == null || '${mbrAuthVo_Session.mbr_pms_7}' == 0){
				window.location.assign("./logout");
			}
			
			//$('td.money').mask('#,##0',{reverse:true});
			_initMask();
			
			$("#ptnrSearch").select2();
			$("#inputPtnrSearch").select2();
		});//ready
		
		//숫자입력만 가능하도록 이벤트 추가 by top3009
		function showKeyCode(event) {
			event = event || window.event;
			var keyID = (event.which) ? event.which : event.keyCode;
			if( ( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 || keyID == 9 ) ){
				return;
			}else{
				return false;
			}
		}
		
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
		 
		function showAddForm(){
			$("#inputBox").show();
			$("#addButton").hide();
			$("#closeButton").show();
			$("#inputPtnrSearch").focus();
		}
		
		function showCloseForm(){
			$("#inputBox").hide();
			$("#addButton").show();
			$("#closeButton").hide();
			//폼초기화
			doAddFormClear();
		}
		
		function doAddData(){			
			//보험사 체크
			var inputPtnrSearchVal = $("#inputPtnrSearch").val();
			var inputIncomeAmountVal = removeMoneyComma($("#inputIncomeAmount").val());			//금액의 콤마제거
			var inputIncomeDateVal = $("#inputIncomeDate").val();
			var inputTaxAmountVal = removeMoneyComma($("#inputTaxAmount").val());
			var inputExtraMemoVal = $("#inputExtraMemo").val();
			
			if( inputPtnrSearchVal == 0 ){
				alert("보험사(거래처)를 선택해주세요.");
				$("#inputPtnrSearch").focus();
				return;
			}
			
			//입금금액 체크
			if( inputIncomeAmountVal == "" ){
				inputIncomeAmountVal = "0";	
			}
			
			//계산서금액 체크
			if( inputTaxAmountVal == "" ){
				inputTaxAmountVal = "0";
			}			
			
			//날짜 패턴 및 값 체크
			if( !datePatternChk(inputIncomeDateVal) ){
				alert("입금일자를 확인해주세요.");
				$("#inputIncomeDate").focus();
				return;
			}			
			
			var sUrl = "depositManageAction";
			
			var param = {};
			
			param.action = "I";								//추가
			param.ptnr_id = inputPtnrSearchVal;
			param.income_amount = inputIncomeAmountVal;
			param.income_date = inputIncomeDateVal;
			param.tax_amount = inputTaxAmountVal;
			param.extra_memo = inputExtraMemoVal;
			
			$.ajax({
		        type: "POST",
		        url: sUrl,
		        data: param,		         
		        dataType: "JSON",
		        cache:false,
		        success: function(data){
		        	if( data.msg == 'success' ){
		        		alert("입금데이터를 추가하였습니다.");
		        		//입력창 초기화
		        		doAddFormClear();
		        		//검색창 불러오기
		        		doDepositSearch();
		        	}else{
		        		alert("입금데이터 추가에 실패하였습니다.\nIT정보보호파트로 연락하세요.");
		        	}
		        }
			
			});
		}
		
		//엑셀다운
		function doExcelDown(){
			
			var msg = "검색 결과를 엑셀파일로 다운로드 하시겠습니까?";
			
			if( !confirm(msg) ){
				return
			}else{				
				$("#searchForm").attr("action","smallDepositManageExcel").submit();				
			}
			
		}
		
		//검색 목록 불러오기
		function doDepositSearch(){
			
			$("#top_loading").show();
			
			var formData = $("#searchForm").serialize();
			
			var url = "smallDepositManageAjax"; 
			
			$.ajax({
		        type: "POST",
		        url: url,
		        data: formData,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        dataType: "HTML", 
		        success: function(data){
		        	$("#depositListDiv").html(data);
		        	$("#top_loading").hide();
		        },
		        error: function(e){
		            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		        }
		    });
		}
		
		//보험사 이름 정렬
		function doOrderPtnrName( p_order ){			
			$("#ptnrOrder").val(p_order);
			doDepositSearch();
		}
		
		//입금금액 정렬
		function doOrderIncomeAmount( p_order ){
			$("#incomeAmountOrder").val(p_order);
			doDepositSearch();
		}
		
		//계산서금액 정렬
		function doOrderTaxAmount( p_order ){
			$("#taxAmountOrder").val(p_order);
			doDepositSearch();
		}
		
		//입금일자 정렬
		function doOrderIncomeDate( p_order ){
			$("#incomeDateOrder").val(p_order);
			doDepositSearch();
		}
		
		//등록일자 정렬
		function doOrderRegDate( p_order ){
			$("#regDateOrder").val(p_order);
			doDepositSearch();
		}
		
		//입력 폼 초기화 (보험사를 제외한 입력폼을 초기화한다.)
		function doAddFormClear(){
			$("#inputIncomeAmount").val('0');
			$("#inputIncomeDate").val('');
			$("#inputTaxAmount").val('0');
			$("#inputExtraMemo").val('');
			$("#inputPtnrSearch").focus();
		}
		
		//수정폼 열기
		function doDepositModify( p_dkey ){
			$("#view_"+p_dkey).hide();
			$("#edit_"+p_dkey).show();
			$("#editPtnrSearch_"+p_dkey).select2();
		}
		
		//수정폼 닫기
		function doDepositModifyCancel( p_dkey ){
			$("#view_"+p_dkey).show();
			$("#edit_"+p_dkey).hide();
		}
		
		//수정 저장
		function doDepositModifySave( p_dkey ){
			
			var editDkeyVal = p_dkey;
			var editPtnrSearchVal = $("#editPtnrSearch_"+p_dkey).val();
			var editIncomeAmountVal = removeMoneyComma($("#editIncomeAmount_"+p_dkey).val());			//금액의 콤마제거
			var editTaxAmountVal = removeMoneyComma($("#editTaxAmount_"+p_dkey).val());			//금액의 콤마제거
			var editIncomeDateVal = $("#editIncomeDate_"+p_dkey).val();
			var editExtraMemoVal = $("#editExtraMemo_"+p_dkey).val();			
			
			if( editPtnrSearchVal == 0 ){
				alert("보험사(거래처)를 선택해주세요.");
				$("#editPtnrSearch_"+p_dkey).focus();
				return;
			}
			
			//입금금액 체크
			if( editIncomeAmountVal == "" ){
				editIncomeAmountVal = "0";	
			}
			
			//계산서금액 체크
			if( editTaxAmountVal == "" ){
				editTaxAmountVal = "0";
			}
			
			//날짜 패턴 및 값 체크
			if( !datePatternChk(editIncomeDateVal) ){
				alert("입금일자를 확인해주세요.");
				$("#editIncomeDate_"+p_dkey).focus();
				return;
			}			
			
			var sUrl = "depositManageAction";
			
			var param = {};
			
			param.action = "U";								//수정
			param.dkey = editDkeyVal;
			param.ptnr_id = editPtnrSearchVal;
			param.income_amount = editIncomeAmountVal;
			param.tax_amount = editTaxAmountVal;
			param.income_date = editIncomeDateVal;
			param.extra_memo = editExtraMemoVal;
			
			$.ajax({
		        type: "POST",
		        url: sUrl,
		        data: param,		         
		        dataType: "JSON",
		        cache:false,
		        success: function(data){
		        	if( data.msg == 'success' ){
		        		alert("입금데이터를 수정 하였습니다.");
		        		//수정창 닫기
		        		doDepositModifyCancel(p_dkey);
		        		//검색창 불러오기
		        		doDepositSearch();
		        	}else{
		        		alert("입금데이터 수정에 실패하였습니다.\nIT정보보호파트로 연락하세요.");
		        	}
		        }
			
			});
		}
		
		function doDepositDelete( p_dkey, p_idx ){
			
			var msg = "No"+p_idx+" 를 삭제하시겠습니까?";
			
			if( !confirm(msg) ){		//삭제 취소
				return;				
			}else{
				
				var sUrl = "depositManageAction";
				
				var param = {};
				
				param.action = "D";								//삭제
				param.dkey = p_dkey;
				
				$.ajax({
			        type: "POST",
			        url: sUrl,
			        data: param,		         
			        dataType: "JSON",
			        cache:false,
			        success: function(data){
			        	if( data.msg == 'success' ){
			        		alert("입금데이터를 삭제 하였습니다.");			        		
			        		//검색창 불러오기
			        		doDepositSearch();
			        	}else{
			        		alert("입금데이터 삭제에 실패하였습니다.\nIT정보보호파트로 연락하세요.");
			        	}
			        }
				
				});
				
			}
		}
	</script>
</head>

<body>

<!-- wrapper -->
<div id="wrapper">
	<!-- skipnavi --><!-- header -->
	<c:import url="../top_main/top_main_menu.jsp"></c:import>
	<!-- //skipnavi --><!-- //header -->
	<!-- contents -->
	<div id="container">
		<div class="contetns" style="width:1315px;height:900px;">
			<!-- centercnt_top -->
			<div class="center_cnt_1300_ds">

				<!-- centercnt_bot -->
				<div class="centercnt_1300_bot1-2_ds" style="height:900px;">
					<div class="guest">

						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">소액입금관리</a></li>								
							</ul>
						</div>						
						<!-- 검색창 시작 -->						
						<form id="searchForm" name="searchForm" method="post">
						<input type="hidden" id="ptnrOrder" name="ptnrOrder"/>
						<input type="hidden" id="incomeAmountOrder" name="incomeAmountOrder"/>
						<input type="hidden" id="taxAmountOrder" name="taxAmountOrder"/>
						<input type="hidden" id="incomeDateOrder" name="incomeDateOrder"/>
						<input type="hidden" id="regDateOrder" name="regDateOrder"/>
						<div id="searchBox" style="overflow:hidden;padding:5px 0 5px 0;">
							<div class= "tableStyle2" style="border-top:0px;">
								<table>
									<tr>
										<th width="130px;">보험사(거래처)</th>
										<td width="200px;">
											<select id="ptnrSearch" name="ptnrSearch" style="width:190px;">
												<option value="0" selected>전체</option>
												<c:forEach items="${ptnrList}" var = "ptnrVo">
													<option value="${ptnrVo.ptnr_id}"
														<c:if test="${searchVO.ptnrSearch == ptnrVo.ptnr_id}">selected</c:if>
													>
														<c:if test="${ptnrVo.ptnr_level == 1}">&nbsp;└</c:if>
														${ptnrVo.ptnr_nick}
													</option>
												</c:forEach>
											</select>
										</td>
										<th width="100px;">
											입금일자
										</th>
										<td width="220px;">
											<input	type="text" class="classCalendar" id="s_income_date" name="s_income_date" size="10" maxlength="10" />
											~ &nbsp;<input	type="text" class="classCalendar" id="e_income_date" name="e_income_date" size="10" maxlength="10" />
										</td>
										<th width="100px;">
											비고검색
										</th>
										<td width="240px;">
											<input type="text" id="searchStr" name="searchStr" size="50" style="width:95%;"/>
										</td>
										<td>
											<input title="검색" class="buttonAssistanceMember" type="button" value="검  색" style="width:80px;" onclick="javascrip:doDepositSearch();">
											<input title="엑셀다운" id="excelButton" name="excelButton" class="buttonAssistanceMember" type="button" value="엑셀다운" style="width:80px;background:#00a000;" onclick="javascrip:doExcelDown();">
											<input title="추가" id="addButton" name="addButton" class="buttonAssistanceMember" type="button" value="추  가" style="width:80px;background:#FFA500;" onclick="javascrip:showAddForm();">											
											<input title="닫기" id="closeButton" name="closeButton" class="buttonAssistanceMember" type="button" value="닫  기" style="width:80px;background:#FF3333;display:none;" onclick="javascrip:showCloseForm();">
										</td>
									</tr>
								</table>
							</div>
						</div>
						</form>
						<!-- 검색창 끝 -->
						<!-- 데이터 등록 폼 시작-->						
						<div id="inputBox" style="overflow:hidden;padding:0 0 5px 0;display:none;">
						<form id="inputForm" name="inputForm">							
							<div class= "tableStyle2" style="border:1px solid #FFA500;">
								<table>
									<tr>
										<th style="width:130px;background:#F3E2A9;">보험사(거래처)</th>
										<td width="200px;">
											<select id="inputPtnrSearch" name="inputPtnrSearch" style="width:190px;" tabindex=0>
												<option value="0" selected>전체</option>
												<c:forEach items="${ptnrList}" var = "ptnrVo">
													<option value="${ptnrVo.ptnr_id}"
														<c:if test="${searchVO.ptnrSearch == ptnrVo.ptnr_id}">selected</c:if>
													>
														<c:if test="${ptnrVo.ptnr_level == 1}">&nbsp;└</c:if>
														${ptnrVo.ptnr_nick}
													</option>
												</c:forEach>
											</select>
										</td>
										<th style="width:80px;background:#F3E2A9;">입금금액</th>
										<td width="95px;">
											<input type="text" class="money" id="inputIncomeAmount" name="inputIncomeAmount" value="0" style="width:80px;text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)" tabindex=1/>											
										</td>
										<th style="width:80px;background:#F3E2A9;">계산서금액</th>
										<td width="95px;">
											<input type="text" class="money" id="inputTaxAmount" name="inputTaxAmount" value="0" style="width:80px;text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)" tabindex=2/>											
										</td>
										<th style="width:80px;background:#F3E2A9;">입금일자</th>
										<td width="100xp;">
											<input	type="text" class="classCalendar" id="inputIncomeDate" name="inputIncomeDate" size="10" maxlength="10" tabindex=3/>
										</td>										
										<th style="width:60px;background:#F3E2A9;">비고</th>											
										<td width="200px;">
											<input type="text" id="inputExtraMemo" name="inputExtraMemo" style="width:95%;" tabindex=4/>
										</td>
										<td>
											<input title="등  록" class="buttonAssistanceMember" type="button" value="등  록" style="width:120px;background:#FFA500;" onclick="javascrip:doAddData();" tabindex=5>
										</td>
									</tr>
								</table>
							</div>
						</form>							
						</div>						
						<!-- 데이터 등록 폼 끝-->
						<!-- 데이터 목록 시작 -->
						<div id="depositListDiv"></div>
						<!-- 데이터 목록 끝 -->
					</div>
				</div>
				<!-- //centercnt_bot -->
			</div>
			<!-- //center_cnt -->
		</div>
	</div>
	<!-- //contents -->	
</div>
<!-- //wrapper -->
</body>
</html>
