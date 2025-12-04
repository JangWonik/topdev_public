<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

							<div class="tableStyle2">
								<table cellpadding="0" cellspacing="0" summary="개인 기본통계">
									<caption>개인 기본통계</caption>
									<colgroup>
										<col width="65">
										<col width="100">
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
					                   <tr>
                 				   	      	<td bgcolor="#EFEFEF" rowspan="4">
                    				   			<p align="center"><b><font color="black">구분</font></b></p>
                   							</td>
				                   			<td bgcolor="#EFEFEF" rowspan="4">
				                      			<p align="center"><b><font color="black">접수번호</font></b></p>
				                    		</td>
											<td bgcolor="#EFEFEF" colspan="14">
				            					<p align="center"><font color="black">공동수행자의 비율 및 금액을 반영한 결과</font></p>
				                    		</td>
				               		   </tr>
				                		<tr>
											<td class="td" bgcolor="#EFEFEF" colspan="14">
				            					<p align="center"><font color="black">인보이스 현황</font><font color="red">(당월)</font></p>
				                    		</td>
				               			</tr>
				            			<tr>
											<td class="td" bgcolor="#EFEFEF" rowspan="2">
					            				<p align="center"><font color="black">기본료</font></p>
					                    	</td>
											<td class="td" bgcolor="#EFEFEF" rowspan="2">
					            				<p align="center"><font color="black">일비</font></p>
					                    	</td>
											<td class="td" bgcolor="#EFEFEF" rowspan="2">
					            				<p align="center"><font color="black">건</font></p>
					                    	</td>
											<td class="td" bgcolor="#EFEFEF" colspan="3">
					            				<p align="center"><font color="black">공동수행 지급</font></p>
					                    	</td>
											<td class="td" bgcolor="#EFEFEF" colspan="3">
					            				<p align="center"><font color="black">공동수행 수령</font></p>
					                    	</td>
											<td class="td" bgcolor="#EFEFEF" rowspan="2">
					            				<p align="center"><font color="black"><b>소계</b></font></p>
					                    	</td>
											<td class="td" bgcolor="#EFEFEF" rowspan="2">
					            				<p align="center"><font color="black">교통비</font></p>
					                    	</td>
											<td class="td" bgcolor="#EFEFEF" rowspan="2">
					            				<p align="center"><font color="black">자문료</font></p>
					                    	</td>
											<td class="td" bgcolor="#EFEFEF" rowspan="2">
					            				<p align="center"><font color="black">기타</font></p>
					                    	</td>
											<td class="td" bgcolor="#EFEFEF" rowspan="2">
					            				<p align="center"><font color="black"><b>합계</b></font></p>
					                    	</td>
					                	</tr>
			                			<tr>
											<td class="td" bgcolor="#EFEFEF">
						            			<p align="center"><font color="black">기본료</font></p>
						                    </td>
											<td class="td" bgcolor="#EFEFEF">
						            			<p align="center"><font color="black">일비</font></p>
						                    </td>
											<td class="td" bgcolor="#EFEFEF">
						            			<p align="center"><font color="black">건</font></p>
						                    </td>
											<td class="td" bgcolor="#EFEFEF">
						            			<p align="center"><font color="black">기본료</font></p>
						                    </td>
											<td class="td" bgcolor="#EFEFEF">
						            			<p align="center"><font color="black">일비</font></p>
						                    </td>
											<td class="td" bgcolor="#EFEFEF">
						            			<p align="center"><font color="black">건</font></p>
						                    </td>
						                </tr>
									</thead>
									<c:forEach var="vo" items="${getMisTmBscMbr2141}" varStatus="status">
						                <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
			                				<td><font color="blue">본인 담당건</font></td>
											<td><a href="javascript:popSuimDtl('${vo.getRid()}')"><c:out value="${vo.getReport_id()}" /></a></td>
											<td><fmt:formatNumber value="${vo.getPrice_assess()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getPrice_time()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getReport_ea()}" pattern="#,##0.###"/></td>
											<td><fmt:formatNumber value="${vo.getP_price_mi_a()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getP_price_mi_b()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getReport_ea_mi()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getP_price_pl_a()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getP_price_pl_b()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getReport_ea_pl()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getSum_little()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getPrice_traffic()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getPrice_question()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getPrice_receipt()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getSum_hap()}" pattern="#,##0.##"/></td>
												<c:set var="sumPrice_assess" value="${vo.getPrice_assess() + sumPrice_assess}" />
												<c:set var="sumPrice_time" value="${vo.getPrice_time() + sumPrice_time}" />
												<c:set var="sumReport_ea" value="${vo.getReport_ea() + sumReport_ea}" />
												<c:set var="sumP_price_mi_a" value="${vo.getP_price_mi_a() + sumP_price_mi_a}" />
												<c:set var="sumP_price_mi_b" value="${vo.getP_price_mi_b() + sumP_price_mi_b}" />
												<c:set var="sumReport_ea_mi" value="${vo.getReport_ea_mi() + sumReport_ea_mi}" />
												<c:set var="sumP_price_pl_a" value="${vo.getP_price_pl_a() + sumP_price_pl_a}" />
												<c:set var="sumP_price_pl_b" value="${vo.getP_price_pl_b() + sumP_price_pl_b}" />
												<c:set var="sumReport_ea_pl" value="${vo.getReport_ea_pl() + sumReport_ea_pl}" />
												<c:set var="sumSum_little" value="${vo.getSum_little() + sumSum_little}" />
												<c:set var="sumPrice_traffic" value="${vo.getPrice_traffic() + sumPrice_traffic}" />
												<c:set var="sumPrice_question" value="${vo.getPrice_question() + sumPrice_question}" />
												<c:set var="sumPrice_receipt" value="${vo.getPrice_receipt() + sumPrice_receipt}" />
												<c:set var="sumSum_hap" value="${vo.getSum_hap() + sumSum_hap}" />
										</tr>
									</c:forEach>			               
									<c:forEach var="vo" items="${getMisTmBscMbr2142}" varStatus="status">
						                <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
			                				<td><font color="red">공동 수행건</font></td>
											<td><a href="javascript:popSuimDtl('${vo.getRid()}')"><c:out value="${vo.getReport_id()}" /></a></td>
											<td><fmt:formatNumber value="${vo.getPrice_assess()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getPrice_time()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getReport_ea()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getP_price_mi_a()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getP_price_mi_b()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getReport_ea_mi()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getP_price_pl_a()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getP_price_pl_b()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getReport_ea_pl()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getSum_little()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getPrice_traffic()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getPrice_question()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getPrice_receipt()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getSum_hap()}" pattern="#,##0.##"/></td>
												<c:set var="sumPrice_assess" value="${vo.getPrice_assess() + sumPrice_assess}" />
												<c:set var="sumPrice_time" value="${vo.getPrice_time() + sumPrice_time}" />
												<c:set var="sumReport_ea" value="${vo.getReport_ea() + sumReport_ea}" />
												<c:set var="sumP_price_mi_a" value="${vo.getP_price_mi_a() + sumP_price_mi_a}" />
												<c:set var="sumP_price_mi_b" value="${vo.getP_price_mi_b() + sumP_price_mi_b}" />
												<c:set var="sumReport_ea_mi" value="${vo.getReport_ea_mi() + sumReport_ea_mi}" />
												<c:set var="sumP_price_pl_a" value="${vo.getP_price_pl_a() + sumP_price_pl_a}" />
												<c:set var="sumP_price_pl_b" value="${vo.getP_price_pl_b() + sumP_price_pl_b}" />
												<c:set var="sumReport_ea_pl" value="${vo.getReport_ea_pl() + sumReport_ea_pl}" />
												<c:set var="sumSum_little" value="${vo.getSum_little() + sumSum_little}" />
												<c:set var="sumPrice_traffic" value="${vo.getPrice_traffic() + sumPrice_traffic}" />
												<c:set var="sumPrice_question" value="${vo.getPrice_question() + sumPrice_question}" />
												<c:set var="sumPrice_receipt" value="${vo.getPrice_receipt() + sumPrice_receipt}" />
												<c:set var="sumSum_hap" value="${vo.getSum_hap() + sumSum_hap}" />
										</tr>
									</c:forEach>
					                <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">						
										<td bgcolor="#EFEFEF" colspan="2">합 계</td>							
										<td><fmt:formatNumber value="${sumPrice_assess}" pattern="#,##0.##" /></td>
										<td><fmt:formatNumber value="${sumPrice_time}" pattern="#,##0.##" /></td>
										<td><fmt:formatNumber value="${sumReport_ea}" pattern="#,##0.###" /></td>
										<td><fmt:formatNumber value="${sumP_price_mi_a}" pattern="#,##0.##" /></td>
										<td><fmt:formatNumber value="${sumP_price_mi_b}" pattern="#,##0.##" /></td>
										<td><fmt:formatNumber value="${sumReport_ea_mi}" pattern="#,##0.##" /></td>
										<td><fmt:formatNumber value="${sumP_price_pl_a}" pattern="#,##0.##" /></td>
										<td><fmt:formatNumber value="${sumP_price_pl_b}" pattern="#,##0.##" /></td>
										<td><fmt:formatNumber value="${sumReport_ea_pl}" pattern="#,##0.##" /></td>
										<td><fmt:formatNumber value="${sumSum_little}" pattern="#,##0.##" /></td>
										<td><fmt:formatNumber value="${sumPrice_traffic}" pattern="#,##0.##" /></td>
										<td><fmt:formatNumber value="${sumPrice_question}" pattern="#,##0.##" /></td>
										<td><fmt:formatNumber value="${sumPrice_receipt}" pattern="#,##0.##" /></td>
										<td><fmt:formatNumber value="${sumSum_hap}" pattern="#,##0.##" /></td>
	</tr>
				               </table>
							</div>
							<!-- // 자기-공동 수행 -->
							<!-- 미수금 내역 -->
							<table align="center" cellpadding="0" cellspacing="0" width="990">
							    <tr>
							        <td width="100%" height="30">
							            <p><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0"> <b><font color="black">미수금내역</font></b></p>
							        </td>
							    </tr>
							</table>
							<div class="tableStyle2">
								<table cellpadding="0" cellspacing="0" width="990" bordercolordark="white" bordercolorlight="#CCCCCC" align="center">
									<colgroup>
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
		                                <tr>
		                                    <td bgcolor="#EFEFEF" height="30" class="td">
		                                        <p align="center"><font color="black">no</font></p>
		                                    </td>
		                                    <td bgcolor="#EFEFEF" class="td">
		           	 							<p align="center"><font color="black">보험사</font></p>
		                                    </td>
		                                    <td bgcolor="#EFEFEF" class="td">
		           								<p align="center"><font color="black">접수번호</font></p>
		                                    </td>
		                                    <td bgcolor="#EFEFEF" class="td">
		         							    <p align="center"><font color="black">계약자</font></p>
		                                    </td>
		                                    <td bgcolor="#EFEFEF" class="td">
		                                        <p align="center"><font color="black">피보험자</font></p>
		                                    </td>
		                                    <td bgcolor="#EFEFEF" class="td">
		            							<p align="center"><font color="black">종결일</font></p>
		                                    </td>
		                                    <td bgcolor="#EFEFEF" class="td">
		            							<p align="center"><font color="black">기본보수</font></p>
		                                    </td>
		                                    <td bgcolor="#EFEFEF" class="td">
		            							<p align="center"><font color="black">일비</font></p>
		                                    </td>
		                                    <td bgcolor="#EFEFEF" class="td">
		            							<p align="center"><font color="black">교통비</font></p>
		                                    </td>
		                                    <td bgcolor="#EFEFEF" class="td">
		            							<p align="center"><font color="black">자문료</font></p>
		                                    </td>
		                                    <td bgcolor="#EFEFEF" class="td">
		            							<p align="center"><font color="black">기타</font></p>
		                                    </td>
		                                    <td bgcolor="#EFEFEF" class="td">
		            							<p align="center"><font color="black">미수금</font></p>
		                                    </td>
		                                </tr>
	                                </thead>
	                                <tbody>
		                                <c:forEach var="vo" items="${getMisTmBscMbr2Mi}" varStatus="status">
		                                <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
		                               		<td>${getMisTmBscMbr2Mi.size() - status.index}</td>
		                                	<td><c:out value="${vo.getIg_nick()}" /></td>
		                                	<td><a href="javascript:popSuimDtl('${vo.getRid()}')"><c:out value="${vo.getReport_id()}" /></a></td>
		                                	<td><c:out value="${vo.getIg_client()}" /></td>
		                                	<td><c:out value="${vo.getIg_insured()}" /></td>
		                                	<td><c:out value="${vo.getEnd_date()}" /></td>
		                                	<td><fmt:formatNumber value="${vo.getPrice_assess_mi()}" pattern="#,##0.##"/></td>
		                                	<td><fmt:formatNumber value="${vo.getPrice_time_mi()}" pattern="#,##0.##"/></td>
		                                	<td><fmt:formatNumber value="${vo.getPrice_traffic_mi()}" pattern="#,##0.##"/></td>
		                                	<td><fmt:formatNumber value="${vo.getPrice_question_mi()}" pattern="#,##0.##"/></td>                           	
		                                	<td><fmt:formatNumber value="${vo.getPrice_receipt_mi()}" pattern="#,##0.##"/></td>
		                                	<td><font color="red"><fmt:formatNumber value="${vo.getSum_hap_mi()}" pattern="#,##0.##"/></font></td>
												<c:set var="sumPrice_assess_mi" value="${vo.getPrice_assess_mi() + sumPrice_assess_mi}" />
												<c:set var="sumPrice_time_mi" value="${vo.getPrice_time_mi() + sumPrice_time_mi}" />
												<c:set var="sumPrice_traffic_mi" value="${vo.getPrice_traffic_mi() + sumPrice_traffic_mi}" />
												<c:set var="sumPrice_question_mi" value="${vo.getPrice_question_mi() + sumPrice_question_mi}" />
												<c:set var="sumPrice_receipt_mi" value="${vo.getPrice_receipt_mi() + sumPrice_receipt_mi}" />
												<c:set var="sumSum_hap_mi" value="${vo.getSum_hap_mi() + sumSum_hap_mi}" />
		                                </tr>
		                                </c:forEach>
		                                <!-- 미수금 합계 시작 -->
		                                 <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">						
											<td bgcolor="#EFEFEF" colspan="6">미수금  합계</td>							
										<td><fmt:formatNumber value="${sumPrice_assess_mi}" pattern="#,##0.##" /></td>
										<td><fmt:formatNumber value="${sumPrice_time_mi}" pattern="#,##0.##" /></td>
										<td><fmt:formatNumber value="${sumPrice_traffic_mi}" pattern="#,##0.##" /></td>
										<td><fmt:formatNumber value="${sumPrice_question_mi}" pattern="#,##0.##" /></td>
										<td><fmt:formatNumber value="${sumPrice_receipt_mi}" pattern="#,##0.##" /></td>
										<td><font color="red"><fmt:formatNumber value="${sumSum_hap_mi}" pattern="#,##0.##" /></font></td>
										</tr>
										<!-- 미수금 합계 끝 -->
	                                </tbody>
	                            </table>
							</div>
