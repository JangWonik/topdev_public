<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>보고서 상세</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	<%--<script src="./resources/daum/161109.js"></script>--%>
	<script src="./resources/daum/postcode.v2.js"></script>
	<script src='https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js'></script>
	

	<script src="./resources/jquery/jquery.mask.min.js"></script>
    <script src="./resources/cmm/js/common.js?v=201707311012"></script>
    
	
	<script>
	
		$(document).ready(function(){
			// 임시권한 변경
			if('${helpVo.editYN}' > 0 || '${helpVo.clientTmId}' == "${mbrVo_Session.team_id_main}"){
				
			}else{
				alert("열람 권한이 없습니다.");
				window.self.close();
			}
			
			$("#suimTmMbrPopBtn").click(function(){//담당 팀, 담당 직원 바꾸기 팝업
				var cw=screen.availWidth;
				var ch=screen.availHeight;
				var sw=500; //띄울 창의 넓이
				var sh=550;  //띄울 창의 높이
				var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
				var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
				window.open('suimTmMbrPop?gbNo='+$("#gbNoForPop").val()+'&smNo='+$("#smNoForPop").val()+'&tmNo='+$("#tmNoForPop").val(),'SuimTmMbrPop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			});//$("#suimTmMbrPopBtn").click
			
			
	        _initMask();
		});
		
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

	        $('input.money').mask('###,###,###,###,###',options);
	        $('div.money').mask('999,999,999,999,999',{reverse:true});
	        $('span.money').mask('999,999,999,999,999',{reverse:true});
	        
	    }
	    
	    
		function helpDtlEditOk(serialNo){
			
			var doneChk = "";
			if( $("#acceptId").attr("acceptNo").trim() == 0 ){
				alert("미배당 상태입니다.");
				return;
			}else if($("#helpDtlDoneChk").is(':checked') == true ){
				doneChk = 2;
			}else if(($("#helpDtlDoneChk").is(':checked') == false) ){
				doneChk = 1;
			}
			
			$.post("./helpRptUdt",
					{	
						 serialNo 	  	:serialNo  //
						,acceptMbr     	:$("#acceptId").attr("acceptNo").trim()
						,helpMemo    	:$("#helpMemo").val() //
						,helpResult    	:$("#helpResult").val() // 
						,trafficFee    	:$("#helpDtlTraffic").val().num() //
						,chartFee    	:$("#helpDtlChart").val().num() //
						,priceTotal    	:$("#priceTotal").html().num() //
						,helpState    	:doneChk  //
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("저장 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{
								alert("저장 하였습니다."); 
								$.each(data, function(index, entry) {
		                    		
// 									$("#helpAccepMbrtListId").html(entry.acceptMbr);
// 									$("#helpStateListId").html(entry.helpState);
// 									$("#helpTotalPriceListId").html(entry.priceTotal.money());
									location.reload();
									
									if(doneChk == 2){
										$("#helpMemo").prop("readonly", true);
										$("#helpResult").prop("readonly", true);
										$("#helpDtlTraffic").prop("readonly", true);
										$("#helpDtlChart").prop("readonly", true);
										$("#helpDtlDoneChk").prop("disabled", true);
										
									}
								});
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					},"json"
			);//post
			
		}// helpEditOk end
		
		function calcFee(){
			var trafficPrice = parseInt($("#helpDtlTraffic").val().num() );
			var chartPrice = parseInt($("#helpDtlChart").val().num() ) ;
			
			var priceTotal = trafficPrice + chartPrice;
			
			$("#priceTotal").html( String(priceTotal).money() );		
		}
		
		
		
		
		function helpDtlDelOk(serialNo)	{
			if(confirm("삭제하시겠습니까?")){
				$.post("./helpRptDel",
						{	
							 serialNo 	  	:serialNo  //
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("삭제 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									alert("삭제 하였습니다."); 
									$("#"+serialNo, parent.window.opener.document).css("display","none");
									window.close();
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			}
		}
		
		function helpFileDel(serialNo){
			
			if( ('${suimVO.suimRptState}' != 0) || ('${mbrVo.user_no}' != '${suimVO.user_no}') ){
				alert("담당건이거나 상신 전에만 삭제 가능합니다.");
				return;
			}
			
			if(confirm("협조건 첨부를 삭제하시겠습니까?")){
				$.post("./helpFileDel",
						{	
							serialNo 	:	serialNo  //						
						},
						function(data,status){
							if(status == "success"){
								if(data != 0){
									$("#rptHelpFileList_"+serialNo).html("");
									 $("#attchFileRptHelp_"+serialNo).prop("disabled",false);
								}else{
									alert("시스템 오류입니다. 잠시 후 재시도 해주세요.");	
								}
							}else{
								alert("시스템 오류입니다. 잠시 후 재시도 해주세요.");
							}
						}
				);		
			}
		}
		
		function helpDtlReturnConfirm(serialNo){
			if(confirm("완료를 취소 하시겠습니까?")){
				$.post("./helpReturn",
						{	
							serialNo 	:	serialNo  //						
						},
						function(data,status){
							if(status == "success"){
								if(data != 0){
									location.reload();
								}else{
									alert("시스템 오류입니다. 잠시 후 재시도 해주세요.");	
								}
							}else{
								alert("시스템 오류입니다. 잠시 후 재시도 해주세요.");
							}
						}
				);		
			}
		}
		
		
		function helpDtlConfirm(serialNo){
			if(confirm("완료 하시겠습니까?")){
				$.post("./helpConfirm",
						{	
							 serialNo 		:serialNo  //	
							,acceptMbr     	:$("#acceptId").attr("acceptNo").trim()
							,helpMemo    	:$("#helpMemo").val() //
							,helpResult    	:$("#helpResult").val() // 
							,trafficFee    	:$("#helpDtlTraffic").val().num() //
							,chartFee    	:$("#helpDtlChart").val().num() //
							,priceTotal    	:$("#priceTotal").html().num() //
							,helpState    	:2  //
						},
						function(data,status){
							if(status == "success"){
								if(data != 0){
									location.reload();
								}else{
									alert("시스템 오류입니다. 잠시 후 재시도 해주세요.");	
								}
							}else{
								alert("시스템 오류입니다. 잠시 후 재시도 해주세요.");
							}
						}
				);		
			}
		}
		
		function helpDtlCancelOk(serialNo){
			if(confirm("완료 요청을 취소 하시겠습니까?")){
				$.post("./helpCancel",
						{	
							 serialNo 		:serialNo  //	
							,acceptMbr     	:$("#acceptId").attr("acceptNo").trim()
							,helpMemo    	:$("#helpMemo").val() //
							,helpResult    	:$("#helpResult").val() // 
							,trafficFee    	:$("#helpDtlTraffic").val().num() //
							,chartFee    	:$("#helpDtlChart").val().num() //
							,priceTotal    	:$("#priceTotal").html().num() //
							,helpState    	:1  //mybastis에 하드코딩 되어있음;
						},
						function(data,status){
							if(status == "success"){
								if(data != 0){
									location.reload();
								}else{
									alert("시스템 오류입니다. 잠시 후 재시도 해주세요.");	
								}
							}else{
								alert("시스템 오류입니다. 잠시 후 재시도 해주세요.");
							}
						}
				);		
			}
		}
		
		
	</script>
	<style>
		.tdhead{
			text-align:center;
			background-color : #E7ECF1;
		}
	</style>
</head>
<body>
	<div id="headerpop">
		<div class="inner clear_v2">
			<h1>
				<img src="./resources/wm_img/common/logo.gif" height="39" alt="top - TRUST OBLIGATION PASSION" />
			</h1>
			<div style="text-align:center;padding-top:10px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
				<font color="white"><b><span style="font-size:11pt;">협조건 상세 정보</span></b></font>
			</div>
		</div>
	</div>
	<div class="tableStyle4" style="padding:10px 30px 10px 30px; ">
		<input type="hidden" name="gbNoForPop" id="gbNoForPop" value="4" /> <!-- 구분 - 1:수임, 2:농작물, 3:적부, 4:협조건 -->
		<input type="hidden" name="smNoForPop" id="smNoForPop" value="${helpVo.serialNo}" />
		<input type="hidden" name="tmNoForPop" id="tmNoForPop" value="${helpVo.acceptTmId}" />
	
		<!-- 협조건 입력 --> 
		<table align="center" style="margin-top:30px;" >
			<colgroup>
				<col width="25%">
				<col width="25%">
				<col width="25%">
				<col width="25%">
			</colgroup>
			<thead>
				<tr bgcolor="#ECEADB">
					<td colspan="7" align="center" >
						<b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;" /> 보고서 기본정보</b>
					</td>
				</tr>
				<tr id ="helpListedHeadId" bgcolor="yellow" style="border: 1px solid black;">
					<th>의뢰인</th>
					<th>의뢰일자</th>
					<th>보고서 접수번호</th>
					<th>처리 담당자</th>
				</tr>
			</thead>
			<tbody id = "rptHelpList">
				
				<tr align="center" >
					<td>
						${helpVo.clientMbr }
					</td>
					<td>
						${helpVo.regDate }
					</td>
					<td >
						<span id = "acceptNoId">${helpVo.acceptNo}</span>
					</td>
					<td>
						<span id = "rptMbrId">
							<c:choose>
								<c:when test="${helpVo.rptMbr eq null }">
									<font color="red">미배당</font>
								</c:when>
								<c:otherwise>
									${helpVo.rptMbr}
								</c:otherwise>
							</c:choose>
						</span>
					</td>				
				</tr>
				
				<tr>
					<td class= "tdhead">보험사</td>
					<td style="text-align:center;">${helpVo.ptnrName} </td>
					<td class= "tdhead">보험사 당당자</td>
					<td style="text-align:center;">
						${helpVo.ptnrMbrNm}
					</td>
				</tr>
				
				<tr>
					<td class= "tdhead">계약자</td>
					<td style="text-align:center;">${helpVo.policyholderNm} </td>
					<td class= "tdhead">연락처</td>
					<td style="text-align:center;">
						${helpVo.policyholderTel}
					</td>
				</tr>
				
				<tr>
					<td class= "tdhead">피보험자</td>
					<td style="text-align:center;">${helpVo.beneficiaryNm} </td>
					<td class= "tdhead">연락처</td>
					<td style="text-align:center;">
						${helpVo.beneficiaryTel}
					</td>
				</tr>
				
				<tr>
					<td class= "tdhead">피해자/물</td>
					<td style="text-align:center;">${helpVo.damagedNm} </td>
					<td class= "tdhead">연락처</td>
					<td style="text-align:center;">
						${helpVo.damagedTel}
					</td>
				</tr>
				
				<tr bgcolor="#ECEADB">
					<td colspan="7" align="center" >
						<b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;" /> 협조건 정보</b>
					</td>
				</tr>
			
				<tr>
					<td class= "tdhead">의뢰팀</td>
					<td colspan="3" style="text-align:center;">${helpVo.clientTm} (의뢰인 연락처 : ${clientPhone}) </td>
					
				</tr>
				<tr>
					<td class= "tdhead">수임팀</td>
					<td style="text-align:center;">${helpVo.acceptTm} </td>
					<td class= "tdhead">수임인</td>
					<td style="text-align:center;">
					<c:choose>
						<c:when test="${helpVo.helpState eq '대기' }">
							<img src="./resources/ls_img/report/icon_change.gif" id="suimTmMbrPopBtn" style="cursor:pointer;" border="0" width="14" height="14">
							<span id="acceptId" acceptNo="${helpVo.acceptMbrId}">${helpVo.acceptMbr}</span>
						</c:when>
						
						<c:when test="${helpVo.helpState eq '진행' }">
							<img src="./resources/ls_img/report/icon_change.gif" id="suimTmMbrPopBtn" style="cursor:pointer;" border="0" width="14" height="14">
							<span id="acceptId" acceptNo="${helpVo.acceptMbrId}">${helpVo.acceptMbr}</span>
						</c:when>
						
						<c:otherwise>
							<span id="acceptId" acceptNo="${helpVo.acceptMbrId}">${helpVo.acceptMbr}</span>
						</c:otherwise>
					</c:choose>
					
					<c:if test="${helpVo.acceptMbrId ne 0}">
						<br />(연락처 : ${helpVo.rptUserPhone})
					</c:if>
					</td>
				</tr>
				<tr>
					<td class= "tdhead">의뢰 내용</td>
					<td colspan="3">
					<c:choose>
						<c:when test="${endModFlag == 1}">
							<textarea cols="70" rows="3" id = "helpMemo">${helpVo.helpMemo} </textarea>	
						</c:when>
						<c:otherwise>
							<textarea cols="70" rows="3" id = "helpMemo" readonly="readonly">${helpVo.helpMemo} </textarea>
						</c:otherwise>
					</c:choose>
					</td>
				</tr>
				<tr>
					<td class= "tdhead">처리 결과</td>
					<td colspan="3">
					<c:choose>
						<c:when test="${helpVo.helpState eq '대기' or helpVo.helpState eq '진행'}">
							<textarea cols="70" rows="3" id = "helpResult" >${helpVo.helpResult} </textarea>
						</c:when>
						<c:otherwise>
							<textarea cols="70" rows="3" id = "helpResult" readonly="readonly">${helpVo.helpResult} </textarea>
						</c:otherwise>
					</c:choose>
					</td>
				</tr>
				<tr>
					<td rowspan="2" class= "tdhead">첨부 파일</td>
					<td colspan="3">
						<%@include file="../include/uploadform_rptHelpFile.jsp"%>
					</td>
				</tr>
				
				<tr>
					<td colspan="3"  id = "rptHelpFileList_${helpVo.serialNo}">
						<c:choose>
							<c:when test="${helpVo.helpFile ne ''}">
								<a href="fileDownload?key=${helpVo.serialNo}&type=rptHelpFile&suimRptNo=${helpVo.suimRptNo}">
		        				   <font color="blue"> ${helpVo.helpFile} </font>
		  					    </a>
	  					    	<img src='./resources/ls_img/btn_del_s.gif' onclick="helpFileDel('${helpVo.serialNo}');" style='cursor:pointer; margin-left:5px;'/>
							</c:when>
							<c:otherwise>
								※ 첨부파일 없음
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<td class= "tdhead">교통비</td>
					<td  >
						<c:choose>
							<c:when test="${helpVo.helpState eq '대기' }">
								<input type="text" class="money" style="text-align:right;" value="${helpVo.trafficFee}" id ="helpDtlTraffic" onkeyup="calcFee('${helpVo.serialNo}');" />원
							</c:when>
							<c:when test="${helpVo.helpState eq '진행' }">
								<input type="text" class="money" style="text-align:right;" value="${helpVo.trafficFee}" id ="helpDtlTraffic" onkeyup="calcFee('${helpVo.serialNo}');" />원
							</c:when>
							<c:otherwise>
								<input type="text" class="money" style="text-align:right;" value="${helpVo.trafficFee}" id ="helpDtlTraffic" onkeyup="calcFee('${helpVo.serialNo}');" readonly="readonly"/>원
							</c:otherwise>
						</c:choose>
						
					</td>
					<td class= "tdhead">챠트비</td>
					<td  >
						<c:choose>
							<c:when test="${helpVo.helpState eq '대기' }">
								<input type="text" class="money" style="text-align:right;" value="${helpVo.chartFee}" id ="helpDtlChart" onkeyup="calcFee('${helpVo.serialNo}');" />원
							</c:when>
							<c:when test="${helpVo.helpState eq '진행' }">
								<input type="text" class="money" style="text-align:right;" value="${helpVo.chartFee}" id ="helpDtlChart" onkeyup="calcFee('${helpVo.serialNo}');" />원
							</c:when>
							<c:otherwise>
								<input type="text" class="money" style="text-align:right;" value="${helpVo.chartFee}" id ="helpDtlChart" onkeyup="calcFee('${helpVo.serialNo}');" readonly="readonly"/>원
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<td class= "tdhead">합    계</td>
					<td colspan="3" style="text-align:center;">
						<span class="money" id="priceTotal">${helpVo.priceTotal}</span>원
					</td>
				</tr>
				<tr>
					<td class= "tdhead">처리 완료 요청</td>
					<td colspan="3" >
						<c:choose>
							<c:when test="${helpVo.helpState eq '대기' }">	
								<input type="checkbox" id = "helpDtlDoneChk" />
								<font color="red">←체크를 하셔야 의뢰인에게 협조완료 요청을 합니다.</font>
							</c:when>
							<c:when test="${helpVo.helpState eq '진행' }">
								<input type="checkbox" id = "helpDtlDoneChk" />
								<font color="red">←체크를 하셔야 의뢰인에게 협조완료 요청을 합니다.</font>
							</c:when>
							<c:otherwise>
								<input type="checkbox" id = "helpDtlDoneChk" disabled="disabled"/>
								<font color="red">←체크를 하셔야 의뢰인에게 협조완료 요청을 합니다.</font>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			
				<!-- 수정을 위해 대기상태로 돌림 -->
				<c:if test="${helpVo.helpState eq '완료' and endModFlag == 1}">
					<tr>
						<td colspan="7" style="text-align:center;">
							<img src="./resources/ls_img/ls_report/btn_h_end_x.gif" alt="협조건 완료 취소" style="cursor:pointer;" onclick="helpDtlReturnConfirm('${helpVo.serialNo}');"/>
						</td>		
					</tr>
				</c:if>
					
				<tr>
					<td colspan="7" style="text-align:center;">
						<c:choose>
							<c:when test="${helpVo.helpState eq '완료' }">
								<font color="blue">※ ${helpVo.endDate}일 완료 상태입니다.</font>
							</c:when>
							<c:when test="${helpVo.helpState eq '완료요청' }">
								<font color="blue">※ 완료 요청 상태입니다.</font>
								<img src="./resources/ls_img/btn_cancel.gif" alt="완료요청 취소" style="cursor:pointer;" onclick="helpDtlCancelOk('${helpVo.serialNo}');"/>
								
							</c:when>
							<c:otherwise> 
								<!-- 완료상태 -> 대기 -> 다시 완료로 돌리기 위함 -->
								<c:choose>
									<c:when test="${helpVo.endDate != '1970-01-01'}">
										<img src="./resources/ls_img/ls_report/btn_h_end_ok.gif" alt="협조건 완료" style="cursor:pointer;" onclick="helpDtlConfirm('${helpVo.serialNo}');"/>
									</c:when>
									<c:otherwise>
										<img src="./resources/ls_img/btn_edite.gif" alt="협조건 수정" style="cursor:pointer;" onclick="helpDtlEditOk('${helpVo.serialNo}');"/>
										<img src="./resources/ls_img/btn_del.gif" alt="협조건 삭제" style="cursor:pointer;" onclick="helpDtlDelOk('${helpVo.serialNo}');"/>
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</body>