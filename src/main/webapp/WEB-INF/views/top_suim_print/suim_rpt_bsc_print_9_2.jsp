<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<script>
		$(document).ready(function(){
			
			/* 1. 조사결과(요약) 수정 취소하기 */
			$("#editeBody9_2ContentsCancelBtnId").click(function(){
				
				$(".print9_2SpanClass").css("display","inline");
				$(".print9_2InputClass").css("display","none");	
				$("#editeBody9_2ContentsCancelBtnId").css("display","none");
				$("#editeBody9_2ContentsOkBtnId").css("display","none");
				$("#rptBody9_2UdtActionBtn").css("display","inline");
				
			});
			
			/* 조사결과(요약) 수정 Ok 하기 */
			$("#editeBody9_2ContentsOkBtnId").click(function(){
				
				$.post("./editeBody9_2Ok",
						{	
							 rptPrintNo				:"${suimRptBody9_13467Vo.rptPrintNo}"
							,diagnosisDisease3  	:$("#diagnosisDisease3").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//진단명
							,accidentDtl3  			:$("#accidentDtl3").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')			//사고개요
							,inspectPoint3  		:$("#inspectPoint3").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')			//확인사항
							,inspectResult3  		:$("#inspectResult3").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//결론
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									$(".print9_2SpanClass").css("display","inline");
									$(".print9_2InputClass").css("display","none");	
									$("#editeBody9_2ContentsCancelBtnId").css("display","none");
									$("#editeBody9_2ContentsOkBtnId").css("display","none");
									$("#rptBody9_2UdtActionBtn").css("display","inline");

									$("#diagnosisDisease3SpanId").html($("#diagnosisDisease3").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#accidentDtl3SpanId").html($("#accidentDtl3").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#inspectPoint3SpanId").html($("#inspectPoint3").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#inspectResult3SpanId").html($("#inspectResult3").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			});
			
		});
		
		function rptBody9_2UdtAction(){
			
			$(".print9_2SpanClass").css("display","none");
			$(".print9_2InputClass").css("display","inline");
			$("#rptBody9_2UdtActionBtn").css("display","none");
			$("#editeBody9_2ContentsCancelBtnId").css("display","inline");
			$("#editeBody9_2ContentsOkBtnId").css("display","inline");
			
		}
	</script>
	
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
        <hr size="1" noshade color="black">
		<table align="center" cellpadding="0" cellspacing="0" width="640">
			<tr>
				<td height="25" >
					<p class="p2">
						<b>2. 조사결과(요약) 
							<!-- <img src="./resources/ls_img/ls_body/icon_score_zoom.gif" title="샘플 양식 보기" id = "print9_2ShowHideBtnId" style="display:none; cursor:pointer; "  /> -->
						</b>
					</p>
				</td>
				<td height="25">
					<p align="right">
						<img style = "cursor:pointer; float:right; " id= "rptBody9_2UdtActionBtn" src="./resources/ls_img/btn_edite.gif" onclick="rptBody9_2UdtAction();"/>
						<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody9_2ContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
						<img src="./resources/ls_img/icon_write.gif" title="저장" id = "editeBody9_2ContentsOkBtnId" style="float:right; display:none; cursor:pointer; margin-right:5px;" />
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
				<td width="20%"></td>
				<td width="70%"></td>
			</tr>
			<tr>
				<td colspan="2" bgcolor="#ECECEC" class="td" >
					<p align="center"><b>청 구 사 항</b></p>
				</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC">
					<p align="center"><b>진단명</b></p>
				</td>
				<td class="td" >
					<p>
						<span class= "print9_2SpanClass" id="diagnosisDisease3SpanId">${suimRptBody9_13467Vo.diagnosisDisease3Span }</span>
						<textarea style="width:99%;height:55px;overflow:visible; display:none;" 
	                         class="print9_2InputClass" id = "diagnosisDisease3">${suimRptBody9_13467Vo.diagnosisDisease3}</textarea>
					</p>
				</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" >
					<p align="center"><b>사고개요</b></p>
				</td>
				<td class="td" >
					<p>
						<span class= "print9_2SpanClass" id="accidentDtl3SpanId">${suimRptBody9_13467Vo.accidentDtl3Span }</span>
						<textarea style="width:99%;height:55px;overflow:visible; display:none;" 
	                         class="print9_2InputClass" id = "accidentDtl3">${suimRptBody9_13467Vo.accidentDtl3}</textarea>
					</p>
				</td>
			</tr>
			<tr>
              <td colspan="2" class="td"  bgcolor="#ECECEC" >
				<p align="center"><b>조 사 결 과</b></p>
              </td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC">
					<p align="center"><b>확인사항</b></p>
				</td>
				<td class="td">
					<p>
						<span class= "print9_2SpanClass" id="inspectPoint3SpanId">${suimRptBody9_13467Vo.inspectPoint3Span }</span>
						<textarea style="width:99%;height:55px;overflow:visible; display:none;" 
	                         class="print9_2InputClass" id = "inspectPoint3">${suimRptBody9_13467Vo.inspectPoint3}</textarea>
					</p>
				</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC">
					<p align="center"><b>결론</b></p>
				</td>
				<td class="td">
					<p>
						<span class= "print9_2SpanClass" id="inspectResult3SpanId">${suimRptBody9_13467Vo.inspectResult3 }</span>
						<textarea style="width:99%;height:55px;overflow:visible; display:none;" 
	                         class="print9_2InputClass" id = "inspectResult3">${suimRptBody9_13467Vo.inspectResult3}</textarea>
					</p>
				</td>
			</tr>
	</table>
</body>
<p>&nbsp;</p>