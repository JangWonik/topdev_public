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
				$("#searchBtn").hide();
				$("#tmGubun").val($("#tmSearch option:selected").text().indexOf("└"));
				$("#ptnrGubun").val($("#ptnrSearch option:selected").text().indexOf("└"));
				$("#hiddenSimpleQueryTxt").val("");
				$("#searchMainQueryForm").attr("action","searchMainQuery");
				searchMainQueryForm.submit();
			});
			
			//폼에서 엔터 입력시 검색버튼 클릭
			$("form input").keydown(function(e) {
				if( e.keyCode == 13 ){
					$("#searchBtn").click();
				}					
			});

			//사고번호상세검색
			$("#accSearchDetail").click(function(){				
				window.open('suimRptAccSearchDetail','사고번호 상세검색','width=750px,height=450px,resizable=yes,scrollbars=yes');				
			});

		});//$(document).ready
	</script>
	<style>
		.buttonSearchMini{
			width:60px;
			height:23px;
		    background-color:#2E7EE8;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		    }
	</style>

	<!-- 검색 조건 테이블 -->
	<div class= "tableStyle21">

		<form action="./searchMainQuery" name="searchMainQueryForm" id="searchMainQueryForm" method="post">
		
			<!-- 상신일, 주민번호 주석처리하였으나 mybatis 보존으로 hidden 값 생성  -->
			<input type="hidden" id="policySsn1Search" name="policySsn1Search" />
			<input type="hidden" id="policySsn2Search" name="policySsn2Search" />
			
			<input type="hidden" id="benefiSsn1Search" name="benefiSsn1Search" />
			<input type="hidden" id="benefiSsn2Search" name="benefiSsn2Search" />
			
			<input type="hidden" id="aprvDateFromSearch" name="aprvDateFromSearch" />
			<input type="hidden" id="aprvDateToSearch" name="aprvDateToSearch" />
			
			<input type="hidden" id="suimRptListTotCntVal" name="suimRptListTotCntVal" value="${suimRptListTotCnt}">

			<table>
				<colgroup>
					<col style="width:8%"/>
					<col style="width:16%"/>
					<col style="width:8%"/>
					<col style="width:16%"/>
					<col style="width:8%"/>
					<col style="width:18%"/>
					<col style="width:8%"/>
					<col style="width:18%"/>
				</colgroup>
				<tbody>
					<tr>
						<td bgcolor="#e7ecf1" style="text-align:center;"><b>진행현황</b></td>
						<td>
							<select id="stateSearch" name="stateSearch" style="width: 118px;">
								<option value="9999" <c:if test="${searchVO.stateSearch == '9999'}">selected</c:if>>전체</option>
								<option value="0" <c:if test="${searchVO.stateSearch == '0'}">selected</c:if>>미결</option>
								<option value="1" <c:if test="${searchVO.stateSearch == '1'}">selected</c:if>>결재</option>
								<option value="11" <c:if test="${searchVO.stateSearch == '11'}">selected</c:if>>반려</option>
								<option value="2" <c:if test="${searchVO.stateSearch == '2'}">selected</c:if>>종결</option>
								<option value="3" <c:if test="${searchVO.stateSearch == '3'}">selected</c:if>>위임취소</option>
								<option value="32" <c:if test="${searchVO.stateSearch == '32'}">selected</c:if>>위임취소(단순)</option>
								<option value="33" <c:if test="${searchVO.stateSearch == '33'}">selected</c:if>>위임취소(전환)</option>
								<option value="31" <c:if test="${searchVO.stateSearch == '31'}">selected</c:if>>위임취소중</option>
							</select>
							&nbsp;&nbsp;<input type="checkbox" id="noUserSearch" name="noUserSearch"
								<c:if test="${searchVO.noUserSearch == 'on'}">checked</c:if>
							/> 미배당
						</td>
						<td bgcolor="#e7ecf1" style="text-align:center;"><b>종별구분</b></td>
						<td >
							<select id="type1Search" name="type1Search" class="srchSelect">
								<option value="0" selected>전체</option>
								<option value="21" <c:if test="${searchVO.type1Search == 21}">selected</c:if> >재물 및 배상</option>
								<option value="23" <c:if test="${searchVO.type1Search == 23}">selected</c:if> >재물 및 배상(서면심사 제외)</option>
								<option value="22" <c:if test="${searchVO.type1Search == 22}">selected</c:if> >질병 및 상해</option>
								
								<c:forEach items="${type1List}" var = "type1Vo">
									<option value="${type1Vo.col_cd}"
										<c:if test="${searchVO.type1Search == type1Vo.col_cd}">selected</c:if>
									>
										${type1Vo.col_val}
									</option>
								</c:forEach>
							</select>
						</td>
						<td bgcolor="#e7ecf1" style="text-align:center;"><b>접수일</b></td>
						<td >
							<input type="text" class="classCalendar" id="regDateFromSearch" name="regDateFromSearch" size="10" value="${searchVO.regDateFromSearch}" /> 
							~<input type="text" class="classCalendar" id="regDateToSearch" name="regDateToSearch" size="10" value="${searchVO.regDateToSearch}" />
						</td>
						<td bgcolor="#e7ecf1" style="text-align:center;"><b>종결일</b></td>
						<td>
							<input type="text" class="classCalendar" id="closeDateFromSearch" name="closeDateFromSearch" size="10" value="${searchVO.closeDateFromSearch}" />
							~<input type="text" class="classCalendar" id="closeDateToSearch" name="closeDateToSearch" size="10" value="${searchVO.closeDateToSearch}" />
						</td>						
					</tr>
					<tr>
						<td bgcolor="#e7ecf1" style="text-align:center;"><b>조사팀</b></td>
						<td >
							<select id="tmSearch" name="tmSearch" class="srchSelect">
								<option value="0" selected>전체</option>
								<c:forEach items="${teamList}" var = "teamVo">
									<option value="${teamVo.team_id}"
										<c:if test="${searchVO.tmSearch == teamVo.team_id}">selected</c:if>
									>
										<c:if test="${teamVo.team_level == 1}">&nbsp;└</c:if>
										<c:if test="${teamVo.team_level == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
										${teamVo.team_name}
									</option>
								</c:forEach>
							</select>
							<input type="hidden" id="tmGubun" name="tmGubun" value='<c:out value="${searchVO.tmGubun}" />' >
						</td>
						<td bgcolor="#e7ecf1" style="text-align:center;"><b>조사 담당자</b></td>
						<td >
							<input type="text" class="srchTxt" id="userNmSearch" name="userNmSearch" value='<c:out value="${searchVO.userNmSearch}" />' onchange="changeSqlRemoveText(this);"/>
						</td>


						<td bgcolor="#e7ecf1" style="text-align:center;"><b>사고번호</b></td>
						<td >
							<input type="text" class="srchTxt" id="accidentNoSearch" name="accidentNoSearch" value='<c:out value="${searchVO.accidentNoSearch}" />' />
							<!-- 사고번호 상세검색기 -->
							<img src="./resources/ls_img/ls_body/icon_score_zoom.gif" title="사고번호 상세검색" id="accSearchDetail" style="cursor:pointer;"/>
						</td>
						<td bgcolor="#e7ecf1" style="text-align:center;"><b>증권번호</b></td>
						<td >
							<input type="text" class="srchTxt" id="policyNoSearch" name="policyNoSearch" value='<c:out value="${searchVO.policyNoSearch}" />' />
						</td>

						
						<!-- 상신일 미사용 180119
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b>상신일</b></td>
						<td width="18%">
							<input type="text" class="classCalendar" id="aprvDateFromSearch" name="aprvDateFromSearch" size="10" value="${searchVO.aprvDateFromSearch}" />
							~ &nbsp;
							<input type="text" class="classCalendar" id="aprvDateToSearch" name="aprvDateToSearch" size="10" value="${searchVO.aprvDateToSearch}" />
						</td>
						 -->
						 

					</tr>
					<tr>
						<td bgcolor="#e7ecf1" style="text-align:center;"><b>보험사</b></td>
						<td>
							<select id="ptnrSearch" name="ptnrSearch" class="srchSelect">
								<option value="0" selected>전체</option>
								<c:forEach items="${ptnrList}" var = "ptnrVo">
									<option value="${ptnrVo.ptnr_id}"
										<c:if test="${searchVO.ptnrSearch == ptnrVo.ptnr_id}">selected</c:if>
									>
										<c:if test="${ptnrVo.ptnr_level == 1}">&nbsp;└</c:if>
										${ptnrVo.ptnr_nick}
									</option>
								</c:forEach>
							</select>
							<input type="hidden" id="ptnrGubun" name="ptnrGubun" value='<c:out value="${searchVO.ptnrGubun}" />' >
						</td>
						<td bgcolor="#e7ecf1" style="text-align:center;"><b>보험사팀</b></td>
						<td >
							<input type="text" class="srchTxt" id="ptnrDeptNmSearch" name="ptnrDeptNmSearch" value='<c:out value="${searchVO.ptnrDeptNmSearch}" />' onchange="changeSqlRemoveText(this);"/>
						</td>
						<td bgcolor="#e7ecf1" style="text-align:center;"><b>보험사 담당자</b></td>
						<td >
							<input type="text" class="srchTxt" id="ptnrUserNmSearch" name="ptnrUserNmSearch" value='<c:out value="${searchVO.ptnrUserNmSearch}" />' onchange="changeSqlRemoveText(this);"/>
						</td>
						<td bgcolor="#e7ecf1" style="text-align:center;"><b>보험종목명</b></td>
						<td >
							<input type="text" class="srchTxt" id="insuNmSearch" name="insuNmSearch" value='<c:out value="${searchVO.insuNmSearch}" />' onchange="changeSqlRemoveText(this);"/>
						</td>
					</tr>
					<tr>
						<td bgcolor="#e7ecf1" style="text-align:center;"><b>계약자</b></td>
						<td >
							<input type="text" class="srchTxt" id="policyhNmSearch" name="policyhNmSearch" value='<c:out value="${searchVO.policyhNmSearch}" />' onchange="changeSqlRemoveText(this);"/>
						</td>
						<td bgcolor="#e7ecf1" style="text-align:center;"><b>피보험자</b></td>
						<td >
							<input type="text" class="srchTxt" id="benefiNmSearch" name="benefiNmSearch" value='<c:out value="${searchVO.benefiNmSearch}" />' onchange="changeSqlRemoveText(this);"/>
						</td>
						
						<td bgcolor="#e7ecf1" style="text-align:center;"><b>민원</b></td>
						<td >
							<input type="radio" name="minwonSearch" value="3" checked="checked" /> 전체
							<input type="radio" name="minwonSearch" value="0" 
								<c:if test="${searchVO.minwonSearch eq 0 || searchVO.minwonSearch eq -1}">checked="checked"</c:if> 
							/> 없음
							<input type="radio" name="minwonSearch" value="1" <c:if test="${searchVO.minwonSearch eq 1}">checked="checked"</c:if> /> 예상
							<input type="radio" name="minwonSearch" value="2" <c:if test="${searchVO.minwonSearch eq 2}">checked="checked"</c:if> /> 발생
						</td>
						<td bgcolor="#e7ecf1" style="text-align:center;"><b>민원 발생일</b></td>
						<td>
							<input type="text" class="classCalendar" id="minwonDateFromSearch" name="minwonDateFromSearch" size="10" value="${searchVO.minwonDateFromSearch}" />
							~<input type="text" class="classCalendar" id="minwonDateToSearch" name="minwonDateToSearch" size="10" value="${searchVO.minwonDateToSearch}" /> 
						</td>						
						
						
						<!-- 주민번호 사용 안함 180119 LDS 
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b>계약자 주번</b></td>
						<td width="16%">
							<input type="text" id="policySsn1Search" name="policySsn1Search" value='<c:out value="${searchVO.policySsn1Search}" />'
								size="10" maxlength="6" />
							- <input type="text" id="policySsn2Search" name="policySsn2Search" value='<c:out value="${searchVO.policySsn2Search}" />'
								size="10" maxlength="7" />
						</td>
						
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b>피보험자 주번</b></td>
						<td width="16%">
							<input type="text" id="benefiSsn1Search" name="benefiSsn1Search" value='<c:out value="${searchVO.benefiSsn1Search}" />'
								size="10" maxlength="6" />
							- <input type="text" id="benefiSsn2Search" name="benefiSsn2Search" value='<c:out value="${searchVO.benefiSsn2Search}" />'
								size="10" maxlength="7" />
						</td>
						 -->
					</tr>
					<tr>
						<td bgcolor="#e7ecf1" style="text-align:center;"><b>피해자/물</b></td>
						<td >
							<input type="text" class="srchTxt" id="damagedNmSearch" name="damagedNmSearch" value='<c:out value="${searchVO.damagedNmSearch}" />' onchange="changeSqlRemoveText(this);"/>
						</td>
						<td bgcolor="#e7ecf1" style="text-align:center;"><b>사고내용</b></td>
						<td >
							<input type="text" class="srchTxt" id="accidentFactsSearch" name="accidentFactsSearch" value='<c:out value="${searchVO.accidentFactsSearch}" />' onchange="changeSqlRemoveText(this);"/>
						</td>
						
						<td bgcolor="#e7ecf1" style="text-align:center;"><b>보험사기</b></td>
						<td >
							<input type="checkbox" id="moralSearch" name="moralSearch"
								<c:if test="${searchVO.moralSearch == 'on'}">checked</c:if>
							/> 모랄건
						</td>
						
						<td bgcolor="#e7ecf1" style="text-align:center;"><b>공문 수신일</b></td>
						<td>
							<input type="text" class="classCalendar" id="moralDateFromSearch" name="moralDateFromSearch" size="10" value="${searchVO.moralDateFromSearch}" />
							~ <input type="text" class="classCalendar" id="moralDateToSearch" name="moralDateToSearch" size="10" value="${searchVO.moralDateToSearch}" /> 
						</td>						
						
					</tr>
					<tr>
						<td bgcolor="#e7ecf1" style="text-align:center;"><b>접수번호</b></td>
						<td>
							<input type="text" class="srchTxt" id="acceptNoSearch" name="acceptNoSearch" value='<c:out value="${searchVO.acceptNoSearch}" />' onchange="changeSqlRemoveText(this);"/>
						</td>
						<!-- 필수 업무프로세스 검색조건 시작 -->
						<td bgcolor="#e7ecf1" style="text-align:center;"><b>업무프로세스</b></td>
						<td>
							<select id="processStateSearch" name="processStateSearch" style="width: 100%;">
								<option value="9999" <c:if test="${searchVO.processStateSearch == '9999'}">selected</c:if>>전체</option>
								<option value="1" <c:if test="${searchVO.processStateSearch == '1'}">selected</c:if>>대상</option>
								<option value="2" <c:if test="${searchVO.processStateSearch == '2'}">selected</c:if>>비대상</option>								
								<option value="3" <c:if test="${searchVO.processStateSearch == '3'}">selected</c:if>>과정관리</option>
								<option value="4" <c:if test="${searchVO.processStateSearch == '4'}">selected</c:if>>현장+과정관리</option>
								<option value="5" <c:if test="${searchVO.processStateSearch == '5'}">selected</c:if>>대상+현장+과정관리</option>								
							</select>							
						</td>
						<!-- 필수 업무프로세스 검색조건 끝 -->						
						<td bgcolor="#e7ecf1" style="text-align:center;"><b>위임 취소일</b></td>
						<td>
							<input type="text" class="classCalendar" id="cancelDateFromSearch" name="cancelDateFromSearch" size="10" value="${searchVO.cancelDateFromSearch}" />
							~<input type="text" class="classCalendar" id="cancelDateToSearch" name="cancelDateToSearch" size="10" value="${searchVO.cancelDateToSearch}" />
						</td>
						<!-- 현장보고서 검색조건 추가 시작-->
						<td bgcolor="#e7ecf1" style="text-align:center;"><b>현장보고서</b></td>
						<td>
							<div style="float:left;width:73%;">
							<select id="siteStateSearch" name="siteStateSearch" style="width: 40%;">
								<option value="9999" <c:if test="${searchVO.siteStateSearch == '9999'}">selected</c:if>>전체</option>
								<option value="0" <c:if test="${searchVO.siteStateSearch == '0'}">selected</c:if>>미결</option>
								<option value="1" <c:if test="${searchVO.siteStateSearch == '1'}">selected</c:if>>결재</option>								
								<option value="2" <c:if test="${searchVO.siteStateSearch == '2'}">selected</c:if>>종결</option>								
							</select>&nbsp;&nbsp;
							<input type="checkbox" id="siteResultSearch" name="siteResultSearch"
								<c:if test="${searchVO.siteResultSearch == 'on'}">checked</c:if>
							/> <span title="현장 보고서 제출 건 중 정식 보고서 제출 없이 일정 보고서만 제출된 건을 조회">일정보고만</span>
							</div>
							<div style="float:right;width:27%;">
							<!-- <img src="./resources/ls_img/ls_invoice/btn_src.gif" style='cursor:pointer;' id="searchBtn"/> -->
							<input class="buttonSearchMini" type="button" value="검색" id="searchBtn">
							<input type="hidden" id="hiddenSimpleQueryTxt" name="searchMainSimpleQueryTxt" value="${searchVO.searchMainSimpleQueryTxt}" >
							</div>
						</td>
						<!-- 현장보고서 검색조건 추가 끝-->
						
						<%-- <td style="text-align:right;">
							<img src="./resources/ls_img/ls_invoice/btn_src.gif" style='cursor:pointer;' id="searchBtn" />
							<input type="hidden" id="hiddenSimpleQueryTxt" name="searchMainSimpleQueryTxt" value="${searchVO.searchMainSimpleQueryTxt}" >
						</td> --%>
						
					</tr>
				</tbody>
			</table>
		</form>

	</div><!-- //tableStyle21 -->
	<!-- //검색 조건 테이블 -->

		<form action="./searchMainQuery" name="searchMainPagingForm" method="post">
			<input type="hidden" id="reqPgNo" name="reqPgNo" >
			<input type="hidden" id="presentPage" name="presentPage" value="${presentPage}" >
			<input type="hidden" id="stateSearch" name="stateSearch" value="${searchVO.stateSearch}" >
			<input type="hidden" id="siteStateSearch" name="siteStateSearch" value="${searchVO.siteStateSearch}" >
			<input type="hidden" id="processStateSearch" name="processStateSearch" value="${searchVO.processStateSearch}" >
			<input type="hidden" id="noUserSearch" name="noUserSearch" value="${searchVO.noUserSearch}" >
			<input type="hidden" id="type1Search" name="type1Search" value="${searchVO.type1Search}" >
			<input type="hidden" id="regDateFromSearch" name="regDateFromSearch" value="${searchVO.regDateFromSearch}" >
			<input type="hidden" id="regDateToSearch" name="regDateToSearch" value="${searchVO.regDateToSearch}" >
			<input type="hidden" id="cancelDateFromSearch" name="cancelDateFromSearch" value="${searchVO.cancelDateFromSearch}" >
			<input type="hidden" id="cancelDateToSearch" name="cancelDateToSearch" value="${searchVO.cancelDateToSearch}" >
			<input type="hidden" id="tmSearch" name="tmSearch" value="${searchVO.tmSearch}" >
			<input type="hidden" id="tmGubun" name="tmGubun" value="${searchVO.tmGubun}" >
			<input type="hidden" id="userNmSearch" name="userNmSearch" value="${searchVO.userNmSearch}" >
			<input type="hidden" id="aprvDateFromSearch" name="aprvDateFromSearch" value="${searchVO.aprvDateFromSearch}" >
			<input type="hidden" id="aprvDateToSearch" name="aprvDateToSearch" value="${searchVO.aprvDateToSearch}" >
			<input type="hidden" id="closeDateFromSearch" name="closeDateFromSearch" value="${searchVO.closeDateFromSearch}" >
			<input type="hidden" id="closeDateToSearch" name="closeDateToSearch" value="${searchVO.closeDateToSearch}" >
			<input type="hidden" id="ptnrSearch" name="ptnrSearch" value="${searchVO.ptnrSearch}" >
			<input type="hidden" id="ptnrGubun" name="ptnrGubun" value="${searchVO.ptnrGubun}" >
			<input type="hidden" id="ptnrDeptNmSearch" name="ptnrDeptNmSearch" value="${searchVO.ptnrDeptNmSearch}" >
			<input type="hidden" id="ptnrUserNmSearch" name="ptnrUserNmSearch" value="${searchVO.ptnrUserNmSearch}" >
			<input type="hidden" id="insuNmSearch" name="insuNmSearch" value="${searchVO.insuNmSearch}" >
			<input type="hidden" id="policyhNmSearch" name="policyhNmSearch" value="${searchVO.policyhNmSearch}" >
			<input type="hidden" id="policySsn1Search" name="policySsn1Search" value="${searchVO.policySsn1Search}" >
			<input type="hidden" id="policySsn2Search" name="policySsn2Search" value="${searchVO.policySsn2Search}" >
			<input type="hidden" id="benefiNmSearch" name="benefiNmSearch" value="${searchVO.benefiNmSearch}" >
			<input type="hidden" id="benefiSsn1Search" name="benefiSsn1Search" value="${searchVO.benefiSsn1Search}" >
			<input type="hidden" id="benefiSsn2Search" name="benefiSsn2Search" value="${searchVO.benefiSsn2Search}" >
			<input type="hidden" id="damagedNmSearch" name="damagedNmSearch" value="${searchVO.damagedNmSearch}" >
			<input type="hidden" id="accidentNoSearch" name="accidentNoSearch" value="${searchVO.accidentNoSearch}" >
			<input type="hidden" id="policyNoSearch" name="policyNoSearch" value="${searchVO.policyNoSearch}" >
			<input type="hidden" id="accidentFactsSearch" name="accidentFactsSearch" value="${searchVO.accidentFactsSearch}" >
			<input type="hidden" id="acceptNoSearch" name="acceptNoSearch" value="${searchVO.acceptNoSearch}" >
			<input type="hidden" id="moralSearch" name="moralSearch" value="${searchVO.moralSearch}" >
			
			<input type="hidden" id="siteResultSearch" name="siteResultSearch" value="${searchVO.siteResultSearch}">
			
			<input type="hidden" id="minwonSearch" name="minwonSearch" value="${searchVO.minwonSearch}" >
			<input type="hidden" id="searchMainSimpleQueryTxt" name="searchMainSimpleQueryTxt" value="${searchVO.searchMainSimpleQueryTxt}" >
			
			<input type="hidden" id="minwonDateFromSearch" name="minwonDateFromSearch" value="${searchVO.minwonDateFromSearch}" >
			<input type="hidden" id="minwonDateToSearch" name="minwonDateToSearch" value="${searchVO.minwonDateToSearch}" >			

			<input type="hidden" id="minwonDateFromSearch" name="moralDateFromSearch" value="${searchVO.moralDateFromSearch}" >
			<input type="hidden" id="minwonDateToSearch" name="moralDateToSearch" value="${searchVO.moralDateToSearch}" >						
			
		</form>
