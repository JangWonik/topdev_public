<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
	$(document).ready(function(){	
		_initMask();
    });
	
	
	function fnInsPrimBizShare(){	
		if($("#mbrNo1").val().trim() == ''){
			alert("공동조사자를 선택하세요.");
			$("#mbrNo1").focus();
			return;
		}
		
		var tmp = window.confirm("공동 조사자를 추가 하시겠습니까?");
		if(tmp == false){
			return;
		}
		
		$("#formRptInvNo").val($("#rpt_invoice_no").val());
		$("#formShareUserNo").val($("#mbrNo1").val());
		$("#formSuimRptNo").val($("#suim_rpt_no").val());
		
		var tmpBasic = $("#share_amt_basic").val().num();
		var tmpDaily = $("#share_amt_daily").val().num();
		var tmpEtc = $("#share_amt_etc").val().num();
		var tmpTraffic = $("#share_amt_traffic").val().num();
		var tmpCounsel = $("#share_amt_counsel").val().num();
		$("#formShareAmtBasic").val(tmpBasic);
		$("#formShareAmtDaily").val(tmpDaily);
		$("#formShareAmtEtc").val(tmpEtc);
		$("#formShareAmtTraffic").val(tmpTraffic);
		$("#formShareAmtCounsel").val(tmpCounsel);
		
		$("#formShareEa").val($("#share_ea").val());
		$("#primBizInvShareInsForm").attr("action", "primBizInvShareAddOK");
		$("#primBizInvShareInsForm").submit();
	}

    /* mask 처리 */
    function _initMask(){
        var options = {
            onKeyPress : function(cep, event, currentField, options){
                var tid = event.currentTarget.id;
                var tidx = tid.substr(tid.length - 1, 1);
                //console.log(tidx);
                //fnCaculateTotal(tidx);
            },
            reverse : true
        };

        $('input.money').mask('#,###,###',options);
        $('div.money').mask('999,999,999',{reverse:true});
    }
	
	function fnUdtPrimBizShare(tmpVar){
		var tmp = window.confirm("공동 조사자를 수정 하시겠습니까?");
		if(tmp == false){
			return;
		}
		$("#formSerialNo").val($("#serial_no"+tmpVar).val());
		$("#formRptInvNo").val($("#rpt_invoice_no").val());
		$("#formShareUserNo").val($("#share_user_no"+tmpVar).val());
		$("#formSuimRptNo").val($("#suim_rpt_no").val());
		
		
		var tmpBasic = $("#share_amt_basic"+tmpVar).val().num();
		var tmpDaily = $("#share_amt_daily"+tmpVar).val().num();
		var tmpEtc = $("#share_amt_etc"+tmpVar).val().num();
		var tmpTraffic = $("#share_amt_traffic"+tmpVar).val().num();
		var tmpCounsel = $("#share_amt_counsel"+tmpVar).val().num();
		$("#formShareAmtBasic").val(tmpBasic);
		$("#formShareAmtDaily").val(tmpDaily);
		$("#formShareAmtEtc").val(tmpEtc);
		$("#formShareAmtTraffic").val(tmpTraffic);
		$("#formShareAmtCounsel").val(tmpCounsel);
		
		$("#formShareEa").val($("#share_ea"+tmpVar).val());
		$("#primBizInvShareInsForm").attr("action", "primBizInvShareUdtOK");
		$("#primBizInvShareInsForm").submit();
	}
	
	function fnDelPrimBizShare(tmpVar,p_serialNo,p_shareUserNo,p_shareBasicVal,p_shareDailyVal,p_shareEtcVal,p_shareTrafficVal,p_shareCounselVal){
		var tmpVar = $(this).attr("value");
		var tmp = window.confirm("공동 조사자를 삭제 하시겠습니까?");
		if(tmp == false){
			return;
		}

		$("#formSerialNo").val(p_serialNo);
		$("#formRptInvNo").val($("#rpt_invoice_no").val());
		$("#formShareUserNo").val(p_shareUserNo);
		$("#formSuimRptNo").val($("#suim_rpt_no").val());				
		
		var tmpBasicVal = p_shareBasicVal;
		var tmpDailyVal = p_shareDailyVal;
		var tmpEtcVal = p_shareEtcVal;
		var tmpTrafficVal = p_shareTrafficVal;
		var tmpCounselVal = p_shareCounselVal;
		
		$("#formShareAmtBasic").val(tmpBasicVal);
		$("#formShareAmtDaily").val(tmpDailyVal);
		$("#formShareAmtEtc").val(tmpEtcVal);
		$("#formShareAmtTraffic").val(tmpTrafficVal);
		$("#formShareAmtCounsel").val(tmpCounselVal);
		
		$("#formShareEa").val($("#share_ea"+tmpVar).val());
		$("#primBizInvShareInsForm").attr("action", "primBizInvShareDelOK");
		$("#primBizInvShareInsForm").submit();
	}/* $("#delShareInv").click */	
	
