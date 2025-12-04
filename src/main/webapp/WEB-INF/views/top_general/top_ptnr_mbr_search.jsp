<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script>
		$(document).ready(function(){
			if('${mbrVo_Session.user_no}' == null || '${mbrVo_Session.user_no}'.trim() == ''){
				alert("로그아웃 상태입니다. 재로그인 하십시오.");
				window.location.assign("./logout");
			}
		});

		$(document).ready(function(){

			$.ajaxSetup({cache:false});
			
			$("#searchStr").focus();

			$("#memberSearchBtn").click(function(){
				$("#ptnrSrc").val($("#ptnrSelect option:selected").val());
				$("#ptnrGb").val($("#ptnrSelect option:selected").text().indexOf("└"));
				$("#srcWord").val($("#searchStr").val());
				$("#topPtnrMbrSearchForm").submit();
			});

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

		});//ready
		
		function enterKey(){
			if(event.keyCode == 13){				
				$("#memberSearchBtn").click();
			}
		}

		function popPtnrUdt(ptnr_id, ptnr_name, ptnr_mbr_no){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1010; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('popPtnrUdt?ptnr_mbr_no='+ptnr_mbr_no+'&ptnr_id='+ptnr_id+'&ptnr_name='+ptnr_name,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}
	</script>
</head>
<style>
	.tableStyle2 td {letter-spacing: 0;}
</style>
<body>
						<!-- search -->
							<form action="./topPtnrList" id="topPtnrMbrSearchForm" name="topPtnrMbrSearchForm" method="get">
								<input type="hidden" id="ptnrSrc" name="ptnrSrc" />
								<input type="hidden" id="ptnrGb" name="ptnrGb" />
								<input type="hidden" id="srcWord" name="srcWord" />
							</form>
							<!-- 검색 조건 테이블 -->
							<div class= "tableStyle2">
					
								<table>
									<thead>
										<tr>
											<th width="40%">보험사명</th>
											<th width="45%">이름 및 전화번호</th>
											<th width="15%">검색</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>
												<select id="ptnrSelect" name="ptnrSelect" style="width:90%;">
													<option value="0" selected>전체</option>
													<c:forEach items="${ptnrListForSearch}" var = "ptnrVo">
														<option value="${ptnrVo.ptnr_id}"
															<c:if test="${ptnrVo.ptnr_id == ptnrSrc}">selected</c:if>
														>
															<c:if test="${ptnrVo.ptnr_level == 1}">&nbsp;└</c:if>
															${ptnrVo.ptnr_nick}
														</option>
													</c:forEach>
												</select>
											</td>
											<td style="text-align:center;">
												<input	type="text" id="searchStr" name="searchStr" size="25" value="${srcWord}" onKeydown="javascript:enterKey();" />
											</td>
											<td width="20%">
												<input type="image" src="./resources/ls_img/btn_src.gif" id="memberSearchBtn" />
											</td>
										</tr>
									</tbody>
								</table>
					
							</div><!-- //tableStyle2 -->
							<!-- //검색 조건 테이블 -->
							<br />
							<!-- 검색 결과 테이블 -->
							<div class= "tableStyle2">
					
									<table>
										<thead>
											<tr>
												<th>이름</th>
												<th>보험사명</th>
												<th>부서명(팀명)</th>
												<th>직위</th>
												<th>직책</th>
												<th>업종</th>
												<th>휴대폰</th>
												<th>직통전화</th>
												<th>팩스</th>
												<th>이메일</th>
												<th>수정</th>
											</tr>
											<tr>
												<th></th>
												<th colspan="4">메모</th>												
												<th colspan="4">주소</th>
												<th colspan="2">세금계산서 담당자</th>
											</tr>
										</thead>
										<tbody id="searchTbody">
											<c:forEach items="${ptnrMbrList}" var="mbrVO" varStatus="status">
												<tr onMouseOver="this.style.backgroundColor='#FFECEC'"
													onMouseOut="this.style.backgroundColor=''" style ="cursor:pointer;" >
													<!--이름-->
													<td>${mbrVO.ptnr_mbr_nm}</td>
													<!--보험사명-->
													<td>${mbrVO.ptnr_nick}</td>
													<!--팀명-->
													<td>
														${mbrVO.ptnr_dept_nm}
														<c:if test="${mbrVO.ptnr_tm2_nm != ''}">
															<br/>(${mbrVO.ptnr_tm2_nm})
														</c:if>
													</td>
													<!--직위-->
													<td>${mbrVO.ptnr_mbr_position_nm}</td>
													<!--직책-->
													<td>${mbrVO.ptnr_mbr_job_memo}</td>
													<!--업종-->
													<td>
														<c:choose>
															<c:when test="${mbrVO.ptnr_mbr_work_type == 1}">1종</c:when>
															<c:when test="${mbrVO.ptnr_mbr_work_type == 4}">4종</c:when>
															<c:when test="${mbrVO.ptnr_mbr_work_type == 0}">1종/4종겸직</c:when>
														</c:choose>
													</td>
													<!--휴대폰-->
													<td>${mbrVO.ptnr_mbr_hp}</td>
													<!--직통전화-->
													<td>${mbrVO.ptnr_mbr_office_tel}</td>
													<!--팩스-->
													<td>${mbrVO.ptnr_mbr_office_fax}</td>
													<!--이메일-->
													<td>${mbrVO.ptnr_mbr_office_email}</td>
													<!--수정-->
													<td>
														<input type="hidden" name="ptnr_id" id="ptnr_id" value="${mbrVO.ptnr_id}"/>
														<input type="hidden" name="ptnr_name" id="ptnr_name" value="${mbrVO.ptnr_name}"/>
														<input type="hidden" name="ptnr_mbr_no" id="ptnr_mbr_no" value="${mbrVO.getPtnr_mbr_no()}"/>
														<c:if test="${mbrAuthVo_Session.mbr_pms_9 == 1 }">
															<img src="./resources/ls_img/btn_edit_s.gif" style="cursor:pointer;" onclick="popPtnrUdt('${mbrVO.ptnr_id}','${mbrVO.ptnr_name}','${mbrVO.ptnr_mbr_no}')" />
															<img src="./resources/ls_img/btn_del_s.gif" style="cursor:pointer;" class="tmpPtnrMbrDelCls" name="<c:out value='${mbrVO.getPtnr_mbr_no()}'/>" />
														</c:if>
													</td>
												</tr>
												<tr>
													<td></td>
													<!--메모-->
													<td colspan="4">${mbrVO.ptnr_mbr_work_memo}</td>													
													<!--주소-->
													<td colspan="4">${mbrVO.ptnr_mbr_office_postcode} ${mbrVO.ptnr_mbr_office_addr1} ${mbrVO.ptnr_mbr_office_addr2}&nbsp;</td>
													<!-- 세금계산서담당자 -->
													<td colspan="2">${mbrVO.ptnr_tax_nm}</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
					
							</div><!-- //tableStyle2 -->
							<!-- //검색 결과 테이블 -->

</body>
</html>
