<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<script>
		$(document).ready(function(){
			
			/* 1. 기타병원_확인내용 수정 취소하기 */
			$("#editeBody9_6ContentsCancelBtnId").click(function(){
				
				$(".print9_6SpanClass").css("display","inline");
				$(".print9_6InputClass").css("display","none");	
				$("#editeBody9_6ContentsCancelBtnId").css("display","none");
				$("#editeBody9_6ContentsOkBtnId").css("display","none");
				$("#rptBody9_6UdtActionBtn").css("display","inline");
				
			});
			
			/* 기타병원_확인내용 수정 Ok 하기 */
			$("#editeBody9_6ContentsOkBtnId").click(function(){
				
				$.post("./editeBody9_6Ok",
						{	
							 rptPrintNo			:"${suimRptBody9_13467Vo.rptPrintNo}"
							,hospitalMemo6  	:$("#hospitalMemo6").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')	//진단명
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									$(".print9_6SpanClass").css("display","inline");
									$(".print9_6InputClass").css("display","none");	
									$("#editeBody9_6ContentsCancelBtnId").css("display","none");
									$("#editeBody9_6ContentsOkBtnId").css("display","none");
									$("#rptBody9_6UdtActionBtn").css("display","inline");

									$("#hospitalMemo6SpanId").html($("#hospitalMemo6").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			});
			
		});
		
		function rptBody9_6UdtAction(){
			
			$(".print9_6SpanClass").css("display","none");
			$(".print9_6InputClass").css("display","inline");
			$("#rptBody9_6UdtActionBtn").css("display","none");
			$("#editeBody9_6ContentsCancelBtnId").css("display","inline");
			$("#editeBody9_6ContentsOkBtnId").css("display","inline");
			
		}
	</script>
	
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
        <hr size="1" noshade color="black">
		<table cellpadding="0" cellspacing="0" align="center" width="640">
			<tr>
				<td bgcolor="#ECECEC" colspan="2" class="td" >
					<p align="left" style="display:inline;"><b>▶ 기타병원 확인내용</b></p>
					<img style = "cursor:pointer; float:right; display:inline; " id= "rptBody9_6UdtActionBtn" src="./resources/ls_img/btn_edite.gif" onclick="rptBody9_6UdtAction();"/>
					<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody9_6ContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
					<img src="./resources/ls_img/icon_write.gif" title="저장" id = "editeBody9_6ContentsOkBtnId" style="float:right; display:none; cursor:pointer; margin-right:5px;" />
				</td>
			</tr>
			<tr>
				<td colspan="2" class="td" >
					<p>
						<span class= "print9_6SpanClass" id="hospitalMemo6SpanId">${suimRptBody9_13467Vo.hospitalMemo6Span }</span>
						<textarea style="width:99%;height:255px;overflow:visible; display:none;" 
	                         class="print9_6InputClass" id = "hospitalMemo6">${suimRptBody9_13467Vo.hospitalMemo6}</textarea>
					</p>
				</td>
			</tr>
	</table>
</body>
<p>&nbsp;</p>