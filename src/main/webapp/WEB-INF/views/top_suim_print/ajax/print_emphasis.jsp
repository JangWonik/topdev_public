<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<script>
$(document).ready(function() {
	//조사결과 옵션1
    fnOption1Close();
    
  	//조사결과 옵션2
    fnOption2Close();
  	
  	//조사결과 옵션3
    fnOption3Close();
  	
  //조사결과 옵션4
    fnOption4Close();
			
  	//조사결과 옵션5
    fnOption5Close();
});
</script>
<table>
    <colgroup>
        <col width="25%">
        <col width="66%">
        <col width="9%">
    </colgroup>
    <tr id="tr_emphasis_invest_view" style="height: 204px;">
        <th>중점<br/>조사사항</th>
        <td style="vertical-align: top;">
            ${fn:replace(fn:replace(fn:escapeXml(reportPrint1.inspectPoint4) , CRLF , '<br>'), ' ', '&nbsp;')}
        </td>
        <td><a id="btn_emphasis_invest_edit" href="#noloc" onclick="fnEmphasisInvestEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a></td>
    </tr>
    <tr id="tr_emphasis_invest_edit" style="display: none">
        <th>중점<br/>조사사항</th>
        <td>
            <select id="select_emphasis_invest" style="margin-bottom: 5px;" onchange="fnEmphasisInvestChange(this);" >
                <option value="">직접입력</option>
                <c:forEach  var="item" items="${reportPointCodeList}" varStatus="status">
                    <option value="${item.colVal}">${item.colVal}</option>
                </c:forEach>
            </select>
            <textarea id="textarea_emphasis_invest" style="height: 150px;">${reportPrint1.inspectPoint4}</textarea>
        </td>
        <td>
            <a id="btn_emphasis_invest_save" href="#noloc" onclick="fnEmphasisInvestSave();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
            <a id="btn_emphasis_invest_close" href="#noloc" onclick="fnEmphasisInvestClose();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
        </td>
    </tr>
    <!-- 조사결과 포멧 수정 시작 by top3009 -->
           	<tr>
            		<th rowspan="5">
            			조사결과
            		</th>
            		<td>
            			<b>ㅁ 담보여부</b><br/>
            			<textarea id="result_option1" style="display:none;height: 80px;"></textarea>
            			<span id="result_option1_view"></span>
            		</td>
            		<td>
            			<a id="option_1_modify" href="#noloc" onclick="fnOption1Modify();"><img src="./resources/ls_img/btn_edite.gif" /></a>
            			<a id="option_1_save" href="#noloc" onclick="fnOption1Save();" style="display:none;"><img src="./resources/ne_img/btn/btn_save.gif" /></a>
            			<a id="option_1_close" href="#noloc" onclick="fnOption1Close();" style="display:none;"><img src="./resources/ne_img/btn/btn_close.gif" style="margin-top: 5px;"/></a>
            		</td>               		
            	</tr>
            	<tr>
            		<td>
            			<textarea id="result_option2" style="display:none;height: 120px;"></textarea>
            			<span id="result_option2_view"></span>
            		</td>
            		<td>
            			<a id="option_2_modify" href="#noloc" onclick="fnOption2Modify();"><img src="./resources/ls_img/btn_edite.gif" /></a>
            			<a id="option_2_save" href="#noloc" onclick="fnOption2Save();" style="display:none;"><img src="./resources/ne_img/btn/btn_save.gif" /></a>
            			<a id="option_2_close" href="#noloc" onclick="fnOption2Close();" style="display:none;"><img src="./resources/ne_img/btn/btn_close.gif" style="margin-top: 5px;"/></a>
            		</td>
            	</tr>
            	
            	<tr>
            		<td>
            			<div id="option3_radio" style="display:none;">
            				<table style="background-color:#ECECEC;">
            					<tr>
            						<td>
            							<input type="radio" name="option3_radio_type"  id="option3_radio_type1" value="1"> 본 보험 가입(OOOO.OO.OO) 이전 동일 진단 및 인과관계 있는 병명으로 치료한 사실이 없음 
            						</td>               						
            					</tr>
            					<tr>
            						<td>
            							<input type="radio" name="option3_radio_type" id="option3_radio_type2" value="2"> 보험가입 전인 동일 진단 병명인 OOO으로 OOOO년 OO월 OO일 ~ OOOO년 OO월 OO일 까지 OO병원에서 OOOO 한 사실이 확인됨
            						</td>
            					</tr>
            				</table>               				
            			</div>
            			<textarea id="result_option3" style="display:none;height: 120px;"></textarea>
            			<span id="result_option3_view"></span>
            		</td>
            		<td>
            			<a id="option_3_modify" href="#noloc" onclick="fnOption3Modify();"><img src="./resources/ls_img/btn_edite.gif" /></a>
            			<a id="option_3_save" href="#noloc" onclick="fnOption3Save();" style="display:none;"><img src="./resources/ne_img/btn/btn_save.gif" /></a>
            			<a id="option_3_close" href="#noloc" onclick="fnOption3Close();" style="display:none;"><img src="./resources/ne_img/btn/btn_close.gif" style="margin-top: 5px;"/></a>
            		</td>
            	</tr>
            	
            	<tr>
            		<td>
            			<textarea id="result_option4" style="display:none;height: 120px;"></textarea>
            			<span id="result_option4_view"></span>
            		</td>
            		<td>
            			<a id="option_4_modify" href="#noloc" onclick="fnOption4Modify();"><img src="./resources/ls_img/btn_edite.gif" /></a>
            			<a id="option_4_save" href="#noloc" onclick="fnOption4Save();" style="display:none;"><img src="./resources/ne_img/btn/btn_save.gif" /></a>
            			<a id="option_4_close" href="#noloc" onclick="fnOption4Close();" style="display:none;"><img src="./resources/ne_img/btn/btn_close.gif" style="margin-top: 5px;"/></a>
            		</td>
            	</tr>
            	
            	<tr>
            		<td>
            			<b>ㅁ 고지의무 위반여부</b><br/>
            			<div id="option5_radio" style="display:none;">
            				<table style="background-color:#ECECEC;">
            					<tr>
            						<td>
            							<input type="radio" name="option5_radio_type"  id="option5_radio_type1" value="1"> 재척기간 경과건으로 해당사항 없음 
            						</td>               						
            					</tr>
            					<tr>
            						<td>
            							<input type="radio" name="option5_radio_type" id="option5_radio_type2" value="2"> 계약전 알릴의무 위반사항 확인되지 않음
            						</td>
            					</tr>
            					<tr>
            						<td>
            							<input type="radio" name="option5_radio_type" id="option5_radio_type3" value="3"> 피보험자는 본 보험 가입(OOOO.OO.OO) 이전인 OOOO년 OO월 OO일 OO병원에서 OO병명으로 OOOO년 OO월 OO일 부터 OOOO년 OO월 OO일까지 OOOO OOO OOO 한 사실이 확인 됨
            						</td>
            					</tr>
            					<tr>
            						<td>
            							<input type="radio" name="option5_radio_type" id="option5_radio_type4" value="4"> 피보험자는 본 보험 가입(OOOO.OO.OO) 당시 OOOO 로 직업 고지하였으며, 확인 결과 OOOO으로 확인됨 
            						</td>
            					</tr>
            					<tr>
            						<td>
            							<input type="radio" name="option5_radio_type" id="option5_radio_type5" value="5"> 직접입력
            						</td>
            					</tr>
            				</table>               				
            			</div>
            			<textarea id="result_option5" style="display:none;height: 120px;"></textarea>
            			<span id="result_option5_view"></span>
            		</td>
            		<td>
            			<a id="option_5_modify" href="#noloc" onclick="fnOption5Modify();"><img src="./resources/ls_img/btn_edite.gif" /></a>
            			<a id="option_5_save" href="#noloc" onclick="fnOption5Save();" style="display:none;"><img src="./resources/ne_img/btn/btn_save.gif" /></a>
            			<a id="option_5_close" href="#noloc" onclick="fnOption5Close();" style="display:none;"><img src="./resources/ne_img/btn/btn_close.gif" style="margin-top: 5px;"/></a>
            		</td>
            	</tr>             	
              <!-- 조사결과 포멧 수정 끝 by top3009 -->
    
    <%-- <tr id="tr_emphasis_result_view" style="height: 204px;">
        <th>조사결과</th>
        <td style="vertical-align: top;">
            ${fn:replace(fn:replace(fn:escapeXml(reportPrint1.inspectResult4) , CRLF , '<br>'), ' ', '&nbsp;')}
        </td>
        <td><a id="btn_emphasis_result_edit" href="#noloc" onclick="fnEmphasisResultEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a></td>
    </tr>
    <tr id="tr_emphasis_result_edit" style="display: none">
        <th>조사결과</th>
        <td>
            <select id="select_emphasis_result" style="margin-bottom: 5px;" onchange="fnEmphasisResultChange(this);">
                <option value="">직접입력</option>
                <c:forEach  var="item" items="${reportResultCodeList}" varStatus="status">
                    <option value="${item.colVal}">${item.colVal}</option>
                </c:forEach>
            </select>
            <textarea id="textarea_emphasis_result" style="height: 150px;">${reportPrint1.inspectResult4}</textarea>
        </td>
        <td>
            <a id="btn_emphasis_result_save" href="#noloc" onclick="fnEmphasisResultSave();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
            <a id="btn_emphasis_result_close" href="#noloc" onclick="fnEmphasisResultClose();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
        </td>
    </tr> --%>
</table>