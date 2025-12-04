<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
		<div class= "tableStyle2">
			<table>
				<colgroup>
						<col width="10%">
						<col width="23%">
						<col width="20%">
						<col width="20%">
						<col width="10%">
						<col width="12%">
						<col width="5%">
				</colgroup>
				<thead>
					<tr>
						<th colspan="7">교육사항</th>
					</tr>
					<tr>
						<th>교육구분</th>
						<th>교육과정명</th>
						<th>교육기관</th>
						<th>교육기간</th>
						<th>교육비용</th>
						<th>비고</th>
						<th></th>
					</tr>
					<c:forEach items="${getMbrEducation}" var="getMbrEducation" varStatus="status">
						<tr>
							<td><input type="text" id="education_gubun${status.index}" name="education_gubun" style="width:85px" value="${getMbrEducation.getEducation_gubun()}"/></td>
							<td><input type="text" id="education_name${status.index}" name="education_name" style="width:210px" value="${getMbrEducation.getEducation_name()}"/></td>
							<td><input type="text" id="education_office${status.index}" name="education_office" style="width:180px" value="${getMbrEducation.getEducation_office()}"/></td>
							<td>
								<input type="text" id="education_start_date${status.index}" name="education_start_date" class="education_start_date" style="width:65px" value="${getMbrEducation.getEducation_start_date()}"/>
								~
								<input type="text" id="education_end_date${status.index}" name="education_end_date" class="education_end_date" style="width:65px" value="${getMbrEducation.getEducation_end_date()}"/>	
							</td>
							<td><input type="text" id="education_price${status.index}" name="education_price" style="width:70px; text-align:right;" 
							value="<fmt:formatNumber value="${getMbrEducation.getEducation_price()}" pattern="###,###,##0.##"/>"
										ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);" style="IME-MODE: disabled;"/>원
							
							</td>
							<td><input type="text" id="education_etc${status.index}" name="education_etc" style="width:100px" value="${getMbrEducation.getEducation_etc()}"/></td>
							<td>
								<input type="image" src="./resources/ls_img/btn_edit_s.gif" style="cursor:pointer;" class="udtMemberEducation" value="${status.index}"/>
								<input type="image" src="./resources/ls_img/btn_del_s.gif" style="cursor:pointer;" class="delMemberEducation" value="${status.index}"/>
								<input type="hidden" id="user_no" value="${getMbrEducation.getUser_no()}"/>
								<input type="hidden" id="education_no${status.index}" name="education_no" value="${getMbrEducation.getEducation_no()}"/>
							</td>
						</tr>
					</c:forEach>
					<tr>
						<td><input type="text" id="education_gubun" name="education_gubun" style="width:85px"/></td>
						<td><input type="text" id="education_name" name="education_name" style="width:210px"/></td>
						<td><input type="text" id="education_office" name="education_office" style="width:180px"/></td>
						<td>
							<input type="text" id="education_start_date" name="education_start_date" style="width:65px"/>
							~
							<input type="text" id="education_end_date" name="education_end_date" style="width:65px"/>
						</td>
						<td><input type="text" id="education_price" name="education_price" style="width:70px; text-align:right;" ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);" style="IME-MODE: disabled;"/>원</td>
						<td><input type="text" id="education_etc" name="education_etc" style="width:100px"/></td>
						<td><input type="image" src="./resources/ls_img/btn_add.gif" style="cursor:pointer;" id="addMemberEducationIns"/></td>
					</tr>
				</thead>
			</table>
			
			<br/>
			
			<table>
				<colgroup>
					<col width="30%">
					<col width="20%">
					<col width="20%">
					<col width="10%">
					<col width="14%">
					<col width="6%">
				</colgroup>
				<thead>
					<tr>
						<th colspan="8"><b>강의이력</b></th>
					</tr>
					<tr>
						<th>교육과정명</th>
						<th>교육기관</th>
						<th>교육기간</th>
						<th>교육시간</th>
						<th>비고</th>
						<th></th>
					</tr>
					<c:forEach items="${getMbrClass}" var="getMbrClass" varStatus="status">
						<tr>
							<td><input type="text" id="class_name${status.index}" name="class_name" style="width:280px" value="${getMbrClass.getClass_name()}"/></td>
							<td><input type="text" id="class_office${status.index}" name="class_office" style="width:180px" value="${getMbrClass.getClass_office()}"/></td>
							<td>
								<input type="text" id="class_start_date${status.index}" name="class_start_date" class="class_start_date" style="width:65px" value="${getMbrClass.getClass_start_date()}"/>
								~
								<input type="text" id="class_end_date${status.index}" name="class_end_date" class="class_end_date" style="width:65px" value="${getMbrClass.getClass_end_date()}"/>	
							</td>
							<td><input type="text" id="class_time${status.index}" name="class_time" style="width:60px; text-align:right;" value="${getMbrClass.getClass_time()}"/>(h)
							</td>
							<td><input type="text" id="class_etc${status.index}" name="class_etc" style="width:120px" value="${getMbrClass.getClass_etc()}"/></td>
							<td>
								<input type="image" src="./resources/ls_img/btn_edit_s.gif" style="cursor:pointer;" class="udtMemberClass" value="${status.index}"/>
								<input type="image" src="./resources/ls_img/btn_del_s.gif" style="cursor:pointer;" class="delMemberClass" value="${status.index}"/>
								<input type="hidden" id="user_no" value="${getMbrClass.getUser_no()}"/>
								<input type="hidden" id="class_no${status.index}" name="class_no" value="${getMbrClass.getClass_no()}"/>
							</td>
						</tr>
					</c:forEach>
					<tr>
						<td><input type="text" id="class_name" name="class_name" style="width:280px"/></td>
						<td><input type="text" id="class_office" name="class_office" style="width:180px"/></td>
						<td>
							<input type="text" id="class_start_date" name="class_start_date" style="width:65px"/>
							~
							<input type="text" id="class_end_date" name="class_end_date" style="width:65px"/>
						</td>
						<td><input type="text" id="class_time" name="class_time" style="width:60px; text-align:right;"/>(h)</td>
						<td><input type="text" id="class_etc" name="class_etc" style="width:120px"/></td>
						<td><input type="image" src="./resources/ls_img/btn_add.gif" style="cursor:pointer;" id="addMemberClassIns"/></td>
					</tr>
					<tr>
						<th colspan="3">교육시간 누계</th>
						<td><c:out value="${getMbrClassTimeSum.class_time_sum}"/>&nbsp; (h)</td>
						<td></td>
						<td></td>
					</tr>
				</thead>
			</table>
		</div>
		
		<script>
			$(document).ready(function(){
		
				$.ajaxSetup({cache:false});
		
			    $("#addMemberEducationIns").click(function(){
					$.post("./popMemberEducationAddOK",
							{	education_start_date     		:$("#education_start_date").val()
								,education_end_date				:$("#education_end_date").val()
								,education_gubun				:$("#education_gubun").val()
								,education_name  				:$("#education_name").val()
								,education_office   			:$("#education_office").val()
								,education_price  				:removeCommaFunc($("#education_price").val())
								,education_etc					:$("#education_etc").val()
								,user_no					:$("#user_no").val()
							},
							function(data,status){
								if(status == "success"){
									popMbrDetail.tabGubun.value = "education";
									popMbrDetail.submit();
								}else{
									alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
								}
							}
					);
				});
				
			    
				$(".udtMemberEducation").click(function(){
					var tmpVar = $(this).attr("value");
					$.post("./popMemberEducationUdtOK",
							{	education_start_date     			:$("#education_start_date"+tmpVar).val()
								,education_end_date					:$("#education_end_date"+tmpVar).val()
								,education_gubun					:$("#education_gubun"+tmpVar).val()
								,education_name  					:$("#education_name"+tmpVar).val()
								,education_office   				:$("#education_office"+tmpVar).val()
								,education_price  					:removeCommaFunc($("#education_price"+tmpVar).val())
								,education_etc						:$("#education_etc"+tmpVar).val()
								,user_no							:$("#user_no").val()
								,education_no     					:$("#education_no"+tmpVar).val()
							},
							function(data,status){
								if(status == "success"){
									popMbrDetail.tabGubun.value = "education";
									popMbrDetail.submit();
								}else{
									alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
								}
							}
					);
				});
				
				
				$(".delMemberEducation").click(function(){
					var tmpVar = $(this).attr("value");
					
					$.post("./popMemberEducationDelOK",
							{	
								 education_no     			:$("#education_no"+tmpVar).val()
								,user_no					:$("#user_no").val()
							},
							function(data,status){
								if(status == "success"){
									popMbrDetail.tabGubun.value = "education";
									popMbrDetail.submit();
								}else{
									alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
								}
							}
					);
				});
				
				$("#addMemberClassIns").click(function(){
					$.post("./popMemberClassAddOK",
							{	 class_name    					:$("#class_name").val()
								,class_office					:$("#class_office").val()
								,class_start_date  				:$("#class_start_date").val()
								,class_end_date  				:$("#class_end_date").val()
								,class_time   					:$("#class_time").val()
								,class_etc  					:$("#class_etc").val()
								,user_no						:$("#user_no").val()
							},
							function(data,status){
								if(status == "success"){
									popMbrDetail.tabGubun.value = "education";
									popMbrDetail.submit();
								}else{
									alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
								}
							}
					);
				});
				
				
				$(".udtMemberClass").click(function(){
					var tmpVar = $(this).attr("value");
					$.post("./popMemberClassUdtOK",
							{	 class_name     		:$("#class_name"+tmpVar).val()
								,class_office			:$("#class_office"+tmpVar).val()
								,class_start_date  		:$("#class_start_date"+tmpVar).val()
								,class_end_date   		:$("#class_end_date"+tmpVar).val()
								,class_time  			:$("#class_time"+tmpVar).val()
								,class_etc     			:$("#class_etc"+tmpVar).val()
								,class_no    			:$("#class_no"+tmpVar).val()
								,user_no				:$("#user_no").val()
							},
							function(data,status){
								if(status == "success"){
									popMbrDetail.tabGubun.value = "education";
									popMbrDetail.submit();
								}else{
									alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
								}
							}
					);
				});
				
				$(".delMemberClass").click(function(){
					var tmpVar = $(this).attr("value");
					
					$.post("./popMemberClassDelOK",
							{	
								class_no     			:$("#class_no"+tmpVar).val()
								,user_no				:$("#user_no").val()
							},
							function(data,status){
								if(status == "success"){
									popMbrDetail.tabGubun.value = "education";
									popMbrDetail.submit();
								}else{
									alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
								}
							}
					);
				});
			});
		</script>

