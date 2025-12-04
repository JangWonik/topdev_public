<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script>
	$(document).ready(function () {
		//주제정보 목록 불러오기
		doSearchInfo();
	});
	
	//입력폼 초기화
	function infoFormClear(){
		$("#info_team_type_add").val("0");
		$("#info_subject_add").val("");
		$("#info_introduce_add").val("");
		$("#info_time_second_add").val("");
		$("#info_manager_name_add").val("");
		$("#info_link_path_add").val("");
		$("#info_attach_file_add").val("");
	}
	
	//정보명 추가
	function infoAdd(){
		infoFormClear();
		$("#addInfoButton").hide();
		$("#infoAddForm").show();
	}
	
	//정보명추가취소
	function infoCancel(){
		infoFormClear();
		$("#addInfoButton").show();
		$("#infoAddForm").hide();
	}
	
	//교육정보 추가저장
	function infoSave(){		
		var addInfoTeamType = $("#info_team_type_add").val(); 
		var addInfoSubject = $("#info_subject_add").val();
		var addInfoIntroduce = $("#info_introduce_add").val(); 
		var addTimesecond = $("#info_time_second_add").val();
		var addManagername = $("#info_manager_name_add").val();
		var addLinkpath = $("#info_link_path_add").val();
		var addPreviewFlag = 0;					//미리보기 사용여부
		
		if( $("#info_preview_flag_add").is(":checked") ){			//true : 사용, false: 미사용
			addPreviewFlag = 1;
		}else{
			addPreviewFlag = 0;
		}		
		
		if( addInfoSubject == "" ){
			alert("주제를 입력해주세요.");
			$("#info_subject_add").focus();
			return;
		}
		
		if( addTimesecond == "" ){
			alert("주제 시간을 입력해주세요. (기준 : 초)");
			$("#info_time_second_add").focus();
			return;
		}
		
		if( isNaN(addTimesecond) ){
			alert("주제 시간은 숫자로입력해주세요. (0~9999)");
			$("#info_time_second_add").focus();
			return;
		}
		
		if( addManagername == "" ){
			alert("주제 담당자를 입력해주세요");
			$("#info_manager_name_add").focus();
			return;
		}
		
		if( addLinkpath == "" ){
			alert("주제 링크정보를 입력해주세요.");
			$("#info_link_path_add").focus();
			return;
		}
		
		var param = new FormData();
		
		param.append("action", "I");
		param.append("team_type", addInfoTeamType);
		param.append("subject", addInfoSubject);
		param.append("manager_name", addManagername);
		param.append("introduce", addInfoIntroduce);
		param.append("link_path", addLinkpath);
		param.append("time_second", addTimesecond);
		param.append("attath_file", $('#info_attach_file_add')[0].files[0]);
		param.append("preview_flag", addPreviewFlag);
		
		var url = "./lectureInfoAction";			//교육정보 갱신

	    $.ajax({
			type: "POST",
	        url: url,
	        data: param,
	        timeout: 20000,
	        processData: false,
	        contentType: false,
	        dataType: "JSON",
			success: function(data){
				if( data ){		//1인 경우 성공 
					alert("교육 정보를 추가하였습니다.");
					infoFormClear();
					$("#addInfoButton").show();
					$("#infoAddForm").hide();
					doSearchInfo();
				}
			}                
	    });
	}
	
	//관리자 주제(동영상) 보기
	function doInfoView( p_ekey ){		
		
		var viewForm = document.eduViewManageForm;		
		
		var url = 'lectureClassManagerView';
		window.open('', 'popEduView','width=1920,height=1080,scrollbars=no,resizable=yes,status=yes,menubar=no,toolbar=no,top=50,left=50');
		viewForm.ekey.value = p_ekey;
		viewForm.action = url;
		viewForm.method = 'post';
		viewForm.target = 'popEduView';
		viewForm.submit();
	}
	
	function doSearchInfo(){
		
		var param = {};
		
		var sUrl = "./getLectureInfo";			//개별목록가져오기
		
		$.ajax({
    		type: "POST",
    		url: sUrl,
    		data: param,
    		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    		dataType: "html",
    		timeout: 20000,
    		success: function(data){
    			$("#lectureInfoList").html(data);    			
    		},            		
    		error: function (request, status, error) {
    			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
    		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
    		}            		
    	});
		
	}
	
	//정보 수정
	function doInfoModify( p_ekey ){
		$("#info_view_"+p_ekey).hide();
		$("#info_edit_"+p_ekey).show();
	}
	
	//정보 수정 취소
	function doInfoEditCancel( p_ekey ){
		$("#info_view_"+p_ekey).show();
		$("#info_edit_"+p_ekey).hide();
	}
	
	//정보 수정 저장
	function doInfoEditSave( p_ekey ){		
		
		var editPreviewFlag = 0;					//미리보기 사용여부
		
		if( $("#info_preview_flag_edit_"+p_ekey).is(":checked") ){			//true : 사용, false: 미사용
			editPreviewFlag = 1;
		}else{
			editPreviewFlag = 0;
		}
		
		var param = new FormData();
		
		param.append("action", "U");
		param.append("ekey", p_ekey);
		param.append("team_type", $("#info_team_type_edit_"+p_ekey).val());
		param.append("subject", $("#info_subject_edit_"+p_ekey).val());		
		param.append("introduce", $("#info_introduce_edit_"+p_ekey).val());
		param.append("link_path", $("#info_link_path_edit_"+p_ekey).val());
		param.append("time_second", $("#info_time_second_edit_"+p_ekey).val());
		param.append("manager_name", $("#info_manager_name_edit_"+p_ekey).val());
		param.append("preview_flag", editPreviewFlag);
		
		var temp_attach_file = $('#info_attach_file_edit_'+p_ekey).val();
		
		if( temp_attach_file ){
			param.append("attath_file", $('#info_attach_file_edit_'+p_ekey)[0].files[0]);
		}
		
		var url = "./lectureInfoAction";

	    $.ajax({
			type: "POST",
			url: url,
			data: param,
			timeout: 20000,
			processData: false,
			contentType: false,
			dataType: "JSON",
			success: function(data){
				if( data ){		//1인 경우 성공 
					alert("정보를 수정하였습니다.");
					doSearchInfo();
				}
			}                
	    });
	}
	
	//정보 삭제	
	function doInfoDelete( p_ekey , p_subject ){
		
		if( !confirm( p_subject+" 교육를 삭제하시겠습니까?") ){
			return;
		}		
		
		var param = {};		
		
		param.action = "D";				//Delete
		param.ekey = p_ekey;		
				
		var url = "./lectureInfoAction";

	    $.ajax({
			type: "POST",
			url: url,
			data: param,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "html",			
			timeout: 20000,
			success: function(data){
				if( data ){		//1인 경우 성공 
					alert("정보를 삭제하였습니다.");					
					doSearchInfo();
				}
			}                
	    });
	}
	
	//첨부파일 삭제
	function doAttachDelete( p_ekey , p_filename){
		if( !confirm( p_filename+" 첨부된 파일을 삭제하시겠습니까?") ){
			return;
		}		
		
		var param = {};		
		
		param.action = "DF";				//첨부파일만 삭제하는 경우
		param.ekey = p_ekey;		
				
		var url = "./lectureInfoAction";

	    $.ajax({
			type: "POST",
			url: url,
			data: param,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "html",			
			timeout: 20000,
			success: function(data){
				if( data ){		//1인 경우 성공 
					alert("정보를 삭제하였습니다.");					
					doSearchInfo();
				}
			}                
	    });
	}
	
	//주제 내 테스트 추가
	function updateLectureQuizRelation( p_ekey ){
		
		var url = "./lectureQuizRelationModal";
		
		var param = {};
		param.ekey = p_ekey;	
		param.view_type = 'view';
		
		$.ajax({
	        type: "POST",
	        url: url,
	        data: param,
	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	        timeout: 20000,
	        dataType: "HTML", 
	        success: function(data){
	        	//lecture-process-dialog
	        	$("#lecture-quiz-dialog").html();
	        	$("#lecture-quiz-dialog").html(data);
				$("#lecture-quiz-dialog").dialog({
					height: 600,
					width: 900,
					closeOnEscape : true,
					draggable : true,
					title: "주제 내 테스트 구성하기",
					modal: true,
					buttons:{
						"저장하기" : function(){
							if (!confirm("선택한 테스트로 주제를 구성하시겠습니까?")){
								return;
							}							
							fnLetureRelationQuizSave();							
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
	
	//교육 테스트 정보 우측이동
	function fnQuizNext(){
		$("#sourceLectureQuizList option:selected").each(function(){
			$(this).appendTo("#targetLectureInfoList");
		});
	}
	
	//교육테스트 정보 좌측이동
	function fnQuizPrev(){
		$("#targetLectureInfoList option:selected").each(function(){
			$(this).appendTo("#sourceLectureQuizList");
		});
	}
	
	//교육주제 내 테스트정보 저장
	function fnLetureRelationQuizSave(){
		
		//저장대상을 모두 selected 처리한다.		
		$("#targetLectureInfoList option").prop('selected',true);
		
		var formData = $("#targetLectureInfoForm").serialize();
		
		$.ajax({
 			type : "post", 			
 			url : "/lectureRelationQuizAction",
 			data : formData,
 			traditional: true,						//배열허용
 			success : function(result){			
 				alert("교육주제 내 테스트 정보가 저장되었습니다.");
 				doSearchInfo();
 			},
 			error: function (request, status, error) {			
 				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
 			}
 		});
		
	}
	
</script>
<!-- 교육정보 시작 -->
<div id="addInfoButton" style="text-align:right;padding:5px 0 5px 0;">
	<a href="#noloc" class="btn-equipment-save" id="btn-search" onclick='javascript:infoAdd();'>주제정보등록</a>
</div>
<div class="tableStyle99" id="infoAddForm" style="display:none;padding-bottom:5px;">
	<table>
		<tr>			
			<th width="7%">구분</th>
			<th width="15%">주제</th>
			<th width="15%">개요</th>
			<th width="10%">교육시간(초)</th>
			<th width="8%">강사</th>
			<th width="10%">링크주소</th>
			<th width="10%">첨부파일</th>
			<th width="6%">미리보기</th>			
			<th width="9%">-</th>
		</tr>				
		<tr>
			<td align="center">
				<select id="info_team_type_add" name="info_team_type_add" style="width:80px;">
					<option value="0">공통</option>
					<option value="1">물보험</option>
					<option value="4">인보험</option>
				</select>
			</td>
			<td style="padding-left:5px;">
				<input type="text" id="info_subject_add" name="info_subject_add" style="width:190px;"/>
			</td>
			<td style="padding-left:5px;">
				<input type="text" id="info_introduce_add" name="info_introduce_add" style="width:190px;"/>
			</td>
			<td align="center">
				<input type="text" id="info_time_second_add" name="info_time_second_add" style="width:80px;"/> 초
			</td>
			<td align="center">
				<input type="text" id="info_manager_name_add" name="info_manager_name_add" style="width:100px;"/>
			</td>
			<td align="center">
				<input type="text" id="info_link_path_add" name="info_link_path_add" style="width:120px;"/>
			</td>
			<td align="center">
				<input type="file" id="info_attach_file_add" name="info_attach_file_add" style="width: 90%;">
			</td>
			<td align="center">사용
				<input type="checkbox" id="info_preview_flag_add" name="info_preview_flag_add" />
			</td>
			<td align="center">
				<a href="#noloc" class="btn-equipment-save-s" id="btn-search" onclick='javascript:infoSave();'>저장</a>
				<a href="#noloc" class="btn-equipment-cancel-s" id="btn-search" onclick='javascript:infoCancel();'>취소</a>
			</td>			
		</tr>		
	</table>	
</div>

<div class="tableStyle99">
	<table>
		<tr>
			<th width="5%">No</th>
			<th width="4%">구분</th>
			<th width="13%">주제</th>
			<th width="13%">개요</th>
			<th width="7%">교육시간(초)</th>
			<th width="7%">강사</th>
			<th width="9%">링크주소</th>
			<th width="8%">등록일</th>			
			<th width="13%">첨부파일</th>
			<th width="3%">
				<img src="/resources/cmm/images/preview.png" title="미리보기"/>
			</th>
			<th width="6%">테스트</th>
			<th width="15%">-</th>
		</tr>		
	</table>
	<div id="lectureInfoList"></div>
</div>	
<!-- 교육분류 끝 -->
<form id="eduViewManageForm" name="eduViewManageForm">
	<input type="hidden" id="ekey" name="ekey"/>
</form>
<!-- 교육과정 구성Modal -->
<div id="lecture-quiz-dialog" title="주제 테스트 구성관리" style="font-size: 12px;" align="center"></div>