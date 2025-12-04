<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
			     <div id="div_compensation_response_view">               
	        <div class="display-table" style="margin-top: 50px;">
	            <div class="display-cell">
	                <p class="subtitle">4. 보상책임 등 검토</p>
	            </div>
		        <div class="display-cell text-right">
	              	<a id="btn_compensation_edit" href="#noloc" onclick="fnCompensationEdit();"><img src='./resources/ne_img/btn_edite.gif'></a>
	          	</div>
	        </div>
        	<table>
        		<colgroup>
        			<col width="25%">
        			<col width="75%">
        		</colgroup>	
        		<tr>
        			<th colspan="2">가. 피보험자의 보상책임</th>
        		</tr>
	     		<tr>
	     			<td>면  /  부  책</td>
	     			<td>
	     				${reportOtherWorkerList.size()}명 중
	     				${workerType2}명 면책 / ${workerType1}명 부책 
     				</td>
	     		</tr>
	     		<tr>
	     			<td>판  단  근  거</td>
	     			<td>
	     			 본 건 사고는 재해근로자 (${reportBscInfo.beneficiaryNm}) 가 해외현장 근무 중 ${reportPrint30.disease}외 질병 및 상해사고가 발현하여 요양후 청구한 사고로,<br />
	     			 재해근로자의 상병명은 업무기인성 및 업무수행성이 인정되지 않는 점, 공제기간내에 발생된 점, 본 공제약관상   <br />
	     			 비업무상재해확장담보 추가 특별약관상 보상하지 않는 손해에 해당되지 아니한 점등을 근거로 판단해 볼 때,	<br />
	     			 보험금 지급에 대한 보상 책임이 있는 것으로 사료되어 지급하고자 합니다.
 	     			<c:if test="${workerType2 != 0}">
		     			<div id="ischeck">
			     			그러나, 피보험자
			     			<c:forEach var="item" items="${reportOtherWorkerList}" varStatus="status" >
				     			<c:if test="${item.workerType == 2}">
				     			 	${item.workerName} 
				     			</c:if>
			     			</c:forEach>
		     			 	의 경우 해외근로자재해공제 보통약관 제2관 제3조 보상하는 손해 규정 중<br />
			     			<c:if test="${reportPrint30.rewardedDamageType == 1}">
			     				<span style="color:red;">① 조합은 피공제자의 근로자에게 생긴 업무상의 재해로 인하여 피공제자가 부담하는 손해를 이 약관 및 특별약관의 규정에 따라 보상하여 드립니다.</span>
			     			</c:if>
							<c:if test="${reportPrint30.rewardedDamageType == 2}">
			     				<span style="color:red;">② 조합은 재해의 원인이 된 사실이 공제기간 중에 생긴 경우에 한하여 보상하여 드립니다.</span>
			     			</c:if>
			     			에 해당되지 않은 손해, <br />즉 
			     			
			     			<c:if test="${reportPrint30.unrewardedDamageType ==1}">
								가입전 질병
			     			</c:if>
							<c:if test="${reportPrint30.unrewardedDamageType == 2}">
								중독, 마취, 만취 등으로 생긴 손해
			     			</c:if>			     			
							<c:if test="${reportPrint30.unrewardedDamageType == 3}">
			     				과격한 운동이나 위험한 오락(스카이다이빙, 스쿠버다이빙, 행글라이딩, 자동차경주 등)으로 인하여 생긴 손해
			     			</c:if>			     			
							<c:if test="${reportPrint30.unrewardedDamageType == 4}">
			     				자해, 자살, 자살미수 및 이와 유사한 행위로 인하여 생긴 손해
			     			</c:if>			     			
							<c:if test="${reportPrint30.unrewardedDamageType == 5}">
			     				한국 표준질병 사인분류에 아래와 같이 분류된 질병 및 이로 인하여 생긴 손해
			     			</c:if>			     			
							<c:if test="${reportPrint30.unrewardedDamageType == 6}">
			     				매독, 임질, AIDS, 기타 이와 유사한 질병 및 이로 인하여 생긴 손해
			     			</c:if>			     			
							<c:if test="${reportPrint30.unrewardedDamageType == 7}">
			     				시력감퇴 등 생리적 노화 또는 약화 및 이로 인하여 생긴 손해
			     			</c:if>			     			
							<c:if test="${reportPrint30.unrewardedDamageType == 8}">
			     				치아에 관련된 질병 및 이로 인하여 생긴 손해
			     			</c:if>			     			
							<c:if test="${reportPrint30.unrewardedDamageType == 9}">
			     				군인이 아닌자로서 군사작전을 수행하거나 군사훈련을 받는 중에 생긴 손해
			     			</c:if>	
			     			
			     			<c:if test="${reportPrint30.standardDisease == 1}">(악성 신생물)</c:if>
			     			<c:if test="${reportPrint30.standardDisease == 2}">(당뇨병)</c:if>
			     			<c:if test="${reportPrint30.standardDisease == 3}">(만성 류마티스성 심질환)</c:if>
			     			<c:if test="${reportPrint30.standardDisease == 4}">(고혈압성 질환)</c:if>
			     			<c:if test="${reportPrint30.standardDisease == 5}">(허혈성 심질환)</c:if>
			     			<c:if test="${reportPrint30.standardDisease == 6}">(기타형의 심 질환)</c:if>
			     			<c:if test="${reportPrint30.standardDisease == 7}">(뇌혈관 질환)</c:if>
			     			
			     			에 해당되어 보험금 지급 책임이 없습니다.
		     			</div>
	     			</c:if>     			  
	     			</td>
	     		</tr>
	     		<tr>
	     			<td>관련법규</td>
	     			<td>비업무상재해확장담보 추가특별약관</td>
	     		</tr>	     		
       			 </table>
			</div>
			<div id="div_compensation_response_edit" style="display: none;">               
		        <div class="display-table" style="margin-top: 50px;">
		            <div class="display-cell">
		                <p class="subtitle">4. 보상책임 등 검토</p>
		            </div>
		        <div class="display-cell text-right">
	              	<a id="btn_compensation_save" href="#noloc" onclick="fnCompensationSave();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
	              	<a id="btn_compensation_close" href="#noloc" onclick="fnCompensationClose();"><img src='./resources/ne_img/btn/btn_close.gif'></a>
	          	</div>
		        </div>
	        	<table>
	        		<colgroup>
	        			<col width="25%">
	        			<col width="75%">
	        		</colgroup>	
	        		<tr>
	        			<th colspan="2">가. 피보험자의 보상책임</th>
	        		</tr>
		     		<tr>
		     			<td>면  /  부  책</td>
		     			<td>${reportOtherWorkerList.size()}명 중 ${countType2.cnt}명 면책 / ${countType1.cnt}명 부책</td>
		     		</tr>
		     		<tr>
		     			<td>질병</td>
		     			<td><input type="text" id="disease" maxlength="40" value="${reportPrint30.disease}"></td>
		     		</tr>
		     		
		     		<c:if test="${workerType2 != 0}">
		     		<tr>
		     			<td>면책자</td>
		     			<td>
		       				<select id="rewarded_dmg_type" onchange="">
		       					<option value="1" <c:if test="${reportPrint30.rewardedDamageType == 1}">selected="selected"</c:if>>조합은 피공제자의 근로자에게 생긴 업무상의 재해로 인하여 피공제자가 부담하는 손해를 이 약관 및 특별약관의 규정에 따라 보상하여 드립니다</option>
								<option value="2" <c:if test="${reportPrint30.rewardedDamageType == 2}">selected="selected"</c:if>>조합은 재해의 원인이 된 사실이 공제기간 중에 생긴 경우에 한하여 보상하여 드립니다</option>
		       				</select><br />에 해당되지 않은 손해, 즉 <br />
		       				<select id="unrewarded_dmg_type" onchange="fnShowUnrewardType(this);">
		       					<option value="1" <c:if test="${reportPrint30.unrewardedDamageType == 1}">selected="selected"</c:if>>가입전 질병</option>
		       					<option value="2" <c:if test="${reportPrint30.unrewardedDamageType == 2}">selected="selected"</c:if>>중독, 마취, 만취 등으로 생긴 손해</option>
								<option value="3" <c:if test="${reportPrint30.unrewardedDamageType == 3}">selected="selected"</c:if>>과격한 운동이나 위험한 오락(스카이다이빙, 스쿠버다이빙, 행글라이딩, 자동차경주 등)으로 인하여 생긴 손해</option>
								<option value="4" <c:if test="${reportPrint30.unrewardedDamageType == 4}">selected="selected"</c:if>>자해, 자살, 자살미수 및 이와 유사한 행위로 인하여 생긴 손해</option>
								<option value="5" <c:if test="${reportPrint30.unrewardedDamageType == 5}">selected="selected"</c:if>>한국 표준질병 사인분류에 아래와 같이 분류된 질병 및 이로 인하여 생긴 손해</option>
								<option value="6" <c:if test="${reportPrint30.unrewardedDamageType == 6}">selected="selected"</c:if>>매독, 임질, AIDS, 기타 이와 유사한 질병 및 이로 인하여 생긴 손해</option>
								<option value="7" <c:if test="${reportPrint30.unrewardedDamageType == 7}">selected="selected"</c:if>>시력감퇴 등 생리적 노화 또는 약화 및 이로 인하여 생긴 손해</option>
								<option value="8" <c:if test="${reportPrint30.unrewardedDamageType == 8}">selected="selected"</c:if>>치아에 관련된 질병 및 이로 인하여 생긴 손해</option>
								<option value="9" <c:if test="${reportPrint30.unrewardedDamageType == 9}">selected="selected"</c:if>>군인이 아닌자로서 군사작전을 수행하거나 군사훈련을 받는 중에 생긴 손해</option>
		       				</select>	
		       				<c:if test="${reportPrint30.unrewardedDamageType == 5}">
			       				<select id="standard_disease">
			       					<option value="1" <c:if test="${reportPrint30.standardDisease == 1}">selected="selected"</c:if>>악성 신생물</option>
			       					<option value="2" <c:if test="${reportPrint30.standardDisease == 2}">selected="selected"</c:if>>당뇨병</option>
			       					<option value="3" <c:if test="${reportPrint30.standardDisease == 3}">selected="selected"</c:if>>만성 류마티스성 심질환</option>
			       					<option value="4" <c:if test="${reportPrint30.standardDisease == 4}">selected="selected"</c:if>>고혈압성 질환</option>
			       					<option value="5" <c:if test="${reportPrint30.standardDisease == 5}">selected="selected"</c:if>>허혈성 심질환</option>
			       					<option value="6" <c:if test="${reportPrint30.standardDisease == 6}">selected="selected"</c:if>>기타형의 심질환</option>
			       					<option value="7" <c:if test="${reportPrint30.standardDisease == 7}">selected="selected"</c:if>>뇌혈관 질환</option>
			       				</select>
		       				</c:if>
		       					<select id="standard_disease" style="display: none;">
			       					<option value="1" <c:if test="${reportPrint30.standardDisease == 1}">selected="selected"</c:if>>악성 신생물</option>
			       					<option value="2" <c:if test="${reportPrint30.standardDisease == 2}">selected="selected"</c:if>>당뇨병</option>
			       					<option value="3" <c:if test="${reportPrint30.standardDisease == 3}">selected="selected"</c:if>>만성 류마티스성 심질환</option>
			       					<option value="4" <c:if test="${reportPrint30.standardDisease == 4}">selected="selected"</c:if>>고혈압성 질환</option>
			       					<option value="5" <c:if test="${reportPrint30.standardDisease == 5}">selected="selected"</c:if>>허혈성 심질환</option>
			       					<option value="6" <c:if test="${reportPrint30.standardDisease == 6}">selected="selected"</c:if>>기타형의 심질환</option>
			       					<option value="7" <c:if test="${reportPrint30.standardDisease == 7}">selected="selected"</c:if>>뇌혈관 질환</option>
			       				</select>
		       				에 해당되어 보험금 지급 책임이 없습니다.
		     			</td>
		     		</tr>
		     		</c:if>
		     		<tr>
		     			<td>관련법규</td>
		     			<td>비업무상재해확장담보 추가특별약관</td>
		     		</tr>	     		
	       		</table>
			</div>			