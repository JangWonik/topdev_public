<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script>
	$(document).ready(function(){
		$.ajaxSetup({cache:false});
		if ( "${getSuimSuit12DtlBsc.editYN2}" < 1 ){
			alert("접근 권한이 없습니다.");
			window.close();
			return false;
		}
		
		//취급기관 전화번호
		$("#rqDhOrgTlNo").html( phoneFomatter( "${getSuimSuit12DtlBsc.rqDhOrgTlNo}" ) );
		
		//심사담당기관전화번호
		$("#rqUdChrOrgTlNo").html( phoneFomatter( "${getSuimSuit12DtlBsc.rqUdChrOrgTlNo}" ) );
		
		//심사담당기관팩스번호
		$("#rqUdChrOrgFxNo").html( phoneFomatter( "${getSuimSuit12DtlBsc.rqUdChrOrgFxNo}" ) );
		
		//심사담당직원번호
		$("#rqUdChrStfNo").html( phoneFomatter( "${getSuimSuit12DtlBsc.rqUdChrStfNo}" ) );
		
		//계약자 전화번호
		$("#rqCrtHomeTlNo").html( phoneFomatter( "${getSuimSuit12DtlBsc.rqCrtHomeTlNo}" ) );
		
		//계약자 직장번호
		$("#rqCrtWpcTlNo").html( phoneFomatter( "${getSuimSuit12DtlBsc.rqCrtWpcTlNo}" ) );
		
		//계약자 핸드폰
		$("#rqCrtHndphTlNo").html( phoneFomatter( "${getSuimSuit12DtlBsc.rqCrtHndphTlNo}" ) );
		
		//취급직원번호
		$("#rqDhStfNo").html( phoneFomatter( "${getSuimSuit12DtlBsc.rqDhStfNo}" ) );
		
		//취급직원핸드폰
		$("#rqDhStfTlNo").html( phoneFomatter( "${getSuimSuit12DtlBsc.rqDhStfTlNo}" ) );
		
		
		
		if("${getSuimSuit12DtlBsc.rstPptyNvCpltYn}" == 2){
			$("#notjudge").css("display","block");
			
		}
		
		
		$("#suimTmMbrPopBtn").click(function(){//담당 팀, 담당 직원 바꾸기 팝업
			if("${getSuimSuit12DtlBsc.suimRptState}" != 0 && "${getSuimSuit12DtlBsc.suimRptState}" != 11 && "${mbrVo.user_no}" != '4' ){
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

	function openSMS(hpNo, suimRptState){
		if("${getSuimSuit12DtlBsc.suimRptState}" != 0 && "${getSuimSuit12DtlBsc.suimRptState}" != 11){
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
	function josaSubmit(suimRptState){
		if( ("${getSuimSuit12DtlBsc.suimRptState}" != 0 && "${getSuimSuit12DtlBsc.suimRptState}" != 11) && ("${mbrVo_Session.user_no}" != "1337") &&  ("${mbrVo_Session.user_no}" != "2737") &&  ("${mbrVo_Session.user_no}" != "1305") && ("${mbrVo_Session.user_no}" != "1117")){
			alert("상신 이후 수정할 수 없습니다. '상신 취소'를 하거나 결재자에게 '결재 취소'를 받으십시오.");
			return;
		}
		udtSuimSuit12Dtl.submit();
	}
	/* 보고서작성 버튼 동작 */
	function reportSubmit(suimRptState){
		if( ("${getSuimSuit12DtlBsc.suimRptState}" != 0 && "${getSuimSuit12DtlBsc.suimRptState}" != 11) && ("${mbrVo_Session.user_no}" != "1337") && ("${mbrVo_Session.user_no}" != "2737") &&  ("${mbrVo_Session.user_no}" != "1305") && ("${mbrVo_Session.user_no}" != "1117") ){
			alert("상신 이후 수정할 수 없습니다. '상신 취소'를 하거나 결재자에게 '결재 취소'를 받으십시오.");
			return;
		}
		udtSuimSuit12DtlRpt.submit();
	}
	/* word다운 버튼 동작 */
	function wordSubmit(suimRptState){
		/*
		//박우현
		if("${getSuimSuit12DtlBsc.suimRptState}" == 2 && "${mbrVo_Session.user_no}" != 4 && "${mbrVo_Session.user_no}" != 1877 && "${mbrVo_Session.user_no}" != 2411 && "${mbrVo_Session.user_no}" != 2586 && "${mbrVo_Session.user_no}" != 2941 && "${mbrVo_Session.user_no}" != 1305 && "${mbrVo_Session.user_no}" != 1337 && "${mbrVo_Session.user_no}" != 2079){
			alert("종결건은 워드전환이 불가능합니다.\n인보험기획팀에 문의하세요.");
			return;
		}
		suimSuit12DtlWordDown.submit();
		*/
		
		var url = "suitWorkAuthChk";
		
		var param = {};
		
		param.suim_rpt_state = "${getSuimSuit12DtlBsc.suimRptState}";				//보고서 종결상태
		
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
		    		suimSuit12DtlWordDown.submit();
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
			
			$.post("./actionSuimSuit12ReportOk",
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


<input type="hidden" name="gbNoForPop" id="gbNoForPop" value="312" />
<input type="hidden" name="ptnrNoForPop" id="ptnrNoForPop" value="${getSuimSuit12DtlBsc.ptnrId}" />
<input type="hidden" name="smNoForPop" id="smNoForPop" value="${getSuimSuit12DtlBsc.suimRptNo}" />
<input type="hidden" name="tmNoForPop" id="tmNoForPop" value="${getSuimSuit12DtlBsc.teamId}" />

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
										
										<b> 보고서 기본 정보 ${getSuimSuit12DtlBsc.editYN2}</b>
									</td>
									<td align="right"style="height:7px" colspan="3">
										
										<!-- 결재하기 -->
										<c:if test="${getSuimSuit12DtlBsc.suimRptState eq '0' or (mbrVo.user_no eq '1337' or mbrVo.user_no eq '2737' or mbrVo.user_no eq '1305') }"> <!-- $_a_work5_w -->
											<c:if test="${getSuimSuit12DtlBsc.editYN2 > 0}">
												<img src="./resources/ls_img/report/btn_rch_1.gif" onclick="action_report('submit');" style="cursor:pointer;"/>
											</c:if>
										</c:if>
										
										<!-- 결재취소하기 -->
										<c:if test="${getSuimSuit12DtlBsc.suimRptState eq '1' or (mbrVo.user_no eq '1337' or mbrVo.user_no eq '2737' or mbrVo.user_no eq '1305') }"> <!-- $_a_work6_w -->
											<c:if test="${getSuimSuit12DtlBsc.editYN2 > 0}">
												<img src="./resources/ls_img/report/btn_rch_1x.gif" onclick="action_report('submit_x');" style="cursor:pointer;"/>
											</c:if>
											
											<c:if test="${getSuimSuit12DtlBsc.suimRptState > 0}"> <!-- 반려건인지 확인 -->
												<img src="./resources/ls_img/report/btn_rch_return_x.gif" onclick="action_report('return_x');" style="cursor:pointer;"/>
											</c:if>																										
										</c:if>
										
										<c:if test="${getSuimSuit12DtlBsc.suimRptState eq '11' or (mbrVo.user_no eq '1337' or mbrVo.user_no eq '2737' or mbrVo.user_no eq '1305') }">
											<c:if test="${getSuimSuit12DtlBsc.editYN2 > 0}">
												<img src="./resources/ls_img/report/btn_rch_1x.gif" onclick="action_report('submit_x');" style="cursor:pointer;"/>
											</c:if>
											<img src="./resources/ls_img/report/btn_rch_return_x.gif" onclick="action_report('return_x');" style="cursor:pointer;"/>	
										</c:if>
									
										<!-- 종결하기 -->
										<c:if test="${getSuimSuit12DtlBsc.suimRptState eq '1' }"> <!-- 건상태가 진행중이면 -->
											<c:if test="${mbrAuthVo_Session.mbr_pms_4 eq '1' or (mbrVo.user_no eq '1337' or mbrVo.user_no eq '2737' or mbrVo.user_no eq '1305') }">
												<img src="./resources/ls_img/report/btn_rch_return.gif" border=0 onclick="action_report('returnRpt');" style="cursor:pointer;"/>
												<img src="./resources/ls_img/report/btn_rch_2.gif" border=0 onclick="action_report('end');" style="cursor:pointer;"/>
											</c:if>
										</c:if>
										
										<!-- 종결취소하기 -->
										<c:if test="${getSuimSuit12DtlBsc.suimRptState eq '2' and mbrAuthVo_Session.mbr_pms_4 eq '1'}">
											<img src="./resources/ls_img/report/btn_rch_2x.gif" border=0 onclick="action_report('submit_e_x');" style="cursor:pointer;"/>
										</c:if>
										
										<!-- 위임취소하기 -->
										<c:if test="${getSuimSuit12DtlBsc.suimRptState ne '3' and getSuimSuit12DtlBsc.suimRptState ne '4' and getSuimSuit12DtlBsc.suimRptState ne '2' and  mbrAuthVo_Session.mbr_pms_4 eq '1'}">
											<img src="./resources/ls_img/report/btn_rch_3.gif" border=0 onclick="action_report('cancel');" style="cursor:pointer;"/>
										</c:if>
										
										<!-- 위임취소하기를 취소하기 -->
										<c:if test="${getSuimSuit12DtlBsc.suimRptState eq '3' and mbrAuthVo_Session.mbr_pms_4 eq '1' }">
											<img src="./resources/ls_img/report/btn_rch_3x.gif" border=0 onclick="action_report('cancel_x');" style="cursor:pointer;"/>
										</c:if>
										
										<!-- 보고서 삭제하기 -->
										<c:if test="${getSuimSuit12DtlBsc.suimRptState ne '2' and mbrAuthVo_Session.mbr_pms_3 eq '1' }">
											<img src="./resources/ls_img/report/btn_report_del.gif" border=0 onclick="action_report('report_del');" style="cursor:pointer;"/>
										</c:if>
										
										<input type="hidden" id = "suimRptNo" value= "${getSuimSuit12DtlBsc.suimRptNo}"/>
										<input type="hidden" id = "suimRptTopTm" value= "${getSuimSuit12DtlBsc.teamId}"/>
									</td>
									<!-- 보고서 상태 값 변경 관리 끝 -->
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ접수번호</b></td>
									<td colspan="3" style="border-right:0;">
										<a href="">${getSuimSuit12DtlBsc.suimAcceptNo}</a>
									</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ처리팀</b></td>
									<td>${getSuimSuit12DtlBsc.teamName}</td>
									<td bgcolor="#E7ECF1"><b>ㆍ처리 담당자</b></td>
									<td style="border-right:0;">
										<c:if test="${getSuimSuit12DtlBsc.mbrChgYN > '0'}">
											<img src="./resources/ls_img/report/icon_change.gif" id="suimTmMbrPopBtn" style="cursor:pointer;" border="0" width="14" height="14">
										</c:if>
										${getSuimSuit12DtlBsc.userName}
										<c:if test="${mbrVoForBody.handphone != ''}">
											&nbsp;<img src="./resources/ls_img/report/icon_hp.gif" style="cursor:pointer;" onclick="openSMS('${mbrVoForBody.handphone}', '${getSuimSuit12DtlBsc.suimRptState}');" />
											${mbrVoForBody.handphone}
										</c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ보험사</b></td>
									<td colspan="3">
										${getSuimSuit12DtlBsc.ptnrName}
									</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ조사내용</b></td>
									<td>
										<form name="udtSuimSuit12Dtl" method="POST" action="./suimSuit12DtlUdt">
											<input type="hidden" id="suimRptNo" name="suimRptNo" value="${getSuimSuit12DtlBsc.suimRptNo}"/> 
										</form>
										<c:if test="${getSuimSuit12DtlBsc.editYN2 > 0}">
											<img src="./resources/ls_img/ls_report/icon_contract_josa.gif" onclick="josaSubmit('${getSuimSuit12DtlBsc.suimRptState}')" style="cursor:pointer;">
											<img src="./resources/ls_img/ls_report/icon_contract_report.gif" onclick="reportSubmit('${getSuimSuit12DtlBsc.suimRptState}')" style="cursor:pointer;">
										</c:if>
										<form name="udtSuimSuit12DtlRpt" method="POST" action="./suimSuit12DtlRptUdt">
											<input type="hidden" id="suimRptNo" name="suimRptNo" value="${getSuimSuit12DtlBsc.suimRptNo}"/>		
										</form>
									</td>
									<td bgcolor="#E7ECF1"><b>ㆍ처리결과</b></td>
									<td>
										<form name="suimSuit12DtlWordDown" method="GET" action="./suimSuit12RptWordDown">
											<input type="hidden" id="suimRptNo" name="suimRptNo" value="${getSuimSuit12DtlBsc.suimRptNo}"/> 
										</form>
										<%-- <c:if test="${mbrVo_Session.mbr_pms_19}"> --%>
										<img src="./resources/ls_img/ls_report/icon_word.gif" onclick="wordSubmit('${getSuimSuit12DtlBsc.suimRptState}')" style="cursor:pointer;">
										<%-- </c:if> --%>
									</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ물건구분</b></td>
									<td colspan="3">
										<c:if test="${getSuimSuit12DtlBsc.bdType eq '1'}">
										일반
										</c:if>
										<c:if test="${getSuimSuit12DtlBsc.bdType eq '2'}">
										공장
										</c:if>
									</td>
								</tr>
								
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ조사완료여부</b></td>
									<td colspan="3">
<%-- 										<c:if test="${getSuimSuit12DtlBsc.report1 eq '01'}"> --%>
<!-- 										조사완료 -->
<%-- 										</c:if> --%>
<%-- 										<c:if test="${getSuimSuit12DtlBsc.report1 eq '02'}"> --%>
<!-- 										조사실패 -->
<%-- 										</c:if> --%>
										<c:if test="${getSuimSuit12DtlBsc.rstPptyNvCpltYn eq '1'}">
											조사완료
										</c:if>
										<c:if test="${getSuimSuit12DtlBsc.rstPptyNvCpltYn eq '2'}">
											조사실패
										</c:if>
										<c:if test="${getSuimSuit12DtlBsc.rstPptyNvCpltYn eq ''}">
											해당없음
										</c:if>
										
									</td>
								</tr>
								
								<tr id="notjudge" style="display:none;">
									<td bgcolor="#DCFFDC"><b>ㆍ미심사사유코드</b></td>
									<td colspan="3">
										<c:if test="${getSuimSuit12DtlBsc.rstUcNspRs eq '01'}">고객의 방문거절(조사거부 포함)</c:if>
										<c:if test="${getSuimSuit12DtlBsc.rstUcNspRs eq '02'}">연락불가(전화번호오류 포함)</c:if>
										<c:if test="${getSuimSuit12DtlBsc.rstUcNspRs eq '03'}">계약취소</c:if>
										<c:if test="${getSuimSuit12DtlBsc.rstUcNspRs eq ''}"></c:if>
									</td>
								</tr>
								
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ적부조사결과코드</b></td>
									<td colspan="3">
										<c:if test="${getSuimSuit12DtlBsc.rstNvRst eq '01'}">양호(일치)</c:if>
										<c:if test="${getSuimSuit12DtlBsc.rstNvRst eq '02'}">수정필요(불일치)</c:if>
										<c:if test="${getSuimSuit12DtlBsc.rstNvRst eq ''}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ적부조사결과의견</b></td>
									<td colspan="3">${getSuimSuit12DtlBsc.rstNvRstCtn}</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ파일갯수</b></td>
									<td colspan="3">${getSuimSuit12DtlBsc.rstRptgFileCt}</td>
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
									<td bgcolor="#E7ECF1"><b>ㆍ송신기관</b></td>
									<td>${getSuimSuit12DtlBsc.rqTrsOrgCd}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ수신기관</b></td>
									<td>${getSuimSuit12DtlBsc.rstRcvOrgCd}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ심사구분코드</b></td>
									<td>
									<c:choose>
										<c:when test="${getSuimSuit12DtlBsc.rqRqFlgCd eq '11'}">
											재물적부
										</c:when>
										<c:otherwise>
											코드가 잘못 되었습니다!
										</c:otherwise>
									</c:choose>
										</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ처리구분코드</b></td>
									<td>
										<c:if test="${getSuimSuit12DtlBsc.rqDlFlgCd eq '01'}">사전의뢰</c:if>
										<c:if test="${getSuimSuit12DtlBsc.rqDlFlgCd eq '02'}">사후의뢰</c:if>
										<c:if test="${getSuimSuit12DtlBsc.rqDlFlgCd eq '03'}">취소</c:if>
										<c:if test="${getSuimSuit12DtlBsc.rqDlFlgCd eq ''}">코드가 잘못 되었습니다!</c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ적부요청일자</b></td>
									<td>${getSuimSuit12DtlBsc.rqPptyRqDt}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ설계번호</b></td>
									<td>${getSuimSuit12DtlBsc.rqPlNo}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ의뢰순번</b></td>
									<td>${getSuimSuit12DtlBsc.rqRequSeqNo}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ증번</b></td>
									<td>${getSuimSuit12DtlBsc.rqPlyNo}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ상품코드</b></td>
									<td>${getSuimSuit12DtlBsc.rqGdCd}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ상품명</b></td>
									<td>${getSuimSuit12DtlBsc.rqGdNm}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ상위취급기관코드</b></td>
									<td>${getSuimSuit12DtlBsc.rqPprDhOrgCd}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ상위취급기관명</b></td>
									<td>${getSuimSuit12DtlBsc.rqPprDhOrgNm}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ취급기관코드</b></td>
									<td>${getSuimSuit12DtlBsc.rqDhOrgCd}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ취급기관명</b></td>
									<td>${getSuimSuit12DtlBsc.rqDhOrgNm}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ취급기관전화번호</b></td>
									<td id="rqDhOrgTlNo"> 
									</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ취급직원번호</b></td>
									<td id="rqDhStfNo"></td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ취급직원명</b></td>
									<td>
										${getSuimSuit12DtlBsc.rqDhStfNm}
									</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ취급직원핸드폰</b></td>
									<td id="rqDhStfTlNo"></td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ심사담당기관코드</b></td>
									<td>${getSuimSuit12DtlBsc.rqUdChrOrgNo}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ심사담당기관명</b></td>
									<td>${getSuimSuit12DtlBsc.rqUdChrOrgNm}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ심사담당기관전화번호</b></td>
									<td id="rqUdChrOrgTlNo"></td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ심사담당기관팩스번호</b></td>
									<td id="rqUdChrOrgFxNo"></td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ심사담당직원번호</b></td>
									<td id="rqUdChrStfNo"></td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ심사담당직원명</b></td>
									<td>${getSuimSuit12DtlBsc.rqUdChrStfNm}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ계약자명</b></td>
									<td>${getSuimSuit12DtlBsc.rqCrtNm}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ계약일자</b></td>
									<td>${getSuimSuit12DtlBsc.rqCnrDt}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ계약자_자택전화</b></td>
									<td id="rqCrtHomeTlNo"></td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ계약자_직장전화</b></td>
									<td id="rqCrtWpcTlNo"></td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ계약자_핸드폰</b></td>
									<td id="rqCrtHndphTlNo"></td>	
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ계약사항_건물건수</b></td>
									<td>${getSuimSuit12DtlBsc.rqBldCt}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ계약사항_목적물건수</b></td>
									<td>${getSuimSuit12DtlBsc.rqOjCt}</td>
								</tr>
								
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ보험설계자_핸드폰</b></td>
									<td>${getSuimSuit12DtlBsc.prHndphTlno}</td>
								</tr>								
								
							</table>
						</div>
						
