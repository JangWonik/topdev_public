<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="./resources/ne_js/calendar.js?v=20170321111520"></script><!-- calendar -->
<table>	
	<tr>
		<th width="5%">No</th>
		<th width="20%">연봉액</th>
		<th width="35%">연봉 계약기간</th>
		<th width="10%">등록자</th>
		<th width="10%">등록일</th>
		<th width="20%"> - </th>
	</tr>
	<c:choose>		
		<c:when test="${userAnnualList.size() == 0}">
			<tr>
				<td colspan="6" align="center">조회결과값이 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			 <c:forEach var="items" items="${userAnnualList}" varStatus="status">
			 	<tr id="annual_view_tr_${items.akey}">
			 		<td align="center">${userAnnualList.size() - status.index}</td>
			 		<td style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.annual_pay}" pattern="#,##0.##"/></td>
			 		<td align="center">${items.annual_sdate_fmt} ~ ${items.annual_edate_fmt}</td>
			 		<td align="center">${items.reg_user_nm}</td>
			 		<td align="center">${items.reg_date_fmt}</td>
			 		<td>
			 			<a id="btn_edit" href="#noloc" onclick="javascript:doAnnualOptionMod('${items.akey}')"><img src="./resources/ls_img/btn_edit_s.gif"/></a>
			 			<a id="btn_del" href="#noloc" onclick="javascript:doAnnualOptionDel('${items.akey}')"><img src="./resources/ls_img/btn_del_s.gif"/></a>
			 		</td>
			 	</tr>
			 	<tr id="annual_edit_tr_${items.akey}" style="display:none;">
			 		<td align="center">${userAnnualList.size() - status.index}</td>
			 		<td style="text-align:right;padding-right:5px;">
			 			<input type="text" id="annual_pay_mod_${items.akey}" name="annual_pay_mod_${items.akey}" value="${items.annual_pay}" style="text-align:right;width:120px;" ONKEYUP="javascript:numberCommaFunc(this);" style="IME-MODE: disabled;" class="amt" /> 원
			 		</td>
			 		<td align="center">
						<input type="text" class="classCalendar" id="annual_sdate_mod_${items.akey}" name="annual_sdate_mod_${items.akey}"  value="${items.annual_sdate_fmt}" style="width:90px;"/> ~ 
						<input type="text" class="classCalendar" id="annual_edate_mod_${items.akey}" name="annual_edate_mod_${items.akey}" value="${items.annual_edate_fmt}" style="width:90px;"/>			
					</td>
					<td align="center">${items.reg_user_nm}</td>
			 		<td align="center">${items.reg_date_fmt}</td>
					<td>
						<a class="btn-equipment-save-s" id="btn-detail" style="width: 40px;" onclick="javascript:doMemberAnnualModSave('${items.akey}')" href="#noloc">저장</a>
						<a class="btn-equipment-cancel" id="btn-detail" style="width: 40px;" onclick="javascript:doMemberAnnualModCancel('${items.akey}')" href="#noloc">취소</a>
					</td>
				</tr>
			 </c:forEach>			
		</c:otherwise>
	</c:choose>
</table>