</script>

	<form id="primBizInvShareInsForm" method="post">
		<input type="hidden" name="formSerialNo" id="formSerialNo" />
		<input type="hidden" name="formRptInvNo" id="formRptInvNo" />
		<input type="hidden" name="formShareUserNo" id="formShareUserNo" />
		<input type="hidden" name="formSuimRptNo" id="formSuimRptNo" />
		<input type="hidden" name="formShareAmtBasic" id="formShareAmtBasic" />
		<input type="hidden" name="formShareAmtDaily" id="formShareAmtDaily" />
		<input type="hidden" name="formShareAmtEtc" id="formShareAmtEtc" />
		<input type="hidden" name="formShareAmtTraffic" id="formShareAmtTraffic" />
		<input type="hidden" name="formShareAmtCounsel" id="formShareAmtCounsel" />
		<input type="hidden" name="formShareEa" id="formShareEa" />
	</form>
	
		<b><font color="#5892C3">공동조사자 추가</font></b>
		<div class= "tableStyle2">
				<table>
					<tr>
						<th style="width:18%">공동조사자</th>
						<th>기본보수</th>
						<th>일비</th>
						<th>교통비</th>
						<th>자문료</th>
						<th>기타</th>
						<th>건수</th>
						<th>-</th>
					</tr>
					<tr>
						<td>
							<input type="hidden" id="mbrNo1" />
							<input type="text" id="mbrNm1" size="13" readonly style="background-color:lightgrey;" />
							<input type="image" src='./resources/ls_img/member/icon_search.gif' class="popOpenBtn" value="1" />
						</td>
						<td><input type="text" class="money" id="share_amt_basic" name="share_amt_basic" style="width:80px;"/></td>
						<td><input type="text" class="money" id="share_amt_daily" name="share_amt_daily" style="width:80px;"/></td>
						<td><input type="text" class="money" id="share_amt_traffic" name="share_amt_traffic" style="width:80px;"/></td>
						<td><input type="text" class="money" id="share_amt_counsel" name="share_amt_counsel" style="width:80px;"/></td>
						<td><input type="text" class="money" id="share_amt_etc" name="share_amt_etc" style="width:80px;"/></td>
						<td><input type="text" class="money" id="share_ea" name="share_ea" style="width:80px;"/></td>
						<td><img src="./resources/ls_img/btn_add.gif" id="addShareInv" onclick="fnInsPrimBizShare()" alt="추가" style ="cursor:pointer" /></td>
					</tr>
				</table>
		</div>
		<br>
			<b><font color="#5892C3">공동조사자 수정/삭제</font></b>
			<div class= "tableStyle2">
			<c:import url="../util_etc/module_mbrpop_1.jsp"></c:import>
			<table>
				<thead>
					<tr>
						<th style="width:18%">공동조사자</th>
						<th>기본보수</th>
						<th>일비</th>
						<th>교통비</th>
						<th>자문료</th>
						<th>기타</th>
						<th>합계</th>
						<th>건수</th>
						<th width="100px">-</th>
					</tr>
					<c:forEach items="${primBizInvShareList}" var="primBizInvShareList" varStatus="status">
					<tr>
						<td>
							<input type="hidden" id="share_user_no${status.index}" name="share_user_no" value="${primBizInvShareList.getShare_user_no()}"/>
							<input type="text" value="${primBizInvShareList.getShare_user_name()}"id="share_user_name${status.index}" size="13" readonly style="background-color:lightgrey;" />
							<input type="image" src='./resources/ls_img/member/icon_search.gif' class="popOpenBtn" value="${status.index}" />
						</td>
						<!-- 기본보수 -->
						<td>
							<input type="text" class="money" id="share_amt_basic${status.index}" name="share_amt_basic" value="${primBizInvShareList.getShare_amt_basic()}" style="width:80px;"/>
						</td>
						<!-- 일비 -->
						<td>
							<input type="text" class="money" id="share_amt_daily${status.index}" name="share_amt_daily" value="${primBizInvShareList.getShare_amt_daily()}" style="width:80px;"/>
						</td>
						<!-- 교통비 -->
						<td>
							<input type="text" class="money" id="share_amt_traffic${status.index}" name="share_amt_traffic" value="${primBizInvShareList.getShare_amt_traffic()}" style="width:80px;"/>
						</td>
						<!-- 자문료 -->
						<td>
							<input type="text" class="money" id="share_amt_counsel${status.index}" name="share_amt_counsel" value="${primBizInvShareList.getShare_amt_counsel()}" style="width:80px;"/>
						</td>
						<!-- 기타 -->
						<td>
							<input type="text" class="money" id="share_amt_etc${status.index}" name="share_amt_etc" value="${primBizInvShareList.getShare_amt_etc()}" style="width:80px;"/>
						</td>
						<td style="letter-spacing: 0;">
							<fmt:formatNumber  value="${primBizInvShareList.getShare_amt_total()}" pattern="#,###"/> 원
						</td>
						<td>
							<input type="text" id="share_ea${status.index}" name="share_ea" value="${primBizInvShareList.getShare_ea()}" style="width:80px;"/>
						</td>
						<td>
							<img src="./resources/ls_img/btn_edite.gif" onclick="fnUdtPrimBizShare(${status.index})" id="udtShareInv" alt="수정" style ="cursor:pointer" />
							<img src="./resources/ls_img/btn_del.gif" onclick="fnDelPrimBizShare(${status.index},'${primBizInvShareList.getSerial_no()}','${primBizInvShareList.getShare_user_no()}','${primBizInvShareList.getShare_amt_basic()}','${primBizInvShareList.getShare_amt_daily()}','${primBizInvShareList.getShare_amt_etc()}','${primBizInvShareList.getShare_amt_traffic()}','${primBizInvShareList.getShare_amt_counsel()}')" id="delShareInv" alt="삭제" style ="cursor:pointer" />
														
							<input type="hidden" id="serial_no${status.index}" name="serial_no" value="${primBizInvShareList.getSerial_no()}"/>
						</td>
					</tr>
					<c:set var="amtBasicSum" value="${amtBasicSum + primBizInvShareList.getShare_amt_basic()}"></c:set>
					<c:set var="amtDailySum" value="${amtDailySum + primBizInvShareList.getShare_amt_daily()}"></c:set>
					<c:set var="amtEtcSum" value="${amtEtcSum + primBizInvShareList.getShare_amt_etc()}"></c:set>
					<c:set var="amtTrafficeSum" value="${amtTrafficeSum + primBizInvShareList.getShare_amt_traffic()}"></c:set>
					<c:set var="amtCounselSum" value="${amtCounselSum + primBizInvShareList.getShare_amt_counsel()}"></c:set>
					<c:set var="amtTotalSum" value="${amtTotalSum + primBizInvShareList.getShare_amt_total()}"></c:set>
					<c:set var="amtEaSum" value="${amtEaSum + primBizInvShareList.getShare_ea()}"></c:set>
										
					</c:forEach>
					<tr>
						<th>합계</th>
						<th style="letter-spacing:0;text-align:right;padding-right:10px;"><fmt:formatNumber value="${amtBasicSum}" pattern="###,###,###"/></th>
						<th style="letter-spacing:0;text-align:right;padding-right:10px;"><fmt:formatNumber value="${amtDailySum}" pattern="###,###,###"/></th>
						<th style="letter-spacing:0;text-align:right;padding-right:10px;"><fmt:formatNumber value="${amtTrafficeSum}" pattern="###,###,###"/></th>
						<th style="letter-spacing:0;text-align:right;padding-right:10px;"><fmt:formatNumber value="${amtCounselSum}" pattern="###,###,###"/></th>
						<th style="letter-spacing:0;text-align:right;padding-right:10px;"><fmt:formatNumber value="${amtEtcSum}" pattern="###,###,###"/></th>
						<th style="letter-spacing:0;"><fmt:formatNumber value="${amtTotalSum}" pattern="###,###,###"/> 원</th>
						<th style="letter-spacing:0;text-align:right;padding-right:10px;">${amtEaSum} 건</th>
						<th></th>
					</tr>
				</tbody>
				
			</table>
	
		</div>

	<%-- </c:forEach> --%>
