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
	
	<c:set var="ptnrDtl" value="${ptnrDtl}"/>
	<c:set value="${ptnrMbrList}" var="ptnrMbrList"/>
	<c:set var="ptnr_id" value="${ptnr_id}"/>
	<c:set var="ptnr_name" value="${ptnrDtl.getPtnr_name()}"/>
	<script>
		$(document).ready(function(){

			$.ajaxSetup({cache:false});

			$("#ptnrMbrInsBtn").click(function(){
				var cw=screen.availWidth;
				var ch=screen.availHeight;
				
				var sw=1010; //띄울 창의 넓이
				var sh=740;  //띄울 창의 높이

				var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
				var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치

				var ptnr_id='${ptnr_id}';
				
				//불필요한 한글 파라미터 제거
				//var ptnr_name='${ptnr_name}';
				
				window.open('popPtnrAdd?ptnr_id='+ptnr_id,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			});//$("#ptnrMbrInsBtn").click
			

			$(".tmpPtnrMbrDelCls").click(function(){
				var ptnrmbrno = $(this).attr("name");
				if(!confirm("해당 직원을 삭제하시겠습니까?")){
					return;
				}else{
					$.post("./popPtnrDelOK",
							{	ptnr_mbr_no   			:ptnrmbrno	},
							function(data,status){
								if(status == "success"){
									if(data == 0){
										alert("삭제 실패하였습니다. 관리자에게 문의해 주세요.");
									}else{
										alert("삭제되었습니다.");
										window.location.assign("./topPtnrDTL?ptnr_id=${ptnr_id}");
									}
								}else{
									alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
								}
							}//function
					);//post
				}//else
			});//$("#ptnrMbrDelBtn").click

		});//$(document).ready
	</script>
	<script>
		function popPtnrUdt(ptnr_mbr_no){
			
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			
// 			var ptnr_id='${ptnr_id}';
// 			var ptnr_name='${ptnr_name}';
			
			var sw=1010; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이

			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			
			window.open('popPtnrUdt?ptnr_mbr_no='+ptnr_mbr_no,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}
		
		//엑셀 다운로드
		function excelPtnrMember(gubun){
			$("#gubun").val(gubun);
			excelPtnrMemberForm.submit();
		}
	</script>
<style>
	.tableStyle2 td {letter-spacing: 0;}
</style>
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

			<!-- left_cnt -->
			<c:import url="../top_main/top_main_left.jsp"></c:import>
			<!-- //left_cnt -->

			<!-- centercnt_top -->
			<div class="center_cnt">

				<!-- centercnt_bot -->
				<div class="centercnt_bot1-2">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">관련업체</a></li>
							</ul>
						</div>
						
						<div class="guestcnt4" style="display:block;">
							<div class= "tableStyle2">
								<table>
									<thead>
										<tr>
											<c:choose>
												<c:when test="${ptnrDtl.getPtnr_img_big().length() == 0}">
													<td class rowspan="4" width="20%"></td>
												</c:when>
												<c:otherwise>
													<td class rowspan="4" width="20%"><img src="${ptnrDtl.getPtnr_img_big()}" width="150"/></td>
												</c:otherwise>
											</c:choose>
											
											<td style="width:65%;  text-align:left;"><b>ㆍ업체명 : <c:out value="${ptnrDtl.getPtnr_name()}"/></b></td>
											
											<td class rowspan="4" width="15%">
												<input type="hidden" name="ptnr_id" id="ptnr_id" value="${ptnr_id}"/>
												<input type="hidden" name="ptnr_name" id="ptnr_name" value="${ptnr_name}"/>
												<a href="./topPtnrList"><img src="./resources/ls_img/ls_partner/btn_list.gif"/></a><br><br>
												<c:if test="${mbrAuthVo_Session.mbr_pms_9 == 1 }">
													<img src="./resources/ls_img/btn_add.gif" id="ptnrMbrInsBtn" style="cursor:pointer;" /> <br><br>
												</c:if>
												<!-- 엑셀 다운 -->
												
												<img src="./resources/ls_img/btn_excel.gif" style="cursor:pointer;" onclick="excelPtnrMember('${ptnr_id}')"   />
												<!-- 엑셀 다운을 위한 폼 -->
												<form name="excelPtnrMemberForm" id="excelPtnrMemberForm" action="excelPtnrMember" method="GET">
													<input type="hidden" id="gubun" name="gubun" />
												</form>		
											</td>
											
										</tr>
										<tr>
											<td style="text-align:left;"><b>ㆍ전화번호 : <c:out value="${ptnrDtl.getPtnr_tel()}"/></b></td>
										</tr>
										<tr>
											<td style="text-align:left;"><b>ㆍ홈페이지 : <c:out value="${ptnrDtl.getPtnr_url()}"/></b></td>
										</tr>
										<tr>
										</tr>
									</thead>
									</table>
								</div><!-- //tableStyle2 -->
								<br><br>
								<div class= "tableStyle2">
									<table>
										<tbody>
											<tr>
												<th width="20%">부서/팀</th>
												<!-- <th>팀</th> -->
												<th width="5%">직위</th>
												<th width="10%">직책</th>
												<th width="5%">업종</th>
												<th width="8%">이름</th>
												<th width="10%">H.P.</th>
												<th width="10%">직통전화</th>
												<th width="10%">팩스</th>
												<th width="10%">mail</th>
												<th width="5%">비고</th>
												<th width="5%">상세</th>
											</tr>
										<!-- 출력 시작 -->
											<c:forEach items="${ptnrMbrList}" var="vo" varStatus="status">
												<tr>
													<%-- <td><c:out value="${vo.getPtnr_dept_id()}"/></td> --%>
													<td>
														<c:out value="${vo.getPtnr_tm_nm()}"/>
														<c:if test="${vo.ptnr_tm2_nm ne '' and vo.ptnr_tm2_nm ne null}">
															<br/>(${vo.ptnr_tm2_nm})
														</c:if>	
													</td>
													<td><c:out value="${vo.getPtnr_mbr_position_nm()}"/></td>
													<td><c:out value="${vo.getPtnr_mbr_job_memo()}"/></td>
													<c:choose>
														<c:when test="${vo.getPtnr_mbr_work_type() eq 0}">
															<td>1,4종</td>
														</c:when>
														<c:otherwise>
															<td><c:out value="${vo.getPtnr_mbr_work_type()}"/>종</td>
														</c:otherwise>
													</c:choose>
													<td><c:out value="${vo.getPtnr_mbr_nm()}"/></td>
													<td><c:out value="${vo.getPtnr_mbr_hp()}"/></td>
													<td><c:out value="${vo.getPtnr_mbr_office_tel()}"/></td>
													<td><c:out value="${vo.getPtnr_mbr_office_fax()}"/></td>
													<td><c:out value="${vo.getPtnr_mbr_office_email()}"/></td>
													<td><c:out value="${vo.getPtnr_mbr_work_memo()}"/></td>
													<td>
														<input type="hidden" name="ptnr_mbr_no" id="ptnr_mbr_no" value="${vo.getPtnr_mbr_no()}"/>
														<c:if test="${mbrAuthVo_Session.mbr_pms_9 == 1 }">
															<img src="./resources/ls_img/btn_edit_s.gif" style="cursor:pointer;" onclick="popPtnrUdt(<c:out value='${vo.getPtnr_mbr_no()}'/>)" />
															<img src="./resources/ls_img/btn_del_s.gif" style="cursor:pointer;" class="tmpPtnrMbrDelCls" name="<c:out value='${vo.getPtnr_mbr_no()}'/>" />
														</c:if>
													</td>
												</tr>
											</c:forEach>
										<!-- 출력 끝 -->
										</tbody>
									</table>
								</div><!-- //tableStyle2 -->
							</div><!-- //guestcnt4 -->
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
