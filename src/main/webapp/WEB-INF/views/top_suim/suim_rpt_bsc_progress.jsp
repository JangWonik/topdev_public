<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style type="text/css">
    #loading {
        width: 100%;
        height: 100%;
        top: 0px;
        left: 0px;
        position: absolute;
        display: block;
        opacity: 0.7;
        background-color: #ffffff;
        z-index: 99;
        text-align: center;
    }

    #loading-image {
        position:absolute;
        /*width: 100%;*/
        /*height: 100%;*/
        top:50%;
        left:50%;
        z-index: 100;
    }
</style>
<script type="text/javascript">
    var rptType1 = '${suimVO.suim_rpt_type1}';
    var chkListSave = '${suimVO.indAjmdmgeEnnc}';
    
    $(document).ready(function() {
        _initMask();
        _initMinwonDisplay("init");
    });

    
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

        $('input.money').mask('###,###,###,###,###',options);
        $('div.money').mask('999,999,999,999,999',{reverse:true});
        $('span.money').mask('999,999,999,999,999',{reverse:true});
    }
    
    function _initDatepicker(){
		$('#p_minwonDate').datepicker({ 
	    	   showOn: 'button',
	    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
	    	   buttonImageOnly: true,
	    	   buttonText: "달력", 
	    	   changeMonth: true,
	    	   changeYear: true,
	    	   showButtonPanel: false
	    });
		
		$('#p_moralDate').datepicker({ 
	    	   showOn: 'button',
	    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
	    	   buttonImageOnly: true,
	    	   buttonText: "달력", 
	    	   changeMonth: true,
	    	   changeYear: true,
	    	   showButtonPanel: false
	    });
    }
    
    function fnPrgssModifyFrm(){
        $("#div_prgss_view").hide();
        $("#div_prgss_edit").show();
        
        fnMinwonDateUseAt('progress');
        _initDatepicker();
    }

    function fnPrgssModifyCancel(){
        $("#div_prgss_view").show();
        $("#div_prgss_edit").hide();
    }
    
    
    function _initMinwonDisplay(gubun, minwonFlag, moralFlag){
    	var suimRptType = $("#suimRptType").val(); 
    	
    	if (gubun == "init"){
			var minwonFlag = $("#minwonFlag").val();
			var moralFlag = $("#moralFlag").val();
    	}
    	
		//if (suimRptType == 14){
		if ( suimRptType == 14 || suimRptType == 15 || suimRptType == 16 || suimRptType == 17 ){
			if (minwonFlag == 2 && moralFlag == 1){
				//민원, 보험사기 동시
				$("#dis_pMinwonDate").parent().attr("colspan","1");
				$("#dis_pMoralDate").parent().attr("colspan","1");
				$("#dis_pMoralDate").parent().show();
				$("#dis_pMoralDate").parent().prev().show();
				$("#dis_pMinwonDate").parent().show();
				$("#dis_pMinwonDate").parent().prev().show();
				$("#dis_pMinwonDate_tr").show();
				
				$("#dis_cMinwonDate").parent().attr("colspan","1");
				$("#dis_cMoralDate").parent().attr("colspan","1");
				$("#dis_cMoralDate").parent().show();
				$("#dis_cMoralDate").parent().prev().show();
				$("#dis_cMinwonDate").parent().show();
				$("#dis_cMinwonDate").parent().prev().show();
				$("#dis_cMinwonDate_tr").show();
				
			}else if (minwonFlag == 2 && moralFlag != 1){
				//민원만
				$("#dis_pMinwonDate").parent().attr("colspan","3");
				$("#dis_pMoralDate").parent().hide();
				$("#dis_pMoralDate").parent().prev().hide();
				$("#dis_pMinwonDate").parent().show();
				$("#dis_pMinwonDate").parent().prev().show();			
				$("#dis_pMinwonDate_tr").show();
				
				$("#dis_cMinwonDate").parent().attr("colspan","3");
				$("#dis_cMoralDate").parent().hide();
				$("#dis_cMoralDate").parent().prev().hide();
				$("#dis_cMinwonDate").parent().show();
				$("#dis_cMinwonDate").parent().prev().show();			
				$("#dis_cMinwonDate_tr").show();
				
			}else if (minwonFlag != 2 && moralFlag == 1){
				//사기만 
				$("#dis_pMoralDate").parent().attr("colspan","3");
				$("#dis_pMoralDate").parent().show();
				$("#dis_pMoralDate").parent().prev().show();
				$("#dis_pMinwonDate").parent().hide();
				$("#dis_pMinwonDate").parent().prev().hide();	
				$("#dis_pMinwonDate_tr").show();
				
				$("#dis_cMoralDate").parent().attr("colspan","3");
				$("#dis_cMoralDate").parent().show();
				$("#dis_cMoralDate").parent().prev().show();
				$("#dis_cMinwonDate").parent().hide();
				$("#dis_cMinwonDate").parent().prev().hide();	
				$("#dis_cMinwonDate_tr").show();
				
			}else if (minwonFlag != 2 && moralFlag != 1){
				//둘다 아니면
				$("#dis_pMinwonDate_tr").hide();
				$("#dis_cMinwonDate_tr").hide();
			}
		}
    }
    
    
	function fnMinwonDateUseAt(gubun){
		var suimRptType = $("#suimRptType").val(); 
		var pMinwonFlag = $("input:radio[name='pMinwonFlag']:checked").val();
		var cMinwonFlag = $("input:radio[name='cMinwonFlag']:checked").val();
		
		var pMoralFlag = 2;
		
		if (suimRptType == 14 || suimRptType == 15 || suimRptType == 16 || suimRptType == 17){
			pMoralFlag = $("input:radio[name='pMoralFlag']:checked").val();
			cMoralFlag = $("input:radio[name='cMoralFlag']:checked").val();
			
			if (pMinwonFlag == 2 && pMoralFlag == 1){
				//둘다 온
				$("#p_minwonDate").parent().attr("colspan","1");
				$("#p_moralDate").parent().attr("colspan","1");
				
				$("#p_moralDate").parent().show();
				$("#p_moralDate").parent().prev().show();
				$("#p_minwonDate").parent().show();
				$("#p_minwonDate").parent().prev().show();
			}else if (pMinwonFlag == 2 && pMoralFlag != 1){
				//민원만 온
				$("#p_minwonDate").parent().attr("colspan","3");
				
				$("#p_moralDate").parent().hide();
				$("#p_moralDate").parent().prev().hide();
				$("#p_minwonDate").parent().show();
				$("#p_minwonDate").parent().prev().show();
				
			}else if (pMinwonFlag != 2 && pMoralFlag == 1){
				//사기만 온
				$("#p_moralDate").parent().attr("colspan","3");
				
				$("#p_moralDate").parent().show();
				$("#p_moralDate").parent().prev().show();
				$("#p_minwonDate").parent().hide();
				$("#p_minwonDate").parent().prev().hide();	
			}
			
			
			if (cMinwonFlag == 2 && cMoralFlag == 1){
				//둘다 온
				$("#c_minwonDate").parent().attr("colspan","1");
				$("#c_moralDate").parent().attr("colspan","1");
				
				$("#c_moralDate").parent().show();
				$("#c_moralDate").parent().prev().show();
				$("#c_minwonDate").parent().show();
				$("#c_minwonDate").parent().prev().show();
			}else if (cMinwonFlag == 2 && cMoralFlag != 1){
				//민원만 온
				$("#c_minwonDate").parent().attr("colspan","3");
				
				$("#c_moralDate").parent().hide();
				$("#c_moralDate").parent().prev().hide();
				$("#c_minwonDate").parent().show();
				$("#c_minwonDate").parent().prev().show();
				
			}else if (cMinwonFlag != 2 && cMoralFlag == 1){
				//사기만 온
				$("#c_moralDate").parent().attr("colspan","3");
				
				$("#c_moralDate").parent().show();
				$("#c_moralDate").parent().prev().show();
				$("#c_minwonDate").parent().hide();
				$("#c_minwonDate").parent().prev().hide();	
			}
			
			if (gubun == 'progress'){
				(pMinwonFlag == 2 || pMoralFlag == 1) ? $("#edit_pMinwonDate_tr").show() : $("#edit_pMinwonDate_tr").hide();
			}else if (gubun == 'end'){
				(cMinwonFlag == 2 || cMoralFlag == 1) ? $("#edit_cMinwonDate_tr").show() : $("#edit_cMinwonDate_tr").hide();
			}		
		}else{
			
			if (gubun == 'progress'){
				(pMinwonFlag !=2 )?$("#edit_pMinwonDate_tr").hide():$("#edit_pMinwonDate_tr").show();
			}else if (gubun == 'end'){
				(cMinwonFlag !=2 )?$("#edit_cMinwonDate_tr").hide():$("#edit_cMinwonDate_tr").show();
			}
		}
		

	}
	
	
    function fnPrgssModifySubmit(){
    	
    	var suimRptType = $("#suimRptType").val(); 
    	
        if ($("#p_amtClaimed").val() == '') {
            alert("청구금액을 입력해 주세요.");
            $("#p_amtClaimed").focus();
            return;
        }

        if ($("#p_amtEstimatedDamage").val() == '') {
            alert("추정손해액을 입력해 주세요.");
            $("#p_amtEstimatedDamage").focus();
            return;
        }

//        if ($("#p_amtEstimatedDamage").val() == '0') {
//            alert("추정손해액은 0보다 커야됩니다.");
//            $("#p_amtEstimatedDamage").focus();
//            return;
//        }

        if (rptType1 != '3' && rptType1 != '4'){

            if (!$('input:radio[name=preEstmtAt]').is(':checked')) {
                alert("선견적 여부를 선택해 주세요.");
                $("#p_preEstmtAt1").focus();
                return;
            }


            if($('input:radio[name=preEstmtAt]:checked').val() == 1){
                if ($("#p_preEstmtCmpy").val() == '') {
                    alert("선견적 업체명을 입력해 주세요.");
                    $("#p_preEstmtCmpy").focus();
                    return;
                }
            }

        }

        if (!$('input:radio[name=indAjmdmgeEnnc]').is(':checked')) {
            alert("독립손사 유무를 선택해 주세요.");
            $("#p_indAjmdmgeEnnc2").focus();
            return;
        }

        if (!$('input:radio[name=docRceptAt]').is(':checked')) {
            alert("손해평가서류 접수 여부를 선택해 주세요.");
            $("#p_docRceptAt1").focus();
            return;
        }

        if (!$('input:radio[name=pMinwonFlag]').is(':checked')) {
            alert("민원발생 여부를 선택해 주세요.");
            $("#p_minwonFlag1").focus();
            return;
        }

        if (!$('input:radio[name=pMoralFlag]').is(':checked')) {
            alert("보험사기 여부를 선택해 주세요.");
            $("#p_moralFlag1").focus();
            return;
        }
        
        if ( $("input:radio[name='pMinwonFlag']:checked").val() == 2 && $("#p_minwonDate").val() == ""){
        	alert("민원 발생일을 입력해 주세요.");
            $("#p_minwonDate").focus();
        	return;
        }
        
        
        //if ( $("input:radio[name='pMoralFlag']:checked").val() == 1 && $("#p_moralDate").val() == "" && suimRptType == 14 ){
		if ( $("input:radio[name='pMoralFlag']:checked").val() == 1 && $("#p_moralDate").val() == "" && (suimRptType == 14 || suimRptType == 15 || suimRptType == 16 || suimRptType == 17) ){        	
        	alert("공문 수신일을 입력해 주세요.");
            $("#p_moralDate").focus();
        	return;
        }
               
        
        var param = {};
        param.suimRptNo             = $("#suimRptNo").val();
        param.amtEstimatedDamage    = $("#p_amtEstimatedDamage").val().num();
        param.amtClaimed            = $("#p_amtClaimed").val().num();

        if (rptType1 != "3" && rptType1 != "4"){
            param.preEstmtAt            = $("input:radio[name='preEstmtAt']:checked").val();
            param.preEstmtCmpy          = $("#p_preEstmtCmpy").val();
        }
        param.indAjmdmgeEnnc        = $("input:radio[name='indAjmdmgeEnnc']:checked").val();
        param.docRceptAt            = $("input:radio[name='docRceptAt']:checked").val();
        param.minwonFlag            = $("input:radio[name='pMinwonFlag']:checked").val();
        param.moralFlag             = $("input:radio[name='pMoralFlag']:checked").val();

        if ( $("input:radio[name='pMinwonFlag']:checked").val() == 2) {
        	param.minwonDate 		= $("#p_minwonDate").val();
        }else{
        	param.minwonDate 		= "";
        }
        
        //if ( $("input:radio[name='pMoralFlag']:checked").val() == 1 && suimRptType == 14 ) {
        if ( $("input:radio[name='pMoralFlag']:checked").val() == 1 && (suimRptType == 14 || suimRptType == 15 || suimRptType == 16 || suimRptType == 17) ) {
        
        	param.moralDate 		= $("#p_moralDate").val();
        }else{
        	param.moralDate 		= "";
        }
       
        
        var url = "./chkListUpdate";

        $.ajax({
            type: "POST",
            url: url,
            data: param,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            dataType: "json",
            timeout: 20000,
            success: function(data){
                if(data.result == "0000"){
                    alert("Check List 수정이 완료되었습니다.");
                    //window.location.reload(true);
                    fnPrgssModifyComplete(data.retData);
                    fnPrgssModifyCancel();
                }else{
                    alert("Check List 수정이 실패했습니다.\n시스템 관리자 에게 문의해 주세요.");
                }
            },
            error: function(e){
                alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
            },
            beforeSend: function(){
                $('#div_prgss_edit').spin();
                //$("#loading").show();
            },
            complete: function(){
                $('#div_prgss_edit').spin(false);
                //$("#loading").hide();
            }
        });

    }

    function fnPrgssModifyComplete(data){
    	
        var sAmtEstimatedDamage = data.amtEstimatedDamage + "";
        var sAmtClaimed = data.amtClaimed + "";

        $("#dis_amtEstimatedDamage").text(sAmtEstimatedDamage.money() + " 원");
        $("#dis_amtClaimed").text(sAmtClaimed.money() + " 원");

        (data.preEstmtAt == 1) ? $("#dis_preEstmtAt").text("여") : $("#dis_preEstmtAt").text("부");

        $("#dis_preEstmtCmpy").text(data.preEstmtCmpy);

        (data.indAjmdmgeEnnc == 1) ? $("#dis_indAjmdmgeEnnc").text("무") : $("#dis_indAjmdmgeEnnc").text("유");
        (data.docRceptAt == 1) ? $("#dis_docRceptAt").text("접수") : $("#dis_docRceptAt").text("미접수");

        if (data.minwonFlag == 0){
            $("#dis_minwonFlag").text("없음");
            $("#dis_pMinwonDate_tr").hide();
            
            $("#dis_cMinwonFlag").text("없음"); //아래 종결내용 수정
            $("#dis_cMinwonDate_tr").hide();
            $("#c_minwonFlag1").prop("checked", true); //아래 종결내용 수정
            
            $("#dis_vminwonFlag").text("민원없음"); //아래 종결내용 수정

        }else if(data.minwonFlag == 1){
            $("#dis_minwonFlag").text("민원예상");
            $("#dis_pMinwonDate_tr").hide();
            
            $("#dis_cMinwonDate_tr").hide();
            $("#dis_cMinwonFlag").text("민원예상"); //아래 종결내용 수정
            $("#c_minwonFlag2").prop("checked", true); //아래 종결내용 수정
            
            $("#dis_vminwonFlag").text("민원예상"); //아래 종결내용 수정

        }else if(data.minwonFlag == 2){
            $("#dis_minwonFlag").text("민원발생");
            $("#dis_pMinwonDate_tr").show();
            $("#dis_pMinwonDate").text(data.minwonDate);
            $("#p_minwonDate").val(data.minwonDate);
            
            $("#dis_cMinwonFlag").text("민원발생"); //아래 종결내용 수정
            $("#dis_cMinwonDate_tr").show();
            $("#dis_cMinwonDate").text(data.minwonDate);
            $("#c_minwonDate").val(data.minwonDate);
            $("#p_minwonFlag3").prop("checked", true);
            
            $("#dis_vminwonFlag").text("민원발생"); //아래 종결내용 수정
        }

        if (data.moralFlag == 0){
            $("#dis_moralFlag").text("조사중");
            $("#dis_cMoralFlag").text("조사중"); //아래 종결내용 수정
            $("#c_moralFlag1").prop("checked", true); //아래 종결내용 수정

        }else if(data.moralFlag == 1){
            $("#dis_moralFlag").text("해당");
            $("#dis_cMoralFlag").text("해당"); //아래 종결내용 수정
            
            $("#dis_pMoralDate").text(data.moralDate);
            $("#dis_cMoralDate").text(data.moralDate);
            
            $("#p_moralDate").val(data.moralDate);
            $("#c_moralDate").val(data.moralDate);
            
            
            
            $("#c_moralFlag2").prop("checked", true); //아래 종결내용 수정

        }else if(data.moralFlag == 2){
            $("#dis_moralFlag").text("해당없음");
            $("#dis_cMoralFlag").text("해당없음"); //아래 종결내용 수정
            $("#c_moralFlag3").prop("checked", true); //아래 종결내용 수정
        }


        //상단 값 변경
        $("#moralFlagForSubmit").val(data.moralFlag);

        //아래 종결내용 추정 손해액 수정
        $("#amtEstimatedDamage").val(sAmtEstimatedDamage.money());
        $("#amtEstimatedDamageSpan").text(sAmtEstimatedDamage.money() + " 원");

        //아래 종결내용 청구금액 수정
        $("#amtClaimed").val(sAmtClaimed.money());
        $("#amtClaimedSpan").text(sAmtClaimed.money() + " 원");


        //chekList 저장여부 변경
        chkListSave = data.indAjmdmgeEnnc;

        //화면 초기화
        _initMinwonDisplay("update",data.minwonFlag,data.moralFlag);
        
        //종결내용
        fnCloseCalc();

    }

    function fnChkListSave(){
        if (chkListSave == '1' || chkListSave == '2') {
            return true;
        }else{
            return false;
        }
    }
    
    
    
