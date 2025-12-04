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
			
			/* 1. 조사결과 요약 수정 취소하기 */
			$("#editeBody17_9ContentsCancelBtnId").click(function(){
				
				$(".print17_9SpanClass").css("display","inline");
				$(".print17_9InputClass").css("display","none");	
				$("#editeBody17_9ContentsCancelBtnId").css("display","none");
				$("#editeBody17_9ContentsOkBtnId").css("display","none");
				$("#rptBody17_9UdtActionBtn").css("display","inline");
				
			});
			
			/* 조사결과 수정 Ok 하기 */
			$("#editeBody17_9ContentsOkBtnId").click(function(){
				
				$.post("./editeBody17_9Ok",
						{	
							 suimRptNo				: "${suimRptBody17_1356891112Vo.suimRptNo}"
							,inspectResult9 		: $("#inspectResult9").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')
							,inspectInsist9 		: $("#inspectInsist9").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')
							,inspectBasis9		: $("#inspectBasis9").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')
							
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									 
									$(".print17_9SpanClass").css("display","inline");
									$(".print17_9InputClass").css("display","none");	
									$("#editeBody17_9ContentsCancelBtnId").css("display","none");
									$("#editeBody17_9ContentsOkBtnId").css("display","none");
									$("#rptBody17_9UdtActionBtn").css("display","inline");
									
									$("#inspectResult9Span").html($("#inspectResult9").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#inspectInsist9Span").html($("#inspectInsist9").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#inspectBasis9Span").html($("#inspectBasis9").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			});
			
		});
		
		function rptBody17_9UdtAction(){
			
			$(".print17_9SpanClass").css("display","none");
			$(".print17_9InputClass").css("display","inline");
			$("#rptBody17_9UdtActionBtn").css("display","none");
			$("#editeBody17_9ContentsCancelBtnId").css("display","inline");
			$("#editeBody17_9ContentsOkBtnId").css("display","inline");
			
		}
	</script>
	
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
        <hr size="1" noshade color="black">
		<table align="center" cellpadding="0" cellspacing="0" width="640">
           <tr>
	           <td height="25" width="50%">
					<p class="p2"><B>9. 
					<c:choose>
						<c:when test="${suimRptBody17_1356891112Vo.chungguTypeCode eq 0}">
							<span id = "print17ContractTitle">계약자 및 피보험자 주장</span>
						</c:when>
						<c:otherwise>
							<span id = "print17ContractTitle">조사결과요약</span>					
						</c:otherwise>
					</c:choose>
					
					</B></p>
	           </td>
	           <td height="25" width="50%">
					<p align="right">
					<c:if test="${suimVO.suimRptState eq 0}">
						<img style = "cursor:pointer; float:right; " id= "rptBody17_9UdtActionBtn" src="./resources/ls_img/btn_edite.gif" onclick="rptBody17_9UdtAction();"/>
						<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody17_9ContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
						<img src="./resources/ls_img/icon_write.gif" title="저장" id = "editeBody17_9ContentsOkBtnId" style="float:right; display:none; cursor:pointer; margin-right:5px;" />
					</c:if>
					</p>
	           </td>
	       </tr>
	    </table>
	<table cellpadding="0" cellspacing="0" align="center" width="640">
		<tr>
	       <td bgcolor="#ECECEC" class="td" width="180">
				<p align="center"><B>조사결과</B></p>
	       </td>
	       <td bgcolor="#ECECEC" class="td" width="290">
	            <p align="center"><B>계약자/피보험자 주장</B></p>
	       </td>
	       <td class="td" bgcolor="#ECECEC" width="160">
				<p align="center"><B>근거자료</B></p>
	       </td>
		</tr>
		<tr>
		    <td class="td" width="180">
				<p>
					<span class= "print17_9SpanClass" id="inspectResult9Span">${suimRptBody17_1356891112Vo.inspectResult9Span }</span>
	                <textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_9InputClass" id = "inspectResult9" >${suimRptBody17_1356891112Vo.inspectResult9}</textarea>
	            </p>
		    </td>
		    <td class="td" width="290">
				<p>
					<span class= "print17_9SpanClass" id="inspectInsist9Span">${suimRptBody17_1356891112Vo.inspectInsist9Span }</span>
	                <textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_9InputClass" id = "inspectInsist9" >${suimRptBody17_1356891112Vo.inspectInsist9}</textarea>
	            </p>
		    </td>
		    <td class="td" width="160">
				<p>
					<span class= "print17_9SpanClass" id="inspectBasis9Span">${suimRptBody17_1356891112Vo.inspectBasis9Span }</span>
	                <textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_9InputClass" id = "inspectBasis9" >${suimRptBody17_1356891112Vo.inspectBasis9}</textarea>
	            </p>
		    </td>
		</tr>
	</table>
</body>
<p>&nbsp;</p>