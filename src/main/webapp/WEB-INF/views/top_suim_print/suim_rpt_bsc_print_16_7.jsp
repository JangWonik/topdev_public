<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<script>
		$(document).ready(function(){
			
			/* 1. 관련자 면담 특이 사항 수정 취소하기 */
			$("#editeBody16_7ContentsCancelBtnId").click(function(){
				
				$(".print16_7SpanClass").css("display","inline");
				$(".print16_7InputClass").css("display","none");	
				$("#editeBody16_7ContentsCancelBtnId").css("display","none");
				$("#editeBody16_7ContentsOkBtnId").css("display","none");
				$("#rptBody16_7UdtActionBtn").css("display","inline");
				$("#print16_7ShowHideBtnId").css("display","none");
				$("#print16_7SampleImg").css("display","none");
				
			});
			
			/* 관련자 면담 특이 사항 수정 Ok 하기 */
			$("#editeBody16_7ContentsOkBtnId").click(function(){
				
				$.post("./editeBody16_7Ok",
						{	
							 rptPrintNo			:"${suimRptBody16_1267Vo.rptPrintNo}"
							,faceMemo7	  	:$("#faceMemo7").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')			//사고내용
							,delegate7 		:$("#delegate7").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')			//고지의무
							,questioning7  		:$("#questioning7").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')			//통지의무
							,guideEtc7  	:$("#guideEtc7").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//직업급수
							,moreDocument7  	:$("#moreDocument7").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//의료자문
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									$(".print16_7SpanClass").css("display","inline");
									$(".print16_7InputClass").css("display","none");	
									$("#editeBody16_7ContentsCancelBtnId").css("display","none");
									$("#editeBody16_7ContentsOkBtnId").css("display","none");
									$("#rptBody16_7UdtActionBtn").css("display","inline");
									
									$("#faceMemo7SpanId").html($("#faceMemo7").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#delegate7SpanId").html($("#delegate7").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#questioning7SpanId").html($("#questioning7").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#guideEtc7SpanId").html($("#guideEtc7").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#moreDocument7SpanId").html($("#moreDocument7").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			});
		});
		
		/* 주요쟁점사항 수정 동작 */
		function rptBody16_7UdtAction(){
			
			$(".print16_7SpanClass").css("display","none");
			$(".print16_7InputClass").css("display","inline");
			$("#rptBody16_7UdtActionBtn").css("display","none");
			$("#editeBody16_7ContentsCancelBtnId").css("display","inline");
			$("#editeBody16_7ContentsOkBtnId").css("display","inline");
			
		}
		
	</script>
	
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
    <hr size="1" noshade color="black">
	<table align="center" cellpadding="0" cellspacing="0" width="640">
		<tr>
			<td height="25" width="50%">
				<p class="p2">
					<p><font color="#113F7D">▣ <b>관련자면담 및 특이사항</b></font></p>
				</p>
			</td>
			<td height="25" width="50%">
				<p align="right">
					<c:if test="${suimVO.suimRptState eq 0}">
						<img style = "cursor:pointer; float:right; " id= "rptBody16_7UdtActionBtn" src="./resources/ls_img/btn_edite.gif" onclick="rptBody16_7UdtAction();"/>
						<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody16_7ContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
						<img src="./resources/ls_img/icon_write.gif" title="저장" id = "editeBody16_7ContentsOkBtnId" style="float:right; display:none; cursor:pointer; margin-right:5px;" />
					</c:if>
				</p>
			</td>
		</tr>
	</table>
	<table cellpadding="0" cellspacing="0" align="center" width="600">
		<tr>
			<td bgcolor="#ECECEC" class="td" width="100">
				<p align="center"><b>구분</b></p>
			</td>
			<td colspan="4" class="td" bgcolor="#ECECEC" width="500">
				<p align="center"><b>쟁점사항</b></p>
			</td>
		</tr>
		<tr>
			<td class="td" >
			 	 <p align="center">피보험자<br />(or 유가족<br />면담사항)</p>
              </td>
              <td colspan="4" class="td">
                 <p >
                  	<span class= "print16_7SpanClass" id="faceMemo7SpanId">${suimRptBody16_1267Vo.faceMemo7Span}</span>
                  	<textarea style="width:99%;height:75px;overflow:visible; display:none;" 
                  	class= "print16_7InputClass" id = "faceMemo7" >${suimRptBody16_1267Vo.faceMemo7}</textarea>
             	 </p>
          	</td>
		</tr>
		<tr>
			<td class="td" >
			 	 <p align="center">독립손사<br />(세부정보포함)</p>
              </td>
              <td colspan="4" class="td">
                 <p >
                  	<span class= "print16_7SpanClass" id="delegate7SpanId">${suimRptBody16_1267Vo.delegate7Span}</span>
                  	<textarea style="width:99%;height:75px;overflow:visible; display:none;" 
                  	class= "print16_7InputClass" id = "delegate7" >${suimRptBody16_1267Vo.delegate7}</textarea>
             	 </p>
          	</td>
		</tr>
		<tr>
			<td class="td" >
			 	 <p align="center">탐문내용</p>
              </td>
              <td colspan="4" class="td">
                 <p >
                  	<span class= "print16_7SpanClass" id="questioning7SpanId">${suimRptBody16_1267Vo.questioning7Span}</span>
                  	<textarea style="width:99%;height:75px;overflow:visible; display:none;" 
                  	class= "print16_7InputClass" id = "questioning7" >${suimRptBody16_1267Vo.questioning7}</textarea>
             	 </p>
          	</td>
		</tr>
		<tr>
			<td class="td" >
			 	 <p align="center">안내<br />및 특이사항</p>
              </td>
              <td colspan="4" class="td">
                 <p >
                  	<span class= "print16_7SpanClass" id="guideEtc7SpanId">${suimRptBody16_1267Vo.guideEtc7Span}</span>
                  	<textarea style="width:99%;height:75px;overflow:visible; display:none;" 
                  	class= "print16_7InputClass" id = "guideEtc7" >${suimRptBody16_1267Vo.guideEtc7}</textarea>
             	 </p>
          	</td>
		</tr>
		<tr>
			<td class="td" >
			 	 <p align="center">추가서류창구</p>
              </td>
              <td colspan="4" class="td">
                 <p >
                  	<span class= "print16_7SpanClass" id="moreDocument7SpanId">${suimRptBody16_1267Vo.moreDocument7Span}</span>
                  	<textarea style="width:99%;height:75px;overflow:visible; display:none;" 
                  	class= "print16_7InputClass" id = "moreDocument7" >${suimRptBody16_1267Vo.moreDocument7}</textarea>
             	 </p>
          	</td>
		</tr>
	</table>
</body>
<p>&nbsp;</p>