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
		//결재완료된 교육과정 가져오기				
		//doSearchProcessUser();
		doSearchConfirmUser();
	});
	
	//결재완료된 교육 과정 가져오기
	function doSearchConfirmUser(){
		
		var param = {};
		
		var sUrl = "./getLectureRoomUser";			//수강신청 후 결재완료된 목록가져오기
		
		$.ajax({
    		type: "POST",
    		url: sUrl,
    		data: param,
    		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    		dataType: "html",
    		timeout: 20000,
    		success: function(data){    			
    			$("#lectureUserRootList").html(data);    			
    		},            		
    		error: function (request, status, error) {
    			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
    		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
    		}            		
    	});		
	}		
	
	//
	function doProcessView( p_pkey ){
		
		var url = "./lectureShowUserModal";		
		
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
	        	$("#lecture-room-dialog").html();
	        	$("#lecture-room-dialog").html(data);
				$("#lecture-room-dialog").dialog({
					height: 600,
					width: 1024,
					closeOnEscape : true,
					draggable : true,
					title: "교육과정",
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
	
	//동영상 플레이 팝업
	function doShowEdu( p_ekey ){
		
		var viewForm = document.eduModalViewForm;		
		
		var url = 'lectureClassView';

		window.open('', 'popEduView','width=1920,height=1080,scrollbars=no,resizable=no,status=yes,menubar=no,toolbar=no,top=50,left=50');
		viewForm.ekey.value = p_ekey;
		viewForm.action = url;
		viewForm.method = 'post';
		viewForm.target = 'popEduView';
		viewForm.submit();			
	}
</script>
<!-- 교육시청 목록시작 -->

<div class="tableStyle99">															
	<table>
		<tr>
			<th width="5%">No</th>
			<th width="8%">상태</th>
			<th width="5%">구분</th>
			<th width="10%">분류</th>
			<th width="20%">교육과정 명</th>			
			<th width="18%">교육기간</th>
			<th width="10%">총 교육시간</th>
			<th width="16%">진행률</th>
			<th width="8%">-</th>			
		</tr>	
	</table>
	<div id="lectureUserRootList"></div>
</div>	
<!-- 교육과정 끝 -->
<!-- 교육과정 입장 Modal -->
<div id="lecture-room-dialog" title="강의실 입장하기" style="font-size: 12px;" align="center"></div>
<!-- 교육시청하기 폼 -->
<form id="eduModalViewForm" name="eduModalViewForm">
	<input type="hidden" id="ekey" name="ekey"/>
</form>
<!-- <form id="eduViewForm" name="eduViewForm">
	<input type="hidden" id="ekey" name="ekey"/>
</form> -->