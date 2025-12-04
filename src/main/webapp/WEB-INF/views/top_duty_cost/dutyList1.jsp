<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- <link rel="stylesheet" href="./resources/font-awesome/css/font-awesome.min.css"/> -->
<script defer src="./resources/fontawesome_5.0/svg-with-js/js/fontawesome-all.js"></script>



<div class="tableStyle2">
	<table>
		<colgroup>
			<col style="width: 10%">
			<col style="width: 90%">
		</colgroup>
		<tr>
			<th>당직일자</th>
			<th>당직자</th>
		</tr>
		<c:forEach  var="item" items="${list}" varStatus="status">
		<tr>	
<%-- 			<td>${fn:substring(item.caDe,0,4)}-${fn:substring(item.caDe,4,6)}-${fn:substring(item.caDe,6,8)}</td> *JSTL 날짜 자르기--%>					
			<td>${item.caDe}</td> <!-- 날짜를 뿌린다. -->
			<td style="text-align: left; padding: 0px 5px;	">
				<c:set var="infoList" value="${fn:split(item.userInfo,',')}" /> <!-- userInfo를 , 를 기준으로 나눠 배열로 담는다 -->
				<c:forEach var="Litem" items="${infoList}" varStatus="status"> <!-- 배열을 돌면서 리스트아이템에 접근을 한다 -->
					<c:set var="Sitem" value="${fn:split(Litem,'-')}" /> <!-- -를 기준으로 나눠 배열로 담는다 -->
<%-- 					${Sitem[0]}1<br> 당직코드
					${Sitem[1]}<br> 팀코드
					${Sitem[2]}<br> 사원번호
					${Sitem[3]}<br> 보험사 아이디
					${Sitem[4]}<br> 당직구문
					${Sitem[5]}<br> 이름
					${Sitem[6]}<br> 팀이름
					${Sitem[7]}<br> 당직상태 --%>
					
					<c:set var="locGubun" value="" />
					<c:choose>
						<c:when test="${mbrAuthVo_Session.mbr_pms_23 == 1  && mbrVo_Session.user_no != Sitem[2] && Sitem[7] != '30'}">					
							<c:set var="locGubun" value="href='#' onclick=fnEdit();fnEditDataCall('${Sitem[0]}')" />
						</c:when>
						<c:when test="${ (mbrAuthVo_Session.mbr_pms_22 == 1 && Sitem[7] != '30') or (mbrVo_Session.user_no == Sitem[2] && Sitem[7] == '0' || Sitem[7] == '10') }">
							<c:set var="locGubun" value="href='/dutyCostRegister?dutyId=${Sitem[0]}'" />
						</c:when>
						<c:otherwise>
							<c:set var="locGubun" value="href='#'" />
						</c:otherwise>
					</c:choose>						
					<a ${locGubun}>
			  		<c:choose>
			  			<c:when test="${Sitem[4] == '1' || Sitem[4] == '2'}">
			  				<c:choose>
			  					<c:when test="${Sitem[7] == '30'}">
					  				<i style="color:red" class="fa fa-phone"></i>					  					
			  					</c:when>
			  					<c:when test="${Sitem[7] == '20'}">
					  				<i style="color:green" class="fa fa-phone"></i>
					  				<!-- <img alt="전화" src="/resources/ls_img/tel_img.png"> -->						  					
			  					</c:when>
			  					<c:when test="${Sitem[7] == '10'}">
					  				<i style="color:blue" class="fa fa-phone"></i>
					  				<!-- <img alt="전화" src="/resources/ls_img/tel_img.png"> -->						  					
			  					</c:when>						  					
			  					<c:otherwise>
			  						<i class="fa fa-phone"></i>
			  					</c:otherwise>
			  				</c:choose>						  									  				
				  										  						  				
			  			</c:when>
			  			<c:when test="${Sitem[4] == '3' || Sitem[4] == '4' || Sitem[4] == '5'}">
			  				<c:choose>
			  					<c:when test="${Sitem[7] == '30'}">
					  				<i style="color:red" class="fa fa-phone"></i>					  					
			  					</c:when>
			  					<c:when test="${Sitem[7] == '20'}">
					  				<i style="color:green" class="fa fa-car"></i>
					  				<!-- <img alt="전화" src="/resources/ls_img/tel_img.png"> -->						  					
			  					</c:when>
			  					<c:when test="${Sitem[7] == '10'}">
					  				<i style="color:blue" class="fa fa-car"></i>
					  				<!-- <img alt="전화" src="/resources/ls_img/tel_img.png"> -->						  					
			  					</c:when>						  					
			  					<c:otherwise>
			  						<i class="fa fa-car"></i>
			  					</c:otherwise>
			  				</c:choose>	
			  				<!-- <img alt="출동" src="/resources/ls_img/car_img.png"> -->
			  			</c:when>
			  		</c:choose>
						  		
			  		<c:choose>
			  			<c:when test="${Sitem[7] == '30'}">
			  				<span style="color:red">${Sitem[6]} ${Sitem[5]}</span>
			  			</c:when>	
			  			<c:when test="${Sitem[7] == '20'}">
			  				<span style="color:green">${Sitem[6]} ${Sitem[5]}</span>
			  			</c:when>						  			
			  			<c:when test="${Sitem[7] == '10'}">
			  				<span style="color:blue">${Sitem[6]} ${Sitem[5]}</span>
			  			</c:when>							  				
			  			<c:otherwise>
			  				${Sitem[6]} ${Sitem[5]}
			  			</c:otherwise>
			  		</c:choose> 
				  	</a> &nbsp;&nbsp;
<%-- 						  		${Sitem[6]} ${Sitem[5]} --%>
						 
				</c:forEach>
				<%-- <a href="/dutyCostRegister">${item.userInfo}</a> --%>
				<%-- <a href="/dutyCostRegister">*출동대기*${i.teamId}${i.userNo}</a> --%>
			</td>					
		</tr>
		</c:forEach>	
		
	</table>
</div>
