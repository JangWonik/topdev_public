<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<body>

<!-- wrapper -->
<div id="wrapper">
	<div class="centercnt_top">
		<div class="nociteA log_top">
			<div class="search_bar">
				<%@ include file="log_member2_top.jsp" %>
			</div>
		</div>
	</div>

	<!-- contents -->
	<div class="centercnt_bot2">
		<div class="guest">
						
					<div class="guestTap">
						<ul>
							<li class='on' id="suimrpttab"><a href="#">기본통계</a></li>
							<li id="primbizrpttab"><a href="#">농작물</a></li>
							<li id="suit10rpttab"><a href="#">적부</a></li>
						</ul>
					</div>

						<!-- 수임대장 -->
						<div class="guestcnt2" style="display:block;">
							<c:import url="../ls_log/log_member2_base.jsp"></c:import>
						</div>

						<!-- 농작물수임대장 -->
						<div class="guestcnt2" style="display:none;">
							<c:import url="../ls_log/log_member2_nsc.jsp"></c:import>
						</div>

						<!-- 적부KB -->
						<div class="guestcnt2" style="display:none;">
							<c:import url="../ls_log/log_member2_contract.jsp"></c:import>
						</div>
		</div><!-- //guest -->
	</div>
</div>
<!-- //wrapper -->

</body>

</html>
