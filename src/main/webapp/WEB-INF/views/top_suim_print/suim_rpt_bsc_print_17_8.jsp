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
			
			/* 1. 계약체결경위 취소하기 */
			$("#editeBody17_8ContentsCancelBtnId").click(function(){
				
				$(".print17_8SpanClass").css("display","inline");
				$(".print17_8InputClass").css("display","none");	
				$("#editeBody17_8ContentsCancelBtnId").css("display","none");
				$("#editeBody17_8ContentsOkBtnId").css("display","none");
				$("#rptBody17_8UdtActionBtn").css("display","inline");
				
			});
			
			/* 청구내용 수정 Ok 하기 */
			$("#editeBody17_8ContentsOkBtnId").click(function(){
				
				$.post("./editeBody17_8Ok",
						{	
							 suimRptNo				: "${suimRptBody17_1356891112Vo.suimRptNo}"
							,contractAgent8 		: $("#contractAgent8").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')
							,contractRelation8 		: $("#contractRelation8").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')
							,contractSituation8		: $("#contractSituation8").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')
							
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									 
									$(".print17_8SpanClass").css("display","inline");
									$(".print17_8InputClass").css("display","none");	
									$("#editeBody17_8ContentsCancelBtnId").css("display","none");
									$("#editeBody17_8ContentsOkBtnId").css("display","none");
									$("#rptBody17_8UdtActionBtn").css("display","inline");
									
									$("#contractAgent8Span").html($("#contractAgent8").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#contractRelation8Span").html($("#contractRelation8").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#contractSituation8Span").html($("#contractSituation8").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			});
			
		});
		
		function rptBody17_8UdtAction(){
			
			$(".print17_8SpanClass").css("display","none");
			$(".print17_8InputClass").css("display","inline");
			$("#rptBody17_8UdtActionBtn").css("display","none");
			$("#editeBody17_8ContentsCancelBtnId").css("display","inline");
			$("#editeBody17_8ContentsOkBtnId").css("display","inline");
			
		}
	</script>
	
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
        <hr size="1" noshade color="black">
		<table align="center" cellpadding="0" cellspacing="0" width="640">
           <tr>
	           <td height="25" width="50%">
					<p class="p2"><B>8. 계약체결경위
					
					</B></p>
	           </td>
	           <td height="25" width="50%">
					<p align="right">
					<c:if test="${suimVO.suimRptState eq 0}">
						<img style = "cursor:pointer; float:right; " id= "rptBody17_8UdtActionBtn" src="./resources/ls_img/btn_edite.gif" onclick="rptBody17_8UdtAction();"/>
						<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody17_8ContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
						<img src="./resources/ls_img/icon_write.gif" title="저장" id = "editeBody17_8ContentsOkBtnId" style="float:right; display:none; cursor:pointer; margin-right:5px;" />
						</c:if>
					</p>
	           </td>
	       </tr>
	    </table>
	<table cellpadding="0" cellspacing="0" align="center" width="640">
		<tr>
	       <td bgcolor="#ECECEC" class="td" width="180">
				<p align="center"><B>모집인명</B></p>
	       </td>
	       <td bgcolor="#ECECEC" class="td" width="290">
	            <p align="center"><B>계약자/피보험자 와의 관계</B></p>
	       </td>
	       <td class="td" bgcolor="#ECECEC" width="160">
				<p align="center"><B>근거자료</B></p>
	       </td>
		</tr>
		<tr>
		    <td class="td" width="180">
				<p>
					<span class= "print17_8SpanClass" id="contractAgent8Span">${suimRptBody17_1356891112Vo.contractAgent8Span }</span>
	                <textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_8InputClass" id = "contractAgent8" >${suimRptBody17_1356891112Vo.contractAgent8}</textarea>
	            </p>
		    </td>
		    <td class="td" width="290">
				<p>
					<span class= "print17_8SpanClass" id="contractRelation8Span">${suimRptBody17_1356891112Vo.contractRelation8Span }</span>
	                <textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_8InputClass" id = "contractRelation8" >${suimRptBody17_1356891112Vo.contractRelation8}</textarea>
	            </p>
		    </td>
		    <td class="td" width="160">
				<p>
					<span class= "print17_8SpanClass" id="contractSituation8Span">${suimRptBody17_1356891112Vo.contractSituation8Span }</span>
	                <textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_8InputClass" id = "contractSituation8" >${suimRptBody17_1356891112Vo.contractSituation8}</textarea>
	            </p>
		    </td>
		</tr>
	</table>
</body>
<p>&nbsp;</p>