<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="tableStyle2">
    <div style="padding-right: 17px; background: #e7ecf1;">
        <table cellpadding="0" cellspacing="0" width="1060" align="center">
		    <thead >
			    <tr>
			        <th rowspan="2" onclick="fnOrderList('');" style="cursor: pointer;">이름</th>
			        <th rowspan="2" onclick="fnOrderList('');" style="cursor: pointer;">센터명</th>
			        <th class="border-right" rowspan="2" onclick="fnOrderList('');" style="cursor: pointer;">팀명</th>
			        <th class="border-right" colspan="4" >기준업무량</th>
	<!-- 		        <th colspan="4" width="30%">공헌이익</th> -->
			        <th class="border-left" rowspan="2">민원발생<br>(건)</th>
			        <th rowspan="2">보험사기 제보, 적발<br>(건)</th>
			    </tr>
			    
			    <tr>
			    	<th onclick="fnOrderList('purpose');" style="cursor: pointer;">
			    		목표(건)
			    		<c:choose>
			    			<c:when test="${srchArg.orderKey eq 'purpose'&& srchArg.orderDirection eq 'asc'}">&nbsp;▲</c:when>
			    			<c:when test="${srchArg.orderKey eq 'purpose'&& srchArg.orderDirection eq 'desc'}">&nbsp;▼</c:when>
			    		</c:choose>
		    		</th>
			    	<th onclick="fnOrderList('calc');" style="cursor: pointer;">
			    		종결(건) 
			    		<c:choose>
			    			<c:when test="${srchArg.orderKey eq 'calc'&& srchArg.orderDirection eq 'asc'}">&nbsp;▲</c:when>
			    			<c:when test="${srchArg.orderKey eq 'calc'&& srchArg.orderDirection eq 'desc'}">&nbsp;▼</c:when>
			    		</c:choose>
		    		</th>
			    	<th onclick="fnOrderList('rate');" style="cursor: pointer;">
			    		달성률
			    		<c:choose>
			    			<c:when test="${srchArg.orderKey eq 'rate'&& srchArg.orderDirection eq 'desc'}">&nbsp;▲</c:when>
			    			<c:when test="${srchArg.orderKey eq 'rate'&& srchArg.orderDirection eq 'asc'}">&nbsp;▼</c:when>
			    		</c:choose>
		    		</th>
		    		
			    	<th onclick="fnOrderList('rank');" style="cursor: pointer;">
			    		백분위(상위)
			    		<c:choose>
			    			<c:when test="${srchArg.orderKey eq 'rank'&& srchArg.orderDirection eq 'asc'}">&nbsp;▲</c:when>
			    			<c:when test="${srchArg.orderKey eq 'rank'&& srchArg.orderDirection eq 'desc'}">&nbsp;▼</c:when>
			    		</c:choose>
		    		</th>
	<!-- 		    	<th width="7.5%">목표금액</th> -->
	<!-- 		    	<th width="7.5%">수수료 실적</th> -->
	<!-- 		    	<th width="7.5%">달성률</th> -->
	<!-- 		    	<th width="7.5%">백분위(상위)</th> -->
			    </tr>
		    </thead>
		</table>
	</div>
	
	<div style="height:630px; overflow-x: hidden; overflow-y: scroll;">
		<table border="1">
		    <tbody>
		    	<c:forEach var="item" items="${workloadList}" varStatus="status">
			    		<!-- 이름 -->
			    		<td>${item.userName}</td>
			    		<!-- 센터명 -->
			    		<td>${item.centerName}</td>
			    		<!-- 팀명 -->
			    		<td class="border-right">${item.teamName}</td>
			     		<!-- 기준업무량-목표(건) -->
			     		<td>
			     			<fmt:formatNumber value="${item.purpose_workload}" pattern="0.0##"/> 
		     			</td>
			     		<!-- 기준업무량-종결(건)-->
			     		<td>
			     			<fmt:formatNumber value="${item.calc_workload}" pattern="0.0##"/> 
		     			</td>
						<!-- 기준업무량-달성률 -->
						<td>
							<c:choose>
								<c:when test="${item.calc_workload != 0 && item.purpose_workload  != 0}">
									<fmt:formatNumber value="${item.calc_workload / item.purpose_workload * 100}" pattern="0.0#"/> %
								</c:when>
								<c:otherwise>
									0.0%
								</c:otherwise>
							</c:choose>
						</td>
						<!-- 기준업무량-백분위(상위) -->
						<td class="border-right">
							<c:choose>
								<c:when test="${item.rank_workload != 0}">
									<fmt:formatNumber value="${item.rank_workload / item.rankListSize * 100}" pattern="0.0"/> %
								</c:when>
								<c:otherwise>
									0.0%
								</c:otherwise>
							</c:choose>
						</td>
			     		<!-- 공헌이익-목표금액 -->
<!-- 			     		<td width="7.5%"></td> -->
			     		<!-- 공헌이익-수수료 실적 -->
<!-- 			     		<td width="7.5%"></td> -->
			     		<!-- 공헌이익-달성률 -->
<!-- 			     		<td width="7.5%"></td> -->
			     		<!-- 공헌이익-백분위(상위) -->
<!-- 			     		<td width="7.5%"></td> -->
			     		<!-- 민원발생(건) -->
			     		<td>${item.minwonCnt}</td>
			     		<!-- 보험사기 제보, 적발(건) -->
			     		<td>${item.moralCnt}</td>
			     	</tr>
		    	</c:forEach>
		    </tbody>
		</table>
	</div>
</div>

<script>
function fnOrderList(key){
	var key;
	
	if ( $("#srchOrderKey").val() == key ){
		if ($("#srchOrderDirection").val() == 'desc'){
			$("#srchOrderDirection").val('asc');
		}else{
			$("#srchOrderDirection").val('desc');
		}
	}else{
		if (key == 'rank'){
			$("#srchOrderDirection").val('asc');			
		}else{
			$("#srchOrderDirection").val('desc');
			
		}
	}
	
	$("#srchOrderKey").val(key);
	
    $("#loading").show();
    
    var frm = document.getElementById("srchFrm");
    frm.action = "./workloadStatistics";
    frm.submit();
}



</script>
