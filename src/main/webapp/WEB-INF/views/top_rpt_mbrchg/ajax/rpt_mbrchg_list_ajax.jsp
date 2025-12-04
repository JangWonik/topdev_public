<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<script>
		$(document).ready(function(){
			$("#srchTmId").val("${srchParam.srchTmId}");
		});
		
		var serialNo = new Array();
		var suimRptNo = new Array();
		
		function fnRptMbrchgOutCancel(index){
			if(index != null){
				fnChkBoxAllOff();
				$("#chkMbrchg"+index).click();
			}
			
			var chkLength = $('input:checkbox[name="chkMbrchg"]:checked').length;
			if (chkLength == 0){
				alert("선택한 보고서가 없습니다.. ");
				return;
			}
			
			var r = confirm("이첩 회수를 하시겠습니까?");
			if(!r){
				return;
			}
			
	        var param = {};
	        param.serialNo = serialNo;
	        
			$.ajaxSettings.traditional = true;

	        var url = "./rptMbrchgOutCancel";
	        $.ajax({
	            type: "POST",
	            url: url,
	            data: param,
	            dataType: "JSON",
	            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	            timeout: 20000,
	            success: function(data){
	            	if (data.result == "0000"){
						alert("이첩 신청을 회수하였습니다.");
						fnGoTab(1);
	            	}
	            },
	            error: function(e){
	                alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
	            }
	        });
	    }
		
		
		function fnRptMbrchgIn(index){
			if(index != null){
				fnChkBoxAllOff();
				$("#chkMbrchg"+index).click();
			}
			
			var chkLength = $('input:checkbox[name="chkMbrchg"]:checked').length;
			if (chkLength == 0){
				alert("선택한 보고서가 없습니다.. ");
				return;
			}
			
			var r = confirm("해당 보고서를 내첩 하시겠습니까?");
			if(!r){
				return;
			}
			
	        var param = {};
	        param.serialNo = serialNo;
	        param.suimRptNo = suimRptNo;
	        
	        
			$.ajaxSettings.traditional = true;

	        var url = "./rptMbrchgIn";
	        $.ajax({
	            type: "POST",
	            url: url,
	            data: param,
	            dataType: "JSON",
	            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	            timeout: 20000,
	            success: function(data){
	            	if (data.result == "0000"){
						alert("내첩을 완료 하였습니다.");
						fnGoTab(2);
	            	}
	            },
	            error: function(e){
	                alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
	            }
	        });
	    }		
		
		
		
		function fnAllChk(chk){
			var isChkAll = $(chk).is(":checked");
			if (isChkAll){
				fnChkBoxAllOn();
			}else{
				fnChkBoxAllOff();
			}
		}
		
		function fnOneChk(chk){
			var chkLength = $('input:checkbox[name="chkMbrchg"]:checked').length;
			serialNo = [];
			suimRptNo = [];
			$('input:checkbox[name="chkMbrchg"]:checked').each(function(){
				serialNo.push( $(this).attr("serialNo") );
				suimRptNo.push( $(this).attr("suimRptNo") );
			});
			$(".chkCntSpan").html("선택한 보고서 : 총 "+chkLength+" 개");
		}
		
		function fnChkBoxAllOn(){
			serialNo = [];
			suimRptNo = [];
			$('input:checkbox[name="chkMbrchg"]').each(function(){
				this.checked = true;
				if (this.checked){
					serialNo.push( $(this).attr("serialNo") );
					suimRptNo.push( $(this).attr("suimRptNo") );
				}
			});
			var chkLength = $('input:checkbox[name="chkMbrchg"]').length;
			$(".chkCntSpan").html("선택한 보고서 : 총 "+chkLength+" 개");
		}
		
		function fnChkBoxAllOff(){
			$('input:checkbox[name="chkMbrchg"]').each(function(){
				this.checked = false;
				serialNo = [];
				suimRptNo = [];
			});
			
			$(".chkCntSpan").html("선택한 보고서 : 0 개");
		}
	</script>
	
	<table>
		<colgroup>
			<col width="30" /> 	<!-- 체크 -->
			<col width="30" />	<!-- 순번 -->
			<col width="90" />	<!-- 접수번호 -->
			<col width="35" />	<!-- 사고번호1 -->
			<col width="60" />	<!-- 사고번호2 -->
			<col width="95" />	<!-- 담당부서 -->
			<col width="80" />	<!-- 담당자 -->
			<col width="100" />	<!-- 계약자 -->
			<col width="100" />	<!-- 피보험자 -->
			<col width="100" />	<!-- 피해자/물 -->
			<col width="70" />	<!-- 접수일 -->
			<col width="80" />	<!-- 이첩 등록자 -->
			<col width="80" />	<!-- 기존 담당자-->
			<col width="80" />	<!-- 변경 담당자 -->
			<col width="70" />	<!-- 이첩 사유 -->		
			<col width="70" />	<!-- 버튼부 && 상태 -->
		</colgroup>
	
		<thead>
			<tr>
				<th><input type="checkbox" id="chkAll" onclick="fnAllChk(this);" name="chkAll" ></th>
				<th>No.</th>
				<th>접수번호</th>
				<th colspan="2">사고번호</th>
				<th>담당부서</th>
				<th>담당자</th>
				<th>계약자</th>
				<th>피보험자</th>
				<th>피해자/물</th>
				<th>접수일</th>
				<th>이첩 등록자</th>
				<th>기존 담당자</th>
				<th>변경 담당자</th>
				<th>이첩 사유</th>
				<th>-</th>
			</tr>
		</thead>
		
		<tbody>
		
		<c:forEach var="rptMbrchgList" items="${rptMbrchgList}" varStatus="rmcStatus">
			<tr id="chgTr${rptMbrchgListStatus.index}"> 
				<!-- 체크 -->
				<td class="chgTd">
					<input type="checkbox" id="chkMbrchg${rmcStatus.index}" name="chkMbrchg" onclick="fnOneChk(this);" SuimRptNo="${rptMbrchgList.suimRptNo}" serialNo="${rptMbrchgList.serialNo}" />
				</td>
				<!-- 순번 -->
				<td class="chgTd">
					${rptMbrchgListCnt - srchParam.limitPage - rmcStatus.index} 
				</td>
				<!-- 접수번호 -->
				<td class="chgTd" style="cursor:pointer;" onclick="popSuimDtl(${rptMbrchgList.suimRptNo})">
					${rptMbrchgList.suimAcceptNo}
				</td>
				<!-- 사고번호1 -->
				<td class="chgTd" align="right">${rptMbrchgList.accidentNo1}</td>
				<!-- 사고번호2 -->
				<td class="chgTd" align="left">${rptMbrchgList.accidentNo2}</td>
				<!-- 부서명 -->
				<td class="chgTd">${rptMbrchgList.teamNm}</td>
				<!-- 담당자 -->
				<td class="chgTd">${rptMbrchgList.userNm}</td>
				<!-- 계약자 -->
				<td class="chgTd">
					${rptMbrchgList.policyholderNm}
				</td>
				<!-- 피보험자 -->
				<td class="chgTd">
					${rptMbrchgList.beneficiaryNm}
				</td>
				<!-- 피해자/물 -->
				<td class="chgTd">
					${rptMbrchgList.damagedNm}
				</td>
				<!-- 등록일 -->
				<td class="chgTd">
					${rptMbrchgList.regDate}
				</td>
				
				<!-- 이첩 등록자 -->
				<td class="chgTd">
					${rptMbrchgList.regUserNm}
				</td>
				<!-- 기존 담당자 -->
				<td class="chgTd">
					${rptMbrchgList.fromUserNm}
				</td>
				<!-- 변경 담당자 -->
				<td class="chgTd">
					${rptMbrchgList.toUserNm}
				</td>

				<c:choose>
					<c:when test="${srchParam.code eq 1}">
						<!-- 이첩 사유- -->
						<td class="chgTd">
							${rptMbrchgList.mbrchgReasonVal}
						</td>
						<!-- 이첩 회수 -->
						<td class="chgTd">
							<img src="./resources/ne_img/btn/btn_chgout_cancel.gif" onclick="fnRptMbrchgOutCancel(${rmcStatus.index});" style="cursor:pointer;">
						</td>
					</c:when>
					<c:when test="${srchParam.code eq 2}">
						<!-- 이첩 사유- -->
						<td class="chgTd">
							${rptMbrchgList.mbrchgReasonVal}
						</td>
						<!-- 내첩 -->					
						<td class="chgTd">
							<img src="./resources/ne_img/btn/btn_chgin.gif" onclick="fnRptMbrchgIn(${rmcStatus.index});" style="cursor:pointer;">
						</td>
					</c:when>
				</c:choose>
			</tr>
			
		</c:forEach>
		</tbody>
	</table>
	
	<div class="pagingWrap">
   	<%--<div class="pageContent">--%>
       	<c:import url="/page_navi">
           	<c:param name="beginIdx" value="${pageInfo.firstPageNoOnPageList}"/>
               <c:param name="endIdx" value="${pageInfo.lastPageNoOnPageList}"/>
               <c:param name="currentIdx" value="${pageInfo.currentPageNo}"/>
               <c:param name="totalPageCnt" value="${pageInfo.totalPageCount}"/>
		</c:import>
	<%--</div>--%>
     </div>	
	
