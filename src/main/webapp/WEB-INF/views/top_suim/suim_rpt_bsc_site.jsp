<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("#addSiteRptBtn").click(function(){
			
			if($("#rptUserNameHidden").val() != 0){
				var cw=screen.availWidth;
				var ch=screen.availHeight;
				
				var sw=880; //띄울 창의 넓이
				//var sh=screen.availHeight;  //띄울 창의 높이
				var sh=860;  //띄울 창의 높이				
		
				var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
				var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
				
				window.open('siteRptAdd?suimRptNo='+$("#suimRptNo").val()+'&interimFlag=site','_blank','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=yes,scrollbars=yes');
			}else{
				alert("처리 담당자 미배당 상태입니다.");
			}
			
		});
		
	});
	
	function siteRptEdite(rptSiteNo){
		
		var cw=screen.availWidth;
		var ch=screen.availHeight;
		
		var sw=880; //띄울 창의 넓이
		var sh=screen.availHeight;  //띄울 창의 높이

		var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
		var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
		
		window.open('siteRptEdite?suimRptNo='+$("#suimRptNo").val()+'&rptSiteNo='+rptSiteNo+'&interimFlag=site','_blank','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=yes,scrollbars=yes');
	}
	
	function siteRptDel(rptSiteNo){
		if(confirm("삭제하시겠습니까?")){
			
			$.post("./siteRptDel",
					{	
						rptSiteNo 	  	:rptSiteNo  //
						
					},
					function(data,status){
						if(status == "success"){
							if(data != 0){
								$("#site_"+rptSiteNo).html("");
								$("#siteFileUploadArea_"+rptSiteNo).html("");
								$("#siteFileDownArea_"+rptSiteNo).html("");
								
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
	
	function printSiteWordBtn(rptSiteNo){
		
		var cw=screen.availWidth;
		var ch=screen.availHeight;
		
		var sw=1010; //띄울 창의 넓이
		var sh=740;  //띄울 창의 높이
	
		var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
		var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
		
		window.open('interimPrintPage?suimRptNo='+$("#suimRptNo").val()+'&rptSiteNo='+rptSiteNo+'&interimFlag=site&type=word','_blank','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
	}
	
	function printSiteBtn(rptSiteNo){
		
		var cw=screen.availWidth;
		var ch=screen.availHeight;
		
		var sw=1010; //띄울 창의 넓이
		var sh=740;  //띄울 창의 높이
	
		var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
		var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
		
		window.open('interimPrintPage?suimRptNo='+$("#suimRptNo").val()+'&rptSiteNo='+rptSiteNo+'&interimFlag=site&type=print','_blank','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
	}
	
	/* 현장보고서 파일 업로드 */
	function siteRptFileUp(rptSiteNo){
		
		$("#siteFileUploadTd_"+rptSiteNo).css("display","block");
		
	}
	
</script>
		<!-- 첨부파일이 있는 현장보고서 갯수 -->		
		<input type="hidden" id="siteCnt" name="siteCnt" value="${siteCnt}"/>
		<table align="center" style="margin-top:10px;">
		<colgroup>
			<col width="15%">
			<col width="15%">
			<col width="10%">
			<col width="45%">
			<col width="15%">
		</colgroup>
		<thead>
			<tr>
				<td colspan="5" height="30" style="background-color: #e7f5ff"><span style="font-size: 20px;"><b>3. 보고서제출</b></span></td>
			</tr>
			<tr>
				<td colspan="3">
					<b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;" /> 3-1. 현장조사보고서</b>
				</td>
				<td colspan="2" style="text-align:right;padding-right:10px;">					
					<%-- 현장보고서 결재 시작 --%>					
					<%-- 현장보고서 결재권한 : ${approvalSiteAuth} / ${suimVO.site_rpt_state} / ${suimVO.suimRptType1} / ${suimVO.editYN} / ${suimVO.pendncyTrgetAt} --%>
					<c:if test="${suimVO.editYN > 0}">
						<c:if test="${suimVO.pendncyTrgetAt eq '1' or suimVO.pendncyTrgetAt eq '4'}">
							<c:if test="${suimVO.suimRptType1 eq '1' or suimVO.suimRptType1 eq '2' or suimVO.suimRptType1 eq '11' or suimVO.suimRptType1 eq '12' or suimVO.suimRptType1 eq '13' }">
								<c:choose>
									<c:when test="${suimVO.site_rpt_state eq '0'}">
										<img src="./resources/ls_img/report/btn_rch_1.gif" onclick="action_report('site_submit');" style="cursor:pointer;"/>
									</c:when>
									<c:when test="${suimVO.site_rpt_state eq '1'}">
										<img src="./resources/ls_img/report/btn_rch_1x.gif" onclick="action_report('site_submit_x');" style="cursor:pointer;"/>
										<c:if test="${suimVO.closeAuthYN eq '1' or approvalSiteAuth}">
											<img src="./resources/ls_img/report/btn_rch_2.gif" border=0 onclick="action_report('site_end');" style="cursor:pointer;"/>
										</c:if>
									</c:when>
									<c:when test="${ endModFlag > 0 && suimVO.suimRptState eq '2'}">
										-
									</c:when>
									<c:when test="${suimVO.site_rpt_state eq '2'}">
										<c:if test="${suimVO.closeAuthYN eq '1'}">											
											<img src="./resources/ls_img/report/btn_rch_2x.gif" border=0 onclick="action_report('site_e_x');" style="cursor:pointer;"/>
										</c:if>
									</c:when>									
								</c:choose>
							</c:if>
						</c:if>
					</c:if>
					
					<%-- 현장보고서 결재 완료 --%>
					<c:if test="${suimVO.site_rpt_state eq '0' and suimVO.editYN > 0 or suimVO.site_result_flag eq '1'}">																	
						&nbsp;<img src="./resources/ls_img/btn_add_s.gif" title="현장 보고 추가" id = "addSiteRptBtn" style="cursor:pointer;"/>
					</c:if>
				</td>
			</tr>
			<tr>
				<th>작성일</th>
				<th>제출일</th>
				<th>종류</th>
				<th>파일명</th>
				<th>비고</th>
			</tr>
		</thead>		
		<tbody align="center" id = "siteRptMainBody" >			
			<c:forEach items="${siteList}" var="siteVo" varStatus="status">
				<tr id = "site_${siteVo.rptSiteNo }">
					<td>${siteVo.siteDate}</td>					
					<td id="siteSubDate_${siteVo.rptSiteNo }">
					<c:choose>
						<%-- 처음등록된 현장보고서만 결재일로 표시할지 체크 --%>
						<c:when test="${status.index eq 0}">
							<c:choose>
								<c:when test="${ (suimVO.suimRptType1 eq '1' or suimVO.suimRptType1 eq '2' or suimVO.suimRptType1 eq '11' or suimVO.suimRptType1 eq '12' or suimVO.suimRptType1 eq '13'  ) and (suimVO.pendncyTrgetAt eq '1' or suimVO.pendncyTrgetAt eq '4')}">								
									<c:choose>
										<c:when test="${suimVO.site_rpt_aprv_date eq 0}"> - </c:when>
										<c:otherwise>${suimVO.site_rpt_aprv_date_fmt}</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>${siteVo.siteDate}</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							${siteVo.subDate}
						</c:otherwise>
					</c:choose>							
					</td>
					<td>
						<c:choose>
							<c:when test="${siteVo.siteFlag eq 0}">정식</c:when>
							<c:when test="${siteVo.siteFlag eq 1}">일정</c:when>
							<c:otherwise>-</c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${empty siteVo.fileName}">파일없음</c:when>
							<c:otherwise>
								<a href='fileDownload?key=${siteVo.rptSiteNo}&type=siteInterim'>
									${siteVo.fileName}
		    					</a>
							</c:otherwise>
						</c:choose>						
					</td>
					<td>
						<c:choose>
							<c:when test="${suimVO.editYN > 0 or endModFlag > 0}">
								<img src="./resources/ls_img/btn_word_s.gif" title="MS Word 인쇄" style="cursor:pointer;" onclick="printSiteWordBtn('${siteVo.rptSiteNo}');"/>
								<img src="./resources/ls_img/btn_print_s.gif" title="인쇄" style="cursor:pointer;" onclick="printSiteBtn('${siteVo.rptSiteNo}');"/>
							</c:when>
							<c:otherwise>
								-
							</c:otherwise>
						</c:choose>						
						<c:choose>
							<c:when test="${suimVO.site_rpt_state eq '0' and suimVO.editYN > 0}">
								<img src="./resources/ls_img/btn_edit_s.gif" title="현장보고서 수정" style= "cursor:pointer;" id = "siteRptEditeBtn_${siteVo.rptSiteNo}" onclick="siteRptEdite('${siteVo.rptSiteNo}');" />
								<img src='./resources/ls_img/btn_del_s.gif' title="현장보고서 삭제" style="cursor:pointer;" id = "siteRptDelBtn_${siteVo.rptSiteNo}" onclick="siteRptDel('${siteVo.rptSiteNo}');" />
								<%-- <c:if test="${siteVo.fileName eq ''}">
									<img src='./resources/ls_img/icon_disket.gif' title="현장보고서 제출" style="cursor:pointer;" id = "siteRptFileUpBtnID_${siteVo.rptSiteNo}" onclick="siteRptFileUp('${siteVo.rptSiteNo}');" />
								</c:if>
								<c:if test="${siteVo.fileName ne ''}">
									<img src='./resources/ls_img/icon_disket.gif' title="현장보고서 제출" style="cursor:pointer; display:none;" id = "siteRptFileUpBtnID_${siteVo.rptSiteNo}" onclick="siteRptFileUp('${siteVo.rptSiteNo}');" />
								</c:if> --%>
							</c:when>
							<c:otherwise>
								-
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				
				<%-- <tr id ="siteFileUploadArea_${siteVo.rptSiteNo}" >
					<td colspan="4" id = "siteFileUploadTd_${siteVo.rptSiteNo}" style ="display:none;">
						<%@include file="../include/uploadform_siteFile.jsp"%>
					</td>
				</tr>
				<tr id ='siteFileDownArea_${siteVo.rptSiteNo}'>
					<c:if test="${siteVo.fileName ne ''}">
					<td align="center" colspan="4">
     				   <a href='fileDownload?key=${siteVo.rptSiteNo}&type=siteInterim'>
	     				   ${siteVo.fileName}
    					</a>
    					<img src='./resources/ls_img/btn_del_s.gif' id = 'siteFileDelBtn_${siteVo.rptSiteNo}' onclick="siteFileDel('${siteVo.rptSiteNo}');" style='cursor:pointer; margin-left:5px;'/>
    				</td>
	   				</c:if>
   				</tr> --%>
			</c:forEach>			
		</tbody>
	</table>
