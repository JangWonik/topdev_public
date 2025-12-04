<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<table>	
	<tr id="report_office_1_view">
		<c:choose>			
			<c:when test="${reportOfficeList1.size() == 0 }">								
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
						<a href="#noloc" onclick="fnOffice1Update();"><img src='./resources/ls_img/btn_edite.gif'></a>
					</td>				
			</c:when>
			<c:otherwise>
				<c:forEach var="item" items="${reportOfficeList1}" varStatus="status">
					<td width="20%" style="text-align:center;">
		    			${item.writeDate1Fmt}
		    		</td>
		    		<td width="55%">    			
						<c:if test="${!empty item.checkDate1}">
							<div style="padding:5px,0,0,5px;">
							- 신고일시 : ${item.checkDate1}
							</div>
						</c:if>
						<c:if test="${!empty item.occurSpot1}">
							<div style="padding:5px,0,0,5px;">
							- 발생장소 : ${item.occurSpot1}
							</div>
						</c:if>
						<c:if test="${!empty item.occurType1}">
							<div style="padding:5px,0,0,5px;">
							- 발생유형 : ${item.occurType1}
							</div>
						</c:if>
						<c:if test="${!empty item.disaster1}">
							<div style="padding:5px,0,0,5px;">
							- 재해경위 : ${item.disaster1}
							</div>
						</c:if>
						<c:if test="${!empty item.transHospital1}">
							<div style="padding:5px,0,0,5px;">
							- 후송병원 : ${item.transHospital1}
							</div>
						</c:if>
					</td>
					<td width="15%">
		    			${item.remarkContent1}
		    		</td>
		    		<td  width="10%" style="text-align: center">
		            	<a href="#noloc" onclick="fnOffice1Update();"><img src='./resources/ls_img/btn_edite.gif'></a>
					</td>
				</c:forEach>
			</c:otherwise>			
		</c:choose>
		</tr>
		
		<tr id="report_office_1_edit" style="display:none;">
			<c:choose>			
				<c:when test="${reportOfficeList1.size() == 0 }">								
					<td width="20%" style="text-align:center;">
						<input type="text" id="office_write_date_1" class="calendar" style="width:90px;"/>
					</td>
					<td width="55%">
						<table>
	           				<tr>
		      					<td width="20%" style="background-color:#ececec;text-align:center">신고일시</td>
		      					<td width="80%"><input type="text" id="check_date_1" style="width:260px;" /></td>
	      					</tr>
	      					<tr>
		      					<td width="20%" style="background-color:#ececec;text-align:center">발생장소</td>
		      					<td width="80%"><input type="text" id="occur_spot_1" style="width:260px;" /></td>
	      					</tr>
	      					<tr>
		      					<td width="20%" style="background-color:#ececec;text-align:center">발생유형</td>
		      					<td width="80%"><input type="text" id="occur_type_1" style="width:260px;" /></td>
	      					</tr>
	      					<tr>
		      					<td width="20%" style="background-color:#ececec;text-align:center">재해경위</td>
		      					<td width="80%"><input type="text" id="disaster_1" style="width:260px;" /></td>
	      					</tr>
	      					<tr>
		      					<td width="20%" style="background-color:#ececec;text-align:center">후송병원</td>
		      					<td width="80%"><input type="text" id="trans_hospital_1" style="width:260px;" /></td>
	      					</tr>	      					
	      				</table>
					</td>
					<td width="15%">
						<input type="text" id="office_remark_content_1" style="width:80px;" />
					</td>
					<td  width="10%" style="text-align: center">
						<a href="#noloc" onclick="fnOffice1ModifySave();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
               			<a href="#noloc" onclick="fnGetReportOffice1();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
					</td>				
				</c:when>
				<c:otherwise>
					<c:forEach var="item" items="${reportOfficeList1}" varStatus="status">
						<td width="20%" style="text-align:center;">
			    			<input type="text" id="office_write_date_1" class="calendar" style="width:90px;" value="${item.writeDate1Fmt}" />
			    		</td>
			    		<td width="55%">    			
							<table>
		           				<tr>
			      					<td width="20%" style="background-color:#ececec;text-align:center">신고일시</td>
			      					<td width="80%"><input type="text" id="check_date_1" style="width:260px;" value="${item.checkDate1}"/></td>
			      				</tr>
		      					<tr>
			      					<td width="20%" style="background-color:#ececec;text-align:center">발생장소</td>
			      					<td width="80%"><input type="text" id="occur_spot_1" style="width:260px;" value="${item.occurSpot1}" /></td>
		      					</tr>
		      					<tr>
			      					<td width="20%" style="background-color:#ececec;text-align:center">발생유형</td>
			      					<td width="80%"><input type="text" id="occur_type_1" style="width:260px;" value="${item.occurType1}" /></td>
		      					</tr>
		      					<tr>
			      					<td width="20%" style="background-color:#ececec;text-align:center">재해경위</td>
			      					<td width="80%"><input type="text" id="disaster_1" style="width:260px;" value="${item.disaster1}" /></td>
		      					</tr>
		      					<tr>
			      					<td width="20%" style="background-color:#ececec;text-align:center">후송병원</td>
			      					<td width="80%"><input type="text" id="trans_hospital_1" style="width:260px;" value="${item.transHospital1}" /></td>
		      					</tr>		      					
		      				</table>
						</td>
						<td width="15%">
							<input type="text" id="office_remark_content_1" style="width:80px;" value="${item.remarkContent1}" />			    			
			    		</td>
			    		<td  width="10%" style="text-align: center">
			            	<a href="#noloc" onclick="fnOffice1ModifySave();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                			<a href="#noloc" onclick="fnGetReportOffice1();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
						</td>
					</c:forEach>
				</c:otherwise>			
			</c:choose>
		</tr>            	
</table>