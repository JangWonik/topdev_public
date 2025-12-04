<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<style type="text/css">

A:link {color: #000000;text-decoration: none; }
A:visited {color: #000000;text-decoration: none;}
A:hover {color:#0000ff;text-decoration: none;}
A:active {color: #000000;text-decoration: none;}

p {color:#000000; font-size:9pt; line-height:130%; margin-top:0; margin-bottom:0; font-family:굴림,굴림체;}
input {border:solid 1 #dcdcdc; background-color:#ffffff; font-size:9pt; ime-mode:active;}
textarea {border:solid 1 #dcdcdc; background-color:#ffffff; font-size:9pt; ime-mode:active;}
in_text {border:solid 1 #000000; font-family:굴림,굴림체; font-size:9pt;}

table {border-collapse:collapse;border-spacing:0; font-size:9pt;}
.td {border:1px solid #cccccc; padding:3px;}
.radio{border:0;}
.btn{border:0;}

body {
background-color:#ffffff;
color:#000000;
font-family:굴림,굴림체;
font-size:9pt;
margin-left:0;margin-right:0;margin-top:0;margin-bottom:0;
color: #000000;
scrollbar-face-color: #FFFFFF;
scrollbar-shadow-color: #CCCCCC; 
scrollbar-highlight-color: #F0F0F0; 
scrollbar-3dlight-color: #CCCCCC;
scrollbar-darkshadow-color: #CCCCCC; 
scrollbar-track-color: #F0F0F0; 
scrollbar-arrow-color: #0083c7;
}

</style>
<title>${title_Session}</title>
<script>
	$(document).ready(function(){
		if('${mbrAuthVo_Session.user_no}' == null || '${mbrAuthVo_Session.mbr_pms_7}' == 0){
			window.opener.location.assign("./logout");
			window.self.close();
		}
	});//ready
</script>
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
<table align="center" cellpadding="0" cellspacing="0" width="604" height="460">
<c:set value="${taxInvDtl}" var="taxInvDtl"/>
    <tr>
        <td width="100%" height="450%" valign="top" background="./resources/ls_img/ls_tax/tax_bg_02.jpg">
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td width="100%" height="35">
                        <p>&nbsp;</p>
                    </td>
                </tr>
                <tr>
                    <td width="100%" height="43" valign="top">
                            <table align="right" cellpadding="0" cellspacing="0" width="300">
                                <tr>
                                    <td width="195">
                        <p align="right">${taxInvDtl.tax_date_y2}</p>
                                    </td>
                                    <td width="105">
                        <p align="right" style="margin-right:25;">${taxInvDtl.tax_invoice_no}</p>
                                    </td>
                                </tr>
                            </table>
                    </td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td width="359" height="30">
                        <p>&nbsp;</p>
                    </td>
                    <td width="245" height="30">
						<P align=center><span style="letter-spacing:13px;">${taxInvDtl.ptnr_biz_reg_no}</span></P>
                    </td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td width="363" height="30">
                        <p>&nbsp;</p>
                    </td>
                    <td width="138" height="30">
                        <p align="center">${taxInvDtl.ptnr_name}</p>
                    </td>
                    <td width="20" height="30">
                        <p>&nbsp;</p>
                    </td>
                    <td width="83" height="30">
                        <p align="center">${taxInvDtl.ptnr_ceo_nm}</p>
                    </td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td width="362" height="30">
                        <p>&nbsp;</p>
                    </td>
                    <td width="242" height="30">
                        <p align="center">${taxInvDtl.ptnr_addr1}<br />${taxInvDtl.ptnr_addr2}</p>
                    </td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td width="362" height="30">
                        <p>&nbsp;</p>
                    </td>
                    <td width="99" height="30">
                        <p align="center">${taxInvDtl.ptnr_biz_type1}</p>
                    </td>
                    <td width="20" height="30">
                        <p>&nbsp;</p>
                    </td>
                    <td width="123" height="30">
                        <p align="center">${taxInvDtl.ptnr_biz_type2}</p>
                    </td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td width="28" height="88">
                        <p>&nbsp;</p>
                        <p align="center">${taxInvDtl.tax_date_y}</p>
                    </td>
                    <td width="24" height="88">
                        <p>&nbsp;</p>
                        <p align="center">${taxInvDtl.tax_date_m}</p>
                    </td>
                    <td width="25" height="88">
                        <p>&nbsp;</p>
                        <p align="center">${taxInvDtl.tax_date_d}</p>
                    </td>
                    <td width="19" height="88">
                        <p>&nbsp;</p>
                        <p align="center">${11 - taxInvDtl.amt_total.length()}</p>
                    </td>
                    <td width="215" height="88">
                        <p>&nbsp;</p>
                        <p align="right"><span style="letter-spacing:13px;">${taxInvDtl.amt_total}</span></p>
                    </td>
                    <td width="293" height="88">
						<p align=center>
							<c:choose>
								<c:when test="${taxInvDtl.ptnr_id == 6}">
									보고번호 : ${taxInvDtl.suim_accept_no}
									<br />
									증권번호 : ${taxInvDtl.policy_no}
								</c:when>
								<c:otherwise>
									${taxInvDtl.policyholder_nm}/${taxInvDtl.beneficiary_nm}
								</c:otherwise>
							</c:choose>
						</p>
					</td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td width="52" height="95" valign="top">
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td width="29" height="24">
                        <p align="center">${taxInvDtl.tax_date_m}</p>
                    </td>
                    <td width="23" height="24">
                        <p align="center">${taxInvDtl.tax_date_d}</p>
                    </td>
                </tr>
            </table>
                    </td>
                    <td width="409" height="95" valign="top">
            <table cellpadding="0" cellspacing="0" width="100%">

                <tr>
                    <td width="124" height="24">
						<p align="center">
							<c:choose>
								<c:when test="${taxInvDtl.ptnr_id == 6}">
									${taxInvDtl.policyholder_nm}
								</c:when>
								<c:otherwise>
									${taxInvDtl.suim_accept_no}
								</c:otherwise>
							</c:choose>
						</p>
                    </td>
                    <td width="185" height="24">
                                    <p align="center">1</p>
                    </td>
                    <td width="100" height="24">
                        <p align="right" style="margin-right:5;"><fmt:formatNumber value="${taxInvDtl.amt_total}" pattern="###,###,##0.##"/></p>
                    </td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td width="124" height="24">
						<p align="center">
							<c:if test="${taxInvDtl.ptnr_id == 6}">
								(${taxInvDtl.damaged_nm})
							</c:if>
						</p>
                    </td>
                    <td width="185" height="24">
						<p align="center">&nbsp;</p>
                    </td>
                    <td width="100" height="24">
                        <p align="right" style="margin-right:5;">&nbsp;</p>
                    </td>
                </tr>
            </table>
                    </td>
                    <td width="143" height="95" valign="top">
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td width="143" height="24">
                                    <p align="center">&nbsp;</p>
                    </td>
                </tr>
            </table>
                    </td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td width="96" height="58">
                        <p>&nbsp;</p>
						<P align=center>\&nbsp;<fmt:formatNumber value="${taxInvDtl.amt_total}" pattern="###,###,##0.##"/></P>
						
                    </td>
                    <td width="508" height="58">
						<P>&nbsp;</P>
                    </td>
                </tr>
            </table>
            <p>&nbsp;</p>
        </td>
    </tr>
</table>

	<script language="JavaScript"> 
		window.print();
	</script>

</body>

</html>
