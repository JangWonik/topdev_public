<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
	.law_sel_content tr th {padding: 4px 0px 4px 0px; border: 1px solid; background-color: #E7ECF1; text-align: center; vertical-align:middle; font-weight: normal;}
	.law_sel_content tr td {border: 1px solid; text-align: center; vertical-align: middle;}
</style>
<input type="hidden" id="reparationLiabilityType" name="reparationLiabilityType" value="${lawSelContentInfo.reparation_liability_type}">
<table id="table_law_sel_content_view" class="law_sel_content" style="border: 1px solid">	
    <tr>
    	<th style="width:15%;">지&nbsp;&nbsp;급&nbsp;&nbsp;책&nbsp;&nbsp;임</th>
    	<td style="width:35%;text-align:left;padding-left:5px;">
    		<c:choose>
    			<c:when test="${lawSelContentInfo.reparation_liability_type == 1}">부책</c:when>
    			<c:when test="${lawSelContentInfo.reparation_liability_type == 2}">면책</c:when>
    			<c:otherwise> - </c:otherwise>
    		</c:choose>    		
    	</td>
    	<th style="width:15%;">책&nbsp;&nbsp;임&nbsp;&nbsp;범&nbsp;&nbsp;위</th>
    	<td style="width:35%;text-align:left;padding-left:5px;">
    		<c:choose>
    			<c:when test="${lawSelContentInfo.reparation_liability_reason_etc == 1}">동 약관 보상하는 손해</c:when>
    			<c:when test="${lawSelContentInfo.reparation_liability_reason_etc == 2}">동 약관 보상하지 않는 손해</c:when>
    			<c:otherwise> - </c:otherwise>
    		</c:choose>    		
    	</td>
    </tr>
</table>
<table id="table_law_sel_content_edit" class="law_sel_content" style="display:none;">
    <tr>
    	<th style="width:15%;">지&nbsp;&nbsp;급&nbsp;&nbsp;책&nbsp;&nbsp;임</th>
    	<td style="width:35%; text-align:left;padding-left:5px;">
			<select id="reparation_liability_type" name="reparation_liability_type" style="width:80px; padding-left: 1px; padding-right: 1px;">
				<option <c:if test="${lawSelContentInfo.reparation_liability_type == 0 or empty lawSelContentInfo.reparation_liability_type}">selected</c:if> value="0">미선택</option>
				<option <c:if test="${lawSelContentInfo.reparation_liability_type == 1}">selected</c:if> value="1">부책</option>
				<option <c:if test="${lawSelContentInfo.reparation_liability_type == 2}">selected</c:if> value="2">면책</option>
			</select>
    	</td>
    	<th style="width:15%;">책&nbsp;&nbsp;임&nbsp;&nbsp;범&nbsp;&nbsp;위</th>
    	<td style="width:35%;">
    		<select id="reparation_liability_reason_etc" name="reparation_liability_reason_etc" style="width:200px; padding-left: 1px; padding-right: 1px;">
				<option <c:if test="${lawSelContentInfo.reparation_liability_reason_etc == 0}">selected</c:if> value="0">미선택</option>
				<option <c:if test="${lawSelContentInfo.reparation_liability_reason_etc == 1}">selected</c:if> value="1">동 약관 보상하는 손해</option>
				<option <c:if test="${lawSelContentInfo.reparation_liability_reason_etc == 2}">selected</c:if> value="2">동 약관 보상하지 않는 손해</option>
			</select>
    	</td>
    </tr>                             
</table>    
            
<script type="text/javascript">
$(document).ready(function(){
		
	if( 'edit' ==  '${viewType}' ){		//수정 페이지 인경우		
		$("#table_law_sel_content_view").hide();
		$("#table_law_sel_content_edit").show();
		
		$("#btn_law_edit").hide();
		$("#btn_law_save").show();
		$("#btn_law_cancel").show();
	}else{										//보기 페이지 인경우		
		$("#table_law_sel_content_view").show();
		$("#table_law_sel_content_edit").hide();
		
		$("#btn_law_edit").show();
		$("#btn_law_save").hide();
		$("#btn_law_cancel").hide();
	}
	
	//지급책임을 변경한 경우 default 값으로 책임 범위를 선택해준다.
	$("#reparation_liability_type").change(function(){
		
		var selType = $("#reparation_liability_type").val();
		
		if( selType == 1 ){							//부책을 선택한 경우 기본으로 보상을 선택
			$("#reparation_liability_reason_etc").val(1);
		}else if( selType == 2 ){					//면책을 선택한 경우 기본으로 미보상을 선택
			$("#reparation_liability_reason_etc").val(2);
		}else{
			$("#reparation_liability_reason_etc").val(0);
		}
		
		
	});
	
});
</script>