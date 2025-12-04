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
		
		function fnAllChk(chk){
			var isChkAll = $(chk).is(":checked");
			outRpt = []; //배열초기화
			
			if (isChkAll){
				$('input:checkbox[name="chkMbrchg"]').each(function(){
					this.checked = true;					
				});
				var chkLength = $('input:checkbox[name="chkMbrchg"]').length;
				//alert("선택한 보고서 : 총 "+chkLength+" 개");
				//$(".chkCntSpan").html("선택한 보고서 : 총 "+chkLength+" 개");
				
			}else{
				$('input:checkbox[name="chkMbrchg"]').each(function(){
					this.checked = false;
				});
				//alert("선택한 보고서 : 총 "+chkLength+" 개");
				//$(".chkCntSpan").html("선택한 보고서 : 0 개");
			}
		}		

		function popSuimDtl(suim_rpt_no, delDate){
			if(delDate < 0){
				alert("삭제된 보고서 입니다.");
				return;
			}	
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1010; //띄울 창의 넓이
			var sh=screen.availHeight;  //띄울 창의 높이 740
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			//창띄우기 전에 스크립트 초기화 by top3009			
			localStorage.setItem('activeTab','1');
			window.open('suimRptBscDtl?suim_rpt_no='+suim_rpt_no, suim_rpt_no,'width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=yes,scrollbars=yes');
		}
		
		//결재하기
		function action_report(param){			
			var chkCount = 0;
			
			$("input[name=chkMbrchg]:checked").each(function(){
				chkCount++;
			});			
			
			if( param == 'end' ){		//종결				
				if(chkCount == 0){
					alert("종결 할 보고서를 체크해주세요.");
					return;
				}else{
					if( confirm("총 "+chkCount+" 개의 보고서를 종결처리하시겠습니까?") ){					
						$("input[name=chkMbrchg]:checked").each(function(){
							var cVal = $(this).val();
							endRpt(cVal);
						});					
					}		
				}
				alert("종결 처리되었습니다.");
				window.location.href="./quickApprovalList?stateSearch=2";				
			}else{							//반려
				if(chkCount == 0){
					alert("반려 할 보고서를 체크해주세요.");
					return;
				}else{					
					if( confirm("총 "+chkCount+" 개의 보고서를 반려처리하시겠습니까?") ){						
						$("input[name=chkMbrchg]:checked").each(function(){							
							var cVal = $(this).val();							
							returnRpt(cVal);
						});						
					}	
				}
				alert("반려 처리되었습니다.");
				window.location.href="./quickApprovalList?stateSearch=11";
			}			
		}
		
		function returnRpt( returnVal ){
			var param = {};
	        param.suim_rpt_no	= returnVal;	        
	        
	        var url = "./returnRpt_action";

	        $.ajax({
	            type: "POST",
	            url: url,
	            data: param,
	            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	            dataType: "JSON",
	            timeout: 20000,
	            success: function(data){	            	
	            	if (data == 1){	            		
	            		return 1;
	            	}
	            },
	            error: function(xhr, status, error){
	                if(xhr.status == "901"){
	                    fnWinClose();
	                }else{
	                    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
	                }
	            },
	            beforeSend : function(xmlHttpRequest){
	                xmlHttpRequest.setRequestHeader("AJAX", "true");
	            }

	        });
		}
		
		function endRpt( returnVal ){
			var param = {};
	        param.suim_rpt_no	= returnVal;	        
	        
	        var url = "./endRpt_action";

	        $.ajax({
	            type: "POST",
	            url: url,
	            data: param,
	            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	            dataType: "JSON",
	            timeout: 20000,
	            success: function(data){	            	
	            	if (data == 1){	            		
	            		return 1;
	            	}
	            },
	            error: function(xhr, status, error){
	                if(xhr.status == "901"){
	                    fnWinClose();
	                }else{
	                    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
	                }
	            },
	            beforeSend : function(xmlHttpRequest){
	                xmlHttpRequest.setRequestHeader("AJAX", "true");
	            }

	        });
		}

		function reqPgNoClickSuim(pgNo){
			searchMainPagingForm.reqPgNo.value = pgNo;
			searchMainPagingForm.presentPage.value = "suimrpttab";
			searchMainPagingForm.submit();
		}
	</script>		
			<p style="margin-bottom:5px;text-align:right;">
				<!-- 반려하기 -->
				<img src="./resources/ls_img/report/btn_rch_return.gif" border=0 onclick="action_report('returnRpt');" style="cursor:pointer;"/>
				<!-- 결재하기 -->				
				<img src="./resources/ls_img/report/btn_rch_2.gif" border=0 onclick="action_report('end');" style="cursor:pointer;"/>									
			</p>
			<div class= "tableStyle_approval">
				<table class="srchResultTable">
					<colgroup>										
						<col style="width:3%;" />										
						<col style="width:5%;" />
						<col style="width:8%;" />
						<col style="width:8%;" />
						<col style="width:10%;" />
						<col style="width:10%;" />
						<col style="width:10%;" />
						<col style="width:10%;" />
						<col style="width:10%;" />
						<col style="width:10%;" />
						<col style="width:8%;" />
						<col style="width:8%;" />										
					</colgroup>
					<thead>
						<tr>											
							<th><input type="checkbox" id="chkAll" onclick="fnAllChk(this);" name="chkAll" ></th>											
							<th>no.</th>											
							<th>접수번호</th>
							<th>사고번호</th>
							<th>담당부서</th>
							<th>담당자</th>
							<th>계약자</th>
							<th>피보험자</th>
							<th>피해자/물</th>
							<th>접수일</th>
							<th>상신일</th>
							<th>상태</th>
						</tr>
					</thead>
					<tbody>
						<!--  -->
						<c:forEach items="${suimBookList}" var="suimVO" varStatus="status" > <!-- begin="1" end="20" step="1" -->
						
						<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" style ="cursor:pointer;">
							<!-- 체크박스-->											
							<td class="chgTd">
								<input type="checkbox" id="chkMbrchg" name="chkMbrchg" value="${suimVO.suim_rpt_no}"/>
							</td>											
							<!-- no -->
							<td onclick="popSuimDtl('${suimVO.suim_rpt_no}', '${suimVO.delDate}')">${suimRptListTotCnt - (18 * (reqPgNoInt101 - 1)) - status.index}</td>											
							<!-- 접수번호 -->
							<td title="${suimVO.minwon_flag_nm}" onclick="popSuimDtl('${suimVO.suim_rpt_no}', '${suimVO.delDate}')">
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
							<!-- 사고번호 -->
							<td onclick="popSuimDtl('${suimVO.suim_rpt_no}', '${suimVO.delDate}')">${suimVO.accident_no}</td>											
							<!-- 담당부서 -->
							<td title="${suimVO.team_name}" onclick="popSuimDtl('${suimVO.suim_rpt_no}', '${suimVO.delDate}')">
								<c:if test="${not empty suimVO.team_mark}">
									<span class="mark_alarm">${suimVO.team_mark}</span>
								</c:if>
							</td>
							<!-- 담당자 -->
							<td title="${suimVO.user_name}" onclick="popSuimDtl('${suimVO.suim_rpt_no}', '${suimVO.delDate}')">
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
							<td title="${suimVO.policyholder_nm}" onclick="popSuimDtl('${suimVO.suim_rpt_no}', '${suimVO.delDate}')">
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
							<td title="${suimVO.beneficiary_nm}" onclick="popSuimDtl('${suimVO.suim_rpt_no}', '${suimVO.delDate}')">
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
							<!-- 피해자 / 물 -->
							<td title="${suimVO.damaged_nm}" onclick="popSuimDtl('${suimVO.suim_rpt_no}', '${suimVO.delDate}')">
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
							<!-- 접수일 -->
							<td onclick="popSuimDtl('${suimVO.suim_rpt_no}', '${suimVO.delDate}')">${suimVO.reg_date_fmt}</td>
							<!-- 상신일 -->
							<td onclick="popSuimDtl('${suimVO.suim_rpt_no}', '${suimVO.delDate}')">${suimVO.suim_rpt_aprv_date_fmt}</td>
							<!-- 상태 -->
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
			</div><!-- //tableStyle_approval -->
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
