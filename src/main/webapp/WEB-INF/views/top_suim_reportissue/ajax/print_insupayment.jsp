<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
        	<table id="table_insupayment_view">
	            	<tr>
	                    <th>
	                    	<c:choose>
	                    		<c:when test="${rptIssueMain.amtInsuPaymentDisable eq 1}">
	                    			<!-- 협의금액에 따름 -->단체 사고의 경우 개별 안내 금액에 따름
	                    		</c:when>
	                    		<c:otherwise>
	                    			￦ <span class="money">${rptIssueMain.amtInsuPayment}</span>		
	                    		</c:otherwise>
	                    	</c:choose>
	                   	</th>
	                </tr>
	            </table>
	            
	            <table id="table_insupayment_edit" style="display:none;">
	                <tr>
	                    <td>
	                    	<c:choose>
	                    		<c:when test="${rptIssueMain.amtInsuPaymentDisable eq 1}">
	                    			<input type="checkbox" id="insupayment_disable" checked /> 단체 사고의 경우 개별 안내 금액에 따름<br/>
	                    			<input class="money"  type="text" id="amt_insu_payment" value="${rptIssueMain.amtInsuPayment}" readonly style="background-color:#e2e2e2;">
	                    		</c:when>
	                    		<c:otherwise>
	                    			<input type="checkbox" id="insupayment_disable"/> 단체 사고의 경우 개별 안내 금액에 따름<br/>
	                    			<input class="money"  type="text" id="amt_insu_payment" value="${rptIssueMain.amtInsuPayment}">		
	                    		</c:otherwise>
	                    	</c:choose>	                    	
	                   	</td> 
	                </tr>
	            </table>
<script>
//지급보험금 옵션처리
$("#insupayment_disable").click( function(){
	if( $('input:checkbox[id="insupayment_disable"]').is(":checked") ){			//체크				
		$("#amt_insu_payment").prop('readonly','true');
		$("#amt_insu_payment").attr('style','background-color:#e2e2e2;');
	}else{			//체크해제				
		$("#amt_insu_payment").prop('readonly','');
		$("#amt_insu_payment").attr('style','background-color:#FFFFFF;');
	}			
});
</script>