<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<link rel="stylesheet" type="text/css" href="./resources/wm_css/general_report.css?v=201707261117"/>
<script type="text/javascript">
function fnReportWord(){
    var cw=screen.availWidth;
    var ch=screen.availHeight;

    var sw=1000; //띄울 창의 넓이
    var sh=740;  //띄울 창의 높이

    var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
    var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치

//     window.open('/cstRptInfo?suim_rpt_no='+'${param.suim_rpt_no}'+'&cmd=word','word','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
}

function fnReportPrint(){
    var cw=screen.availWidth;
    var ch=screen.availHeight;

    var sw=700; //띄울 창의 넓이
    var sh=550;  //띄울 창의 높이

    var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
    var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치

//     window.open('/cstRptInfo?suim_rpt_no='+'${param.suim_rpt_no}'+'&cmd=print','print','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
}

</script>

<div class="reportWrap">
	<div class="reportContent" style="width:900px;">>
		<div class="text-right">
        </div>
	        <div>
			<img src="//www.toplac.co.kr/resources/ls_img/ls_body/print_head.jpg" width="640" height="56">
			<p class="text-center" style="padding-top: 6px;"><span style="font-size: 9pt;">${reportTeamInfo.teamAddr}</span></p>
			<p class="text-center">
				<span style="font-size: 9pt;">
			         전화 : ${reportTeamInfo.teamTelephone} &nbsp;팩스 : ${reportTeamInfo.teamFax} &nbsp;이메일 : ${reportInvgUser.email}
			    </span>
			</p>
			<p class="text-center" style="padding-top: 2px;">
	                <img src="//www.toplac.co.kr/resources/ls_img/ls_body/print_hr.jpg" width="640" height="3" border="0" class="img-responsive center-block">
	        </p>
		</div>
		<div style="margin-top: 10px;">
			<div style="width: 65%; float: left">
                <p class="title">수 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;신 : ${reportBscInfo.ptnrName}</p>
                <p class="title">참 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;조 : ${reportBscInfo.ptnrDeptNm}
                    <c:if test="${reportBscInfo.ptnrMbrNm != ''}">
                        〔 담당 : ${reportBscInfo.ptnrMbrNm} 님 〕
                    </c:if>
                </p>
                <p class="title">제 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목 :
                    <c:if test="${reportBscInfo.beneficiaryNm != ''}">${reportBscInfo.insuranceNm}
                        &quot;<b>${reportBscInfo.policyholderNm}</b>&quot;
                    </c:if>
                    <b>손해사정서</b>
                </p>
                <p class="title">증 권 번 호 : 제 ${reportBscInfo.policyNo} 호</p>
                <p class="title">사 고 번 호 : ${reportBscInfo.accidentNo}</p>
            </div>
			<div style="width: 35%; float: left">
                <p class="title">Report No. ${reportBscInfo.suimAcceptNo}</p>
                <p class="title">
                    <c:choose>
                        <c:when test="${reportBscInfo.invoiceDate == null || reportBscInfo.invoiceDate == ''}">
                            날짜 정보없음
                        </c:when>
                        <c:otherwise>
                            보고서 제출일 : ${reportBscInfo.invoiceDate}
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>
			<div style="clear: both"></div>
			<div>
                <p style="margin-top: 20px; padding: 0px 5px;">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    귀사의 요청에 의거 ${a} ~ ${b} 사이에 발생한 ${c} 로 인해 발생한  &quot;${reportBscInfo.beneficiaryNm} 외 상해사고&quot; 에 대한 사고조사를 실시하고 
                    그 결과에 대한 최종 보고서를 다음과 같이 제출합니다.
                </p>
            </div>
		
			<!-- 서명란 -->
			<div style="margin-top: 50px;">
            <table class="approval" align="center">
                <colgroup>
                    <col width="25%">
                    <col width="25%">
                    <col width="25%">
                    <col width="25%">
                </colgroup>
                <tr>
                    <th>구분</th>
                    <th>성명</th>
                    <th>서명</th>
                    <th>연락처</th>
                </tr>
                <tr>
                    <td>손해사정사</td>
                    <td>윤경수</td>
                    <td><img src="./resources/ls_img/ls_body/sign_yoon.jpg" width="62" height="60" border="0"></td>
                    <td>070-8255-3000</td>
                </tr>
                <tr>
                    <td>팀&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;장</td>
                    <td>
                        ${reportAprvUser.userName}<br/>
                        <c:if test="${reportAprvUser.workLevel != null && reportAprvUser.workLevel != ''}">
                            (${reportAprvUser.disWorkLevel})
                        </c:if>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${reportAprvUser.userSign != null}">
                                <img width="50" height="50" src="https://toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${reportAprvUser.userNo}/${reportAprvUser.userSign}"/>
                            </c:when>
                            <c:otherwise>
                                사인없음
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${reportAprvUser.handphone}</td>
                </tr>
                <tr>
                    <td>조 &nbsp;&nbsp;사 &nbsp;&nbsp;자</td>
                    <td>${reportInvgUser.userName } <br />(${reportInvgUser.disWorkLevel})</td>
                    <td>
                        <c:choose>
                            <c:when test="${reportInvgUser.userSign != null}">
                                <img width="50" height="50" src="https://toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${reportInvgUser.userNo}/${reportInvgUser.userSign}"/>
                            </c:when>
                            <c:otherwise>
                                사인없음
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${reportInvgUser.handphone }</td>
                </tr>
            </table>
        </div>
        
		 <!-- 1. 청구공제금(추산) -->

        
        
		</div>
	</div>


</div>