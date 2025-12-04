<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<script>
		$(document).ready(function(){
			
			if ("${srchParam.code}" == 0 || "${srchParam.code}" == 3){
				$("#srchTmId").val("${srchParam.srchTmId}");
			}
			
			$("#srchTmId").select2();
			$("#topTeamId").select2();
			$("#topMbr").select2();
			$("#mbrchgReason").select2();
			

			/* 처리팀 지정 */
			$("#topTeamId").change(function(){ 
				var team_id = $("#topTeamId option:selected").val();
				$.post("topMbrForSelectedTeam"
						,{ team_id : team_id }
						,function(data,status){
							if(status == "success"){
								$("#topMbr").empty();
								if(data.length == 0){
									$("#topMbr").append(
										"<option value='0'>"
											+"직원 없음"
										+"</option>"
									);
								}else{
									$("#topMbr").append( "<option value = '0'>담당자 미지정</option>");
									
				                    $.each(data, function(index, entry) {
			                    		$("#topMbr").append(
			                    				"<option value = '"+entry.user_no+"'>"
													+entry.user_name
		                                		+ "</option>"
			   							);
									});//each
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
						,"json"
				);//post
			});//$("#topTeamId").change()
			
			//폼에서 엔터 입력시 검색버튼 클릭
			$("#srchFrm input").keydown(function(e) {
				if( e.keyCode == 13 ){
					fnSearch();
				}					
			});
			
		});//$(document).ready()
		
		/* EXCEL 다운로드 */
		function fnExcelDown(){
	        var frm = document.getElementById("srchFrm");
	        frm.action = "./rptMbrchgListExcelDown";
	        frm.submit();
		}
		
		/* 검색 */
	    function fnSearch() {
			param = $("#srchFrm").serialize();
	        url = "./getRptMbrchgListTab";
	        
	        $.ajax({
	            type: "POST",
	            url: url,
	            data: param,
	            dataType: "html",
	            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	            timeout: 20000,
	            success: function(data){
	            	$("#listTable").html("");
	            	$("#listTable").html(data);
	            	
	            },
	            error: function(e){
	                alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
	            }
	            /*
				error : function( jqXHR, textStatus, errorThrown ) {
					
					alert( jqXHR.status );
					alert( jqXHR.statusText );
					alert( jqXHR.responseText );
					alert( jqXHR.readyState );

					alert ( textStatus );
					alert( errorThrown );
				}
	            */
	        });
	    }
		
	</script>
	
	
   	<%--검색 영역--%>
	<div class="nociteA log_top" style="margin-bottom: 20px;">
       	<div class="search_bar">
			<div style="margin-bottom: 5px;">
	       		<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0"> <b>보고서 담당자 변경</b>
	       		
	       		<span id="srchComment">
		       		&nbsp;&nbsp;&nbsp;<font color="red">※ 미결이면서 이첩 미진행건만 표시됩니다.</font>
	       		</span>
	       		
			</div>
		
			<form class="srchFrm" id="srchFrm" name="srchFrm" method="post" action="/rptMbrchgList" >
				<input type="hidden" id="pageIdx" name="pageIdx" />
				<input type="hidden" id="code" name="code" value="${srchParam.code}"/>
				<input type="hidden" id="flag" name="flag" value="${srchParam.flag}"/>
								
				<div class= "tableStyle21">
					<table>
						<colgroup>
							<col width="79px" />
							<col width="236px" />
							<col width="79px" />
							<col width="236px" />
							<col width="79px" />
							<col width="236px" />
							<col width="79px" />
							<col width="236px" />							
						</colgroup>
						
						<tr height="38">
							<th bgcolor="#e7ecf1" >접수번호</th>
							<td>
								<input class="srchInput" type="text" size="20" id="srchAcceptNo" name="srchAcceptNo" value="${srchParam.srchAcceptNo}" maxlength="10"/>
							</td>			
						
							<th bgcolor="#e7ecf1" >사고번호</th> 
							<td>
								<input class="srchInput" type="text" size="20" id="srchAccidentNo" name="srchAccidentNo" value="${srchParam.srchAccidentNo}" maxlength="10"/>
							</td>			
									
							<th bgcolor="#e7ecf1" >계약자 이름</th>
							<td>
								<input class="srchInput" type="text" size="20" id="srchPolicyNm" name="srchPolicyNm" value="${srchParam.srchPolicyNm}" maxlength="10"/>
							</td>
							
							<th bgcolor="#e7ecf1" >접수일</th>
							<td>
								<input type="text" class="calendar srchInput2" id="suimStartDate" name="suimStartDate" size="10" value="${srchParam.suimStartDate}" maxlength="10" /> ~ 
								<input type="text" class="calendar srchInput2" id="suimEndDate"  name="suimEndDate" size="10" value="${srchParam.suimEndDate}" maxlength="10"/>
							</td>			
						</tr>
						
						<tr height="38">
							<th bgcolor="#e7ecf1" >담당 부서</th>
							<td>
								<select class="srchTmId" id="srchTmId" name="srchTmId" style="width:150px;">
									<option value="999" selected>-- 전체 --</option>
									<c:forEach items="${pmsTeamList}" var = "pmsTeamVo">
										<option value="${pmsTeamVo.team_id}">
											<c:if test="${pmsTeamVo.team_level == 1}">&nbsp;└</c:if>
											${pmsTeamVo.team_name}
										</option>
									</c:forEach>
								</select>
							</td>	
							
							<th bgcolor="#e7ecf1" >담당자</th>
							<td>
								<input class="srchInput" type="text" size="20" id="srchUserNm" name="srchUserNm" value="${srchParam.srchUserNm}" maxlength="10"/>
							</td>	
							
							<th class="logTd" bgcolor="#e7ecf1" style="visibility: hidden;">이첩일</th>
							<td class="logTd" style="visibility: hidden;">
								<input type="text" class="calendar srchInput2" id="chgStartDate" name="chgStartDate" size="10" value="${srchParam.chgStartDate}" maxlength="10" /> ~ 
								<input type="text" class="calendar srchInput2" id="chgEndDate"  name="chgEndDate" size="10" value="${srchParam.chgEndDate}" maxlength="10"/>
							</td>			
									
							<td colspan="2" align="right" > 
							
								<img src="./resources/ls_img/btn_excel.gif" style="cursor:pointer;" onclick="fnExcelDown();">
								<img src="./resources/ne_img/btn/btn_src.gif" style="cursor:pointer;" onclick="fnSearch();" />
							</td>
						
						</tr>						
					</table>
				</div>	
			</form>

			<div class="tableStyle21" id="chgOutDiv">
				<table> 
					<colgroup>
						<col width="79px" />
						<col width="551px" />
						<col width="79px" />
						<col width="237px" />
						<col width="214px" />
						<col width="100px" />
					</colgroup>
					
					<tr id="tabTr0" height="36">
						<th bgcolor="#e7ecf1" >이첩 대상자</th>
						<td>
							<select class="topTeamId" name="topTeamId" id="topTeamId" style="width:180px;" >
								<option value="0" selected>담당부서 미지정</option>
								<c:forEach items="${topTeamList}" var = "topTeamVo">
									<option value="${topTeamVo.team_id}">
									<c:if test="${topTeamVo.team_level eq 1}">&nbsp;&nbsp;└</c:if>
									<c:if test="${topTeamVo.team_level eq 2}">&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
									${topTeamVo.team_name}
									</option>
								</c:forEach>
							</select>
							
							<select name="topMbr" id="topMbr" style="width:180px;">
								<option value="0">담당부서 미지정</option>
							</select>
						</td>
						
						<th bgcolor="#e7ecf1"> 이첩 사유 </th>
						<td>
							<select name="mbrchgReason" id="mbrchgReason" style="width:180px;">
								<option value="0">-- 사유 선택 --</option>
								<c:forEach items="${mbrchgReasonList}" var="reasonList">
									<option value="${reasonList.col_cd}">${reasonList.col_val}</option>
								</c:forEach>
							</select>
						</td>
						
						<td>
							<span class="chkCntSpan" id="chkCntSpan" style="font-size:13px;font-weight: bold;"> 선택한 보고서 : 0 개 </span>
						</td>
						
						<td align="right">
							<img src="./resources/ne_img/btn/btn_chgout.gif" onclick="fnRptMbrchgOut();" style="cursor:pointer;">	
						</td>
					</tr>			
									
					<tr id="tabTr1" height="36" style="display: none;">
						<td colspan="4"></td>
						<td>
							<span class="chkCntSpan" id="chkCntSpan" style="font-size:13px;font-weight: bold;"> 선택한 보고서 : 0 개 </span>
						</td>
						
						<td align="right">
							<img src="./resources/ne_img/btn/btn_chgout_cancel.gif" onclick="fnRptMbrchgOutCancel();" style="cursor:pointer;">	
						</td>
					</tr>
									
					<tr id="tabTr2" height="36" style="display:none;">
						<td colspan="4"></td>
						<td>
							<span class="chkCntSpan" id="chkCntSpan" style="font-size:13px;font-weight: bold;"> 선택한 보고서 : 0 개 </span>
						</td>
						
						<td align="right">
							<img src="./resources/ne_img/btn/btn_chgin.gif" onclick="fnRptMbrchgIn();" style="cursor:pointer;">	
						</td>
					</tr>
				</table>
			</div>	
		</div>
	</div>
