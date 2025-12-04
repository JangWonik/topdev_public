<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<script>
		$(document).ready(function(){
		
		});
		
		/* 보고서 이첩 */
	    function fnRptMbrchgOut() {
			var outMbr = $("#topMbr").val();
			
			var mbrchgReason = $("#mbrchgReason").val();
			var chkLength = $('input:checkbox[name="chkMbrchg"]:checked').length;

			if( chkLength == 0 ){
				alert("선택한 보고서가 없습니다..");
				return;
			}
			
			if (outMbr == 0){
				alert("이첩 대상자를 선택 해 주세요..");
				$("#topMbr").focus();
				return;
			}	

			if ( mbrchgReason == 0 ){
				alert("이첩 사유를 선택 해 주세요..");
				return;
			}
			
			var userChk = 0;
			
			$.each(outRpt, function(index, data) {
				var chkUserNo  = data.split("-")[1];
				var chkSuimRptNo  = data.split("-")[0];
				if (outMbr == chkUserNo){
					var chkAcceptNo = $("#AcceptNo"+chkSuimRptNo).html().trim();
					alert("이첩 대상자는 본인이 될 수 없습니다..\n[ "+chkAcceptNo+" ]을 확인해주세요.");
					$("#topMbr").focus();
					userChk = 1;
					return false;//each문 내부에서 return false;는 break;로 쓰임
				}	
			});
			if( userChk == 1){
				return;
			}
			
			var r = confirm("선택한 보고서는 "+chkLength+"개 입니다.\n"+"이첩 하시겠습니까?");
			if (!r){
				return;
			}
			
			$.ajaxSettings.traditional = true;
			
	        var param = {};
	        param.outRpt = outRpt;
	        param.toUserNo = $("#topMbr").val();
	        param.toTeamId = $("#topTeamId").val();
	        param.mbrchgReason = $("#mbrchgReason").val();
	        
	        var url = "./rptMbrchgOut";
	        $.ajax({
	            type: "POST",
	            url: url,
	            data: param,
	            dataType: "JSON",
	            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	            timeout: 20000,
	            success: function(data){
	            	if (data.result == "0000"){
						alert("이첩신청을 완료하였습니다.");
						location.reload();
	            	}else{
	            		alert("이첩에 실패하였습니다. \n관리자에게 문의 해주세요.")
	            	}
	            },
	            error: function(e){
	                alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
	            }
	        });	
	    }
		
		function fnAllChk(chk){
			var isChkAll = $(chk).is(":checked");
			outRpt = []; //배열초기화
			
			if (isChkAll){
				$('input:checkbox[name="chkMbrchg"]').each(function(){
					this.checked = true;
					if (this.checked){
						var tmpStr = $(this).attr("suimRptNo")+"-"+$(this).attr("userNo")+"-"+$(this).attr("teamId");
						outRpt.push(tmpStr);
					}
				});
				var chkLength = $('input:checkbox[name="chkMbrchg"]').length;
				$(".chkCntSpan").html("선택한 보고서 : 총 "+chkLength+" 개");
				
			}else{
				$('input:checkbox[name="chkMbrchg"]').each(function(){
					this.checked = false;
				});
				$(".chkCntSpan").html("선택한 보고서 : 0 개");
			}
		}
		
		function fnOneChk(chk){
			var chkLength = $('input:checkbox[name="chkMbrchg"]:checked').length;
			outRpt = [];
			$('input:checkbox[name="chkMbrchg"]:checked').each(function(){
				var tmpStr = $(this).attr("suimRptNo")+"-"+$(this).attr("userNo")+"-"+$(this).attr("teamId");
				outRpt.push(tmpStr);
			});
			$(".chkCntSpan").html("선택한 보고서 : 총 "+chkLength+" 개");
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
			<col width="100" />	<!-- 접수일 -->
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
			</tr>
		</thead>
		
		<tbody>
		
		<c:forEach var="rptMbrchgList" items="${rptMbrchgList}" varStatus="rmcStatus">
			<tr id="chgTr${rptMbrchgList.suimRptNo}"> 
				<!-- 체크 -->
				<td class="chgTd">
					<input type="checkbox" id="chkMbrchg${rmcStatus.index}" name="chkMbrchg" onclick="fnOneChk(this);" suimRptNo="${rptMbrchgList.suimRptNo}" userNo="${rptMbrchgList.userNo}" teamId="${rptMbrchgList.teamId}" }/>
				</td>
				<!-- 순번 -->
				<td class="chgTd">
					${rptMbrchgListCnt - srchParam.limitPage - rmcStatus.index} 
				</td>
				<!-- 접수번호 -->
				<td class="chgTd" id="AcceptNo${rptMbrchgList.suimRptNo}" style="cursor:pointer;" onclick="popSuimDtl(${rptMbrchgList.suimRptNo})">
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
	
