<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<div style="float: left; height: 25px;">
		<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0">&nbsp;
		<b>${ptnrNickName}</b>
	</div>
	<div class="tableStyle2" style="width:1570px; overflow-x: auto; overflow-y: hidden !important;">
		<div style="width:1570px;" >
			<c:choose>
				<c:when test="${ptnrCenterList.size() < 12}">
					<c:set var="rightVal" value="0"></c:set>
				</c:when>
				<c:otherwise>
					<c:set var="rightVal" value="17"></c:set>
				</c:otherwise>
			</c:choose>
		    <div style="background: #e7ecf1;padding-right:${rightVal}px;">
		        <table>
		            <colgroup>
		                <col width="100">
		                <col width="100">
		                <col width="50">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
						<col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">		                
					</colgroup>
					<thead>
						<tr>
			                <th class="border-right">구분</th>
			                <th class="border-right" colspan="2">센터명</th>
			                <th class="border-right">합계</th>
			                <th class="border-right">미결</th>
			                <th class="border-right">연간<br/>수임</th>
			                <th class="border-right">당월<br/>종결</th>
			                <th class="border-right">연간<br/>종결</th>
			                <th>${nowVO.dayBefore29.substring(8,10)}</th>
			                <th>${nowVO.dayBefore28.substring(8,10)}</th>
			                <th>${nowVO.dayBefore27.substring(8,10)}</th>
			                <th>${nowVO.dayBefore26.substring(8,10)}</th>
			                <th>${nowVO.dayBefore25.substring(8,10)}</th>
			                <th>${nowVO.dayBefore24.substring(8,10)}</th>
			                <th>${nowVO.dayBefore23.substring(8,10)}</th>
			                <th>${nowVO.dayBefore22.substring(8,10)}</th>
			                <th>${nowVO.dayBefore21.substring(8,10)}</th>
			                <th>${nowVO.dayBefore20.substring(8,10)}</th>
			                <th>${nowVO.dayBefore19.substring(8,10)}</th>
			                <th>${nowVO.dayBefore18.substring(8,10)}</th>
			                <th>${nowVO.dayBefore17.substring(8,10)}</th>
			                <th>${nowVO.dayBefore16.substring(8,10)}</th>
			                <th>${nowVO.dayBefore15.substring(8,10)}</th>
			                <th>${nowVO.dayBefore14.substring(8,10)}</th>
			                <th>${nowVO.dayBefore13.substring(8,10)}</th>
			                <th>${nowVO.dayBefore12.substring(8,10)}</th>
			                <th>${nowVO.dayBefore11.substring(8,10)}</th>
			                <th>${nowVO.dayBefore10.substring(8,10)}</th>
			                <th>${nowVO.dayBefore9.substring(8,10)}</th>
			                <th>${nowVO.dayBefore8.substring(8,10)}</th>
			                <th>${nowVO.dayBefore7.substring(8,10)}</th>
			                <th>${nowVO.dayBefore6.substring(8,10)}</th>
			                <th>${nowVO.dayBefore5.substring(8,10)}</th>
			                <th>${nowVO.dayBefore4.substring(8,10)}</th>
			                <th>${nowVO.dayBefore3.substring(8,10)}</th>
			                <th>${nowVO.dayBefore2.substring(8,10)}</th>
			                <th>${nowVO.dayBefore1.substring(8,10)}</th>
			                <th class="border-right">${nowVO.dayBefore0.substring(8,10)}</th>
						</tr>
					</thead>
				</table>
			</div>
			
			<div style="height:600px; overflow-x: hidden; overflow-y: auto; border-top:0px;">
		        <table cellpadding="0" cellspacing="0" width="1570" align="center">
		            <colgroup>
		            	<col width="100">
		                <col width="100">
		                <col width="50">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
						<col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		                <col width="30">
		            </colgroup>
		            <tbody>
		            	<!-- 인덱스 변수 -->
		            	<c:set var="rowIdx" value="1"/>
		            	<!-- 소계값 변수 시작 -->
		            	<c:set var="sum1RegTotal" value="0"/>
			            <c:set var="sum1RegMiSum" value="0"/>			            
			            <c:set var="sum1RegYearSum" value="0"/>
			            <c:set var="sum1EndYearSum" value="0"/>
			            <c:set var="sum1EndMonthSum" value="0"/>			            
			            <c:set var="sum1Reg01" value="0"/>
			            <c:set var="sum1Reg02" value="0"/>
			            <c:set var="sum1Reg03" value="0"/>
			            <c:set var="sum1Reg04" value="0"/>
			            <c:set var="sum1Reg05" value="0"/>
			            <c:set var="sum1Reg06" value="0"/>
			            <c:set var="sum1Reg07" value="0"/>
			            <c:set var="sum1Reg08" value="0"/>
			            <c:set var="sum1Reg09" value="0"/>
			            <c:set var="sum1Reg10" value="0"/>
			            <c:set var="sum1Reg11" value="0"/>
			            <c:set var="sum1Reg12" value="0"/>
			            <c:set var="sum1Reg13" value="0"/>
			            <c:set var="sum1Reg14" value="0"/>
			            <c:set var="sum1Reg15" value="0"/>
			            <c:set var="sum1Reg16" value="0"/>
			            <c:set var="sum1Reg17" value="0"/>
			            <c:set var="sum1Reg18" value="0"/>
			            <c:set var="sum1Reg19" value="0"/>
			            <c:set var="sum1Reg20" value="0"/>
			            <c:set var="sum1Reg21" value="0"/>
			            <c:set var="sum1Reg22" value="0"/>
			            <c:set var="sum1Reg23" value="0"/>
			            <c:set var="sum1Reg24" value="0"/>
			            <c:set var="sum1Reg25" value="0"/>
			            <c:set var="sum1Reg26" value="0"/>
			            <c:set var="sum1Reg27" value="0"/>
			            <c:set var="sum1Reg28" value="0"/>
			            <c:set var="sum1Reg29" value="0"/>
			            <c:set var="sum1Reg30" value="0"/>
			            
			            <c:set var="sum1EndTotal" value="0"/>
			            <c:set var="sum1End01" value="0"/>
			            <c:set var="sum1End02" value="0"/>
			            <c:set var="sum1End03" value="0"/>
			            <c:set var="sum1End04" value="0"/>
			            <c:set var="sum1End05" value="0"/>
			            <c:set var="sum1End06" value="0"/>
			            <c:set var="sum1End07" value="0"/>
			            <c:set var="sum1End08" value="0"/>
			            <c:set var="sum1End09" value="0"/>
			            <c:set var="sum1End10" value="0"/>
			            <c:set var="sum1End11" value="0"/>
			            <c:set var="sum1End12" value="0"/>
			            <c:set var="sum1End13" value="0"/>
			            <c:set var="sum1End14" value="0"/>
			            <c:set var="sum1End15" value="0"/>
			            <c:set var="sum1End16" value="0"/>
			            <c:set var="sum1End17" value="0"/>
			            <c:set var="sum1End18" value="0"/>
			            <c:set var="sum1End19" value="0"/>
			            <c:set var="sum1End20" value="0"/>
			            <c:set var="sum1End21" value="0"/>
			            <c:set var="sum1End22" value="0"/>
			            <c:set var="sum1End23" value="0"/>
			            <c:set var="sum1End24" value="0"/>
			            <c:set var="sum1End25" value="0"/>
			            <c:set var="sum1End26" value="0"/>
			            <c:set var="sum1End27" value="0"/>
			            <c:set var="sum1End28" value="0"/>
			            <c:set var="sum1End29" value="0"/>
			            <c:set var="sum1End30" value="0"/>
			            
			            <c:set var="sumAllRegTotal" value="0"/>
			            <c:set var="sumAllReg01" value="0"/>
			            <c:set var="sumAllReg02" value="0"/>
			            <c:set var="sumAllReg03" value="0"/>
			            <c:set var="sumAllReg04" value="0"/>
			            <c:set var="sumAllReg05" value="0"/>
			            <c:set var="sumAllReg06" value="0"/>
			            <c:set var="sumAllReg07" value="0"/>
			            <c:set var="sumAllReg08" value="0"/>
			            <c:set var="sumAllReg09" value="0"/>
			            <c:set var="sumAllReg10" value="0"/>
			            <c:set var="sumAllReg11" value="0"/>
			            <c:set var="sumAllReg12" value="0"/>
			            <c:set var="sumAllReg13" value="0"/>
			            <c:set var="sumAllReg14" value="0"/>
			            <c:set var="sumAllReg15" value="0"/>
			            <c:set var="sumAllReg16" value="0"/>
			            <c:set var="sumAllReg17" value="0"/>
			            <c:set var="sumAllReg18" value="0"/>
			            <c:set var="sumAllReg19" value="0"/>
			            <c:set var="sumAllReg20" value="0"/>
			            <c:set var="sumAllReg21" value="0"/>
			            <c:set var="sumAllReg22" value="0"/>
			            <c:set var="sumAllReg23" value="0"/>
			            <c:set var="sumAllReg24" value="0"/>
			            <c:set var="sumAllReg25" value="0"/>
			            <c:set var="sumAllReg26" value="0"/>
			            <c:set var="sumAllReg27" value="0"/>
			            <c:set var="sumAllReg28" value="0"/>
			            <c:set var="sumAllReg29" value="0"/>
			            <c:set var="sumAllReg30" value="0"/>	
			            
			            <c:set var="sumAllEndTotal" value="0"/>
			            <c:set var="sumAllEnd01" value="0"/>
			            <c:set var="sumAllEnd02" value="0"/>
			            <c:set var="sumAllEnd03" value="0"/>
			            <c:set var="sumAllEnd04" value="0"/>
			            <c:set var="sumAllEnd05" value="0"/>
			            <c:set var="sumAllEnd06" value="0"/>
			            <c:set var="sumAllEnd07" value="0"/>
			            <c:set var="sumAllEnd08" value="0"/>
			            <c:set var="sumAllEnd09" value="0"/>
			            <c:set var="sumAllEnd10" value="0"/>
			            <c:set var="sumAllEnd11" value="0"/>
			            <c:set var="sumAllEnd12" value="0"/>
			            <c:set var="sumAllEnd13" value="0"/>
			            <c:set var="sumAllEnd14" value="0"/>
			            <c:set var="sumAllEnd15" value="0"/>
			            <c:set var="sumAllEnd16" value="0"/>
			            <c:set var="sumAllEnd17" value="0"/>
			            <c:set var="sumAllEnd18" value="0"/>
			            <c:set var="sumAllEnd19" value="0"/>
			            <c:set var="sumAllEnd20" value="0"/>
			            <c:set var="sumAllEnd21" value="0"/>
			            <c:set var="sumAllEnd22" value="0"/>
			            <c:set var="sumAllEnd23" value="0"/>
			            <c:set var="sumAllEnd24" value="0"/>
			            <c:set var="sumAllEnd25" value="0"/>
			            <c:set var="sumAllEnd26" value="0"/>
			            <c:set var="sumAllEnd27" value="0"/>
			            <c:set var="sumAllEnd28" value="0"/>
			            <c:set var="sumAllEnd29" value="0"/>
			            <c:set var="sumAllEnd30" value="0"/>
			            
			            <c:set var="sumAllRegMiSum" value="0"/>
			            <c:set var="sumAllRegYearSum" value="0"/>
			            <c:set var="sumAllEndMonthSum" value="0"/>
			            <c:set var="sumAllEndYearSum" value="0"/>
			            
		            	<c:forEach var="center" items="${ptnrCenterList}" varStatus="status">
		            		<c:set var="sub1_regSum" value="${center.reg30+center.reg29+center.reg28+center.reg27+center.reg26+center.reg25+center.reg24+center.reg23+center.reg22+center.reg21+center.reg20+center.reg19+center.reg18+center.reg17+center.reg16+center.reg15+center.reg14+center.reg13+center.reg12+center.reg11+center.reg10+center.reg09+center.reg08+center.reg07+center.reg06+center.reg05+center.reg04+center.reg03+center.reg02+center.reg01}"/>
		            		<c:set var="sub1_endSum" value="${center.end30+center.end29+center.end28+center.end27+center.end26+center.end25+center.end24+center.end23+center.end22+center.end21+center.end20+center.end19+center.end18+center.end17+center.end16+center.end15+center.end14+center.end13+center.end12+center.end11+center.end10+center.end09+center.end08+center.end07+center.end06+center.end05+center.end04+center.end03+center.end02+center.end01}"/>
		            		
		            		<c:set var="sum1RegTotal" value="${sum1RegTotal+sub1_regSum}"></c:set>
			            	<c:set var="sum1RegMiSum" value="${sum1RegMiSum+center.regMiSum}"></c:set>
			            	<c:set var="sum1RegYearSum" value="${sum1RegYearSum+center.regYearSum}"></c:set>
			            	<c:set var="sum1EndYearSum" value="${sum1EndYearSum+center.endYearSum}"></c:set>
			            	<c:set var="sum1EndMonthSum" value="${sum1EndMonthSum+center.endMonthSum}"></c:set>			            			            		
		            		
		            		<c:set var="sum1Reg01" value="${sum1Reg01+center.reg01}"></c:set>
			            	<c:set var="sum1Reg02" value="${sum1Reg02+center.reg02}"></c:set>
			            	<c:set var="sum1Reg03" value="${sum1Reg03+center.reg03}"></c:set>
			            	<c:set var="sum1Reg04" value="${sum1Reg04+center.reg04}"></c:set>
			            	<c:set var="sum1Reg05" value="${sum1Reg05+center.reg05}"></c:set>
			            	<c:set var="sum1Reg06" value="${sum1Reg06+center.reg06}"></c:set>
			            	<c:set var="sum1Reg07" value="${sum1Reg07+center.reg07}"></c:set>
			            	<c:set var="sum1Reg08" value="${sum1Reg08+center.reg08}"></c:set>
			            	<c:set var="sum1Reg09" value="${sum1Reg09+center.reg09}"></c:set>
			            	<c:set var="sum1Reg10" value="${sum1Reg10+center.reg10}"></c:set>		            	
			            	<c:set var="sum1Reg11" value="${sum1Reg11+center.reg11}"></c:set>
			            	<c:set var="sum1Reg12" value="${sum1Reg12+center.reg12}"></c:set>
			            	<c:set var="sum1Reg13" value="${sum1Reg13+center.reg13}"></c:set>
			            	<c:set var="sum1Reg14" value="${sum1Reg14+center.reg14}"></c:set>
			            	<c:set var="sum1Reg15" value="${sum1Reg15+center.reg15}"></c:set>
			            	<c:set var="sum1Reg16" value="${sum1Reg16+center.reg16}"></c:set>
			            	<c:set var="sum1Reg17" value="${sum1Reg17+center.reg17}"></c:set>
			            	<c:set var="sum1Reg18" value="${sum1Reg18+center.reg18}"></c:set>
			            	<c:set var="sum1Reg19" value="${sum1Reg19+center.reg19}"></c:set>
			            	<c:set var="sum1Reg20" value="${sum1Reg20+center.reg20}"></c:set>		            	
			            	<c:set var="sum1Reg21" value="${sum1Reg21+center.reg11}"></c:set>
			            	<c:set var="sum1Reg22" value="${sum1Reg22+center.reg22}"></c:set>
			            	<c:set var="sum1Reg23" value="${sum1Reg23+center.reg23}"></c:set>
			            	<c:set var="sum1Reg24" value="${sum1Reg24+center.reg24}"></c:set>
			            	<c:set var="sum1Reg25" value="${sum1Reg25+center.reg25}"></c:set>
			            	<c:set var="sum1Reg26" value="${sum1Reg26+center.reg26}"></c:set>
			            	<c:set var="sum1Reg27" value="${sum1Reg27+center.reg27}"></c:set>
			            	<c:set var="sum1Reg28" value="${sum1Reg28+center.reg28}"></c:set>
			            	<c:set var="sum1Reg29" value="${sum1Reg29+center.reg29}"></c:set>
			            	<c:set var="sum1Reg30" value="${sum1Reg30+center.reg30}"></c:set>
			            	
			            	<c:set var="sum1EndTotal" value="${sum1EndTotal+sub1_endSum}"></c:set>
			            	<c:set var="sum1End01" value="${sum1End01+center.end01}"></c:set>
			            	<c:set var="sum1End02" value="${sum1End02+center.end02}"></c:set>
			            	<c:set var="sum1End03" value="${sum1End03+center.end03}"></c:set>
			            	<c:set var="sum1End04" value="${sum1End04+center.end04}"></c:set>
			            	<c:set var="sum1End05" value="${sum1End05+center.end05}"></c:set>
			            	<c:set var="sum1End06" value="${sum1End06+center.end06}"></c:set>
			            	<c:set var="sum1End07" value="${sum1End07+center.end07}"></c:set>
			            	<c:set var="sum1End08" value="${sum1End08+center.end08}"></c:set>
			            	<c:set var="sum1End09" value="${sum1End09+center.end09}"></c:set>
			            	<c:set var="sum1End10" value="${sum1End10+center.end10}"></c:set>		            	
			            	<c:set var="sum1End11" value="${sum1End11+center.end11}"></c:set>
			            	<c:set var="sum1End12" value="${sum1End12+center.end12}"></c:set>
			            	<c:set var="sum1End13" value="${sum1End13+center.end13}"></c:set>
			            	<c:set var="sum1End14" value="${sum1End14+center.end14}"></c:set>
			            	<c:set var="sum1End15" value="${sum1End15+center.end15}"></c:set>
			            	<c:set var="sum1End16" value="${sum1End16+center.end16}"></c:set>
			            	<c:set var="sum1End17" value="${sum1End17+center.end17}"></c:set>
			            	<c:set var="sum1End18" value="${sum1End18+center.end18}"></c:set>
			            	<c:set var="sum1End19" value="${sum1End19+center.end19}"></c:set>
			            	<c:set var="sum1End20" value="${sum1End20+center.end20}"></c:set>		            	
			            	<c:set var="sum1End21" value="${sum1End21+center.end11}"></c:set>
			            	<c:set var="sum1End22" value="${sum1End22+center.end22}"></c:set>
			            	<c:set var="sum1End23" value="${sum1End23+center.end23}"></c:set>
			            	<c:set var="sum1End24" value="${sum1End24+center.end24}"></c:set>
			            	<c:set var="sum1End25" value="${sum1End25+center.end25}"></c:set>
			            	<c:set var="sum1End26" value="${sum1End26+center.end26}"></c:set>
			            	<c:set var="sum1End27" value="${sum1End27+center.end27}"></c:set>
			            	<c:set var="sum1End28" value="${sum1End28+center.end28}"></c:set>
			            	<c:set var="sum1End29" value="${sum1End29+center.end29}"></c:set>
			            	<c:set var="sum1End30" value="${sum1End30+center.end30}"></c:set>
			            	
			            	<c:set var="sumAllRegTotal" value="${sumAllRegTotal+sub1_regSum}"></c:set>
			            	<c:set var="sumAllReg01" value="${sumAllReg01+center.reg01}"></c:set>
			            	<c:set var="sumAllReg02" value="${sumAllReg02+center.reg02}"></c:set>
			            	<c:set var="sumAllReg03" value="${sumAllReg03+center.reg03}"></c:set>
			            	<c:set var="sumAllReg04" value="${sumAllReg04+center.reg04}"></c:set>
			            	<c:set var="sumAllReg05" value="${sumAllReg05+center.reg05}"></c:set>
			            	<c:set var="sumAllReg06" value="${sumAllReg06+center.reg06}"></c:set>
			            	<c:set var="sumAllReg07" value="${sumAllReg07+center.reg07}"></c:set>
			            	<c:set var="sumAllReg08" value="${sumAllReg08+center.reg08}"></c:set>
			            	<c:set var="sumAllReg09" value="${sumAllReg09+center.reg09}"></c:set>
			            	<c:set var="sumAllReg10" value="${sumAllReg10+center.reg10}"></c:set>		            	
			            	<c:set var="sumAllReg11" value="${sumAllReg11+center.reg11}"></c:set>
			            	<c:set var="sumAllReg12" value="${sumAllReg12+center.reg12}"></c:set>
			            	<c:set var="sumAllReg13" value="${sumAllReg13+center.reg13}"></c:set>
			            	<c:set var="sumAllReg14" value="${sumAllReg14+center.reg14}"></c:set>
			            	<c:set var="sumAllReg15" value="${sumAllReg15+center.reg15}"></c:set>
			            	<c:set var="sumAllReg16" value="${sumAllReg16+center.reg16}"></c:set>
			            	<c:set var="sumAllReg17" value="${sumAllReg17+center.reg17}"></c:set>
			            	<c:set var="sumAllReg18" value="${sumAllReg18+center.reg18}"></c:set>
			            	<c:set var="sumAllReg19" value="${sumAllReg19+center.reg19}"></c:set>
			            	<c:set var="sumAllReg20" value="${sumAllReg20+center.reg20}"></c:set>		            	
			            	<c:set var="sumAllReg21" value="${sumAllReg21+center.reg11}"></c:set>
			            	<c:set var="sumAllReg22" value="${sumAllReg22+center.reg22}"></c:set>
			            	<c:set var="sumAllReg23" value="${sumAllReg23+center.reg23}"></c:set>
			            	<c:set var="sumAllReg24" value="${sumAllReg24+center.reg24}"></c:set>
			            	<c:set var="sumAllReg25" value="${sumAllReg25+center.reg25}"></c:set>
			            	<c:set var="sumAllReg26" value="${sumAllReg26+center.reg26}"></c:set>
			            	<c:set var="sumAllReg27" value="${sumAllReg27+center.reg27}"></c:set>
			            	<c:set var="sumAllReg28" value="${sumAllReg28+center.reg28}"></c:set>
			            	<c:set var="sumAllReg29" value="${sumAllReg29+center.reg29}"></c:set>
			            	<c:set var="sumAllReg30" value="${sumAllReg30+center.reg30}"></c:set>
			            	
			            	<c:set var="sumAllEndTotal" value="${sumAllEndTotal+sub1_endSum}"></c:set>
			            	<c:set var="sumAllEnd01" value="${sumAllEnd01+center.end01}"></c:set>
			            	<c:set var="sumAllEnd02" value="${sumAllEnd02+center.end02}"></c:set>
			            	<c:set var="sumAllEnd03" value="${sumAllEnd03+center.end03}"></c:set>
			            	<c:set var="sumAllEnd04" value="${sumAllEnd04+center.end04}"></c:set>
			            	<c:set var="sumAllEnd05" value="${sumAllEnd05+center.end05}"></c:set>
			            	<c:set var="sumAllEnd06" value="${sumAllEnd06+center.end06}"></c:set>
			            	<c:set var="sumAllEnd07" value="${sumAllEnd07+center.end07}"></c:set>
			            	<c:set var="sumAllEnd08" value="${sumAllEnd08+center.end08}"></c:set>
			            	<c:set var="sumAllEnd09" value="${sumAllEnd09+center.end09}"></c:set>
			            	<c:set var="sumAllEnd10" value="${sumAllEnd10+center.end10}"></c:set>		            	
			            	<c:set var="sumAllEnd11" value="${sumAllEnd11+center.end11}"></c:set>
			            	<c:set var="sumAllEnd12" value="${sumAllEnd12+center.end12}"></c:set>
			            	<c:set var="sumAllEnd13" value="${sumAllEnd13+center.end13}"></c:set>
			            	<c:set var="sumAllEnd14" value="${sumAllEnd14+center.end14}"></c:set>
			            	<c:set var="sumAllEnd15" value="${sumAllEnd15+center.end15}"></c:set>
			            	<c:set var="sumAllEnd16" value="${sumAllEnd16+center.end16}"></c:set>
			            	<c:set var="sumAllEnd17" value="${sumAllEnd17+center.end17}"></c:set>
			            	<c:set var="sumAllEnd18" value="${sumAllEnd18+center.end18}"></c:set>
			            	<c:set var="sumAllEnd19" value="${sumAllEnd19+center.end19}"></c:set>
			            	<c:set var="sumAllEnd20" value="${sumAllEnd20+center.end20}"></c:set>		            	
			            	<c:set var="sumAllEnd21" value="${sumAllEnd21+center.end11}"></c:set>
			            	<c:set var="sumAllEnd22" value="${sumAllEnd22+center.end22}"></c:set>
			            	<c:set var="sumAllEnd23" value="${sumAllEnd23+center.end23}"></c:set>
			            	<c:set var="sumAllEnd24" value="${sumAllEnd24+center.end24}"></c:set>
			            	<c:set var="sumAllEnd25" value="${sumAllEnd25+center.end25}"></c:set>
			            	<c:set var="sumAllEnd26" value="${sumAllEnd26+center.end26}"></c:set>
			            	<c:set var="sumAllEnd27" value="${sumAllEnd27+center.end27}"></c:set>
			            	<c:set var="sumAllEnd28" value="${sumAllEnd28+center.end28}"></c:set>
			            	<c:set var="sumAllEnd29" value="${sumAllEnd29+center.end29}"></c:set>
			            	<c:set var="sumAllEnd30" value="${sumAllEnd30+center.end30}"></c:set>
			            	
			            	<c:set var="sumAllRegMiSum" value="${sumAllRegMiSum+center.regMiSum}"></c:set>
			            	<c:set var="sumAllRegYearSum" value="${sumAllRegYearSum+center.regYearSum}"></c:set>
			            	<c:set var="sumAllEndMonthSum" value="${sumAllEndMonthSum+center.endMonthSum}"></c:set>
			            	<c:set var="sumAllEndYearSum" value="${sumAllEndYearSum+center.endYearSum}"></c:set>
		            		<tr>
		            			<c:choose>
		            				<c:when test="${center.rowCnt == 1}">
		            					<td class="border-right">${center.ptnrIdSubName}</td>
		            					<c:set var="rowIdx" value="1"/>				
		            				</c:when>
		            				<c:otherwise>
		            					<c:if test="${rowIdx == 1}">
		            						<td class="border-right" rowspan="${center.rowCnt+1}">${center.ptnrIdSubName}</td>	
		            					</c:if>		            							            					
		            				</c:otherwise>
		            			</c:choose>		            			
		            			<td class="border-right">${center.centerName}</td>
		            			<td class="border-right">
		            				<p>수임</p>
		            				<p class="sub-p">종결</p>
		            			</td>
		            			<td class="border-right" bgcolor="#faebd7">		            			
			            			<p>${sub1_regSum}</p><p class="sub-p">${sub1_endSum}</p>
			            		</td>
		            			<!-- 미결 -->
			            		<td class="border-right" bgcolor="#faebd7">
			            			<p>${center.regMiSum}</p>
			            		</td>
			            		<!-- 연간수임 -->
			            		<td class="border-right" bgcolor="#faebd7">
			            			<p>${center.regYearSum}</p>
			            		</td>
			            		<!-- 당월종결 -->
			            		<td class="border-right" bgcolor="#faebd7">
			            			<p>${center.endMonthSum}</p>
			            		</td>		            		
			            		<!-- 연간종결 -->
			            		<td class="border-right" bgcolor="#faebd7">
			            			<p>${center.endYearSum}</p>
			            		</td>		            			
		            			<td class="border-right">
		            				<p>${center.reg01}</p><p class="sub-p">${center.end01}</p>		            				
			            		</td>
			            		<td class="border-right">
			            			<p>${center.reg02}</p><p class="sub-p">${center.end02}</p>
			            		</td>
			            		<td class="border-right">
			            			<p>${center.reg03}</p><p class="sub-p">${center.end03}</p>
			            		</td>
			            		<td class="border-right">
			            			<p>${center.reg04}</p><p class="sub-p">${center.end04}</p>
			            		</td>
			            		<td class="border-right">
			            			<p>${center.reg05}</p><p class="sub-p">${center.end05}</p>
			            		</td>
			            		<td class="border-right">
			            			<p>${center.reg06}</p><p class="sub-p">${center.end06}</p>
			            		</td>
			            		<td class="border-right">
			            			<p>${center.reg07}</p><p class="sub-p">${center.end07}</p>
			            		</td>
			            		<td class="border-right">
			            			<p>${center.reg08}</p><p class="sub-p">${center.end08}</p>
			            		</td>
			            		<td class="border-right">
			            			<p>${center.reg09}</p><p class="sub-p">${center.end09}</p>
			            		</td>
			            		<td class="border-right">
			            			<p>${center.reg10}</p><p class="sub-p">${center.end10}</p>
			            		</td>
			            		<td class="border-right">
			            			<p>${center.reg11}</p><p class="sub-p">${center.end11}</p>
			            		</td>
			            		<td class="border-right">
			            			<p>${center.reg12}</p><p class="sub-p">${center.end12}</p>
			            		</td>
			            		<td class="border-right">
			            			<p>${center.reg13}</p><p class="sub-p">${center.end13}</p>
			            		</td>
			            		<td class="border-right">
			            			<p>${center.reg14}</p><p class="sub-p">${center.end14}</p>
			            		</td>
			            		<td class="border-right">
			            			<p>${center.reg15}</p><p class="sub-p">${center.end15}</p>
			            		</td>
			            		<td class="border-right">
			            			<p>${center.reg16}</p><p class="sub-p">${center.end16}</p>
			            		</td>
			            		<td class="border-right">
			            			<p>${center.reg17}</p><p class="sub-p">${center.end17}</p>
			            		</td>
			            		<td class="border-right">
			            			<p>${center.reg18}</p><p class="sub-p">${center.end18}</p>
			            		</td>
			            		<td class="border-right">
			            			<p>${center.reg19}</p><p class="sub-p">${center.end19}</p>
			            		</td>
			            		<td class="border-right">
			            			<p>${center.reg20}</p><p class="sub-p">${center.end20}</p>
			            		</td>
			            		<td class="border-right">
			            			<p>${center.reg21}</p><p class="sub-p">${center.end21}</p>
			            		</td>
			            		<td class="border-right">
			            			<p>${center.reg22}</p><p class="sub-p">${center.end22}</p>
			            		</td>
			            		<td class="border-right">
			            			<p>${center.reg23}</p><p class="sub-p">${center.end23}</p>
			            		</td>
			            		<td class="border-right">
			            			<p>${center.reg24}</p><p class="sub-p">${center.end24}</p>
			            		</td>
			            		<td class="border-right">
			            			<p>${center.reg25}</p><p class="sub-p">${center.end25}</p>
			            		</td>
			            		<td class="border-right">
			            			<p>${center.reg26}</p><p class="sub-p">${center.end26}</p>
			            		</td>
			            		<td class="border-right">
			            			<p>${center.reg27}</p><p class="sub-p">${center.end27}</p>
			            		</td>		            		
			            		<td class="border-right">
			            			<p>${center.reg28}</p><p class="sub-p">${center.end28}</p>
			            		</td>
			            		<td class="border-right">
			            			<p>${center.reg29}</p><p class="sub-p">${center.end29}</p>
			            		</td>
			            		<td class="border-right">
			            			<p>${center.reg30}</p><p class="sub-p">${center.end30}</p>
			            		</td>
		            		</tr>
		            		<c:choose>
		            			<c:when test="${center.rowCnt == rowIdx}">
		            				<c:set var="rowIdx" value="1"/>
		            				<c:if test="${center.rowCnt > 1}">
		            					<tr>
				            				<th style="border-right: 1px solid #b9b9b9 !important;" colspan="2">소계</th>
				            				<th style="border-right: 1px solid #b9b9b9 !important;">
				            					<p>${sum1RegTotal}</p><p class="sub-p">${sum1EndTotal}</p>			            					
				            				</th>
				            				<th style="border-right: 1px solid #b9b9b9 !important;">
				            					<p>${sum1RegMiSum}</p>			            					
				            				</th>
				            				<th style="border-right: 1px solid #b9b9b9 !important;">
				            					<p>${sum1RegYearSum}</p>			            					
				            				</th>
				            				<th style="border-right: 1px solid #b9b9b9 !important;">
				            					<p>${sum1EndMonthSum}</p>			            					
				            				</th>
				            				<th style="border-right: 1px solid #b9b9b9 !important;">
				            					<p>${sum1EndYearSum}</p>			            					
				            				</th>
				            				<th><p>${sum1Reg01}</p><p class="sub-p">${sum1End01}</p></th>
				            				<th><p>${sum1Reg02}</p><p class="sub-p">${sum1End02}</p></th>
				            				<th><p>${sum1Reg03}</p><p class="sub-p">${sum1End03}</p></th>
				            				<th><p>${sum1Reg04}</p><p class="sub-p">${sum1End04}</p></th>
				            				<th><p>${sum1Reg05}</p><p class="sub-p">${sum1End05}</p></th>
				            				<th><p>${sum1Reg06}</p><p class="sub-p">${sum1End06}</p></th>
				            				<th><p>${sum1Reg07}</p><p class="sub-p">${sum1End07}</p></th>
				            				<th><p>${sum1Reg08}</p><p class="sub-p">${sum1End08}</p></th>
				            				<th><p>${sum1Reg09}</p><p class="sub-p">${sum1End09}</p></th>
				            				<th><p>${sum1Reg10}</p><p class="sub-p">${sum1End10}</p></th>
				            				<th><p>${sum1Reg11}</p><p class="sub-p">${sum1End11}</p></th>
				            				<th><p>${sum1Reg12}</p><p class="sub-p">${sum1End12}</p></th>
				            				<th><p>${sum1Reg13}</p><p class="sub-p">${sum1End13}</p></th>
				            				<th><p>${sum1Reg14}</p><p class="sub-p">${sum1End14}</p></th>
				            				<th><p>${sum1Reg15}</p><p class="sub-p">${sum1End15}</p></th>
				            				<th><p>${sum1Reg16}</p><p class="sub-p">${sum1End16}</p></th>
				            				<th><p>${sum1Reg17}</p><p class="sub-p">${sum1End17}</p></th>
				            				<th><p>${sum1Reg18}</p><p class="sub-p">${sum1End18}</p></th>
				            				<th><p>${sum1Reg19}</p><p class="sub-p">${sum1End19}</p></th>
				            				<th><p>${sum1Reg20}</p><p class="sub-p">${sum1End20}</p></th>			            				
				            				<th><p>${sum1Reg21}</p><p class="sub-p">${sum1End21}</p></th>
				            				<th><p>${sum1Reg22}</p><p class="sub-p">${sum1End22}</p></th>
				            				<th><p>${sum1Reg23}</p><p class="sub-p">${sum1End23}</p></th>
				            				<th><p>${sum1Reg24}</p><p class="sub-p">${sum1End24}</p></th>
				            				<th><p>${sum1Reg25}</p><p class="sub-p">${sum1End25}</p></th>
				            				<th><p>${sum1Reg26}</p><p class="sub-p">${sum1End26}</p></th>
				            				<th><p>${sum1Reg27}</p><p class="sub-p">${sum1End27}</p></th>
				            				<th><p>${sum1Reg28}</p><p class="sub-p">${sum1End28}</p></th>
				            				<th><p>${sum1Reg29}</p><p class="sub-p">${sum1End29}</p></th>
				            				<th style="border-right: 1px solid #b9b9b9"><p>${sum1Reg30}</p><p class="sub-p">${sum1End30}</p></th>			            				
				            			</tr>
		            				</c:if>
		            				<!-- 소계 계산후 초기화 -->		            			
			            			<c:set var="rowIdx" value="1"/>
			            			<c:set var="sum1RegTotal" value="0" />		            			
			            			<c:set var="sum1RegMiSum" value="0" />
			            			<c:set var="sum1RegYearSum" value="0" />
			            			<c:set var="sum1EndYearSum" value="0" />
			            			<c:set var="sum1EndMonthSum" value="0" />			            			
			            			<c:set var="sum1Reg01" value="0" />
			            			<c:set var="sum1Reg02" value="0" />
			            			<c:set var="sum1Reg03" value="0" />
			            			<c:set var="sum1Reg04" value="0" />
			            			<c:set var="sum1Reg05" value="0" />
			            			<c:set var="sum1Reg06" value="0" />
			            			<c:set var="sum1Reg07" value="0" />
			            			<c:set var="sum1Reg08" value="0" />
			            			<c:set var="sum1Reg09" value="0" />
			            			<c:set var="sum1Reg10" value="0" />
			            			<c:set var="sum1Reg11" value="0" />
			            			<c:set var="sum1Reg12" value="0" />
			            			<c:set var="sum1Reg13" value="0" />
			            			<c:set var="sum1Reg14" value="0" />
			            			<c:set var="sum1Reg15" value="0" />
			            			<c:set var="sum1Reg16" value="0" />
			            			<c:set var="sum1Reg17" value="0" />
			            			<c:set var="sum1Reg18" value="0" />
			            			<c:set var="sum1Reg19" value="0" />
			            			<c:set var="sum1Reg20" value="0" />
			            			<c:set var="sum1Reg21" value="0" />
			            			<c:set var="sum1Reg22" value="0" />
			            			<c:set var="sum1Reg23" value="0" />
			            			<c:set var="sum1Reg24" value="0" />
			            			<c:set var="sum1Reg25" value="0" />
			            			<c:set var="sum1Reg26" value="0" />
			            			<c:set var="sum1Reg27" value="0" />
			            			<c:set var="sum1Reg28" value="0" />
			            			<c:set var="sum1Reg29" value="0" />
			            			<c:set var="sum1Reg30" value="0" />
			            			
			            			<c:set var="sum1EndTotal" value="0" />
			            			<c:set var="sum1End01" value="0" />
			            			<c:set var="sum1End02" value="0" />
			            			<c:set var="sum1End03" value="0" />
			            			<c:set var="sum1End04" value="0" />
			            			<c:set var="sum1End05" value="0" />
			            			<c:set var="sum1End06" value="0" />
			            			<c:set var="sum1End07" value="0" />
			            			<c:set var="sum1End08" value="0" />
			            			<c:set var="sum1End09" value="0" />
			            			<c:set var="sum1End10" value="0" />
			            			<c:set var="sum1End11" value="0" />
			            			<c:set var="sum1End12" value="0" />
			            			<c:set var="sum1End13" value="0" />
			            			<c:set var="sum1End14" value="0" />
			            			<c:set var="sum1End15" value="0" />
			            			<c:set var="sum1End16" value="0" />
			            			<c:set var="sum1End17" value="0" />
			            			<c:set var="sum1End18" value="0" />
			            			<c:set var="sum1End19" value="0" />
			            			<c:set var="sum1End20" value="0" />
			            			<c:set var="sum1End21" value="0" />
			            			<c:set var="sum1End22" value="0" />
			            			<c:set var="sum1End23" value="0" />
			            			<c:set var="sum1End24" value="0" />
			            			<c:set var="sum1End25" value="0" />
			            			<c:set var="sum1End26" value="0" />
			            			<c:set var="sum1End27" value="0" />
			            			<c:set var="sum1End28" value="0" />
			            			<c:set var="sum1End29" value="0" />
			            			<c:set var="sum1End30" value="0" />
		            			</c:when>
		            			<c:otherwise>
		            				<c:set var="rowIdx" value="${rowIdx+1}"/>
		            			</c:otherwise>
		            		</c:choose>
		            	</c:forEach>
		            	<!-- 전체 합계 시작 -->
			            <tr>
			            	<th colspan="3" class="border-right">합계</th>
			            	<th class="border-right" bgcolor="#faebd7">
		            			<p>${sumAllRegTotal}</p><p class="sub-p">${sumAllEndTotal}</p>
			            	</th>
			            	<!-- 미결 -->
			            	<th class="border-right" bgcolor="#faebd7">
		            			<p>${sumAllRegMiSum}</p>
			            	</th>
			            	<!-- 연간수임 -->
			            	<th class="border-right" bgcolor="#faebd7">
		            			<p>${sumAllRegYearSum}</p>
			            	</th>
			            	<!-- 당월종결 -->
			            	<th class="border-right" bgcolor="#faebd7">
		            			<p>${sumAllEndMonthSum}</p>
			            	</th>
			            	<!-- 연간종결 -->
			            	<th class="border-right" bgcolor="#faebd7">
		            			<p>${sumAllEndYearSum}</p>
			            	</th>
			            	<th><p>${sumAllReg01}</p><p class="sub-p">${sumAllEnd01}</p></th>
	           				<th><p>${sumAllReg02}</p><p class="sub-p">${sumAllEnd02}</p></th>
	           				<th><p>${sumAllReg03}</p><p class="sub-p">${sumAllEnd03}</p></th>
	           				<th><p>${sumAllReg04}</p><p class="sub-p">${sumAllEnd04}</p></th>
	           				<th><p>${sumAllReg05}</p><p class="sub-p">${sumAllEnd05}</p></th>
	           				<th><p>${sumAllReg06}</p><p class="sub-p">${sumAllEnd06}</p></th>
	           				<th><p>${sumAllReg07}</p><p class="sub-p">${sumAllEnd07}</p></th>
	           				<th><p>${sumAllReg08}</p><p class="sub-p">${sumAllEnd08}</p></th>
	           				<th><p>${sumAllReg09}</p><p class="sub-p">${sumAllEnd09}</p></th>
	           				<th><p>${sumAllReg10}</p><p class="sub-p">${sumAllEnd10}</p></th>
	           				<th><p>${sumAllReg11}</p><p class="sub-p">${sumAllEnd11}</p></th>
	           				<th><p>${sumAllReg12}</p><p class="sub-p">${sumAllEnd12}</p></th>
	           				<th><p>${sumAllReg13}</p><p class="sub-p">${sumAllEnd13}</p></th>
	           				<th><p>${sumAllReg14}</p><p class="sub-p">${sumAllEnd14}</p></th>
	           				<th><p>${sumAllReg15}</p><p class="sub-p">${sumAllEnd15}</p></th>
	           				<th><p>${sumAllReg16}</p><p class="sub-p">${sumAllEnd16}</p></th>
	           				<th><p>${sumAllReg17}</p><p class="sub-p">${sumAllEnd17}</p></th>
	           				<th><p>${sumAllReg18}</p><p class="sub-p">${sumAllEnd18}</p></th>
	           				<th><p>${sumAllReg19}</p><p class="sub-p">${sumAllEnd19}</p></th>
	           				<th><p>${sumAllReg20}</p><p class="sub-p">${sumAllEnd20}</p></th>
	           				<th><p>${sumAllReg21}</p><p class="sub-p">${sumAllEnd21}</p></th>
	           				<th><p>${sumAllReg22}</p><p class="sub-p">${sumAllEnd22}</p></th>
	           				<th><p>${sumAllReg23}</p><p class="sub-p">${sumAllEnd23}</p></th>
	           				<th><p>${sumAllReg24}</p><p class="sub-p">${sumAllEnd24}</p></th>
	           				<th><p>${sumAllReg25}</p><p class="sub-p">${sumAllEnd25}</p></th>
	           				<th><p>${sumAllReg26}</p><p class="sub-p">${sumAllEnd26}</p></th>
	           				<th><p>${sumAllReg27}</p><p class="sub-p">${sumAllEnd27}</p></th>
	           				<th><p>${sumAllReg28}</p><p class="sub-p">${sumAllEnd28}</p></th>
	           				<th><p>${sumAllReg29}</p><p class="sub-p">${sumAllEnd29}</p></th>
	           				<th style="border-right: 1px solid #b9b9b9"><p>${sumAllReg30}</p><p class="sub-p">${sumAllEnd30}</p></th>
			            </tr>		            	
					</tbody>
				</table>
			</div>
			
		</div>
	</div>
