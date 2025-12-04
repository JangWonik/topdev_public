<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link href="./resources/select2/select2.min.css" rel="stylesheet" />
<script src="./resources/select2/select2.min.js"></script>
	<style>
		.search-td {
			padding-left:20px;
			text-align: left;
		}
		
		.invoiceResultTable tr td{
			letter-spacing: 0px;
			text-overflow : ellipsis;
			overflow : hidden;
			white-space : nowrap;
			word-wrap:normal;
		}
		
		.td-overflow-none{

		}
	</style>
	<script>
		$(document).ready(function(){
			if('${mbrAuthVo_Session.user_no}' == null || '${mbrAuthVo_Session.mbr_pms_7}' == 0){
				window.location.assign("./logout");
			}
		});//ready

		$(document).ready(function(){
			
			_initMask();
			
			//선택상자 셋팅
			$("#tmSearch").select2();					//담당팀
			$("#ptnrSearch").select2();				//보험사
			$("#srchUserNoMain").select2();		//조사자이름
			$("#rptTypeSearch").select2();			//보고서구분
			
			$.ajaxSetup({cache:false});

			$("#searchBtn").click(function(){
				
				//팀아이디
				//var team_id_val = $("#tmSearch").val();				
				//보험사 아이디
				//var ptnr_id_val = $("#ptnrSearch").val();			
				//직원아이디(조사자)
				//var user_name_val = $("#srchUserNoMain").val();
				
				//alert("team_id_val="+team_id_val+" : "+ptnr_id_val + " : "+user_name_val);
				
				$("#rptTaxSearchForm").attr("action","rptTaxSearch");
				
				rptTaxSearchForm.submit();
			});

			$("#excelBtn").click(function(){				
				$("#rptTaxSearchForm").attr("action","rptTaxListExcel");
				rptTaxSearchForm.submit();
			});
			
			
			/**** input 및 selectbox 에서 엔터 입력시 검색버튼 클릭. ****/
			$('input').keyup(function(e) {
			    if (e.keyCode == 13){
			    	$("#searchBtn").click();
			    }       
			});
			
			$('select').keyup(function(e) {
			    if (e.keyCode == 13){
			    	$("#searchBtn").click();
			    }
			});

		});//$(document).ready

	    /* mask 처리 */
	    function _initMask(){
	        var options = {
	            onKeyPress : function(cep, event, currentField, options){
	                var tid = event.currentTarget.id;
	                var tidx = tid.substr(tid.length - 1, 1);
	                //console.log(tidx);
	                //fnCaculateTotal(tidx);
	            },
	            reverse : true
	        };

	        $('input.money').mask('#,###,###',options);
	        $('div.money').mask('999,999,999',{reverse:true});
	    }
		
		
		function reqPgNoClick(pgNo){
			rptTaxPagingSearchForm.reqPgNo.value = pgNo;
			rptTaxPagingSearchForm.submit();
		}

		function rptInvDtl(no){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1010; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('rptInvDtl?no='+no,'invdtl','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}
		
		//세금계산서 작성팝업창 by top3009		
		function rptTaxDtl(suim_rpt_no, rpt_type){			
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1010; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			if(rpt_type == 1){
				window.open('rptTaxDtl?no='+suim_rpt_no,'taxdtl','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');	
			}else{			//2인경우 농작물
				window.open('primTaxDtl?no='+suim_rpt_no,'taxdtl','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');	
			}
		}		
		
		function popSuimDtl(suim_rpt_no, rpt_type){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1010; //띄울 창의 넓이
			var sh=screen.availHeight;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			
			if(rpt_type == 1){				
				window.open('suimRptBscDtl?suim_rpt_no='+suim_rpt_no,suim_rpt_no,'width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=yes,scrollbars=yes');
			}else{			//2인 경우 농작물 				
				window.open('primBizRptDtl?suim_rpt_no='+suim_rpt_no,suim_rpt_no,'width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=yes,scrollbars=yes');
			}
			
		}
	</script>

	<!-- 검색 조건 테이블 -->
	<div class= "tableStyle21" style="width: 100%;text-align: center; margin: 0 auto;" align="center">

		<form action="./rptInvSearch" name="rptTaxSearchForm" id="rptTaxSearchForm">
			<table>
				<colgroup>
					<col width="10%">
					<col width="16%">
					<col width="10%">
					<col width="16%">
					<col width="10%">
					<col width="16%">
					<col width="10%">
					<col width="12%">																
				</colgroup>
				<tbody>
					<tr>
						<th>담당팀</th>
						<td class="search-td" >
							<select id="tmSearch" name="tmSearch">
								<option value="0" selected>전체</option>
								<c:forEach items="${teamList}" var = "teamVo">
									<option value="${teamVo.team_id}"
										<c:if test="${searchVO.tmSearch == teamVo.team_id}">selected</c:if>
									>
										<c:if test="${teamVo.team_level == 1}">&nbsp;└</c:if>
										<c:if test="${teamVo.team_level == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
										${teamVo.team_name}
									</option>
								</c:forEach>
							</select>							
						</td>
						<th>보험사</th>
						<td class="search-td" >
							<select id="ptnrSearch" name="ptnrSearch" style="width:200px;">
								<option value="0" selected>전체</option>
								<c:forEach items="${ptnrList}" var = "ptnrVo">
									<option value="${ptnrVo.ptnr_id}"
										<c:if test="${searchVO.ptnrSearch == ptnrVo.ptnr_id}">selected</c:if>
									>
										<c:if test="${ptnrVo.ptnr_level == 1}">&nbsp;└</c:if>
										${ptnrVo.ptnr_nick}
									</option>
								</c:forEach>
							</select>							
						</td>
						<th>조사자</th>
						<td class="search-td">
							<%-- <input type="text" id="userNmSearch" name="userNmSearch" value='<c:out value="${searchVO.userNmSearch}" />' /> --%>
							<select id="srchUserNoMain" name="srchUserNoMain" style="width:180px;text-align:left;">
								<option value="" <c:if test="${empty srchUserNoMain}">selected</c:if> > - 전체 - </option>								
								<c:forEach items="${memberList}" var="item" >
									<option value="${item.userNo}" <c:if test="${searchVO.srchUserNoMain == item.userNo}">selected</c:if> >${item.userName}</option>									
								</c:forEach>										
							</select>
						</td>
						<th>보고서 구분</th>
						<td>
							<select id="rptTypeSearch" name="rptTypeSearch" style="width:180px;">								
								<option value="0" <c:if test="${searchVO.rptTypeSearch eq 0 }">selected</c:if>>전체</option>
								<option value="1" <c:if test="${searchVO.rptTypeSearch eq 1 }">selected</c:if>>일반</option>
								<option value="2" <c:if test="${searchVO.rptTypeSearch eq 2 }">selected</c:if>>농작물</option>
							</select>
						</td>						
					</tr>
					<tr>
						<th>계산서 발행일</th>
						<td class="search-td">
							<input	type="text" class="classCalendar" id="tax_date_from" name="tax_date_from"
									value='<c:out value="${searchVO.tax_date_from}" />' size="10" maxlength="10" />
							~ &nbsp;<input	type="text" class="classCalendar" id="tax_date_to" name="tax_date_to"
											value='<c:out value="${searchVO.tax_date_to}" />' size="10" maxlength="10" />
						</td>
						<th>입금일</th>
						<td class="search-td">
							<input	type="text" class="classCalendar" id="deposit_date_from" name="deposit_date_from"
									value='<c:out value="${searchVO.deposit_date_from}" />' size="10" maxlength="10" />
							~ &nbsp;<input	type="text" class="classCalendar" id="deposit_date_to" name="deposit_date_to"
											value='<c:out value="${searchVO.deposit_date_to}" />' size="10" maxlength="10" />
						</td>
						<th>종결일</th>
						<td class="search-td">
							<input	type="text" class="classCalendar" id="close_date_from" name="close_date_from"
									value='<c:out value="${searchVO.close_date_from}" />' size="10" maxlength="10" />
							~ &nbsp;<input	type="text" class="classCalendar" id="close_date_to" name="close_date_to"
											value='<c:out value="${searchVO.close_date_to}" />' size="10" maxlength="10" />
						</td>
						<td colspan="2">
							<div style="width:50%;float:left;">								
								<span title="계산서발생일이 존재하면서 계산서합계와 입금합계가 다른 경우 체크!!">ㆍ 미수 <input type="checkbox" id="taxNoCheck" name="taxNoCheck" <c:if test="${searchVO.taxNoCheck == 'on'}">checked</c:if> /></span>
								<span title="작업이완료되지 않은 세금계산서 조회!!">ㆍ 미완료 <input type="checkbox" id="endNoCheck" name="endNoCheck" <c:if test="${searchVO.endNoCheck == 'on'}">checked</c:if> /></span>
							</div>							
							<div style="width:50%;float:right;">
								<img src="./resources/ls_img/ls_invoice/btn_excel.gif" style='cursor:pointer;' id="excelBtn" />							
								<img src="./resources/ls_img/ls_invoice/btn_src.gif" style='cursor:pointer;' id="searchBtn" />
							</div>
						</td>												
					</tr>
				</tbody>
			</table>
		</form>
	</div><!-- //tableStyle21 -->
	
	
	<!-- //검색 조건 테이블 -->
	<br />
	<!-- 검색 결과 테이블 -->
	<div class= "tableStyle2" style="padding-bottom:10px;">
			<table class="invoiceResultTable">
				<thead>
					<tr>
						<th style="width:4%">no</th>
						<th>보고서구분</th>
						<th>접수번호</th>
						<th>보험사</th>
						<th>센터명</th>
						<th>팀명</th>						
						<th>조사자</th>
						<th>종결일</th>
						<th>발행일</th>
						<th>입금일</th>
						<th>입금금액</th>
						<th>계산서합계</th>
						<th>입금합계</th>
						<th>미수잔액</th>
						<th>상태</th>						
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${invList}" var="invVO" varStatus="status">
						<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" >
							<!--no-->
							<td>${totCntInt - (18 * (reqPgNoInt1 - 1)) - status.index}</td>
							<!--보고서 구분-->
							<td>
								<c:choose>
									<c:when test="${invVO.rpt_type eq 1}">일반</c:when>
									<c:when test="${invVO.rpt_type eq 2}">농작물</c:when>
								</c:choose>							
							</td>
							<!-- 접수번호 -->							
							<td><a href="javascript:popSuimDtl('${invVO.suim_rpt_no}','${invVO.rpt_type}')">${invVO.suim_accept_no}</a></td>
							<!--보험사-->
							<td>${invVO.ptnr_name}</td>
							<!-- 센터명 -->
							<td>${invVO.center_name}</td>
							<!-- 팀명 -->
							<td>${invVO.team_name}</td>
							<!--조사자-->
							<td>${invVO.user_name}</td>
							<!-- 종결일 -->
							<td>${invVO.close_date_fmt}</td>
							<!-- 발행일(세금계산서) -->
							<td>${invVO.publish_date_fmt}</td>
							<!-- 입금일 -->
							<td>${invVO.invoice_deposit_date}</td>
							<!-- 입금금액 -->
							<td><fmt:formatNumber value="${invVO.invoice_amt_total}" pattern="###,###,##0.##"/> 원</td>
							<!--계산서 합계-->
							<td style="text-align:right;padding-right:5px;">
								<a href="javascript:rptTaxDtl('${invVO.rpt_invoice_no}','${invVO.rpt_type}');">
								<fmt:formatNumber value="${invVO.sum_tax_val}" pattern="###,###,##0.##"/> 원
								</a>
							</td>
							<!--입금 합계-->
							<td style="text-align:right;padding-right:5px;">
								<a href="javascript:rptTaxDtl('${invVO.rpt_invoice_no}','${invVO.rpt_type}');">
								<fmt:formatNumber value="${invVO.sum_deposit_val}" pattern="###,###,##0.##"/> 원
								</a>
							</td>
							<!--미수잔액-->
							<td style="text-align:right;padding-right:5px;">
								<a href="javascript:rptTaxDtl('${invVO.rpt_invoice_no}','${invVO.rpt_type}');">
								<c:choose>
									<c:when test="${invVO.sum_minus_val < 0}"><font color="blue"><fmt:formatNumber value="${invVO.sum_minus_val}" pattern="###,###,##0.##"/> 원</font></c:when>
									<c:when test="${invVO.sum_minus_val > 0}"><font color="red"><fmt:formatNumber value="${invVO.sum_minus_val}" pattern="###,###,##0.##"/> 원</font></c:when>
									<c:otherwise><fmt:formatNumber value="${invVO.sum_minus_val}" pattern="###,###,##0.##"/> 원</c:otherwise>
								</c:choose>								
								</a>
							</td>
							<!-- 구분 -->							
							<td>								
								<a href="javascript:rptTaxDtl('${invVO.rpt_invoice_no}','${invVO.rpt_type}');">
								<c:choose>
									<c:when test="${invVO.tax_edit_end eq 0}"><font color="red">미완료</font></c:when>
									<c:when test="${invVO.tax_edit_end eq 1}">완료</c:when>
								</c:choose>
								</a>
							</td>
						</tr>
					</c:forEach>					
				</tbody>
			</table>

	</div><!-- //tableStyle2 -->
	<!-- //검색 결과 테이블 -->

	<!-- page start -->
		<c:if test="${pgNm1 != null}">
			<p style="text-align:center;">
				<c:if test="${startPgNoInt1 > 10}">
					<a href="javascript:reqPgNoClick(${startPgNoInt1 - 1});">&lt;</a>
				</c:if>
				<c:forEach var="pageNo" begin="${startPgNoInt1}" end="${endPgNoInt1}" step="1">
					<c:choose>
						<c:when test="${reqPgNoInt1 != pageNo}">
							<a href="javascript:reqPgNoClick(${pageNo});"><c:out value="${pageNo}" /></a>
							&nbsp;&nbsp;
						</c:when>
						<c:otherwise>
							<font color="red"><c:out value="${pageNo}" /></font>
							&nbsp;&nbsp;
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${totPgCntInt1 >= endPgNoInt1 + 1}">
					<a href="javascript:reqPgNoClick(${endPgNoInt1 + 1});">&gt;</a>
				</c:if>
			</p>
		</c:if>
		<form action="./rptTaxSearch" name="rptTaxPagingSearchForm">
			<!-- 페이지 번호 -->
			<input type="hidden" id="reqPgNo" name="reqPgNo" value='<c:out value="${reqPgNoInt1}" />' >
			<input type="hidden" id="tmSearch" name="tmSearch" value='<c:out value="${searchVO.tmSearch}" />' >
			<input type="hidden" id="ptnrSearch" name="ptnrSearch" value='<c:out value="${searchVO.ptnrSearch}" />' >
			<input type="hidden" id="srchUserNoMain" name="srchUserNoMain" value='<c:out value="${searchVO.srchUserNoMain}" />' >
			<input type="hidden" id="rptTypeSearch" name="rptTypeSearch" value='<c:out value="${searchVO.rptTypeSearch}" />' >			
			<input type="hidden" id="tax_date_from" name="tax_date_from" value='<c:out value="${searchVO.tax_date_from}" />' >
			<input type="hidden" id="tax_date_to" name="tax_date_to" value='<c:out value="${searchVO.tax_date_to}" />' >
			<input type="hidden" id="deposit_date_from" name="deposit_date_from" value='<c:out value="${searchVO.deposit_date_from}" />' >
			<input type="hidden" id="deposit_date_to" name="deposit_date_to" value='<c:out value="${searchVO.deposit_date_to}" />' >
			<input type="hidden" id="close_date_from" name="close_date_from" value='<c:out value="${searchVO.close_date_from}" />' >
			<input type="hidden" id="close_date_to" name="close_date_to" value='<c:out value="${searchVO.close_date_to}" />' >			
			<input type="hidden" id="taxNoCheck" name="taxNoCheck" value='<c:out value="${searchVO.taxNoCheck}" />' >
			<input type="hidden" id="endNoCheck" name="endNoCheck" value='<c:out value="${searchVO.endNoCheck}" />' >			
		</form>
	<!-- //page end -->
	<br>
	<!-- 총계 테이블 -->
	<div class= "tableStyle2">
		<table class="invoiceResultTable">
				<tr>					
					<th>세금계산서 총합</th>
					<td style="text-align:right;padding-right:5px;"><b><fmt:formatNumber value="${total_tax_amount}" pattern="###,###,##0.##"/> 원</b></td>					
					<th>입금액 총합</th>
					<td style="text-align:right;padding-right:5px;"><b><font color="blue"><fmt:formatNumber value="${total_deposit_amount}" pattern="###,###,##0.##"/> 원</font></b></td>
					<th>미수금액 총합</th>
					<td style="text-align:right;padding-right:5px;"><b><font color="red"><fmt:formatNumber value="${total_minus_amount}" pattern="###,###,##0.##"/> 원</font></b></td>					
				</tr>				
		</table>
	</div><!-- //tableStyle2 -->
	<!-- //총계 테이블 -->

