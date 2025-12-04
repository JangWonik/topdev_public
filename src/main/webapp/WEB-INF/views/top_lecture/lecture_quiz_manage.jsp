<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script>
	$(document).ready(function () {
		fnQuizSearch();
	});
	
	//테스트 보기
	function doQuizView( p_qkey ){
		
		var sUrl = "lecture_quiz_manage_modal_detail";
		
		var qkeyVal = p_qkey;
		var param = {};
		param.qkey = qkeyVal;		
		
		$.ajax({
			type: "POST",
			url: sUrl,
			data: param,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			timeout: 20000,
			dataType: "HTML", 
			success: function(data){
				$("#quiz-detail-dialog").html();				
				$("#quiz-detail-dialog").html(data);
					$("#quiz-detail-dialog").dialog({
						height: 650,
						width: 800,
						closeOnEscape : true,
						draggable : true,
						title: "테스트 내역 상세",
						buttons:{							
							"닫기" : function(){
								$(this).dialog("close");
							}
						},
						modal: true,
						overlay:{ opacity: 0., background: '#000000'}
					});		
			},
			error: function(e){
			    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
			}
		});
		
	}
	
	//테스트 수정
	function doQuizMod( p_qkey ){
		
		var sUrl = "get_lecture_quiz_info";		
		
		var param = {};
		param.qkey = p_qkey;			
		
		$.ajax({
	        type: "POST",
	        url: sUrl,
	        data: param,		         
	        dataType: "JSON", 
	        success: function(data){	        		
        		//alert(JSON.stringify(data));
        		//alert("data="+data.user_no);
        		
        		//수정폼 설정
        		$("#qkey_val").val(data.qkey);        		
        		$("#quiz_title").val(data.title);
        		$("#quiz_question").val(data.question);
        		$("#quiz_ex1").val(data.ex1);
        		$("#quiz_ex2").val(data.ex2);
        		$("#quiz_ex3").val(data.ex3);
        		$("#quiz_ex4").val(data.ex4);
        		$("#quiz_ex5").val(data.ex5);		
        		$("#quiz_answer").val(data.answer);
        		$("#quiz_is_use").val(data.is_use);
        		$("#quiz_memo").val(data.comment);
        		
    			$("#quiz-action-dialog").dialog({
    				height: 650,
    				width: 800,
    				closeOnEscape : true,
    				draggable : true,
    				appendTo : "#quizActionFrm",
    				title: "테스트 수정",
    				buttons:{
    					"테스트 수정" : function(){
    						var action = fnQuizAction('U');		//수정
    						if (action){
    							$(this).dialog("close");
    						}
    					},
    					"취소" : function(){
    						$(this).dialog("close");
    					}
    				},
    				modal: true,
    				overlay:{ opacity: 0., background: '#000000'}
    			});
    			
    			$("#quiz_answer").select2({
    				dropdownParent: $("#quiz-action-dialog")	
    			});
    			
    			$("#quiz_is_use").select2({
    				dropdownParent: $("#quiz-action-dialog")	
    			});
    			
	        },
	        error: function(e){
	            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
	        }
	    });
	}
	
	//테스트 등록
	function quizAdd(){
		
		//등록폼 초기화
		$("#quiz_title").val('');
		$("#quiz_question").val('');
		$("#quiz_ex1").val('');
		$("#quiz_ex2").val('');
		$("#quiz_ex3").val('');
		$("#quiz_ex4").val('');
		$("#quiz_ex5").val('');		
		$("#quiz_answer option:eq(0)").prop('selected', true);
		$("#quiz_is_use option:eq(0)").prop('selected', true);		
		$("#quiz_memo").val('');		
		
		$("#quiz-action-dialog").dialog({
			height: 650,
			width: 800,
			closeOnEscape : true,
			draggable : true,
			appendTo : "#quizActionFrm",
			title: "테스트 등록",
			buttons:{
				"테스트 등록" : function(){
					var action = fnQuizAction('I');		//등록
					if (action){
						$(this).dialog("close");
					}
				},
				"취소" : function(){
					$(this).dialog("close");
				}
			},
			modal: true,
			overlay:{ opacity: 0., background: '#000000'}
		});
		
		$("#quiz_answer").select2({
			dropdownParent: $("#quiz-action-dialog")	
		});
		
		$("#quiz_is_use").select2({
			dropdownParent: $("#quiz-action-dialog")	
		});
	}
	
	function doQuizDelete( p_qkey, p_title ){
		
		if( confirm( "테스트 명 ' "+p_title+" ' 을(를) 삭제하시겠습니까?" ) ){			
			$("#qkey_val").val( p_qkey );
			fnQuizAction( 'D' );
		}
	}
	
	//테스트 입력값 저장
	function fnQuizAction( action ){
		
		var sUrl = "lecture_quiz_action";
		
		var qkeyVal = $("#qkey_val").val();
		var titleVal = $("#quiz_title").val();
		var questionVal = $("#quiz_question").val();
		var ex1Val = $("#quiz_ex1").val();
		var ex2Val = $("#quiz_ex2").val();
		var ex3Val = $("#quiz_ex3").val();
		var ex4Val = $("#quiz_ex4").val();
		var ex5Val = $("#quiz_ex5").val();
		var answerVal = $("#quiz_answer").val();		
		var isUseVal = $("#quiz_is_use").val();
		var commentVal = $("#quiz_memo").val();
		
		var param = {};
		
		param.action = action;
		param.qkey = qkeyVal;
		param.title = titleVal;
		param.question = questionVal;
		param.ex1 = ex1Val;
		param.ex2 = ex2Val;
		param.ex3 = ex3Val;
		param.ex4 = ex4Val;
		param.ex5 = ex5Val;
		param.answer = answerVal;
		param.is_use = isUseVal;
		param.comment = commentVal;
		
		//등록
		if( action == 'I' || action == 'U' ){
			
			if( titleVal == '' ){
				alert( "테스트 명을 입력해주세요." );
				$("#quiz_title").focus();
				return;
			}
			
			if( questionVal == '' ){
				alert( "질문 내용을 입력해주세요." );
				$("#quiz_question").focus();
				return;
			}
			
			if( ex1Val == '' ){
				alert( "보기1 항목을 입력해주세요." );
				$("#quiz_ex1").focus();
				return;
			}
			
			if( ex2Val == '' ){
				alert( "보기2 항목을 입력해주세요." );
				$("#quiz_ex2").focus();
				return;
			}
			
			if( answerVal == '0' ){
				alert( "정답을 입력해주세요." );
				$("#quiz_answer").focus();
				return;
			}			
		}
		
		$.ajax({
			type: "POST",
   	        url: sUrl,
   	        data: param,
   	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
   	        timeout: 20000,
   	        async: false,
   	        dataType: "html", 
   	        success: function(data){
   	        	if (data == 1){
					alert("테스트 내용을 등록하였습니다.");
					$("#quiz-action-dialog").dialog("close");
	   	        	fnQuizSearch();
   	        	}else if(data == 2){
   	        		alert("테스트 내용을 수정하였습니다.");
   	        		$("#quiz-action-dialog").dialog("close");
   	   	        	fnQuizSearch();
   	        	}else if(data == 9){
   	        		alert("테스트가 삭제되었습니다.");   	        		
   	   	        	fnQuizSearch();
   	        	}
   	        	
   	        },
			error: function(e){
			    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
			}
		});
		
	}
	
	function fnQuizSearch(){
		
		var param = {};
		
		var sUrl = "./getLectureQuizList";			//개별목록가져오기
		
		$.ajax({
    		type: "POST",
    		url: sUrl,
    		data: param,
    		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    		dataType: "html",
    		timeout: 20000,
    		success: function(data){
    			$("#lectureQuizList").html(data);    			
    		},            		
    		error: function (request, status, error) {
    			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
    		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
    		}            		
    	});
		
	}
