<%--
  Created by IntelliJ IDEA.
  User: hongkihun
  Date: 2017. 08. 11.
  Time:  오후 2:25
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>당직 비용 등록</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/jquery/jquery.mask.min.js"></script>	
	<script src="./resources/wm_js/common.js"></script>
		

	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	
	<script src="./resources/ne_js/ne_number.js"></script>
	
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>
	<script src="./resources/cmm/js/common.js"></script>	
		<style>
		.head1{
			/*width:15%;*/
			/*text-align:left;*/
			padding: 4px 0 4px 5px;
			background-color:#EDEDED;
		}
		
	</style>	
<script type="text/javascript">
var fileNo = 1;
$(document).ready(function () {
    _initButton();
    _initMask();
});

//버튼 이벤트
/* function _initButton() {
    $("#dutyCost_save").on("click", function () {
    	alert("저장하였습니다.")
        fnSave(); 
    });         
} */

 function _initButton() {
    $("#dutyCost_save").on("click", function () {
    	if(confirm("저장 하시겠습니까?")){
    		fnSave();
    	}
        
    });

    $("#btn_add_file").on("click", function () {
        fnAddFileForm();
    });    
}

/* mask 처리 */
function _initMask(){
    var options = {
        onKeyPress : function(cep, event, currentField, options){
            var tid = event.currentTarget.id;
            var tidx = tid.substr(tid.length - 1, 1);
            //console.log(tidx);
            //fnCaculateTotal(tidx);
        },
        reverse : true
    };

    $('input.calendar').mask('0000-00-00',options);
    $('input.money').mask('#,###,###',options);
    $('div.money').mask('999,999,999',{reverse:true});
    $('span.money').mask('999,999,999',{reverse:true});

}

function fnSave() {

    if(!$('input:radio[name=dutyType]').is(':checked')){
        alert("당직구분을 선택해 주세요.");
        return;
    }

    if ($("#processCnt").val() == '') {
        alert("건수 입력해 주세요1.");
        $("#processCnt").focus();
        
        return ;	
	}

    if ($("#processCnt").val() != '0' && $("#fileCnt").val() == '0') {	
        alert("첨부파일을 등록해 주세요.");
        $("#upfile").focus();
        
        return ;	
	}     
    
    if ($("#dutyCost").val() == '') {
        alert("비용을 입력해 주세요.");
        $("#dutyCost").focus();
        
	       
        
        return;	
    }      
    
    $("#dutyCost").val($("#dutyCost").val().num());//, 없애고 숫자변환
    
    $("#dutyCostform").submit();
    
}
function ptnrNormal(){
	
}

function fnAddFileForm() {
    $("#addFileFormDiv").append(
            "첨부파일추가 "+fileNo+" : <input type='file' id='upfile' name='upfile"+fileNo+"' onchange='fnfileChg()' style='width:80%;'><br /><br />"
    );
    fileNo = fileNo + 1;
}

function fnfileChg(){
	var cnt = $("#fileCnt").val();
	$("#fileCnt").val(parseInt(cnt) + 1);
}



function fnFileDel(fileNo, idx) {

    if (confirm("첨부파일을 삭제하시겠습니까?")){
        var param = {};
        param.file_no           = fileNo;
        var url = "./duty_cost_file_delete";
	
        $.ajax({
            type: "POST",
            url: url,
            data: param,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            dataType: "json",
            timeout: 20000,
            success: function(data){
                if (data.Authorize == 'T' && data.Result == "success"){
                    alert("첨부파일 삭제를 성공 하였습니다.");
                    $("#p_file" + idx).remove();
                	var cnt = $("#fileCnt").val();
                	$("#fileCnt").val(parseInt(cnt) - 1);
                }else{
                    alert("첨부파일 삭제를 실패 하였습니다.");
                }
            },
            error: function(xhr, status, error){
                if(xhr.status == "901"){
                    fnWinClose();
                }else{
                    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
                }
            },
            beforeSend : function(xmlHttpRequest){
                xmlHttpRequest.setRequestHeader("AJAX", "true");
            }
        });
    }
}


function fnCalcDutyCost(type){
	
	//당직일 체크추가 (20230614일 이전인지 이후인지)
	//당직일기준
	var sDutyDay = '${dutyVo.dutyDe}';
	sDutyDay = sDutyDay.replace(/\-/g,'');	
	var chkDay = "20230614";
	
	if( sDutyDay < chkDay ){
		switch (type){
	        case '1' :$("#dutyCost").val('10,000'); break;
	        case '2' :$("#dutyCost").val('40,000'); break;
	        case '3' :$("#dutyCost").val('50,000'); break;
	        case '4' :$("#dutyCost").val('100,000'); break;
	        case '5' :$("#dutyCost").val('100,000'); break;
	    }
	}else{
		switch (type){
	        case '1' :$("#dutyCost").val('10,000'); break;
	        case '2' :$("#dutyCost").val('100,000'); break;				//2023년 6월 14일 부터 휴일은 전화당직 10만원
	        case '3' :$("#dutyCost").val('50,000'); break;
	        case '4' :$("#dutyCost").val('100,000'); break;
	        case '5' :$("#dutyCost").val('100,000'); break;
	    }
	}
	
    
}

