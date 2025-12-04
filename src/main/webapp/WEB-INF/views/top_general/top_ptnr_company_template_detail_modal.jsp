<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link href="./resources/select2/select2.min.css" rel="stylesheet" />
<script src="./resources/select2/select2.min.js"></script>
	<style>
		.td-overflow-none{
			text-overflow : ellipsis;
			overflow : hidden;
			white-space : nowrap;
			word-wrap:normal;
		}
		/* 모달창 셀렉트 박스 */
		.select2-container--default{
			text-align : left;
			font-color:#444;
			font-size:12px;
		}	
	</style>			
		<div id="template-action-dialog" title="보험사 문서서식 다운로드" style="font-size: 15px;" align="center">		
			<div class="tableStyle2">
				<table class="vacation-ins-table">
					<tr>
						<th width="6%">구분</th>
						<th width="25%">서식종류</th>
						<th width="50%">파일명</th>
						<th width="11%">등록일</th>
						<th width="8%">다운로드</th>							
					</tr>
					<c:forEach items="${templateList}" var="item" varStatus="var">
						<tr>
							<td>
								<c:choose>
									<c:when test="${item.team_type eq 1}">1종</c:when>
									<c:when test="${item.team_type eq 4}">4종</c:when>
									<c:otherwise>공통</c:otherwise>
								</c:choose>
							</td>
							<td>${item.category_name}</td>
							<td>
								<c:choose>
									<c:when test="${empty item.template_org_file}">
										<font color="blue">
											${item.nofile_content_val}
										</font>										
									</c:when>
									<c:otherwise>${item.template_org_file}</c:otherwise>
								</c:choose>							
							</td>
							<td>${item.reg_date_fmt}</td>												
							<td>					
								<c:if test="${!empty item.template_org_file}">			
								<a href="#noloc" onclick="fnTemplateDown('${item.tkey}');"><img src='./resources/ls_img/icon_disket.gif'></a>
								</c:if>
							</td>					
						</tr>		
					</c:forEach>
				</table>
			</div>
		</div>