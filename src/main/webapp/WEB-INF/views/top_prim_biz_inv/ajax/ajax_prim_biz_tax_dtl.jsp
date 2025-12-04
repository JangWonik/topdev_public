<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
</head>
<script>
	$(document).ready(function(){		
		_initCalendar();
		
		
		$("input:radio[name=tax_edit_kind]").click(function(){
			var chkVal = $("input:radio[name=tax_edit_kind]:checked").val();			
			//작업 진행상태 갱신
			
			var suim_rpt_no = $("#suim_rpt_no").val();
			
			var param = {};
            param.suim_rpt_no = suim_rpt_no;
            param.tax_edit_end = 	chkVal;
            
            var url = "./invPrimTaxUpdateWork";
            //var url = "./invTaxUpdateWork";

            $.ajax({
                type: "POST",
                url: url,
                data: param,
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                dataType: "html",
                traditional: true,						//배열허용
                timeout: 20000,
                success: function(data){
                	if( data ){		//1인 경우 성공
                		if( chkVal == 1 ){
                			alert("작업완료로 변경되었습니다.");
                		}else{
                			alert("작업중으로 변경되었습니다.");
                		}
                		opener.location.reload();
                		window.close();
                	}                	
                }                
            });			
		});
	});
	
	function _initCalendar(){    	 
  		$('.calendar').datepicker({
  			showOn: 'button',
  			buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
  			buttonImageOnly: true,
  			buttonText: "달력", 
  			changeMonth: true,
  			changeYear: true,	    	   
  			showButtonPanel: false,
  			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
  			dayNamesMin: ['일','월','화','수','목','금','토'],
  			dateFormat: 'yy-mm-dd',
  			firstDay: 0,
  			isRTL: false,
  			showMonthAfterYear: true
  	    }); 		
  		
  	}
	
</script>
<c:if test="${ cont_edit_type eq 'view' }">
<div class= "tableStyle22">
	<table id="table_tax_view">
		<tr>
			<th width="25%">발행일자</th>
			<th width="25%">발행금액</th>			
			<th width="25%">입금일자</th>
			<th width="25%">입금금액</th>					
		</tr>
		<c:choose>
			<c:when test="${taxList.size() == 0}">
				<tr>
					<td colspan="5" style="text-align:center;">등록된 세금계산서 정보가 없습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${taxList}" var="item" varStatus="status">
					<tr>						
						<td align="center">${item.publish_date_fmt}</td>
						<td style="text-align: right;padding-right:5px;">
							<c:choose>
								<c:when test="${item.publish_amount < 0}"><font color="red"><fmt:formatNumber value="${item.publish_amount}" pattern="#,###" /> 원</font></c:when>
								<c:otherwise><fmt:formatNumber value="${item.publish_amount}" pattern="#,###" /> 원</c:otherwise>
							</c:choose>							
						</td>
						<td align="center">${item.deposit_date_fmt}</td>
						<td style="text-align: right;padding-right:5px;">
							<c:choose>
								<c:when test="${item.deposit_amount < 0}"><font color="red"><fmt:formatNumber value="${item.deposit_amount}" pattern="#,###" /> 원</font></c:when>
								<c:otherwise><fmt:formatNumber value="${item.deposit_amount}" pattern="#,###" /> 원</c:otherwise>
							</c:choose>							
						</td>												
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>						
	</table>
</div>
</c:if>

