<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div class= "tableStyle2" style="border-top:0px;">
	<table>	
		<c:forEach items="${pmsList}" var="pmsList" varStatus="">
			<tr>
				<td>${pmsList.user_name}</td>
				<td>${pmsList.mbr_pms_1}</td>
				<td>${pmsList.mbr_pms_3}</td>
				<td>${pmsList.mbr_pms_4}</td>
				<td>${pmsList.mbr_pms_5}</td>
				<td>${pmsList.mbr_pms_6}</td>
				<td>${pmsList.mbr_pms_7}</td>
				<td>${pmsList.mbr_pms_8}</td>
				<td>${pmsList.mbr_pms_9}</td>
				<td>${pmsList.mbr_pms_10}</td>
				<td>${pmsList.mbr_pms_11}</td>
				<td>${pmsList.mbr_pms_12}</td>
				<td>${pmsList.mbr_pms_13}</td>
				<td>${pmsList.mbr_pms_14}</td>
				<td>${pmsList.mbr_pms_15}</td>
				<td>${pmsList.mbr_pms_16}</td>
				<td>${pmsList.mbr_pms_17}</td>
				<td>${pmsList.mbr_pms_18}</td>
				<td>${pmsList.mbr_pms_19}</td>
				<td>${pmsList.mbr_pms_20}</td>
				<td>${pmsList.mbr_pms_21}</td>
				<td>${pmsList.reg_user}</td>
				<td>${pmsList.reg_date}</td>
			</tr>
		</c:forEach>					
	</table>
</div><!-- //tableStyle2 -->
