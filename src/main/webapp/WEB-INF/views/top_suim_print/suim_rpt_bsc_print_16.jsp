<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>보고서 작성</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<link rel="stylesheet" type="text/css" href="./resources/ls_css/rpt_6_style.css" />
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	
	<script>
		$(document).ready(function(){
			
			$("#editeBody16_1ContentsCancelBtnId").click(function(){
				
				$(".print16_1SpanClass").show();
				$(".print16_1InputClass").hide();
				
				$("#editeBody16_1ContentsCancelBtnId").hide();
				$("#editeBody16_1ContentsOkBtnId").hide();
				
				$("#rptBody16_1UdtActionBtnId").show();
				$("#print16_1AccDateSpan").hide();
			});
			
			/* 1.계약사항 update */ 
			$("#editeBody16_1ContentsOkBtnId").click(function(){
				
				$.post("./editeBody16_1Ok",
						{	
							 rptPrintNo				:"${suimRptBody16_1267Vo.rptPrintNo}"
							,accidentDate1			:$("#accidentDate1").val() 
							,insuPeriodS1  			:$("#insuPeriodS1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//보험시기
							,insuPeriodE1  			:$("#insuPeriodE1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//보험종기
							,contractState1  		:$("#contractState1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//계약상태
							,accidentSumUp1  		:$("#accidentSumUp1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//사고유형
							,diagnosisCode1  		:$("#diagnosisCode1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//진단코드
							,diagnosisDisease1  	:$("#diagnosisDisease1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')	//진단명
							,jobGradeJoin1  		:$("#jobGradeJoin1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//직업급수
							,jobGradeAccident1  	:$("#jobGradeAccident1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')	//사고시직업급수
							,insuMortgageDtl1  		:$("#insuMortgageDtl1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')	//담보내용
							,amtTotInsu1  			:$("#amtTotInsu1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//보험가입금액
							,amtEstimatedDmgDtl1  	:$("#amtEstimatedDmgDtl1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')	//추정손해액
							
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("불러오기를 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									$(".print16_1SpanClass").css("display","inline");
									$(".print16_1InputClass").css("display","none");	
									$("#editeBody16_1ContentsCancelBtnId").css("display","none");
									$("#editeBody16_1ContentsOkBtnId").css("display","none");
									$("#rptBody16_1UdtActionBtnId").css("display","inline");
									$("#print16_1AccDateSpan").hide();
									
									$("#accidentDate1Span").html($("#accidentDate1").val());	
									$("#insuPeriodS1Span").html($("#insuPeriodS1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#insuPeriodE1Span").html($("#insuPeriodE1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#contractState1Span").html($("#contractState1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#accidentSumUp1Span").html($("#accidentSumUp1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#diagnosisCode1Span").html($("#diagnosisCode1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#diagnosisDisease1Span").html($("#diagnosisDisease1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#jobGradeJoin1Span").html($("#jobGradeJoin1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#jobGradeAccident1Span").html($("#jobGradeAccident1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#insuMortgageDtl1Span").html($("#insuMortgageDtl1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#amtTotInsu1Span").html($("#amtTotInsu1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#amtEstimatedDmgDtl1Span").html($("#amtEstimatedDmgDtl1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			});
			
			$("#rptBody16WordOut").click(function(){
				
// 				if("${suimVO.suimRptState}" != 2){
// 					alert("종결건이 아니면 인쇄할 수 없습니다.");
// 					return;
// 				}
				
				var cw=screen.availWidth;
				var ch=screen.availHeight;
				
				var sw=1010; //띄울 창의 넓이
				var sh=740;  //띄울 창의 높이
		
				var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
				var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
				
				window.open('suimRptBody16PrintOut?suimRptNo='+'${suimRptBody16_1267Vo.suimRptNo}'+'&type=word','tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			});
			
			$("#rptBody16PageOut").click(function(){
				
// 				if("${suimVO.suimRptState}" != 2){
// 					alert("종결건이 아니면 인쇄할 수 없습니다.");
// 					return;
// 				}
				
				var cw=screen.availWidth;
				var ch=screen.availHeight;
				
				var sw=700; //띄울 창의 넓이
				var sh=550;  //띄울 창의 높이
		
				var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
				var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
				
				window.open('suimRptBody16PrintOut?suimRptNo='+'${suimRptBody16_1267Vo.suimRptNo}'+'&type=page','_blank','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			});
			
		});
		
		/* Print_16_1 수정동작 */
		function rptBody16UdtAction(){
			
			$("#rptBody16_1UdtActionBtnId").hide();
			$(".print16_1SpanClass").hide();
			$(".print16_1InputClass").show();
			
			$("#editeBody16_1ContentsCancelBtnId").show();
			$("#editeBody16_1ContentsOkBtnId").show();
			
			$("#print16_1AccDateSpan").show();
			
			$('#accidentDate1').datepicker({ 
				   showOn: 'button',
				   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
				   buttonImageOnly: true,
				   buttonText: "달력", 
				   changeMonth: true,
				   changeYear: true,
				   showButtonPanel: false
			});
			
		}
		
		
		
	</script>
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
	<table id = "rptBody6Table" align="center" cellpadding="0" cellspacing="0" width="648">
		<tr>
			<td>
				<p align="right">
					<img src="./resources/ls_img/report/btn_word.gif" id ="rptBody16WordOut" title ="워드 출력" style="cursor:pointer;" border="0">
					<img src="./resources/ls_img/report/icon_print.gif" id ="rptBody16PageOut" title ="화면 인쇄" style="cursor:pointer;" border="0">
				</p>
				<p>&nbsp;</p>
				<table align="center" cellpadding="0" cellspacing="0" width="100%" bgcolor="white">
					<tr>
						<td width="50%" height="30">
							<p><font color="#113F7D">▣ <b>계약사항 및 손해사항</b></font></p>
						</td>
						<td width="50%" height="30">
							<p align="right">
								<c:if test="${suimVO.suimRptState eq 0}">
									<img style = "cursor:pointer; float:right; " id = "rptBody16_1UdtActionBtnId"src="./resources/ls_img/btn_edite.gif" onclick="rptBody16UdtAction();"/>
									<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody16_1ContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
									<img src="./resources/ls_img/icon_write.gif" title="저장" id = "editeBody16_1ContentsOkBtnId" style="float:right; display:none; cursor:pointer; margin-right:5px;" />
								</c:if>
							</p> 
						</td>
					</tr>
					<tr>
						<td width="100%" height="1" colspan="2" bgcolor="#113F7D">
						</td>
					</tr>
				</table>
				<table align="center" cellpadding="0" cellspacing="0" width="100%">
					<tr height="30">
						<th width="34%" align="left">사고접수일 : ${suimVO.accident_date}</th>
						<th width="33%" align="center">의뢰일시 : ${suimVO.reg_date}</th>
						<th width="33%" align="right">보고일자 : 
							<c:choose>
								<c:when test="${suimInvVO.invoiceDate ne null }">
									<c:choose>
										<c:when test="${suimInvVO.invoiceDate ne '' }">
											${suimInvVO.invoiceDate }														
										</c:when>
										<c:otherwise>
											<font color="red">미제출 </font>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<font color="red">미제출 </font>
								</c:otherwise>
							</c:choose>
						</th>
					</tr>
				</table>
				<table align="center" width="640">
					<tr align="center">
						<td width="10%" bgcolor="#EFEFEF" class="td"><p>피보험자</p></td>
						<td width="15%" class="td"><p>${suimVO.getBeneficiary_nm()}</p></td>
						<td width="10%" bgcolor="#EFEFEF" class="td"><p>사고번호</p></td>
						<td width="20%" class="td"><p>${suimVO.getAccident_no()}</p></td>
						<td width="10%" bgcolor="#EFEFEF" class="td"><p>조사담당</p></td>
						<td width="25%" class="td"><p>${suimVO.user_name}</p></td>
					</tr>
					<tr align="center">
						<td bgcolor="#EFEFEF" class="td"><p>주민번호</p></td>
						<td colspan="3" class="td"><p>${suimVO.getBeneficiary_ssn()}</p></td>
						<td bgcolor="#EFEFEF" class="td"><p>보상담당</p></td>
						<td class="td"><p>${suimVO.ptnr_mbr_nm }</p></td>
					</tr>
				</table>
				<p>&nbsp;</p>
				<table align="center" cellpadding="0" cellspacing="0" width="640">
					<tr>
						<td width="100%" height="30">
							<p>▣ <b>계약사항</b></p>
						</td>
					</tr>
				</table>
				<table align="center" width="640">
					<tr align="center" bgcolor="#EFEFEF">
						<td class="td" nowrap><p>상품명</p></td>
						<td class="td" nowrap><p>증권번호</p></td>
						<td class="td" nowrap><p>보험시기</p></td>
						<td class="td" nowrap><p>보험종기</p></td>
						<td class="td" nowrap><p>계약자명</p></td>
						<td class="td" nowrap><p>계약상태</p></td>
					</tr>
					<tr align="center">
						<td class="td"><p>${suimVO.getInsurance_nm()} </p></td>
						<td class="td"><p>${suimVO.getPolicy_no()} </p></td>
						<td class="td">
							<p>
								<span class="print16_1SpanClass" id = "insuPeriodS1Span">${ suimRptBody16_1267Vo.insuPeriodS1Span}</span>
								<textarea style="width:99%;height:55px;overflow:visible; display:none;" 
                   			class="print16_1InputClass" id = "insuPeriodS1">${suimRptBody16_1267Vo.insuPeriodS1}</textarea>
							</p>
						</td> 
						<td class="td">
							<p> 
								<span class="print16_1SpanClass" id = "insuPeriodE1Span">${ suimRptBody16_1267Vo.insuPeriodE1Span}</span>
								<textarea style="width:99%;height:55px;overflow:visible; display:none;" 
                   			class="print16_1InputClass" id = "insuPeriodE1">${suimRptBody16_1267Vo.insuPeriodE1}</textarea>
							</p>
						</td>
						<td class="td"><p>${suimVO.getPolicyholder_nm()} </p></td>
						<td class="td">
							<p> 
								<span class="print16_1SpanClass" id = "contractState1Span">${ suimRptBody16_1267Vo.contractState1Span}</span>
								<textarea style="width:99%;height:55px;overflow:visible; display:none;" 
                   			class="print16_1InputClass" id = "contractState1">${suimRptBody16_1267Vo.contractState1}</textarea>
							</p>
						</td> 
					</tr>
				</table>
				<p>&nbsp;</p>
				<table align="center" cellpadding="0" cellspacing="0" width="640">
					<tr>
						<td width="100%" height="30">
							<p>▣ <b>손해사항</b></p>
						</td>
					</tr>
				</table>
				<table align="center" width="640">
					<tr align="center" bgcolor="#EFEFEF">
						<td class="td" nowrap><p>사고일자</p></td>
						<td class="td" nowrap><p>사고유형</p></td>
						<td class="td" nowrap colspan="2"><p>진단명</p></td>
						<td class="td" nowrap><p>가입시<br>직업급수</p></td>
						<td class="td" nowrap><p>사고시<br>직업급수</p></td>
					</tr>
					<tr align="center">
						<td class="td">
							<p>
								<span class="print16_1SpanClass" id = "accidentDate1Span">
								<c:choose>
									<c:when test="${suimRptBody16_1267Vo.accidentDate1 eq '1970-01-01' }">
										-								
									</c:when>
									<c:otherwise>
										${ suimRptBody16_1267Vo.accidentDate1}
									</c:otherwise>								
								</c:choose>
								</span>
								<span id = "print16_1AccDateSpan" style="display:none;">
									<input type="text" id = "accidentDate1" size="10" value="" />
								</span>
							</p>
						</td>
						<td class="td">
							<p>
								<span class="print16_1SpanClass" id = "accidentSumUp1Span">${ suimRptBody16_1267Vo.accidentSumUp1Span}</span>
								<textarea style="width:99%;height:55px;overflow:visible; display:none;" 
                   			class="print16_1InputClass" id = "accidentSumUp1">${suimRptBody16_1267Vo.accidentSumUp1}</textarea>
							</p>
						</td> <!-- accident_sum_up_1 -->
						<td class="td">
							<p>
								<span class="print16_1SpanClass" id = "diagnosisDisease1Span">${ suimRptBody16_1267Vo.diagnosisDisease1Span}</span>
								<textarea style="width:99%;height:55px;overflow:visible; display:none;" 
                   			class="print16_1InputClass" id = "diagnosisDisease1">${suimRptBody16_1267Vo.diagnosisDisease1}</textarea>
							</p>
						</td> <!-- diagnosis_disease_1 -->
						<td class="td">
							<p>
								<span class="print16_1SpanClass" id = "diagnosisCode1Span">${ suimRptBody16_1267Vo.diagnosisCode1Span}</span>
								<textarea style="width:99%;height:55px;overflow:visible; display:none;" 
                   			class="print16_1InputClass" id = "diagnosisCode1">${suimRptBody16_1267Vo.diagnosisCode1}</textarea>
							</p>
						</td> <!-- diagnosis_code_1 -->
						<td class="td">
							<p>
								<span class="print16_1SpanClass" id = "jobGradeJoin1Span">${ suimRptBody16_1267Vo.jobGradeJoin1Span}</span>
								<textarea style="width:99%;height:55px;overflow:visible; display:none;" 
                   			class="print16_1InputClass" id = "jobGradeJoin1">${suimRptBody16_1267Vo.jobGradeJoin1}</textarea>
							</p>
						</td> <!-- job_grade_join_1 -->
						<td class="td">
							<p>
								<span class="print16_1SpanClass" id = "jobGradeAccident1Span">${ suimRptBody16_1267Vo.jobGradeAccident1Span}</span>
								<textarea style="width:99%;height:55px;overflow:visible; display:none;" 
                   			class="print16_1InputClass" id = "jobGradeAccident1">${suimRptBody16_1267Vo.jobGradeAccident1}</textarea>
							</p>
						</td> <!-- job_grade_accident_1 -->
					</tr>
				</table>
				<p>&nbsp;</p>
				<table align="center" width="640">
					<tr align="center" bgcolor="#efefef">
						<td class="td" nowrap>담보내용</td>
						<td class="td" nowrap>보험가입금액</td>
						<td class="td" nowrap>추정손해액</td>
					</tr>
					<tr align="center">
						<td class="td"> 
								<span class="print16_1SpanClass" id = "insuMortgageDtl1Span">${ suimRptBody16_1267Vo.insuMortgageDtl1Span}</span>
								<textarea style="width:99%;height:55px;overflow:visible; display:none;" 
                   			class="print16_1InputClass" id = "insuMortgageDtl1">${suimRptBody16_1267Vo.insuMortgageDtl1}</textarea>
						</td> <!-- insu_mortgage_dtl_1 -->
						<td class="td"> 
								<span class="print16_1SpanClass" id = "amtTotInsu1Span">${ suimRptBody16_1267Vo.amtTotInsu1Span}</span>
								<textarea style="width:99%;height:55px;overflow:visible; display:none;" 
                   			class="print16_1InputClass" id = "amtTotInsu1">${suimRptBody16_1267Vo.amtTotInsu1}</textarea>
						</td> <!-- amt_tot_insu_1 -->
						<td class="td"> 
								<span class="print16_1SpanClass" id = "amtEstimatedDmgDtl1Span">${ suimRptBody16_1267Vo.amtEstimatedDmgDtl1Span}</span>
								<textarea style="width:99%;height:55px;overflow:visible; display:none;" 
                   			class="print16_1InputClass" id = "amtEstimatedDmgDtl1">${suimRptBody16_1267Vo.amtEstimatedDmgDtl1}</textarea>
						</td> <!-- amt_estimated_dmg_dtl_1 -->
					</tr>
					<tr align="center">
						<td bgcolor="#efefef" class="td" colspan="2">합 계</td>
						<td class="td">	
							<span>${ suimVO.amtEstimatedDamage} 원</span>								
                   		</td>
					</tr>
				</table>
            <p>&nbsp;</p>
            
            <!-- 청구내용 및 조사결과 -->
			<c:import url="../top_suim_print/suim_rpt_bsc_print_16_2.jsp"></c:import>
			<!-- //청구내용 및 조사결과 -->
            
            <!-- 조사자 일자별 확인사항 -->
			<c:import url="../top_suim_print/suim_rpt_bsc_print_16_3.jsp"></c:import>
			<!-- //조사자 일자별 확인사항 -->
            
            <!-- 타사 가입 사항 -->
			<c:import url="../top_suim_print/suim_rpt_bsc_print_16_4.jsp"></c:import>
			<!-- //타사 가입 사항 -->
            
            <!-- 주요 쟁점 사항 -->
			<c:import url="../top_suim_print/suim_rpt_bsc_print_16_5.jsp"></c:import>
			<!-- //주요 쟁점 사항 -->
            
            <!-- 관련자면담 및 특이사항 -->
			<c:import url="../top_suim_print/suim_rpt_bsc_print_16_7.jsp"></c:import>
			<!-- //주요 쟁점 사항 -->
            
            <!-- 사고조사 처리과정  -->
			<c:import url="../top_suim_print/suim_rpt_bsc_print_16_ctr.jsp"></c:import>
			<!-- //사고조사 처리과정 -->
            
			</td>
		</tr>
	</table>	
</body>