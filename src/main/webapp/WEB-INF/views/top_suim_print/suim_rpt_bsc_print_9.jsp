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
	<link rel="stylesheet" type="text/css" href="./resources/ls_css/rpt_1001_style.css" />
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	
	<script src="./resources/cmm/js/common.js"></script>
	
	<script>
		$(document).ready(function(){
			
			$("#editeBody9_1ContentsCancelBtnId").click(function(){
				
				$(".print9_1SpanClass").show();
				$(".print9_1InputClass").hide();
				
				$("#editeBody9_1ContentsCancelBtnId").hide();
				$("#editeBody9_1ContentsOkBtnId").hide();
				
				$("#rptBody9_1UdtActionBtnId").show();
			});
			
			/* 1.계약사항 update */ 
			$("#editeBody9_1ContentsOkBtnId").click(function(){
				
				$.post("./editeBody9_1Ok",
						{	
							 rptPrintNo				:"${suimRptBody9_13467Vo.rptPrintNo}"
							,insuredJob1  			: $("#insuredJob1").val() .replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')				//직무
							,insuMortgage1  		:$("#insuMortgage1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')			//담보구분
							,insuMortgageDtl1  		:$("#insuMortgageDtl1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//담보내역
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("불러오기를 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									$(".print9_1SpanClass").css("display","inline");
									$(".print9_1InputClass").css("display","none");	
									$("#editeBody9_1ContentsCancelBtnId").css("display","none");
									$("#editeBody9_1ContentsOkBtnId").css("display","none");
									$("#rptBody9_1UdtActionBtnId").css("display","inline");
									
									$("#insuredJob1SpanId").html($("#insuredJob1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#insuMortgage1SpanId").html($("#insuMortgage1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#insuMortgageDtl1SpanId").html($("#insuMortgageDtl1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			});
			
			$("#rptBody9WordOut").click(function(){
				
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
				
				window.open('suimRptBody9PrintOut?suimRptNo='+'${suimRptBody9_13467Vo.suimRptNo}'+'&type=word','tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			});
			
			$("#rptBody9PageOut").click(function(){
				
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
				
				window.open('suimRptBody9PrintOut?suimRptNo='+'${suimRptBody9_13467Vo.suimRptNo}'+'&type=page','_blank','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			});
			
		});
		
		/* Print_9_1 수정동작 */
		function rptBody9UdtAction(){
			
			$("#rptBody9_1UdtActionBtnId").hide();
			$(".print9_1SpanClass").hide();
			$(".print9_1InputClass").show();
			
			$("#editeBody9_1ContentsCancelBtnId").show();
			$("#editeBody9_1ContentsOkBtnId").show();
		}
		
	    /* mask 처리 */
	    function _initMask(){
	        var options = {
	            onKeyPress : function(cep, event, currentField, options){
	                var tid = event.currentTarget.id;
	                var tidx = tid.substr(tid.length - 1, 1);
	                //console.log(tidx);
	                //fnCaculateTotal(tidx);
	            },
	            reverse : true
	        };

	        $('input.onlyNumber').mask('#######',options);
	        $('div.onlyNumber').mask('999999999',{reverse:true});
	    }
		
	</script>
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
	<input type="hidden" id="rptPrintNo" value="${suimRptBody9_13467Vo.rptPrintNo}" />
	<table id = "rptBody6Table" align="center" cellpadding="0" cellspacing="0" width="648">
		<tr>
			<td>
				<p align="right">
					<img src="./resources/ls_img/report/btn_word.gif" id ="rptBody9WordOut" title ="워드 출력" style="cursor:pointer;" border="0">
					<img src="./resources/ls_img/report/icon_print.gif" id ="rptBody9PageOut" title ="화면 인쇄" style="cursor:pointer;" border="0">
				</p>
				<p align="center"><img src="https://www.toplac.co.kr/resources/ls_img/ls_body/print_head.jpg" width="640" height="56" border="0"></p>
				<p align="center" style="line-height:50%; margin-top:0; margin-bottom:0;">&nbsp;</p>
				<p align="center"><span style="font-size:9pt;">${tmInforForBody.team_addr}</span></p> 
				<p align="center"><span style="font-size:9pt;">전화 : ${tmInforForBody.team_interphone} &nbsp;팩스 : ${tmInforForBody.team_fax} &nbsp;이메일 : ${mbrVoForBody.email}</span></p>
				<hr size="1" width="640" noshade color="black">
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<table cellpadding="0" cellspacing="0" width="648" align="center">
					<tr>
						<th width="85" height="30" align="center">
							<p>수 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;신</p>
						</th>
						<th width="350" align="left">
							<p>: ${suimVO.ptnr_name}</p>
						</th>
						<th width="90" align="right">
							<p>Report No.</p>
						</th>
						<th width="115" align="left">
							<p>&nbsp;${suimVO.suim_accept_no}</p>
						</th>
					</tr>
					<tr>
						<th height="30" width="85" align="center">
							<p>참 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;조</p>
						</th>
						<th width="350" align="left">
							<p>: ${suimVO.ptnr_dept_nm} 
							<c:if test="${suimVO.ptnr_mbr_nm ne ''}">
								(담당 : ${suimVO.ptnr_mbr_nm} 님)
							</c:if></p>
						</th>
					</tr>
					<tr>
						<th height="30" width="85" align="center">
							<p>제 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</p>
						</th>
						<th width="555" colspan="3" align="left">
							<p>: ${suimVO.insurance_nm} 
								<c:if test="${suimVO.policyholder_nm ne ''}">
									&quot;<b>${suimVO.policyholder_nm}</b>&quot;
								</c:if>
								 손해사정서
							 </p>
						</th>
					</tr>
					<tr>
						<th height="30" width="85" align="center">
							<p>증 권 번 호</p>
						</th>
						<th width="555" colspan="3" align="left">
							<p><b>: 제 ${suimVO.policy_no} 호</b></p>
						</th>
					</tr>
					<tr>
						<td colspan="4" height="120" width="640">
							<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							귀사의 요청에 의거하여 피보험자 <b>&quot;${suimVO.beneficiary_nm}&quot;</b> 의 
			                        보험금 청구건에 대한 사고조사를 실시하고, 그 결과를 
			                        다음과 같이 제출합니다.
							</p>	
						</td>
					</tr>
				</table>
				
				<p>&nbsp;</p>
				<div  align="right">
				<table cellpadding="0" cellspacing="0" width="640">
	                <tr>
	                    <td height="70" width="500">
	                        <p>&nbsp;</p>
	                        <p>&nbsp;</p>
	                        <p align="right">손해사정사</p>
	                    </td>
	                    <td width="65">
	                        <p>&nbsp;</p>
	                        <p>&nbsp;</p>
	                        <p>&nbsp;: 윤경수</p>
	                    </td>
	                    <td width="75" rowspan="2">
	                        <p><img src="./resources/ls_img/ls_body/sign_yoon.jpg" width="72" height="70" border="0"></p>
	                    </td>
	                </tr>
	                <tr>
	                    <td width="565" colspan="2">
	                        <p align="right">070-8255-3000</p>
	                    </td>
	                </tr>
	                <tr>
	                    <td height="50" width="500">
	                        <p>&nbsp;</p>
	                        <p align="right">결 &nbsp;&nbsp;재 &nbsp;&nbsp;자 :</p>
	                    </td>
	                    <td width="65">
	                        <p>&nbsp;</p>
	                        <p>&nbsp; 
	                        	<c:choose>
		                        	<c:when test="${mbrVoForBodySantion ne null}">
			                        	${mbrVoForBodySantion.user_name}	                        	
		                        	</c:when>
		                        	<c:otherwise>
		                        		<font color="red"> 미상신</font>
		                        	</c:otherwise>
	                        	</c:choose>
	                        </p>
	                    </td>
	                    <td width="75" rowspan="2">
	                        <p>
	                        	<c:if test="${mbrVoForBodySantion ne null}">
									<c:choose>
										<c:when test="${mbrVoForBodySantion.user_sign ne null}">
											<%-- <img src="/home/hosting_users/toplac/www/ls_data/member_sign/${mbrVoForBodySantion.user_no}/${mbrVoForBodySantion.user_sign}" width=50 height=50 border=0> --%>	                        	
											<img src="https://toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${mbrVoForBodySantion.user_no}/${mbrVoForBodySantion.user_sign}" width=50 height=50 border=0>
										</c:when>
										<c:otherwise>
											사인 없음
										</c:otherwise>
									</c:choose>
	                        	</c:if>
	                        </p>
	                    </td>
	                </tr>
	                <tr>
	                    <td width="565" colspan="2">
	                        <p align="right">${mbrVoForBodySantion.handphone }</p>
	                    </td>
	                </tr>
	                <tr>
	                    <td height="50" width="500">
	                        <p>&nbsp;</p>
	                        <p align="right">조 &nbsp;&nbsp;사 &nbsp;&nbsp;자 :</p>
	                    </td>
	                    <td width="65">
	                        <p>&nbsp;</p>
	                        <p>&nbsp; ${mbrVoForBody.user_name }</p>
	                    </td>
	                    <td width="75" rowspan="2">
	                        <p>
								<c:choose>
									<c:when test="${signVoForRptUser.user_sign ne '' or signVoForRptUser.user_sign ne null}">
										<%-- <img src='/home/hosting_users/toplac/www/ls_data/member_sign/${signVoForRptUser.user_no}/${signVoForRptUser.user_sign}' width=50 height=50 border=0> --%>	                        	
										<img src="https://toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${signVoForRptUser.user_no}/${signVoForRptUser.user_sign}" width=50 height=50 border=0>
									</c:when>
									<c:otherwise>
										사인 없음
									</c:otherwise>
								</c:choose>  
	                        </p>
	                    </td>
	                </tr>
	                <tr>
	                    <td width="565" colspan="2">
	                        <p align="right">${mbrVoForBody.handphone }</p>
	                    </td>
	                </tr>
	            </table>
				</div>
				<p>&nbsp;</p>
	            <hr size="1" noshade color="black">
	            <table align="center" cellpadding="0" cellspacing="0" width="640">
					<tr>
						<td height="25" width="20%">
							<p class="p2">
								<b>1. 계약확인사항
									<!-- <img src="./resources/ls_img/ls_body/icon_score_zoom.gif" title="샘플 양식 보기" id = "print1_1ShowHideBtnId" style="display:none; cursor:pointer; "  /> -->
								</b>
							</p>
						</td>
						<td height="25" width="70%">
							<p align="right">
								<img style = "cursor:pointer; float:right; " id = "rptBody9_1UdtActionBtnId"src="./resources/ls_img/btn_edite.gif" onclick="rptBody9UdtAction();"/>
								<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody9_1ContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
								<img src="./resources/ls_img/icon_write.gif" title="저장" id = "editeBody9_1ContentsOkBtnId" style="float:right; display:none; cursor:pointer; margin-right:5px;" />
							</p>
						</td>
					</tr>
					<tr >
						<td colspan="2" align="center">
							<!-- <img src="./resources/ls_img/ls_body/1/09.jpg" title="계약 사항 샘플 양식" id = "print9SampleImg" style="display:none; cursor:pointer; " onclick="print9ShowHide();" /> -->
						</td>
					</tr>
				</table>
            <table cellpadding="0" cellspacing="0" align="center" width="640">
                 <tr>
                    <td class="td" width="20%" bgcolor="#ECECEC">
						<p align="center"><B>보 &nbsp;험 &nbsp;종 &nbsp;목</B></p>
                    </td>
                    <td colspan="2" class="td" width="70%">
                        <p align="center">${suimVO.insurance_nm }</p>
                    </td>
                    
				</tr>
                 <tr>
                    <td class="td" bgcolor="#ECECEC">
						<p align="center"><B>증 &nbsp;권 &nbsp;번 &nbsp;호</B></p>
                    </td>
                    <td colspan="2" class="td">
                        <p align="center">${suimVO.policy_no }</p>
                    </td>
				</tr>
                 <tr>
                    <td class="td" bgcolor="#ECECEC">
                        <p align="center"><B><span style="font-size:9pt;">계약자/ 피보험자</span></B></p>
                    </td>
                    <td colspan="2" class="td">
						<p align="center">${suimVO.policyholder_nm }(${suimVO.policyholder_ssn }) / ${suimVO.beneficiary_nm }(${suimVO.beneficiary_ssn })</p>
                    </td>
				</tr>
                 <tr>
                   <td class="td" rowspan="2" bgcolor="#ECECEC">
                       <p align="center"><B>청 &nbsp;구 &nbsp;담 &nbsp;보</B></p>
                   </td>
                   <td class="td" bgcolor="#ECECEC">
                   	<p align="center">담 보 구 분</p>
                   </td>
                    <td class="td" bgcolor="#ECECEC">
                    <p align="center">담 보 내 역</p>
                   </td>
				</tr>
				 <tr>
	                  <td>
	                   	<p align="center">
                   			<span class="print9_1SpanClass" id="insuMortgage1SpanId">${suimRptBody9_13467Vo.insuMortgage1Span }</span>
                   			<textarea style="width:99%;height:55px;overflow:visible; display:none;" 
                   			class="print9_1InputClass" id = "insuMortgage1">${suimRptBody9_13467Vo.insuMortgage1}</textarea>
	                   	</p>
	                  </td>
	                  <td class="td">
	                   	<p style="margin-left:10;">
                   			<span  class="print9_1SpanClass"  id="insuMortgageDtl1SpanId">${suimRptBody9_13467Vo.insuMortgageDtl1Span }</span>
	                   		<textarea style="width:99%;height:55px;overflow:visible; display:none;" 
	                   		class="print9_1InputClass" id = "insuMortgageDtl1">${suimRptBody9_13467Vo.insuMortgageDtl1}</textarea>
	                   	</p> 
	                  	</td>
	              </tr>
                <tr>
		            <td class="td" bgcolor="#ECECEC">
                        <p align="center"><B>직무확인사항</B></p>
		            </td>
		            <td colspan="2" class="td">
		                <p>
		                	<span class="print9_1SpanClass" id = "insuredJob1SpanId">${suimRptBody9_13467Vo.insuredJob1Span }</span>
		                	<textarea style="width:99%;height:55px;overflow:visible; display:none;" 
	                         class="print9_1InputClass" id = "insuredJob1">${suimRptBody9_13467Vo.insuredJob1}</textarea>
		                </p>
		            </td>
               </tr>
            </table>
            <p>&nbsp;</p>
            
            <!-- 조사결과(요약) -->
			<c:import url="../top_suim_print/suim_rpt_bsc_print_9_2.jsp"></c:import>
			<!-- //조사결과(요약) -->
			
			<!-- 조사내용(요약) :가 -->
			<c:import url="../top_suim_print/suim_rpt_bsc_print_9_3b.jsp"></c:import>
			<!-- //조사내용(요약) :가 -->
			
			<!-- 조사내용(요약) :나 -->
			<c:import url="../top_suim_print/suim_rpt_bsc_print_9_3a.jsp"></c:import>
			<!-- //조사내용(요약) :나 -->
			
			<!-- 조사내용(요약) :다 -->
			<c:import url="../top_suim_print/suim_rpt_bsc_print_9_3c.jsp"></c:import>
			<!-- //조사내용(요약) :다 -->
            
            <!-- 청구 관련 조사내용(상세) -->
			<c:import url="../top_suim_print/suim_rpt_bsc_print_9_3d.jsp"></c:import>
			<!-- //청구 관련 조사내용(상세) -->
			
			<!-- 기타병원_확인내용 -->
			<c:import url="../top_suim_print/suim_rpt_bsc_print_9_6.jsp"></c:import>
			<!-- //기타병원_확인내용 -->
            
            <!-- 조사결과_상세내용 -->
			<c:import url="../top_suim_print/suim_rpt_bsc_print_9_7.jsp"></c:import>
			<!-- //조사결과_상세내용 -->
            
            <p align="center">&nbsp;</p>
            <p align="center"><B>◁◁ 본 보고서는 최대 신의 성실로 공정하게 작성 되었음을 명백히 합니다. ▷▷ </B></p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            
            <hr size="1" noshade color="black">
				
			<!-- 사고처리 과정표 -->
			<c:import url="../top_suim_print/suim_rpt_bsc_print_9_ctrl.jsp"></c:import>
			<!-- //사고처리 과정표-->
			
			<!-- 8.첨부파일 목록 -->
			<c:import url="../top_suim_print/suim_rpt_bsc_print_9_fileList.jsp"></c:import>
			<!-- //8.첨부파일 목록-->
			
			</td>
		</tr>
	</table>
	
	
</body>