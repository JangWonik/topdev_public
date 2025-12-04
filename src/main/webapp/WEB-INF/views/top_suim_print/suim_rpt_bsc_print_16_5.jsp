<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<script>
		$(document).ready(function(){
			
			/* 1. 주요 쟁점 사항 수정 취소하기 */
			$("#editeBody16_5ContentsCancelBtnId").click(function(){
				
				$(".print16_5SpanClass").css("display","inline");
				$(".print16_5InputClass").css("display","none");	
				$("#editeBody16_5ContentsCancelBtnId").css("display","none");
				$("#editeBody16_5ContentsOkBtnId").css("display","none");
				$("#rptBody16_5UdtActionBtn").css("display","inline");
				
			});
			
			/* 주요 쟁점 사항 수정 Ok 하기 */
			$("#editeBody16_5ContentsOkBtnId").click(function(){
				
				$.post("./editeBody16_5Ok",
						{	
							 rptPrintNo			:"${suimRptBody16_1267Vo.rptPrintNo}"
							,accidentDtl6	  	:$("#accidentDtl6").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')			//사고내용
							,noticeDuty16 		:$("#noticeDuty16").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')			//고지의무
							,noticeDuty26  		:$("#noticeDuty26").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')			//통지의무
							,jobGradeConfirm6  	:$("#jobGradeConfirm6").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//직업급수
							,counselMedical6  	:$("#counselMedical6").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//의료자문
							,counselLegal6  	:$("#counselLegal6").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')			//법률자문
							,confirmPublic6  	:$("#confirmPublic6").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//관공서확인내용
							,sitePicture6  		:$("#sitePicture6").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')			//사고현장사진
							,disability6  		:$("#disability6").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')			//장해율
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									$(".print16_5SpanClass").css("display","inline");
									$(".print16_5InputClass").css("display","none");	
									$("#editeBody16_5ContentsCancelBtnId").css("display","none");
									$("#editeBody16_5ContentsOkBtnId").css("display","none");
									$("#rptBody16_5UdtActionBtn").css("display","inline");

									$("#accidentDtl6SpanId").html($("#accidentDtl6").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#noticeDuty16SpanId").html($("#noticeDuty16").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#noticeDuty26SpanId").html($("#noticeDuty26").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#jobGradeConfirm6SpanId").html($("#jobGradeConfirm6").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#counselMedical6SpanId").html($("#counselMedical6").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#counselLegal6SpanId").html($("#counselLegal6").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#confirmPublic6SpanId").html($("#confirmPublic6").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#sitePicture6SpanId").html($("#sitePicture6").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#disability6SpanId").html($("#disability6").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			});
		});
		
		/* 주요쟁점사항 수정 동작 */
		function rptBody16_5UdtAction(){
			
			$(".print16_5SpanClass").css("display","none");
			$(".print16_5InputClass").css("display","inline");
			$("#rptBody16_5UdtActionBtn").css("display","none");
			$("#editeBody16_5ContentsCancelBtnId").css("display","inline");
			$("#editeBody16_5ContentsOkBtnId").css("display","inline");
			
		}
		
	</script>
	
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
    <hr size="1" noshade color="black">
	<table align="center" cellpadding="0" cellspacing="0" width="640">
		<tr>
			<td height="25" width="50%">
				<p class="p2">
					<p><font color="#113F7D">▣ <b>주요쟁점사항</b></font></p>
				</p>
			</td>
			<td height="25" width="50%">
				<p align="right">
					<c:if test="${suimVO.suimRptState eq 0}">
						<img style = "cursor:pointer; float:right; " id= "rptBody16_5UdtActionBtn" src="./resources/ls_img/btn_edite.gif" onclick="rptBody16_5UdtAction();"/>
						<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody16_5ContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
						<img src="./resources/ls_img/icon_write.gif" title="저장" id = "editeBody16_5ContentsOkBtnId" style="float:right; display:none; cursor:pointer; margin-right:5px;" />
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
			 	 <p align="center">사고내용</p>
              </td>
              <td colspan="4" class="td">
                 <p >
                  	<span class= "print16_5SpanClass" id="accidentDtl6SpanId">${suimRptBody16_1267Vo.accidentDtl6Span}</span>
                  	<textarea style="width:99%;height:75px;overflow:visible; display:none;" 
                  	class= "print16_5InputClass" id = "accidentDtl6" >${suimRptBody16_1267Vo.accidentDtl6}</textarea>
             	 </p>
          	</td>
		</tr>
		<tr>
			<td class="td" >
			 	 <p align="center">고지의무</p>
              </td>
              <td colspan="4" class="td">
                 <p >
                  	<span class= "print16_5SpanClass" id="noticeDuty16SpanId">${suimRptBody16_1267Vo.noticeDuty16Span}</span>
                  	<textarea style="width:99%;height:75px;overflow:visible; display:none;" 
                  	class= "print16_5InputClass" id = "noticeDuty16" >${suimRptBody16_1267Vo.noticeDuty16}</textarea>
             	 </p>
          	</td>
		</tr>
		<tr>
			<td class="td" >
			 	 <p align="center">통지의무</p>
              </td>
              <td colspan="4" class="td">
                 <p >
                  	<span class= "print16_5SpanClass" id="noticeDuty26SpanId">${suimRptBody16_1267Vo.noticeDuty26Span}</span>
                  	<textarea style="width:99%;height:75px;overflow:visible; display:none;" 
                  	class= "print16_5InputClass" id = "noticeDuty26" >${suimRptBody16_1267Vo.noticeDuty26}</textarea>
             	 </p>
          	</td>
		</tr>
		<tr>
			<td class="td" >
			 	 <p align="center">직업급수(확인)</p>
              </td>
              <td colspan="4" class="td">
                 <p >
                  	<span class= "print16_5SpanClass" id="jobGradeConfirm6SpanId">${suimRptBody16_1267Vo.jobGradeConfirm6Span}</span>
                  	<textarea style="width:99%;height:75px;overflow:visible; display:none;" 
                  	class= "print16_5InputClass" id = "jobGradeConfirm6" >${suimRptBody16_1267Vo.jobGradeConfirm6}</textarea>
             	 </p>
          	</td>
		</tr>
		<tr>
			<td class="td" >
			 	 <p align="center">의료자문</p>
              </td>
              <td colspan="4" class="td">
                 <p >
                  	<span class= "print16_5SpanClass" id="counselMedical6SpanId">${suimRptBody16_1267Vo.counselMedical6Span}</span>
                  	<textarea style="width:99%;height:75px;overflow:visible; display:none;" 
                  	class= "print16_5InputClass" id = "counselMedical6" >${suimRptBody16_1267Vo.counselMedical6}</textarea>
             	 </p>
          	</td>
		</tr>
		<tr>
			<td class="td" >
			 	 <p align="center">법률자문</p>
              </td>
              <td colspan="4" class="td">
                 <p >
                  	<span class= "print16_5SpanClass" id="counselLegal6SpanId">${suimRptBody16_1267Vo.counselLegal6Span}</span>
                  	<textarea style="width:99%;height:75px;overflow:visible; display:none;" 
                  	class= "print16_5InputClass" id = "counselLegal6" >${suimRptBody16_1267Vo.counselLegal6}</textarea>
             	 </p>
          	</td>
		</tr>
		<tr>
			<td class="td" >
			 	 <p align="center">관공서확인내용<br />(경찰서 등)</p>
              </td>
              <td colspan="4" class="td">
                 <p >
                  	<span class= "print16_5SpanClass" id="confirmPublic6SpanId">${suimRptBody16_1267Vo.confirmPublic6Span}</span>
                  	<textarea style="width:99%;height:75px;overflow:visible; display:none;" 
                  	class= "print16_5InputClass" id = "confirmPublic6" >${suimRptBody16_1267Vo.confirmPublic6}</textarea>
             	 </p>
          	</td>
		</tr>
		<tr>
			<td class="td" >
			 	 <p align="center">사고현장사진</p>
              </td>
              <td colspan="4" class="td">
                 <p >
                  	<span class= "print16_5SpanClass" id="sitePicture6SpanId">${suimRptBody16_1267Vo.sitePicture6Span}</span>
                  	<textarea style="width:99%;height:75px;overflow:visible; display:none;" 
                  	class= "print16_5InputClass" id = "sitePicture6" >${suimRptBody16_1267Vo.sitePicture6}</textarea>
             	 </p>
          	</td>
		</tr>
		<tr>
			<td class="td" >
			 	 <p align="center">장해율/<br />장해상태확인</p>
              </td>
              <td colspan="4" class="td">
                 <p >
                  	<span class= "print16_5SpanClass" id="disability6SpanId">${suimRptBody16_1267Vo.disability6Span}</span>
                  	<textarea style="width:99%;height:75px;overflow:visible; display:none;" 
                  	class= "print16_5InputClass" id = "disability6" >${suimRptBody16_1267Vo.disability6}</textarea>
             	 </p>
          	</td>
		</tr>
	</table>
</body>
<p>&nbsp;</p>