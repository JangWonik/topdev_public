<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

	<div class= "tableStyle2">

		<!-- 검색 결과 테이블 시작-->
		<table>
			<thead>
				<tr>
					<th width="3.5%" bgcolor="#efefef">보고서<br />접수<br />(수임)</th>
					<th width="3.5%" bgcolor="#efefef">보고서<br />삭제</th>
					<th width="3.5%" bgcolor="#efefef">보고서<br />종결<br />(결재)<br />취소</th>
					<th width="3.5%" bgcolor="#efefef">보고서<br />잠금<br />해재</th>
					<th width="3.5%" bgcolor="#efefef">조사<br />보고서<br />엑셀<br />다운</th>
					<th width="3.5%" bgcolor="#efefef">총무<br />경리<br />열람</th>
					<th width="3.5%" bgcolor="#efefef">총무<br />경리<br />수정</th>
					<th width="3.5%" bgcolor="#efefef">보험사<br />정보<br />수정</th>
					<th width="3.5%" bgcolor="#efefef">관련<br />업체<br />엑셀<br />다운</th>
					<th width="3.5%" bgcolor="#efefef">보험사<br />공지<br />관리<br />(1종)</th>
					<th width="3.5%" bgcolor="#efefef">보험사<br />공지<br />관리<br />(3.5종)</th>
					<th width="3.5%" bgcolor="#efefef">팀관리</th>
					<th width="3.5%" bgcolor="#efefef">인사<br />기록</th> 
					<th width="3.5%" bgcolor="#efefef">인사<br />평가<br />관리<br />권한</th>
					<th width="3.5%" bgcolor="#efefef">재직<br />증명서<br />승인</th>
					<th width="3.5%" bgcolor="#efefef">경비<br />내역<br />결재<br />&<br />취소</th>
					<th width="3.5%" bgcolor="#efefef">경비<br />내역<br />승인<br />&<br />취소</th>
					<th width="3.5%" bgcolor="#efefef">적<br />부<br />워<br />드</th>
					<th width="3.5%" bgcolor="#efefef">응<br />답<br />전<br />문</th>
					<th width="3.5%" bgcolor="#efefef">통<br />계</th>
					<th width="3.5%" bgcolor="#efefef">당직<br/>결재</th>
					<th width="3.5%" bgcolor="#efefef">당직<br/>등록</th>					
					<th width="3.5%" bgcolor="#efefef">알림</th>
					<th width="3.5%" bgcolor="#efefef">이첩</th>
					<th width="3.5%" bgcolor="#efefef">사내지침</th>
					<th width="3.5%" bgcolor="#efefef">강<br />의<br />실</th>
					<th width="3.5%" bgcolor="#efefef">휴<br/>가<br/>결<br/>재<br/></th>
					<th width="3.5%" bgcolor="#efefef">빠른결재</th>
					<th width="3.5%" bgcolor="#efefef">전산권한결재</th>
					<th width="3.5%" bgcolor="#efefef">보험사양식관리</th>
					<th width="3.5%" bgcolor="#efefef">서면심사(물)실적관리</th>
					<th width="3.5%" bgcolor="#efefef">보고서검색후엑셀다운로드</th>
					<th width="3.5%" bgcolor="#efefef">관리자휴가신청권한</th>
					<th width="3.5%" bgcolor="#efefef">통화내역조회권한</th>
					<th width="3.5%" bgcolor="#efefef">교육조회권한</th>
					<th width="3.5%" bgcolor="#efefef">계약관리조회권한</th>
					<th width="3.5%" bgcolor="#efefef">현장보고서 팝업조회권한</th>
					<th width="3.5%" bgcolor="#efefef">물보험 자료실 관리자 권한</th>
					<th width="3.5%" bgcolor="#efefef">성과급 로그조회 권한</th>
					<th width="3.5%" bgcolor="#efefef">기본통계(전체) 조회권한</th>
					<th width="3.5%" bgcolor="#efefef">보험사별손해사정서조회권한</th>
					<th width="3.5%" bgcolor="#efefef">수<br />정<br />자</th>					
					<th width="3.5%" bgcolor="#efefef">변경일</th>
				</tr>
			</thead>
			
			<tbody id = "authListTable">
				<c:forEach items="${mbrAuthLogList}" var="item" varStatus="status">
					<tr>
						<td>${item.mbr_pms_1}</td>
						<td>${item.mbr_pms_3}</td>
						<td>${item.mbr_pms_4}</td>
						<td>${item.mbr_pms_5}</td>
						<td>${item.mbr_pms_6}</td>
						<td>${item.mbr_pms_7}</td>
						<td>${item.mbr_pms_8}</td>
						<td>${item.mbr_pms_9}</td>
						<td>${item.mbr_pms_10}</td>
						<td>${item.mbr_pms_11}</td>
						<td>${item.mbr_pms_12}</td>
						<td>${item.mbr_pms_13}</td>
						<td>${item.mbr_pms_14}</td>
						<td>${item.mbr_pms_15}</td>
						<td>${item.mbr_pms_16}</td>
						<td>${item.mbr_pms_17}</td>
						<td>${item.mbr_pms_18}</td>
						<td>${item.mbr_pms_19}</td>
						<td>${item.mbr_pms_20}</td>
						<td>${item.mbr_pms_21}</td>
						<td>${item.mbr_pms_22}</td>
						<td>${item.mbr_pms_23}</td>
						<td>${item.mbr_pms_24}</td>
						<td>${item.mbr_pms_25}</td>
						<td>${item.mbr_pms_26}</td>
						<td>${item.mbr_pms_27}</td>
						<td>${item.mbr_pms_28}</td>
						<td>${item.mbr_pms_29}</td>
						<td>${item.mbr_pms_30}</td>
						<td>${item.mbr_pms_31}</td>
						<td>${item.mbr_pms_32}</td>
						<td>${item.mbr_pms_33}</td>
						<td>${item.mbr_pms_34}</td>
						<td>${item.mbr_pms_35}</td>
						<td>${item.mbr_pms_36}</td>
						<td>${item.mbr_pms_37}</td>
						<td>${item.mbr_pms_38}</td>
						<td>${item.mbr_pms_39}</td>
						<td>${item.mbr_pms_45}</td>
						<td>${item.mbr_pms_46}</td>
						<td>${item.mbr_pms_47}</td>
						<td>${item.reg_user}</td>
						<td>${item.reg_date}</td>
					</tr>
				</c:forEach>			
			</tbody>
			
		</table>

	</div>

