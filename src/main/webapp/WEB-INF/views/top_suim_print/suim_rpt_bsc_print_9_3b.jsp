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
			
			/* 1. 조사내용(요약) 가. 수정 취소하기 */
			$("#editeBody9_3bContentsCancelBtnId").click(function(){
				
				$(".print9_3bSpanClass").css("display","inline");
				$(".print9_3bInputClass").css("display","none");	
				$("#editeBody9_3bContentsCancelBtnId").css("display","none");
				$("#editeBody9_3bContentsOkBtnId").css("display","none");
				$("#rptBody9_3bUdtActionBtn").css("display","inline");
				$("#print9_3bShowHideBtnId").css("display","none");
				
			});
			
			/* 조사내용(요약) 가. 수정 Ok 하기 */
			$("#editeBody9_3bContentsOkBtnId").click(function(){
				
				$.post("./editeBody9_3bOk",
						{	
							 rptPrintNo					:"${suimRptBody9_13467Vo.rptPrintNo}"
							,faceContractSituation4		:$("#faceContractSituation4").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')	//
							,faceInformSignYn4			:$("#faceInformSignYn4").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')	//
							,faceOtherInsuMemo4			:$("#faceOtherInsuMemo4").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')	//
							,faceInsuredDemand4			:$("#faceInsuredDemand4").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')	//
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									$(".print9_3bSpanClass").css("display","inline");
									$(".print9_3bInputClass").css("display","none");	
									$("#editeBody9_3bContentsCancelBtnId").css("display","none");
									$("#editeBody9_3bContentsOkBtnId").css("display","none");
									$("#rptBody9_3bUdtActionBtn").css("display","inline");
									
									$("#faceContractSituation4SpanId").html($("#faceContractSituation4").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#faceInformSignYn4SpanId").html($("#faceInformSignYn4").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#faceOtherInsuMemo4SpanId").html($("#faceOtherInsuMemo4").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#faceInsuredDemand4SpanId").html($("#faceInsuredDemand4").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			});
			
		});
		
		function rptBody9_3bUdtAction(){
			
			$(".print9_3bSpanClass").css("display","none");
			$(".print9_3bInputClass").css("display","inline");
			$("#rptBody9_3bUdtActionBtn").css("display","none");
			$("#editeBody9_3bContentsCancelBtnId").css("display","inline");
			$("#editeBody9_3bContentsOkBtnId").css("display","inline");
			
		}
	</script>
	
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
        <hr size="1" noshade color="black">
		<table align="center" cellpadding="0" cellspacing="0" width="640">
			<tr>
				<td height="25" width="70%">
					<p class="p2">
						<b>3. 조사내용(요약) : 가. 피보험자 면담사항
							<!-- <img src="./resources/ls_img/ls_body/icon_score_zoom.gif" title="샘플 양식 보기" id = "print9_3bShowHideBtnId" style="display:none; cursor:pointer; "  /> -->
						</b>
					</p>
				</td>
				<td height="25" width="30%">
					<p align="right">
						<img style = "cursor:pointer; float:right; " id= "rptBody9_3bUdtActionBtn" src="./resources/ls_img/btn_edite.gif" onclick="rptBody9_3bUdtAction();"/>
						<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody9_3bContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
						<img src="./resources/ls_img/icon_write.gif" title="저장" id = "editeBody9_3bContentsOkBtnId" style="float:right; display:none; cursor:pointer; margin-right:5px;" />
					</p>
				</td>
			</tr>
			<tr >
				<td colspan="2" align="center">
					<!-- <img src="./resources/ls_img/ls_body/1/06.jpg" title="조사 사항 샘플 양식" id = "print1_6SampleImg" style="display:none; cursor:pointer; " onclick="print1_6ShowHide();" /> -->
				</td>
			</tr>
		</table>
		<table cellpadding="0" cellspacing="0"  align="center" width="640" > 
			<tr>
				<td bgcolor="#ECECEC" class="td" width="140" style="border-bottom:0px;">
					<p align="center"><b>구      분</b></p>
				</td>
				<td colspan="3" class="td" bgcolor="#ECECEC" width="460" style="border-bottom:0px;">
					<p align="center"><b>내           용</b></p>
				</td>
			</tr>
		</table>
		<table cellpadding="0" cellspacing="0"  align="center" >
		<tr>
			<td class="td" bgcolor="#ECECEC" width="140" >
			 	 <p align="center"><b>보험가입경위</b></p>
              </td>
              <td class="td" width="460" >
                 <p >
                  	<span class= "print9_3bSpanClass" id="faceContractSituation4SpanId">${suimRptBody9_13467Vo.faceContractSituation4Span }</span>
                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
                  	class= "print9_3bInputClass" id = "faceContractSituation4" >${suimRptBody9_13467Vo.faceContractSituation4}</textarea>
             	 </p>
          	</td>
		</tr>
		<tr>
			<td class="td" bgcolor="#ECECEC">
			 	 <p align="center"><b>중요사항 고지 및<br />자필서명 여부</b></p>
              </td>
              <td class="td">
                 <p >
                  	<span class= "print9_3bSpanClass" id="faceInformSignYn4SpanId">${suimRptBody9_13467Vo.faceInformSignYn4Span }</span>
                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
                  	class= "print9_3bInputClass" id = "faceInformSignYn4" >${suimRptBody9_13467Vo.faceInformSignYn4}</textarea>
             	 </p>
          	</td>
		</tr>
		<tr>
			<td class="td" bgcolor="#ECECEC">
			 	 <p align="center"><b>타 보험확인사항</b></p>
              </td>
              <td class="td">
                 <p >
                  	<span class= "print9_3bSpanClass" id="faceOtherInsuMemo4SpanId">${suimRptBody9_13467Vo.faceOtherInsuMemo4Span }</span>
                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
                  	class= "print9_3bInputClass" id = "faceOtherInsuMemo4" >${suimRptBody9_13467Vo.faceOtherInsuMemo4}</textarea>
             	 </p>
          	</td>
		</tr>
		
		<tr>
			<td class="td" bgcolor="#ECECEC">
			 	 <p align="center"><b>피보험자 요청사항</b></p>
              </td>
              <td class="td">
                 <p >
                  	<span class= "print9_3bSpanClass" id="faceInsuredDemand4SpanId">${suimRptBody9_13467Vo.faceInsuredDemand4Span }</span>
                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
                  	class= "print9_3bInputClass" id = "faceInsuredDemand4" >${suimRptBody9_13467Vo.faceInsuredDemand4}</textarea>
             	 </p>
          	</td>
		</tr>
	</table>
</body>
<p>&nbsp;</p>