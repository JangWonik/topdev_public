<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<table>	
	<tr>
		<th width="90%" style="text-align:left;padding-left:5px;">확인사항 안내</th>
		<th width="10%">-</th>
	</tr>
	<tr id="report_office_5_view">
	<c:choose>
	<c:when test="${reportOfficeList5.size() == 0 }">	
		<td width="90%">
			- 수정버튼을 눌러 정보를 입력해주세요.
		</td>
		<td  width="10%" style="text-align: center">
			<a href="#noloc" onclick="fnOffice5Update();"><img src='./resources/ls_img/btn_edite.gif'></a>
		</td>	
	</c:when>
	<c:otherwise>
		<c:forEach var="item" items="${reportOfficeList5}" varStatus="status">			
    		<td width="90%">						
				<c:if test="${!empty item.confirmContent5}">
					<div style="padding:5px,0,0,5px;">
					${fn:replace(item.confirmContent5,LF,'<br/>')}
					</div>
				</c:if>						
			</td>			
    		<td  width="10%" style="text-align: center">
            	<a href="#noloc" onclick="fnOffice5Update();"><img src='./resources/ls_img/btn_edite.gif'></a>
			</td>
		</c:forEach>		
	</c:otherwise>
	</c:choose>
	</tr>
	
	<tr id="report_office_5_edit" style="display:none;">
		<td>
			<table style="background-color:#ECECEC;">
				<tr>
					<td>
						<input type="radio" name="etc5_radio_type"  id="etc5_radio_type1" value="1"> 피보험자측에게 상기 확인내용에 대해 설명, 안내하고, 최종 결정은 OOOOO보험에서 검토후 처리됨을 안내하자 잘 알겠다는 입장. 
					</td>               						
				</tr>
				<tr>
					<td>
						<input type="radio" name="etc5_radio_type" id="etc5_radio_type2" value="2"> 직접입력
					</td>
				</tr>
			</table>
				<c:choose>
					<c:when test="${reportOfficeList5.size() == 0 }">				
							<textarea id="confirm_content_5" style="height: 50px;"></textarea>									
					</c:when>
					<c:otherwise>
						<c:forEach var="item" items="${reportOfficeList5}" varStatus="status">										
							<textarea id="confirm_content_5" style="height: 100px;">${item.confirmContent5}</textarea>					    		
						</c:forEach>		
				</c:otherwise>
			</c:choose>		
		</td>
		<td rowspan="2" width="10%" style="text-align: center">
			<a href="#noloc" onclick="fnOffice5ModifySave();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
            <a href="#noloc" onclick="fnGetReportOffice5();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
		</td>		
	</tr>	
</table>
<script type="text/javascript">
$(document).ready(function() {
	//기타 특이사항 라디오버튼 
  	$("#etc5_radio_type1").click(function(){  		
  		$("#confirm_content_5").val("피보험자측에게 상기 확인내용에 대해 설명, 안내하고, 최종 결정은 OOOOO보험에서 검토후 처리됨을 안내하자 잘 알겠다는 입장.");
  	});
  	
  	//기타 특이사항 라디오버튼
  	$("#etc5_radio_type2").click(function(){  		
  		$("#confirm_content_5").val("");
  		$("#confirm_content_5").attr('placeholder','직접입력하세요.');
  	});
});
</script>