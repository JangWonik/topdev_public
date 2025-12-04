<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="idmemberListContract" value="${idmemberListContract}" />

							<div class="tableStyle2">
								<table cellpadding="0" cellspacing="0" summary="팀&개인 기본통계 1종">
									<caption>팀&개인 기본통계 1종</caption>
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
									<tr style="bgcolor: #E7ECF1; text-align: center;">
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
								<c:set var="gubun" value="0"></c:set>
								<c:forEach var="vo" items="${idmemberListContract}" varStatus="status">
				                <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
				                	<c:choose>
				                		<c:when test="${gubun != vo.getGubun()}">
				                			<c:if test="${vo.getGubun() == 1}">
				                				<td rowspan="${myself}">본인 담당건</td>
				                				<c:set var="gubun" value="1"></c:set>
				                			</c:if>
				                			<c:if test="${vo.getGubun() == 2}">
				                				<td rowspan="${together}">공동 수행건</td>
				                				<c:set var="gubun" value="2"></c:set>
				                			</c:if>
				                		</c:when>
				                	</c:choose>
									<td><a href="./ls_report_pop?rid=${vo.getRid()}&report_id=${vo.getReport_id()}"><c:out value="${vo.getReport_id()}" /></td>
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
								</tr>
								</c:forEach>			               
				                <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">						
									<td bgcolor="#EFEFEF" colspan="2">합 계</td>							
									<td><c:out value="${summember2Contract.getPrice_assess()}"/></td>
									<td><c:out value="${summember2Contract.getPrice_time()}" /></td>
									<td><c:out value="${summember2Contract.getReport_ea()}" /></td>
									<td><c:out value="${summember2Contract.getP_price_mi_a()}" /></td>
									<td><c:out value="${summember2Contract.getP_price_mi_b()}" /></td>
									<td><c:out value="${summember2Contract.getReport_ea_mi()}" /></td>
									<td><c:out value="${summember2Contract.getP_price_pl_a()}" /></td>
									<td><c:out value="${summember2Contract.getP_price_pl_b()}" /></td>
									<td><c:out value="${summember2Contract.getReport_ea_pl()}" /></td>
									<td><c:out value="${summember2Contract.getSum_little()}" /></td>
									<td><c:out value="${summember2Contract.getPrice_traffic()}" /></td>
									<td><c:out value="${summember2Contract.getPrice_question()}" /></td>
									<td><c:out value="${summember2Contract.getPrice_receipt()}" /></td>
									<td><c:out value="${summember2Contract.getSum_hap()}" /></td>
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
                                <c:forEach var="vo" items="${mimemberListContract}" varStatus="status">
                                <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
                               		<td>-</td>
                                	<td><c:out value="${vo.getIg_nick()}" /></td>
                                	<td><c:out value="${vo.getReport_id()}" /></td>
                                	<td><c:out value="${vo.getIg_client()}" /></td>
                                	<td><c:out value="${vo.getIg_insured()}" /></td>
                                	<td><c:out value="${vo.getEnd_date()}" /></td>
                                	<td><fmt:formatNumber value="${vo.getPrice_assess()}" pattern="#,##0.##"/></td>
                                	<td><fmt:formatNumber value="${vo.getPrice_time()}" pattern="#,##0.##"/></td>
                                	<td><fmt:formatNumber value="${vo.getPrice_question()}" pattern="#,##0.##"/></td>                           	
                                	<td><fmt:formatNumber value="${vo.getPrice_traffic()}" pattern="#,##0.##"/></td>
                                	<td><fmt:formatNumber value="${vo.getPrice_receipt()}" pattern="#,##0.##"/></td>
                                	<td><fmt:formatNumber value="${vo.getSum_hap()}" pattern="#,##0.##"/></td>
                                	
                                </tr>
                                </c:forEach>
                                <!-- 미수금 합계 시작 -->
                                 <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">						
									<td bgcolor="#EFEFEF" colspan="6">미수금  합계</td>							
									<td><c:out value="${summimember2Contract.getPrice_assess()}"/></td>
									<td><c:out value="${summimember2Contract.getPrice_time()}" /></td>
									<td><c:out value="${summimember2Contract.getPrice_traffic()}" /></td>
									<td><c:out value="${summimember2Contract.getPrice_question()}" /></td>
									<td><c:out value="${summimember2Contract.getPrice_receipt()}" /></td>
									<td><c:out value="${summimember2Contract.getSum_hap()}" /></td>
								</tr>
								<!-- 미수금 합계 끝 -->
                                </tbody>
                            </table>
							</div>
						</div>
