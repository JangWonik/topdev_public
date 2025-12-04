<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>
	$(document).ready(function(){
		$("#top_loading").hide();
	});
</script>
<div class="tableStyle2">
	<div style="width:100%; overflow-x: auto; overflow-y: hidden !important;">
		<div style="width:1882px;" >			
		    <div style="padding-right: 17px;background: #e7ecf1;">
		        <table cellpadding="0" cellspacing="0" width="1060" align="center">
		            <colgroup>
		            	<col width="60">
		                <col width="105">		                
		                <col width="100">
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
		            	<th class="border-right">Type</th>
		                <th class="border-right">보험사</th>
		                <th class="border-right" colspan="2">구분</th>		                
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
		    <!-- 1종 조사 시작 -->		    
		    <div style="height:632px; overflow-x: hidden; overflow-y: auto;">
		        <table cellpadding="0" cellspacing="0" width="1060" align="center">
		            <colgroup>
		            	<col width="60">
		                <col width="105">		                
		                <col width="100">
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
		            		<c:if test="${status.index == 0}">	
		            			<td rowspan="${leftRow}">1종 조사</td>
		            		</c:if>		            				            				            				            		
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
		            	<th colspan="4" class="border-right">1종 조사 합계</th>		            	
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
		    <!-- 1종 조사 끝 -->
		    
		    <!-- 1종 심사 시작 -->		    
		        <table cellpadding="0" cellspacing="0" width="1060" align="center">
		            <colgroup>
		            	<col width="60">
		                <col width="105">		                
		                <col width="100">
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
		            <tbody>
		            <!-- 인덱스 변수 시작 -->
		            <c:set var="rowIdx" value="1"/>
		            <!-- 소계값 변수 시작 -->
		            <c:set var="sum1_10_RegTotal" value="0"/>
		            <c:set var="sum1_10_RegMiSum" value="0"/>
		            <c:set var="sum1_10_RegYearSum" value="0"/>
		            <c:set var="sum1_10_EndMonthSum" value="0"/>
		            <c:set var="sum1_10_EndYearSum" value="0"/>
		            <c:set var="sum1_10_Reg01" value="0"/>
		            <c:set var="sum1_10_Reg02" value="0"/>
		            <c:set var="sum1_10_Reg03" value="0"/>
		            <c:set var="sum1_10_Reg04" value="0"/>
		            <c:set var="sum1_10_Reg05" value="0"/>
		            <c:set var="sum1_10_Reg06" value="0"/>
		            <c:set var="sum1_10_Reg07" value="0"/>
		            <c:set var="sum1_10_Reg08" value="0"/>
		            <c:set var="sum1_10_Reg09" value="0"/>
		            <c:set var="sum1_10_Reg10" value="0"/>
		            <c:set var="sum1_10_Reg11" value="0"/>
		            <c:set var="sum1_10_Reg12" value="0"/>
		            <c:set var="sum1_10_Reg13" value="0"/>
		            <c:set var="sum1_10_Reg14" value="0"/>
		            <c:set var="sum1_10_Reg15" value="0"/>
		            <c:set var="sum1_10_Reg16" value="0"/>
		            <c:set var="sum1_10_Reg17" value="0"/>
		            <c:set var="sum1_10_Reg18" value="0"/>
		            <c:set var="sum1_10_Reg19" value="0"/>
		            <c:set var="sum1_10_Reg20" value="0"/>
		            <c:set var="sum1_10_Reg21" value="0"/>
		            <c:set var="sum1_10_Reg22" value="0"/>
		            <c:set var="sum1_10_Reg23" value="0"/>
		            <c:set var="sum1_10_Reg24" value="0"/>
		            <c:set var="sum1_10_Reg25" value="0"/>
		            <c:set var="sum1_10_Reg26" value="0"/>
		            <c:set var="sum1_10_Reg27" value="0"/>
		            <c:set var="sum1_10_Reg28" value="0"/>
		            <c:set var="sum1_10_Reg29" value="0"/>
		            <c:set var="sum1_10_Reg30" value="0"/>
		            
		            <c:set var="sum1_10_EndTotal" value="0"/>
		            <c:set var="sum1_10_End01" value="0"/>
		            <c:set var="sum1_10_End02" value="0"/>
		            <c:set var="sum1_10_End03" value="0"/>
		            <c:set var="sum1_10_End04" value="0"/>
		            <c:set var="sum1_10_End05" value="0"/>
		            <c:set var="sum1_10_End06" value="0"/>
		            <c:set var="sum1_10_End07" value="0"/>
		            <c:set var="sum1_10_End08" value="0"/>
		            <c:set var="sum1_10_End09" value="0"/>
		            <c:set var="sum1_10_End10" value="0"/>
		            <c:set var="sum1_10_End11" value="0"/>
		            <c:set var="sum1_10_End12" value="0"/>
		            <c:set var="sum1_10_End13" value="0"/>
		            <c:set var="sum1_10_End14" value="0"/>
		            <c:set var="sum1_10_End15" value="0"/>
		            <c:set var="sum1_10_End16" value="0"/>
		            <c:set var="sum1_10_End17" value="0"/>
		            <c:set var="sum1_10_End18" value="0"/>
		            <c:set var="sum1_10_End19" value="0"/>
		            <c:set var="sum1_10_End20" value="0"/>
		            <c:set var="sum1_10_End21" value="0"/>
		            <c:set var="sum1_10_End22" value="0"/>
		            <c:set var="sum1_10_End23" value="0"/>
		            <c:set var="sum1_10_End24" value="0"/>
		            <c:set var="sum1_10_End25" value="0"/>
		            <c:set var="sum1_10_End26" value="0"/>
		            <c:set var="sum1_10_End27" value="0"/>
		            <c:set var="sum1_10_End28" value="0"/>
		            <c:set var="sum1_10_End29" value="0"/>
		            <c:set var="sum1_10_End30" value="0"/>
		            
		            <c:set var="sumAll_10_RegTotal" value="0"/>
		            <c:set var="sumAll_10_Reg01" value="0"/>
		            <c:set var="sumAll_10_Reg02" value="0"/>
		            <c:set var="sumAll_10_Reg03" value="0"/>
		            <c:set var="sumAll_10_Reg04" value="0"/>
		            <c:set var="sumAll_10_Reg05" value="0"/>
		            <c:set var="sumAll_10_Reg06" value="0"/>
		            <c:set var="sumAll_10_Reg07" value="0"/>
		            <c:set var="sumAll_10_Reg08" value="0"/>
		            <c:set var="sumAll_10_Reg09" value="0"/>
		            <c:set var="sumAll_10_Reg10" value="0"/>
		            <c:set var="sumAll_10_Reg11" value="0"/>
		            <c:set var="sumAll_10_Reg12" value="0"/>
		            <c:set var="sumAll_10_Reg13" value="0"/>
		            <c:set var="sumAll_10_Reg14" value="0"/>
		            <c:set var="sumAll_10_Reg15" value="0"/>
		            <c:set var="sumAll_10_Reg16" value="0"/>
		            <c:set var="sumAll_10_Reg17" value="0"/>
		            <c:set var="sumAll_10_Reg18" value="0"/>
		            <c:set var="sumAll_10_Reg19" value="0"/>
		            <c:set var="sumAll_10_Reg20" value="0"/>
		            <c:set var="sumAll_10_Reg21" value="0"/>
		            <c:set var="sumAll_10_Reg22" value="0"/>
		            <c:set var="sumAll_10_Reg23" value="0"/>
		            <c:set var="sumAll_10_Reg24" value="0"/>
		            <c:set var="sumAll_10_Reg25" value="0"/>
		            <c:set var="sumAll_10_Reg26" value="0"/>
		            <c:set var="sumAll_10_Reg27" value="0"/>
		            <c:set var="sumAll_10_Reg28" value="0"/>
		            <c:set var="sumAll_10_Reg29" value="0"/>
		            <c:set var="sumAll_10_Reg30" value="0"/>	
		            
		            <c:set var="sumAll_10_EndTotal" value="0"/>
		            <c:set var="sumAll_10_End01" value="0"/>
		            <c:set var="sumAll_10_End02" value="0"/>
		            <c:set var="sumAll_10_End03" value="0"/>
		            <c:set var="sumAll_10_End04" value="0"/>
		            <c:set var="sumAll_10_End05" value="0"/>
		            <c:set var="sumAll_10_End06" value="0"/>
		            <c:set var="sumAll_10_End07" value="0"/>
		            <c:set var="sumAll_10_End08" value="0"/>
		            <c:set var="sumAll_10_End09" value="0"/>
		            <c:set var="sumAll_10_End10" value="0"/>
		            <c:set var="sumAll_10_End11" value="0"/>
		            <c:set var="sumAll_10_End12" value="0"/>
		            <c:set var="sumAll_10_End13" value="0"/>
		            <c:set var="sumAll_10_End14" value="0"/>
		            <c:set var="sumAll_10_End15" value="0"/>
		            <c:set var="sumAll_10_End16" value="0"/>
		            <c:set var="sumAll_10_End17" value="0"/>
		            <c:set var="sumAll_10_End18" value="0"/>
		            <c:set var="sumAll_10_End19" value="0"/>
		            <c:set var="sumAll_10_End20" value="0"/>
		            <c:set var="sumAll_10_End21" value="0"/>
		            <c:set var="sumAll_10_End22" value="0"/>
		            <c:set var="sumAll_10_End23" value="0"/>
		            <c:set var="sumAll_10_End24" value="0"/>
		            <c:set var="sumAll_10_End25" value="0"/>
		            <c:set var="sumAll_10_End26" value="0"/>
		            <c:set var="sumAll_10_End27" value="0"/>
		            <c:set var="sumAll_10_End28" value="0"/>
		            <c:set var="sumAll_10_End29" value="0"/>
		            <c:set var="sumAll_10_End30" value="0"/>
		            
		            <c:set var="sumAll_10_RegMiSum" value="0"/>
		            <c:set var="sumAll_10_RegYearSum" value="0"/>
		            <c:set var="sumAll_10_EndMonthSum" value="0"/>
		            <c:set var="sumAll_10_EndYearSum" value="0"/>		            	            
		            <c:forEach var="ptnrSub_10" items="${ptnrIdSubList_10}" varStatus="status">	            	
		            	<!-- 가로축 합계 -->
		            	<c:set var="sub1_10_regSum" value="${ptnrSub_10.reg30+ptnrSub_10.reg29+ptnrSub_10.reg28+ptnrSub_10.reg27+ptnrSub_10.reg26+ptnrSub_10.reg25+ptnrSub_10.reg24+ptnrSub_10.reg23+ptnrSub_10.reg22+ptnrSub_10.reg21+ptnrSub_10.reg20+ptnrSub_10.reg19+ptnrSub_10.reg18+ptnrSub_10.reg17+ptnrSub_10.reg16+ptnrSub_10.reg15+ptnrSub_10.reg14+ptnrSub_10.reg13+ptnrSub_10.reg12+ptnrSub_10.reg11+ptnrSub_10.reg10+ptnrSub_10.reg09+ptnrSub_10.reg08+ptnrSub_10.reg07+ptnrSub_10.reg06+ptnrSub_10.reg05+ptnrSub_10.reg04+ptnrSub_10.reg03+ptnrSub_10.reg02+ptnrSub_10.reg01}"/>
		            	<c:set var="sub1_10_endSum" value="${ptnrSub_10.end30+ptnrSub_10.end29+ptnrSub_10.end28+ptnrSub_10.end27+ptnrSub_10.end26+ptnrSub_10.end25+ptnrSub_10.end24+ptnrSub_10.end23+ptnrSub_10.end22+ptnrSub_10.end21+ptnrSub_10.end20+ptnrSub_10.end19+ptnrSub_10.end18+ptnrSub_10.end17+ptnrSub_10.end16+ptnrSub_10.end15+ptnrSub_10.end14+ptnrSub_10.end13+ptnrSub_10.end12+ptnrSub_10.end11+ptnrSub_10.end10+ptnrSub_10.end09+ptnrSub_10.end08+ptnrSub_10.end07+ptnrSub_10.end06+ptnrSub_10.end05+ptnrSub_10.end04+ptnrSub_10.end03+ptnrSub_10.end02+ptnrSub_10.end01}"/>
		            	
		            	<c:set var="sum1_10_RegTotal" value="${sum1_10_RegTotal+sub1_10_regSum}"></c:set>
		            	<c:set var="sum1_10_RegMiSum" value="${sum1_10_RegMiSum+ptnrSub_10.regMiSum}"></c:set>
		            	<c:set var="sum1_10_RegYearSum" value="${sum1_10_RegYearSum+ptnrSub_10.regYearSum}"></c:set>
		            	<c:set var="sum1_10_EndMonthSum" value="${sum1_10_EndMonthSum+ptnrSub_10.endMonthSum}"></c:set>
		            	<c:set var="sum1_10_EndYearSum" value="${sum1_10_EndYearSum+ptnrSub_10.endYearSum}"></c:set>
		            	<c:set var="sum1_10_Reg01" value="${sum1_10_Reg01+ptnrSub_10.reg01}"></c:set>
		            	<c:set var="sum1_10_Reg02" value="${sum1_10_Reg02+ptnrSub_10.reg02}"></c:set>
		            	<c:set var="sum1_10_Reg03" value="${sum1_10_Reg03+ptnrSub_10.reg03}"></c:set>
		            	<c:set var="sum1_10_Reg04" value="${sum1_10_Reg04+ptnrSub_10.reg04}"></c:set>
		            	<c:set var="sum1_10_Reg05" value="${sum1_10_Reg05+ptnrSub_10.reg05}"></c:set>
		            	<c:set var="sum1_10_Reg06" value="${sum1_10_Reg06+ptnrSub_10.reg06}"></c:set>
		            	<c:set var="sum1_10_Reg07" value="${sum1_10_Reg07+ptnrSub_10.reg07}"></c:set>
		            	<c:set var="sum1_10_Reg08" value="${sum1_10_Reg08+ptnrSub_10.reg08}"></c:set>
		            	<c:set var="sum1_10_Reg09" value="${sum1_10_Reg09+ptnrSub_10.reg09}"></c:set>
		            	<c:set var="sum1_10_Reg10" value="${sum1_10_Reg10+ptnrSub_10.reg10}"></c:set>		            	
		            	<c:set var="sum1_10_Reg11" value="${sum1_10_Reg11+ptnrSub_10.reg11}"></c:set>
		            	<c:set var="sum1_10_Reg12" value="${sum1_10_Reg12+ptnrSub_10.reg12}"></c:set>
		            	<c:set var="sum1_10_Reg13" value="${sum1_10_Reg13+ptnrSub_10.reg13}"></c:set>
		            	<c:set var="sum1_10_Reg14" value="${sum1_10_Reg14+ptnrSub_10.reg14}"></c:set>
		            	<c:set var="sum1_10_Reg15" value="${sum1_10_Reg15+ptnrSub_10.reg15}"></c:set>
		            	<c:set var="sum1_10_Reg16" value="${sum1_10_Reg16+ptnrSub_10.reg16}"></c:set>
		            	<c:set var="sum1_10_Reg17" value="${sum1_10_Reg17+ptnrSub_10.reg17}"></c:set>
		            	<c:set var="sum1_10_Reg18" value="${sum1_10_Reg18+ptnrSub_10.reg18}"></c:set>
		            	<c:set var="sum1_10_Reg19" value="${sum1_10_Reg19+ptnrSub_10.reg19}"></c:set>
		            	<c:set var="sum1_10_Reg20" value="${sum1_10_Reg20+ptnrSub_10.reg20}"></c:set>		            	
		            	<c:set var="sum1_10_Reg21" value="${sum1_10_Reg21+ptnrSub_10.reg11}"></c:set>
		            	<c:set var="sum1_10_Reg22" value="${sum1_10_Reg22+ptnrSub_10.reg22}"></c:set>
		            	<c:set var="sum1_10_Reg23" value="${sum1_10_Reg23+ptnrSub_10.reg23}"></c:set>
		            	<c:set var="sum1_10_Reg24" value="${sum1_10_Reg24+ptnrSub_10.reg24}"></c:set>
		            	<c:set var="sum1_10_Reg25" value="${sum1_10_Reg25+ptnrSub_10.reg25}"></c:set>
		            	<c:set var="sum1_10_Reg26" value="${sum1_10_Reg26+ptnrSub_10.reg26}"></c:set>
		            	<c:set var="sum1_10_Reg27" value="${sum1_10_Reg27+ptnrSub_10.reg27}"></c:set>
		            	<c:set var="sum1_10_Reg28" value="${sum1_10_Reg28+ptnrSub_10.reg28}"></c:set>
		            	<c:set var="sum1_10_Reg29" value="${sum1_10_Reg29+ptnrSub_10.reg29}"></c:set>
		            	<c:set var="sum1_10_Reg30" value="${sum1_10_Reg30+ptnrSub_10.reg30}"></c:set>
		            	
		            	<c:set var="sum1_10_EndTotal" value="${sum1_10_EndTotal+sub1_10_endSum}"></c:set>
		            	<c:set var="sum1_10_End01" value="${sum1_10_End01+ptnrSub_10.end01}"></c:set>
		            	<c:set var="sum1_10_End02" value="${sum1_10_End02+ptnrSub_10.end02}"></c:set>
		            	<c:set var="sum1_10_End03" value="${sum1_10_End03+ptnrSub_10.end03}"></c:set>
		            	<c:set var="sum1_10_End04" value="${sum1_10_End04+ptnrSub_10.end04}"></c:set>
		            	<c:set var="sum1_10_End05" value="${sum1_10_End05+ptnrSub_10.end05}"></c:set>
		            	<c:set var="sum1_10_End06" value="${sum1_10_End06+ptnrSub_10.end06}"></c:set>
		            	<c:set var="sum1_10_End07" value="${sum1_10_End07+ptnrSub_10.end07}"></c:set>
		            	<c:set var="sum1_10_End08" value="${sum1_10_End08+ptnrSub_10.end08}"></c:set>
		            	<c:set var="sum1_10_End09" value="${sum1_10_End09+ptnrSub_10.end09}"></c:set>
		            	<c:set var="sum1_10_End10" value="${sum1_10_End10+ptnrSub_10.end10}"></c:set>		            	
		            	<c:set var="sum1_10_End11" value="${sum1_10_End11+ptnrSub_10.end11}"></c:set>
		            	<c:set var="sum1_10_End12" value="${sum1_10_End12+ptnrSub_10.end12}"></c:set>
		            	<c:set var="sum1_10_End13" value="${sum1_10_End13+ptnrSub_10.end13}"></c:set>
		            	<c:set var="sum1_10_End14" value="${sum1_10_End14+ptnrSub_10.end14}"></c:set>
		            	<c:set var="sum1_10_End15" value="${sum1_10_End15+ptnrSub_10.end15}"></c:set>
		            	<c:set var="sum1_10_End16" value="${sum1_10_End16+ptnrSub_10.end16}"></c:set>
		            	<c:set var="sum1_10_End17" value="${sum1_10_End17+ptnrSub_10.end17}"></c:set>
		            	<c:set var="sum1_10_End18" value="${sum1_10_End18+ptnrSub_10.end18}"></c:set>
		            	<c:set var="sum1_10_End19" value="${sum1_10_End19+ptnrSub_10.end19}"></c:set>
		            	<c:set var="sum1_10_End20" value="${sum1_10_End20+ptnrSub_10.end20}"></c:set>		            	
		            	<c:set var="sum1_10_End21" value="${sum1_10_End21+ptnrSub_10.end11}"></c:set>
		            	<c:set var="sum1_10_End22" value="${sum1_10_End22+ptnrSub_10.end22}"></c:set>
		            	<c:set var="sum1_10_End23" value="${sum1_10_End23+ptnrSub_10.end23}"></c:set>
		            	<c:set var="sum1_10_End24" value="${sum1_10_End24+ptnrSub_10.end24}"></c:set>
		            	<c:set var="sum1_10_End25" value="${sum1_10_End25+ptnrSub_10.end25}"></c:set>
		            	<c:set var="sum1_10_End26" value="${sum1_10_End26+ptnrSub_10.end26}"></c:set>
		            	<c:set var="sum1_10_End27" value="${sum1_10_End27+ptnrSub_10.end27}"></c:set>
		            	<c:set var="sum1_10_End28" value="${sum1_10_End28+ptnrSub_10.end28}"></c:set>
		            	<c:set var="sum1_10_End29" value="${sum1_10_End29+ptnrSub_10.end29}"></c:set>
		            	<c:set var="sum1_10_End30" value="${sum1_10_End30+ptnrSub_10.end30}"></c:set>
		            	
		            	<c:set var="sumAll_10_RegTotal" value="${sumAll_10_RegTotal+sub1_10_regSum}"></c:set>
		            	<c:set var="sumAll_10_Reg01" value="${sumAll_10_Reg01+ptnrSub_10.reg01}"></c:set>
		            	<c:set var="sumAll_10_Reg02" value="${sumAll_10_Reg02+ptnrSub_10.reg02}"></c:set>
		            	<c:set var="sumAll_10_Reg03" value="${sumAll_10_Reg03+ptnrSub_10.reg03}"></c:set>
		            	<c:set var="sumAll_10_Reg04" value="${sumAll_10_Reg04+ptnrSub_10.reg04}"></c:set>
		            	<c:set var="sumAll_10_Reg05" value="${sumAll_10_Reg05+ptnrSub_10.reg05}"></c:set>
		            	<c:set var="sumAll_10_Reg06" value="${sumAll_10_Reg06+ptnrSub_10.reg06}"></c:set>
		            	<c:set var="sumAll_10_Reg07" value="${sumAll_10_Reg07+ptnrSub_10.reg07}"></c:set>
		            	<c:set var="sumAll_10_Reg08" value="${sumAll_10_Reg08+ptnrSub_10.reg08}"></c:set>
		            	<c:set var="sumAll_10_Reg09" value="${sumAll_10_Reg09+ptnrSub_10.reg09}"></c:set>
		            	<c:set var="sumAll_10_Reg10" value="${sumAll_10_Reg10+ptnrSub_10.reg10}"></c:set>		            	
		            	<c:set var="sumAll_10_Reg11" value="${sumAll_10_Reg11+ptnrSub_10.reg11}"></c:set>
		            	<c:set var="sumAll_10_Reg12" value="${sumAll_10_Reg12+ptnrSub_10.reg12}"></c:set>
		            	<c:set var="sumAll_10_Reg13" value="${sumAll_10_Reg13+ptnrSub_10.reg13}"></c:set>
		            	<c:set var="sumAll_10_Reg14" value="${sumAll_10_Reg14+ptnrSub_10.reg14}"></c:set>
		            	<c:set var="sumAll_10_Reg15" value="${sumAll_10_Reg15+ptnrSub_10.reg15}"></c:set>
		            	<c:set var="sumAll_10_Reg16" value="${sumAll_10_Reg16+ptnrSub_10.reg16}"></c:set>
		            	<c:set var="sumAll_10_Reg17" value="${sumAll_10_Reg17+ptnrSub_10.reg17}"></c:set>
		            	<c:set var="sumAll_10_Reg18" value="${sumAll_10_Reg18+ptnrSub_10.reg18}"></c:set>
		            	<c:set var="sumAll_10_Reg19" value="${sumAll_10_Reg19+ptnrSub_10.reg19}"></c:set>
		            	<c:set var="sumAll_10_Reg20" value="${sumAll_10_Reg20+ptnrSub_10.reg20}"></c:set>		            	
		            	<c:set var="sumAll_10_Reg21" value="${sumAll_10_Reg21+ptnrSub_10.reg11}"></c:set>
		            	<c:set var="sumAll_10_Reg22" value="${sumAll_10_Reg22+ptnrSub_10.reg22}"></c:set>
		            	<c:set var="sumAll_10_Reg23" value="${sumAll_10_Reg23+ptnrSub_10.reg23}"></c:set>
		            	<c:set var="sumAll_10_Reg24" value="${sumAll_10_Reg24+ptnrSub_10.reg24}"></c:set>
		            	<c:set var="sumAll_10_Reg25" value="${sumAll_10_Reg25+ptnrSub_10.reg25}"></c:set>
		            	<c:set var="sumAll_10_Reg26" value="${sumAll_10_Reg26+ptnrSub_10.reg26}"></c:set>
		            	<c:set var="sumAll_10_Reg27" value="${sumAll_10_Reg27+ptnrSub_10.reg27}"></c:set>
		            	<c:set var="sumAll_10_Reg28" value="${sumAll_10_Reg28+ptnrSub_10.reg28}"></c:set>
		            	<c:set var="sumAll_10_Reg29" value="${sumAll_10_Reg29+ptnrSub_10.reg29}"></c:set>
		            	<c:set var="sumAll_10_Reg30" value="${sumAll_10_Reg30+ptnrSub_10.reg30}"></c:set>
		            	
		            	<c:set var="sumAll_10_EndTotal" value="${sumAll_10_EndTotal+sub1_10_endSum}"></c:set>
		            	<c:set var="sumAll_10_End01" value="${sumAll_10_End01+ptnrSub_10.end01}"></c:set>
		            	<c:set var="sumAll_10_End02" value="${sumAll_10_End02+ptnrSub_10.end02}"></c:set>
		            	<c:set var="sumAll_10_End03" value="${sumAll_10_End03+ptnrSub_10.end03}"></c:set>
		            	<c:set var="sumAll_10_End04" value="${sumAll_10_End04+ptnrSub_10.end04}"></c:set>
		            	<c:set var="sumAll_10_End05" value="${sumAll_10_End05+ptnrSub_10.end05}"></c:set>
		            	<c:set var="sumAll_10_End06" value="${sumAll_10_End06+ptnrSub_10.end06}"></c:set>
		            	<c:set var="sumAll_10_End07" value="${sumAll_10_End07+ptnrSub_10.end07}"></c:set>
		            	<c:set var="sumAll_10_End08" value="${sumAll_10_End08+ptnrSub_10.end08}"></c:set>
		            	<c:set var="sumAll_10_End09" value="${sumAll_10_End09+ptnrSub_10.end09}"></c:set>
		            	<c:set var="sumAll_10_End10" value="${sumAll_10_End10+ptnrSub_10.end10}"></c:set>		            	
		            	<c:set var="sumAll_10_End11" value="${sumAll_10_End11+ptnrSub_10.end11}"></c:set>
		            	<c:set var="sumAll_10_End12" value="${sumAll_10_End12+ptnrSub_10.end12}"></c:set>
		            	<c:set var="sumAll_10_End13" value="${sumAll_10_End13+ptnrSub_10.end13}"></c:set>
		            	<c:set var="sumAll_10_End14" value="${sumAll_10_End14+ptnrSub_10.end14}"></c:set>
		            	<c:set var="sumAll_10_End15" value="${sumAll_10_End15+ptnrSub_10.end15}"></c:set>
		            	<c:set var="sumAll_10_End16" value="${sumAll_10_End16+ptnrSub_10.end16}"></c:set>
		            	<c:set var="sumAll_10_End17" value="${sumAll_10_End17+ptnrSub_10.end17}"></c:set>
		            	<c:set var="sumAll_10_End18" value="${sumAll_10_End18+ptnrSub_10.end18}"></c:set>
		            	<c:set var="sumAll_10_End19" value="${sumAll_10_End19+ptnrSub_10.end19}"></c:set>
		            	<c:set var="sumAll_10_End20" value="${sumAll_10_End20+ptnrSub_10.end20}"></c:set>		            	
		            	<c:set var="sumAll_10_End21" value="${sumAll_10_End21+ptnrSub_10.end11}"></c:set>
		            	<c:set var="sumAll_10_End22" value="${sumAll_10_End22+ptnrSub_10.end22}"></c:set>
		            	<c:set var="sumAll_10_End23" value="${sumAll_10_End23+ptnrSub_10.end23}"></c:set>
		            	<c:set var="sumAll_10_End24" value="${sumAll_10_End24+ptnrSub_10.end24}"></c:set>
		            	<c:set var="sumAll_10_End25" value="${sumAll_10_End25+ptnrSub_10.end25}"></c:set>
		            	<c:set var="sumAll_10_End26" value="${sumAll_10_End26+ptnrSub_10.end26}"></c:set>
		            	<c:set var="sumAll_10_End27" value="${sumAll_10_End27+ptnrSub_10.end27}"></c:set>
		            	<c:set var="sumAll_10_End28" value="${sumAll_10_End28+ptnrSub_10.end28}"></c:set>
		            	<c:set var="sumAll_10_End29" value="${sumAll_10_End29+ptnrSub_10.end29}"></c:set>
		            	<c:set var="sumAll_10_End30" value="${sumAll_10_End30+ptnrSub_10.end30}"></c:set>
		            	
		            	<c:set var="sumAll_10_RegMiSum" value="${sumAll_10_RegMiSum+ptnrSub_10.regMiSum}"></c:set>
		            	<c:set var="sumAll_10_RegYearSum" value="${sumAll_10_RegYearSum+ptnrSub_10.regYearSum}"></c:set>
		            	<c:set var="sumAll_10_EndMonthSum" value="${sumAll_10_EndMonthSum+ptnrSub_10.endMonthSum}"></c:set>
		            	<c:set var="sumAll_10_EndYearSum" value="${sumAll_10_EndYearSum+ptnrSub_10.endYearSum}"></c:set>
		            			            			            		            		            	
		            	<%-- <tr style="bgcolor: #E7ECF1; text-align: center; cursor:pointer;" onclick="openPtnrByCenterModal('${ptnrSub_10.ptnrId}','${ptnrSub_10.ptnrNick}');" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"> --%>		            	
		            	<tr>
		            		<c:if test="${status.index == 0}">	
		            			<td rowspan="${leftRow_10}">1종 심사</td>
		            		</c:if>		            				            				            				            		
		            		<c:choose>
		            			<c:when test="${ptnrSub_10.rowCnt == 1 or empty ptnrSub_10.rowCnt}">
		            				<c:set var="rowIdx" value="1"/>		            				
		            				<td colspan="2" style="border-right: 1px solid #b9b9b9 !important;">
		            					${ptnrSub_10.ptnrNick}
		            				</td>
		            			</c:when>
		            			<c:otherwise>		            						            				
		            				<c:if test="${rowIdx == 1 }">		            					
		            					<td rowspan="${ptnrSub_10.rowCnt+1}">
						            		${ptnrSub_10.ptnrNick}
						            	</td>	
		            				</c:if>
					            	<td style="border-right: 1px solid #b9b9b9 !important;">
					            		${ptnrSub_10.ptnrIdSubName}					            		
					            	</td>					            						            	
		            			</c:otherwise>
		            		</c:choose>		   
		            		<td style="text-align:center;border-right: 1px solid #b9b9b9">
		            			<p>수임</p>
		            			<p class="sub-p">종결</p>
		            		</td>         		
		            		<td class="border-right" bgcolor="#faebd7">
		            			<p>${sub1_10_regSum}</p><p class="sub-p">${sub1_10_endSum}</p>		            					            			
		            		</td>
		            		<!-- 미결 -->
		            		<td class="border-right" bgcolor="#faebd7">
		            			<p>${ptnrSub_10.regMiSum}</p>
		            		</td>
		            		<!-- 연간수임 -->
		            		<td class="border-right" bgcolor="#faebd7">
		            			<p>${ptnrSub_10.regYearSum}</p>
		            		</td>
		            		<!-- 당월종결 -->
		            		<td class="border-right" bgcolor="#faebd7">
		            			<p>${ptnrSub_10.endMonthSum}</p>
		            		</td>		            		
		            		<!-- 연간종결 -->
		            		<td class="border-right" bgcolor="#faebd7">
		            			<p>${ptnrSub_10.endYearSum}</p>
		            		</td>
		            		
		            		<td class="border-right">
		            			<p>${ptnrSub_10.reg01}</p><p class="sub-p">${ptnrSub_10.end01}</p>		            			
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_10.reg02}</p><p class="sub-p">${ptnrSub_10.end02}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_10.reg03}</p><p class="sub-p">${ptnrSub_10.end03}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_10.reg04}</p><p class="sub-p">${ptnrSub_10.end04}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_10.reg05}</p><p class="sub-p">${ptnrSub_10.end05}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_10.reg06}</p><p class="sub-p">${ptnrSub_10.end06}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_10.reg07}</p><p class="sub-p">${ptnrSub_10.end07}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_10.reg08}</p><p class="sub-p">${ptnrSub_10.end08}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_10.reg09}</p><p class="sub-p">${ptnrSub_10.end09}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_10.reg10}</p><p class="sub-p">${ptnrSub_10.end10}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_10.reg11}</p><p class="sub-p">${ptnrSub_10.end11}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_10.reg12}</p><p class="sub-p">${ptnrSub_10.end12}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_10.reg13}</p><p class="sub-p">${ptnrSub_10.end13}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_10.reg14}</p><p class="sub-p">${ptnrSub_10.end14}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_10.reg15}</p><p class="sub-p">${ptnrSub_10.end15}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_10.reg16}</p><p class="sub-p">${ptnrSub_10.end16}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_10.reg17}</p><p class="sub-p">${ptnrSub_10.end17}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_10.reg18}</p><p class="sub-p">${ptnrSub_10.end18}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_10.reg19}</p><p class="sub-p">${ptnrSub_10.end19}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_10.reg20}</p><p class="sub-p">${ptnrSub_10.end20}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_10.reg21}</p><p class="sub-p">${ptnrSub_10.end21}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_10.reg22}</p><p class="sub-p">${ptnrSub_10.end22}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_10.reg23}</p><p class="sub-p">${ptnrSub_10.end23}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_10.reg24}</p><p class="sub-p">${ptnrSub_10.end24}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_10.reg25}</p><p class="sub-p">${ptnrSub_10.end25}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_10.reg26}</p><p class="sub-p">${ptnrSub_10.end26}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_10.reg27}</p><p class="sub-p">${ptnrSub_10.end27}</p>
		            		</td>		            		
		            		<td class="border-right">
		            			<p>${ptnrSub_10.reg28}</p><p class="sub-p">${ptnrSub_10.end28}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_10.reg29}</p><p class="sub-p">${ptnrSub_10.end29}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_10.reg30}</p><p class="sub-p">${ptnrSub_10.end30}</p>
		            		</td>		            		
		            	</tr>
		            	<!-- 보험사 소계 시작 -->		            	
		            	<c:choose>
		            		<c:when test="${ptnrSub_10.rowCnt == rowIdx}">		            			
		            			<c:if test="${ptnrSub_10.rowCnt > 1}">
		            				<tr>
			            				<th style="border-right: 1px solid #b9b9b9 !important;" colspan="2">소계</th>
			            				<th style="border-right: 1px solid #b9b9b9 !important;">
			            					<p>${sum1_10_RegTotal}</p><p class="sub-p">${sum1_10_EndTotal}</p>			            					
			            				</th>
			            				<th style="border-right: 1px solid #b9b9b9 !important;">
			            					<p>${sum1_10_RegMiSum}</p>			            					
			            				</th>
			            				<th style="border-right: 1px solid #b9b9b9 !important;">
			            					<p>${sum1_10_RegYearSum}</p>			            					
			            				</th>
			            				<th style="border-right: 1px solid #b9b9b9 !important;">
			            					<p>${sum1_10_EndMonthSum}</p>			            					
			            				</th>
			            				<th style="border-right: 1px solid #b9b9b9 !important;">
			            					<p>${sum1_10_EndYearSum}</p>			            					
			            				</th>			            				
			            				<th><p>${sum1_10_Reg01}</p><p class="sub-p">${sum1_10_End01}</p></th>
			            				<th><p>${sum1_10_Reg02}</p><p class="sub-p">${sum1_10_End02}</p></th>
			            				<th><p>${sum1_10_Reg03}</p><p class="sub-p">${sum1_10_End03}</p></th>
			            				<th><p>${sum1_10_Reg04}</p><p class="sub-p">${sum1_10_End04}</p></th>
			            				<th><p>${sum1_10_Reg05}</p><p class="sub-p">${sum1_10_End05}</p></th>
			            				<th><p>${sum1_10_Reg06}</p><p class="sub-p">${sum1_10_End06}</p></th>
			            				<th><p>${sum1_10_Reg07}</p><p class="sub-p">${sum1_10_End07}</p></th>
			            				<th><p>${sum1_10_Reg08}</p><p class="sub-p">${sum1_10_End08}</p></th>
			            				<th><p>${sum1_10_Reg09}</p><p class="sub-p">${sum1_10_End09}</p></th>
			            				<th><p>${sum1_10_Reg10}</p><p class="sub-p">${sum1_10_End10}</p></th>
			            				<th><p>${sum1_10_Reg11}</p><p class="sub-p">${sum1_10_End11}</p></th>
			            				<th><p>${sum1_10_Reg12}</p><p class="sub-p">${sum1_10_End12}</p></th>
			            				<th><p>${sum1_10_Reg13}</p><p class="sub-p">${sum1_10_End13}</p></th>
			            				<th><p>${sum1_10_Reg14}</p><p class="sub-p">${sum1_10_End14}</p></th>
			            				<th><p>${sum1_10_Reg15}</p><p class="sub-p">${sum1_10_End15}</p></th>
			            				<th><p>${sum1_10_Reg16}</p><p class="sub-p">${sum1_10_End16}</p></th>
			            				<th><p>${sum1_10_Reg17}</p><p class="sub-p">${sum1_10_End17}</p></th>
			            				<th><p>${sum1_10_Reg18}</p><p class="sub-p">${sum1_10_End18}</p></th>
			            				<th><p>${sum1_10_Reg19}</p><p class="sub-p">${sum1_10_End19}</p></th>
			            				<th><p>${sum1_10_Reg20}</p><p class="sub-p">${sum1_10_End20}</p></th>			            				
			            				<th><p>${sum1_10_Reg21}</p><p class="sub-p">${sum1_10_End21}</p></th>
			            				<th><p>${sum1_10_Reg22}</p><p class="sub-p">${sum1_10_End22}</p></th>
			            				<th><p>${sum1_10_Reg23}</p><p class="sub-p">${sum1_10_End23}</p></th>
			            				<th><p>${sum1_10_Reg24}</p><p class="sub-p">${sum1_10_End24}</p></th>
			            				<th><p>${sum1_10_Reg25}</p><p class="sub-p">${sum1_10_End25}</p></th>
			            				<th><p>${sum1_10_Reg26}</p><p class="sub-p">${sum1_10_End26}</p></th>
			            				<th><p>${sum1_10_Reg27}</p><p class="sub-p">${sum1_10_End27}</p></th>
			            				<th><p>${sum1_10_Reg28}</p><p class="sub-p">${sum1_10_End28}</p></th>
			            				<th><p>${sum1_10_Reg29}</p><p class="sub-p">${sum1_10_End29}</p></th>
			            				<th style="border-right: 1px solid #b9b9b9"><p>${sum1_10_Reg30}</p><p class="sub-p">${sum1_10_End30}</p></th>			            				
			            			</tr>
		            			</c:if>
		            			<!-- 소계 계산후 초기화 -->		            			
		            			<c:set var="rowIdx" value="1"/>
		            			<c:set var="sum1_10_RegTotal" value="0" />		            			
		            			<c:set var="sum1_10_RegMiSum" value="0" />
		            			<c:set var="sum1_10_RegYearSum" value="0" />
		            			<c:set var="sum1_10_EndYearSum" value="0" />
		            			<c:set var="sum1_10_EndMonthSum" value="0" />
		            			<c:set var="sum1_10_EndYearSum" value="0" />
		            			<c:set var="sum1_10_Reg01" value="0" />
		            			<c:set var="sum1_10_Reg02" value="0" />
		            			<c:set var="sum1_10_Reg03" value="0" />
		            			<c:set var="sum1_10_Reg04" value="0" />
		            			<c:set var="sum1_10_Reg05" value="0" />
		            			<c:set var="sum1_10_Reg06" value="0" />
		            			<c:set var="sum1_10_Reg07" value="0" />
		            			<c:set var="sum1_10_Reg08" value="0" />
		            			<c:set var="sum1_10_Reg09" value="0" />
		            			<c:set var="sum1_10_Reg10" value="0" />
		            			<c:set var="sum1_10_Reg11" value="0" />
		            			<c:set var="sum1_10_Reg12" value="0" />
		            			<c:set var="sum1_10_Reg13" value="0" />
		            			<c:set var="sum1_10_Reg14" value="0" />
		            			<c:set var="sum1_10_Reg15" value="0" />
		            			<c:set var="sum1_10_Reg16" value="0" />
		            			<c:set var="sum1_10_Reg17" value="0" />
		            			<c:set var="sum1_10_Reg18" value="0" />
		            			<c:set var="sum1_10_Reg19" value="0" />
		            			<c:set var="sum1_10_Reg20" value="0" />
		            			<c:set var="sum1_10_Reg21" value="0" />
		            			<c:set var="sum1_10_Reg22" value="0" />
		            			<c:set var="sum1_10_Reg23" value="0" />
		            			<c:set var="sum1_10_Reg24" value="0" />
		            			<c:set var="sum1_10_Reg25" value="0" />
		            			<c:set var="sum1_10_Reg26" value="0" />
		            			<c:set var="sum1_10_Reg27" value="0" />
		            			<c:set var="sum1_10_Reg28" value="0" />
		            			<c:set var="sum1_10_Reg29" value="0" />
		            			<c:set var="sum1_10_Reg30" value="0" />
		            			
		            			<c:set var="sum1_10_EndTotal" value="0" />
		            			<c:set var="sum1_10_End01" value="0" />
		            			<c:set var="sum1_10_End02" value="0" />
		            			<c:set var="sum1_10_End03" value="0" />
		            			<c:set var="sum1_10_End04" value="0" />
		            			<c:set var="sum1_10_End05" value="0" />
		            			<c:set var="sum1_10_End06" value="0" />
		            			<c:set var="sum1_10_End07" value="0" />
		            			<c:set var="sum1_10_End08" value="0" />
		            			<c:set var="sum1_10_End09" value="0" />
		            			<c:set var="sum1_10_End10" value="0" />
		            			<c:set var="sum1_10_End11" value="0" />
		            			<c:set var="sum1_10_End12" value="0" />
		            			<c:set var="sum1_10_End13" value="0" />
		            			<c:set var="sum1_10_End14" value="0" />
		            			<c:set var="sum1_10_End15" value="0" />
		            			<c:set var="sum1_10_End16" value="0" />
		            			<c:set var="sum1_10_End17" value="0" />
		            			<c:set var="sum1_10_End18" value="0" />
		            			<c:set var="sum1_10_End19" value="0" />
		            			<c:set var="sum1_10_End20" value="0" />
		            			<c:set var="sum1_10_End21" value="0" />
		            			<c:set var="sum1_10_End22" value="0" />
		            			<c:set var="sum1_10_End23" value="0" />
		            			<c:set var="sum1_10_End24" value="0" />
		            			<c:set var="sum1_10_End25" value="0" />
		            			<c:set var="sum1_10_End26" value="0" />
		            			<c:set var="sum1_10_End27" value="0" />
		            			<c:set var="sum1_10_End28" value="0" />
		            			<c:set var="sum1_10_End29" value="0" />
		            			<c:set var="sum1_10_End30" value="0" />		            			
		            		</c:when>
		            		<c:otherwise>
		            			<c:set var="rowIdx" value="${rowIdx+1}"/>
		            		</c:otherwise>
		            	</c:choose>
		            	<!-- 보험사 소계 끝 -->
		            </c:forEach>
		            <!-- 전체 합계 시작 -->
		            <tr>
		            	<th colspan="4" class="border-right">1종 심사 합계</th>		            	
		            	<th class="border-right" bgcolor="#faebd7">
	            			<p>${sumAll_10_RegTotal}</p><p class="sub-p">${sumAll_10_EndTotal}</p>
		            	</th>
		            	<!-- 미결 -->
		            	<th class="border-right" bgcolor="#faebd7">
	            			<p>${sumAll_10_RegMiSum}</p>
		            	</th>
		            	<!-- 연간수임 -->
		            	<th class="border-right" bgcolor="#faebd7">
	            			<p>${sumAll_10_RegYearSum}</p>
		            	</th>
		            	<!-- 당월종결 -->
		            	<th class="border-right" bgcolor="#faebd7">
	            			<p>${sumAll_10_EndMonthSum}</p>
		            	</th>
		            	<!-- 연간종결 -->
		            	<th class="border-right" bgcolor="#faebd7">
	            			<p>${sumAll_10_EndYearSum}</p>
		            	</th>
		            	<th><p>${sumAll_10_Reg01}</p><p class="sub-p">${sumAll_10_End01}</p></th>
           				<th><p>${sumAll_10_Reg02}</p><p class="sub-p">${sumAll_10_End02}</p></th>
           				<th><p>${sumAll_10_Reg03}</p><p class="sub-p">${sumAll_10_End03}</p></th>
           				<th><p>${sumAll_10_Reg04}</p><p class="sub-p">${sumAll_10_End04}</p></th>
           				<th><p>${sumAll_10_Reg05}</p><p class="sub-p">${sumAll_10_End05}</p></th>
           				<th><p>${sumAll_10_Reg06}</p><p class="sub-p">${sumAll_10_End06}</p></th>
           				<th><p>${sumAll_10_Reg07}</p><p class="sub-p">${sumAll_10_End07}</p></th>
           				<th><p>${sumAll_10_Reg08}</p><p class="sub-p">${sumAll_10_End08}</p></th>
           				<th><p>${sumAll_10_Reg09}</p><p class="sub-p">${sumAll_10_End09}</p></th>
           				<th><p>${sumAll_10_Reg10}</p><p class="sub-p">${sumAll_10_End10}</p></th>
           				<th><p>${sumAll_10_Reg11}</p><p class="sub-p">${sumAll_10_End11}</p></th>
           				<th><p>${sumAll_10_Reg12}</p><p class="sub-p">${sumAll_10_End12}</p></th>
           				<th><p>${sumAll_10_Reg13}</p><p class="sub-p">${sumAll_10_End13}</p></th>
           				<th><p>${sumAll_10_Reg14}</p><p class="sub-p">${sumAll_10_End14}</p></th>
           				<th><p>${sumAll_10_Reg15}</p><p class="sub-p">${sumAll_10_End15}</p></th>
           				<th><p>${sumAll_10_Reg16}</p><p class="sub-p">${sumAll_10_End16}</p></th>
           				<th><p>${sumAll_10_Reg17}</p><p class="sub-p">${sumAll_10_End17}</p></th>
           				<th><p>${sumAll_10_Reg18}</p><p class="sub-p">${sumAll_10_End18}</p></th>
           				<th><p>${sumAll_10_Reg19}</p><p class="sub-p">${sumAll_10_End19}</p></th>
           				<th><p>${sumAll_10_Reg20}</p><p class="sub-p">${sumAll_10_End20}</p></th>
           				<th><p>${sumAll_10_Reg21}</p><p class="sub-p">${sumAll_10_End21}</p></th>
           				<th><p>${sumAll_10_Reg22}</p><p class="sub-p">${sumAll_10_End22}</p></th>
           				<th><p>${sumAll_10_Reg23}</p><p class="sub-p">${sumAll_10_End23}</p></th>
           				<th><p>${sumAll_10_Reg24}</p><p class="sub-p">${sumAll_10_End24}</p></th>
           				<th><p>${sumAll_10_Reg25}</p><p class="sub-p">${sumAll_10_End25}</p></th>
           				<th><p>${sumAll_10_Reg26}</p><p class="sub-p">${sumAll_10_End26}</p></th>
           				<th><p>${sumAll_10_Reg27}</p><p class="sub-p">${sumAll_10_End27}</p></th>
           				<th><p>${sumAll_10_Reg28}</p><p class="sub-p">${sumAll_10_End28}</p></th>
           				<th><p>${sumAll_10_Reg29}</p><p class="sub-p">${sumAll_10_End29}</p></th>
           				<th style="border-right: 1px solid #b9b9b9"><p>${sumAll_10_Reg30}</p><p class="sub-p">${sumAll_10_End30}</p></th>
		            </tr>
		            </tbody>
		        </table>
		    <!-- 1종 심사 끝 -->
		    
		    <!-- 1종 기타 시작 -->
			    <table cellpadding="0" cellspacing="0" width="1060" align="center">
		            <colgroup>
		            	<col width="60">
		                <col width="105">		                
		                <col width="100">
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
		            <tbody>
		            <!-- 인덱스 변수 시작 -->
		            <c:set var="rowIdx" value="1"/>
		            <!-- 소계값 변수 시작 -->
		            <c:set var="sum1_15_RegTotal" value="0"/>
		            <c:set var="sum1_15_RegMiSum" value="0"/>
		            <c:set var="sum1_15_RegYearSum" value="0"/>
		            <c:set var="sum1_15_EndMonthSum" value="0"/>
		            <c:set var="sum1_15_EndYearSum" value="0"/>
		            <c:set var="sum1_15_Reg01" value="0"/>
		            <c:set var="sum1_15_Reg02" value="0"/>
		            <c:set var="sum1_15_Reg03" value="0"/>
		            <c:set var="sum1_15_Reg04" value="0"/>
		            <c:set var="sum1_15_Reg05" value="0"/>
		            <c:set var="sum1_15_Reg06" value="0"/>
		            <c:set var="sum1_15_Reg07" value="0"/>
		            <c:set var="sum1_15_Reg08" value="0"/>
		            <c:set var="sum1_15_Reg09" value="0"/>
		            <c:set var="sum1_15_Reg10" value="0"/>
		            <c:set var="sum1_15_Reg11" value="0"/>
		            <c:set var="sum1_15_Reg12" value="0"/>
		            <c:set var="sum1_15_Reg13" value="0"/>
		            <c:set var="sum1_15_Reg14" value="0"/>
		            <c:set var="sum1_15_Reg15" value="0"/>
		            <c:set var="sum1_15_Reg16" value="0"/>
		            <c:set var="sum1_15_Reg17" value="0"/>
		            <c:set var="sum1_15_Reg18" value="0"/>
		            <c:set var="sum1_15_Reg19" value="0"/>
		            <c:set var="sum1_15_Reg20" value="0"/>
		            <c:set var="sum1_15_Reg21" value="0"/>
		            <c:set var="sum1_15_Reg22" value="0"/>
		            <c:set var="sum1_15_Reg23" value="0"/>
		            <c:set var="sum1_15_Reg24" value="0"/>
		            <c:set var="sum1_15_Reg25" value="0"/>
		            <c:set var="sum1_15_Reg26" value="0"/>
		            <c:set var="sum1_15_Reg27" value="0"/>
		            <c:set var="sum1_15_Reg28" value="0"/>
		            <c:set var="sum1_15_Reg29" value="0"/>
		            <c:set var="sum1_15_Reg30" value="0"/>
		            
		            <c:set var="sum1_15_EndTotal" value="0"/>
		            <c:set var="sum1_15_End01" value="0"/>
		            <c:set var="sum1_15_End02" value="0"/>
		            <c:set var="sum1_15_End03" value="0"/>
		            <c:set var="sum1_15_End04" value="0"/>
		            <c:set var="sum1_15_End05" value="0"/>
		            <c:set var="sum1_15_End06" value="0"/>
		            <c:set var="sum1_15_End07" value="0"/>
		            <c:set var="sum1_15_End08" value="0"/>
		            <c:set var="sum1_15_End09" value="0"/>
		            <c:set var="sum1_15_End10" value="0"/>
		            <c:set var="sum1_15_End11" value="0"/>
		            <c:set var="sum1_15_End12" value="0"/>
		            <c:set var="sum1_15_End13" value="0"/>
		            <c:set var="sum1_15_End14" value="0"/>
		            <c:set var="sum1_15_End15" value="0"/>
		            <c:set var="sum1_15_End16" value="0"/>
		            <c:set var="sum1_15_End17" value="0"/>
		            <c:set var="sum1_15_End18" value="0"/>
		            <c:set var="sum1_15_End19" value="0"/>
		            <c:set var="sum1_15_End20" value="0"/>
		            <c:set var="sum1_15_End21" value="0"/>
		            <c:set var="sum1_15_End22" value="0"/>
		            <c:set var="sum1_15_End23" value="0"/>
		            <c:set var="sum1_15_End24" value="0"/>
		            <c:set var="sum1_15_End25" value="0"/>
		            <c:set var="sum1_15_End26" value="0"/>
		            <c:set var="sum1_15_End27" value="0"/>
		            <c:set var="sum1_15_End28" value="0"/>
		            <c:set var="sum1_15_End29" value="0"/>
		            <c:set var="sum1_15_End30" value="0"/>
		            
		            <c:set var="sumAll_15_RegTotal" value="0"/>
		            <c:set var="sumAll_15_Reg01" value="0"/>
		            <c:set var="sumAll_15_Reg02" value="0"/>
		            <c:set var="sumAll_15_Reg03" value="0"/>
		            <c:set var="sumAll_15_Reg04" value="0"/>
		            <c:set var="sumAll_15_Reg05" value="0"/>
		            <c:set var="sumAll_15_Reg06" value="0"/>
		            <c:set var="sumAll_15_Reg07" value="0"/>
		            <c:set var="sumAll_15_Reg08" value="0"/>
		            <c:set var="sumAll_15_Reg09" value="0"/>
		            <c:set var="sumAll_15_Reg10" value="0"/>
		            <c:set var="sumAll_15_Reg11" value="0"/>
		            <c:set var="sumAll_15_Reg12" value="0"/>
		            <c:set var="sumAll_15_Reg13" value="0"/>
		            <c:set var="sumAll_15_Reg14" value="0"/>
		            <c:set var="sumAll_15_Reg15" value="0"/>
		            <c:set var="sumAll_15_Reg16" value="0"/>
		            <c:set var="sumAll_15_Reg17" value="0"/>
		            <c:set var="sumAll_15_Reg18" value="0"/>
		            <c:set var="sumAll_15_Reg19" value="0"/>
		            <c:set var="sumAll_15_Reg20" value="0"/>
		            <c:set var="sumAll_15_Reg21" value="0"/>
		            <c:set var="sumAll_15_Reg22" value="0"/>
		            <c:set var="sumAll_15_Reg23" value="0"/>
		            <c:set var="sumAll_15_Reg24" value="0"/>
		            <c:set var="sumAll_15_Reg25" value="0"/>
		            <c:set var="sumAll_15_Reg26" value="0"/>
		            <c:set var="sumAll_15_Reg27" value="0"/>
		            <c:set var="sumAll_15_Reg28" value="0"/>
		            <c:set var="sumAll_15_Reg29" value="0"/>
		            <c:set var="sumAll_15_Reg30" value="0"/>	
		            
		            <c:set var="sumAll_15_EndTotal" value="0"/>
		            <c:set var="sumAll_15_End01" value="0"/>
		            <c:set var="sumAll_15_End02" value="0"/>
		            <c:set var="sumAll_15_End03" value="0"/>
		            <c:set var="sumAll_15_End04" value="0"/>
		            <c:set var="sumAll_15_End05" value="0"/>
		            <c:set var="sumAll_15_End06" value="0"/>
		            <c:set var="sumAll_15_End07" value="0"/>
		            <c:set var="sumAll_15_End08" value="0"/>
		            <c:set var="sumAll_15_End09" value="0"/>
		            <c:set var="sumAll_15_End10" value="0"/>
		            <c:set var="sumAll_15_End11" value="0"/>
		            <c:set var="sumAll_15_End12" value="0"/>
		            <c:set var="sumAll_15_End13" value="0"/>
		            <c:set var="sumAll_15_End14" value="0"/>
		            <c:set var="sumAll_15_End15" value="0"/>
		            <c:set var="sumAll_15_End16" value="0"/>
		            <c:set var="sumAll_15_End17" value="0"/>
		            <c:set var="sumAll_15_End18" value="0"/>
		            <c:set var="sumAll_15_End19" value="0"/>
		            <c:set var="sumAll_15_End20" value="0"/>
		            <c:set var="sumAll_15_End21" value="0"/>
		            <c:set var="sumAll_15_End22" value="0"/>
		            <c:set var="sumAll_15_End23" value="0"/>
		            <c:set var="sumAll_15_End24" value="0"/>
		            <c:set var="sumAll_15_End25" value="0"/>
		            <c:set var="sumAll_15_End26" value="0"/>
		            <c:set var="sumAll_15_End27" value="0"/>
		            <c:set var="sumAll_15_End28" value="0"/>
		            <c:set var="sumAll_15_End29" value="0"/>
		            <c:set var="sumAll_15_End30" value="0"/>
		            
		            <c:set var="sumAll_15_RegMiSum" value="0"/>
		            <c:set var="sumAll_15_RegYearSum" value="0"/>
		            <c:set var="sumAll_15_EndMonthSum" value="0"/>
		            <c:set var="sumAll_15_EndYearSum" value="0"/>		            	            
		            <c:forEach var="ptnrSub_15" items="${ptnrIdSubList_15}" varStatus="status">	            	
		            	<!-- 가로축 합계 -->
		            	<c:set var="sub1_15_regSum" value="${ptnrSub_15.reg30+ptnrSub_15.reg29+ptnrSub_15.reg28+ptnrSub_15.reg27+ptnrSub_15.reg26+ptnrSub_15.reg25+ptnrSub_15.reg24+ptnrSub_15.reg23+ptnrSub_15.reg22+ptnrSub_15.reg21+ptnrSub_15.reg20+ptnrSub_15.reg19+ptnrSub_15.reg18+ptnrSub_15.reg17+ptnrSub_15.reg16+ptnrSub_15.reg15+ptnrSub_15.reg14+ptnrSub_15.reg13+ptnrSub_15.reg12+ptnrSub_15.reg11+ptnrSub_15.reg10+ptnrSub_15.reg09+ptnrSub_15.reg08+ptnrSub_15.reg07+ptnrSub_15.reg06+ptnrSub_15.reg05+ptnrSub_15.reg04+ptnrSub_15.reg03+ptnrSub_15.reg02+ptnrSub_15.reg01}"/>
		            	<c:set var="sub1_15_endSum" value="${ptnrSub_15.end30+ptnrSub_15.end29+ptnrSub_15.end28+ptnrSub_15.end27+ptnrSub_15.end26+ptnrSub_15.end25+ptnrSub_15.end24+ptnrSub_15.end23+ptnrSub_15.end22+ptnrSub_15.end21+ptnrSub_15.end20+ptnrSub_15.end19+ptnrSub_15.end18+ptnrSub_15.end17+ptnrSub_15.end16+ptnrSub_15.end15+ptnrSub_15.end14+ptnrSub_15.end13+ptnrSub_15.end12+ptnrSub_15.end11+ptnrSub_15.end10+ptnrSub_15.end09+ptnrSub_15.end08+ptnrSub_15.end07+ptnrSub_15.end06+ptnrSub_15.end05+ptnrSub_15.end04+ptnrSub_15.end03+ptnrSub_15.end02+ptnrSub_15.end01}"/>
		            	
		            	<c:set var="sum1_15_RegTotal" value="${sum1_15_RegTotal+sub1_15_regSum}"></c:set>
		            	<c:set var="sum1_15_RegMiSum" value="${sum1_15_RegMiSum+ptnrSub_15.regMiSum}"></c:set>
		            	<c:set var="sum1_15_RegYearSum" value="${sum1_15_RegYearSum+ptnrSub_15.regYearSum}"></c:set>
		            	<c:set var="sum1_15_EndMonthSum" value="${sum1_15_EndMonthSum+ptnrSub_15.endMonthSum}"></c:set>
		            	<c:set var="sum1_15_EndYearSum" value="${sum1_15_EndYearSum+ptnrSub_15.endYearSum}"></c:set>
		            	<c:set var="sum1_15_Reg01" value="${sum1_15_Reg01+ptnrSub_15.reg01}"></c:set>
		            	<c:set var="sum1_15_Reg02" value="${sum1_15_Reg02+ptnrSub_15.reg02}"></c:set>
		            	<c:set var="sum1_15_Reg03" value="${sum1_15_Reg03+ptnrSub_15.reg03}"></c:set>
		            	<c:set var="sum1_15_Reg04" value="${sum1_15_Reg04+ptnrSub_15.reg04}"></c:set>
		            	<c:set var="sum1_15_Reg05" value="${sum1_15_Reg05+ptnrSub_15.reg05}"></c:set>
		            	<c:set var="sum1_15_Reg06" value="${sum1_15_Reg06+ptnrSub_15.reg06}"></c:set>
		            	<c:set var="sum1_15_Reg07" value="${sum1_15_Reg07+ptnrSub_15.reg07}"></c:set>
		            	<c:set var="sum1_15_Reg08" value="${sum1_15_Reg08+ptnrSub_15.reg08}"></c:set>
		            	<c:set var="sum1_15_Reg09" value="${sum1_15_Reg09+ptnrSub_15.reg09}"></c:set>
		            	<c:set var="sum1_15_Reg10" value="${sum1_15_Reg10+ptnrSub_15.reg10}"></c:set>		            	
		            	<c:set var="sum1_15_Reg11" value="${sum1_15_Reg11+ptnrSub_15.reg11}"></c:set>
		            	<c:set var="sum1_15_Reg12" value="${sum1_15_Reg12+ptnrSub_15.reg12}"></c:set>
		            	<c:set var="sum1_15_Reg13" value="${sum1_15_Reg13+ptnrSub_15.reg13}"></c:set>
		            	<c:set var="sum1_15_Reg14" value="${sum1_15_Reg14+ptnrSub_15.reg14}"></c:set>
		            	<c:set var="sum1_15_Reg15" value="${sum1_15_Reg15+ptnrSub_15.reg15}"></c:set>
		            	<c:set var="sum1_15_Reg16" value="${sum1_15_Reg16+ptnrSub_15.reg16}"></c:set>
		            	<c:set var="sum1_15_Reg17" value="${sum1_15_Reg17+ptnrSub_15.reg17}"></c:set>
		            	<c:set var="sum1_15_Reg18" value="${sum1_15_Reg18+ptnrSub_15.reg18}"></c:set>
		            	<c:set var="sum1_15_Reg19" value="${sum1_15_Reg19+ptnrSub_15.reg19}"></c:set>
		            	<c:set var="sum1_15_Reg20" value="${sum1_15_Reg20+ptnrSub_15.reg20}"></c:set>		            	
		            	<c:set var="sum1_15_Reg21" value="${sum1_15_Reg21+ptnrSub_15.reg11}"></c:set>
		            	<c:set var="sum1_15_Reg22" value="${sum1_15_Reg22+ptnrSub_15.reg22}"></c:set>
		            	<c:set var="sum1_15_Reg23" value="${sum1_15_Reg23+ptnrSub_15.reg23}"></c:set>
		            	<c:set var="sum1_15_Reg24" value="${sum1_15_Reg24+ptnrSub_15.reg24}"></c:set>
		            	<c:set var="sum1_15_Reg25" value="${sum1_15_Reg25+ptnrSub_15.reg25}"></c:set>
		            	<c:set var="sum1_15_Reg26" value="${sum1_15_Reg26+ptnrSub_15.reg26}"></c:set>
		            	<c:set var="sum1_15_Reg27" value="${sum1_15_Reg27+ptnrSub_15.reg27}"></c:set>
		            	<c:set var="sum1_15_Reg28" value="${sum1_15_Reg28+ptnrSub_15.reg28}"></c:set>
		            	<c:set var="sum1_15_Reg29" value="${sum1_15_Reg29+ptnrSub_15.reg29}"></c:set>
		            	<c:set var="sum1_15_Reg30" value="${sum1_15_Reg30+ptnrSub_15.reg30}"></c:set>
		            	
		            	<c:set var="sum1_15_EndTotal" value="${sum1_15_EndTotal+sub1_15_endSum}"></c:set>
		            	<c:set var="sum1_15_End01" value="${sum1_15_End01+ptnrSub_15.end01}"></c:set>
		            	<c:set var="sum1_15_End02" value="${sum1_15_End02+ptnrSub_15.end02}"></c:set>
		            	<c:set var="sum1_15_End03" value="${sum1_15_End03+ptnrSub_15.end03}"></c:set>
		            	<c:set var="sum1_15_End04" value="${sum1_15_End04+ptnrSub_15.end04}"></c:set>
		            	<c:set var="sum1_15_End05" value="${sum1_15_End05+ptnrSub_15.end05}"></c:set>
		            	<c:set var="sum1_15_End06" value="${sum1_15_End06+ptnrSub_15.end06}"></c:set>
		            	<c:set var="sum1_15_End07" value="${sum1_15_End07+ptnrSub_15.end07}"></c:set>
		            	<c:set var="sum1_15_End08" value="${sum1_15_End08+ptnrSub_15.end08}"></c:set>
		            	<c:set var="sum1_15_End09" value="${sum1_15_End09+ptnrSub_15.end09}"></c:set>
		            	<c:set var="sum1_15_End10" value="${sum1_15_End10+ptnrSub_15.end10}"></c:set>		            	
		            	<c:set var="sum1_15_End11" value="${sum1_15_End11+ptnrSub_15.end11}"></c:set>
		            	<c:set var="sum1_15_End12" value="${sum1_15_End12+ptnrSub_15.end12}"></c:set>
		            	<c:set var="sum1_15_End13" value="${sum1_15_End13+ptnrSub_15.end13}"></c:set>
		            	<c:set var="sum1_15_End14" value="${sum1_15_End14+ptnrSub_15.end14}"></c:set>
		            	<c:set var="sum1_15_End15" value="${sum1_15_End15+ptnrSub_15.end15}"></c:set>
		            	<c:set var="sum1_15_End16" value="${sum1_15_End16+ptnrSub_15.end16}"></c:set>
		            	<c:set var="sum1_15_End17" value="${sum1_15_End17+ptnrSub_15.end17}"></c:set>
		            	<c:set var="sum1_15_End18" value="${sum1_15_End18+ptnrSub_15.end18}"></c:set>
		            	<c:set var="sum1_15_End19" value="${sum1_15_End19+ptnrSub_15.end19}"></c:set>
		            	<c:set var="sum1_15_End20" value="${sum1_15_End20+ptnrSub_15.end20}"></c:set>		            	
		            	<c:set var="sum1_15_End21" value="${sum1_15_End21+ptnrSub_15.end11}"></c:set>
		            	<c:set var="sum1_15_End22" value="${sum1_15_End22+ptnrSub_15.end22}"></c:set>
		            	<c:set var="sum1_15_End23" value="${sum1_15_End23+ptnrSub_15.end23}"></c:set>
		            	<c:set var="sum1_15_End24" value="${sum1_15_End24+ptnrSub_15.end24}"></c:set>
		            	<c:set var="sum1_15_End25" value="${sum1_15_End25+ptnrSub_15.end25}"></c:set>
		            	<c:set var="sum1_15_End26" value="${sum1_15_End26+ptnrSub_15.end26}"></c:set>
		            	<c:set var="sum1_15_End27" value="${sum1_15_End27+ptnrSub_15.end27}"></c:set>
		            	<c:set var="sum1_15_End28" value="${sum1_15_End28+ptnrSub_15.end28}"></c:set>
		            	<c:set var="sum1_15_End29" value="${sum1_15_End29+ptnrSub_15.end29}"></c:set>
		            	<c:set var="sum1_15_End30" value="${sum1_15_End30+ptnrSub_15.end30}"></c:set>
		            	
		            	<c:set var="sumAll_15_RegTotal" value="${sumAll_15_RegTotal+sub1_15_regSum}"></c:set>
		            	<c:set var="sumAll_15_Reg01" value="${sumAll_15_Reg01+ptnrSub_15.reg01}"></c:set>
		            	<c:set var="sumAll_15_Reg02" value="${sumAll_15_Reg02+ptnrSub_15.reg02}"></c:set>
		            	<c:set var="sumAll_15_Reg03" value="${sumAll_15_Reg03+ptnrSub_15.reg03}"></c:set>
		            	<c:set var="sumAll_15_Reg04" value="${sumAll_15_Reg04+ptnrSub_15.reg04}"></c:set>
		            	<c:set var="sumAll_15_Reg05" value="${sumAll_15_Reg05+ptnrSub_15.reg05}"></c:set>
		            	<c:set var="sumAll_15_Reg06" value="${sumAll_15_Reg06+ptnrSub_15.reg06}"></c:set>
		            	<c:set var="sumAll_15_Reg07" value="${sumAll_15_Reg07+ptnrSub_15.reg07}"></c:set>
		            	<c:set var="sumAll_15_Reg08" value="${sumAll_15_Reg08+ptnrSub_15.reg08}"></c:set>
		            	<c:set var="sumAll_15_Reg09" value="${sumAll_15_Reg09+ptnrSub_15.reg09}"></c:set>
		            	<c:set var="sumAll_15_Reg10" value="${sumAll_15_Reg10+ptnrSub_15.reg10}"></c:set>		            	
		            	<c:set var="sumAll_15_Reg11" value="${sumAll_15_Reg11+ptnrSub_15.reg11}"></c:set>
		            	<c:set var="sumAll_15_Reg12" value="${sumAll_15_Reg12+ptnrSub_15.reg12}"></c:set>
		            	<c:set var="sumAll_15_Reg13" value="${sumAll_15_Reg13+ptnrSub_15.reg13}"></c:set>
		            	<c:set var="sumAll_15_Reg14" value="${sumAll_15_Reg14+ptnrSub_15.reg14}"></c:set>
		            	<c:set var="sumAll_15_Reg15" value="${sumAll_15_Reg15+ptnrSub_15.reg15}"></c:set>
		            	<c:set var="sumAll_15_Reg16" value="${sumAll_15_Reg16+ptnrSub_15.reg16}"></c:set>
		            	<c:set var="sumAll_15_Reg17" value="${sumAll_15_Reg17+ptnrSub_15.reg17}"></c:set>
		            	<c:set var="sumAll_15_Reg18" value="${sumAll_15_Reg18+ptnrSub_15.reg18}"></c:set>
		            	<c:set var="sumAll_15_Reg19" value="${sumAll_15_Reg19+ptnrSub_15.reg19}"></c:set>
		            	<c:set var="sumAll_15_Reg20" value="${sumAll_15_Reg20+ptnrSub_15.reg20}"></c:set>		            	
		            	<c:set var="sumAll_15_Reg21" value="${sumAll_15_Reg21+ptnrSub_15.reg11}"></c:set>
		            	<c:set var="sumAll_15_Reg22" value="${sumAll_15_Reg22+ptnrSub_15.reg22}"></c:set>
		            	<c:set var="sumAll_15_Reg23" value="${sumAll_15_Reg23+ptnrSub_15.reg23}"></c:set>
		            	<c:set var="sumAll_15_Reg24" value="${sumAll_15_Reg24+ptnrSub_15.reg24}"></c:set>
		            	<c:set var="sumAll_15_Reg25" value="${sumAll_15_Reg25+ptnrSub_15.reg25}"></c:set>
		            	<c:set var="sumAll_15_Reg26" value="${sumAll_15_Reg26+ptnrSub_15.reg26}"></c:set>
		            	<c:set var="sumAll_15_Reg27" value="${sumAll_15_Reg27+ptnrSub_15.reg27}"></c:set>
		            	<c:set var="sumAll_15_Reg28" value="${sumAll_15_Reg28+ptnrSub_15.reg28}"></c:set>
		            	<c:set var="sumAll_15_Reg29" value="${sumAll_15_Reg29+ptnrSub_15.reg29}"></c:set>
		            	<c:set var="sumAll_15_Reg30" value="${sumAll_15_Reg30+ptnrSub_15.reg30}"></c:set>
		            	
		            	<c:set var="sumAll_15_EndTotal" value="${sumAll_15_EndTotal+sub1_15_endSum}"></c:set>
		            	<c:set var="sumAll_15_End01" value="${sumAll_15_End01+ptnrSub_15.end01}"></c:set>
		            	<c:set var="sumAll_15_End02" value="${sumAll_15_End02+ptnrSub_15.end02}"></c:set>
		            	<c:set var="sumAll_15_End03" value="${sumAll_15_End03+ptnrSub_15.end03}"></c:set>
		            	<c:set var="sumAll_15_End04" value="${sumAll_15_End04+ptnrSub_15.end04}"></c:set>
		            	<c:set var="sumAll_15_End05" value="${sumAll_15_End05+ptnrSub_15.end05}"></c:set>
		            	<c:set var="sumAll_15_End06" value="${sumAll_15_End06+ptnrSub_15.end06}"></c:set>
		            	<c:set var="sumAll_15_End07" value="${sumAll_15_End07+ptnrSub_15.end07}"></c:set>
		            	<c:set var="sumAll_15_End08" value="${sumAll_15_End08+ptnrSub_15.end08}"></c:set>
		            	<c:set var="sumAll_15_End09" value="${sumAll_15_End09+ptnrSub_15.end09}"></c:set>
		            	<c:set var="sumAll_15_End10" value="${sumAll_15_End10+ptnrSub_15.end10}"></c:set>		            	
		            	<c:set var="sumAll_15_End11" value="${sumAll_15_End11+ptnrSub_15.end11}"></c:set>
		            	<c:set var="sumAll_15_End12" value="${sumAll_15_End12+ptnrSub_15.end12}"></c:set>
		            	<c:set var="sumAll_15_End13" value="${sumAll_15_End13+ptnrSub_15.end13}"></c:set>
		            	<c:set var="sumAll_15_End14" value="${sumAll_15_End14+ptnrSub_15.end14}"></c:set>
		            	<c:set var="sumAll_15_End15" value="${sumAll_15_End15+ptnrSub_15.end15}"></c:set>
		            	<c:set var="sumAll_15_End16" value="${sumAll_15_End16+ptnrSub_15.end16}"></c:set>
		            	<c:set var="sumAll_15_End17" value="${sumAll_15_End17+ptnrSub_15.end17}"></c:set>
		            	<c:set var="sumAll_15_End18" value="${sumAll_15_End18+ptnrSub_15.end18}"></c:set>
		            	<c:set var="sumAll_15_End19" value="${sumAll_15_End19+ptnrSub_15.end19}"></c:set>
		            	<c:set var="sumAll_15_End20" value="${sumAll_15_End20+ptnrSub_15.end20}"></c:set>		            	
		            	<c:set var="sumAll_15_End21" value="${sumAll_15_End21+ptnrSub_15.end11}"></c:set>
		            	<c:set var="sumAll_15_End22" value="${sumAll_15_End22+ptnrSub_15.end22}"></c:set>
		            	<c:set var="sumAll_15_End23" value="${sumAll_15_End23+ptnrSub_15.end23}"></c:set>
		            	<c:set var="sumAll_15_End24" value="${sumAll_15_End24+ptnrSub_15.end24}"></c:set>
		            	<c:set var="sumAll_15_End25" value="${sumAll_15_End25+ptnrSub_15.end25}"></c:set>
		            	<c:set var="sumAll_15_End26" value="${sumAll_15_End26+ptnrSub_15.end26}"></c:set>
		            	<c:set var="sumAll_15_End27" value="${sumAll_15_End27+ptnrSub_15.end27}"></c:set>
		            	<c:set var="sumAll_15_End28" value="${sumAll_15_End28+ptnrSub_15.end28}"></c:set>
		            	<c:set var="sumAll_15_End29" value="${sumAll_15_End29+ptnrSub_15.end29}"></c:set>
		            	<c:set var="sumAll_15_End30" value="${sumAll_15_End30+ptnrSub_15.end30}"></c:set>
		            	
		            	<c:set var="sumAll_15_RegMiSum" value="${sumAll_15_RegMiSum+ptnrSub_15.regMiSum}"></c:set>
		            	<c:set var="sumAll_15_RegYearSum" value="${sumAll_15_RegYearSum+ptnrSub_15.regYearSum}"></c:set>
		            	<c:set var="sumAll_15_EndMonthSum" value="${sumAll_15_EndMonthSum+ptnrSub_15.endMonthSum}"></c:set>
		            	<c:set var="sumAll_15_EndYearSum" value="${sumAll_15_EndYearSum+ptnrSub_15.endYearSum}"></c:set>
		            			            			            		            		            	
		            	<%-- <tr style="bgcolor: #E7ECF1; text-align: center; cursor:pointer;" onclick="openPtnrByCenterModal('${ptnrSub_15.ptnrId}','${ptnrSub_15.ptnrNick}');" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"> --%>		            	
		            	<tr>
		            		<c:if test="${status.index == 0}">	
		            			<td rowspan="${leftRow_15}">1종 기타</td>
		            		</c:if>		            				            				            				            		
		            		<c:choose>
		            			<c:when test="${ptnrSub_15.rowCnt == 1 or empty ptnrSub_15.rowCnt}">
		            				<c:set var="rowIdx" value="1"/>		            				
		            				<td colspan="2" style="border-right: 1px solid #b9b9b9 !important;">
		            					${ptnrSub_15.ptnrNick}
		            				</td>
		            			</c:when>
		            			<c:otherwise>		            						            				
		            				<c:if test="${rowIdx == 1 }">		            					
		            					<td rowspan="${ptnrSub_15.rowCnt+1}">
						            		${ptnrSub_15.ptnrNick}
						            	</td>	
		            				</c:if>
					            	<td style="border-right: 1px solid #b9b9b9 !important;">
					            		${ptnrSub_15.ptnrIdSubName}					            		
					            	</td>					            						            	
		            			</c:otherwise>
		            		</c:choose>		   
		            		<td style="text-align:center;border-right: 1px solid #b9b9b9">
		            			<p>수임</p>
		            			<p class="sub-p">종결</p>
		            		</td>         		
		            		<td class="border-right" bgcolor="#faebd7">
		            			<p>${sub1_15_regSum}</p><p class="sub-p">${sub1_15_endSum}</p>		            					            			
		            		</td>
		            		<!-- 미결 -->
		            		<td class="border-right" bgcolor="#faebd7">
		            			<p>${ptnrSub_15.regMiSum}</p>
		            		</td>
		            		<!-- 연간수임 -->
		            		<td class="border-right" bgcolor="#faebd7">
		            			<p>${ptnrSub_15.regYearSum}</p>
		            		</td>
		            		<!-- 당월종결 -->
		            		<td class="border-right" bgcolor="#faebd7">
		            			<p>${ptnrSub_15.endMonthSum}</p>
		            		</td>		            		
		            		<!-- 연간종결 -->
		            		<td class="border-right" bgcolor="#faebd7">
		            			<p>${ptnrSub_15.endYearSum}</p>
		            		</td>
		            		
		            		<td class="border-right">
		            			<p>${ptnrSub_15.reg01}</p><p class="sub-p">${ptnrSub_15.end01}</p>		            			
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_15.reg02}</p><p class="sub-p">${ptnrSub_15.end02}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_15.reg03}</p><p class="sub-p">${ptnrSub_15.end03}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_15.reg04}</p><p class="sub-p">${ptnrSub_15.end04}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_15.reg05}</p><p class="sub-p">${ptnrSub_15.end05}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_15.reg06}</p><p class="sub-p">${ptnrSub_15.end06}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_15.reg07}</p><p class="sub-p">${ptnrSub_15.end07}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_15.reg08}</p><p class="sub-p">${ptnrSub_15.end08}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_15.reg09}</p><p class="sub-p">${ptnrSub_15.end09}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_15.reg10}</p><p class="sub-p">${ptnrSub_15.end10}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_15.reg11}</p><p class="sub-p">${ptnrSub_15.end11}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_15.reg12}</p><p class="sub-p">${ptnrSub_15.end12}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_15.reg13}</p><p class="sub-p">${ptnrSub_15.end13}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_15.reg14}</p><p class="sub-p">${ptnrSub_15.end14}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_15.reg15}</p><p class="sub-p">${ptnrSub_15.end15}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_15.reg16}</p><p class="sub-p">${ptnrSub_15.end16}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_15.reg17}</p><p class="sub-p">${ptnrSub_15.end17}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_15.reg18}</p><p class="sub-p">${ptnrSub_15.end18}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_15.reg19}</p><p class="sub-p">${ptnrSub_15.end19}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_15.reg20}</p><p class="sub-p">${ptnrSub_15.end20}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_15.reg21}</p><p class="sub-p">${ptnrSub_15.end21}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_15.reg22}</p><p class="sub-p">${ptnrSub_15.end22}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_15.reg23}</p><p class="sub-p">${ptnrSub_15.end23}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_15.reg24}</p><p class="sub-p">${ptnrSub_15.end24}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_15.reg25}</p><p class="sub-p">${ptnrSub_15.end25}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_15.reg26}</p><p class="sub-p">${ptnrSub_15.end26}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_15.reg27}</p><p class="sub-p">${ptnrSub_15.end27}</p>
		            		</td>		            		
		            		<td class="border-right">
		            			<p>${ptnrSub_15.reg28}</p><p class="sub-p">${ptnrSub_15.end28}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_15.reg29}</p><p class="sub-p">${ptnrSub_15.end29}</p>
		            		</td>
		            		<td class="border-right">
		            			<p>${ptnrSub_15.reg30}</p><p class="sub-p">${ptnrSub_15.end30}</p>
		            		</td>		            		
		            	</tr>
		            	<!-- 보험사 소계 시작 -->		            	
		            	<c:choose>
		            		<c:when test="${ptnrSub_15.rowCnt == rowIdx}">		            			
		            			<c:if test="${ptnrSub_15.rowCnt > 1}">
		            				<tr>
			            				<th style="border-right: 1px solid #b9b9b9 !important;" colspan="2">소계</th>
			            				<th style="border-right: 1px solid #b9b9b9 !important;">
			            					<p>${sum1_15_RegTotal}</p><p class="sub-p">${sum1_15_EndTotal}</p>			            					
			            				</th>
			            				<th style="border-right: 1px solid #b9b9b9 !important;">
			            					<p>${sum1_15_RegMiSum}</p>			            					
			            				</th>
			            				<th style="border-right: 1px solid #b9b9b9 !important;">
			            					<p>${sum1_15_RegYearSum}</p>			            					
			            				</th>
			            				<th style="border-right: 1px solid #b9b9b9 !important;">
			            					<p>${sum1_15_EndMonthSum}</p>			            					
			            				</th>
			            				<th style="border-right: 1px solid #b9b9b9 !important;">
			            					<p>${sum1_15_EndYearSum}</p>			            					
			            				</th>			            				
			            				<th><p>${sum1_15_Reg01}</p><p class="sub-p">${sum1_15_End01}</p></th>
			            				<th><p>${sum1_15_Reg02}</p><p class="sub-p">${sum1_15_End02}</p></th>
			            				<th><p>${sum1_15_Reg03}</p><p class="sub-p">${sum1_15_End03}</p></th>
			            				<th><p>${sum1_15_Reg04}</p><p class="sub-p">${sum1_15_End04}</p></th>
			            				<th><p>${sum1_15_Reg05}</p><p class="sub-p">${sum1_15_End05}</p></th>
			            				<th><p>${sum1_15_Reg06}</p><p class="sub-p">${sum1_15_End06}</p></th>
			            				<th><p>${sum1_15_Reg07}</p><p class="sub-p">${sum1_15_End07}</p></th>
			            				<th><p>${sum1_15_Reg08}</p><p class="sub-p">${sum1_15_End08}</p></th>
			            				<th><p>${sum1_15_Reg09}</p><p class="sub-p">${sum1_15_End09}</p></th>
			            				<th><p>${sum1_15_Reg10}</p><p class="sub-p">${sum1_15_End10}</p></th>
			            				<th><p>${sum1_15_Reg11}</p><p class="sub-p">${sum1_15_End11}</p></th>
			            				<th><p>${sum1_15_Reg12}</p><p class="sub-p">${sum1_15_End12}</p></th>
			            				<th><p>${sum1_15_Reg13}</p><p class="sub-p">${sum1_15_End13}</p></th>
			            				<th><p>${sum1_15_Reg14}</p><p class="sub-p">${sum1_15_End14}</p></th>
			            				<th><p>${sum1_15_Reg15}</p><p class="sub-p">${sum1_15_End15}</p></th>
			            				<th><p>${sum1_15_Reg16}</p><p class="sub-p">${sum1_15_End16}</p></th>
			            				<th><p>${sum1_15_Reg17}</p><p class="sub-p">${sum1_15_End17}</p></th>
			            				<th><p>${sum1_15_Reg18}</p><p class="sub-p">${sum1_15_End18}</p></th>
			            				<th><p>${sum1_15_Reg19}</p><p class="sub-p">${sum1_15_End19}</p></th>
			            				<th><p>${sum1_15_Reg20}</p><p class="sub-p">${sum1_15_End20}</p></th>			            				
			            				<th><p>${sum1_15_Reg21}</p><p class="sub-p">${sum1_15_End21}</p></th>
			            				<th><p>${sum1_15_Reg22}</p><p class="sub-p">${sum1_15_End22}</p></th>
			            				<th><p>${sum1_15_Reg23}</p><p class="sub-p">${sum1_15_End23}</p></th>
			            				<th><p>${sum1_15_Reg24}</p><p class="sub-p">${sum1_15_End24}</p></th>
			            				<th><p>${sum1_15_Reg25}</p><p class="sub-p">${sum1_15_End25}</p></th>
			            				<th><p>${sum1_15_Reg26}</p><p class="sub-p">${sum1_15_End26}</p></th>
			            				<th><p>${sum1_15_Reg27}</p><p class="sub-p">${sum1_15_End27}</p></th>
			            				<th><p>${sum1_15_Reg28}</p><p class="sub-p">${sum1_15_End28}</p></th>
			            				<th><p>${sum1_15_Reg29}</p><p class="sub-p">${sum1_15_End29}</p></th>
			            				<th style="border-right: 1px solid #b9b9b9"><p>${sum1_15_Reg30}</p><p class="sub-p">${sum1_15_End30}</p></th>			            				
			            			</tr>
		            			</c:if>
		            			<!-- 소계 계산후 초기화 -->		            			
		            			<c:set var="rowIdx" value="1"/>
		            			<c:set var="sum1_15_RegTotal" value="0" />		            			
		            			<c:set var="sum1_15_RegMiSum" value="0" />
		            			<c:set var="sum1_15_RegYearSum" value="0" />
		            			<c:set var="sum1_15_EndYearSum" value="0" />
		            			<c:set var="sum1_15_EndMonthSum" value="0" />
		            			<c:set var="sum1_15_EndYearSum" value="0" />
		            			<c:set var="sum1_15_Reg01" value="0" />
		            			<c:set var="sum1_15_Reg02" value="0" />
		            			<c:set var="sum1_15_Reg03" value="0" />
		            			<c:set var="sum1_15_Reg04" value="0" />
		            			<c:set var="sum1_15_Reg05" value="0" />
		            			<c:set var="sum1_15_Reg06" value="0" />
		            			<c:set var="sum1_15_Reg07" value="0" />
		            			<c:set var="sum1_15_Reg08" value="0" />
		            			<c:set var="sum1_15_Reg09" value="0" />
		            			<c:set var="sum1_15_Reg10" value="0" />
		            			<c:set var="sum1_15_Reg11" value="0" />
		            			<c:set var="sum1_15_Reg12" value="0" />
		            			<c:set var="sum1_15_Reg13" value="0" />
		            			<c:set var="sum1_15_Reg14" value="0" />
		            			<c:set var="sum1_15_Reg15" value="0" />
		            			<c:set var="sum1_15_Reg16" value="0" />
		            			<c:set var="sum1_15_Reg17" value="0" />
		            			<c:set var="sum1_15_Reg18" value="0" />
		            			<c:set var="sum1_15_Reg19" value="0" />
		            			<c:set var="sum1_15_Reg20" value="0" />
		            			<c:set var="sum1_15_Reg21" value="0" />
		            			<c:set var="sum1_15_Reg22" value="0" />
		            			<c:set var="sum1_15_Reg23" value="0" />
		            			<c:set var="sum1_15_Reg24" value="0" />
		            			<c:set var="sum1_15_Reg25" value="0" />
		            			<c:set var="sum1_15_Reg26" value="0" />
		            			<c:set var="sum1_15_Reg27" value="0" />
		            			<c:set var="sum1_15_Reg28" value="0" />
		            			<c:set var="sum1_15_Reg29" value="0" />
		            			<c:set var="sum1_15_Reg30" value="0" />
		            			
		            			<c:set var="sum1_15_EndTotal" value="0" />
		            			<c:set var="sum1_15_End01" value="0" />
		            			<c:set var="sum1_15_End02" value="0" />
		            			<c:set var="sum1_15_End03" value="0" />
		            			<c:set var="sum1_15_End04" value="0" />
		            			<c:set var="sum1_15_End05" value="0" />
		            			<c:set var="sum1_15_End06" value="0" />
		            			<c:set var="sum1_15_End07" value="0" />
		            			<c:set var="sum1_15_End08" value="0" />
		            			<c:set var="sum1_15_End09" value="0" />
		            			<c:set var="sum1_15_End10" value="0" />
		            			<c:set var="sum1_15_End11" value="0" />
		            			<c:set var="sum1_15_End12" value="0" />
		            			<c:set var="sum1_15_End13" value="0" />
		            			<c:set var="sum1_15_End14" value="0" />
		            			<c:set var="sum1_15_End15" value="0" />
		            			<c:set var="sum1_15_End16" value="0" />
		            			<c:set var="sum1_15_End17" value="0" />
		            			<c:set var="sum1_15_End18" value="0" />
		            			<c:set var="sum1_15_End19" value="0" />
		            			<c:set var="sum1_15_End20" value="0" />
		            			<c:set var="sum1_15_End21" value="0" />
		            			<c:set var="sum1_15_End22" value="0" />
		            			<c:set var="sum1_15_End23" value="0" />
		            			<c:set var="sum1_15_End24" value="0" />
		            			<c:set var="sum1_15_End25" value="0" />
		            			<c:set var="sum1_15_End26" value="0" />
		            			<c:set var="sum1_15_End27" value="0" />
		            			<c:set var="sum1_15_End28" value="0" />
		            			<c:set var="sum1_15_End29" value="0" />
		            			<c:set var="sum1_15_End30" value="0" />		            			
		            		</c:when>
		            		<c:otherwise>
		            			<c:set var="rowIdx" value="${rowIdx+1}"/>
		            		</c:otherwise>
		            	</c:choose>
		            	<!-- 보험사 소계 끝 -->
		            </c:forEach>
		            <!-- 전체 합계 시작 -->
			            <tr>
			            	<th colspan="4" class="border-right">1종 기타 합계</th>		            	
			            	<th class="border-right" bgcolor="#faebd7">
		            			<p>${sumAll_15_RegTotal}</p><p class="sub-p">${sumAll_15_EndTotal}</p>
			            	</th>
			            	<!-- 미결 -->
			            	<th class="border-right" bgcolor="#faebd7">
		            			<p>${sumAll_15_RegMiSum}</p>
			            	</th>
			            	<!-- 연간수임 -->
			            	<th class="border-right" bgcolor="#faebd7">
		            			<p>${sumAll_15_RegYearSum}</p>
			            	</th>
			            	<!-- 당월종결 -->
			            	<th class="border-right" bgcolor="#faebd7">
		            			<p>${sumAll_15_EndMonthSum}</p>
			            	</th>
			            	<!-- 연간종결 -->
			            	<th class="border-right" bgcolor="#faebd7">
		            			<p>${sumAll_15_EndYearSum}</p>
			            	</th>
			            	<th><p>${sumAll_15_Reg01}</p><p class="sub-p">${sumAll_15_End01}</p></th>
	           				<th><p>${sumAll_15_Reg02}</p><p class="sub-p">${sumAll_15_End02}</p></th>
	           				<th><p>${sumAll_15_Reg03}</p><p class="sub-p">${sumAll_15_End03}</p></th>
	           				<th><p>${sumAll_15_Reg04}</p><p class="sub-p">${sumAll_15_End04}</p></th>
	           				<th><p>${sumAll_15_Reg05}</p><p class="sub-p">${sumAll_15_End05}</p></th>
	           				<th><p>${sumAll_15_Reg06}</p><p class="sub-p">${sumAll_15_End06}</p></th>
	           				<th><p>${sumAll_15_Reg07}</p><p class="sub-p">${sumAll_15_End07}</p></th>
	           				<th><p>${sumAll_15_Reg08}</p><p class="sub-p">${sumAll_15_End08}</p></th>
	           				<th><p>${sumAll_15_Reg09}</p><p class="sub-p">${sumAll_15_End09}</p></th>
	           				<th><p>${sumAll_15_Reg10}</p><p class="sub-p">${sumAll_15_End10}</p></th>
	           				<th><p>${sumAll_15_Reg11}</p><p class="sub-p">${sumAll_15_End11}</p></th>
	           				<th><p>${sumAll_15_Reg12}</p><p class="sub-p">${sumAll_15_End12}</p></th>
	           				<th><p>${sumAll_15_Reg13}</p><p class="sub-p">${sumAll_15_End13}</p></th>
	           				<th><p>${sumAll_15_Reg14}</p><p class="sub-p">${sumAll_15_End14}</p></th>
	           				<th><p>${sumAll_15_Reg15}</p><p class="sub-p">${sumAll_15_End15}</p></th>
	           				<th><p>${sumAll_15_Reg16}</p><p class="sub-p">${sumAll_15_End16}</p></th>
	           				<th><p>${sumAll_15_Reg17}</p><p class="sub-p">${sumAll_15_End17}</p></th>
	           				<th><p>${sumAll_15_Reg18}</p><p class="sub-p">${sumAll_15_End18}</p></th>
	           				<th><p>${sumAll_15_Reg19}</p><p class="sub-p">${sumAll_15_End19}</p></th>
	           				<th><p>${sumAll_15_Reg20}</p><p class="sub-p">${sumAll_15_End20}</p></th>
	           				<th><p>${sumAll_15_Reg21}</p><p class="sub-p">${sumAll_15_End21}</p></th>
	           				<th><p>${sumAll_15_Reg22}</p><p class="sub-p">${sumAll_15_End22}</p></th>
	           				<th><p>${sumAll_15_Reg23}</p><p class="sub-p">${sumAll_15_End23}</p></th>
	           				<th><p>${sumAll_15_Reg24}</p><p class="sub-p">${sumAll_15_End24}</p></th>
	           				<th><p>${sumAll_15_Reg25}</p><p class="sub-p">${sumAll_15_End25}</p></th>
	           				<th><p>${sumAll_15_Reg26}</p><p class="sub-p">${sumAll_15_End26}</p></th>
	           				<th><p>${sumAll_15_Reg27}</p><p class="sub-p">${sumAll_15_End27}</p></th>
	           				<th><p>${sumAll_15_Reg28}</p><p class="sub-p">${sumAll_15_End28}</p></th>
	           				<th><p>${sumAll_15_Reg29}</p><p class="sub-p">${sumAll_15_End29}</p></th>
	           				<th style="border-right: 1px solid #b9b9b9"><p>${sumAll_15_Reg30}</p><p class="sub-p">${sumAll_15_End30}</p></th>
			            </tr>
		            </tbody>
		        </table>
		    <!-- 1종 기타 끝 -->		    
			</div>
			<!-- 전체 합계 시작 -->
			<div style="padding-right: 17px;background: #e7ecf1;">
		        <table cellpadding="0" cellspacing="0" width="1060" align="center">
		            <colgroup>
		            	<col width="309">
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
		            	<th class="border-right" style="color:blue;">전체합계</th>
		                <th class="border-right" style="color:blue;"><p>${sumAllRegTotal + sumAll_10_RegTotal + sumAll_15_RegTotal}</p><p class="sub-p">${sumAllEndTotal + sumAll_10_EndTotal + sumAll_15_EndTotal}</p></th>
		                <th class="border-right" style="color:blue;">${sumAllRegMiSum + sumAll_10_RegMiSum +sumAll_15_RegMiSum}</th>
		                <th class="border-right" style="color:blue;">${sumAllRegYearSum + sumAll_10_RegYearSum + sumAll_15_RegYearSum}</th>
		                <th class="border-right" style="color:blue;">${sumAllEndMonthSum + sumAll_10_EndMonthSum + sumAll_15_EndMonthSum}</th>
		                <th class="border-right" style="color:blue;">${sumAllEndYearSum + sumAll_10_EndYearSum + sumAll_15_EndYearSum}</th>
		                <th style="color:blue;"><p>${sumAllReg01 + sumAll_10_Reg01 + sumAll_15_Reg01}</p><p class="sub-p">${sumAllEnd01 + sumAll_10_End01 + sumAll_15_End01}</p></th>
						<th style="color:blue;"><p>${sumAllReg02 + sumAll_10_Reg02 + sumAll_15_Reg02}</p><p class="sub-p">${sumAllEnd02 + sumAll_10_End02 + sumAll_15_End02}</p></th>
						<th style="color:blue;"><p>${sumAllReg03 + sumAll_10_Reg03 + sumAll_15_Reg03}</p><p class="sub-p">${sumAllEnd03 + sumAll_10_End03 + sumAll_15_End03}</p></th>
						<th style="color:blue;"><p>${sumAllReg04 + sumAll_10_Reg04 + sumAll_15_Reg04}</p><p class="sub-p">${sumAllEnd04 + sumAll_10_End04 + sumAll_15_End04}</p></th>
						<th style="color:blue;"><p>${sumAllReg05 + sumAll_10_Reg05 + sumAll_15_Reg05}</p><p class="sub-p">${sumAllEnd05 + sumAll_10_End05 + sumAll_15_End05}</p></th>
						<th style="color:blue;"><p>${sumAllReg06 + sumAll_10_Reg06 + sumAll_15_Reg06}</p><p class="sub-p">${sumAllEnd06 + sumAll_10_End06 + sumAll_15_End06}</p></th>
						<th style="color:blue;"><p>${sumAllReg07 + sumAll_10_Reg07 + sumAll_15_Reg07}</p><p class="sub-p">${sumAllEnd07 + sumAll_10_End07 + sumAll_15_End07}</p></th>
						<th style="color:blue;"><p>${sumAllReg08 + sumAll_10_Reg08 + sumAll_15_Reg08}</p><p class="sub-p">${sumAllEnd08 + sumAll_10_End08 + sumAll_15_End08}</p></th>
						<th style="color:blue;"><p>${sumAllReg09 + sumAll_10_Reg09 + sumAll_15_Reg09}</p><p class="sub-p">${sumAllEnd09 + sumAll_10_End09 + sumAll_15_End09}</p></th>
						<th style="color:blue;"><p>${sumAllReg10 + sumAll_10_Reg10 + sumAll_15_Reg10}</p><p class="sub-p">${sumAllEnd10 + sumAll_10_End10 + sumAll_15_End10}</p></th>
						<th style="color:blue;"><p>${sumAllReg11 + sumAll_10_Reg11 + sumAll_15_Reg11}</p><p class="sub-p">${sumAllEnd11 + sumAll_10_End11 + sumAll_15_End11}</p></th>
						<th style="color:blue;"><p>${sumAllReg12 + sumAll_10_Reg12 + sumAll_15_Reg12}</p><p class="sub-p">${sumAllEnd12 + sumAll_10_End12 + sumAll_15_End12}</p></th>
						<th style="color:blue;"><p>${sumAllReg13 + sumAll_10_Reg13 + sumAll_15_Reg13}</p><p class="sub-p">${sumAllEnd13 + sumAll_10_End13 + sumAll_15_End13}</p></th>
						<th style="color:blue;"><p>${sumAllReg14 + sumAll_10_Reg14 + sumAll_15_Reg14}</p><p class="sub-p">${sumAllEnd14 + sumAll_10_End14 + sumAll_15_End14}</p></th>
						<th style="color:blue;"><p>${sumAllReg15 + sumAll_10_Reg15 + sumAll_15_Reg15}</p><p class="sub-p">${sumAllEnd15 + sumAll_10_End15 + sumAll_15_End15}</p></th>
						<th style="color:blue;"><p>${sumAllReg16 + sumAll_10_Reg16 + sumAll_15_Reg16}</p><p class="sub-p">${sumAllEnd16 + sumAll_10_End16 + sumAll_15_End16}</p></th>
						<th style="color:blue;"><p>${sumAllReg17 + sumAll_10_Reg17 + sumAll_15_Reg17}</p><p class="sub-p">${sumAllEnd17 + sumAll_10_End17 + sumAll_15_End17}</p></th>
						<th style="color:blue;"><p>${sumAllReg18 + sumAll_10_Reg18 + sumAll_15_Reg18}</p><p class="sub-p">${sumAllEnd18 + sumAll_10_End18 + sumAll_15_End18}</p></th>
						<th style="color:blue;"><p>${sumAllReg19 + sumAll_10_Reg19 + sumAll_15_Reg19}</p><p class="sub-p">${sumAllEnd19 + sumAll_10_End19 + sumAll_15_End19}</p></th>
						<th style="color:blue;"><p>${sumAllReg20 + sumAll_10_Reg20 + sumAll_15_Reg20}</p><p class="sub-p">${sumAllEnd20 + sumAll_10_End20 + sumAll_15_End20}</p></th>
						<th style="color:blue;"><p>${sumAllReg21 + sumAll_10_Reg21 + sumAll_15_Reg21}</p><p class="sub-p">${sumAllEnd21 + sumAll_10_End21 + sumAll_15_End21}</p></th>
						<th style="color:blue;"><p>${sumAllReg22 + sumAll_10_Reg22 + sumAll_15_Reg22}</p><p class="sub-p">${sumAllEnd22 + sumAll_10_End22 + sumAll_15_End22}</p></th>
						<th style="color:blue;"><p>${sumAllReg23 + sumAll_10_Reg23 + sumAll_15_Reg23}</p><p class="sub-p">${sumAllEnd23 + sumAll_10_End23 + sumAll_15_End23}</p></th>
						<th style="color:blue;"><p>${sumAllReg24 + sumAll_10_Reg24 + sumAll_15_Reg24}</p><p class="sub-p">${sumAllEnd24 + sumAll_10_End24 + sumAll_15_End24}</p></th>
						<th style="color:blue;"><p>${sumAllReg25 + sumAll_10_Reg25 + sumAll_15_Reg25}</p><p class="sub-p">${sumAllEnd25 + sumAll_10_End25 + sumAll_15_End25}</p></th>
						<th style="color:blue;"><p>${sumAllReg26 + sumAll_10_Reg26 + sumAll_15_Reg26}</p><p class="sub-p">${sumAllEnd26 + sumAll_10_End26 + sumAll_15_End26}</p></th>
						<th style="color:blue;"><p>${sumAllReg27 + sumAll_10_Reg27 + sumAll_15_Reg27}</p><p class="sub-p">${sumAllEnd27 + sumAll_10_End27 + sumAll_15_End27}</p></th>
						<th style="color:blue;"><p>${sumAllReg28 + sumAll_10_Reg28 + sumAll_15_Reg28}</p><p class="sub-p">${sumAllEnd28 + sumAll_10_End28 + sumAll_15_End28}</p></th>
						<th style="color:blue;"><p>${sumAllReg29 + sumAll_10_Reg29 + sumAll_15_Reg29}</p><p class="sub-p">${sumAllEnd29 + sumAll_10_End29 + sumAll_15_End29}</p></th>
		                <th style="border-right: 1px solid #b9b9b9;color:blue;"><p>${sumAllReg30 + sumAll_10_Reg30 + sumAll_15_Reg30}</p><p class="sub-p">${sumAllEnd30 + sumAll_10_End30 + sumAll_15_End30}</p></th>		                		                		                
		            </tr>
		            </thead>
		        </table>
			</div>
			<!-- 전체 합계 끝 -->
		</div>
	</div>