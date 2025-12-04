<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
<script src="./resources/ne_js/calendar.js?v=20170321111520"></script><!-- calendar -->
<script src="./resources/ne_js/ne_number.js"></script>
<style>
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
</style>
<script>
	$(document).ready(function () {
		
		$("#srchTeamId").select2();
		$("#srchUserState").select2();
		
		//폼에서 엔터 입력시 검색버튼 클릭
		$("form input").keydown(function(e) {
			if( e.keyCode == 13 ){
				doSalesSearch();
			}
		});
		
		//페이지 로딩 후 검색
		doSalesSearch();
	});
	
	function doSalesSearch(){
		var formData = $("#searchSalesFrm").serialize();
		
		$.ajax({
			type : "post",			
			url : "salesMemberListAjax",
			data : formData,
			success : function(result){			
				//날짜수정 페이지를 가져온다.				
				$("#salesMemberList").html(result);	 				
			},
			error: function (request, status, error) {			
				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
			}
		});		
	}
	
	//실적수정폼 불러오기
	function doSalesMemberModify( p_user_no, p_pkey, p_skey ){		
		
		var sales_date_val = $("#sales_date").val();
		var chk_edate_val = $("#chk_edate").val();
		var user_no_val = p_user_no;
		var pkey_val = p_pkey;
		var skey_val = p_skey;
		
		var sUrl = "get_sales_member_info";
		
		var param = {};
		param.user_no = user_no_val;
		param.sales_date = sales_date_val;
		param.chk_edate = chk_edate_val;
		param.pkey = pkey_val;
		param.skey = skey_val;
		
		$.ajax({
			type: "POST",
			url: sUrl,
			data: param,		         
			dataType: "JSON", 
			success: function(data){	        		
				//alert(JSON.stringify(data));
				//console.log("data : "+data);
				
				$("#skey_val").val(data.skey);
				
				//입력폼에 기존값 불러오기 시작
				$("#self_option_pay").val(data.self_option_pay);
				$("#job_option_pay").val(data.job_option_pay);
				$("#etc1_option_pay").val(data.etc1_option_pay);
				$("#etc2_option_pay").val(data.etc2_option_pay);
				$("#etc_memo").val(data.etc_memo);
				$("#loss_rate").val(data.update_loss_rate);
				$("#minwon_cnt").val(data.minwon_cnt);
				$("#result_count").val(data.result_count);
				$("#result_sales").val(data.result_sales);
				$("#total_sales_amount_val").val('');			//수정시에도 합계값을 초기화한다.
				//입력폼에 기존값 불러오기 끝				
				
				$("#form_chk_sdate").text($("#chk_sdate").val());
				$("#form_chk_edate").text($("#chk_edate").val());
				$("#form_sales_date").text($("#sales_date").val());
				
				$("#cal_chk_sdate").val($("#chk_sdate").val());
				$("#cal_chk_edate").val($("#chk_edate").val());
				$("#cal_sales_date").val($("#sales_date").val());
				
				$("#user_no_val").val(data.user_no);
				$("#form_team_name").text(data.team_name);
				$("#form_user_name").text(data.user_name);
				
				$("#form_insu_name").text(data.salary_4_insu_nm);
				$("#form_part_name").text(data.salary_4_part_nm);
				
				if( data.insu_type == 1 ){				//건수 기준
					$("#form_insu_type").html("<font color='blue'>종결건</font>");
					$("#form_sector_interval_1").text(data.base_count+" ~ "+data.count_chk_point_1);
					$("#form_sector_interval_2").text(data.count_chk_point_1+" ~ "+data.count_chk_point_2);
					$("#form_sector_interval_3").text(data.count_chk_point_2+" ~ "+data.count_chk_point_3);
					$("#form_sector_interval_4").text(data.count_chk_point_3+" 초과");
					$("#form_input_title").html("<font color='blue'>종결건</font>");
					$("#form_result_sales").hide();
					$("#form_result_count").show();
					//구간계산값 셋팅
					$("#cal_sector_interval_1").val(data.count_chk_point_1);
					$("#cal_sector_interval_2").val(data.count_chk_point_2);
					$("#cal_sector_interval_3").val(data.count_chk_point_3);
				}else{											//매출액 기준
					$("#form_insu_type").html("<font color='green'>매출액</font>");
					$("#form_sector_interval_1").text(data.base_sales+" ~ "+data.sales_chk_point_1);
					$("#form_sector_interval_2").text(data.sales_chk_point_1+" ~ "+data.sales_chk_point_2);
					$("#form_sector_interval_3").text(data.sales_chk_point_2+" ~ "+data.sales_chk_point_3);
					$("#form_sector_interval_4").text(data.sales_chk_point_3+" 초과");
					$("#form_input_title").html("<font color='green'>매출액</font>");
					$("#form_result_count").hide();
					$("#form_result_sales").show();
					//구간계산값 셋팅
					$("#cal_sector_interval_1").val(data.sales_chk_point_1);
					$("#cal_sector_interval_2").val(data.sales_chk_point_2);
					$("#cal_sector_interval_3").val(data.sales_chk_point_3);
				}				
				
				$("#form_total_work_month").text(data.total_work_month_text);
				$("#form_loss_rate").text(data.loss_rate);
				$("#form_unit_sales").text( data.unit_sales );
				$("#form_base_count").text( data.base_count );
				$("#form_base_sales").text( data.base_sales );
				
				$("#form_sector_per_1").text(data.payout_rate_1+"%");
				$("#form_sector_per_2").text(data.payout_rate_2+"%");
				$("#form_sector_per_3").text(data.payout_rate_3+"%");
				$("#form_sector_per_4").text(data.payout_rate_4+"%");
				$("#form_fail_rate").text(data.fail_rate+"%");
				
				//계산을 위한 json 입력시작
				$("#cal_insu_type").val(data.insu_type);
				$("#cal_loss_rate").val(data.loss_rate);
				$("#cal_unit_sales").val(data.unit_sales);
				$("#cal_base_count").val(data.base_count);
				$("#cal_base_sales").val(data.base_sales);
				$("#cal_payout_rate_1").val(data.payout_rate_1);
				$("#cal_payout_rate_2").val(data.payout_rate_2);
				$("#cal_payout_rate_3").val(data.payout_rate_3);
				$("#cal_payout_rate_4").val(data.payout_rate_4);
				$("#cal_fail_rate").val(data.fail_rate);
				//계산을 위한 json 입력 끝
				
				//수정시에는 최초1회 자동계산한다.
				salesCalDo();
				
				$("#sales-action-dialog").dialog({
					height: 700,
					width: 800,
					closeOnEscape : true,
					draggable : true,
					appendTo : "#salesActionFrm",
					title: "성과급 실적 수정",
					buttons:{
						"실적수정" : function(){
							var action = fnSalesAction('U');		//수정
							if (action){
								$(this).dialog("close");
							}
						},
						"취소" : function(){
							$(this).dialog("close");
						}
					},
					modal: true,
					overlay:{ opacity: 0., background: '#000000'}
				});				
				
			},
			error: function(e){
			    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
			}
			
		});		
		
	}
	
	//실적등록폼 불러오기
	function doSalesMemberAdd( p_user_no, p_pkey ){
		
		var sales_date_val = $("#sales_date").val();
		var chk_edate_val = $("#chk_edate").val();
		var user_no_val = p_user_no;
		var pkey_val = p_pkey;		
		
		var sUrl = "get_sales_member_info";
		
		var param = {};
		param.user_no = user_no_val;
		param.sales_date = sales_date_val;
		param.chk_edate = chk_edate_val;
		param.pkey = pkey_val; 
		
		$.ajax({
			type: "POST",
			url: sUrl,
			data: param,		         
			dataType: "JSON", 
			success: function(data){	        		
				//alert(JSON.stringify(data));
				//console.log("data : "+data);
				
				//입력폼 초기화
				$("#self_option_pay").val(0);
				$("#job_option_pay").val(0);
				$("#etc1_option_pay").val(0);
				$("#etc2_option_pay").val(0);
				$("#etc_memo").val('');
				$("#loss_rate").val(0);
				$("#minwon_cnt").val(0);
				$("#result_count").val(0);
				$("#result_sales").val(0);
				$("#total_sales_amount_val").val('');
				$("#result_info_text_val").val('');
				$("#cal_result_sales").val(0);
				$("#tr_result_info_text").hide();
				//입력폼 초기화 끝				
				
				$("#form_chk_sdate").text($("#chk_sdate").val());
				$("#form_chk_edate").text($("#chk_edate").val());
				$("#form_sales_date").text($("#sales_date").val());
				
				$("#cal_chk_sdate").val($("#chk_sdate").val());
				$("#cal_chk_edate").val($("#chk_edate").val());
				$("#cal_sales_date").val($("#sales_date").val());
				
				$("#user_no_val").val(data.user_no);
				$("#form_team_name").text(data.team_name);
				$("#form_user_name").text(data.user_name);
				
				$("#form_insu_name").text(data.salary_4_insu_nm);
				$("#form_part_name").text(data.salary_4_part_nm);
				
				if( data.insu_type == 1 ){				//건수 기준
					$("#form_insu_type").html("<font color='blue'>종결건</font>");
					$("#form_sector_interval_1").text(data.base_count+" ~ "+data.count_chk_point_1);
					$("#form_sector_interval_2").text(data.count_chk_point_1+" ~ "+data.count_chk_point_2);
					$("#form_sector_interval_3").text(data.count_chk_point_2+" ~ "+data.count_chk_point_3);
					$("#form_sector_interval_4").text(data.count_chk_point_3+" 초과");
					$("#form_input_title").html("<font color='blue'>종결건</font>");
					$("#form_result_sales").hide();
					$("#form_result_count").show();
					//구간계산값 셋팅
					$("#cal_sector_interval_1").val(data.count_chk_point_1);
					$("#cal_sector_interval_2").val(data.count_chk_point_2);
					$("#cal_sector_interval_3").val(data.count_chk_point_3);
				}else{											//매출액 기준
					$("#form_insu_type").html("<font color='green'>매출액</font>");
					$("#form_sector_interval_1").text(data.base_sales+" ~ "+data.sales_chk_point_1);
					$("#form_sector_interval_2").text(data.sales_chk_point_1+" ~ "+data.sales_chk_point_2);
					$("#form_sector_interval_3").text(data.sales_chk_point_2+" ~ "+data.sales_chk_point_3);
					$("#form_sector_interval_4").text(data.sales_chk_point_3+" 초과");
					$("#form_input_title").html("<font color='green'>매출액</font>");
					$("#form_result_count").hide();
					$("#form_result_sales").show();
					//구간계산값 셋팅
					$("#cal_sector_interval_1").val(data.sales_chk_point_1);
					$("#cal_sector_interval_2").val(data.sales_chk_point_2);
					$("#cal_sector_interval_3").val(data.sales_chk_point_3);
				}				
				
				$("#form_total_work_month").text(data.total_work_month_text);
				$("#form_loss_rate").text(data.loss_rate);
				$("#form_unit_sales").text( data.unit_sales );
				$("#form_base_count").text( data.base_count );
				$("#form_base_sales").text( data.base_sales );
				
				$("#form_sector_per_1").text(data.payout_rate_1+"%");
				$("#form_sector_per_2").text(data.payout_rate_2+"%");
				$("#form_sector_per_3").text(data.payout_rate_3+"%");
				$("#form_sector_per_4").text(data.payout_rate_4+"%");
				$("#form_fail_rate").text(data.fail_rate+"%");
				
				//계산을 위한 json 입력시작
				$("#cal_insu_type").val(data.insu_type);
				$("#cal_loss_rate").val(data.loss_rate);
				$("#cal_unit_sales").val(data.unit_sales);
				$("#cal_base_count").val(data.base_count);
				$("#cal_base_sales").val(data.base_sales);
				$("#cal_payout_rate_1").val(data.payout_rate_1);
				$("#cal_payout_rate_2").val(data.payout_rate_2);
				$("#cal_payout_rate_3").val(data.payout_rate_3);
				$("#cal_payout_rate_4").val(data.payout_rate_4);
				$("#cal_fail_rate").val(data.fail_rate);
				//계산을 위한 json 입력 끝
				
				$("#sales-action-dialog").dialog({
					height: 700,
					width: 800,
					closeOnEscape : true,
					draggable : true,
					appendTo : "#salesActionFrm",
					title: "성과급 실적 등록",
					buttons:{
						"실적등록" : function(){
							var action = fnSalesAction('I');		//등록
							if (action){
								$(this).dialog("close");
							}
						},
						"취소" : function(){
							$(this).dialog("close");
						}
					},
					modal: true,
					overlay:{ opacity: 0., background: '#000000'}
				});				
				
			},
			error: function(e){
			    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
			}
			
		});
		
	}
	
	//실적등록
	function fnSalesAction( p_flag ){
		
		$("#action_flag").val(p_flag);
		
		var totalSalesAmountVal = $("#total_sales_amount_val").val();
		
		if( totalSalesAmountVal == '' ){
			alert('성과급 합계값 정보가 없습니다.\n계산하기를 눌러주세요.');
			return;
		}
		
		var sUrl = "confirmSalary4IncentivePay";
		
		var formData = $("#salesActionFrm").serialize();
		
		$.ajax({
			type : "post",
			url : sUrl,
			data : formData,
			dataType: "JSON",
			success : function(data){		
				if( data.result == "Insert" ){
					alert('실적을 등록하였습니다.');	
				}else if( data.result == "Update" ){
					alert('실적을 수정하였습니다.');
				}				
				$("#sales-action-dialog").dialog("close");
				doSalesSearch();
				doSalesResultSearch();
			},
			error: function (request, status, error) {			
				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
			}
		});
		
	}
	
	//성과급 계산하기
	function salesCalDo(){
				
		var formData = $("#salesActionFrm").serialize();
		
		$("#tr_result_info_text").hide();
		
		$.ajax({
			type : "post",
			url : "get_sales_calculation",
			data : formData,
			dataType: "JSON",
			success : function(data){
				//성과급 등록용 순수 구간성과급
				$("#cal_part_pay").val(data.part_pay);				
				$("#result_info_text").text(data.result_info_text);
				$("#result_info_text_val").val(data.result_info_text);
				$("#total_sales_amount").text(data.total_sales_amount);
				$("#total_sales_amount_val").val(data.total_sales_amount);
				
				//직원 발생매출액
				$("#cal_result_sales").val(data.cal_result_sales);
				
				$("#tr_result_info_text").show();				 				
			},
			error: function (request, status, error) {			
				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
			}
		});
	}
	
	//성과급 정보삭제
	function doSalesMemberDelete( p_user_no, p_user_name, p_skey){		
		
		var msg = p_user_name+"님의 성과급 정보를 삭제하시겠습니까?";
		
		if( !confirm(msg) ){
			return;
		}
		
		var param = {};
		param.action_flag = "D";
		param.skey_val = p_skey;		
		
		var sUrl = "confirmSalary4IncentivePay";
		
		$.ajax({
			type : "post",
			url : sUrl,
			data : param,
			dataType: "JSON",
			success : function(data){
				alert('삭제 하였습니다.');
				doSalesSearch();
				doSalesResultSearch();
			},
			error: function (request, status, error) {			
				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
			}
		});		
		
	}
	
