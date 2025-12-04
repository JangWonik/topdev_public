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
		fnExceptSearch();		
		$("#srchExceptUserNo").select2();
	});
	
	function fnExceptSearch(){
		var formData = $("#searchExceptFrm").serialize();
		
		$.ajax({
			type : "post",
			url : "salaryExceptListAjax",
			data : formData,
			success : function(result){			
				//현재 예외자 목록을 가져온다.
				$("#salaryExceptList").html(result);	 				
			},
			error: function (request, status, error) {			
				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
			}
		});		
	}
	
	//예외자 삭제
	function doExceptMemberDelete( p_ekey, p_user_name ){
		
		if( confirm( p_user_name+" 을(를) 예외자 명단에서 삭제하시겠습니까?" ) ){
			
			var sUrl = "salary_except_member_action";	
			
			var param = {};
			param.ekey = p_ekey;
			param.action_flag = "D";
			
			$.ajax({
				type: "POST",
				url: sUrl,
				data: param,		         
				dataType: "JSON", 
				success: function(data){
					if( data.result == 'Delete' ){
						alert("삭제하였습니다.");
						fnExceptSearch();
					}
				},	        
				error: function(e){
				    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
				}
				
			});
			
		}
		
	}
	
	//예외자 등록
	function exceptAdd(){
		
		var user_no_val = $("#srchExceptUserNo").val();		
		
		if( user_no_val == 0 ){
			alert("예외자로 등록할 직원을 선택해 주세요.");
			$("#srchExceptUserNo").focus();
			return;
		}
		
		var sUrl = "salary_except_member_action";
		
		var param = {};
		param.user_no = user_no_val;
		param.action_flag = "I";
		
		$.ajax({
			type: "POST",
			url: sUrl,
			data: param,		         
			dataType: "JSON", 
			success: function(data){	 
				//console.log("msg = "+JSON.stringify(data));
				if( data.result == 'Dup' ){
					alert('예외자로 이미 등록된 직원입니다.\n확인 후 추가 해 주세요.');
				}else if( data.result == 'Insert' ){
					alert('예외자로 등록하였습니다.');					
					fnExceptSearch();					
				}
				
			},	        
			error: function(e){
			    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
			}
			
		});
		
	}
</script>
<!-- 예외자 검색이 필요한경우 사용 -->
<form id="searchExceptFrm" name="searchExceptFrm">
</form>
<!-- 예외자설정 등록 폼 시작 -->
<div class="tableStyle99">
	<table>
		<tr>
			<td width="65%" style="border:0px;">						
			</td>
			<th width="7%">이름</th>
			<td width="18%" align="center">			
				<select id="srchExceptUserNo" name="srchExceptUserNo" style="width: 190px;">
					<option value="0">- 선택하세요 -</option>
						<c:forEach items="${srchMemberList}" var="srchVo">
							<option value="${srchVo.user_no}">${srchVo.user_name}</option>																						
						</c:forEach>
				</select>			
			</td>
			<td width="10%" align="center">
				<a href="#noloc" class="btn-equipment-save" id="btn-search" onclick='javascript:exceptAdd();'>예외자 등록</a>
			</td>
		</tr>
		<tr>
			<td colspan="4" style="border:0px;"></td>
		</tr>		
	</table>
</div>
<!-- 예외자설정 등록 폼 끝-->

<!-- 예외자 목록시작 -->
<div class="tableStyle99">															
	<table>
		<tr>
			<th width="5%">No</th>
			<th width="15%">센터명</th>
			<th width="15%">팀명</th>
			<th width="10%">직급</th>
			<th width="15%">이름</th>
			<th width="10%">입사일자</th>
			<th width="10%">등록자</th>
			<th width="10%">등록일자</th>
			<th width="10%">기능</th>				
		</tr>		
	</table>
	<div id="salaryExceptList"></div>
</div>	
<!-- 예외자 목록끝 -->