<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<script>
		$(document).ready(function(){
			
			/* 1. 조사결과(상세) 수정 취소하기 */
			$("#editeBody9_7ContentsCancelBtnId").click(function(){
				
				$(".print9_7SpanClass").css("display","inline");
				$(".print9_7InputClass").css("display","none");	
				$("#editeBody9_7ContentsCancelBtnId").css("display","none");
				$("#editeBody9_7ContentsOkBtnId").css("display","none");
				$("#rptBody9_7UdtActionBtn").css("display","inline");
				
			});
			
			/* 조사결과(상세) 수정 Ok 하기 */
			$("#editeBody9_7ContentsOkBtnId").click(function(){
				
				$.post("./editeBody9_7Ok",
						{	
							 rptPrintNo			:"${suimRptBody9_13467Vo.rptPrintNo}"
							,detailRecord7  	:$("#detailRecord7").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')	//진단명
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									$(".print9_7SpanClass").css("display","inline");
									$(".print9_7InputClass").css("display","none");	
									$("#editeBody9_7ContentsCancelBtnId").css("display","none");
									$("#editeBody9_7ContentsOkBtnId").css("display","none");
									$("#rptBody9_7UdtActionBtn").css("display","inline");

									$("#detailRecord7SpanId").html($("#detailRecord7").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			});
			
		});
		
		function rptBody9_7UdtAction(){
			
			$(".print9_7SpanClass").css("display","none");
			$(".print9_7InputClass").css("display","inline");
			$("#rptBody9_7UdtActionBtn").css("display","none");
			$("#editeBody9_7ContentsCancelBtnId").css("display","inline");
			$("#editeBody9_7ContentsOkBtnId").css("display","inline");
			
		}
	</script>
	
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
        <hr size="1" noshade color="black">
        <table align="center" cellpadding="0" cellspacing="0" width="640">
			<tr>
				<td height="25" >
					<p class="p2">
						<b>5. 조사결과(상세) 
							<!-- <img src="./resources/ls_img/ls_body/icon_score_zoom.gif" title="샘플 양식 보기" id = "print9_7ShowHideBtnId" style="display:none; cursor:pointer; "  /> -->
						</b>
					</p>
				</td>
				<td height="25">
					<p align="right">
						<img style = "cursor:pointer; float:right; " id= "rptBody9_7UdtActionBtn" src="./resources/ls_img/btn_edite.gif" onclick="rptBody9_7UdtAction();"/>
						<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody9_7ContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
						<img src="./resources/ls_img/icon_write.gif" title="저장" id = "editeBody9_7ContentsOkBtnId" style="float:right; display:none; cursor:pointer; margin-right:5px;" />
					</p>
				</td>
			</tr>
			<tr >
				<td colspan="2" align="center">
					<!-- <img src="./resources/ls_img/ls_body/1/03.jpg" title="사고 사항 샘플 양식" id = "print1_3SampleImg" style="display:none; cursor:pointer; " onclick="print1_3ShowHide();" /> -->
				</td>
			</tr>
		</table>
		<table cellpadding="0" cellspacing="0" align="center" width="640">
			<tr>
				<td bgcolor="#ECECEC" colspan="2" class="td" >
					<p align="left" style="display:inline;"><b>▶ 조사결과</b></p>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="td" >
					<p>
						<span class= "print9_7SpanClass" id="detailRecord7SpanId">${suimRptBody9_13467Vo.detailRecord7Span }</span>
						<textarea style="width:99%;height:255px;overflow:visible; display:none;" 
	                         class="print9_7InputClass" id = "detailRecord7">${suimRptBody9_13467Vo.detailRecord7}</textarea>
					</p>
				</td>
			</tr>
	</table>
</body>
<p>&nbsp;</p>