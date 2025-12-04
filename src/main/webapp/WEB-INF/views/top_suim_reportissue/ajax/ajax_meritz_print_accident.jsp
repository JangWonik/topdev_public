<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
 <script type="text/javascript">
		 $(function(){
		     //직접입력 인풋박스 기존에는 숨어있다가
		$("#insu_content").hide();
		$("#selbox").change(function() {
				
		               //직접입력을 누를 때 나타남
				if($("#selbox").val() == "direct") {
					$("#insu_content").show();
				}  else {
					$("#insu_content").hide().val($(this).val());
					$("#insu_content").attr("readonly",ture);
				}
			}) 
		});
 
 
</script>           
<table id="table_accident_view">
	<tr>                    
		<td style="text-align: left;">
			&nbsp;${fn:replace(fn:replace(fn:escapeXml(rptIssue.insuContent) , CRLF , '<br>'), ' ', '&nbsp;')}
        </td>
    </tr>                 
</table>
<input type="hidden" id="accident_date_2" name="accident_date_2" value="${rptIssueMain.accidentDate4}">
<table id="table_accident_edit" style="display:none;">
	<tr>                   
		<td style="text-align: left;">			  		
			<select id="selbox" name="selbox" style="margin-bottom: 5px;">
				<option value="${rptIssue.insuContent}">선택하세요</option>
				<option value="direct">직접입력</option>
				<option value="건강정보 등의 민간정보가 포함되어 보험업법 시행령 제99조에 의거 이를 제외하고 교부합니다.">건강정보 등의 민간정보가 포함되어 보험업법 시행령 제99조에 의거 이를 제외하고 교부합니다.</option>
			</select> 
			<textarea id=insu_content rows="5">${fn:replace(fn:replace(rptIssue.insuContent , '<br>', CRLF), ' ', '&nbsp;')}</textarea> 
		</td>
	</tr>
</table>
        