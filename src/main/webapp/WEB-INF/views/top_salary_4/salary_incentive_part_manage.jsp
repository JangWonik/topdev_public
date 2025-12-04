<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
<script src="./resources/ne_js/calendar.js?v=20170321111520"></script><!-- calendar -->
<script src="./resources/ne_js/ne_number.js"></script>
<script src="./resources/select2/select2.min.js"></script>
<link href="./resources/select2/select2.min.css" rel="stylesheet" />
<script>
	$(document).ready(function () {		
		$("#srchInsuCompany").select2();
		$("#srchIncentiveType").select2();
		$("#srchPartIsUse").select2();
				
		//폼에서 엔터 입력방지
		$('input[type="text"]').keydown(function() {
		    if (event.keyCode === 13) {
		        event.preventDefault();
		    }
		});
		fnPartSearch();
	});
	
	function doSalaryPartDelete( p_pkey, p_title ){
		if( confirm( "직무명 : ' "+p_title+" ' 을(를) 삭제하시겠습니까?" ) ){			
			$("#pkey_val").val( p_pkey );
			fnPartAction( 'D' );
		}
	}
	
	function partAdd(){
		//등록폼 초기화
		$("#insu_company option:eq(0)").prop('selected', true);
		$("#part_name").val('');
		$("#loss_rate").val('');
		$("#base_count").val('');
		$("#base_sales").val('');
		$("#unit_sales").val('');
		$('input[name="incentive_type"]').removeAttr('checked');			//라디오 버튼 초기화
		
		$("#count_chk_point_1_1").val('');
		$("#count_chk_point_1_2").val('');
		$("#count_chk_point_1_3").val('');
		$("#count_chk_point_2_1").val('');
		$("#count_chk_point_2_2").val('');
		$("#count_chk_point_2_3").val('');
		$("#count_chk_point_3_1").val('');
		$("#count_chk_point_3_2").val('');
		$("#count_chk_point_3_3").val('');
		$("#count_chk_point_4_1").val('');
		$("#count_chk_point_4_2").val('');
		$("#count_chk_point_4_3").val('');
		
		$("#sales_chk_point_1_1").val('');
		$("#sales_chk_point_1_2").val('');
		$("#sales_chk_point_1_3").val('');
		$("#sales_chk_point_2_1").val('');
		$("#sales_chk_point_2_2").val('');
		$("#sales_chk_point_2_3").val('');
		$("#sales_chk_point_3_1").val('');
		$("#sales_chk_point_3_2").val('');
		$("#sales_chk_point_3_3").val('');
		$("#sales_chk_point_4_1").val('');
		$("#sales_chk_point_4_2").val('');
		$("#sales_chk_point_4_3").val('');
		
		$("#payout_rate_1").val('');
		$("#payout_rate_2").val('');
		$("#payout_rate_3").val('');
		$("#payout_rate_4").val('');
		$("#fail_rate").val('');
		$("#part_is_use").val(0);
		
		$("#part-action-dialog").dialog({
			height: 700,
			width: 800,
			closeOnEscape : true,
			draggable : true,
			appendTo : "#partActionFrm",
			title: "직무 설정 등록",
			buttons:{
				"등록" : function(){
					var action = fnPartAction('I');		//등록
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
		
		$("#part_is_use").select2({
			dropdownParent: $("#part-action-dialog")	
		});
		
		$("#insu_company").select2({
			dropdownParent: $("#part-action-dialog")	
		});
	}
	
	//직무 수정
	function doSalaryPartMod( p_pkey ){
		
		var sUrl = "get_salary_part_info";
		
		var param = {};
		param.pkey = p_pkey;			
		
		$.ajax({
		type: "POST",
		url: sUrl,
		data: param,		         
		dataType: "JSON", 
		success: function(data){	        		
			//alert(JSON.stringify(data));
			//alert("data="+data.user_no);			
			
			//수정폼 설정
			$("#pkey_val").val(data.pkey);
			$("#insu_company").val(data.ikey);			
			$("#part_name").val(data.part_name);			
			$("#loss_rate").val(data.loss_rate);
			$("#base_count").val(data.base_count);
			$("#base_sales").val(data.base_sales);
			$("#unit_sales").val(data.unit_sales);
			
			if( data.incentive_type == '1' ){
				$("#incentive_type_1").prop('checked',true);
				$("#div_count_form").show();
				$("#div_sales_form").hide();
			}else if( data.incentive_type == '2' ){
				$("#incentive_type_2").prop('checked',true);				
				$("#div_sales_form").show();
				$("#div_count_form").hide();
			}
			
			$("#count_chk_point_1_1").val(data.count_chk_point_1_1);
			$("#count_chk_point_1_2").val(data.count_chk_point_1_2);
			$("#count_chk_point_1_3").val(data.count_chk_point_1_3);
			$("#count_chk_point_2_1").val(data.count_chk_point_2_1);
			$("#count_chk_point_2_2").val(data.count_chk_point_2_2);
			$("#count_chk_point_2_3").val(data.count_chk_point_2_3);
			$("#count_chk_point_3_1").val(data.count_chk_point_3_1);
			$("#count_chk_point_3_2").val(data.count_chk_point_3_2);
			$("#count_chk_point_3_3").val(data.count_chk_point_3_3);
			$("#count_chk_point_4_1").val(data.count_chk_point_4_1);
			$("#count_chk_point_4_2").val(data.count_chk_point_4_2);
			$("#count_chk_point_4_3").val(data.count_chk_point_4_3);
			
			$("#sales_chk_point_1_1").val(data.sales_chk_point_1_1);
			$("#sales_chk_point_1_2").val(data.sales_chk_point_1_2);
			$("#sales_chk_point_1_3").val(data.sales_chk_point_1_3);
			$("#sales_chk_point_2_1").val(data.sales_chk_point_2_1);
			$("#sales_chk_point_2_2").val(data.sales_chk_point_2_2);
			$("#sales_chk_point_2_3").val(data.sales_chk_point_2_3);
			$("#sales_chk_point_3_1").val(data.sales_chk_point_3_1);
			$("#sales_chk_point_3_2").val(data.sales_chk_point_3_2);
			$("#sales_chk_point_3_3").val(data.sales_chk_point_3_3);
			$("#sales_chk_point_4_1").val(data.sales_chk_point_4_1);
			$("#sales_chk_point_4_2").val(data.sales_chk_point_4_2);
			$("#sales_chk_point_4_3").val(data.sales_chk_point_4_3);
			
			$("#payout_rate_1").val(data.payout_rate_1);
			$("#payout_rate_2").val(data.payout_rate_2);
			$("#payout_rate_3").val(data.payout_rate_3);
			$("#payout_rate_4").val(data.payout_rate_4);
			$("#fail_rate").val(data.fail_rate);
			$("#part_is_use").val(data.is_use);
			
			$("#part-action-dialog").dialog({
				height: 700,
				width: 800,
				closeOnEscape : true,
				draggable : true,
				appendTo : "#partActionFrm",
				title: "성과급 설정 수정",
				buttons:{
					"수정" : function(){
						var action = fnPartAction('U');		//수정
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
			
			$("#part_is_use").select2({
				dropdownParent: $("#part-action-dialog")	
			});
			
			$("#insu_company").select2({
				dropdownParent: $("#part-action-dialog")	
			});
			
		},
		error: function(e){
		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		}
		
	    });
	}
	
	function fnPartAction( p_action ){
		
		var insu_company_val = $("#insu_company").val();
		var is_use_val = $("#part_is_use").val();
		var part_name_val = $("#part_name").val();
		var loss_rate_val = $("#loss_rate").val();
		var base_count_val = $("#base_count").val().replace(/,/gi,"");
		var base_sales_val = $("#base_sales").val().replace(/,/gi,"");
		var unit_sales_val = $("#unit_sales").val().replace(/,/gi,"");
		var incentive_type_val = $(":input[name=incentive_type]:checked").val();			//성과급 기준(라디오버튼)
				
		var count_chk_point_1_1_val = $("#count_chk_point_1_1").val().replace(/,/gi,"");
		var count_chk_point_1_2_val = $("#count_chk_point_1_2").val().replace(/,/gi,"");
		var count_chk_point_1_3_val = $("#count_chk_point_1_3").val().replace(/,/gi,"");
		var count_chk_point_2_1_val = $("#count_chk_point_2_1").val().replace(/,/gi,"");
		var count_chk_point_2_2_val = $("#count_chk_point_2_2").val().replace(/,/gi,"");
		var count_chk_point_2_3_val = $("#count_chk_point_2_3").val().replace(/,/gi,"");
		var count_chk_point_3_1_val = $("#count_chk_point_3_1").val().replace(/,/gi,"");
		var count_chk_point_3_2_val = $("#count_chk_point_3_2").val().replace(/,/gi,"");
		var count_chk_point_3_3_val = $("#count_chk_point_3_3").val().replace(/,/gi,"");
		var count_chk_point_4_1_val = $("#count_chk_point_4_1").val().replace(/,/gi,"");
		var count_chk_point_4_2_val = $("#count_chk_point_4_2").val().replace(/,/gi,"");
		var count_chk_point_4_3_val = $("#count_chk_point_4_3").val().replace(/,/gi,"");
		
		var sales_chk_point_1_1_val = $("#sales_chk_point_1_1").val().replace(/,/gi,"");
		var sales_chk_point_1_2_val = $("#sales_chk_point_1_2").val().replace(/,/gi,"");
		var sales_chk_point_1_3_val = $("#sales_chk_point_1_3").val().replace(/,/gi,"");
		var sales_chk_point_2_1_val = $("#sales_chk_point_2_1").val().replace(/,/gi,"");
		var sales_chk_point_2_2_val = $("#sales_chk_point_2_2").val().replace(/,/gi,"");
		var sales_chk_point_2_3_val = $("#sales_chk_point_2_3").val().replace(/,/gi,"");
		var sales_chk_point_3_1_val = $("#sales_chk_point_3_1").val().replace(/,/gi,"");
		var sales_chk_point_3_2_val = $("#sales_chk_point_3_2").val().replace(/,/gi,"");
		var sales_chk_point_3_3_val = $("#sales_chk_point_3_3").val().replace(/,/gi,"");
		var sales_chk_point_4_1_val = $("#sales_chk_point_4_1").val().replace(/,/gi,"");
		var sales_chk_point_4_2_val = $("#sales_chk_point_4_2").val().replace(/,/gi,"");
		var sales_chk_point_4_3_val = $("#sales_chk_point_4_3").val().replace(/,/gi,"");
		
		var payout_rate_1_val = $("#payout_rate_1").val();
		var payout_rate_2_val = $("#payout_rate_2").val();
		var payout_rate_3_val = $("#payout_rate_3").val();
		var payout_rate_4_val = $("#payout_rate_4").val();
		var fail_rate_val = $("#fail_rate").val();
		
		//등록 또는 수정
		if( p_action == 'I' || p_action == 'U' ){
		
			if( insu_company_val == '0' ){
				alert("보험사를 선택해 주세요.");
				$("#insu_company").focus();
				return;
			}
			
			if( part_name_val == '' ){
				alert("직무명을 입력해 주세요.");
				$("#part_name").focus();
				return;
			}
			
			if( loss_rate_val == '' ){
				alert("손감율을 입력해 주세요.");
				$("#loss_rate").focus();
				return;
			}
			
			if( base_count_val == '' ){
				alert("기본 건수를 입력해 주세요.");
				$("#base_count").focus();
				return;
			}
			
			if( base_sales_val == '' ){
				alert("기본 매출액을 입력해 주세요.");
				$("#base_sales").focus();
				return;
			}
			
			if( unit_sales_val == '' ){
				alert("건당 매출책을 입력해 주세요.")
				$("#unit_sales").focus();
				return;
			}
			
			if( typeof incentive_type_val == "undefined" ){
				alert("성과급 기준을 선택해주세요.");
				$("#incentive_type_1").focus();
				return;
			}
			
			//종결건 기준인 경우
			if( incentive_type_val == '1' ){
				if( count_chk_point_1_1_val == '' || count_chk_point_1_1_val == 0 ){
					alert("종결(초과)건 기준 1년차 1~2구간 기준값을 입력해 주세요.");
					$("#count_chk_point_1_1").focus();
					return;				
				}
				
				if( count_chk_point_1_2_val == '' || count_chk_point_1_2_val == 0 ){
					alert("종결(초과)건 기준 1년차 2~3구간 기준값을 입력해 주세요.");
					$("#count_chk_point_1_2").focus();
					return;				
				}
				
				if( count_chk_point_1_3_val == '' || count_chk_point_1_3_val == 0 ){
					alert("종결(초과)건 기준 1년차 3~4구간 기준값을 입력해 주세요.");
					$("#count_chk_point_1_3").focus();
					return;
				}
				
				if( count_chk_point_2_1_val == '' || count_chk_point_2_1_val == 0 ){
					alert("종결(초과)건 기준 2년차 1~2구간 기준값을 입력해 주세요.");
					$("#count_chk_point_2_1").focus();
					return;				
				}
				
				if( count_chk_point_2_2_val == '' || count_chk_point_2_2_val == 0 ){
					alert("종결(초과)건 기준 2년차 2~3구간 기준값을 입력해 주세요.");
					$("#count_chk_point_2_2").focus();
					return;				
				}
				
				if( count_chk_point_2_3_val == '' || count_chk_point_2_3_val == 0 ){
					alert("종결(초과)건 기준 2년차 3~4구간 기준값을 입력해 주세요.");
					$("#count_chk_point_2_3").focus();
					return;
				}
				
				if( count_chk_point_3_1_val == '' || count_chk_point_3_1_val == 0 ){
					alert("종결(초과)건 기준 3년차 1~2구간 기준값을 입력해 주세요.");
					$("#count_chk_point_3_1").focus();
					return;				
				}
				
				if( count_chk_point_3_2_val == '' || count_chk_point_3_2_val == 0 ){
					alert("종결(초과)건 기준 3년차 2~3구간 기준값을 입력해 주세요.");
					$("#count_chk_point_3_2").focus();
					return;				
				}
				
				if( count_chk_point_3_3_val == '' || count_chk_point_3_3_val == 0 ){
					alert("종결(초과)건 기준 3년차 3~4구간 기준값을 입력해 주세요.");
					$("#count_chk_point_3_3").focus();
					return;
				}
				
				if( count_chk_point_4_1_val == '' || count_chk_point_4_1_val == 0 ){
					alert("종결(초과)건 기준 4년차 1~2구간 기준값을 입력해 주세요.");
					$("#count_chk_point_4_1").focus();
					return;				
				}
				
				if( count_chk_point_4_2_val == '' || count_chk_point_4_2_val == 0 ){
					alert("종결(초과)건 기준 4년차 2~3구간 기준값을 입력해 주세요.");
					$("#count_chk_point_4_2").focus();
					return;				
				}
				
				if( count_chk_point_4_3_val == '' || count_chk_point_4_3_val == 0 ){
					alert("종결(초과)건 기준 4년차 3~4구간 기준값을 입력해 주세요.");
					$("#count_chk_point_4_3").focus();
					return;
				}
				
				//매출액 기준값을 0으로 초기화한다.
				sales_chk_point_1_1_val = 0;
				sales_chk_point_1_2_val = 0;
				sales_chk_point_1_3_val = 0;
				sales_chk_point_2_1_val = 0;
				sales_chk_point_2_2_val = 0;
				sales_chk_point_2_3_val = 0;
				sales_chk_point_3_1_val = 0;
				sales_chk_point_3_2_val = 0;
				sales_chk_point_3_3_val = 0;
				sales_chk_point_4_1_val = 0;
				sales_chk_point_4_2_val = 0;
				sales_chk_point_4_3_val = 0;
			}
			
			//매출액 기준인 경우
			if( incentive_type_val == '2' ){
				if( sales_chk_point_1_1_val == '' || sales_chk_point_1_1_val == 0 ){
					alert("매출(초과)액 기준 1년차 1~2구간 기준값을 입력해 주세요.");
					$("#sales_chk_point_1_1").focus();
					return;				
				}
				
				if( sales_chk_point_1_2_val == '' || sales_chk_point_1_2_val == 0 ){
					alert("매출(초과)액 기준 1년차 2~3구간 기준값을 입력해 주세요.");
					$("#sales_chk_point_1_2").focus();
					return;				
				}
				
				if( sales_chk_point_1_3_val == '' || sales_chk_point_1_3_val == 0 ){
					alert("매출(초과)액 기준 1년차 3~4구간 기준값을 입력해 주세요.");
					$("#sales_chk_point_1_3").focus();
					return;
				}
				
				if( sales_chk_point_2_1_val == '' || sales_chk_point_2_1_val == 0 ){
					alert("매출(초과)액 기준 2년차 1~2구간 기준값을 입력해 주세요.");
					$("#sales_chk_point_2_1").focus();
					return;				
				}
				
				if( sales_chk_point_2_2_val == '' || sales_chk_point_2_2_val == 0 ){
					alert("매출(초과)액 기준 2년차 2~3구간 기준값을 입력해 주세요.");
					$("#sales_chk_point_2_2").focus();
					return;				
				}
				
				if( sales_chk_point_2_3_val == '' || sales_chk_point_2_3_val == 0 ){
					alert("매출(초과)액 기준 2년차 3~4구간 기준값을 입력해 주세요.");
					$("#sales_chk_point_2_3").focus();
					return;
				}
				
				if( sales_chk_point_3_1_val == '' || sales_chk_point_3_1_val == 0 ){
					alert("매출(초과)액 기준 3년차 1~2구간 기준값을 입력해 주세요.");
					$("#sales_chk_point_3_1").focus();
					return;				
				}
				
				if( sales_chk_point_3_2_val == '' || sales_chk_point_3_2_val == 0 ){
					alert("매출(초과)액 기준 3년차 2~3구간 기준값을 입력해 주세요.");
					$("#sales_chk_point_3_2").focus();
					return;				
				}
				
				if( sales_chk_point_3_3_val == '' || sales_chk_point_3_3_val == 0 ){
					alert("매출(초과)액 기준 3년차 3~4구간 기준값을 입력해 주세요.");
					$("#sales_chk_point_3_3").focus();
					return;
				}
				
				if( sales_chk_point_4_1_val == '' || sales_chk_point_4_1_val == 0 ){
					alert("매출(초과)액 기준 4년차 1~2구간 기준값을 입력해 주세요.");
					$("#sales_chk_point_4_1").focus();
					return;				
				}
				
				if( sales_chk_point_4_2_val == '' || sales_chk_point_4_2_val == 0 ){
					alert("매출(초과)액 기준 4년차 2~3구간 기준값을 입력해 주세요.");
					$("#sales_chk_point_4_2").focus();
					return;				
				}
				
				if( sales_chk_point_4_3_val == '' || sales_chk_point_4_3_val == 0 ){
					alert("매출(초과)액 기준 4년차 3~4구간 기준값을 입력해 주세요.");
					$("#sales_chk_point_4_3").focus();
					return;
				}
				
				//건수 기준값을 0으로 초기화한다.
				count_chk_point_1_1_val = 0;
				count_chk_point_1_2_val = 0;
				count_chk_point_1_3_val = 0;
				count_chk_point_2_1_val = 0;
				count_chk_point_2_2_val = 0;
				count_chk_point_2_3_val = 0;
				count_chk_point_3_1_val = 0;
				count_chk_point_3_2_val = 0;
				count_chk_point_3_3_val = 0;
				count_chk_point_4_1_val = 0;
				count_chk_point_4_2_val = 0;
				count_chk_point_4_3_val = 0;
			}
			
			//구간별 지급율 체크
			if( payout_rate_1_val == '' || payout_rate_1_val == 0){
				alert("1구간 지급율을 입력해 주세요");
				$("#payout_rate_1").focus();
				return;
			}
			
			if( payout_rate_2_val == '' || payout_rate_2_val == 0){
				alert("2구간 지급율을 입력해 주세요");
				$("#payout_rate_2").focus();
				return;
			}
			
			if( payout_rate_3_val == '' || payout_rate_3_val == 0){
				alert("3구간 지급율을 입력해 주세요");
				$("#payout_rate_3").focus();
				return;
			}
			
			if( payout_rate_4_val == '' || payout_rate_4_val == 0){
				alert("4구간 지급율을 입력해 주세요");
				$("#payout_rate_4").focus();
				return;
			}
			
			if( fail_rate_val == '' || fail_rate_val == 0){
				alert("손감 미달성 또는 민원 발생 시 지급율을 입력해 주세요");
				$("#fail_rate").focus();
				return;
			}
		}
		
		var param = {};
		param.pkey = $("#pkey_val").val();
		param.action = p_action;
		param.ikey = insu_company_val;
		param.part_name = part_name_val;
		param.unit_sales = unit_sales_val;
		param.loss_rate = loss_rate_val;
		param.incentive_type = incentive_type_val;		
		param.base_count = base_count_val;
		param.base_sales = base_sales_val;
		param.payout_rate_1 = payout_rate_1_val;
		param.payout_rate_2 = payout_rate_2_val;
		param.payout_rate_3 = payout_rate_3_val;
		param.payout_rate_4 = payout_rate_4_val;
		
		param.count_chk_point_1_1 = count_chk_point_1_1_val;
		param.count_chk_point_1_2 = count_chk_point_1_2_val;
		param.count_chk_point_1_3 = count_chk_point_1_3_val;
		param.count_chk_point_2_1 = count_chk_point_2_1_val;
		param.count_chk_point_2_2 = count_chk_point_2_2_val;
		param.count_chk_point_2_3 = count_chk_point_2_3_val;
		param.count_chk_point_3_1 = count_chk_point_3_1_val;
		param.count_chk_point_3_2 = count_chk_point_3_2_val;
		param.count_chk_point_3_3 = count_chk_point_3_3_val;
		param.count_chk_point_4_1 = count_chk_point_4_1_val;
		param.count_chk_point_4_2 = count_chk_point_4_2_val;
		param.count_chk_point_4_3 = count_chk_point_4_3_val;
		
		param.sales_chk_point_1_1 = sales_chk_point_1_1_val;
		param.sales_chk_point_1_2 = sales_chk_point_1_2_val;
		param.sales_chk_point_1_3 = sales_chk_point_1_3_val;
		param.sales_chk_point_2_1 = sales_chk_point_2_1_val;
		param.sales_chk_point_2_2 = sales_chk_point_2_2_val;
		param.sales_chk_point_2_3 = sales_chk_point_2_3_val;
		param.sales_chk_point_3_1 = sales_chk_point_3_1_val;
		param.sales_chk_point_3_2 = sales_chk_point_3_2_val;
		param.sales_chk_point_3_3 = sales_chk_point_3_3_val;
		param.sales_chk_point_4_1 = sales_chk_point_4_1_val;
		param.sales_chk_point_4_2 = sales_chk_point_4_2_val;
		param.sales_chk_point_4_3 = sales_chk_point_4_3_val;
		
		param.fail_rate = fail_rate_val;
		param.is_use = is_use_val;
		
		var sUrl = "salary_part_action";			//컨트롤 작업필요
		
		$.ajax({
			type: "POST",
   	        url: sUrl,
   	        data: param,
   	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
   	        timeout: 20000,
   	        async: false,
   	        dataType: "html", 
   	        success: function(data){   	        	
   	        	if (data == 1){
					alert("직무 설정 정보를 등록하였습니다.");
					$("#part-action-dialog").dialog("close");
					fnPartSearch();
   	        	}else if(data == 2){
   	        		alert("직무 설정 정보를 수정하였습니다.");
   	        		$("#part-action-dialog").dialog("close");
   	        		fnPartSearch();
   	        	}else if(data == 9){
   	        		alert("직무 설정 정보를 삭제하였습니다.");   	        		
   	        		fnPartSearch();
   	        	}else{
   	        		alert("기본급 설정 정보 작업을 실패하였습니다.");
   	        	}
   	        	
   	        },
			error: function(e){
			    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
			}
		});
		
		
	}
	
	function fnCountChk(){
		$("#div_count_form").show();
		$("#div_sales_form").hide();
	}
	
	function fnSalesChk(){
		$("#div_count_form").hide();
		$("#div_sales_form").show();
	}
	
	function fnPartSearch(){
		
		var sUrl = "./getSalaryPartInfoList";		//개별목록 가져오기
		
		var formData = $("#searchPartFrm").serialize();
		
		$.ajax({
    		type: "POST",
    		url: sUrl,
    		data: formData,
    		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    		dataType: "html",
    		timeout: 20000,
    		success: function(data){
    			$("#salaryPartList").html(data);    			
    		},            		
    		error: function (request, status, error) {
    			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
    		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
    		}            		
    	});
	}
	
</script>
<!-- 직무 설정 검색이 필요한경우 사용 -->
<form id="searchPartFrm" name="searchPartFrm">
	<div class="tableStyle99">
		<table>
			<tr>
				<th width="10%">보험사 명</th>
				<td width="15%" style="text-align:center">
					<select id="srchInsuCompany" name="srchInsuCompany" style="width:180px;text-align:center;">
						<option value="0">- 전체 -</option>
						<c:forEach items="${insuCompanyList}" var="insuVo" >
							<option value="${insuVo.ikey}">${insuVo.insu_name}</option>
						</c:forEach>
					</select>
				</td>
				<th width="10%">직무 명</th>
				<td width="15%" style="text-align:center">
					<input type="text" id="srchPartName" name="srchPartName" style="width:180px;" value="${srchParam.srchPartName}">
				</td>
				<th width="10%">성과급 기준</th>
				<td width="10%" style="text-align:center">
					<select id="srchIncentiveType" name="srchIncentiveType" style="width:100px;text-align:center">
						<option value="0">- 전체 -</option>
						<option value="1">종결건</option>
						<option value="2">매출액</option>
					</select>
				</td>
				<th width="10%">사용여부</th>
				<td width="10%" style="text-align:center">
					<select id="srchPartIsUse" name="srchPartIsUse" style="width:100px;text-align:center">
						<option value="9">- 전체 -</option>
						<option value="0">사용함</option>
						<option value="1">사용안함</option>						
					</select>
				</td>				
				<td align="center" width="10%">
					<a href="#noloc" class="btn-vacation-aprv" id="btn-search" onclick='fnPartSearch();'>검색</a>
				</td>
			</tr>
		</table>
	</div>
</form>
<div style="text-align:right;padding:10px 0 10px 0;">		
	<a href="#noloc" class="btn-equipment-save" id="addInsuButton" onclick='javascript:partAdd();'>직무 등록</a>	
</div>
<!-- 직무 설정 등록 폼 시작 -->
<form id="partActionFrm">
	<input type="hidden" id="pkey_val" name="pkey_val"/>		
	<div id="part-action-dialog" title="직무 설정 등록" style="font-size: 15px;display:none;" align="center">
		<br/>
		<div class="tableStyle2" style="width: 750px;">
			<table class="vacation-ins-table">				
				<tr>
					<th width="15%">보험사</th>
					<td width="35%" style="font-weight:bold;text-align:left;padding-left:10px;">
						<select id="insu_company" name="insu_company" style="width:230px;text-align:center;">
							<option value="0">- 보험사 선택 -</option>
							<c:forEach items="${insuCompanyList}" var="insuVo" >
								<option value="${insuVo.ikey}">${insuVo.insu_name}</option>
							</c:forEach>							
						</select>
					</td>					
					<th width="15%">사용여부</th>
					<td width="35%" style="font-weight:bold;text-align:left;padding-left:10px;">
						<select id="part_is_use" name="part_is_use" style="width:130px;text-align:center;">
							<option value="0">사용함</option>
							<option value="1">사용안함</option>							
						</select>
					</td>					
				</tr>	
				<tr>
					<th>직무 명</th>
					<td style="font-weight:bold;text-align:left;padding-left:10px;">
						<input type="text" id="part_name" name="part_name" style="width:235px;"/>
					</td>					
					<th>손감율</th>
					<td style="font-weight:bold;text-align:left;padding-left:10px;">
						<input type="text" id="loss_rate" name="loss_rate" style="text-align:right;width:100px;IME-MODE: disabled;"/>&nbsp; 
						( 예 : 2.3, 4.0 )
					</td>
				</tr>
				<tr>
					<th>(최소)기본건수</th>
					<td  style="font-weight:bold;text-align:left;padding-left:10px;">
						<input type="text" id="base_count" name="base_count" style="text-align:right;width:200px;IME-MODE: disabled;" ONKEYUP="javascript:numberCommaFunc(this);"/> 건
					</td>
					<th>(최소)기본 매출액</th>
					<td  style="font-weight:bold;text-align:left;padding-left:10px;">
						<input type="text" id="base_sales" name="base_sales" style="text-align:right;width:200px;IME-MODE: disabled;" ONKEYUP="javascript:numberCommaFunc(this);" class="amt" /> 원
					</td>					
				</tr>	
				<tr>
					<th>건당 매출액</th>
					<td  style="font-weight:bold;text-align:left;padding-left:10px;">
						<input type="text" id="unit_sales" name="unit_sales" style="text-align:right;width:200px;IME-MODE: disabled;" ONKEYUP="javascript:numberCommaFunc(this);" class="amt" /> 원
					</td>
					<th>성과급 기준</th>
					<td  style="font-weight:bold;text-align:left;padding-left:10px;">
						<input type="radio" id="incentive_type_1" name="incentive_type" value="1" onchange="javascript:fnCountChk();"> <font color="blue">종결건</font>
						&nbsp;
						<input type="radio" id="incentive_type_2" name="incentive_type" value="2" onchange="javascript:fnSalesChk();"> <font color="green">매출액</font>
					</td>
				</tr>	
				<tr>
					<td colspan="4" style="border:0px;"></td>
				</tr>																																																
			</table>
			
			<!-- 건수기준 테이블 시작 -->
			<table id="div_count_form" style="display:none;">
				<tr>
					<th colspan="3"><font color="blue">종결(초과)건 기준 1년차</font></th>					
				</tr>
				<tr>
					<th>1 ~ 2구간</th>
					<th>2 ~ 3구간</th>
					<th>3 ~ 4구간</th>
				</tr>
				<tr>
					<td><input type="text" id="count_chk_point_1_1" name="count_chk_point_1_1" ONKEYUP="javascript:numberCommaFunc(this);" style="text-align:right;width:150px;IME-MODE: disabled;" /> 건</td>
					<td><input type="text" id="count_chk_point_1_2" name="count_chk_point_1_2" ONKEYUP="javascript:numberCommaFunc(this);" style="text-align:right;width:150px;IME-MODE: disabled;" /> 건</td>
					<td><input type="text" id="count_chk_point_1_3" name="count_chk_point_1_3" ONKEYUP="javascript:numberCommaFunc(this);" style="text-align:right;width:150px;IME-MODE: disabled;" /> 건</td>
				</tr>
				<tr>
					<th colspan="3"><font color="blue">종결(초과)건 기준 2년차</font></th>					
				</tr>
				<tr>
					<th>1 ~ 2구간</th>
					<th>2 ~ 3구간</th>
					<th>3 ~ 4구간</th>
				</tr>
				<tr>
					<td><input type="text" id="count_chk_point_2_1" name="count_chk_point_2_1" ONKEYUP="javascript:numberCommaFunc(this);" style="text-align:right;width:150px;IME-MODE: disabled;" /> 건</td>
					<td><input type="text" id="count_chk_point_2_2" name="count_chk_point_2_2" ONKEYUP="javascript:numberCommaFunc(this);" style="text-align:right;width:150px;IME-MODE: disabled;" /> 건</td>
					<td><input type="text" id="count_chk_point_2_3" name="count_chk_point_2_3" ONKEYUP="javascript:numberCommaFunc(this);" style="text-align:right;width:150px;IME-MODE: disabled;" /> 건</td>
				</tr>
				<tr>
					<th colspan="3"><font color="blue">종결(초과)건 기준 3년차</font></th>					
				</tr>
				<tr>
					<th>1 ~ 2구간</th>
					<th>2 ~ 3구간</th>
					<th>3 ~ 4구간</th>
				</tr>
				<tr>
					<td><input type="text" id="count_chk_point_3_1" name="count_chk_point_3_1" ONKEYUP="javascript:numberCommaFunc(this);" style="text-align:right;width:150px;IME-MODE: disabled;" /> 건</td>
					<td><input type="text" id="count_chk_point_3_2" name="count_chk_point_3_2" ONKEYUP="javascript:numberCommaFunc(this);" style="text-align:right;width:150px;IME-MODE: disabled;" /> 건</td>
					<td><input type="text" id="count_chk_point_3_3" name="count_chk_point_3_3" ONKEYUP="javascript:numberCommaFunc(this);" style="text-align:right;width:150px;IME-MODE: disabled;" /> 건</td>
				</tr>
				<tr>
					<th colspan="3"><font color="blue">종결(초과)건 기준 4년차 이상</font></th>					
				</tr>
				<tr>
					<th>1 ~ 2구간</th>
					<th>2 ~ 3구간</th>
					<th>3 ~ 4구간</th>
				</tr>
				<tr>
					<td><input type="text" id="count_chk_point_4_1" name="count_chk_point_4_1" ONKEYUP="javascript:numberCommaFunc(this);" style="text-align:right;width:150px;IME-MODE: disabled;" /> 건</td>
					<td><input type="text" id="count_chk_point_4_2" name="count_chk_point_4_2" ONKEYUP="javascript:numberCommaFunc(this);" style="text-align:right;width:150px;IME-MODE: disabled;" /> 건</td>
					<td><input type="text" id="count_chk_point_4_3" name="count_chk_point_4_3" ONKEYUP="javascript:numberCommaFunc(this);" style="text-align:right;width:150px;IME-MODE: disabled;" /> 건</td>
				</tr>
				<tr>
					<td colspan="3" style="border:0px;"></td>
				</tr>
			</table>			
			<!-- 건수기준 테이블 끝 -->
			
			<!-- 매출액 테이블 시작 -->
			<table id="div_sales_form" style="display:none;">
				<tr>
					<th colspan="3"><font color="green">매출(초과)액 기준 1년차</font></th>					
				</tr>
				<tr>
					<th>1 ~ 2구간</th>
					<th>2 ~ 3구간</th>
					<th>3 ~ 4구간</th>
				</tr>
				<tr>
					<td><input type="text" id="sales_chk_point_1_1" name="sales_chk_point_1_1" ONKEYUP="javascript:numberCommaFunc(this);" style="text-align:right;width:150px;IME-MODE: disabled;" class="amt" /> 원</td>
					<td><input type="text" id="sales_chk_point_1_2" name="sales_chk_point_1_2" ONKEYUP="javascript:numberCommaFunc(this);" style="text-align:right;width:150px;IME-MODE: disabled;" class="amt" /> 원</td>
					<td><input type="text" id="sales_chk_point_1_3" name="sales_chk_point_1_3" ONKEYUP="javascript:numberCommaFunc(this);" style="text-align:right;width:150px;IME-MODE: disabled;" class="amt" /> 원</td>
				</tr>
				<tr>
					<th colspan="3"><font color="green">매출(초과)액 기준 2년차</font></th>					
				</tr>
				<tr>
					<th>1 ~ 2구간</th>
					<th>2 ~ 3구간</th>
					<th>3 ~ 4구간</th>
				</tr>
				<tr>
					<td><input type="text" id="sales_chk_point_2_1" name="sales_chk_point_2_1" ONKEYUP="javascript:numberCommaFunc(this);" style="text-align:right;width:150px;IME-MODE: disabled;" class="amt" /> 원</td>
					<td><input type="text" id="sales_chk_point_2_2" name="sales_chk_point_2_2" ONKEYUP="javascript:numberCommaFunc(this);" style="text-align:right;width:150px;IME-MODE: disabled;" class="amt" /> 원</td>
					<td><input type="text" id="sales_chk_point_2_3" name="sales_chk_point_2_3" ONKEYUP="javascript:numberCommaFunc(this);" style="text-align:right;width:150px;IME-MODE: disabled;" class="amt" /> 원</td>
				</tr>
				<tr>
					<th colspan="3"><font color="green">매출(초과)액 기준 3년차</font></th>					
				</tr>
				<tr>
					<th>1 ~ 2구간</th>
					<th>2 ~ 3구간</th>
					<th>3 ~ 4구간</th>
				</tr>
				<tr>
					<td><input type="text" id="sales_chk_point_3_1" name="sales_chk_point_3_1" ONKEYUP="javascript:numberCommaFunc(this);" style="text-align:right;width:150px;IME-MODE: disabled;" class="amt" /> 원</td>
					<td><input type="text" id="sales_chk_point_3_2" name="sales_chk_point_3_2" ONKEYUP="javascript:numberCommaFunc(this);" style="text-align:right;width:150px;IME-MODE: disabled;" class="amt" /> 원</td>
					<td><input type="text" id="sales_chk_point_3_3" name="sales_chk_point_3_3" ONKEYUP="javascript:numberCommaFunc(this);" style="text-align:right;width:150px;IME-MODE: disabled;" class="amt" /> 원</td>
				</tr>
				<tr>
					<th colspan="3"><font color="green">매출(초과)액 기준 4년차</font></th>					
				</tr>
				<tr>
					<th>1 ~ 2구간</th>
					<th>2 ~ 3구간</th>
					<th>3 ~ 4구간</th>
				</tr>
				<tr>
					<td><input type="text" id="sales_chk_point_4_1" name="sales_chk_point_4_1" ONKEYUP="javascript:numberCommaFunc(this);" style="text-align:right;width:150px;IME-MODE: disabled;" class="amt" /> 원</td>
					<td><input type="text" id="sales_chk_point_4_2" name="sales_chk_point_4_2" ONKEYUP="javascript:numberCommaFunc(this);" style="text-align:right;width:150px;IME-MODE: disabled;" class="amt" /> 원</td>
					<td><input type="text" id="sales_chk_point_4_3" name="sales_chk_point_4_3" ONKEYUP="javascript:numberCommaFunc(this);" style="text-align:right;width:150px;IME-MODE: disabled;" class="amt" /> 원</td>
				</tr>
				<tr>
					<td colspan="3" style="border:0px;"></td>
				</tr>
			</table>
			<!-- 매출액 기준 테이블 끝 -->
			
			<!-- 지급율 테이블 시작 -->
			<table>
				<tr>					
					<th colspan="4" width="70%">구간별 지급율</th>
					<th rowspan="2" width="30%"><font color="red">손감 미달성 / 민원 발생 시</font></th>
				</tr>
				<tr>					
					<th width="15%">1구간</th>
					<th width="15%">2구간</th>
					<th width="15%">3구간</th>
					<th width="15%">4구간</th>
				</tr>
				<tr>					
					<td>
						<input type="text" id="payout_rate_1" name="payout_rate_1"style=" text-align:right;width:80px;IME-MODE: disabled;" /> %					
					</td>
					<td>
						<input type="text" id="payout_rate_2" name="payout_rate_2"style=" text-align:right;width:80px;IME-MODE: disabled;" /> %					
					</td>
					<td>
						<input type="text" id="payout_rate_3" name="payout_rate_3"style=" text-align:right;width:80px;IME-MODE: disabled;" /> %					
					</td>
					<td>
						<input type="text" id="payout_rate_4" name="payout_rate_4"style=" text-align:right;width:80px;IME-MODE: disabled;" /> %					
					</td>
					<td>
						<input type="text" id="fail_rate" name="fail_rate"style=" text-align:right;width:80px;IME-MODE: disabled;" /> %					
					</td>
				</tr>
			</table>
			<!-- 지급율 테이블 끝 -->				
		</div>
	</div>
</form>
<!-- 직무 등록 폼 끝-->

<!-- 직무 목록시작 -->
<div class="tableStyle99">															
	<table>
		<tr>
			<th width="5%">No</th>
			<th width="12%">보험사 명</th>
			<th width="12%">직무 명</th>
			<th width="5%">손감율</th>
			<th width="8%">기본 건수</th>
			<th width="10%">기본 매출액</th>
			<th width="8%">건당 매출액</th>
			<th width="10%">성과급 기준</th>
			<th width="6%">사용여부</th>
			<th width="7%">등록자</th>
			<th width="7%">등록일</th>
			<th width="10%">기능</th>
		</tr>		
	</table>
	<div id="salaryPartList"></div>
</div>