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
											<th width="5%">현장보고</th>
											<th width="5%">경과</th>
											<th width="5%">상태</th>
										</tr>
									</thead>
									<tbody>
										
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
										style ="cursor:pointer;" >
											<!-- suim_rpt_type1 -->
											<td colspan="8">미결건이 없습니다.</td>
										</tr>
										<!-- 손해보험 출력 끝 -->
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
