<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<script src="./resources/jquery/jquery.min_1_12.js"></script>
<style>
	p {color:#000000; font-size:12pt; line-height:150%; margin-top:0; margin-bottom:0; font-family:돋움,돋움체;}
	table {border-collapse:collapse;border-spacing:0; color:#000000; font-size:12pt; line-height:150%; margin-top:0; margin-bottom:0; font-family:돋움,돋움체;}
	.td {border:1px solid #666666; padding:3px; color:#000000; font-size:12pt; line-height:150%; margin-top:0; margin-bottom:0; font-family:돋움,돋움체;}
	H2.breakhere {page-break-before: always}
	body{margin-left:0;margin-right:0;margin-top:0;margin-bottom:0;}
</style>
<script>

</script>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
</head>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
	<table align="center" cellpadding="0" cellspacing="0" width="640">
	    <tr>
	        <td width="100%" height="100%" valign="top">
	            <p><img src="./resources/ls_img/pt_print_t.jpg" width="640" height="70" border="0"></p>
	            <table cellpadding="0" cellspacing="0" width="100%" height="47">
	                <tr>
	                    <td width="100%" height="50">            
							<p align="center" style="line-height:100%; margin-top:0; margin-bottom:0;">&nbsp;</p>
	                        <p align="center"></p>
	                        <p align="center">ㆍ전화 : ${teamVo.team_telephone}  &nbsp;ㆍ팩스 
	                        ${teamVo.team_fax}: &nbsp;&nbsp;ㆍ이메일 : ${mbrVo.email} </p>
	                    </td>
	                </tr>
	            </table>
	            <hr style="line-height:100%; margin-top:0; margin-bottom:0;" size="1" width="100%" noshade color="black">
	            <table align="center" cellpadding="0" cellspacing="0" width="640">
	                <tr>
	                    <td width="200">
	                        <p>&nbsp;</p>
	                    </td>
	                    <td width="190" height="60">            
	                    	<p align="center" style="line-height:200%;">
	                    		<B><u><font size="5">사고처리과정표</font></u></B>
	                    	</p>
	                    </td>
	                    <td width="200">
	                        <p>(${rptInfoVo.suim_accept_no})</p>
	                    </td>
	                </tr>
	            </table>
	            <table cellpadding="0" cellspacing="0" width="100%">
	                <tr>
	                    <td width="50%" height="45">
	                        <p><b>일반사항</b></p>
	                    </td>
	                    <td width="50%">
	                        <p align="right">&nbsp;</p>
	                    </td>
	                </tr>
	            </table>
	            <table cellpadding="0" cellspacing="0" width="100%">
	                <tr>
	                    <td class="td" width="20%" height="35" bgcolor="#EDEDED">
	                        <p align="center">보험종목</p>
	                    </td>
	                    <td class="td" width="30%">
		                    <p align="center">
		                    	${rptInfoVo.insurance_nm}
		                    </p>
	                    </td>
	                    <td class="td" width="20%" bgcolor="#EDEDED">
	                        <p align="center">사고일시</p>
	                    </td>
	                    <td class="td" width="30%">
	                    	<p align="center">${rptInfoVo.accident_date }</p>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="td" height="35" bgcolor="#EDEDED">
	                        <p align="center">피보험자</p>
	                    </td>
	                    <td class="td">
		                    <p align="center">
		                    ${rptInfoVo.beneficiary_nm}
		                    </p>
	                    </td>
	                    <td class="td" bgcolor="#EDEDED">
	                        <p align="center">보험회사담당자</p>
	                    </td>
	                    <td class="td">
	                    	<p align="center">
	                    	${rptInfoVo.ptnr_mbr_nm}
	                    	</p>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="td" height="35" bgcolor="#EDEDED">
	                        <p align="center">조 &nbsp;사 &nbsp;자</p>
	                    </td>
	                    <td class="td">
							<p align="center">
							${rptInfoVo.user_name}
							</p>
	                    </td>
	                    <td class="td" bgcolor="#EDEDED">
	                        <p align="center">사 고 수 임 일</p>
	                    </td>
	                    <td class="td">
		                    <p align="center">
		                    ${rptInfoVo.reg_date}
		                    </p>
	                    </td>
	                </tr>
	                
	                <!-- ig_id = 10 일 경우  -->
	
	               <!--  <tr>
	                    <td class="td" height="35" bgcolor="#EDEDED">
	                        <p align="center">증권번호</p>
	                    </td>
	                    <td class="td">
							<p align="center"></p>
	                    </td>
	                    <td class="td" bgcolor="#EDEDED">
	                        <p align="center">사고번호</p>
	                    </td>
	                    <td class="td"><p align="center"></p>
	                    </td>
	                </tr> -->
					<!-- //ig_id = 10 일 경우  -->
					
	            </table>
	            <table cellpadding="0" cellspacing="0" width="100%">
	                <tr>
	                    <td width="50%" height="45">
	                        <p><b>처리과정(서류접수 현황포함)</b></p>
	                    </td>
	                    <td width="50%">
	                        <p align="right"></p>
	                    </td>
	                </tr>
	            </table>
		<TABLE cellSpacing=0 cellPadding="0" width="640" align="center">
			<tr>
				<td bgcolor="#EDEDED" class="td">
			        <p align="center"><b>진&nbsp;행&nbsp;일&nbsp;시</b>
			    </td>
				<td bgcolor="#EDEDED" class="td">
			        <p align="center"><b>주&nbsp;요&nbsp;내&nbsp;용</b>
			    </td>
				<td bgcolor="#EDEDED" class="td">
			        <p align="center"><b>면&nbsp;&nbsp;담&nbsp;&nbsp;자</b>
			    </td>
			    <td bgcolor="#EDEDED" class="td">
			        <p align="center"><b>관 &nbsp;&nbsp;계</b>
			    </td>
			    <td bgcolor="#EDEDED" class="td">
			        <p align="center"><b>접 &nbsp;촉 &nbsp;방 &nbsp;법</b>
			    </td>
		    </tr>
		    
		<c:forEach items="${sagoList}" var = "sagoVo16">
		
			<tr>
				<td bgcolor="#F7F5EE" class="td">
				    <p align="center">
				    ${sagoVo16.controlDate}
				    </p>
				</td>
				<td class="td">
				    <p align="center">
				    ${sagoVo16.controlMemoSpan}
				    </p>
				</td>
				<td class="td">
				    <p align="center">
				    ${sagoVo16.controlWho}
				    </p>
				</td>
			    <td class="td">
				    <p align="center">
				    ${sagoVo16.controlRelation}
				    </p>
			    </td>
			    <td class="td">
				    <p align="center">
				    ${sagoVo16.controlContact}
				    </p>
			    </td>
			</tr>
		</c:forEach>		
			
		</TABLE>
		        </td>
		    </tr>
	</table>
	
	<script language="JavaScript">
		window.print();
	</script>
	
</body>

</html>