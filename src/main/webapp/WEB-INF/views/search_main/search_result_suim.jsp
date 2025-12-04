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

			$("#mainSearchSuimExcelBtn").click(function(){
				$("#tmGubun").val($("#tmSearch option:selected").text().indexOf("└"));
				$("#ptnrGubun").val($("#ptnrSearch option:selected").text().indexOf("└"));				
				//다운로드시 대상항목 체크
				//alert('suimRptListTotCntVal='+$("#suimRptListTotCntVal").val());
				var nTotalCnt = $("#suimRptListTotCntVal").val();
				if( '${mbrVo_Session.user_no}' != '1786' && $("#suimRptListTotCntVal").val() > 10000){
					alert('다운로드 대상 건수가 10,000 건 이상입니다. \n검색결과를 10,000건 이하로 줄이고 다운로드하세요.');
					return;
				}				
				
				$("#searchMainQueryForm").attr("action","searchMainQuerySuimExcel");				
				searchMainQueryForm.submit();
			});
			
			/** 20171218 위임취소 엑셀다운 추가 by. lds **/
			$("#mainSearchCancelExcelBtn").click(function(){
				$("#tmGubun").val($("#tmSearch option:selected").text().indexOf("└"));
				$("#ptnrGubun").val($("#ptnrSearch option:selected").text().indexOf("└"));
				$("#searchMainQueryForm").attr("action","searchMainQueryCancelExcel");
				searchMainQueryForm.submit();
			});			
		});		

		function popSuimDtl(suim_rpt_no, delDate){
			if(delDate < 0){
				alert("삭제된 보고서 입니다.");
				return;
			}	
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1010; //띄울 창의 넓이
			//var sh=screen.availHeight;  //띄울 창의 높이 740
			var sh=780;  //띄울 창의 높이 740 (780으로 조정 by top3009)
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			//창띄우기 전에 스크립트 초기화 by top3009			
			localStorage.setItem('activeTab','1');
			window.open('suimRptBscDtl?suim_rpt_no='+suim_rpt_no, suim_rpt_no,'width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=yes,scrollbars=yes');
		}

		function reqPgNoClickSuim(pgNo){
			searchMainPagingForm.reqPgNo.value = pgNo;
			searchMainPagingForm.presentPage.value = "suimrpttab";
			searchMainPagingForm.submit();
		}
		
		function doSagoView(suim_rpt_no){			
			
			var url = "sagoDetailNewModal";		//상세내역페이지
			//var url = "/vacationDetailNewModal";		//상세내역페이지
			var param = {};
			param.suim_rpt_no = suim_rpt_no;			
											
		    $.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        dataType: "HTML", 
		        success: function(data){
		        	$("#sago-detail-dialog").html();
		        	$("#sago-detail-dialog").html(data);
					$("#sago-detail-dialog").dialog({
						height: 580,
						width: 800,
						closeOnEscape : true,
						draggable : true,
						title: "사고처리과정표 상세",
						//buttons : modalButtons,
						modal: true,
						buttons:{						
							"닫기" : function(){
								$(this).dialog("close");
							}
						},
						overlay:{ opacity: 0., background: '#000000'}
					});		
		        },
		        error: function(e){
		            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		        }
		    });
		}
	</script>
			<!-- 엑셀다운로드는 권한이있는 직원만 가능하도록 변경 by top3009 -->
			<c:if test="${mbrAuthVo_Session.mbr_pms_33 eq '1'}">
			<p style="margin-bottom:1px;text-align:right;">			
				<c:choose>
					<c:when test="${searchVO.stateSearch == 32 or searchVO.stateSearch == 33}">
						<img src="./resources/ls_img/ls_invoice/btn_excel.gif" style='cursor:pointer;' id="mainSearchCancelExcelBtn" />
					</c:when>
					<c:otherwise>
						<img src="./resources/ls_img/ls_invoice/btn_excel.gif" style='cursor:pointer;' id="mainSearchSuimExcelBtn" />
					</c:otherwise>
				</c:choose>
			</p>
			</c:if>

							<div class= "tableStyle2">
								<table class="srchResultTable">
									<colgroup>
										<col style="width:3%;" />
										<col style="width:2%;" />
										<col style="width:5%;" />
										<col style="width:7%;" />
										<col style="width:6%;" />
										<col style="width:6%;" />
										<col style="width:7%;" />
										<col style="width:5%;" />
										<col style="width:5%;" />
										<col style="width:5%;" />
										<col style="width:8%;" />
										<col style="width:8%;" />
										<col style="width:8%;" />
										<col style="width:5%;" />
										<col style="width:5%;" />
										<col style="width:5%;" />
										<col style="width:5%;" />
										<col style="width:5%;" />
									</colgroup>
									<thead>
										<tr>
											<th>no.</th>
											<th>-</th>
											<th>구분</th>
											<th>접수번호</th>
											<th>종결번호</th>
											<th>보험사</th>
											<th>보험팀</th>
											<th>보험담당</th>
											<th>처리팀</th>
											<th>담당자</th>
											<th>계약자</th>
											<th>피보험자</th>
											<th>피해자</th>
											<th>사고</th>
											<th>수임</th>
											<th>현장</th>
											<th>중간</th>
											<th>상태</th>
										</tr>
									</thead>
									<tbody>
										<!--  -->
										<c:forEach items="${suimBookList}" var="suimVO" varStatus="status" > <!-- begin="1" end="20" step="1" -->
										
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
										style ="cursor:pointer;" onclick="popSuimDtl('${suimVO.suim_rpt_no}', '${suimVO.delDate}')"
										<c:choose>
											<c:when test="${ empty suimVO.deposit_date_fmt}">title='입금일 정보없음'</c:when>
											<c:otherwise>title='입금일 : ${suimVO.deposit_date_fmt}'</c:otherwise>
										</c:choose> 
										>										
											<!-- no -->
											<td>${suimRptListTotCnt - (18 * (reqPgNoInt101 - 1)) - status.index}</td>
											<!-- lock -->
											<td>
												<c:if test="${suimVO.lock_flag eq 1}">
													<img src="./resources/ne_img/icon_lock.png" width="20px" height="20px" alt="보고서 잠금" />
												</c:if>
												<c:if test="${suimVO.lock_flag eq 0}">
													<img src="./resources/ne_img/icon_unlock.png" width="20px" height="20px" alt="보고서 열람가능" />
												</c:if>
											</td>
											<!-- suim_rpt_type1 -->
											<td title="${suimVO.suim_rpt_type1_nm}" >
												<c:choose>
													<c:when test="${suimVO.suim_rpt_type1_nm eq '배상(스피드)'}">
														스피드
													</c:when>
													<c:otherwise>
														${suimVO.suim_rpt_type1_nm}
													</c:otherwise>
												</c:choose>
											</td>
											<!-- suim_accept_no -->
											<td title="${suimVO.minwon_flag_nm}" >
												<c:choose>
													<c:when test="${suimVO.minwon_flag == 1}">
														<font color="BLUE">${suimVO.suim_accept_no}</font>
													</c:when>
													<c:when test="${suimVO.minwon_flag == 2}">
														<font color="RED">${suimVO.suim_accept_no}</font>
													</c:when>
													<c:otherwise>${suimVO.suim_accept_no}</c:otherwise>
												</c:choose>
												<c:if test="${suimVO.memo_cnt > 0}"><font color="#0066CC">[${suimVO.memo_cnt}]</font></c:if>
												<c:if test="${suimVO.file_cnt > 0}"><img src="./resources/ls_img/icon_disket.gif" width="10" height="10" border="0"></c:if>
											</td>
											<!-- suim_close_no -->
											<td title="${suimVO.suim_close_no}" >
												<a href="javascript:doSagoView('${suimVO.suim_rpt_no}')" onclick="event.cancelBubble=true" style="cursor:pointer;">
												<c:choose>
													<c:when test="${suimVO.suim_close_no != '' and suimVO.suim_close_no != null}">${suimVO.suim_close_no}</c:when>
													<c:when test="${suimVO.suim_rpt_state == 3}">반송</c:when>
													<c:otherwise><font color="red">미결</font></c:otherwise>
												</c:choose>
												</a>
											</td>
											<!-- 보험사 -->
											<td title="${suimVO.ptnr_name}" >${suimVO.ptnr_nick}</td>
											<!-- 보험팀 -->
											<!-- 종결여부에 따라 보여지는 부서명을 다르게 표시 -->
											<c:choose>
												<c:when test="${suimVO.suim_rpt_state eq 2}">
													<td title="${suimVO.close_ptnr_dept_nm}" >
														<c:choose>
															<c:when test="${fn:length(suimVO.close_ptnr_dept_nm) > 6}">
																${fn:substring(suimVO.close_ptnr_dept_nm,0,6)}...
															</c:when>
															<c:otherwise>${suimVO.close_ptnr_dept_nm}</c:otherwise>
														</c:choose>
													</td>
												</c:when>
												<c:otherwise>
													<td title="${suimVO.ptnr_dept_nm}" >
														<c:choose>
															<c:when test="${fn:length(suimVO.ptnr_dept_nm) > 6}">
																${fn:substring(suimVO.ptnr_dept_nm,0,6)}...
															</c:when>
															<c:otherwise>${suimVO.ptnr_dept_nm}</c:otherwise>
														</c:choose>
													</td>													
												</c:otherwise>
											</c:choose>
											<!-- 보험담당 -->
											<td title="${suimVO.ptnr_mbr_nm}" >
												<c:choose>
													<c:when test="${fn:length(suimVO.ptnr_mbr_nm) > 3}">
														${fn:substring(suimVO.ptnr_mbr_nm,0,3)}...
													</c:when>
													<c:otherwise>${suimVO.ptnr_mbr_nm}</c:otherwise>
												</c:choose>
											</td>
											<!-- 처리팀 -->
											<td title="${suimVO.team_name}" >
												<c:if test="${not empty suimVO.team_mark}">
													<span class="mark_alarm">${suimVO.team_mark}</span>
												</c:if>
											</td>
											<!-- 담당자 -->
											<td title="${suimVO.user_name}" >
												<c:choose>
													<c:when test="${suimVO.user_no > 0}">
														<c:choose>
															<c:when test="${fn:length(suimVO.user_name) > 3}">
																${fn:substring(suimVO.user_name,0,3)}...
															</c:when>
															<c:otherwise>${suimVO.user_name}</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise><font color="red">미배당</font></c:otherwise>
												</c:choose>
											</td>
											<!-- 계약자 -->
											<td title="${suimVO.policyholder_nm}">
												<c:choose>
													<c:when test="${suimVO.policyholder_nm != ''}">
														<c:choose>
															<c:when test="${fn:length(suimVO.policyholder_nm) > 8}">
																${fn:substring(suimVO.policyholder_nm,0,8)}...
															</c:when>
															<c:otherwise>${suimVO.policyholder_nm}</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>-</c:otherwise>
												</c:choose>
											</td>
											<!-- 피보험자 -->
											<td title="${suimVO.beneficiary_nm}" >
												<c:choose>
													<c:when test="${suimVO.beneficiary_nm != ''}">
														<c:choose>
															<c:when test="${fn:length(suimVO.beneficiary_nm) > 8}">
																${fn:substring(suimVO.beneficiary_nm,0,8)}...
															</c:when>
															<c:otherwise>${suimVO.beneficiary_nm}</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>-</c:otherwise>
												</c:choose>
											</td>
											<!-- 피해자 -->
											<td title="${suimVO.damaged_nm}" >
												<c:choose>
													<c:when test="${suimVO.damaged_nm != ''}">
														<c:choose>
															<c:when test="${fn:length(suimVO.damaged_nm) > 8}">
																${fn:substring(suimVO.damaged_nm,0,8)}...
															</c:when>
															<c:otherwise>${suimVO.damaged_nm}</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>-</c:otherwise>
												</c:choose>
											</td>
											<!-- 사고 -->
											<td title="${suimVO.accident_date_fmt}" >${suimVO.accident_date_fmt}</td>
											<!-- 수임 -->
											<td title="${suimVO.rpt_now_txt}" >${suimVO.reg_date_fmt}</td>
											<!-- 현장 -->
											<!-- 현장 보고서 (물보험은 현장보고서결재일, 인보험은 기존 중간보고서 최신으로 표시 -->
											<c:choose>
												<c:when test="${suimVO.suim_rpt_type1 eq 3 or suimVO.suim_rpt_type1 eq 4}">
													<td title="${suimVO.site_date_fmt}" >${suimVO.site_date_fmt}</td>
												</c:when>
												<c:otherwise>
													<td title="${suimVO.site_rpt_aprv_date_fmt}" >${suimVO.site_rpt_aprv_date_fmt}</td>		
												</c:otherwise>
											</c:choose>
											<!-- 중간 -->
											<td title="${suimVO.interim_date_fmt}" >${suimVO.interim_date_fmt}</td>
											<!-- 종결 -->
											<td <c:if test="${suimVO.delDate != 0}">bgcolor="pink"</c:if>>
												<p <c:if test="${suimVO.suim_rpt_state  eq 3}">title="${suimVO.suim_cancel_date_fmt}"</c:if> >
													<c:choose>
														<c:when test="${suimVO.delDate < 0}"><font color="red"><b>삭제</b></font></c:when>
														<c:otherwise>
															<c:choose>
																<c:when test="${suimVO.suim_rpt_state  eq 1}"><font color="#0066ff">결재</font></c:when>
																<c:when test="${suimVO.suim_rpt_state  eq 11}"><font color="#CC3300">반려</font></c:when>
																<c:when test="${suimVO.suim_rpt_state  eq 2}">${suimVO.close_date_fmt}</c:when>
																<c:when test="${suimVO.suim_rpt_state  eq 3}">반송</c:when>
																<c:when test="${suimVO.suim_rpt_state  eq 31}"><font color=#C5A700>위임취소중</font></c:when>
																<c:when test="${suimVO.suim_rpt_state  eq 4}">소송</c:when>
																<c:when test="${suimVO.past_date > 15}"><font color="fuchsia">${suimVO.past_date}일</font></c:when>
																<c:otherwise>${suimVO.past_date}일</c:otherwise>
															</c:choose>
														</c:otherwise>
													</c:choose>
												</p>
											</td>
										</tr>
										</c:forEach>
										<!-- 손해보험 출력 끝 -->
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->

	<!-- page start -->
		<c:if test="${pgNm101 != null}">
			<p style="text-align:center;">
				<c:if test="${startPgNoInt101 > 10}">
					<a href="javascript:reqPgNoClickSuim(${startPgNoInt101 - 1});">&lt;</a>
				</c:if>
				<c:forEach var="pageNo" begin="${startPgNoInt101}" end="${endPgNoInt101}" step="1">
					<c:choose>
						<c:when test="${reqPgNoInt101 != pageNo}">
							<a href="javascript:reqPgNoClickSuim(${pageNo});"><c:out value="${pageNo}" /></a>
							&nbsp;&nbsp;
						</c:when>
						<c:otherwise>
							<font color="red"><c:out value="${pageNo}" /></font>
							&nbsp;&nbsp;
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${totPgCntInt101 >= endPgNoInt101 + 1}">
					<a href="javascript:reqPgNoClickSuim(${endPgNoInt101 + 1});">&gt;</a>
				</c:if>
			</p>
		</c:if>
	<!-- //page end -->
	<!-- //통합로딩바 -->
	<div id="top_loading" style="display: none;">
		<img id="loading-image" src="./resources/cmm/images/spinner.gif" alt="Loading..." />
	</div>
	<!-- //통합로딩바끝 -->
	<!-- 사고처리내역 팝업보기 시작-->
	<div id="sago-detail-dialog" title="사고처리과정표" style="font-size: 15px;display:none;" align="center">
	</div>
	<!-- 사고처리내역 팝업보기 끝-->