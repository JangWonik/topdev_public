<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- <%--<script src="./resources/daum/161109.js"></script>--%>
	<script src="./resources/daum/postcode.v2.js"></script>
	<script src='https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js'></script> -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	<script>
		$(document).ready(function(){
			/* 검색 동작 시작 */
 			$("#searchBtn").click(function(){
 				$.post("./searchSuimReg",
 						{	
 							accept_no:$("#searchStr").val()
 						},
 						function(data,status){
 							$("#srcResult").empty();
 							if(status == "success"){
 								
 								
 								if(data.length == 0){
 									
 									$("#srcResult").append(
 										"<tr>"
 											+"<td colspan='12'> 검색 결과 없음</td>"
 										+"</tr>"
 												
 									);
 									
 									$("#searchStr").focus();
 									
 								}else{
 				                    $.each(data, function(index, entry) {
 				                    	
			                    		$("#srcResult").append("<tr onclick=\"putSuimIns('"+entry.rpt_no+"','"+entry.teamId+"','"+entry.userNo+"','"+entry.ptnrId+"','"+entry.ptnrDeptId+"','"+entry.ptnrMbrId+"','"+entry.suim_rpt_type1+"');\" style= 'cursor:pointer;' onMouseOver='this.style.backgroundColor=\"#FFECEC\"' onMouseOut='this.style.backgroundColor=\"\"'>"
			                    				
												+ "<td  >"+entry.ROWNUM+"</td>"
												+ "<td  >"+entry.suim_rpt_type1_nm+"</td>"
												+ "<td  >"+entry.accept_no+"</td>"
												+ "<td  >"+entry.ptnr_nick+"</td>"
												+ "<td  >"+entry.ptnr_dept_nm+"</td>"
												+ "<td  >"+entry.ptnr_mbr_nm+"</td>"
												+ "<td  >"+entry.team_name+"</td>"
												+ "<td  >"+entry.accident_date+"</td>"
												+ "<td  >"+entry.reg_date+"</td>"
												
		                                		+ "</tr>"
		                                		
			   							);
 				                    	
 									});//each
 									
 				                   $("#searchStr").focus();
 								}
 							}else{
 								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
 							}
 						},"json"
 				);//post
 				
 			});//$("#certSearchBtn").click
 			/* 검색 동작 끝*/
		}); //ready
		
		
	</script>
	
	
</head>

<body>

	<div class= "tableStyle4" align="center">
		<!-- 검색테이블 시작 -->
		<table align="center">
			<thead>
				<tr>
					<th >접수번호</th>
					<th >비고</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<input type="text" id="searchStr" name="searchStr" size="50" onfocus = "this.select()"/>
					</td>
					<td>
						<input type="image" src="./resources/ls_img/btn_src.gif" id="searchBtn" />
					</td>
				</tr>
			</tbody>
		</table>
		<!-- 검색 테이블 끝-->
	</div>
	<div class= "tableStyle4" align="center" style="height:680px;overflow-y:auto;">
		<table align="center" style="margin-top:35px;">
			<thead>
				<tr>
					<th width="4%">no.</th>
					<th width="12%">구분</th>
					<th width="10%">접수번호</th>
					
					<th>보험사</th>
					<th>보험팀</th>
					<th>보험담당</th>
					<th width="13%">처리팀</th>
					
					<th>사고</th>
					<th>수임</th>
					
				</tr>
			</thead>
			<tbody id = "srcResult">
				<c:forEach items="${suimBookList}" var="suimVO" > <!-- begin="1" end="20" step="1" -->
				<tr style= 'cursor:pointer;' onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" 
				onclick="putSuimIns('${suimVO.suim_rpt_no}','${suimVO.team_id}','${suimVO.user_no}','${suimVO.ptnr_id}','${suimVO.ptnr_dept_id}','${suimVO.ptnr_mbr_no}','${suimVO.suim_rpt_type1}');">
					<td>${suimVO.ROWNUM}</td>
					<td>${suimVO.suim_rpt_type1_nm}</td>
					<td>${suimVO.suim_accept_no}</td>
					
					<td>${suimVO.ptnr_nick}</td>
					<td>${suimVO.ptnr_dept_nm}</td>
					<td>${suimVO.ptnr_mbr_nm}</td>
					<td>${suimVO.team_name}</td>
					
					
					<td>${suimVO.accident_date_fmt}</td>
					<td>${suimVO.reg_date_fmt}</td>
					
					
				</tr>
				</c:forEach>
			</tbody>	
		</table>

	</div>

</body>

</html>
