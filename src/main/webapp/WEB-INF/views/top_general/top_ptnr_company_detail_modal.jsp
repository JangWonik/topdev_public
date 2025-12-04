<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link href="./resources/select2/select2.min.css" rel="stylesheet" />
<script src="./resources/select2/select2.min.js"></script>
	<style>
		.td-overflow-none{
			text-overflow : ellipsis;
			overflow : hidden;
			white-space : nowrap;
			word-wrap:normal;
		}
		/* 모달창 셀렉트 박스 */
		.select2-container--default{
			text-align : left;
			font-color:#444;
			font-size:12px;
		}
		
		.buttonMiniView{
			width:120px;
			height:20px;
		    background-color:#F7F7F7;
		    color:#666;
		    text-align: center;
			border-radius:5px;
		    font-size: 11px;
		    cursor: pointer;
		    text-decoration:none;
		    border: solid 1px grey;		    
		}		
	</style>
	<script>
	$(document).ready( function(){
		
	});		
	</script>		
		<div id="ptnr-company-detail-dialog" title="관련업체 회사정보조회" style="font-size: 12px;" align="center">
			<div class="tableStyle2" style="width: 775px;">
				<table class="vacation-ins-table">
					<colgroup>
					<col width="15%"/>
					<col width="35%"/>
					<col width="15%"/>
					<col width="35%"/>															
					</colgroup>					
				<tbody>
					<tr>
						<th height="25px;">회사구분</th>
						<td style="text-align:left;padding-left:5px;">
							<c:choose>
								<c:when test="${ptnrCompanyInfo.ptnr_type eq 1}">손해보험</c:when>
								<c:when test="${ptnrCompanyInfo.ptnr_type eq 2}">생명보험</c:when>
								<c:when test="${ptnrCompanyInfo.ptnr_type eq 3}">협회</c:when>
								<c:when test="${ptnrCompanyInfo.ptnr_type eq 4}">공제</c:when>
								<c:when test="${ptnrCompanyInfo.ptnr_type eq 5}">기타</c:when>
							</c:choose>							
						</td>
						<th height="25px;">로고</th>
						<td style="text-align:left;padding-left:5px;">
							<c:if test="${not empty ptnrCompanyInfo.ptnr_img_small}">							
								<img src="https://www.toplac.co.kr/home/hosting_users/toplac/www/ls_data/ig/small/${ptnrCompanyInfo.ptnr_img_small}" width="75px" height="15px" border=0>
							</c:if>
						</td>
					</tr>
					<tr>
						<th height="25px;">회사명</th>
						<td style="text-align:left;padding-left:5px;">	${ptnrCompanyInfo.ptnr_name}</td>
						<th height="25px;">대표성명</th>
						<td style="text-align:left;padding-left:5px;">	${ptnrCompanyInfo.ptnr_ceo_nm}</td>
					</tr>
					<tr>
						<th height="25px;">사업자번호</th>
						<td style="text-align:left;padding-left:5px;">${ptnrCompanyInfo.ptnr_biz_reg_no}</td>
						<th height="25px;">고객센터</th>
						<td style="text-align:left;padding-left:5px;">${ptnrCompanyInfo.ptnr_tel}</td>
					</tr>
					<tr>
						<th height="25px;">업태</th>
						<td style="text-align:left;padding-left:5px;">${ptnrCompanyInfo.ptnr_biz_type1}</td>
						<th height="25px;">업종</th>
						<td style="text-align:left;padding-left:5px;">${ptnrCompanyInfo.ptnr_biz_type2}</td>
					</tr>
					<tr>
						<th height="25px;">주소</th>
						<td colspan="3" style="text-align:left;padding-left:5px;">
							${ptnrCompanyInfo.ptnr_postcode} ${ptnrCompanyInfo.ptnr_addr1} ${ptnrCompanyInfo.ptnr_addr2} ${ptnrCompanyInfo.ptnr_addr} 
						</td>						
					</tr>
					<tr>
						<th height="25px;">홈페이지</th>
						<td colspan="3" style="text-align:left;padding-left:5px;">
							<c:if test="${not empty ptnrCompanyInfo.ptnr_homepage}">
								${ptnrCompanyInfo.ptnr_homepage}&nbsp;
								<a href="${ptnrCompanyInfo.ptnr_homepage}" target="_blank">
									<input type="button" class="buttonMiniView" value="홈페이지 바로가기">
								</a>
							</c:if>
						</td>						
					</tr>
					<tr>
						<th height="25px;">PRM주소</th>						
						<td colspan="3" style="text-align:left;padding-left:5px;">
							<c:if test="${not empty ptnrCompanyInfo.ptnr_url}">
								${ptnrCompanyInfo.ptnr_url}&nbsp;
								<a href="${ptnrCompanyInfo.ptnr_url}" target="_blank">
									<input type="button" class="buttonMiniView" value="PRM 바로가기">
								</a>
							</c:if>							
						</td>						
					</tr>					
				</tbody>
				</table>
			</div>
		</div>