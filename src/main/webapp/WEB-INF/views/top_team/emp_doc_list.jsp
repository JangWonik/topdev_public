<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	
	<script>
 		$(document).ready(function(){
 			if('${mbrAuthVo_Session}'== null || '${mbrAuthVo_Session.mbr_pms_16}' == 0){
 				window.location.assign("./logout");
 			}
 			
 			$.ajaxSetup({cache:false});
 			
			$("#memberSearchBtn").click(function(){
				$.post("./docMemberSearch",
						{	ustat:$("#ustat").val()
							,tid:$("#tid").val()
							,searchStr:$("#searchStr").val()
							,gid:$("#tid option:selected").text().indexOf("└")
						},
						function(data,status){
							$("#searchTbody").empty();
							if(status == "success"){
								if(data.length == 0){
									alert("검색 결과가 없습니다.");
								}else{
				                    $.each(data, function(index, entry) {
		                        		$("#searchTbody").append('<tr>'
												+"<td>"+entry.rownum+"</td>"
												+"<td>"+entry.team_name+"</td>"
												+"<td>"+entry.work_level+"</td>"
												+"<td>"+entry.work_type+"</td>"
												+"<td>"+entry.user_name+"</td>"
												+"<td>"+entry.user_id+"</td>"
												+"<td>"+entry.join_date+"</td>"
												+"<td>"+entry.user_state+"</td>"
												+"<td>"+"<img src='./resources/ls_img/member/btn_view.gif' id='afterSearchBtn"+index+"' style='cursor:pointer;' /></td>"
		                                		+ '</tr>'
			   							);
		                        		$("#afterSearchBtn"+index).bind("click",function(){
		                        			popMbrDocDetail(entry.user_no);
		                        		});
									});//each
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						},"json"
				);//post
			});
			
 		});//$(document).ready
 		
 		function docStateChange(serial_no,flag){
			if (flag == "delete"){
				var r = confirm("해당 내용을 삭제하시겠습니까?");	
			}
			
			if (r == false){
				return;
			}
			
			$.post( "./mbrDocStateChange"
					, {serial_no : serial_no
					  ,flag : flag}
					,function(data,status){
						if(status == "success" && data == 2){ //삭제 요청
							alert("삭제가 완료되었습니다.");
							location.reload();
						}else{
							alert("잠시 후 다시 시도해 주세요.");
						}
					}
			);
		}//docStateChange
 		
 		
		function popMbrDocDetail(user_no){
			
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			
			var sw=1500; //띄울 창의 넓이
			var sh=900;  //띄울 창의 높이

			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('popMbrDetail?user_no='+user_no+'&presentPage=mbrDocTab','tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=yes,scrollbars=yes');
// 			window.open('popMemberDetail?user_no='+user_no+'&presentPage=mbrDocTab','tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}
	</script>
	
</head>

<body>


<!-- wrapper -->
<div id="wrapper">
	<!-- skipnavi --><!-- header -->
	<c:import url="../top_main/top_main_menu.jsp"></c:import>
	<!-- //skipnavi --><!-- //header -->
	<!-- contents -->
	<div id="container">
		<div class="contetns">
		
			<!-- centercnt_top -->
			<div class="center_cnt_1300">

				<!-- centercnt_bot -->
				<div class="center_cnt_1300_bot">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">인사서식 확인 관리</a></li>
								<li><a href="#">사원 검색</a></li>
								
							</ul>
						</div>
						
						<div class="guestcntSearch" style="display:block;">
							<div class= "tableStyle6">
								<table align="center" style = "margin-top:10px;" >
									<thead>
										<tr>
											<th width="15%">이름</th>
											<th width="15%">종류</th>
											<th width="40%">제목</th>
											<th width="10%">상태</th>
											<th width="20%">비고</th>
										</tr>
									</thead>
									
									<tbody align="center">
									<c:forEach items="${docList}" var="docVo">
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
											<td style= "cursor:pointer;">${docVo.user_name}</td>
											<td style= "cursor:pointer;">${docVo.col_val}</td>
											<td style= "cursor:pointer;">${docVo.doc_title}</td>
											<c:choose>
												<c:when test="${docVo.doc_state == 0}">
													<td style= "cursor:pointer;">
														<font color="#0000DB">미등록</font>
													</td>
												</c:when>
												<c:when test="${docVo.doc_state == 8}">
													<td style= "cursor:pointer;">
														<font color="#DB0000">삭제 요청</font>
													</td>
												</c:when>
											</c:choose>
											
											<td style= "cursor:pointer;">
												<c:if test="${mbrVo_Session.user_no == '966' || mbrVo_Session.user_no == '6' || mbrVo_Session.user_no == '62' || mbrVo_Session.user_no == '670'}">
													<span class="mark_alarm">
														<a href="./mbrDocFileDownload?path=${docVo.file_path}&fname=${docVo.file_name}&dstate=${docVo.doc_state}">
															다운로드
														</a>
													</span>
												</c:if>
												<span class="mark_alarm" id="delBtn" onclick="docStateChange(${docVo.serial_no},'delete')">
													<font color="#DB0000">삭제</font>
												</span>
											</td>
										</tr>
									</c:forEach>
									</tbody>		
								</table>
							</div><!-- //tableStyle6 -->
						</div><!-- //guestcntSearch -->
						
						<!-- 검색 탭 -->
						<div class="guestcntSearch" style="display:none;">
							<!-- 검색 테이블 시작 -->
							<div class= "tableStyle6">
								<table align="center" style="margin-top:10px;">
									<thead>
										<tr>
											<th width="25%">재직상태</th>
											<th width="25%">팀명</th>
											<th width="35%">검색어(이름)</th>
											<th width="15%">검색</th>
										</tr>
									</thead>
									<tbody>
										<tr align="center">
											<td>
												<select id="ustat">
													<option value="10" selected>전체(근무자/발령대기자/퇴사자)</option>
													<option value="0">근무자</option>
													<option value="2">발령대기자</option>
													<option value="1 ">퇴사자</option>
													<option value="9">SA</option>
												</select>
											</td>
											<td>
												<select id="tid">
													<option value="0" selected>전체</option>
													<c:forEach items="${teamList}" var = "teamVo">
														<option value="${teamVo.team_id}">
															<c:if test="${teamVo.team_level == 1}">&nbsp;└</c:if>
															<c:if test="${teamVo.team_level == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
															${teamVo.team_name}
														</option>
													</c:forEach>
												</select>
											</td>
											<td>
												<input type="text" id="searchStr" name="searchStr" size="45" />
											</td>
											<td>
												<input type="image" src="./resources/ls_img/btn_src.gif" id="memberSearchBtn" />
											</td>
										</tr>
									</tbody>
								</table>
								
							</div><!-- //tableStyle2 --> 
							<br />
							<div class= "tableStyle6" align="center">
								<!-- 검색 결과 테이블 시작 -->
								<table>
									<thead>
										<tr>
											<th width="5%">No</th>
											<th width="20%">부서명</th>
											<th>직위</th>
											<th>직책</th>
											<th>이름</th>
											<th>아이디</th>
											<th>입사일</th>
											<th>현재상태</th>
											<th>비고</th>
										</tr>
									</thead>
									<tbody id="searchTbody">
										<tr>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<!--  검색탭 -->
						
						
					</div>
				</div>
				<!-- //centercnt_bot -->

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

	<script>
		$(document).ready(function(){
			if('${fromMainLeftStr}'== 'on'){
				$('#issue_state option[value="0"]').attr('selected', 'selected');
				$("#certSearchBtn").click();
			}
		});
	</script>

</body>

</html>
