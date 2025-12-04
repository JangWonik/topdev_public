<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
	<c:forEach items="${print_1_detail}" var="etcDtlChk" varStatus="etcDtlChkStatus">
		<c:if test="${etcDtlChk.detailGubun eq 99}">
			<tr id='${etcDtlChkStatus.index}DtlChkTr1'><td>&nbsp;</td></tr>
	  				
			<tr id='${etcDtlChkStatus.index}DtlChkTr2' class='td' bgcolor='#ECECEC'>
				<td style='font-size:16px;font-weight:bold;padding:10px;' colspan='2'>
					<span id="${etcDtlChkStatus.index}DtlTitleSpan">
						${etcDtlChk.detailTitle}			
					</span>
					<input type='text' class='dtlTitleTxt' id='${etcDtlChkStatus.index}DtlTitleTxt' style="display:none;" value="${etcDtlChk.detailTitle}"/>
				</td>
			</tr>
			
			<tr id='${etcDtlChkStatus.index}DtlChkTr3'>
				<td class='td' colspan='2' style='padding: 0px;'>
					<table cellpadding='0' cellspacing='0' >
						<colgroup>
							<col width='100'></col>
							<col width='490'></col>
							<col width='50'></col>
						</colgroup>

						<tr>
							<td colspan='2' style='padding: 5px;'>
								<span id="${etcDtlChkStatus.index}ViewSpan">${etcDtlChk.detailContent}</span>
								<span id='${etcDtlChkStatus.index}InputSpan' style="display:none;">
									<textarea class='dtlTxtArea' id='${etcDtlChkStatus.index}DtlTxtArea' style='width:575px;'
									  		  onfocus='javascript:fnAutoSize(this.scrollHeight,this);' 
											  onKeyUP='javascript:fnAutoSize(this.scrollHeight,this);'
											  onKeyDown='javascript:fnAutoSize(this.scrollHeight,this);'>${etcDtlChk.detailContent}</textarea>
								</span>
							</td>
			
							<td align='center'>
							
								<p align="center">
									<span class='etcDtlChkSpan' id='ModBtnEtcDtlChkSpan${etcDtlChkStatus.index}' >
										<img src='./resources/ls_img/btn_edit_s.gif' onclick='javascript:etcDtlChkModifyView(${etcDtlChkStatus.index});' style='cursor:pointer;'/>
										<img src='./resources/ls_img/btn_del_s.gif' onclick="javascript:etcDtlChkDelete(${etcDtlChk.serialNo})" style='cursor:pointer;'/>
									</span>
									<span class='etcDtlChkSpan' id='ModAftSaveBtnEtcDtlChkSpan${etcDtlChkStatus.index}' style='display:none;'>			
										<img src='./resources/ne_img/btn/btn_save.gif' onclick="javascript:etcDtlChkUpdate(${etcDtlChkStatus.index},${etcDtlChk.serialNo})" style='cursor:pointer;'/>
										<br/><img src='./resources/ne_img/btn/btn_close.gif' onclick="javascript:etcDtlChkModifyClose(${etcDtlChkStatus.index})" style='cursor:pointer;margin-top:5px;'/>
									</span>
								</p>
							</td>
			
						</tr>
					</table>
				</td>
			</tr>
		</c:if>
	</c:forEach>

	
