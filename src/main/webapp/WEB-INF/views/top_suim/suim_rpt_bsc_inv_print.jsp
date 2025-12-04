<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>보고서 작성</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<link rel="stylesheet" type="text/css" href="./resources/ls_css/rpt_6_style.css" />
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<!-- <script src="./resources/jquery/jquery-ui.min.js"></script> -->
	<!-- <script src="./resources/wm_js/common.js"></script> -->
</head>

<style>
@page {size: A4; page-break-after: always;}
.td {color: black;}

</style>


<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" style="width:840;margin:0 auto;">

<table align="center" cellpadding="0" cellspacing="0" width="840">
    <tr>
        <td width="100%" height="100%" valign="top">
            <p><img src="./resources/ls_img/ls_body/print_head.jpg" width="100%" height="100%" border="0"></p>
            <table cellpadding="0" cellspacing="0" width="100%" height="47">
                <tr>
                    <td width="100%" height="50">            
						<p align="center" style="line-height:100%; margin-top:0; margin-bottom:0;">&nbsp;</p>
                        <p align="center">${topTmBscVo.team_addr}</p>
                        <p align="center">
                        	ㆍ전화 : ${topTmBscVo.team_telephone} &nbsp;
                       		<c:if test="${topTmBscVo.team_fax != ''}">ㆍ팩스 : ${topTmBscVo.team_fax}&nbsp;</c:if>
                       		ㆍ이메일 : ${mbrVoForBody.email}
                     	</p>
                    </td>
                </tr>
            </table>
            <p align="center" style="margin-top:15px;"><img src="./resources/ls_img/ls_body/print_hr.jpg" width="100%" height="3" border="0"></p>
            
			<p align="right">&nbsp;${rptInvInfoVo.suim_close_no}</p>
			
			<div style="width:420px;margin:30px auto;">
				<table>
					<colgroup>
						<col width="150px"></col>
						<col width="120px"></col>
						<col width="150px"></col>
					</colgroup>
					<tr>
						<td>
						</td>
						<td style="height:30px;border-bottom: 2px double;vertical-align:bottom;" align="center">
							<font size="5" face="serif" style="color:black; font-weight:bold;">INVOICE</font>
						</td>
						<td style="vertical-align:bottom;">
							(${rptInvInfoVo.suim_accept_no})
						</td>
					</tr>
				</table>
			</div>
			
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td width="50%" height="45">
                        <p>수신처 : ${rptInvInfoVo.ptnr_name}</p>
                    </td>
                    <td width="50%">
                        <p align="right"><u>DATE
                        <!-- 인보이스 출력시 종결일 체크 제거 by top3009 20230619 (김두현부장 요청사항) -->
                        <c:choose>
                        	<c:when test="${rptInvInfoVo.tax_date > 0}">${rptInvInfoVo.tax_date_fmt}</c:when>                        	
                        	 <c:otherwise>
                        		<c:choose>                        			
		                        	<%-- <c:when test="${rptInvInfoVo.close_date > 0}">${rptInvInfoVo.close_date_fmt}</c:when> --%>
		                        	<c:when test="${rptInvInfoVo.invoice_date > 0}">${rptInvInfoVo.invoice_date_fmt}</c:when>
                        			<c:otherwise></c:otherwise>
                        		</c:choose>
                        	</c:otherwise>
                        </c:choose>
                        </u></p>
                    </td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" width="100%" style="border:3px solid black;">
      			<colgroup>
	      			<col width="10%"></col>
					<col width="15%"></col>
					<col width="30%"></col>
					<col width="15%"></col>
					<col width="30%"></col>
				</colgroup>
                <tr>
                    <th rowspan="2" class="td" width="120">
                        <p align="center">관련사고</p>
                    </th>
                    <th class="td" width="120" height="30">
                        <p align="center">보험계약자</p>
                    </th>
                    <td class="td"><p align="center">${rptInvInfoVo.policyholder_nm}</p>
                    </td>
                    <th class="td" width="120">
                        <p align="center">피 보 험 자</p>
                    </th>
                    <td class="td"><p align="center">${rptInvInfoVo.beneficiary_nm}</p>
                    </td>
                </tr>
                <tr>
                    <th class="td" height="30">
                        <p align="center">증 권 번 호</p>
                    </th>
                    <td class="td"><p align="center">${rptInvInfoVo.policy_no}</p>
                    </td>
                    <th class="td">
                        <p align="center">사 고 번 호</p>
                    </th>
                    <td class="td"><p align="center">${rptInvInfoVo.accident_no}</p>
                    </td>
                </tr>
                <c:if test="${rptInvInfoVo.ptnr_id eq '34'}"><!-- 수협 -->
                <tr>
                    <td class="td" height="30">
                        <p align="center"><b>보험상품명</b></p>
                    </td>
                    <td class="td" colspan="2">
                        <p align="center">${rptInvInfoVo.insurance_nm}</p>
                    </td>
                    <td class="td">
                        <p align="center">사 고 일 자</p>
                    </td>
                    <td class="td">
						<p align="center">
						<c:if test="${rptInvInfoVo.accident_date ne ''}">${rptInvInfoVo.accident_date_fmt}</c:if>
                    </td>
                </tr>
                </c:if>
            </table>
            <p style="line-height:150%;">&nbsp;</p>
				<table cellpadding="0" cellspacing="0" width="640" align="center" style="border:3px solid black;">
	      			<colgroup>
		      			<col width="80px"></col>
						<col width="440px"></col>
						<col width="120px"></col>
					</colgroup>
    				<tr style="border-bottom:2px double;">
        				<th height="30" class="td" width="120">
							<p align="center">
								구 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;분
							</p>
        				</th>
        				<th class="td">
							<p align="center">
								내 &nbsp;&nbsp;&nbsp;역
							</p>                                
						</th>

        				<th class="td" width="150">
            				<p align="center">
            					금액(원)
           					</p>
       					</th>
    				</tr>
    
    				<tr>
				        <th height="30" class="td">
							<p align="center">기본 보수</p>
				        </th>
        				<td class="td" style="font-family:'굴림';">
							${rptInvInfoVo.amt_basic_dtl}                                
						</td>
                        <td class="td">
                            <p align="right"> 
								\<fmt:formatNumber value="${rptInvInfoVo.amt_basic}" pattern="###,###,##0.##"/>.-
							</p>
     					</td>
 					</tr>
 					
 					<c:if test="${rptInvInfoVo.ptnr_id eq 14 and rptInvInfoVo.suim_rpt_type1 != 3 and rptInvInfoVo.suim_rpt_type1 != 4}">
 						<th height="30" class="td">
							<p align="center">결재 수수료</p>
				        </th>
        				<td class="td" style="font-family:'굴림';">
        					<c:if test="${not empty collaboApprovalVO.approvalUserName}">
        						결재자 : ${collaboApprovalVO.approvalTeamName} / ${collaboApprovalVO.approvalUserName}
        					</c:if>							                                
						</td>
                        <td class="td">
                            <p align="right">
                            	\
                            	<c:choose>
                            		<c:when test="${empty collaboApprovalVO.collaboPrice}">
                            			<fmt:formatNumber value="0" pattern="###,###,##0.##"/>.-
                            		</c:when>
                            		<c:otherwise>
                            			<fmt:formatNumber value="${collaboApprovalVO.collaboPrice}" pattern="###,###,##0.##"/>.-		
                            		</c:otherwise>
                            	</c:choose>
							</p>
     					</td>
 					</c:if>
 					
 					<tr>
     					<th height="30" class="td" style="font-family:'굴림';">
							<p align="center">
								일&nbsp;&nbsp;&nbsp;&nbsp;비
							</p>
     					</th>
     					<td class="td" style="font-family:'굴림';">
							${rptInvInfoVo.amt_daily_dtl}                               
						</td>
                        <td class="td">
                            <p align="right">
                            	\ <fmt:formatNumber value="${rptInvInfoVo.amt_daily}" pattern="###,###,##0.##"/>.-
                           	</p>
     					</td>
 					</tr>
 
					<tr>
						<th height="30" class="td">
							<p align="center">
								교&nbsp;&nbsp;통&nbsp;&nbsp;비
							</p>
				     	</th>
						<td class="td" style="font-family:'굴림';">
							${rptInvInfoVo.amt_traffic_dtl}                                
						</td>
                        <td class="td">
                            <p align="right">
                           		\ <fmt:formatNumber value="${rptInvInfoVo.amt_traffic}" pattern="###,###,##0.##"/>.-
							</p>
						</td>
 					</tr>
 					<tr>
     					<th height="30" class="td">
							<p align="center">
								자&nbsp;&nbsp;문&nbsp;&nbsp;료
							</p>
     					</th>
     					<td class="td" style="font-family:'굴림';">
							${rptInvInfoVo.amt_counsel_dtl}                                
						</td>
                        <td class="td">
                            <p align="right">
                            	\ <fmt:formatNumber value="${rptInvInfoVo.amt_counsel}" pattern="###,###,##0.##"/>.-
        					</p>
     					</td>
 					</tr>
 					
 					<tr>
						<th height="30" class="td" style="font-family:'굴림';">
							<p align="center">
								기&nbsp;&nbsp;&nbsp;&nbsp;타
							</p>
			     		</th>
				     	<td class="td">
							${rptInvInfoVo.amt_etc_dtl}                                
						</td>
                        <td class="td">
                            <p align="right">
                            	\ <fmt:formatNumber value="${rptInvInfoVo.amt_etc}" pattern="###,###,##0.##"/>.-
        					</p>
     					</td>
 					</tr>
				 	
			 		<tr style="border-top:2px double;">
			     		<td height="30" class="td" colspan="2">
			         		<p align="center"><B>합계</b></p>
			     		</td>
			     		<td class="td">
			         		<p align="right">
			         			\ <B><fmt:formatNumber value="${rptInvInfoVo.amt_total}" pattern="###,###,##0.##"/>.-</b>
		         			</p>
			        	</td>
			    	</tr>
				</table>
				
            	<p style="line-height:150%;">&nbsp;</p>
	            
           		<table cellpadding="0" cellspacing="0" width="100%" style="border:3px solid black;"	>
	                <tr>
                    	<td class="td" width="120" height="30">
                        	<p align="center">지 &nbsp;급 &nbsp;처</p>
                    	</td>
                    	<td class="td">
                    		<p>
                    			${rptInvInfoVo.top_accnt_nm}
                   			</p>
                    	</td>
	                    <td class="td">
	                        <p align="center">사업자등록번호</p>
	                    </td>
	                    <td class="td">
	                        <p>105-86-49340</p>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="td" height="30">
	                        <p align="center">은 &nbsp;행 &nbsp;명</p>
	                    </td>
	                    <td class="td"><p>${rptInvInfoVo.top_accnt_bank}</p>
	                    </td>
	                    <td class="td">
	                        <p align="center">계 &nbsp;&nbsp;좌 &nbsp;&nbsp;번 &nbsp;호</p>
	                    </td>
	                    <td class="td"><p>${rptInvInfoVo.top_accnt_no}</p>
	                    </td>
	                </tr>
            	</table>
	            <p>&nbsp;</p>
	            <p>&nbsp;</p>
	            <p>&nbsp;</p>
	            <p align="center">
	            	<!-- <img src="https://www.toplac.co.kr/resources/ne_img/sign_salary.jpg" width="260" height="99" border="0"/> -->
	            	<!-- 사인이미지가 안보이는 현상이 있어 임시로 수정 by top3009. 20200512 -->
	            	<img src="https://www.toplac.co.kr/resources/ne_img/sign_ceo.jpg" width="260" height="99" border="0"/>
	           	</p>
        	</td>
		</tr>
	</table>
	<script language="JavaScript">
		window.print();
	</script>
	</body>
</html>
