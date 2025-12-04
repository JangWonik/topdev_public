<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
	<script>
		$(document).ready(function(){
			
			/* 1. 손해사정 결과 수정 취소하기 */
			$("#editeBody1_7ContentsCancelBtnId").click(function(){
				
				$(".print1_7SpanClass").css("display","inline");
				$(".print1_7InputClass").css("display","none");	
				$("#editeBody1_7ContentsCancelBtnId").css("display","none");
				$("#editeBody1_7ContentsOkBtnId").css("display","none");
				$("#rptBody1_7UdtActionBtn").css("display","inline");
				$("#print1_7ShowHideBtnId").css("display","none");
				$("#print1_7SampleImg").css("display","none");
				
			});
			
			/* 손해사정 결과 수정 Ok 하기 */
			$("#editeBody1_7ContentsOkBtnId").click(function(){
				
				$.post("./editeBody1_7Ok",
						{	
							 rptPrintNo					:"${suimRptBody1_13467Vo.rptPrintNo}"
							,adjustResult7 				:$.trim($("#adjustResult7").val()).replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')	// 
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									$(".print1_7SpanClass").css("display","inline");
									$(".print1_7InputClass").css("display","none");	
									$("#editeBody1_7ContentsCancelBtnId").css("display","none");
									$("#editeBody1_7ContentsOkBtnId").css("display","none");
									$("#rptBody1_7UdtActionBtn").css("display","inline");
									$("#print1_7ShowHideBtnId").css("display","none");
									$("#print1_7SampleImg").css("display","none");
									
									$("#adjustResult7SpanId").html($("#adjustResult7").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			});
			
			
			/* 손해사정 결과 샘플 이미지 보이기 */
			$("#print1_7ShowHideBtnId").click(function(){
				
				$("#print1_7SampleImg").css("display","block");					
			});
			
		});
		
		function rptBody1_7UdtAction(){
			
			$(".print1_7SpanClass").css("display","none");
			$(".print1_7InputClass").css("display","inline");
			$("#rptBody1_7UdtActionBtn").css("display","none");
			$("#editeBody1_7ContentsCancelBtnId").css("display","inline");
			$("#editeBody1_7ContentsOkBtnId").css("display","inline");
			$("#print1_7ShowHideBtnId").css("display","inline");
			
		}
		
		/* 손해사정 결과 샘플 양식 숨기기 */
		function print1_7ShowHide(){
			$("#print1_7SampleImg").css("display","none");	
		}
		
	</script>
	
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
        <hr size="1" noshade color="black">
		<table align="center" cellpadding="0" cellspacing="0" width="650">
			<tr>
				<td height="25" >
					<p class="p2">
						<b>7. 손해사정 결과 
							<img src="./resources/ls_img/ls_body/icon_score_zoom.gif" title="샘플 양식 보기" id = "print1_7ShowHideBtnId" style="display:none; cursor:pointer; "  />
						</b>
					</p>
				</td>
				<td height="25">
					<p align="right">
						<img style = "cursor:pointer; float:right; " id= "rptBody1_7UdtActionBtn" src="./resources/ls_img/btn_edite.gif" onclick="rptBody1_7UdtAction();"/>
						<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody1_7ContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
						<img src="./resources/ls_img/icon_write.gif" title="저장" id = "editeBody1_7ContentsOkBtnId" style="float:right; display:none; cursor:pointer; margin-right:5px;" />
					</p>
				</td>
			</tr>
			<tr >
				<td colspan="2" align="center">
					<img src="./resources/ls_img/ls_body/1/07.jpg" title="결과 샘플 양식" id = "print1_7SampleImg" style="display:none; cursor:pointer; " onclick="print1_7ShowHide();" />
				</td>
			</tr>
		</table>
		<table cellpadding="0" cellspacing="0"  align="center" width="650" > 
		<tr>
               <c:choose>
	               <c:when test="${suimRptBody1_13467Vo.adjustResult7Span eq ''}">
	               <td class="td" width="650">
		               	<span class= "print1_7SpanClass" id="adjustResult7SpanId" style="display:none;">
		               		${suimRptBody1_13467Vo.adjustResult7Span}
		               	</span>
		               	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
                  	class= "print1_7InputClass" id = "adjustResult7" >${suimRptBody1_13467Vo.adjustResult7}</textarea>
	               	</td>
	               </c:when>
	               <c:otherwise>
	               <td class="td" width="650">
		               	<span class= "print1_7SpanClass" id="adjustResult7SpanId">
		               		${suimRptBody1_13467Vo.adjustResult7Span}
		               	</span>
		               	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
                  	class= "print1_7InputClass" id = "adjustResult7" >${suimRptBody1_13467Vo.adjustResult7}</textarea>
	               	</td>
	               </c:otherwise>               
               </c:choose>
		</tr>
	</table>
</body>
<p>&nbsp;</p>