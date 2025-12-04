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
								<c:forEach items="${getSuimSuit12DtlBld}" var="getSuimSuit12DtlBld" varStatus="status">
								<tr>
									<td bgcolor="#E4CAFF" colspan="2"><b>ㆍ건물 ${status.index + 1} 계약사항</b></td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ소재지코드</b></td>
									<td>${getSuimSuit12DtlBld.getRqBld_LctNo()}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ목적물순번</b></td>
									<td>${getSuimSuit12DtlBld.getRqBld_OjSeqNo()}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ건물순번</b></td>
									<td>${getSuimSuit12DtlBld.getRqBld_BldSeqNo()}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ실제소유자</b></td>
									<td>${getSuimSuit12DtlBld.getRqBld_RlOwrNm()}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ소재지주소</b></td>
									<td>${getSuimSuit12DtlBld.getRqBld_CtnAdr()}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ영위업종명</b></td>
									<td>${getSuimSuit12DtlBld.getRqBld_MngmBnNm()}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ건물 급수</b></td>
									<td>${getSuimSuit12DtlBld.getRqBld_BldRnkCd()}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ건물 기둥</b></td>
									<td>${getSuimSuit12DtlBld.getRqBld_PleNm()}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ건물 지붕</b></td>
									<td>${getSuimSuit12DtlBld.getRqBld_RofNm()}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ건물 외벽</b></td>
									<td>${getSuimSuit12DtlBld.getRqBld_WllNm()}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ건물규모 지상(층)</b></td>
									<td>${getSuimSuit12DtlBld.getRqBld_Grod()}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ건물규모 지하(층)</b></td>
									<td>${getSuimSuit12DtlBld.getRqBld_Undg()}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ건물규모 연면적</b></td>
									<td>${getSuimSuit12DtlBld.getRqBld_Ttare()}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ건물규모 가입면적</b></td>
									<td>${getSuimSuit12DtlBld.getRqBld_IsAre()}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ건물규모 가입유형</b></td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRqBld_IsTp() eq '01'}">전치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRqBld_IsTp() eq '02'}">일부</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRqBld_IsTp() eq '0' || getSuimSuit12DtlBld.getRqBld_IsTp() eq ''}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ건물규모 건물설명</b></td>
									<td>${getSuimSuit12DtlBld.getRqBld_BldXpNm()}</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ실사자</b></td>
									<td></td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ실사일자</b></td>
									<td>${getSuimSuit12DtlBld.getRstBld_RcnDt()}</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ업체명</b></td>
									<td></td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ면담자명</b></td>
									<td>${getSuimSuit12DtlBld.getRstBld_InvpsNm()}</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ계약자와의관계</b></td>
									<td>${getSuimSuit12DtlBld.getRstBld_CrRelpcRel()}</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ면담자연락처</b></td>
									<td>${getSuimSuit12DtlBld.getRstBld_InvpsCntAd()}</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ실제소유자 일치여부</b></td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_RlOwrNm() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_RlOwrNm() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_RlOwrNm() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_RlOwrNm() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ소재지주소 일치여부</b></td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_CtnAdr() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_CtnAdr() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_CtnAdr() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_CtnAdr() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ영위업종명 일치여부</b></td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_MngmBnNm() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_MngmBnNm() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_MngmBnNm() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_MngmBnNm() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ건물급수 일치여부</b></td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_BldRnkCd() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_BldRnkCd() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_BldRnkCd() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_BldRnkCd() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ건물규모 지상(층) 일치여부</b></td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_GrodEqalYn() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_GrodEqalYn() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_GrodEqalYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_GrodEqalYn() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ건물규모 지하(층) 일치여부</b></td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_UndgEqalYn() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_UndgEqalYn() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_UndgEqalYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_UndgEqalYn() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ건물규모 연면적(㎡) 일치여부</b></td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_TtareEqalYn() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_TtareEqalYn() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_TtareEqalYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_TtareEqalYn() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ건물규모 가입면적 일치여부</b></td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_IsAreEqalYn() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_IsAreEqalYn() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_IsAreEqalYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_IsAreEqalYn() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ건물규모 가입유형 일치여부</b></td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_IsTpEqalYn() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_IsTpEqalYn() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_IsTpEqalYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_IsTpEqalYn() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ실제소유자 기타의견</b></td>
									<td>${getSuimSuit12DtlBld.getRstBld_RlOwrNmEtMtt()}</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ소재지주소 기타의견</b></td>
									<td>${getSuimSuit12DtlBld.getRstBld_CtnAdrEtMtt()}</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ영위업종명 기타의견</b></td>
									<td>${getSuimSuit12DtlBld.getRstBld_MngmBnnmEtMtt()}</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ건물급수 기타의견</b></td>
									<td>${getSuimSuit12DtlBld.getRstBld_BldRnkcdEtMtt()}</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ건물규모 지상(층) 기타의견</b></td>
									<td>${getSuimSuit12DtlBld.getRstBld_GrodEtMtt()}</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ건물규모 지하(층) 기타의견</b></td>
									<td>${getSuimSuit12DtlBld.getRstBld_UndgEtMtt()}</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ건물규모 연면적(㎡) 기타의견</b></td>
									<td>${getSuimSuit12DtlBld.getRstBld_TtareEtMtt()}</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ건물규모 가입면적 기타의견</b></td>
									<td>${getSuimSuit12DtlBld.getRstBld_IsAreEtMtt()}</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ건물규모 가입유형 기타의견</b></td>
									<td>${getSuimSuit12DtlBld.getRstBld_IsTpEtMtt()}</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ건물구조 기둥 일치여부</b></td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_PleNm() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_PleNm() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_PleNm() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_PleNm() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ건물구조 지붕 일치여부</b></td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_RofNm() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_RofNm() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_RofNm() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_RofNm() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ건물구조 외벽 일치여부</b></td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_WllNm() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_WllNm() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_WllNm() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_WllNm() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ판넬 유무</b></td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_PanlYn() eq '1'}">유</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_PanlYn() eq '2'}">무</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_PanlYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_PanlYn() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ판넬 위치</b></td>
									<td>${getSuimSuit12DtlBld.getRstBld_PanlPst()}</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ천막 유무</b></td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_TntYn() eq '1'}">유</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_TntYn() eq '2'}">무</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_TntYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_TntYn() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ천막 위치</b></td>
									<td>${getSuimSuit12DtlBld.getRstBld_TntPst()}</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ층별방화구획유무</b></td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_FlrFirZoneYn() eq '1'}">유</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_FlrFirZoneYn() eq '2'}">무</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_FlrFirZoneYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_FlrFirZoneYn() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ기타의견1(확인의견)</b></td>
									<td>${getSuimSuit12DtlBld.getRstBld_EtMtt1()}</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ층별업종 지하</b></td>
									<td>${getSuimSuit12DtlBld.getRstBld_FlrBtpUndg()}</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ층별업종 1층</b></td>
									<td>${getSuimSuit12DtlBld.getRstBld_FlrBtpFloor1()}</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ층별업종 2층</b></td>
									<td>${getSuimSuit12DtlBld.getRstBld_FlrBtpFloor2()}</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ층별업종 3층</b></td>
									<td>${getSuimSuit12DtlBld.getRstBld_FlrBtpFloor3()}</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ판매시설 상설할인유무</b></td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_SlEqmtDcYn() eq '1'}">유</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_SlEqmtDcYn() eq '2'}">무</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_SlEqmtDcYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_SlEqmtDcYn() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ판매시설 재래시장유무</b></td>
									<td>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_MrkYn() eq '1'}">유</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_MrkYn() eq '2'}">무</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_MrkYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_MrkYn() eq '0'}"></c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ기타의견2(종합의견)</b></td>
									<td>${getSuimSuit12DtlBld.getRstBld_EtMtt2()}</td>
								</tr>
								</c:forEach>
								
								
							</table>
						</div>
						
