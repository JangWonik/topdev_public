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
			
			/* 1. 피보험자 면답내용 수정 취소하기 */
			$("#editeBody17_3ContentsCancelBtnId").click(function(){
				
				$(".print17_3SpanClass").css("display","inline");
				$(".print17_3InputClass").css("display","none");	
				$("#editeBody17_3ContentsCancelBtnId").css("display","none");
				$("#editeBody17_3ContentsOkBtnId").css("display","none");
				$("#rptBody17_3UdtActionBtn").css("display","inline");
				
			});
			
			/* 청구내용 수정 Ok 하기 */
			$("#editeBody17_3ContentsOkBtnId").click(function(){
				
				$.post("./editeBody17_3Ok",
						{	
							 suimRptNo		: "${suimRptBody17_1356891112Vo.suimRptNo}"
							,faceDate3 		: $("#faceDate3").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')
							,faceDtl3 		: $("#faceDtl3").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')
							,moreDocument3	: $("#moreDocument3").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')
							
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									 
									$(".print17_3SpanClass").css("display","inline");
									$(".print17_3InputClass").css("display","none");	
									$("#editeBody17_3ContentsCancelBtnId").css("display","none");
									$("#editeBody17_3ContentsOkBtnId").css("display","none");
									$("#rptBody17_3UdtActionBtn").css("display","inline");
									
									$("#faceDate3Span").html($("#faceDate3").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#faceDtl3Span").html($("#faceDtl3").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#moreDocument3Span").html($("#moreDocument3").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			});
			
		});
		
		function rptBody17_3UdtAction(){
			
			$(".print17_3SpanClass").css("display","none");
			$(".print17_3InputClass").css("display","inline");
			$("#rptBody17_3UdtActionBtn").css("display","none");
			$("#editeBody17_3ContentsCancelBtnId").css("display","inline");
			$("#editeBody17_3ContentsOkBtnId").css("display","inline");
			
		}
	</script>
	
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
        <hr size="1" noshade color="black">
		<table align="center" cellpadding="0" cellspacing="0" width="640">
             <tr>
                <td height="25" width="50%">
					<p class="p2"><B>3. 피보험자 면담내용</B></p>
                </td>
                <td height="25" width="50%">
					<p align="right">
					<c:if test="${suimVO.suimRptState eq 0}">
						<img style = "cursor:pointer; float:right; " id= "rptBody17_3UdtActionBtn" src="./resources/ls_img/btn_edite.gif" onclick="rptBody17_3UdtAction();"/>
						<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody17_3ContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
						<img src="./resources/ls_img/icon_write.gif" title="저장" id = "editeBody17_3ContentsOkBtnId" style="float:right; display:none; cursor:pointer; margin-right:5px;" />
						</c:if>
					</p>
                </td>
             </tr>
        </table>
        <table cellpadding="0" cellspacing="0" align="center" width="640">
           	<tr>
                <td align="center" bgcolor="#ECECEC" class="td" width="140">
					<p align="center"><B>구 &nbsp;분</B></p>
                </td>
                <td class="td" bgcolor="#ECECEC" width="500">
					<p align="center"><B>내 &nbsp;용</B></p>
                </td>
			</tr>
            <tr>
                <td align="center" class="td" width="140" bgcolor="#ECECEC">
                    <p><b>면담일시</b></p>
                </td>
                <td class="td" width="440">
                    <p>
                    	<span class= "print17_3SpanClass" id="faceDate3Span">${suimRptBody17_1356891112Vo.faceDate3Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_3InputClass" id = "faceDate3" >${suimRptBody17_1356891112Vo.faceDate3}</textarea>
                    </p>
                </td>
            </tr>
            <tr>
                <td align="center" class="td" width="140" bgcolor="#ECECEC">
                    <p><b>면담장소/면담내용</b></p>
                </td>
                <td class="td" width="440">
                    <p>
                    	<span class= "print17_3SpanClass" id="faceDtl3Span">${suimRptBody17_1356891112Vo.faceDtl3Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_3InputClass" id = "faceDtl3" >${suimRptBody17_1356891112Vo.faceDtl3}</textarea>
                    </p>
                </td>
            </tr>
            <tr>
                <td align="center" class="td" nowrap width="140" bgcolor="#ECECEC">
                    <p><b>징구서류</b></p>
                </td>
                <td class="td" width="440">
                    <p>
                    	<span class= "print17_3SpanClass" id="moreDocument3Span">${suimRptBody17_1356891112Vo.moreDocument3Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_3InputClass" id = "moreDocument3" >${suimRptBody17_1356891112Vo.moreDocument3}</textarea>
                    </p>
                </td>
			</tr>
        </table>
</body>
<p>&nbsp;</p>