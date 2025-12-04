<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<!-- 직원별 목록시작 -->
<div class= "tableStyle2" style="border-top:0px;">
	<table>
		<tr>
			<th width="60px">순번</th>
			<th width="150px">센터명</th>
			<th width="150px">부서명</th>
			<th width="120px">이름</th>
			<!-- <th width="80px">재직상태</th> -->
			<th width="120px">등록구분</th>
			<th width="90px">등록보종</th>
			<th width="90px">등록번호</th>
			<th width="90px">등록일자</th>
			<th width="180px">담당 손해사정사</th>
			<th width="100px">직원정보</th>
			<c:if test="${certiMemberList.size() > 16}">
				<th width="15px;"> </th>	
			</c:if>			
		</tr>
	</table>
</div>
<div class= "tableStyle2" style="border-top:0px;height: 600px;overflow-x: hidden !important; overflow-y: auto;">
	<table>
		<c:choose>
			<c:when test="${certiMemberList.size() == 0}">
				<tr>
					<td colspan="10" style="text-align:center;">
						검색된 결과가 없습니다.
					</td>
				</tr>		
			</c:when>
			<c:otherwise>			
				<c:forEach items="${certiMemberList}" var="memberVo" varStatus="status">
					<tr>
						<td style="width:60px;">${certiMemberList.size() - status.index}</td>
						<td style="width:150px;">${memberVo.center_name}</td>
						<td style="width:150px;">${memberVo.team_name}</td>
						<td style="width:120px;">${memberVo.user_name}</td>
						<%-- <td style="width:80px;">
							<c:choose>
								<c:when test="${memberVo.user_state eq 1}"><font color="red">퇴사</font></c:when>
								<c:otherwise>재직중</c:otherwise>
							</c:choose>							
						</td> --%>						
						<td style="width:120px;">
							<c:choose>								
								<c:when test="${memberVo.certi_state eq 1}"><font color="green">보조인 자격 충족</font></c:when>
								<c:when test="${memberVo.certi_state eq 2}"><font color="orange">보조인 자격 불충족</font></c:when>
								<c:when test="${memberVo.certi_state eq 3}">비대상</c:when>
								<c:when test="${memberVo.certi_state eq 4}"><font color="blue">손해사정사</font></c:when>
								<c:when test="${memberVo.certi_state eq 6}"><font color="purple">손해사정사+보조인</font></c:when>
								<c:otherwise><font color="red">미등록</font></c:otherwise>
							</c:choose>
						</td>
						<c:choose>
							<c:when test="${memberVo.certi_cnt > 1}">
								<td style="width:90px;" title="${memberVo.certi_type_nm} 외 ${memberVo.certi_cnt-1} 건"><font color="blue">${memberVo.certi_type_nm}</font></td>
								<td style="width:90px;" title="${memberVo.certi_number} 외 ${memberVo.certi_cnt-1} 건"><font color="blue">${memberVo.certi_number}</font></td>
							</c:when>
							<c:otherwise>
								<td style="width:90px;">${memberVo.certi_type_nm}</td>
								<td style="width:90px;">${memberVo.certi_number}</td>
							</c:otherwise>
						</c:choose>
						<td style="width:90px;">${memberVo.certi_date_fmt}</td>
						<td style="width:175px; text-align:left;padding-left:5px;">
							<div style="width:175px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" title='${memberVo.manager_info_text} <c:if test="${memberVo.certi_manager_cnt > 1}"> 외 ${memberVo.certi_manager_cnt - 1}명</c:if>'>							
								<c:choose>
									<c:when test="${memberVo.certi_manager_cnt > 1}">
										<font color="green">
											${memberVo.manager_info_text} 외 ${memberVo.certi_manager_cnt - 1}명
										</font> 
									</c:when>
									<c:otherwise>
										${memberVo.manager_info_text}
									</c:otherwise>
								</c:choose>
							</div>
						</td>
						<td style="width:100px;">
							<a class="btn-vacation-aprv" id="btn-detail" style="width: 58px;" onclick="popMbrDetail(${memberVo.user_no})" href="#noloc">상세보기</a>
						</td>											
					</tr>
				</c:forEach>			
			</c:otherwise>
		</c:choose>
	</table>
</div>
