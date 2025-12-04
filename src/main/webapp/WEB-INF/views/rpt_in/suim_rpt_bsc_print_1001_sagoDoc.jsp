<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
						<c:forEach items="${print1_8}" var="print1_8" varStatus="print1_8Status">
							<tr id="sagoDocTr${print1_8Status.index}">
								<td class='td'>
									<p align='center'>
										<span class='sagoDocSpan' id='sagoDocOrderSpan${print1_8Status.index}'>${print1_8Status.count}</span>
<%-- 									<input class='sagoTxt' type='text' id='sagoOrderTxt${print1_8Status}' value='${print1_8Status.count}' style='width:29px;'/> --%>
									</p>
								</td>
								
								<td class='td'>
									<p>
										<span class='sagoDocSpan' id='sagoDocNmSpan${print1_8Status.index}'>${print1_8.attachName}</span>
										<input class='sagoDocTxt' type='text' id='sagoDocNmTxt${print1_8Status.index}' value='${print1_8.attachName}' style='width:219px;display:none;' />
									</p>
								</td>
								
								<td class='td'>
									<p align='center'>
										<span class='sagoDocSpan' id='sagoDocCntSpan${print1_8Status.index}'>${print1_8.attachCopy}</span>
										<input class='sagoDocTxt' type='text' id='sagoDocCntTxt${print1_8Status.index}' value='${print1_8.attachCopy}' style='width:29px;display:none;'/>
									</p>
								</td>
								
								<td class='td'>
									<p>
										<span class='sagoDocSpan' id='sagoDocNoteSpan${print1_8Status.index}'>${print1_8.attachEtcMemo}</span>
										<span class='sagoDocInputSpan' id='sagoDocNoteInputSpan${print1_8Status.index}' style="display:none;">
		  									<select id='sagoDocNoteSelect${print1_8Status.index}' onchange='javascript:fnSelectPick(this,3,${print1_8Status.index});' style='width:229px;' >
		  									</select>	
											<input class='sagoDocTxt' type='text' id='sagoDocNoteTxt${print1_8Status.index}' value='${print1_8.attachEtcMemo}' style='width:229px;display:none;'/>
										</span>
									</p>
								</td>
								
								<td class='td'>
									<p align='center'>
										<span class='sagoDocSpan' id='ModBtnSagoDocSpan${print1_8Status.index}'>
											<img src='./resources/ls_img/btn_edit_s.gif' class='SagoDocModBtn' onclick="sagoDocModifyView('${print1_8Status.index}')"   id='SagoDocModViewBtn${print1_8Status.index}' serialNo='${print1_8.serialNo}' style='cursor:pointer;'/>
											<img src='./resources/ls_img/btn_del_s.gif' class='SagoDocDelBtn' onclick="sagoDocDelete('${print1_8.serialNo}')" id='SagoDocDelBtn${print1_8Status.index}' index='${print1_8Status.count}' serialNo='${print1_8.serialNo}' style='cursor:pointer;'/>
										</span>
							
										<span class='sagoDocSpan' id='ModAftSaveBtnSagoDocSpan${print1_8Status.index}' style='display:none;'>
											<img src='./resources/ne_img/btn/btn_save.gif' class='SagoModSaveBtn' onclick="sagoDocUpdate('${print1_8Status.index}','${print1_8.serialNo}')" id='SagoDocModSaveBtn${print1_8Status.index}'style='cursor:pointer;'/>
											<br/><img src='./resources/ne_img/btn/btn_close.gif' class='SagoModCloseBtn' onclick="sagoDocModifyClose('${print1_8Status.index}')" id='SagoDocModCloseBtn${print1_8Status.index}' style='cursor:pointer;margin-top:5px;'/>
										</span>
									</p>
								</td>
							<tr>
						</c:forEach>
						
						
						
						