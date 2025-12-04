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
                   <col width="15%">
                   <col width="85%">
                <tr>
                    <th>사&nbsp;&nbsp;고&nbsp;&nbsp;일&nbsp;&nbsp;자</th>
                    <td style="text-align: left;">&nbsp;${rptIssueMain.accidentDate5}</td>
                </tr> 
                <tr>
                    <th>사&nbsp;&nbsp;고&nbsp;&nbsp;내&nbsp;&nbsp;용</th>
                    <td style="text-align: left;">
               		&nbsp;${fn:replace(fn:replace(fn:escapeXml(rptIssue.insuContent) , CRLF , '<br>'), ' ', '&nbsp;')}
                    </td>
                </tr>                 
            </table>
            
            <table id="table_accident_edit" style="display:none;">
                <col width="15%">
                <col width="85%">
                <tr>
                    <th>사&nbsp;&nbsp;고&nbsp;&nbsp;일&nbsp;&nbsp;자</th>
                    <td style="text-align: left;"><input type="text" class="calendar" id="accident_date_2" value="${rptIssueMain.accidentDate4}" style="width:90px;" maxlength="10"></td> 
  				   
                </tr>
                <tr>
                   <th>사&nbsp;&nbsp;고&nbsp;&nbsp;내&nbsp;&nbsp;용</th>
 					<td style="text-align: left;">			  		
 							<select id="selbox" name="selbox" style="margin-bottom: 5px;">
  								<option value="${rptIssue.insuContent}">선택하세요</option>
                            	<option value="direct">직접입력</option>
	                            <option value="건강정보 등의 민간정보가 포함되어 보험업법 시행령 제99조에 의거 이를 제외하고 교부합니다.">건강정보 등의 민간정보가 포함되어 보험업법 시행령 제99조에 의거 이를 제외하고 교부합니다.</option>
                        	</select> 
                         	<textarea id=insu_content rows="5">${fn:replace(fn:replace(rptIssue.insuContent , '<br>', CRLF), ' ', '&nbsp;')}</textarea> 
					</td>	                  
                     <td>
                    	<%-- <textarea id="accident_facts" rows="5">${rptIssueMain.accidentFacts}</textarea> --%>
<%--  						<textarea id="insu_content" rows="5">${rptIssue.insuContent}</textarea> --%>
                   	</td>
                </tr>
            </table>
<%--             <table id="table_accident_view">
                <col width="17%">
                <col width="2%">
                <col width="81%">
                <tr>
                    <th>가. 사 고 일 자3</th>
                    <td>:</td>
                    <td>${rptIssueMain.accidentDate5}</td>
                </tr>
                <tr>
                    <th>나. 사 고 내 용</th>
                    <td>:</td>
                    <td>
                    	${fn:replace(fn:replace(fn:escapeXml(rptIssueMain.accidentFacts) , CRLF , '<br>'), ' ', '&nbsp;')}
						${fn:replace(fn:replace(fn:escapeXml(rptIssue.insuContent) , CRLF , '<br>'), ' ', '&nbsp;')}
							
                   	</td>
                    
                </tr>
            </table>
            
            <table id="table_accident_edit" style="display:none;">
                <col width="18%">
                <col width="82%">
                <tr>
                    <th>가. 사 고 일 자4</th>
                    <td><input type="text" class="calendar" id="accident_date_2" value="${rptIssueMain.accidentDate4}" style="width:90px;" maxlength="10"></td> 
                </tr>
                <tr>
                   <th>나. 사 고 내 용</th>
  					<td>			  		
 							<select id="selbox" name="selbox" style="margin-bottom: 5px;">
 								<option value="">선택하세요</option>
                            	<option value="direct">직접입력</option>
	                            <option value="건강정보 등의 민간정보가 포함되어 보험업법 시행령 제99조에 의거 이를 제외하고 교부합니다.">건강정보 등의 민간정보가 포함되어 보험업법 시행령 제99조에 의거 이를 제외하고 교부합니다.</option>
                        	</select> 
<!-- 							<input type="text" id="selboxDirect" name="selboxDirect"/> -->
                         	<textarea id=insu_content rows="5">${fn:replace(fn:replace(rptIssue.insuContent , '<br>', CRLF), ' ', '&nbsp;')}</textarea> 

					</td>          
                    <td>
                    	<textarea id="accident_facts" rows="5">${rptIssue.rptissueComment}</textarea>
                    	<textarea id="insu_content" rows="5">${rptIssue.insuContent}</textarea>
                   	</td>
                </tr>
            </table> --%>