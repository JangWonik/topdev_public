<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<table>	
	<tr id="report_office_2_view">
		<c:choose>			
			<c:when test="${reportOfficeList2.size() == 0 }">								
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
						<a href="#noloc" onclick="fnOffice2Update();"><img src='./resources/ls_img/btn_edite.gif'></a>
					</td>				
			</c:when>
			<c:otherwise>
				<c:forEach var="item" items="${reportOfficeList2}" varStatus="status">
					<td width="20%" style="text-align:center;">
		    			${item.writeDate2Fmt}
		    		</td>
		    		<td width="55%">    			
						<c:if test="${!empty item.personalInfo2}">
							<div style="padding:5px,0,0,5px;">
							- 인적사항 : ${item.personalInfo2}
							</div>
						</c:if>
						<c:if test="${!empty item.hireDate2Fmt}">
							<div style="padding:5px,0,0,5px;">
							- 채용일자 : ${item.hireDate2Fmt}
							</div>
						</c:if>
						<c:if test="${!empty item.hireType2}">
							<div style="padding:5px,0,0,5px;">
							- 채용직종 : ${item.hireType2}
							</div>
						</c:if>
						<c:if test="${!empty item.officeName2}">
							<div style="padding:5px,0,0,5px;">
							- 사업장명 : ${item.officeName2}
							</div>
						</c:if>
						<c:if test="${!empty item.disasterDate2Fmt}">
							<div style="padding:5px,0,0,5px;">
							- 재해일자 : ${item.disasterDate2Fmt}
							</div>
						</c:if>						
						<c:if test="${!empty item.disasterType2}">
							<div style="padding:5px,0,0,5px;">
							- 재해유형 : ${item.disasterType2}
							</div>
						</c:if>
						<c:if test="${!empty item.disasterContent2}">
							<div style="padding:5px,0,0,5px;">
							- 재해경위 : ${fn:replace(item.disasterContent2,LF,'<br/>')}
							</div>
						</c:if>
						<c:if test="${!empty item.obstacleLevel2}">
							<div style="padding:5px,0,0,5px;">
							- 장해등급 : ${item.obstacleLevel2}
							</div>
						</c:if>
						<c:if test="${!empty item.option2}">
							<div style="padding:5px,0,0,5px;">
							- 기타사항 : ${fn:replace(item.option2,LF,'<br/>')}
							</div>
						</c:if>
					</td>
					<td width="15%">
		    			${item.remarkContent2}
		    		</td>
		    		<td  width="10%" style="text-align: center">
		            	<a href="#noloc" onclick="fnOffice2Update();"><img src='./resources/ls_img/btn_edite.gif'></a>
					</td>
				</c:forEach>
			</c:otherwise>			
		</c:choose>
		</tr>
		
		<tr id="report_office_2_edit" style="display:none;">
			<c:choose>			
				<c:when test="${reportOfficeList2.size() == 0 }">								
					<td width="20%" style="text-align:center;">
						<input type="text" id="office_write_date_2" class="calendar" style="width:90px;"/>
					</td>
					<td width="55%">
						<table>
	           				<tr>
		      					<td width="20%" style="background-color:#ececec;text-align:center">인적사항</td>
		      					<td width="80%"><input type="text" id="personal_info_2" style="width:260px;" /></td>
	      					</tr>
	      					<tr>
		      					<td width="20%" style="background-color:#ececec;text-align:center">채용일자</td>
		      					<td width="80%"><input type="text" id="hire_date_2" class="calendar" style="width:90px;" /></td>
	      					</tr>
	      					<tr>
		      					<td width="20%" style="background-color:#ececec;text-align:center">채용직종</td>
		      					<td width="80%"><input type="text" id="hire_type_2" style="width:260px;" /></td>
	      					</tr>
	      					<tr>
		      					<td width="20%" style="background-color:#ececec;text-align:center">사업장명</td>
		      					<td width="80%"><input type="text" id="office_name_2" style="width:260px;" /></td>
	      					</tr>
	      					<tr>
		      					<td width="20%" style="background-color:#ececec;text-align:center">재해일자</td>
		      					<td width="80%"><input type="text" id="disaster_date_2" class="calendar" style="width:90px;" /></td>
	      					</tr>
	      					<tr>
		      					<td width="20%" style="background-color:#ececec;text-align:center">재해유형</td>
		      					<td width="80%"><input type="text" id="disaster_type_2" style="width:260px;" /></td>
	      					</tr>
	      					<tr>
		      					<td width="20%" style="background-color:#ececec;text-align:center">재해경위</td>
		      					<td width="80%"><textarea id="disaster_content_2" style="height: 50px;"></textarea></td>
	      					</tr>
	      					<tr>
		      					<td width="20%" style="background-color:#ececec;text-align:center">장해등급</td>
		      					<td width="80%"><input type="text" id="obstacle_level_2" style="width:260px;" /></td>
	      					</tr>
	      					<tr>
		      					<td width="20%" style="background-color:#ececec;text-align:center">기타사항</td>
		      					<td width="80%"><textarea id="option_2" style="height: 50px;"></textarea></td>
	      					</tr>	      					
	      				</table>
					</td>
					<td width="15%">
						<input type="text" id="office_remark_content_2" style="width:80px;" />
					</td>
					<td  width="10%" style="text-align: center">
						<a href="#noloc" onclick="fnOffice2ModifySave();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
               			<a href="#noloc" onclick="fnGetReportOffice2();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
					</td>				
				</c:when>
				<c:otherwise>
					<c:forEach var="item" items="${reportOfficeList2}" varStatus="status">
						<td width="20%" style="text-align:center;">
							<input type="text" id="office_write_date_2" class="calendar" style="width:90px;" value="${item.writeDate2Fmt}"/>			    			
			    		</td>
			    		<td width="55%">    			
							<table>
							<!-- 여기부터해라 -->
		           				<tr>
			      					<td width="20%" style="background-color:#ececec;text-align:center">인적사항</td>
			      					<td width="80%"><input type="text" id="personal_info_2" style="width:260px;" value="${item.personalInfo2}"/></td>
		      					</tr>
		      					<tr>
			      					<td width="20%" style="background-color:#ececec;text-align:center">채용일자</td>
			      					<td width="80%"><input type="text" id="hire_date_2" class="calendar" style="width:90px;" value="${item.hireDate2Fmt}"/></td>
		      					</tr>
		      					<tr>
			      					<td width="20%" style="background-color:#ececec;text-align:center">채용직종</td>
			      					<td width="80%"><input type="text" id="hire_type_2" style="width:260px;" value="${item.hireType2}"/></td>
		      					</tr>
		      					<tr>
			      					<td width="20%" style="background-color:#ececec;text-align:center">사업장명</td>
			      					<td width="80%"><input type="text" id="office_name_2" style="width:260px;" value="${item.officeName2}"/></td>
		      					</tr>
		      					<tr>
			      					<td width="20%" style="background-color:#ececec;text-align:center">재해일자</td>
			      					<td width="80%"><input type="text" id="disaster_date_2" class="calendar" style="width:90px;" value="${item.disasterDate2Fmt}"/></td>
		      					</tr>
		      					<tr>
			      					<td width="20%" style="background-color:#ececec;text-align:center">재해유형</td>
			      					<td width="80%"><input type="text" id="disaster_type_2" style="width:260px;" value="${item.disasterType2}"/></td>
		      					</tr>
		      					<tr>
			      					<td width="20%" style="background-color:#ececec;text-align:center">재해경위</td>
			      					<td width="80%"><textarea id="disaster_content_2" style="height: 50px;">${item.disasterContent2}</textarea></td>
		      					</tr>
		      					<tr>
			      					<td width="20%" style="background-color:#ececec;text-align:center">장해등급</td>
			      					<td width="80%"><input type="text" id="obstacle_level_2" style="width:260px;" value="${obstacleLevel2}"/></td>
		      					</tr>
		      					<tr>
			      					<td width="20%" style="background-color:#ececec;text-align:center">기타사항</td>
			      					<td width="80%"><textarea id="option_2" style="height: 50px;">${option2}</textarea></td>
		      					</tr>		      					
		      				</table>
						</td>
						<td width="15%">							
							<input type="text" id="office_remark_content_2" style="width:80px;" value="${item.remarkContent2}"/>			    			
			    		</td>
			    		<td  width="10%" style="text-align: center">
			            	<a href="#noloc" onclick="fnOffice2ModifySave();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                			<a href="#noloc" onclick="fnGetReportOffice2();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
						</td>
					</c:forEach>
				</c:otherwise>			
			</c:choose>
		</tr>            	
</table>