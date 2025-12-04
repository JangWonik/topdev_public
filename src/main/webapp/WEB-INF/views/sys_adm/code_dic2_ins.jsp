<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<script>
		$(document).ready(function(){
			if('${mbrVo_Session.user_no}' == null || '${mbrVo_Session.user_state}' != 9){
				window.location.assign("./logout");
			}
		});//ready
		$(document).ready(function(){

			$.ajaxSetup({cache:false});

			$("#selectCodeTable").change(function(){
				$("#selectColumn option[value='']").attr('selected', 'selected');
				searchTableForm.submit();
			});

			$("#selectUserTable").change(function(){
				$("#selectColumn option[value='']").attr('selected', 'selected');
				searchTableForm.submit();
			});

			$("#selectColumn").change(function(){
				searchTableForm.submit();
			});

			$("#insertCodeBtn").click(function(){
				if($("#selectColumn").val().trim() == ""){
					alert("컬럼을 확인 후 저장해주세요.");
					$("#selectColumn").focus();
					return;
				}
				if($("#insertCode1").val().trim() == ""){
					alert("코드1을 확인 후 저장해주세요.");
					$("#insertCode1").focus();
					return;
				}
				if($("#selectCodeTable").val() == "sysadm_codedic2" && $("#insertCode2").val().trim() == ""){
					alert("코드2을 확인 후 저장해주세요.");
					$("#insertCode2").focus();
					return;
				}
				if($("#insertCodeValue").val().trim() == ""){
					alert("코드값을 확인 후 저장해주세요.");
					$("#insertCodeValue").focus();
					return;
				}
				var tmp = window.confirm("코드를 입력 하시겠습니까?");
				if(tmp == false){
					return;
				}
				$.post("./codeWrite",
						{	selectCodeTable:$("#selectCodeTable").val()
							,selectUserTable:$("#selectUserTable").val()
							,selectColumn:$("#selectColumn").val()
							,insertCode1:$("#insertCode1").val()
							,insertCode2:$("#insertCode2").val()
							,insertCodeValue:$("#insertCodeValue").val()
						},
						function(data,status){
							if(status == "success"){
								if(data.length == 0){
									alert("코드 입력을 실패 하였습니다.");
								}else{
									searchTableForm.submit();
								}//if(data.length == 0){
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			});//$("#storeHolidayBtn").click

		});//ready

		function deleteCodeFunc(table, column, code1, code2){
			var tmp = window.confirm("코드를 삭제 하시겠습니까?");
			if(tmp == false){
				return;
			}
			$.post("./codeDelete",
					{	selectCodeTable:$("#selectCodeTable").val()
						,selectUserTable:table
						,selectColumn:column
						,insertCode1:code1
						,insertCode2:code2
					},
					function(data,status){
						if(status == "success"){
							if(data.length == 0){
								alert("코드 입력을 실패 하였습니다.");
							}else{
								searchTableForm.submit();
							}//if(data.length == 0){
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}
			);//post
		}//function deleteCodeFunc
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
								<li class="on"><a href="#">코드 관리</a></li>
							</ul>
						</div>

						<div class="guestcnt4" style="display:block;">

							<div class= "tableStyle2">

								<form id="searchTableForm" name="searchTableForm" action="./sysAdmCode">
									<table>
										<tr>
											<th>입력 테이블 선택</th>
											<th>데이터 테이블 선택</th>
											<th>데이터 컬럼 선택</th>
										</tr>
										<tr>
											<td>
												<select id="selectCodeTable" name="selectCodeTable">
														<option value="sysadm_codedic"
															<c:if test="${'sysadm_codedic' == selectCodeTable}">selected</c:if> >
															sysadm_codedic</option>
														<option value="sysadm_codedic2"
															<c:if test="${'sysadm_codedic2' == selectCodeTable}">selected</c:if> >sysadm_codedic2</option>
												</select>
											</td>
											<td>
												<select id="selectUserTable" name="selectUserTable">
													<c:forEach items="${allTableList}" var = "allTableVo">
														<option value="${allTableVo}"
															<c:if test="${allTableVo == selectUserTable}">selected</c:if> >
															${allTableVo}
														</option>
													</c:forEach>
												</select>
											</td>
											<td>
												<select id="selectColumn" name="selectColumn">
													<option value=""> - 선 택 - </option>
													<c:forEach items="${allColumnList}" var = "columnVo">
														<option value="${columnVo}"
															<c:if test="${columnVo == selectColumn}">selected</c:if> >
															${columnVo}
														</option>
													</c:forEach>
												</select>
											</td>
										</tr>
									</table>
								</form>
							</div><!-- //tableStyle2 -->

							<br />

							<div class= "tableStyle2">
								<table>
									<tr>
										<th>입력 코드 1</th>
										<th>입력 코드 2</th>
										<th>입력 코드 값</th>
										<th>입력</th>
									</tr>
									<tr>
										<td><input type="text" id="insertCode1" name="insertCode1" /></td>
										<td><input type="text" id="insertCode2" name="insertCode2" /></td>
										<td><input type="text" id="insertCodeValue" name="insertCodeValue" /></td>
										<td><input type="button" id="insertCodeBtn" name="insertCodeBtn" value="코드 입력" /></td>
									</tr>
								</table>
							</div><!-- //tableStyle2 -->
							*** 테이블 내부의 코드로 이루어진 컬럼에 존재하는 각각의 코드 값에 해당하는 값을 입력하는 화면 입니다.<br />
							*** 코드 값을 입력한 테이블 컬럼은 코드를 값으로 치환하여 사용할 수 있습니다.<br />
							*** 참고) DB함수 getCodeValue('테이블명','컬럼명',코드NO), getCode2Value('테이블명','컬럼명',코드NO1,코드NO2)

							<br /><br />

							<c:if test="${selectCodeTable != null}">${selectCodeTable} 에서</c:if>
							<c:if test="${selectUserTable != null}">테이블 이름 ${selectUserTable}</c:if>
							<c:if test="${selectColumn != null && selectColumn != ''}">과 컬럼 이름 ${selectColumn}</c:if>
							<c:if test="${selectUserTable != null}">으로 검색한 결과 입니다.</c:if>
							<c:if test="${selectUserTable != null}">
								<div class="tableStyle2">
									<table>
										<thead>
											<tr>
												<th>테이블 이름</th>
												<th>컬럼 이름</th>
												<th>컬럼 코드1</th>
												<th>컬럼 코드2</th>
												<th>컬럼 값</th>
												<th>삭제</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${codeDicList}" var="codeVo">
												<tr>
													<td>${codeVo.tbl_nm}</td>
													<td>${codeVo.col_nm}</td>
													<td>${codeVo.col_cd1}</td>
													<td>${codeVo.col_cd2}</td>
													<td>${codeVo.col_val}</td>
													<td>
														<img src="./resources/ls_img/btn_del_s.gif" style ="cursor:pointer;" alt="코드 삭제" 
														onclick="deleteCodeFunc('${codeVo.tbl_nm}','${codeVo.col_nm}','${codeVo.col_cd1}','${codeVo.col_cd2}');"/>
													</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div><!-- //tableStyle2 -->
							</c:if>

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

</body>

</html>
