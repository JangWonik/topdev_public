<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

			<div class= "tableStyle2">
				<!-- 검색 결과 테이블 시작-->
				<table border="1">
					<thead>
						<tr>
							<th width="4%" bgcolor="#efefef">번호</th>
							<th width="4%" bgcolor="#efefef">이름</th>
							<th width="4%" bgcolor="#efefef">보고서<br />접수<br />(수임)</th>
							<th width="4%" bgcolor="#efefef">보고서<br />삭제</th>
							<th width="4%" bgcolor="#efefef">보고서<br />종결<br />(결재)<br />취소</th>
							<th width="4%" bgcolor="#efefef">보고서<br />잠금<br />해재</th>
							<th width="4%" bgcolor="#efefef">조사<br />보고서<br />엑셀<br />다운</th>
							<th width="4%" bgcolor="#efefef">총무<br />경리<br />열람</th>
							<th width="4%" bgcolor="#efefef">총무<br />경리<br />수정</th>
							<th width="4%" bgcolor="#efefef">보험사<br />정보<br />수정</th>
							<th width="4%" bgcolor="#efefef">관련<br />업체<br />엑셀<br />다운</th>
							<th width="4%" bgcolor="#efefef">보험사<br />공지<br />관리<br />(1종)</th>
							<th width="4%" bgcolor="#efefef">보험사<br />공지<br />관리<br />(4종)</th>
							<th width="4%" bgcolor="#efefef">팀관리</th>
							<th width="4%" bgcolor="#efefef">인사<br />기록</th>
							<th width="4%" bgcolor="#efefef">인사<br />평가<br />관리<br />권한</th>
							<th width="4%" bgcolor="#efefef">재직<br />증명서<br />승인</th>
							<th width="4%" bgcolor="#efefef">경비<br />내역<br />결재<br />&<br />취소</th>
							<th width="4%" bgcolor="#efefef">경비<br />내역<br />승인<br 6/>&<br />취소</th>
							<th width="4%" bgcolor="#efefef">적<br />부<br />워<br />드</th>
							<th width="4%" bgcolor="#efefef">응<br />답<br />전<br />문</th>
							<th width="4%" bgcolor="#efefef">통<br />계</th>
							<th width="4%" bgcolor="#efefef">수<br />정<br />자</th>
							<th width="4%" bgcolor="#efefef">변경일</th>
						</tr>
					</thead>
					
					<tbody id = "pmsLogTable">
					<c:forEach items="${pmsList}" var="pmsList" varStatus="pmsListStatus">
						<tr>
							<td>${pmsListStatus.count}</td>
							<td>${pmsList.user_name}</td>
							<td>${pmsList.mbr_pms_1}</td>
							<td>${pmsList.mbr_pms_3}</td>
							<td>${pmsList.mbr_pms_4}</td>
							<td>${pmsList.mbr_pms_5}</td>
							<td>${pmsList.mbr_pms_6}</td>
							<td>${pmsList.mbr_pms_7}</td>
							<td>${pmsList.mbr_pms_8}</td>
							<td>${pmsList.mbr_pms_9}</td>
							<td>${pmsList.mbr_pms_10}</td>
							<td>${pmsList.mbr_pms_11}</td>
							<td>${pmsList.mbr_pms_12}</td>
							<td>${pmsList.mbr_pms_13}</td>
							<td>${pmsList.mbr_pms_14}</td>
							<td>${pmsList.mbr_pms_15}</td>
							<td>${pmsList.mbr_pms_16}</td>
							<td>${pmsList.mbr_pms_17}</td>
							<td>${pmsList.mbr_pms_18}</td>
							<td>${pmsList.mbr_pms_19}</td>
							<td>${pmsList.mbr_pms_20}</td>
							<td>${pmsList.mbr_pms_21}</td>
							<td>${pmsList.reg_user}</td>
							<td>${pmsList.reg_date}</td>
						</tr>
					</c:forEach>
					
					</tbody>
					
				</table>
			</div><!-- //tableStyle2 -->
