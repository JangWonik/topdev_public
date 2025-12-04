
<!-- /*
	 * ***************************************
	 * ID : sysadm_codedic_updateOk
	 * Method Name : 시스템 코드 관리 화면 
	 * Description : 소스 상의 주석 확인*
	 * Author : 이선형
	 * Date : 20160404
	 * ***************************************
	 * */ -->
	 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<script src="./resources/ne_js/jquery.form.js"></script>
	<script>
		$(document).ready(function(){
			if('${mbrVo_Session.user_no}' == null || '${mbrVo_Session.user_state}' != 9){
				window.location.assign("./logout");
			}
		});//ready
	</script>

<script>
	$(document).ready(function(){
		
		/* 테이블명 선택 시 테이블명을 전달 받은 화면을 재호출 한다. */
		$("#tablename").change(function(){
			
			$("#tablename option:selected").each(function(){
				var tbl_nm= $(this).val();
				location.href = "topSysAdmCode?tname="+tbl_nm;
			});
						
		});
		
		/* 컬럼이름 선택 시 테이블명, 컬럼이름을 전달 받은 화면을 재호출 한다. */
		$("#colname").change(function(){
			
			var tname = document.sysadmcodeform.tbl_nm.value;
			
			$("#colname option:selected").each(function(){
				var col_nm= $(this).val();
				location.href = "topSysAdmCode?tname="+tname+"&cname="+col_nm;
			});
						
		});
		
		/* 새 코드 추가 동작*/
		$("#sysadmcodeform").ajaxForm({
			  dataType : 'text',
			  success:function(data) {
				  
				  if((data != 2) && (data != 0)){
					  var codeArr = data.split("-");
					  var newrow = 
						  "<tr>"+
						  	"<td>"+codeArr[1] +"</td>"+
						  	"<td>"+codeArr[2] +"</td>"+
						  	"<td>"+codeArr[3]+"</td>"+
						  	"<td>"
		 						+"<img src='./resources/ls_img/btn_del_s.gif' style ='cursor:pointer;' alt='코드 삭제' onclick=\"del('"
				 				+codeArr[0]+"','"
				 				+codeArr[1]+"','"
				 				+codeArr[2]+"');\"/>"
		 				   +"</td>"
		 				   +"</tr>";
						$("#Contents").append(newrow);					  
				  }else if(data == 2){
					  alert("중복 코드 입니다.\n(화면 목록에 없는 코드일 경우 삭제 상태 값을 확인하세요)");
					  document.sysadmcodeform.col_cd.focus();
				  }else if(data == 0){
					  alert("컬럼코드는 필수입력사항입니다.");
					  document.sysadmcodeform.col_cd.focus();
				  }
			}			
		});
		
	});

	$(document).ready(function(){
		$("#addTblNmBtn").click(function(){
			if($("#addTblNm").val().trim() == ""){
				alert("추가하실 테이블 이름을 입력 해주세요.");
				$("#addTblNm").focus();
				return;
			}else{
				$("#tablename").append("<option value="+$("#addTblNm").val()+" selected>"+$("#addTblNm").val()+"</option>");
				$("#addTblNm").val("");
			}
		});//$("#addTblNmBtn").click
		$("#addColNmBtn").click(function(){
			if($("#addColNm").val().trim() == ""){
				alert("추가하실 테이블 이름을 입력 해주세요.");
				$("#addColNm").focus();
				return;
			}else{
				$("#colname").append("<option value="+$("#addColNm").val()+" selected>"+$("#addColNm").val()+"</option>");
				$("#addColNm").val("");
			}
		});//$("#addTblNmBtn").click
	});//ready
