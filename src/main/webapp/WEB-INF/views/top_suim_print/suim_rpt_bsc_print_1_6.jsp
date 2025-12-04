<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%
    pageContext.setAttribute("cr", "\r"); //Space
    pageContext.setAttribute("cn", "\n"); //Enter
    pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
    pageContext.setAttribute("br", "<br/>"); //br 태그
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
	<script>
		$(document).ready(function(){
			
			/* 1. 조사내용 수정 취소하기 */
			$("#editeBody1_6ContentsCancelBtnId").click(function(){
				
				$(".print1_6SpanClass").css("display","inline");
				$(".print1_6InputClass").css("display","none");	
				$("#editeBody1_6ContentsCancelBtnId").css("display","none");
				$("#editeBody1_6ContentsOkBtnId").css("display","none");
				$("#rptBody1_6UdtActionBtn").css("display","inline");
				$("#print1_6ShowHideBtnId").css("display","none");
				$("#print1_6SampleImg").css("display","none");
				
			});
			
			/* 조사내용 수정 Ok 하기 */
			$("#editeBody1_6ContentsOkBtnId").click(function(){
				
				$.post("./editeBody1_6Ok",
						{	
							 rptPrintNo					:"${suimRptBody1_13467Vo.rptPrintNo}"
							,faceOutline6  				:$.trim($("#faceOutline6").val())	// 
							,faceInsuredJob6			:$.trim($("#faceInsuredJob6").val()).replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')	//
							,faceContractSituation6		:$.trim($("#faceContractSituation6").val()).replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')	//
							,faceOccurSituation6		:$.trim($("#faceOccurSituation6").val()).replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')	//
							,faceInformSignYn6			:$.trim($("#faceInformSignYn6").val()).replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')	//
							,faceEtcMemo6				:$.trim($("#faceEtcMemo6").val()).replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')	//
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									$(".print1_6SpanClass").css("display","inline");
									$(".print1_6InputClass").css("display","none");	
									$("#editeBody1_6ContentsCancelBtnId").css("display","none");
									$("#editeBody1_6ContentsOkBtnId").css("display","none");
									$("#rptBody1_6UdtActionBtn").css("display","inline");
									$("#print1_6ShowHideBtnId").css("display","none");
									$("#print1_6SampleImg").css("display","none");
									
									$("#faceOutline6SpanId").html($("#faceOutline6").val());
									$("#faceInsuredJob6SpanId").html($("#faceInsuredJob6").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#faceContractSituation6SpanId").html($("#faceContractSituation6").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#faceOccurSituation6SpanId").html($("#faceOccurSituation6").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#faceInformSignYn6SpanId").html($("#faceInformSignYn6").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#faceEtcMemo6SpanId").html($("#faceEtcMemo6").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			});
			
			
			/* 조사내용 샘플 이미지 보이기 */
			$("#print1_6ShowHideBtnId").click(function(){
				
				$("#print1_6SampleImg").css("display","block");					
			});
			
		});
		
		function rptBody1_6UdtAction(){
			
			$(".print1_6SpanClass").css("display","none");
			$(".print1_6InputClass").css("display","inline");
			$("#rptBody1_6UdtActionBtn").css("display","none");
			$("#editeBody1_6ContentsCancelBtnId").css("display","inline");
			$("#editeBody1_6ContentsOkBtnId").css("display","inline");
			$("#print1_6ShowHideBtnId").css("display","inline");
			
		}
		
		/* 조사내용 샘플 양식 숨기기 */
		function print1_6ShowHide(){
			$("#print1_6SampleImg").css("display","none");	
		}
		
	</script>
	
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
        <hr size="1" noshade color="black">
		<table align="center" cellpadding="0" cellspacing="0" width="640">
			<tr>
				<td height="25" >
					<p class="p2">
						<b>6-가. 조사내용 
							<img src="./resources/ls_img/ls_body/icon_score_zoom.gif" title="샘플 양식 보기" id = "print1_6ShowHideBtnId" style="display:none; cursor:pointer; "  />
						</b>
					</p>
				</td>
				<td height="25">
					<p align="right">
						<img style = "cursor:pointer; float:right; " id= "rptBody1_6UdtActionBtn" src="./resources/ls_img/btn_edite.gif" onclick="rptBody1_6UdtAction();"/>
						<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody1_6ContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
						<img src="./resources/ls_img/icon_write.gif" title="저장" id = "editeBody1_6ContentsOkBtnId" style="float:right; display:none; cursor:pointer; margin-right:5px;" />
					</p>
				</td>
			</tr>
			<tr >
				<td colspan="2" align="center">
					<img src="./resources/ls_img/ls_body/1/06.jpg" title="조사 사항 샘플 양식" id = "print1_6SampleImg" style="display:none; cursor:pointer; " onclick="print1_6ShowHide();" />
				</td>
			</tr>
		</table>
		<table cellpadding="0" cellspacing="0"  align="center" width="640" > 
		<tr>
			<td bgcolor="#ECECEC" class="td" width="649"colspan="2" style="border-bottom:0;" >
				<p align="left"><b>가.</b>
				<span id = "faceOutline6SpanId" class="print1_6SpanClass">${suimRptBody1_13467Vo.faceOutline6}</span>
				<c:choose>
					<c:when test="${suimRptBody1_13467Vo.faceOutline6 eq '' }">
						<input type="text" style="display:none;" size="70" class="print1_6InputClass" id = "faceOutline6" value="피보험자(${suimVO.beneficiary_nm})면담"/>				
					</c:when>
					<c:otherwise>
						<input type="text" style="display:none;" size="70" class="print1_6InputClass" id = "faceOutline6" value="${suimRptBody1_13467Vo.faceOutline6}"/>
					</c:otherwise>
				</c:choose>
				</p>
			</td>
		</tr>
		</table>
		<table cellpadding="0" cellspacing="0"  align="center" >
		<tr>
             <td class="td" bgcolor="#ECECEC" width="130">
			<p align="center">피보험자직업</p>
             </td>
             <td  class="td" width="510"> 
               <p >
               	<span class= "print1_6SpanClass" id="faceInsuredJob6SpanId">
               		${suimRptBody1_13467Vo.faceInsuredJob6}
               	</span>
               	<input type="text" class="print1_6InputClass" style="display:none;" id = "faceInsuredJob6" value ="${suimRptBody1_13467Vo.faceInsuredJob6 }" />
               </p>
             </td>
		</tr>
		<tr>
			<td class="td" bgcolor="#ECECEC">
			 	 <p align="center">보험가입경위</p>
              </td>
              <td class="td">
                 <p >
                  	<span class= "print1_6SpanClass" id="faceContractSituation6SpanId">${suimRptBody1_13467Vo.faceContractSituation6Span }</span>
                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
                  	class= "print1_6InputClass" id = "faceContractSituation6" >${suimRptBody1_13467Vo.faceContractSituation6}</textarea>
             	 </p>
          	</td>
		</tr>
		<tr>
			<td class="td" bgcolor="#ECECEC">
			 	 <p align="center">발병경위<br />및<br />사고경위</p>
              </td>
              <td class="td">
                 <p >
                  	<span class= "print1_6SpanClass" id="faceOccurSituation6SpanId">${suimRptBody1_13467Vo.faceOccurSituation6Span }</span>
                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
                  	class= "print1_6InputClass" id = "faceOccurSituation6" >${suimRptBody1_13467Vo.faceOccurSituation6}</textarea>
             	 </p>
          	</td>
		</tr>
		<tr>
			<td class="td" bgcolor="#ECECEC">
			 	 <p align="center">중요사항 고지 및<br />자필서명 여부</p>
              </td>
              <td class="td">
                 <p >
                  	<span class= "print1_6SpanClass" id="faceInformSignYn6SpanId">${suimRptBody1_13467Vo.faceInformSignYn6Span }</span>
                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
                  	class= "print1_6InputClass" id = "faceInformSignYn6" >${suimRptBody1_13467Vo.faceInformSignYn6}</textarea>
             	 </p>
          	</td>
		</tr>
		<tr>
			<td class="td" bgcolor="#ECECEC">
			 	 <p align="center">기타사항</p>
              </td>
              <td class="td">
                 <p >
                  	<span class= "print1_6SpanClass" id="faceEtcMemo6SpanId">${suimRptBody1_13467Vo.faceEtcMemo6Span }</span>
                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
                  	class= "print1_6InputClass" id = "faceEtcMemo6" >${suimRptBody1_13467Vo.faceEtcMemo6}</textarea>
             	 </p>
          	</td>
		</tr>
	</table>
</body>
<p>&nbsp;</p>