<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<script src="./resources/jquery/jquery.min_1_12.js"></script>
<style type="text/css">
<!--
td {color:#000000; font-size:9pt; line-height:130%; margin-top:0; margin-bottom:0; font-family:돋음,돋음체;}
p {color:#000000; font-size:9pt; line-height:130%; margin-top:0; margin-bottom:0; font-family:돋음,돋음체;}
table {border-collapse:collapse;border-spacing:0; font-size:9pt;}
.td {border:1px solid #000000; padding:3px;}

body {
background-color:#ffffff;
color:#000000;
font-family:굴림,굴림체;
font-size:9pt;
margin-left:0;margin-right:0;margin-top:0;margin-bottom:0;
border: 1px #000000; color: #000000;
}
-->
</style>
<script>
 $(document).ready(function(){
	 print_mark(3, "${mbrVo_Session.user_name}"); 
 });
 
//텍스트 워터마크 삽입
	function print_mark(cnt,userName){
		var mahi = 900/cnt;
		var print_mark = "";
		var print_mark_left = "";
		for(var i=0;i<cnt;i++){
			print_mark ="탑손해사정(주) "+ userName+" "+date('Y-m-d H:i:s',Time())+"&nbsp;&nbsp;&nbsp;";
		}
		
		for(var i=0;i<cnt;i++){
			//$print_mark_left=rand(0,400);
			print_mark_left=0;
			print_mark_top=rand((i-1)*mahi,i*mahi);
			echo"<div id=print_mark_layer1 style=\"width:100%; height:20px; position:absolute; left:"+print_mark_left+"px; top:"+$print_mark_top+"px; z-index:1;\"><p><font color='#EFEFEF'><span style=\"font-size:7pt;sans-serif;line-height:120%;\">"+print_mark+"</span></font></p></div>";
		}
	}
</script>
</head>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
	<table align="center" cellpadding="0" cellspacing="0" width="640">
    <tr>
        <td width="100%" height="100%" valign="top">
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td colspan="4" class="td" height="40">
                        <p align="center" style="line-height:200%;"><B><u>
                        <span style="font-size:11pt;">
                        	사 고 처 리 과 정 표
                        </span></u></B></p>
                    </td>
                    <td class="td" height="40">
                        <p align="center">보고서번호</p>
                    </td>
                    <td class="td" height="40">
						<p>${suimVo.suim_accept_no}</p>
                    </td>
                </tr>
                <tr>
                    <td class="td" height="27">
                        <p align="center">접 수 일 자</p>
                    </td>
                    <td colspan="3" class="td">
                        <p>${suimVo.reg_date }</p>
                    </td>
                    <td class="td">
                        <p align="center">사 고 번 호</p>
                    </td>
                    <td class="td">
						<p>${suimVo.accident_no }</p>
                    </td>
                </tr>
                <tr>
                    <td class="td" height="27">
                        <p align="center">접 수 시 간</p>
                    </td>
                    <td colspan="3" class="td">
                        <p>&nbsp;</p>
                    </td>
                    <td class="td">
                        <p align="center">성 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명</p>
                    </td>
                    <td class="td">
                        <p>&nbsp;</p>
                    </td>
                </tr>
                <tr>
                    <td class="td" height="27">
                        <p align="center">보 &nbsp;&nbsp;험 &nbsp;&nbsp;사</p>
                    </td>
                    <td class="td">
						<p>${suimVo.ptnr_name }</p>
                    </td>
                    <td class="td">
                        <p align="center">부, 팀명</p>
                    </td>
                    <td class="td">
						<p>${suimVo.ptnr_dept_nm }</p>
                    </td>
                    <td class="td">
                        <p align="center">담 &nbsp;&nbsp;당 &nbsp;&nbsp;자</p>
                    </td>
                    <td class="td">
						<p>
							${suimVo.ptnr_mbr_nm }
							<br/>
							${suimVo.ptnr_mbr_office_tel }
						</p>
                    </td>
                </tr>
                <tr>
                    <td class="td" height="27">
                        <p align="center">보 험 종 목</p>
                        <div id=print_mark_layer1 style="width:100%; height:20px; position:absolute; z-index:1; margin-left:-180px;">
                        	<p>
                        		<font color='#EFEFEF'>
	                        		<span style="font-size:7pt;sans-serif;line-height:120%;">
	                        			탑손해사정(주) ${suimVo.user_name} ${timeNow} 탑손해사정(주) ${suimVo.user_name} ${timeNow} 탑손해사정(주) ${suimVo.user_name} ${timeNow}
	                        		</span>
                        		</font>
                        	</p>
                        </div>
                    </td>
                    
                    <td colspan="3" class="td">
						<p>${suimVo.insurance_nm }</p>
                    </td>
                    <td class="td">
                        <p align="center">증 권 번 호</p>
                    </td>
                    <td class="td">
						<p>${suimVo.policy_no }</p>
                    </td>
                </tr>
                <tr>
                    <td rowspan="2" class="td" height="27">
                        <p align="center">계 &nbsp;&nbsp;약 &nbsp;&nbsp;자</p>
                    </td>
                    <td class="td">
                        <p align="center">성 &nbsp;명</p>
                    </td>
                    <td colspan="2" class="td">
						<p>${suimVo.policyholder_nm }</p>
                    </td>
                    <td rowspan="2" class="td">
                        <p align="center">연 &nbsp;&nbsp;락 &nbsp;&nbsp;처</p>
                    </td>
                    <td class="td">
						<p>${suimVo.policyholder_tel }</p>
                    </td>
                </tr>
                <tr>
                    <td class="td">
                        <p align="center">상 &nbsp;호</p>
                    </td>
                    <td colspan="2" class="td">
                        <p>&nbsp;</p>
                    </td>
                    <td class="td">
                        <p>&nbsp;</p>
                    </td>
                </tr>
                <tr>
                    <td class="td" height="27">
                        <p align="center">피 &nbsp;&nbsp;해 &nbsp;&nbsp;자</p>
                    </td>
                    <td colspan="3" class="td">
						<p>${suimVo.damaged_nm }</p>
                    </td>
                    <td class="td">
                        <p align="center">연 &nbsp;&nbsp;락 &nbsp;&nbsp;처</p>
                    </td>
                    <td class="td">
						<p>${suimVo.damaged_tel }</p>
                    </td>
                </tr>
                <tr>
                    <td class="td" height="27">
                        <p align="center">사 고 일 자</p>
                    </td>
                    <td colspan="3" class="td">
						<p>${suimVo.accident_date }</p>
                    </td>
                    <td class="td">
                        <p align="center">사 고 장 소</p>
                    </td>
                    <td class="td">
                        <p>&nbsp;</p>
                    </td>
                </tr>
                <tr>
                    <td class="td" height="27">
                        <p align="center">사 고 내 용</p>
                    </td>
                    <td colspan="5" class="td">
						<p>${suimVo.accident_facts }</p>
                    </td>
                </tr>
                <tr>
                    <td class="td" height="27">
                        <p align="center">보 험 기 간</p>
                    </td>
                    <td colspan="3" class="td">
                        <p>&nbsp;</p>
                    </td>
                    <td class="td">
                        <p align="center">사 고 원 인</p>
                    </td>
                    <td class="td">
                        <p>&nbsp;</p>
                    </td>
                </tr>
                <tr>
                    <td class="td" height="27">
                        <p align="center">손 해 종 류</p>
                    </td>
                    <td colspan="3" class="td">
						<p>
							<c:choose>
								<c:when test="${suimVo.suimRptType1 eq 1 }">
									배상
								</c:when>
								<c:when test="${suimVo.suimRptType1 eq 2 }">
									재물
								</c:when>
								<c:when test="${suimVo.suimRptType1 eq 3 }">
									상해
								</c:when>
								<c:when test="${suimVo.suimRptType1 eq 4 }">
									질병
								</c:when>
								<c:when test="${suimVo.suimRptType1 eq 11 }">
									대인
								</c:when>
								<c:when test="${suimVo.suimRptType1 eq 12 }">
									대물
								</c:when>
								<c:when test="${suimVo.suimRptType1 eq 13 }">
									신종
								</c:when>
								<c:when test="${suimVo.suimRptType1 eq 14 or suimVo.suimRptType1 eq 18}">
									메리츠스피드심사
								</c:when>
							</c:choose>
						</p>
                    </td>
                    <td class="td">
                        <p align="center">조 &nbsp;&nbsp;사 &nbsp;&nbsp;자</p>
                    </td>
                    <td class="td">
						<p>
							${suimVo.user_name }
						</p>
                    </td>
                </tr>
            </table>
            <p>&nbsp;</p>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td width="20" rowspan="5" class="td">
                        <p align="center">피보험자</p>
                         <div id=print_mark_layer1 style="width:100%; height:20px; position:absolute; z-index:1; margin-left:-180px;">
                        	<p>
                        		<font color='#EFEFEF'>
	                        		<span style="font-size:7pt;sans-serif;line-height:120%;">
	                        			탑손해사정(주) ${suimVo.user_name} ${timeNow} 탑손해사정(주) ${suimVo.user_name} ${timeNow} 탑손해사정(주) ${suimVo.user_name} ${timeNow}
	                        		</span>
                        		</font>
                        	</p>
                        </div>
                    </td>
                    <td width="80" class="td" height="27">
                        <p align="center">성 &nbsp;&nbsp;명</p>
                    </td>
                    <td width="220" class="td">
						<p>${suimVo.beneficiary_nm }</p>
                    </td>
                    <td width="20" rowspan="5" class="td">
                        <p align="center">피</p>
                        <p align="center">해</p>
                        <p align="center">자</p>
                    </td>
                    <td width="80" class="td">
                        <p align="center">성 &nbsp;&nbsp;명</p>
                    </td>
                    <td width="220" class="td">
						<p>${suimVo.damaged_nm }</p>
                    </td>
                </tr>
                <tr>
                    <td class="td" height="27">
                        <p align="center">핸드폰</p>
                    </td>
                    <td class="td">
						<p>&nbsp;</p>
                    </td>
                    <td class="td">
                        <p align="center">핸드폰</p>
                    </td>
                    <td class="td">
						<p>&nbsp;</p>
                    </td>
                </tr>
                <tr>
                    <td class="td" height="27">
                        <p align="center">전 &nbsp;&nbsp;화</p>
                    </td>
                    <td class="td">
						<p>${suimVo.beneficiary_tel }</p>
                    </td>
                    <td class="td">
                        <p align="center">전 &nbsp;&nbsp;화</p>
                    </td>
                    <td class="td">
						<p>${suimVo.damaged_tel }</p>
                    </td>
                </tr>
                <tr>
                    <td class="td" height="27">
                        <p align="center">팩 &nbsp;&nbsp;스</p>
                    </td>
                    <td class="td">
                        <p>&nbsp;</p>
                    </td>
                    <td class="td">
                        <p align="center">팩 &nbsp;&nbsp;스</p>
                    </td>
                    <td class="td">
                        <p>&nbsp;</p>
                    </td>
                </tr>
                <tr>
                    <td class="td" height="27">
                        <p align="center">주 &nbsp;&nbsp;소</p>
                    </td>
                    <td class="td">
                        <p>&nbsp;</p>
                        <p>&nbsp;</p>
                        <p>&nbsp;</p>
                    </td>
                    <td class="td">
                        <p align="center">주 &nbsp;&nbsp;소</p>
                    </td>
                    <td class="td">
                        <p>&nbsp;</p>
                        <p>&nbsp;</p>
                        <p>&nbsp;</p>
                    </td>
                </tr>
            </table>
            <p>&nbsp;</p>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td width="100" class="td" height="60">
                        <p align="center">중점 조사</p>
                        <p align="center">사 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;항</p>
                    </td>
                    <td width="540" class="td">
                        <p>&nbsp;</p>
                    </td>
                </tr>
            </table>
            <p>&nbsp;</p>
            <p>◈ 처리과정 (서류접수, 유선통화, 약속 등)</p>
             <div id=print_mark_layer1 style="width:100%; height:20px; position:absolute; z-index:1; margin-left:-180px;">
             	<p>
             		<font color='#EFEFEF'>
              		<span style="font-size:7pt;sans-serif;line-height:120%;">
              			탑손해사정(주) ${suimVo.user_name} ${timeNow} 탑손해사정(주) ${suimVo.user_name} ${timeNow} 탑손해사정(주) ${suimVo.user_name} ${timeNow}
              		</span>
             		</font>
             	</p>
             </div>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td class="td" width="25">
                        <p align="center">No</p>
                    </td>
                    <td class="td" width="99">
                        <p align="center">처리일자</p>
                    </td>
                    <td class="td" width="358">
                        <p align="center">처리내용</p>
                    </td>
                    <td class="td" width="129">
                        <p align="center">팀장 지시 및 결재</p>
                    </td>
                </tr>
                <tr>
                    <td class="td" width="25">
                        <p align="center">1</p>
                    </td>
                    <td class="td" width="99">
                        <p>&nbsp;</p>
                    </td>
                    <td class="td" width="358">
                        <p>&nbsp;</p>
                    </td>
                    <td class="td" width="129">
                        <p>&nbsp;</p>
                    </td>
                </tr>
                <tr>
                    <td class="td" width="25">
                        <p align="center">2</p>
                    </td>
                    <td class="td" width="99">
                        <p>&nbsp;</p>
                    </td>
                    <td class="td" width="358">
                        <p>&nbsp;</p>
                    </td>
                    <td class="td" width="129">
                        <p>&nbsp;</p>
                    </td>
                </tr>
                <tr>
                    <td class="td" width="25">
                        <p align="center">3</p>
                    </td>
                    <td class="td" width="99">
                        <p>&nbsp;</p>
                    </td>
                    <td class="td" width="358">
                        <p>&nbsp;</p>
                    </td>
                    <td class="td" width="129">
                        <p>&nbsp;</p>
                    </td>
                </tr>
                <tr>
                    <td class="td" width="25">
                        <p align="center">4</p>
                    </td>
                    <td class="td" width="99">
                        <p>&nbsp;</p>
                    </td>
                    <td class="td" width="358">
                        <p>&nbsp;</p>
                    </td>
                    <td class="td" width="129">
                        <p>&nbsp;</p>
                    </td>
                </tr>
                <tr>
                    <td class="td" width="25">
                        <p align="center">5</p>
                    </td>
                    <td class="td" width="99">
                        <p>&nbsp;</p>
                    </td>
                    <td class="td" width="358">
                        <p>&nbsp;</p>
                    </td>
                    <td class="td" width="129">
                        <p>&nbsp;</p>
                    </td>
                </tr>
                <tr>
                    <td class="td" width="25">
                        <p align="center">6</p>
                    </td>
                    <td class="td" width="99">
                        <p>&nbsp;</p>
                    </td>
                    <td class="td" width="358">
                        <p>&nbsp;</p>
                    </td>
                    <td class="td" width="129">
                        <p>&nbsp;</p>
                    </td>
                </tr>
                <tr>
                    <td class="td" width="25">
                        <p align="center">7</p>
                    </td>
                    <td class="td" width="99">
                        <p>&nbsp;</p>
                    </td>
                    <td class="td" width="358">
                        <p>&nbsp;</p>
                    </td>
                    <td class="td" width="129">
                        <p>&nbsp;</p>
                    </td>
                </tr>
                <tr>
                    <td class="td" width="25">
                        <p align="center">8</p>
                    </td>
                    <td class="td" width="99">
                        <p>&nbsp;</p>
                    </td>
                    <td class="td" width="358">
                        <p>&nbsp;</p>
                    </td>
                    <td class="td" width="129">
                        <p>&nbsp;</p>
                    </td>
                </tr>
                <tr>
                    <td class="td" width="25">
                        <p align="center">9</p>
                    </td>
                    <td class="td" width="99">
                        <p>&nbsp;</p>
                    </td>
                    <td class="td" width="358">
                        <p>&nbsp;</p>
                    </td>
                    <td class="td" width="129">
                        <p>&nbsp;</p>
                    </td>
                </tr>
                <tr>
                    <td class="td" width="25">
                        <p align="center">10</p>
                    </td>
                    <td class="td" width="99">
                        <p>&nbsp;</p>
                    </td>
                    <td class="td" width="358">
                        <p>&nbsp;</p>
                    </td>
                    <td class="td" width="129">
                        <p>&nbsp;</p>
                    </td>
                </tr>
                <tr>
                    <td class="td" width="25">
                        <p align="center">11</p>
                    </td>
                    <td class="td" width="99">
                        <p>&nbsp;</p>
                    </td>
                    <td class="td" width="358">
                        <p>&nbsp;</p>
                    </td>
                    <td class="td" width="129">
                        <p>&nbsp;</p>
                    </td>
                </tr>
                <tr>
                    <td class="td" width="25">
                        <p align="center">12</p>
                    </td>
                    <td class="td" width="99">
                        <p>&nbsp;</p>
                    </td>
                    <td class="td" width="358">
                        <p>&nbsp;</p>
                    </td>
                    <td class="td" width="129">
                        <p>&nbsp;</p>
                    </td>
                </tr>
                <tr>
                    <td class="td" width="25">
                        <p align="center">13</p>
                    </td>
                    <td class="td" width="99">
                        <p>&nbsp;</p>
                    </td>
                    <td class="td" width="358">
                        <p>&nbsp;</p>
                    </td>
                    <td class="td" width="129">
                        <p>&nbsp;</p>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
	
	<script language="JavaScript">
		window.print();
	</script>
	
</body>

</html>