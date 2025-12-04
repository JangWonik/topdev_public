<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script>
	$(document).ready(function () {		
		//목록 새로고침
		doRefleshAll();
	});
	
	function doRefleshAll(){
		doSearchApprovalList(1);
		doSearchApprovalResultList(1);
		doSearchApprovalAllList(1);
	}
	
	//교육 대상 목록 불러오기
	function doSearchApprovalList( pageIdx ){
		
		var param = {};
		
		param.ap_state = '10';			//결재 대기상태인 목록만 가져오기
		param.view_type = 'list';
		param.pageIdx = pageIdx;
		
		var sUrl = "./getLectureApprovalList";
		
		$.ajax({
    		type: "POST",
    		url: sUrl,
    		data: param,
    		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    		dataType: "html",
    		timeout: 20000,    		         
    		success: function(data){    			
    			$("#lectureApprovalList").html(data);    			
    		},            		
    		error: function (request, status, error) {
    			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
    		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
    		}            		
    	});		
	}
	
	//결재완료 목록 불러오기
	function doSearchApprovalResultList( pageIdx ){
		
		var param = {};
		
		param.view_type = 'result';			//결재 결과 페이지
		param.ap_state = '11,12';			//결재 대기상태인 목록만 가져오기
		param.pageIdx = pageIdx;
		
		var sUrl = "./getLectureApprovalList";
		
		$.ajax({
    		type: "POST",
    		url: sUrl,
    		data: param,
    		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    		dataType: "html",
    		timeout: 20000,    		         
    		success: function(data){    			
    			$("#lectureApprovalResultList").html(data);    			
    		},            		
    		error: function (request, status, error) {
    			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
    		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
    		}            		
    	});		
	}
	
	//결재전체 목록 불러오기
	function doSearchApprovalAllList( pageIdx ){
		
		var param = {};
		param.view_type = 'all';
		param.pageIdx = pageIdx;
		
		var sUrl = "./getLectureApprovalList";		
		
		$.ajax({
    		type: "POST",
    		url: sUrl,
    		data: param,
    		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    		dataType: "html",
    		timeout: 20000,    		         
    		success: function(data){    			
    			$("#lectureApprovalAllList").html(data);    			
    		},            		
    		error: function (request, status, error) {
    			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
    		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
    		}            		
    	});		
	}
	
	//결재하기
	function doApproval( p_akey ){
		
		var url = "./lectureApprovalManagerModal";
		
		var param = {};
		param.akey = p_akey;
		param.view_type = 'info';			//정보보기
		
		$.ajax({
	        type: "POST",
	        url: url,
	        data: param,
	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	        timeout: 20000,
	        dataType: "HTML", 
	        success: function(data){
	        	$("#lecture-manager-dialog").html();
	        	$("#lecture-manager-dialog").html(data);
				$("#lecture-manager-dialog").dialog({
					height: 600,
					width: 900,
					closeOnEscape : true,
					draggable : true,
					title: "수강신청 결재하기",
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
	
	//상세보기
	function doApprovalView( p_akey ){
		
		var url = "./lectureApprovalManagerModal";
		
		var param = {};
		param.akey = p_akey;
		param.view_type = 'view';			//상세보기
		
		$.ajax({
	        type: "POST",
	        url: url,
	        data: param,
	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	        timeout: 20000,
	        dataType: "HTML", 
	        success: function(data){
	        	$("#lecture-manager-dialog").html();
	        	$("#lecture-manager-dialog").html(data);
				$("#lecture-manager-dialog").dialog({
					height: 600,
					width: 900,
					closeOnEscape : true,
					draggable : true,
					title: "결재정보 조회하기",
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
	
	//관리자 결재 또는 반려
	function managerAprovalAction(){
		
		var sUrl = "./lectureManagerAction";			//수강신청 결재하기
		
		if( $("#actionType").val() == 'reject' && $("#ap_comment").val() == '' ){
			alert('반려시에는 의견을 입력해야합니다.');
			$("#ap_comment").focus();
			return;
		}
		
		//취소시 재확인 필요
		if( $("#actionType").val() == 'cancel' ){
			if( !confirm('결재를 취소하시겠습니까?') ){
				return;
			}
		}
		
		var param = {};
		
		var action_type = $("#actionType").val();
		
		param.akey = $("#applyAkey").val();
		param.ap_comment = $("#ap_comment").val();
		param.action_type = $("#actionType").val();		
		
		$.ajax({
 			type : "post",
 			url : sUrl,
 			data : param, 			
 			success : function(data){
 				
 				var sRet = data.action_type; 				
 				
 				if( sRet == 'confirm' ){
 					alert("수강신청을 결재하였습니다.");	
 				}else if( sRet == 'reject' ){
 					alert("수강신청을 반려하였습니다.");
 				}else if( sRet == 'cancel' ){
 					alert("결재를 취소하였습니다.");
 				}
 				
 				$("#lecture-manager-dialog").dialog("close");
 				//목록 새로고침
 				doRefleshAll(); 				
 			},
 			error: function (request, status, error) {			
 				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
 			}
 		});
		
	}
	
	//결재 대상 목록 페이징
	function fnGoPageList( pageIdx ){
		doSearchApprovalList(pageIdx);
	}
	
	//결재 완료 목록 페이징
	function fnGoPageResult( pageIdx ){
		doSearchApprovalResultList(pageIdx);
	}
	
	//결재 결과 목록 페이징
	function fnGoPageAll( pageIdx ){
		doSearchApprovalAllList(pageIdx);
	}
</script>
<!-- 결재 대상 검색 시작 -->

<!-- 결재 대상 검색 종료 -->

<!-- 결재 대상건 조회 시작 -->
<div class="tableStyle99">															
	<table>
		<tr>
			<th width="6%">No</th>
			<th width="12%">센터명</th>
			<th width="12%">부서명</th>
			<th width="10%">신청자</th>
			<th width="16%">교육과정 명</th>
			<th width="8%">신청일</th>
			<th width="14%">시청기간</th>
			<th width="14%">신청사유</th>			
			<th width="8%"> - </th>			
		</tr>
	</table>
	<div id="lectureApprovalList"></div>
</div>
<!-- 결재 대상건 조회 끝 -->
<!-- 교육과정 구성Modal -->
<div id="lecture-manager-dialog" title="수강신청결재" style="font-size: 12px;" align="center"></div>