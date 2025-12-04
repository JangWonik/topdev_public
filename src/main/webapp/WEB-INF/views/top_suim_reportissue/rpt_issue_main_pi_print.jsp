<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge;text/html; charset=UTF-8">
    <title>손해사정서 교부</title>
    <style>
        /*기본태그 정의*/
        html, body{padding:0;margin:0;}
        /* 모바일 가로모드 폰트확대 방지 */
        body{-webkit-text-size-adjust:none;}
        body,table {font-size:10pt;font-family:'굴림','굴림체','돋움','Nanum Gothic', 'verdana'; color:#000;}
        /* 마진과 패딩의 초기화 */
        body, div, p, th, td, textarea {margin:0;padding:0;}
        .reportWrap {width: 100%;}
        .reportContent {
            position: relative;
            /*background-color: #3e8f3e;*/
            width: 640px;
            margin: auto;
        }

        .text-left {text-align: left;}
        .text-right {text-align: right;}
        .text-center {text-align: center;}

        .display-table{
            width: 100%;
            display: table;
            table-layout: fixed;
        }

        .display-cell{
            display: table-cell;
            vertical-align: middle;
            float: none;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }
        tr {height: 42px;}
        th {
            background-color: #ECECEC;
            font-weight: bold;
            text-align: center;
            vertical-align: middle;
            padding: 4px 2px 4px 2px;
        }
        td {
            font-weight: normal;
            padding: 4px 5px 4px 5px;
            letter-spacing: -1px;
            line-height:20px;
            text-align: left;
            vertical-align: middle;
        }

/*         table, th, td { */
/*             border: 1px solid black; */
/*         } */

        table.approval  th {background-color: #FFF3F3;}
        table.approval  td {text-align: center;}
        table.approval  tr {height: 69px;}
        table.approval  tr:first-child {height: 42px;}
        table.center    td {text-align: center}



        p {line-height: 150%;}
        p.title {font-weight: bold; margin: 10px 10px 8px 0px;}
        p.subtitle {font-weight: bold; margin: 10px 10px 8px 0px; font-size: 11pt !important;}
        .panel-title {font-weight: bold;}

		.reportContent tr {height: 35px;}
		.reportContent th {padding: 8px 0px 4px 20px; border: 0px solid; background-color: #FFF; text-align: left; vertical-align: top; font-weight: normal;}
		.reportContent td {border: 0px solid; vertical-align: top; text-align: left;}

#table_issue_contract_view th {padding: 4px 0px 4px 0px; border: 1px solid; background-color: #E7ECF1; text-align: center; vertical-align:middle; font-weight: normal; border-bottom: 1px double;}
#table_issue_contract_view td {border: 1px solid; text-align: center; vertical-align: middle;}
#table_accident_view th {padding: 4px 0px 4px 0px; border: 1px solid; background-color: #E7ECF1; text-align: center; vertical-align:middle; font-weight: normal; border-bottom: 1px double;}
#table_accident_view td {border: 1px solid; text-align: center; vertical-align: middle;}
        /*.reportContent table {width: 100%; border-spacing: 0px;}*/
        /*.reportContent tr {height: 42px;}*/
        /*.reportContent th {background-color: #ECECEC; border: 1px solid; font-weight: bold; padding: 4px 0px 4px 0px; text-align: center; vertical-align: middle}*/
        /*.reportContent td {border: 1px solid; font-weight: normal; padding: 4px 5px 4px 5px; letter-spacing: -1px; line-height:20px; text-align: left; vertical-align: middle}*/
    </style>
   	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js?v=201706141814"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/jquery/jquery.mask.min.js"></script>

	<%--spiner start--%>
    <script src="/resources/jquery/spin.js"></script>
    <script src="/resources/jquery/jquery.spin.js"></script>
    <%--spiner end --%>

	<script src="./resources/ne_js/calendar.js"></script>
	<%--<script src="./resources/daum/161109.js"></script>--%>
	<script src="./resources/daum/postcode.v2.js"></script>
	<script src='https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js'></script>
	
	
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>

    <script src="./resources/cmm/js/common.js?v=201707311012"></script>
</head>
<body>
<div class="reportWrap">
    <div class="reportContent">
        <input type="hidden" id="suim_rpt_no" value="${param.suim_rpt_no}">
        <div>
            <img src="//www.toplac.co.kr/resources/ls_img/ls_body/print_head.jpg" width="640" height="56">
            <p class="text-center" style="padding-top: 6px;"><span style="font-size: 9pt;">${reportTeamInfo.teamAddr}</span></p>
            <p class="text-center">
					<span style="font-size: 9pt;">
                        전화 : ${reportInvgUser.officeTel} &nbsp;팩스 : ${reportInvgUser.officeFax} &nbsp;이메일 : ${reportInvgUser.email}
                    </span>
            </p>
            <p class="text-center" style="padding-top: 0px;">
                <img src="//www.toplac.co.kr/resources/ls_img/ls_body/print_hr.jpg" width="640" height="3" border="0" class="img-responsive center-block">
            </p>
        </div>
        <div style="margin-top: 10px;">
            <div style="width: 78%; float: left">
            	<p class="issuetitle">Report No. &nbsp;:&nbsp; ${rptIssueMain.suimAcceptNo}</p>
                <p class="issuetitle">
                	수 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;신&nbsp;&nbsp;:&nbsp;&nbsp;보험계약자, 피보험자 및 보험금청구권자
               	</p>
                <p class="issuetitle" style="padding-bottom: 30px">
                    제 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목&nbsp;&nbsp;:&nbsp;&nbsp;손해사정 결과 안내 [사고번호 : ${rptIssueMain.accidentNo}]
                </p>
            </div>
            
            <div style="width: 22%; float: right">
				<p class="issuetitle" style="margin-right: 0; text-align: right;"> Date ${rptIssue.writeDateFmt} </p>				
			</div>  
		</div>
			        

      
        
        <!--// 1.보험계약사항 -->
        <div class="display-table" style="margin-top: 50px;">
            <div class="display-cell">
                <p class="subtitle">1. 보험계약사항</p>
            </div>
        </div>
         
            <table id="table_issue_contract_view" style="border: 1px solid">
                <colgroup>
                    <col width="15%">
                    <col width="35%">
                    <col width="15%">                    
                    <col width="35%">
                </colgroup>                
                <tr>
                    <th>보&nbsp;&nbsp;험&nbsp;&nbsp;사&nbsp;&nbsp;명</th>
                    <td style="text-align: left;">&nbsp;${rptIssueMain.ptnrName}</td>
                    <th>보&nbsp;&nbsp;험&nbsp;&nbsp;종&nbsp;&nbsp;목</th>
                    <td style="text-align: left;">&nbsp;${rptIssueMain.insuranceNm}</td>
                </tr>   
                <tr>
                    <th>보&nbsp;&nbsp;험&nbsp;&nbsp;기&nbsp;&nbsp;간</th>
                    <td style="text-align: left;">&nbsp;${rptIssueMain.insuTerm}</td>
                    <th>담&nbsp;&nbsp;보&nbsp;&nbsp;내&nbsp;&nbsp;용</th>
                    <td style="text-align: left;">&nbsp;${rptIssueMain.insuCondition}</td>
                </tr>                    
                <tr>
                    <th>가&nbsp;&nbsp;입&nbsp;&nbsp;금&nbsp;&nbsp;액</th>
                    <td style="text-align: left;" colspan="3">&nbsp;${rptIssueMain.amtCompensationLimitUnit} 
                    	<span class="money">${rptIssueMain.amtCompensationLimit}</span>                    
                    </td>                    
                </tr>                
            </table>
 

        <!--// 1.보험계약사항 -->
        
        <!--// 2.사고사항 -->
        <div class="display-table" style="margin-top: 20px;">
            <div class="display-cell">
                <p class="subtitle">2. 사고사항</p>
            </div>
        </div>        
            <table id="table_accident_view">
                   <col width="15%">
                   <col width="85%">
                <tr>
                    <th>사&nbsp;&nbsp;고&nbsp;&nbsp;일&nbsp;&nbsp;자</th>
                    <td style="text-align: left;">&nbsp;${rptIssueMain.accidentDate5}</td>
                </tr> 
                <tr>
                    <th>사&nbsp;&nbsp;고&nbsp;&nbsp;내&nbsp;&nbsp;용</th>
                    <td style="text-align: left;">
               		&nbsp;${fn:replace(fn:replace(fn:escapeXml(rptIssue.insuContent) , CRLF , '<br>'), ' ', '&nbsp;')}
                    </td>
                </tr>                 
            </table>
            
            <!-- 3.관계법규 및 보험 약관 -->
	        <div class="display-table" style="margin-top: 20px;">
	            <div class="display-cell">
	                <p class="subtitle">3. 손해사정 시 적용된 관계 법규 및 약관</p>
	            </div>
	        </div>
	        <table id="table_accident_view">
			    <tr>
			    	<th style="width:15%;">관&nbsp;&nbsp;련&nbsp;&nbsp;법&nbsp;&nbsp;규</th>
			    	<td style="width:35%;text-align:left;padding-left:5px;">${lawEtcContentInfo.law_subject}</td>
			    	<th style="width:15%;">관&nbsp;&nbsp;련&nbsp;&nbsp;약&nbsp;&nbsp;관</th>
			    	<td style="width:35%;text-align:left;padding-left:5px;">${lawEtcContentInfo.law_etc}</td>
			    </tr>
			</table>
			
			<div class="display-table" style="margin-top: 20px;">
	            <div class="display-cell">
	                <p class="subtitle">4. 약관상 보험자 지급책임의 범위</p>
	            </div>
	        </div>
	        <table id="table_accident_view">
			    <tr>
			    	<th style="width:15%;">지&nbsp;&nbsp;급&nbsp;&nbsp;책&nbsp;&nbsp;임</th>
			    	<td style="width:35%;text-align:left;padding-left:5px;">
			    		<c:choose>
			    			<c:when test="${lawSelContentInfo.reparation_liability_type == 1}">부책</c:when>
			    			<c:when test="${lawSelContentInfo.reparation_liability_type == 2}">면책</c:when>
			    			<c:otherwise> - </c:otherwise>
			    		</c:choose>    		
			    	</td>
			    	<th style="width:15%;">책&nbsp;&nbsp;임&nbsp;&nbsp;범&nbsp;&nbsp;위</th>
			    	<td style="width:35%;text-align:left;padding-left:5px;">
			    		<c:choose>
			    			<c:when test="${lawSelContentInfo.reparation_liability_reason_etc == 1}">동 약관 보상하는 손해</c:when>
			    			<c:when test="${lawSelContentInfo.reparation_liability_reason_etc == 2}">동 약관 보상하지 않는 손해</c:when>
			    			<c:otherwise> - </c:otherwise>
			    		</c:choose>    		
			    	</td>
			    </tr>
			</table>
			
			<div class="display-table" style="margin-top: 20px;">
	            <div class="display-cell">
	                <p class="subtitle">5. 손해액 및 보험금 사정에 크게 영향을 미친 사항</p>
	            </div>
	        </div>
	        
	        <table id="table_accident_view">
	        	<tr>
			    	<td style="text-align:left;padding-left:5px;">
			    		<c:choose>
			    			<c:when test="${empty lawReasonInfo.reparationLiabilityReason}"> - </c:when>
			    			<c:otherwise>
			    				${lawReasonInfo.reparationLiabilityReason}		
			    			</c:otherwise>
			    		</c:choose>    		
			    	</td>
			    </tr>
	        </table>
		       	
	        <!-- 5. 지급보험금 -->
	        <div class="display-table" style="margin-top: 20px;">
	            <div class="display-cell" style="width: 70% !important;">
	                <p class="subtitle">6. 지급보험금</p>
	            </div>
	            <div class="display-cell text-right" style="width: 30% !important;">
	            </div>
	        </div> 
			<div id="div_basis">
	        	<table id="table_basis_view">
	            	<tr>
	                    <th>
	                    	<c:choose>
	                    		<c:when test="${rptIssueMain.amtInsuPaymentDisable eq 1}">
	                    			<!-- 협의금액에 따름 -->단체 사고의 경우 개별 안내 금액에 따름
	                    		</c:when>
	                    		<c:otherwise>
	                    			￦ <span class="money">${rptIssueMain.amtInsuPayment}</span>		
	                    		</c:otherwise>
	                    	</c:choose>
	                   	</th>
	                </tr>
	            </table>
			</div>
			<!--// 6. 지급보험금 -->
            
         	<!-- 조사자, 담당손해사정사 시작 -->
	    	<div style="padding-top: 20px; ">		 	
			 	<c:choose>
			 		<c:when test="${empty certiReportUser}">
			 			<div style="padding:20px 0 20px 0;">
						 	<table>
						 		<tr>					 			
						 			<td style="font-size:14px; font-family: 돋움; color: red; text-align:left;">
						 				[미배당건으로 담당자 정보가 없습니다.]
						 			</td>					 			
						 		</tr>					 		
						 	</table>
					 	</div>
			 		</c:when>
			 		<c:otherwise>
			 			<c:forEach items="${certiReportUser}" var="certiUserVo">
			 				<div style="padding:10px 0 10px 0;">
							 	<table>
							 		<tr>						 			
							 			<td width="12%" style="font-size:14px; font-family: 돋움; color: #000; text-align:left;">
							 				${certiUserVo.certi_state_val}
							 			</td>
							 			<td width="20%" style="font-size:14px; font-family: 돋움; color: #000; text-align:center;">
							 				${certiUserVo.user_name}
							 			</td>
							 			<td width="18%" style="font-size:14px; font-family: 돋움; color: #000; text-align:left;">						 										 				
							 				<img src="https://www.toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${certiUserVo.user_no}/${certiUserVo.user_sign}" width="30px" height="20px">
							 			</td>
							 			<td width="50%" style="font-size:13px; font-family: 돋움; color: #000; text-align:left;"></td>						 			
							 		</tr>
							 		<tr>
							 			<td colspan="4" style="font-size:14px; font-family: 돋움; color: #000; text-align:left;">
							 			 [ 등록번호 : ${certiUserVo.certi_number} <c:if test='${certiUserVo.work_phone != ""}'>/ 연락처 : ${certiUserVo.work_phone} </c:if>]
							 			</td>						 							 			
							 		</tr>
							 	</table>
						 	</div>
			 			</c:forEach>
			 		</c:otherwise>
			 	</c:choose>
		 	</div>		 	
		 	<!-- 조사자, 담당손해사정사 끝 -->     	
         <%-- <div class="text-right" style="font-size: 14px; font-family: 돋움; color: #000; margin: 50px 0px; padding-right: 4px;" >
			담당자 : ${reportInvgUser.disWorkLevel} ${reportInvgUser.userName}  (연락처 : ${reportInvgUser.handphone})
		</div>         
		<div style="font-size: 14px; width:155px; height:30px; float:left; padding-top: 5px; padding-left: 327px">
			대표손해사정사 : 윤경수    	   			
		</div>		
		<div style="width:70px; height:30px; float:left;">
			<img height="30" width="50" src="./resources/ne_img/sign_yun.jpg" />
		</div>
		<br/>--%>			
		<div class="text-center" style="padding-top: 50px; ">	
			<img src="./resources/ne_img/sign_ceo.jpg" /><br/><br/>		
        </div >
            <p style="font-size: 9pt; margin-top: 20px; text-align: left; ">
				※본 손해사정서는 보험업법 제188조에 근거한 손해사정사의 의견으로 보험업법 제189조에 따라 발송하는 서식이며 보험사의
				최종의사결과에 따라 달라질 수 있음을 양지해 주시기 바랍니다.
            </p>
    </div> <!-- //reportContent-->
</div> <!-- //reportWrap-->

<script type="text/javascript">
    $(document).ready(function() {
		_initMask();
		window.print();
    });
    
	function _initMask(){
	    var options = {
	        onKeyPress : function(cep, event, currentField, options){
	            var tid = event.currentTarget.id;
	            var tidx = tid.substr(tid.length - 1, 1);
	        },
	        reverse : true
	    };

	    $('input.calendar').mask('0000-00-00',options);
	    $('input.money').mask('#,###,###',options);
	    $('td.money').mask('#,##0',{reverse:true});
	    $('div.money').mask('#,##0',{reverse:true});
	    $('span.money').mask('#,##0',{reverse:true});
	}
    
</script>

</body>
</html>
