<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
	<script>
		$(document).ready(function(){
			
			/* 1. 조사내용 과거력 수정 취소하기 */
			$("#editeBody1_6_cContentsCancelBtnId").click(function(){
				
				$(".print1_6_cSpanClass").css("display","inline");
				$(".print1_6_cInputClass").css("display","none");	
				$("#editeBody1_6_cContentsCancelBtnId").css("display","none");
				$("#editeBody1_6_cContentsOkBtnId").css("display","none");
				$("#rptBody1_6_cUdtActionBtn").css("display","inline");
				$("#print1_6_cShowHideBtnId").css("display","none");
				$("#print1_6_cSampleImg").css("display","none");
				
			});
			
			/* 조사내용 과거력 수정 Ok 하기 */
			$("#editeBody1_6_cContentsOkBtnId").click(function(){
				
				$.post("./editeBody1_6_cOk",
						{	
							 rptPrintNo			:"${suimRptBody1_13467Vo.rptPrintNo}"
							,pastRespect6  		:$.trim($("#pastRespect6").val()).replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')	// 사항 .replace("\r\n","<br />") $('#BBS_COMMENT_CONTENT').val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;');
							,pastHospital6		:$.trim($("#pastHospital6").val()).replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')	//탐문병원
							,pastResult6		:$.trim($("#pastResult6").val()).replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//탐문결과
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									$(".print1_6_cSpanClass").css("display","inline");
									$(".print1_6_cInputClass").css("display","none");	
									$("#editeBody1_6_cContentsCancelBtnId").css("display","none");
									$("#editeBody1_6_cContentsOkBtnId").css("display","none");
									$("#rptBody1_6_cUdtActionBtn").css("display","inline");
									$("#print1_6_cShowHideBtnId").css("display","none");
									$("#print1_6_cSampleImg").css("display","none");
									
									$("#pastRespect6SpanId").html($("#pastRespect6").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#pastHospital6SpanId").html($("#pastHospital6").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#pastResult6SpanId").html($("#pastResult6").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			});
			
			
			/* 조사내용 과거력 샘플 이미지 보이기 */
			$("#print1_6_cShowHideBtnId").click(function(){
				
				$("#print1_6_cSampleImg").css("display","block");					
			});
			
		});
		
		function rptBody1_6_cUdtAction(){
			
			$(".print1_6_cSpanClass").css("display","none");
			$(".print1_6_cInputClass").css("display","inline");
			$("#rptBody1_6_cUdtActionBtn").css("display","none");
			$("#editeBody1_6_cContentsCancelBtnId").css("display","inline");
			$("#editeBody1_6_cContentsOkBtnId").css("display","inline");
			$("#print1_6_cShowHideBtnId").css("display","inline");
			
		}
		
		/* 조사내용 과거력 샘플 양식 숨기기 */
		function print1_6_cShowHide(){
			$("#print1_6_cSampleImg").css("display","none");	
		}
		
	</script>
	
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
        <hr size="1" noshade color="black">
		<table align="center" cellpadding="0" cellspacing="0" width="648">
			<tr>
				<td height="25" width="50%">
					<p class="p2">
						<b>6-다-1. 조사내용 
							<img src="./resources/ls_img/ls_body/icon_score_zoom.gif" title="샘플 양식 보기" id = "print1_6_cShowHideBtnId" style="display:none; cursor:pointer; "  />
						</b>
					</p>
				</td>
				<td height="25" width="50%">
					<p align="right">
						<img style = "cursor:pointer; float:right; " id= "rptBody1_6_cUdtActionBtn" src="./resources/ls_img/btn_edite.gif" onclick="rptBody1_6_cUdtAction();"/>
						<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody1_6_cContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
						<img src="./resources/ls_img/icon_write.gif" title="저장" id = "editeBody1_6_cContentsOkBtnId" style="float:right; display:none; cursor:pointer; margin-right:5px;" />
					</p>
				</td>
			</tr>
			<tr >
				<td colspan="2" align="center">
					<img src="./resources/ls_img/ls_body/1/06c.jpg" title="조사 사항 샘플 양식" id = "print1_6_cSampleImg" style="display:none; cursor:pointer; " onclick="print1_6_cShowHide();" />
				</td>
			</tr>
		</table>
		<table cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="640">
		<tr>
			<td bgcolor="#ECECEC" class="td" width="648" style="border-bottom:0;">
				<p align="left"><b>다-1. 과거력 확인사항</b></p>
			</td>
		</tr>
		</table>
		<table cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="650">
		<tr>
             <td class="td" width="140" >
				<p align="center">확인사항</p>
             </td>
             <td  colspan="4" class="td" width="501" >
               <p >
	               	<span class= "print1_6_cSpanClass" id="pastRespect6SpanId">${suimRptBody1_13467Vo.pastRespect6Span}</span>
		            <textarea style="text-align:left; width:99%;height:55px;overflow:visible; display:none;" 
	               	 class= "print1_6_cInputClass" id = "pastRespect6" >${suimRptBody1_13467Vo.pastRespect6}</textarea>               	
               </p>
             </td>
		</tr>
		<tr>
			<td class="td" >
			 	 <p align="center">탐문병원</p>
              </td>
              <td colspan="4" class="td">
                 <p >
                  	<span class= "print1_6_cSpanClass" id="pastHospital6SpanId">${suimRptBody1_13467Vo.pastHospital6Span }</span>
                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
                  	class= "print1_6_cInputClass" id = "pastHospital6" >${suimRptBody1_13467Vo.pastHospital6}</textarea>
             	 </p>
          	</td>
		</tr>
		<tr>
			<td class="td" >
			 	 <p align="center">탐문결과</p>
              </td>
              <td colspan="4" class="td">
                 <p >
                  	<span class= "print1_6_cSpanClass" id="pastResult6SpanId">${suimRptBody1_13467Vo.pastResult6Span }</span>
                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
                  	class= "print1_6_cInputClass" id = "pastResult6" >${suimRptBody1_13467Vo.pastResult6}</textarea>
             	 </p>
          	</td>
		</tr>
	</table>
</body>
<p>&nbsp;</p>