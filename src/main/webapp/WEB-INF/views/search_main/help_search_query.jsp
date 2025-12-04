<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	<script>
		$(document).ready(function(){
			if('${mbrVo_Session.user_no}' == null || '${mbrVo_Session.user_no}'.trim() == ''){
				alert("로그아웃 상태입니다. 재로그인 하십시오.");
				window.location.assign("./logout");
			}
		});//ready

		$(document).ready(function(){

			$.ajaxSetup({cache:false});

			$("#searchBtn").click(function(){
				$("#tmGubunCilent").val($("#tmSearchCilent option:selected").text().indexOf("└"));
				$("#tmGubunAccept").val($("#tmSearchAccept option:selected").text().indexOf("└"));
				$("#helpSearchQueryForm").attr("action","helpSearchQuery");
				helpSearchQueryForm.submit();
			});

		});//$(document).ready
	</script>

	<!-- 검색 조건 테이블 -->
	<div class= "tableStyle21">

		<form action="./helpSearchQuery" name="helpSearchQueryForm" id="helpSearchQueryForm" method="post">
			<table>
				<tbody>
					<tr>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b>의뢰팀</b></td>
						<td width="16%">
							<select id="tmSearchClient" name="tmSearchClient">
								<option value="0" selected>전체</option>
								<c:forEach items="${teamList}" var = "teamVo">
									<option value="${teamVo.team_id}"
										<c:if test="${searchVO.tmSearchClient == teamVo.team_id}">selected</c:if>
									>
										<c:if test="${teamVo.team_level == 1}">&nbsp;└</c:if>
										<c:if test="${teamVo.team_level == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
										${teamVo.team_name}
									</option>
								</c:forEach>
							</select>
							<input type="hidden" id="tmGubunClient" name="tmGubunClient" value='<c:out value="${searchVO.tmGubunClient}" />' >
						</td>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b>의뢰인</b></td>
						<td width="16%">
							<input type="text" id="clientNmSearch" name="clientNmSearch" value='<c:out value="${searchVO.clientNmSearch}" />' />
						</td>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b>의뢰일</b></td>
						<td width="18%">
							<input type="text" class="classCalendar" id="regDateFromSearch" name="regDateFromSearch" size="10"
								value="${searchVO.regDateFromSearch}" readonly style="background-color:lightgrey;" />
							~ &nbsp;
							<input type="text" class="classCalendar" id="regDateToSearch" name="regDateToSearch" size="10"
								value="${searchVO.regDateToSearch}" readonly style="background-color:lightgrey;" />
						</td>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b>완료일</b></td>
						<td width="18%">
							<input type="text" class="classCalendar" id="endDateFromSearch" name="endDateFromSearch" size="10"
								value="${searchVO.endDateFromSearch}" readonly style="background-color:lightgrey;" />
							~ &nbsp;
							<input type="text" class="classCalendar" id="endDateToSearch" name="endDateToSearch" size="10"
								value="${searchVO.endDateToSearch}" readonly style="background-color:lightgrey;" />
						</td>
					</tr>
					<tr>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b>수임팀</b></td>
						<td width="16%">
							<select id="tmSearchAccept" name="tmSearchAccept">
								<option value="0" selected>전체</option>
								<c:forEach items="${teamList}" var = "teamVo">
									<option value="${teamVo.team_id}"
										<c:if test="${searchVO.tmSearchAccept == teamVo.team_id}">selected</c:if>
									>
										<c:if test="${teamVo.team_level == 1}">&nbsp;└</c:if>
										<c:if test="${teamVo.team_level == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
										${teamVo.team_name}
									</option>
								</c:forEach>
							</select>
							<input type="hidden" id="tmGubunAccept" name="tmGubunAccept" value='<c:out value="${searchVO.tmGubunAccept}" />' >
						</td>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b>수임인</b></td>
						<td width="16%">
							<input type="text" id="acceptNmSearch" name="acceptNmSearch" value='<c:out value="${searchVO.acceptNmSearch}" />' />
						</td>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b>진행상태</b></td>
						<td width="18%">
							<select id="stateSearch" name="stateSearch">
								<option value="-1" selected>전체</option>
								<c:forEach items="${helpStateList}" var = "stateVo">
									<option value="${stateVo.col_cd}"
										<c:if test="${searchVO.stateSearch == stateVo.col_cd}">selected</c:if>
									>
										${stateVo.col_val}
									</option>
								</c:forEach>
							</select>
						</td>
						<td colspan="2" style="text-align:right;">
							<img src="./resources/ls_img/ls_invoice/btn_src.gif" style='cursor:pointer;' id="searchBtn" />
						</td>
					</tr>
				</tbody>
			</table>
		</form>

	</div><!-- //tableStyle21 -->
	<!-- //검색 조건 테이블 -->

		<form action="./helpSearchQuery" name="helpSearchPagingForm" method="post">
			<input type="hidden" id="reqPgNo" name="reqPgNo" >
			<input type="hidden" id="tmSearchClient" name="tmSearchClient" value="${searchVO.tmSearchClient}" >
			<input type="hidden" id="tmGubunClient" name="tmGubunClient" value="${searchVO.tmGubunClient}" >
			<input type="hidden" id="clientNmSearch" name="clientNmSearch" value="${searchVO.clientNmSearch}" >
			<input type="hidden" id="regDateFromSearch" name="regDateFromSearch" value="${searchVO.regDateFromSearch}" >
			<input type="hidden" id="regDateToSearch" name="regDateToSearch" value="${searchVO.regDateToSearch}" >
			<input type="hidden" id="endDateFromSearch" name="endDateFromSearch" value="${searchVO.endDateFromSearch}" >
			<input type="hidden" id="endDateToSearch" name="endDateToSearch" value="${searchVO.endDateToSearch}" >
			<input type="hidden" id="tmSearchAccept" name="tmSearchAccept" value="${searchVO.tmSearchAccept}" >
			<input type="hidden" id="tmGubunAccept" name="tmGubunAccept" value="${searchVO.tmGubunAccept}" >
			<input type="hidden" id="acceptNmSearch" name="acceptNmSearch" value="${searchVO.acceptNmSearch}" >
			<input type="hidden" id="stateSearch" name="stateSearch" value="${searchVO.stateSearch}" >
		</form>