<form name="taxEditForm" id="taxEditForm" method="post">
<input type="hidden" id="suim_rpt_no" name="suim_rpt_no" value="${suim_rpt_no}" />
<input type="hidden" id="taxListSize" name="taxListSize" value="${taxList.size()}">
<c:if test="${ cont_edit_type eq 'edit' }">
	<div class= "tableStyle22">
		<table id="table_tax_edit">
			<tr name="tax_tr">
				<th width="25%">발행일자</th>
				<th width="20%">발행금액</th>			
				<th width="25%">입금일자</th>
				<th width="20%">입금금액</th>			
				<th width="10%"><img src="./resources/ls_img/btn_add_s.gif" onclick="fnTaxform_add();" style="cursor:pointer"/></th>		
			</tr>
			<c:choose>
				<c:when test="${taxList.size() == 0}">
					<tr>								
						<td align="center"><input type="text" class="calendar" id="publish_date" name="publish_date"  style="width: 50%;"/></td>
						<td style="text-align: right;padding-right:5px;">
							<!-- <input type="text" class="money" id="publish_amount" name="publish_amount" value="0" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"> 원 -->
							<input type="text" id="publish_amount" name="publish_amount" value="0" class="amt" ONKEYUP="javascript:numberCommaFunc(this);" style="text-align:right;padding-right:5px;IME-MODE: disabled;" class="amt" /> 원
						</td>						
						<td align="center"><input type="text" class="calendar" id="deposit_date" name="deposit_date"  style="width: 50%;"/></td>
						<td style="text-align: right;padding-right:5px;">
							<!-- <input type="text" class="money" id="deposit_amount" name="deposit_amount" value="0" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"> 원 -->
							<input type="text" id="deposit_amount" name="deposit_amount" value="0" class="amt" ONKEYUP="javascript:numberCommaFunc(this);" style="text-align:right;padding-right:5px;IME-MODE: disabled;" class="amt" /> 원
							</td>
						<td></td>						
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${taxList}" var="item" varStatus="status">
						<tr>						
							<td align="center"><input type="text" class="calendar" id="publish_date" name="publish_date"  style="width: 50%;" value="${item.publish_date_fmt}"/></td>
							<td style="text-align: right;padding-right:5px;">
								<%-- <input type="text" class="money" id="publish_amount" name="publish_amount" value="${item.publish_amount}" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"> 원 --%>
								<input type="text" id="publish_amount" name="publish_amount" value='<fmt:formatNumber value="${item.publish_amount}" pattern="###,###,##0.##"/>' class="amt" ONKEYUP="javascript:numberCommaFunc(this);" style="text-align:right;padding-right:5px;IME-MODE: disabled;" class="amt" /> 원
							</td>
							<td align="center"><input type="text" class="calendar" id="deposit_date" name="deposit_date"  style="width: 50%;" value="${item.deposit_date_fmt}"/></td>
							<td style="text-align: right;padding-right:5px;">
								<%-- <input type="text" class="money" id="deposit_amount" name="deposit_amount" value="${item.deposit_amount}" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"> 원 --%>
								<input type="text" id="deposit_amount" name="deposit_amount" value='<fmt:formatNumber value="${item.deposit_amount}" pattern="###,###,##0.##"/>' class="amt" ONKEYUP="javascript:numberCommaFunc(this);" style="text-align:right;padding-right:5px;IME-MODE: disabled;" class="amt" /> 원
							</td>
							<td align="center"><img src="./resources/ls_img/btn_del_s.gif" border="0" style="cursor:pointer" onclick="fnTaxForm_del_data(${item.tax_no})"/></td>						
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>						
		</table>
	</div>
</c:if>
</form>

<div class="display-table" style="margin-top: 10px;">
	<div class= "tableStyle22">
		<table id="table_tax_sum">
			<tr>
				<th>계산서 합계</th>
				<th>일치여부</th>
				<th>입금 합계</th>
				<th>미수잔액</th>
			</tr>
			<tr>
				<c:choose>
					<c:when test="${chk_tax eq 'O'}">
						<td style="text-align:right;padding-right:10px;"><font color="blue"><fmt:formatNumber value="${sum_tax}" pattern="#,###" /> 원</font></td>
						<td align="center"><font color="blue">${chk_tax}</font></td>
					</c:when>
					<c:otherwise>
						<td style="text-align:right;padding-right:10px;"><font color="red"><fmt:formatNumber value="${sum_tax}" pattern="#,###" /> 원</font></td>
						<td align="center"><font color="red">${chk_tax}</font></td>						
					</c:otherwise>
				</c:choose>				
				<td style="text-align:right;padding-right:10px;"><fmt:formatNumber value="${sum_deposit}" pattern="#,###" /> 원</td>
				<td style="text-align:right;padding-right:10px;"><fmt:formatNumber value="${sum_outpay}" pattern="#,###" /> 원</td>
			</tr>		
		</table>		
	</div>
	<div style="padding-top:10px;padding-bottom:10px;text-align:left;">※ 기존 인보이스 합계금액과 계산서 발행 합계금액이 일치 시<font color="blue">(청색)</font>, 불일치 시 <font color="red">(적색)</font>으로 표시 됩니다.</div>
	<div class= "tableStyle22">
		<table id="table_tax_sum">
			<tr>
				<th width="50%">작업 진행 상태</th>				
				<td width="25%" align="center">
					<input type="radio" name="tax_edit_kind" id="tax_edit_work" value="0" <c:if test="${tax_edit_end eq 0}"> checked </c:if>/> 작업 중 					
				</td>
				<td width="25%" align="center">
					<input type="radio" name="tax_edit_kind" id="tax_edit_end" value="1" <c:if test="${tax_edit_end eq 1}"> checked </c:if>/>	작업 완료 
				</td>
			</tr>					
		</table>		
	</div>
</div>