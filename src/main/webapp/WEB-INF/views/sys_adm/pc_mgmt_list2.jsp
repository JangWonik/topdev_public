<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<link rel="stylesheet" href="./resources/jquery/themes/smoothness/jquery-ui.css">
	<script src="./resources/jquery/jquery.js"></script>
	<script src="./resources/jquery/jquery-ui.js"></script>
	<script>
		$(document).ready(function(){
			if('${mbrVo_Session.user_no}' == null || '${mbrVo_Session.user_state}' != 9){
				window.location.assign("./logout");
			}
		});//ready
	</script>
</head>

<body>

<!-- wrapper -->
<div id="wrapper">
	<!-- skipnavi --><!-- header -->
	<c:import url="../top_main/top_sysadm_menu.jsp"></c:import>
	<!-- //skipnavi --><!-- //header -->

	<!-- contents -->
	<div id="container">
		<div class="contetns">

			<!-- centercnt_top -->
			<div class="center_cnt_1300_ds">

				<!-- centercnt_bot -->
				<div class="centercnt_1300_bot1-2_ds">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">장비 관리</a></li>
							</ul>
						</div>

						<div class="guestcnt_1300_ds" style="display:block; height:700px !important;">
							<form id="srchFrm" name="srchFrm" method="get" action="pc_mgmt_list" onsubmit="return fnSearch();">
								<input type="hidden" id="pageIdx" name="pageIdx"/>
							</form>
						
							<div class= "tableStyle2">
								<table>
									<tr>
										<th>이름</th>
										<th>센터명</th>
										<th>팀명</th>
										<th>IP</th>
										<th>PC</th>
										<th>모니터1</th>
										<th>모니터2</th>
										<th> - </th>
									</tr>		
									<c:forEach items="${memberList}" var="item" varStatus="status">
										<tr>
											<td>${item.userName}</td>
											<td>${item.centerName}</td>
											<td>${item.teamName}</td>
											<td>${item.ipAddr}</td>
											<td>${item.computerNo}</td>
											<td>${item.monitorNo1}</td>
											<td>${item.monitorNo2}</td>
											<td> 상세보기 </td>										
										</tr>
									</c:forEach>
								</table>
								<br/>
								<div class="searchDiv" style="width: 100%; text-align: center;">
									<select>
                                    	<option>이름</option>
                                    	<option>센터명</option>
                                    	<option>팀명</option>
                                    </select>
                                    <input type="text" id="srchTxt" />
                                    <button type="button" id="srchBtn">검색</button>
								</div>
								<div class="pagingWrap">
                                    <%--<div class="pageContent">--%>
                                        <c:import url="/page_navi">
                                            <c:param name="beginIdx" value="${pageInfo.firstPageNoOnPageList}"/>
                                            <c:param name="endIdx" value="${pageInfo.lastPageNoOnPageList}"/>
                                            <c:param name="currentIdx" value="${pageInfo.currentPageNo}"/>
                                            <c:param name="totalPageCnt" value="${pageInfo.totalPageCount}"/>
                                        </c:import>
                                    <%--</div>--%>
                                </div>
                                
							</div><!-- //tableStyle2 -->
							<br />
						</div><!-- //guestcnt4 -->

					</div><!-- //guest -->
				</div>
				<!-- //centercnt_bot -->

				<!-- banner -->
				<c:import url="../top_main/top_main_banner.jsp"></c:import>
				<!-- //banner -->

			</div>
			<!-- //center_cnt -->
		</div>
	</div>
	<!-- //contents -->

	<!-- footer -->
	<c:import url="../top_main/top_main_footer.jsp"></c:import>
	<!-- //footer -->

</div>
<!-- //wrapper -->

<script>
	$(document).ready(function () {
	    _initButton();
	});
	
	function fnGoPage(pageIdx) {
	    var frm = document.getElementById("srchFrm");
	    frm.method = "get";
	    frm.action = "./pc_mgmt_list";
	    $("#pageIdx").val(pageIdx);
	    frm.submit();
	}

</script>



</body>

</html>