function fnDisabledType(ptnrId){
    if(ptnrId == '7' || ptnrId == '18'){
        $("#dutyType1").attr("disabled", true).attr("checked", false);
        $("#dutyType2").attr("disabled", true).attr("checked", false);
    }else{
        $("#dutyType1").attr("disabled", false);
        $("#dutyType2").attr("disabled", false);
    }
}

function fnWinClose(){
    window.location.href = "/";
}
</script>	
</head>
<body>
<div id="wrapper">
	<!-- skipnavi --><!-- header -->
	<c:import url="../top_main/top_main_menu.jsp"></c:import>
	<!-- //skipnavi --><!-- //header -->

	<!-- contents -->
	<div id="container">
		<div class="contetns">

			<!-- centercnt_top -->
			<div class="center_cnt_1300">
				<div class="center_cnt_1300_bot">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on" style="width: 90%;"><a href="#">당직비 신청</a></li>
							</ul>			
						</div>
						<form id="dutyCostform" name="dutyCostform" method=post action="dutyCostUpdate" enctype="multipart/form-data">
						<input type="hidden" id="dutyId" name="dutyId" value="${dutyVo.dutyId}">
						<input type="hidden" name="tabFlag" value="<%=request.getParameter("tabFlag") %>">
							<div class= "tableStyle6">
								<table align="center" style = "margin-top:10px;" >
									<colgroup>
										<col width="15%">
										<col width="30%">
										<col width="15%">
										<col width="30%">
									</colgroup>
									<tbody>
						                <tr id = "reportType2Tr">
										
										<tr>
											<td class="head1">ㆍ고유번호</td>
											<td colspan="3" >
												${fn:substring(dutyVo.dutyId,0,7)}-${fn:substring(dutyVo.dutyId,7,9)}
											</td>
										</tr>
										<tr>
											<td class="head1">ㆍ당직일</td>
											<td colspan="3">
												${dutyVo.dutyDe}
											</td>
										</tr>				
										<tr>
											<td class="head1">ㆍ당직자</td>
											<td colspan="3" >
												${dutyVo.userName}
											</td>
										</tr>	
										<tr>					                
						                    <td class="head1">ㆍ보험사</td>
						                    <td colspan="3">
						                    <%-- 		${dutyVo.ptnrNick}	--%>
												<span id="ptnrNormal">
													<input type="radio" id="ptnr_rpt23" name="ptnrId" onclick="fnDisabledType('6');" value = "6" <c:if test="${dutyVo.ptnrId == 6}"> checked="checked" </c:if> /><label for='ptnr_rpt23'><b>농협</b></label>
													<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
													<input type="radio" id="ptnr_rpt21" name="ptnrId" onclick="fnDisabledType('7');" value = "7" <c:if test="${dutyVo.ptnrId == 7}"> checked="checked" </c:if> /><label for='ptnr_rpt21'><b>동부</b></label>
													<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
													<input type="radio" id="ptnr_rpt22" name="ptnrId" onclick="fnDisabledType('18');" value = "18" <c:if test="${dutyVo.ptnrId == 18}"> checked="checked" </c:if> /><label for='ptnr_rpt22'><b>삼성</b></label>
												</span> 
											</td>
										</tr>
										<tr>
						                    <td class="head1">ㆍ당직 구분</td>
						                    <td colspan="3">
                                                <c:choose>
                                                    <c:when test="${dutyVo.ptnrId == 7 || dutyVo.ptnrId == 18}">
                                                        <c:set var="dutyType_disable1" value="disabled='disabled'"/>
                                                        <c:set var="dutyType_disable2" value="disabled='disabled'"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:set var="dutyType_disable1" value=""/>
                                                        <c:set var="dutyType_disable2" value=""/>
                                                    </c:otherwise>
                                                </c:choose>
												<input type="radio" id="dutyType1" name = "dutyType"  onclick="fnCalcDutyCost('1');" value = "1" <c:if test = "${dutyVo.dutyType == 1}"> checked="checked" </c:if> ${dutyType_disable1} /><label for='dutyType1'><b>전화당직(평일)</b></label>
												<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
												<input type="radio" id="dutyType2" name = "dutyType"  onclick="fnCalcDutyCost('2');" value = "2" <c:if test = "${dutyVo.dutyType == 2}"> checked="checked" </c:if> ${dutyType_disable2} /> <label for='dutyType2'><b>전화당직(휴일)</b></label>
												<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
												<input type="radio" id="dutyType3" name = "dutyType"  onclick="fnCalcDutyCost('3');" value = "3" <c:if test = "${dutyVo.dutyType == 3}"> checked="checked" </c:if>/> <label for='dutyType3'><b>출동대기</b></label>
												<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
												<input type="radio" id="dutyType5" name = "dutyType"  onclick="fnCalcDutyCost('5');" value = "5" <c:if test = "${dutyVo.dutyType == 5}"> checked="checked" </c:if>/> <label for='dutyType5'><b>출동대기+출동</b></label>
												<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
												<input type="radio" id="dutyType4" name = "dutyType"  onclick="fnCalcDutyCost('4');" value = "4" <c:if test = "${dutyVo.dutyType == 4}"> checked="checked" </c:if>/> <label for='dutyType4'><b>출동</b></label>			
											</td>
										</tr>										
										<tr>
											<td class="head1">ㆍ건수(콜접수/출동)</td>
											<td colspan="3" >
												<input type="text" id="processCnt"  name="processCnt" value="${dutyVo.processCnt}" size="10"/>건
											</td>
										</tr>
										<tr class="rptInsBodyNoneSpeed">
											<td class="head1">ㆍ출동내용(계약자명)</td>
											<td colspan="3">
												<textarea rows="3" style="width:560px;" id = "gutCn" name="gutCn">${dutyVo.gutCn}</textarea>
											</td>
										</tr>										
										<tr>
										<td class="head1">ㆍ당직비용</td>
											<td colspan="3" >
											<c:set var="chkDate" value="20230614"></c:set>
											<c:set var="sorceDate" value="${fn:replace(dutyVo.dutyDe,'-','')}"></c:set>
												<c:choose>
                                                    <c:when test="${dutyVo.dutyCost == null and (sorceDate < chkDate) }">
                                                        <c:choose>
                                                            <c:when test="${dutyVo.dutyType == 1}">
                                                                <c:set var="duty_cost" value="10000"/>
                                                            </c:when>
                                                            <c:when test="${dutyVo.dutyType == 2}">
                                                                <c:set var="duty_cost" value="40000"/>
                                                            </c:when>
                                                            <c:when test="${dutyVo.dutyType == 3}">
                                                                <c:set var="duty_cost" value="50000"/>                                        						
                                                            </c:when>
                                                            <c:when test="${dutyVo.dutyType == 4}">
                                                                <c:set var="duty_cost" value="100000"/>
                                                            </c:when>
                                                            <c:when test="${dutyVo.dutyType == 5}">
                                                                <c:set var="duty_cost" value="100000"/>
                                                            </c:when>
                                                        </c:choose>
                                                    </c:when>
                                                    <c:when test="${dutyVo.dutyCost == null and (sorceDate >= chkDate) }">
                                                    	<c:choose>
                                                            <c:when test="${dutyVo.dutyType == 1}">
                                                                <c:set var="duty_cost" value="10000"/>
                                                            </c:when>
                                                            <c:when test="${dutyVo.dutyType == 2}">
                                                                <c:set var="duty_cost" value="100000"/>
                                                            </c:when>
                                                            <c:when test="${dutyVo.dutyType == 3}">
                                                                <c:set var="duty_cost" value="50000"/>                                        						
                                                            </c:when>
                                                            <c:when test="${dutyVo.dutyType == 4}">
                                                                <c:set var="duty_cost" value="100000"/>
                                                            </c:when>
                                                            <c:when test="${dutyVo.dutyType == 5}">
                                                                <c:set var="duty_cost" value="100000"/>
                                                            </c:when>
                                                        </c:choose>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:set var="duty_cost" value="${dutyVo.dutyCost}"/>
                                                    </c:otherwise>
                                                </c:choose>                                                
												<input id="dutyCost" name="dutyCost" type="text" class="money" value="${duty_cost}" style="text-align:right;"/>
											</td>
										</tr>									 	
	                                    <tr>
	                                        <th>첨부파일</th>
	                                        <td colspan="3" style="text-align: left; padding-left: 5px;">
	                                            <c:forEach  var="item" items="${fileList}" varStatus="status">
	                                                <p id="p_file${status.index}">
	                                                    <a href="/duty_cost_file_down?file_no=${item.fileNo}">${item.orignlFileNm}</a>&nbsp;&nbsp;&nbsp;
	                                                    <a href="#noloc" onclick="fnFileDel('${item.fileNo}','${status.index}')">
	                                                        <img src="./resources/ls_img/ls_board/btn_s_del.gif"/>
	                                                    </a>
	                                                </p>
	
	                                            </c:forEach>
	                                        </td>
	                                    </tr>
	                                    <tr>
	                                        <th style="vertical-align:top;">
	                                            <input type="button" id="btn_add_file" value="첨부파일추가" />
	                                            <input type="hidden" id="fileCnt" value="${fileList.size()}">
	                                        </th>
	                                        
	                                        <td id="addFileFormDiv"  colspan="3"></td>
	                                    </tr>																																									
									</tbody>
								</table>	
							</div>
						</form>	
						<div style ="text-align:center; margin-top:10px;">
							<a id="dutyCost_save" href="#nocl"><img src="./resources/ls_img/btn_ok.gif" /></a>
							<a href="#" onclick="history.back();"><img src="./resources/ls_img/btn_cancel.gif"/></a> 
						</div>
					</div><!-- guest -->
				</div><!-- center_cnt_1300_bot -->
			</div><!-- center_cnt_1300 -->
		</div><!-- contetns -->
	</div><!-- container	 -->
	<!-- footer -->
	<c:import url="../top_main/top_main_footer.jsp"></c:import>
	<!-- //footer -->
</div><!-- //wrapper -->				
</body>
</html>