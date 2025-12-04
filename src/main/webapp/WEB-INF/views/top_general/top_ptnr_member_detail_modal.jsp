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
		.buttonAssistanceEmail {
		    width: 120px;
		    height: 50px;
		    background-color: darkCyan;
		    color: #FFFFFF;
		    text-align: center;
		    border-radius: 5px;
		    font-size: 15px;
		    font-weight: bold;
		    cursor: pointer;
		    text-decoration: none;
		    border: none;
		}
	</style>
	<script>
	$(document).ready( function(){	
		
		$("#clearBtn").click(function(){
			var sMsg = "입력된 주소와 우편번호를 초기화 하시겠습니까?";
			
			if(confirm(sMsg)){
				$("#ptnr_mbr_office_postcode_edit").val('');
				$("#ptnr_mbr_office_addr1_edit").val('');
				$("#ptnr_mbr_office_addr2_edit").val('');
				alert("주소와 우편번호가 초기화 되었습니다.\n하단의 수정버튼을 누르면 데이터에 적용됩니다.");
			}
			
		});
		
		if( '${view_type}' == 'edit' ){		//수정인경우 select 박스 변경			
			$("#editPtnrId").val(${ptnrMemberInfo.ptnr_id}).trigger('change');
			$("#editDeptId").val(${ptnrMemberInfo.ptnr_dept_id}).trigger('change');
		}
		
		
		//보험사 직원정보 수정 모달 내 보험사 선택시								
		$("#editPtnrId").change(function(){
			var sUrl = "getPtnrDeptInfoAjax";
			
			var param = {};
			param.ptnr_id = $("#editPtnrId").val();			
			
			$.ajax({
			    type: "POST",
			    url: sUrl,
			    data: param,
			    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			    timeout: 20000,
			    dataType: "json", 
			    success: function(data){						
						$("#editDeptId").empty();
						if ( JSON.stringify(data).length == 2 ){		//보험사 담당자 지원이 없을 시 '{}' 리턴 ->length == 2
							$("#editDeptId").append(
								"<option value='0'>"
									+"부서정보없음"
								+"</option>"
							);
						}else{
							$("#editDeptId").append(
								"<option value = '0'>담당부서 미지정</option>"
							);
						    $.each(data.list, function(i, n) {
								$("#editDeptId").append(
									"<option value='"+n.ptnr_dept_id+"'>"+n.ptnr_dept_nm+ "</option>"
								);
							});//each
						}
			    },
			    error: function(e){
					alert("네트웍 상태가 불안정합니다. 잠시 후 다시 시도해 주십시요.");
			    }
			});
		});
		
		//보험사 직원 추가 모달 내 보험사 선택시								
		$("#addPtnrId").change(function(){
			var sUrl = "getPtnrDeptInfoAjax";
			
			var param = {};
			param.ptnr_id = $("#addPtnrId").val();			
			
			$.ajax({
			    type: "POST",
			    url: sUrl,
			    data: param,
			    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			    timeout: 20000,
			    dataType: "json", 
			    success: function(data){						
						$("#addDeptId").empty();
						if ( JSON.stringify(data).length == 2 ){		//보험사 담당자 지원이 없을 시 '{}' 리턴 ->length == 2
							$("#addDeptId").append(
								"<option value='0'>"
									+"부서정보없음"
								+"</option>"
							);
						}else{
							$("#addDeptId").append(
								"<option value = '0'>담당부서 미지정</option>"
							);
						    $.each(data.list, function(i, n) {
								$("#addDeptId").append(
									"<option value='"+n.ptnr_dept_id+"'>"+n.ptnr_dept_nm+ "</option>"
								);
							});//each
						}
			    },
			    error: function(e){
					alert("네트웍 상태가 불안정합니다. 잠시 후 다시 시도해 주십시요.");
			    }
			});
			
		});
		
	});		
	</script>
		<%-- 조회 시작--%>
		<c:if test="${view_type eq 'view'}">
			<div id="ptnr-member-detail-dialog" title="관련업체 직원정보조회" style="font-size: 12px;" align="center">
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
							<th height="25px;">보험사명</th>
							<td style="text-align:left;padding-left:5px;">${ptnrMemberInfo.ptnr_name}</td>
							<th height="25px;">부서명</th>
							<td style="text-align:left;padding-left:5px;">${ptnrMemberInfo.ptnr_dept_nm}</td>
						</tr>
						<tr>
							<th height="25px;">팀명</th>
							<td style="text-align:left;padding-left:5px;">${ptnrMemberInfo.ptnr_tm2_nm}</td>
							<th height="25px;">이름</th>
							<td style="text-align:left;padding-left:5px;">${ptnrMemberInfo.ptnr_mbr_nm}</td>
						</tr>
						<tr>
							<th height="25px;">업종</th>
							<td style="text-align:left;padding-left:5px;">
								<c:if test="${ptnrMemberInfo.ptnr_mbr_work_type == '1'}">
									<font color="red">1종</font>
								</c:if>
								<c:if test="${ptnrMemberInfo.ptnr_mbr_work_type == '4'}">
									<font color="green">4종</font>
								</c:if>
								<c:if test="${ptnrMemberInfo.ptnr_mbr_work_type == '0'}">
									<font color="blue">1, 4종 겸직</font>
								</c:if>
							</td>
							<th height="25px;">직위</th>
							<td style="text-align:left;padding-left:5px;">${ptnrMemberInfo.ptnr_mbr_position_nm}</td>
						</tr>
						<tr>
							<th height="25px;">직책</th>
							<td style="text-align:left;padding-left:5px;">${ptnrMemberInfo.ptnr_mbr_job_memo}</td>
							<th height="25px;">휴대전화</th>
							<td style="text-align:left;padding-left:5px;">${ptnrMemberInfo.ptnr_mbr_hp}</td>
						</tr>
						<tr>
							<th height="25px;">직통전화</th>
							<td style="text-align:left;padding-left:5px;">${ptnrMemberInfo.ptnr_mbr_office_tel}</td>
							<th height="25px;">팩스</th>
							<td style="text-align:left;padding-left:5px;">${ptnrMemberInfo.ptnr_mbr_office_fax}</td>
						</tr>
						<tr>
							<th height="25px;">이메일</th>
							<td style="text-align:left;padding-left:5px;">${ptnrMemberInfo.ptnr_mbr_office_email}</td>
							<th height="25px;">주소</th>
							<td style="text-align:left;padding-left:5px;">
								<c:if test="${not empty ptnrMemberInfo.ptnr_mbr_office_postcode}">
									(${ptnrMemberInfo.ptnr_mbr_office_postcode})
								</c:if>
								${ptnrMemberInfo.ptnr_mbr_office_addr1} ${ptnrMemberInfo.ptnr_mbr_office_addr2}
							</td>
						</tr>
						<tr>
							<th height="30px;">기타메모</th>
							<td style="text-align:left;padding-left:5px;">${ptnrMemberInfo.ptnr_mbr_work_memo}</td>
							<th height="30px;">세금계산서<br/>담당자</th>
							<td style="text-align:left;padding-left:5px;">${ptnrMemberInfo.ptnr_tax_nm}</td>
						</tr>
					</tbody>
					</table>
				</div>
			</div>
		</c:if>
		<%-- 조회 끝--%>
		
		<%-- 등록 폼 시작--%>
		<c:if test="${view_type eq 'add'}">
		<form id="ptnrAddActionFrm">
			<div id="ptnr-member-detail-dialog" title="관련업체 직원정보등록" style="font-size: 12px;" align="center">
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
							<th height="25px;">보험사명</th>
							<td style="text-align:left;padding-left:5px;">								
								<select id="addPtnrId" name="addPtnrId" style="width:90%;">
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
							<th height="25px;">부서명</th>
							<td style="text-align:left;padding-left:5px;">
								<select id="addDeptId" name="addDeptId" style="width:90%;">
									<option value="0" selected>부서 미지정</option>									
								</select>
								<%-- ${ptnrMemberInfo.ptnr_dept_nm} --%>
							</td>
						</tr>
						<tr>
							<th height="25px;">팀명</th>
							<td style="text-align:left;padding-left:5px;">
								<input type="text" id="ptnr_tm2_nm_add" name="ptnr_tm2_nm_add" style="width:90%;">
								<%-- ${ptnrMemberInfo.ptnr_tm2_nm} --%>
							</td>
							<th height="25px;">이름</th>
							<td style="text-align:left;padding-left:5px;">
								<input type="text" id="ptnr_mbr_nm_add" name="ptnr_mbr_nm_add" style="width:90%;">
								<%-- ${ptnrMemberInfo.ptnr_mbr_nm} --%>
							</td>
						</tr>
						<tr>
							<th height="25px;">업종</th>
							<td style="text-align:left;padding-left:5px;">
								<input type="radio" name="ptnr_mbr_work_type_add" id="ptnr_mbr_work_type_add_1" value="1">								
									<font color="red">1종</font>&nbsp;								
								<input type="radio" name="ptnr_mbr_work_type_add" id="ptnr_mbr_work_type_add_4" value="4">
									<font color="green">4종</font>&nbsp;								
								<input type="radio" name="ptnr_mbr_work_type_add" id="ptnr_mbr_work_type_add_0" value="0">
									<font color="blue">1, 4종 겸직</font>							
							</td>
							<th height="25px;">직위</th>
							<td style="text-align:left;padding-left:5px;">
								<input type="text" id="ptnr_mbr_position_nm_add" name="ptnr_mbr_position_nm_add" style="width:90%;">
								<%-- ${ptnrMemberInfo.ptnr_mbr_position_nm} --%>
							</td>
						</tr>
						<tr>
							<th height="25px;">직책</th>
							<td style="text-align:left;padding-left:5px;">
								<input type="text" id="ptnr_mbr_job_memo_add" name="ptnr_mbr_job_memo_add" style="width:90%;">
								<%-- ${ptnrMemberInfo.ptnr_mbr_job_memo} --%>								
							</td>
							<th height="25px;">휴대전화</th>
							<td style="text-align:left;padding-left:5px;">
								<input type="text" id="ptnr_mbr_hp_add" name="ptnr_mbr_hp_add" style="width:90%;">
								<%-- ${ptnrMemberInfo.ptnr_mbr_hp} --%>
							</td>
						</tr>
						<tr>
							<th height="25px;">직통전화</th>
							<td style="text-align:left;padding-left:5px;">
								<input type="text" id="ptnr_mbr_office_tel_add" name="ptnr_mbr_office_tel_add" style="width:90%;">
								<%-- ${ptnrMemberInfo.ptnr_mbr_office_tel} --%>
							</td>
							<th height="25px;">팩스</th>
							<td style="text-align:left;padding-left:5px;">
								<input type="text" id="ptnr_mbr_office_fax_add" name="ptnr_mbr_office_fax_add" style="width:90%;">
								<%-- ${ptnrMemberInfo.ptnr_mbr_office_fax} --%>
							</td>
						</tr>
						<tr>
							<th height="25px;">이메일</th>
							<td style="text-align:left;padding-left:5px;">
								<input type="text" id="ptnr_mbr_office_email_add" name="ptnr_mbr_office_email_add" style="width:90%;">
								<%-- ${ptnrMemberInfo.ptnr_mbr_office_email} --%>
							</td>
							<th height="30px;">세금계산서<br/>담당자</th>
							<td style="text-align:left;padding-left:5px;">
								<input type="text" id="ptnr_tax_nm_add" name="ptnr_tax_nm_add" style="width:90%;">
								<%-- ${ptnrMemberInfo.ptnr_tax_nm} --%>
							</td>							
						</tr>
						<tr>
							<th height="25px;">주소</th>
							<td style="text-align:left;padding-left:5px;" colspan="3">
								<input type="text" name="ptnr_mbr_office_postcode_add" id="ptnr_mbr_office_postcode_add" size="12" readonly style="background-color:lightgrey;" />
									<input type="button" id="postCodeBtn" value="우편번호 찾기" onclick="javascript:postCodeBtnAdd();">
									<input type="text" name="ptnr_mbr_office_addr1_add" id="ptnr_mbr_office_addr1_add" size="30" readonly style="background-color:lightgrey;" />
									<input type="text" name="ptnr_mbr_office_addr2_add" id="ptnr_mbr_office_addr2_add" size="37" />
								<%-- <c:if test="${not empty ptnrMemberInfo.ptnr_mbr_office_postcode}">
									(${ptnrMemberInfo.ptnr_mbr_office_postcode})
								</c:if>
								${ptnrMemberInfo.ptnr_mbr_office_addr1} ${ptnrMemberInfo.ptnr_mbr_office_addr2} --%>
							</td>
						</tr>
						<tr>
							<th height="30px;">기타메모</th>
							<td style="text-align:left;padding-left:5px;" colspan="3">
								<input type="text" id="ptnr_mbr_work_memo_add" name="ptnr_mbr_work_memo_add" style="width:96%;">
								<%-- ${ptnrMemberInfo.ptnr_mbr_work_memo} --%>
							</td>							
						</tr>
					</tbody>
					</table>
				</div>
			</div>
		</form>			
		</c:if>
		<%-- 등록 폼 끝--%>
		
		<%-- 수정 폼 시작--%>
		<c:if test="${view_type eq 'edit'}">
		<form id="ptnrEditActionFrm">
			<input type="hidden" id="editPtnrMbrNo" name="editPtnrMbrNo" value="${ptnrMemberInfo.ptnr_mbr_no}">
			<div id="ptnr-member-detail-dialog" title="관련업체 직원정보수정" style="font-size: 12px;" align="center">
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
							<th height="25px;">보험사명</th>
							<td style="text-align:left;padding-left:5px;">								
								<select id="editPtnrId" name="editPtnrId" style="width:90%;">
									<option value="0" selected>전체</option>
									<c:forEach items="${ptnrListForSearch}" var = "ptnrVo">
										<option value="${ptnrVo.ptnr_id}">
											<c:if test="${ptnrVo.ptnr_level == 1}">&nbsp;└</c:if>
											${ptnrVo.ptnr_nick}
										</option>
									</c:forEach>
								</select>
							</td>
							<th height="25px;">부서명</th>
							<td style="text-align:left;padding-left:5px;">
								<select id="editDeptId" name="editDeptId" style="width:90%;">
									<option value="0" selected>부서 미지정</option>
									<c:forEach items="${ptnrDeptList}" var = "deptVo">
										<option value="${deptVo.ptnr_dept_id}">${deptVo.ptnr_dept_nm}</option>
									</c:forEach>									
								</select>								
							</td>
						</tr>
						<tr>
							<th height="25px;">팀명</th>
							<td style="text-align:left;padding-left:5px;">
								<input type="text" id="ptnr_tm2_nm_edit" name="ptnr_tm2_nm_edit" style="width:90%;" value="${ptnrMemberInfo.ptnr_tm2_nm}">								
							</td>
							<th height="25px;">이름</th>
							<td style="text-align:left;padding-left:5px;">
								<input type="text" id="ptnr_mbr_nm_edit" name="ptnr_mbr_nm_edit" style="width:90%;" value="${ptnrMemberInfo.ptnr_mbr_nm}">								
							</td>
						</tr>
						<tr>
							<th height="25px;">업종</th>							
							<td style="text-align:left;padding-left:5px;">
								<input type="radio" name="ptnr_mbr_work_type_edit" id="ptnr_mbr_work_type_edit_1" value="1" <c:if test="${ptnrMemberInfo.ptnr_mbr_work_type eq 1}">checked</c:if> >								
									<font color="red">1종</font>&nbsp;								
								<input type="radio" name="ptnr_mbr_work_type_edit" id="ptnr_mbr_work_type_edit_4" value="4" <c:if test="${ptnrMemberInfo.ptnr_mbr_work_type eq 4}">checked</c:if> >
									<font color="green">4종</font>&nbsp;								
								<input type="radio" name="ptnr_mbr_work_type_edit" id="ptnr_mbr_work_type_edit_0" value="0" <c:if test="${ptnrMemberInfo.ptnr_mbr_work_type eq 0}">checked</c:if> >
									<font color="blue">1, 4종 겸직</font>							
							</td>
							<th height="25px;">직위</th>
							<td style="text-align:left;padding-left:5px;">
								<input type="text" id="ptnr_mbr_position_nm_edit" name="ptnr_mbr_position_nm_edit" style="width:90%;" value="${ptnrMemberInfo.ptnr_mbr_position_nm}">
							</td>
						</tr>
						<tr>
							<th height="25px;">직책</th>
							<td style="text-align:left;padding-left:5px;">
								<input type="text" id="ptnr_mbr_job_memo_edit" name="ptnr_mbr_job_memo_edit" style="width:90%;" value="${ptnrMemberInfo.ptnr_mbr_job_memo}">
							</td>
							<th height="25px;">휴대전화</th>
							<td style="text-align:left;padding-left:5px;">
								<input type="text" id="ptnr_mbr_hp_edit" name="ptnr_mbr_hp_edit" style="width:90%;" value="${ptnrMemberInfo.ptnr_mbr_hp}">
							</td>
						</tr>
						<tr>
							<th height="25px;">직통전화</th>
							<td style="text-align:left;padding-left:5px;">
								<input type="text" id="ptnr_mbr_office_tel_edit" name="ptnr_mbr_office_tel_edit" style="width:90%;" value="${ptnrMemberInfo.ptnr_mbr_office_tel}">
							</td>
							<th height="25px;">팩스</th>
							<td style="text-align:left;padding-left:5px;">
								<input type="text" id="ptnr_mbr_office_fax_edit" name="ptnr_mbr_office_fax_edit" style="width:90%;" value="${ptnrMemberInfo.ptnr_mbr_office_fax}">
							</td>
						</tr>
						<tr>
							<th height="25px;">이메일</th>
							<td style="text-align:left;padding-left:5px;">
								<input type="text" id="ptnr_mbr_office_email_edit" name="ptnr_mbr_office_email_edit" style="width:90%;" value="${ptnrMemberInfo.ptnr_mbr_office_email}">
							</td>
							<th height="30px;">세금계산서<br/>담당자</th>
							<td style="text-align:left;padding-left:5px;">
								<input type="text" id="ptnr_tax_nm_edit" name="ptnr_tax_nm_edit" style="width:90%;" value="${ptnrMemberInfo.ptnr_tax_nm}">
							</td>							
						</tr>
						<tr>
							<th height="25px;">주소</th>
							<td colspan="3">
								<table>
									<tr>
										<td style="width:70%;text-align:left;padding-left:5px;border:0px;">
											<input type="text" name="ptnr_mbr_office_postcode_edit" id="ptnr_mbr_office_postcode_edit" size="12" readonly style="background-color:lightgrey;" value="${ptnrMemberInfo.ptnr_mbr_office_postcode}"/>
											<input type="button" id="postCodeBtn" value="우편번호 찾기" onclick="javascript:postCodeBtnEdit();">
											<input type="text" name="ptnr_mbr_office_addr1_edit" id="ptnr_mbr_office_addr1_edit" size="34" readonly style="background-color:lightgrey;" value="${ptnrMemberInfo.ptnr_mbr_office_addr1}" />
										</td>
										<td style="width:30%;text-align:left;padding-left:5px;border:0px;" rowspan="2">
											<input title="주소 초기화" class="buttonAssistanceEmail" type="button" value="주소 초기화" id="clearBtn">
										</td>										
									</tr>
									<tr>
										<td style="width:70%;text-align:left;padding-left:5px;border:0px;">
											<input type="text" name="ptnr_mbr_office_addr2_edit" id="ptnr_mbr_office_addr2_edit" size="58" value="${ptnrMemberInfo.ptnr_mbr_office_addr2}" />
										</td>		
									</tr>
								</table>
							</td>
							<%-- <td style="text-align:left;padding-left:5px;" colspan="3">
								<input type="text" name="ptnr_mbr_office_postcode_edit" id="ptnr_mbr_office_postcode_edit" size="12" readonly style="background-color:lightgrey;" value="${ptnrMemberInfo.ptnr_mbr_office_postcode}"/>
								<input type="button" id="postCodeBtn" value="우편번호 찾기" onclick="javascript:postCodeBtnEdit();">
								<input type="text" name="ptnr_mbr_office_addr1_edit" id="ptnr_mbr_office_addr1_edit" size="30" readonly style="background-color:lightgrey;" value="${ptnrMemberInfo.ptnr_mbr_office_addr1}" />
								<input type="text" name="ptnr_mbr_office_addr2_edit" id="ptnr_mbr_office_addr2_edit" size="37" value="${ptnrMemberInfo.ptnr_mbr_office_addr2}" />
							</td> --%>
						</tr>
						<tr>
							<th height="30px;">기타메모</th>
							<td style="text-align:left;padding-left:5px;" colspan="3">
								<input type="text" id="ptnr_mbr_work_memo_edit" name="ptnr_mbr_work_memo_edit" style="width:96%;" value="${ptnrMemberInfo.ptnr_mbr_work_memo}" />
							</td>							
						</tr>
					</tbody>
					</table>
				</div>
			</div>
		</form>			
		</c:if>
		<%-- 수정 폼 끝 --%>