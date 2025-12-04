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
			
			/* 1. 면부책/사실관계확인 수정 취소하기 */
			$("#editeBody17_6ContentsCancelBtnId").click(function(){
				
				$(".print17_6SpanClass").css("display","inline");
				$(".print17_6InputClass").css("display","none");	
				$("#editeBody17_6ContentsCancelBtnId").css("display","none");
				$("#editeBody17_6ContentsOkBtnId").css("display","none");
				$("#rptBody17_6UdtActionBtn").css("display","inline");
				
			});
			
			/* 청구내용 수정 Ok 하기 */
			$("#editeBody17_6ContentsOkBtnId").click(function(){
				
				$.post("./editeBody17_6Ok",
						{	
							 suimRptNo				: "${suimRptBody17_1356891112Vo.suimRptNo}"
							,exemptionBasis6 		: $("#exemptionBasis6").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')
							,exemptionDtl6 			: $("#exemptionDtl6").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')
							,exemptionProve6		: $("#exemptionProve6").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')
							
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									 
									$(".print17_6SpanClass").css("display","inline");
									$(".print17_6InputClass").css("display","none");	
									$("#editeBody17_6ContentsCancelBtnId").css("display","none");
									$("#editeBody17_6ContentsOkBtnId").css("display","none");
									$("#rptBody17_6UdtActionBtn").css("display","inline");
									
									$("#exemptionBasis6Span").html($("#exemptionBasis6").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#exemptionDtl6Span").html($("#exemptionDtl6").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#exemptionProve6Span").html($("#exemptionProve6").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			});
			
		});
		
		function rptBody17_6UdtAction(){
			
			$(".print17_6SpanClass").css("display","none");
			$(".print17_6InputClass").css("display","inline");
			$("#rptBody17_6UdtActionBtn").css("display","none");
			$("#editeBody17_6ContentsCancelBtnId").css("display","inline");
			$("#editeBody17_6ContentsOkBtnId").css("display","inline");
			
		}
	</script>
	
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
        <hr size="1" noshade color="black">
		<table align="center" cellpadding="0" cellspacing="0" width="640">
           <tr>
	           <td height="25" width="50%">
					<p class="p2"><B>6.
						<c:choose>
							<c:when test="">
								사실관계확인결과
							</c:when>
							<c:otherwise>
								면부책여부
							</c:otherwise>
						</c:choose>
					
					</B></p>
	           </td>
	           <td height="25" width="50%">
					<p align="right">
					<c:if test="${suimVO.suimRptState eq 0}">
						<img style = "cursor:pointer; float:right; " id= "rptBody17_6UdtActionBtn" src="./resources/ls_img/btn_edite.gif" onclick="rptBody17_6UdtAction();"/>
						<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody17_6ContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
						<img src="./resources/ls_img/icon_write.gif" title="저장" id = "editeBody17_6ContentsOkBtnId" style="float:right; display:none; cursor:pointer; margin-right:5px;" />
						</c:if>
					</p>
	           </td>
	       </tr>
	    </table>
		<table cellpadding="0" cellspacing="0" align="center" width="640">
			<tr>
		       <td bgcolor="#ECECEC" class="td" width="210">
					<p align="center"><B>관공서명</B></p>
		       </td>
		       <td bgcolor="#ECECEC" class="td" width="210">
		            <p align="center"><B>문서명</B></p>
		       </td>
		       <td class="td" bgcolor="#ECECEC" width="210">
					<p align="center"><B>비고</B></p>
		       </td>
			</tr>
			<tr>
			    <td class="td" width="210">
					<p>
						<span class= "print17_6SpanClass" id="exemptionBasis6Span">${suimRptBody17_1356891112Vo.exemptionBasis6Span }</span>
		                <textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
		                  	class= "print17_6InputClass" id = "exemptionBasis6" >${suimRptBody17_1356891112Vo.exemptionBasis6}</textarea>
		            </p>
			    </td>
			    <td class="td" width="210">
					<p>
						<span class= "print17_6SpanClass" id="exemptionDtl6Span">${suimRptBody17_1356891112Vo.exemptionDtl6Span }</span>
		                <textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
		                  	class= "print17_6InputClass" id = "exemptionDtl6" >${suimRptBody17_1356891112Vo.exemptionDtl6}</textarea>
		            </p>
			    </td>
			    <td class="td" width="210">
					<p>
						<span class= "print17_6SpanClass" id="exemptionProve6Span">${suimRptBody17_1356891112Vo.exemptionProve6Span }</span>
		                <textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
		                  	class= "print17_6InputClass" id = "exemptionProve6" >${suimRptBody17_1356891112Vo.exemptionProve6}</textarea>
		            </p>
			    </td>
			</tr>
		</table>
</body>
<p>&nbsp;</p>