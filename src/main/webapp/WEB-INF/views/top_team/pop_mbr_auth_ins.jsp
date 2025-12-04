<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<style>
		.btn-equipment-save {
			font-weight:bold;
			text-decoration:none;
			font-family:Arial;
			text-indent:0px;
			line-height:0px;
			-moz-border-radius:5px;
			-webkit-border-radius:5px;
			border-radius:5px;
			text-align:center;
			vertical-align:middle;
			display:inline-block;
			font-size:12px;
			color:#FFFFFF  !important;
			width:120px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #3399FF;		
		}
	</style>
	<div id="addMemoButton" style="text-align:left;padding:0px 0 5px 0;">
			<a href="#noloc" class="btn-equipment-save" id="btn-search" onclick="javascript:popMbrRptAuthDetail('${userNo}');">전산권한 세부설정</a>
	</div>
	<div class= "tableStyle2">
		<form id="authInsFrm" action="updateMbrAuth" method="post">
			<input type="hidden" name="tabGubun" id="tabGubun" value="authIns" />
			<input type="hidden" name="userNo" id="userNo" value="${userNo}" />
			<input type="hidden" name="pmsLength" id="pmsLength" value="${pmsLength}" />
			
			
			<!-- 검색 결과 테이블 시작-->
			<table>
				<tr bgcolor="#E7ECF1">
					<td width="30%" ><font color="red">전체 선택</font></td>
					<td width="70%">
						권한 없음 (<input type="radio" name = "authAllChk" onclick="fnAllChk(0);"/>)   
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						권한 있음 (<input type="radio" name = "authAllChk" onclick="fnAllChk(1);" />) 
					</td>
				</tr>
				<tr>
					<td width="30%" bgcolor="#efefef">보고서 접수(수임)</td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_1_0" name="mbr_pms_1" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_1_1" name="mbr_pms_1" value="1" /> 권한 있음
						<input type="hidden" id="pms1" value="${mbrAuth.mbr_pms_1}" />
					</td>
				</tr>
				<!--<tr>
					<td width="30%" bgcolor="#efefef">
						<a href="javascript:popMbrRptAuthDetail('${memberVo.user_no}');">보고서 편집 및 열람</a>
					</td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_2_0" name="pms2" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_2_1" name="pms2" value="1" /> 권한 있음
						<input type="hidden" id="pms2" value="${mbrAuth.mbr_pms_2}" />
					</td>
				</tr>-->
				<tr>
					<td width="30%" bgcolor="#efefef">보고서 삭제</td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_3_0" name="mbr_pms_3" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_3_1" name="mbr_pms_3" value="1" /> 권한 있음
						<input type="hidden" id="pms3" value="${mbrAuth.mbr_pms_3}" />
					</td>
				</tr>
				<tr>
					<td width="30%" bgcolor="#efefef">보고서 종결(결재) 취소</td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_4_0" name="mbr_pms_4" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_4_1" name="mbr_pms_4" value="1" /> 권한 있음
						<input type="hidden" id="pms4" value="${mbrAuth.mbr_pms_4}" />
					</td>
				</tr>
				<tr>
					<td width="30%" bgcolor="#efefef">보고서 잠금 해재</td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_5_0" name="mbr_pms_5" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_5_1" name="mbr_pms_5" value="1" /> 권한 있음
						<input type="hidden" id="pms5" value="${mbrAuth.mbr_pms_5}" />
					</td>
				</tr>
				<tr>
					<td width="30%" bgcolor="#efefef">조사보고서 엑셀다운</td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_6_0" name="mbr_pms_6" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_6_1" name="mbr_pms_6" value="1" /> 팀
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_6_2" name="mbr_pms_6" value="2" /> 지역본부
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_6_3" name="mbr_pms_6" value="3" /> 업종
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_6_4" name="mbr_pms_6" value="4" /> 전체
						<input type="hidden" id="pms6" value="${mbrAuth.mbr_pms_6}" />
					</td>
				</tr>
				<tr>
					<td width="30%" bgcolor="#efefef">총무경리 열람(인보이스)</td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_7_0" name="mbr_pms_7" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_7_1" name="mbr_pms_7" value="1" /> 팀
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_7_2" name="mbr_pms_7" value="2" /> 지역본부
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_7_3" name="mbr_pms_7" value="3" /> 업종
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_7_4" name="mbr_pms_7" value="4" /> 전체
						<input type="hidden" id="pms7" value="${mbrAuth.mbr_pms_7}" />
					</td>
				</tr>
				<tr>
					<td width="30%" bgcolor="#efefef">총무경리 수정(인보이스)</td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_8_0" name="mbr_pms_8" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_8_1" name="mbr_pms_8" value="1" /> 권한 있음
						<input type="hidden" id="pms8" value="${mbrAuth.mbr_pms_8}" />
					</td>
				</tr>
				<tr>
					<td width="30%" bgcolor="#efefef">보험사 정보 수정</td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_9_0" name="mbr_pms_9" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_9_1" name="mbr_pms_9" value="1" /> 권한 있음
						<input type="hidden" id="pms9" value="${mbrAuth.mbr_pms_9}" />
					</td>
				</tr>
				<tr>
					<td width="30%" bgcolor="#efefef">관련업체 엑셀다운</td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_10_0" name="mbr_pms_10" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_10_1" name="mbr_pms_10" value="1" /> 권한 있음
						<input type="hidden" id="pms10" value="${mbrAuth.mbr_pms_10}" />
					</td>
				</tr>
				<tr>
					<td width="30%" bgcolor="#efefef">보험사_공지관리(1종)</td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_11_0" name="mbr_pms_11" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_11_1" name="mbr_pms_11" value="1" /> 권한 있음
						<input type="hidden" id="pms11" value="${mbrAuth.mbr_pms_11}" />
					</td>
				</tr>
				<tr>
					<td width="30%" bgcolor="#efefef">보험사_공지관리(4종)</td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_12_0" name="mbr_pms_12" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_12_1" name="mbr_pms_12" value="1" /> 권한 있음
						<input type="hidden" id="pms12" value="${mbrAuth.mbr_pms_12}" />
					</td>
				</tr>
				<tr>
					<td width="30%" bgcolor="#efefef">팀관리</td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_13_0" name="mbr_pms_13" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_13_1" name="mbr_pms_13" value="1" /> 권한 있음
						<input type="hidden" id="pms13" value="${mbrAuth.mbr_pms_13}" />
					</td>
				</tr>
				<tr>
					<td width="30%" bgcolor="#efefef">인사기록</td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_14_0" name="mbr_pms_14" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_14_1" name="mbr_pms_14" value="1" /> 권한 있음
						<input type="hidden" id="pms14" value="${mbrAuth.mbr_pms_14}" />
					</td>
				</tr>
				<tr>
					<td width="30%" bgcolor="#efefef">인사평가 관리권한</td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_15_0" name="mbr_pms_15" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_15_1" name="mbr_pms_15" value="1" /> 권한 있음
						<input type="hidden" id="pms15" value="${mbrAuth.mbr_pms_15}" />
					</td>
				</tr>
				<tr>
					<td width="30%" bgcolor="#efefef">재직증명서 승인</td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_16_0" name="mbr_pms_16" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_16_1" name="mbr_pms_16" value="1" /> 권한 있음
						<input type="hidden" id="pms16" value="${mbrAuth.mbr_pms_16}" />
					</td>
				</tr>
				<tr>
					<td width="30%" bgcolor="#efefef">경비내역 결재&취소(top_cost)</td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_17_0" name="mbr_pms_17" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_17_1" name="mbr_pms_17" value="1" /> 권한 있음
						<input type="hidden" id="pms17" value="${mbrAuth.mbr_pms_17}" />
					</td>
				</tr>
				<tr>
					<td width="30%" bgcolor="#efefef">경비내역 승인&취소(top_cost)</td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_18_0" name="mbr_pms_18" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_18_1" name="mbr_pms_18" value="1" /> 권한 있음
						<input type="hidden" id="pms18" value="${mbrAuth.mbr_pms_18}" />
					</td>
				</tr>
				<tr>
					<td width="30%" bgcolor="#efefef">적부 워드전환</td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_19_0" name="mbr_pms_19" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_19_1" name="mbr_pms_19" value="1" /> 권한 있음
						<input type="hidden" id="pms19" value="${mbrAuth.mbr_pms_19}" />
					</td>
				</tr>
				<tr>
					<td width="30%" bgcolor="#efefef">응답 전문 출력</td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_20_0" name="mbr_pms_20" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_20_1" name="mbr_pms_20" value="1" /> 권한 있음
						<input type="hidden" id="pms20" value="${mbrAuth.mbr_pms_20}" />
					</td>
				</tr>
				<tr>
					<td width="30%" bgcolor="#efefef">통계</td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_21_0" name="mbr_pms_21" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_21_1" name="mbr_pms_21" value="1" /> 권한 있음
						<input type="hidden" id="pms21" value="${mbrAuth.mbr_pms_21}" />
					</td>
				</tr>
				<tr>
					<td width="30%" bgcolor="#efefef">당직 결재 권한</td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_22_0" name="mbr_pms_22" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_22_1" name="mbr_pms_22" value="1" /> 권한 있음
						<input type="hidden" id="pms22" value="${mbrAuth.mbr_pms_22}" />
					</td>
				</tr>
				<tr>
					<td width="30%" bgcolor="#efefef">당직 등록 권한</td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_23_0" name="mbr_pms_23" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_23_1" name="mbr_pms_23" value="1" /> 권한 있음
						<input type="hidden" id="pms23" value="${mbrAuth.mbr_pms_23}" />
					</td>
				</tr>
				
				<tr>
					<td width="30%" bgcolor="#efefef">보고서 알림 접근 권한</td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_24_0" name="mbr_pms_24" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_24_1" name="mbr_pms_24" value="1" /> 개인
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_24_2" name="mbr_pms_24" value="2" /> 팀
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_24_3" name="mbr_pms_24" value="3" /> 관리자
						<input type="hidden" id="pms24" value="${mbrAuth.mbr_pms_24}" />
						
					</td>
				</tr>			
				
				<tr>
					<td width="30%" bgcolor="#efefef">보고서 이첩 접근 권한</td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_25_0" name="mbr_pms_25" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_25_1" name="mbr_pms_25" value="1" /> 개인
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_25_2" name="mbr_pms_25" value="2" /> 팀장
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_25_3" name="mbr_pms_25" value="3" /> 센터장
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_25_4" name="mbr_pms_25" value="4" /> 관리자
						<input type="hidden" id="pms25" value="${mbrAuth.mbr_pms_25}" />
					</td>
				</tr>
				
				<tr>
					<td width="30%" bgcolor="#efefef">사내지침 글쓰기 권한</td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_26_0" name="mbr_pms_26" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_26_1" name="mbr_pms_26" value="1" /> 권한 있음
						<input type="hidden" id="pms26" value="${mbrAuth.mbr_pms_26}" />
					</td>
				</tr>
	
				<tr>
					<td width="30%" bgcolor="#efefef">강의실 결재 권한</td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_27_0" name="mbr_pms_27" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_27_1" name="mbr_pms_27" value="1" /> 권한 있음
						<input type="hidden" id="pms27" value="${mbrAuth.mbr_pms_27}" />
					</td>
				</tr>
				
				<tr>
					<td width="30%" bgcolor="#efefef">휴가 최종 확인 권한 / 최종확인자 표시여부 <input type="checkbox" id="mbr_pms_28_v" name="mbr_pms_28_v" value="1" <c:if test="${ mbrAuth.mbr_pms_28_v eq 1 }">checked</c:if>  /></td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_28_0" name="mbr_pms_28" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_28_1" name="mbr_pms_28" value="1" /> 1종
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_28_4" name="mbr_pms_28" value="4" /> 4종
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_28_5" name="mbr_pms_28" value="5" /> 전체 (1, 4) 종
						<input type="hidden" id="pms28" value="${mbrAuth.mbr_pms_28}" />						
					</td>
				</tr>
				
				<!-- 빠른 결재 (체크박스형식) 사용권한 -->
				<tr>
					<td width="30%" bgcolor="#efefef">빠른 결재(체크박스) 사용 권한</td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_29_0" name="mbr_pms_29" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_29_1" name="mbr_pms_29" value="1" /> 권한 있음
						<input type="hidden" id="pms29" value="${mbrAuth.mbr_pms_29}" />						
					</td>
				</tr>
				
				<!-- 전산권한결재 사용권한 -->
				<tr>
					<td width="30%" bgcolor="#efefef">전산권한요청 결재 권한</td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_30_0" name="mbr_pms_30" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_30_1" name="mbr_pms_30" value="1" /> 1종
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_30_4" name="mbr_pms_30" value="4" /> 4종
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_30_5" name="mbr_pms_30" value="5" /> 전체 (1, 4) 종
						<input type="hidden" id="pms30" value="${mbrAuth.mbr_pms_30}" />						
					</td>
				</tr>
				
				<!-- 보험사 보고서 양식 관리 권한 -->				
				<tr>
					<td width="30%" bgcolor="#efefef">보험사 보고서양식 관리 권한</td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_31_0" name="mbr_pms_31" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_31_1" name="mbr_pms_31" value="1" /> 1종
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_31_4" name="mbr_pms_31" value="4" /> 4종
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_31_5" name="mbr_pms_31" value="5" /> 전체 (1, 4) 종
						<input type="hidden" id="pms31" value="${mbrAuth.mbr_pms_31}" />						
					</td>
				</tr>
				
				<!-- 서면심사(물)실적관리 권한 -->
				
				<tr>
					<td width="30%" bgcolor="#efefef">서면심사(물)실적관리 권한</td>					
					<td width="70%">
						<input type="radio" id = "mbr_pms_32_0" name="mbr_pms_32" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_32_1" name="mbr_pms_32" value="1" /> 권한 있음
						<input type="hidden" id="pms32" value="${mbrAuth.mbr_pms_32}" />					
					</td>
				</tr>				
				
				<!-- 보고서검색 엑셀다운로드 권한-->
				<tr>
					<td width="30%" bgcolor="#efefef">보고서검색 엑셀다운로드 권한</td>					
					<td width="70%">
						<input type="radio" id = "mbr_pms_33_0" name="mbr_pms_33" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_33_1" name="mbr_pms_33" value="1" /> 권한 있음
						<input type="hidden" id="pms33" value="${mbrAuth.mbr_pms_33}" />					
					</td>
				</tr>
				
				<!-- 관리자 휴가신청 권한-->
				<tr>
					<td width="30%" bgcolor="#efefef">관리자 휴가신청 권한</td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_34_0" name="mbr_pms_34" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_34_1" name="mbr_pms_34" value="1" /> 1종
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_34_4" name="mbr_pms_34" value="4" /> 4종
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_34_5" name="mbr_pms_34" value="5" /> 전체 (1, 4) 종
						<input type="hidden" id="pms34" value="${mbrAuth.mbr_pms_34}" />						
					</td>
				</tr>
				
				<!-- 통화내역 조회권한 -->
				<tr>
					<td width="30%" bgcolor="#efefef">통화내역 조회권한</td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_35_0" name="mbr_pms_35" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_35_1" name="mbr_pms_35" value="1" /> 권한 있음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_35_2" name="mbr_pms_35" value="2" /> 관리자 권한
						<input type="hidden" id="pms35" value="${mbrAuth.mbr_pms_35}" />						
					</td>
				</tr>
				
				<!-- 교육 조회 권한-->
				<tr>
					<td width="30%" bgcolor="#efefef">교육 조회 권한</td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_36_0" name="mbr_pms_36" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_36_1" name="mbr_pms_36" value="1" /> 1종
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_36_4" name="mbr_pms_36" value="4" /> 4종
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_36_5" name="mbr_pms_36" value="5" /> 전체 (1, 4) 종
						<input type="hidden" id="pms36" value="${mbrAuth.mbr_pms_36}" />						
					</td>
				</tr>
				
				<!-- 계약서관리 조회 권한-->
				<tr>
					<td width="30%" bgcolor="#efefef">계약서관리 조회권한</td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_37_0" name="mbr_pms_37" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_37_1" name="mbr_pms_37" value="1" /> 1종
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_37_4" name="mbr_pms_37" value="4" /> 4종
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_37_5" name="mbr_pms_37" value="5" /> 전체 (1, 4) 종
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_37_9" name="mbr_pms_37" value="9" /> 관리자 권한
						<input type="hidden" id="pms37" value="${mbrAuth.mbr_pms_37}" />						
					</td>
				</tr>
				
				<!-- 현장보고서 로그인 팝업 조회권한 -->
				<tr>
					<td width="30%" bgcolor="#efefef">현장보고서 팝업조회권한</td>					
					<td width="70%">
						<input type="radio" id = "mbr_pms_38_0" name="mbr_pms_38" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_38_1" name="mbr_pms_38" value="1" /> 권한 있음
						<input type="hidden" id="pms38" value="${mbrAuth.mbr_pms_38}" />					
					</td>
				</tr>
				
				<!-- 물보험 자료실 등록 수정권한 -->
				<tr>
					<td width="30%" bgcolor="#efefef">물보험 자료실 관리자 권한</td>					
					<td width="70%">
						<input type="radio" id = "mbr_pms_39_0" name="mbr_pms_39" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_39_1" name="mbr_pms_39" value="1" /> 권한 있음
						<input type="hidden" id="pms39" value="${mbrAuth.mbr_pms_39}" />					
					</td>
				</tr>
				
				<!-- 인사 메뉴 사용권한 시작 -->
				<tr>
					<td width="30%" bgcolor="#efefef">(인사관리) 발령,진급 및 휴직</td>					
					<td width="70%">
						<input type="radio" id = "mbr_pms_40_0" name="mbr_pms_40" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_40_1" name="mbr_pms_40" value="1" /> 권한 있음
						<input type="hidden" id="pms40" value="${mbrAuth.mbr_pms_40}" />					
					</td>
				</tr>
				
				<tr>
					<td width="30%" bgcolor="#efefef">(인사관리) 상벌사항</td>					
					<td width="70%">
						<input type="radio" id = "mbr_pms_41_0" name="mbr_pms_41" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_41_1" name="mbr_pms_41" value="1" /> 권한 있음
						<input type="hidden" id="pms41" value="${mbrAuth.mbr_pms_41}" />					
					</td>
				</tr>
				
				<tr>
					<td width="30%" bgcolor="#efefef">(인사관리) 경력 및 자격</td>					
					<td width="70%">
						<input type="radio" id = "mbr_pms_42_0" name="mbr_pms_42" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_42_1" name="mbr_pms_42" value="1" /> 권한 있음
						<input type="hidden" id="pms42" value="${mbrAuth.mbr_pms_42}" />					
					</td>
				</tr>
				
				<tr>
					<td width="30%" bgcolor="#efefef">(인사관리) 교육 및 강의이력</td>					
					<td width="70%">
						<input type="radio" id = "mbr_pms_43_0" name="mbr_pms_43" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_43_1" name="mbr_pms_43" value="1" /> 권한 있음
						<input type="hidden" id="pms43" value="${mbrAuth.mbr_pms_43}" />					
					</td>
				</tr>
				
				<tr>
					<td width="30%" bgcolor="#efefef">(인사관리) 학력 및 가족관계</td>					
					<td width="70%">
						<input type="radio" id = "mbr_pms_44_0" name="mbr_pms_44" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_44_1" name="mbr_pms_44" value="1" /> 권한 있음
						<input type="hidden" id="pms44" value="${mbrAuth.mbr_pms_44}" />					
					</td>
				</tr>
				<!-- 인사 메뉴 사용권한 끝 -->
				
				<!-- (실적관리) 성과급 조회 권한 시작 -->
				<tr>
					<td width="30%" bgcolor="#efefef">(실적관리) 성과급 로그조회</td>					
					<td width="70%">
						<input type="radio" id = "mbr_pms_45_0" name="mbr_pms_45" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_45_1" name="mbr_pms_45" value="1" /> 권한 있음
						<input type="hidden" id="pms45" value="${mbrAuth.mbr_pms_45}" />					
					</td>
				</tr>
				<!-- (실적관리) 성과급 조회 권한 끝 -->
				
				<!-- 기본통계(전체) 조회기능 시작 -->
				<tr>
					<td width="30%" bgcolor="#efefef">기본통계(전체) 조회권한</td>					
					<td width="70%">
						<input type="radio" id = "mbr_pms_46_0" name="mbr_pms_46" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_46_1" name="mbr_pms_46" value="1" /> 권한 있음
						<input type="hidden" id="pms46" value="${mbrAuth.mbr_pms_46}" />					
					</td>
				</tr>
				<!-- 기본통계(전체) 조회기능 끝 -->
				<!-- 보험사별 손해사정서 교부현황 조회 권한시작 -->
				<tr>
					<td width="30%" bgcolor="#efefef">보험사별 손해사정서 교부현황조회</td>
					<td width="70%">
						<input type="radio" id = "mbr_pms_47_0" name="mbr_pms_47" value="0" /> 권한 없음
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_47_1" name="mbr_pms_47" value="1" /> 1종
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_47_4" name="mbr_pms_47" value="4" /> 4종
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" id = "mbr_pms_47_5" name="mbr_pms_47" value="5" /> 전체 (1, 4) 종
						<input type="hidden" id="pms47" value="${mbrAuth.mbr_pms_47}" />						
					</td>
				</tr>
				<!-- 보험사별 손해사정서 교부현황 조회 끝 -->				
				<tr>
					<td colspan="2">
						<img src="./resources/ls_img/btn_edite.gif" alt="수정" id ="authEditeBtn" onclick="submit();" style ="cursor:pointer;"/>
					</td>
				</tr>
				
			</table>
		</form>
		
		<script>
		
			$(document).ready(function(){
				_initAuthInsView();
			});
			
			function popMbrRptAuthDetail(user_no){
				var cw=screen.availWidth;
				var ch=screen.availHeight;
				var sw=1010; //띄울 창의 넓이
				var sh=900;  //띄울 창의 높이
				var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
				var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
				window.open('popMbrAuth2Dtl?user_no='+user_no,'MbrRptAuth','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			}
			
			function _initAuthInsView(){
				var pmsLength = $("#pmsLength").val();
				
				for(var i=1; i<=pmsLength ;i++){
					var authValue = $("#pms"+i).val();
					
					if( authValue != "" ){
						$("input:radio[name='mbr_pms_"+i+"']:radio[value="+authValue+"]").prop("checked",true);		
					}else{
						$("input:radio[name='mbr_pms_"+i+"']:radio[value=0]").prop("checked",true);
					}
				}
			}			
			
			function fnAllChk(val){
				var pmsLength = $("#pmsLength").val();
				var authValue = 0;
				if (val == 1){
					authValue = 1;										
				}
				
				for(var i=1; i<=pmsLength ;i++){
					$("input:radio[name='mbr_pms_"+i+"']:radio[value="+authValue+"]").prop("checked",true);		
				}
				
			}
			
		</script>
	</div>
