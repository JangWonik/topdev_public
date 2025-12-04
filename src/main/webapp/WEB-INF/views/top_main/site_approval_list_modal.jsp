<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div id="lecture-process-dialog" title="현장보고서 결재요청 내역" style="font-size: 12px;" align="center">
	<br/>	
	<div class="tableStyle2" style="width: 950px;">		
		<table>
			<tr>
				<th width="5%">순번</th>
				<th width="10%">구분</th>
				<th width="10%">접수번호</th>
				<th width="15%">보험사</th>
				<th width="20%">피보험자</th>
				<th width="15%">담당팀</th>
				<th width="15%">담당자</th>				
				<th width="10%">수임일자</th>																
			</tr>
			<c:forEach items="${approvalSiteList}" var="item" varStatus="status">
				<tr onclick="javascript:popSuimDtl(${item.suim_rpt_no});" style="cursor:pointer;" onmouseover="this.style.backgroundColor='#FFECEC'" onmouseout="this.style.backgroundColor=''">					
					<td>${approvalSiteList.size() - status.index}</td>
					<td>${item.suim_rpt_type1_nm}</td>
					<td>${item.suim_accept_no }</td>
					<td>${item.ptnr_name}</td>
					<td style="text-align:center;" title="${item.beneficiary_nm}">
						<div style="width:190px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">						
							${item.beneficiary_nm}
						</div>
					</td>
					<td>${item.team_name}</td>
					<td>${item.user_name}</td>
					<td>${item.reg_date_fmt}</td>																	
				</tr>
			</c:forEach>									
		</table>	
	</div>
</div>