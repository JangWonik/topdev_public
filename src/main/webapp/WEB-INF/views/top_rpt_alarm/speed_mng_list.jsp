<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<table>
		<colgroup>
			<col width="90"></col> 	<!-- 알림 -->
			<col width="50"></col>	<!-- 메모 -->
			<col width="90"></col>	<!-- 접수번호 -->
			<col width="35"></col>	<!-- 사고번호1 -->
			<col width="60"></col>	<!-- 사고번호2 -->
			<col width="95"></col>	<!-- 증권번호 -->
			<col width="90"></col>	<!-- 부서명 -->	
			<col width="80"></col>	<!-- 담당자 -->
			<col width="80"></col>	<!-- 스피드구분 -->
			<col width="120"></col>	<!-- 계약자 -->
			<col width="120"></col>	<!-- 피보험자 -->
			<col width="120"></col>	<!-- 피해자/물 -->
			<col width="70"></col>	<!-- 접수일 -->
			<col width="80"></col>	<!-- 상태 -->
		</colgroup>
	
		<thead>
			<tr>
				<th>알림</th>
				<th>메모</th>
				<th>접수번호</th>
				<th colspan="2">사고번호</th>
				<th>증권번호</th>
				<th>부서명</th>
				<th>담당자</th>
				<th>스피드구분</th>
				<th>계약자</th>
				<th>피보험자</th>
				<th>피해자/물</th>
				<th>접수일</th>
				<th>상태</th>
			</tr>
		</thead>
		
		<tbody>
		<c:forEach var="speedList" items="${speedList}" varStatus="speedListStatus">
			<tr id="spdTr${speedListStatus.index}"> 
				<!-- 알림 -->
				<td class="speedTd" style="letter-spacing: 0">
					${speedList.recentAlarmDateFmt} <img src="./resources/ls_img/btn_add_s.gif" onclick="javascript:fnViewAlarm(${speedList.suimRptNo})" style="cursor:pointer;">
				</td>
				
				<!-- 메모 -->
				<td class="speedTd">
					<img src='./resources/ls_img/btn_edit_s.gif' id="memoBtn${speedListStatus.index}" onclick='javascript:spdCommentView(${speedListStatus.index})' ViewYN='0' style='cursor:pointer;'/>
				</td>
				
				<!-- 접수번호 -->
				<td class="speedTd" style="letter-spacing: 0;cursor:pointer;" onclick="popSuimDtl(${speedList.suimRptNo})">
					<font <c:if test="${speedList.speedOneStop eq '1'}">style="color:blue;"</c:if>>
						${speedList.suimAcceptNo}
					</font>
				</td>
				
				<!-- 사고번호1 -->
				<td class="speedTd" align="right" style="letter-spacing: 0;">${speedList.accidentNo1}</td>
				<!-- 사고번호2 -->
				<td class="speedTd" align="left" style="letter-spacing: 0;">${speedList.accidentNo2}</td>
				<!-- 증권번호 -->
				<td class="speedTd" style="letter-spacing: 0;">${speedList.policyNo}</td>
				<!-- 부서명 -->
				<td class="speedTd">${speedList.teamNm}</td>
				<!-- 담당자 -->
				<td class="speedTd">${speedList.userNm}</td>
				<!-- 스피드구분 -->
				<td class="speedTd">${speedList.speedTypeVal}</td>
				<!-- 계약자 -->
				<td class="speedTd tooltip" id="policyNm${speedListStatus.count}" title="${speedList.policyholderTel}">
					${speedList.policyholderNm}
				</td>
				<!-- 피보험자 -->
				<td class="speedTd tooltip" id="beneficiaryNm${speedListStatus.count}" title="${speedList.beneficiaryTel}">
					${speedList.beneficiaryNm}
				</td>
				<!-- 피해자/물 -->
				<td class="speedTd tooltip" id="damagedNm${speedListStatus.count}" title="${speedList.damagedTel}">
					${speedList.damagedNm}
				</td>
				<!-- 접수일 -->
				<td class="speedTd" style="letter-spacing:0;">${speedList.regDate}</td>		
				
				<td <c:if test="${speedList.delDate != 0}">bgcolor="pink"</c:if>>
					<p <c:if test="${speedList.suimRptStateCd  eq 3}">title="${speedList.suimCancelDateFmt}"</c:if> >
						<c:choose>
							<c:when test="${speedList.delDate != 0}"><font color="red"><b>삭제</b></font></c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${speedList.suimRptStateCd  eq 0}">미결</c:when>
									<c:when test="${speedList.suimRptStateCd  eq 1}"><font color="#0066ff">결재</font></c:when>
									<c:when test="${speedList.suimRptStateCd  eq 11}"><font color="#CC3300">반려</font></c:when>
									<c:when test="${speedList.suimRptStateCd  eq 2}">${speedList.closeDateFmt}</c:when>
									<c:when test="${speedList.suimRptStateCd  eq 3}">반송</c:when>
									<c:when test="${speedList.suimRptStateCd  eq 31}"><font color=#C5A700>위임취소중</font></c:when>
									<c:when test="${speedList.suimRptStateCd  eq 4}">소송</c:when>
								</c:choose>
							</c:otherwise>
						</c:choose>
					</p>
				</td>
			</tr>
			
			<tr style="padding:0px;display:none;" id="spdAlarmTable${speedList.suimRptNo}" ViewYN ="0">
				<td colspan="14">
					<table style="border: 2px solid #6d6d6d;">
						<tr>
							<th colspan="2" >알림일</th>
							<th colspan="9">알림내용</th>
							<th>작성자</th>
							<th colspan="2">-</th>
						</tr>
			
						<tr style="border-bottom: dotted;">
							<td colspan="2">
								<input type="text" class="calendar" size="15" id="insAlarmDate${speedList.suimRptNo}" value="" maxlength="10"> 
							</td>
							<td colspan="9">
								<input type="text" id="insAlarmComment${speedList.suimRptNo}" size="115">
							</td>
							<td>
								${mbrVo_Session.user_name}
							</td>
							
							<td colspan="2" >
								<img src="./resources/ls_img/btn_add.gif" onClick="fnInsRptAlarm(${speedList.suimRptNo})" style="cursor:pointer;">
							</td>
						</tr>
						
						<tbody style="background: rgba(221, 221, 221, 0.2)" id="rptAlarmListTbody${speedList.suimRptNo}" suimRptNo="${speedList.suimRptNo}">
							
						</tbody>
					</table> 
				</td>
			</tr>

			
			<tr id="spdCommentTr${speedListStatus.index}" style="display: none;">
				<td colspan="13"> 
					<textarea class='speedCommentTxtArea' id='speedCommentTxtArea${speedListStatus.index}' style='display:block;width:1135px;margin: 0 auto;'
	  				  	 	  onfocus='javascript:fnAutoSize(this.scrollHeight,this);'
	 	 	  				  onKeyUP='javascript:fnAutoSize(this.scrollHeight,this);'
		  				      onKeyDown='javascript:fnAutoSize(this.scrollHeight,this);'>${speedList.speedComment}</textarea>
				</td>
				
				<td>
					<img src='./resources/ne_img/btn/btn_save.gif' onclick="javascript:spdCommentUpdate(${speedList.suimRptNo}, ${speedListStatus.index})" style='cursor:pointer;'/>
					<br/><img src='./resources/ne_img/btn/btn_close.gif' onclick="javascript:spdCommentClose(${speedListStatus.index})" style='cursor:pointer;margin-top:5px;'/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagingWrap">
    	<%--<div class="pageContent">--%>
        	<c:import url="/page_navi">
            	<c:param name="beginIdx" value="${pageInfo.firstPageNoOnPageList}"/>
                <c:param name="endIdx" value="${pageInfo.lastPageNoOnPageList}"/>
                <c:param name="currentIdx" value="${pageInfo.currentPageNo}"/>
                <c:param name="totalPageCnt" value="${pageInfo.totalPageCount}"/>
			</c:import>
		<%--</div>--%>
      </div>
    <div id="loading" style="display: none;">
       	<img id="loading-image" src="./resources/cmm/images/spinner.gif" alt="Loading..." />
   	</div>
