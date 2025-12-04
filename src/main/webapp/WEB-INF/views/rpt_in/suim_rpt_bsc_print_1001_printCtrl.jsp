<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
						<c:forEach items="${print_1_ctrl}" var="printCtrlVo" varStatus="printCtrlStatus">
							<tr id='printCtrlTr${printCtrlStatus.index}'>
								<td class='td'>
									<p align='center'>
										<span class="printCtrlSpan" id="printCtrlDateSpan${printCtrlStatus.index}">${printCtrlVo.controlDate}</span>
										<span class="printCtrlInputSpan" id="printCtrlDateInputSpan${printCtrlStatus.index}" style="display:none;">
											<input type='text' class='printCtrlTxt' id='printCtrlDateTxt${printCtrlStatus.index}' maxlength='10' value='${printCtrlVo.controlDate}' style='width:90px; font-size:15px;'/>
										</span>
										
									</p>
								</td>
								<td class='td'>
									<p align='center'>
										<span class="printCtrlSpan" id="printCtrlSubjectSpan${printCtrlStatus.index}">${printCtrlVo.controlSubject}</span>
										<span class="printCtrlInputSpan" id="printCtrlSubjectInputSpan${printCtrlStatus.index}" style="display:none;">
		  									<select id='printCtrlSubjectSelect${printCtrlStatus.index}' onchange='javascript:fnSelectPick(this,1,${printCtrlStatus.index});' style='width:180px;' >
		  									</select>
											<input type='text' class='printCtrlTxt' id='printCtrlSubjectTxt${printCtrlStatus.index}' maxlength='10' value='${printCtrlVo.controlSubject}' style='width:180px;display:none;' />								
										</span>
									</p>
								</td>
							
								<td class='td'>
									<p align='center'>
										<span class="printCtrlSpan" id="printCtrlMemoSpan${printCtrlStatus.index}" >${printCtrlVo.controlMemo}</span>
										<span class="printCtrlInputSpan" id="printCtrlMemoInputSpan${printCtrlStatus.index}" style="display:none;">
		  									<select id='printCtrlMemoSelect${printCtrlStatus.index}' onchange='javascript:fnSelectPick(this,2,${printCtrlStatus.index});' style='width:180px;' >
		  									</select>				
											<input class='printCtrlTxt' type='text' id='printCtrlMemoTxt${printCtrlStatus.index}' value='${printCtrlVo.controlMemo}' style='width:180px;display:none;' />
										</span>
									</p>		
								</td>						
							
								<td class="td">
									<p align="center">
										<span class='passTableSpan' id='ModBtnPrintCtrlSpan${printCtrlStatus.index}' >
											<img src='./resources/ls_img/btn_edit_s.gif' onclick='javascript:printCtrlModifyView(${printCtrlStatus.index},"${printCtrlVo.controlSubject}","${printCtrlVo.controlMemo}");' style='cursor:pointer;'/>
											<img src='./resources/ls_img/btn_del_s.gif' onclick="javascript:printCtrlDelete(${printCtrlVo.serialNo},'1001')" style='cursor:pointer;'/>
										</span>
										<span class='passTableSpan' id='ModAftSaveBtnPrintCtrlSpan${printCtrlStatus.index}' style='display:none;'>			
											<img src='./resources/ne_img/btn/btn_save.gif' onclick="javascript:printCtrlUpdate(${printCtrlStatus.index},${printCtrlVo.serialNo},'1001')" style='cursor:pointer;'/>
											<br/><img src='./resources/ne_img/btn/btn_close.gif' onclick="javascript:printCtrlModifyClose(${printCtrlStatus.index})" style='cursor:pointer;margin-top:5px;'/>
										</span>
									</p>
								</td>
							</tr>
						</c:forEach>