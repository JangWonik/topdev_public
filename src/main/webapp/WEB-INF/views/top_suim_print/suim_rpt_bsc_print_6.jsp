<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	
	<script>
		$(document).ready(function(){
	
			$("#editeBodyContentsOkBtnId").click(function(){
				var serialNo = "${suimRptBodyVo.serialNo}";
				
				$.post("./suimRptBody6EditeOk",
						{	
							 serialNo  		: serialNo
					 		,requestDtl 	: $("#requestDtl").val()
					 		,daysInpatient 	: $("#daysInpatient").val()
					 		,daysOutpatient : $("#daysOutpatient").val()
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("저장 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									
									$("#rptBody6UdtActionBtn").css("display","inline");
									$("#editeBodyContentsCancelBtnId").css("display","none");
									$("#editeBodyContentsOkBtnId").css("display","none");
									
									$(".suimRptBodyContentsSpan").css("display","inline");
									$(".suimRptBodyContentsInput").css("display","none");
									
									$("#requestDtlSpan").html($("#requestDtl").val());
									$("#daysInpatientSpan").html($("#daysInpatient").val());
									$("#daysOutpatientSpan").html($("#daysOutpatient").val());
									
									$("#requestDtlContents").html($("#requestDtl").val());
									$("#daysInpatientContents").html($("#daysInpatient").val());
									$("#daysOutpatientContents").html($("#daysOutpatient").val());
									
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
				
			});
			
			$("#rptBody6WordOut").click(function(){
				
// 				if("${suimVO.suimRptState}" != 2){
// 					alert("종결건이 아니면 인쇄할 수 없습니다.");
// 					return;
// 				}
				
				var cw=screen.availWidth;
				var ch=screen.availHeight;
				
				var sw=1010; //띄울 창의 넓이
				var sh=740;  //띄울 창의 높이
		
				var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
				var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
				
				window.open('suimRptBody6PrintOut?suimRptNo='+'${suimRptBodyVo.suimRptNo}'+'&serialNo='+'${suimRptBodyVo.serialNo}'+'&type=word','tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			});
			
			$("#rptBody6PageOut").click(function(){
				
// 				if("${suimVO.suimRptState}" != 2){
// 					alert("종결건이 아니면 인쇄할 수 없습니다.");
// 					return;
// 				}
				
				var cw=screen.availWidth;
				var ch=screen.availHeight;
				
				var sw=700; //띄울 창의 넓이
				var sh=550;  //띄울 창의 높이
		
				var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
				var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
				
				window.open('suimRptBody6PrintOut?suimRptNo='+'${suimRptBodyVo.suimRptNo}'+'&serialNo='+'${suimRptBodyVo.serialNo}'+'&type=page','_blank','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			});
			
		});
		
		function rptBody6UdtAction(){
			
			$("#rptBody6UdtActionBtn").css("display","none");
			$("#editeBodyContentsCancelBtnId").css("display","inline");
			$("#editeBodyContentsOkBtnId").css("display","inline");
			
			$(".suimRptBodyContentsSpan").css("display","none");
			$(".suimRptBodyContentsInput").css("display","inline");
			
			$("#requestDtl").val($("#requestDtlSpan").html());
			$("#daysInpatient").val($("#daysInpatientSpan").html());
			$("#daysOutpatient").val($("#daysOutpatientSpan").html());
			
		}
		
		function editeCancelBodyContents(){
			
			$("#rptBody6UdtActionBtn").css("display","inline");
			$("#editeBodyContentsCancelBtnId").css("display","none");
			$("#editeBodyContentsOkBtnId").css("display","none");
			
			$(".suimRptBodyContentsSpan").css("display","inline");
			$(".suimRptBodyContentsInput").css("display","none");
		}
		
		
		
	</script>
	
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
	<table id = "rptBody6Table" align="center" cellpadding="0" cellspacing="0" width="640">
		<tr>
			<td>
				<p align="right">
					<img src="./resources/ls_img/report/btn_word.gif" id ="rptBody6WordOut" title ="워드 출력" style="cursor:pointer;" border="0">
					<img src="./resources/ls_img/report/icon_print.gif" id ="rptBody6PageOut" title ="화면 인쇄" style="cursor:pointer;" border="0">
				</p>
				<p align="center"><img src="https://www.toplac.co.kr/resources/ls_img/ls_body/print_head.jpg" width="640" height="56" border="0"></p>
				<p align="center" style="line-height:50%; margin-top:0; margin-bottom:0;">&nbsp;</p>
				<p align="center"><span style="font-size:9pt;">${tmInforForBody.team_addr}</span></p> 
				<p align="center"><span style="font-size:9pt;">전화 : ${tmInforForBody.team_interphone} &nbsp;팩스 : ${tmInforForBody.team_fax} &nbsp;이메일 : ${mbrVoForBody.email}</span></p>
				<hr size="1" width="640" noshade color="black">
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<table cellpadding="0" cellspacing="0" width="640" align="center">
					<tr>
						<th width="85" height="30" align="center">
							<p>수 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;신</p>
						</th>
						<th width="350" align="left">
							<p>: ${suimVO.ptnr_name}</p>
						</th>
						<th width="90" align="right">
							<p>Report No.</p>
						</th>
						<th width="115" align="left">
							<p>&nbsp;${suimVO.suim_accept_no}</p>
						</th>
					</tr>
					<tr>
						<th height="30" width="85" align="center">
							<p>참 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;조</p>
						</th>
						<th width="350" align="left">
							<p>: ${suimVO.ptnr_dept_nm} 
							<c:if test="${suimVO.ptnr_mbr_nm ne ''}">
								(담당 : ${suimVO.ptnr_mbr_nm} 님)
							</c:if></p>
						</th>
						<th width="90" align="right">
							<p>Date.</p>
						</th>
						<th width="115" align="left">
							<p>&nbsp;
							<c:if test="${suimInvVO.invoiceDate eq '' or suimInvVO.invoiceDate eq null}">
								날짜 정보없음
							</c:if>
							<c:if test="${suimInvVO.invoiceDate ne '' or suimInvVO.invoiceDate ne null}">
								${suimInvVO.invoiceDate }
							</c:if>
								
							</p>
						</th>
					</tr>
					<tr>
						<th height="30" width="85" align="center">
							<p>제 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</p>
						</th>
						<th width="555" colspan="3" align="left">
							<p>: ${suimVO.insurance_nm} 
								<c:if test="${suimVO.policyholder_nm ne ''}">
									&quot;<b>${suimVO.policyholder_nm}</b>&quot;
								</c:if>
								 손해사정서
							 </p>
						</th>
					</tr>
					<tr>
						<th height="30" width="85" align="center">
							<p>수 &nbsp;&nbsp;임 &nbsp;&nbsp;일</p>
						</th>
						<th width="555" colspan="3" align="left">
							<p>: ${suimVO.reg_date} </p>
						</th>
					</tr>
					<tr>
						<th height="30" width="85" align="center">
							<p>사 고 번 호</p>
						</th>
						<th width="555" colspan="3" align="left">
							<p>: ${suimVO.accident_no}</p>
						</th>
					</tr>
				</table>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<table cellpadding="0" cellspacing="0"  align="center" width="640">
					<tr>
						<td class="td_box" width="100%">
							<p>&nbsp;1. 귀사에서 손해사정 의뢰하신 ${suimVO.policyholder_nm }(${suimVO.policyholder_ssn })님의 보험금 청구와 관련하여</p>
							<table cellpadding="0" cellspacing="0">
								<tr>
									<td nowrap>
										<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(청구내용: <span id = "requestDtlContents">${suimRptBodyVo.requestDtl}</span> 
											<c:if test="${suimRptBodyVo.daysInpatient ne '' }">
												<br />
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												입원일: <span id = "daysInpatientContents">${suimRptBodyVo.daysInpatient }</span>
											</c:if>
											<c:if test="${suimRptBodyVo.daysOutpatient ne '' }">
												<br />
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												통원일: <span id = "daysOutpatientContents">${suimRptBodyVo.daysOutpatient }</span>									
											</c:if>
											)
										</p>	
									</td>
								</tr>
						    </table>
							<p>&nbsp;2. 본 보고서는 최대 선의의 원칙에 의거하여 이해 당사자 어느 일방에도 치우침 없이 작성하였음을</p>
							<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명백히 합니다.</p>
						</td>
					</tr>
	            </table>
				<p>&nbsp;</p>
				<div  align="right">
				<table cellpadding="0" cellspacing="0" width="640">
	                <!-- <tr>
	                    <td height="70" width="500">
	                        <p>&nbsp;</p>
	                        <p>&nbsp;</p>
	                        <p align="right">손해사정사</p>
	                    </td>
	                    <td width="65">
	                        <p>&nbsp;</p>
	                        <p>&nbsp;</p>
	                        <p>&nbsp;: 윤경수</p>
	                    </td>
	                    <td width="75" rowspan="2">
	                        <p><img src="./resources/ls_img/ls_body/sign_yoon.jpg" width="72" height="70" border="0"></p>
	                    </td>
	                </tr>
	                <tr>
	                    <td width="565" colspan="2">
	                        <p align="right">070-8255-3000</p>
	                    </td>
	                </tr> -->
	                <%-- 담당 손해사정사 정보로 변경 시작 --%>               	               	               	
					<c:forEach items="${certiManager4ReportUser}" var="certiUserVo">
						<c:if test="${certiUserVo.certi_state_val eq '손해사정사'}">					
							<tr>
			                    <td height="50" width="500">
			                        <p>&nbsp;</p>
			                        <p>&nbsp;</p>
			                        <p style="text-align:right;padding-right:16px;">${certiUserVo.certi_state_val}</p>
			                    </td>
			                    <td width="65">
			                        <p>&nbsp;</p>
			                        <p>&nbsp;</p>
			                        <p>&nbsp;: ${certiUserVo.user_name}</p>
			                    </td>
			                    <td width="75" rowspan="2">
			                        <p>
			                        	<img src="https://www.toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${certiUserVo.user_no}/${certiUserVo.user_sign}" width="50" height="50">		                        	
			                        </p>
			                    </td>
			                </tr>
			                <tr>
			                    <td width="565" colspan="2">
			                        <p align="right"><c:if test='${certiUserVo.work_phone != ""}'>${certiUserVo.work_phone} </c:if></p>
			                    </td>
			                </tr>
		                </c:if>						
					</c:forEach>
					<%-- 담당 손해사정사 정보로 변경 끝 --%>
	                <tr>
	                    <td height="50" width="500">
	                        <p>&nbsp;</p>
	                        <p align="right">결 &nbsp;&nbsp;재 &nbsp;&nbsp;자 :</p>
	                    </td>
	                    <td width="65">
	                        <p>&nbsp;</p>
	                        <p>&nbsp; ${mbrVoForBodySantion.user_name}</p>
	                    </td>
	                    <td width="75" rowspan="2">
	                        <p>
								<c:choose>
									<c:when test="${mbrVoForBodySantion.user_sign ne null}">
										<%-- <img src="/home/hosting_users/toplac/www/ls_data/member_sign/${mbrVoForBodySantion.user_no}/${mbrVoForBodySantion.user_sign}" width=50 height=50 border=0> --%>	                        	
										<img src="https://toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${mbrVoForBodySantion.user_no}/${mbrVoForBodySantion.user_sign}" width=50 height=50 border=0>
									</c:when>
									<c:otherwise>
										사인 없음
									</c:otherwise>
								</c:choose>
	                        </p>
	                    </td>
	                </tr>
	                <tr>
	                    <td width="565" colspan="2">
	                        <p align="right">${mbrVoForBodySantion.handphone }</p>
	                    </td>
	                </tr>
	                <tr>
	                    <td height="50" width="500">
	                        <p>&nbsp;</p>
	                        <p align="right">조 &nbsp;&nbsp;사 &nbsp;&nbsp;자 :</p>
	                    </td>
	                    <td width="65">
	                        <p>&nbsp;</p>
	                        <p>&nbsp; ${mbrVoForBody.user_name }</p>
	                    </td>
	                    <td width="75" rowspan="2">
	                        <p>
								<c:choose>
									<c:when test="${signVoForRptUser.user_sign ne '' or signVoForRptUser.user_sign ne null}">
										<%-- <img src='/home/hosting_users/toplac/www/ls_data/member_sign/${signVoForRptUser.user_no}/${signVoForRptUser.user_sign}' width=50 height=50 border=0> --%>	                        	
										<img src="https://toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${signVoForRptUser.user_no}/${signVoForRptUser.user_sign}" width=50 height=50 border=0>
									</c:when>
									<c:otherwise>
										사인 없음
									</c:otherwise>
								</c:choose>  
	                        </p>
	                    </td>
	                </tr>
	                <tr>
	                    <td width="565" colspan="2">
	                        <p align="right">${mbrVoForBody.handphone }</p>
	                    </td>
	                </tr>
	            </table>
				</div>
				<p>&nbsp;</p>
	            <hr size="1" noshade color="black">
				<table align="center" cellpadding="0" cellspacing="0" width="640">
					<tr>
						<td height="25" width="50%">
							<p class="p2"><b>1. 보험계약사항</b></p>
						</td>
						<td height="25" width="50%">
							<p align="right">
								<img style = "cursor:pointer; float:right; " id= "rptBody6UdtActionBtn" src="./resources/ls_img/btn_edite.gif" onclick="rptBody6UdtAction('${suimRptBodyVo.serialNo}');"/>
								<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBodyContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " onclick="editeCancelBodyContents();"/>
								<img src="./resources/ls_img/icon_write.gif" title="저장" id = "editeBodyContentsOkBtnId" style="float:right; display:none; cursor:pointer; margin-right:5px;" />
							</p>
						</td>
					</tr>
				</table>
				<table cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="640">
					<tr>
						<td bgcolor="#ECECEC" class="td" width="140">
							<p align="center"><b>구분</b></p>
						</td>
						<td colspan="4" class="td" bgcolor="#ECECEC" width="500">
							<p align="center"><b>내용</b></p>
						</td>
					</tr>
					<tr>
						<td class="td">
							<p align="center">청구내용</p>
						</td>
						<td colspan="4" class="td">
							<p>
								<span class= "suimRptBodyContentsSpan" id="requestDtlSpan">${suimRptBodyVo.requestDtl}</span>
								<input type="text" size= "70" class= "suimRptBodyContentsInput" id = "requestDtl" style="display:none;"/>
								<font color="#cccccc" class= "suimRptBodyContentsInput" style="display:none;"><b>예)</b> 질병입원실손의료비外</font>
							</p>
						</td>
					</tr>
					<tr>
						<td class="td">
							<p align="center">입원일</p>
						</td>
						<td colspan="4" class="td">
							<p>
								<span class= "suimRptBodyContentsSpan" id="daysInpatientSpan">${suimRptBodyVo.daysInpatient}</span>
								<input type="text" size= "70" class= "suimRptBodyContentsInput" id = "daysInpatient" style="display:none;"/>
								<font color="#cccccc" class= "suimRptBodyContentsInput" style="display:none;"><b>예)</b> 0000.00.00 ~ 0000.00.00</font>
							</p>
						</td>
					</tr>
					<tr>
	                    <td class="td">
							<p align="center">통원일</p>
	                    </td>
	                    <td colspan="4" class="td">
	                        <p>
	                        	<span class= "suimRptBodyContentsSpan" id="daysOutpatientSpan">${suimRptBodyVo.daysOutpatient}</span>
	                        	<input type="text" size= "70" class= "suimRptBodyContentsInput" id = "daysOutpatient" style="display:none;"/>
	                        	<font color="#cccccc" class= "suimRptBodyContentsInput" style="display:none;"><b>예)</b> 0000.00.00 ~ 0000.00.00</font>
	                        </p>
	                    </td>
					</tr>
				</table>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
			</td>
		</tr>
	</table>
</body>