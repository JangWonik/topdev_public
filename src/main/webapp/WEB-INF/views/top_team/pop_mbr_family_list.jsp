<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

	<div class= "tableStyle2">
		<!-- 검색 결과 테이블 시작-->
		<form id="academic" name="academic" method="post" action="/popMemberAcademicAddOK">		
			<table>
				<colgroup>
					<col width="15%">
					<col width="20%">
					<col width="15%">
					<col width="15%">
					<col width="15%">
					<col width="15%">
					<col width="5%">
				</colgroup>
				<tr>
					<th colspan="7">학력사항</th>
				</tr>
				<tr>
					<th>구분</th>
					<th>학교명</th>
					<th>학과</th>
					<th>졸업여부</th>
					<th>졸업년월</th>
					<th>비고</th>
					<th></th>
				</tr>
				<c:forEach var="item" items="${academiclist}" varStatus="status">
					<tr>					
						<td>
							<input type="hidden" id="acadmic_no${status.index}" value="${item.acadmicNo}">
							<select id="school${status.index}" name="school">
								<option value="10" <c:if test="${item.acadmicType == '10'}">selected</c:if>>고등학교</option>
								<option value="20" <c:if test="${item.acadmicType == '20'}">selected</c:if>>대학교</option>
								<option value="30" <c:if test="${item.acadmicType == '30'}">selected</c:if>>대학원</option>
							</select>						
						</td>
						
						<td>
							<input type="text" id="schoolName${status.index}" name="schoolName" value="${item.acadmicSchool}"/>
						</td>
						
						<td>
							<input type="text" id="department${status.index}" name="department" value="${item.acadmicDepartment}"/>
						</td>
						
						<td>
							<input type="radio" id="graduation${status.index}1" name="graduation${status.index}" value="Y" 
								<c:if test="${item.acadmicGraduation  == 'Y'}"> checked="checked"</c:if>>졸업&nbsp;&nbsp;&nbsp;																								
							<input type="radio" id="graduation${status.index}2" name="graduation${status.index}" value="N"
					     	    <c:if test="${item.acadmicGraduation  == 'N'}"> checked="checked"</c:if>>중퇴&nbsp;&nbsp;&nbsp;
						</td>
						
						<td>
							<input type="text" id="graduation_date${status.index}" name="graduation_date" value="${item.graduationDate}"/>
						</td>
						<td>
							<input type="text" id="memo${status.index}" name="memo" value="${item.acadmicMemo}"/>
						</td>
						<td>
							<a id="btn_school_modify" href="#noloc" onclick = "fnSchoolModify('${status.index}')"><img src="./resources/ls_img/btn_edit_s.gif"/></a>
							<a id="btn_school_del" href="#noloc" onclick = "fnSchoolDel('${status.index}')"><img src="./resources/ls_img/btn_del_s.gif"/></a>						
						</td>											
					</tr>
				</c:forEach>				
				<tr>
					<td>
						<select id="school" name="school">
							<option value="10">고등학교</option>
							<option value="20">대학교</option>
							<option value="30">대학원</option>
						</select>
					</td>
					<td>
						<input type="text" id="schoolName" name="schoolName" value=""/>
					</td>
					<td>
						<input type="text" id="department" name="department" value=""/>
					</td>
					<td>
						<input type="radio" id="graduation1" name="graduation" value="Y" checked="checked">졸업&nbsp;&nbsp;&nbsp;
						<input type="radio" id="graduation2" name="graduation" value="N">중퇴
					</td>
					<td>
						<input type="text" id="graduation_date" name="graduation_date" value=""/>
					</td>
					<td>
						<input type="text" id="memo" name="memo" value=""/>
					</td>
					<td>
						<a id="btn_school_add" href="#noloc"><img src="./resources/ls_img/btn_add.gif"/></a>
					</td>					
				</tr>					
			</table>		
		</form>
	</div>	
	
	
	<div class= "tableStyle2" style="margin-top: 3%">
		<table>
			<colgroup>
				<col width="40%">
				<col width="55%">
				<col width="5%">
			</colgroup>
			<thead>
				<tr>
					<th colspan="8">가족사항</th>
				</tr>
				<tr>
					<th>관계</th>
					<th>이름</th>
					<th></th>
				</tr>
				<c:forEach items="${getMbrFamily}" var="getMbrFamily" varStatus="status">
					<tr>
						<td><input type="text" id="family_relationship${status.index}" name="family_relationship" style="width:65px" value="${getMbrFamily.getFamily_relationship()}"/></td>
						<td><input type="text" id="family_name${status.index}" name="family_name" style="width:200px" value="${getMbrFamily.getFamily_name()}"/></td>
						<td>
							<input type="image" src="./resources/ls_img/btn_edit_s.gif" style="cursor:pointer;" class="udtMemberFamily" value="${status.index}"/>
							<input type="image" src="./resources/ls_img/btn_del_s.gif" style="cursor:pointer;" class="delMemberFamily" value="${status.index}"/>
							<input type="hidden" id="user_no" value="${getMbrFamily.getUser_no()}"/>
							<input type="hidden" id="family_no${status.index}" name="family_no" value="${getMbrFamily.getFamily_no()}"/>
						</td>
					</tr>
				</c:forEach>
				<tr>
					<td><input type="text" id="family_relationship" name="family_relationship" style="width:65px"/></td>
					<td><input type="text" id="family_name" name="family_name" style="width:200px"/></td>
					<td><input type="image" src="./resources/ls_img/btn_add.gif" style="cursor:pointer;" id="addMemberFamilyIns"/></td>
				</tr>
			</thead>
		</table>
				
		<br />
	</div>

	<script>
		$(document).ready(function(){
	
			$.ajaxSetup({cache:false});
	
		    $("#addMemberFamilyIns").click(function(){
				$.post("./popMemberFamilyAddOK",
						{	 family_relationship     	:$("#family_relationship").val()
							,family_name				:$("#family_name").val()
							,user_no					:$("#user_no").val()
						},
						function(data,status){
							if(status == "success"){
								popMbrDetail.tabGubun.value = "family";
								popMbrDetail.submit();
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);
			});
			
		    $("#addAcademic").click(function(){
				$.post("./popMemberAcademicAddOK",
						{	family_relationship     	:$("#family_relationship").val()
							,family_name				:$("#family_name").val()
							,user_no					:$("#user_no").val()
						},
						function(data,status){
							if(status == "success"){
								popMbrDetail.tabGubun.value = "family";
								popMbrDetail.submit();
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);
			});	
			
		    
			$(".udtMemberFamily").click(function(){
				var tmpVar = $(this).attr("value");
				$.post("./popMemberFamilyUdtOK",
						{	 family_relationship     	:$("#family_relationship"+tmpVar).val()
							,family_name				:$("#family_name"+tmpVar).val()
							,family_no     				:$("#family_no"+tmpVar).val()
							,user_no					:$("#user_no").val()
						},
						function(data,status){
							if(status == "success"){
								popMbrDetail.tabGubun.value = "family";
								popMbrDetail.submit();
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);
			});
			
			$(".delMemberFamily").click(function(){
				var tmpVar = $(this).attr("value");
				
				$.post("./popMemberFamilyDelOK",
						{	
							 family_no     				:$("#family_no"+tmpVar).val()
							,user_no					:$("#user_no").val()
						},
						function(data,status){
							if(status == "success"){
								popMbrDetail.tabGubun.value = "family";
								popMbrDetail.submit();
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);
			});
		});
	</script>


	<script type="text/javascript">
		var editMode = 0;
		$(document).ready(function () {
		    _initSchoolButton();
		});
	
		//버튼이벤트
		function _initSchoolButton() {
	        $("#btn_school_add").on("click", function () {
	            fnSchoolSave();
	        });
		}
		
		function fnSchoolSave(){
		
		    if ($("#schoolName").val() == ''){
		    	alert("학교명을 입력해 주세요.");
		    	$("#schoolName").focus();
		    	
		    	return;
		    }
		    
		    var param = {};
		    param.user_no			= $("#user_no").val();
		    param.school        	= $("#school option:selected").val();
		    param.schoolName    	= $("#schoolName").val();
		    param.department    	= $("#department").val();
		    param.graduation    	= $(":input:radio[name=graduation]:checked").val()
		    param.graduation_date	= $("#graduation_date").val();        
		    param.memo           	= $("#memo").val();    
		    
		    var url = "./popMemberAcademicAddOK";
		
		    $.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        dataType: "json",
		        timeout: 20000,
		        success: function(data){
		            if(data.RSLTCODE == '0'){
		            	alert("저장되었습니다.");
						popMbrDetail.tabGubun.value = "family";
						popMbrDetail.submit();
		            }else{
		            	alert("저장에 실패 하였습니다.");
						popMbrDetail.tabGubun.value = "family";
						popMbrDetail.submit();
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
		
		function fnWinClose(){
		    self.close();
		}	
		
		function fnSchoolModify(idx){
			
		    if ($("#schoolName"+idx).val() == ''){
		    	alert("학교명을 입력해 주세요.");
		    	$("#schoolName"+idx).focus();
		    	
		    	return;
		    }
		    	    
		    var param = {};
		    param.acadmic_no       		= $("#acadmic_no"+idx).val();	    
		    param.user_no          		= $("#user_no").val();
		    param.school           		= $("#school"+idx+" option:selected").val();
		    param.schoolName           	= $("#schoolName"+idx).val();
		    param.department           	= $("#department"+idx).val();
		    param.graduation           	= $("input:radio[name=graduation"+idx+"]:checked").val()
		    param.graduation_date       = $("#graduation_date"+idx).val();        
		    param.memo           		= $("#memo"+idx).val();
		    
		    var url = "./popMemberAcademicModifyOK";
		
		    $.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        dataType: "json",
		        timeout: 20000,
		        success: function(data){
		            if(data.RSLTCODE == '0'){
		            	alert("수정되었습니다.");
						popMbrDetail.tabGubun.value = "family";
						popMbrDetail.submit();
		            }else{
		            	alert("수정에 실패 하였습니다.");
						popMbrDetail.tabGubun.value = "family";
						popMbrDetail.submit();
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
	
		function fnSchoolDel(idx){
			if(confirm("삭제하시겠습니까?")){
				var param = {};
				param.acadmic_no		= $("#acadmic_no"+idx).val();
				
				var url = "./popMemberAcadmicDel";
				
				$.ajax({
			        type: "POST",
			        url: url,
			        data: param,
			        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			        dataType: "json",
			        timeout: 20000,
			        success: function(data){
						popMbrDetail.tabGubun.value = "family";
						popMbrDetail.submit();
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
	</script>		
