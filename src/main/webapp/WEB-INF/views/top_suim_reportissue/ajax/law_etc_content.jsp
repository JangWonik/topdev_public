<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
	.law_etc_content tr th {padding: 4px 0px 4px 0px; border: 1px solid; background-color: #E7ECF1; text-align: center; vertical-align:middle; font-weight: normal;}
	.law_etc_content tr td {border: 1px solid; text-align: center; vertical-align: middle;}
</style>
<table id="table_law_etc_content_view" class="law_etc_content" style="border: 1px solid">
    <tr>
    	<th style="width:15%;">관&nbsp;&nbsp;련&nbsp;&nbsp;법&nbsp;&nbsp;규</th>
    	<td style="width:35%;text-align:left;padding-left:5px;"><span id="law_subject_text">${lawEtcContentInfo.law_subject}</span></td>
    	<th style="width:15%;">관&nbsp;&nbsp;련&nbsp;&nbsp;약&nbsp;&nbsp;관</th>
    	<td style="width:35%;text-align:left;padding-left:5px;"><span id="law_etc_text">${lawEtcContentInfo.law_etc}</span></td>
    </tr>
</table>
<table id="table_law_etc_content_edit" class="law_etc_content" style="display:none;">
    <tr>
    	<th style="width:15%;">관&nbsp;&nbsp;련&nbsp;&nbsp;법&nbsp;&nbsp;규</th>
    	<td style="width:35%;"><input type="text" id="law_subject" name="law_subject" value="${lawEtcContentInfo.law_subject}" placeholder="예) 상법 750조, 상법 755조"/></td>
    	<th style="width:15%;">관&nbsp;&nbsp;련&nbsp;&nbsp;약&nbsp;&nbsp;관</th>
    	<td style="width:35%;"><input type="text" id="law_etc" name="law_etc" value="${lawEtcContentInfo.law_etc}" placeholder="예) 일상생활배상책임 특별약관"/></td>
    </tr>                             
</table>    
            
<script type="text/javascript">
$(document).ready(function(){
		
	if( 'edit' ==  '${viewType}' ){		//수정 페이지 인경우		
		$("#table_law_etc_content_view").hide();
		$("#table_law_etc_content_edit").show();
		
		$("#btn_law_content_edit").hide();
		$("#btn_law_content_save").show();
		$("#btn_law_content_cancel").show();
	}else{										//보기 페이지 인경우		
		$("#table_law_etc_content_view").show();
		$("#table_law_etc_content_edit").hide();
		
		$("#btn_law_content_edit").show();
		$("#btn_law_content_save").hide();
		$("#btn_law_content_cancel").hide();
	}
	
});
</script>