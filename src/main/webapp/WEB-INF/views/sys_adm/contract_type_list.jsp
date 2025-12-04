<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>		
<script>
$(document).ready(function(){
	doSearchType();
});

//계약종류 추가
function typeSave(){		
	var addAction = 'I'; 
	var addCodeType = 'c_type';
	var addCodeName = $("#type_code_name_add").val();
	var addIsDel = $(":input:radio[name='type_is_del_add']:checked").val();	
	
	if( addCodeName == "" ){
		alert("계약서 종류명을 입력해주세요.");
		$("#type_code_name_add").focus();
		return;
	}
		
	var param = {};
	
	param.action = addAction;
	param.code_type = addCodeType;
	param.code_name = addCodeName;
	param.is_del = addIsDel; 
	
	var url = "./contractCodeAction";			//계약관리 계약서 정보 갱신

    $.ajax({
		type: "POST",
        url: url,
        data: param,
        timeout: 20000,        
        dataType: "JSON",
		success: function(data){
			if( data ){		//1인 경우 성공 
				alert("계약서 종류를 추가하였습니다.");
				typeFormClear();
				$("#addTypeButton").show();
				$("#typeAddForm").hide();
				doSearchType();
			}
		}                
    });
}

function doSearchType(){
	
	var param = {};
	
	var sUrl = "./getContractType";			//계약서 종류 목록 가져오기
	
	$.ajax({
		type: "POST",
		url: sUrl,
		data: param,
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		dataType: "html",
		timeout: 20000,
		success: function(data){
			$("#contractTypeList").html(data);    			
		},            		
		error: function (request, status, error) {
			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		}            		
	});
	
}

//계약서 정보명 추가
function typeAdd(){
	typeFormClear();
	$("#addTypeButton").hide();
	$("#typeAddForm").show();
	$("#type_code_name_add").focus();
}

//계약서 정보명 취소
function typeCancel(){
	typeFormClear();
	$("#addTypeButton").show();
	$("#typeAddForm").hide();
}

//계약서 입력폼 초기화
function typeFormClear(){	
	$("#type_code_name_add").val("");
	$("#type_is_del_add_0").prop("checked",true);
	$("#type_is_del_add_1").prop("checked",false);
}

//계약서 종류 수정
function doTypeModify( p_ckey ){	
	$("#tr_conType_"+p_ckey).hide();
	$("#tr_conType_edit_"+p_ckey).show();
}

//계약서 종류 수정 취소
function typeModCancel( p_ckey ){	
	$("#tr_conType_edit_"+p_ckey).hide();
	$("#tr_conType_"+p_ckey).show();
}

//계약서 종류 삭제
function doTypeDelete( p_ckey, p_subject ){
	var sMsg = p_subject+"의 계약서 종류를 삭제하시겠습니까? \n오입력이 아닌경우는 사용여부를 사용안함으로 수정하세요.";
	
	if(confirm(sMsg)){
		var param = {};
		
		param.action = "D";
		param.ckey = p_ckey;		
		
		var url = "./contractCodeAction";			//계약관리 계약서 정보 갱신

	    $.ajax({
			type: "POST",
	        url: url,
	        data: param,
	        timeout: 20000,        
	        dataType: "JSON",
			success: function(data){
				if( data ){		//1인 경우 성공 
					alert("계약서 종류를 삭제하였습니다.");
					typeFormClear();					
					doSearchType();
				}
			}                
	    });
	}	
}

//계약서 종류 수정저장
function typeModSave( p_ckey ){
	var modAction = 'U';
	var modCkey = p_ckey;
	var modCodeType = 'c_type';	
	var modCodeName = $("#type_code_name_mod_"+p_ckey).val();
	var modIsDel = $(":input:radio[name='type_is_del_mod_"+p_ckey+"']:checked").val();
	
	if( modCodeName == "" ){
		alert("수정 할 계약서 종류명을 입력해주세요.");
		$("#type_code_name_mod_"+p_ckey).focus();
		return;
	}
		
	var param = {};
	
	param.action = modAction;
	param.ckey = modCkey;
	param.code_type = modCodeType;
	param.code_name = modCodeName;
	param.is_del = modIsDel;
	
	var url = "./contractCodeAction";			//계약관리 계약서 정보 갱신

    $.ajax({
		type: "POST",
        url: url,
        data: param,
        timeout: 20000,        
        dataType: "JSON",
		success: function(data){
			if( data ){		//1인 경우 성공 
				alert("계약서 종류를 수정하였습니다.");				
				doSearchType();
			}
		}                
    });
	
}

</script>
<style>
	/*저장 버튼*/
		.btn-equipment-save {
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
			color:#FFFFFF  !important;
			width:100px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #3399FF;
		}
</style>
<!-- 계약서 종류 시작 -->
<div id="addTypeButton" style="text-align:right;padding:5px 0 5px 0;">
	<a href="#noloc" class="btn-equipment-save" id="btn-search" onclick='javascript:typeAdd();'>계약서종류등록</a>
</div>
<div class="tableStyle99" id="typeAddForm" style="display:none;padding-bottom:5px;">
	<table>
		<tr>			
			<th width="10%">No</th>
			<th width="60%">계약서 종류명</th>						
			<th width="20%">사용여부</th>
			<th width="20%">-</th>
		</tr>		
		<tr>
			<td align="center">-</td>
			<td style="padding-left:5px;">
				<input type="text" id="type_code_name_add" name="type_code_name_add" style="width:670px;"/>
			</td>
			<td align="center">
				사용함 <input type="radio" id="type_is_del_add_0" name="type_is_del_add" value="0" checked>&nbsp;
				사용안함 <input type="radio" id="type_is_del_add_1" name="type_is_del_add" value="1">
			</td>
			<td align="center">
				<a href="#noloc" class="btn-equipment-save-s" id="btn-search" onclick='javascript:typeSave();'>저장</a>
				<a href="#noloc" class="btn-equipment-cancel-s" id="btn-search" onclick='javascript:typeCancel();'>취소</a>
			</td>			
		</tr>
	</table>	
</div>

<div class="tableStyle99">															
	<table>
		<tr>
			<th width="10%">No</th>
			<th width="60%">계약서 종류명</th>
			<th width="20%">사용여부</th>			
			<th width="20%">-</th>
		</tr>		
	</table>
	<div id="contractTypeList"></div>
</div>	
<!-- 교육분류 끝 -->