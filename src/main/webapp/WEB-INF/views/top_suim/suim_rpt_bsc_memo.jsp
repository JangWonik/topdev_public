<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- <link rel="stylesheet" href="./resources/jquery/jquery-ui.css"> -->
	<script src="./resources/jquery/jquery-ui.js"></script>
	<style>
		.tdhead{
			text-align:center;
			background-color : #E7ECF1;
		}
	</style>
</head>

<body>

	<script type="text/javascript">
		var dialogMemo;
		$(document).ready(function(){
	
			$.ajaxSetup({cache:false});
			//update form start
			dialogMemo = $("#dialog-form-rptMemo").dialog({
				autoOpen: false,
				height: 300,
				width: 350,
				modal: true
			});
			//update form end

			//최초 조회 시작
			$.post("./memoList",
					{	targetStr:$("#targetStr").val()
						,linkNo:$("#linkNo").val()
					},
					function(data,status){
						if(status == "success"){
							if(data.length > 0){

								$("#memoHeadRptDtl").append(
										
									"<tr >"
									+	"<th width='15%'>작성자</th>"
									+	"<th width='45%'>한 줄 메모</th>"
									+	"<th width='20%'>작성일</th>"
									+	"<th width='7%'>수정</th>"
									+	"<th width='7%'>삭제</th>"
									+"</tr>"
								
								);
								
			                    $.each(data, function(index, entry) {
	                        		$("#memoTbody").append('<tr>'
											+"<td align='center'>"+entry.userNm+"</td>"
											+"<td style='text-align:left;padding-left:5px;'>"+entry.mContents+"</td>"
											+"<td align='center'>"+entry.regDate+"</td>"
											+"<td><img src='./resources/ls_img/ls_memo/btn_s_edite.gif' id='editBtn"+index+"' style='cursor:pointer;' /></td>"
											+"<td><img src='./resources/ls_img/ls_memo/btn_s_del.gif' id='delBtn"+index+"' style='cursor:pointer;' /></td>"
	                                		+ '</tr>'
		   							);
	                        		$("#editBtn"+index).bind("click",function(){
	                        			//alert($(this).parent().parent().children().eq(1).text());
	                        			memoUpdateForm(entry.memoNo, entry.userNm, $(this).parent().parent().children().eq(1).html(), entry.regDate, $(this).parent().parent().index());
	                        		});
	                        		$("#delBtn"+index).bind("click",function(){
	                        			memoDelete(entry.memoNo, $(this).parent().parent().index());
	                        		});
								});//each
							}//if(data.length > 0){
						}else{
							alert("메모를 불러오기를 실패하였습니다. 잠시 후 다시 시도해 주세요.");
						}
					},"json"
			);//post
			//최초 조회 끝

			//메모 등록 시작
			$("#memoWrite").click(function(){
				if($("#memoArea").val().trim() == ""){
					return;
				}
				$.post("./memoWrite",
						{	targetStr:$("#targetStr").val()
							,linkNo:$("#linkNo").val()
							,mContents:$("#memoArea").val()
						},
						function(data,status){
							if(status == "success"){
								if(data.length == 0){
									alert("메모 등록을 실패 하였습니다.");
								}else{
									
									/* lsh 수정 */
									if($("#memoHeadRptDtl").html().trim() == ''){
										$("#memoHeadRptDtl").append(
												
												"<tr >"
												+	"<th width='15%'>작성자</th>"
												+	"<th width='45%'>한 줄 메모</th>"
												+	"<th width='20%'>작성일</th>"
												+	"<th width='7%'>수정</th>"
												+	"<th width='7%'>삭제</th>"
												+"</tr>"
											
											);
									}
									
									var tmpVar = $("#memoTbody").children().last().index()+1;
				                    $.each(data, function(index, entry) {
				                    	
		                        		$("#memoTbody").append('<tr>'
												+"<td align='center'>"+entry.userNm+"</td>"
												+"<td style='text-align:left;padding-left:5px;'>"+entry.mContents+"</td>"
												+"<td align='center'>"+entry.regDate+"</td>"
												+"<td><img src='./resources/ls_img/ls_memo/btn_s_edite.gif' id='editBtn"+tmpVar+"' style='cursor:pointer;' /></td>"
												+"<td><img src='./resources/ls_img/ls_memo/btn_s_del.gif' id='delBtn"+tmpVar+"' style='cursor:pointer;' /></td>"
		                                		+ '</tr>'
			   							);
		                        		$("#editBtn"+tmpVar).bind("click",function(){
		                        			memoUpdateForm(entry.memoNo, entry.userNm, $(this).parent().parent().children().eq(1).html(), entry.regDate, $(this).parent().parent().index());
		                        		});
		                        		$("#delBtn"+tmpVar).bind("click",function(){
		                        			memoDelete(entry.memoNo, $(this).parent().parent().index());
		                        		});
									});//each
									$("#memoArea").val("");
									alert("나도한마디가 등록되었습니다.");
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
				if( !("${suimVO.suimRptState}" == 0) ){
					alert("상신 후에는 수정 할 수 없습니다.");
					return;
				}
			
				if($("#mcon").val().trim() == ""){
					alert("메모 내용을 확인 후 저장해주세요.");
					$("#mcon").focus();
					return;
				}
				$.post("./memoUpdate",
						{	targetStr:$("#targetStr").val()
							,memoNo:$("#mno").val()
							,mContents:$("#mcon").val()
						},
						function(data,status){
							if(status == "success"){
								if(data.length == 0){
									alert("메모 수정을 실패 하였습니다.");
								}else{
									$("#memoTbody").children().eq($("#idx").val()).children().eq(1).html($("#mcon").text().replace(/\n/g,'<br>'));
									$("#idx").val('');
									$("#mno").val('');
									$("#unm").text('');
									$("#rdate").text('');
									$("#mcon").text('');
									dialogMemo.dialog("close");
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
		function memoDelete(memoNo, index){
			
			if( !("${suimVO.suimRptState}" == 0) ){
				alert("상신 후에는 삭제 할 수 없습니다.");
				return;
			}
		
			$.post("./memoDelete",
					{	targetStr:$("#targetStr").val()
						,memoNo:memoNo
					},
					function(data,status){
						if(status == "success"){
							if(data.length == 0){
								alert("메모 삭제를 실패 하였습니다.");
							}else{
								$("#memoTbody").children().eq(index).remove();
								
								/* lsh 수정 */
								if($("#memoTbody").html().trim() == ''){
									$("#memoHeadRptDtl").html("");
								}
							}//if(data.length == 0){
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}
			);//post
		}
		//메모 삭제 end

		//update form open start
		function memoUpdateForm(memoNo, userNm, mContents, regDate, index){
			$("#idx").val(index);
			$("#mno").val(memoNo);
			$("#unm").text(userNm);
			$("#rdate").text(regDate);
			$("#mcon").val(mContents.replace(/<br>/g,'\r'));
			dialogMemo.dialog("open");
		}
		//update form open end
	</script>
	
							
	<div id="dialog-form-rptMemo" title="메모 수정" align="center">
		<form>
				<input type="hidden" id="targetStr" value="TopReport" />
				<input type="hidden" id="linkNo" value="${suimVO.suim_rpt_no}" />
				
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
        <br/>
		<table align="center" >
			<thead id = "memoHeadRptDtl">
			</thead>
			<tbody id="memoTbody">

			</tbody>
		</table>

		<table align="center" style="margin-top:15px;">
			<tbody>
				<tr>
					<td width="20%" align="center">
						<%--<img src="./resources/ls_img/ls_memo/t_memo.gif" />--%>
						<span style="font-weight: bold;font-size: 14px;">과정관리 의견</span>
					</td>
					<td width="60%">
						<textarea style="width:99%" rows="3" cols="" id="memoArea"></textarea>
					</td>
					<td width="20%" align="center">
						<input type="image" src="./resources/ls_img/ls_memo/btn_write.gif" id="memoWrite" />
					</td>
				</tr>
			</tbody>
		</table>


	<!-- 검색 결과 테이블 -->

	

	<!-- //검색 결과 테이블 -->

</body>

</html>
