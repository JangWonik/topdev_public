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
			alert("처리일자 안내\n1.비 동의 : 비 동의시간(적색표기)\n2.동의 : 휴대폰발송완료시간 (청색표기)\n3.동의 : 이메일,팩스발송시간(청색표기)\n※ 휴대폰 발송완료건은 삭제가 불가하며,\n휴대폰발송전 이메일 팩스등록건은 삭제가 가능합니다.");
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
	
	//휴대폰 선택
	function selMobile(){
		$("#select_display").hide();
		$("#agree").html("<b>휴대폰발송</b>"); 
		$("#send_method").val('mobile');			//휴대폰 발송
		//입력폼 초기화		
		$("#tel1_add").val('');
		$("#tel2_add").val('');
		$("#tel3_add").val('');		
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
		$("#email_add").focus();
	}
	
	//이메일 직접발송
	function emailSend(){
		$("#agree").html("<b>수신자 이메일 주소저장</b>");
		$("#email_sel_display").hide();
		$("#send_method").val('email_send');			//발송할 메일주소 저장
		$("#email_save_display").show();
		$("#email_send_date_text").hide();				//메일 발송일자는 저장하지 않는다.
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
		$("#email_sel_display").hide();
		$("#fax_display").hide();		
		$("#select_display").show();		
	}
</script>
</head>
<c:if test="${ send_edit_type eq 'edit' }">
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
	    	<select id="send_target_add" >
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
           	<input type="hidden" id="privacy_agree_val" value="">
           	<input type="hidden" id="send_method" value="">
	    </td>
	    <td  style="text-align: center;" style="display:none;">
	    	<div id="disagree_display">
           		<input class="calendar" type="text" id="disagree_date" value="${sToday}" style="width: 50%;"/>
           		<input type="button" class="buttonMini" value="저장" onclick="javascript:fnIssueSendSave();" style="width:40px;">				
           	</div>
           	<div id="select_display" style="display:none;">
           		<input type="button" class="buttonMini" value="휴대폰" onclick="javascript:selMobile();">&nbsp;
           		<input type="button" class="buttonMini" value="이메일" onclick="javascript:selEmail();" style="background-color:#D8F6CE;">&nbsp;
           		<input type="button" class="buttonMini" value="팩 스" onclick="javascript:selFax();" style="background-color:#F3E2A9;">           		           	
           	</div>
           	<div id="mobile_display" style="display:none;">
				<input type="text" class="tel" id="tel1_add"  maxlength="3" style="width:40px;" /> 
				<input type="text" class="tel" id="tel2_add"  maxlength="4" style="width:50px;" /> 
				<input type="text" class="tel" id="tel3_add"  maxlength="4" style="width:50px;" />&nbsp;
				<input type="button" class="buttonMini" value="저장" onclick="javascript:fnIssueSendSave();" style="width:40px;">
				<input type="button" class="buttonMini" value="취소" onclick="javascript:selCancel();" style="width:40px;background-color:#F6CED8;">				
	        </div>
	        <!-- 이메일 저장방식 선택 -->
	        <div id="email_sel_display" style="display:none;">
	        	<input type="button" class="buttonMini" value="인트라넷 메일교부" onclick="javascript:emailSend();" style="width:110px;background-color:#D8F6CE;">&nbsp;
	        	<input type="button" class="buttonMini" value="개인메일 발송이력" onclick="javascript:emailSave();" style="width:110px;">&nbsp;
	        	<input type="button" class="buttonMini" value="취소" onclick="javascript:selCancel();" style="width:40px;background-color:#F6CED8;">
	        </div>
	        <div id="email_save_display" style="display:none;">
	        	<input type="text" id="email_add" style="width:140px;"/>&nbsp;
	        	<input type="button" class="buttonMini" value="저장" onclick="javascript:fnIssueSendSave();" style="width:40px;">
				<input type="button" class="buttonMini" value="취소" onclick="javascript:selEmail();" style="width:40px;background-color:#F6CED8;">
				<span id="email_send_date_text" style="display:none;">				
					<br/>발송일(예정)&nbsp;&nbsp; : &nbsp;&nbsp;<input class="calendar" type="text" id="email_send_date" value="${sToday}" style="width: 40%;"/>
				</span>
	        </div>	        
	        <div id="fax_display" style="display:none;">
	        	<input type="text" class="tel" id="fax1_add"  maxlength="3" style="width:40px;" /> 
				<input type="text" class="tel" id="fax2_add"  maxlength="4" style="width:50px;" /> 
				<input type="text" class="tel" id="fax3_add"  maxlength="4" style="width:50px;" />&nbsp;
				<input type="button" class="buttonMini" value="저장" onclick="javascript:fnIssueSendSave();" style="width:40px;">
				<input type="button" class="buttonMini" value="취소" onclick="javascript:selCancel();" style="width:40px;background-color:#F6CED8;">				
				<br/>발송일(예정)&nbsp;&nbsp; : &nbsp;&nbsp;<input class="calendar" type="text" id="fax_send_date" value="${sToday}" style="width: 40%;"/>
	        </div>
	    </td>
	</tr>	
    </tbody>
