<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

	<link rel="stylesheet" href="./resources/jquery/jquery-ui.css">
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/jquery/jquery-ui.js"></script>
	<script>
		var dialog;
		$(document).ready(function(){
	
			$.ajaxSetup({cache:false});

			$("#searchResultTable").hide();

			//update form start
			dialog = $("#dialog-form").dialog({
				autoOpen: false,
				height: 300,
				width: 350,
				modal: true
			});
			//update form end

			//최초 조회 시작
			$.post("./boardMemoList",
					{	targetStr:$("#targetStr").val()
						,linkNo:$("#linkNo").val()
					},
					function(data,status){
						if(status == "success"){
							if(data.length > 0){
								$("#searchResultTable").show();
			                    $.each(data, function(index, entry) {
	                        		$("#memoTbody").append('<tr>'
											+"<td align='center'>"+entry.userNm+"</td>"
											+"<td style='text-align:left;padding-left:5px;'>"+entry.mContents+"</td>"
											+"<td align='center'>"+entry.regDate+"</td>"
											+"<td align='center'><img src='./resources/ls_img/ls_memo/btn_s_edite.gif' id='editBtn"+index+"' style='cursor:pointer;' /></td>"
											+"<td align='center'><img src='./resources/ls_img/ls_memo/btn_s_del.gif' id='delBtn"+index+"' style='cursor:pointer;' /></td>"
	                                		+ '</tr>'
		   							);
	                        		$("#editBtn"+index).bind("click",function(){
	                        			//alert($(this).parent().parent().children().eq(1).text());
	                        			memoUpdateForm(entry.userNo, entry.memoNo, entry.userNm, $(this).parent().parent().children().eq(1).html(), entry.regDate, $(this).parent().parent().index());
	                        		});
	                        		$("#delBtn"+index).bind("click",function(){
	                        			memoDelete(entry.userNo, entry.memoNo, $(this).parent().parent().index());
	                        		});
								});//each
							}//if(data.length > 0){
						}else{
							alert("답변 불러오기를 실패하였습니다. 잠시 후 다시 시도해 주세요.");
						}
					},"json"
			);//post
			//최초 조회 끝

			//메모 등록 시작
			$("#memoWrite").click(function(){
				if($("#memoArea").val().trim() == ""){
					return;
				}
				$.post("./boardMemoWrite",
						{	targetStr:$("#targetStr").val()
							,linkNo:$("#linkNo").val()
							,mContents:$("#memoArea").val()
						},
						function(data,status){
							if(status == "success"){
								if(data.length == 0){
									alert("답변 등록을 실패 하였습니다.");
								}else{
									$("#searchResultTable").show();
									var tmpVar = $("#memoTbody").children().last().index()+1;
				                    $.each(data, function(index, entry) {
		                        		$("#memoTbody").append('<tr>'
												+"<td align='center'>"+entry.userNm+"</td>"
												+"<td align='center' style='text-align:left;padding-left:5px;'>"+entry.mContents+"</td>"
												+"<td align='center'>"+entry.regDate+"</td>"
												+"<td align='center'><img src='./resources/ls_img/ls_memo/btn_s_edite.gif' id='editBtn"+tmpVar+"' style='cursor:pointer;' /></td>"
												+"<td align='center'><img src='./resources/ls_img/ls_memo/btn_s_del.gif' id='delBtn"+tmpVar+"' style='cursor:pointer;' /></td>"
		                                		+ '</tr>'
			   							);
		                        		$("#editBtn"+tmpVar).bind("click",function(){
		                        			memoUpdateForm(entry.userNo, entry.memoNo, entry.userNm, $(this).parent().parent().children().eq(1).html(), entry.regDate, $(this).parent().parent().index());
		                        		});
		                        		$("#delBtn"+tmpVar).bind("click",function(){
		                        			memoDelete(entry.userNo, entry.memoNo, $(this).parent().parent().index());
		                        		});
									});//each
									$("#memoArea").val("");
									alert("답변이 입력되었습니다.");
								}//if(data.length == 0){
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						},"json"
				);//post

			});//$("#memoWrite").click
			//메모 등록 끝

			//메모 수정 start
			$("#memoUpdateBtn").click(function(){
				if($("#mcon").val().trim() == ""){
					alert("답변 내용을 확인 후 저장해주세요.");
					$("#mcon").focus();
					return;
				}
				$.post("./boardMemoUpdate",
						{	targetStr:$("#targetStr").val()
							,memoNo:$("#mno").val()
							,mContents:$("#mcon").val()
						},
						function(data,status){
							if(status == "success"){
								if(data.length == 0){
									alert("답변 수정을 실패 하였습니다.");
								}else{
									$("#memoTbody").children().eq($("#idx").val()).children().eq(1).html($("#mcon").text().replace(/\n/g,'<br>'));
									$("#idx").val('');
									$("#mno").val('');
									$("#unm").text('');
									$("#rdate").text('');
									$("#mcon").text('');
									dialog.dialog("close");
									location.reload();
								}//if(data.length == 0){
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			});
			//메모 수정 end

		});//$(document).ready

		//메모 삭제 start
		function memoDelete(userNo, memoNo, index){
			if('${mbrVo_Session.user_no}' != userNo){
				alert("답변은 작성하신 당사자만이 삭제 가능합니다.");
				return;
			}

			var tmp = window.confirm("답변을 삭제 하시겠습니까?");
			if(tmp == false){
				return;
			}else if(tmp == true){
				$.post("./boardMemoDelete",
						{	targetStr:$("#targetStr").val()
							,memoNo:memoNo
						},
						function(data,status){
							if(status == "success"){
								if(data.length == 0){
									alert("답변 삭제를 실패 하였습니다.");
								}else{
									$("#memoTbody").children().eq(index).remove();
								}//if(data.length == 0){
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			}
		}
		//메모 삭제 end

		//update form open start
		function memoUpdateForm(userNo, memoNo, userNm, mContents, regDate, index){
			if('${mbrVo_Session.user_no}' != userNo){
				alert("답변은 작성하신 당사자만이 수정 가능합니다.");
				return;
			}

			$("#idx").val(index);
			$("#mno").val(memoNo);
			$("#unm").text(userNm);
			$("#rdate").text(regDate);
			$("#mcon").val(mContents.replace(/<br>/g,'\r'));
			dialog.dialog("open");
		}
		//update form open end
	</script>
	<style>
		.btn-vacation-aprv {
			font-weight:bold;
			text-decoration:none;
			font-family:Arial;
			text-indent:0px;
			line-height:0px;
			-moz-border-radius:5px;
			-webkit-border-radius:5px;
			border-radius:5px;
			text-align:center;
			vertical-align:middle;
			display:inline-block;
			font-size:11px;
			color:#696969;
			width:50px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #eeeeee;
		}
	</style>

	<div id="dialog-form" title="답변 수정">
		<form>
				<input type="hidden" id="idx">
				<input type="hidden" name="mno" id="mno">
				작성자 : <span id="unm"></span>
				<br />
				작성일 : <span id="rdate"></span>
				<br />
				내 용
				<br />
				<textarea rows="8" cols="45" id="mcon" wrap="hard"></textarea>
				<br /><br />
				<center><img src='./resources/ls_img/btn_edite.gif' id='memoUpdateBtn' style='cursor:pointer;' /></center>
		</form>
	</div>

	<!-- 검색 조건 테이블 -->
	
	<!-- //검색 조건 테이블 -->
	<br />
	<!-- 검색 결과 테이블 -->
	<div class= "tableStyle4" id="searchResultTable">

			<table>
				<thead>
					<tr>
						<th width="15%">답변자</th>
						<th width="50%">답변 내용</th>
						<th width="15%">작성일</th>
						<th width="10%">수정</th>
						<th width="10%">삭제</th>
					</tr>
				</thead>
				<tbody id="memoTbody">
					<tr>
					</tr>
				</tbody>
			</table>

	</div><!-- //tableStyle2 -->
	<!-- //검색 결과 테이블 -->
	<br>
	<div class= "tableStyle4">

			<table>
				<tbody>
					<tr>
						<td width="15%" style="background-color:#CEE3F6;" align="center">																					
							<b>답변 하기</b>							
						</td>
						<td width="75%">
							<textarea style="width:99%" rows="2" cols="" id="memoArea"></textarea>
						</td>
						<td width="10%" align="center">
							<a href="#noloc" class="btn-vacation-aprv" id="memoWrite" style="background:#D0F5A9;">답변입력</a>
						</td>
					</tr>
				</tbody>
			</table>

	</div><!-- //tableStyle2 -->
