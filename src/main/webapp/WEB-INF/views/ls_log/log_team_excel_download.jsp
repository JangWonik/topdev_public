<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> --%>
<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

		<c:set var="kind1List" value="${kind1List}" />
		<c:set var="kind4List" value="${kind4List}" />

		<article> <!-- article 시작 -->
			<div class="nav form-group" style="margin-bottom:10px;">
               	<div class="col-lg-1">
               		<button class="btn btn-success" id="exceldownbtn">엑셀 다운로드</button>
               	</div>
               	
              	<div class="col-lg-2 col-lg-offset-8" style="padding:0;">
              		<input type="text" class="form-control" id="skeyword" name="skeyword" placeholder="검색" maxlength="12">
               	</div>
               	
               	<div class="col-lg-1">
              		<input type="button" class="btn btn-primary" id="searchbtn" name="searchbtn" value="검색">
               	</div>
            </div>
            
			<form action="./exceldown" method="POST" id="excelform">
				<div id="tab">
					<div class="guestTap">
							<ul>
								<li class="on"><a>${toAccumYear}년 ${toMonthInt}월 팀별 평균 통계</a></li>
							</ul>
						</div>
						<div class="guestcnt2" style="display:block;">
							<div class="tableStyle2">
								<table cellpadding="0" cellspacing="0" summary="팀&개인 기본통계 1종">
									<caption>팀&개인 기본통계 1종</caption>
									<colgroup>
										<col width="65">
										<col width="130">
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="65">
									</colgroup>
									<thead>
									<tr style="bgcolor: #E7ECF1;">
					                    <td class="td" bgcolor="#E7ECF1" rowspan="3">
					                        <p align="center"><B>Type</B></p>
					                    </td>
					                    <td class="td" bgcolor="#E7ECF1" rowspan="3">
					                        <p align="center"><B>팀명</B></p>
					                    </td>
										<td class="td" bgcolor="#E7ECF1" colspan="2">
					                        <p align="center"><B>수임현황</B></p>
					                    </td>
										<td class="td" bgcolor="#E7ECF1" colspan="2">
					                        <p align="center"><B>종결현황</B></p>
					                    </td>
										<td class="td" colspan="2" bgcolor="#E7ECF1" rowspan="2">
					                        <p align="center"><b>처리율(%)</b></p>
					                    </td>
										<td class="td" bgcolor="#E7ECF1" colspan="2">
					           			    <p align="center"><B>미결현황</B></p>
					                    </td>
										<td class="td" bgcolor="#E7ECF1" colspan="2">
					              	        <p align="center"><B>종결평가</B></p>
					                    </td>
										<td class="td" bgcolor="#E7ECF1" colspan="7">
					         				<p align="center"><b>공동수행자의 비율 및 금액을 반영한 결과<font color="red">(반영안함!)</font></b></p>
					                    </td>
										<td class="td" bgcolor="#E7ECF1" rowspan="3">
					           				<p align="center"><B>미수금</B></p>
					                    </td>
					                </tr>
					                <tr>
										<td class="td" bgcolor="#E7ECF1" colspan="2">
					           			    <p align="center"><B>절대건수</B></p>
					                    </td>
										<td class="td" bgcolor="#E7ECF1" colspan="2">
					         				<p align="center"><B>절대건수</B></p>
					                    </td>
										<td class="td" bgcolor="#E7ECF1" colspan="2">
					          				<p align="center"><B>절대건수</B></p>
					                    </td>
										<td class="td" bgcolor="#E7ECF1" colspan="2">
					           				<p align="center"><B>평가건수</B></p>
					                    </td>
										<td class="td" bgcolor="#E7ECF1" colspan="7">
					         				<p align="center"><B>인보이스 현황<font color="red"><B>(당월)</B></font></p>
					                    </td>
					                </tr>
										<tr>
											<th>당월</th>
											<th>년누계</th>
											<th>당월</th>
											<th>년누계</th>
											<th>당월</th>
											<th>년누계</th>
											<th>현재</th>
											<th>30,15</th>
											<th>당월</th>
											<th>년누계</th>
											<th>기본료</th>
											<th>일비</th>
											<th>소계<br />(기본+일)</th>
											<th>교통비</th>
											<th>자문료</th>
											<th>기타</th>
											<th>합계</th>
										</tr>
									</thead>
									<tbody>
										
											<td class="td" rowspan="25" >1종</td>
											<c:forEach var="vo" items="${kind1List}" varStatus="status">
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
											<td><c:out value="${vo.getTeam_name()}" /></td>
											<td><c:out value="${vo.getReg_m()}" /></td>
											<td><c:out value="${vo.getReg_y()}" /></td>
											<td><c:out value="${vo.getEnd_m()}" /></td>
											<td><c:out value="${vo.getEnd_y()}" /></td>
											<td><c:out value="${vo.getProc_m()}" />%</td>
											<td><c:out value="${vo.getProc_y()}" />%</td>
											<td><c:out value="${vo.getNend_p()}" /></td>
											<td><c:out value="${vo.getNend_30r()}" />%</td>
											<td><c:out value="${vo.getEndea_m()}" /></td>
											<td><c:out value="${vo.getEndea_y()}" /></td>
											<td><c:out value="${vo.getPrice_assess()}" /></td>
											<td><c:out value="${vo.getPrice_time()}" /></td>
											<td><c:out value="${vo.getPrice_sum1()}" /></td>
											<td><c:out value="${vo.getPrice_traffic()}" /></td>
											<td><c:out value="${vo.getPrice_question()}" /></td>
											<td><c:out value="${vo.getPrice_receipt()}" /></td>
											<td><c:out value="${vo.getPrice_sum2()}" /></td>
											<td class="td"><font color="red"><c:out value="${vo.getPrice_total()}" /></font></td>
										</tr>
										</c:forEach>
										
										
									</tbody>
									<tbody>
										
											<td class="td" rowspan="25">4종</td>
											<c:forEach var="vot" items="${kind4List}" varStatus="status">
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
											<td><c:out value="${vot.getTeam_name()}" /></td>
											<td><c:out value="${vot.getReg_m()}" /></td>
											<td><c:out value="${vot.getReg_y()}" /></td>
											<td><c:out value="${vot.getEnd_m()}" /></td>
											<td><c:out value="${vot.getEnd_y()}" /></td>
											<td><c:out value="${vot.getProc_m()}" />%</td>
											<td><c:out value="${vot.getProc_y()}" />%</td>
											<td><c:out value="${vot.getNend_p()}" /></td>
											<td><c:out value="${vot.getNend_30r()}" />%</td>
											<td><c:out value="${vot.getEndea_m()}" /></td>
											<td><c:out value="${vot.getEndea_y()}" /></td>
											<td><c:out value="${vot.getPrice_assess()}" /></td>
											<td><c:out value="${vot.getPrice_time()}" /></td>
											<td><c:out value="${vot.getPrice_sum1()}" /></td>
											<td><c:out value="${vot.getPrice_traffic()}" /></td>
											<td><c:out value="${vot.getPrice_question()}" /></td>
											<td><c:out value="${vot.getPrice_receipt()}" /></td>
											<td><c:out value="${vot.getPrice_sum2()}" /></td>
											<td class="td"><font color="red"><c:out value="${vot.getPrice_total()}" /></font></td>
										</tr>
									</c:forEach>
									
									
									</tbody>
									<tbody>
									
										<tr bgcolor="#E7ECF1">
										<td class="td" colspan="2"><b>합 계</b></td>
										<td><c:out value="${sumobj.getSum_reg_m()}"/></td>
										<td><c:out value="${sumobj.getSum_reg_y()}"/></td>
										<td><c:out value="${sumobj.getSum_end_m()}"/></td>
										<td><c:out value="${sumobj.getSum_end_y()}"/></td>
										<td><c:out value="${sumobj.getSum_proc_m()}"/>%</td>
										<td><c:out value="${sumobj.getSum_proc_y()}"/>%</td>
										<td><c:out value="${sumobj.getSum_nend_p()}"/></td>
										<td><c:out value="${sumobj.getSum_nend_30r()}"/>%</td>
										<td><c:out value="${sumobj.getSum_endea_m()}"/></td>
										<td><c:out value="${sumobj.getSum_endea_y()}"/></td>
										<td><c:out value="${sumobj.getSum_price_assess()}"/></td>
										<td><c:out value="${sumobj.getSum_price_time()}"/></td>
										<td><c:out value="${sumobj.getSum_price_sum1()}"/></td>
										<td><c:out value="${sumobj.getSum_price_traffic()}"/></td>
										<td><c:out value="${sumobj.getSum_price_question()}"/></td>
										<td><c:out value="${sumobj.getSum_price_receipt()}"/></td>
										<td><c:out value="${sumobj.getSum_price_sum2()}"/></td>
										<td><c:out value="${sumobj.getSum_price_total()}"/></td>										
										</tr>
										
									</tbody>
								</table>
							</div>
						</div>
				</div>
				<input type="hidden" name="hidtab" id="hidtab" value="" />
				<input type="hidden" name="hidname" id="hidname" value="whole" />
				
			</form>
			<span>비밀번호 초기화는 ID를 클릭해주세요.</span>
		</article> <!-- article 끝 -->
		

	

</body>
</html>