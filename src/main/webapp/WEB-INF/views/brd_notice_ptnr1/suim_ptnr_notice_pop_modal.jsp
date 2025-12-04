<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
	<c:choose>
		<c:when test="${empty boardDetail.ptnr_name}">
			<div id="headerpop">
				<div class="inner clear_v2">
					<h1>
						<img src="./resources/wm_img/common/logo.gif" height="39" alt="top - TRUST OBLIGATION PASSION" />
					</h1>
					<div style="text-align:center;padding-top:10px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
						<font color="white"><b><span style="font-size:11pt;"> 등록된 보험사 공지사항이 없습니다. </span></b></font>
					</div>
				</div>
			</div>			
		</c:when>
		<c:otherwise>
			<div id="headerpop">
				<div class="inner clear_v2">
					<h1>
						<img src="./resources/wm_img/common/logo.gif" height="39" alt="top - TRUST OBLIGATION PASSION" />
					</h1>
					<div style="text-align:center;padding-top:10px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
						<font color="white"><b><span style="font-size:11pt;"> <c:out value="${boardDetail.ptnr_name}" /> </span></b></font>
					</div>
				</div>
			</div>
			<!-- //header -->
			<div style="margin:10px 5px 0px 5px;">
					<div class="tableStyle4">
						<table>
							<tr>
								<td>
									${boardDetail.contents}
								</td>
							</tr>
						</table>
					</div>
			</div>		
		</c:otherwise>
	</c:choose>		    
   </body>
</html>
