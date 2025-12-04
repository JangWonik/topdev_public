<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
							<c:if test="${mbrVo_Session.user_state eq 9}">
							<table>
								<tr>
									<td style="text-align:right;padding : 0 0 5px 0">
										<a id="btn_excel" href="#noloc"><img src="./resources/ls_img/btn_excel.gif"></a>
									</td>
								</tr>
							</table>												
							</c:if>
							<div class="tableStyle2">								
								<table>									
									<thead>										
										<tr>
											<th width="5%">번호</th>
											<th width="5%">상태</th>
											<th width="8%">구분</th>
											<th width="10%">제목</th>
											<th width="3%">첨부</th>
											<th width="8%">요청부서</th>
											<th width="8%">요청자</th>
											<th width="8%">요청일</th>
											<th width="8%">접수자</th>
											<th width="8%">접수일</th>
											<th width="8%">결재(반려)자</th>
											<th width="8%">결재(반려)일</th>
											<th width="8%">완료일</th>
											<th width="5%">조회</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${boardListAuth}" var="boardList">
											<tr>
													<!--번호-->
													<td>${boardList.board_no}</td>
													<!--상태-->
													<td>${boardList.solve_state_nm}</td>
													<!--구분-->
													<td>${boardList.accept_classify_nm}</td>
													<!--제목-->
													<td style="text-align:left;padding-left:7px;">
														<div style="width:110px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;cursor:pointer;">
														<a href="./helpDeskBoardDetail?boardNo=${boardList.board_no}&boardSrcType=${searchVO.boardSrcType}&boardSrcWord=${searchVO.boardSrcWord}&reqPgNo=${reqPgNoInt1}">
															${boardList.title}
														</a>
														<c:if test="${boardList.memo_cnt > 0}"> [ ${boardList.memo_cnt} ] </c:if>
														</div>
													</td>
													<!--첨부-->
													<td>
														<c:if test="${boardList.file_cnt > 0}">
															<img alt="" src="./resources/ls_img/ls_board/icon_disket.gif">
														</c:if>
													</td>
													<!--요청부서-->
													<td>${boardList.team_name}</td>
													<!--요청자-->
													<td>${boardList.user_nm}</td>
													<!--작성일-->
													<td>${boardList.reg_date_fmt}</td>
													<!--접수자-->
													<td>${boardList.drafter_nm}</td>
													<!--접수일-->
													<td>${boardList.accept_date_fmt}</td>
													<!--결재(반려)자-->
													<td>${boardList.approval_nm}</td>
													<!--결재(반려)일-->
													<td>${boardList.approval_date_fmt}</td>
													<!--완료일-->
													<td>${boardList.solve_date_fmt}</td>
													<!--조회-->
													<td>${boardList.view_cnt}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							<table border="0" style="margin-top:7px;">
								<tr>
									<td align="center">
										<!-- page -->
									<c:if test="${pgNm8 != null}">
										<c:if test="${startPgNoInt8 > 10}">
											<a href="javascript:reqPgNoClick(${startPgNoInt8 - 1},'auth');">&lt;</a>
										</c:if>
								
										<c:forEach var="pageNo" begin="${startPgNoInt8}" end="${endPgNoInt8}" step="1">
											<c:choose>
												<c:when test="${reqPgNoInt8 != pageNo}">
													<a href="javascript:reqPgNoClick(${pageNo},'auth');"><c:out value="${pageNo}" /></a>
													&nbsp;&nbsp;
												</c:when>
												<c:otherwise>
													<font color="red"><c:out value="${pageNo}" /></font>
													&nbsp;&nbsp;
												</c:otherwise>
											</c:choose>
										</c:forEach>
								
										<c:if test="${totPgCntInt8 >= endPgNoInt8 + 1}">
											<a href="javascript:reqPgNoClick(${endPgNoInt8 + 1},'auth');">&gt;</a>
										</c:if>
									</c:if>
										<!-- //page -->
									</td>
								</tr>
							</table>
