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
											<th>부서</th>
											<td>
												<span style="text-align: left !important;">
													<select id="srchInfoTeamId" name="srchInfoTeamId" >
														<option value="0">- 전체 -</option>
														
														<c:set var="loopCheck" value="0"  />
														<c:forEach items="${teamList}" var = "teamVo">
														
															<c:choose>
																<c:when test="${infoParam.pms28 == 4 and teamVo.team_type != 4}">
																	<c:set var="loopCheck" value="0" />
																</c:when>
																<c:otherwise>
																	<c:set var="loopCheck" value="1" />
																</c:otherwise>
															</c:choose>
															
															
															<c:if test ="${loopCheck == 1}">
																<c:choose>
																	<c:when test="${infoParam.srchTeamId == teamVo.team_id}">
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
															</c:if>
															
															
															
														</c:forEach>
														
													</select>
												</span>
											</td>
											<th>이름</th>
											<td>
												<input type="text" id="srchInfoName" name="srchInfoName" value="${logParam.srchUserName}"/>
											</td>
											<td colspan="2">
												<a href="#noloc" class="btn-vacation-aprv" id="btn-search" onclick="fnInfoSearch();">검색</a>
											</td>
										</tr>
									</table>
									<br/>
								</div> 
								
								<table>
									<colgroup>
										<col style="width:5%" />
										<col style="width:15%" />
										<col style="width:10%" />
										<col style="width:10%" />
										<col style="width:10%" />
										
										<col style="width:12.5%" />
										<col style="width:12.5%" />
										<col style="width:12.5%" />
										<col style="width:12.5%" />
									</colgroup>
									<thead>
										<tr>
											<th rowspan="2">No.</th>
											<th rowspan="2">부서</th>
											<th rowspan="2">이름</th>
											<th rowspan="2">직급</th>
											<th rowspan="2">입사일</th>
											<th rowspan="2">총 휴가일수</th>
											<th colspan="2">사용 휴가일수</th>
											<th rowspan="2">남은 휴가일수</th>
										</tr>
										<tr>
											<th>신청 중</th>
											<th>승인 완료</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${vacationInfoList}" var="item" varStatus="status">
											<tr style ="cursor:pointer;">
												<td class="td-overflow-none">${status.count * pageInfo.currentPageNo }</td>
												<td class="td-overflow-none">${item.teamNm}</td>
												<td class="td-overflow-none">${item.userNm}</td>
												<td class="td-overflow-none">${item.workLevelNm}</td>
												<td class="td-overflow-none" style="letter-spacing: 0">${item.joinDate}</td>
												<td class="td-overflow-none">
													<c:choose>
														<c:when test="${item.teamType == 4}">
															${item.vacationDayCnt} 일
														</c:when>
														<c:otherwise>
															-
														</c:otherwise>
													</c:choose>
												</td>
												
												<td class="td-overflow-none">
													<fmt:formatNumber value="${item.vacationReqCnt}" pattern="##.#"/> 일
												</td>
												<td class="td-overflow-none">
													<fmt:formatNumber value="${item.vacationAppvCnt}" pattern="##.#"/> 일
												</td>
												
												<td class="td-overflow-none">
													<c:choose>
														<c:when test="${item.teamType == 4}">
															<fmt:formatNumber value="${item.vacationDayCnt - item.vacationReqCnt - item.vacationAppvCnt}" pattern="##.#"/> 일
														</c:when>
														<c:otherwise>
															-
														</c:otherwise>
													</c:choose>												
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
								$("#srchInfoTeamId").select2();
								
								
								/* 2채널 방식에서 패스워드 인풋 태그에서 엔터(코드 :13) 눌렸을 시 동작 */
								$("#srchInfoName").keypress(function(e) {
									 if (e.which == 13) {
										 fnInfoSearch();
									 }
								});			
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
							function fnInfoSearch(){
								
						        var param = {};
				        		param.srchTeamId = $("#srchInfoTeamId option:selected").val();
				        		param.srchUserName = $("#srchInfoName").val().trim(); 
						        
				        		fnInfoAction(param);
							}
							
							/* 페이지 Reload Ajax (검색, 페이지이동) */
							function fnInfoAction(param){
								var url = "/vacationInfoList";
								
							    $.ajax({
							        type: "POST",
							        url: url,
							        data: param,
							        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
							        timeout: 20000,
							        dataType: "HTML", 
							        success: function(data){
							        	$("#infoCnt").html();
							        	$("#infoCnt").html(data);
							        },
							        error: function(e){
							            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
							        },
						            beforeSend: function(){
						                $('#infoCnt').spin();
						            },
						            complete: function(){
						                $('#infoCnt').spin(false);
						            }
							    });			
							}
							
							
							
						</script>

</body>
</html>