</script>
<!-- 실적 등록 폼 시작 -->
<form id="salesActionFrm">	
	<input type="hidden" id="user_no_val" name="user_no_val"/>
	<input type="hidden" id="action_flag" name="action_flag"/>
	<input type="hidden" id="cal_chk_sdate" name="cal_chk_sdate"/>
	<input type="hidden" id="cal_chk_edate" name="cal_chk_edate"/>
	<input type="hidden" id="cal_sales_date" name="cal_sales_date"/>
	<input type="hidden" id="skey_val" name="skey_val"/>
	<input type="hidden" id="cal_insu_type" name="cal_insu_type"><!-- 성과급 기준 -->
	<input type="hidden" id="cal_loss_rate" name="cal_loss_rate"><!-- 기준손감율 -->
	<input type="hidden" id="cal_unit_sales" name="cal_unit_sales"><!-- 건당금액 -->
	<input type="hidden" id="cal_base_count" name="cal_base_count"><!-- 기본건수 -->
	<input type="hidden" id="cal_base_sales" name="cal_base_sales"><!-- 기본금액 -->
	<input type="hidden" id="cal_sector_interval_1" name="cal_sector_interval_1"><!-- 1~2구간 -->
	<input type="hidden" id="cal_sector_interval_2" name="cal_sector_interval_2"><!-- 2~3구간 -->
	<input type="hidden" id="cal_sector_interval_3" name="cal_sector_interval_3"><!-- 3~4구간 -->
	<input type="hidden" id="cal_payout_rate_1" name="cal_payout_rate_1"><!-- 1구간 퍼센트 -->
	<input type="hidden" id="cal_payout_rate_2" name="cal_payout_rate_2"><!-- 2구간 퍼센트 -->
	<input type="hidden" id="cal_payout_rate_3" name="cal_payout_rate_3"><!-- 3구간 퍼센트 -->
	<input type="hidden" id="cal_payout_rate_4" name="cal_payout_rate_4"><!-- 4구간 퍼센트 -->
	<input type="hidden" id="cal_fail_rate" name="cal_fail_rate"><!-- 민원발생 퍼센트 -->
	<input type="hidden" id="cal_part_pay" name="cal_part_pay"><!-- 순수 구간성과급 -->	
	<input type="hidden" id="total_sales_amount_val" name="total_sales_amount_val"><!-- 실적계산결과 합계 -->
	<input type="hidden" id="cal_result_sales" name="cal_result_sales"><!-- 직원발생 매출액 -->
	<input type="hidden" id="result_info_text_val" name="result_info_text_val"><!-- 계산근거(구간 또는 사유) -->
	
	<div id="sales-action-dialog" title="실적 등록" style="font-size: 15px;display:none;" align="center">		
		<div class="tableStyle2" style="width: 750px;">
			<table class="vacation-ins-table">
				<tr>
					<th width="25%">실적기준일자</th>
					<td width="25%"><span id="form_chk_sdate"></span> ~ <span id="form_chk_edate"></span></td>
					<th width="25%">정산일자</th>
					<td width="25%"><span id="form_sales_date"></span></td>
				</tr>				
				<tr>
					<th>팀명</th>
					<td><span id="form_team_name"></span></td>
					<th>이름</th>
					<td><span id="form_user_name"></span></td>
				</tr>
				<tr>
					<th>보험사명</th>
					<td><span id="form_insu_name"></span></td>
					<th>직무명</th>
					<td><span id="form_part_name"></span></td>
				</tr>
				<tr>					
					<th>성과급 기준</th>
					<td><span id="form_insu_type"></span></td>
					<th>경력(연차)</th>
					<td><span id="form_total_work_month"></span></td>
				</tr>
				<tr>					
					<th>기준손감율</th>
					<td><span id="form_loss_rate"></span></td>
					<th>건당금액</th>
					<td><span id="form_unit_sales"></span> 원</td>
				</tr>
				<tr>					
					<th>(최소)기본건수</th>
					<td><span id="form_base_count"></span> 건</td>
					<th>(최소)기본 매출액</th>
					<td><span id="form_base_sales"></span> 원</td>
				</tr>
				<tr>
					<td colspan="4" style="border:0px;"></td>
				</tr>
				<tr>
					<th colspan="4">구간별 지급율</th>
				</tr>
				<tr>
					<th>1구간 (<span id="form_sector_per_1"></span>)</th>
					<th>2구간 (<span id="form_sector_per_2"></span>)</th>
					<th>3구간 (<span id="form_sector_per_3"></span>)</th>
					<th>4구간 (<span id="form_sector_per_4"></span>)</th>
				</tr>
				<tr>
					<td align="center"><span id="form_sector_interval_1"></span></td>
					<td align="center"><span id="form_sector_interval_2"></span></td>
					<td align="center"><span id="form_sector_interval_3"></span></td>
					<td align="center"><span id="form_sector_interval_4"></span></td>
				</tr>
				<tr>
					<td colspan="4" style="text-align:left;padding-left:5px;">&#8251; 손감미만 또는 민원발생시 지급율 : <b><span id="form_fail_rate"></span></b></td>
				</tr>
				<tr>
					<td colspan="4" style="border:0px;"></td>
				</tr>
				<tr>
					<th>본인부담금 시상비</th>
					<th>직업변경 시상비</th>
					<th>기타1</th>
					<th>기타2</th>
				</tr>
				<tr>
					<td><input type="text" id="self_option_pay" name="self_option_pay" value="0" ONKEYUP="javascript:numberCommaFunc(this);" style="text-align:right;width:150px;IME-MODE: disabled;"> 원</td>
					<td><input type="text" id="job_option_pay" name="job_option_pay" value="0" ONKEYUP="javascript:numberCommaFunc(this);" style="text-align:right;width:150px;IME-MODE: disabled;"> 원</td>
					<td><input type="text" id="etc1_option_pay" name="etc1_option_pay" value="0" ONKEYUP="javascript:numberCommaFunc(this);" style="text-align:right;width:150px;IME-MODE: disabled;"> 원</td>
					<td><input type="text" id="etc2_option_pay" name="etc2_option_pay" value="0" ONKEYUP="javascript:numberCommaFunc(this);" style="text-align:right;width:150px;IME-MODE: disabled;"> 원</td>
				</tr>
				<tr>
					<th height="80">비 고</th>
					<td colspan="3" align="left" style="text-align:left;padding-left:10px;">
						<textarea rows="5" cols="81" id="etc_memo" name="etc_memo"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="4" style="border:0px;"></td>
				</tr>
				<tr>
					<th>손감율</th>
					<th>민원발생</th>
					<th><span id="form_input_title"></span></th>
					<th>-</th>
				</tr>
				<tr>
					<td><input type="text" id="loss_rate" name="loss_rate" value="0" style="width:50px;text-align:right;IME-MODE: disabled;"/> %</td>
					<td><input type="text" id="minwon_cnt" name="minwon_cnt" value="0" style="width:50px;text-align:right;IME-MODE: disabled;"/> 건</td>
					<td id="form_result_count" style="display:none;">
						<input type="text" id="result_count" name="result_count" value="0" ONKEYUP="javascript:numberCommaFunc(this);" style="text-align:right;width:150px;IME-MODE: disabled;"> 건
					</td>
					<td id="form_result_sales" style="display:none;">
						<input type="text" id="result_sales" name="result_sales" value="0" ONKEYUP="javascript:numberCommaFunc(this);" style="text-align:right;width:150px;IME-MODE: disabled;"> 원
					</td>
					<td>
						<a class="btn-equipment-save" id="btn-search" onclick="javascript:salesCalDo();" href="#noloc">계산하기</a>
					</td>
				</tr>
				<tr id="tr_result_info_text" style="display:none;">
					<th>처리구간</th>
					<td><span id="result_info_text"></span></td>
					<th>합계</th>
					<td><b><font color="blue"><span id="total_sales_amount"></span> 원</font></b></td>
				</tr>
				<tr>
					<td colspan="4" style="border:0px;"></td>
				</tr>
				<tr>
					<td colspan="4" style="border:0px;text-align:left;">
						<b>&#8251; 실적등록, 수정 시 <a class="btn-equipment-save" id="btn-search">계산하기</a> 버튼을 클릭해서 <font color="red">합계 값 계산 후</font> 실적등록, 수정을 클릭 해 주세요.</b>
					</td>
				</tr>
			</table>			
		</div>		
	</div>
