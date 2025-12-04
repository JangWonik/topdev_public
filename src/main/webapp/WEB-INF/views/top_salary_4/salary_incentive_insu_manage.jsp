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
		fnInsuSearch();
	});
	
	//보험사 입력폼 초기화
	function insuFormClear(){		
		$("#insu_name_add").val("");
		$("#is_use_add").val("0");		
	}
	
	//보험사 정보 등록
	function insuAdd(){
		insuFormClear();
		$("#addInsuButton").hide();
		$("#insuAddForm").show();
		$("#insu_name_add").focus();
	}
	
	//보험사 정보 등록폼 취소
	function insuCancel(){
		insuFormClear();
		$("#addInsuButton").show();
		$("#insuAddForm").hide();		
	}
	
	//보험사 정보 저장
	function insuSave(){
		var insu_name_val = $("#insu_name_add").val();
		var is_use_val = $("#is_use_add").val();
		
		if( insu_name_val == '' ){
			alert("보험사 명을 등록해주세요");
			$("#insu_name_add").focus();
			return;
		}
		
		var sUrl = "salary_incentive_insu_company_action";
		
		var param = {};
		param.insu_name = insu_name_val;
		param.is_use = is_use_val;
		param.action_flag = "I";
		
		$.ajax({
			type: "POST",
			url: sUrl,
			data: param,		         
			dataType: "JSON", 
			success: function(data){	 
				//console.log("msg = "+JSON.stringify(data));
				if( data.result == 'Dup' ){
					alert('이미 등록된 보험사 명 입니다.\n확인 후 추가 해 주세요.');
				}else if( data.result == 'Insert' ){
					alert('보험사 명을 등록하였습니다.');					
					fnInsuSearch();
					insuCancel();
				}
				
			},	        
			error: function(e){
			    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
			}			
		});
	}
	
	function doInsuMod( p_ikey ){
		$("#insu_company_view_"+p_ikey).hide();
		$("#insu_company_edit_"+p_ikey).show();
	}
	
	function doInsuModCancel( p_ikey ){		
		$("#insu_company_edit_"+p_ikey).hide();
		$("#insu_company_view_"+p_ikey).show();
	}
	
	//보험사 정보 수정
	function doInsuModSave( p_ikey ){
		
		var ikey_val = p_ikey;
		var insu_name_val = $("#insu_name_mod_"+p_ikey).val();
		var is_use_val = $("#is_use_mod_"+p_ikey).val();		
		
		if( insu_name_val == '' ){
			alert("보험사 명을 등록해주세요");
			$("#insu_name_mod_"+p_ikey).focus();
			return;
		}
		
		var sUrl = "salary_incentive_insu_company_action";
		
		var param = {};
		param.ikey = ikey_val;
		param.insu_name = insu_name_val;
		param.is_use = is_use_val;
		param.action_flag = "U";
		
		$.ajax({
			type: "POST",
			url: sUrl,
			data: param,		         
			dataType: "JSON", 
			success: function(data){	 
				//console.log("msg = "+JSON.stringify(data));
				if( data.result == 'Dup' ){
					alert('이미 등록된 보험사 명 입니다.\n확인 후 추가 해 주세요.');
				}else if( data.result == 'Update' ){
					alert('보험사 명을 수정하였습니다.');					
					fnInsuSearch();
				}
				
			},	        
			error: function(e){
			    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
			}			
		});
		
	}
		
	//보험사 정보 삭제
	function doInsuDelete( p_ikey, p_insu_name ){		
		
		if( confirm( p_insu_name+" 을(를) 보험사 목록 에서 삭제하시겠습니까?" ) ){
			
			var sUrl = "salary_incentive_insu_company_action";	
			
			var param = {};
			param.ikey = p_ikey;
			param.action_flag = "D";
			
			$.ajax({
				type: "POST",
				url: sUrl,
				data: param,		         
				dataType: "JSON", 
				success: function(data){
					if( data.result == 'Delete' ){
						alert("삭제하였습니다.");
						fnInsuSearch();
					}
				},	        
				error: function(e){
				    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
				}
				
			});
			
		}
		
	}
	
	function fnInsuSearch(){
		var formData = $("#searchInsuFrm").serialize();
		
		$.ajax({
			type : "post",
			url : "salaryInsuListAjax",
			data : formData,
			success : function(result){				
				//보험사 목록을 가져온다.
				$("#salaryInsuList").html(result);	 				
			},
			error: function (request, status, error) {			
				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
			}
		});		
	}
</script>
<!-- 예외자 검색이 필요한경우 사용 -->
<form id="searchInsuFrm" name="searchInsuFrm">
</form>
<div style="text-align:right;padding:0 0 5px 0;">		
	<a href="#noloc" class="btn-equipment-save" id="addInsuButton" onclick='javascript:insuAdd();'>보험사 등록</a>	
</div>
<!-- 보험사 설정 등록 폼 시작 -->
<div class="tableStyle99" id="insuAddForm" style="display:none;padding-bottom:5px;">
	<table>
		<tr>			
			<th width="70%">보험사 명</th>
			<th width="15%">사용여부</th>
			<th width="15%"></th>
		</tr>				
		<tr>
			<td style="padding-left:10px;">
				<input type="text" id="insu_name_add" name="insu_name_add" style="width:860px;"/>
			</td>
			<td align="center">
				<select id="is_use_add" name="is_use_add" style="width:100px;">
					<option value="0">사용함</option>
					<option value="1">사용안함</option>					
				</select>
			</td>			
			<td align="center">
				<a href="#noloc" class="btn-equipment-save-s" id="btn-search" onclick='javascript:insuSave();'>저장</a>
				<a href="#noloc" class="btn-equipment-cancel-s" id="btn-search" onclick='javascript:insuCancel();'>취소</a>
			</td>			
		</tr>		
	</table>	
</div>
<!-- 보험사 설정 등록 폼 끝-->

<!-- 예외자 목록시작 -->
<div class="tableStyle99">															
	<table>
		<tr>
			<th width="5%">No</th>
			<th width="50%">보험사 명</th>
			<th width="10%">사용여부</th>
			<th width="10%">등록자</th>
			<th width="10%">등록일</th>
			<th width="15%">기능</th>
		</tr>		
	</table>
	<div id="salaryInsuList"></div>
</div>	
<!-- 예외자 목록끝 -->