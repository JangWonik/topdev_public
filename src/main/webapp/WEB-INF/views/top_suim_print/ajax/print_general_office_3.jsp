<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<table>	
	<tr id="report_office_3_view">
		<c:choose>			
			<c:when test="${reportOfficeList3.size() == 0 }">								
					<td width="20%" style="text-align:center;">
						-
					</td>
					<td width="55%">
						- 수정버튼을 눌러 정보를 입력해주세요.
					</td>
					<td width="15%">
						-
					</td>
					<td  width="10%" style="text-align: center">
						<a href="#noloc" onclick="fnOffice3Update();"><img src='./resources/ls_img/btn_edite.gif'></a>
					</td>				
			</c:when>
			<c:otherwise>
				<c:forEach var="item" items="${reportOfficeList3}" varStatus="status">
					<td width="20%" style="text-align:center;">
		    			${item.writeDate3Fmt}
		    		</td>
		    		<td width="55%">    			
						<c:if test="${!empty item.occurDate3}">
							<div style="padding:5px,0,0,5px;">
							- 발생일시 : ${item.occurDate3}
							</div>
						</c:if>
						<c:if test="${!empty item.occurSpot3}">
							<div style="padding:5px,0,0,5px;">
							- 발생장소 : ${item.occurSpot3}
							</div>
						</c:if>
						<c:if test="${!empty item.deadDate3}">
							<div style="padding:5px,0,0,5px;">
							- 사망일시 : ${item.deadDate3}
							</div>
						</c:if>
						<c:if test="${!empty item.deadCause3}">
							<div style="padding:5px,0,0,5px;">
							- 사망원인 : ${item.deadCause3}
							</div>
						</c:if>
						<c:if test="${!empty item.agreeContent3}">
							<div style="padding:5px,0,0,5px;">
							- 협의내용 : ${fn:replace(item.agreeContent3,LF,'<br/>')}
							</div>
						</c:if>
						<c:if test="${!empty item.resultInfo3}">
							<div style="padding:5px,0,0,5px;">
							- 검안결과 : ${item.resultInfo3}
							</div>
						</c:if>
						<c:if test="${!empty item.resultComment3}">
							<div style="padding:5px,0,0,5px;">
							- 내사의견 : ${fn:replace(item.resultComment3,LF,'<br/>')}
							</div>
						</c:if>
						<c:if test="${!empty item.familyComment3}">
							<div style="padding:5px,0,0,5px;">
							- 유족진술 : ${fn:replace(item.familyComment3,LF,'<br/>')}
							</div>
						</c:if>
						<c:if test="${!empty item.option3}">
							<div style="padding:5px,0,0,5px;">
							- 기타사항 : ${fn:replace(item.option3,LF,'<br/>')}
							</div>
						</c:if>
					</td>
					<td width="15%">
		    			${item.remarkContent3}
		    		</td>
		    		<td  width="10%" style="text-align: center">
		            	<a href="#noloc" onclick="fnOffice3Update();"><img src='./resources/ls_img/btn_edite.gif'></a>
					</td>
				</c:forEach>
			</c:otherwise>			
		</c:choose>
		</tr>
		
		<tr id="report_office_3_edit" style="display:none;">
			<c:choose>			
				<c:when test="${reportOfficeList3.size() == 0 }">								
					<td width="20%" style="text-align:center;">
						<input type="text" id="office_write_date_3" class="calendar" style="width:90px;"/>
					</td>
					<td width="55%">
						<table>
							<tr>
		      					<td width="20%" style="background-color:#ececec;text-align:center">발생일시</td>
		      					<td width="80%"><input type="text" id="occur_date_3" style="width:260px;" /></td>
	      					</tr>
	      					<tr>
		      					<td width="20%" style="background-color:#ececec;text-align:center">발생장소</td>
		      					<td width="80%"><input type="text" id="occur_spot_3" style="width:260px;" /></td>
	      					</tr>
	      					<tr>
		      					<td width="20%" style="background-color:#ececec;text-align:center">사망일시</td>
		      					<td width="80%"><input type="text" id="dead_date_3" style="width:260px;" /></td>
	      					</tr>
	      					<tr>
		      					<td width="20%" style="background-color:#ececec;text-align:center">사망원인</td>
		      					<td width="80%"><input type="text" id="dead_cause_3" style="width:260px;" /></td>
	      					</tr>
							<tr>
		      					<td width="20%" style="background-color:#ececec;text-align:center">협의내용</td>
		      					<td width="80%"><textarea id="agree_content_3" style="height: 50px;"></textarea></td>
	      					</tr>
	      					<tr>
		      					<td width="20%" style="background-color:#ececec;text-align:center">검안결과</td>
		      					<td width="80%"><input type="text" id="result_info_3" style="width:260px;" /></td>
	      					</tr>
	      					<tr>
		      					<td width="20%" style="background-color:#ececec;text-align:center">내사의견</td>
		      					<td width="80%"><textarea id="result_comment_3" style="height: 50px;"></textarea></td>
	      					</tr>
	      					<tr>
		      					<td width="20%" style="background-color:#ececec;text-align:center">유족진술</td>
		      					<td width="80%"><textarea id="family_comment_3" style="height: 50px;"></textarea></td>
	      					</tr>
	      					<tr>
		      					<td width="20%" style="background-color:#ececec;text-align:center">기타사항</td>
		      					<td width="80%"><textarea id="option_3" style="height: 50px;"></textarea></td>
	      					</tr>	      										
	      				</table>
					</td>
					<td width="15%">
						<input type="text" id="office_remark_content_3" style="width:80px;" />
					</td>
					<td  width="10%" style="text-align: center">
						<a href="#noloc" onclick="fnOffice3ModifySave();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
               			<a href="#noloc" onclick="fnGetReportOffice3();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
					</td>				
				</c:when>
				<c:otherwise>
					<c:forEach var="item" items="${reportOfficeList3}" varStatus="status">
						<td width="20%" style="text-align:center;">
							<input type="text" id="office_write_date_3" class="calendar" style="width:90px;" value="${item.writeDate3Fmt}"/>			    			
			    		</td>
			    		<td width="55%">    			
							<table>
							<!-- 여기부터해라 -->
		           				<tr>
			      					<td width="20%" style="background-color:#ececec;text-align:center">발생일시</td>
			      					<td width="80%"><input type="text" id="occur_date_3" style="width:260px;" value="${item.occurDate3}"/></td>
		      					</tr>
		      					<tr>
			      					<td width="20%" style="background-color:#ececec;text-align:center">발생장소</td>
			      					<td width="80%"><input type="text" id="occur_spot_3" style="width:260px;" value="${item.occurSpot3}"/></td>
		      					</tr>
		      					<tr>
			      					<td width="20%" style="background-color:#ececec;text-align:center">사망일시</td>
			      					<td width="80%"><input type="text" id="dead_date_3" style="width:260px;" value="${item.deadDate3}"/></td>
		      					</tr>
		      					<tr>
			      					<td width="20%" style="background-color:#ececec;text-align:center">사망원인</td>
			      					<td width="80%"><input type="text" id="dead_cause_3" style="width:260px;" value="${item.deadCause3}"/></td>
		      					</tr>
								<tr>
			      					<td width="20%" style="background-color:#ececec;text-align:center">협의내용</td>
			      					<td width="80%"><textarea id="agree_content_3" style="height: 50px;">${item.agreeContent3}</textarea></td>
		      					</tr>
		      					<tr>
			      					<td width="20%" style="background-color:#ececec;text-align:center">검안결과</td>
			      					<td width="80%"><input type="text" id="result_info_3" style="width:260px;" value="${item.resultInfo3}"/></td>
		      					</tr>
		      					<tr>
			      					<td width="20%" style="background-color:#ececec;text-align:center">내사의견</td>
			      					<td width="80%"><textarea id="result_comment_3" style="height: 50px;">${item.resultComment3}</textarea></td>
		      					</tr>
		      					<tr>
			      					<td width="20%" style="background-color:#ececec;text-align:center">유족진술</td>
			      					<td width="80%"><textarea id="family_comment_3" style="height: 50px;">${item.familyComment3}</textarea></td>
		      					</tr>
		      					<tr>
			      					<td width="20%" style="background-color:#ececec;text-align:center">기타사항</td>
			      					<td width="80%"><textarea id="option_3" style="height: 50px;">${item.option_3}</textarea></td>
		      					</tr>	      					
		      				</table>
						</td>
						<td width="15%">							
							<input type="text" id="office_remark_content_3" style="width:80px;" value="${item.remarkContent3}"/>			    			
			    		</td>
			    		<td  width="10%" style="text-align: center">
			            	<a href="#noloc" onclick="fnOffice3ModifySave();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                			<a href="#noloc" onclick="fnGetReportOffice3();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
						</td>
					</c:forEach>
				</c:otherwise>			
			</c:choose>
		</tr>            	
</table>