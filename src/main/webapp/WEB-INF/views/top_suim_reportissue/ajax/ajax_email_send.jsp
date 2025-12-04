<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
	$(document).ready(function(){	
		$("#disagree_display").hide();
		$("#mobile_display").hide();
		
		if($("#send_edit_type").val() == 'edit'){
			_initCalendar();
		}
		
		$("#question_info").click( function(){
			//alert("처리일자 안내\n1.비 동의 : 비 동의시간(적색표기)\n2.동의 : 휴대폰발송완료시간 (청색표기)\n3.동의 : 이메일,팩스발송시간(청색표기)\n※ 휴대폰 발송완료건은 삭제가 불가하며,\n휴대폰발송전 이메일 팩스등록건은 삭제가 가능합니다.");
			
			$("#question-info-dialog").dialog({
				height: 270,
				width: 340,
				closeOnEscape : true,
				draggable : false,					
				title: "교부(거부)일자 안내",
				buttons:{						
					"닫기" : function(){
						$(this).dialog("close");
					}
				},
				modal: true,
				overlay:{ opacity: 0., background: '#000000'}
			});
			
		});
		
	});
	
	function rptIssueFileDel(serialNo){
		if(confirm("손해사정서 교부동의서 파일을 삭제하시겠습니까?")){
			//$.post("./rptOrgFileDel",
			$.post("./rptIssueFileDel",
					{	
						serialNo 	:	serialNo  //						
					},
					function(data,status){
						if(status == "success"){
							if(data != 0){								
								//삭제가 끝나면 교부 ajax 호출
								  getSendList();
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
	
	function sendReload(){		
		location.reload();		
	}
	
	function fnShowMobile(){
		$("#email_add").hide();
		$("#tel1_add").show();
		$("#tel2_add").show();
		$("#tel3_add").show();
		//값 초기화
		$("#email_add").val('');
	}
	
	function fnPrivacyAgreeChk(){
		
		//동의 또는 비 동의 여부를 선택하기전 교부동의서가 업로드 되어있는지 체크한다.
		var param = {};
		param.suim_rpt_no = $("#suim_rpt_no").val();
		
		var url = "getCountTopRptIssueFileBySuimRptNo";
		
		$.ajax({
		    type: "POST",
		    url: url,
		    data: param,
		    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		    dataType: "html",		    
		    timeout: 2000,
		    success: function(data){
		    	
		    	if( $("#privacy_agree1_add").is(":checked") ){						//동의시에는 교부동의서 첨부여부를 확인하지 않는다.
		    		$("#agree").html("<b>교부방법(택1)</b>");      		
	          		$("#privacy_agree_val").val('1');
	          		$("#disagree_display").hide();
	          		$("#select_display").show();
		    	}else{															//비 동의시에는 교부동의서 첨부여부를 확인한다.
		    		if( data ==  0 ){		//교부동의서가 없는경우
			    		alert("교부동의서가 첨부되어야 동의여부 선택이 가능합니다.");
			    		$('input[name="privacy_agree_add"]').prop('checked',false);
			    		fnIssueSendCancel();
			    		return;
			    	}else{
			    		$("#agree").html("<b>비 동의 일자</b>");    		
		        		$("#privacy_agree_val").val('2');
		        		$("#mobile_display").hide();
		        		$("#email_save_display").hide();
		        		$("#email_sel_display").hide();
		        		$("#fax_display").hide();
		        		$("#select_display").hide();
		        		$("#disagree_display").show();
			    	}
		    	}		    	
		    	
		    	/** 비동의시에만 첨부파일을 확인하는 방식으로 기능 수정  20250923
		    	
		    	if( data ==  0 ){		//교부동의서가 없는경우
		    		alert("교부동의서가 첨부되어야 동의여부 선택이 가능합니다.");
		    		$('input[name="privacy_agree_add"]').prop('checked',false);
		    		return;
		    	}else{					//교부동의서가 있는경우
		    		if ($("#privacy_agree1_add").is(":checked")){			//동의 클릭 시      		
		          		$("#agree").html("<b>교부방법(택1)</b>");      		
		          		$("#privacy_agree_val").val('1');
		          		$("#disagree_display").hide();
		          		$("#select_display").show();      		
		        	}else{														//비 동의 클릭 시
		        		$("#agree").html("<b>비 동의 일자</b>");    		
		        		$("#privacy_agree_val").val('2');
		        		$("#mobile_display").hide();
		        		$("#email_save_display").hide();
		        		$("#email_sel_display").hide();
		        		$("#fax_display").hide();
		        		$("#select_display").hide();
		        		$("#disagree_display").show();
		        	}
		    	}
		    	**/
		    }		    
		});
    }
	
	//휴대폰 선택
	function selMobile(){
		$("#select_display").hide();
		/* $("#agree").html("<b>교부방법등록</b>"); */
		$("#agree").html("<b>수신자 휴대폰 번호 및 첨부파일 저장</b>");
		$("#send_method").val('mobile');			//휴대폰 발송		
		//입력폼 초기화
		$("#tel1_add").val('');
		$("#tel2_add").val('');
		$("#tel3_add").val('');
		
		//버튼활성화
		$("#mobileAttachButton").show();
		$("#mobile_display").show();
	}
	
	//이메일 선택
	function selEmail(){
		$("#agree").html("<b>이메일발송</b>");
		$("#select_display").hide();
		$("#email_save_display").hide();
		$("#email_sel_display").show();
	}
	
	//이메일 발송내역저장
	function emailSave(){
		$("#agree").html("<b>이메일 발송기록 저장</b>");
		$("#email_sel_display").hide();
		$("#send_method").val('email');			//메일발송기록저장
		$("#email_save_display").show();
		$("#email_send_date_text").show();
		$("#email_attach_text").hide();				//메일 첨부파일 등록폼
		$("#emailSaveButton").show();						//메일 직접 저장버튼
		$("#emailAttachButton").hide();					//메일 첨부 저장버튼
		$("#email_add").focus();
	}
	
	//이메일 직접발송
	function emailSend(){
		$("#agree").html("<b>수신자 이메일 주소 및 첨부파일 저장</b>");		
		$("#select_display").hide();							//이메일 휴대폰 선택 삭제 차단
		$("#email_sel_display").hide();
		$("#send_method").val('email_send');			//발송할 메일주소 저장
		$("#email_save_display").show();
		$("#email_send_date_text").hide();				//메일 발송일자는 저장하지 않는다.
		$("#email_attach_text").show();					//메일 첨부파일 등록폼
		$("#emailSaveButton").hide();						//메일 직접 저장버튼
		$("#emailAttachButton").show();					//메일 첨부 저장버튼
		$("#email_add").focus();
		
	}
	
	//팩스 선택
	function selFax(){
		$("#agree").html("<b>팩스 발송기록 저장</b>");
		$("#select_display").hide();
		$("#send_method").val('fax');			//팩스 발송
		//입력폼 초기화		
		$("#fax1_add").val('');
		$("#fax2_add").val('');
		$("#fax3_add").val('');
		$("#sendtemp").val('');
		$("#fax_display").show();
	}
	
	//교부방법 선택으로 이동
	function selCancel(){
		$("#agree").html("<b>교부방법(택1)</b>");
		$("#mobile_display").hide();
		//$("#email_sel_display").hide();
		$("#email_save_display").hide();
		$("#fax_display").hide();		
		$("#select_display").show();		
	}	
</script>
</head>
<c:if test="${ send_edit_type eq 'edit' }">
<form id="issueEmailForm" name="issueEmailForm" method="post" enctype="multipart/form-data">
<input type="hidden" id="suim_rpt_no" name="suim_rpt_no" value="${suimVO.suim_rpt_no}">
<table id="table_issue_contract_edit" style="border: 1px solid currentColor;">
	<colgroup>
	    <col width="35%">
	    <col width="20%">
	    <col width="45%">
	</colgroup>                
	<tbody>
	<tr>
		<th><b>구분</b></th>
		<th><b>동의여부</b></th>
		<th><span id="agree"></span></th>										                	
	</tr>
	<tr>				    
	    <td style="text-align: left;padding-left:5px;padding-right:5px;">
	    	<select id="send_target_add" name="send_target">
           		<option value="1">계약자</option>
           		<option value="5">피보험자</option>
           		<option value="10">보험청구권자</option>
           		<option value="6">계약자+피보험자</option>
           		<option value="15">피보험자+보험청구권자</option>
           		<option value="16">계약자+피보험자+보험청구권자</option>
           	</select>
	    </td>
	    <td>
	    	<input type="radio" id="privacy_agree1_add" name="privacy_agree_add" value="1" onchange="fnPrivacyAgreeChk();"/> 동의
           	<input type="radio" id="privacy_agree2_add" name="privacy_agree_add" value="2" onchange="fnPrivacyAgreeChk();"/> 비 동의
           	<input type="hidden" id="privacy_agree_val" name="privacy_agree" value="">
           	<input type="hidden" id="send_method" name="send_method" value="">
	    </td>
	    <td  style="text-align: center;" style="display:none;">
	    	<div id="disagree_display">
           		<input class="calendar" type="text" id="disagree_date" value="${sToday}" style="width: 50%;"/>
           		<input type="button" class="buttonMini" value="저장" onclick="javascript:fnIssueSendSave();" style="width:40px;">				
           	</div>
           	<div id="select_display" style="display:none;">
           		<!-- <input type="button" class="buttonMini" value="이메일" onclick="javascript:selEmail();" style="background-color:#D8F6CE;">&nbsp; -->
           		<input type="button" class="buttonMini" value="휴대폰" onclick="javascript:selMobile();">&nbsp;
           		<!-- 이메일 선택 시 바로 등록페이지로 이동 -->
           		<input type="button" class="buttonMini" value="이메일" onclick="javascript:emailSend();" style="background-color:#D8F6CE;">&nbsp;           		           		
           		<!-- <input type="button" class="buttonMini" value="팩 스" onclick="javascript:selFax();" style="background-color:#F3E2A9;"> -->           		           	
           	</div>
           	<div id="mobile_display" style="display:none;">
				<div style="text-align:right;padding-right:10px;padding-bottom:4px;">
	        		<input type="button" id="mobileAttachButton" class="buttonMini" value="저장" onclick="javascript:fnIssueMobileSave();" style="width:40px;display:none;">
					<input type="button" class="buttonMini" value="취소" onclick="javascript:selCancel();" style="width:40px;background-color:#F6CED8;">					
	        	</div>
				<table>	        		
	        		<tr id="mobile_tel_text">
	        			<th style="border-left:0px;width:27%;"><b>휴대폰 번호</b></th>
	        			<td style="border-right:0px;width:73%;">
	        				<input type="text" class="tel" id="tel1_add" name="tel1_add" maxlength="3" style="width:40px;" /> 
							<input type="text" class="tel" id="tel2_add" name="tel2_add"  maxlength="4" style="width:50px;" /> 
							<input type="text" class="tel" id="tel3_add" name="tel3_add"  maxlength="4" style="width:50px;" />
	        			</td>
	        		</tr>
	        		<%-- <tr id="mobile_send_date_text">
	        			<th style="border-left:0px;width:27%;"><b>교부일자</b></th>
	        			<td style="border-right:0px;width:73%;"><input class="calendar" type="text" id="mobile_send_date" name="mobile_send_date" value="${sToday}" style="width:40%"/></td>
	        		</tr> --%>
	        		<tr id="mobile_attach_text">
	        			<th style="border-left:0px;width:27%;"><b>첨부파일</b></th>
	        			<td style="border-right:0px;width:73%;"><input type="file" id="mobile_attach_file" name="mobile_attach_file" style="border:1px solid;padding:1px;"></td>
	        		</tr>
	        	</table>
	        </div>
	        <!-- 이메일 저장방식 선택 -->
	        <div id="email_sel_display" style="display:none;">
	        	<input type="button" class="buttonMini" value="인트라넷 메일교부" onclick="javascript:emailSend();" style="width:110px;background-color:#D8F6CE;">&nbsp;
	        	<!-- <input type="button" class="buttonMini" value="개인메일 발송이력" onclick="javascript:emailSave();" style="width:110px;">&nbsp; -->
	        	<input type="button" class="buttonMini" value="취소" onclick="javascript:selCancel();" style="width:40px;background-color:#F6CED8;">
	        </div>
	        <div id="email_save_display" style="display:none;padding:0px;">
	        	<div style="text-align:right;padding-right:10px;padding-bottom:4px;">
	        		<input type="button" id="emailAttachButton" class="buttonMini" value="저장" onclick="javascript:fnIssueEmailSave();" style="width:40px;display:none;">
	        		<input type="button" id="emailSaveButton" class="buttonMini" value="저장" onclick="javascript:fnIssueSendSave();" style="width:40px;display:none;">
					<!-- <input type="button" class="buttonMini" value="취소" onclick="javascript:selEmail();" style="width:40px;background-color:#F6CED8;"> -->
					<input type="button" class="buttonMini" value="취소" onclick="javascript:selCancel();" style="width:40px;background-color:#F6CED8;">
	        	</div>
	        	<table>	        		
	        		<tr>
	        			<th style="border-left:0px;width:27%;"><b>메일주소</b></th>
	        			<td style="border-right:0px;width:73%;"><input type="text" id="email_add" name="email_add" style="width:180px;" placeholder="abc@domain.com"/></td>
	        		</tr>
	        		<tr id="email_send_date_text" style="display:none;">
	        			<th style="border-left:0px;width:27%;"><b>발송일(예정)</b></th>
	        			<td style="border-right:0px;width:73%;"><input class="calendar" type="text" id="email_send_date" name="email_send_date" value="${sToday}" style="width:40%"/></td>
	        		</tr>
	        		<tr id="email_attach_text" style="display:none;">
	        			<th style="border-left:0px;width:27%;"><b>첨부파일</b></th>
	        			<td style="border-right:0px;width:73%;"><input type="file" id="email_attach_file" name="email_attach_file" style="border:1px solid;padding:1px;"></td>
	        		</tr>
	        	</table>
	        	
	        	<%--
				<span id="email_send_date_text" style="display:none;">				
					<br/>발송일(예정)&nbsp;&nbsp; : &nbsp;&nbsp;<input class="calendar" type="text" id="email_send_date" value="${sToday}" style="width: 40%;"/>
				</span>
				<span id="email_attach_text" style="display:none;">
					<br/>첨부파일&nbsp;&nbsp; : <input type="file" id="email_attach_file" name="email_attach_file">
					<%@include file="../../include/uploadform_suimrptissue.jsp"%>
				</span>
				 --%>
	        </div>	        
	        <div id="fax_display" style="display:none;">
	        	<input type="text" class="tel" id="fax1_add" name="fax1_add" maxlength="3" style="width:40px;" /> 
				<input type="text" class="tel" id="fax2_add" name="fax2_add" maxlength="4" style="width:50px;" /> 
				<input type="text" class="tel" id="fax3_add" name="fax3_add" maxlength="4" style="width:50px;" />&nbsp;
				<input type="button" class="buttonMini" value="저장" onclick="javascript:fnIssueSendSave();" style="width:40px;">
				<input type="button" class="buttonMini" value="취소" onclick="javascript:selCancel();" style="width:40px;background-color:#F6CED8;">				
				<br/>발송일(예정)&nbsp;&nbsp; : &nbsp;&nbsp;<input class="calendar" type="text" id="fax_send_date" value="${sToday}" style="width: 40%;"/>
	        </div>
	    </td>
	</tr>	
    </tbody>
</table>
</form>
<br/>
</c:if>
<!-- 발송목록 -->
<table id="table_issue_contract_view" style="border: 1px solid currentColor;">
	<colgroup>
	    <col width="15%">
	    <col width="10%">
	    <col width="38%">
	    <col width="17%">
	    <col width="20%">
	</colgroup>                
	<tbody>
	<!-- 교부동의서 첨부 추가 시작 -->
	<tr>
		<th rowspan="2" colspan="2"><b>교부동의서 첨부</b></th>
		<th colspan="2"><b>파일명</b></th>
		<th><b>등록일자</b></th>		
	</tr>		
		<c:forEach items="${rptIssueFileList}" var="orgFileVo">
			<tr id = "rptFileOrgTr_${orgFileVo.serialNo}">
				<td colspan="2">
					<a href="fileDownload?key=${orgFileVo.serialNo}&type=rptIssue&suimRptNo=${suimVO.suim_rpt_no}">
						<font color="blue"> ${orgFileVo.fileName}</font>						
					</a>&nbsp;
					<img src='/resources/ls_img/btn_del_s.gif' onclick="rptIssueFileDel('${orgFileVo.serialNo}');" style='cursor:pointer; margin-left:5px;'/>
				</td>
				<td>
					${orgFileVo.regDate}											
				</td>
			</tr>
		</c:forEach>		
		<c:if test="${fn:length(rptIssueFileList) eq 0 }">	
			<tr>		
				<td colspan="3">					
					<%@include file="../../include/uploadform_suimrptissue.jsp"%>								
				</td>		
			</tr>
		</c:if>
	<!-- 교부동의서 첨부 추가 끝 -->
	</tbody>
</table>
<br/>
<table id="table_issue_contract_view" style="border: 1px solid currentColor;border-bottom:0px;">
	<%-- <colgroup>
	    <col width="14%">
	    <col width="14%">
	    <col width="32%">
	    <col width="14%">	    
	    <col width="9%">
	    <col width="17%">
	</colgroup> --%>                
	<!-- <tbody> -->	
	<tr>	
		<th width="90px"><b>교부 대상자</b></th>
		<th width="90px"><b>교부 동의여부</b></th>
		<th width="210px"><b>교부방법</b></th>
		<th width="90px"><b>상태</b> <img src="/resources/ls_img/bt_icon.gif" style="cursor:pointer;" onclick="sendReload();"></th>
		<th width="40px"><b>교부<br/>내용</b></th>
		<th width="112px"><b>교부(거부)일자</b> <span id="question_info" style="font-size:9px;cursor:pointer;">[?]</span></th>		      	
	</tr>
</table>
<div style="height: 480px; overflow-y: auto;">
	<table id="table_issue_contract_view" style="border:1px solid currentColor;border-top:0px;">	
		<c:forEach items="${rptIssueSendList}" var="item" varStatus="status">	
		<input type="hidden" id="msgid" value="${item.msgid}"/>
		<tr>				    
		    <td width="90px" style="border-top:0px;">
		    	<c:if test="${item.sendTarget eq '1'}">계약자</c:if>
		    	<c:if test="${item.sendTarget eq '5'}">피보험자</c:if>
		    	<c:if test="${item.sendTarget eq '10'}">보험청구권자</c:if>
		    </td>
		    <td width="90px" style="border-top:0px;">
		    	<c:if test="${item.privacyAgree == 1}">동의</c:if>
		    	<c:if test="${item.privacyAgree == 2}">비 동의</c:if>
		    </td>
		    <td width="209px" style="text-align: left;padding-left:2px;border-top:0px;">	    	
		    	<c:choose>	    		
		    		<c:when test="${item.sendMethod eq 'mobile'}">
		    			<input type="button" class="buttonMini" value="휴대폰" style="cursor:default;">
		    			${ item.tel1}-${ item.tel2}-${ item.tel3}
		    		</c:when>
		    		<c:when test="${item.sendMethod eq 'email'}">
		    			<div style="width:220px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" title="${item.email}">
		    			<input type="button" class="buttonMini" value="이메일" style="cursor:default;background-color:#D8F6CE;">	    			
		    				${item.email}
		    			</div>
		    		</c:when>
		    		<c:when test="${item.sendMethod eq 'email_send'}">
		    			<div style="width:220px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" title="${item.email}">
		    			<input type="button" class="buttonMini" value="이메일" style="cursor:default;background-color:#D8F6CE;">	    			
		    				${item.email}
		    			</div>
		    		</c:when>	    		
		    		<c:when test="${item.sendMethod eq 'fax'}">
		    			<input type="button" class="buttonMini" value="팩 스"  style="cursor:default;background-color:#F3E2A9;">
		    			${ item.tel1}-${ item.tel2}-${ item.tel3}
		    		</c:when>
		    	</c:choose>
		    </td>	    
		    <td width="90px" style="border-top:0px;">	    	    	
		    	<c:choose>				
					<c:when test="${not empty suimVO.suimRptState}">
		               	<c:choose>
		               		<c:when test="${item.privacyAgree == 2}">
		                		-
		                	</c:when>	
		                	<c:when test="${item.sendState == 1 or item.sendState == 2}">
		                		<font color="blue"><b>교부 완료</b></font>
		                	</c:when>
		                	<c:when test="${item.sendMethod eq 'mobile' && item.completeFlag == 1}">
		                		<font color="blue"><b>교부 완료</b></font>
		                	</c:when>
							<c:when test="${item.sendMethod eq 'mobile' && empty item.sendDate}">
								<input type="button" title="문자발송" class="buttonAssistanceDocu" style="background-color:#2E7EE8;" value="문자발송" onclick="fnIssueSendMsg(${item.serialNo});">									                    	
							</c:when>
							<c:when test="${item.privacyAgree == 1 && item.sendMethod eq 'email_send' }">
								<input type="button" title="메일발송" class="buttonAssistanceDocu" style="background-color:#04B404;" value="메일발송" onclick="fnIssueSendEmailAttach(${item.serialNo});">									                    	
							</c:when>
		                	<c:otherwise>
								<c:choose>							
									<c:when test="${item.privacyAgree == 1 && (item.sendMethod eq 'email' || item.sendMethod eq 'fax' )}">
										<font color="blue"><b>교부 완료</b></font>
									</c:when>
									<c:otherwise>
									-
									</c:otherwise>
								</c:choose>
		                	</c:otherwise>
		               	</c:choose>
		             </c:when>
				</c:choose>
		    </td>
		    <!-- 첨부파일이 있는 경우 파일 다운로드로 표시, 그외 발송내용 보기 (모바일, 이메일)-->
		    <td width="40px" style="border-top:0px;">
		    	<c:choose>
		    		<c:when test="${not empty item.orgFileName}">
		    			<a href="fileDownload?key=${item.serialNo}&amp;type=emailAttach&amp;suimRptNo=${item.suimRptNo}" title="첨부파일 다운로드">
							<img src="./resources/ls_img/icon_disket.gif" title="${item.orgFileName}">
						</a>
		    		</c:when>
		    		<c:when test='${item.sendContent eq ""}'> - </c:when>	    		
		    		<c:otherwise>
		    			<c:if test="${item.sendMethod eq 'mobile'}">
		    				<input type="button" class="buttonMini" value="보기" style="width:40px;" onclick="javascript:showMobileContent('${item.serialNo}');">
		    			</c:if>
		    			<c:if test="${item.sendMethod eq 'email'}">
		    				<input type="button" class="buttonMini" value="보기" style="width:40px;background-color:#D8F6CE;" onclick="javascript:showEmailContent('${item.serialNo}');">
		    			</c:if>
		    		</c:otherwise>
		    	</c:choose>
		    </td>
			    <c:choose>
			    	<c:when test="${rptIssueSendList.size() > 13}">
			    		<td width="93px" style="text-align: left;border-top:0px;padding-left:2px;">
			    	</c:when>
			    	<c:otherwise>
			    		<td width="110px" style="text-align: left;border-top:0px;padding-left:2px;">		
			    	</c:otherwise>
			    </c:choose>		    
		    	<c:choose>
			    	<c:when test="${item.privacyAgree == 2}">
			            <span style="color:red"> ${ item.disagreeDate } </span>
					</c:when>	
					<c:when test="${item.sendState == 1 || item.sendMethod eq 'fax'}">
						<span style="color:blue"> ${ item.sendDate } </span>
					</c:when>
					<c:otherwise>
						${ item.regDate}
					</c:otherwise>
				</c:choose>				
				<c:if test="${item.sendState == 0}">
				<img src="./resources/ls_img/btn_del_s.gif" border="0" onclick="fnSend_del('${item.suimRptNo }','${item.serialNo}');" style="cursor:pointer;padding-left:2px;" />
				</c:if>
		    </td>	    
		</tr>	
		</c:forEach>
		<c:if test="${fn:length(rptIssueSendList) == 0}">
		<tr>				    
		    <td colspan="6" style="border-top:0px;">등록된 교부대상자 정보가 없습니다.</td>	    
		</tr>	
		</c:if>
	    <!-- </tbody> -->
	</table>
</div>
<div id="question-info-dialog" title="교부(거부)일자 안내" style="font-size: 15px;display:none;" align="center">
	<br/>
	<div class="tableStyle2" style="width: 300px;border-top:0px;">
		<table class="vacation-ins-table">
			<tr>
				<th colspan="2" style="text-align:left;padding-left:10px;height:25px;color:red;">&#8251; 발송완료 건은 삭제가 불가합니다.</th>
			</tr>
			<tr>
				<th>교부</th>
				<td style="color:blue">청색표기</td>				
			</tr>
			<tr>
				<th>미 교부</th>
				<td>흑색표기</td>				
			</tr>
			<tr>
				<th>비 동의</th>
				<td style="color:red">적색표기</td>				
			</tr>			
		</table>
	</div>
</div>
</html>