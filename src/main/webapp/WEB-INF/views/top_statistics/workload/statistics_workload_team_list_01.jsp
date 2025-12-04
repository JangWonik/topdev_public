<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<input type="hidden" id="gubun" name="gubun" value="${srchArg.gubun}">
<input type="hidden" id="type" name="type" value="${srchArg.type}">
<input type="hidden" id="teamId" name="teamId" value="${srchArg.teamId}">
<input type="hidden" id="teamGroupOrder" name="teamGroupOrder" value="${srchArg.teamGroupOrder}">

  <input type="hidden" id="srchBasicYN" name="basicYN" value="${srchArg.basicYN}"/>
  <input type="hidden" id="srchPrimYN" name="primYN" value="${srchArg.primYN}"/>
  <input type="hidden" id="srchContractYN" name="contractYN" value="${srchArg.contractYN}"/>
  <input type="hidden" id="srchExcelYN" name="excelYN" value="N">



<script>
	function goWorkloadMngTeam(gubun,teamGroupOrder){
		$("#gubun").val(gubun);
		$("#type").val("2");
		$("#teamGroupOrder").val(teamGroupOrder);
		
		fnSearch();
		//location.href = "/workloadStatistics?gubun="+gubun+"&type=2&teamGroupOrder="+teamGroupOrder;
	}
	function goWorkloadMngMember(gubun,teamId){
		$("#gubun").val(gubun);
		$("#type").val("3");
		$("#teamId").val(teamId);
		
		fnSearch();
		//location.href = "/workloadStatistics?gubun="+gubun+"&type=3&teamId="+teamId;
	}
</script>

<div class="tableStyle2">
    <div style="padding-right: 17px; background: #e7ecf1;">
        <table cellpadding="0" cellspacing="0" width="1060" align="center">
			<colgroup>
				<col style="width:230px;" />
				<col style="width:230px;" />
				<col style="width:230px;" />
				<col style="width:230px;" />
				<col style="width:230px;" />
				<col style="width:230px;" />
				<col style="width:230px;" />
			</colgroup>
		    <tr>
		        <th class="border-right" rowspan="2">팀명</th>
		        <th class="border-right" colspan="4">기준업무량</th>
		        <!--  <th colspan="4">공헌이익</th>  -->
		        <th class="border-left" rowspan="2" >민원발생<br/>(건)</th>
		        <th rowspan="2" >보험사기 제보, 적발<br/>(건)</th>
		    </tr>
		    <tr>
		    	<th>목표(건)</th>
		    	<th>종결(건)</th>
		    	<th>달성률</th>
		    	<th class="border-right">백분위(상위)</th>
		    	<!-- 
		    	<th>목표금액</th>
		    	<th>수수료 실적</th>
		    	<th>달성률</th>
		    	<th>백분위(상위)</th>
		    	 -->
		    </tr>
		</table>
	</div>
	<div style="height:632px; overflow-x: hidden; overflow-y: scroll;">
		<table border="1">
			<colgroup>
				<col style="width:230px;" />
				<col style="width:230px;" />
				<col style="width:230px;" />
				<col style="width:230px;" />
				<col style="width:230px;" />
				<col style="width:230px;" />
				<col style="width:230px;" />
			</colgroup>			
		    <tbody>
		    	<c:choose>
			    	<c:when test="${fn:length(workloadList) != 0}">
				    	<c:forEach var="item" items="${workloadList}" varStatus="status">
				    		<c:choose>
				    			<c:when test="${srchArg.type == 1}">
				    				<tr onclick="goWorkloadMngTeam('${srchArg.gubun}',${item.teamGroupOrder});" style="cursor:pointer;">
				    			</c:when>
				    			<c:when test="${srchArg.type == 2}">
							     	<tr onclick="goWorkloadMngMember('${srchArg.gubun}',${item.teamId});" style="cursor:pointer;">
						     	</c:when>
				    		</c:choose>
				    		<!-- 팀명 -->
		                    <c:choose>
		                    	<c:when test="${srchArg.type == 1}">
		                    		<td class="border-right">${item.centerName}</td>
		                   		</c:when>
		                    	<c:when test="${srchArg.type == 2}">
		                    		<td class="border-right">${item.teamName}</td>
		                    	</c:when>
		                    </c:choose>		    		
					     		
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
								<c:when test="${item.purpose_workload != 0.0 and item.calc_workload != 0.0}">
									<fmt:formatNumber value="${item.calc_workload / item.purpose_workload * 100}" pattern="0.0#"/> %
								</c:when>
								<c:otherwise>
									0 %
								</c:otherwise>
							</c:choose>
				     		</td>
				     		<!-- 기준업무량-백분위(상위) -->
				     		<td class="border-right"></td>
				     		<!-- 공헌이익-목표금액 -->
<!-- 				     		<td></td> -->
				     		<!-- 공헌이익-수수료 실적 -->
<!-- 				     		<td></td> -->
				     		<!-- 공헌이익-달성률 -->
<!-- 				     		<td></td> -->
				     		<!-- 공헌이익-백분위(상위) -->
<!-- 				     		<td></td> -->
				     		<!-- 민원발생(건) -->
				     		<td>${item.minwonCnt}</td>
				     		<!-- 보험사기 제보, 적발(건) -->
				     		<td>${item.moralCnt}</td>
				     	</tr>
			    	</c:forEach>
		    		</c:when>
			    	<c:otherwise>
			    		<tr>
			    			<td colspan="11">
			    				표시 될 내용이 없습니다.
			    			</td>
			    		</tr>
			    	</c:otherwise>
		    	</c:choose>
		    </tbody>
		</table>
	</div>
</div>

