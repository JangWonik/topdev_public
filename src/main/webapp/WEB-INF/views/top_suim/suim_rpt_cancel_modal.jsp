<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<!-- <script src="./resources/ne_js/rpt_cancel.js"></script> -->
<script>
	function fnRemoveSpecial( p_param ){
		
		var reVal = "";
		var reg = /[`~!@#$%^&*()_|+\-=?;:'"<>\{\}\[\]\\\/.\n ]/gi;	
		
		if( reg.test(p_param) ){
			reVal = p_param.replace(reg,"");
		}else{
			reVal = p_param;
		}
		return reVal;
	}
	
	function fnRptCancelIns(){
		$("#cancel-dialog").dialog({
			height: 450,
			width: 500,
			closeOnEscape : true,
			draggable : false,
			appendTo : "#rptCancelForm",
			buttons:{
				"위임취소 신청" : function(){				
					
					if ( !$("input:radio[name='insCancelGubun']").is(":checked") ){
						alert("위임취소 구분을 확인 해 주세요.");
						event.preventDefault();
						return;
					}
					
					//위임취소 사유입력여부 체크 by top3009 20240717 (김두현부장 요청사항)
					var sInputVal = $("#cancelReasonTxtArea").val();
					if( !sInputVal ){
						alert("위임취소 사유를 입력해주세요.");
						event.preventDefault();
						return;
					}
					
					sInputVal = fnRemoveSpecial(sInputVal);
					
					if( sInputVal.length < 7 ){
						alert("위임취소 사유는 7글자 이상으로 상세하게 입력하세요. \n(현재 "+sInputVal.length+" 글자 입니다.)");
						event.preventDefault();
						return;
					}
					
					$("#rptCancelForm").attr("action","insRptCancel");
					$("#rptCancelForm").submit();
					$(this).dialog("close");
				},
				"취소" : function(){
					$(this).dialog("close");
				}
			},
			modal: true,
			overlay:{ opacity: 0., background: '#000000'}
		});
	}
	
	function fnRptCancelMod(){
		$("#cancel-mod-dialog").dialog({
			height: 450,
			width: 500,
			closeOnEscape : true,
			draggable : false,
			appendTo : "#rptCancelForm",
			buttons:{
				"수정" : function(){				
					
					//위임취소 사유입력여부 체크 by top3009 20240717 (김두현부장 요청사항)
					var sInputVal = $("#cancelReasonModTxtArea").val();
					if( !sInputVal ){
						alert("위임취소 사유를 입력해주세요.");
						event.preventDefault();
						return;
					}
					
					sInputVal = fnRemoveSpecial(sInputVal);
					
					if( sInputVal.length < 7 ){
						alert("위임취소 사유는 7글자 이상으로 상세하게 입력하세요. \n(현재 "+sInputVal.length+" 글자 입니다.)");
						event.preventDefault();
						return;
					}
					
					$("#rptCancelForm").attr("action","udtRptCancel");
					$("#rptCancelForm").submit();
					
					
					$(this).dialog("close");
				},
				"취소" : function(){
					$(this).dialog("close");
				}
			},
			modal: true,
			overlay:{ opacity: 0., background: '#000000'}
		});
	}
	
	function fnRptCancelDel(){
		var r = confirm("위임취소 신청을 취소하시겠습니까?");
		if ( r != true){
			return;				
		}
		$("#rptCancelForm").attr("action","delRptCancel");
		$("#rptCancelForm").submit();
	}
	
	
	function fnRptCancelRestore(){
		var r = confirm("위임취소를 되돌리시겠습니까?");
		if ( r != true){
			return;				
		}
		$("#rptCancelForm").attr("action","restoreRptCancel");
		$("#rptCancelForm").submit();
	}
	
	
	function fnRptCancelApproval(){
		$("#cancel-approv-dialog").dialog({
			height: 450,
			width: 500,
			closeOnEscape : true,
			draggable : false,
			appendTo : "#rptCancelForm",
			buttons:{
				"결재" : function(){
					$("#rptCancelForm").attr("action","approvRptCancel");
					$("#rptCancelForm").submit();
					$(this).dialog("close");
				},
				"반려" : function(){
					$("#rptCancelForm").attr("action","returnRptCancel");
					$("#rptCancelForm").submit();
					$(this).dialog("close");
				},
				"취소" : function(){
					$(this).dialog("close");
				}
			},
			modal: true,
			overlay:{ opacity: 0., background: '#000000'}
		});			
	}
</script>
<!-- 모달 버튼 CSS -->
<style>
	.ui-button-text-only {
		height:2.1em !important;
	}
</style>

<!-- 위임취소 사유기재 로직 추가 -->
<form id="rptCancelForm" method="post">
	<input type="hidden" name="rptCancelSuimRptNo" id="rptCancelSuimRptNo" value="${suimVO.suim_rpt_no}" />
	<input type="hidden" name="rptCancelPrimRptNo" id="rptCancelPrimRptNo" value="${primBizRptDtl.suim_rpt_no}" />
	<input type="hidden" name="rptCancelSerialNo" id="rptCancelSerialNo" value="${rptCancel.serialNo}"/>	
	<input type="hidden" name="processChk" id="processChk" value="${processChk}" />				
	<input type="hidden" name="viewGubun" id="viewGubun" value="${viewGubun}" />				
					
	<div id="cancel-dialog" title="위임 취소 사유 작성" style="font-size: 15px;display:none;" align="center">
		<br/>
		<div style="width: 380px;">
			<table>
				<tr height="30">
					<th align="center"> 위임 취소 사유 </th>
				</tr>
				<tr>
					<td align="center" style="padding:3px;">
						<textarea class="cancelReasonTxtArea" id="cancelReasonTxtArea" name="cancelReasonTxtArea"
								  style="padding:4px; word-break:break-all;
								         line-height:120%; height:200px; width:93%;margin: 0 auto;
					           			 border: 2px solid #b3b3b3; border-radius: 4px;font-size: 10pt;
										   	 font-family: 굴림,굴림체; line-height: 150%; color:black;"></textarea>
					</td>
				</tr>
			</table>
			<input type="radio" name="insCancelGubun" id="insCancelGubun" value="1"> 단순위임취소
			<input type="radio" name="insCancelGubun" id="insCancelGubun" value="2"> 서면→일반전환건
			
														
		</div>
	</div>
	
	<div id="cancel-mod-dialog" title="위임 취소 사유 수정" style="font-size: 15px;display:none;" align="center">
		<br/>
		<div style="width: 380px;">
			<table>
				<tr height="30">
					<th align="center"> 위임 취소 사유 수정 </th>
				</tr>
				<tr>
					<td align="center" style="padding:3px;">
						<textarea class="cancelReasonTxtArea" id="cancelReasonModTxtArea" name="cancelReasonModTxtArea"
								  style="padding:4px; word-break:break-all;
								         line-height:120%; height:200px; width:93%;margin: 0 auto;
					           			 border: 2px solid #b3b3b3; border-radius: 4px;font-size: 10pt;
										   	 font-family: 굴림,굴림체; line-height: 150%; color:black;">${rptCancel.cancelReason}</textarea>
					</td>
				</tr>
			</table>
			<input type="radio" name="udtCancelGubun" id="udtCancelGubun" value="1" <c:if test="${rptCancel.cancelGubun eq '1'}">checked</c:if> > 단순위임취소
			<input type="radio" name="udtCancelGubun" id="udtCancelGubun" value="2" <c:if test="${rptCancel.cancelGubun eq '2'}">checked</c:if> > 서면→일반전환건											
		</div>
	</div>									
	
	<div id="cancel-approv-dialog" title="위임 취소 결재" style="font-size: 15px;display:none;" align="center">
		<br/>
		<div style="width: 380px;">
			<table>
				<tr height="30">
					<th align="center"> 위임 취소 결재</th>
				</tr>
				<tr>
					<td align="center" style="padding:3px;background-color: #FFF">
						<c:choose>
							<c:when test="${rptCancel.cancelGubun eq '1'}"><b>[단순위임취소]</b><br/></c:when>
							<c:when test="${rptCancel.cancelGubun eq '2'}"><b>[서면→일반전환건]</b><br/></c:when>
							<c:otherwise></c:otherwise>
						</c:choose>
						${fn:replace(fn:replace(fn:escapeXml(rptCancel.cancelReason) , CRLF , '<br>'), ' ', '&nbsp;')}												
					</td>
				</tr>
			</table>
			

														
		</div>
	</div>	
	
</form>					