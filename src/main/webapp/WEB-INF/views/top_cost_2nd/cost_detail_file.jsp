<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
			
			
			
			<c:set var="costFileView" value="1" />
			<c:if test="${empty costDepositNo}">
				<c:set var="costFileView" value="0" />
			</c:if>
			<form id ="fileFrm" name="fileFrm" enctype="multipart/form-data" method="post">
				<div id="div_cost_file">
					<input type="hidden" id="costDepositNo" name="costDepositNo" value="${costDepositNo}">
					<table class="tableStyle2">
						<colgroup>
							<col style="width:60%" />
							<col style="width:40%" />
						</colgroup>
						<thead>
							<tr>
								<th>파일명</th>
								<th>등록일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${costDetailFileList}" var="item" varStatus="status">
								<c:choose>
									<c:when test="${costDepositState ne '4' || user_state eq '9'}">
										<tr>
											<td>
												<a href=cost_detail_file_down?serialNo=${item.serial_no}>
													<font color="blue"> ${item.file_name} </font>
									  			</a>
											</td>
											
											<td>
												${item.reg_date}
												<img src='./resources/ls_img/btn_del_s.gif' onclick="fnDeleteFile('${item.serial_no}','${item.cost_deposit_no}');" style='cursor:pointer; margin-left:5px;'/>
											</td>								
										</tr>
									</c:when>
									<c:otherwise>
										<tr>
											<td>${item.file_name}</td>
											<td>${item.reg_date}</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							
							<c:if test="${costDepositState ne '4'}">
								<tr>
									<td colspan="2" align="center">
										<c:choose>
											<c:when test="${costFileView == 1 }">
												<input type="file" id="costDetailFile" name="costDetailFile" onchange="fnUploadFile()"/>
											</c:when>
											<c:otherwise>
												해당 월에 입력된 경비가 없습니다.
											</c:otherwise>
										</c:choose>
										
									</td>
								</tr>
							</c:if>
							
						</tbody>
					</table>
				</div>
			</form>
	
	
			<script>
			
				function fnUploadFile(){
					var url ="./cost_detail_file_upload";
				    var frmData = new FormData();
				    
				    var costDepositNo = $("#costDepositNo").val();
				    var costDetailFile = $('#costDetailFile')[0].files[0];
				  
				    frmData.append('costDepositNo', costDepositNo);
				    frmData.append('costDetailFile', costDetailFile);
				    
				    $.ajax({
				        type: "POST",
				        url: url,
				        data: frmData,
				        timeout: 100000,
				        processData: false,
				        contentType: false,
				        dataType: "html", 
				        success: function(data){
				        	alert("영수증 파일이 등록 되었습니다.");
				        	$("#file_div").html("");
				        	$("#file_div").html(data);
				        },
				        error: function(e){
				            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
				        },
			            beforeSend: function(){
			                $('#div_cost_file').spin();
			                //$("#loading").show();
			            },
			            complete: function(){
			                $('#div_cost_file').spin(false);
			                //$("#loading").hide();
			            }
				    });
				}
				
				function fnDeleteFile(serialNo,costDepositNo){
					var r = confirm("삭제하시겠습니까?");
					
					if (!r){
						return;
					}
					
					var url ="./cost_detail_file_delete";
					
					param = {};
					param.serialNo 		= serialNo;
					param.costDepositNo = costDepositNo;
					
					
			        $.ajax({
			            type: "POST",
			            url: url,
			            data: param,
			            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			            timeout: 20000,
				        dataType: "html", 
				        success: function(data){
				        	alert("파일이 삭제 되었습니다.");
				        	$("#file_div").html("");
				        	$("#file_div").html(data);
				        },
				        error: function(e){
				            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
				        }
				    });	
				}			
			
			</script>
