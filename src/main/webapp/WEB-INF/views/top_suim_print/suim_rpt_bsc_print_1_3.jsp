<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<script>
		$(document).ready(function(){
			
			/* 1. 사고사항 수정 취소하기 */
			$("#editeBody1_3ContentsCancelBtnId").click(function(){
				
				$(".print1_3SpanClass").css("display","inline");
				$(".print1_3InputClass").css("display","none");	
				$("#editeBody1_3ContentsCancelBtnId").css("display","none");
				$("#editeBody1_3ContentsOkBtnId").css("display","none");
				$("#rptBody1_3UdtActionBtn").css("display","inline");
				$("#print1_3ShowHideBtnId").css("display","none");
				$("#print1_3SampleImg").css("display","none");
				
			});
			
			/* 사고사항 수정 Ok 하기 */
			$("#editeBody1_3ContentsOkBtnId").click(function(){
				
				$.post("./editeBody1_3Ok",
						{	
							 rptPrintNo			:"${suimRptBody1_13467Vo.rptPrintNo}"
							,diagnosisDisease3  :$("#diagnosisDisease3").val()			//질병
							,diagnosisHospital3 :$("#diagnosisHospital3").val()			//병원
							,accidentDtl3  		:$.trim($("#accidentDtl3").html()).replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//사고내용
							,claimDtl3  		:$.trim($("#claimDtl3").html()).replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')			//청구내용	
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									$(".print1_3SpanClass").css("display","inline");
									$(".print1_3InputClass").css("display","none");	
									$("#editeBody1_3ContentsCancelBtnId").css("display","none");
									$("#editeBody1_3ContentsOkBtnId").css("display","none");
									$("#rptBody1_3UdtActionBtn").css("display","inline");
									$("#print1_3ShowHideBtnId").css("display","none");
									$("#print1_3SampleImg").css("display","none");
									
									$("#diagnosisDisease3SpanId").html($("#diagnosisDisease3").val());
									$("#diagnosisHospital3SpanId").html($("#diagnosisHospital3").val());
									$("#accidentDtl3SpanId").html($("#accidentDtl3").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#claimDtl3SpanId").html($("#claimDtl3").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			});
			
			
			/* 사고사항 샘플 이미지 보이기 */
			$("#print1_3ShowHideBtnId").click(function(){
				
				$("#print1_3SampleImg").css("display","block");					
			});
			
		});
		
		function rptBody1_3UdtAction(){
			
			$(".print1_3SpanClass").css("display","none");
			$(".print1_3InputClass").css("display","inline");
			$("#rptBody1_3UdtActionBtn").css("display","none");
			$("#editeBody1_3ContentsCancelBtnId").css("display","inline");
			$("#editeBody1_3ContentsOkBtnId").css("display","inline");
			$("#print1_3ShowHideBtnId").css("display","inline");
			
		}
		
		/* 사고사항 샘플 양식 숨기기 */
		function print1_3ShowHide(){
			$("#print1_3SampleImg").css("display","none");	
		}
		
	</script>
	
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
          <hr size="1" noshade color="black">
			<table align="center" cellpadding="0" cellspacing="0" width="640">
				<tr>
					<td height="25" width="50%">
						<p class="p2">
							<b>3. 사고사항(청구내용) 
								<img src="./resources/ls_img/ls_body/icon_score_zoom.gif" title="샘플 양식 보기" id = "print1_3ShowHideBtnId" style="display:none; cursor:pointer; "  />
							</b>
						</p>
					</td>
					<td height="25" width="50%">
						<p align="right">
							<img style = "cursor:pointer; float:right; " id= "rptBody1_3UdtActionBtn" src="./resources/ls_img/btn_edite.gif" onclick="rptBody1_3UdtAction();"/>
							<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody1_3ContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
							<img src="./resources/ls_img/icon_write.gif" title="저장" id = "editeBody1_3ContentsOkBtnId" style="float:right; display:none; cursor:pointer; margin-right:5px;" />
						</p>
					</td>
				</tr>
				<tr >
					<td colspan="2" align="center">
						<img src="./resources/ls_img/ls_body/1/03.jpg" title="사고 사항 샘플 양식" id = "print1_3SampleImg" style="display:none; cursor:pointer; " onclick="print1_3ShowHide();" />
					</td>
				</tr>
			</table>
			<table cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="640">
			<tr>
				<td bgcolor="#ECECEC" class="td" width="140">
					<p align="center"><b>구분</b></p>
				</td>
				<td colspan="4" class="td" bgcolor="#ECECEC" width="500">
					<p align="center"><b>내용</b></p>
				</td>
			</tr>
			<tr>
				<td class="td">
					<p align="center">진단병명</p>
				</td>
				<td class="td">
					<p>
						<span class= "print1_3SpanClass" id="diagnosisDisease3SpanId">${suimRptBody1_13467Vo.diagnosisDisease3 }</span>
						<input type="text" size= "20" class= "print1_3InputClass" id = "diagnosisDisease3" style="display:none;" value="${suimRptBody1_13467Vo.diagnosisDisease3 }"/>
					</p>
				</td>
				<td class="td" bgcolor="#ECECEC">
					<p align="center">진단병원</p>
				</td>
				<td colspan="2" class="td">
					<p>
						<span class= "print1_3SpanClass" id="diagnosisHospital3SpanId">${suimRptBody1_13467Vo.diagnosisHospital3 }</span>
						<input type="text" size= "20" class= "print1_3InputClass" id = "diagnosisHospital3" style="display:none;" value="${suimRptBody1_13467Vo.diagnosisHospital3 }"/>
					</p>
				</td>
			</tr>
			<tr>
				<td class="td">
					<p align="center">사고일자</p>
				</td>
				<td colspan="4" class="td">
					<p>
						<span>${suimVO.accident_date}</span>
					</p>
				</td>
			</tr>
			<tr>
              <td class="td">
				<p align="center">사고내용</p>
              </td>
              <td  colspan="4" class="td">
                <p >
                	<span class= "print1_3SpanClass" id="accidentDtl3SpanId">${suimRptBody1_13467Vo.accidentDtl3Span }</span>
                	<textarea style="width:99%;height:35px;overflow:visible; display:none;"  
                	class= "print1_3InputClass" id = "accidentDtl3" >${suimRptBody1_13467Vo.accidentDtl3}</textarea>
                </p>
              </td>
		</tr>
		<tr>
			<td class="td" >
			 	 <p align="center">청구내용</p>
              </td>
              <td colspan="4" class="td">
                 <p >
                  	<span class= "print1_3SpanClass" id="claimDtl3SpanId">${suimRptBody1_13467Vo.claimDtl3Span }</span>
                  	<textarea style="width:99%;height:75px;overflow:visible; display:none;" 
                  	class= "print1_3InputClass" id = "claimDtl3" >${suimRptBody1_13467Vo.claimDtl3}</textarea>
             	 </p>
          	</td>
		</tr>
	</table>
</body>
<p>&nbsp;</p>