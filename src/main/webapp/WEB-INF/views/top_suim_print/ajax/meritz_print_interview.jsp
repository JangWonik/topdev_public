<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
        		<table>
      				<colgroup>
       					<col width="20%" />
       					<col width="80%" />
       				</colgroup>
        			<thead>
	        			<tr>
	        				<th>구분</th>
	        				<th>쟁점사항</th>
	        			</tr>
        			</thead>
        			<tbody class="meritz_interview_view">
        				<tr>
        					<td style="text-align: center">
        						피보험자
        						<br/>(or 유가족 면담사항)
       						</td>
        					<td>
       							${fn:replace(fn:replace(rptBasic.faceMemo7 , CRLF , '<br>'), ' ', '&nbsp;')}
       						</td>
        				</tr>
        				<tr>
        					<td style="text-align: center">
        						독립손사
        						<br/>(세부정보포함)
       						</td>
        					<td>
        						${fn:replace(fn:replace(rptBasic.delegate7 , CRLF , '<br>'), ' ', '&nbsp;')}
       						</td>
        				</tr>
        				<tr>
        					<td style="text-align: center">
        						탐문내용
       						</td>
        					<td>
        						${fn:replace(fn:replace(rptBasic.questioning7 , CRLF , '<br>'), ' ', '&nbsp;')}
       						</td>
        				</tr>
        				<tr>
        					<td style="text-align: center">
        						안내 및 특이사항
       						</td>
        					<td>
        						${fn:replace(fn:replace(rptBasic.guideEtc7 , CRLF , '<br>'), ' ', '&nbsp;')}
       						</td>
        				</tr>
        				<tr>
        					<td style="text-align: center">
        						추가서류창구
       						</td>
        					<td>
        						${fn:replace(fn:replace(rptBasic.moreDocument7 , CRLF , '<br>'), ' ', '&nbsp;')}
       						</td>
        				</tr>        				
        			</tbody>
        			
        			<tbody class="meritz_interview_edit" style="display: none;">
        				<tr>
        					<td style="text-align: center">
        						피보험자
        						<br/>(or 유가족 면담사항)
       						</td>
        					<td>
        						<textarea id="face_memo" rows="5">${fn:replace(fn:replace(rptBasic.faceMemo7 , '<br>', CRLF), ' ', '&nbsp;')}</textarea>
       						</td>
        				</tr>
        				<tr>
        					<td style="text-align: center">
        						독립손사
        						<br/>(세부정보포함)
       						</td>
        					<td>
        						<textarea id="delegate" rows="5">${fn:replace(fn:replace(rptBasic.delegate7 , '<br>', CRLF), ' ', '&nbsp;')}</textarea>
       						</td>
        				</tr>
        				<tr>
        					<td style="text-align: center">
        						탐문내용
       						</td>
        					<td>
        						<textarea id="questioning" rows="5">${fn:replace(fn:replace(rptBasic.questioning7 , '<br>', CRLF), ' ', '&nbsp;')}</textarea>
       						</td>
        				</tr>
        				<tr>
        					<td style="text-align: center">
        						안내 및 특이사항
       						</td>
        					<td>
        						<textarea id="guide_etc" rows="5">${fn:replace(fn:replace(rptBasic.guideEtc7 , '<br>', CRLF), ' ', '&nbsp;')}</textarea>
       						</td>
        				</tr>
        				<tr>
        					<td style="text-align: center">
        						추가서류창구
       						</td>
        					<td>
        						<textarea id="more_document" rows="5">${fn:replace(fn:replace(rptBasic.moreDocument7 , '<br>', CRLF), ' ', '&nbsp;')}</textarea>
       						</td>
        				</tr>        	        			
        			</tbody>
        		</table>