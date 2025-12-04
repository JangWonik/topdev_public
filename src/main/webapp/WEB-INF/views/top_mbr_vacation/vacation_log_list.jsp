<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
	
	<style>
		.td-overflow-none{
			text-overflow : ellipsis;
			overflow : hidden;
			white-space : nowrap;
			word-wrap:normal;
		}
		
		.btn-vacation-aprv {
			font-weight:bold;
			text-decoration:none;
			font-family:Arial;
			text-indent:0px;
			line-height:0px;
			-moz-border-radius:5px;
			-webkit-border-radius:5px;
			border-radius:5px;
			text-align:center;
			vertical-align:middle;
			display:inline-block;
			font-size:12px;
			color:#696969  !important;
			width:60px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #eeeeee;
		}

		/* 모달 버튼 */
		.ui-button-text-only {
			height:2.1em !important;
		}
	</style>	
		
							<div class="tableStyle2" style="border-top: 0px;">
								<!-- search-box -->
								<div id="search-box"  align="center">
									<input type="hidden" id="currPageIdx" value="${pageInfo.currentPageNo}"/>
									<table style="width: 80%;" align="center">
										<colgroup>
											<col width="96px" />
											<col width="270px" />
											<col width="96px" />
											<col width="270px" />
											<col width="96px" />
											<col width="270px" />
										</colgroup>
										<tr>
											<th>년도</th>
											<td>
												<select id="srchLogYear">
													<option value="99">- 전체 -</option>
													<c:forEach items="${yearList}" var="item" varStatus="status">
														<c:choose>
															<c:when test="${logParam.srchYear == item}">
																<option value="${item}" selected="selected">${item} 년</option>
															</c:when>
															<c:otherwise>
																<option value="${item}">${item} 년</option>
															</c:otherwise>
														</c:choose>
													</c:forEach>
												</select>
											</td>
											<th>종류</th>
											<td>
												<select id="srchLogKind">
													<option value="99">- 전체 -</option>
													<c:forEach items="${vacationKindList}" var="item" varStatus="status">
														<c:choose>
															<c:when test="${logParam.srchKind == item.col_cd}">
																<option value="${item.col_cd}" selected="selected">${item.col_val}</option>
															</c:when>
															<c:otherwise>
																<option value="${item.col_cd}">${item.col_val}</option>
															</c:otherwise>
														</c:choose>													
													</c:forEach>
												</select>											
											</td>
											<th>상태</th>
											<td>
												<select id="srchLogState">
													<option value="99">- 전체 -</option>
													<c:forEach items="${vacationStateList}" var="item" varStatus="status">
														<c:choose>
															<c:when test="${logParam.srchState == item.col_cd}">
																<option value="${item.col_cd}" selected="selected">${item.col_val}</option>
															</c:when>
															<c:otherwise>
																<option value="${item.col_cd}">${item.col_val}</option>
															</c:otherwise>
														</c:choose>		
													</c:forEach>	
												</select>												
											</td>
										</tr>
										<tr>
											<th>부서</th>
											<td>
												<span style="text-align: left !important;">
													<select id="srchLogTeamId" name="srchLogTeamId"  style="width: 156px;">
														
														<c:if test="${logParam.pms28 == 1 or logParam.pms28 == 4}">
															<option value="0">- 전체 -</option>
														</c:if>
														
														<c:forEach items="${teamList}" var = "teamVo">
															<c:choose>
																<c:when test="${logParam.srchTeamId == teamVo.team_id}">
																	<option value="${teamVo.team_id}" selected="selected">
																</c:when>
																<c:otherwise>
																	<option value="${teamVo.team_id}">
																</c:otherwise>
															
															</c:choose>
															
																<c:if test="${teamVo.team_level == 1}">&nbsp;└</c:if>
																<c:if test="${teamVo.team_level == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
																${teamVo.team_name}
															</option>
														</c:forEach>
													</select>
												</span>
											</td>
											<th>이름</th>
											<td>
												<input type="text" id="srchLogName" name="srchLogName" value="${logParam.srchUserName}"/>
											</td>
											<td colspan="2">
												<a href="#noloc" class="btn-vacation-aprv" id="btn-search" onclick="fnLogSearch();">검색</a>
											</td>
										</tr>
									</table>
									<br/>
								</div> 
								
								<table>
									<colgroup>
										<col width="4%"/>
										<col width="8%"/>
										<col width="8%"/>
										<col width="7%"/>
										<col width="3%"/>
										<col width="6%"/>
										<col width="6%"/>
										<col width="8%"/>
										<col width="12%"/>
										<col width="5%"/>
										<col width="20%"/>
										<col width="6%"/>
										<col width="7%"/>
									</colgroup>
									<thead>
										<tr>
											<th>No.</th>
											<th>센터명</th>
											<th>부서명</th>
											<th>이름</th>
											<th>직급</th>
											<th>입사일</th>
											<th>신청일</th>
											<th>종류</th>
											<th>기간</th>
											<th>사용 일수</th>
											<th>사유</th>
											<th>상태</th>
											<th>비고</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${vacationLogList}" var="item" varStatus="status">
											<tr class="aprvTr" id="aprvTr${item.vacationNo}" style ="cursor:pointer;">
												<td class="td-overflow-none">${item.vacationNo}</td>
												<td class="td-overflow-none">${item.centerNm}</td>
												<td class="td-overflow-none">${item.teamNm}</td>
												<td class="td-overflow-none">${item.userNm}</td>
												<td class="td-overflow-none">${item.workLevelNm}</td>
												<td class="td-overflow-none">${item.joinDate}</td>
												<td class="td-overflow-none">${item.regDate}</td>
												<td class="td-overflow-none">${item.vacationKindValue}</td>
												<td class="td-overflow-none" style="letter-spacing: 0px;">${item.vacationStartDate} ~ ${item.vacationEndDate}</td>
												<td class="td-overflow-none">
													<fmt:formatNumber value="${item.vacationUseCnt}" pattern="##.#"/> 일
												</td>
												<td class="td-overflow-none">${item.vacationComment}</td>
												<td class="td-overflow-none">${item.vacationStateValue}</td>
												<td class="td-overflow-none">
													<a href="#noloc" class="btn-vacation-aprv" id="btn-detail" onclick="openDetail(${item.vacationNo})" style="width: 58px;">상세보기</a>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<div class="pagingWrap">
						    	<%--<div class="pageContent">--%>
						        	<c:import url="/page_navi_multi">
						            	<c:param name="beginIdx" value="${pageInfo.firstPageNoOnPageList}"/>
						                <c:param name="endIdx" value="${pageInfo.lastPageNoOnPageList}"/>
						                <c:param name="currentIdx" value="${pageInfo.currentPageNo}"/>
						                <c:param name="totalPageCnt" value="${pageInfo.totalPageCount}"/>
						                <c:param name="pageName" value="${pageInfo.pageName}"/>
									</c:import>
								<%--</div>--%>
						      	</div>	
								
							</div><!-- //tableStyle2 -->
							
						
						<script>
							$(document).ready(function(){
								$("#srchLogTeamId").select2();
								$("#srchLogYear").select2();
								$("#srchLogKind").select2();
								$("#srchLogState").select2();
							});
							
							/* 페이지 이동 */
							function fnGoPage(pageIdx,pageName) {
								
						        var param = {};
						        
						        if (pageName == "log"){
							        param.pageIdx 	= pageIdx;
							        param.srchYear 	= $("#srchLogYear option:selected").val();
						        	param.srchKind 	= $("#srchLogKind option:selected").val();
					        		param.srchState = $("#srchLogState option:selected").val();
					        		param.srchTeamId = $("#srchLogTeamId option:selected").val();
					        		param.srchUserName = $("#srchLogName").val().trim(); 
					        		fnLogAction(param);				        
						        }else if(pageName == "info"){
							        param.pageIdx 	= pageIdx;
					        		param.srchTeamId = $("#srchInfoTeamId option:selected").val();
					        		param.srchUserName = $("#srchInfoName").val().trim(); 
							        	
					        		fnInfoAction(param);	
						        }
						    }
							
							/* 검색 */
							function fnLogSearch(){
						        var param = {};
						        param.srchYear 	= $("#srchLogYear option:selected").val();
					        	param.srchKind 	= $("#srchLogKind option:selected").val();
				        		param.srchState = $("#srchLogState option:selected").val();
				        		param.srchTeamId = $("#srchLogTeamId option:selected").val();
				        		param.srchUserName = $("#srchLogName").val().trim();
						        
				        		fnLogAction(param);
							}
							
							/* 페이지 Reload Ajax (검색, 페이지이동) */
							function fnLogAction(param){
								var url = "/vacationLogList";
								
							    $.ajax({
							        type: "POST",
							        url: url,
							        data: param,
							        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
							        timeout: 20000,
							        dataType: "HTML", 
							        success: function(data){
							        	$("#logCnt").html();
							        	$("#logCnt").html(data);
							        },
							        error: function(e){
							            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
							        },
						            beforeSend: function(){
						                $('#logCnt').spin();
						            },
						            complete: function(){
						                $('#logCnt').spin(false);
						            }
							    });			
							}
							
						</script>

</body>
</html>