</table>
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
<table id="table_issue_contract_view" style="border: 1px solid currentColor;">
	<colgroup>
	    <col width="14%">
	    <col width="9%">
	    <col width="35%">
	    <col width="16%">	    
	    <col width="9%">
	    <col width="17%">
	</colgroup>                
	<tbody>	
	<tr>	
		<th><b>구분</b></th>
		<th><b>동의여부</b></th>
		<th><b>교부방법</b></th>
		<th><b>상태</b> <img src="/resources/ls_img/bt_icon.gif" style="cursor:pointer;" onclick="sendReload();"></th>
		<th><b>발송내용</b></th>
		<th><b>처리일자</b> <span id="question_info" style="font-size:9px;cursor:pointer;">[?]</span></th>												                	
	</tr>	
	<c:forEach items="${rptIssueSendList}" var="item" varStatus="status">	
	<input type="hidden" id="msgid" value="${item.msgid}"/>
	<tr>				    
	    <td>
	    	<c:if test="${item.sendTarget eq '1'}">계약자</c:if>
	    	<c:if test="${item.sendTarget eq '5'}">피보험자</c:if>
	    	<c:if test="${item.sendTarget eq '10'}">보험청구권자</c:if>
	    </td>
	    <td>
	    	<c:if test="${item.privacyAgree == 1}">동의</c:if>
	    	<c:if test="${item.privacyAgree == 2}">비 동의</c:if>
	    </td>
	    <td style="text-align: left;padding-left:5px;">
	    	<c:choose>
	    		<c:when test="${item.sendMethod eq 'mobile'}">
	    			<input type="button" class="buttonMini" value="휴대폰" style="cursor:default;">
	    			${ item.tel1}-${ item.tel2}-${ item.tel3}
	    		</c:when>
	    		<c:when test="${item.sendMethod eq 'email' or item.sendMethod eq 'email_send'}">
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
	    <td>	    	    	
	    	<c:choose>
				<c:when test="${suimVO.suimRptState == 2}">
	               	<c:choose>
	               		<c:when test="${item.privacyAgree == 2}">
	                		-
	                	</c:when>	
	                	<c:when test="${item.sendState == 1 or item.sendState == 2}">
	                		<font color="blue"><b>발송 완료</b></font>
	                	</c:when>
	                	<%-- <c:when test="${item.sendState == 2}">				                    	
	                		발송중<br/>
	                		( ${ item.stateMsg } )				                    		
	                	</c:when> --%>
	                	<c:when test="${item.sendState == 0 && item.sendDate != null && item.sendMethod eq 'mobile'}">				                    	
	                		발송실패<br/>
	                		( ${ item.stateMsg } )				                    		
	                	</c:when>				                    				                    	
						<c:when test="${item.privacyAgree == 1 && item.sendMethod eq 'mobile' }">
							<input type="button" title="문자발송" class="buttonAssistanceDocu" style="background-color:#2E7EE8;" value="문자발송" onclick="fnIssueSendMsg(${item.serialNo});">									                    	
						</c:when>
						<c:when test="${item.privacyAgree == 1 && item.sendMethod eq 'email_send' }">
							<input type="button" title="메일발송" class="buttonAssistanceDocu" style="background-color:#04B404;" value="메일발송" onclick="fnIssueSendEmail(${item.serialNo});">									                    	
						</c:when>
	                	<c:otherwise>
						<c:choose>
							<c:when test="${item.privacyAgree == 1 && item.sendMethod eq 'mobile' }">								
								<input type="button" title="문자발송" class="buttonAssistanceDocu" style="background-color:#2E7EE8;" value="문자발송" onclick="fnIssueSendMsg(${item.serialNo});">
							</c:when>
							<c:when test="${item.privacyAgree == 1 && (item.sendMethod eq 'email' || item.sendMethod eq 'fax' )}">
								<b>교부 완료</b>
							</c:when>
							<c:otherwise>
							-
							</c:otherwise>
						</c:choose>
	                	</c:otherwise>
	               	</c:choose>
	             </c:when>	             
	             <c:otherwise>
	               	<c:choose>
	               		<c:when test="${item.privacyAgree == 2}">
	                		-
	                	</c:when>
	                	<c:when test="${item.sendState == 1 or item.sendState == 2}">
	                		<font color="blue"><b>발송 완료</b></font>
	                	</c:when>
	                	<%-- <c:when test="${item.sendState == 2}">
	                		발송중<br/>
	                		( ${ item.stateMsg } )
	                	</c:when> --%>
	                	<c:when test="${item.sendState == 0  && item.sendDate != null && item.sendMethod eq 'mobile' }">
	                		발송실패<br/>
	                		( ${ item.stateMsg } )
	                	</c:when>
	                	<c:when test="${item.sendMethod eq 'email' || item.sendMethod eq 'email_send' || item.sendMethod eq 'fax'}">
	                		종결 후 교부가능
	                	</c:when>
	                	<c:otherwise>
						종결 후 발송가능		                    	
	                	</c:otherwise>
	               	</c:choose>
				</c:otherwise>
			</c:choose>
	    </td>
	    <!-- 발송내용 보기 (모바일, 이메일)-->
	    <td>
	    	<c:choose>
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
	    <td style="text-align: left;padding-left:10px;">
	    	<c:choose>
		    	<c:when test="${item.privacyAgree == 2}">
		            <span style="color:red"> ${ item.disagreeDate } </span>
				</c:when>	
				<c:when test="${item.sendState == 1 || ( item.sendMethod eq 'fax' || item.sendMethod eq 'email' ) }">
					<span style="color:blue"> ${ item.sendDate } </span>
				</c:when>
				<c:otherwise>
					${ item.regDate }
				</c:otherwise>
			</c:choose>
			<c:if test="${item.sendState != 1}">
			<img src="./resources/ls_img/btn_del_s.gif" border="0" onclick="fnSend_del('${item.suimRptNo }','${item.serialNo}');" style="cursor:pointer;padding-left:2px;" />
			</c:if>
	    </td>	    
	</tr>	
	</c:forEach>
	<c:if test="${fn:length(rptIssueSendList) == 0}">
	<tr>				    
	    <td colspan="6">등록된 교부대상자 정보가 없습니다.</td>	    
	</tr>	
	</c:if>
    </tbody>
</table>
</html>