<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<script type="text/javascript" src="./resources/jquery/jquery.cookie.min.js"></script>
<script>

	$(document).ready(function(){
		
		/* 협조건 1행 추가 시작 */
		$("#helpRptInsBtn").click(function(){
			
			if($("#acceptTm").val() == 0){
				alert("협조팀을 지정하세요.");
				return;
			}
			
			if($("#helpContents").val() == ''){
				alert("의뢰 내용을 입력하세요.");
				return;
			}
			
			$.post("./helpRptIns",
					{	
						 suimRptNo   	:$("#suimRptNo").val()  //
						,regDate       	:$("#helpRegDate").val()  //
						,helpMemo      	:$("#helpContents").val() // 
						,clientTm		:"${mbrVo_Session.team_id_main}"//
						,acceptTm		:$("#acceptTm").val() //
						,clientMbr		:"${user_no_Session}" //
						
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("저장 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{
								
								x=document.body.scrollLeft; 
								y=document.body.scrollTop; 

								location.href = "suimRptBscDtl?suim_rpt_no="+$("#suimRptNo").val()+"&x="+x+"&y="+y; 
								
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					},"json"
			);//post
		});
		/* 협조건 1행 추가 끝 */
		
	});
	
	function getToday(){
	    var date = new Date();
	    var year = date.getFullYear();
	    var month = ("0" + (1 + date.getMonth())).slice(-2);
	    var day = ("0" + date.getDate()).slice(-2);

	    return year + "-" + month + "-" + day;
	}
	
	function showHelpAddArea(){
		
		$(".rptHelpList").hide();
		$("#helpListedHeadId").hide();
		
		$(".hideHelpDtlBtnClass").hide();
		$(".helpDtl").hide();
		
		$("#helpAddAreaId").show();
		$(".showHelpDtlBtnClass").show();
		
		$("#showHelpAddAreaBtn").hide();
		$("#hideHelpAddAreaBtn").show();
		
		
		$(".rptHelpList").css("background-color","white");
		
		/* 일자에 오늘 날짜 자동 입력 */
		var today = getToday();

		$("#helpRegDate").val(today);
				
		$('#helpRegDate').datepicker({ 
		 	   showOn: 'button',
		 	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		 	   buttonImageOnly: true,
		 	   buttonText: "달력", 
		 	   changeMonth: true,
		 	   changeYear: true,
		 	   showButtonPanel: false
		 	});
		
		$("#helpContents").focus();
	}
	
	function hideHelpAddArea(){
		
		$("#helpListedHeadId").show();
		$(".rptHelpList").show(); 
		
		
		$("#showHelpAddAreaBtn").show();
		$("#hideHelpAddAreaBtn").hide();
		
		$("#helpAddAreaId").hide();
		
	}
	
	function showHelpDtl(obj,acceptTm){
		
		$("#helpDtl_"+obj).show();
		$("#helpDtlShowBtn_"+obj).hide();
		$("#helpDtlHideBtn_"+obj).show();
		$("#help_"+obj).css("background-color","yellow");
		
		$.post("rptHelpGetTopMbrList",
				{	
					acceptTm : acceptTm,
					serialNo : obj
				},
				function(data,status){
					
					var accpetId = "";
					
					if(status == "success"){
						
						if(data.length == 0){
							$("#helpAcceptMbrSelect_"+obj).html("");
							$("#helpAcceptMbrSelect_"+obj).append(
								"<option value='0'>"
									+"직원 없음"
								+"</option>"
							);
						}else{
							$("#helpAcceptMbrSelect_"+obj).html("");
							$("#helpAcceptMbrSelect_"+obj).append(
                				
                    			"<option value = '0'>미배당</option>"
   							);
							
		                    $.each(data, function(index, entry) {
		                    		
		                    		accpetId = entry.accpetId;
		                    		
		                    		$("#helpAcceptMbrSelect_"+obj).append(
		                    				"<option value = '"+entry.user_no+"'>"
											+entry.user_name
	                                		+ "</option>"
		   							);
							});
		                    
			                $("#helpAcceptMbrSelect_"+obj).val(accpetId);
			                
						}
					}else{
						alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
					}
				},"json"
		);
		
	}
	
	function hideHelpDtl(obj){
		
		$("#helpDtl_"+obj).hide();
		$("#helpDtlShowBtn_"+obj).show();
		$("#helpDtlHideBtn_"+obj).hide();
		$("#help_"+obj).css("background-color","white");
		
	}
	
	function helpDtlEditOk(serialNo){
		
		var doneChk = "";
		
		if( $("#helpAcceptMbrSelect_"+serialNo+" option:selected").val() == 0 ){
			alert("미배당 상태입니다.");
			return;
		}else if($("#helpDtlDoneChk_"+serialNo).is(':checked') == true ){
			doneChk = 2;
		}else if(($("#helpDtlDoneChk_"+serialNo).is(':checked') == false) ){
			doneChk = 1;
		}
		
		$.post("./helpRptUdt",
				{	
					 serialNo 	  	:serialNo  //
					,acceptMbr     	:$("#helpAcceptMbrSelect_"+serialNo+" option:selected").val()  
					,helpMemo    	:$("#helpMemo_"+serialNo).val() //
					,helpResult    	:$("#helpResult_"+serialNo).val() // 
					,trafficFee    	:$("#helpDtlTraffic_"+serialNo).val().num() //
					,chartFee    	:$("#helpDtlChart_"+serialNo).val().num() //
					,priceTotal    	:$("#priceTotal_"+serialNo).html().num() //
					,helpState    	:doneChk  //
				},
				function(data,status){
					if(status == "success"){
						if(data == 0){
							alert("저장 실패하였습니다. 관리자에게 문의해 주세요.");
						}else{
							alert("저장 하였습니다."); 
							$.each(data, function(index, entry) {
	                    		
								$("#helpAccepMbrtListId_"+entry.serialNo).html(entry.acceptMbr);
								$("#helpStateListId_"+entry.serialNo).html(entry.helpState);
								$("#helpTotalPriceListId_"+entry.serialNo).html(entry.priceTotal.money() );
								
								if(doneChk == 2){

									$("#helpAcceptMbrSelect_"+entry.serialNo).prop("disabled", true);
									$("#helpMemo_"+entry.serialNo).prop("readonly", true);
									$("#helpResult_"+entry.serialNo).prop("readonly", true);
									$("#helpDtlTraffic_"+entry.serialNo).prop("readonly", true);
									$("#helpDtlChart_"+entry.serialNo).prop("readonly", true);
									$("#helpDtlDoneChk_"+entry.serialNo).prop("disabled", true);
									
								}
							});
						}
					}else{
						alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
					}
				},"json"
		);//post
		
	}// helpEditOk end
	
	function calcFee(obj){
		var trafficPrice = parseInt($("#helpDtlTraffic_"+obj).val().num() );
		var chartPrice = parseInt($("#helpDtlChart_"+obj).val().num() ) ;
		
		var priceTotal = trafficPrice + chartPrice;
		
		$("#priceTotal_"+obj).html( String(priceTotal).money() );		
		
	}
	
	function helpDone(serialNo){
		
		if(confirm("협조건을 완료하시겠습니까?")){
			$.post("./helpDone",
					{	
						serialNo   	:serialNo  //
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("완료 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{
								$("helpDone_"+serialNo).html("");
								$("helpDone_"+serialNo).append(
									"<font color='blue'>※ 완료 상태입니다.</font>"
								);
								
								/* 오늘 일자 */
								var currentDate = new Date();
								var month = currentDate.getMonth() + 1+"";
								
								if(month.length ==1){
									month = "0"+month;
								}
								
								var day = currentDate.getDate();
								var year = currentDate.getFullYear();
								
								var today = year+"-"+month+"-"+day;
								
								$("#helpStateListId_"+serialNo).html("완료");	
								$("#helpEndDate_"+serialNo).html(today); 
								$("#helpDone_"+serialNo).html("");
								$("#helpDone_"+serialNo).append(
									"<font color='blue'>※ 완료 상태입니다.</font>"	
								);
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}
			);//post
		}else{
			return;
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
	<!-- 협조건 입력 --> 
	<table align="center" style="margin-top:10px;" >
		<colgroup>
			<col width="15%">
			<col width="15%">
			<col width="15%">
			<col width="15%">
			<col width="15%">
			<col width="15%">
			<col width="10%">
		</colgroup>
		<thead>
			<tr>
				<td colspan="7">
					<b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;" /> 보고서 협조</b>
					<c:if test="${suimVO.suimRptState eq '0' and suimVO.editYN > 0}">
						<img src="./resources/ls_img/btn_h_add.gif" id = "showHelpAddAreaBtn" title="추가" style="float:right; cursor:pointer; margin-right:10px;" onclick="showHelpAddArea();"/>
						<img src="./resources/ls_img/btn_write_cancel.gif" id = "hideHelpAddAreaBtn" title="협조건 작성 취소" style="float:right; display:none; cursor:pointer; margin-right:10px;" onclick="hideHelpAddArea();"/>
					</c:if>
				</td>
			</tr>
			<tr id ="helpListedHeadId">
				<th>의뢰인</th>
				<th>의뢰일자</th>
				<th>협조인</th>
				<th>완료일자</th>
				<th>상태</th>
				<th>금액</th>
				<th>상세보기</th>
			</tr>
		</thead>
		<tbody id = "rptHelpList">

				<c:forEach items="${helpList}" var="helpVo">
				
					<tr  id = "help_${helpVo.serialNo}" class = "rptHelpList" align="center">
						<td>
							${helpVo.clientMbr }
						</td>
						<td>
							${helpVo.regDate }
						</td>
						<c:choose>
							<c:when test="${helpVo.acceptMbr == '0' }">
								<td >
									<span id = "helpAccepMbrtListId_${helpVo.serialNo}"><font color="red"><b>미배당</b></font></span>
								</td>
							</c:when>
							<c:otherwise>
								<td >
									<span id = "helpAccepMbrtListId_${helpVo.serialNo}">${helpVo.acceptMbr}</span>
								</td>
							</c:otherwise>
						</c:choose>
						
						<c:choose>
							<c:when test="${helpVo.endDate == '1970-01-01' }">
								<td id ="helpEndDate_${helpVo.serialNo}">
									<font color="red"><b>미결</b></font>
								</td>
							</c:when>
							<c:otherwise>
								<td id ="helpEndDate_${helpVo.serialNo}">
									${helpVo.endDate }
								</td>
							</c:otherwise>
						</c:choose>
						<td >
							<span id = "helpStateListId_${helpVo.serialNo}">${helpVo.helpState }</span>
						</td>
						<td >
							<span class="money" id = "helpTotalPriceListId_${helpVo.serialNo}">${helpVo.priceTotal }</span>원
						</td>					
						<td>
							<img src="./resources/ls_img/btns_view.gif" class="showHelpDtlBtnClass" alt="펼치기" id = "helpDtlShowBtn_${helpVo.serialNo}" style="cursor:pointer;" onclick="showHelpDtl('${helpVo.serialNo}','${helpVo.acceptTmId}');"/>
							<img src="./resources/ls_img/btn_close.gif" class="hideHelpDtlBtnClass" alt="닫기" id = "helpDtlHideBtn_${helpVo.serialNo}" style="cursor:pointer; display:none;" onclick="hideHelpDtl('${helpVo.serialNo}');"/>
						</td>
					</tr>
					
					<tbody id = "helpDtl_${helpVo.serialNo}" class="helpDtl" style="display:none;">
						<tr>
							<td class= "tdhead">의뢰팀</td>
							<td colspan="6" style="text-align:center;">${helpVo.clientTm} </td>
							
						</tr>
						<tr>
							<td class= "tdhead">수임팀</td>
							<td colspan="3" style="text-align:center;">${helpVo.acceptTm} </td>
							<td class= "tdhead">수임인</td>
							<td colspan="2" style="text-align:center;">
							<c:choose>
								<c:when test="${suimVO.suimRptState eq '0' and suimVO.editYN > 0}">
									<c:choose>
										<c:when test="${helpVo.helpState eq '대기' or helpVo.helpState eq '진행' }">
											<select id="helpAcceptMbrSelect_${helpVo.serialNo}" >
												
											</select>
										</c:when>
										<c:otherwise>
											<select id="helpAcceptMbrSelect_${helpVo.serialNo}" disabled="disabled">
												
											</select>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<select id="helpAcceptMbrSelect_${helpVo.serialNo}" disabled="disabled">
												
									</select>
								</c:otherwise>
							</c:choose>
							</td>
						</tr>
						<tr>
							<td class= "tdhead">의뢰 내용</td>
							<td colspan="6">
							<c:if test="${suimVO.suimRptState eq '0' and suimVO.editYN > 0}">
								<c:choose>
									<c:when test="${helpVo.helpState eq '대기' or helpVo.helpState eq '진행'}">
										<textarea cols="87" rows="3" id = "helpMemo_${helpVo.serialNo}" >${helpVo.helpMemo} </textarea>
									</c:when>
									<c:otherwise>
										<textarea cols="87" rows="3" id = "helpMemo_${helpVo.serialNo}" readonly="readonly">${helpVo.helpMemo} </textarea>
									</c:otherwise>
								</c:choose>							
							</c:if>
							</td>
						</tr>
						<tr>
							<td class= "tdhead">처리 결과</td>
							<td colspan="6">
								<textarea cols="87" rows="3" id = "helpResult_${helpVo.serialNo}" readonly="readonly">${helpVo.helpResult} </textarea>
							</td>
						</tr>
						<tr>
							<td class= "tdhead">첨부 파일</td>
							<td colspan="3" >
								<%@include file="../include/uploadform_rptHelpFile.jsp"%>
							</td>
							<td colspan="3" id = "rptHelpFileList_${helpVo.serialNo}">
								<c:choose>
									<c:when test="${suimVO.editYN > 0 and helpVo.helpFile ne ''}">
										<a href="fileDownload?key=${helpVo.serialNo}&type=rptHelpFile&suimRptNo=${suimVO.suim_rpt_no}">
				        				   <font color="blue"> ${helpVo.helpFile} </font>
				  					    </a>
			  					    	<img src='./resources/ls_img/btn_del_s.gif' onclick="helpFileDel('${helpVo.serialNo}');" style='cursor:pointer; margin-left:5px;'/>
									</c:when>
									<c:otherwise>
										${helpVo.helpFile}
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<td class= "tdhead">교통비</td>
							<td colspan="3" >
								<c:choose>
									<c:when test="${suimVO.suimRptState eq '0' and suimVO.editYN > 0}">
										<c:choose>
											<c:when test="${helpVo.helpState eq '대기' }">
												<input type="text" class="money" style="text-align:right;" value="${helpVo.trafficFee}" id ="helpDtlTraffic_${helpVo.serialNo}" onkeyup="calcFee('${helpVo.serialNo}');" />원
											</c:when>
											<c:when test="${helpVo.helpState eq '진행' }">
												<input type="text" class="money" style="text-align:right;" value="${helpVo.trafficFee}" id ="helpDtlTraffic_${helpVo.serialNo}" onkeyup="calcFee('${helpVo.serialNo}');" />원
											</c:when>
											<c:otherwise>
												<span class="money">${helpVo.trafficFee}</span> 원
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<span class="money">${helpVo.trafficFee}</span> 원
									</c:otherwise>
								</c:choose>
							</td>
							<td class= "tdhead">챠트비</td>
							<td colspan="2" >
								<c:choose>
									<c:when test="${suimVO.suimRptState eq '0' and suimVO.editYN > 0}">
										<c:choose>
											<c:when test="${helpVo.helpState eq '대기' }">
												<input type="text" class="money" style="text-align:right;width:120px;" value="${helpVo.chartFee}" id ="helpDtlChart_${helpVo.serialNo}" onkeyup="calcFee('${helpVo.serialNo}');" />원
											</c:when>
											<c:when test="${helpVo.helpState eq '진행' }">
												<input type="text" class="money" style="text-align:right;width:120px;" value="${helpVo.chartFee}" id ="helpDtlChart_${helpVo.serialNo}" onkeyup="calcFee('${helpVo.serialNo}');" />원
											</c:when>
											<c:otherwise>
												<span class="money">${helpVo.chartFee}</span> 원
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<span class="money">${helpVo.chartFee}</span> 원
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<td class= "tdhead">합    계</td>
							<td colspan="6" style="text-align:center;">
								<span class="money" id="priceTotal_${helpVo.serialNo}">${helpVo.priceTotal}</span>원
							</td>
						</tr>
						<%-- <tr>
							<td class= "tdhead">처리 완료 요청</td>
							<td colspan="6" >
								<c:choose>
									<c:when test="${helpVo.helpState eq '대기' }">
										<input type="checkbox" id = "helpDtlDoneChk_${helpVo.serialNo}" />
										<font color="red">←체크를 하셔야 의뢰인에게 협조완료 요청을 합니다.</font>
									</c:when>
									<c:when test="${helpVo.helpState eq '진행' }">
										<input type="checkbox" id = "helpDtlDoneChk_${helpVo.serialNo}" />
										<font color="red">←체크를 하셔야 의뢰인에게 협조완료 요청을 합니다.</font>
									</c:when>
									<c:otherwise>
										<input type="checkbox" id = "helpDtlDoneChk_${helpVo.serialNo}" disabled="disabled"/>
										<font color="red">←체크를 하셔야 의뢰인에게 협조완료 요청을 합니다.</font>
									</c:otherwise>
								</c:choose>
							</td>
						</tr> --%>
						<tr>
							<td colspan="7" style="text-align:center;" id = "helpDone_${helpVo.serialNo}">
								<c:choose>
									<c:when test="${helpVo.helpState eq '완료' }">
										<font color="blue">※ 완료 상태입니다.</font>
									</c:when>
									<c:when test="${helpVo.helpState eq '완료요청' }">
										<img src="./resources/ls_img/report/btn_h_end_ok.gif" title="협조건 완료 하기" style="cursor:pointer;" onclick="helpDone('${helpVo.serialNo}');"/>
									</c:when>
									<c:otherwise>
										<c:if test="${suimVO.suimRptState eq '0' and suimVO.editYN > 0}">
											<img src="./resources/ls_img/btn_edite.gif" alt="협조건 수정" style="cursor:pointer;" onclick="helpDtlEditOk('${helpVo.serialNo}');"/>
										</c:if>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						
					</tbody>
				
				</c:forEach>
		</tbody>
	</table>
	
	<table align="center" style="display:none; " id = "helpAddAreaId">
		<colgroup>
			<col width="20%">
			<col width="30%">
			<col width="40%">
			<col width="10%">
		</colgroup>
		<tr>
			<th>의뢰일자</th>
			<th>협조 수임팀 선택</th>
			<th>의뢰 내용</th>
			<th>비고</th>
		</tr>
		<tr align="center" >
			<td>
				<input type="text" size="13" id="helpRegDate"/>
			</td>
			<td>
				<select id="acceptTm" >
					<option value="0" selected>---- 협조 수임팀 지정 ----</option>
					<c:forEach items="${topTeamList}" var = "topTeamVo">
						<c:if test="${topTeamVo.team_level ne 0}">
							<option value="${topTeamVo.team_id}">
							<c:if test="${topTeamVo.team_level eq 2}">&nbsp;&nbsp;└</c:if>
							${topTeamVo.team_name}
							</option>
						
						</c:if>
					</c:forEach>
				</select>
			</td>
			<td>
				<textarea id="helpContents" cols="30" rows="7"></textarea>
			</td>
			<td>
				<img src="./resources/ls_img/btn_add.gif" id="helpRptInsBtn" style="cursor:pointer;"/>
			</td>
		</tr>	
	</table>
</body>