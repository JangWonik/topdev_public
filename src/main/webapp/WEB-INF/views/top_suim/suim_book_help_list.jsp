<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<style>
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
			color:#FFFFFF  !important;
			width:60px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #2E7EE8;
		}
	</style>
	<script>
		$(document).ready(function(){
			$("#srchSuimAcceptNo").focus();
		});//ready
	
		function popSuimDtl(serialNo, editYN){
// 			if(editYN < 1){
// 				alert("열람 권한이 없습니다.");
// 				return;
// 			}
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=705; //띄울 창의 넓이
			var sh=700;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('helpRptBscDtl?serialNo='+serialNo,'_blank','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}
		
		function popSuimDtl2(serialNo, editYN){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1010; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('suimRptBscDtl?suim_rpt_no='+serialNo,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');}
		
		function doHelpSearch(){
			$("#helpSrcForm").submit();
		}
	</script>
</head>

<body>

<!-- wrapper -->
<div id="wrapper">
	<!-- skipnavi --><!-- header -->
	<c:import url="../top_main/top_main_menu.jsp"></c:import>
	<!-- //skipnavi --><!-- //header -->

	<!-- contents -->
	<div id="container">
		<div class="contetns">

			<!-- centercnt_top -->
			<div class="center_cnt_1300">

				<!-- centercnt_bot -->
				<div class="center_cnt_1300_bot">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">협조건 대장 - 전체팀</a></li>
							</ul>
						</div>
						<!-- 검색창시작 -->
						<div class="tableStyle2" style="padding:5px 0 0 0">
							<form method="get" name="helpSrcForm" id="helpSrcForm" action="./helpBookList">
							<table>																								
								<tr>
									<th width="155px">접수번호</th>
									<td style="text-align:left;padding-left:25px;border-right:hidden;height:30px;background:#F8FBEF;">
											<input type="text" id="srchSuimAcceptNo" name="srchSuimAcceptNo" value="${srchSuimAcceptNo}" size="30" />&nbsp;																							
											<input type="hidden" id="reqPgNo" name="reqPgNo" value="${searchVO.reqPgNo}"/>												
											&nbsp;<a class="btn-vacation-aprv" id="boardSrcBtn" href="javascript:doHelpSearch();">검 색</a>																							
									</td>									
								</tr>
							</table>
							</form>													
						</div>							
						<!-- 검색창끝 -->						
						<div class="guestcnt4" style="display:block;">
							<div class= "tableStyle2">
								<table>
									<thead>
										<tr>
											<th width="4%">no.</th>
											<th width="10%">의뢰팀</th>
											<th width="10%">의뢰인</th>
											<th width="10%">수임팀</th>
											<th width="10%">수임인</th>
											<th width="8%">접수번호</th>
											<th width="10%">피보험자</th>
											<th width="10%">의뢰일</th>
											<th width="10%">완료일</th>
											<th width="6%">상태</th>
											<th width="6%">상세보기</th>
											
										</tr>
									</thead>
									<tbody>
									<c:forEach items="${helpBookList}" var="helpVo" varStatus="status">
<!-- 									onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" -->
										<tr id = "${helpVo.serialNo}" 
										style ="cursor:pointer;" >
											<td>${helpVo.ROWNUM}</td>
											<td>${helpVo.clientTm}</td>
											<td>${helpVo.clientMbr}</td>
											<td>${helpVo.acceptTm}</td>
											<td>${helpVo.acceptMbr}</td>
											<td onClick="popSuimDtl2('${helpVo.suimRptNo}','${helpVo.editYN}');" 
												onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
												${helpVo.acceptNo}
											</td>
											<td>${helpVo.beneficiaryNm}</td>
											<td>${helpVo.regDate}</td>
											<c:choose>
												<c:when test="${helpVo.helpState eq '완료' }">
													<td>${helpVo.endDate}</td>
												</c:when>
												<c:otherwise>
													<td>-</td>
												</c:otherwise>
											</c:choose>
											<td>${helpVo.helpState}</td>
											<td onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
												<img src="./resources/ls_img/btns_view.gif" onclick="popSuimDtl('${helpVo.serialNo}','${helpVo.editYN}');" style="cursor:pointer;"/>
											</td>
										</tr>
									</c:forEach>
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
							
							<c:import url="../util_page/page_bsc_help.jsp" charEncoding="UTF-8"></c:import>
						</div><!-- //guestcnt4 -->

					</div>
				</div>
				<!-- //centercnt_bot -->

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

</body>
</html>
