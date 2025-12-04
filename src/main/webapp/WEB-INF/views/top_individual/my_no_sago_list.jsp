<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

	<script>
		$(document).ready(function(){
			if('${mbrVo_Session.user_no}' == null || '${mbrVo_Session.user_no}'.trim() == ''){
				alert("로그아웃 상태입니다. 재로그인 하십시오.");
				window.location.assign("./logout");
			}
		});

		function popSuimDtl(suim_rpt_no){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1010; //띄울 창의 넓이
			var sh=screen.availHeight;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('suimRptBscDtl?suim_rpt_no='+suim_rpt_no,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}
	</script>

							<div class= "tableStyle2">
								<table>
									<thead>
										<tr>
											<th width="5%">구분</th>
											<th width="7%">접수번호</th>
											<th width="6%">보험사</th>
											<th width="8%">피보험자</th>
											<th width="5%">수임일자</th>
											<th width="5%">경과</th>
											<th width="5%">상태</th>
										</tr>
									</thead>
									<tbody>
										<!--  -->
										<c:forEach items="${myNoSagoListPop}" var="suimVO" varStatus="status" > <!-- begin="1" end="20" step="1" -->
										
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
										style ="cursor:pointer;" onclick="popSuimDtl('${suimVO.suim_rpt_no}')">
											<!-- suim_rpt_type1 -->
											<td>${suimVO.suim_rpt_type1_nm}</td>
											<!-- suim_accept_no -->
											<td>${suimVO.suim_accept_no}</td>
											<!-- 보험사 -->
											<td>${suimVO.ptnr_name}</td>
											<!-- 피보험자 -->
											<td>${suimVO.beneficiary_nm}</td>
											<!-- 수임일자 -->
											<td>${suimVO.reg_date_fmt}</td>
											<!-- 경과 -->
											<td>${suimVO.past_date} 일</td>
											<!-- 상태 -->
											<td>${suimVO.suim_rpt_state_nm}</td>
										</tr>
										</c:forEach>
										<!-- 손해보험 출력 끝 -->
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
