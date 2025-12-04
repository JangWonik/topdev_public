<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

	<style>
		.td-overflow-none{
			text-overflow : ellipsis;
			overflow : hidden;
			white-space : nowrap;
			word-wrap:normal;
		}
		
		#law_modal_tbl td {
			letter-spacing: 0px !important;
		}
		
		
	</style>	
	
				
	<div id="rpt_issue_modal" title="항목 선택" style="font-size: 15px;display:none;" align="center">
		<br/>
		<div class="tableStyle2" style="width: 400px;">
			<table id="law_modal_tbl">
				
				<tr>
					<td>
						<input type="text"  id="txt_reparation_liability_reason" style="width: 100%;" />
					</td>
				</tr>
				
				
				<c:set var="brCnt" value="1" />
				<c:set var="trCnt" value="0" />				
				<c:forEach items="${itemList}" var="item" varStatus="status">
					<c:if test="${status.first or trCnt == 1}">
						<c:set var="trCnt" value="0"/>			
						<tr>
							<td style="text-align: left;padding-left: 25px;background: #FFF;">					
					</c:if>
					
					<input type="checkbox" id="liailiby_law_${item.col_cd1}_${item.col_cd2}" name="liailiby_law" value="${item.col_val}" /> 
					<label for="liailiby_law_${item.col_cd1}_${item.col_cd2}"> ${item.col_val}</label>&nbsp;
					
					<c:if test="${brCnt == 3}">
						<br/>
						<c:set var="brCnt" value="0"/>
					</c:if>
						
					<c:if test="${item.col_cd1 != itemList[status.count].col_cd1}">

						<c:set var="brCnt" value="0"/>			
						<c:set var="trCnt" value="1"/>			
								
					</c:if>
					
					<c:set var="brCnt" value="${brCnt + 1}"/>
				
				</c:forEach>
				
			
			</table>
		</div>
	</div>
	<input type="hidden" id="tempVal"/>
	
	<script>
		$(document).ready(function (){
			$("input:checkbox[name='liailiby_law']").click(function(){
				var txtVal = "";
				var chkCnt = 0;
				//alert('test='+this.value);				
				/* 기존의 체크된 내역을 다시 확인해서 문자열로 만드는 방식 */
				/* $("input:checkbox[name='liailiby_law']").each(function() {					
			    	if(this.checked){//checked 처리된 항목의 값			    		
						if (chkCnt == 0){
							txtVal = this.value;
							chkCnt = 1;
						}else{
							txtVal += ", "+this.value;
						}			    		
					}					
				}); */
				
				//임시저장된 값을 가져온다.
				var sTemp = $("#tempVal").val();
				
				//임시저장된 값에 체크값이 없는 경우				
				if( sTemp.indexOf(this.value) < 0 ){					
					if( sTemp == "" ){
						sTemp = this.value;
					}else{
						sTemp += ","+this.value;
					}
					$("#tempVal").val(sTemp);
					txtVal = $("#tempVal").val();						
				}else{						//값이 있는경우 uncheck 인 경우 String 을 배열로 변환한다.					
					var sVal = this.value;					
					var bRet =sTemp.split(",");					
					bRet.splice(bRet.indexOf(sVal),1);
					txtVal = bRet.join(",");
				}				
				$("#tempVal").val(txtVal);		//임시저장소에도 Set 한다.
				$("#txt_reparation_liability_reason").val(txtVal);
				
			});
		});
	
	
		function fnOpenLawModal(){
			$("#rpt_issue_modal").dialog({
				height: 400,
				width: 480,
				closeOnEscape : true,
				draggable : false,
				// appendTo : "#vacationActionFrm",
				// title: "휴가 신청",
				buttons:{
					"적용" : function(){
						var txtVal = $("#txt_reparation_liability_reason").val();
						
						$("#reparation_liability_reason").val(txtVal);
						$(this).dialog("close");
					},
					"취소" : function(){
						$(this).dialog("close");
					}
				},
				modal: true,
				overlay:{ opacity: 0., background: '#000000'}
			});
	    	
		}	
	
	</script>
