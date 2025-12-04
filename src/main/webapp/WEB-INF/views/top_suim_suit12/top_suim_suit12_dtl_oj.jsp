<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script>
	
	
</script>

<input type="hidden" name="gbNoForPop" id="gbNoForPop" value="312" />
<input type="hidden" name="ptnrNoForPop" id="ptnrNoForPop" value="${getSuimSuit12DtlBsc.ptnrId}" />
<input type="hidden" name="smNoForPop" id="smNoForPop" value="${getSuimSuit12DtlBsc.suimRptNo}" />
<input type="hidden" name="tmNoForPop" id="tmNoForPop" value="${getSuimSuit12DtlBsc.teamId}" />

						<c:set var="suimRptNo" value="${suimRptNo}"/>
								
								<div class= "tableStyle21">
								<table>
								<colgroup>
									<col width="25%">
									<col width="75%">
								</colgroup>
							<c:forEach items="${getSuimSuit12DtlOj}" var="getSuimSuit12DtlOj" varStatus="status">
								<tr>
									<td bgcolor="#E4CAFF" colspan="2"><b>ㆍ목적물 ${status.count} 계약사항 </b></td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ목적물순번 ${getSuimSuit12DtlOj.getRqOj_OjSeqNo()}</b></td>
									<td>${getSuimSuit12DtlOj.getRqOj_OjSeqNo()}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ건물순번</b></td>
									<td>${getSuimSuit12DtlOj.getRqOj_BldSeqNo()}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ목적물부호</b></td>
									<td>${getSuimSuit12DtlOj.getRqOj_OjSign()}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ목적물유형</b></td>
									<td>${getSuimSuit12DtlOj.getRqOj_OjTp()}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ급수</b></td>
									<td>${getSuimSuit12DtlOj.getRqOj_Rnk()}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ세부사항</b></td>
									<td>${getSuimSuit12DtlOj.getRqOj_Dt_Mtt()}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ세부수용장소</b></td>
									<td>${getSuimSuit12DtlOj.getRqOj_Dt_AccptPlc()}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ수용장소구분</b></td>
									<td>
										<c:if test="${getSuimSuit12DtlOj.getRqOj_AccptPlcFlgCd() eq '1'}">건물내</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRqOj_AccptPlcFlgCd() eq '2'}">건물밖(야적)</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRqOj_AccptPlcFlgCd() eq '0' || getSuimSuit12DtlOj.getRqOj_AccptPlcFlgCd() eq ''}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ야적물건구분</b></td>
									<td>${getSuimSuit12DtlOj.getRqOj_FldstObjFlgCd()}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ지하수용여부</b></td>
									<td>
										<c:if test="${getSuimSuit12DtlOj.getRqOj_UndgAccptYn() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRqOj_UndgAccptYn() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRqOj_UndgAccptYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRqOj_UndgAccptYn() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ목적물유형 일치여부</b></td>
									<td>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_OjTpEqalYn() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_OjTpEqalYn() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_OjTpEqalYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_OjTpEqalYn() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ급수 일치여부</b></td>
									<td>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_RnkEqalYn() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_RnkEqalYn() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_RnkEqalYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_RnkEqalYn() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ세부사항 일치여부</b></td>
									<td>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_Dt_MttEqalYn() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_Dt_MttEqalYn() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_Dt_MttEqalYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_Dt_MttEqalYn() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ세부수용장소 일치여부</b></td>
									<td>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_Dt_AccptPlcEqalYn() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_Dt_AccptPlcEqalYn() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_Dt_AccptPlcEqalYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_Dt_AccptPlcEqalYn() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ수용장소구분 일치여부</b></td>
									<td>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_AccptPlcFlgcdEqalYn() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_AccptPlcFlgcdEqalYn() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_AccptPlcFlgcdEqalYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_AccptPlcFlgcdEqalYn() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ야적물건구분 일치여부</b></td>
									<td>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_FldstObjFlgcdEqalYn() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_FldstObjFlgcdEqalYn() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_FldstObjFlgcdEqalYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_FldstObjFlgcdEqalYn() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ지하수용여부 일치여부</b></td>
									<td>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_UndgAccptYnEqalYn() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_UndgAccptYnEqalYn() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_UndgAccptYnEqalYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlOj.getRstOj_UndgAccptYnEqalYn() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ기타의견</b></td>
									<td>
										${getSuimSuit12DtlOj.getRstOj_EtMtt()}
									</td>
								</tr>
							</c:forEach>
								
								
							</table>
						</div>
						
