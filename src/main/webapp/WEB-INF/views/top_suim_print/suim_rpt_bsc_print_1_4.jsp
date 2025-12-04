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
			
			/* 1. 조사방향 수정 취소하기 */
			$("#editeBody1_4ContentsCancelBtnId").click(function(){
				
				$(".print1_4SpanClass").css("display","inline");
				$(".print1_4InputClass").css("display","none");	
				$("#editeBody1_4ContentsCancelBtnId").css("display","none");
				$("#editeBody1_4ContentsOkBtnId").css("display","none");
				$("#rptBody1_4UdtActionBtn").css("display","inline");
				$("#print1_4ShowHideBtnId").css("display","none");
				$("#print1_4SampleImg").css("display","none");
				
			});
			
			/* 조사방향 수정 Ok 하기 */
			$("#editeBody1_4ContentsOkBtnId").click(function(){
				
				$.post("./editeBody1_4Ok",
						{	
							 rptPrintNo			:"${suimRptBody1_13467Vo.rptPrintNo}"
							,inspectPoint4  	:$.trim($("#inspectPoint4").val()).replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')	// 사항 .replace("\r\n","<br />") $('#BBS_COMMENT_CONTENT').val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;');
							,inspectResult4		:$.trim($("#inspectResult4").val()).replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')	//결과
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									$(".print1_4SpanClass").css("display","inline");
									$(".print1_4InputClass").css("display","none");	
									$("#editeBody1_4ContentsCancelBtnId").css("display","none");
									$("#editeBody1_4ContentsOkBtnId").css("display","none");
									$("#rptBody1_4UdtActionBtn").css("display","inline");
									$("#print1_4ShowHideBtnId").css("display","none");
									$("#print1_4SampleImg").css("display","none");
									
									$("#inspectPoint4SpanId").html($("#inspectPoint4").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#inspectResult4SpanId").html($("#inspectResult4").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			});
			
			
			/* 조사방향 샘플 이미지 보이기 */
			$("#print1_4ShowHideBtnId").click(function(){
				
				$("#print1_4SampleImg").css("display","block");					
			});
			
		});
		
		function rptBody1_4UdtAction(){
			
			/* var inspectPoint4 = $("#inspectPoint4SpanId").html();
			var inspectResult4 = $("#inspectResult4SpanId").html();
			
			$("#inspectPoint4").html(inspectPoint4.replace(/<br>/g,"\r\n"));
			$("#inspectResult4").html(inspectResult4.replace(/<br>/g,"\r\n")); */
			$(".print1_4SpanClass").css("display","none");
			$(".print1_4InputClass").css("display","inline");
			$("#rptBody1_4UdtActionBtn").css("display","none");
			$("#editeBody1_4ContentsCancelBtnId").css("display","inline");
			$("#editeBody1_4ContentsOkBtnId").css("display","inline");
			$("#print1_4ShowHideBtnId").css("display","inline");
			
		}
		
		/* 조사방향 샘플 양식 숨기기 */
		function print1_4ShowHide(){
			$("#print1_4SampleImg").css("display","none");	
		}
		
	</script>
	
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
        <hr size="1" noshade color="black">
		<table align="center" cellpadding="0" cellspacing="0" width="640">
			<tr>
				<td height="25" width="50%">
					<p class="p2">
						<b>4. 조사방향 및 결과 
							<img src="./resources/ls_img/ls_body/icon_score_zoom.gif" title="샘플 양식 보기" id = "print1_4ShowHideBtnId" style="display:none; cursor:pointer; "  />
						</b>
					</p>
				</td>
				<td height="25" width="50%">
					<p align="right">
						<img style = "cursor:pointer; float:right; " id= "rptBody1_4UdtActionBtn" src="./resources/ls_img/btn_edite.gif" onclick="rptBody1_4UdtAction();"/>
						<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody1_4ContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
						<img src="./resources/ls_img/icon_write.gif" title="저장" id = "editeBody1_4ContentsOkBtnId" style="float:right; display:none; cursor:pointer; margin-right:5px;" />
					</p>
				</td>
			</tr>
			<tr >
				<td colspan="2" align="center">
					<img src="./resources/ls_img/ls_body/1/04.jpg" title="조사 사항 샘플 양식" id = "print1_4SampleImg" style="display:none; cursor:pointer; " onclick="print1_4ShowHide();" />
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
			<p align="center">확인사항</p>
             </td>
             <td  colspan="4" class="td">
               <p >
               	<span class= "print1_4SpanClass" id="inspectPoint4SpanId">
               		${suimRptBody1_13467Vo.inspectPoint4Span}
               	</span>
               	
               	<c:choose>
	               	<c:when test="${suimRptBody1_13467Vo.inspectPoint4 eq null or suimRptBody1_13467Vo.inspectPoint4 eq '' }">
	               		<textarea style="text-align:left; width:99%;height:55px;overflow:visible; display:none;" 
               	 class= "print1_4InputClass" id = "inspectPoint4" >① 정확한 사고경위 : 
② 장해적정성 여부 :
③ 타보험사항 확인 :</textarea>
						 
	               	</c:when>
	               	<c:otherwise>
	               		<textarea style="text-align:left; width:99%;height:55px;overflow:visible; display:none;" 
               	 class= "print1_4InputClass" id = "inspectPoint4" >${suimRptBody1_13467Vo.inspectPoint4}</textarea>
	               	</c:otherwise>
               	</c:choose>
               	
               	
               </p>
             </td>
		</tr>
		<tr>
			<td class="td" >
			 	 <p align="center">조사결과</p>
              </td>
              <td colspan="4" class="td">
                 <p >
                  	<span class= "print1_4SpanClass" id="inspectResult4SpanId">${suimRptBody1_13467Vo.inspectResult4Span }</span>
                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
                  	class= "print1_4InputClass" id = "inspectResult4" >${suimRptBody1_13467Vo.inspectResult4}</textarea>
             	 </p>
          	</td>
		</tr>
	</table>
</body>
<p>&nbsp;</p>