</script>
<!-- 테스트 등록 폼시작 -->

<form id="quizActionFrm">
	<input type="hidden" id="qkey_val" name="qkey_val"/>		
	<div id="quiz-action-dialog" title="테스트 등록" style="font-size: 15px;display:none;" align="center">
		<br/>
		<div class="tableStyle2" style="width: 750px;">
			<table class="vacation-ins-table">
				<colgroup>
					<col style="width:20%;">
					<col style="width:30%;">
					<col style="width:20%;">
					<col style="width:30%;">					
				</colgroup>
				<tbody>
				<tr>
					<th width="20%"><font color="red">*</font> 테스트 명</th>
					<td colspan="3" style="text-align:left;padding-left: 5px;font-weight:bold;">
						<input type="text" id="quiz_title" name="quiz_title" style="width:580px;"/>
					</td>
				</tr>
				<tr>
					<th width="20%"><font color="red">*</font> 질문 내용</th>
					<td colspan="3" style="text-align:left;padding-left: 5px;font-weight:bold;">
						<input type="text" id="quiz_question" name="quiz_question" style="width:580px;"/>
					</td>
				</tr>
				<tr>
					<th width="20%"><font color="red">*</font> 보기1</th>
					<td colspan="3" style="text-align:left;padding-left: 5px;font-weight:bold;">
						<input type="text" id="quiz_ex1" name="quiz_ex1" style="width:580px;"/>
					</td>
				</tr>
				<tr>
					<th width="20%"><font color="red">*</font> 보기2</th>
					<td colspan="3" style="text-align:left;padding-left: 5px;font-weight:bold;">
						<input type="text" id="quiz_ex2" name="quiz_ex2" style="width:580px;"/>
					</td>
				</tr>
				<tr>
					<th width="20%">보기3</th>
					<td colspan="3" style="text-align:left;padding-left: 5px;font-weight:bold;">
						<input type="text" id="quiz_ex3" name="quiz_ex3" style="width:580px;"/>
					</td>
				</tr>
				<tr>
					<th width="20%">보기4</th>
					<td colspan="3" style="text-align:left;padding-left: 5px;font-weight:bold;">
						<input type="text" id="quiz_ex4" name="quiz_ex4" style="width:580px;"/>
					</td>
				</tr>
				<tr>
					<th width="20%">보기5</th>
					<td colspan="3" style="text-align:left;padding-left: 5px;font-weight:bold;">
						<input type="text" id="quiz_ex5" name="quiz_ex5" style="width:580px;"/>
					</td>
				</tr>
				<tr>
					<th width="20%"><font color="red">*</font> 정답</th>
					<td width="30%">
						<select id="quiz_answer" name="quiz_answer" style="width:200px;text-align:center;">
							<option value="0">- 선택 -</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>														
						</select>
					</td>
					<th width="20%">사용여부</th>
					<td width="30%">
						<select id="quiz_is_use" name="quiz_is_use"style="width:200px;text-align:center;">
							<option value="0">사용</option>
							<option value="1">사용안함</option>																					
						</select>
					</td>
				</tr>
				<tr>
					<th width="20%" height="200">해 설<br/>(오답 선택 시 표시)</th>
					<td colspan="3" align="left" style="text-align:left;padding-left:5px;">
						<textarea rows="12" cols="74" id="quiz_memo" name="quiz_memo"></textarea>
					</td>
				</tr>
				</tbody>																																																		
			</table>
			<div style="text-align:left;padding-left:5px;padding-top:5px;font-size:12px;">
					<font color="red">*</font> 필수 입력 값
				</div>
			</div>
		</div>
	</form>
<!-- 테스트 등록 폼 끝 -->
<!-- 테스트목록 시작 -->
<div id="addQuizButton" style="text-align:right;padding:5px 0 5px 0;">
	<a href="#noloc" class="btn-equipment-save" id="btn-search" onclick='javascript:quizAdd();'>테스트등록</a>
</div>
<!-- 검색창 추가시 사용 -->
<form id="searchFrm" name="searchFrm" method="post"></form>
<div class="tableStyle99">															
	<table>
		<tr>
			<th width="5%">No</th>
			<th width="22%">테스트 명</th><!-- 공통, 물보험본부, 인보험본부 -->
			<th width="22%">질문</th>
			<th width="22%">해설</th>
			<th width="9%">사용여부</th>
			<th width="10%">등록일자</th>
			<th width="10%">기능</th>														
		</tr>		
	</table>
	<div id="lectureQuizList"></div>
</div>
<div id="quiz-detail-dialog" title="테스트 상세 보기" style="font-size: 15px;display:none;" align="center"></div>	
<!-- 교육분류 끝 -->