</form>
<!-- 실적 등록 폼 끝 -->

<div style="text-align:left;padding: 0 0 10px 5px;">
	<img src="./resources/wm_img/common/dot_bg.png" /> <b>정산일자 : <span id="sales_date_text">${srchParam.sales_date}</span></b>
</div>
<!-- 검색창 추가시 사용 -->
<form id="searchSalesFrm" name="searchSalesFrm" method="post">
<div class="tableStyle99">
	<input type="hidden" id="sales_date" name="sales_date" value="${srchParam.sales_date}"/>
	<table>								
		<tr>			
			<th width="8%">
				실적 기준일자
			</th>
			<td align="center" width="15%">
				<input type="text" id="chk_sdate" name="chk_sdate" value="${srchParam.chk_sdate}" readonly style="width:70px;"/> ~ 
				<input type="text" id="chk_edate" name="chk_edate" value="${srchParam.chk_edate}" readonly style="width:70px;"/>				
			</td>
			<th width="8%">부서</th>
			<td width="17%" style="text-align:left;padding-left:10px;">
				<span style="text-align: left !important;">
					<select id="srchTeamId" name="srchTeamId" style="width: 195px;">
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
			<th width="8%">이름</th>
			<td width="12%" style="text-align:left;padding-left:10px;">
				<input type="text" style="width: 130px;" id="srchUserName" name="srchUserName" value="${srchParam.srchUserName }"/>	
			</td>
			<th width="8%">재직상태</th>
			<td width="14%" style="text-align:left;padding-left:10px;">
				<select id="srchUserState" name="srchUserState" style="width: 156px;">																											
					<option value="99" <c:if test="${srchParam.srchUserState eq '99'}">selected</c:if> >- 전체 -</option>
					<option value="0" <c:if test="${srchParam.srchUserState eq '0'}">selected</c:if>>근무자</option>
					<option value="2" <c:if test="${srchParam.srchUserState eq '2'}">selected</c:if>>대기자</option>
					<option value="1"<c:if test="${srchParam.srchUserState eq '1'}">selected</c:if>>퇴사자</option>
					<option value="9" <c:if test="${srchParam.srchUserState eq '9'}">selected</c:if>>SA</option>													
				</select>													
			</td>
			<td align="center" width="10%">
				<a href="#noloc" class="btn-vacation-aprv" id="btn-search" onclick='doSalesSearch();'>검색</a>
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
			<th width="10%">보험사</th>
			<th width="8%">직무</th>
			<th width="6%">경력일수</th>			
			<th width="6%">손감</th>
			<th width="6%">민원</th>			
			<th width="8%">구간 성과급</th>
			<th width="8%">시상비 합계</th>			
			<th width="9%">성과급 합계</th>			
			<th width="8%">-</th>
		</tr>
	</table>
	<div id="salesMemberList"></div>
</div>