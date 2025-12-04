<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<!-- <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> -->
<meta http-equiv="X-UA-Compatible" content="IE=edge;text/html; charset=UTF-8">
	<!-- 상단 include 페이지의 css 적용 -->
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css?v=201705231112" />
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<!-- 상단 include 페이지의 css 적용 -->
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/rpt_issue.css?v=20181204?v=2018"/>		
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script type="text/javascript">
    $(document).ready(function() {
		window.print();
    });
</script>
</head>
<div class="reportWrap">
    <div class="issue_reportContent">
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
        <div class="issue_lotte">			
			<!-- 발송목록 -->
			<table>
				<colgroup>
				    <col width="15%">
				    <col width="65%">
				    <col width="20%">				    
				</colgroup>                
				<tbody>
					<tr>
						<td style="text-align: left;padding-left:5px;">Report No.</td>
						<td style="text-align: left;padding-left:5px;">: ${rptIssueMain.suimAcceptNo}</td>
						<td style="text-align: left;padding-left:5px;">Date ${rptIssue.writeDateFmt} </td>
					</tr>
					<tr>
						<td style="text-align: left;padding-left:5px;">수 신</td>
						<td colspan="2" style="text-align: left;padding-left:5px;">: ${ ptnr_mbr_nm } 담당자님</td>
					</tr>
					<tr>
						<td style="text-align: left;padding-left:5px;">제 목</td>
						<td colspan="2" style="text-align: left;padding-left:5px;">: 손해사정서 교부 결과 안내 [사고번호 : ${rptIssueMain.accidentNo}]</td>
					</tr>
				</tbody>
			</table>		        
    	<div class="display-table" style="margin-top: 10px;">
	    	<!-- 1. 계약사항 -->    	
	        <div class="display-cell">
				<p class="subtitle">
					<c:if test="${ctype eq 'C'}">
		   				재물보험 손해 사정서 교부대상자
		   			</c:if>
		   			<c:if test="${ctype eq 'B'}">
		   				배상책임보험 손해 사정서 교부대상자
		   			</c:if>
		   			<c:if test="${ctype eq 'T'}">
		   				여행자보험 손해 사정서 교부대상자
		   			</c:if>
		   			<c:if test="${ctype eq 'I'}">
		   				인보험 손해 사정서 교부대상자
		   			</c:if>
				</p>			
			</div>			
       	</div>
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
				                	<c:when test="${item.sendState == 0 && item.sendDate != null && item.sensMethod eq 'mobile'}">				                    	
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
				                	<c:when test="${item.sendState == 0  && item.sendDate != null && item.sensMethod eq 'mobile' }">
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
		<!-- 조사자, 담당손해사정사 시작 -->		 	
		<c:choose>
			<c:when test="${empty certiReportUser}">
				<div style="padding:20px 0 20px 0;">
					<table>
						<tr>					 			
							<td style="font-weight:bold; color: red; text-align:left;">
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
								<td width="12%" style="font-weight:bold; text-align:left;">
									${certiUserVo.certi_state_val}
								</td>
								<td width="20%" style="font-weight:bold; text-align:center;">
									${certiUserVo.user_name}
								</td>
								<td width="18%" style="font-weight:bold; text-align:left;">						 										 				
									<img src="https://www.toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${certiUserVo.user_no}/${certiUserVo.user_sign}" width="30px" height="20px">
								</td>
								<td width="50%" style="font-weight:bold; text-align:left;"></td>						 			
							</tr>
							<tr>
								<td colspan="4" style="font-weight:bold; text-align:left;">
								 [ 등록번호 : ${certiUserVo.certi_number} <c:if test='${certiUserVo.work_phone != ""}'>/ 연락처 : ${certiUserVo.work_phone} </c:if>]
								</td>						 							 			
							</tr>
						</table>
					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>		 	
		<!-- 조사자, 담당손해사정사 끝 -->
		<%-- <table>
			<colgroup>
			    <col width="50%">
			    <col width="50%">			    
			</colgroup>
			<tbody>								
				<tr style="height:10px;">
					<td></td>
					<td><b>수임일자 : ${suimVO.getReg_date()}</b></td>	
				</tr>
				<tr style="height:10px;">
					<td></td>
					<td>
						<b>작성일자 : ${nowdate}</b>
					</td>						
				</tr>
				<tr style="height:10px;">
					<td></td>
					<td><b>조 사 자 : ${reportInvgUser.disWorkLevel} ${reportInvgUser.userName}  (연락처 : ${reportInvgUser.handphone})</b></td>	
				</tr>
				<tr>
					<td></td>
					<td><b>대표손해사정사 : 윤경수</b><img alt="윤경수" src="./resources/ne_img/sign_yun.jpg" width="50" height="30"></td>	
				</tr>
			</tbody>			
		</table> --%>
		<br/>
		<div align="center"><img src="https://www.toplac.co.kr/resources/ne_img/sign_ceo.jpg" border="0"/></div>					
    </div>
    </div>    
</div>
</div>
<br/>
<br/>