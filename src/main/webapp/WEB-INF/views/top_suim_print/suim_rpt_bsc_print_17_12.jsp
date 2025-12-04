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
			
			/* 1. 제3자 개입여부 수정 취소하기 */
			$("#editeBody17_12ContentsCancelBtnId").click(function(){
				
				$(".print17_12SpanClass").css("display","inline");
				$(".print17_12InputClass").css("display","none");	
				$("#editeBody17_12ContentsCancelBtnId").css("display","none");
				$("#editeBody17_12ContentsOkBtnId").css("display","none");
				$("#rptBody17_12UdtActionBtn").css("display","inline");
				
			});
			
			/* 조사결과 수정 Ok 하기 */
			$("#editeBody17_12ContentsOkBtnId").click(function(){
				
				$.post("./editeBody17_12Ok",
						{	
							 suimRptNo				: "${suimRptBody17_1356891112Vo.suimRptNo}"
							,interveneNm12 			: $("#interveneNm12").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')
							,interveneSituation12 	: $("#interveneSituation12").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')
							,interveneStaff12		: $("#interveneStaff12").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')
							,interveneTel12			: $("#interveneTel12").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')
							
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									 
									$(".print17_12SpanClass").css("display","inline");
									$(".print17_12InputClass").css("display","none");	
									$("#editeBody17_12ContentsCancelBtnId").css("display","none");
									$("#editeBody17_12ContentsOkBtnId").css("display","none");
									$("#rptBody17_12UdtActionBtn").css("display","inline");
									
									$("#interveneNm12Span").html($("#interveneNm12").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#interveneSituation12Span").html($("#interveneSituation12").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#interveneStaff12Span").html($("#interveneStaff12").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#interveneTel12Span").html($("#interveneTel12").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			});
			
		});
		
		function rptBody17_12UdtAction(){
			
			$(".print17_12SpanClass").css("display","none");
			$(".print17_12InputClass").css("display","inline");
			$("#rptBody17_12UdtActionBtn").css("display","none");
			$("#editeBody17_12ContentsCancelBtnId").css("display","inline");
			$("#editeBody17_12ContentsOkBtnId").css("display","inline");
			
		}
	</script>
	
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
        <hr size="1" noshade color="black">
		<table align="center" cellpadding="0" cellspacing="0" width="640">
           <tr>
	           <td height="25" width="50%">
					<p class="p2"><B>12. 제3자 개입여부
					
					</B></p>
	           </td>
	           <td height="25" width="50%">
					<p align="right">
					<c:if test="${suimVO.suimRptState eq 0}">
						<img style = "cursor:pointer; float:right; " id= "rptBody17_12UdtActionBtn" src="./resources/ls_img/btn_edite.gif" onclick="rptBody17_12UdtAction();"/>
						<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody17_12ContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
						<img src="./resources/ls_img/icon_write.gif" title="저장" id = "editeBody17_12ContentsOkBtnId" style="float:right; display:none; cursor:pointer; margin-right:5px;" />
					</c:if>
					</p>
	           </td>
	       </tr>
	    </table>
	<table cellpadding="0" cellspacing="0" align="center" width="640">
		<tr>
	       <td bgcolor="#ECECEC" class="td" width="156">
				<p align="center"><B>제3자명</B></p>
	       </td>
	       <td bgcolor="#ECECEC" class="td" width="156">
	            <p align="center"><B>위입경위</B></p>
	       </td>
	       <td class="td" bgcolor="#ECECEC" width="156">
				<p align="center"><B>실제 업무처리자</B></p>
	       </td>
	       <td class="td" bgcolor="#ECECEC" width="156">
				<p align="center"><B>전화번호</B></p>
	       </td>
		</tr>
		<tr>
		    <td class="td" width="156">
				<p>
					<span class= "print17_12SpanClass" id="interveneNm12Span">${suimRptBody17_1356891112Vo.interveneNm12Span }</span>
	                <textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_12InputClass" id = "interveneNm12" >${suimRptBody17_1356891112Vo.interveneNm12}</textarea>
	            </p>
		    </td>
		    <td class="td" width="156">
				<p>
					<span class= "print17_12SpanClass" id="interveneSituation12Span">${suimRptBody17_1356891112Vo.interveneSituation12Span }</span>
	                <textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_12InputClass" id = "interveneSituation12" >${suimRptBody17_1356891112Vo.interveneSituation12}</textarea>
	            </p>
		    </td>
		    <td class="td" width="156">
				<p>
					<span class= "print17_12SpanClass" id="interveneStaff12Span">${suimRptBody17_1356891112Vo.interveneStaff12Span }</span>
	                <textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_12InputClass" id = "interveneStaff12" >${suimRptBody17_1356891112Vo.interveneStaff12}</textarea>
	            </p>
		    </td>
		    <td class="td" width="156">
				<p>
					<span class= "print17_12SpanClass" id="interveneTel12Span">${suimRptBody17_1356891112Vo.interveneTel12Span }</span>
	                <textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_12InputClass" id = "interveneTel12" >${suimRptBody17_1356891112Vo.interveneTel12}</textarea>
	            </p>
		    </td>
		</tr>
	</table>
</body>
<p>&nbsp;</p>