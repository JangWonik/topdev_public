<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
		
		.buttonAssistanceDocu{
			width:120px;
			height:25px;
		    background-color:#9900CC;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		    }
		    
		.buttonAssistance{
			width:120px;
			height:25px;
		    background-color:#2E7EE8;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		    }
		    
		 .buttonAssistanceEmail{
			width:120px;
			height:50px;
		    background-color:darkCyan;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 15px;
		    font-weight: bold;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		    }		
	</style>
	<script>
		$(document).ready(function(){
			if('${mbrAuthVo_Session.user_no}' == null || '${mbrAuthVo_Session.mbr_pms_7}' == 0){
				window.location.assign("./logout");
			}		

			$.ajaxSetup({cache:false});
			
			$("#tmSearch").select2();
			$("#ptnrSearch").select2();			
			$("#type1Search").select2();
			$("#orderBy").select2();

			$("#searchBtn").click(function(){
				$("#tmGubun").val($("#tmSearch option:selected").text().indexOf("└"));
				$("#ptnrGubun").val($("#ptnrSearch option:selected").text().indexOf("└"));
				$("#primBizInvSearchForm").attr("action","primBizInvSearch");
				
				var sel_page = $("#selPageSize").val();
				$("#queryPgSizeInt").val(sel_page);
				
				primBizInvSearchForm.submit();
			});

			$("#excelBtn").click(function(){
				$("#tmGubun").val($("#tmSearch option:selected").text().indexOf("└"));
				$("#ptnrGubun").val($("#ptnrSearch option:selected").text().indexOf("└"));
				$("#primBizInvSearchForm").attr("action","primBizInvListExcel");
				primBizInvSearchForm.submit();
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

			//페이지 값 변경시
			$("#selPageSize").change(function(){				
				var sel_page = $("#selPageSize").val();
				$("#queryPgSizeInt").val(sel_page);
				$("#searchBtn").click();
			});
			
			//농작물 입금일 파일등록 모달창
			$("#incomeFileBtn").click(function(){
				
				//농작물 입금일자 파일등록 dialog
				var url = "/incomeFilePrimBizModal";
				
				$.ajax({
					type: "POST",
					url: url,					
					contentType: "application/x-www-form-urlencoded; charset=UTF-8",
					dataType: "html",					
					timeout: 20000,
					success: function(data){						
						
						$("#income-detail-dialog").html();
						$("#income-detail-dialog").html(data);			
							$("#income-detail-dialog").dialog({
								height: 600,
								width: 700,
								closeOnEscape : true,
								draggable : true,
								title: "농작물 입금일 파일등록",					
								modal: true,
								position: { 'at' : 'center' },					
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
				
			});
			
			//입금일 일괄처리
			$("#incomeBtn").click(function(){				
				//체크박스 전체 수
				var totalChk = $('input:checkbox[name="chkInvoiceNo"]').length;
				
				//ajax로 넘길 invoice_no
				var arrList = new Array();
				
				//체크여부 확인
				var nChk = $("input:checkbox[name='chkInvoiceNo']:checked").length;
				if( nChk == 0 ){
					alert("입금일자를 일괄처리 할 목록을 체크해주세요.");
					return;
				}else{
					var k = 0;
					for( var i=0; i < totalChk; i++){
						//체크표시된경우만 값을 넣는다.
						if( $("input:checkbox[id='chkInvoiceNo_"+i+"']").is(":checked") == true ){
							arrList[k] = $("input:checkbox[id='chkInvoiceNo_"+i+"']").val();
							k++;
						}						
					}				
					
					//입금일자 일괄처리 dialog					
					var url = "/incomePrimUpdateModal";
					
					var param = {};
					param.invList = arrList;
					
					var h_size = 380; 
					
					if( arrList.length > 5){
						h_size = 380 + ((arrList.length - 5) * 25);
					}
					
					$.ajax({
						type: "POST",
						url: url,
						data: param,
						contentType: "application/x-www-form-urlencoded; charset=UTF-8",
						dataType: "html",
						traditional: true,						//배열허용
						timeout: 20000,
						success: function(data){							
							
							$("#income-detail-dialog").html();
							$("#income-detail-dialog").html(data);			
								$("#income-detail-dialog").dialog({
									height: h_size,
									width: 600,
									closeOnEscape : true,
									draggable : true,
									title: "입금일자 일괄처리",					
									modal: true,
									position: { 'at' : 'center' },					
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
			});
			
			//계산서 일괄처리
			$("#publishBtn").click(function(){
				//체크박스 전체 수
				var totalChk = $('input:checkbox[name="chkInvoiceNo"]').length;
				
				//ajax로 넘길 invoice_no
				var arrList = new Array();
				
				//체크여부 확인
				var nChk = $("input:checkbox[name='chkInvoiceNo']:checked").length;
				if( nChk == 0 ){
					alert("계산서 발행일자를 일괄처리 할 목록을 체크해주세요.");
					return;
				}else{
					var k = 0;
					for( var i=0; i < totalChk; i++){
						//체크표시된경우만 값을 넣는다.
						if( $("input:checkbox[id='chkInvoiceNo_"+i+"']").is(":checked") == true ){
							arrList[k] = $("input:checkbox[id='chkInvoiceNo_"+i+"']").val();
							k++;
						}						
					}					
					
					//계산서 발행일자 일괄처리 dialog
					//var url = "/publishUpdateModal";
					var url = "/publishPrimUpdateModal";
					
					var param = {};
					param.invList = arrList;
					
					var h_size = 380; 
					
					if( arrList.length > 5){
						h_size = 380 + ((arrList.length - 5) * 25);
					}
					
					$.ajax({
						type: "POST",
						url: url,
						data: param,
						contentType: "application/x-www-form-urlencoded; charset=UTF-8",
						dataType: "html",
						traditional: true,						//배열허용
						timeout: 20000,
						success: function(data){
							
							//console.log("data : "+data);
							
							$("#publish-detail-dialog").html();
							$("#publish-detail-dialog").html(data);			
								$("#publish-detail-dialog").dialog({
									height: h_size,
									width: 600,
									closeOnEscape : true,
									draggable : true,
									title: "계산서 발행일자 일괄처리",					
									modal: true,
									position: { 'at' : 'center' },					
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
				
			});			

		});//$(document).ready

		function reqPgNoClick(pgNo){			
			primBizInvPagingSearchForm.reqPgNo.value = pgNo;
			primBizInvPagingSearchForm.submit();
		}
		
		//세금계산서 작성팝업창 by top3009		
		function rptTaxDtl(no){			
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1010; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			//no = suim_rpt_no
			window.open('primTaxDtl?no='+no,'taxdtl','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}

		function primBizInvMemoPop(rpt_invoice_no){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1010; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('primbizinvMemoPop?rpt_invoice_no='+rpt_invoice_no, 'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}

		function primBizInvDtl(rpt_invoice_no){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1010; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('primBizInvDtl?rpt_invoice_no='+rpt_invoice_no, 'primbizinvdtl','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}		
		
		function primBizTaxInvDtlPop(rpt_invoice_no){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1010; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('primBizTaxInvDtlPop?rpt_invoice_no='+rpt_invoice_no, 'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}
		
		function fnAllChk(){			
			//전체 체크박스 체크한 경우
			if($("#chkAll").is(":checked")){
				$("input[name='chkInvoiceNo']").prop("checked",true);
			}else{
				$("input[name='chkInvoiceNo']").prop("checked",false);				
			}			
		}

	</script>
</head>

<body>

	<!-- 검색 조건 테이블 -->
	<div class= "tableStyle21" style="width: 100%;text-align: center; margin: 0 auto;" align="center">
		<form action="./primBizInvSearch" name="primBizInvSearchForm" id="primBizInvSearchForm">
			<input type="hidden" id="queryPgSizeInt" name="queryPgSizeInt" value="${searchVO.queryPgSizeInt}" />
			<table>
				<tbody>
				<colgroup>
					<col width="8%">
					<col width="18%">
					<col width="8%">
					<col width="11%">
					<col width="8%">
					<col width="15%">
					<col width="8%">
					<col width="15%">
					<col width="9%">										
				</colgroup>
					<tr>
						<th>담당팀</th>
						<td class="search-td" >
							<select id="tmSearch" name="tmSearch" style="width:250px;">
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
							<input type="hidden" id="tmGubun" name="tmGubun" value='<c:out value="${searchVO.tmGubun}" />' >
						</td>
						<th>보험사</th>
						<td class="search-td" >
							<select id="ptnrSearch" name="ptnrSearch" style="width:190px;">
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
							<input type="hidden" id="ptnrGubun" name="ptnrGubun" value='<c:out value="${searchVO.ptnrGubun}" />' >
						</td>
						<th>종별구분</th>
						<td class="search-td" >
							<select id="type1Search" name="type1Search" style="width:170px;">
								<option value="0" selected>전체</option>
								<c:forEach items="${type1List}" var = "type1Vo">
									<option value="${type1Vo.col_cd}"
										<c:if test="${searchVO.type1Search == type1Vo.col_cd}">selected</c:if>
									>
										${type1Vo.col_val}
									</option>
								</c:forEach>
							</select>
							<%-- ㆍ스피드심사 <input type="checkbox" id="speedCheck" name="speedCheck"
											<c:if test="${searchVO.speedCheck == 'on'}">checked</c:if>
										/> --%>
						</td>
						<th>제출일</th>
						<td class="search-td" >
							<input	type="text" class="classCalendar" id="invoice_date_From" name="invoice_date_From"
									value='<c:out value="${searchVO.invoice_date_From}" />' size="10" maxlength="10" />
							~ &nbsp;<input	type="text" class="classCalendar" id="invoice_date_To" name="invoice_date_To"
											value='<c:out value="${searchVO.invoice_date_To}" />' size="10" maxlength="10" />
							ㆍ 수정 <input type="checkbox" id="invDateEditCheck" name="invDateEditCheck"
										<c:if test="${searchVO.invDateEditCheck == 'on'}">checked</c:if> />
						</td>
						<td rowspan="4" style="border-left: 1px solid #cfcfcf;">
							<div style="padding-bottom:5px;">
								<input title="검색" class="buttonAssistanceEmail" type="button" value="검 색" id="searchBtn">
							</div>
							<div style="padding-bottom:5px;">
								<input title="입금일자 일괄처리" class="buttonAssistance" type="button" value="입금일 일괄처리" id="incomeBtn">
							</div>
							<!-- 입금일자 파일등록 재경팀요청사항으로 추가 -->
							<div style="padding-bottom:5px;">
								<input title="입금일자 파일등록" class="buttonAssistance" style="background-color:#0040FF" type="button" value="입금일 파일등록" id="incomeFileBtn">
							</div>
							<!-- 입금일자 파일등록 재경팀요청사항으로 끝 -->
							<div>
								<input title="계산서발행일자 일괄처리" class="buttonAssistanceDocu" type="button" value="계산서 일괄처리" id="publishBtn">
							</div>
						</td>
					</tr>
					<tr>
						<th>조사자</th>
						<td class="search-td" ><input type="text" id="userNmSearch" name="userNmSearch" value='<c:out value="${searchVO.userNmSearch}" />' /></td>
						<th>보험사담당자</th>
						<td class="search-td" ><input type="text" id="ptnrUserNmSearch" name="ptnrUserNmSearch" value='<c:out value="${searchVO.ptnrUserNmSearch}" />' /></td>
						<th>사고번호</th>
						<td class="search-td">
							<input type="text" id="accidentNoSearch" name="accidentNoSearch" value='<c:out value="${searchVO.accidentNoSearch}" />' />
						</td>
						<th>종결일</th>
						<td class="search-td" >
							<input	type="text" class="classCalendar" class="classCalendar" id="close_date_From" name="close_date_From"
									value='<c:out value="${searchVO.close_date_From}" />' size="10" maxlength="10" />
							~ &nbsp;<input	type="text" class="classCalendar" class="classCalendar" id="close_date_To" name="close_date_To"
											value='<c:out value="${searchVO.close_date_To}" />' size="10" maxlength="10" />
						</td>
					</tr>
					<tr>
						<th>피보험자</th>
						<td class="search-td" ><input type="text" id="benefiNmSearch" name="benefiNmSearch" value='<c:out value="${searchVO.benefiNmSearch}" />' /></td>
						<th>계약자</th>
						<td class="search-td" ><input type="text" id="policyhNmSearch" name="policyhNmSearch" value='<c:out value="${searchVO.policyhNmSearch}" />' /></td>
						<th>접수번호</th>
						<td class="search-td" ><input type="text" id="acceptNoSearch" name="acceptNoSearch" value='<c:out value="${searchVO.acceptNoSearch}" />' /></td>
						<th>입금일</th>
						<td class="search-td" >
							<input	type="text" class="classCalendar" id="deposit_date_From" name="deposit_date_From"
									value='<c:out value="${searchVO.deposit_date_From}" />' size="10" maxlength="10" />
							~ &nbsp;<input	type="text" class="classCalendar" id="deposit_date_To" name="deposit_date_To"
											value='<c:out value="${searchVO.deposit_date_To}" />' size="10" maxlength="10" />
						</td>
					</tr>
					<tr>
						<th>입금액</th>
						<td class="search-td">
							<input type="text" id="totAmtF" name="totAmtF" style="width:90px;" value='<fmt:formatNumber value="${searchVO.totAmtF}" pattern="###,###,##0.##"/>' />
							~ <input type="text" id="totAmtT" name="totAmtT" style="width:90px;" value='<fmt:formatNumber value="${searchVO.totAmtT}" pattern="###,###,##0.##"/>' />
							ㆍ 미수 <input type="checkbox" id="depositNoCheck" name="depositNoCheck"
										<c:if test="${searchVO.depositNoCheck == 'on'}">checked</c:if>
									/>
							ㆍ 수정 <input type="checkbox" id="amtEditCheck" name="amtEditCheck"
										<c:if test="${searchVO.amtEditCheck == 'on'}">checked</c:if>
									/>
						</td>
						
						<th>정렬기준</th>
						<td class="search-td">
							<select id="orderBy" name="orderBy" style="width:80px;">
								<option value="close_date"
									<c:if test="${searchVO.orderBy == 'close_date'}">selected</c:if>
								>종결일</option>
								<option value="invoice_date"
									<c:if test="${searchVO.orderBy == 'invoice_date'}">selected</c:if>
								>제출일</option>
								<option value="deposit_date"
									<c:if test="${searchVO.orderBy == 'deposit_date'}">selected</c:if>
								>입금일</option>
							</select>
						</td>
						
						<th>계산서No</th>
						<td class="search-td" >
							<%-- <input type="text" id="taxNoSearch" name="taxNoSearch" value='<c:out value="${searchVO.taxNoSearch}" />' /> --%>
							ㆍ 미발행 <input type="checkbox" id="taxNoCheck" name="taxNoCheck"
										<c:if test="${searchVO.taxNoCheck == 'on'}">checked</c:if>
									/>
							ㆍ 미완료 <input type="checkbox" id="taxEditEnd" name="taxEditEnd"
										<c:if test="${searchVO.taxEditEnd == 'on'}">checked</c:if>
									/>
						</td>
						<th>계산서</th>
						<td class="search-td" >
							<input	type="text" class="classCalendar" id="tax_date_From" name="tax_date_From"
									value='<c:out value="${searchVO.tax_date_From}" />' size="10" maxlength="10" />
							~ &nbsp;<input	type="text" class="classCalendar" id="tax_date_To" name="tax_date_To"
											value='<c:out value="${searchVO.tax_date_To}" />' size="10" maxlength="10" />
						</td>
					</tr>
				</tbody>
			</table>
		</form>

	</div><!-- //tableStyle21 -->
	<div style="text-align:right;padding:5px 5px 5px;">	
		<img src="./resources/ls_img/ls_invoice/btn_excel.gif" style='cursor:pointer;' id="excelBtn" />								
		<select id="selPageSize">			
			<option value="18" <c:if test="${searchVO.queryPgSizeInt == 18}">selected</c:if> >18</option>
			<option value="50" <c:if test="${searchVO.queryPgSizeInt == 50}">selected</c:if> >50</option>
			<option value="100" <c:if test="${searchVO.queryPgSizeInt == 100}">selected</c:if> >100</option>			
			<option value="200" <c:if test="${searchVO.queryPgSizeInt == 200}">selected</c:if> >200</option>
			<option value="300" <c:if test="${searchVO.queryPgSizeInt == 300}">selected</c:if> >300</option>
			<option value="400" <c:if test="${searchVO.queryPgSizeInt == 400}">selected</c:if> >400</option>
			<option value="500" <c:if test="${searchVO.queryPgSizeInt == 500}">selected</c:if> >500</option>
		</select>	
	</div>
	<!-- //검색 조건 테이블 -->	
	<!-- 검색 결과 테이블 -->
	<div class= "tableStyle2">
			<table>
				<thead>
					<tr>
						<th style="width:2%">
							<!-- 전체 체크 -->
							<input type="checkbox" id="chkAll" onclick="fnAllChk();" name="chkAll" >
						</th>
						<th style="width:4%">no</th>
						<th>구분</th>
						<th>지점</th>
						<th>조사자</th>
						<th>담당자</th>
						<th>보험사</th>
						<th>접수번호</th>
						<th>계약자</th>
						<th>피보험자</th>
						<th>제출일</th>
						<th>계산서<br />재발행일</th>
						<th>종결일</th>
						<th>기본보수</th>
						<th>일비</th>
						<th>교통비</th>
						<th>자문료</th>
						<th>기타</th>
						<th>계</th>
						<th style="width:3%">수정</th>
						<th>입금일</th>
						<th style="width:3%">기능</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${invList}" var="invVO" varStatus="status">
						<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
							<!--no-->
							<td>								
								<input type="checkbox" id="chkInvoiceNo_${status.index}" name="chkInvoiceNo" value="${invVO.rpt_invoice_no}"/>
							</td>							
							<%-- <td>${totCntInt - (18 * (reqPgNoInt1 - 1)) - status.index}</td> --%>
							<td>${totCntInt - (pgSize * (reqPgNoInt1 - 1)) - status.index}</td>
							<!--구분-->
							<td>${invVO.suim_rpt_type1_nm}</td>
							<!--지점-->
							<td>
								<c:if test="${not empty invVO.team_mark}">
									<span class="mark_alarm">${invVO.team_mark}</span>
								</c:if>
							</td>
							<!--조사자-->
							<td>${invVO.user_nm}</td>
							<!--담당자-->
							<td>${invVO.ptnr_mbr_nm_4edit}</td>
							<!--보험사-->
							<td>${invVO.ptnr_nick}</td>
							<!--접수번호-->
							<td>${invVO.suim_accept_no}</td>
							<!--계약자-->
							<td>${invVO.policyholder_nm}</td>
							<!--피보험자-->
							<td>${invVO.beneficiary_nm}</td>
							<!--제출일-->
							<td>${invVO.invoice_date_fmt}</td>
							<!--계산서<br />재발행일-->
							<td>${invVO.tax_date_fmt}</td>
							<!--종결일-->
							<td>${invVO.close_date_fmt}</td>
							<!--기본보수-->
							<td style="letter-spacing: 0;">
								<c:choose>
									<c:when test="${invVO.sum_share_amt_basic != invVO.amt_basic}">
										<font color="red"><fmt:formatNumber value="${invVO.amt_basic}" pattern="###,###,##0.##"/></font>
									</c:when>
									<c:otherwise>
										<fmt:formatNumber value="${invVO.amt_basic}" pattern="###,###,##0.##"/>
									</c:otherwise>
								</c:choose>
								<c:set var="sum_amt_basic" value="${invVO.amt_basic + sum_amt_basic}" />
							</td>
							<!--일비-->
							<td style="letter-spacing: 0;">
								<c:choose>
									<c:when test="${invVO.sum_share_amt_daily != invVO.amt_daily}">
										<font color="red"><fmt:formatNumber value="${invVO.amt_daily}" pattern="###,###,##0.##"/></font>
									</c:when>
									<c:otherwise>
										<fmt:formatNumber value="${invVO.amt_daily}" pattern="###,###,##0.##"/>
									</c:otherwise>
								</c:choose>
								<c:set var="sum_amt_daily" value="${invVO.amt_daily + sum_amt_daily}" />
							</td>
							<!--교통비-->
							<td style="letter-spacing: 0;">
								<c:choose>
									<c:when test="${invVO.sum_share_amt_traffic != invVO.amt_traffic}">
										<font color="red"><fmt:formatNumber value="${invVO.amt_traffic}" pattern="###,###,##0.##"/></font>
									</c:when>
									<c:otherwise>
										<fmt:formatNumber value="${invVO.amt_traffic}" pattern="###,###,##0.##"/>
									</c:otherwise>
								</c:choose>
								<c:set var="sum_amt_traffic" value="${invVO.amt_traffic + sum_amt_traffic}" />
							</td>
							<!--자문료-->
							<td style="letter-spacing: 0;">
								<c:choose>
									<c:when test="${invVO.sum_share_amt_counsel != invVO.amt_counsel}">
										<font color="red"><fmt:formatNumber value="${invVO.amt_counsel}" pattern="###,###,##0.##"/></font>
									</c:when>
									<c:otherwise>
										<fmt:formatNumber value="${invVO.amt_counsel}" pattern="###,###,##0.##"/>
									</c:otherwise>
								</c:choose>
								<c:set var="sum_amt_counsel" value="${invVO.amt_counsel + sum_amt_counsel}" />
							</td>
							<!--기타-->
							<td style="letter-spacing: 0;">
								<c:choose>
									<c:when test="${invVO.sum_share_amt_etc != invVO.amt_etc}">
										<font color="red"><fmt:formatNumber value="${invVO.amt_etc}" pattern="###,###,##0.##"/></font>
									</c:when>
									<c:otherwise>
										<fmt:formatNumber value="${invVO.amt_etc}" pattern="###,###,##0.##"/>
									</c:otherwise>
								</c:choose>
								<c:set var="sum_amt_etc" value="${invVO.amt_etc + sum_amt_etc}" />
							</td>
							<!--계-->
							<td style="letter-spacing: 0;">
								<c:choose>
									<c:when test="${invVO.sum_share_amt_total != invVO.amt_total}">
										<font color="red"><fmt:formatNumber value="${invVO.amt_total}" pattern="###,###,##0.##"/></font>
									</c:when>
									<c:otherwise>
										<fmt:formatNumber value="${invVO.amt_total}" pattern="###,###,##0.##"/>
									</c:otherwise>
								</c:choose>
								<c:set var="sum_amt_total" value="${invVO.amt_total + sum_amt_total}" />
							</td>
							<!--수정-->
							<td><c:if test="${invVO.edit_amt_cnt > 0}">수정</c:if></td>
							<!--입금일-->
							<td>
								<a href="#;" onclick="primBizInvMemoPop(${invVO.rpt_invoice_no});">
									<c:choose>
										<c:when test="${invVO.deposit_date > 0}">
											${invVO.deposit_date_fmt}
										</c:when>
										<c:when test="${(invVO.deposit_date == NULL || invVO.deposit_date < 1) && (invVO.rpt_invoice_memo != NULL && invVO.rpt_invoice_memo != '')}">
											<img src="./resources/ls_img/ls_invoice/icon_bigo_o.gif" style="cursor:pointer;" title="${invVO.rpt_invoice_memo}" />
										</c:when>
										<c:when test="${(invVO.deposit_date == NULL || invVO.deposit_date < 1) && (invVO.rpt_invoice_memo == NULL || invVO.rpt_invoice_memo == '')}">
											<img src="./resources/ls_img/ls_invoice/icon_bigo_x.gif" style="cursor:pointer;" />
										</c:when>
									</c:choose>
								</a>
								<c:if test="${invVO.deposit_date == null || invVO.deposit_date < 1}">
									<c:set var="sum_not_deposit" value="${invVO.amt_total + sum_not_deposit}" />
								</c:if>
							</td>
							<!----->
							<td>
								<c:choose>
									<c:when test="${invVO.issue_tax_invoice == 1 && invVO.tax_invoice_no != ''}">
										<img src="./resources/ls_img/ls_invoice/btn_p_tax.gif" style="cursor:pointer;"
											onclick="primBizTaxInvDtlPop(${invVO.rpt_invoice_no})" />
									</c:when>
									<c:when test="${invVO.issue_tax_invoice != 1 && invVO.tax_invoice_no != ''}">
										<img src='./resources/ls_img/ls_invoice/btn_p_tax_x.gif' width=14 height=14 border=0 />
									</c:when>
									<c:otherwise>
											<img src='./resources/ls_img/ls_invoice/icon_angry_1.gif' width=14 height=14 border=0 />
									</c:otherwise>
								</c:choose>

								<c:if test="${mbrAuthVo_Session.user_no != null && mbrAuthVo_Session.mbr_pms_8 > 0}">
									<img src="./resources/ls_img/ls_invoice/btn_s_edite.gif" style="cursor:pointer;"
										onclick="primBizInvDtl(${invVO.rpt_invoice_no})" title="정보수정하기" />
								</c:if>
								
								<!-- 세금계산서 입력시작 -->
								<c:choose>
									<c:when test="${invVO.tax_edit_end eq 0}">
										<img src="./resources/ls_img/ls_invoice/btn_s_money.gif" style="cursor:pointer;" onclick="rptTaxDtl(${invVO.rpt_invoice_no})" title="세금계산서작성하기" />	
									</c:when>
									<c:otherwise>
										<img src="./resources/ls_img/ls_invoice/btn_s_money_end.gif" style="cursor:pointer;" onclick="rptTaxDtl(${invVO.rpt_invoice_no})" title="세금계산서작업완료" />
									</c:otherwise>
								</c:choose>								
								<!-- 세금계산서 입력 끝 -->
							</td>
						</tr>
					</c:forEach>
					<tr>
						<td colspan="13" bgcolor="#e7ecf1">현재 페이지 합계</td>
						<td style="letter-spacing: 0;"><fmt:formatNumber value="${sum_amt_basic}" pattern="###,###,##0.##"/></td>
						<td style="letter-spacing: 0;"><fmt:formatNumber value="${sum_amt_daily}" pattern="###,###,##0.##"/></td>
						<td style="letter-spacing: 0;"><fmt:formatNumber value="${sum_amt_traffic}" pattern="###,###,##0.##"/></td>
						<td style="letter-spacing: 0;"><fmt:formatNumber value="${sum_amt_counsel}" pattern="###,###,##0.##"/></td>
						<td style="letter-spacing: 0;"><fmt:formatNumber value="${sum_amt_etc}" pattern="###,###,##0.##"/></td>
						<td style="letter-spacing: 0;"><fmt:formatNumber value="${sum_amt_total}" pattern="###,###,##0.##"/></td>
						<td colspan="3" style="letter-spacing: 0;">
							<font color="red"><fmt:formatNumber value="${sum_not_deposit}" pattern="###,###,##0.##"/></font>
						</td>
					</tr>
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

		<form action="./primBizInvSearch" name="primBizInvPagingSearchForm">
			<input type="hidden" id="reqPgNo" name="reqPgNo" value='<c:out value="${reqPgNoInt1}" />' >
			<input type="hidden" id="tmSearch" name="tmSearch" value='<c:out value="${searchVO.tmSearch}" />' >
			<input type="hidden" id="tmGubun" name="tmGubun" value='<c:out value="${searchVO.tmGubun}" />' >
			<input type="hidden" id="ptnrSearch" name="ptnrSearch" value='<c:out value="${searchVO.ptnrSearch}" />' >
			<input type="hidden" id="ptnrGubun" name="ptnrGubun" value='<c:out value="${searchVO.ptnrGubun}" />' >
			<input type="hidden" id="type1Search" name="type1Search" value='<c:out value="${searchVO.type1Search}" />' >
			<input type="hidden" id="speedCheck" name="speedCheck" value='<c:out value="${searchVO.speedCheck}" />' >
			<input type="hidden" id="invoice_date_From" name="invoice_date_From" value='<c:out value="${searchVO.invoice_date_From}" />' >
			<input type="hidden" id="invoice_date_To" name="invoice_date_To" value='<c:out value="${searchVO.invoice_date_To}" />' >
			<input type="hidden" id="invDateEditCheck" name="invDateEditCheck" value='<c:out value="${searchVO.invDateEditCheck}" />' >
			<input type="hidden" id="userNmSearch" name="userNmSearch" value='<c:out value="${searchVO.userNmSearch}" />' >
			<input type="hidden" id="ptnrUserNmSearch" name="ptnrUserNmSearch" value='<c:out value="${searchVO.ptnrUserNmSearch}" />' >
			<input type="hidden" id="orderBy" name="orderBy" value='<c:out value="${searchVO.orderBy}" />' >
			<input type="hidden" id="close_date_From" name="close_date_From" value='<c:out value="${searchVO.close_date_From}" />' >
			<input type="hidden" id="close_date_To" name="close_date_To" value='<c:out value="${searchVO.close_date_To}" />' >
			<input type="hidden" id="benefiNmSearch" name="benefiNmSearch" value='<c:out value="${searchVO.benefiNmSearch}" />' >
			<input type="hidden" id="policyhNmSearch" name="policyhNmSearch" value='<c:out value="${searchVO.policyhNmSearch}" />' >
			<input type="hidden" id="acceptNoSearch" name="acceptNoSearch" value='<c:out value="${searchVO.acceptNoSearch}" />' >
			<input type="hidden" id="deposit_date_From" name="deposit_date_From" value='<c:out value="${searchVO.deposit_date_From}" />' >
			<input type="hidden" id="deposit_date_To" name="deposit_date_To" value='<c:out value="${searchVO.deposit_date_To}" />' >
			<input type="hidden" id="totAmtF" name="totAmtF" value='<c:out value="${searchVO.totAmtF}" />' >
			<input type="hidden" id="totAmtT" name="totAmtT" value='<c:out value="${searchVO.totAmtT}" />' >
			<input type="hidden" id="depositNoCheck" name="depositNoCheck" value='<c:out value="${searchVO.depositNoCheck}" />' >
			<input type="hidden" id="amtEditCheck" name="amtEditCheck" value='<c:out value="${searchVO.amtEditCheck}" />' >
			<input type="hidden" id="taxNoSearch" name="taxNoSearch" value='<c:out value="${searchVO.taxNoSearch}" />' >
			<input type="hidden" id="taxNoCheck" name="taxNoCheck" value='<c:out value="${searchVO.taxNoCheck}" />' >
			<input type="hidden" id="taxEditEnd" name="taxEditEnd" value='<c:out value="${searchVO.taxEditEnd}" />' >
			<input type="hidden" id="tax_date_From" name="tax_date_From" value='<c:out value="${searchVO.tax_date_From}" />' >
			<input type="hidden" id="tax_date_To" name="tax_date_To" value='<c:out value="${searchVO.tax_date_To}" />' >
			<input type="hidden" id="pagesize_val" name="pagesize_val" value=<c:out value="${searchVO.queryPgSizeInt}" /> >
		</form>
	<!-- //page end -->
	<br>
	<!-- 총계 테이블 -->
	<div class= "tableStyle2">
		<table>
				<tr>
					<th rowspan="2">총합계</th>
					<th>기본보수</th>
					<th>일비</th>
					<th>교통비</th>
					<th>자문료</th>
					<th>기타</th>
					<th>합계</th>
					<th>미수금</th>
				</tr>
				<tr>
					<td><fmt:formatNumber value="${totVO.totAmtBasic}" pattern="###,###,##0.##"/></td>
					<td><fmt:formatNumber value="${totVO.totAmtDaily}" pattern="###,###,##0.##"/></td>
					<td><fmt:formatNumber value="${totVO.totAmtTraffic}" pattern="###,###,##0.##"/></td>
					<td><fmt:formatNumber value="${totVO.totAmtCounsel}" pattern="###,###,##0.##"/></td>
					<td><fmt:formatNumber value="${totVO.totAmtEtc}" pattern="###,###,##0.##"/></td>
					<td><fmt:formatNumber value="${totVO.totAmtTotal}" pattern="###,###,##0.##"/></td>
					<td><font color="red"><fmt:formatNumber value="${totAmtNotDeposit}" pattern="###,###,##0.##"/></font></td>
				</tr>																					
		</table>
	</div><!-- //tableStyle2 -->
	<!-- //총계 테이블 -->
	<!-- //입금일 일괄처리 팝업-->
	<div id="income-detail-dialog" title="입금일자 일괄처리" align="center"></div>
	<!-- //계산서 일괄처리 팝업 -->
	<div id="publish-detail-dialog" title="계산서 발행일자 일괄처리" align="center"></div>

</body>

</html>
