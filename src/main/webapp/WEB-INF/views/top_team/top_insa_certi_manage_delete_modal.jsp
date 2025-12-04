<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link href="./resources/select2/select2.min.css" rel="stylesheet" />
<script src="./resources/select2/select2.min.js"></script>
<style>
	.tableStyle2 td{
		letter-spacing : 0px;
	}
	.buttonAssistanceMember{
		width:100px;
		height:25px;
	    background-color:#2E7EE8;
	    color:#FFFFFF;
	    text-align: center;
		border-radius:5px;
	    font-size: 13px;
	    cursor: pointer;
	    text-decoration:none;
	    border: none;
	    font-weight:bold;
    }
</style>
<script>
	function doExcelDown(){
		$("#subExcelForm").submit();		
	}
</script>
<form id="subExcelForm" name="subExcelForm" action="doCertiSubInfoDown" method="post">
	<input type="hidden" id="ckey" name="ckey" value="${certiInfoMap.ckey}"/>
	<input type="hidden" id="user_name" name="user_name" value="${certiInfoMap.user_name}"/>
</form>
<div id="certi-delete-dialog" title="손해사정사 삭제관리" style="font-size: 12px;" align="center">
	<table>		
		<tr>
			<td style="text-align:left;padding:5px 0 5px 0;">
				<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0"> <b>손해사정 등록정보</b>			
			</td>
		</tr>
	</table>
	<div class="tableStyle2">
		<table class="vacation-ins-table">
			<tr>				
				<th>이름</th>
				<th>등록보종</th>
				<th>등록번호</th>
				<th>지점연락처</th>				
			</tr>
			<tr>				
				<td>${certiInfoMap.user_name}</td>
				<td>${certiInfoMap.certi_type_nm}</td>
				<td>${certiInfoMap.certi_number}</td>
				<td>${certiInfoMap.work_phone}</td>
			</tr>
		</table>
	</div>
	<table>
		<tr>
			<td style="height:24px;text-align:left;padding:5px 0 5px 0;">
				<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0"> <b>담당 손해사정사 보조인현황</b>			
			</td>
			<td align="right">				
				<input title="보조인 현황 다운로드" class="buttonAssistanceMember" type="button" value="보조인 현황 다운로드" style="width:140px;background-color:#31B404;" onclick="javascript:doExcelDown();">
			</td>
		</tr>
	</table>
	<div class="tableStyle2">
		<table class="vacation-ins-table">
			<tr>
				<th>부서명</th>
				<th>이름</th>								
			</tr>
			<c:choose>
				<c:when test="${certiSubMemberList.size() == 0}">
					<tr>
						<td colspan="2">담당 손해사정사로 등록된 보조인이 없습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${certiSubMemberList}" var = "subMemberVo">
						<tr>
							<td>${subMemberVo.team_name}</td>
							<td>${subMemberVo.user_name}</td>				
						</tr>
					</c:forEach>		
				</c:otherwise>
			</c:choose>						
		</table>		
	</div>
	<c:if test="${srchParam.manual_text eq 1}">
		<table>
			<tr>
				<td style="padding:5px 0 5px 0;"><font style="color:blue;font-weight:bold;">&#8251; 삭제 클릭시 손해사정사 정보 및 보조인에 등록된 담당손해사정사 정보도 삭제됩니다.</font></td>
			</tr>
			<tr>
				<td style="padding:5px 0 5px 0;"><font style="color:blue;font-weight:bold;">&#8251; 취소 클릭시 담당손해사정사 정보와 보조인의 담당 손해사정사정보는 삭제되지 않습니다.</font></td>
			</tr>
		</table>
	</c:if>
</div>