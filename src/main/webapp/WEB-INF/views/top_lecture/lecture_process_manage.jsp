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
		doSearchProcess();
		_initCalendar();
		$("#process_category_no_add").select2();
	});
	
	function _initCalendar(){    	 
  		$('.calendar').datepicker({
  			showOn: 'button',
  			buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
  			buttonImageOnly: true,
  			buttonText: "달력", 
  			changeMonth: true,
  			changeYear: true,	    	   
  			showButtonPanel: false,
  			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
  			dayNamesMin: ['일','월','화','수','목','금','토'],
  			dateFormat: 'yy-mm-dd',
  			firstDay: 0,
  			isRTL: false,
  			showMonthAfterYear: true
  	    });  		
  	}
	
	//입력폼 초기화
	function processFormClear(){
		$("#process_team_type_add").val("0");
		$("#process_category_no_add").val("0");
		$("#process_title_add").val("");
		$("#process_apply_sdate_add").val("");
		$("#process_apply_edate_add").val("");
		$("#process_show_sdate_add").val("");
		$("#process_show_edate_add").val("");
		$("#process_isuse_add").val("0");
	}
	
	//과정정보 추가
	function processAdd(){
		processFormClear();
		$("#addProcessButton").hide();
		$("#processAddForm").show();
	}
	
	//과정정보 취소
	function processCancel(){
		processFormClear();
		$("#addProcessButton").show();
		$("#processAddForm").hide();
	}
	
	//과정정보 추가저장
	function processSave(){		
		var addProcessTeamType = $("#process_team_type_add").val(); 
		var addProcessCategoryNo = $("#process_category_no_add").val();
		var addProcessTitle = $("#process_title_add").val(); 
		var addProcessContent = $("#process_content_add").val();
		var addProcessApplySdate = $("#process_apply_sdate_add").val();
		var addProcessApplyEdate = $("#process_apply_edate_add").val();
		var addProcessShowSdate = $("#process_show_sdate_add").val();
		var addProcessShowEdate = $("#process_show_edate_add").val();
		var addProcessIsuse = $("#process_isuse_add").val();
		var addProcessLectureType = $("#process_lecture_type_add").val();
		var addProcessQnaUse = $("#process_qna_use_add").val();
		
		if( !addProcessCategoryNo ){
			alert("분류를 선택해주세요.");
			$("#process_category_no_add").focus();
			return;
		}
		
		if( addProcessTitle == "" ){
			alert("과정명을 입력해주세요.");
			$("#process_title_add").focus();
			return;
		}
		
		if( addProcessContent == "" ){
			alert("과정설명을 입력해주세요.");
			$("#process_content_add").focus();
			return;
		}
		
		if( addProcessApplySdate == "" ){
			alert("수강신청 시작일자를 입력해주세요.");
			$("#process_apply_sdate_add").focus();
			return;
		}
		
		if( addProcessApplyEdate == "" ){
			alert("수강신청 종료일자를 입력해주세요.");
			$("#process_apply_edate_add").focus();
			return;
		}
		
		if( addProcessShowSdate == "" ){
			alert("교육시청 시작일자를 입력해주세요.");
			$("#process_show_sdate_add").focus();
			return;
		}
		
		if( addProcessShowEdate == "" ){
			alert("교육시청 종료일자를 입력해주세요.");
			$("#process_show_edate_add").focus();
			return;
		}
		
		var param = {};
		
		param.action = "I";				//Insert
		param.team_type = addProcessTeamType;
		param.category_no = addProcessCategoryNo;
		param.p_title = addProcessTitle;
		param.p_content = addProcessContent;
		param.apply_sdate = addProcessApplySdate+" 00:00:00";
		param.apply_edate = addProcessApplyEdate+" 23:59:59";
		param.show_sdate = addProcessShowSdate+" 00:00:00";
		param.show_edate = addProcessShowEdate+" 23:59:59";
		param.isuse = addProcessIsuse;		
		param.lecture_type = addProcessLectureType;
		param.qna_use = addProcessQnaUse;
		
		var url = "./lectureProcessAction";			//과정정보 갱신

	    $.ajax({
			type: "POST",
			url: url,
			data: param,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "html",			
			timeout: 20000,
			success: function(data){
				if( data ){		//1인 경우 성공 
					alert("교육 과정정보를 추가하였습니다.");
					processFormClear();
					$("#addProcessButton").show();
					$("#processAddForm").hide();
					doSearchProcess();
				}
			}                
	    });
	}
	
	function doSearchProcess(){
		
		var param = {};
		
		var sUrl = "./getLectureProcess";			//과정목록가져오기		
		
		$.ajax({
    		type: "POST",
    		url: sUrl,
    		data: param,
    		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    		dataType: "html",
    		timeout: 20000,
    		success: function(data){
    			$("#lectureProcessList").html(data);    			
    		},            		
    		error: function (request, status, error) {
    			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
    		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
    		}            		
    	});
		
	}
	
	//과정 수정
	function doProcessModify( p_pkey , p_category_no){		
		$("#process_view_"+p_pkey).hide();
		$("#process_edit_"+p_pkey).show();
		$("#process_category_no_edit_"+p_pkey).select2();	
		$("#process_category_no_edit_"+p_pkey).val(p_category_no).trigger('change');
		_initCalendar();
	}
	
	//정보 수정 취소
	function doProcessEditCancel( p_pkey ){
		$("#process_view_"+p_pkey).show();
		$("#process_edit_"+p_pkey).hide();
	}
	
	//정보 수정 저장
	function doProcessEditSave( p_pkey ){
		var param = {};		
		
		param.action = "U";				//Update
		param.pkey = p_pkey;		
		param.team_type = $("#process_team_type_edit_"+p_pkey).val();
		param.category_no = $("#process_category_no_edit_"+p_pkey).val();
		param.lecture_type = $("#process_lecture_type_edit_"+p_pkey).val();
		param.p_title = $("#process_p_title_edit_"+p_pkey).val();
		param.p_content = $("#process_p_content_edit_"+p_pkey).val();
		param.apply_sdate = $("#process_apply_sdate_edit_"+p_pkey).val()+" 00:00:00";
		param.apply_edate = $("#process_apply_edate_edit_"+p_pkey).val()+" 23:59:59";
		param.show_sdate = $("#process_show_sdate_edit_"+p_pkey).val()+" 00:00:00";
		param.show_edate = $("#process_show_edate_edit_"+p_pkey).val()+" 23:59:59";
		param.isuse = $("#process_isuse_edit_"+p_pkey).val();
		param.qna_use = $("#process_qna_use_edit_"+p_pkey).val();
		
		//alert(param.action+" : "+param.category_name+" : "+param.category_ord+" : "+param.category_isuse);
		//return;
		
		var url = "./lectureProcessAction";

	    $.ajax({
			type: "POST",
			url: url,
			data: param,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "html",			
			timeout: 20000,
			success: function(data){
				if( data ){		//1인 경우 성공 
					alert("정보를 수정하였습니다.");
					doSearchProcess();
				}
			}                
	    });
	}
	
	//정보 삭제	
	function doProcessDelete( p_pkey , p_subject ){
		
		if( !confirm( p_subject+" 과정을 삭제하시겠습니까?") ){
			return;
		}		
		
		var param = {};		
		
		param.action = "D";				//Delete
		param.pkey = p_pkey;		
				
		var url = "./lectureProcessAction";

	    $.ajax({
			type: "POST",
			url: url,
			data: param,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "html",			
			timeout: 20000,
			success: function(data){
				if( data ){		//1인 경우 성공 
					alert("과정정보를 삭제하였습니다.");					
					doSearchProcess();
				}
			}                
	    });
	}
	
	//교육 과정에 교육등록하는 layer
	function updateLectureRelation( p_pkey ){		
		
		var url = "./lectureProcessModal";
		var param = {};
		param.pkey = p_pkey;	
		param.view_type = 'view';
		
		$.ajax({
	        type: "POST",
	        url: url,
	        data: param,
	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	        timeout: 20000,
	        dataType: "HTML", 
	        success: function(data){
	        	$("#lecture-process-dialog").html();
	        	$("#lecture-process-dialog").html(data);
				$("#lecture-process-dialog").dialog({
					height: 600,
					width: 900,
					closeOnEscape : true,
					draggable : true,
					title: "교육과정 구성하기",
					modal: true,
					buttons:{
						"저장하기" : function(){
							if (!confirm("선택한 교육로 과정을 구성하시겠습니까?")){
								return;
							}							
							fnLetureRelationSave();
							$(this).dialog("close");							
						},
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
	
	//교육정보 우측이동
	function fnNext(){
		$("#sourceLectureList option:selected").each(function(){
			$(this).appendTo("#targetLectureList");
		});
	}
	
	//교육정보 좌측이동
	function fnPrev(){
		$("#targetLectureList option:selected").each(function(){
			$(this).appendTo("#sourceLectureList");
		});
	}
	
	//교육과정 내 과정정보 저장
	function fnLetureRelationSave(){
		
		//저장대상을 모두 selected 처리한다.		
		$("#targetLectureList option").prop('selected',true);
		
		var formData = $("#targetLectureForm").serialize();
		
		$.ajax({
 			type : "post",
 			url : "/lectureRelationAction",
 			data : formData,
 			traditional: true,						//배열허용
 			success : function(result){			
 				alert("교육과정이 저장되었습니다.");
 				doSearchProcess();
 			},
 			error: function (request, status, error) {			
 				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
 			}
 		});
		
	}
</script>
<!-- 교육과정 시작 -->
<div id="addProcessButton" style="text-align:right;padding:5px 0 5px 0;">
	<a href="#noloc" class="btn-equipment-save" id="btn-search" onclick='javascript:processAdd();'>교육과정등록</a>
</div>
<div class="tableStyle99" id="processAddForm" style="display:none;padding-bottom:5px;">
	<table>
		<tr>			
			<th width="8%">구분</th>
			<th width="15%">분류</th>
			<th width="18%">교육과정 명</th>
			<th width="20%">신청기간</th>						
			<th width="9%">과정 사용여부</th>
			<th width="10%"> - </th>			
		</tr>
		<tr>
			<td align="center">
				<select id="process_team_type_add" name="process_team_type_add" style="width:110px;">
					<option value="0">공통</option>
					<option value="1">물보험</option>
					<option value="4">인보험</option>
				</select>
			</td>
			<td style="padding-left:5px;">				
				<select id="process_category_no_add" name="process_category_no_add" style="width: 220px;">
					<option value="">- 전체 -</option>
					<c:forEach items="${selCategoryList}" var="categoryVo">
						<option value="${categoryVo.ckey}" >${categoryVo.category_name}</option>
					</c:forEach>
				</select>
			</td>
			<td style="padding-left:5px;">
				<input type="text" id="process_title_add" name="process_title_add" style="width:270px;"/>
			</td>
			<td align="center">
				<input type="text" class="calendar" id="process_apply_sdate_add" name="process_apply_sdate_add" style="width:100px;"/> ~ 
				<input type="text" class="calendar" id="process_apply_edate_add" name="process_apply_edate_add" style="width:100px;"/>
			</td>			
			<td align="center">
				<select id="process_isuse_add" name="process_isuse_add" style="width:110px;">
					<option value="0">사용</option>
					<option value="1">미사용</option>					
				</select>
			</td>
			<td align="center" rowspan="3">
				<a href="#noloc" class="btn-equipment-save-s" id="btn-search" onclick='javascript:processSave();'>저장</a>
				<a href="#noloc" class="btn-equipment-cancel-s" id="btn-search" onclick='javascript:processCancel();'>취소</a>
			</td>			
		</tr>
		<tr>
			<th>교육구분</th>
			<th colspan="2">과정설명</th>
			<th>교육기간</th>
			<th>Q&A 사용여부</th>
		</tr>
		<tr>
			<td align="center">
				<select id="process_lecture_type_add" name="process_lecture_type_add" style="width:110px;">
					<option value="0">상시교육</option>
					<option value="1">의무교육</option>					
				</select>
			</td>
			<td style="padding-left:5px;" colspan="2">
				<input type="text" id="process_content_add" name="process_content_add" style="width:505px;"/>
			</td>
			<td align="center">
				<input type="text" class="calendar" id="process_show_sdate_add" name="process_show_sdate_add" style="width:100px;"/> ~ 
				<input type="text" class="calendar" id="process_show_edate_add" name="process_show_edate_add" style="width:100px;"/>
			</td>
			<td align="center">
				<select id="process_qna_use_add" name="process_qna_use_add" style="width:110px;">
					<option value="0">미사용</option>
					<option value="1">사용</option>					
				</select>
			</td>
		</tr>
	</table>	
</div>

<div class="tableStyle99">															
	<table>
		<tr>
			<th width="5%">No</th>
			<th width="5%">교육구분</th>
			<th width="5%">구분</th>
			<th width="12%">분류</th>
			<th width="15%">교육과정 명</th>
			<th width="10%">신청기간</th>
			<th width="10%">교육기간</th>
			<th width="8%">등록자</th>
			<th width="8%">등록일</th>
			<th width="6%">주제</th>
			<th width="6%">사용여부<br/>(과정/Q&A)</th>
			<th width="10%"> - </th>
		</tr>		
	</table>
	<div id="lectureProcessList"></div>
</div>	
<!-- 교육과정 끝 -->
<!-- 교육과정 구성Modal -->
<div id="lecture-process-dialog" title="교육과정 구성관리" style="font-size: 12px;" align="center"></div>