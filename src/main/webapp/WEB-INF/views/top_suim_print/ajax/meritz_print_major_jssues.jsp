<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
	       		<!-- 사고내용 -->
	       		<section class="major_issues_sub">
	       			<div class="issues_sub_head">
		       			<div class="issues_title">
		       				사고내용
		       				<span>
		       					ex) 피보험자, 목격자, 근로복지공단, 경찰서 등 구분
	       					</span>
		       			</div>
		       			<div class="issues_use_at">
			                <input type="radio" value="1" name="accident" onclick="fnRadioUseAt(this);"  <c:if test="${rptBasic.accidentDtlUseAt == 1}">checked="checked"</c:if>> <label for="">사용</label>
			                <input type="radio" value="0" name="accident" onclick="fnRadioUseAt(this);"  <c:if test="${rptBasic.accidentDtlUseAt == 0}">checked="checked"</c:if>> <label for="">미사용</label>
		       			</div>
	       			</div>
	       			
		            <c:choose>
		                <c:when test="${rptBasic.accidentDtlUseAt == 1}">
		                    <c:set var="issues_view_use_at_accident" value=""/>
		                </c:when>
		                <c:otherwise>
		                    <c:set var="issues_view_use_at_accident" value="display: none;"/>
		                </c:otherwise>
	       			</c:choose>
	       			<div class="issues_sub_body_view" id="issues_view_accident" style="${issues_view_use_at_accident}"> 
		                <div class="display-cell">
		                	<c:if test="${rptBasic.accidentDtlSub ne '' and rptBasic.accidentDtlSub != null}"> ${rptBasic.accidentDtlSub} 확인 결과, <br/></c:if>
		                    ${fn:replace(fn:replace(rptBasic.accidentDtl6 , CRLF , '<br>'), ' ', '&nbsp;')}
		                </div>
		                <div class="display-cell text-center">
							<a href="#noloc" onclick="fnMajorIssueEdit('accident');"><img src='./resources/ls_img/btn_edite.gif'></a>
		                </div>
	       			</div>
	       			
	       			<div class="issues_sub_body_edit" id="issues_edit_accident" style="display: none;">
	       				<div class="display-cell">
							<c:forEach items="${issuesAccidentCode}" var="iaList" varStatus="iaStatus">
								<input type="button" onclick="fnSetIssuesSubTxt(this,'accident')" value="${iaList.colVal}" />
							</c:forEach>
							<br/>
							<input type="text" id="issues_txt_sub_accident" value="${rptBasic.accidentDtlSub}" style="width:380px;"/>	확인 결과,
	       					<textarea id="issues_txt_accident" rows="8">${fn:replace(fn:replace(rptBasic.accidentDtl6,'<br>', CRLF), '&nbsp;', ' ')}</textarea>
	       				</div>
		                <div class="display-cell text-center">
		                    <a href="#noloc" onclick="fnMajorIssueUpdate('accident')"><img src='./resources/ne_img/btn/btn_save.gif'></a>
		                    <a href="#noloc" onclick="fnMajorIssueClose('accident');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
		                </div>
	       			</div>
	       		</section>       		
       		
       		
	       		<!-- 고지의무 -->
	       		<section class="major_issues_sub">
	       			<div class="issues_sub_head">
		       			<div class="issues_title">
		       				고지의무
		       			</div>
		       			<div class="issues_use_at">
			                <input type="radio" value="1" name="notice1" onclick="fnRadioUseAt(this);"  <c:if test="${rptBasic.noticeDuty1UseAt == 1}">checked="checked"</c:if>> <label for="">사용</label>
			                <input type="radio" value="0" name="notice1" onclick="fnRadioUseAt(this);"  <c:if test="${rptBasic.noticeDuty1UseAt == 0}">checked="checked"</c:if>> <label for="">미사용</label>
		       			</div>
	       			</div>
	       			
		            <c:choose>
		                <c:when test="${rptBasic.noticeDuty1UseAt == 1}">
		                    <c:set var="issues_view_use_at_notice1" value=""/>
		                </c:when>
		                <c:otherwise>
		                    <c:set var="issues_view_use_at_notice1" value="display: none;"/>
		                </c:otherwise>
	       			</c:choose>
	       			<div class="issues_sub_body_view" id="issues_view_notice1" style="${issues_view_use_at_notice1}"> 
		                <div class="display-cell">
		                    ${fn:replace(fn:replace(rptBasic.noticeDuty16 , CRLF , '<br>'), ' ', '&nbsp;')}
		                </div>
		                <div class="display-cell text-center">
							<a href="#noloc" onclick="fnMajorIssueEdit('notice1');"><img src='./resources/ls_img/btn_edite.gif'></a>
		                </div>
	       			</div>
	       			<div class="issues_sub_body_edit" id="issues_edit_notice1" style="display: none;">
	       				<div class="display-cell">
	       					<textarea id="issues_txt_notice1" rows="8">${fn:replace(fn:replace(rptBasic.noticeDuty16,'<br>', CRLF), '&nbsp;', ' ')}</textarea>
	       				</div>
		                <div class="display-cell text-center">
		                    <a href="#noloc" onclick="fnMajorIssueUpdate('notice1')"><img src='./resources/ne_img/btn/btn_save.gif'></a>
		                    <a href="#noloc" onclick="fnMajorIssueClose('notice1');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
		                </div>
	       			</div>
	       		</section>

	       		<!-- 통지의무 -->
	       		<section class="major_issues_sub">
	       			<div class="issues_sub_head">
		       			<div class="issues_title">
		       				통지의무
		       			</div>
		       			<div class="issues_use_at">
			                <input type="radio" value="1" name="notice2" onclick="fnRadioUseAt(this);"  <c:if test="${rptBasic.noticeDuty2UseAt == 1}">checked="checked"</c:if>> <label for="">사용</label>
			                <input type="radio" value="0" name="notice2" onclick="fnRadioUseAt(this);"  <c:if test="${rptBasic.noticeDuty2UseAt == 0}">checked="checked"</c:if>> <label for="">미사용</label>
		       			</div>
	       			</div>
	       			
		            <c:choose>
		                <c:when test="${rptBasic.noticeDuty2UseAt == 1}">
		                    <c:set var="issues_view_use_at_notice2" value=""/>
		                </c:when>
		                <c:otherwise>
		                    <c:set var="issues_view_use_at_notice2" value="display: none;"/>
		                </c:otherwise>
	       			</c:choose>
	       			<div class="issues_sub_body_view" id="issues_view_notice2" style="${issues_view_use_at_notice2}"> 
		                <div class="display-cell">
		                    ${fn:replace(fn:replace(rptBasic.noticeDuty26 , CRLF , '<br>'), ' ', '&nbsp;')}
		                </div>
		                <div class="display-cell text-center">
							<a href="#noloc" onclick="fnMajorIssueEdit('notice2');"><img src='./resources/ls_img/btn_edite.gif'></a>
		                </div>
	       			</div>
	       			<div class="issues_sub_body_edit" id="issues_edit_notice2" style="display: none;">
	       				<div class="display-cell">
	       					<textarea id="issues_txt_notice2" rows="8">${fn:replace(fn:replace(rptBasic.noticeDuty26,'<br>', CRLF), '&nbsp;', ' ')}</textarea>
	       				</div>
		                <div class="display-cell text-center">
		                    <a href="#noloc" onclick="fnMajorIssueUpdate('notice2')"><img src='./resources/ne_img/btn/btn_save.gif'></a>
		                    <a href="#noloc" onclick="fnMajorIssueClose('notice2');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
		                </div>
	       			</div>
	       		</section>	       		

	       		<!-- 직업급수 -->
	       		<section class="major_issues_sub">
	       			<div class="issues_sub_head">
		       			<div class="issues_title">
		       				직업급수(확인)
							<span>
								ex) 피보험자, 회사 등 관계인, 근로복지공단 등 구분 
							</span>		       				
		       			</div>
		       			<div class="issues_use_at">
			                <input type="radio" value="1" name="job" onclick="fnRadioUseAt(this);"  <c:if test="${rptBasic.jobGradeConfirmUseAt == 1}">checked="checked"</c:if>> <label for="">사용</label>
			                <input type="radio" value="0" name="job" onclick="fnRadioUseAt(this);"  <c:if test="${rptBasic.jobGradeConfirmUseAt == 0}">checked="checked"</c:if>> <label for="">미사용</label>
		       			</div>
	       			</div>
		            <c:choose>
		                <c:when test="${rptBasic.jobGradeConfirmUseAt == 1}">
		                    <c:set var="issues_view_use_at_job" value=""/>
		                </c:when>
		                <c:otherwise>
		                    <c:set var="issues_view_use_at_job" value="display: none;"/>
		                </c:otherwise>
	       			</c:choose>
	       			<div class="issues_sub_body_view" id="issues_view_job" style="${issues_view_use_at_job}"> 
		                <div class="display-cell">
		                	<c:if test="${rptBasic.jobGradeConfirmSub ne '' and rptBasic.jobGradeConfirmSub != null}"> ${rptBasic.jobGradeConfirmSub} 확인 결과, <br/></c:if>
		                    ${fn:replace(fn:replace(rptBasic.jobGradeConfirm6 , CRLF , '<br>'), ' ', '&nbsp;')}
		                </div>
		                <div class="display-cell text-center">
							<a href="#noloc" onclick="fnMajorIssueEdit('job');"><img src='./resources/ls_img/btn_edite.gif'></a>
		                </div>
	       			</div>
	       			
	       			<div class="issues_sub_body_edit" id="issues_edit_job" style="display: none;">
	       				<div class="display-cell">
							<c:forEach items="${issuesjobCode}" var="ijList" varStatus="ijStatus">
								<input type="button" onclick="fnSetIssuesSubTxt(this,'job')" value="${ijList.colVal}" />
							</c:forEach>
							<br/>
							<input type="text" id="issues_txt_sub_job" value="${rptBasic.jobGradeConfirmSub}" style="width:380px;"/>	확인 결과,
	       					<textarea id="issues_txt_job" rows="8">${fn:replace(fn:replace(rptBasic.jobGradeConfirm6,'<br>', CRLF), '&nbsp;', ' ')}</textarea>
	       				</div>
		                <div class="display-cell text-center">
		                    <a href="#noloc" onclick="fnMajorIssueUpdate('job')"><img src='./resources/ne_img/btn/btn_save.gif'></a>
		                    <a href="#noloc" onclick="fnMajorIssueClose('job');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
		                </div>
	       			</div>
	       		</section>  
	       		
	       		
	       		<!-- 의료자문 -->
	       		<section class="major_issues_sub">
	       			<div class="issues_sub_head">
		       			<div class="issues_title">
		       				의료자문
		       			</div>
		       			<div class="issues_use_at">
			                <input type="radio" value="1" name="medical" onclick="fnRadioUseAt(this);"  <c:if test="${rptBasic.counselMedicalUseAt == 1}">checked="checked"</c:if>> <label for="">사용</label>
			                <input type="radio" value="0" name="medical" onclick="fnRadioUseAt(this);"  <c:if test="${rptBasic.counselMedicalUseAt == 0}">checked="checked"</c:if>> <label for="">미사용</label>
		       			</div>
	       			</div>
	       			
		            <c:choose>
		                <c:when test="${rptBasic.counselMedicalUseAt == 1}">
		                    <c:set var="issues_view_use_at_medical" value=""/>
		                </c:when>
		                <c:otherwise>
		                    <c:set var="issues_view_use_at_medical" value="display: none;"/>
		                </c:otherwise>
	       			</c:choose>
	       			<div class="issues_sub_body_view" id="issues_view_medical" style="${issues_view_use_at_medical}"> 
		                <div class="display-cell">
		                    ${fn:replace(fn:replace(rptBasic.counselMedical6 , CRLF , '<br>'), ' ', '&nbsp;')}
		                </div>
		                <div class="display-cell text-center">
							<a href="#noloc" onclick="fnMajorIssueEdit('medical');"><img src='./resources/ls_img/btn_edite.gif'></a>
		                </div>
	       			</div>
	       			<div class="issues_sub_body_edit" id="issues_edit_medical" style="display: none;">
	       				<div class="display-cell">
	       					<textarea id="issues_txt_medical" rows="8">${fn:replace(fn:replace(rptBasic.counselMedical6,'<br>', CRLF), '&nbsp;', ' ')}</textarea>
	       				</div>
		                <div class="display-cell text-center">
		                    <a href="#noloc" onclick="fnMajorIssueUpdate('medical')"><img src='./resources/ne_img/btn/btn_save.gif'></a>
		                    <a href="#noloc" onclick="fnMajorIssueClose('medical');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
		                </div>
	       			</div>
	       		</section>		       		     		


	       		<!-- 법률자문 -->
	       		<section class="major_issues_sub">
	       			<div class="issues_sub_head">
		       			<div class="issues_title">
		       				법률자문
		       			</div>
		       			<div class="issues_use_at">
			                <input type="radio" value="1" name="legal" onclick="fnRadioUseAt(this);"  <c:if test="${rptBasic.counselLegalUseAt == 1}">checked="checked"</c:if>> <label for="">사용</label>
			                <input type="radio" value="0" name="legal" onclick="fnRadioUseAt(this);"  <c:if test="${rptBasic.counselLegalUseAt == 0}">checked="checked"</c:if>> <label for="">미사용</label>
		       			</div>
	       			</div>
	       			
		            <c:choose>
		                <c:when test="${rptBasic.counselLegalUseAt == 1}">
		                    <c:set var="issues_view_use_at_legal" value=""/>
		                </c:when>
		                <c:otherwise>
		                    <c:set var="issues_view_use_at_legal" value="display: none;"/>
		                </c:otherwise>
	       			</c:choose>
	       			<div class="issues_sub_body_view" id="issues_view_legal" style="${issues_view_use_at_legal}"> 
		                <div class="display-cell">
		                    ${fn:replace(fn:replace(rptBasic.counselLegal6 , CRLF , '<br>'), ' ', '&nbsp;')}
		                </div>
		                <div class="display-cell text-center">
							<a href="#noloc" onclick="fnMajorIssueEdit('legal');"><img src='./resources/ls_img/btn_edite.gif'></a>
		                </div>
	       			</div>
	       			<div class="issues_sub_body_edit" id="issues_edit_legal" style="display: none;">
	       				<div class="display-cell">
	       					<textarea id="issues_txt_legal" rows="8">${fn:replace(fn:replace(rptBasic.counselLegal6,'<br>', CRLF), '&nbsp;', ' ')}</textarea>
	       				</div>
		                <div class="display-cell text-center">
		                    <a href="#noloc" onclick="fnMajorIssueUpdate('legal')"><img src='./resources/ne_img/btn/btn_save.gif'></a>
		                    <a href="#noloc" onclick="fnMajorIssueClose('legal');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
		                </div>
	       			</div>
	       		</section>
	       		
	       		<!-- 관공서 확인내용 -->
	       		<section class="major_issues_sub">
	       			<div class="issues_sub_head">
		       			<div class="issues_title">
		       				관공서확인내용 (경찰서 등)
		       			</div>
		       			<div class="issues_use_at">
			                <input type="radio" value="1" name="public" onclick="fnRadioUseAt(this);"  <c:if test="${rptBasic.confirmPublicUseAt == 1}">checked="checked"</c:if>> <label for="">사용</label>
			                <input type="radio" value="0" name="public" onclick="fnRadioUseAt(this);"  <c:if test="${rptBasic.confirmPublicUseAt == 0}">checked="checked"</c:if>> <label for="">미사용</label>
		       			</div>
	       			</div>
	       			
		            <c:choose>
		                <c:when test="${rptBasic.confirmPublicUseAt == 1}">
		                    <c:set var="issues_view_use_at_public" value=""/>
		                </c:when>
		                <c:otherwise>
		                    <c:set var="issues_view_use_at_public" value="display: none;"/>
		                </c:otherwise>
	       			</c:choose>
	       			<div class="issues_sub_body_view" id="issues_view_public" style="${issues_view_use_at_public}"> 
		                <div class="display-cell">
		                    ${fn:replace(fn:replace(rptBasic.confirmPublic6 , CRLF , '<br>'), ' ', '&nbsp;')}
		                </div>
		                <div class="display-cell text-center">
							<a href="#noloc" onclick="fnMajorIssueEdit('public');"><img src='./resources/ls_img/btn_edite.gif'></a>
		                </div>
	       			</div>
	       			<div class="issues_sub_body_edit" id="issues_edit_public" style="display: none;">
	       				<div class="display-cell">
	       					<textarea id="issues_txt_public" rows="8">${fn:replace(fn:replace(rptBasic.confirmPublic6,'<br>', CRLF), '&nbsp;', ' ')}</textarea>
	       				</div>
		                <div class="display-cell text-center">
		                    <a href="#noloc" onclick="fnMajorIssueUpdate('public')"><img src='./resources/ne_img/btn/btn_save.gif'></a>
		                    <a href="#noloc" onclick="fnMajorIssueClose('public');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
		                </div>
	       			</div>
	       		</section>	     

	       		<!-- 관공서 확인내용 -->
	       		<section class="major_issues_sub">
	       			<div class="issues_sub_head">
		       			<div class="issues_title">
		       				장해율/장해상태 확인
							<br/>		       				
		       				<span>
								ex) 문답 과정에서 확인한 피보험자 장해상태 기술 (촬영한 사진은 보고서 뒤 별첨으로 첨부)		       				
		       				</span>
		       			</div>
		       			<div class="issues_use_at">
			                <input type="radio" value="1" name="disability" onclick="fnRadioUseAt(this);"  <c:if test="${rptBasic.disabilityUseAt == 1}">checked="checked"</c:if>> <label for="">사용</label>
			                <input type="radio" value="0" name="disability" onclick="fnRadioUseAt(this);"  <c:if test="${rptBasic.disabilityUseAt == 0}">checked="checked"</c:if>> <label for="">미사용</label>
		       			</div>
	       			</div>
	       			
		            <c:choose>
		                <c:when test="${rptBasic.disabilityUseAt == 1}">
		                    <c:set var="issues_view_use_at_disability" value=""/>
		                </c:when>
		                <c:otherwise>
		                    <c:set var="issues_view_use_at_disability" value="display: none;"/>
		                </c:otherwise>
	       			</c:choose>
	       			<div class="issues_sub_body_view" id="issues_view_disability" style="${issues_view_use_at_disability}"> 
		                <div class="display-cell">
		                    ${fn:replace(fn:replace(rptBasic.disability6 , CRLF , '<br>'), ' ', '&nbsp;')}
		                </div>
		                <div class="display-cell text-center">
							<a href="#noloc" onclick="fnMajorIssueEdit('disability');"><img src='./resources/ls_img/btn_edite.gif'></a>
		                </div>
	       			</div>
	       			<div class="issues_sub_body_edit" id="issues_edit_disability" style="display: none;">
	       				<div class="display-cell">
	       					<textarea id="issues_txt_disability" rows="8">${fn:replace(fn:replace(rptBasic.disability6,'<br>', CRLF), '&nbsp;', ' ')}</textarea>
	       				</div>
		                <div class="display-cell text-center">
		                    <a href="#noloc" onclick="fnMajorIssueUpdate('disability')"><img src='./resources/ne_img/btn/btn_save.gif'></a>
		                    <a href="#noloc" onclick="fnMajorIssueClose('disability');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
		                </div>
	       			</div>
	       		</section>	 
	       				      		