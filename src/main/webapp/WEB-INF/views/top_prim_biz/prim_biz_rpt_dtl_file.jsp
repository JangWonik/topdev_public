<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script>
	/* 보고서 원본파일 삭제 */
	function rptOrgFileDel(serialNo){
		if(confirm("보고서 원본 파일을 삭제하시겠습니까?")){
			$.post("./primBizRptOrgFileDel",
					{	
						serialNo 	:	serialNo  //						
					},
					function(data,status){
						if(status == "success"){
							if(data != 0){
								$("#rptFileOrgTr_"+serialNo).css("display","none");
							}else{
								alert("시스템 오류입니다. 잠시 후 재시도 해주세요.");	
							}
						}else{
							alert("시스템 오류입니다. 잠시 후 재시도 해주세요.");
						}
					}
			);//post
		}//if
	}//function
</script>

						<table style="margin-bottom:5px;">
							<tr>
								<td align="left" style="padding-left:10px;"><b> 보고서 원본 파일 업로드</b></td>
								<td align="right" style="padding-right:10px;">
								</td>
							</tr>
						</table>
						<div class= "tableStyle2">
							<table>
								<thead>
									<tr>
										<th width="60%">파일명</th>
										<th width="40%">등록일</th>
									</tr>
								</thead>
								<tbody align="center" id = "rptOrgFileList">
									<c:forEach items="${rptOrgFileList}" var="orgFileVo">
										<tr id = "rptFileOrgTr_${orgFileVo.serialNo}">
											<td>
												<c:choose>													
													<c:when test="${primBizRptDtl.edit_yn > 0}">
														<a href="primBizFileDownload?key=${orgFileVo.serialNo}&type=rptOrigin&suimRptNo=${primBizRptDtl.suim_rpt_no}">
								        				   <font color="blue"> ${orgFileVo.fileName} </font>
								  					    </a>
													</c:when>
													<c:otherwise>
														${orgFileVo.fileName}
													</c:otherwise>
												</c:choose>
											</td>
											<td>
												${orgFileVo.regDate}
												<c:if test="${primBizRptDtl.suim_rpt_state eq '0'}">
													<img src='./resources/ls_img/btn_del_s.gif' onclick="rptOrgFileDel('${orgFileVo.serialNo}');" style='cursor:pointer; margin-left:5px;'/>
												</c:if>
											</td>
										</tr>
									</c:forEach>
								</tbody>
								<tr>
									<td colspan="2" align="center">
									<c:choose>
										<c:when test="${primBizRptDtl.suim_rpt_state eq '0' and mbrVo_Session.user_no eq primBizRptDtl.user_no }">
											<%@include file="../include/uploadform_primBizRptOrgFile.jsp"%>			
										</c:when>
										<c:otherwise>
											<font color="red">
												※ 담당건이 아니거나 상신 이후에는 원본 파일 업로드를 할 수 없습니다.
											</font>
										</c:otherwise>
									</c:choose>
									</td>
								</tr>
							</table>
						</div><!-- //tableStyle21 -->
