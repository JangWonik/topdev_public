<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script>
	$(document).ready(function () {
		//카테고리 목록 불러오기
		doSearchCategory();
	});

	//입력폼 초기화
	function formClear(){
		$("#category_name_add").val("");
		$("#category_ord_add").val("");
	}
	
	//분류명 추가
	function categoryAdd(){
		formClear();
		$("#addCategoryButton").hide();
		$("#categoryAddForm").show();
	}
	
	//분류명추가취소
	function categoryCancel(){
		formClear();
		$("#addCategoryButton").show();
		$("#categoryAddForm").hide();
	}
	
	//분류명 추가저장
	function categorySave(){
		
		var addCategoryName = $("#category_name_add").val();
		var addCategoryOrd = $("#category_ord_add").val();
		
		if( addCategoryName == "" ){
			alert("교육분류명을 입력해주세요.");
			$("#category_name_add").focus();
			return;
		}
		
		if( addCategoryOrd == "" ){
			alert("교육정렬순서를 입력해주세요 (0~9999)");
			$("#category_ord_add").focus();
			return;
		}
		
		if( isNaN(addCategoryOrd) ){
			alert("교육정렬순서는 숫자로입력해주세요. (0~9999)");
			$("#category_ord_add").focus();
			return;
		}
		
		var param = {};
		
		param.action = "I";				//Insert
		param.category_name = addCategoryName;
		param.category_ord = addCategoryOrd; 
		
		var url = "./lectureCategoryAction";			//개별등록

	    $.ajax({
			type: "POST",
			url: url,
			data: param,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "html",			
			timeout: 20000,
			success: function(data){
				if( data ){		//1인 경우 성공 
					alert("정보를 추가하였습니다.");
					formClear();
					$("#addCategoryButton").show();
					$("#categoryAddForm").hide();
					doSearchCategory();
				}
			}                
	    });		
	}
	
	function doSearchCategory(){
		
		var param = {};
		
		var sUrl = "./getLectureCategory";			//개별목록가져오기
		
		$.ajax({
    		type: "POST",
    		url: sUrl,
    		data: param,
    		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    		dataType: "html",
    		timeout: 20000,    		         
    		success: function(data){    			
    			$("#lectureCategoryList").html(data);    			
    		},            		
    		error: function (request, status, error) {
    			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
    		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
    		}            		
    	});
		
	}
	
	//카테고리 수정
	function doCateModify( p_ckey ){		
		$("#category_view_"+p_ckey).hide();
		$("#category_edit_"+p_ckey).show();
	}
	
	//카테고리 수정 취소
	function doCateEditCancel( p_ckey ){
		$("#category_view_"+p_ckey).show();
		$("#category_edit_"+p_ckey).hide();
	}
	
	//카테고리 수정 저장
	function doCateEditSave( p_ckey ){
		var param = {};		
		
		param.action = "U";				//Update
		param.ckey = p_ckey;
		param.category_name = $("#category_name_edit_"+p_ckey).val();
		param.category_ord = $("#category_ord_edit_"+p_ckey).val();
		param.category_isuse = $("#category_isuse_edit_"+p_ckey).val();
		
		//alert(param.action+" : "+param.category_name+" : "+param.category_ord+" : "+param.category_isuse);
		//return;
		
		var url = "./lectureCategoryAction";			//개별등록

	    $.ajax({
			type: "POST",
			url: url,
			data: param,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "html",			
			timeout: 20000,
			success: function(data){
				if( data ){		//1인 경우 성공 
					alert("정보를 수정하였습니다.");					
					doSearchCategory();
				}
			}                
	    });
	}
	
	//카테고리 삭제
	function doCateDelete( p_ckey , p_category_name ){
		
		if( !confirm( p_category_name+" 카테고리를 삭제하시겠습니까?") ){
			return;	
		}		
		
		var param = {};		
		
		param.action = "D";				//Delete
		param.ckey = p_ckey;		
				
		var url = "./lectureCategoryAction";			//개별등록

	    $.ajax({
			type: "POST",
			url: url,
			data: param,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "html",			
			timeout: 20000,
			success: function(data){
				if( data ){		//1인 경우 성공 
					alert("정보를 삭제하였습니다.");					
					doSearchCategory();
				}
			}                
	    });
	}
</script>
<!-- 교육분류 시작 -->
<div id="addCategoryButton" style="text-align:right;padding:5px 0 5px 0;">
	<a href="#noloc" class="btn-equipment-save" id="btn-search" onclick='javascript:categoryAdd();'>교육분류등록</a>
</div>
<div class="tableStyle99" id="categoryAddForm" style="display:none;padding-bottom:5px;">
	<table>
		<tr>
			<th width="10%">교육분류명</th>
			<td width="40%" style="padding-left:5px;"><input type="text" id="category_name_add" name="category_name_add" style="width:618px;" placeholder="교육분류명을 입력해주세요."/></td>
			<th width="10%">교육정렬순서</th>
			<td width="10%" style="padding-left:5px;"><input type="text" id="category_ord_add" name="category_ord_add" style="width:145px;text-align:right;" placeholder="0 ~ 9999"/></td>
			<td width="10%" style="text-align:center;">
				<a href="#noloc" class="btn-equipment-save-s" id="btn-search" onclick='javascript:categorySave();'>저장</a>
				<a href="#noloc" class="btn-equipment-cancel-s" id="btn-search" onclick='javascript:categoryCancel();'>취소</a>
			</td>			
		</tr>		
	</table>	
</div>

<div class="tableStyle99">															
	<table>
		<tr>
			<th width="10%">No</th>
			<th width="40%">교육분류명</th><!-- 공통, 물보험본부, 인보험본부 -->
			<th width="10%">교육정렬순서</th>
			<th width="20%">사용여부</th>
			<th width="20%">기능</th>														
		</tr>		
	</table>
	<div id="lectureCategoryList"></div>
</div>	
<!-- 교육분류 끝 -->