</script>
<div id="div_prgss_view" style="margin-top:10px;">
    <table align="center">
        <colgroup>
            <col width="20%">
            <col width="30%">
            <col width="20%">
            <col width="30%">
        </colgroup>
        
        <tr>
            <td colspan="4" height="30" style="background-color: #e7f5ff"><span style="font-size: 20px;"><b>2. 과정관리</b></span></td>
        </tr>
        
        <tr>
            <td colspan="4">
                <img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;" /> <b> 2-1. Check List</b>

                <c:if test="${suimVO.suimRptState eq '0' or suimVO.suimRptState eq '11' }">
                    <c:if test="${suimVO.editYN > 0}">
                        <a href="#noloc" onclick="fnPrgssModifyFrm();" style="float:right; margin-right:10px;"><img src="./resources/ls_img/btn_edite.gif" /></a>
                    </c:if>
                </c:if>
                
                <c:if test="${endModFlag > 0 && (suimVO.suimRptState eq '2' or suimVO.suimRptState eq '3')}">
                    <a href="#noloc" onclick="fnPrgssModifyFrm();" style="float:right; margin-right:10px;"><img src="./resources/ne_img/btn/btn_end_mod.jpg" /></a>
                </c:if>
            </td>
        </tr>
        
        <tr>
            <td bgcolor="#E7ECF1"><b>ㆍ청구금액</b></td>
            <td>
                <span id="dis_amtClaimed">
                    <c:if test="${suimVO.amtClaimed != null && suimVO.amtClaimed != ''}">
                        <fmt:formatNumber  value="${suimVO.amtClaimed}" pattern="#,###"/> 원
                    </c:if>
                </span>
            </td>
            <td bgcolor="#E7ECF1"><b>ㆍ추정손해액</b></td>
            <td>
                <span id="dis_amtEstimatedDamage">
                    <c:if test="${suimVO.amtEstimatedDamage != null && suimVO.amtEstimatedDamage != ''}">
                        <fmt:formatNumber  value="${suimVO.amtEstimatedDamage}" pattern="#,###"/> 원
                    </c:if>
                </span>
            </td>
        </tr>
        <c:if test="${suimVO.suim_rpt_type1 != 3 && suimVO.suim_rpt_type1 != 4}">
        <tr>
            <td bgcolor="#E7ECF1"><b>ㆍ선견적</b></td>
            <td>
                <span id="dis_preEstmtAt">
                    <c:if test="${suimVO.preEstmtAt == 1}">여</c:if>
                    <c:if test="${suimVO.preEstmtAt == 2}">부</c:if>
                </span>
            </td>
            <td bgcolor="#E7ECF1"><b>ㆍ선견적업체명</b></td>
            <td><span id="dis_preEstmtCmpy">${suimVO.preEstmtCmpy}</span></td>
        </tr>
        </c:if>
        <tr>
            <td bgcolor="#E7ECF1"><b>ㆍ독립손사</b></td>
            <td>
                <span id="dis_indAjmdmgeEnnc">
                    <c:if test="${suimVO.indAjmdmgeEnnc == 1}">무</c:if>
                    <c:if test="${suimVO.indAjmdmgeEnnc == 2}">유</c:if>
                </span>
            </td>
            <td bgcolor="#E7ECF1"><b>ㆍ손해평가서류</b></td>
            <td>
                <span id="dis_docRceptAt">
                    <c:if test="${suimVO.docRceptAt == 1}">접수</c:if>
                    <c:if test="${suimVO.docRceptAt == 2}">미접수</c:if>
                </span>
            </td>
        </tr>
        <tr>
            <td bgcolor="#E7ECF1"><b>ㆍ민원</b></td>
            <td>
                <span id="dis_minwonFlag">
                    <c:if test="${suimVO.minwonFlag == 0}">없음</c:if>
                    <c:if test="${suimVO.minwonFlag == 1}">민원예상</c:if>
                    <c:if test="${suimVO.minwonFlag == 2}">민원발생</c:if>
                </span>
            </td>
            <td bgcolor="#E7ECF1"><b>ㆍ보험사기</b></td>
            <td>
                <span id="dis_moralFlag">
                    <c:if test="${suimVO.moralFlag == 0}">조사중</c:if>
                    <c:if test="${suimVO.moralFlag == 1}">해당</c:if>
                    <c:if test="${suimVO.moralFlag == 2}">해당없음</c:if>
                </span>
            </td>
        </tr>
        
        <tr id="dis_pMinwonDate_tr"  <c:if test="${suimVO.minwonFlag != 2}">style="display:none;"</c:if> >
        	<td bgcolor="#E7ECF1"><b>ㆍ민원 발생일</b></td>
			<td colspan="3">
				<span id="dis_pMinwonDate">
					<c:if test="${suimVO.minwonDate != 0}">
						${suimVO.minwonDateVal}
					</c:if>
                </span>
			</td>
        	<td bgcolor="#E7ECF1" style="display: none;"><b>ㆍ공문 수신일</b></td>
			<td colspan="1" style="display: none;">
				<span id="dis_pMoralDate">
					<c:if test="${suimVO.moralDate != 0}">
						${suimVO.moralDateVal}
					</c:if>
                </span>
			</td>			
		</tr>
		
    </table>
