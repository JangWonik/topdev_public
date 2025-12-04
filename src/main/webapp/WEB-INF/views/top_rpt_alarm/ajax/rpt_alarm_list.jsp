<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:choose>
	<c:when test="${alarmList.size() > 0}">
	
		<c:forEach items="${alarmList}" var="alarmList" varStatus="alarmListStatus">
			<tr id="spdAlarmList" <c:if test="${alarmList.alarmState eq '1'}">style="background-color: #ffc3c3;"</c:if> >
				<td colspan="2" style="letter-spacing: 0">
					${alarmList.alarmDateFormat}
					<c:if test="${alarmList.serialNo eq maxSerialNo}">
						<img src="./resources/ls_img/p_new.gif">
					</c:if>
		<%-- 			<input type="text" class="calendar" size="15" id="alarmDate${alarmList.serialNo}" value="${alarmList.alarmDateFormat}" maxlength="10">  --%>
				</td>
				<td colspan="9" >
					<c:choose>
						<c:when test="${alarmList.alarmState eq '0'}">
							<input type="text" id="alarmComment${alarmList.serialNo}" size="115" value="${alarmList.alarmComment}">
						</c:when>
						<c:otherwise>
							${alarmList.alarmComment}
						</c:otherwise>
					</c:choose>			
					
				</td>
				<td>
					${alarmList.regUserNm}			
				</td>
				<td colspan="2">
					<c:choose>
						<c:when test="${alarmList.alarmState eq '0'}">
							<img src="./resources/ls_img/btn_edite.gif" onclick="fnUdtRptAlarm(${alarmList.serialNo})" style="cursor:pointer;">
		<!-- 				<img src="./resources/ls_img/btn_del.gif" style="cursor:pointer;"> -->
							<img src="./resources/ne_img/btn/btn_confirm.gif" onclick="fnUdtRptAlarmConfirm(${alarmList.serialNo},${alarmList.suimRptNo})" style="cursor:pointer;">
		<!-- 				<img src="./resources/ne_img/btn/btn_extend.gif" style="cursor:pointer;"> -->
						</c:when>
						<c:otherwise>
							완료
						</c:otherwise>
					</c:choose>	
				</td>
			</tr>
		</c:forEach>
	
	</c:when>
	
	<c:otherwise>
		<tr>
			<td colspan="14">
				알림 미등록
			</td>
		</tr>
	</c:otherwise>
</c:choose>


