<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="tableStyle2">
	<div style="width:100%; overflow-x: auto; overflow-y: hidden !important;">
		<div style="width:1882px;" >
		    <div style="padding-right: 17px;background: #e7ecf1;">
		        <table cellpadding="0" cellspacing="0" width="1060" align="center">
		            <colgroup>
		                <col width="135">		                
		                <col width="130">
		                <col width="44">
		                <col width="49">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">		                
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		            </colgroup>
		            <thead>
		            <tr>
		                <th class="border-right">보험사</th>
		                <th class="border-right" colspan="2">구분</th>
		                <!-- <th class="border-right">-</th> -->
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
		                <th>${nowVO.dayBefore0.substring(8,10)}</th>		                		                
		            </tr>
		            </thead>
		        </table>
		    </div>
		    <div style="height:632px; overflow-x: hidden; overflow-y: auto;">
		        <table cellpadding="0" cellspacing="0" width="1060" align="center">
		            <colgroup>
		                <col width="135">		                
		                <col width="130">
		                <col width="44">
		                <col width="49">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		            	<c:if test="${ptnrIdSubList.size() < 13}">    
		                	<col width="14">
		            	</c:if>    
		            </colgroup>		            
		            <tbody>
		            <!-- 인덱스 변수 시작 -->
		            <c:set var="rowIdx" value="1"/>
		            <!-- 소계값 변수 시작 -->
		            <c:set var="sum1RegTotal" value="0"/>
		            <c:set var="sum1RegMiSum" value="0"/>
		            <c:set var="sum1RegYearSum" value="0"/>
		            <c:set var="sum1EndMonthSum" value="0"/>
		            <c:set var="sum1EndYearSum" value="0"/>
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
		            	            		            
		            <c:forEach var="ptnrSub" items="${ptnrIdSubList}" varStatus="status">
		            	<!-- 가로축 합계 -->
		            	<c:set var="sub1_regSum" value="${ptnrSub.reg30+ptnrSub.reg29+ptnrSub.reg28+ptnrSub.reg27+ptnrSub.reg26+ptnrSub.reg25+ptnrSub.reg24+ptnrSub.reg23+ptnrSub.reg22+ptnrSub.reg21+ptnrSub.reg20+ptnrSub.reg19+ptnrSub.reg18+ptnrSub.reg17+ptnrSub.reg16+ptnrSub.reg15+ptnrSub.reg14+ptnrSub.reg13+ptnrSub.reg12+ptnrSub.reg11+ptnrSub.reg10+ptnrSub.reg09+ptnrSub.reg08+ptnrSub.reg07+ptnrSub.reg06+ptnrSub.reg05+ptnrSub.reg04+ptnrSub.reg03+ptnrSub.reg02+ptnrSub.reg01}"/>
		            	<c:set var="sub1_endSum" value="${ptnrSub.end30+ptnrSub.end29+ptnrSub.end28+ptnrSub.end27+ptnrSub.end26+ptnrSub.end25+ptnrSub.end24+ptnrSub.end23+ptnrSub.end22+ptnrSub.end21+ptnrSub.end20+ptnrSub.end19+ptnrSub.end18+ptnrSub.end17+ptnrSub.end16+ptnrSub.end15+ptnrSub.end14+ptnrSub.end13+ptnrSub.end12+ptnrSub.end11+ptnrSub.end10+ptnrSub.end09+ptnrSub.end08+ptnrSub.end07+ptnrSub.end06+ptnrSub.end05+ptnrSub.end04+ptnrSub.end03+ptnrSub.end02+ptnrSub.end01}"/>
		            	
		            	<c:set var="sum1RegTotal" value="${sum1RegTotal+sub1_regSum}"></c:set>
		            	<c:set var="sum1RegMiSum" value="${sum1RegMiSum+ptnrSub.regMiSum}"></c:set>
		            	<c:set var="sum1RegYearSum" value="${sum1RegYearSum+ptnrSub.regYearSum}"></c:set>
		            	<c:set var="sum1EndMonthSum" value="${sum1EndMonthSum+ptnrSub.endMonthSum}"></c:set>
		            	<c:set var="sum1EndYearSum" value="${sum1EndYearSum+ptnrSub.endYearSum}"></c:set>
		            	<c:set var="sum1Reg01" value="${sum1Reg01+ptnrSub.reg01}"></c:set>
		            	<c:set var="sum1Reg02" value="${sum1Reg02+ptnrSub.reg02}"></c:set>
		            	<c:set var="sum1Reg03" value="${sum1Reg03+ptnrSub.reg03}"></c:set>
		            	<c:set var="sum1Reg04" value="${sum1Reg04+ptnrSub.reg04}"></c:set>
		            	<c:set var="sum1Reg05" value="${sum1Reg05+ptnrSub.reg05}"></c:set>
		            	<c:set var="sum1Reg06" value="${sum1Reg06+ptnrSub.reg06}"></c:set>
		            	<c:set var="sum1Reg07" value="${sum1Reg07+ptnrSub.reg07}"></c:set>
		            	<c:set var="sum1Reg08" value="${sum1Reg08+ptnrSub.reg08}"></c:set>
		            	<c:set var="sum1Reg09" value="${sum1Reg09+ptnrSub.reg09}"></c:set>
		            	<c:set var="sum1Reg10" value="${sum1Reg10+ptnrSub.reg10}"></c:set>		            	
		            	<c:set var="sum1Reg11" value="${sum1Reg11+ptnrSub.reg11}"></c:set>
		            	<c:set var="sum1Reg12" value="${sum1Reg12+ptnrSub.reg12}"></c:set>
		            	<c:set var="sum1Reg13" value="${sum1Reg13+ptnrSub.reg13}"></c:set>
		            	<c:set var="sum1Reg14" value="${sum1Reg14+ptnrSub.reg14}"></c:set>
		            	<c:set var="sum1Reg15" value="${sum1Reg15+ptnrSub.reg15}"></c:set>
		            	<c:set var="sum1Reg16" value="${sum1Reg16+ptnrSub.reg16}"></c:set>
		            	<c:set var="sum1Reg17" value="${sum1Reg17+ptnrSub.reg17}"></c:set>
		            	<c:set var="sum1Reg18" value="${sum1Reg18+ptnrSub.reg18}"></c:set>
		            	<c:set var="sum1Reg19" value="${sum1Reg19+ptnrSub.reg19}"></c:set>
		            	<c:set var="sum1Reg20" value="${sum1Reg20+ptnrSub.reg20}"></c:set>		            	
		            	<c:set var="sum1Reg21" value="${sum1Reg21+ptnrSub.reg11}"></c:set>
		            	<c:set var="sum1Reg22" value="${sum1Reg22+ptnrSub.reg22}"></c:set>
		            	<c:set var="sum1Reg23" value="${sum1Reg23+ptnrSub.reg23}"></c:set>
		            	<c:set var="sum1Reg24" value="${sum1Reg24+ptnrSub.reg24}"></c:set>
		            	<c:set var="sum1Reg25" value="${sum1Reg25+ptnrSub.reg25}"></c:set>
		            	<c:set var="sum1Reg26" value="${sum1Reg26+ptnrSub.reg26}"></c:set>
		            	<c:set var="sum1Reg27" value="${sum1Reg27+ptnrSub.reg27}"></c:set>
		            	<c:set var="sum1Reg28" value="${sum1Reg28+ptnrSub.reg28}"></c:set>
		            	<c:set var="sum1Reg29" value="${sum1Reg29+ptnrSub.reg29}"></c:set>
		            	<c:set var="sum1Reg30" value="${sum1Reg30+ptnrSub.reg30}"></c:set>
		            	
		            	<c:set var="sum1EndTotal" value="${sum1EndTotal+sub1_endSum}"></c:set>
		            	<c:set var="sum1End01" value="${sum1End01+ptnrSub.end01}"></c:set>
		            	<c:set var="sum1End02" value="${sum1End02+ptnrSub.end02}"></c:set>
		            	<c:set var="sum1End03" value="${sum1End03+ptnrSub.end03}"></c:set>
		            	<c:set var="sum1End04" value="${sum1End04+ptnrSub.end04}"></c:set>
		            	<c:set var="sum1End05" value="${sum1End05+ptnrSub.end05}"></c:set>
		            	<c:set var="sum1End06" value="${sum1End06+ptnrSub.end06}"></c:set>
		            	<c:set var="sum1End07" value="${sum1End07+ptnrSub.end07}"></c:set>
		            	<c:set var="sum1End08" value="${sum1End08+ptnrSub.end08}"></c:set>
		            	<c:set var="sum1End09" value="${sum1End09+ptnrSub.end09}"></c:set>
		            	<c:set var="sum1End10" value="${sum1End10+ptnrSub.end10}"></c:set>		            	
		            	<c:set var="sum1End11" value="${sum1End11+ptnrSub.end11}"></c:set>
		            	<c:set var="sum1End12" value="${sum1End12+ptnrSub.end12}"></c:set>
		            	<c:set var="sum1End13" value="${sum1End13+ptnrSub.end13}"></c:set>
		            	<c:set var="sum1End14" value="${sum1End14+ptnrSub.end14}"></c:set>
		            	<c:set var="sum1End15" value="${sum1End15+ptnrSub.end15}"></c:set>
		            	<c:set var="sum1End16" value="${sum1End16+ptnrSub.end16}"></c:set>
		            	<c:set var="sum1End17" value="${sum1End17+ptnrSub.end17}"></c:set>
		            	<c:set var="sum1End18" value="${sum1End18+ptnrSub.end18}"></c:set>
		            	<c:set var="sum1End19" value="${sum1End19+ptnrSub.end19}"></c:set>
		            	<c:set var="sum1End20" value="${sum1End20+ptnrSub.end20}"></c:set>		            	
		            	<c:set var="sum1End21" value="${sum1End21+ptnrSub.end11}"></c:set>
		            	<c:set var="sum1End22" value="${sum1End22+ptnrSub.end22}"></c:set>
		            	<c:set var="sum1End23" value="${sum1End23+ptnrSub.end23}"></c:set>
		            	<c:set var="sum1End24" value="${sum1End24+ptnrSub.end24}"></c:set>
		            	<c:set var="sum1End25" value="${sum1End25+ptnrSub.end25}"></c:set>
		            	<c:set var="sum1End26" value="${sum1End26+ptnrSub.end26}"></c:set>
		            	<c:set var="sum1End27" value="${sum1End27+ptnrSub.end27}"></c:set>
		            	<c:set var="sum1End28" value="${sum1End28+ptnrSub.end28}"></c:set>
		            	<c:set var="sum1End29" value="${sum1End29+ptnrSub.end29}"></c:set>
		            	<c:set var="sum1End30" value="${sum1End30+ptnrSub.end30}"></c:set>
		            	
		            	<c:set var="sumAllRegTotal" value="${sumAllRegTotal+sub1_regSum}"></c:set>
		            	<c:set var="sumAllReg01" value="${sumAllReg01+ptnrSub.reg01}"></c:set>
		            	<c:set var="sumAllReg02" value="${sumAllReg02+ptnrSub.reg02}"></c:set>
		            	<c:set var="sumAllReg03" value="${sumAllReg03+ptnrSub.reg03}"></c:set>
		            	<c:set var="sumAllReg04" value="${sumAllReg04+ptnrSub.reg04}"></c:set>
		            	<c:set var="sumAllReg05" value="${sumAllReg05+ptnrSub.reg05}"></c:set>
		            	<c:set var="sumAllReg06" value="${sumAllReg06+ptnrSub.reg06}"></c:set>
		            	<c:set var="sumAllReg07" value="${sumAllReg07+ptnrSub.reg07}"></c:set>
		            	<c:set var="sumAllReg08" value="${sumAllReg08+ptnrSub.reg08}"></c:set>
		            	<c:set var="sumAllReg09" value="${sumAllReg09+ptnrSub.reg09}"></c:set>
		            	<c:set var="sumAllReg10" value="${sumAllReg10+ptnrSub.reg10}"></c:set>		            	
		            	<c:set var="sumAllReg11" value="${sumAllReg11+ptnrSub.reg11}"></c:set>
		            	<c:set var="sumAllReg12" value="${sumAllReg12+ptnrSub.reg12}"></c:set>
		            	<c:set var="sumAllReg13" value="${sumAllReg13+ptnrSub.reg13}"></c:set>
		            	<c:set var="sumAllReg14" value="${sumAllReg14+ptnrSub.reg14}"></c:set>
		            	<c:set var="sumAllReg15" value="${sumAllReg15+ptnrSub.reg15}"></c:set>
		            	<c:set var="sumAllReg16" value="${sumAllReg16+ptnrSub.reg16}"></c:set>
		            	<c:set var="sumAllReg17" value="${sumAllReg17+ptnrSub.reg17}"></c:set>
		            	<c:set var="sumAllReg18" value="${sumAllReg18+ptnrSub.reg18}"></c:set>
		            	<c:set var="sumAllReg19" value="${sumAllReg19+ptnrSub.reg19}"></c:set>
		            	<c:set var="sumAllReg20" value="${sumAllReg20+ptnrSub.reg20}"></c:set>		            	
		            	<c:set var="sumAllReg21" value="${sumAllReg21+ptnrSub.reg11}"></c:set>
		            	<c:set var="sumAllReg22" value="${sumAllReg22+ptnrSub.reg22}"></c:set>
		            	<c:set var="sumAllReg23" value="${sumAllReg23+ptnrSub.reg23}"></c:set>
		            	<c:set var="sumAllReg24" value="${sumAllReg24+ptnrSub.reg24}"></c:set>
		            	<c:set var="sumAllReg25" value="${sumAllReg25+ptnrSub.reg25}"></c:set>
		            	<c:set var="sumAllReg26" value="${sumAllReg26+ptnrSub.reg26}"></c:set>
		            	<c:set var="sumAllReg27" value="${sumAllReg27+ptnrSub.reg27}"></c:set>
		            	<c:set var="sumAllReg28" value="${sumAllReg28+ptnrSub.reg28}"></c:set>
		            	<c:set var="sumAllReg29" value="${sumAllReg29+ptnrSub.reg29}"></c:set>
		            	<c:set var="sumAllReg30" value="${sumAllReg30+ptnrSub.reg30}"></c:set>
		            	
		            	<c:set var="sumAllEndTotal" value="${sumAllEndTotal+sub1_endSum}"></c:set>
		            	<c:set var="sumAllEnd01" value="${sumAllEnd01+ptnrSub.end01}"></c:set>
		            	<c:set var="sumAllEnd02" value="${sumAllEnd02+ptnrSub.end02}"></c:set>
		            	<c:set var="sumAllEnd03" value="${sumAllEnd03+ptnrSub.end03}"></c:set>
		            	<c:set var="sumAllEnd04" value="${sumAllEnd04+ptnrSub.end04}"></c:set>
		            	<c:set var="sumAllEnd05" value="${sumAllEnd05+ptnrSub.end05}"></c:set>
		            	<c:set var="sumAllEnd06" value="${sumAllEnd06+ptnrSub.end06}"></c:set>
		            	<c:set var="sumAllEnd07" value="${sumAllEnd07+ptnrSub.end07}"></c:set>
		            	<c:set var="sumAllEnd08" value="${sumAllEnd08+ptnrSub.end08}"></c:set>
		            	<c:set var="sumAllEnd09" value="${sumAllEnd09+ptnrSub.end09}"></c:set>
		            	<c:set var="sumAllEnd10" value="${sumAllEnd10+ptnrSub.end10}"></c:set>		            	
		            	<c:set var="sumAllEnd11" value="${sumAllEnd11+ptnrSub.end11}"></c:set>
		            	<c:set var="sumAllEnd12" value="${sumAllEnd12+ptnrSub.end12}"></c:set>
		            	<c:set var="sumAllEnd13" value="${sumAllEnd13+ptnrSub.end13}"></c:set>
		            	<c:set var="sumAllEnd14" value="${sumAllEnd14+ptnrSub.end14}"></c:set>
		            	<c:set var="sumAllEnd15" value="${sumAllEnd15+ptnrSub.end15}"></c:set>
		            	<c:set var="sumAllEnd16" value="${sumAllEnd16+ptnrSub.end16}"></c:set>
		            	<c:set var="sumAllEnd17" value="${sumAllEnd17+ptnrSub.end17}"></c:set>
		            	<c:set var="sumAllEnd18" value="${sumAllEnd18+ptnrSub.end18}"></c:set>
		            	<c:set var="sumAllEnd19" value="${sumAllEnd19+ptnrSub.end19}"></c:set>
		            	<c:set var="sumAllEnd20" value="${sumAllEnd20+ptnrSub.end20}"></c:set>		            	
		            	<c:set var="sumAllEnd21" value="${sumAllEnd21+ptnrSub.end11}"></c:set>
		            	<c:set var="sumAllEnd22" value="${sumAllEnd22+ptnrSub.end22}"></c:set>
		            	<c:set var="sumAllEnd23" value="${sumAllEnd23+ptnrSub.end23}"></c:set>
		            	<c:set var="sumAllEnd24" value="${sumAllEnd24+ptnrSub.end24}"></c:set>
		            	<c:set var="sumAllEnd25" value="${sumAllEnd25+ptnrSub.end25}"></c:set>
		            	<c:set var="sumAllEnd26" value="${sumAllEnd26+ptnrSub.end26}"></c:set>
		            	<c:set var="sumAllEnd27" value="${sumAllEnd27+ptnrSub.end27}"></c:set>
		            	<c:set var="sumAllEnd28" value="${sumAllEnd28+ptnrSub.end28}"></c:set>
		            	<c:set var="sumAllEnd29" value="${sumAllEnd29+ptnrSub.end29}"></c:set>
		            	<c:set var="sumAllEnd30" value="${sumAllEnd30+ptnrSub.end30}"></c:set>
		            	
		            	<c:set var="sumAllRegMiSum" value="${sumAllRegMiSum+ptnrSub.regMiSum}"></c:set>
		            	<c:set var="sumAllRegYearSum" value="${sumAllRegYearSum+ptnrSub.regYearSum}"></c:set>
		            	<c:set var="sumAllEndMonthSum" value="${sumAllEndMonthSum+ptnrSub.endMonthSum}"></c:set>
		            	<c:set var="sumAllEndYearSum" value="${sumAllEndYearSum+ptnrSub.endYearSum}"></c:set>
		            			            			            		            		            	
		            	<%-- <tr style="bgcolor: #E7ECF1; text-align: center; cursor:pointer;" onclick="openPtnrByCenterModal('${ptnrSub.ptnrId}','${ptnrSub.ptnrNick}');" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"> --%>
		            	<tr>
		            		<c:choose>
		            			<c:when test="${ptnrSub.rowCnt == 1 or empty ptnrSub.rowCnt}">
		            				<c:set var="rowIdx" value="1"/>
		            				<td colspan="2" style="border-right: 1px solid #b9b9b9 !important;">
		            					${ptnrSub.ptnrNick}
		            				</td>
		            			</c:when>
		            			<c:otherwise>		            				
		            				<c:if test="${rowIdx == 1 }">
		            					<td rowspan="${ptnrSub.rowCnt+1}">
						            		${ptnrSub.ptnrNick}
						            	</td>	
		            				</c:if>
					            	<td style="border-right: 1px solid #b9b9b9 !important;">
					            		${ptnrSub.ptnrIdSubName}					            		
					            	</td>					            						            	
		            			</c:otherwise>
		            		</c:choose>		   
		            		<td style="text-align:center;border-right: 1px solid #b9b9b9">
		            			<p>수임</p>
		            			<p class="sub-p">종결</p>
		            		</td>         		
		            		<td class="border-right" bgcolor="#faebd7">
		            			<p>${sub1_regSum}</p><p class="sub-p">${sub1_endSum}</p>		            					            			
		            		</td>
		            		<!-- 미결 -->
		            		<td class="border-right" bgcolor="#faebd7">
		            			<p>${ptnrSub.regMiSum}</p>
		            		</td>
		            		<!-- 연간수임 -->
		            		<td class="border-right" bgcolor="#faebd7">
		            			<p>${ptnrSub.regYearSum}</p>
		            		</td>
		            		<!-- 당월종결 -->
		            		<td class="border-right" bgcolor="#faebd7">
		            			<p>${ptnrSub.endMonthSum}</p>
		            		</td>		            		
		            		<!-- 연간종결 -->
		            		<td class="border-right" bgcolor="#faebd7">
		            			<p>${ptnrSub.endYearSum}</p>
		            		</td>
		            		
		            		<td class="border-right">
		            			<p>${ptnrSub.reg01}</p><p class="sub-p">${ptnrSub.end01}</p>		            			
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub.reg02}</p><p class="sub-p">${ptnrSub.end02}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub.reg03}</p><p class="sub-p">${ptnrSub.end03}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub.reg04}</p><p class="sub-p">${ptnrSub.end04}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub.reg05}</p><p class="sub-p">${ptnrSub.end05}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub.reg06}</p><p class="sub-p">${ptnrSub.end06}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub.reg07}</p><p class="sub-p">${ptnrSub.end07}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub.reg08}</p><p class="sub-p">${ptnrSub.end08}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub.reg09}</p><p class="sub-p">${ptnrSub.end09}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub.reg10}</p><p class="sub-p">${ptnrSub.end10}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub.reg11}</p><p class="sub-p">${ptnrSub.end11}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub.reg12}</p><p class="sub-p">${ptnrSub.end12}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub.reg13}</p><p class="sub-p">${ptnrSub.end13}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub.reg14}</p><p class="sub-p">${ptnrSub.end14}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub.reg15}</p><p class="sub-p">${ptnrSub.end15}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub.reg16}</p><p class="sub-p">${ptnrSub.end16}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub.reg17}</p><p class="sub-p">${ptnrSub.end17}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub.reg18}</p><p class="sub-p">${ptnrSub.end18}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub.reg19}</p><p class="sub-p">${ptnrSub.end19}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub.reg20}</p><p class="sub-p">${ptnrSub.end20}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub.reg21}</p><p class="sub-p">${ptnrSub.end21}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub.reg22}</p><p class="sub-p">${ptnrSub.end22}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub.reg23}</p><p class="sub-p">${ptnrSub.end23}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub.reg24}</p><p class="sub-p">${ptnrSub.end24}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub.reg25}</p><p class="sub-p">${ptnrSub.end25}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub.reg26}</p><p class="sub-p">${ptnrSub.end26}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub.reg27}</p><p class="sub-p">${ptnrSub.end27}</p>
		            		</td>		            		
		            		<td class="border-right">
		            			<p>${ptnrSub.reg28}</p><p class="sub-p">${ptnrSub.end28}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub.reg29}</p><p class="sub-p">${ptnrSub.end29}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub.reg30}</p><p class="sub-p">${ptnrSub.end30}</p>
		            		</td>
		            		<c:if test="${ptnrIdSubList.size() < 13}">
		            			<td></td>
		            		</c:if>
		            	</tr>
		            	<!-- 보험사 소계 시작 -->		            	
		            	<c:choose>
		            		<c:when test="${ptnrSub.rowCnt == rowIdx}">		            			
		            			<c:if test="${ptnrSub.rowCnt > 1}">
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
		            			<c:set var="sum1EndYearSum" value="0" />
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
		            	<!-- 보험사 소계 끝 -->
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
</div>
