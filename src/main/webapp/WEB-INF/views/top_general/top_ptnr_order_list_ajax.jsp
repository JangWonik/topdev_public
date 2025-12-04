<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<table>
<c:choose>						
	<c:when test="${companyList.size() != 0}">						
		<c:forEach items="${companyList}" var="item" varStatus="status">
			<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" style ="cursor:pointer;">														
				<td width="7%" class="td-overflow-none">${item.statistics_order}</td>
				<td width="13%" class="td-overflow-none">
					<c:choose>
						<c:when test="${item.statistics_order < 2}">
							<input class="buttonMini" style="background-color:#D8D8D8;" type="button" value="-">&nbsp;
						</c:when>
						<c:otherwise>
							<a href="javascript:doUpOrder('${item.ptnr_id}','${item.statistics_order}');">
								<input class="buttonMini" style="background-color:#F781D8;" type="button" value="&#9650;">&nbsp;
							</a>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${companyList.size() == status.count}">
							<input class="buttonMini" style="background-color:#D8D8D8;" type="button" value="-">&nbsp;
						</c:when>
						<c:otherwise>
							<a href="javascript:doDownOrder('${item.ptnr_id}','${item.statistics_order}');">
								<input class="buttonMini" style="background-color:#819FF7;" type="button" value="&#9660;">&nbsp;
							</a>			
						</c:otherwise>
					</c:choose>				
				</td>				
				<!-- 로고 -->
				<td width="14%" class="td-overflow-none" onclick="javascript:openCompanyDetailView(${item.ptnr_id});">
					<c:choose>
						<c:when test="${not empty item.ptnr_img_small}">							
							<img src="https://www.toplac.co.kr/home/hosting_users/toplac/www/ls_data/ig/small/${item.ptnr_img_small}" width="75px" height="15px" border=0>
						</c:when>
						<c:otherwise> - </c:otherwise>
					</c:choose>					
				</td>
				<!-- 회사명 -->
				<td width="30%" class="td-overflow-none">${item.ptnr_name}</td>
				<!-- 회사구분 -->														
				<td width="9%" class="td-overflow-none">
					<c:choose>
						<c:when test="${item.ptnr_type eq 1}">손해보험</c:when>
						<c:when test="${item.ptnr_type eq 2}">생명보험</c:when>
						<c:when test="${item.ptnr_type eq 3}">협회</c:when>
						<c:when test="${item.ptnr_type eq 4}">공제</c:when>
						<c:when test="${item.ptnr_type eq 5}">기타</c:when>
					</c:choose>
				</td>				
				<!-- 공지사항 -->				
				<td width="9%" class="td-overflow-none">
					<c:if test="${item.notice_ptnr1_cnt > 0}">					
						<a href="javascript:doShowInsuNoti(1,${item.ptnr_id});">
							<input class="buttonMini" style="background-color:#F6CECE;" type="button" value="1종">&nbsp;
						</a>
					</c:if>
					<c:if test="${item.notice_ptnr4_cnt > 0}">
						<a href="javascript:doShowInsuNoti(4,${item.ptnr_id});">
							<input class="buttonMini" style="background-color:#D8F6CE;" type="button" value="4종">
						</a>
					</c:if>
				</td>				
				<!-- PRM -->
				<td width="9%">
					<c:choose>
						<c:when test="${empty item.ptnr_url}"> - </c:when>
						<c:otherwise><a href="${item.ptnr_url}" target="_blank"><input type="button" value="PRM" class="buttonAssistance" title="PRM 링크연결"></a></c:otherwise>
					</c:choose>
				</td>
				<!-- 홈페이지 -->
				<td width="9%">
					<c:choose>
						<c:when test="${empty item.ptnr_homepage}"> - </c:when>
						<c:otherwise><a href="${item.ptnr_homepage}" target="_blank"><input type="button" value="홈페이지" class="buttonAssistanceEmail"  title="홈페이지 링크연결"></a></c:otherwise>
					</c:choose>
				</td>
			</tr>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
			<td colspan="10">
				검색된 관련업체 회사가 없습니다.
			</td>
		</tr>
	</c:otherwise>
</c:choose>
</table>