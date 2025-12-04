<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

	<c:forEach items="${print_1_2}" var="otherInsu" varStatus="otherInsuStatus">
		<tr id="otherInsuTr${otherInsuStatus.index}">
			<td class="td">
				<p align="center">
					<span class='otherInsuSpan' id='InsuComSpan${otherInsuStatus.index}'>${otherInsu.otherInsuCom}</span>
					<input class='otherInsuTxt' type='text' id='InsuComTxt${otherInsuStatus.index}' value='${otherInsu.otherInsuCom}' style='width:75px;display:none;'/>
				</p>
			</td>

			<td class="td">
				<p align="center">
					<span class='otherInsuSpan' id='InsuContSpan${otherInsuStatus.index}'>${otherInsu.otherInsuContract}</span>
					<input class='otherInsuTxt' type='text' id='InsuContTxt${otherInsuStatus.index}' value='${otherInsu.otherInsuContract}' style='width:115px;display:none;'/>
				</p>
			</td>
			
			<td class="td">
				<p align="center">
					<span class='otherInsuSpan' id='InsuDtlSpan${otherInsuStatus.index}'>${otherInsu.otherInsuDtl}</span>
					<input class='otherInsuTxt' type='text' id='InsuDtlTxt${otherInsuStatus.index}' value='${otherInsu.otherInsuDtl}' style='width:325px;display:none;'/>
				</p>
			</td>
			
			<td class="td">
				<p align="center">
					<span class='OtherInsuSpan' id='ModBtnOtherInsuSpan${otherInsuStatus.index}' >
						<img src='./resources/ls_img/btn_edit_s.gif' onclick='javascript:otherInsuModifyView(${otherInsuStatus.index});' style='cursor:pointer;'/>
						<img src='./resources/ls_img/btn_del_s.gif' onclick="javascript:otherInsuDelete(${otherInsu.serialNo})" style='cursor:pointer;'/>
					</span>
					<span class='OtherInsuSpan' id='ModAftSaveBtnOtherInsuSpan${otherInsuStatus.index}' style='display:none;'>			
						<img src='./resources/ne_img/btn/btn_save.gif' onclick="javascript:otherInsuUpdate(${otherInsuStatus.index},${otherInsu.serialNo})" style='cursor:pointer;'/>
						<br/><img src='./resources/ne_img/btn/btn_close.gif' onclick="javascript:otherInsuModifyClose(${otherInsuStatus.index})" style='cursor:pointer;margin-top:5px;'/>
					</span>
				</p>
			</td>
		</tr>
	</c:forEach>
