<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

						<c:forEach items="${print_1_6_1}" var="passTableVo" varStatus="passTableStatus">
							<tr id='passTableTr${passTableStatus.index}'>
								<td class='td'>
									<p align='center'>
										<span class="passTableSpan" id="passTableDateSpan${passTableStatus.index}">
											${passTableVo.investigateToDate}
											<c:if test="${passTableVo.investigateFromDate ne NULL and passTableVo.investigateFromDate ne ''}">
												<br/>~
												${passTableVo.investigateFromDate}
											</c:if>
											<c:if test="${passTableVo.investigateDateDtl ne NULL and passTableVo.investigateDateDtl ne ''}">
												<br/>
												(${passTableVo.investigateDateDtl})
											</c:if>
										</span>
										<span class='passTableInputSpan' id="passTalbeDateInputSpan${passTableStatus.index}" style="display: none;">
											<input type='text' class='passTableDateTxt' id='passTableToDateTxt${passTableStatus.index}' maxlength='10' value='${passTableVo.investigateToDate}' />
											<br/>~ &nbsp;
											<input type='text' class='passTableDateTxt' id='passTableFromDateTxt${passTableStatus.index}' maxlength='10' value='${passTableVo.investigateFromDate}' style='margin-top:5px;'/>
											<br/><br/>
											<input type="radio" name="passTableGubun" onclick="fnPassTableGubun(1,${passTableStatus.index})" value = "1"/> 입원
											<input type="radio" name="passTableGubun" onclick="fnPassTableGubun(2,${passTableStatus.index})" value = "2"/> 통원
											<br/>
											<input type="text" id="passTableGubunTxt${passTableStatus.index}" value="${passTableVo.investigateDateDtl}" style="width:100px;"/>
										</span>
									</p>
								</td>
								
								<td class='td'>
									<p align='left'>
										<span class="passTableSpan" id="passTableDtlSpan${passTableStatus.index}">
											${passTableVo.investigateDtl}
										</span>
										<textarea class='passTableTxtArea' id='passTableDtlTxtArea${passTableStatus.index}' style='display:none;width:318px;'
								  				   onfocus='javascript:fnAutoSize(this.scrollHeight,this);'
						   	 	  				   onKeyUP='javascript:fnAutoSize(this.scrollHeight,this);'
						 		  				   onKeyDown='javascript:fnAutoSize(this.scrollHeight,this);'>${passTableVo.investigateDtl}</textarea>
									</p>
								</td>
								
								<td class='td'>
									<p align='center'>	
										<span class="passTableSpan" id="passTableNoteSpan${passTableStatus.index}">
											${passTableVo.investigateOutline}
										</span>		
										<input class='passTableTxt' type='text' id='passTableNoteTxt${passTableStatus.index}' value='${passTableVo.investigateOutline}' style='display:none;width:108px;'/>
									</p>	
								</td>
								
								<td class='td'>
									<p align='center'>
										<span class='passTableSpan' id='ModBtnPassTableSpan${passTableStatus.index}' >
											<img src='./resources/ls_img/btn_edit_s.gif' onclick='javascript:passTableModifyView(${passTableStatus.index});' style='cursor:pointer;'/>
											<img src='./resources/ls_img/btn_del_s.gif' onclick="javascript:passTableDelete(${passTableVo.serialNo})" style='cursor:pointer;'/>
										</span>
										<span class='passTableSpan' id='ModAftSaveBtnPassTableSpan${passTableStatus.index}' style='display:none;'>			
											<img src='./resources/ne_img/btn/btn_save.gif' onclick="javascript:passTableUpdate(${passTableStatus.index},${passTableVo.serialNo})" style='cursor:pointer;'/>
											<br/><img src='./resources/ne_img/btn/btn_close.gif' onclick="javascript:passTableModifyClose(${passTableStatus.index})" style='cursor:pointer;margin-top:5px;'/>
										</span>
									</p>
								</td>
							</tr>
						</c:forEach>