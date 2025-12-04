<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.css">
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/jquery/jquery-ui.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<script>
	var dialog_aprvUser;
		$(document).ready(function(){
	
			$.ajaxSetup({cache:false});

			$("#aprvUserLogTbl").hide();

			//update form start
			dialog_aprvUser = $("#dialog-form-aprvUser").dialog({
				autoOpen: false,
				height: 300,
				width: 500,
				modal: true
			});
			//update form end

			$("#chgAprvUserBtn").click(function(){
				if($("#teamNo").val() == 0){
					alert("팀을 선택 해주세요.");
					$("#teamNo").focus();
					return;
				}
				if($("#taskNo").val() == 0){
					alert("업무를 선택 해주세요.");
					$("#taskNo").focus();
					return;
				}
				if($.trim($("#mbrNo1").val()) == ""){
					alert("신규 결재자를 검색 해주세요.");
					$("#mbrNo1").focus();
					return;
				}
				if($.trim($("#chgAprvUserReason").val()) == ""){
					alert("신규 결재자 지정 사유를 입력 해주세요.");
					$("#chgAprvUserReason").focus();
					return;
				}

				var tmp = window.confirm("주의! 결재자 변경 업무는 로그 보존을 위해 수정 삭제가 불가능합니다.\n\n결재자를 입력 하시겠습니까?");
				if(tmp == false){
					return;
				}

				$.post("./aprvUserIns",
						{	teamNo:$("#teamNo").val()
							,taskNo:$("#taskNo").val()
							,mbrNo1:$("#mbrNo1").val()
							,chgAprvUserReason:$("#chgAprvUserReason").val()
						},
						function(data,status){
							if(status == "success"){
								if(data.length == 0){
									alert("결재자 등록을 실패 하였습니다.");
								}else{
									$("#aprvUserLogTbl").show();
									alert("결재자 등록을 성공 하였습니다.");
									$("#teamNo").change();
// 									$("#teamNo option[value='0']").attr('selected', 'selected');
// 									$("#taskNo option[value='0']").attr('selected', 'selected');
 									$("#mbrNo1").val("");
 									$("#mbrNm1").val("");
 									$("#chgAprvUserReason").val("");
								}//if(data.length == 0){
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						},"json"
				);//post

			});//$("#chgAprvUserBtn").click

			$("#teamNo").change(function(){
				if($("#teamNo").val() == 0){
					alert("팀을 선택 해주세요.");
					return;
				}

				$.post("./aprvUserList",
						{	teamNo:$("#teamNo").val()
							,taskNo:$("#taskNo").val()
						},
						function(data,status){
							if(status == "success"){
								if(data.length == 0){
									alert("결재자 조회 결과가 없습니다.");
								}else{
									$("#aprvUserTbody").children().remove();
									$("#aprvUserLogTbl").show();
				                    $.each(data, function(index, entry) {
		                        		$("#aprvUserTbody").append('<tr>'
												+"<td>"+entry.teamNm+"</td>"
												+"<td>"+entry.taskCodeNm+"</td>"
												+"<td>"+entry.aprvUserNm+"</td>"
												+"<td title="+entry.regReason+">"+entry.regDateFmt+"</td>"
												+"<td>"+entry.regIp+"</td>"
												+"<td>"+entry.regUserNm+"</td>"
												+"<td><img src='./resources/ls_img/ls_memo/btn_s_del.gif' id='delBtn"+index+"' style='cursor:pointer;' /></td>"
												+"<td title="+entry.delReason+">"+entry.delDateFmt+"</td>"
												+"<td>"+entry.delIp+"</td>"
												+"<td>"+entry.delUserNm+"</td>"
		                                		+"</tr>"
			   							);
		                        		$("#delBtn"+index).bind("click",function(){
		                        			aprvUserDeleteForm(entry.serialNo, entry.teamNm, entry.taskCodeNm, entry.aprvUserNm, $(this).parent().parent().index(), entry.delDate);
		                        		});
									});//each
								}//if(data.length == 0){
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						},"json"
				);//post

			});//$("#teamNo").change

			$("#taskNo").change(function(){
				if($("#teamNo").val() == 0){
					alert("팀을 선택 해주세요.");
					return;
				}

				$.post("./aprvUserList",
						{	teamNo:$("#teamNo").val()
							,taskNo:$("#taskNo").val()
						},
						function(data,status){
							if(status == "success"){
								if(data.length == 0){
									alert("결재자 조회 결과가 없습니다.");
								}else{
									$("#aprvUserTbody").children().remove();
									$("#aprvUserLogTbl").show();
				                    $.each(data, function(index, entry) {
		                        		$("#aprvUserTbody").append('<tr>'
												+"<td>"+entry.teamNm+"</td>"
												+"<td>"+entry.taskCodeNm+"</td>"
												+"<td>"+entry.aprvUserNm+"</td>"
												+"<td title="+entry.regReason+">"+entry.regDateFmt+"</td>"
												+"<td>"+entry.regIp+"</td>"
												+"<td>"+entry.regUserNm+"</td>"
												+"<td><img src='./resources/ls_img/ls_memo/btn_s_del.gif' id='delBtn"+index+"' style='cursor:pointer;' /></td>"
												+"<td title="+entry.delReason+">"+entry.delDateFmt+"</td>"
												+"<td>"+entry.delIp+"</td>"
												+"<td>"+entry.delUserNm+"</td>"
		                                		+"</tr>"
			   							);
		                        		$("#delBtn"+index).bind("click",function(){
		                        			aprvUserDeleteForm(entry.serialNo, entry.teamNm, entry.taskCodeNm, entry.aprvUserNm, $(this).parent().parent().index(), entry.delDate);
		                        		});
									});//each
								}//if(data.length == 0){
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						},"json"
				);//post

			});//$("#teamNo").change

			$("#deleteAprvUser").click(function(){
				var tmp = window.confirm("결재 권한을 해지 하시겠습니까?");
				if(tmp == false){
					return;
				}
				$.post("./deleteAprvUser",
						{	serialNo:$("#serialNo").val()
							, delReason:$("#delReason").val()
						},
						function(data,status){
							if(status == "success"){
								if(data.length == 0){
									alert("결재 권한 해지를 실패 하였습니다.");
								}else{
									alert("결재 권한 해지를 성공 하였습니다.");
									dialog_aprvUser.dialog("close");
									$("#teamNo").change();
								}//if(data.length == 0){
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			});//$("#restoreHolidayBtn").click

		});//$(document).ready

		//update form open start
		function aprvUserDeleteForm(serialNo, teamNm, taskCodeNm, aprvUserNm, index, delDate){
			if(delDate != ''){
				alert("이미 삭제된 데이터 입니다.");
				return;
			}
			$("#index").val(index);
			$("#serialNo").val(serialNo);
			$("#teamNm").text(teamNm);
			$("#taskCodeNm").text(taskCodeNm);
			$("#aprvUserNm").text(aprvUserNm);
			dialog_aprvUser.dialog("open");
		}
		//update form open end
	</script>
</head>

<body>

<!-- wrapper -->
<div id="wrapper">
	<!-- skipnavi --><!-- header -->
	<c:import url="../top_main/top_sysadm_menu.jsp"></c:import>
	<!-- //skipnavi --><!-- //header -->

	<!-- contents -->
	<div id="container">
		<div class="contetns">

			<!-- left_cnt -->
			<c:import url="../top_main/top_sysadm_left.jsp"></c:import>
			<!-- //left_cnt -->

			<!-- centercnt_top -->
			<div class="center_cnt">

				<!-- centercnt_bot -->
				<div class="centercnt_bot1-2">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">팀별 업무별 결재자 변경</a></li>
							</ul>
						</div>

						<div class="guestcnt4" style="display:block;">

							<div class= "tableStyle2">
									<table>
										<thead>
											<tr>
												<th>신규 결재자를 지정할 팀</th>
												<th>신규 결재자가 수행할 업무</th>
												<th width="35%">새로운 결재자 사번 / 이름 검색</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<!-- team search -->
												<td>
													<select id="teamNo">
														<option value="0" selected>팀 선택</option>
														<c:forEach items="${teamList}" var = "teamVo">
															<option value="${teamVo.team_id}">
																<c:if test="${teamVo.team_level == 1}">&nbsp;└</c:if>
																<c:if test="${teamVo.team_level == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
																${teamVo.team_name}
															</option>
														</c:forEach>
													</select>
												</td>
												<!-- //team search -->
												<!-- task search -->
												<td>
													<select id="taskNo">
														<option value="0" selected>업무 선택</option>
														<c:forEach items="${taskCodeList}" var = "taskVo">
															<option value="${taskVo.col_cd}">${taskVo.col_val}</option>
														</c:forEach>
													</select>
												</td>
												<!-- //task search -->
												<!-- member search -->
												<td>
													<input type="text" id="mbrNo1" readonly style="background-color:lightgrey;" />
													<input type="text" id="mbrNm1" readonly style="background-color:lightgrey;" />
													<input type="image" src='./resources/ls_img/member/icon_search.gif' class="popOpenBtn" value="1" />
												</td>
												<!-- //member search -->
											</tr>
											<tr>
												<th colspan="3">결재자 변경 사유</th>
											</tr>
											<tr>
												<td colspan="3">
													<input type="text" id="chgAprvUserReason" style="width:90%;height:20px;" maxlength="50" />
													<input type="button" id="chgAprvUserBtn" value="결재자 추가" />
												</td>
											</tr>
										</tbody>
									</table>
									*** 결재자 변경 사유를 자세히 작성해 주세요. ***
									<br />
									*** 예)신규 팀장 임명에 따른 결재자 변경   예)결재자 부재로 인한 대체 결제자 지정 등 ***
									<br />
									*** <font color="red"><b>주의!</b></font> 결재자 변경 업무는 로그 보존을 위해 수정이 불가능합니다.
									<font color="red"><b>오 입력 시, 재 입력 하시기 바랍니다.</b></font> ***
							</div><!-- //tableStyle2 -->
							<c:import url="../util_etc/module_mbrpop_1.jsp"></c:import>

							<br /><br />

							<!-- 검색 결과 테이블 -->
							<div class= "tableStyle2" id="aprvUserLogTbl">
									<table>
										<thead>
											<tr>
												<th>팀</th>
												<th>업무</th>
												<th>결재자</th>
												<th>등록일</th>
												<th>등록IP</th>
												<th>등록자</th>
												<th>삭제</th>
												<th>삭제일</th>
												<th>삭제IP</th>
												<th>삭제자</th>
											</tr>
										</thead>
										<tbody id="aprvUserTbody">
											<tr>
											</tr>
										</tbody>
									</table>
							</div><!-- //tableStyle2 -->
							<!-- //검색 결과 테이블 -->

						</div><!-- //guestcnt4 -->

					</div><!-- //guest -->
				</div>
				<!-- //centercnt_bot -->

				<!-- banner -->
				<c:import url="../top_main/top_main_banner.jsp"></c:import>
				<!-- //banner -->

			</div>
			<!-- //center_cnt -->
		</div>
	</div>
	<!-- //contents -->

	<!-- footer -->
	<c:import url="../top_main/top_main_footer.jsp"></c:import>
	<!-- //footer -->

</div>
<!-- //wrapper -->

	<div id="dialog-form-aprvUser" title="결재자 삭제">
		<br />
		<p style="text-align:center;"><b>선택하신 결재자의 결재 권한을 해제 합니다.</b></p>
		<br />
		<div class= "tableStyle2">
			<table>
				<tr>
					<td width="30%" bgcolor="#e7ecf1">팀명</td>
					<td><span id="teamNm"></span></td>
				</tr>
				<tr>
					<td bgcolor="#e7ecf1">결재권한명</td>
					<td><span id="taskCodeNm"></span></td>
				</tr>
				<tr>
					<td bgcolor="#e7ecf1">결재자명</td>
					<td><span id="aprvUserNm"></span></td>
				</tr>
				<tr>
					<td bgcolor="#e7ecf1">결재 권한 해제 사유</td>
					<td>
						<input type="text" id="delReason" name="delReason" maxlength="50" style="width:96%;" />
						<input type="hidden" name="index" id="index">
						<input type="hidden" name="serialNo" id="serialNo">
					</td>
				</tr>
			</table>
		</div>
		<br />
		<p style="text-align:center;">
			<input type="button" id="deleteAprvUser" name="deleteAprvUser" value="결재 권한 해제" />
		</p>
	</div>

</body>
</html>
