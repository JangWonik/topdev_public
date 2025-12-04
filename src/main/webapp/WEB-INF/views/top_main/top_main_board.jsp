<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<style>
		.buttonMini{
			width:40px;
			height:18px;
		    background-color:#CEE3F6;
		    color:#666;
		    text-align: center;
			border-radius:5px;
		    font-size: 11px;
		    cursor: pointer;
		    text-decoration:none;
		    border: solid 1px grey;		    
		}
	</style>
				<div class="centercnt_top"><!-- centercnt_top -->
					<table>
						<tr>
							<td>
								<div class="nociteA nocite" style="height:200px;">
								<div class="notice_top">
									<h3>중요공지</h3>
								</div>					
								<div class="notice_bot" style="margin: 5px 13px 10px 13px;">
									<div class="tableStyle1">
										<table summary="공지사항" >
											<caption>중요공지</caption>
											<colgroup>
												<col width="*">
												<col width="80" />
											</colgroup>
											<tbody>
												<c:forEach items="${topMainBoardNoticeList}" var="boardNoticeVo" varStatus="noticeStatus">
												<tr>
													<!--제목-->
													<td>
														<c:choose>
															<c:when test="${boardNoticeVo.board_type == 1}">
																<a href="./noticeTopBoardDetail?boardNo=${boardNoticeVo.board_no}" class="txt"
																	onmouseover="contentpreviewlayer1('notice', ${noticeStatus.index});showpreviewlayer1('previewlayer1');"
																	onmouseout="hidepreviewlayer1('previewlayer1');">
																	<c:choose>
																		<c:when test="${boardNoticeVo.title_classify eq 1}">
																			<input class="buttonMini" type="button" value="1종" style="background-color:#F6CECE;">
																		</c:when>
																		<c:when test="${boardNoticeVo.title_classify eq 4}">
																			<input class="buttonMini" type="button" value="4종" style="background-color:#D8F6CE;">
																		</c:when>
																		<c:otherwise>
																			<input class="buttonMini" type="button" value="전체">
																		</c:otherwise>
																	</c:choose>&nbsp;																																	
																	${boardNoticeVo.title_text}
																	<c:if test="${boardNoticeVo.day_cnt <= 1}">
																		<span class="ico_new">
																			<img src="./resources/wm_img/common/ico_new.png" alt="new" />
																		</span>
																	</c:if>
																</a>
																<input type="hidden" name="board_notice" value="${boardNoticeVo.contents}" />
															</c:when>															
														</c:choose>
													</td>
													<!--작성일-->
													<td class="day">
														<c:choose>
															<c:when test="${boardNoticeVo.board_type == 1}">
																${boardNoticeVo.reg_date_fmt}
															</c:when>
														</c:choose>
													</td>
												</tr>
											</c:forEach>
											</tbody>
										</table>
									</div>
								</div>	
								<a href=./noticeTopBoardList class="btn_more"><img src="./resources/wm_img/common/btn_more.gif" alt="더보기" /></a>	
							</div>
							</td>
							
							<td>
								<div class="nociteA nocite notice02" style="height:200px;">
								<div class="notice_top">
									<h3>사내규정·지침</h3>
								</div>					
								<div class="notice_bot" style="margin: 5px 13px 10px 13px;">
									<div class="tableStyle1">
										<table cellpadding="0" cellspacing="0" summary="공지사항" >
											<caption>사내규정·지침</caption>
											<colgroup>
												<col width="*">
												<col width="80" />
											</colgroup>
											<tbody>
												<c:forEach var="item" items="${topMainGuidelist}" varStatus="status">
													<tr>
														<td>
															<!-- <span class="middot"></span> -->
															<a href="./brd_guide_view?guide_no=${item.guideNo}" class="txt"
																onmouseover="contentpreviewlayer1('guide', ${status.index});
																			 showpreviewlayer1('previewlayer1');"
																onmouseout="hidepreviewlayer1('previewlayer1');" style="width:330px;">
															<c:choose>
																<c:when test="${item.guideType == 1}">
																	<input class="buttonMini" type="button" value="1종" style="background-color:#F6CECE;">
																</c:when>
																<c:when test="${item.guideType == 4}">
																	<input class="buttonMini" type="button" value="4종" style="background-color:#D8F6CE;">
																</c:when>
																<c:otherwise>
																	<input class="buttonMini" type="button" value="전체">
																</c:otherwise>
															</c:choose>&nbsp;
															${item.title}															
															<c:if test="${item.dayCnt <= 1}">
																<span class="ico_new">
																	<img src="./resources/wm_img/common/ico_new.png" alt="new" />
																</span>														
															</c:if></a>
															<input type="hidden" name="board_guide" value="${item.contents}" />
														</td>
														<td class="day">${item.regDateFmt}</td>
													</tr>
												
												</c:forEach>
											</tbody>
										</table>
									</div>
								</div>	
								<a href="./brdGuideBoardList" class="btn_more"><img src="./resources/wm_img/common/btn_more.gif" alt="더보기" /></a>	
							</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="nociteA nocite" style="height:200px;">
								<div class="notice_top">
									<h3>보험사 공지&middot;자료실 / 평가기준&middot;결과</h3>
								</div>
								<div class="notice_bot" style="margin: 5px 13px 10px 13px;">
									<div class="tableStyle1">
										<table cellpadding="0" cellspacing="0" summary="보험사 공지&middot;자료실 / 평가기준&middot;결과">
											<caption>보험사 공지&middot;자료실 / 평가기준&middot;결과</caption>
											<colgroup>
												<col width="*">
												<col width="80" />
											</colgroup>
											<tbody>
												<c:forEach items="${topMainBoardNoticeList}" var="boardNoticeVo" varStatus="noticeStatus">
												<tr>
													<!--제목-->
													<c:choose>															
															<c:when test="${boardNoticeVo.board_type == 2}">															
															<td>
																<!-- <span class="middot"></span> -->
																<a href="./referencePtnrBoardDetail?boardNo=${boardNoticeVo.board_no}&cateSearch=${boardNoticeVo.category_id}" class="txt"
																	onmouseover="contentpreviewlayer1('notice', ${noticeStatus.index});showpreviewlayer1('previewlayer1');"
																	onmouseout="hidepreviewlayer1('previewlayer1');">
																	<c:choose>
																		<c:when test="${boardNoticeVo.title_classify eq 1}">
																			<input class="buttonMini" type="button" value="1종" style="background-color:#F6CECE;">
																		</c:when>
																		<c:when test="${boardNoticeVo.title_classify eq 4}">
																			<input class="buttonMini" type="button" value="4종" style="background-color:#D8F6CE;">
																		</c:when>
																		<c:otherwise>
																			<input class="buttonMini" type="button" value="전체">
																		</c:otherwise>
																	</c:choose>
																	<c:if test="${not empty boardNoticeVo.ptnr_name}">
																		<%-- <input class="buttonMini" type="button" value="${boardNoticeVo.ptnr_name}" style="background-color:#F7F7F7;width:50px;"> --%>
																		&nbsp;[${boardNoticeVo.ptnr_name}]
																	</c:if>
																	&nbsp;${boardNoticeVo.title_text}
																	<c:if test="${boardNoticeVo.day_cnt <= 1}">
																		<span class="ico_new">
																			<img src="./resources/wm_img/common/ico_new.png" alt="new" />
																		</span>
																	</c:if>
																</a>
																<input type="hidden" name="board_notice" value="${boardNoticeVo.contents}" />															
															</td>
															<td class="day">														
																${boardNoticeVo.reg_date_fmt}														
															</td>
														</c:when>															
													</c:choose>
													<!--작성일-->													
												</tr>
											</c:forEach>
											</tbody>
										</table>
									</div>
								</div>
								<a href="./referencePtnrBoardList" class="btn_more"><img src="./resources/wm_img/common/btn_more.gif" alt="더보기" /></a>
							</div>
							</td>
							<td>
								<div class="nociteA nocite notice02" style="height:200px;">
								<div class="notice_top">
									<h3>자유게시판</h3>
								</div>
								<div class="notice_bot" style="margin: 5px 13px 10px 13px;">
									<div class="tableStyle1">
										<table cellpadding="0" cellspacing="0" summary="공지사항">
											<caption>자유게시판</caption>
											<colgroup>
												<col width="*">
												<col width="80" />
											</colgroup>
											<tbody>
												<c:forEach items="${topMainBoardFreeList}" var="boardFreeVo" varStatus="status">
													<tr>
														<!--제목-->
														<td>
															<span class="middot"></span>
															<a href="./freeBoardDetail?boardNo=${boardFreeVo.board_no}" class="txt"
																onmouseover="contentpreviewlayer1('free', ${status.index});showpreviewlayer1('previewlayer1');"
																onmouseout="hidepreviewlayer1('previewlayer1');" style="width:330px;">
																${boardFreeVo.title}
																<c:if test="${boardFreeVo.day_cnt <= 1}">
																	<span class="ico_new">
																		<img src="./resources/wm_img/common/ico_new.png" alt="new" />
																	</span>
																</c:if>
															</a>
															<input type="hidden" name="board_free" value="${boardFreeVo.contents}" />
														</td>
														<!--작성일-->
														<td class="day">${boardFreeVo.reg_date_fmt}</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
								</div>
								<a href="./freeBoardList" class="btn_more"><img src="./resources/wm_img/common/btn_more.gif" alt="더보기" /></a>
							</div>
							</td>
						</tr>
					</table>
				</div><!-- //centercnt_top -->

				<!-- previewlayer1 -->
				<style type="text/css">
					#previewlayer1{
						position:absolute;
						padding:5px;
						/*filter:alpha(opacity=50);*/
						width:300px; height:55px;
						color:#333;
						background-color:white;
						border:1px #000000 dotted;
						z-index:999;
						overflow: hidden;
						visibility:hidden;
					}
				</style>
				<script type="text/javascript">
					function contentpreviewlayer1(text, no){
						if(text == 'free'){//alert(event.y);
							previewlayer1.innerHTML = document.getElementsByName("board_free")[no].value.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, "");
							previewlayer3location(no,550);
						}else if(text == 'notice'){
							previewlayer1.innerHTML = document.getElementsByName("board_notice")[no].value.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, "");
							previewlayer1location(no,90);
						}else if(text == 'guide'){
							previewlayer1.innerHTML = document.getElementsByName("board_guide")[no].value.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, "");
							previewlayer2location(no,550);
						}
					}
					function showpreviewlayer1(id){
						if(document.all)
							document.all[id].style.visibility="visible";
						else if(document.layers)
							document.layers[id].style.visibility="visible";            
					}
					
					
					
					function hidepreviewlayer1(id){
						if(document.all)
							document.all[id].style.visibility="hidden";
						else if(document.layers)
							document.layers[id].style.visibility="hidden";      
					}
					function previewlayer1location(top,left) {
						//previewlayer1.style.pixelTop=event.y+document.body.scrollTop+65;
						//previewlayer1.style.pixelLeft=event.x+document.body.scrollLeft+590;
						previewlayer1.style.pixelTop=(parseInt(top)*30)+70;
						previewlayer1.style.pixelLeft=left;
					}
					
					function previewlayer2location(top,left) {
						//previewlayer1.style.pixelTop=event.y+document.body.scrollTop+65;
						//previewlayer1.style.pixelLeft=event.x+document.body.scrollLeft+590;
						previewlayer1.style.pixelTop=(parseInt(top)*29)+62;
						previewlayer1.style.pixelLeft=left;
					}
					
					function previewlayer3location(top,left) {
						//previewlayer1.style.pixelTop=event.y+document.body.scrollTop+65;
						//previewlayer1.style.pixelLeft=event.x+document.body.scrollLeft+590;
						previewlayer1.style.pixelTop=(parseInt(top)*29)+260;
						previewlayer1.style.pixelLeft=left;
					}					

					//document.onmousemove=previewlayer1location;
				</script>
				<div id="previewlayer1">
				</div>
				<!-- //previewlayer1 -->
