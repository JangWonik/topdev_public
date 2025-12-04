<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table id="table_law_reason_view" style="border: 1px solid">
    <tr>
    	<td style="text-align:left;padding-left:5px;">
    		<c:choose>
    			<c:when test="${empty lawReasonInfo.reparationLiabilityReason}"> - </c:when>
    			<c:otherwise>
    				${lawReasonInfo.reparationLiabilityReason}		
    			</c:otherwise>
    		</c:choose>    		
    	</td>
    </tr>
</table>
<table id="table_law_reason_edit" style="display:none;border: 0px;">
    <tr>
    	<td>
    		<button class="btn_pop_law" id="btn_pop_law" type="button" style="width:84px; padding-top: 16px; padding-bottom: 16px; padding-left: 1px; padding-right: 1px;">항목선택</button>
    		<input style="width:550px;" type="text" id="reparation_liability_reason" name="reparation_liability_reason" maxlength="100" value="${lawReasonInfo.reparationLiabilityReason}">
    	</td>
    </tr>                             
</table>    
            
<script type="text/javascript">
$(document).ready(function(){
		
	if( 'edit' ==  '${viewType}' ){		//수정 페이지 인경우		
		$("#table_law_reason_view").hide();
		$("#table_law_reason_edit").show();
		
		$("#btn_law_reason_edit").hide();
		$("#btn_law_reason_save").show();
		$("#btn_law_reason_cancel").show();
	}else{										//보기 페이지 인경우		
		$("#table_law_reason_view").show();
		$("#table_law_reason_edit").hide();
		
		$("#btn_law_reason_edit").show();
		$("#btn_law_reason_save").hide();
		$("#btn_law_reason_cancel").hide();
	}
	
	$("#btn_pop_law").on("click", function () {
    	fnOpenLawModal();
    });
	
});
</script>