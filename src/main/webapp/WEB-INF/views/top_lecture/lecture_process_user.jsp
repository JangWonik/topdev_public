<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="./resources/jquery/jquery-ui.min.js"></script>
<script src="./resources/ne_js/calendar.js"></script>
<link href="./resources/select2/select2.min.css" rel="stylesheet" />
<script src="./resources/select2/select2.min.js"></script>
<script>
	$(document).ready(function () {
		//교육과정 목록 불러오기				
		doSearchProcessUser();
	});
	
	//사용자 수강신청
	function userApplyAction(){
		
		var infoMsg = "수강신청 하시겠습니까?";
				
		if( $("#actionType").val() == 'cancel' ){
			infoMsg = "수강신청을 취소하시겠습니까??";
		}
		
		if( !confirm( infoMsg ) ){			
			return;
		}

		var sUrl = "./lectureUserAction";			//수강신청하기
		
		var param = {};
		
		var action_type = $("#actionType").val();
		
		param.pkey = $("#applyPkey").val();
		param.user_comment = $("#user_comment").val();
		param.action_type = $("#actionType").val();		
		
		$.ajax({
 			type : "post",
 			url : sUrl,
 			data : param, 			
 			success : function(result){
 				if( action_type == 'apply' ){
 					alert("수강신청하였습니다.");	
 				}else if( action_type = 'cancel' ){
 					alert("수강신청을 취소하였습니다.");
 				}
 				
 				$("#lecture-user-dialog").dialog("close");
 				doSearchProcessUser();
 			},
 			error: function (request, status, error) {			
 				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
 			}
 		});
	}
	
	function doSearchProcessUser(){
		
		var param = {};
		
		var sUrl = "./getLectureProcessUser";			//수강신청 가능 목록가져오기
		
		$.ajax({
    		type: "POST",
    		url: sUrl,
    		data: param,
    		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    		dataType: "html",
    		timeout: 20000,
    		success: function(data){
    			$("#lectureProcessUserList").html(data);    			
    		},            		
    		error: function (request, status, error) {
    			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
    		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
    		}            		
    	});		
		
	}
	
	function lectureRelationView( p_pkey ){
		
		var url = "./lectureProcessUserModal";
		
		var param = {};
		param.pkey = p_pkey;
		param.view_type = 'info';			//정보보기
		
		$.ajax({
	        type: "POST",
	        url: url,
	        data: param,
	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	        timeout: 20000,
	        dataType: "HTML", 
	        success: function(data){
	        	$("#lecture-user-dialog").html();
	        	$("#lecture-user-dialog").html(data);
				$("#lecture-user-dialog").dialog({
					height: 600,
					width: 900,
					closeOnEscape : true,
					draggable : true,
					title: "교육과정 확인",
					modal: true,
					buttons:{						
						"닫기" : function(){
							$(this).dialog("close");
						}
					},
					overlay:{ opacity: 0., background: '#000000'}
				});		
	        },
	        error: function(e){
	            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
	        }
	    });
	}
	
	function doUserApply( p_pkey, p_title ){
		
		//if( !confirm( p_title+" 과정을 수강신청 하시겠습니까?") ){			
			//return;
		//}
		
		var url = "./lectureProcessUserModal";
		
		var param = {};
		param.pkey = p_pkey;
		param.view_type = 'add';			//신청		
		
		$.ajax({
	        type: "POST",
	        url: url,
	        data: param,
	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	        timeout: 20000,
	        dataType: "HTML", 
	        success: function(data){
	        	$("#lecture-user-dialog").html();
	        	$("#lecture-user-dialog").html(data);
				$("#lecture-user-dialog").dialog({
					height: 600,
					width: 900,
					closeOnEscape : true,
					draggable : true,
					title: "수강신청",
					modal: true,
					buttons:{						
						"닫기" : function(){
							$(this).dialog("close");
						}
					},
					overlay:{ opacity: 0., background: '#000000'}
				});		
	        },
	        error: function(e){
	            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
	        }
	    });		
	}
	
	//수강신청 내역 보기
	function doUserApplyView( p_pkey, ap_state ){		//결재상태 포함
		
		var url = "./lectureProcessUserModal";
				
		var param = {};
		param.pkey = p_pkey;
		param.ap_state = ap_state;		
		
		param.view_type = 'view';			//신청
		
		$.ajax({
	        type: "POST",
	        url: url,
	        data: param,
	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	        timeout: 20000,
	        dataType: "HTML", 
	        success: function(data){
	        	$("#lecture-user-dialog").html();
	        	$("#lecture-user-dialog").html(data);
				$("#lecture-user-dialog").dialog({
					height: 600,
					width: 900,
					closeOnEscape : true,
					draggable : true,
					title: "교육신청",
					modal: true,
					buttons:{						
						"닫기" : function(){
							$(this).dialog("close");
						}
					},
					overlay:{ opacity: 0., background: '#000000'}
				});		
	        },
	        error: function(e){
	            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
	        }
    	});		
	}
	
	//미리보기 동영상 플래이 팝업
	function doPrevewEdu( p_ekey ){		
		
		var viewForm = document.eduPreViewForm;
		
		var url = 'lectureClassPreView';
		window.open('', 'popEduPreView','width=1110,height=868,scrollbars=no,resizable=no,status=yes,menubar=no,toolbar=no,top=50,left=50');		
		viewForm.ekey.value = p_ekey;		
		viewForm.action = url;
		viewForm.method = 'post';
		viewForm.target = 'popEduPreView';
		viewForm.submit();
	}
</script>
<!-- 수강신청 시작 -->

<div class="tableStyle99">															
	<table>
		<tr>
			<th width="5%">No</th>
			<th width="5%">구분</th>
			<th width="6%">분류</th>
			<th width="20%">교육과정 명</th>
			<th width="15%">신청기간</th>
			<th width="15%">교육기간</th>			
			<th width="10%">총 교육시간</th>
			<th width="8%">등록일</th>
			<th width="8%">주제</th>			
			<th width="8%">상태</th>			
		</tr>		
	</table>
	<div id="lectureProcessUserList"></div>
</div>	
<!-- 교육과정 끝 -->
<form id="eduPreViewForm" name="eduPreViewForm">
	<input type="hidden" id="ekey" name="ekey"/>
</form>
<!-- 교육과정 구성Modal -->
<div id="lecture-user-dialog" title="교육과정 구성관리" style="font-size: 12px;" align="center"></div>