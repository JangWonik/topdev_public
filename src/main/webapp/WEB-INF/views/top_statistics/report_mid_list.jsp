<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

				<div class="centercnt_top">
				</div><!-- centercnt_top -->

				<div class="center_cnt_1300_bot" style="margin:0 auto;">
					<div class="guest">
					<script>
						$(document).ready(function(){
							if('${mbrVo_Session.user_no}' == null || '${mbrVo_Session.user_no}'.trim() == ''){
								alert("로그아웃 상태입니다. 재로그인 하십시오.");
								window.location.assign("./logout");
							}
						});//ready
				
						function noSiteMngTmMbrList(tmNo,UsrNo){
							var cw=screen.availWidth;
							var ch=screen.availHeight;
							var sw=1305; //띄울 창의 넓이
							var sh=740;  //띄울 창의 높이
							var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
							var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
							window.open('myNoSiteListPop?tmNo='+tmNo+'&UsrNo='+UsrNo,'noSiteMngTmMbrList','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=no');
						}
					</script>
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">현장 및 중간보고 현황</a></li>
							</ul>
						</div>
						<div class="guestcntSearch" style="display:block;">
							<div class="tableStyle2" >
							<center>
								<table cellpadding="0" cellspacing="0" summary="team조사" style="width:600px;" >
									<thead>
										<tr>
											<th>팀</th>
											<th width="85px">이름</th>
											<th>현장</th>
											<th>중간</th>
											<th>진행<br />경과</th>
										</tr>
									</thead>
									<tbody>
										<c:set var="tmMbrCnt" value="" />
										<c:forEach items="${teamCnt}" var="cntVO" varStatus="cntStatus">
												<c:if test="${tmMbrCnt != cntVO.team_id}">
													<tr>
														<c:set var="tmMbrCnt" value="${cntVO.team_id}" />
														<td rowspan="${cntVO.team_type}">${cntVO.team_name}</td>
													</tr>
												</c:if>
												<c:forEach items="${reportMidList}" var="listVO" varStatus="listStatus">
													<c:if test="${tmMbrCnt == listVO.team_id}">
														<tr	onMouseOver="this.style.backgroundColor='#FFECEC'"
															onMouseOut="this.style.backgroundColor=''" style ="cursor:pointer;"
															onclick="noSiteMngTmMbrList('${listVO.team_id}','${listVO.user_no}')">
															<td>${listVO.user_name}</td>
															<td>${listVO.miSiteCnt}</td>
															<td>${listVO.miInterimCnt}</td>
															<td>${listVO.interim2Cnt}</td>
														</tr>
													</c:if>
												</c:forEach>
										</c:forEach>


									</tbody>
								</table>
							<center>
							</div><!-- //tableStyle2 -->
						</div><!-- //guestcnt2 -->
					</div>
				</div><!-- centercnt_bot2 -->
