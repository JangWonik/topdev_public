<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<!-- footer -->
	<div id="footer">
		<!-- inner -->
		<div class="inner">
			<ul class="infolist">
				<li>서울특별시 마포구 마포대로 63-8, 301(도화동, 삼창프라자 빌딩) </li>
				<li>전화 02-6077-4600</li>
				<li>팩스 02-338-3234</li>
				<li><a href="javascript:history.back(-1);"><img src="./resources/ls_img/icon_copy_back.gif"></a></li>
				<li>
					<c:choose>
						<c:when test="${mbrVo_Session.user_state == 9}">
							<a href="./holidayPan"><img src="./resources/ls_img/icon_copy_top.gif"></a>
						</c:when>
						<c:otherwise>
							<a href="#"><img src="./resources/ls_img/icon_copy_top.gif"></a>
						</c:otherwise>
					</c:choose>
				</li>
				<c:if test="${mbrVo_Session.user_no == 670 || mbrVo_Session.user_no == 215 || mbrVo_Session.user_no == 6 || mbrVo_Session.user_no == 1265 || mbrVo_Session.user_no == 966}">
					<li>
						<a href="https://old.toplac.co.kr/admng" target="_blank">연봉바로가기</a>
					</li>
				</c:if>
			</ul>
		</div>
		<!-- //inner -->
	</div>
	<!-- //footer -->
	<%--로딩 div --%>
   <div id="loading" style="display: none;">
       <img id="loading-image" src="./resources/cmm/images/spinner.gif" alt="Loading..." />
   </div>
