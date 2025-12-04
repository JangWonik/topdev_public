<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge;text/html; charset=UTF-8">
    <title>손해사정서 교부결과 안내</title>
    <style>
        /*기본태그 정의*/
        html, body{padding:0;margin:0;}
        /* 모바일 가로모드 폰트확대 방지 */
        body{-webkit-text-size-adjust:none;}
        body,table {font-size:10pt;font-family:'굴림','굴림체','돋움','Nanum Gothic', 'verdana'; color:#000;}
        /* 마진과 패딩의 초기화 */
        body, div, p, th, td, textarea {margin:0;padding:0;}
        .reportWrap {width: 100%;}
        .reportContent {
            position: relative;
            /*background-color: #3e8f3e;*/
            width: 640px;
            margin: auto;
        }

        .text-left {text-align: left;}
        .text-right {text-align: right;}
        .text-center {text-align: center;}

        .display-table{
            width: 100%;
            display: table;
            table-layout: fixed;
        }

        .display-cell{
            display: table-cell;
            vertical-align: middle;
            float: none;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }
        tr {height: 42px;}
        th {
            background-color: #ECECEC;
            font-weight: bold;
            text-align: center;
            vertical-align: middle;
            padding: 4px 2px 4px 2px;
        }
        td {
            font-weight: normal;
            padding: 4px 5px 4px 5px;
            letter-spacing: -1px;
            line-height:20px;
            text-align: left;
            vertical-align: middle;
        }

        table.approval  th {background-color: #FFF3F3;}
        table.approval  td {text-align: center;}
        table.approval  tr {height: 69px;}
        table.approval  tr:first-child {height: 42px;}
        table.center    td {text-align: center}

        p {line-height: 150%;}
        p.title {font-weight: bold; margin: 10px 10px 8px 0px;}
        p.subtitle {font-weight: bold; margin: 10px 10px 8px 0px; font-size: 11pt !important;}
        .panel-title {font-weight: bold;}

		.reportContent tr {height: 35px;}
		.reportContent th {padding: 8px 0px 4px 20px; border: 0px solid; background-color: #FFF; text-align: left; vertical-align: top; font-weight: normal;}
		.reportContent td {border: 0px solid; vertical-align: top; text-align: left;}

		#table_issue_contract_view th {padding: 4px 0px 4px 0px; border: 1px solid; background-color: #E7ECF1; text-align: center; vertical-align:middle; font-weight: normal; border-bottom: 1px double;}
		#table_issue_contract_view td {border: 1px solid; text-align: center; vertical-align: middle;}
		#table_accident_view th {padding: 4px 0px 4px 0px; border: 1px solid; background-color: #E7ECF1; text-align: center; vertical-align:middle; font-weight: normal; border-bottom: 1px double;}
		#table_accident_view td {border: 1px solid; text-align: center; vertical-align: middle;}
		        
    </style>
   	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js?v=201706141814"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/jquery/jquery.mask.min.js"></script>

	<%--spiner start--%>
    <script src="/resources/jquery/spin.js"></script>
    <script src="/resources/jquery/jquery.spin.js"></script>
    <%--spiner end --%>

	<script src="./resources/ne_js/calendar.js"></script>
	<%--<script src="./resources/daum/161109.js"></script>--%>
	<script src="./resources/daum/postcode.v2.js"></script>
	<script src='https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js'></script>
	
	
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>

    <script src="./resources/cmm/js/common.js?v=201707311012"></script>
</head>
<body>
<div class="reportWrap">
    <div class="reportContent">
        <input type="hidden" id="suim_rpt_no" value="${param.suim_rpt_no}">
        <div>
            <img src="//www.toplac.co.kr/resources/ls_img/ls_body/print_head.jpg" width="640" height="56">
            <p class="text-center" style="padding-top: 6px;"><span style="font-size: 9pt;">${reportTeamInfo.teamAddr}</span></p>
            <p class="text-center">
					<span style="font-size: 9pt;">
                        전화 : ${reportInvgUser.officeTel} &nbsp;팩스 : ${reportInvgUser.officeFax} &nbsp;이메일 : ${reportInvgUser.email}
                    </span>
            </p>
            <p class="text-center" style="padding-top: 0px;">
                <img src="//www.toplac.co.kr/resources/ls_img/ls_body/print_hr.jpg" width="640" height="3" border="0" class="img-responsive center-block">
            </p>
        </div>
        <div style="margin-top: 10px;">
            <div style="width: 78%; float: left">
            	<p class="issuetitle">Report No. &nbsp;:&nbsp; ${rptIssueMain.suimAcceptNo}</p>
                <p class="issuetitle">
                	수 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;신&nbsp;&nbsp;:&nbsp;&nbsp;${ param.ptnr_mbr_nm }&nbsp;담당자님
               	</p>
                <p class="issuetitle">
                    제 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목&nbsp;&nbsp;:&nbsp;&nbsp;손해사정서 교부 결과 안내 [사고번호 : ${rptIssueMain.accidentNo}]
                </p>
                <!-- 수임일추가 시작 by top3009 -->
                <p class="issuetitle" style="padding-bottom: 30px">수&nbsp;&nbsp;&nbsp;임&nbsp;&nbsp;&nbsp;일&nbsp;&nbsp;:&nbsp;&nbsp;${rptIssueMain.regDate}</p>
                <!-- 수임일추가 끝 by top3009 -->
            </div>
            
            <div style="width: 22%; float: right">
				<p class="issuetitle" style="margin-right: 0; text-align: right;"> Date ${rptIssue.writeDateFmt} </p>				
			</div>  
		</div>
		        
        <!--// 1.보험계약사항 -->
        <div class="display-table" style="margin-top: 50px;">
            <div class="display-cell">
                <p class="subtitle">손해사정서 교부대상자</p>
            </div>
        </div>     
 			<!-- oniku -->
            <div class="issue_lotte">			
			<!-- 발송목록 -->
			<table id="table_issue_contract_view" style="border: 1px solid currentColor;">
				<colgroup>
				    <col width="15%">
				    <col width="10%">
				    <col width="38%">
				    <col width="17%">
				    <col width="20%">
				</colgroup>                
				<tbody>
				<tr>
					<th><b>구분</b></th>
					<th><b>동의여부</b></th>
					<th><b>교부방법</b></th>
					<th><b>상태</b></th>
					<th><b>처리일자</b></th>										                	
				</tr>	
				<c:forEach items="${rptIssueSendList}" var="item" varStatus="status">	
				<input type="hidden" id="msgid" value="${item.msgid}"/>
				<tr>				    
				    <td>
				    	<c:if test="${item.sendTarget eq '1'}">계약자</c:if>
				    	<c:if test="${item.sendTarget eq '5'}">피보험자</c:if>
				    	<c:if test="${item.sendTarget eq '10'}">보험청구권자</c:if>
				    </td>
				    <td>
				    	<c:if test="${item.privacyAgree == 1}">동의</c:if>
				    	<c:if test="${item.privacyAgree == 2}">비 동의</c:if>
				    </td>
				    <td style="text-align: left;padding-left:5px;">
				    	<c:if test="${item.sendMethod eq 'mobile'}">휴대폰
				    	/ ${ item.tel1}-****-${ item.tel3}
				    	</c:if>
				    	<c:if test="${item.sendMethod eq 'email'}">이메일
				    	/ <%-- ${ item.email} --%>***<c:out value="${fn:substring(item.email,3,fn:length(item.email))}" />
				    	</c:if>
				    	<c:if test="${item.sendMethod eq 'fax'}">팩스
				    	/ ${ item.tel1}-****-${ item.tel3}
				    	</c:if>
				    </td>				     
				    <td>	    	    	
				    	<c:choose>
							<c:when test="${suimVO.suimRptState == 2}">
				               	<c:choose>
				               		<c:when test="${item.privacyAgree == 2}">
				                		-
				                	</c:when>	
				                	<c:when test="${item.sendState == 1}">
				                		발송 완료
				                	</c:when>
				                	<c:when test="${item.sendState == 2}">				                    	
				                		발송중<br/>
				                		( ${ item.stateMsg } )				                    		
				                	</c:when>
				                	<c:when test="${item.sendState == 0 && item.sendDate != null && item.sendMethod eq 'mobile'}">				                    	
				                		발송실패<br/>
				                		( ${ item.stateMsg } )				                    		
				                	</c:when>				                    				                    	
									<c:when test="${item.privacyAgree == 1 && item.sendMethod eq 'mobile' }">
										발송대기		                    	
									</c:when>
				                	<c:otherwise>
									<c:choose>
										<c:when test="${item.privacyAgree == 1 && item.sendMethod eq 'mobile' }">
											발송대기		                    	
										</c:when>
										<c:when test="${item.privacyAgree == 1 && (item.sendMethod eq 'email' || item.sendMethod eq 'fax' )}">
											교부 완료
										</c:when>
										<c:otherwise>
										-
										</c:otherwise>
									</c:choose>
				                	</c:otherwise>
				               	</c:choose>
				             </c:when>	             
				             <c:otherwise>
				               	<c:choose>
				               		<c:when test="${item.privacyAgree == 2}">
				                		-
				                	</c:when>
				                	<c:when test="${item.sendState == 1}">
				                		발송 완료
				                	</c:when>
				                	<c:when test="${item.sendState == 2}">
				                		발송중<br/>
				                		( ${ item.stateMsg } )
				                	</c:when>
				                	<c:when test="${item.sendState == 0  && item.sendDate != null && item.sendMethod eq 'mobile' }">
				                		발송실패<br/>
				                		( ${ item.stateMsg } )
				                	</c:when>
				                	<c:when test="${item.privacyAgree == 1 && (item.sendMethod eq 'email' || item.sendMethod eq 'fax' )}">
										종결후 교부가능
									</c:when>
				                	<c:otherwise>
										-	                    	
				                	</c:otherwise>
				               	</c:choose>
							</c:otherwise>
						</c:choose>
				    </td>
				    <td>
				    	<c:choose>
					    	<c:when test="${item.privacyAgree == 2}">
					            <span style="color:red"> ${ item.disagreeDate } </span>
							</c:when>	
							<c:when test="${item.sendState == 1 || ( item.sendMethod eq 'fax' || item.sendMethod eq 'email' ) }">
								<span style="color:blue"> ${ item.sendDate } </span>
							</c:when>
							<c:otherwise>
								${ item.regDate }
							</c:otherwise>
						</c:choose>						
				    </td>
				</tr>
				</c:forEach>
				<c:if test="${fn:length(rptIssueSendList) == 0}">
				<tr>				    
				    <td colspan="5">등록된 교부대상자 정보가 없습니다.</td>	    
				</tr>	
				</c:if>
			    </tbody>
			</table>		
		<br/>
		<br/>
		<br/>
		<table>						
			<%-- <tr>				
				<td style="text-align:left;padding-left:5px;"><b>수임일자 : ${suimVO.getReg_date()}</b></td>	
			</tr>
			<tr>				
				<td style="text-align:left;padding-left:5px;">
					<b>작성일자 : ${nowdate}</b>
				</td>						
			</tr> --%>
			<tr>
				<td>
				<!-- 조사자, 담당손해사정사 시작 -->		 	
			 	<c:choose>
			 		<c:when test="${empty certiReportUser}">
			 			<div style="padding:10px 0 10px 0;">
						 	<table>
						 		<tr>					 			
						 			<td style="font-size:12px; font-family: 돋움; color: red; text-align:left;">
						 				[미배당건으로 담당자 정보가 없습니다.]
						 			</td>					 			
						 		</tr>					 		
						 	</table>
					 	</div>
			 		</c:when>
			 		<c:otherwise>
			 			<c:forEach items="${certiReportUser}" var="certiUserVo">
			 				<div style="padding:10px 0 10px 0;">
							 	<table>
							 		<tr>						 			
							 			<td width="12%" style="font-size:14px; font-family: 돋움; color: #000; text-align:left;">
							 				${certiUserVo.certi_state_val}
							 			</td>
							 			<td width="20%" style="font-size:14px; font-family: 돋움; color: #000; text-align:center;">
							 				${certiUserVo.user_name}
							 			</td>
							 			<td width="18%" style="font-size:14px; font-family: 돋움; color: #000; text-align:left;">						 										 				
							 				<img src="https://www.toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${certiUserVo.user_no}/${certiUserVo.user_sign}" width="30px" height="20px">
							 			</td>
							 			<td width="50%" style="font-size:14px; font-family: 돋움; color: #000; text-align:left;"></td>						 			
							 		</tr>
							 		<tr>
							 			<td colspan="4" style="font-size:12px; font-family: 돋움; color: #000; text-align:left;letter-spacing:0px;">
							 			 [ 등록번호 : ${certiUserVo.certi_number} <c:if test='${certiUserVo.work_phone != ""}'>/ 연락처 : ${certiUserVo.work_phone} </c:if>]
							 			</td>						 							 			
							 		</tr>
							 	</table>
						 	</div>
			 			</c:forEach>
			 		</c:otherwise>
			 	</c:choose>
			 	</td>		 	
			 </tr>
		 	<!-- 조사자, 담당손해사정사 끝 -->
				<%-- <tr style="height:10px;">
					<td></td>
					<td><b>조 사 자 : ${reportInvgUser.disWorkLevel} ${reportInvgUser.userName}  (연락처 : ${reportInvgUser.handphone})</b></td>	
				</tr>
				<tr>
					<td></td>
					<td><b>대표손해사정사 : 윤경수</b><img alt="윤경수" src="./resources/ne_img/sign_yun.jpg" width="50" height="30"></td>	
				</tr> --%>
		</tbody>			
		</table>
		<br/>
		<div align="center"><img src="https://www.toplac.co.kr/resources/ne_img/sign_ceo.jpg" border="0"/></div>					
    </div> 		
    </div> <!-- //reportContent-->
</div> <!-- //reportWrap-->
<script type="text/javascript">
    $(document).ready(function() {		
		window.print();
    });    
</script>
</body>
</html>