</div>

<div id="div_prgss_edit" style="margin-top:10px;position: relative; display: none;">
    <table align="center">
        <colgroup>
            <col width="20%">
            <col width="30%">
            <col width="20%">
            <col width="30%">
        </colgroup>
        <tr>
            <td colspan="4" height="30" style="background-color: #e7f5ff"><span style="font-size: 20px;"><b>2. 과정관리</b></span></td>
        </tr>
        <tr>
            <td colspan="4">
                <img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;" /> <b> 2-1. Check List</b>
                <c:if test="${(suimVO.suimRptState eq '0' and suimVO.editYN > 0) or endModFlag > 0}">
                    <a href="#noloc" onclick="fnPrgssModifyCancel();" style="float:right; margin-right:10px;"><img src="./resources/ls_img/btn_write_cancel.gif" /></a>
                    <a href="#noloc" onclick="fnPrgssModifySubmit();" style="float:right; margin-right:10px;"><img src="./resources/ls_img/icon_write.gif" /></a>
                    <%--<a href="#noloc" onclick="fnPrgssModifySubmit();" style="float:right; margin-right:10px;"><img src="./resources/ls_img/btn_edite.gif" /></a>--%>
                </c:if>
            </td>
        </tr>
        
        <tr>
            <td bgcolor="#E7ECF1"><b>ㆍ청구금액</b></td>
            <td><input type="text" id="p_amtClaimed" maxlength="16" class="money" value="${suimVO.amtClaimed}" style="width: 80%;text-align: right; padding-right:1px;">원</td>
            <td bgcolor="#E7ECF1"><b>ㆍ추정손해액</b></td>
            <td><input type="text" id="p_amtEstimatedDamage" maxlength="16" class="money" value="${suimVO.amtEstimatedDamage}" style="width: 80%;text-align: right; padding-right:1px;">원</td>
        </tr>
        
        <c:if test="${suimVO.suim_rpt_type1 != 3 && suimVO.suim_rpt_type1 != 4}">
        <tr>
            <td bgcolor="#E7ECF1"><b>ㆍ선견적</b></td>
            <td>
                <input type="radio" id="p_preEstmtAt1" name="preEstmtAt" value="1" <c:if test="${suimVO.preEstmtAt == 1}">checked</c:if>><label for="p_preEstmtAt1"> 여 </label>&nbsp;&nbsp;
                <input type="radio" id="p_preEstmtAt2" name="preEstmtAt" value="2" <c:if test="${suimVO.preEstmtAt == 2}">checked</c:if>><label for="p_preEstmtAt2"> 부 </label>
            </td>
            <td bgcolor="#E7ECF1"><b>ㆍ선견적업체명</b></td>
            <td>
                <input type="text" id="p_preEstmtCmpy" value="${suimVO.preEstmtCmpy}" style="width: 80%;" maxlength="100">
            </td>
        </tr>
        </c:if>
        <tr>
            <td bgcolor="#E7ECF1"><b>ㆍ독립손사</b></td>
            <td>
                <input type="radio" id="p_indAjmdmgeEnnc2" name="indAjmdmgeEnnc" value="2" <c:if test="${suimVO.indAjmdmgeEnnc == 2}">checked</c:if>><label for="p_indAjmdmgeEnnc2"> 유 </label>&nbsp;&nbsp;
                <input type="radio" id="p_indAjmdmgeEnnc1" name="indAjmdmgeEnnc" value="1" <c:if test="${suimVO.indAjmdmgeEnnc == 1}">checked</c:if>><label for="p_indAjmdmgeEnnc1"> 무 </label>
            </td>
            <td bgcolor="#E7ECF1"><b>ㆍ손해평가서류</b></td>
            <td>
                <input type="radio" id="p_docRceptAt1" name="docRceptAt" value="1" <c:if test="${suimVO.docRceptAt == 1}">checked</c:if>><label for="p_docRceptAt1"> 접수 </label>&nbsp;&nbsp;
                <input type="radio" id="p_docRceptAt2" name="docRceptAt" value="2" <c:if test="${suimVO.docRceptAt == 2}">checked</c:if>><label for="p_docRceptAt2"> 미접수 </label>
            </td>
        </tr>
        
        <tr>
            <td bgcolor="#E7ECF1"><b>ㆍ민원</b></td>
            <td>
                <input type="radio" id="p_minwonFlag1" name="pMinwonFlag" onclick="fnMinwonDateUseAt('progress');" value="0" <c:if test="${suimVO.minwonFlag == 0}">checked</c:if>><label for="p_minwonFlag1"> 없음 </label>&nbsp;&nbsp;
                <input type="radio" id="p_minwonFlag2" name="pMinwonFlag" onclick="fnMinwonDateUseAt('progress');" value="1" <c:if test="${suimVO.minwonFlag == 1}">checked</c:if>><label for="p_minwonFlag2"> 민원예상 </label>&nbsp;&nbsp;
                <input type="radio" id="p_minwonFlag3" name="pMinwonFlag" onclick="fnMinwonDateUseAt('progress');" value="2" <c:if test="${suimVO.minwonFlag == 2}">checked</c:if>><label for="p_minwonFlag3"> 민원발생</label>
            </td>
            <td bgcolor="#E7ECF1"><b>ㆍ보험사기</b></td>
            <td>
                <input type="radio" id="p_moralFlag3" name="pMoralFlag" onclick="fnMinwonDateUseAt('progress');"  value="2" <c:if test="${suimVO.moralFlag == 2}">checked</c:if>><label for="p_moralFlag3"> 해당없음</label>&nbsp;&nbsp;
                <input type="radio" id="p_moralFlag1" name="pMoralFlag" onclick="fnMinwonDateUseAt('progress');"  value="0" <c:if test="${suimVO.moralFlag == 0}">checked</c:if>><label for="p_moralFlag1"> 조사중 </label>&nbsp;&nbsp;
                <input type="radio" id="p_moralFlag2" name="pMoralFlag" onclick="fnMinwonDateUseAt('progress');"  value="1" <c:if test="${suimVO.moralFlag == 1}">checked</c:if>><label for="p_moralFlag2"> 해당 </label>
            </td>
        </tr>
        
		<tr id="edit_pMinwonDate_tr" style="display: none;">
			<td bgcolor="#E7ECF1"><b>ㆍ민원 발생일</b></td>
			<td colspan="3">
				<input type="text" id="p_minwonDate" <c:if test="${suimVO.minwonDate != 0}"> value="${suimVO.minwonDateVal}" </c:if> />
    		</td> 
			<td bgcolor="#E7ECF1" style="display:none;"><b>ㆍ공문 수신일</b></td>
			<td colspan="1" style="display:none;">
				<input type="text" id="p_moralDate" <c:if test="${suimVO.moralDate != 0}"> value="${suimVO.moralDateVal}" </c:if> />
    		</td> 
		</tr>
		
    </table>
    <%--로딩 div --%>
    <div id="loading" style="display: none;">
        <img id="loading-image" src="./resources/cmm/images/spinner.gif" alt="Loading..." />
    </div>
</div>