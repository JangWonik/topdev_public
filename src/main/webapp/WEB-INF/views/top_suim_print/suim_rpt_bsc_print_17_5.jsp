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
			
			/* 1. 형사기록 수정 취소하기 */
			$("#editeBody17_5ContentsCancelBtnId").click(function(){
				
				$(".print17_5SpanClass").css("display","inline");
				$(".print17_5InputClass").css("display","none");	
				$("#editeBody17_5ContentsCancelBtnId").css("display","none");
				$("#editeBody17_5ContentsOkBtnId").css("display","none");
				$("#rptBody17_5UdtActionBtn").css("display","inline");
				
			});
			
			/* 청구내용 수정 Ok 하기 */
			$("#editeBody17_5ContentsOkBtnId").click(function(){
				
				$.post("./editeBody17_5Ok",
						{	
							 suimRptNo			: "${suimRptBody17_1356891112Vo.suimRptNo}"
							,recordPublic5 		: $("#recordPublic5").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')
							,recordDocNm5 		: $("#recordDocNm5").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')
							,recordDtl5			: $("#recordDtl5").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')
							,recordEtc5			: $("#recordEtc5").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')
							
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									 
									$(".print17_5SpanClass").css("display","inline");
									$(".print17_5InputClass").css("display","none");	
									$("#editeBody17_5ContentsCancelBtnId").css("display","none");
									$("#editeBody17_5ContentsOkBtnId").css("display","none");
									$("#rptBody17_5UdtActionBtn").css("display","inline");
									
									$("#recordPublic5Span").html($("#recordPublic5").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#recordDocNm5Span").html($("#recordDocNm5").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#recordDtl5Span").html($("#recordDtl5").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#recordEtc5Span").html($("#recordEtc5").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			});
			
		});
		
		function rptBody17_5UdtAction(){
			
			$(".print17_5SpanClass").css("display","none");
			$(".print17_5InputClass").css("display","inline");
			$("#rptBody17_5UdtActionBtn").css("display","none");
			$("#editeBody17_5ContentsCancelBtnId").css("display","inline");
			$("#editeBody17_5ContentsOkBtnId").css("display","inline");
			
		}
	</script>
	
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
        <hr size="1" noshade color="black">
		<table align="center" cellpadding="0" cellspacing="0" width="640">
           <tr>
	           <td height="25" width="50%">
					<p class="p2"><B>5. 형사기록</B></p>
	           </td>
	           <td height="25" width="50%">
					<p align="right">
					<c:if test="${suimVO.suimRptState eq 0}">
						<img style = "cursor:pointer; float:right; " id= "rptBody17_5UdtActionBtn" src="./resources/ls_img/btn_edite.gif" onclick="rptBody17_5UdtAction();"/>
						<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody17_5ContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
						<img src="./resources/ls_img/icon_write.gif" title="저장" id = "editeBody17_5ContentsOkBtnId" style="float:right; display:none; cursor:pointer; margin-right:5px;" />
						</c:if>
					</p>
	           </td>
	       </tr>
	    </table>
	<table cellpadding="0" cellspacing="0" align="center" width="640">
		<tr>
	       <td bgcolor="#ECECEC" class="td" width="155">
				<p align="center"><B>관공서명</B></p>
	       </td>
	       <td bgcolor="#ECECEC" class="td" width="155">
	            <p align="center"><B>문서명</B></p>
	       </td>
	       <td bgcolor="#ECECEC" class="td" width="155">
	            <p align="center"><B>내용</B></p>
	       </td>
	       <td class="td" bgcolor="#ECECEC" width="155">
				<p align="center"><B>비고</B></p>
	       </td>
		</tr>
		<tr>
		    <td class="td" width="155">
				<p>
					<span class= "print17_5SpanClass" id="recordPublic5Span">${suimRptBody17_1356891112Vo.recordPublic5Span }</span>
	                <textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_5InputClass" id = "recordPublic5" >${suimRptBody17_1356891112Vo.recordPublic5}</textarea>
	            </p>
		    </td>
		    <td class="td" width="155">
				<p>
					<span class= "print17_5SpanClass" id="recordDocNm5Span">${suimRptBody17_1356891112Vo.recordDocNm5Span }</span>
	                <textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_5InputClass" id = "recordDocNm5" >${suimRptBody17_1356891112Vo.recordDocNm5}</textarea>
	            </p>
		    </td>
		    <td class="td" width="155">
				<p>
					<span class= "print17_5SpanClass" id="recordDtl5Span">${suimRptBody17_1356891112Vo.recordDtl5Span }</span>
	                <textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_5InputClass" id = "recordDtl5" >${suimRptBody17_1356891112Vo.recordDtl5}</textarea>
	            </p>
		    </td>
		    <td class="td" width="155">
				<p>
					<span class= "print17_5SpanClass" id="recordEtc5Span">${suimRptBody17_1356891112Vo.recordEtc5Span }</span>
	                <textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_5InputClass" id = "recordEtc5" >${suimRptBody17_1356891112Vo.recordEtc5}</textarea>
	            </p>
		    </td>
		</tr>
	</table>
</body>
<p>&nbsp;</p>