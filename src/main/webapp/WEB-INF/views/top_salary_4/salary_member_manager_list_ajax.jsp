<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="./resources/ne_js/calendar.js?v=20170321111520"></script><!-- calendar -->
<table>	
	<tr>
		<th width="5%">No</th>
		<th width="45%">팀장 지정기간</th>
		<th width="15%">등록자</th>
		<th width="15%">등록일</th>
		<th width="20%"> - </th>
	</tr>
	<c:choose>		
		<c:when test="${userManagerList.size() == 0}">
			<tr>
				<td colspan="5" align="center">조회결과값이 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			 <c:forEach var="items" items="${userManagerList}" varStatus="status">
			 	<tr id="tr_manager_view_${items.mkey}">
			 		<td align="center">${userManagerList.size() - status.index}</td>
			 		<td align="center">${items.manager_sdate_fmt} ~ ${items.manager_edate_fmt}</td>
			 		<td align="center">${items.reg_user_nm}</td>
			 		<td align="center">${items.reg_date_fmt}</td>
			 		<td>
			 			<a id="btn_edit" href="#noloc" onclick="javascript:doMemberOptionMod('${items.mkey}')"><img src="./resources/ls_img/btn_edit_s.gif"/></a>
			 			<a id="btn_del" href="#noloc" onclick="javascript:doMemberOptionDel('${items.mkey}')"><img src="./resources/ls_img/btn_del_s.gif"/></a>
			 		</td>
			 	</tr>
			 	<tr id="tr_manager_edit_${items.mkey}" style="display:none;">
			 		<td align="center">${userManagerList.size() - status.index}</td>
			 		<td align="center">
			 			<input type="text" class="classCalendar" id="manager_sdate_mod_${items.mkey}" name="manager_sdate_mod_${items.mkey}"  value="${items.manager_sdate_fmt}" style="width:90px;"/> ~ 
						<input type="text" class="classCalendar" id="manager_edate_mod_${items.mkey}" name="manager_edate_mod_${items.mkey}" value="${items.manager_edate_fmt}" style="width:90px;"/>
			 		</td>
			 		<td align="center">${items.reg_user_nm}</td>
			 		<td align="center">${items.reg_date_fmt}</td>
			 		<td>			 		
						<a class="btn-equipment-save-s" id="btn-detail" style="width: 40px;" onclick="javascript:doMemberOptionModSave('${items.mkey}')" href="#noloc">저장</a>
						<a class="btn-equipment-cancel" id="btn-detail" style="width: 40px;" onclick="javascript:doMemberOptionModCancel('${items.mkey}')" href="#noloc">취소</a>
			 		</td>
			 	</tr>
			 </c:forEach>			
		</c:otherwise>
	</c:choose>
</table>