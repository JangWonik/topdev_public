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





