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
			
			/* 1. 청구내용 수정 취소하기 */
			$("#editeBody17_2ContentsCancelBtnId").click(function(){
				
				var cungguType = $("input:radio[name='chungguType']:checked").val();
				var cungguTypeFlag = "";
				
				if(cungguType == 1){
					cungguTypeFlag = "a";
				}else if(cungguType == 2){
					cungguTypeFlag = "b";
				}else if(cungguType == 3){
					cungguTypeFlag = "c";
				}else if(cungguType == 4){
					cungguTypeFlag = "d";
				}else if(cungguType == 5){
					cungguTypeFlag = "e";
				}else if(cungguType == 6){
					cungguTypeFlag = "f";
				} 
				
				$(".print17_2"+cungguTypeFlag+"SpanClass").css("display","inline");
				$(".print17_2"+cungguTypeFlag+"InputClass").css("display","none");	
				$("#editeBody17_2ContentsCancelBtnId").css("display","none");
				$("#editeBody17_2ContentsOkBtnId").css("display","none");
				$("#rptBody17_2UdtActionBtn").css("display","inline");
				
			});
			
			/* 청구내용 수정 Ok 하기 */
			$("#editeBody17_2ContentsOkBtnId").click(function(){
				
				/* 파라미터 세팅 */
				var cungguType = $("input:radio[name='chungguType']:checked").val();
				var cungguTypeFlag = "";
				
				var chungguContentsCount = "";
				
				if(cungguType == 1){
					cungguTypeFlag = "a";
					chungguContentsCount = 7;
				}else if(cungguType == 2){
					cungguTypeFlag = "b";
					chungguContentsCount = 7;
				}else if(cungguType == 3){
					cungguTypeFlag = "c";
					chungguContentsCount = 7;
				}else if(cungguType == 4){
					cungguTypeFlag = "d";
					chungguContentsCount = 10;
				}else if(cungguType == 5){
					cungguTypeFlag = "e";
					chungguContentsCount = 9;
				}else if(cungguType == 6){
					cungguTypeFlag = "f";
					chungguContentsCount = 9;
				} 
				
				var chungguDtl = new Array();
				
				for (var i = 0; i < chungguContentsCount ; i++) {
					chungguDtl[i] = $("#chungguDtl"+(i+1)+cungguTypeFlag).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;');
				}
				
				$.post("./editeBody17_2Ok",
						{	
							 suimRptNo					:"${suimRptBody17_2Vo.suimRptNo}"
							,chungguDtl 				: chungguDtl
							,chungguContentsCount 		: chungguContentsCount
							
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									 
									$(".print17_2"+cungguTypeFlag+"SpanClass").css("display","inline");
									$(".print17_2"+cungguTypeFlag+"InputClass").css("display","none");	
									$("#editeBody17_2ContentsCancelBtnId").css("display","none");
									$("#editeBody17_2ContentsOkBtnId").css("display","none");
									$("#rptBody17_2UdtActionBtn").css("display","inline");
									
									for (var i = 0; i < chungguContentsCount ; i++) {
										$("#chungguDtl"+(i+1)+cungguTypeFlag+"Span").html($("#chungguDtl"+(i+1)+cungguTypeFlag).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									}
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			});
			
		});
		
		function rptBody17_2UdtAction(){
			
			/* 파라미터 세팅 */
			var cungguType = $("input:radio[name='chungguType']:checked").val();
			var cungguTypeFlag = "";
			
			if(cungguType == 1){
				cungguTypeFlag = "a";
			}else if(cungguType == 2){
				cungguTypeFlag = "b";
			}else if(cungguType == 3){
				cungguTypeFlag = "c";
			}else if(cungguType == 4){
				cungguTypeFlag = "d";
			}else if(cungguType == 5){
				cungguTypeFlag = "e";
			}else if(cungguType == 6){
				cungguTypeFlag = "f";
			} 
			
			$(".print17_2"+cungguTypeFlag+"SpanClass").css("display","none");
			$(".print17_2"+cungguTypeFlag+"InputClass").css("display","inline");
			$("#rptBody17_2UdtActionBtn").css("display","none");
			$("#editeBody17_2ContentsCancelBtnId").css("display","inline");
			$("#editeBody17_2ContentsOkBtnId").css("display","inline");
			
		}
	</script>
	
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
        <hr size="1" noshade color="black">
		<table align="center" cellpadding="0" cellspacing="0" width="640">
			<tr>
				<td height="25" width="70%">
					<p class="p2">
						<b>2. 청구내용
							<!-- <img src="./resources/ls_img/ls_body/icon_score_zoom.gif" title="샘플 양식 보기" id = "print17_2ShowHideBtnId" style="display:none; cursor:pointer; "  /> -->
						</b>
					</p>
				</td>
				<td height="25" width="30%">
					<p align="right">
					<c:if test="${suimVO.suimRptState eq 0}">
						<img style = "cursor:pointer; float:right; " id= "rptBody17_2UdtActionBtn" src="./resources/ls_img/btn_edite.gif" onclick="rptBody17_2UdtAction();"/>
						<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody17_2ContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
						<img src="./resources/ls_img/icon_write.gif" title="저장" id = "editeBody17_2ContentsOkBtnId" style="float:right; display:none; cursor:pointer; margin-right:5px;" />
					</c:if>
					</p>
				</td>
			</tr>
			<tr >
				<td colspan="2" align="center">
					<!-- <img src="./resources/ls_img/ls_body/1/06.jpg" title="조사 사항 샘플 양식" id = "print1_6SampleImg" style="display:none; cursor:pointer; " onclick="print1_6ShowHide();" /> -->
				</td>
			</tr>
		</table>
		<table cellpadding="0" cellspacing="0"  align="center" width="640" > 
			<tr>
				<td bgcolor="#ECECEC" class="td" width="140" style="border-bottom:0px;">
					<p align="center"><b>구      분</b></p>
				</td>
				<td colspan="3" class="td" bgcolor="#ECECEC" width="500" style="border-bottom:0px;">
					<p align="center"><b>내           용</b></p>
				</td>
			</tr>
		</table>
		<!-- 과거력 시작 -->
		<table cellpadding="0" cellspacing="0"  align="center" id = "print17_2aTable" style="display:none;">
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>청구병명</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2aSpanClass" id="chungguDtl1aSpan">${suimRptBody17_2Vo.chungguDtl1Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2aInputClass" id = "chungguDtl1a" >${suimRptBody17_2Vo.chungguDtl1}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>병원초진일/초진병원</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2aSpanClass" id="chungguDtl2aSpan">${suimRptBody17_2Vo.chungguDtl2Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2aInputClass" id = "chungguDtl2a" >${suimRptBody17_2Vo.chungguDtl2}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>초진병원차트상 내원경위</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2aSpanClass" id="chungguDtl3aSpan">${suimRptBody17_2Vo.chungguDtl3Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2aInputClass" id = "chungguDtl3a" >${suimRptBody17_2Vo.chungguDtl3}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>진단병원/의사</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2aSpanClass" id="chungguDtl4aSpan">${suimRptBody17_2Vo.chungguDtl4Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2aInputClass" id = "chungguDtl4a" >${suimRptBody17_2Vo.chungguDtl4}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>검사명</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2aSpanClass" id="chungguDtl5aSpan">${suimRptBody17_2Vo.chungguDtl5Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2aInputClass" id = "chungguDtl5a" >${suimRptBody17_2Vo.chungguDtl5}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>수술명/수술일</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2aSpanClass" id="chungguDtl6aSpan">${suimRptBody17_2Vo.chungguDtl6Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2aInputClass" id = "chungguDtl6a" >${suimRptBody17_2Vo.chungguDtl6}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>특이사항</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2aSpanClass" id="chungguDtl7aSpan">${suimRptBody17_2Vo.chungguDtl7Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2aInputClass" id = "chungguDtl7a" >${suimRptBody17_2Vo.chungguDtl7}</textarea>
	             	 </p>
	          	</td>
			</tr>
		</table>
		<!-- 과거력 끝 -->
		
		<!-- 2대질병 시작 -->
		<table cellpadding="0" cellspacing="0"  align="center" id = "print17_2bTable" style="display:none;">
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>청구병명</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2bSpanClass" id="chungguDtl1bSpan">${suimRptBody17_2Vo.chungguDtl1Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2bInputClass" id = "chungguDtl1b" >${suimRptBody17_2Vo.chungguDtl1}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>병원초진일/초진병원</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2bSpanClass" id="chungguDtl2bSpan">${suimRptBody17_2Vo.chungguDtl2Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2bInputClass" id = "chungguDtl2b" >${suimRptBody17_2Vo.chungguDtl2}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>초진병원차트상 내원경위</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2bSpanClass" id="chungguDtl3bSpan">${suimRptBody17_2Vo.chungguDtl3Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2bInputClass" id = "chungguDtl3b" >${suimRptBody17_2Vo.chungguDtl3}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>진단병원/의사</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2bSpanClass" id="chungguDtl4bSpan">${suimRptBody17_2Vo.chungguDtl4Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2bInputClass" id = "chungguDtl4b" >${suimRptBody17_2Vo.chungguDtl4}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>각종검사내용 및 결과</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2bSpanClass" id="chungguDtl5bSpan">${suimRptBody17_2Vo.chungguDtl5Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2bInputClass" id = "chungguDtl5b" >${suimRptBody17_2Vo.chungguDtl5}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>수술명/수술일</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2bSpanClass" id="chungguDtl6bSpan">${suimRptBody17_2Vo.chungguDtl6Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2bInputClass" id = "chungguDtl6b" >${suimRptBody17_2Vo.chungguDtl6}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>특이사항</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2bSpanClass" id="chungguDtl7bSpan">${suimRptBody17_2Vo.chungguDtl7Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2bInputClass" id = "chungguDtl7b" >${suimRptBody17_2Vo.chungguDtl7}</textarea>
	             	 </p>
	          	</td>
			</tr>
		</table>
		<!-- 2대질병 끝 -->
		
		<!-- 암 시작 -->
		<table cellpadding="0" cellspacing="0"  align="center" id = "print17_2cTable" style="display:none;">
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>청구병명</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2cSpanClass" id="chungguDtl1cSpan">${suimRptBody17_2Vo.chungguDtl1Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2cInputClass" id = "chungguDtl1c" >${suimRptBody17_2Vo.chungguDtl1}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>병원초진일/초진병원</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2cSpanClass" id="chungguDtl2cSpan">${suimRptBody17_2Vo.chungguDtl2Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2cInputClass" id = "chungguDtl2c" >${suimRptBody17_2Vo.chungguDtl2}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>초진병원차트상 내원경위</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2cSpanClass" id="chungguDtl3cSpan">${suimRptBody17_2Vo.chungguDtl3Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2cInputClass" id = "chungguDtl3c" >${suimRptBody17_2Vo.chungguDtl3}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>암진단병원/의사</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2cSpanClass" id="chungguDtl4cSpan">${suimRptBody17_2Vo.chungguDtl4Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2cInputClass" id = "chungguDtl4c" >${suimRptBody17_2Vo.chungguDtl4}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>조직검사시행일/보고일</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2cSpanClass" id="chungguDtl5cSpan">${suimRptBody17_2Vo.chungguDtl5Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2cInputClass" id = "chungguDtl5c" >${suimRptBody17_2Vo.chungguDtl5}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>수술명/수술일</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2cSpanClass" id="chungguDtl6cSpan">${suimRptBody17_2Vo.chungguDtl6Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2cInputClass" id = "chungguDtl6c" >${suimRptBody17_2Vo.chungguDtl6}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>특이사항</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2cSpanClass" id="chungguDtl7cSpan">${suimRptBody17_2Vo.chungguDtl7Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2cInputClass" id = "chungguDtl7c" >${suimRptBody17_2Vo.chungguDtl7}</textarea>
	             	 </p>
	          	</td>
			</tr>
		</table>
		<!-- 암 끝 -->
		
		<!-- 상해사망 시작 -->
		<table cellpadding="0" cellspacing="0"  align="center" id = "print17_2dTable" style="display:none;">
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>사고일시</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2dSpanClass" id="chungguDtl1dSpan">${suimRptBody17_2Vo.chungguDtl1Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2dInputClass" id = "chungguDtl1d" >${suimRptBody17_2Vo.chungguDtl1}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>사고경위</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2dSpanClass" id="chungguDtl2dSpan">${suimRptBody17_2Vo.chungguDtl2Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2dInputClass" id = "chungguDtl2d" >${suimRptBody17_2Vo.chungguDtl2}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>사고장소</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2dSpanClass" id="chungguDtl3dSpan">${suimRptBody17_2Vo.chungguDtl3Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2dInputClass" id = "chungguDtl3d" >${suimRptBody17_2Vo.chungguDtl3}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>사고현장사진</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2dSpanClass" id="chungguDtl4dSpan">${suimRptBody17_2Vo.chungguDtl4Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2dInputClass" id = "chungguDtl4d" >${suimRptBody17_2Vo.chungguDtl4}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>목격자여부</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2dSpanClass" id="chungguDtl5dSpan">${suimRptBody17_2Vo.chungguDtl5Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2dInputClass" id = "chungguDtl5d" >${suimRptBody17_2Vo.chungguDtl5}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>병원초진일</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2dSpanClass" id="chungguDtl6dSpan">${suimRptBody17_2Vo.chungguDtl6Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2dInputClass" id = "chungguDtl6d" >${suimRptBody17_2Vo.chungguDtl6}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>초진병원 차트 상 내원경위</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2dSpanClass" id="chungguDtl7dSpan">${suimRptBody17_2Vo.chungguDtl7Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2dInputClass" id = "chungguDtl7d" >${suimRptBody17_2Vo.chungguDtl7}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>직접사인/간접사인</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2dSpanClass" id="chungguDtl8dSpan">${suimRptBody17_2Vo.chungguDtl8Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2dInputClass" id = "chungguDtl8d" >${suimRptBody17_2Vo.chungguDtl8}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>진단병원/의사</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2dSpanClass" id="chungguDtl9dSpan">${suimRptBody17_2Vo.chungguDtl9Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2dInputClass" id = "chungguDtl9d" >${suimRptBody17_2Vo.chungguDtl9}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>보검시행여부</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2dSpanClass" id="chungguDtl10dSpan">${suimRptBody17_2Vo.chungguDtl10Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2dInputClass" id = "chungguDtl10d" >${suimRptBody17_2Vo.chungguDtl10}</textarea>
	             	 </p>
	          	</td>
			</tr>
		</table>
		<!-- 상해사망 끝 -->
		
		<!-- 일당/간병비 시작 -->
		<table cellpadding="0" cellspacing="0"  align="center" id = "print17_2eTable" style="display:none;">
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>사고일시</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2eSpanClass" id="chungguDtl1eSpan">${suimRptBody17_2Vo.chungguDtl1Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2eInputClass" id = "chungguDtl1e" >${suimRptBody17_2Vo.chungguDtl1}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>사고경위</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2eSpanClass" id="chungguDtl2eSpan">${suimRptBody17_2Vo.chungguDtl2Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2eInputClass" id = "chungguDtl2e" >${suimRptBody17_2Vo.chungguDtl2}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>사고장소</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2eSpanClass" id="chungguDtl3eSpan">${suimRptBody17_2Vo.chungguDtl3Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2eInputClass" id = "chungguDtl3e" >${suimRptBody17_2Vo.chungguDtl3}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>사고현장사진</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2eSpanClass" id="chungguDtl4eSpan">${suimRptBody17_2Vo.chungguDtl4Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2eInputClass" id = "chungguDtl4e" >${suimRptBody17_2Vo.chungguDtl4}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>목격자여부</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2eSpanClass" id="chungguDtl5eSpan">${suimRptBody17_2Vo.chungguDtl5Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2eInputClass" id = "chungguDtl5e" >${suimRptBody17_2Vo.chungguDtl5}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>병원초진일</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2eSpanClass" id="chungguDtl6eSpan">${suimRptBody17_2Vo.chungguDtl6Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2eInputClass" id = "chungguDtl6e" >${suimRptBody17_2Vo.chungguDtl6}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>초진병원차트상 내원경위</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2eSpanClass" id="chungguDtl7eSpan">${suimRptBody17_2Vo.chungguDtl7Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2eInputClass" id = "chungguDtl7e" >${suimRptBody17_2Vo.chungguDtl7}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>주치료 내용</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2eSpanClass" id="chungguDtl8eSpan">${suimRptBody17_2Vo.chungguDtl8Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2eInputClass" id = "chungguDtl8e" >${suimRptBody17_2Vo.chungguDtl8}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>검사명/검사결과</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2eSpanClass" id="chungguDtl9eSpan">${suimRptBody17_2Vo.chungguDtl9Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2eInputClass" id = "chungguDtl9e" >${suimRptBody17_2Vo.chungguDtl9}</textarea>
	             	 </p>
	          	</td>
			</tr>
		</table>
		<!-- 일당/간병비 끝 -->
		
		<!-- 후유장해 시작 -->
		<table cellpadding="0" cellspacing="0"  align="center" id = "print17_2fTable" style="display:none;">
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>사고일시</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2fSpanClass" id="chungguDtl1fSpan">${suimRptBody17_2Vo.chungguDtl1Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2fInputClass" id = "chungguDtl1f" >${suimRptBody17_2Vo.chungguDtl1}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>사고경위</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2fSpanClass" id="chungguDtl2fSpan">${suimRptBody17_2Vo.chungguDtl2Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2fInputClass" id = "chungguDtl2f" >${suimRptBody17_2Vo.chungguDtl2}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>사고장소</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2fSpanClass" id="chungguDtl3fSpan">${suimRptBody17_2Vo.chungguDtl3Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2fInputClass" id = "chungguDtl3f" >${suimRptBody17_2Vo.chungguDtl3}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>사고현장사진</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2fSpanClass" id="chungguDtl4fSpan">${suimRptBody17_2Vo.chungguDtl4Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2fInputClass" id = "chungguDtl4f" >${suimRptBody17_2Vo.chungguDtl4}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>목격자여부</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2fSpanClass" id="chungguDtl5fSpan">${suimRptBody17_2Vo.chungguDtl5Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2fInputClass" id = "chungguDtl5f" >${suimRptBody17_2Vo.chungguDtl5}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>병원초진일</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2fSpanClass" id="chungguDtl6fSpan">${suimRptBody17_2Vo.chungguDtl6Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2fInputClass" id = "chungguDtl6f" >${suimRptBody17_2Vo.chungguDtl6}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>초진병원 차트 상 내원경위</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2fSpanClass" id="chungguDtl7fSpan">${suimRptBody17_2Vo.chungguDtl7Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2fInputClass" id = "chungguDtl7f" >${suimRptBody17_2Vo.chungguDtl7}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>후유장해항목/장해율</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2fSpanClass" id="chungguDtl8fSpan">${suimRptBody17_2Vo.chungguDtl8Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2fInputClass" id = "chungguDtl8f" >${suimRptBody17_2Vo.chungguDtl8}</textarea>
	             	 </p>
	          	</td>
			</tr>
			<tr>
				<td class="td" bgcolor="#ECECEC" width="140" >
				 	 <p align="center"><b>장해진단병원/의사</b></p>
	              </td>
	              <td class="td" width="500" >
	                 <p >
	                  	<span class= "print17_2fSpanClass" id="chungguDtl9fSpan">${suimRptBody17_2Vo.chungguDtl9Span }</span>
	                  	<textarea style="text-align:left; width:99%;height:75px;overflow:visible; display:none;"  
	                  	class= "print17_2fInputClass" id = "chungguDtl9f" >${suimRptBody17_2Vo.chungguDtl9}</textarea>
	             	 </p>
	          	</td>
			</tr>
		</table>
		<!-- 후유장애 끝 -->
</body>
<p>&nbsp;</p>