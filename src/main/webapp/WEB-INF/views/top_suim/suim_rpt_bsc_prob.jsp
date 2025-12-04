<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<script type="text/javascript">
	
	$(document).ready(function(){
		
		//문제점 추가
		$("#probRptInsBtn").click(function(){
			$.post("./probRptIns",
					{	
						 suimRptNo   	:$("#suimRptNo").val(),  
						 contents		:$("#memoProblem").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;') ,
						 regdate		:$("#prob_regdate").val(),
						 flag 			:"prob"
						
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("저장 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{
								 $.each(data, function(index, entry) {
									alert("저장 완료");
									$("#probList").append(
										"<tr id='prb_"+entry.tmpNo+"'>"
											+ "<td>" + entry.regDate + "</td>"
											+ "<td align='left'>" + decodeURIComponent(entry.contents) + "</td>"
											+ "<td>" + "<img src='./resources/ls_img/btn_edit_s.gif' onclick=\"probEdit('"+entry.tmpNo+"','"+entry.regDate+"','"+entry.contents+"');\" style='cursor:pointer;'/>"
											 + "   <img src='./resources/ls_img/btn_del_s.gif' onclick='probDel("+entry.tmpNo+");' style='cursor:pointer;'/>"
											+ "</td>"
										+"</tr>"
									);
								 });
								$("#probAddAreaId").css("display","none");
								$("#hideProbAddAreaBtn").css("display","none");
								$("#showProbAddAreaBtn").css("display","block");
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					},"json"
				);
		});
	});
	
	
	//수정버튼 클릭시 html 변경
	function probEdit(serialNo, regDate, contents){
		var contents = decodeURIComponent(contents);
		var encContents = contents.replace(/<br>/g,"\n").replace(/&nbsp;/g,"\u0020");
		
		$("#prb_"+serialNo).html("");
		$("#prb_"+serialNo).append(
				"<td>"
				+ "<input type='text' size='15' value = '"+regDate+"' id='prob_regDate_Edit_"+serialNo+"'/>"
				+ "</td>"
				+ "<td>"
				+ "<textarea id='prob_contents_Edit_"+serialNo+"' rows='10' style='width: 100%;'>"+decodeURIComponent(encContents)+"</textarea>"
				+ "</td>"
				+ "<td>"
				+ "<img src='./resources/ls_img/btn_edite.gif' style='cursor:pointer;' onclick='probEditOk("+serialNo+");'/>"
				+ "</td>"
		);
		
		$('#prob_regDate_Edit_'+serialNo).datepicker({ 
	    	   showOn: 'button',
	    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
	    	   buttonImageOnly: true,
	    	   buttonText: "달력", 
	    	   changeMonth: true,
	    	   changeYear: true,
	    	   showButtonPanel: false
	    });
		
		$("#prob_contents_Edit_"+serialNo).focus();
	}
	
	//글수정 confirm
	function probEditOk(serialNo){
		$.post("./probRptUdt",
				{	
				 	serial_no 	  	:serialNo  //
					,prb_memo      	:$("#prob_contents_Edit_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')
					,prb_date      	:$("#prob_regDate_Edit_"+serialNo).val() //
					
				},
				function(data,status){
					if(status == "success"){
						if(data == 0){
							alert("저장 실패하였습니다. 관리자에게 문의해 주세요.");
						}else{
							 alert("수정에 성공하였습니다.");
							 $.each(data, function(index, entry) {
								$("#prb_"+entry.serialNo).html("");
								$("#prb_"+entry.serialNo).append(
									  "<td>" + entry.regDate + "</td>"
									+ "<td align='left'>" + entry.contents + "</td>"
									+ "<td>" + "<img src='./resources/ls_img/btn_edit_s.gif' onclick=\"probEdit('"+entry.serialNo+"','"+entry.regDate+"','"+entry.contents+"');\" style='cursor:pointer;'/>"
									 + "   <img src='./resources/ls_img/btn_del_s.gif' onclick='probDel("+entry.serialNo+");' style='cursor:pointer;'/>"
									+ "</td>"
									
								);
							 });
						}
					}else{
						alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
					}
				},"json"
		);//post
	};
	
	
	/* 문제점 삭제 */
	function probDel(serialNo){
		if(confirm("삭제하시겠습니까?")){
			$.post("./probRptDel",
					{	
						serialNo 	  	:serialNo  //
						
					},
					function(data,status){
						if(status == "success"){
							if(data != 0){
								$("#prb_"+data).html("");									
							}else{
								alert("시스템 오류입니다. 잠시 후 재시도 해주세요.");	
							}
						}else{
							alert("시스템 오류입니다. 잠시 후 재시도 해주세요.");
						}
					}
			);
			
		}
	}
	
	
	/*  추가 영역 보이기 시작 */
	function showProbAddArea(){

		if( !fnChkListSave()){
			alert("체크리스트 내용을 먼저 입력해 주세요.");
			fnPrgssModifyFrm();
			$("#p_amtEstimatedDamage").focus();
			return;
		}

//		$("#probAddAreaId").css("display","block");
//		$("#showProbAddAreaBtn").css("display","none");
//		$("#hideProbAddAreaBtn").css("display","block");
		$("#probAddAreaId").show();
		$("#showProbAddAreaBtn").hide();
		$("#hideProbAddAreaBtn").show();

		/* 일자에 오늘 날짜 자동 입력 */
		var currentDate = new Date();
		var month = currentDate.getMonth() + 1 + "";
		
		if(month.length == 1){
			month = "0"+month;
		}
		
		var day = currentDate.getDate() + "";
		
		if(day.length == 1){
			day = "0"+day;
		}
		
		var year = currentDate.getFullYear();
		
		var today = year+"-"+month+"-"+day;

		$("#prob_regdate").val(today);
		$('#prob_regdate').datepicker({ 
	    	   showOn: 'button',
	    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
	    	   buttonImageOnly: true,
	    	   buttonText: "달력", 
	    	   changeMonth: true,
	    	   changeYear: true,
	    	   showButtonPanel: false
	    	});
		$("#memoProblem").html("");
		$("#memoProblem").focus();
		
		
	}
	/*  추가 영역 보이기 끝*/
	
	/*  추가 영역 숨기기 시작 */
	function hideProbAddArea(){
//		$("#showProbAddAreaBtn").css("display","block");
//		$("#hideProbAddAreaBtn").css("display","none");
//		$("#probAddAreaId").css("display","none");

		$("#showProbAddAreaBtn").show();
		$("#hideProbAddAreaBtn").hide();
		$("#probAddAreaId").hide();
	}
	/*  추가 영역 숨기기 끝 */

</script>

	<!--  입력 -->
	<table align="center" style="margin-top:10px;">
		<thead>
			<tr>
				<td colspan="3">
					<b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;" /> 2-4. 문제점</b>

					<c:if test="${(suimVO.suimRptState eq '0' and suimVO.editYN > 0) or endModFlag > 0}">
						<img src="./resources/ls_img/btn_add_s.gif" title="추가" id = "showProbAddAreaBtn" style="float:right; cursor:pointer; margin-right:10px;" onclick="showProbAddArea();"/>
						<img src="./resources/ls_img/btn_close.gif" title="추가 취소" id = "hideProbAddAreaBtn" style="float:right; cursor:pointer; margin-right:10px; display:none;" onclick="hideProbAddArea();"/>
					</c:if>
				</td>
			</tr>
			<colgroup>
				<col width="20%">
				<col width="60%">
				<col width="20%">
			</colgroup>
			<tr>
				<th>일자</th>
				<th>문제점</th>
				<th>비고</th>
			</tr>
		</thead>
		
		<tbody align="center" id="probList">			
			<tr align="center" style="display:none;" id = "probAddAreaId">
				<td>
					<input type="text" size="15" id="prob_regdate"/>
				</td>
				
				<td>
					<textarea id="memoProblem" rows="10" style="width: 100%;"></textarea>
				</td>
				<td>
<!-- 					<img src="./resources/ls_img/btn_edite.gif" id="probRptInsBtn" style="cursor:pointer;"/> -->
<!-- 					<img src="./resources/ls_img/btn_del.gif" style="cursor:pointer;" onclick="probDel();"/> -->
					<img src="./resources/ls_img/btn_add.gif" id="probRptInsBtn" style="cursor:pointer;"/>
				</td>
			</tr>
		<c:forEach var="prbList" items="${probList}" varStatus="prbStatus"> 
			<tr id = "prb_${prbList.serial_no}">
				<td>${prbList.prb_date}</td>
				<td align="left">
					${prbList.prb_memo}
					<!-- <textarea id="test" cols="60" rows="10"></textarea> -->
				</td>
				<td>
					<c:choose>
						<c:when test="${(suimVO.suimRptState eq '0' and suimVO.editYN > 0) or endModFlag > 0}">
							<img src='./resources/ls_img/btn_edit_s.gif' onclick="probEdit('${prbList.serial_no}','${prbList.prb_date}','${prbList.prb_memo}')" style='cursor:pointer;'/> 
							<img src='./resources/ls_img/btn_del_s.gif' onclick="probDel('${prbList.serial_no}')" style='cursor:pointer;'/>
						</c:when>
						<c:otherwise>
							-
						</c:otherwise>
					</c:choose>
				</td>
		</c:forEach>
		</tbody>			
	</table>