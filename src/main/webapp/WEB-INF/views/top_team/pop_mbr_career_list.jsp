<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<div class= "tableStyle2">
		<!-- 검색 결과 테이블 시작-->
		<table>
			<colgroup>
				<col width="23%">
				<col width="17%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="15%">
				<col width="5%">
			</colgroup>
			<thead>
				<tr>
					<th colspan="8">경력사항(보험)</th>
				</tr>
				<tr>
					<th rowspan="2">회사명</th>
					<th rowspan="2">부서</th>
					<th rowspan="2">직위</th>
					<th colspan="2">근무기간</th>
					<th rowspan="2">근속년수</th>
					<th rowspan="2">담당업무</th>
					<th rowspan="2"></th>
				</tr>
				<tr>
					<th>입사일자</th>
					<th>퇴사일자</th>
				</tr>
				<c:forEach items="${getMbrCareer}" var="items" varStatus="status">
					<tr>
						<td><input type="text" id="career_corporate_name${status.index}" class="career_corporate_name" name="career_corporate_name" style="width:210px" value="${items.getCareer_corporate_name()}"/></td>
						<td><input type="text" id="career_depart${status.index}" name="career_depart" style="width:150px" value="${items.getCareer_depart()}"/></td>
						<td><input type="text" id="career_rank${status.index}" name="career_rank" style="width:80px" value="${items.getCareer_rank()}"/></td>
						<td><input type="text" id="career_start_date${status.index}" name="career_start_date" class="career_start_date" style="width:65px" value="${items.getCareer_start_date()}"/></td>
						<td><input type="text" id="career_end_date${status.index}" name="career_end_date" class="career_end_date" style="width:65px" value="${items.getCareer_end_date()}"/></td>
						<td>
							<input type="text" id="career_year${status.index}" name="career_year" style="width:20px" value="${items.getCareer_year()}"/>년&nbsp;
							<input type="text" id="career_month${status.index}" name="career_month" style="width:20px" value="${items.getCareer_month()}"/>개월
						</td>
						<td><input type="text" id="career_work${status.index}" name="career_work" style="width:130px" value="${items.getCareer_work()}"/></td>
						<td>
							<input type="image" src="./resources/ls_img/btn_edit_s.gif" style="cursor:pointer;" class="udtMemberCareer" value="${status.index}"/>
							<input type="image" src="./resources/ls_img/btn_del_s.gif" style="cursor:pointer;" class="delMemberCareer" value="${status.index}"/>
							<input type="hidden" id="career_no${status.index}" name="career_no" value="${items.getCareer_no()}"/>
						</td>
					</tr>
				</c:forEach>
				<tr>
					<td><input type="text" id="career_corporate_name" name="career_corporate_name" style="width:210px"/></td>
					<td><input type="text" id="career_depart" name="career_depart" style="width:150px"/></td>
					<td><input type="text" id="career_rank" name="career_rank" style="width:80px"/></td>
					<td><input type="text" id="career_start_date" name="career_start_date" style="width:65px"/></td>
					<td><input type="text" id="career_end_date" name="career_end_date" style="width:65px"/></td>
					<td>
						<input type="text" id="career_year" name="career_year" style="width:20px"/>년&nbsp;
						<input type="text" id="career_month" name="career_month" style="width:20px"/>개월
					</td>
					<td><input type="text" id="career_work" name="career_work" style="width:130px"/></td>
					<td><input type="image" src="./resources/ls_img/btn_add.gif" style="cursor:pointer;" id="addMemberCareerIns"/></td>
				</tr>
				<tr>
					<th colspan="5">근속누계</th>
					<td>
						<c:out value="${getMbrCareerSum.getCareer_year_sum()}"/>년&nbsp;
						<c:out value="${getMbrCareerSum.getCareer_month_sum()}"/>개월
					</td>
					<td></td>
					<td></td>
				</tr>
			</thead>
		</table>		
		
		<br />
		
		<!-- 경력사항 건설 -->
		<table>
			<colgroup>
				<col width="23%">
				<col width="17%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="15%">
				<col width="5%">
			</colgroup>
			<thead>
				<tr>
					<th colspan="8">경력사항(건설)</th>
				</tr>
				<tr>
					<th rowspan="2">회사명</th>
					<th rowspan="2">부서</th>
					<th rowspan="2">직위</th>
					<th colspan="2">근무기간</th>
					<th rowspan="2">근속년수</th>
					<th rowspan="2">담당업무</th>
					<th rowspan="2"></th>
				</tr>
				<tr>
					<th>입사일자</th>
					<th>퇴사일자</th>
				</tr>
				<c:forEach items="${getMbrCareerCst}" var="items" varStatus="status">
					<tr>
						<td><input type="text" id="career2_corporate_name${status.index}" class="career_corporate_name" name="career_corporate_name" style="width:210px" value="${items.getCareer_corporate_name()}"/></td>
						<td><input type="text" id="career2_depart${status.index}" name="career_depart" style="width:150px" value="${items.getCareer_depart()}"/></td>
						<td><input type="text" id="career2_rank${status.index}" name="career_rank" style="width:80px" value="${items.getCareer_rank()}"/></td>
						<td><input type="text" id="career2_start_date${status.index}" name="career_start_date" class="career_start_date" style="width:65px" value="${items.getCareer_start_date()}"/></td>
						<td><input type="text" id="career2_end_date${status.index}" name="career_end_date" class="career_end_date" style="width:65px" value="${items.getCareer_end_date()}"/></td>
						<td>
							<input type="text" id="career2_year${status.index}" name="career_year" style="width:20px" value="${items.getCareer_year()}"/>년&nbsp;
							<input type="text" id="career2_month${status.index}" name="career_month" style="width:20px" value="${items.getCareer_month()}"/>개월
						</td>
						<td><input type="text" id="career2_work${status.index}" name="career_work" style="width:130px" value="${items.getCareer_work()}"/></td>
						<td>
							<input type="image" src="./resources/ls_img/btn_edit_s.gif" style="cursor:pointer;" class="udtMemberCareer2" value="${status.index}"/>
							<input type="image" src="./resources/ls_img/btn_del_s.gif" style="cursor:pointer;" class="delMemberCareer2" value="${status.index}"/>
							<input type="hidden" id="career2_no${status.index}" name="career_no" value="${items.getCareer_no()}"/>
						</td>
					</tr>
				</c:forEach>
				<tr>
					<td><input type="text" id="career2_corporate_name" name="career_corporate_name" style="width:210px"/></td>
					<td><input type="text" id="career2_depart" name="career_depart" style="width:150px"/></td>
					<td><input type="text" id="career2_rank" name="career_rank" style="width:80px"/></td>
					<td><input type="text" id="career2_start_date" name="career_start_date" class="career_start_date" style="width:65px"/></td>
					<td><input type="text" id="career2_end_date" name="career_end_date" class="career_end_date" style="width:65px"/></td>
					<td>
						<input type="text" id="career2_year" name="career_year" style="width:20px"/>년&nbsp;
						<input type="text" id="career2_month" name="career_month" style="width:20px"/>개월
					</td>
					<td><input type="text" id="career2_work" name="career2_work" style="width:130px"/></td>
					<td><input type="image" src="./resources/ls_img/btn_add.gif" style="cursor:pointer;" id="addMemberCareerIns2"/></td>
				</tr>
				<tr>
					<th colspan="5">근속누계</th>
					<td>
						<c:out value="${getMbrCareerConstructSum.getCareer_year_sum()}"/>년&nbsp;
						<c:out value="${getMbrCareerConstructSum.getCareer_month_sum()}"/>개월
					</td>
					<td></td>
					<td></td>
				</tr>
			</thead>
		</table>		
		
		<br />
		
		<!-- 경력사항 일반 -->
		<table>
			<colgroup>
				<col width="23%">
				<col width="17%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="15%">
				<col width="5%">
			</colgroup>
			<thead>
				<tr>
					<th colspan="8">경력사항(일반)</th>
				</tr>
				<tr>
					<th rowspan="2">회사명</th>
					<th rowspan="2">부서</th>
					<th rowspan="2">직위</th>
					<th colspan="2">근무기간</th>
					<th rowspan="2">근속년수</th>
					<th rowspan="2">담당업무</th>
					<th rowspan="2"></th>
				</tr>
				<tr>
					<th>입사일자</th>
					<th>퇴사일자</th>
				</tr>
				<c:forEach items="${getMbrCareerGnl}" var="items" varStatus="status">
					<tr>
						<td><input type="text" id="career3_corporate_name${status.index}" class="career_corporate_name" name="career_corporate_name" style="width:210px" value="${items.getCareer_corporate_name()}"/></td>
						<td><input type="text" id="career3_depart${status.index}" name="career_depart" style="width:150px" value="${items.getCareer_depart()}"/></td>
						<td><input type="text" id="career3_rank${status.index}" name="career_rank" style="width:80px" value="${items.getCareer_rank()}"/></td>
						<td><input type="text" id="career3_start_date${status.index}" name="career_start_date" class="career_start_date" style="width:65px" value="${items.getCareer_start_date()}"/></td>
						<td><input type="text" id="career3_end_date${status.index}" name="career_end_date" class="career_end_date" style="width:65px" value="${items.getCareer_end_date()}"/></td>
						<td>
							<input type="text" id="career3_year${status.index}" name="career_year" style="width:20px" value="${items.getCareer_year()}"/>년&nbsp;
							<input type="text" id="career3_month${status.index}" name="career_month" style="width:20px" value="${items.getCareer_month()}"/>개월
						</td>
						<td><input type="text" id="career3_work${status.index}" name="career_work" style="width:130px" value="${items.getCareer_work()}"/></td>
						<td>
							<input type="image" src="./resources/ls_img/btn_edit_s.gif" style="cursor:pointer;" class="udtMemberCareer3" value="${status.index}"/>
							<input type="image" src="./resources/ls_img/btn_del_s.gif" style="cursor:pointer;" class="delMemberCareer3" value="${status.index}"/>
							<input type="hidden" id="career3_no${status.index}" name="career_no" value="${items.getCareer_no()}"/>
						</td>
					</tr>
				</c:forEach>
				<tr>
					<td><input type="text" id="career3_corporate_name" name="career_corporate_name" style="width:210px"/></td>
					<td><input type="text" id="career3_depart" name="career_depart" style="width:150px"/></td>
					<td><input type="text" id="career3_rank" name="career_rank" style="width:80px"/></td>
					<td><input type="text" id="career3_start_date" name="career_start_date" class="career_start_date" style="width:65px"/></td>
					<td><input type="text" id="career3_end_date" name="career_end_date" class="career_end_date" style="width:65px"/></td>
					<td>
						<input type="text" id="career3_year" name="career_year" style="width:20px"/>년&nbsp;
						<input type="text" id="career3_month" name="career_month" style="width:20px"/>개월
					</td>
					<td><input type="text" id="career3_work" name="career_work" style="width:130px"/></td>
					<td><input type="image" src="./resources/ls_img/btn_add.gif" style="cursor:pointer;" id="addMemberCareerIns3"/></td>
				</tr>
				<tr>
					<th colspan="5">근속누계</th>
					<td>
						<c:out value="${getMbrCareerGeneralSum.getCareer_year_sum()}"/>년&nbsp;
						<c:out value="${getMbrCareerGeneralSum.getCareer_month_sum()}"/>개월
					</td>
					<td></td>
					<td></td>					
				</tr>
				<tr>
					<th colspan="5">총근속누계</th>
					<td>
						<c:choose>
						<c:when test="${getMbrCareerSum.getCareer_month_sum() + getMbrCareerConstructSum.getCareer_month_sum() + getMbrCareerGeneralSum.getCareer_month_sum() > 23 }">
						${getMbrCareerSum.getCareer_year_sum()+ getMbrCareerConstructSum.getCareer_year_sum() + getMbrCareerGeneralSum.getCareer_year_sum()+2}년&nbsp;
						${getMbrCareerSum.getCareer_month_sum() + getMbrCareerConstructSum.getCareer_month_sum() + getMbrCareerGeneralSum.getCareer_month_sum()-24 }개월
						</c:when>
						<c:when test="${getMbrCareerSum.getCareer_month_sum() + getMbrCareerConstructSum.getCareer_month_sum() + getMbrCareerGeneralSum.getCareer_month_sum() > 11 }">
						${getMbrCareerSum.getCareer_year_sum()+ getMbrCareerConstructSum.getCareer_year_sum() + getMbrCareerGeneralSum.getCareer_year_sum()+1}년&nbsp;
						${getMbrCareerSum.getCareer_month_sum() + getMbrCareerConstructSum.getCareer_month_sum() + getMbrCareerGeneralSum.getCareer_month_sum()-12 }개월						
						</c:when>
						<c:otherwise>
						${getMbrCareerSum.getCareer_year_sum()+ getMbrCareerConstructSum.getCareer_year_sum() + getMbrCareerGeneralSum.getCareer_year_sum()}년&nbsp;
						${getMbrCareerSum.getCareer_month_sum() + getMbrCareerConstructSum.getCareer_month_sum() + getMbrCareerGeneralSum.getCareer_month_sum()}개월
						</c:otherwise>
						</c:choose>
					</td>
					<td></td>
					<td></td>
				</tr>
			</thead>
		</table>
		
		<br />
		
		<table>
			<colgroup>
				<col width="27%">
				<col width="12%">
				<col width="20%">
				<col width="20%">
				<col width="15%">
				<col width="6%">
			</colgroup>
			<thead>
				<tr>
					<th colspan="8"><b>자격사항</b></th>
				</tr>
				<tr>
					<th>자격면허 명칭</th>
					<th>취득일</th>
					<th>등록번호</th>
					<th>발행기관</th>
					<th>비고</th>
					<th></th>
				</tr>
				<c:forEach items="${getMbrLicense}" var="getMbrLicense" varStatus="status">
					<tr>
						<td><input type="text" id="license_name${status.index}" name="license_name" style="width:250px" value="${getMbrLicense.getLicense_name()}"/></td>
						<td><input type="text" id="license_acquire_date${status.index}" class="license_acquire_date" name="license_acquire_date" style="width:80px" value="${getMbrLicense.getLicense_acquire_date()}"/></td>
						<td><input type="text" id="license_register_no${status.index}" name="license_register_no" style="width:180px" value="${getMbrLicense.getLicense_register_no()}"/></td>
						<td><input type="text" id="license_publishing_office${status.index}" name="license_publishing_office" style="width:180px" value="${getMbrLicense.getLicense_publishing_office()}"/></td>
						<td><input type="text" id="license_etc${status.index}" name="license_etc" style="width:135px" value="${getMbrLicense.getLicense_etc()}"/></td>
						<td>
							<input type="image" src="./resources/ls_img/btn_edit_s.gif" style="cursor:pointer;" class="udtMemberLicense" value="${status.index}"/>
							<input type="image" src="./resources/ls_img/btn_del_s.gif" style="cursor:pointer;" class="delMemberLicense" value="${status.index}"/>
							<input type="hidden" id="license_no${status.index}" name="license_no" value="${getMbrLicense.getLicense_no()}"/>
						</td>
					</tr>
				</c:forEach>
				<tr>
					<td><input type="text" id="license_name" name="license_name" style="width:250px"/></td>
					<td><input type="text" id="license_acquire_date" name="license_acquire_date" style="width:80px"/></td>
					<td><input type="text" id="license_register_no" name="license_register_no" style="width:180px"/></td>
					<td><input type="text" id="license_publishing_office" name="license_publishing_office" style="width:180px"/></td>
					<td><input type="text" id="license_etc" name="license_etc" style="width:135px"/></td>
					<td><input type="image" src="./resources/ls_img/btn_add.gif" style="cursor:pointer;" id="addMemberLicenseIns"/></td>
				</tr>
			</thead>
		</table>
		
		<br/><br/>
		<%-- 컨트롤러 쪽 파라미터가 잘못 처리되어있어 if문으로 처리함 by top3009 --%>		
		<c:if test="${empty userNo}">
			<c:set var="userNo" value="${param.user_no}"></c:set>
		</c:if>
		<form id="upload" name="upload" method="post" action="/popMemberLicenseUpload" enctype="multipart/form-data">	
			<input type="hidden" name="user_no" value = "${userNo}" />
			<div class= "tableStyle2">
				<table>
					<colgroup>
						<col width="30%">
						<col width="70%">
					</colgroup>	
					
					<c:if test="${!empty fileList}">
					<tr>
						<th>자격증 파일</th>
					    <td style="text-align: left; padding-left: 5px;">
							<c:forEach  var="item" items="${fileList}" varStatus="status">
								<p id="p_file${status.index}">
									<a href="/popMemberLicenseFiledown?file_no=${item.fileNo}">${item.orignlFileNm}</a>&nbsp;&nbsp;&nbsp;
									<a href="#noloc" onclick="fnFileDel('${item.fileNo}','${status.index}')">
										<img src="./resources/ls_img/ls_board/btn_s_del.gif"/>
									</a>
								</p>
							</c:forEach>
						</td>
					</tr>
					</c:if>	
					
					<tr height="25">
					  <th style="vertical-align:top;">
					  <input type="button" id="btn_add_file" value="자격증파일추가" onclick="javascript:fnAddFileForm();"/>
					</th>
					<td id="addFileFormDiv" style="text-align: left; padding-left: 5px;"></td>
					</tr>
				</table>
				
				<div align="center" style="margin-top: 5px;">
					<a href="#" id="btn_upload" onclick="javascript:fnUpload();"><img src="./resources/ls_img/btn_add.gif"></a>
				</div>
				<br />
			</div>
		</form>	
	</div>
		
	<script type="text/javascript">
	
		$(document).ready(function(){
		
			$.ajaxSetup({cache:false});
		
		    $("#addMemberCareerIns").click(function(){
		    	
		    	var careerStartDateVal = $("#career_start_date").val();
		    	var careerEndDateVal = $("#career_end_date").val();
		    	
		    	if( !careerStartDateVal ){
		    		alert("입사일자를 입력해주세요.");		    		
		    		return;
		    	}
		    	
		    	if( !careerEndDateVal ){
		    		alert("퇴사일자를 입력해주세요.");
		    		return;
		    	}		    	
		    	
				$.post("./popMemberCareerAddOK",
						{	career_start_date     		:$("#career_start_date").val()
							,career_end_date			:$("#career_end_date").val()
							,career_depart				:$("#career_depart").val()
							,career_rank  				:$("#career_rank").val()
							,career_corporate_name   	:$("#career_corporate_name").val()
							,career_year  				:$("#career_year").val()
							,career_month				:$("#career_month").val()
							,career_work     			:$("#career_work").val()
							,user_no					:$("#user_no").val()
						},
						function(data,status){
							if(status == "success"){
								popMbrDetail.tabGubun.value = "career";
								popMbrDetail.submit();
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}//function
				);//post
			});//$("#addMyCostIns").click
			
		    $("#addMemberCareerIns2").click(function(){
				$.post("./popMemberCareerCstAddOK",
						{	career_start_date     		:$("#career2_start_date").val()
							,career_end_date			:$("#career2_end_date").val()
							,career_depart				:$("#career2_depart").val()
							,career_rank  				:$("#career2_rank").val()
							,career_corporate_name   	:$("#career2_corporate_name").val()
							,career_year  				:$("#career2_year").val()
							,career_month				:$("#career2_month").val()
							,career_work     			:$("#career2_work").val()
							,user_no					:$("#user_no").val()
						},
						function(data,status){
							if(status == "success"){
								popMbrDetail.tabGubun.value = "career";
								popMbrDetail.submit();
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}//function
				);//post
			});//$("#addMyCostIns2").click		
		
		    $("#addMemberCareerIns3").click(function(){
				$.post("./popMemberCareerGnlAddOK",
						{	career_start_date     	:$("#career3_start_date").val()
							,career_end_date		:$("#career3_end_date").val()
							,career_depart			:$("#career3_depart").val()
							,career_rank  			:$("#career3_rank").val()
							,career_corporate_name  :$("#career3_corporate_name").val()
							,career_year  			:$("#career3_year").val()
							,career_month			:$("#career3_month").val()
							,career_work     		:$("#career3_work").val()
							,user_no				:$("#user_no").val()
						},
						function(data,status){
							if(status == "success"){
								popMbrDetail.tabGubun.value = "career";
								popMbrDetail.submit();
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}//function
				);//post
			});//$("#addMyCostIns3").click			
			
			$(".udtMemberCareer").click(function(){
				var tmpVar = $(this).attr("value");
				$.post("./popMemberCareerUdtOK",
						{	career_start_date     			:$("#career_start_date"+tmpVar).val()
							,career_end_date				:$("#career_end_date"+tmpVar).val()
							,career_depart					:$("#career_depart"+tmpVar).val()
							,career_rank  					:$("#career_rank"+tmpVar).val()
							,career_corporate_name   		:$("#career_corporate_name"+tmpVar).val()
							,career_year  					:$("#career_year"+tmpVar).val()
							,career_month					:$("#career_month"+tmpVar).val()
							,career_work     				:$("#career_work"+tmpVar).val()
							,user_no						:$("#user_no").val()
							,career_no     					:$("#career_no"+tmpVar).val()
						},
						function(data,status){
							if(status == "success"){
								popMbrDetail.tabGubun.value = "career";
								popMbrDetail.submit();
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}//function
				);//post
			});//$("#udtMyCostIns").click
			
			$(".udtMemberCareer2").click(function(){
				var tmpVar = $(this).attr("value");
				$.post("./popMemberCareerCstUdtOK",
						{	career_start_date     			:$("#career2_start_date"+tmpVar).val()
							,career_end_date				:$("#career2_end_date"+tmpVar).val()
							,career_depart					:$("#career2_depart"+tmpVar).val()
							,career_rank  					:$("#career2_rank"+tmpVar).val()
							,career_corporate_name   		:$("#career2_corporate_name"+tmpVar).val()
							,career_year  					:$("#career2_year"+tmpVar).val()
							,career_month					:$("#career2_month"+tmpVar).val()
							,career_work     				:$("#career2_work"+tmpVar).val()
							,user_no						:$("#user_no").val()
							,career_no     					:$("#career2_no"+tmpVar).val()
						},
						function(data,status){
							if(status == "success"){
								popMbrDetail.tabGubun.value = "career";
								popMbrDetail.submit();
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}//function
				);//post
			});//$("#udtMyCostIns2").click		
			
			$(".udtMemberCareer3").click(function(){
				var tmpVar = $(this).attr("value");
				$.post("./popMemberCareerGnlUdtOK",
						{	career_start_date     			:$("#career3_start_date"+tmpVar).val()
							,career_end_date				:$("#career3_end_date"+tmpVar).val()
							,career_depart					:$("#career3_depart"+tmpVar).val()
							,career_rank  					:$("#career3_rank"+tmpVar).val()
							,career_corporate_name   		:$("#career3_corporate_name"+tmpVar).val()
							,career_year  					:$("#career3_year"+tmpVar).val()
							,career_month					:$("#career3_month"+tmpVar).val()
							,career_work     				:$("#career3_work"+tmpVar).val()
							,user_no						:$("#user_no").val()
							,career_no     					:$("#career3_no"+tmpVar).val()
						},
						function(data,status){
							if(status == "success"){
								popMbrDetail.tabGubun.value = "career";
								popMbrDetail.submit();
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}//function
				);//post
			});//$("#udtMyCostIns3").click			
			
			$(".delMemberCareer").click(function(){
				var tmpVar = $(this).attr("value");
				var tmp = window.confirm("경력사항을 삭제하시겠습니까?");
				if(tmp == false){
					return;
				}else if(tmp == true){
		
					$.post("./popMemberCareerDelOK",
							{	
								 career_no     				:$("#career_no"+tmpVar).val()
								,user_no					:$("#user_no").val()
							},
							function(data,status){
								if(status == "success"){
									popMbrDetail.tabGubun.value = "career";
									popMbrDetail.submit();
								}else{
									alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
								}
							}//function
					);//post
				
				}
			});//$(".delMemberCareer").click
			
			$(".delMemberCareer2").click(function(){
				var tmpVar = $(this).attr("value");
				var tmp = window.confirm("경력사항을 삭제하시겠습니까?");
				if(tmp == false){
					return;
				}else if(tmp == true){
				$.post("./popMemberCareerCstDelOK",
						{							
							career_no     				:$("#career2_no"+tmpVar).val()
							,user_no					:$("#user_no").val()
						},
						function(data,status){
							if(status == "success"){
								popMbrDetail.tabGubun.value = "career";
								popMbrDetail.submit();
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}//function
				);//post
				}
			});//$(".delMemberCareer2").click		
			
			$(".delMemberCareer3").click(function(){
				var tmpVar = $(this).attr("value");
				var tmp = window.confirm("경력사항을 삭제하시겠습니까?");
				if(tmp == false){
					return;
				}else if(tmp == true){
				$.post("./popMemberCareerGnlDelOK",
						{							
							career_no     				:$("#career3_no"+tmpVar).val()
							,user_no					:$("#user_no").val()
						},
						function(data,status){
							if(status == "success"){
								popMbrDetail.tabGubun.value = "career";
								popMbrDetail.submit();
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}//function
				);//post
				}
			});//$(".delMemberCareer").click		
			
			$("#addMemberLicenseIns").click(function(){
				$.post("./popMemberLicenseAddOK",
						{	license_name    					:$("#license_name").val()
							,license_acquire_date				:$("#license_acquire_date").val()
							,license_register_no  				:$("#license_register_no").val()
							,license_publishing_office   		:$("#license_publishing_office").val()
							,license_etc  						:$("#license_etc").val()
							,user_no							:$("#user_no").val()
						},
						function(data,status){
							if(status == "success"){
								popMbrDetail.tabGubun.value = "career";
								popMbrDetail.submit();
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}//function
				);//post
			});//$("#addMyCostIns").click
			
			$(".udtMemberLicense").click(function(){
				var tmpVar = $(this).attr("value");
				$.post("./popMemberLicenseUdtOK",
						{	license_name     					:$("#license_name"+tmpVar).val()
							,license_acquire_date				:$("#license_acquire_date"+tmpVar).val()
							,license_register_no  				:$("#license_register_no"+tmpVar).val()
							,license_publishing_office   		:$("#license_publishing_office"+tmpVar).val()
							,license_etc  						:$("#license_etc"+tmpVar).val()
							,license_no     					:$("#license_no"+tmpVar).val()
							,user_no							:$("#user_no").val()
						},
						function(data,status){
							if(status == "success"){
								popMbrDetail.tabGubun.value = "career";
								popMbrDetail.submit();
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}//function
				);//post
			});//$("#addMyCostIns").click
			
			$(".delMemberLicense").click(function(){
				var tmpVar = $(this).attr("value");
				
				$.post("./popMemberLicenseDelOK",
						{	
							
							license_no     			:$("#license_no"+tmpVar).val()
							,user_no					:$("#user_no").val()
						},
						function(data,status){
							if(status == "success"){
								popMbrDetail.tabGubun.value = "career";
								popMbrDetail.submit();
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}//function
				);//post
			});//$("#addMyCostIns").click
		});//$(document).ready
	
	
	    var fileNo = 1;
	    $(document).ready(function () {
	        _initButton();
	    });
	
	    //버튼 이벤트
	    function _initButton() {
	        /* $("#btn_add_file").on("click", function () {
	            fnAddFileForm();
	        });
	        
	        $("#btn_upload").on("click", function(){
	        	fnUpload();
	        }); */
	    }
	
	
	    function fnAddFileForm() {
	        $("#addFileFormDiv").append(
	                "첨부파일추가 "+fileNo+" : <input type='file' name='upfile"+fileNo+"' style='width:80%;'><br /><br />"
	        );
	        fileNo = fileNo + 1;
	    }
	 
	    function fnUpload(){
			
	    	$("#upload").submit();
	    }
	    
	    function fnFileDel(fileNo, idx){
	    	
	    	 if (confirm("첨부파일을 삭제하시겠습니까?")){
	             var param = {};
	             param.file_no		= fileNo;
	             
	             var url = "./popMemberLicenseFileDel"
	             
	            	 $.ajax({
	                     type: "POST",
	                     url: url,
	                     data: param,
	                     contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	                     dataType: "json",
	                     timeout: 20000,
	                     success: function(data){
	                         if (data.Authorize == 'T' && data.Result == "success"){
	                             alert("첨부파일 삭제를 성공 하였습니다.");
	                             $("#p_file" + idx).remove();
	                         }else{
	                             alert("첨부파일 삭제를 실패 하였습니다.");
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
	    }
	    //popMemberLicenseFiledown
	</script>
