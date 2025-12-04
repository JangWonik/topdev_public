<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="getSuimSuit17DtlBsc" value="${getSuimSuit17DtlBsc}"/>
<script>
	$(document).ready(function(){
		$.ajaxSetup({cache:false});
		if ( "${getSuimSuit17DtlBsc.editYN2}" <  1 ){
			alert("접근 권한이 없습니다.");
			window.close()
			return false;
		}
		
		
		$("#suimTmMbrPopBtn").click(function(){//담당 팀, 담당 직원 바꾸기 팝업
			if("${getSuimSuit17DtlBsc.suimRptState}" != 0 && "${getSuimSuit17DtlBsc.suimRptState}" != 11){
				alert("상신 이후 수정할 수 없습니다. '상신 취소'를 하거나 결재자에게 '결재 취소'를 받으십시오.");
				return;
			}
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=500; //띄울 창의 넓이
			var sh=550;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('suimTmMbrPop?gbNo='+$("#gbNoForPop").val()+'&smNo='+$("#smNoForPop").val()+'&tmNo='+$("#tmNoForPop").val(),'SuimTmMbrPop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		});//$("#suimTmMbrPopBtn").click

		$("#suimPtnrMbrPopBtn").click(function(){//담당 팀, 담당 직원 바꾸기 팝업
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=500; //띄울 창의 넓이
			var sh=550;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('suimPtnrMbrPop?gbNo='+$("#gbNoForPop").val()+'&smNo='+$("#smNoForPop").val()+'&ptnrNo='+$("#ptnrNoForPop").val(),'SuimTmMbrPop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		});//$("#suimPtnrMbrPopBtn").click

	});//$(document).ready

	function openSMS(hpNo){
		if("${getSuimSuit17DtlBsc.suimRptState}" != 0 && "${getSuimSuit17DtlBsc.suimRptState}" != 11){
			alert("상신 이후 sms전송을 할 수 없습니다. '상신 취소'를 하거나 결재자에게 '결재 취소'를 받으십시오.");
			return;
		}
		var cw=screen.availWidth;
		var ch=screen.availHeight;
		var sw=380; //띄울 창의 넓이
		var sh=533;  //띄울 창의 높이
		var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
		var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
		window.open('simpleSMSForm?hpNo='+hpNo,'simpleSMS','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
	}//openSMS

	function openBrdRefPtnr(ptnrSearch){
		var cw=screen.availWidth;
		var ch=screen.availHeight;
		var sw=1010; //띄울 창의 넓이
		var sh=740;  //띄울 창의 높이
		var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
		var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
		window.open('referencePtnrBoardListPop?ptnrSearch='+ptnrSearch,'simpleSMS','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
	}//openSMS
	
	/* 조사 버튼 동작 */
	/** 박우현부장님, 임대성(개발테스트) **/
	function josaSubmit(suimRptState){
		if("${getSuimSuit17DtlBsc.suimRptState}" != 0 && "${getSuimSuit17DtlBsc.suimRptState}" != 11  && ("${mbrVo_Session.user_no}" != "4") && ("${mbrVo_Session.user_no}" != "1117")){
			alert("상신 이후 수정할 수 없습니다. '상신 취소'를 하거나 결재자에게 '결재 취소'를 받으십시오.");
			return;
		}
		udtSuimSuit17Dtl.submit();
	}
	/* 보고서작성 버튼 동작 */
	/** 박우현부장님, 임대성(개발테스트) **/
	function reportSubmit(suimRptState){
		if("${getSuimSuit17DtlBsc.suimRptState}" != 0 && "${getSuimSuit17DtlBsc.suimRptState}" != 11 && ("${mbrVo_Session.user_no}" != "4") && ("${mbrVo_Session.user_no}" != "1117")){
			alert("상신 이후 수정할 수 없습니다. '상신 취소'를 하거나 결재자에게 '결재 취소'를 받으십시오.");
			return;
		}
		udtSuimSuit17DtlRpt.submit();
	}
	/* word다운 버튼 동작 */
	function wordSubmit(suimRptState){
		/*
		if("${getSuimSuit17DtlBsc.suimRptState}" == 2 && "${mbrVo_Session.user_no}" != 4 && "${mbrVo_Session.user_no}" != 1877 && "${mbrVo_Session.user_no}" != 2411 && "${mbrVo_Session.user_no}" != 2586 && "${mbrVo_Session.user_no}" != 2941 && "${mbrVo_Session.user_no}" != 1305 && "${mbrVo_Session.user_no}" != 1337 && "${mbrVo_Session.user_no}" != 2079){
			alert("종결건은 워드전환이 불가능합니다.\n인보험기획팀에 문의하세요.");
			return;
		}
		suimSuit17DtlWordDown.submit();
		*/		
		
		var url = "suitWorkAuthChk";
		
		var param = {};
		
		param.suim_rpt_state = "${getSuimSuit17DtlBsc.suimRptState}";				//보고서 종결상태
		
		$.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        async: false,
		        dataType: "html", 
		        success: function(data){
		        	
		        	if (data == 1){			//권한이 있는 경우
		        		suimSuit17DtlWordDown.submit();
		        	}else if(data == 9){	//종결로인해 전환이 불가능한 경우
       	        		alert("종결건은 워드전환이 불가능합니다.\n인보험기획팀에 문의하세요.");    		
       	        	}else{
		        		alert("워드전환 권한이 없습니다.\n인보험기획팀에 문의하세요.");
		        	}
		        	
		        }
		});
	}
	
	/* 결재하기 */
	function action_report(action){
		if(action =='end') {
			if(!confirm("종결 하시겠습니까? \n종결 전 종결 내용 및 인보이스 정보를 다시 한번 확인해 주십시오.")){
				return;
			}									
		}else if(action =='returnRpt'){
			if(!confirm("반려 하시겠습니까?")){
				return;
			}
		}else if(action =='return_x'){
			if(!confirm("반려건을 재결재 하시겠습니까?")){
				return;
			}
		}else if(action =='submit_x'){
			if(!confirm("상신 취소 하시겠습니까?")){
				return;
			}
		}else if(action =='submit'){

		    if ($("#reportChk").val() == ''){
		        alert("조사완료 여부를 체크 해주세요.");
		        return;
            }

			if(!confirm("상신 하시겠습니까?\n상신 전 보고서 종결 내용 정보를 다시 한번 확인해 주십시오.")){
				return;
			}
		}else if(action == 'submit_e_x'){
			if(!confirm("종결 취소하시겠습니까?")){
				return;
			}
		}else if(action == 'report_supp'){
			if(!confirm("보완 요청 하시겠습니까?")){
				return;
			}
		}else if(action == 'report_supp_ok'){
			if(!confirm("보완 완료 하시겠습니까?")){
				return;
			}
		}else if(action =='returnRpt'){
			if(!confirm("반려 하시겠습니까?")){
				return;
			}
		}else if(action =='return_x'){
			if(!confirm("반려건을 재결재 하시겠습니까?")){
				return;
			}
		}else if(action == 'report_del'){
			if(!confirm("보고서를 삭제 하시겠습니까?")){
				return;
			}
		}else if(action == 'cancel'){
			if(!confirm("위임 취소 하시겠습니까?")){
				return;
			}
		}else if(action == 'cancel_x'){
			if(!confirm("위임 취소를 취소 하시겠습니까?")){
				return;
			}
		}
		
		$.post("./actionSuimSuit17ReportOk",
				{	
					 action  			:action
			 		,suimRptNo   		:$("#suimRptNo").val()
			 		//
				},
				function(data,status){
					if(status == "success"){
						if(data == 0){
							alert("저장 실패하였습니다. 관리자에게 문의해 주세요.");
						
						}else{
							
							if(action =='end') {
								alert("종결하였습니다.");	
							}else if(action =='submit_e_x'){
								alert("종결취소 하였습니다.");
							}else if(action =='submit'){
								alert("상신 하였습니다.");
							}else if(action =='returnRpt'){
								alert("반려 하였습니다.");
							}else if(action =='submit_x'){
								alert("상신취소 하였습니다.");
							}else if(action =='cancel'){
								alert("위임취소 하였습니다.");
							}else if(action =='return_x'){
								alert("반려건을 재결재 올렸습니다.");
							}else if(action =='cancel_x'){
								alert("위임취소를 취소 하였습니다.");
							}else if(action =='report_del'){
								alert("보고서를 삭제 하였습니다.");
								window.opener.location.reload();
								window.close();
							}else if(action =='un_lock'){
								alert("보고서를 잠금을 해제 하였습니다.");
							}
							
							window.opener.location.reload();
							window.location.reload();								
						}
					}else{
						alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
					}
				}
		);//post */
	}
	
</script>

<input type="hidden" name="gbNoForPop" id="gbNoForPop" value="317" />
<input type="hidden" name="ptnrNoForPop" id="ptnrNoForPop" value="${getSuimSuit17DtlBsc.ptnrId}" />
<input type="hidden" name="smNoForPop" id="smNoForPop" value="${getSuimSuit17DtlBsc.suimRptNo}" />
<input type="hidden" name="tmNoForPop" id="tmNoForPop" value="${getSuimSuit17DtlBsc.teamId}" />

<input type="hidden" id="reportChk" value="${getSuimSuit17DtlBsc.report1}"/>


			<c:set var="suimRptNo" value="${suimRptNo}"/>
			<div class= "tableStyle21">
				<table>
					<colgroup>
						<col width="20%">
						<col width="30%">
						<col width="15%">
						<col width="20%">
					</colgroup>
					<tr>
						<td align="left" style="border-right:0px;">
							
							<b> 보고서 기본 정보</b>
						</td>
						<td align="right" style="height:7px" colspan="3">
							
							<!-- 결재하기 -->
							<c:if test="${getSuimSuit17DtlBsc.suimRptState eq '0' or (mbrVo.user_no eq '1337' or mbrVo.user_no eq '2737' or mbrVo.user_no eq '1305') }"> <!-- $_a_work5_w -->
								<c:if test="${getSuimSuit17DtlBsc.editYN2 > 0}">
									<img src="./resources/ls_img/report/btn_rch_1.gif" onclick="action_report('submit');" style="cursor:pointer;"/>
								</c:if>
							</c:if>
							
							<!-- 결재취소하기 -->
							<c:if test="${getSuimSuit17DtlBsc.suimRptState eq '1' or (mbrVo.user_no eq '1337' or mbrVo.user_no eq '2737' or mbrVo.user_no eq '1305') }"> <!-- $_a_work6_w -->
								<c:if test="${getSuimSuit17DtlBsc.editYN2 > 0}">
									<img src="./resources/ls_img/report/btn_rch_1x.gif" onclick="action_report('submit_x');" style="cursor:pointer;"/>
								</c:if>
								<c:if test="${getSuimSuit17DtlBsc.suimRptState eq '11'}"> <!-- 반려건인지 확인 -->
									<img src="./resources/ls_img/report/btn_rch_return_x.gif" onclick="action_report('return_x');" style="cursor:pointer;"/>
								</c:if>																										
							</c:if>
							
							<c:if test="${getSuimSuit17DtlBsc.suimRptState eq '11'}">
								<c:if test="${getSuimSuit17DtlBsc.editYN2 > 0}">
									<img src="./resources/ls_img/report/btn_rch_1x.gif" onclick="action_report('submit_x');" style="cursor:pointer;"/>
								</c:if>
								<img src="./resources/ls_img/report/btn_rch_return_x.gif" onclick="action_report('return_x');" style="cursor:pointer;"/>	
							</c:if>
						
							<!-- 종결하기 -->
							<c:if test="${getSuimSuit17DtlBsc.suimRptState eq '1'}"> <!-- 건상태가 진행중이면 -->
								<c:if test="${mbrAuthVo_Session.mbr_pms_4 eq '1' or (mbrVo.user_no eq '1337' or mbrVo.user_no eq '2737' or mbrVo.user_no eq '1305') }">
									<img src="./resources/ls_img/report/btn_rch_return.gif" border=0 onclick="action_report('returnRpt');" style="cursor:pointer;"/>
									<img src="./resources/ls_img/report/btn_rch_2.gif" border=0 onclick="action_report('end');" style="cursor:pointer;"/>
								</c:if>
							</c:if>
							
							<!-- 종결취소하기 -->
							<c:if test="${getSuimSuit17DtlBsc.suimRptState eq '2' and mbrAuthVo_Session.mbr_pms_4 eq '1'}">
								<img src="./resources/ls_img/report/btn_rch_2x.gif" border=0 onclick="action_report('submit_e_x');" style="cursor:pointer;"/>
							</c:if>
							
							<!-- 위임취소하기 -->
							<c:if test="${getSuimSuit17DtlBsc.suimRptState ne '3' and getSuimSuit17DtlBsc.suimRptState ne '4' and getSuimSuit17DtlBsc.suimRptState ne '2' and  mbrAuthVo_Session.mbr_pms_4 eq '1'}">
								<img src="./resources/ls_img/report/btn_rch_3.gif" border=0 onclick="action_report('cancel');" style="cursor:pointer;"/>
							</c:if>
							
							<!-- 위임취소하기를 취소하기 -->
							<c:if test="${getSuimSuit17DtlBsc.suimRptState eq '3' and mbrAuthVo_Session.mbr_pms_4 eq '1' }">
								<img src="./resources/ls_img/report/btn_rch_3x.gif" border=0 onclick="action_report('cancel_x');" style="cursor:pointer;"/>
							</c:if>
							
							<!-- 보고서 삭제하기 -->
							<c:if test="${getSuimSuit17DtlBsc.suimRptState ne '2' and mbrAuthVo_Session.mbr_pms_3 eq '1' }">
								<img src="./resources/ls_img/report/btn_report_del.gif" border=0 onclick="action_report('report_del');" style="cursor:pointer;"/>
							</c:if>
							
							<input type="hidden" id = "suimRptNo" value= "${getSuimSuit17DtlBsc.suimRptNo}"/>
							<input type="hidden" id = "suimRptTopTm" value= "${getSuimSuit17DtlBsc.teamId}"/>
						</td>
						<!-- 보고서 상태 값 변경 관리 끝 -->
					</tr>
					<tr>
						<td bgcolor="#E7ECF1"><b>ㆍ접수번호</b></td>
						<td colspan="3" style="border-right:0;">
							${getSuimSuit17DtlBsc.suimAcceptNo}
						</td>
					</tr>
					<tr>
						<td bgcolor="#E7ECF1"><b>ㆍ처리팀</b></td>
						<td>${getSuimSuit17DtlBsc.teamName}</td>
						<td bgcolor="#E7ECF1"><b>ㆍ처리 담당자</b></td>
						<td style="border-right:0;">
							<c:if test="${getSuimSuit17DtlBsc.mbrChgYN > '0'}">
								<img src="./resources/ls_img/report/icon_change.gif" id="suimTmMbrPopBtn" style="cursor:pointer;" border="0" width="14" height="14">
							</c:if>
							${getSuimSuit17DtlBsc.userName}
							<c:if test="${mbrVoForBody.handphone != ''}">
								&nbsp;<img src="./resources/ls_img/report/icon_hp.gif" style="cursor:pointer;" onclick="openSMS('${mbrVoForBody.handphone}', '${getSuimSuit17DtlBsc.suimRptState}');" />
								${mbrVoForBody.handphone}
							</c:if>
						</td>
					</tr>
					<tr>
						<td bgcolor="#E7ECF1"><b>ㆍ보험사</b></td>
						<td colspan="3">
							${getSuimSuit17DtlBsc.ptnrName}
						</td>
					</tr>
					<tr>
						<td bgcolor="#E7ECF1"><b>ㆍ조사내용</b></td>
						<td>
							<form name="udtSuimSuit17Dtl" method="POST" action="./suimSuit17DtlUdt">
								<input type="hidden" id="suimRptNo" name="suimRptNo" value="${getSuimSuit17DtlBsc.suimRptNo}"/> 
							</form>
							<c:if test="${getSuimSuit17DtlBsc.editYN2 > 0}">
								<img src="./resources/ls_img/ls_report/icon_contract_josa.gif" onclick="josaSubmit(${getSuimSuit17DtlBsc.suimRptState})" style="cursor:pointer;">
								<img src="./resources/ls_img/ls_report/icon_contract_report.gif" onclick="reportSubmit(${getSuimSuit17DtlBsc.suimRptState})" style="cursor:pointer;">
							</c:if>
							<form name="udtSuimSuit17DtlRpt" method="POST" action="./suimSuit17DtlRptUdt">
								<input type="hidden" id="suimRptNo" name="suimRptNo" value="${getSuimSuit17DtlBsc.suimRptNo}"/>		
							</form>
						</td>
						<td bgcolor="#E7ECF1"><b>ㆍ처리결과</b></td>
						<td>
							<form name="suimSuit17DtlWordDown" method="GET" action="./suimSuit17RptWordDown">
								<input type="hidden" id="suimRptNo" name="suimRptNo" value="${getSuimSuit17DtlBsc.suimRptNo}"/> 
							</form>
							<%-- <c:if test="${mbrAuthSessionVo.mbr_pms_19}"> --%>
								<img src="./resources/ls_img/ls_report/icon_word.gif" onclick="wordSubmit(${getSuimSuit17DtlBsc.suimRptState})" style="cursor:pointer;">
							<%-- </c:if> --%>
						</td>
					</tr>
					<tr>
						<td bgcolor="#DCFFDC"><b>ㆍ조사완료여부</b></td>
						<td colspan="3">
							<c:if test="${getSuimSuit17DtlBsc.report1 eq '01'}">
							조사완료
							</c:if>
							<c:if test="${getSuimSuit17DtlBsc.report1 eq '02'}">
							조사실패
							</c:if>
						</td>
					</tr>
					<tr>
						<td bgcolor="#FFFFCC"><b>ㆍ설계번호</b></td>
						<td colspan="3">${getSuimSuit17DtlBsc.infoA}</td>
					</tr>
					<tr>
						<td bgcolor="#FFFFCC"><b>ㆍ물건구분명</b></td>
						<td colspan="3">${getSuimSuit17DtlBsc.infoM}</td>
					</tr>
					<tr>
						<td bgcolor="#DCFFDC"><b>ㆍ실사일자</b></td>
						<td colspan="3">${getSuimSuit17DtlBsc.reC}</td>
					</tr>
					<tr>
						<td bgcolor="#DCFFDC"><b>ㆍ실사자명</b></td>
						<td colspan="3">${getSuimSuit17DtlBsc.userName}</td>
					</tr>
					<tr>
						<td bgcolor="#DCFFDC"><b>ㆍ실사자 휴대전화번호</b></td>
						<td colspan="3">${mbrVoForBody.handphone}</td>
					</tr>
					<tr>
						<td bgcolor="#DCFFDC"><b>ㆍ책임자명</b></td>
						<td colspan="3">${getSuimSuit17DtlBsc.reF}</td>
					</tr>
					<tr>
						<td bgcolor="#DCFFDC"><b>ㆍ건물급수 확인사항</b></td>
						<td colspan="3">${getSuimSuit17DtlBsc.reG}급</td>
					</tr>
					<tr>
						<td bgcolor="#DCFFDC"><b>ㆍ건물급수 일치여부</b></td>
						<td colspan="3">${getSuimSuit17DtlBsc.reH}</td>
					</tr>
					<tr>
						<td bgcolor="#DCFFDC"><b>ㆍ가입업종 확인사항</b></td>
						<td colspan="3">${getSuimSuit17DtlBsc.reI}</td>
					</tr>
					<tr>
						<td bgcolor="#DCFFDC"><b>ㆍ가입업종 일치여부</b></td>
						<td colspan="3">${getSuimSuit17DtlBsc.reJ}</td>
					</tr>
					<tr>
						<td bgcolor="#DCFFDC"><b>ㆍ요율업종 확인사항</b></td>
						<td colspan="3">${getSuimSuit17DtlBsc.reK}</td>
					</tr>
					<tr>
						<td bgcolor="#DCFFDC"><b>ㆍ요율업종 일치여부</b></td>
						<td colspan="3">${getSuimSuit17DtlBsc.reL}</td>
					</tr>
					<tr>
						<td bgcolor="#FFFFCC"><b>ㆍ소재지 우편번호</b></td>
						<td colspan="3">${getSuimSuit17DtlBsc.infoAa}</td>
					</tr>
					<tr>
						<td bgcolor="#FFFFCC"><b>ㆍ소재지 주소</b></td>
						<td colspan="3">${getSuimSuit17DtlBsc.infoAb}</td>
					</tr>
					<tr>
						<td bgcolor="#FFFFCC"><b>ㆍ소재지 기타주소</b></td>
						<td colspan="3">
							<img src="./resources/ls_img/ls_report/btns_view.gif" onclick="window.open('suimSuit17DtlView?suimRptNo='+${getSuimSuit17DtlBsc.suimRptNo}+'&data=infoAc','_blank','width=540,height=290,scrollbars=no');" style="cursor:pointer;">
						</td>
					</tr>
					<tr>
						<td bgcolor="#DCFFDC"><b>ㆍ소재지 일치여부</b></td>
						<td colspan="3">${getSuimSuit17DtlBsc.reP}</td>
					</tr>
					<tr>
						<td bgcolor="#DCFFDC"><b>ㆍ소유자 확인사항</b></td>
						<td colspan="3">${getSuimSuit17DtlBsc.reQ}</td>
					</tr>
					<tr>
						<td bgcolor="#DCFFDC"><b>ㆍ소유자 일치여부</b></td>
						<td colspan="3">${getSuimSuit17DtlBsc.reR}</td>
					</tr>
					<tr>
						<td bgcolor="#FFFFCC"><b>ㆍ중점요청사항</b></td>
						<td colspan="3">${getSuimSuit17DtlBsc.infoAe}</td>
					</tr>
					<tr>
						<td bgcolor="#DCFFDC"><b>ㆍ중점요청사항 일치여부</b></td>
						<td colspan="3">${getSuimSuit17DtlBsc.reT}</td>
					</tr>
					<tr>
						<td bgcolor="#DCFFDC"><b>ㆍ구조건물구조 조사의견</b></td>
						<td colspan="3">${getSuimSuit17DtlBsc.reU}</td>
					</tr>
					<tr>
						<td bgcolor="#DCFFDC"><b>ㆍ구조방화구획 조사의견</b></td>
						<td colspan="3">${getSuimSuit17DtlBsc.reV}</td>
					</tr>
					<tr>
						<td bgcolor="#DCFFDC"><b>ㆍ구조확인의견</b></td>
						<td colspan="3">${getSuimSuit17DtlBsc.reW}</td>
					</tr>
					<tr>
						<td bgcolor="#DCFFDC"><b>ㆍ업종일반층별업종 조사의견</b></td>
						<td colspan="3">${getSuimSuit17DtlBsc.reX}</td>
					</tr>
					<tr>
						<td bgcolor="#DCFFDC"><b>ㆍ업종일반 확인의견</b></td>
						<td colspan="3">${getSuimSuit17DtlBsc.reY}</td>
					</tr>
					<tr>
						<td bgcolor="#DCFFDC"><b>ㆍ업종공장공정 조사의견</b></td>
						<td colspan="3">${getSuimSuit17DtlBsc.reZ}</td>
					</tr>
					<tr>
						<td bgcolor="#DCFFDC"><b>ㆍ업종공장생산품 조사의견</b></td>
						<td colspan="3">${getSuimSuit17DtlBsc.reAa}</td>
					</tr>
					<tr>
						<td bgcolor="#DCFFDC"><b>ㆍ업종공장 확인의견</b></td>
						<td colspan="3">${getSuimSuit17DtlBsc.reAb}</td>
					</tr>
					<tr>
						<td bgcolor="#DCFFDC"><b>ㆍ소재지 확인의견</b></td>
						<td colspan="3">${getSuimSuit17DtlBsc.reAc}</td>
					</tr>
					
				</table>
			</div>
			
			<br>
			
			<div class= "tableStyle21">
				<table>
					<colgroup>
						<col width="25%">
						<col width="75%">
					</colgroup>
					<tr>
						<td bgcolor="#EDEDED"><b>ㆍ가입설계번호</b></td>
						<td>${getSuimSuit17DtlBsc.infoA}</td>
					</tr>
					<tr>
						<td bgcolor="#EDEDED"><b>ㆍ설계상태</b></td>
						<td>${getSuimSuit17DtlBsc.infoB}</td>
					</tr>
					<tr>
						<td bgcolor="#EDEDED"><b>ㆍ인수승인현황</b></td>
						<td>${getSuimSuit17DtlBsc.infoC}</td>
					</tr>
					<tr>
						<td bgcolor="#EDEDED"><b>ㆍ심사자</b></td>
						<td>${getSuimSuit17DtlBsc.infoD}</td>
					</tr>
					<tr>
						<td bgcolor="#EDEDED"><b>ㆍ심사구분</b></td>
						<td colspan="3">${getSuimSuit17DtlBsc.infoE}</td>
					</tr>
					<tr>
						<td bgcolor="#EDEDED"><b>ㆍ계약번호</b></td>
						<td>${getSuimSuit17DtlBsc.infoF}</td>
					</tr>
					<tr>
						<td bgcolor="#EDEDED"><b>ㆍ계약상태</b></td>
						<td>${getSuimSuit17DtlBsc.infoG}</td>
					</tr>
					<tr>
						<td bgcolor="#EDEDED"><b>ㆍ조사업체</b></td>
						<td>${getSuimSuit17DtlBsc.infoH}</td>
					</tr>
					<tr>
						<td bgcolor="#EDEDED"><b>ㆍ이미지등록여부</b></td>
						<td>${getSuimSuit17DtlBsc.infoI}</td>
					</tr>
					<tr>
						<td bgcolor="#EDEDED"><b>ㆍ진행상황</b></td>
						<td>${getSuimSuit17DtlBsc.infoJ}</td>
					</tr>
					<tr>
						<td bgcolor="#EDEDED"><b>ㆍ조사상태내역</b></td>
						<td>${getSuimSuit17DtlBsc.infoK}</td>
					</tr>
					<tr>
						<td bgcolor="#EDEDED"><b>ㆍ물건구분</b></td>
						<td>
							<c:choose>
								<c:when test="${getSuimSuit17DtlBsc.bdType eq 1}">
									일반
								</c:when>
								<c:otherwise>
									공장
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<td bgcolor="#EDEDED"><b>ㆍ물건구분명</b></td>
						<td>${getSuimSuit17DtlBsc.infoM}</td>
					</tr>
					<tr>
						<td bgcolor="#EDEDED"><b>ㆍ건물급수</b></td>
						<td>${getSuimSuit17DtlBsc.infoN}</td>
					</tr>
					<tr>
						<td bgcolor="#EDEDED"><b>ㆍ가입업종명</b></td>
						<td>${getSuimSuit17DtlBsc.infoO}</td>
					</tr>
					<tr>
						<td bgcolor="#EDEDED"><b>ㆍ요율업종명</b></td>
						<td>${getSuimSuit17DtlBsc.infoP}</td>
					</tr>
					<tr>
						<td bgcolor="#EDEDED"><b>ㆍ계약자명</b></td>
						<td>${getSuimSuit17DtlBsc.policyholderNm}</td>
					</tr>
					<tr>
						<td bgcolor="#EDEDED"><b>ㆍ계약자 자택전화번호</b></td>
						<td>${getSuimSuit17DtlBsc.policyholderTel1}</td>
					</tr>
					<tr>
						<td bgcolor="#EDEDED"><b>ㆍ계약자 회사전화번호</b></td>
						<td>
							<img src="./resources/ls_img/ls_report/btns_view.gif" onclick="window.open('suimSuit17DtlView?suimRptNo='+${getSuimSuit17DtlBsc.suimRptNo}+'&data=policyholderTel2','_blank','width=540,height=290,scrollbars=no');" style="cursor:pointer;">
						</td>
					</tr>
					<tr>
						<td bgcolor="#EDEDED"><b>ㆍ계약자 핸드폰번호</b></td>
						<td>${getSuimSuit17DtlBsc.policyholderHp}</td>
					</tr>
					<tr>
						<td bgcolor="#EDEDED"><b>ㆍ의뢰일자</b></td>
						<td>${getSuimSuit17DtlBsc.infoU}</td>
					</tr>
					<tr>
						<td bgcolor="#EDEDED"><b>ㆍ실사일자</b></td>
						<td>${getSuimSuit17DtlBsc.infoUa}</td>
					</tr>
					<tr>
						<td bgcolor="#EDEDED"><b>ㆍ일치여부</b></td>
						<td>${getSuimSuit17DtlBsc.infoUb}</td>
					</tr>
					
					
					<tr>
						<td bgcolor="#EDEDED"><b>ㆍ지점명</b></td>
						<td>${getSuimSuit17DtlBsc.infoV}</td>
					</tr>
					<tr>
						<td bgcolor="#EDEDED"><b>ㆍ지점전화번호</b></td>
						<td>
							<img src="./resources/ls_img/ls_report/btns_view.gif" onclick="window.open('suimSuit17DtlView?suimRptNo='+${getSuimSuit17DtlBsc.suimRptNo}+'&data=infoW','_blank','width=540,height=290,scrollbars=no');" style="cursor:pointer;">
						</td>
					</tr>
					<tr>
						<td bgcolor="#EDEDED"><b>ㆍ점포명</b></td>
						<td>${getSuimSuit17DtlBsc.infoX}</td>
					</tr>
					<tr>
						<td bgcolor="#EDEDED"><b>ㆍ점포명</b></td>
						<td>${getSuimSuit17DtlBsc.infoY}</td>
					</tr>
					<tr>
						<td bgcolor="#EDEDED"><b>ㆍ취급자 전화번호</b></td>
						<td>
							<img src="./resources/ls_img/ls_report/btns_view.gif" onclick="window.open('suimSuit17DtlView?suimRptNo='+${getSuimSuit17DtlBsc.suimRptNo}+'&data=infoZ','_blank','width=540,height=290,scrollbars=no');" style="cursor:pointer;">
						</td>
					</tr>
					<tr>
						<td bgcolor="#EDEDED"><b>ㆍ우편번호</b></td>
						<td>${getSuimSuit17DtlBsc.infoAa}</td>
					</tr>
					<tr>
						<td bgcolor="#EDEDED"><b>ㆍ주소</b></td>
						<td>${getSuimSuit17DtlBsc.infoAb}</td>
					</tr>
					<tr>
						<td bgcolor="#EDEDED"><b>ㆍ상세주소</b></td>
						<td>
							<img src="./resources/ls_img/ls_report/btns_view.gif" onclick="window.open('suimSuit17DtlView?suimRptNo='+${getSuimSuit17DtlBsc.suimRptNo}+'&data=infoAc','_blank','width=540,height=290,scrollbars=no');" style="cursor:pointer;">
						</td>
					</tr>
					<tr>
						<td bgcolor="#EDEDED"><b>ㆍ소유자명</b></td>
						<td>${getSuimSuit17DtlBsc.infoAd}</td>
					</tr>
					<tr>
						<td bgcolor="#EDEDED"><b>ㆍ중점요청사항</b></td>
						<td>${getSuimSuit17DtlBsc.infoAe}</td>
					</tr>
					<tr>
						<td bgcolor="#EDEDED"><b>ㆍ상품명</b></td>
						<td>${getSuimSuit17DtlBsc.infoAf}</td>
					</tr>
					
				</table>
			</div>
