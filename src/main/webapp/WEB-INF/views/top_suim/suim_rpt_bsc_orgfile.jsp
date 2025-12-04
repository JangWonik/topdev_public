<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<script>
	function rptOrgFileDel(serialNo){
		if(confirm("보고서 원본 파일을 삭제하시겠습니까?")){
			$.post("./rptOrgFileDel",
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
			);		
		}
	}
	
	function fileDownModal(fkey, type, suim_rpt_no,fileName){
		
		var url = "filedownModal";		//파일다운로드 확인페이지
		
		var param = {};
		param.key = fkey;		
		param.type = type;
		param.suimRptNo = suim_rpt_no;
		param.fileName = fileName;
		
		$.ajax({
	        type: "POST",
	        url: url,
	        data: param,
	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	        timeout: 20000,
	        dataType: "HTML", 
	        success: function(data){
	        	$("#filedown-dialog").html();
	        	$("#filedown-dialog").html(data);
				$("#filedown-dialog").dialog({
					height: 200,
					width: 500,
					closeOnEscape : true,
					draggable : true,
					title: "파일 다운로드",					
					modal: true,					
					overlay:{ opacity: 0., background: '#000000'}
				});		
	        },
	        error: function(e){
	            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
	        }
	    });
	}
	
	function doDownStart(p_key){
		var f_comment = $("#downComment_"+p_key).val();
		if( f_comment.length < 5 ){
			alert("파일 다운로드 사유를 5글자 이상 입력해주세요.");
			return;
		}else{
			$("#filedown-dialog").dialog("close");
			$("#downForm_"+p_key).attr('action','fileDownloadNew');
			$("#downForm_"+p_key).submit();	
		}
	}
	
	function doDownCancel(){
		$("#filedown-dialog").dialog("close");		
	}
	
	function doDownLog(fkey, suim_rpt_no, fileName){
		
		var url = "filelogModal";		//파일다운로드 로그확인페이지
		
		var param = {};
		param.key = fkey;
		param.suimRptNo = suim_rpt_no;
		param.fileName = fileName;
		
		$.ajax({
	        type: "POST",
	        url: url,
	        data: param,
	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	        timeout: 20000,
	        dataType: "HTML", 
	        success: function(data){
	        	$("#filelog-dialog").html();
	        	$("#filelog-dialog").html(data);
				$("#filelog-dialog").dialog({
					height: 400,
					width: 700,
					closeOnEscape : true,
					draggable : true,
					title: "파일 다운로드 로그조회",					
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
</script>
<style>
	.buttonEduView{
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
		color:#FFFFFF  !important;
		width:60px;
		height:0px;
		padding:10px;
		border-color:#e1e1e1;
		border-width:1px;
		border-style:solid;
		background: #3232FF;
	}
		    
	.buttonEduDown{
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
		color:#FFFFFF  !important;
		width:60px;
		height:0px;
		padding:10px;
		border-color:#e1e1e1;
		border-width:1px;
		border-style:solid;
		background: #FF0099;
	}
	
	.buttonEduLog{
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
		font-size:11px;
		color:#FFFFFF  !important;
		width:50px;
		height:0px;
		padding:10px;
		border-color:#e1e1e1;
		border-width:1px;
		border-style:solid;
		background: #FFA500;
	}
</style>
</head>
<body>
	<!-- 현재 진행 상황 입력 --> 
	<table align="center" style="margin-top:10px;">
		<colgroup>
			<col width="60%">
			<col width="40%">
		</colgroup>
		<thead>
			<tr>
				<td colspan="4">
					<b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;" /> 4-3. 보고서 원본 파일 업로드</b>
				</td>
			</tr>
			<tr>
				<th>파일명</th>
				<th>등록일</th>				
			</tr>
		</thead>
		<tbody align="center" id = "rptOrgFileList">
			<c:forEach items="${rptOrgFileList}" var="orgFileVo">
				<tr id = "rptFileOrgTr_${orgFileVo.serialNo}">
					<td>
						<c:choose>
							<c:when test="${suimVO.lockFlag eq 0}"> 
								<%-- 다운로드 수정 by top3009 --%>
								<%-- <a href="fileDownload?key=${orgFileVo.serialNo}&type=rptOrigin&suimRptNo=${suimVO.suim_rpt_no}">
		        				   <font color="blue"> ${orgFileVo.fileName} </font>
		  					    </a> --%>
		  					    <a href="#" onclick="fileDownModal('${orgFileVo.serialNo}','rptOrigin','${suimVO.suim_rpt_no}','${orgFileVo.fileName}')">
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
						<c:if test="${suimVO.suimRptState eq '0' and suimVO.editYN > 0}">
							<img src='./resources/ls_img/btn_del_s.gif' onclick="rptOrgFileDel('${orgFileVo.serialNo}');" style='cursor:pointer; margin-left:5px;'/>
						</c:if>
						<c:if test="${mbrVo_Session.user_state eq 9}">&nbsp;&nbsp;
							<a href="#noloc" class="buttonEduLog" id="btn-search" onclick="javascript:doDownLog('${orgFileVo.serialNo}','${suimVO.suim_rpt_no}','${orgFileVo.fileName}');">로그확인</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</tbody>
		<tr>
			<td colspan="2" align="center">
			<c:choose>
				<c:when test="${suimVO.suimRptState eq '0' and suimVO.editYN > 0}">
					<%@include file="../include/uploadform_rptOrgFile.jsp"%>			
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
	<!-- 파일다은로드 모달 시작-->
	<div id="filedown-dialog" title="파일다운로드" style="font-size: 15px;display:none;" align="center">
	</div>
	<!-- 파일다은로드 모달 끝-->
	<!-- 파일다은로드 로그모달 시작-->
	<div id="filelog-dialog" title="파일다운로드내역" style="font-size: 15px;display:none;" align="center">
	</div>
	<!-- 파일다은로드 로그모달 끝-->
</body>