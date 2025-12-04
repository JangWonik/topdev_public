<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

	<input type="hidden" id="assureSize" value="${print_1_assure.size()}"/><!-- 이벤트 발생용 구분값 -->
	<table>
		<colgroup>
			<col width='149'></col>
			<col width='150'></col>
			<col width='150'></col>
			<col width='50'></col>
		</colgroup>
		<tr>
			<td class='td' align='center' bgcolor='#ECECEC' style='border-top:0px; border-left:0px;'>담보사항</td>
			<td class='td' align='center' bgcolor='#ECECEC' style='border-top:0px;'>가입금액</td>
			<td class='td' align='center' bgcolor='#ECECEC' style='border-top:0px;'>추정손해액</td>
			<td class='td' align='center' bgcolor='#ECECEC' style='border-top:0px;' >
				<!-- 추가버튼 -->
				<img src='./resources/ls_img/ls_body/btn_add.gif' title='추가' id="assureAddBtn" onclick='javascript:assureAddView();' style='cursor:pointer;' />
			</td>
		</tr>
		<tbody id='assureTbody'>
			<c:forEach items='${print_1_assure}' var='assureVo' varStatus='assureStatus'>
				<tr id='assureTr${assureStatus.index}' index='${assureStatus.index}'>
					<td class='td' align='center' style='border-left: 0px;'>
						<span class='assureSpan' id='dtlAssureSpan${assureStatus.index}'>${assureVo.assureDtl}</span>
						<input type='text' class='assureTxt' id='dtlAssureTxt${assureStatus.index}' value='${assureVo.assureDtl}' style='width:120px;display:none;'/>				
					</td>
				
					<!-- 가입금액 -->
					<td class='td' align='center'>
						<span class= 'assureSpan' id='joinAmountAssureSpan${assureStatus.index}'><fmt:formatNumber value='${assureVo.joinAmount}' pattern='###,###,##0.##'/> 원</span>
	<%-- 												<input type='text' class='assureTxt' id='joinAmountAssureTxt${assureStatus.index}' value='${assureVo.joinAmount}' /> --%>
						<input  type='text' class='assureTxt' name='joinAmountAssureTxt' id='joinAmountAssureTxt${assureStatus.index}'
								value='<fmt:formatNumber value='${assureVo.joinAmount}' pattern='###,###,##0.##'/>' style='width:120px;display:none;IME-MODE: disabled;'
								ONKEYDOWN='javascript:onlyNumberFunc2(this);' ONKEYUP='javascript:numberCommaFunc(this);plusInvVal();'/>
					</td>
				
					<!-- 추정손해액 -->
					<td class='td' align='center'>
						<span class= 'assureSpan' id='estimationAmoutAssureSpan${assureStatus.index}'><fmt:formatNumber value='${assureVo.estimationAmount}' pattern='###,###,##0.##'/> 원</span>
	<%-- 												<input type='text' class='assureTxt' id='estimationAmoutAssureTxt${assureStatus.index}' value='${assureVo.estimationAmount}' style='width:120px;display:none;'/> --%>
						<input  type='text' class='assureTxt' name='estimationAmoutAssureTxt' id='estimationAmoutAssureTxt${assureStatus.index}'
								value='<fmt:formatNumber value='${assureVo.estimationAmount}' pattern='###,###,##0.##'/>' style='width:120px;display:none;IME-MODE: disabled;'
								ONKEYDOWN='javascript:onlyNumberFunc2(this);' ONKEYUP='javascript:numberCommaFunc(this);plusInvVal();'/>				
					</td>
				
					<td class='td' align='center'>										
						<span class='assureSpan' id='ModBtnAssureSpan${assureStatus.index}'>
							<img src='./resources/ls_img/btn_edit_s.gif' class='assureModBtn' onclick='javascript:assureModifyView(${assureStatus.index});' style='cursor:pointer;'/>
							 <img src='./resources/ls_img/btn_del_s.gif' class='assureDelBtn' onclick='javascript:assureDelete(${assureVo.serialNo})' style='cursor:pointer;'/>
						</span>
						
						<span class='assureSpan' id='ModAftSaveBtnAssureSpan${assureStatus.index}' style='display:none;'>			
							<img src='./resources/ne_img/btn/btn_save.gif' class='assureModSaveBtn' onclick='javascript:assureUpdate(${assureStatus.index},${assureVo.serialNo});' id='assureModSaveBtn${assureStatus.index}' serialNo='${assureVo.serialNo}' index='${assureStatus.index}' style='cursor:pointer;'/>
							<br/><img src='./resources/ne_img/btn/btn_close.gif' class='assureModCloseBtn' onclick='javascript:assureModifyClose(${assureStatus.index});'  style='cursor:pointer;margin-top:5px;'/>
						</span>					
						
					</td>

				</tr>
				<c:set var='joinAmountSum' value='${assureVo.joinAmount + joinAmountSum}'/>
				<c:set var='estimationAmoutSum' value='${assureVo.estimationAmount + estimationAmoutSum}'/>
			</c:forEach>
		</tbody>
	
		<tr>
			<td class='td' align='center' bgcolor='#ECECEC' style='border-left: 0px;'>합계</td>
			<td class='td' align='center'>
				<span class= 'claimSpan' id='joinAmountSumSpan'>
					<c:choose>
						<c:when test="${joinAmountSum ne 0 and joinAmountSum ne ''}">
							<fmt:formatNumber value='${joinAmountSum}' pattern='###,###,##0.##'/> 원
						</c:when>
						<c:otherwise>
							-												
						</c:otherwise>
					</c:choose>
				</span>
			</td>
			<td class='td' align='center'>
				<span class= 'claimSpan' id='estimationAmoutSum'>
					<c:choose>
						<c:when test="${estimationAmoutSum ne 0 and estimationAmoutSum ne ''}">
							<fmt:formatNumber value='${estimationAmoutSum}' pattern='###,###,##0.##'/> 원
						</c:when>
						<c:otherwise>
							-												
						</c:otherwise>
					</c:choose>
				</span>	
			</td>
			<td class='td' align='center'>
				-
			</td>
		</tr>			
	</table>