</script>
<script type="text/javascript">
	function del(tbl_nm,col_nm,col_cd){
		
		if(confirm("삭제하시겠습니까?")){
			location.href="delSysAdmCode?tname="+tbl_nm+"&cname="+col_nm+"&ccode="+col_cd;
		}
		
	};
	
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

			<!-- center_cnt -->
			<div class="center_cnt">

				<!-- centercnt_bot -->
				<div class="centercnt_bot1-2">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">관리자 코드</a></li>
							</ul>
						</div>
						<div class="guestcnt4" style="display:block;"><!-- //guestcnt -->

							<div class= "tableStyle4">
								<table>
									<tr>
										<th>하단 테이블의 테이블이름 SelectBox에 테이블 이름 추가하기</th>
										<th>하단 테이블의 컬럼이름 SelectBox에 컬럼 이름 추가하기</th>
									</tr>
									<tr>
										<td align="center">
											<input type="text" id="addTblNm" size="50" />
											<input type="button" id="addTblNmBtn" value ="테이블 이름 추가하기" />
										</td>
										<td align="center">
											<input type="text" id="addColNm" size="50" />
											<input type="button" id="addColNmBtn" value ="컬럼 이름 추가하기" />
										</td>
									</tr>
								</table>
							</div>
							*** 테이블 이름이나 컬럼 이름을 잘못 입력하신 경우, F5를 누르시면 초기화 됩니다. ***<br />

							<br /><br />

							<div class= "tableStyle2">
								<form id = "sysadmcodeform" name = "sysadmcodeform" action="addSysAdmCode" method = "post">
									<table>
										<thead>
											<tr>
												<th>테이블이름</th>
												<th>컬럼이름</th>
												<th>컬럼코드</th>
												<th>컬럼 값</th>
												<th width="50">비고</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>
													<select id="tablename" name="tbl_nm">
														<option> 선 택 </option>
														<c:forEach items="${tblnmList}" var = "tblnm">
															<option value="${tblnm.tbl_nm}" > ${tblnm.tbl_nm} </option>
														</c:forEach>
													</select>
												</td>
												<td>
													<select id="colname" name="col_nm">
														<option> 선 택 </option>
														<c:forEach items="${colnmList}" var = "colnm">
															<option value="${colnm.col_nm}" > ${colnm.col_nm} </option>
														</c:forEach>
													</select>
												</td>
												<td>
													<input type="text" id = "colcd" name = "col_cd" />
												</td>
												<td>
													<input type="text" id = "colval" name = "col_val"/> 
												</td>
												<td>
													<input type="submit" value ="추가"/>
													<!-- <img  src="./resources/ls_img/btn_add_s.gif" id ="add" style ="cursor:pointer;" alt="새코드 추가"/> -->
												</td>				
											</tr>
										</tbody>
									</table>
									*** 테이블 내부의 코드로 이루어진 컬럼에 존재하는 각각의 코드 값에 해당하는 값을 입력하는 화면 입니다. ***<br />
									*** 코드 값을 입력한 테이블 컬럼은 코드를 값으로 치환하여 사용할 수 있습니다. 참고) DB함수 getCodeValue('테이블명','컬럼명',코드NO) ***
								</form>
							</div>	

							<c:if test="${tblNameTitle ne null}">
								<script type="text/javascript">
									document.sysadmcodeform.tbl_nm.value="${tblNameTitle}";
								</script>
							</c:if>
							<c:if test="${colNameTitle ne null}">
								<script type="text/javascript">
									document.sysadmcodeform.col_nm.value="${colNameTitle}";				
								</script>
							</c:if>

							<br /><br />

							<span id = "tblnmTitle">
								<c:if test="${tblNameTitle ne null}">
									※  [ ${tblNameTitle} ]
								</c:if>
							</span>
							<span id = "colnmTitle"> 
								<c:if test="${colNameTitle ne null}">
									> [ ${colNameTitle} ]
								</c:if>
							</span>

							<div class="tableStyle2">
								<table>
									<thead>
										<tr>
											<th>컬럼이름</th>
											<th>컬럼코드</th>
											<th>컬럼 값</th>
											<th width="50">비고</th>
										</tr>
									</thead>
									<tbody id = "Contents">
										<c:forEach items="${tblOneList}" var="col">
											<tr id ="codeContents">
												<td>${col.col_nm}</td>
												<td>${col.col_cd}</td>
												<td>${col.col_val}</td>
												<td>
													<img src="./resources/ls_img/btn_del_s.gif" style ="cursor:pointer;" alt="코드 삭제" 
													onclick="del('${col.tbl_nm}','${col.col_nm}','${col.col_cd}');"/>
												</td>
											</tr>							
										</c:forEach>
									</tbody>
								</table>
							</div>

						</div><!-- //guestcnt -->
					</div>
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
