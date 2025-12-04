<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script>
	$(document).ready(function(){

		/* 공동조사자 추가 */
		$("#addShareInv").click(function(){
			if($("#mbrNo0").val().trim() == ''){
				alert("공동조사자를 선택하세요.");
				$("#mbrNo0").focus();
				return;
			}
			$.post("./primBizRptDtlShaAdd",
					{
						rpt_invoice_no				:$("#rpt_invoice_no").val()
						,suim_rpt_no				:$("#suim_rpt_no").val()
						,share_user_no     			:$("#mbrNo0").val()
						,share_team_id				:$("#share_team_id0").val()
						,suim_rpt_no				:$("#suim_rpt_no").val()
						,share_amt_basic     		:$("#share_amt_basic").val()
						,share_amt_daily      		:$("#share_amt_daily").val()
						,share_amt_etc    			:$("#share_amt_etc").val()
						,share_amt_traffic  		:$("#share_amt_traffic").val()
						,share_amt_counsel   		:$("#share_amt_counsel").val()
						,share_ea	   				:$("#share_ea").val()
						,share_workload_ea	   		:$("#share_workload_ea").val()
						
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("공동조사자 추가가 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{
								alert("추가되었습니다.");
								//window.opener.location.reload();
								window.location.reload();
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}//function
			);//post

		});//$("#popptnrsave").click

		/* 공동조사자 수정 */
		$(".udtShareInv").click(function(){
			var tmpVar = $(this).attr("value");
			$.post("./primBizRptDtlShaUdt",
					{
						serial_no					:$("#serial_no"+tmpVar).val()
						,rpt_invoice_no				:$("#rpt_invoice_no"+tmpVar).val()
						,share_user_no     			:$("#mbrNo"+tmpVar).val()
                        ,share_team_id              :$("#share_team_id"+tmpVar).val()
						,suim_rpt_no				:$("#suim_rpt_no"+tmpVar).val()
						,share_amt_basic     		:$("#share_amt_basic"+tmpVar).val()
						,share_amt_daily      		:$("#share_amt_daily"+tmpVar).val()
						,share_amt_etc    			:$("#share_amt_etc"+tmpVar).val()
						,share_amt_traffic  		:$("#share_amt_traffic"+tmpVar).val()
						,share_amt_counsel   		:$("#share_amt_counsel"+tmpVar).val()
						,share_ea	   				:$("#share_ea"+tmpVar).val()
						,share_workload_ea	   		:$("#share_workload_ea"+tmpVar).val()
						
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("공동조사자 수정이 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{
								alert("수정되었습니다.");
								//window.opener.location.reload();
								window.location.reload();
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}//function
			);//post
		});/* $("#popptnrsave").click */

		$(".shareAmtToSum").blur(function(){
			var tmpSum = String(parseInt($("#share_amt_basic").val().replace(/,/g,""))
			+ parseInt($("#share_amt_daily").val().replace(/,/g,""))
			+ parseInt($("#share_amt_traffic").val().replace(/,/g,""))
			+ parseInt($("#share_amt_counsel").val().replace(/,/g,""))
			+ parseInt($("#share_amt_etc").val().replace(/,/g,"")));
			$("#share_amt_total").val(tmpSum.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));
		});//$("#amtBasic").blur

		/* 공동조사자 삭제 */
		$(".delShareInv").click(function(){
			var tmpVar = $(this).attr("value");
			$.post("./primBizRptDtlShaDel",
					{
						serial_no					:$("#serial_no"+tmpVar).val()
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("공동조사자 삭제가 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{
								alert("삭제되었습니다.");
								//window.opener.location.reload();	
								window.location.reload();
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}//function
			);//post
		});/* $("#popptnrsave").click */

	}); //document.ready

	function shareNoAmtToSum(no){
		var tmpSum = String(parseInt($("#share_amt_basic"+no).val().replace(/,/g,""))
				+ parseInt($("#share_amt_daily"+no).val().replace(/,/g,""))
				+ parseInt($("#share_amt_traffic"+no).val().replace(/,/g,""))
				+ parseInt($("#share_amt_counsel"+no).val().replace(/,/g,""))
				+ parseInt($("#share_amt_etc"+no).val().replace(/,/g,"")));
				$("#share_amt_total"+no).val(tmpSum.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));
	}
</script>

						<c:import url="../util_etc/module_mbrpop_1.jsp"></c:import>
						<table style="margin-bottom:5px;">
							<tr>
								<td align="left" style="padding-left:10px;"><b> 공동 조사자</b></td>
								<td align="right" style="padding-right:10px;">
								</td>
							</tr>
						</table>
						<div class= "tableStyle2">
							<table>
								<tr>
									<th style="width:18%">공동조사자</th>
									<th>기본보수</th>
									<th>일비</th>
									<th>교통비</th>
									<th>자문료</th>
									<th>기타</th>
									<th>합계</th>
									<th>건수</th>
									<c:if test="${primBizRptDtl.workloadUseAt == 1}">
										<th>기준업무량<br/>종결건수</th>
									</c:if>
									<th>추가</th>
								</tr>
								<tr>
									<td>
										<input type="hidden" id="mbrNo0" />
										<input type="hidden" id="share_team_id0" />
										<input type="text" id="mbrNm0" size="9" readonly style="background-color:lightgrey;" />
										<input type="image" src='./resources/ls_img/member/icon_search.gif' class="popOpenBtn" value="0" />
									</td>
									<td>
										<input type="text" name="share_amt_basic" id="share_amt_basic" class="shareAmtToSum" value="0"
											ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);"  style="ime-mode:disabled;text-align:right;width:63px;" /> 원
									</td>
									<td>
										<input type="text" name="share_amt_daily" id="share_amt_daily" class="shareAmtToSum" value="0"
											ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);"  style="ime-mode:disabled;text-align:right;width:63px;" /> 원
									</td>
									<td>
										<input type="text" name="share_amt_traffic" id="share_amt_traffic" class="shareAmtToSum" value="0"
											ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);"  style="ime-mode:disabled;text-align:right;width:63px;" /> 원
									</td>
									<td>
										<input type="text" name="share_amt_counsel" id="share_amt_counsel" class="shareAmtToSum" value="0"
											ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);"  style="ime-mode:disabled;text-align:right;width:63px;" /> 원
									</td>
									<td>
										<input type="text" name="share_amt_etc" id="share_amt_etc" class="shareAmtToSum" value="0"
											ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);"  style="ime-mode:disabled;text-align:right;width:63px;" /> 원
									</td>
									<td>
										<input type="text" name="share_amt_total" id="share_amt_total"
											readonly style="background-color:lightgrey;text-align:right;width:63px;" /> 원
									</td>
									<td>
										<input type="text" name="share_ea" id="share_ea" value="0"
											style="ime-mode:disabled;text-align:right;width:63px;" /> 건
									</td>
									
									<c:if test="${primBizRptDtl.workloadUseAt == 1}">
										<td>
											<input type="text" name="share_workload_ea" id="share_workload_ea" value="0"
												style="ime-mode:disabled;text-align:right;width:63px;" /> 건
										</td>				
									</c:if>
																		
									<td>
										<c:choose>
											<c:when test="${( primBizRptDtl.suim_rpt_state == 0 && primBizRptDtl.edit_yn > 0 )}">
												<img src="./resources/ls_img/btn_add.gif" id="addShareInv" alt="추가" style ="cursor:pointer" />
											</c:when>
											
											<c:when test="${( primBizRptDtl.suim_rpt_state != 0 && primBizRptDtl.endModAuth > 0 )}">
												<img src="./resources/ls_img/btn_add.gif" id="addShareInv" alt="추가(종결 후 수정)" style ="cursor:pointer" /> 
											</c:when>
											
											<c:otherwise>
												권한 없음
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
							</table>
						</div>

						<c:if test="${primBizShareList.size() > 0}">
							<!-- 공동조사자 기본료 합계를 위한 변수선언 -->
							<c:set value="0" var="amtBasicSum"/> <!-- 기본료 -->
							<c:set value="0" var="amtDailySum"/> <!-- 일비 -->
							<c:set value="0" var="amtTrafficeSum"/><!-- 교통비 -->
							<c:set value="0" var="amtCounselSum"/><!-- 자문료 -->
							<c:set value="0" var="amtEtcSum"/><!-- 기타 -->
							<c:set value="0" var="amtTotalSum"/><!-- 합계 -->
							<%--<c:set value="0" var="amtEaSum"/><!-- 종결건수 -->--%>

                            <fmt:formatNumber var="amtEaSum" value="0" pattern="#.###"/>
                            <fmt:formatNumber var="amtWorkloadEaSum" value="0" pattern="#.###"/>
                            
							
							
							<div class= "tableStyle2" style="margin-top:3px;">
								<table>
									<tr>
										<th style="width:18%">공동조사자</th>
										<th>기본보수</th>
										<th>일비</th>
										<th>교통비</th>
										<th>자문료</th>
										<th>기타</th>
										<th>합계</th>
										<th>건수</th>
										
										<c:if test="${primBizRptDtl.workloadUseAt == 1}">
											<th>기준업무량<br/>종결건수</th>
										</c:if>
										
										<th>수정/삭제</th>
									</tr>
									<c:forEach items="${primBizShareList}" var="primBizShareList" varStatus="status">
										<tr>
											<td>
												<input type="hidden" id="mbrNo${status.count}" name="share_user_no" value="${primBizShareList.getShare_user_no()}"/>
                                                <input type="hidden" id="share_team_id${status.count}" value="${primBizShareList.share_team_id}"/>
												<input type="text" id="mbrNm${status.count}" value="${primBizShareList.getShare_user_name()}" size="9" readonly style="background-color:lightgrey;" />
												<input type="image" src='./resources/ls_img/member/icon_search.gif' class="popOpenBtn" value="${status.count}" />
											</td>
											<td>
												<!-- 기본료 합 -->
												<c:set var="amtBasicSum" value="${amtBasicSum + primBizShareList.getShare_amt_basic()}" />
												<input type="text" name="share_amt_basic${status.count}" id="share_amt_basic${status.count}"
													value="<fmt:formatNumber value="${primBizShareList.getShare_amt_basic()}" pattern="###,###,##0.##"/>"
													ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);"  style="ime-mode:disabled;text-align:right;width:63px;"
													ONBLUR="shareNoAmtToSum(${status.count})" /> 원
											</td>
											<td>
												<c:set var="amtDailySum" value="${amtDailySum + primBizShareList.getShare_amt_daily()}" />
												<input type="text" name="share_amt_daily${status.count}" id="share_amt_daily${status.count}"
													value="<fmt:formatNumber value="${primBizShareList.getShare_amt_daily()}" pattern="###,###,##0.##"/>"
													ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);"  style="ime-mode:disabled;text-align:right;width:63px;"
													ONBLUR="shareNoAmtToSum(${status.count})" /> 원
											</td>
											<td>
												<c:set var="amtTrafficeSum" value="${amtTrafficeSum + primBizShareList.getShare_amt_traffic()}" />
												<input type="text" name="share_amt_traffic${status.count}" id="share_amt_traffic${status.count}"
													value="<fmt:formatNumber value="${primBizShareList.getShare_amt_traffic()}" pattern="###,###,##0.##"/>"
													ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);"  style="ime-mode:disabled;text-align:right;width:63px;"
													ONBLUR="shareNoAmtToSum(${status.count})" /> 원
											</td>
											<td>
												<c:set var="amtCounselSum" value="${amtCounselSum + primBizShareList.getShare_amt_counsel()}" />
												<input type="text" name="share_amt_counsel${status.count}" id="share_amt_counsel${status.count}"
													value="<fmt:formatNumber value="${primBizShareList.getShare_amt_counsel()}" pattern="###,###,##0.##"/>"
													ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);"  style="ime-mode:disabled;text-align:right;width:63px;"
													ONBLUR="shareNoAmtToSum(${status.count})" /> 원
											</td>
											<td>
												<c:set var="amtEtcSum" value="${amtEtcSum + primBizShareList.getShare_amt_etc()}" />
												<input type="text" name="share_amt_etc${status.count}" id="share_amt_etc${status.count}"
													value="<fmt:formatNumber value="${primBizShareList.getShare_amt_etc()}" pattern="###,###,##0.##"/>"
													ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);"  style="ime-mode:disabled;text-align:right;width:63px;"
													ONBLUR="shareNoAmtToSum(${status.count})" /> 원
											</td>
											<td align="center">
												<c:set var="amtTotalSum" value="${amtTotalSum + primBizShareList.getShare_amt_total()}" />
												<input type="hidden" name="shareAmtTotalArr" value="${primBizShareList.getShare_amt_total()}" />
												<input type="text" name="share_amt_total${status.count}" id="share_amt_total${status.count}"
													value="<fmt:formatNumber value="${primBizShareList.getShare_amt_total()}" pattern="###,###,##0.##"/>"
													readonly style="background-color:lightgrey;text-align:right;width:63px;" /> 원
											</td>
											
											<td>
												<%--<c:set var="amtEaSum" value="${amtEaSum + primBizShareList.getShare_ea()}" />--%>
                                                <fmt:formatNumber var="amtEaSum" value="${amtEaSum + primBizShareList.getShare_ea()}" pattern="#.###"/>
												<input type="text" name="share_ea${status.count}" id="share_ea${status.count}"
													   value="<fmt:formatNumber value="${primBizShareList.getShare_ea()}" pattern="###,###,##0.##"/>"
													   style="ime-mode:disabled;text-align:right;width:63px;" /> 건
											</td>
											
											<c:if test="${primBizRptDtl.workloadUseAt == 1}">
												<td>
	                                               	<fmt:formatNumber var="amtWorkloadEaSum" value="${amtWorkloadEaSum + primBizShareList.getShare_workload_ea()}" pattern="#.###"/>
													<input type="text" name="share_workload_ea${status.count}" id="share_workload_ea${status.count}"
														   value="<fmt:formatNumber value="${primBizShareList.getShare_workload_ea()}" pattern="###,###,##0.##"/>"
														   style="ime-mode:disabled;text-align:right;width:63px;" /> 건
												</td>		
											</c:if>	
																			
											<td align="center">
												<c:choose>
													<c:when test="${primBizRptDtl.suim_rpt_state == 0 && primBizRptDtl.edit_yn > 0}">
														<input type="image" src="./resources/ls_img/btn_edite.gif" value="${status.count}" class="udtShareInv" alt="수정" style ="cursor:pointer" /><br>
														<input type="image" src="./resources/ls_img/btn_del.gif" value="${status.count}" class="delShareInv" alt="삭제" style ="cursor:pointer" />
													</c:when>
													<c:when test="${primBizRptDtl.suim_rpt_state != 0 && primBizRptDtl.endModAuth > 0}">
														<input type="image" src="./resources/ls_img/btn_edite.gif" value="${status.count}" class="udtShareInv" alt="수정" style ="cursor:pointer" /><br>
														<input type="image" src="./resources/ls_img/btn_del.gif" value="${status.count}" class="delShareInv" alt="삭제" style ="cursor:pointer" /> 
													</c:when>
													<c:otherwise>권한 없음</c:otherwise>
												</c:choose>
												<input type="hidden" id="serial_no${status.count}" name="serial_no" value="${primBizShareList.getSerial_no()}"/>
											</td>
											
										</tr>
									</c:forEach>
									
									<!-- 공동 조사자의 금액 합계 -->
									<input type="hidden" id="amtBasicSum" name="amtBasicSum" value="${amtBasicSum}" />
									<input type="hidden" id="amtDailySum" name="amtDailySum" value="${amtDailySum}" />
									<input type="hidden" id="amtTrafficeSum" name="amtTrafficeSum" value="${amtTrafficeSum}" />
									<input type="hidden" id="amtCounselSum" name="amtCounselSum" value="${amtCounselSum}" />
									<input type="hidden" id="amtEtcSum" name="amtEtcSum" value="${amtEtcSum}" />
									<input type="hidden" id="amtTotalSum" name="amtTotalSum" value="${amtTotalSum}" />
									<input type="hidden" id="amtEaSum" name="amtEaSum" value="${amtEaSum}" />
									<input type="hidden" id="amtWorkloadEaSum" name="amtWorkloadEaSum" value="${amtWorkloadEaSum}" />
									
								</table>
							</div>
						</c:if>
