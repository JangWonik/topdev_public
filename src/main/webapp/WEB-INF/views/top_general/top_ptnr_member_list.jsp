<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<script src="./resources/daum/postcode.v2.js"></script>
<script src='https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js'></script>	
	<style>
		.tableStyle2 td{
			letter-spacing : 0px;
		}
		
		.td-overflow-none{
			text-overflow : ellipsis;
			overflow : hidden;
			white-space : nowrap;
			word-wrap:normal;
		}
		
		.btn-vacation-aprv {
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
			color:#ffffff  !important;
			width:60px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #2E7EE8;			
		}
		
		.buttonMini{
			width:40px;
			height:20px;
		    background-color:#CEE3F6;
		    color:#666;
		    text-align: center;
			border-radius:5px;
		    font-size: 11px;
		    font-weight: bold;
		    cursor: pointer;
		    text-decoration:none;
		    border: solid 0px grey;		    
		}

		.btn-vacation-aprv:active {
			position:relative;
			top:4px
		}
		
		/* 모달 버튼 */
		.ui-button-text-only {
			height:2.1em !important;
		}
	</style>
	<script>
		function doMemberSearch(){
			
			var formData = $("#searchFrm").serialize();
			$.ajax({
				type : "post",
				url : "topPtnrMemberListAjax",
				data : formData,
				success : function(result){					
					$("#ptnrMemberList").html(result);				
				},
				error: function (request, status, error) {			
					console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
				}
			});
		}
		
		function fnGoSearchPage(pageIdx) {			
		    $("#pageIdxSearch").val(pageIdx);
		    doMemberSearch();
		}
		
		function enterKey(){
			if(event.keyCode == 13){				
				doMemberSearch();
			}
		}
		
		function doMemberExcelDown(){
			
			var gubunVal = $("#srchPtnrId").val();
			if( gubunVal == 0 ){
				$("#gubun").val('all');
			}else{
				$("#gubun").val(gubunVal);
			}
			
			$('#memberFiledownForm').submit();			
			
		}
		
		//담당직원 수정 폼 열기
		function doMemberEdit( p_ptnr_mbr_no ){
			
			var sUrl = "ptnrMemberDetailModal";
			
			var param = {};			
			param.view_type = "edit";
			param.ptnr_mbr_no = p_ptnr_mbr_no;
			
			$.ajax({
				type: "POST",
				url: sUrl,
				data: param,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				timeout: 20000,
				dataType: "HTML", 
				success: function(data){
					$("#ptnr-member-detail-dialog").html();
					$("#ptnr-member-detail-dialog").html(data);
						$("#ptnr-member-detail-dialog").dialog({
							height: 450,
							width: 850,
							closeOnEscape : true,
							draggable : true,
							title: "관련업체 직원수정",							
							modal: true,
							buttons:{
								"수정" : function(){																								
									doMemberEditSave();
								},								
								"닫기" : function(){
									$(this).dialog("close");
								}
							},
							overlay:{ opacity: 0., background: '#000000'}
						});
						
						//modal 창 안에 select2 활성화 
					    $("#editPtnrId").select2({
					    	dropdownParent: $("#ptnr-member-detail-dialog")
					    });
					    $("#editDeptId").select2({
					    	dropdownParent: $("#ptnr-member-detail-dialog")
					    });					    
				},
				error: function(e){
				    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
				}
			});
		}
		
		//직원 정보수정 저장
		function doMemberEditSave(){
			
			var sUrl = "actionMemberSave";
			
			var ptnrMbrNoVal = $("#editPtnrMbrNo").val();			//수정할 직원사번
			var ptnrIdVal = $("#editPtnrId").val();						//보험사 아이디
			var ptnrMbrWorkTypeVal = $('input[name=ptnr_mbr_work_type_edit]:checked').val();			//직종구분
			var ptnrMbrNmVal = $("#ptnr_mbr_nm_edit").val();		//이름
						
			//유효성 체크
			if( ptnrIdVal == 0 ){
				alert("보험사명을 선택해주세요.");
				$("#editPtnrId").focus();
				return;
			}
			
			if( ptnrMbrNmVal == '' ){
				alert("이름을 입력해주세요.");
				$("#ptnr_mbr_nm_edit").focus();
				return;
			}
			
			if( typeof ptnrMbrWorkTypeVal == "undefined" ){
				alert("업종을 선택해주세요.");
				$("#ptnr_mbr_work_type_edit_1").focus();
				return;
			}			
			
			var param = {};			
			param.action_flag = "U";
			param.ptnr_mbr_no = ptnrMbrNoVal;
			param.ptnr_id =  ptnrIdVal;
			param.ptnr_dept_id = $("#editDeptId").val();
			param.ptnr_tm_nm = $("#editDeptId option:selected").text().trim();
			param.ptnr_tm2_nm = $("#ptnr_tm2_nm_edit").val();
			param.ptnr_mbr_nm = ptnrMbrNmVal;
			param.ptnr_mbr_work_type = ptnrMbrWorkTypeVal;
			param.ptnr_mbr_position_nm = $("#ptnr_mbr_position_nm_edit").val();
			param.ptnr_mbr_job_memo = $("#ptnr_mbr_job_memo_edit").val();
			param.ptnr_mbr_hp = $("#ptnr_mbr_hp_edit").val();
			param.ptnr_mbr_office_tel = $("#ptnr_mbr_office_tel_edit").val();
			param.ptnr_mbr_office_fax = $("#ptnr_mbr_office_fax_edit").val();
			param.ptnr_mbr_office_email = $("#ptnr_mbr_office_email_edit").val();
			param.ptnr_mbr_office_postcode = $("#ptnr_mbr_office_postcode_edit").val();
			param.ptnr_mbr_office_addr1 = $("#ptnr_mbr_office_addr1_edit").val();
			param.ptnr_mbr_office_addr2 = $("#ptnr_mbr_office_addr2_edit").val();
			param.ptnr_mbr_work_memo = $("#ptnr_mbr_work_memo_edit").val();
			param.ptnr_tax_nm = $("#ptnr_tax_nm_edit").val();
			
			$.ajax({
				type: "POST",
       	        url: sUrl,
       	        data: param,
       	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
       	        timeout: 20000,
       	        async: false,
       	        dataType: "html", 
       	        success: function(data){
       	        	if (data == 1){
						alert("관련업체 담당직원 정보를 수정하였습니다.");
						$("#ptnr-member-detail-dialog").dialog("close");						
       	        	}else{
       	        		alert("관련업체 담당직원 정보 수정에 실패 하였습니다.");
       	        	}
       	        	
       	       		//재검색
					doMemberSearch();
       	        },
				error: function(e){
				    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
				}
			});
			
			
		}
		
		//담당직원 등록 폼 열기
		function doMemberAdd(){
			var sUrl = "ptnrMemberDetailModal";
			
			var param = {};			
			param.view_type = "add";
			
			$.ajax({
				type: "POST",
				url: sUrl,
				data: param,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				timeout: 20000,
				dataType: "HTML", 
				success: function(data){
					$("#ptnr-member-detail-dialog").html();
					$("#ptnr-member-detail-dialog").html(data);
						$("#ptnr-member-detail-dialog").dialog({
							height: 450,
							width: 850,
							closeOnEscape : true,
							draggable : true,
							title: "관련업체 직원등록",							
							modal: true,
							buttons:{
								"등록" : function(){																								
									doMemberAddSave();
								},								
								"닫기" : function(){
									$(this).dialog("close");
								}
							},
							overlay:{ opacity: 0., background: '#000000'}
						});
						
						//modal 창 안에 select2 활성화 
					    $("#addPtnrId").select2({
					    	dropdownParent: $("#ptnr-member-detail-dialog")
					    });
					    $("#addDeptId").select2({
					    	dropdownParent: $("#ptnr-member-detail-dialog")
					    });					    
				},
				error: function(e){
				    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
				}
			});			
		}
		
		//직원 등록 저장
		function doMemberAddSave(){
			
			var sUrl = "actionMemberSave";
			
			var ptnrIdVal = $("#addPtnrId").val();		//보험사 아이디
			var ptnrMbrWorkTypeVal = $('input[name=ptnr_mbr_work_type_add]:checked').val();			//직종구분
			var ptnrMbrNmVal = $("#ptnr_mbr_nm_add").val();		//이름
						
			//유효성 체크
			if( ptnrIdVal == 0 ){
				alert("보험사명을 선택해주세요.");
				$("#addPtnrId").focus();
				return;
			}
			
			if( ptnrMbrNmVal == '' ){
				alert("이름을 입력해주세요.");
				$("#ptnr_mbr_nm_add").focus();
				return;
			}
			
			if( typeof ptnrMbrWorkTypeVal == "undefined" ){
				alert("업종을 선택해주세요.");
				$("#ptnr_mbr_work_type_add_1").focus();
				return;
			}			
			
			var param = {};
			param.action_flag = "I";
			param.ptnr_id =  ptnrIdVal;
			param.ptnr_dept_id = $("#addDeptId").val();
			param.ptnr_tm_nm = $("#addDeptId option:selected").text().trim();
			param.ptnr_tm2_nm = $("#ptnr_tm2_nm_add").val();
			param.ptnr_mbr_nm = ptnrMbrNmVal;
			param.ptnr_mbr_work_type = ptnrMbrWorkTypeVal;
			param.ptnr_mbr_position_nm = $("#ptnr_mbr_position_nm_add").val();
			param.ptnr_mbr_job_memo = $("#ptnr_mbr_job_memo_add").val();
			param.ptnr_mbr_hp = $("#ptnr_mbr_hp_add").val();
			param.ptnr_mbr_office_tel = $("#ptnr_mbr_office_tel_add").val();
			param.ptnr_mbr_office_fax = $("#ptnr_mbr_office_fax_add").val();
			param.ptnr_mbr_office_email = $("#ptnr_mbr_office_email_add").val();
			param.ptnr_mbr_office_postcode = $("#ptnr_mbr_office_postcode_add").val();
			param.ptnr_mbr_office_addr1 = $("#ptnr_mbr_office_addr1_add").val();
			param.ptnr_mbr_office_addr2 = $("#ptnr_mbr_office_addr2_add").val();
			param.ptnr_mbr_work_memo = $("#ptnr_mbr_work_memo_add").val();
			param.ptnr_tax_nm = $("#ptnr_tax_nm_add").val();
			
			$.ajax({
				type: "POST",
       	        url: sUrl,
       	        data: param,
       	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
       	        timeout: 20000,
       	        async: false,
       	        dataType: "html", 
       	        success: function(data){
       	        	if (data == 1){
						alert("관련업체 담당직원 정보를 등록하였습니다.");
						$("#ptnr-member-detail-dialog").dialog("close");						
       	        	}else{
       	        		alert("관련업체 담당직원 정보 등록에 실패 하였습니다.");
       	        	}
       	        	
       	       		//재검색
					doMemberSearch();
       	        },
				error: function(e){
				    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
				}
			});
		}
		
		//당당직원 정보 삭제
		function doMemberDel( p_ptnr_mbr_no, p_ptnr_mbr_nm ){
			
			if( !confirm( p_ptnr_mbr_nm+"님의 관련업체 직원정보를 삭제하시겠습니까?" ) ){
				return;
			}
			
			var sUrl = "actionMemberSave";
			
			var param = {};			
			param.action_flag = "D";
			param.ptnr_mbr_no = p_ptnr_mbr_no;
			
			$.ajax({
				type: "POST",
       	        url: sUrl,
       	        data: param,
       	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
       	        timeout: 20000,
       	        async: false,
       	        dataType: "html", 
       	        success: function(data){
       	        	if (data == 1){
						alert("관련업체 담당직원 정보를 삭제하였습니다.");												
       	        	}else{
       	        		alert("관련업체 담당직원 정보 삭제에 실패 하였습니다.");
       	        	}
       	        	
       	       		//재검색
					doMemberSearch();
       	        },
				error: function(e){
				    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
				}
			});
			
		}
		
		function openDetailView( p_ptnr_user_no ){
			
			var sUrl = "ptnrMemberDetailModal";
			
			var param = {};
			param.ptnr_mbr_no = p_ptnr_user_no;
			param.view_type = "view";
			
			$.ajax({
				type: "POST",
				url: sUrl,
				data: param,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				timeout: 20000,
				dataType: "HTML", 
				success: function(data){
					$("#ptnr-member-detail-dialog").html();
					$("#ptnr-member-detail-dialog").html(data);
						$("#ptnr-member-detail-dialog").dialog({
							height: 400,
							width: 800,
							closeOnEscape : true,
							draggable : true,
							title: "관련업체 직원정보",							
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
		
		function postCodeBtnAdd(){
			var themeObj = {
					   bgColor: "#C00C0C", //바탕 배경색					   
					   emphTextColor: "#C01160" //강조 글자색					   
					};
				new daum.Postcode({
				theme: themeObj,
				oncomplete: function(data) {
					$("#ptnr_mbr_office_postcode_add").val(data.zonecode);
					$("#ptnr_mbr_office_addr1_add").val(data.roadAddress);
				}
			}).open();
		}
		
		function postCodeBtnEdit(){
			var themeObj = {
					   bgColor: "#C00C0C", //바탕 배경색					   
					   emphTextColor: "#C01160" //강조 글자색					   
					};
				new daum.Postcode({
				theme: themeObj,
				oncomplete: function(data) {
					$("#ptnr_mbr_office_postcode_edit").val(data.zonecode);
					$("#ptnr_mbr_office_addr1_edit").val(data.roadAddress);
				}
			}).open();
		}
	</script>				
		<div class= "tableStyle2" style="border-top: 0px;">
			<!-- search-box -->
			<form id="searchFrm" name="searchFrm" method="POST">
				<input type="hidden" id="view_type" name="view_type" value="member" />
				<input type="hidden" id="pageIdxSearch" name="pageIdxSearch" />									
				<div id="search-box"  align="center" style="padding-bottom:5px;">
					<table style="width: 100%;">											
						<tr>
							<th width="10%">보험사명</th>
							<td width="20%">
								<select id="srchPtnrId" name="srchPtnrId" style="width:90%;">
									<option value="0" selected>전체</option>
									<c:forEach items="${ptnrListForSearch}" var = "ptnrVo">
										<option value="${ptnrVo.ptnr_id}"
											<c:if test="${ptnrVo.ptnr_id == ptnrSrc}">selected</c:if>>
											<c:if test="${ptnrVo.ptnr_level == 1}">&nbsp;└</c:if>
											${ptnrVo.ptnr_nick}
										</option>
									</c:forEach>
								</select>													
							</td>
							<th width="10%">이름</th>
							<td width="15%">
								<input type="text" name="srchPtnrMbrName" id="srchPtnrMbrName" value="${paramMap.srchPtnrMbrName}" style="width:90%;" onkeypress="JavaScript:enterKey();"/>											
							</td>
							<th width="10%">직통번호</th>
							<td width="25%">
								<input type="text" name="srchPtnrMbrTel" id="srchPtnrMbrTel" value="${paramMap.srchPtnrMbrTel}"  style="width:90%;" onkeypress="JavaScript:enterKey();" placeholder="(예:02-1234-5678) 이 형식으로 입력"/>												
							</td>
							<td width="10%">								
								<a href="#noloc" class="btn-vacation-aprv" id="approval-all-btn-search" onclick="javascript:doMemberSearch();">검 색</a>
							</td>												
						</tr>
					</table>					
				</div> 
			</form>				
			<div style="text-align:left;padding-bottom:5px;float:left;">
				<c:if test="${mbrAuthVo_Session.mbr_pms_9 == 1 }">
					<a href="#noloc" class="btn-vacation-aprv" id="approval-all-btn-search" style="background-color:#FFA500;width:100px;" onclick="javascript:doMemberAdd();">담당직원 등록</a>
				</c:if>
			</div>	
			<div style="text-align:right;padding-bottom:5px;float:right;">				
				<img src="./resources/ls_img/ls_invoice/btn_excel.gif" style='cursor:pointer;' id="approvalAllexcelBtn" onclick="javascript:doMemberExcelDown();"/>
			</div>																		
			<table>
					<tr>											
						<th width="4%">No.</th>
						<th width="9%">이름</th>
						<th width="9%">보험사명</th>
						<th width="15%">부서명(팀명)</th>
						<th width="6%">직위</th>
						<th width="6%">직책</th>
						<th width="6%">업종</th>
						<th width="7%">휴대폰</th>
						<th width="7%">직통전화</th>
						<th width="7%">팩스</th>
						<th width="8%">이메일</th>
						<!-- <th width="8%">메모</th>
						<th width="8%">주소</th> -->
						<th width="7%">세금계산서<br/>담당자</th>
						<th width="9%">-</th>											
					</tr>
			</table>
			<div id="ptnrMemberList"></div>
		</div>
		<div id="ptnr-member-detail-dialog" title="상세 보기" style="font-size: 15px;display:none;" align="center">
		</div>
		<form id="memberFiledownForm" name="memberFiledownForm" action="excelPtnrMember" method="GET">
			<input type="hidden" id="gubun" name="gubun"/>
		</form>		