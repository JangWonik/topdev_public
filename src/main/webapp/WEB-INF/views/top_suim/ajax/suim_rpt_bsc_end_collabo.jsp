<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="true" %>
<c:choose>	
	<c:when test="${ suimRptType1 eq 14 or suimRptType1 eq 15 or suimRptType1 eq 16 or suimRptType1 eq 17 or suimRptType1 eq 18}">
		<c:forEach items="${collaboList}" var="item" varStatus="status">
			<fmt:parseNumber var="written_cnt" value="${item.writtenCnt}"/>
			<fmt:parseNumber var="written_basic" value="${item.writtenBasic}"/>			
			<c:if test="${!status.first}">					
				<tr>
					<td colspan="2" style="border:0px !important; padding: 1px 0 1px 0 !important;"></td>
				</tr>
			</c:if>												
			<c:choose>
					<c:when test="${ written_cnt == 0 and written_basic == 0}">
						<tr>
							<td bgcolor="#E7ECF1"><b>ㆍ공동수행자</b></td>
							<td>
								${item.userName}
								<c:if test="${(authMap.suimRptState eq '0' and authMap.editYN > 0) or (authMap.endModFlag > 0) }">								
									<img src="./resources/ls_img/btn_del_s.gif" onclick="fnDeleteCollabo('${item.serialNo}');" style='cursor:pointer; float:right; margin-right:20px;'/>
								</c:if>								
							</td>
							
							<td bgcolor="#E7ECF1"><b>ㆍ공동수행율</b></td>
							<td>
								${item.collaboPp} %
							</td>
						</tr>
						<tr>
							<td bgcolor="#E7ECF1"><b>ㆍ공동수행 일비</b></td>
							<td>
								<c:choose>
									<c:when test="${item.collaboDailyType eq '0' }">
										${item.collaboDaily} %
									</c:when>
									<c:otherwise>
										<fmt:formatNumber value="${item.collaboDaily}" pattern="###,###,##0.##"/> 원
									</c:otherwise>
								</c:choose>
							</td>
							<td bgcolor="#E7ECF1"><b>ㆍ공동수행 교통비</b></td>
							<td>
								<fmt:formatNumber value="${item.collaboTraffic}" pattern="###,###,##0.##"/> 원
							</td>
						</tr>
					</c:when>
					<c:otherwise>
						<tr>
							<td bgcolor="#E7ECF1"><b>ㆍ공동수행자</b></td>
							<td>
								${item.userName}
								<c:if test="${(authMap.suimRptState eq '0' and authMap.editYN > 0) or (authMap.endModFlag > 0) }">
									<img src="./resources/ls_img/btn_del_s.gif" onclick="fnDeleteCollabo('${item.serialNo}');" style='cursor:pointer; float:right; margin-right:20px;'/>
								</c:if>								
							</td>
							
							<td bgcolor="#E7ECF1"><b>ㆍ공동(종결) 건수</b></td>
							<td>
								${item.writtenCnt} 건
							</td>
						</tr>
						<tr>
							<td bgcolor="#E7ECF1"><b>ㆍ공동(기본) 보수</b></td>
							<td>
								<fmt:formatNumber value="${item.writtenBasic}" pattern="###,###,##0.##"/> 원
							</td>
							<td bgcolor="#E7ECF1"></td>
							<td>										
							</td>
						</tr>
					</c:otherwise>		
			</c:choose>
							
		</c:forEach>
	</c:when>

	<c:when test="${ suimRptType1 ne 3 and suimRptType1 ne 4 }">
		<c:forEach items="${collaboList}" var="item" varStatus="status">
			<c:if test="${!status.first}">					
				<tr>
					<td colspan="2" style="border:0px !important; padding: 1px 0 1px 0 !important;"></td>
				</tr>
			</c:if>
							
			<tr>
				<td bgcolor="#E7ECF1"><b>ㆍ공동수행자</b></td>
				<td>
					${item.userName}
					<c:if test="${(authMap.suimRptState eq '0' and authMap.editYN > 0) or (authMap.endModFlag > 0) }">
						<img src="./resources/ls_img/btn_del_s.gif" onclick="fnDeleteCollabo('${item.serialNo}');" style='cursor:pointer; float:right; margin-right:20px;'/>
					</c:if>								
				</td>
				
				<td bgcolor="#E7ECF1"><b>ㆍ공동수행율</b></td>
				<td>
					${item.collaboPp} %
				</td>
			</tr>
			<tr>
				<td bgcolor="#E7ECF1"><b>ㆍ공동수행 기본보수</b></td>
				<td colspan="3">
					<c:choose>
						<c:when test="${item.collaboPriceType eq '0' }">
							${item.collaboPrice} %
						</c:when>
						<c:otherwise>
							<fmt:formatNumber value="${item.collaboPrice}" pattern="###,###,##0.##"/> 원
						</c:otherwise>
					</c:choose>
				</td>				
			</tr>
			<tr>
				<td bgcolor="#E7ECF1"><b>ㆍ공동수행 일비</b></td>
				<td colspan="3">
					<c:choose>
						<c:when test="${item.collaboDailyType eq '0' }">
							${item.collaboDaily} %
						</c:when>
						<c:otherwise>
							<fmt:formatNumber value="${item.collaboDaily}" pattern="###,###,##0.##"/> 원
						</c:otherwise>
					</c:choose>
				</td>				
			</tr>
			<tr>
				<td bgcolor="#E7ECF1"><b>ㆍ공동수행 교통비</b></td>
				<td colspan="3">
					<fmt:formatNumber value="${item.collaboTraffic}" pattern="###,###,##0.##"/> 원
				</td>
			</tr>
		</c:forEach>
	</c:when>
	
	<c:otherwise>
		<c:forEach items="${collaboList}" var="item" varStatus="status">
			<c:if test="${!status.first}">					
				<tr>
					<td colspan="2" style="border:0px !important; padding: 1px 0 1px 0 !important;"></td>
				</tr>
			</c:if>
							
			<tr>
				<td bgcolor="#E7ECF1"><b>ㆍ공동수행자</b></td>
				<td>
					${item.userName}
				</td>
				
				<td bgcolor="#E7ECF1"><b>ㆍ공동수행금액</b></td>
				<td>
					${item.collaboPp} 원
					<c:if test="${(authMap.suimRptState eq '0' and authMap.editYN > 0) or (authMap.endModFlag > 0) }">
						<img src="./resources/ls_img/btn_del_s.gif" onclick="fnDeleteCollabo('${item.serialNo}');" style='cursor:pointer; float:right; margin-right:20px;'/>
					</c:if>
				</td>
			</tr>
		</c:forEach>					
	</c:otherwise>
</c:choose>