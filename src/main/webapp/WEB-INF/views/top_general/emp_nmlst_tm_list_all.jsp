<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

	<div class= "tableStyle2" >
		<!-- 엑셀 다운 -->
		<div style="margin-top:5px">
			<img src="./resources/ls_img/ls_invoice/btn_excel.gif" style='cursor:pointer;' onclick="excMemberTel('all')" align="right" />
			<form id="excelTelForm" action="MemberTelExcel" method="GET">
				<input type="hidden" id="gubun" name="gubun" />
			</form>
		</div>
		<!-- //엑셀 다운 -->
		
		<table style="margin-top:30px">
			<thead>
				<tr>
					<th width="9%">총괄</th>
					<th width="9%">구분</th>
					<th width="9%">임원</th>
					<th width="9%">센터장</th>
					<th width="9%">팀장</th>
					<th width="9%">파트장</th>
					<th width="9%">팀원</th>
					<th width="9%">업무지원</th>
					<th width="9%">파견근무</th>
					<th width="9%">합계</th>
					<th width="9%">총원</th>
				</tr>
			</thead>
			<tbody>
				<c:set var="worktype_cnt" value="${worktype_cnt}" />
				<tr>
					<td rowspan="2"><c:out value="${worktype_cnt.get(0).getCnt()}"/>명</td>
					<td style = "background:#EFEFEF;">1종파트</td>
					<td><c:out value="${worktype_cnt.get(1).getCnt()}"/>명</td> <!-- 임원 -->
					<td><c:out value="${worktype_cnt.get(13).getCnt()}"/>명</td> <!-- 센터장 -->
					<td><c:out value="${worktype_cnt.get(2).getCnt()}"/>명</td> <!-- 팀장 -->
					<td><c:out value="${worktype_cnt.get(3).getCnt()}"/>명</td> <!-- 파트장 -->
					<td><c:out value="${worktype_cnt.get(4).getCnt()}"/>명</td> <!-- 팀원 -->
					<td><c:out value="${worktype_cnt.get(9).getCnt()}"/>명</td> <!-- 업무지원 -->
					<td><c:out value="${worktype_cnt.get(10).getCnt()}"/>명</td><!-- 파견근무 -->
					
					<!-- 1종 합계 -->
					<td><c:out value="${worktype_cnt.get(1).getCnt()+worktype_cnt.get(2).getCnt()
					+worktype_cnt.get(3).getCnt()+worktype_cnt.get(4).getCnt()
					+worktype_cnt.get(9).getCnt()+worktype_cnt.get(10).getCnt()+worktype_cnt.get(13).getCnt()}"/>명</td>
					
					<!-- 총합 -->
					<td rowspan="2"><c:out value="${worktype_cnt.get(0).getCnt()
					+worktype_cnt.get(1).getCnt()+worktype_cnt.get(2).getCnt()
					+worktype_cnt.get(3).getCnt()+worktype_cnt.get(4).getCnt()
					+worktype_cnt.get(9).getCnt()+worktype_cnt.get(10).getCnt()
					+worktype_cnt.get(5).getCnt()+worktype_cnt.get(6).getCnt()
					+worktype_cnt.get(7).getCnt()+worktype_cnt.get(8).getCnt()
					+worktype_cnt.get(11).getCnt()+worktype_cnt.get(12).getCnt()
					+worktype_cnt.get(13).getCnt()+worktype_cnt.get(14).getCnt()}"/>명</td>
				</tr>
				<tr>
					<td style = "background:#EFEFEF;">4종파트</td>
					<td><c:out value="${worktype_cnt.get(5).getCnt()}"/>명</td><!-- 임원 -->
					<td><c:out value="${worktype_cnt.get(14).getCnt()}"/>명</td><!-- 센터장 -->
					<td><c:out value="${worktype_cnt.get(6).getCnt()}"/>명</td><!-- 팀장 -->
					<td><c:out value="${worktype_cnt.get(7).getCnt()}"/>명</td><!-- 파트장 -->
					<td><c:out value="${worktype_cnt.get(8).getCnt()}"/>명</td><!-- 팀원 -->
					<td><c:out value="${worktype_cnt.get(11).getCnt()}"/>명</td><!-- 업무지원 -->
					<td><c:out value="${worktype_cnt.get(12).getCnt()}"/>명</td><!-- 파견 -->
					<!-- 4종합계 -->
					<td><c:out value="${worktype_cnt.get(5).getCnt()+worktype_cnt.get(6).getCnt()
					+worktype_cnt.get(7).getCnt()+worktype_cnt.get(8).getCnt()
					+worktype_cnt.get(11).getCnt()+worktype_cnt.get(12).getCnt()+worktype_cnt.get(14).getCnt()}"/>명</td>
				</tr>
				
			</table>
		</div><!-- //tableStyle2 -->
	<br />
	
	<!-- 본사 총괄 -->
	<div class= "tableStyle2">
		<p style="margin-top:10px;">
			<font size="3"> <b> - 본사사업부 </b> </font>
		</p>
		<div style="text-align:right;padding-right:5px;">※ 팀 내 겸직인원이 존재하는 경우 () 괄호안에 겸직 포함인원으로 표시됩니다.
		</div>
		<table>
			<c:forEach items="${teamList_head}" var="tmVo">
				<c:choose>
			
					<c:when  test="${tmVo.team_level eq 0}">
						<tr style = "background:#E5EBFF;">
							<td width="15%"><b>${tmVo.team_name}</b></td>
							<td width="15%"></td>
							<td width="50%"></td>
							<td width="10%">
								<c:choose>
									<c:when test="${tmVo.cnt ne '-'}">
										${tmVo.cnt - tmVo.sub_cnt} 명
									</c:when>
									<c:otherwise> - 명</c:otherwise>
								</c:choose>
								<c:if test="${tmVo.sub_cnt > 0}"> (${tmVo.cnt} 명)</c:if>
							</td>
							<td width="10%"></td>
						</tr>
					</c:when>
					<c:when  test="${tmVo.team_level ne 0}">
						<c:if test="${tmVo.cnt ne '-'}">
							<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
								<td>
								<c:if test="${tmVo.team_level eq 2}">└</c:if>
								${tmVo.team_name}</td>
								<td>${tmVo.team_telephone}</td>
								<td>${tmVo.team_addr}</td>
								<td>
									<c:choose>
										<c:when test="${tmVo.cnt ne '-'}">
											${tmVo.cnt - tmVo.sub_cnt} 명
										</c:when>
										<c:otherwise> - 명</c:otherwise>
									</c:choose>
									<c:if test="${tmVo.sub_cnt > 0}"> (${tmVo.cnt} 명)</c:if>
								</td>
								<td><a href="./empNmlstTmDtl?team_id=${tmVo.team_id}"><img src="./resources/ls_img/member/btn_view.gif"/></a></td>
							</tr>
						</c:if>
					</c:when>
				</c:choose>
			</c:forEach>
		</table>
	</div><!-- //tableStyle2 -->
	
	
	<div class= "tableStyle2">
		<p style="margin-top:10px;">
			<font size="3"> <b> - 1종 사업부 </b> </font>
		</p>
			<table>
				<c:forEach items="${teamList_1}" var="tmVo">
					<c:choose>
						<c:when  test="${tmVo.team_level eq 0 and tmVo.cnt ne '-'}">							
							<tr style = "background:#E5EBFF;">
								<td width="15%"><b>${tmVo.team_name}</b></td>
								<td width="15%"></td>
								<td width="50%"></td>
								<td width="10%">
									<c:choose>
										<c:when test="${tmVo.cnt ne '-'}">
											${tmVo.cnt - tmVo.sub_cnt} 명
										</c:when>
										<c:otherwise> - 명</c:otherwise>
									</c:choose>
									<c:if test="${tmVo.sub_cnt > 0}"> (${tmVo.cnt} 명)</c:if>
								</td>
								<td width="10%"></td>
							</tr>
						</c:when>
						<c:when  test="${tmVo.team_level ne 0}">
							<c:if test="${tmVo.cnt ne '-'}">
								<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
									<td>
									<c:if test="${tmVo.team_level eq 2}">└</c:if>
									${tmVo.team_name}</td>
									<td>${tmVo.team_telephone}</td>
									<td>${tmVo.team_addr}</td>
									<td>
										<c:choose>
											<c:when test="${tmVo.cnt ne '-'}">
												${tmVo.cnt - tmVo.sub_cnt} 명
											</c:when>
											<c:otherwise> - 명</c:otherwise>
										</c:choose>
										<c:if test="${tmVo.sub_cnt > 0}"> (${tmVo.cnt} 명)</c:if>
									</td>
									<td><a href="./empNmlstTmDtl?team_id=${tmVo.team_id}"><img src="./resources/ls_img/member/btn_view.gif" style="cursor:pointer;"/></a></td>
								</tr>
							</c:if>
						</c:when>
					</c:choose>
				</c:forEach>
			</table>
	</div><!-- //tableStyle2 -->
	
	<div class= "tableStyle2">
		<p style="margin-top:10px;">
			<font size="3"> <b> - 4종 사업부 </b> </font>
		</p>
			<table>
				<c:forEach items="${teamList_4}" var="tmVo">
					<c:choose>
						<c:when  test="${tmVo.team_level eq 0}">
							<tr style = "background:#F7E6CF;">
								<td width="15%"><b>${tmVo.team_name}</b></td>
								<td width="15%"></td>
								<td width="50%"></td>
								<td width="10%">
									<c:choose>
										<c:when test="${tmVo.cnt ne '-'}">
											${tmVo.cnt - tmVo.sub_cnt} 명
										</c:when>
										<c:otherwise> - 명</c:otherwise>
									</c:choose>
									<c:if test="${tmVo.sub_cnt > 0}"> (${tmVo.cnt} 명)</c:if>
								</td>
								<td width="10%"></td>
							</tr>
						</c:when>
						<c:when  test="${tmVo.team_level ne 0}">
							<c:if test="${tmVo.cnt ne '-'}">
								<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
									<td>
									<c:if test="${tmVo.team_level eq 2}">└</c:if>
									${tmVo.team_name}</td>
									<td>${tmVo.team_telephone}</td>
									<td>${tmVo.team_addr}</td>
									<td>
										<c:choose>
											<c:when test="${tmVo.cnt ne '-'}">
												${tmVo.cnt - tmVo.sub_cnt} 명
											</c:when>
											<c:otherwise> - 명</c:otherwise>
										</c:choose>
										<c:if test="${tmVo.sub_cnt > 0}"> (${tmVo.cnt} 명)</c:if>
									</td>
									<td><a href="./empNmlstTmDtl?team_id=${tmVo.team_id}"><img src="./resources/ls_img/member/btn_view.gif" style="cursor:pointer;"/></a></td>
								</tr>
							</c:if>
						</c:when>
					</c:choose>
				</c:forEach>
			</table>
	</div><!-- //tableStyle2 -->	
	
	
							