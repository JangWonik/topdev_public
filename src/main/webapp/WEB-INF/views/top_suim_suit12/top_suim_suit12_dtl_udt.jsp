<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	<%--<script src="./resources/daum/161109.js"></script>--%>
	<script src="./resources/daum/postcode.v2.js"></script>
	<script src='https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js'></script>
	
	<style>
		.tableStyle2 td{
			letter-spacing: 0px !important;
		}
	</style>
</head>

<script>
	$(document).ready(function(){

		$.ajaxSetup({cache:false});
		
		if ( "${getSuimSuit12DtlBsc.editYN2}" < 1 ){
			alert("접근 권한이 없습니다.");
			window.close();
			return false;
		}
		
		if( $("input:radio[name='rstPptyNvCpltYn']:checked").val() == 2 ){
			$("#notjudge").css("display","block");
		}
		
		
		$("input:radio[name='rstPptyNvCpltYn']").change(function(){
			var tmp = $("input:radio[name='rstPptyNvCpltYn']:checked").val(); 
			if(tmp != 2 || tmp == null){
				$("#notjudge").css("display","none");
			}else{
				$("#notjudge").css("display","block");
			}
			
		});
		
		
		$("#suimTmMbrPopBtn").click(function(){//담당 팀, 담당 직원 바꾸기 팝업
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=500; //띄울 창의 넓이
			var sh=550;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('suimTmMbrPop?gbNo='+$("#gbNoForPop").val()+'&smNo='+$("#smNoForPop").val()+'&tmNo='+$("#tmNoForPop").val(),'SuimTmMbrPop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		});//$("#suimTmMbrPopBtn").click

		$("#suimPtnrMbrPopBtn").click(function(){//담당 팀, 담당 직원 바꾸기 팝업
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=500; //띄울 창의 넓이
			var sh=550;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('suimPtnrMbrPop?gbNo='+$("#gbNoForPop").val()+'&smNo='+$("#smNoForPop").val()+'&ptnrNo='+$("#ptnrNoForPop").val(),'SuimTmMbrPop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		});//$("#suimPtnrMbrPopBtn").click

	});//$(document).ready

	function openSMS(hpNo){
		var cw=screen.availWidth;
		var ch=screen.availHeight;
		var sw=380; //띄울 창의 넓이
		var sh=533;  //띄울 창의 높이
		var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
		var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
		window.open('simpleSMSForm?hpNo='+hpNo,'simpleSMS','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
	}//openSMS

	function openBrdRefPtnr(ptnrSearch){
		var cw=screen.availWidth;
		var ch=screen.availHeight;
		var sw=1010; //띄울 창의 넓이
		var sh=740;  //띄울 창의 높이
		var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
		var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
		window.open('referencePtnrBoardListPop?ptnrSearch='+ptnrSearch,'simpleSMS','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
	}//openSMS
	
	$(document).ready(function(){
		$.ajaxSetup({cache:false});
		$("#edite").click(function(){
			var hiddenOjObjCntVar = $("#hiddenOjObjCnt").val();
			var hiddenBldObjCntVar = $("#hiddenBldObjCnt").val();
			
			var serialNoOjArrVar = new Array();
			var rstOj_OjTpEqalYnVar = new Array();
			var rstOj_RnkEqalYnVar = new Array();
			var rstOj_Dt_MttEqalYnVar = new Array();
			var rstOj_Dt_AccptPlcEqalYnVar = new Array();
			var rstOj_AccptPlcFlgcdEqalYnVar = new Array();
			var rstOj_FldstObjFlgcdEqalYnVar = new Array();
			var rstOj_UndgAccptYnEqalYnVar = new Array();
			var rstOj_EtMttVar = new Array();
			
			var serialNoBldArrVar = new Array();
			var rstBld_RcnDtVar = new Array();
			var rstBld_InvpsNmVar = new Array();
			var rstBld_CrRelpcRelVar = new Array();
			var rstBld_InvpsCntAdVar = new Array();
			var rstBld_RlOwrNmVar = new Array();
			var rstBld_CtnAdrVar = new Array();
			var rstBld_MngmBnNmVar = new Array();
			var rstBld_BldRnkCdVar = new Array();
			var rstBld_GrodEqalYnVar = new Array();
			var rstBld_UndgEqalYnVar = new Array();
			var rstBld_TtareEqalYnVar = new Array();
			var rstBld_IsAreEqalYnVar = new Array();
			var rstBld_IsTpEqalYnVar = new Array();
			var rstBld_RlOwrNmEtMttVar = new Array();
			var rstBld_CtnAdrEtMttVar = new Array();
			var rstBld_MngmBnnmEtMttVar = new Array();
			var rstBld_BldRnkcdEtMttVar = new Array();
			var rstBld_GrodEtMttVar = new Array();
			var rstBld_UndgEtMttVar = new Array();
			var rstBld_TtareEtMttVar = new Array();
			var rstBld_IsAreEtMttVar = new Array();
			var rstBld_IsTpEtMttVar = new Array();
			var rstBld_PleNmVar = new Array();
			var rstBld_RofNmVar = new Array();
			var rstBld_WllNmVar = new Array();
			var rstBld_PanlYnVar = new Array();
			var rstBld_PanlPstVar = new Array();
			var rstBld_TntYnVar = new Array();
			var rstBld_TntPstVar = new Array();
			var rstBld_FlrFirZoneYnVar = new Array();
			var rstBld_EtMtt1Var = new Array();
			var rstBld_FlrBtpUndgVar = new Array();
			var rstBld_FlrBtpFloor1Var = new Array();
			var rstBld_FlrBtpFloor2Var = new Array();
			var rstBld_FlrBtpFloor3Var = new Array();
			var rstBld_SlEqmtDcYnVar = new Array();
			var rstBld_MrkYnVar = new Array();
			var rstBld_EtMtt2Var = new Array();
			
			for(i = 0; i < hiddenBldObjCntVar; i++){
				serialNoBldArrVar[i] = $("#serialNoBld"+i).val();
				
				
				if($("#rstBld_RcnDt"+i).val().trim() == ''){
					rstBld_RcnDtVar[i] = ' ';
				}else{
					rstBld_RcnDtVar[i] = $("#rstBld_RcnDt"+i).val();
				}
				if($("#rstBld_InvpsNm"+i).val().trim() == ''){
					rstBld_InvpsNmVar[i] = ' ';
				}else{
					rstBld_InvpsNmVar[i] = $("#rstBld_InvpsNm"+i).val();
				}
				if($("#rstBld_CrRelpcRel"+i).val().trim() == ''){
					rstBld_CrRelpcRelVar[i] = ' ';
				}else{
					rstBld_CrRelpcRelVar[i] = $("#rstBld_CrRelpcRel"+i).val();
				}
				if($("#rstBld_InvpsCntAd"+i).val().trim() == ''){
					rstBld_InvpsCntAdVar[i] = ' ';
				}else{
					rstBld_InvpsCntAdVar[i] = $("#rstBld_InvpsCntAd"+i).val();
				}
				rstBld_RlOwrNmVar[i] = $("input:radio[id='rstBld_RlOwrNm"+i+"']:checked").val();
				rstBld_CtnAdrVar[i] = $("input:radio[id='rstBld_CtnAdr"+i+"']:checked").val();
				rstBld_MngmBnNmVar[i] = $("input:radio[id='rstBld_MngmBnNm"+i+"']:checked").val();
				rstBld_BldRnkCdVar[i] = $("input:radio[id='rstBld_BldRnkCd"+i+"']:checked").val();
				rstBld_GrodEqalYnVar[i] = $("input:radio[id='rstBld_GrodEqalYn"+i+"']:checked").val();
				rstBld_UndgEqalYnVar[i] = $("input:radio[id='rstBld_UndgEqalYn"+i+"']:checked").val();
				rstBld_TtareEqalYnVar[i] = $("input:radio[id='rstBld_TtareEqalYn"+i+"']:checked").val();
				rstBld_IsAreEqalYnVar[i] = $("input:radio[id='rstBld_IsAreEqalYn"+i+"']:checked").val();
				rstBld_IsTpEqalYnVar[i] = $("input:radio[id='rstBld_IsTpEqalYn"+i+"']:checked").val();
				if($("#rstBld_RlOwrNmEtMtt"+i).val().trim() == ''){
					rstBld_RlOwrNmEtMttVar[i] = ' ';
				}else{
					rstBld_RlOwrNmEtMttVar[i] = $("#rstBld_RlOwrNmEtMtt"+i).val();
				}
				if($("#rstBld_CtnAdrEtMtt"+i).val().trim() == ''){
					rstBld_CtnAdrEtMttVar[i] = ' ';
				}else{
					rstBld_CtnAdrEtMttVar[i] = $("#rstBld_CtnAdrEtMtt"+i).val();
				}
				if($("#rstBld_MngmBnnmEtMtt"+i).val().trim() == ''){
					rstBld_MngmBnnmEtMttVar[i] = ' ';
				}else{
					rstBld_MngmBnnmEtMttVar[i] = $("#rstBld_MngmBnnmEtMtt"+i).val();
				}
				if($("#rstBld_BldRnkcdEtMtt"+i).val().trim() == ''){
					rstBld_BldRnkcdEtMttVar[i] = ' ';
				}else{
					rstBld_BldRnkcdEtMttVar[i] = $("#rstBld_BldRnkcdEtMtt"+i).val();
				}
				if($("#rstBld_GrodEtMtt"+i).val().trim() == ''){
					rstBld_GrodEtMttVar[i] = ' ';
				}else{
					rstBld_GrodEtMttVar[i] = $("#rstBld_GrodEtMtt"+i).val();
				}
				if($("#rstBld_UndgEtMtt"+i).val().trim() == ''){
					rstBld_UndgEtMttVar[i] = ' ';
				}else{
					rstBld_UndgEtMttVar[i] = $("#rstBld_UndgEtMtt"+i).val();
				}
				if($("#rstBld_TtareEtMtt"+i).val().trim() == ''){
					rstBld_TtareEtMttVar[i] = ' ';
				}else{
					rstBld_TtareEtMttVar[i] = $("#rstBld_TtareEtMtt"+i).val();
				}
				if($("#rstBld_IsAreEtMtt"+i).val().trim() == ''){
					rstBld_IsAreEtMttVar[i] = ' ';
				}else{
					rstBld_IsAreEtMttVar[i] = $("#rstBld_IsAreEtMtt"+i).val();
				}
				if($("#rstBld_IsTpEtMtt"+i).val().trim() == ''){
					rstBld_IsTpEtMttVar[i] = ' ';
				}else{
					rstBld_IsTpEtMttVar[i] = $("#rstBld_IsTpEtMtt"+i).val();
				}
				
				rstBld_PleNmVar[i] = $("input:radio[id='rstBld_PleNm"+i+"']:checked").val();
				rstBld_RofNmVar[i] = $("input:radio[id='rstBld_RofNm"+i+"']:checked").val();
				rstBld_WllNmVar[i] = $("input:radio[id='rstBld_WllNm"+i+"']:checked").val();
				rstBld_PanlYnVar[i] = $("input:radio[id='rstBld_PanlYn"+i+"']:checked").val();
				if($("#rstBld_PanlPst"+i).val().trim() == ''){
					rstBld_PanlPstVar[i] = ' ';
				}else{
					rstBld_PanlPstVar[i] = $("#rstBld_PanlPst"+i).val();
				}
				rstBld_TntYnVar[i] = $("input:radio[id='rstBld_TntYn"+i+"']:checked").val();
				if($("#rstBld_TntPst"+i).val().trim() == ''){
					rstBld_TntPstVar[i] = ' ';
				}else{
					rstBld_TntPstVar[i] = $("#rstBld_TntPst"+i).val();
				}
				rstBld_FlrFirZoneYnVar[i] = $("input:radio[id='rstBld_FlrFirZoneYn"+i+"']:checked").val();
				if($("#rstBld_EtMtt1"+i).val().trim() == ''){
					rstBld_EtMtt1Var[i] = ' ';
				}else{
					rstBld_EtMtt1Var[i] = $("#rstBld_EtMtt1"+i).val();
				}
				if($("#rstBld_FlrBtpUndg"+i).val().trim() == ''){
					rstBld_FlrBtpUndgVar[i] = ' ';
				}else{
					rstBld_FlrBtpUndgVar[i] = $("#rstBld_FlrBtpUndg"+i).val();
				}
				if($("#rstBld_FlrBtpFloor1"+i).val().trim() == ''){
					rstBld_FlrBtpFloor1Var[i] = ' ';
				}else{
					rstBld_FlrBtpFloor1Var[i] = $("#rstBld_FlrBtpFloor1"+i).val();
				}
				if($("#rstBld_FlrBtpFloor2"+i).val().trim() == ''){
					rstBld_FlrBtpFloor2Var[i] = ' ';
				}else{
					rstBld_FlrBtpFloor2Var[i] = $("#rstBld_FlrBtpFloor2"+i).val();
				}
				if($("#rstBld_FlrBtpFloor3"+i).val().trim() == ''){
					rstBld_FlrBtpFloor3Var[i] = ' ';
				}else{
					rstBld_FlrBtpFloor3Var[i] = $("#rstBld_FlrBtpFloor3"+i).val();
				}
				rstBld_SlEqmtDcYnVar[i] = $("input:radio[id='rstBld_SlEqmtDcYn"+i+"']:checked").val();
				rstBld_MrkYnVar[i] = $("input:radio[id='rstBld_MrkYn"+i+"']:checked").val();
				if($("#rstBld_EtMtt2"+i).val().trim() == ''){
					rstBld_EtMtt2Var[i] = ' ';
				}else{
					rstBld_EtMtt2Var[i] = $("#rstBld_EtMtt2"+i).val();
				}
				
			}

			for(i = 0; i < hiddenOjObjCntVar; i++){
				serialNoOjArrVar[i] = $("#serialNoOj"+i).val();
				rstOj_OjTpEqalYnVar[i] = $("input:radio[id='rstOj_OjTpEqalYn"+i+"']:checked").val();
				rstOj_RnkEqalYnVar[i] = $("input:radio[id='rstOj_RnkEqalYn"+i+"']:checked").val();
				rstOj_Dt_MttEqalYnVar[i] = $("input:radio[id='rstOj_Dt_MttEqalYn"+i+"']:checked").val();
				rstOj_Dt_AccptPlcEqalYnVar[i] = $("input:radio[id='rstOj_Dt_AccptPlcEqalYn"+i+"']:checked").val();
				rstOj_AccptPlcFlgcdEqalYnVar[i] = $("input:radio[id='rstOj_AccptPlcFlgcdEqalYn"+i+"']:checked").val();
				rstOj_FldstObjFlgcdEqalYnVar[i] = $("input:radio[id='rstOj_FldstObjFlgcdEqalYn"+i+"']:checked").val();
				rstOj_UndgAccptYnEqalYnVar[i] = $("input:radio[id='rstOj_UndgAccptYnEqalYn"+i+"']:checked").val();
				if($("#rstOj_EtMtt"+i).val().trim() == ''){
					rstOj_EtMttVar[i] = ' ';
				}else{
					rstOj_EtMttVar[i] = $("#rstOj_EtMtt"+i).val();
				}
				
			}
			if(!window.confirm("저장하시겠습니까?")){
				return;
			}
			
			
			jQuery.ajaxSettings.traditional = true;
			$.post("./suimSuit12DtlUdtOK",
					{	
						suimRptNo       				:$("#suimRptNo").val()  //
						,bdType        					:$("input:radio[name='bdType']:checked").val()  // 
						,rstPptyNvCpltYn        		:$("input:radio[name='rstPptyNvCpltYn']:checked").val()  //
						,rstUcNspRs        				:$("input:radio[name='rstUcNspRs']:checked").val()  //
						,rstNvRst        				:$("input:radio[name='rstNvRst']:checked").val()  //
						,rstNvRstCtn         			:$("#rstNvRstCtn").val()  //
						,rstRptgFileCt         			:$("#rstRptgFileCt").val()  //
						
						,serialNoOjArr					: serialNoOjArrVar
						,rstOj_OjTpEqalYn 				: rstOj_OjTpEqalYnVar
						,rstOj_RnkEqalYn 				: rstOj_RnkEqalYnVar
						,rstOj_Dt_MttEqalYn 			: rstOj_Dt_MttEqalYnVar
						,rstOj_Dt_AccptPlcEqalYn 		: rstOj_Dt_AccptPlcEqalYnVar
						,rstOj_AccptPlcFlgcdEqalYn 		: rstOj_AccptPlcFlgcdEqalYnVar
						,rstOj_FldstObjFlgcdEqalYn 		: rstOj_FldstObjFlgcdEqalYnVar
						,rstOj_UndgAccptYnEqalYn 		: rstOj_UndgAccptYnEqalYnVar
						,rstOj_EtMtt 					: rstOj_EtMttVar
						
						,serialNoBldArr					: serialNoBldArrVar
						,rstBld_RcnDt             		: rstBld_RcnDtVar        
						,rstBld_InvpsNm           		: rstBld_InvpsNmVar      
						,rstBld_CrRelpcRel        		: rstBld_CrRelpcRelVar   
						,rstBld_InvpsCntAd        		: rstBld_InvpsCntAdVar   
						,rstBld_RlOwrNm           		: rstBld_RlOwrNmVar      
						,rstBld_CtnAdr            		: rstBld_CtnAdrVar       
						,rstBld_MngmBnNm          		: rstBld_MngmBnNmVar     
						,rstBld_BldRnkCd          		: rstBld_BldRnkCdVar     
						,rstBld_GrodEqalYn        		: rstBld_GrodEqalYnVar   
						,rstBld_UndgEqalYn        		: rstBld_UndgEqalYnVar   
						,rstBld_TtareEqalYn       		: rstBld_TtareEqalYnVar  
						,rstBld_IsAreEqalYn       		: rstBld_IsAreEqalYnVar  
						,rstBld_IsTpEqalYn        		: rstBld_IsTpEqalYnVar   
						,rstBld_RlOwrNmEtMtt      		: rstBld_RlOwrNmEtMttVar 
						,rstBld_CtnAdrEtMtt       		: rstBld_CtnAdrEtMttVar  
						,rstBld_MngmBnnmEtMtt     		: rstBld_MngmBnnmEtMttVar
						,rstBld_BldRnkcdEtMtt     		: rstBld_BldRnkcdEtMttVar
						,rstBld_GrodEtMtt         		: rstBld_GrodEtMttVar    
						,rstBld_UndgEtMtt         		: rstBld_UndgEtMttVar    
						,rstBld_TtareEtMtt        		: rstBld_TtareEtMttVar   
						,rstBld_IsAreEtMtt        		: rstBld_IsAreEtMttVar   
						,rstBld_IsTpEtMtt         		: rstBld_IsTpEtMttVar    
						,rstBld_PleNm             		: rstBld_PleNmVar        
						,rstBld_RofNm             		: rstBld_RofNmVar        
						,rstBld_WllNm             		: rstBld_WllNmVar        
						,rstBld_PanlYn            		: rstBld_PanlYnVar       
						,rstBld_PanlPst           		: rstBld_PanlPstVar      
						,rstBld_TntYn             		: rstBld_TntYnVar        
						,rstBld_TntPst            		: rstBld_TntPstVar       
						,rstBld_FlrFirZoneYn      		: rstBld_FlrFirZoneYnVar 
						,rstBld_EtMtt1            		: rstBld_EtMtt1Var       
						,rstBld_FlrBtpUndg        		: rstBld_FlrBtpUndgVar   
						,rstBld_FlrBtpFloor1      		: rstBld_FlrBtpFloor1Var 
						,rstBld_FlrBtpFloor2      		: rstBld_FlrBtpFloor2Var 
						,rstBld_FlrBtpFloor3      		: rstBld_FlrBtpFloor3Var 
						,rstBld_SlEqmtDcYn        		: rstBld_SlEqmtDcYnVar   
						,rstBld_MrkYn           		: rstBld_MrkYnVar        
						,rstBld_EtMtt2                  : rstBld_EtMtt2Var       
						
					},
					
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{
								alert("수정되었습니다.");
								location.href = "topSuimSuit12Dtl?suimRptNo="+$("#suimRptNo").val();
								window.opener.location.reload();
								//window.location.reload();
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}//function
			);//post
		});
	
	/* 취소 버튼 동작 */
	$("#cancel").click(function(){
		history.back();
	});
		
	/* 수정 확인 버튼 동작 */
	$("#edite2").click(function(){
		$.post("./suimSuit17DtlUdtOK",
				{	
					suimRptNo       :$("#suimRptNo").val()  //
					,testrjh : rstOj_UndgAccptYnEqalYnVar
					,report1        :$("input:radio[name='report1']:checked").val()  // 
					,reC         	:$("#reC").val()  //
					,reF           	:$("#reF").val() // 
					,reG           	:$("#reG").val() // 
					,reH         	:$("input:radio[name='reH']:checked").val()  // 
					,reI           	:$("#reI").val() // 
					,reJ         	:$("input:radio[name='reJ']:checked").val()  // 
					,reK           	:$("#reK").val() // 
					,reL         	:$("input:radio[name='reL']:checked").val()  //
					,reP         	:$("input:radio[name='reP']:checked").val()  //
					,reQ           	:$("#reQ").val() // 
					,reP         	:$("input:radio[name='reP']:checked").val()  //
					,reT         	:$("input:radio[name='reT']:checked").val()  //
					,reU           	:$("#reU").val() //
					,reV         	:$("input:radio[name='reV']:checked").val()  //
					,reW           	:$("#reW").val() //
					,reX           	:$("#reX").val() //
					,reY           	:$("#reY").val() //
					,reZ           	:$("#reZ").val() //
					,reAa           :$("#reAa").val() //
					,reAb           :$("#reAb").val() //
					,reAc           :$("#reAc").val() //
					
				},
				function(data,status){
					if(status == "success"){
						if(data == 0){
							alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
						}else{
							alert("수정되었습니다.");
							location.href = "topSuimSuit17Dtl?suimRptNo="+$("#suimRptNo").val();
							window.opener.location.reload();
							//window.location.reload();
						}
					}else{
						alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
					}
				}//function
		);//post
	});
	});//$(document).ready
</script>

<c:set var="suimRptNo" value="${suimRptNo}"/>
<body>

	<!-- header -->
	<div id="headerpop_mbr">
		<div class="inner clear_v2">
			<h1>
				<img src="./resources/wm_img/common/logo.gif" height="40" alt="top - TRUST OBLIGATION PASSION" />
			</h1>
			<div style="text-align:center;padding-top:10px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
				<font color="white"><b><span style="font-size:11pt;"> 장기 물보험 적부 시스템</span></b></font>
			</div>
		</div>
	</div>
	<!-- //header -->

	<!-- center -->
	<div id ="container">
		<div class="contetnsPop">
			<div class="center_cnt">
				<div class="centercnt_bot1-3">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">적부(한화) 기본정보</a></li>
							</ul>
						</div>

						<div class="guestcnt5" style="display:block;">

						<div class= "tableStyle21">
							<table>
								<colgroup>
									<col width="20%">
									<col width="30%">
									<col width="15%">
									<col width="20%">
								</colgroup>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ접수번호</b></td>
									<td colspan="3" style="border-right:0;">
										${getSuimSuit12DtlBsc.suimAcceptNo}
									</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ처리팀</b></td>
									<td>${getSuimSuit12DtlBsc.teamName}</td>
									<td bgcolor="#E7ECF1"><b>ㆍ처리 담당자</b></td>
									<td style="border-right:0;">
										${getSuimSuit12DtlBsc.userName}
									</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ보험사</b></td>
									<td colspan="3">
										${getSuimSuit12DtlBsc.ptnrName}
									</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ물건구분</b></td>
									<td colspan="3">
										<input type="radio" id="bdType" name="bdType" value="1"
										<c:if test="${getSuimSuit12DtlBsc.bdType eq '1'}">checked="checked"
										</c:if>/>
										일반&nbsp;&nbsp;
										<input type="radio" id="bdType" name="bdType" value="2"
										<c:if test="${getSuimSuit12DtlBsc.bdType eq '2'}">checked="checked"
										</c:if>/>
										공장&nbsp;&nbsp;
										<input type="radio" id="bdType" name="bdType" value="0"
										<c:if test="${getSuimSuit12DtlBsc.bdType eq '0'}">checked="checked"
										</c:if>/>
										해당없음
									</td>
								</tr>
								
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ조사완료여부</b></td>
									<td colspan="3">
										<input type="radio" id="rstPptyNvCpltYn" name="rstPptyNvCpltYn" value="1"
										<c:if test="${getSuimSuit12DtlBsc.rstPptyNvCpltYn eq '1'}">checked="checked"
										</c:if>/>
										완료&nbsp;&nbsp;
										<input type="radio" id="rstPptyNvCpltYn" name="rstPptyNvCpltYn" value="2"
										<c:if test="${getSuimSuit12DtlBsc.rstPptyNvCpltYn eq '2'}">checked="checked"
										</c:if>/>
										미수검&nbsp;&nbsp;
										<input type="radio" id="rstPptyNvCpltYn" name="rstPptyNvCpltYn" value=""
										<c:if test="${getSuimSuit12DtlBsc.rstPptyNvCpltYn eq ''}">checked="checked"
										</c:if>/>
										해당없음
									</td>
								</tr>
								
								<tr id="notjudge" style="display:none;">
									<td bgcolor="#DCFFDC"><b>ㆍ미심사사유코드</b></td>
									<td colspan="3">
										<input type="radio" id="rstUcNspRs" name="rstUcNspRs" value="01"
										<c:if test="${getSuimSuit12DtlBsc.rstUcNspRs eq '01'}">checked="checked"
										</c:if>/>
										고객의 방문거절(조사거부 포함)&nbsp;&nbsp;
										<input type="radio" id="rstUcNspRs" name="rstUcNspRs" value="02"
										<c:if test="${getSuimSuit12DtlBsc.rstUcNspRs eq '02'}">checked="checked"
										</c:if>/>
										연락불가(전화번호오류 포함)&nbsp;&nbsp;
										<input type="radio" id="rstUcNspRs" name="rstUcNspRs" value="03"
										<c:if test="${getSuimSuit12DtlBsc.rstUcNspRs eq '03'}">checked="checked"
										</c:if>/>
										계약취소&nbsp;&nbsp;
										<input type="radio" id="rstUcNspRs" name="rstUcNspRs" value=""
										<c:if test="${getSuimSuit12DtlBsc.rstUcNspRs eq ''}">checked="checked"
										</c:if>/>
										해당없음
									</td>
								</tr>
								
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ적부조사결과코드</b></td>
									<td colspan="3">
										<input type="radio" id="rstNvRst" name="rstNvRst" value="01"
										<c:if test="${getSuimSuit12DtlBsc.rstNvRst eq '01'}">checked="checked"
										</c:if>/>
										양호(일치)&nbsp;&nbsp;
										<input type="radio" id="rstNvRst" name="rstNvRst" value="02"
										<c:if test="${getSuimSuit12DtlBsc.rstNvRst eq '02'}">checked="checked"
										</c:if>/>
										수정필요(불일치)&nbsp;&nbsp;
										<input type="radio" id="rstNvRst" name="rstNvRst" value=""
										<c:if test="${getSuimSuit12DtlBsc.rstNvRst eq ''}">checked="checked"
										</c:if>/>
										해당없음
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ적부조사결과의견</b></td>
									<td colspan="3">
										<input type="text" id="rstNvRstCtn" name="rstNvRstCtn" style="width:90%" value="${getSuimSuit12DtlBsc.rstNvRstCtn}"/>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ파일갯수</b></td>
									<td colspan="3">
										<input type="text" id="rstRptgFileCt" name="rstRptgFileCt" style="width:5%" value="${getSuimSuit12DtlBsc.rstRptgFileCt}"/>개
										<input type="hidden" id="suimRptNo" name="suimRptNo" value="${suimRptNo}"/>
									</td>
								</tr>
							</table>
						</div>
						<br>
						
						<div class= "tableStyle21">
							<table>
								<colgroup>
									<col width="25%">
									<col width="75%">
								</colgroup>
							<c:forEach items="${getSuimSuit12DtlBldList}" var="getSuimSuit12DtlBld" varStatus="status">
								<tr>
									<td bgcolor="#E4CAFF" colspan="2"><b>ㆍ건물 ${status.index + 1} 계약사항</b>
									<input type="hidden" id="hiddenBldObjCnt" name="hiddenBldObjCnt" value="${getSuimSuit12DtlBldList.size()}" />
									<input type="hidden" id="serialNoBld${status.index}" name="serialNoBld${status.index}" value="${getSuimSuit12DtlBld.getSerialNo()}" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ실사일자</b></td>
									<td>
										<input type="text" id="rstBld_RcnDt${status.index}" name="rstBld_RcnDt${status.index}" class="rstBld_RcnDt" style="width:13%" value="${getSuimSuit12DtlBld.getRstBld_RcnDt()}"/>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ면담자명</b></td>
									<td>
										<input type="text" id="rstBld_InvpsNm${status.index}" name="rstBld_InvpsNm${status.index}" value="${getSuimSuit12DtlBld.getRstBld_InvpsNm()}"/>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ계약자와의관계</b></td>
									<td>
										<input type="text" id="rstBld_CrRelpcRel${status.index}" name="rstBld_CrRelpcRel${status.index}" value="${getSuimSuit12DtlBld.getRstBld_CrRelpcRel()}"/>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ면담자연락처</b></td>
									<td>
										<input type="text" id="rstBld_InvpsCntAd${status.index}" name="rstBld_InvpsCntAd${status.index}" value="${getSuimSuit12DtlBld.getRstBld_InvpsCntAd()}"/>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ실제소유자 일치여부</b></td>
									<td>
										<input type="radio" id="rstBld_RlOwrNm${status.index}" name="rstBld_RlOwrNm${status.index}" value="1"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_RlOwrNm() eq '1'}">checked="checked"
										</c:if>/>
										일치&nbsp;&nbsp;
										<input type="radio" id="rstBld_RlOwrNm${status.index}" name="rstBld_RlOwrNm${status.index}" value="2"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_RlOwrNm() eq '2'}">checked="checked"
										</c:if>/>
										불일치&nbsp;&nbsp;
										<input type="radio" id="rstBld_RlOwrNm${status.index}" name="rstBld_RlOwrNm${status.index}" value="3"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_RlOwrNm() eq '3'}">checked="checked"
										</c:if>/>
										미확인&nbsp;&nbsp;
										<input type="radio" id="rstBld_RlOwrNm${status.index}" name="rstBld_RlOwrNm${status.index}" value="0"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_RlOwrNm() eq '0' || getSuimSuit12DtlBld.getRstBld_RlOwrNm() eq ''}">checked="checked"
										</c:if>/>
										해당없음
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ소재지주소 일치여부</b></td>
									<td>
										<input type="radio" id="rstBld_CtnAdr${status.index}" name="rstBld_CtnAdr${status.index}" value="1"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_CtnAdr() eq '1'}">checked="checked"
										</c:if>/>
										일치&nbsp;&nbsp;
										<input type="radio" id="rstBld_CtnAdr${status.index}" name="rstBld_CtnAdr${status.index}" value="2"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_CtnAdr() eq '2'}">checked="checked"
										</c:if>/>
										불일치&nbsp;&nbsp;
										<input type="radio" id="rstBld_CtnAdr${status.index}" name="rstBld_CtnAdr${status.index}" value="3"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_CtnAdr() eq '3'}">checked="checked"
										</c:if>/>
										미확인&nbsp;&nbsp;
										<input type="radio" id="rstBld_CtnAdr${status.index}" name="rstBld_CtnAdr${status.index}" value="0"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_CtnAdr() eq '0' || getSuimSuit12DtlBld.getRstBld_CtnAdr() eq ''}">checked="checked"
										</c:if>/>
										해당없음
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ영위업종명 일치여부</b></td>
									<td>
										<input type="radio" id="rstBld_MngmBnNm${status.index}" name="rstBld_MngmBnNm${status.index}" value="1"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_MngmBnNm() eq '1'}">checked="checked"
										</c:if>/>
										일치&nbsp;&nbsp;
										<input type="radio" id="rstBld_MngmBnNm${status.index}" name="rstBld_MngmBnNm${status.index}" value="2"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_MngmBnNm() eq '2'}">checked="checked"
										</c:if>/>
										불일치&nbsp;&nbsp;
										<input type="radio" id="rstBld_MngmBnNm${status.index}" name="rstBld_MngmBnNm${status.index}" value="3"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_MngmBnNm() eq '3'}">checked="checked"
										</c:if>/>
										미확인&nbsp;&nbsp;
										<input type="radio" id="rstBld_MngmBnNm${status.index}" name="rstBld_MngmBnNm${status.index}" value="0"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_MngmBnNm() eq '0' || getSuimSuit12DtlBld.getRstBld_MngmBnNm() eq ''}">checked="checked"
										</c:if>/>
										해당없음
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ건물급수 일치여부</b></td>
									<td>
										<input type="radio" id="rstBld_BldRnkCd${status.index}" name="rstBld_BldRnkCd${status.index}" value="1"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_BldRnkCd() eq '1'}">checked="checked"
										</c:if>/>
										일치&nbsp;&nbsp;
										<input type="radio" id="rstBld_BldRnkCd${status.index}" name="rstBld_BldRnkCd${status.index}" value="2"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_BldRnkCd() eq '2'}">checked="checked"
										</c:if>/>
										불일치&nbsp;&nbsp;
										<input type="radio" id="rstBld_BldRnkCd${status.index}" name="rstBld_BldRnkCd${status.index}" value="3"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_BldRnkCd() eq '3'}">checked="checked"
										</c:if>/>
										미확인&nbsp;&nbsp;
										<input type="radio" id="rstBld_BldRnkCd${status.index}" name="rstBld_BldRnkCd${status.index}" value="0"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_BldRnkCd() eq '0' || getSuimSuit12DtlBld.getRstBld_BldRnkCd() eq ''}">checked="checked"
										</c:if>/>
										해당없음
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ건물규모 지상(층) 일치여부</b></td>
									<td>
										<input type="radio" id="rstBld_GrodEqalYn${status.index}" name="rstBld_GrodEqalYn${status.index}" value="1"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_GrodEqalYn() eq '1'}">checked="checked"
										</c:if>/>
										일치&nbsp;&nbsp;
										<input type="radio" id="rstBld_GrodEqalYn${status.index}" name="rstBld_GrodEqalYn${status.index}" value="2"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_GrodEqalYn() eq '2'}">checked="checked"
										</c:if>/>
										불일치&nbsp;&nbsp;
										<input type="radio" id="rstBld_GrodEqalYn${status.index}" name="rstBld_GrodEqalYn${status.index}" value="3"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_GrodEqalYn() eq '3'}">checked="checked"
										</c:if>/>
										미확인&nbsp;&nbsp;
										<input type="radio" id="rstBld_GrodEqalYn${status.index}" name="rstBld_GrodEqalYn${status.index}" value="0"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_GrodEqalYn() eq '0' || getSuimSuit12DtlBld.getRstBld_GrodEqalYn() eq ''}">checked="checked"
										</c:if>/>
										해당없음
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ건물규모 지하(층) 일치여부</b></td>
									<td>
										<input type="radio" id="rstBld_UndgEqalYn${status.index}" name="rstBld_UndgEqalYn${status.index}" value="1"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_UndgEqalYn() eq '1'}">checked="checked"
										</c:if>/>
										일치&nbsp;&nbsp;
										<input type="radio" id="rstBld_UndgEqalYn${status.index}" name="rstBld_UndgEqalYn${status.index}" value="2"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_UndgEqalYn() eq '2'}">checked="checked"
										</c:if>/>
										불일치&nbsp;&nbsp;
										<input type="radio" id="rstBld_UndgEqalYn${status.index}" name="rstBld_UndgEqalYn${status.index}" value="3"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_UndgEqalYn() eq '3'}">checked="checked"
										</c:if>/>
										미확인&nbsp;&nbsp;
										<input type="radio" id="rstBld_UndgEqalYn${status.index}" name="rstBld_UndgEqalYn${status.index}" value="0"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_UndgEqalYn() eq '0' || getSuimSuit12DtlBld.getRstBld_UndgEqalYn() eq ''}">checked="checked"
										</c:if>/>
										해당없음
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ건물규모 연면적(㎡) 일치여부</b></td>
									<td>
										<input type="radio" id="rstBld_TtareEqalYn${status.index}" name="rstBld_TtareEqalYn${status.index}" value="1"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_TtareEqalYn() eq '1'}">checked="checked"
										</c:if>/>
										일치&nbsp;&nbsp;
										<input type="radio" id="rstBld_TtareEqalYn${status.index}" name="rstBld_TtareEqalYn${status.index}" value="2"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_TtareEqalYn() eq '2'}">checked="checked"
										</c:if>/>
										불일치&nbsp;&nbsp;
										<input type="radio" id="rstBld_TtareEqalYn${status.index}" name="rstBld_TtareEqalYn${status.index}" value="3"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_TtareEqalYn() eq '3'}">checked="checked"
										</c:if>/>
										미확인&nbsp;&nbsp;
										<input type="radio" id="rstBld_TtareEqalYn${status.index}" name="rstBld_TtareEqalYn${status.index}" value="0"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_TtareEqalYn() eq '0' || getSuimSuit12DtlBld.getRstBld_TtareEqalYn() eq ''}">checked="checked"
										</c:if>/>
										해당없음
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ건물규모 가입면적 일치여부</b></td>
									<td>
										<input type="radio" id="rstBld_IsAreEqalYn${status.index}" name="rstBld_IsAreEqalYn${status.index}" value="1"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_IsAreEqalYn() eq '1'}">checked="checked"
										</c:if>/>
										일치&nbsp;&nbsp;
										<input type="radio" id="rstBld_IsAreEqalYn${status.index}" name="rstBld_IsAreEqalYn${status.index}" value="2"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_IsAreEqalYn() eq '2'}">checked="checked"
										</c:if>/>
										불일치&nbsp;&nbsp;
										<input type="radio" id="rstBld_IsAreEqalYn${status.index}" name="rstBld_IsAreEqalYn${status.index}" value="3"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_IsAreEqalYn() eq '3'}">checked="checked"
										</c:if>/>
										미확인&nbsp;&nbsp;
										<input type="radio" id="rstBld_IsAreEqalYn${status.index}" name="rstBld_IsAreEqalYn${status.index}" value="0"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_IsAreEqalYn() eq '0' || getSuimSuit12DtlBld.getRstBld_IsAreEqalYn() eq ''}">checked="checked"
										</c:if>/>
										해당없음
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ건물규모 가입유형 일치여부</b></td>
									<td>
										<input type="radio" id="rstBld_IsTpEqalYn${status.index}" name="rstBld_IsTpEqalYn${status.index}" value="1"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_IsTpEqalYn() eq '1'}">checked="checked"
										</c:if>/>
										일치&nbsp;&nbsp;
										<input type="radio" id="rstBld_IsTpEqalYn${status.index}" name="rstBld_IsTpEqalYn${status.index}" value="2"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_IsTpEqalYn() eq '2'}">checked="checked"
										</c:if>/>
										불일치&nbsp;&nbsp;
										<input type="radio" id="rstBld_IsTpEqalYn${status.index}" name="rstBld_IsTpEqalYn${status.index}" value="3"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_IsTpEqalYn() eq '3'}">checked="checked"
										</c:if>/>
										미확인&nbsp;&nbsp;
										<input type="radio" id="rstBld_IsTpEqalYn${status.index}" name="rstBld_IsTpEqalYn${status.index}" value="0"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_IsTpEqalYn() eq '0' || getSuimSuit12DtlBld.getRstBld_IsTpEqalYn() eq ''}">checked="checked"
										</c:if>/>
										해당없음
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ실제소유자 기타의견</b></td>
									<td>
										<input type="text" id="rstBld_RlOwrNmEtMtt${status.index}" name="rstBld_RlOwrNmEtMtt${status.index}" style="width:90%" value="${getSuimSuit12DtlBld.getRstBld_RlOwrNmEtMtt()}"/>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ소재지주소 기타의견</b></td>
									<td>
										<input type="text" id="rstBld_CtnAdrEtMtt${status.index}" name="rstBld_CtnAdrEtMtt${status.index}" style="width:90%" value="${getSuimSuit12DtlBld.getRstBld_CtnAdrEtMtt()}"/>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ영위업종명 기타의견</b></td>
									<td>
										<input type="text" id="rstBld_MngmBnnmEtMtt${status.index}" name="rstBld_MngmBnnmEtMtt${status.index}" style="width:90%" value="${getSuimSuit12DtlBld.getRstBld_MngmBnnmEtMtt()}"/>
										<br>
										<font color="red">건물구분이 <b>공장</b>일 경우 공장물건조사에 준하여 조사하세요</font>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ건물급수 기타의견</b></td>
									<td>
										<input type="text" id="rstBld_BldRnkcdEtMtt${status.index}" name="rstBld_BldRnkcdEtMtt${status.index}" style="width:90%" value="${getSuimSuit12DtlBld.getRstBld_BldRnkcdEtMtt()}"/>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ건물규모 지상(층) 기타의견</b></td>
									<td>
										<input type="text" id="rstBld_GrodEtMtt${status.index}" name="rstBld_GrodEtMtt${status.index}" style="width:90%" value="${getSuimSuit12DtlBld.getRstBld_GrodEtMtt()}"/>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ건물규모 지하(층) 기타의견</b></td>
									<td>
										<input type="text" id="rstBld_UndgEtMtt${status.index}" name="rstBld_UndgEtMtt${status.index}" style="width:90%" value="${getSuimSuit12DtlBld.getRstBld_UndgEtMtt()}"/>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ건물규모 연면적(㎡) 기타의견</b></td>
									<td>
										<input type="text" id="rstBld_TtareEtMtt${status.index}" name="rstBld_TtareEtMtt${status.index}" style="width:90%" value="${getSuimSuit12DtlBld.getRstBld_TtareEtMtt()}"/>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ건물규모 가입면적 기타의견</b></td>
									<td>
										<input type="text" id="rstBld_IsAreEtMtt${status.index}" name="rstBld_IsAreEtMtt${status.index}" style="width:90%" value="${getSuimSuit12DtlBld.getRstBld_IsAreEtMtt()}"/>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ건물규모 가입유형 기타의견</b></td>
									<td>
										<input type="text" id="rstBld_IsTpEtMtt${status.index}" name="rstBld_IsTpEtMtt${status.index}" style="width:90%" value="${getSuimSuit12DtlBld.getRstBld_IsTpEtMtt()}"/>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ건물구조 기둥 일치여부</b></td>
									<td>
										<input type="radio" id="rstBld_PleNm${status.index}" name="rstBld_PleNm${status.index}" value="1"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_PleNm() eq '1'}">checked="checked"
										</c:if>/>
										일치&nbsp;&nbsp;
										<input type="radio" id="rstBld_PleNm${status.index}" name="rstBld_PleNm${status.index}" value="2"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_PleNm() eq '2'}">checked="checked"
										</c:if>/>
										불일치&nbsp;&nbsp;
										<input type="radio" id="rstBld_PleNm${status.index}" name="rstBld_PleNm${status.index}" value="3"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_PleNm() eq '3'}">checked="checked"
										</c:if>/>
										미확인&nbsp;&nbsp;
										<input type="radio" id="rstBld_PleNm${status.index}" name="rstBld_PleNm${status.index}" value="0"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_PleNm() eq '0' || getSuimSuit12DtlBld.getRstBld_PleNm() eq ''}">checked="checked"
										</c:if>/>
										해당없음
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ건물구조 지붕 일치여부</b></td>
									<td>
										<input type="radio" id="rstBld_RofNm${status.index}" name="rstBld_RofNm${status.index}" value="1"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_RofNm() eq '1'}">checked="checked"
										</c:if>/>
										일치&nbsp;&nbsp;
										<input type="radio" id="rstBld_RofNm${status.index}" name="rstBld_RofNm${status.index}" value="2"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_RofNm() eq '2'}">checked="checked"
										</c:if>/>
										불일치&nbsp;&nbsp;
										<input type="radio" id="rstBld_RofNm${status.index}" name="rstBld_RofNm${status.index}" value="3"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_RofNm() eq '3'}">checked="checked"
										</c:if>/>
										미확인&nbsp;&nbsp;
										<input type="radio" id="rstBld_RofNm${status.index}" name="rstBld_RofNm${status.index}" value="0"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_RofNm() eq '0' || getSuimSuit12DtlBld.getRstBld_RofNm() eq ''}">checked="checked"
										</c:if>/>
										해당없음
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ건물구조 외벽 일치여부</b></td>
									<td>
										<input type="radio" id="rstBld_WllNm${status.index}" name="rstBld_WllNm${status.index}" value="1"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_WllNm() eq '1'}">checked="checked"
										</c:if>/>
										일치&nbsp;&nbsp;
										<input type="radio" id="rstBld_WllNm${status.index}" name="rstBld_WllNm${status.index}" value="2"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_WllNm() eq '2'}">checked="checked"
										</c:if>/>
										불일치&nbsp;&nbsp;
										<input type="radio" id="rstBld_WllNm${status.index}" name="rstBld_WllNm${status.index}" value="3"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_WllNm() eq '3'}">checked="checked"
										</c:if>/>
										미확인&nbsp;&nbsp;
										<input type="radio" id="rstBld_WllNm${status.index}" name="rstBld_WllNm${status.index}" value="0"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_WllNm() eq '0' || getSuimSuit12DtlBld.getRstBld_WllNm() eq ''}">checked="checked"
										</c:if>/>
										해당없음
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ판넬 유무</b></td>
									<td>
										<input type="radio" id="rstBld_PanlYn${status.index}" name="rstBld_PanlYn${status.index}" value="1"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_PanlYn() eq '1'}">checked="checked"
										</c:if>/>
										유&nbsp;&nbsp;
										<input type="radio" id="rstBld_PanlYn${status.index}" name="rstBld_PanlYn${status.index}" value="2"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_PanlYn() eq '2'}">checked="checked"
										</c:if>/>
										무&nbsp;&nbsp;
										<input type="radio" id="rstBld_PanlYn${status.index}" name="rstBld_PanlYn${status.index}" value="3"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_PanlYn() eq '3'}">checked="checked"
										</c:if>/>
										미확인&nbsp;&nbsp;
										<input type="radio" id="rstBld_PanlYn${status.index}" name="rstBld_PanlYn${status.index}" value="0"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_PanlYn() eq '0' || getSuimSuit12DtlBld.getRstBld_PanlYn() eq ''}">checked="checked"
										</c:if>/>
										해당없음
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ판넬 위치</b></td>
									<td>
										<input type="text" id="rstBld_PanlPst${status.index}" name="rstBld_PanlPst${status.index}" style="width:90%" value="${getSuimSuit12DtlBld.getRstBld_PanlPst()}"/>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ천막 유무</b></td>
									<td>
										<input type="radio" id="rstBld_TntYn${status.index}" name="rstBld_TntYn${status.index}" value="1"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_TntYn() eq '1'}">checked="checked"
										</c:if>/>
										유&nbsp;&nbsp;
										<input type="radio" id="rstBld_TntYn${status.index}" name="rstBld_TntYn${status.index}" value="2"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_TntYn() eq '2'}">checked="checked"
										</c:if>/>
										무&nbsp;&nbsp;
										<input type="radio" id="rstBld_TntYn${status.index}" name="rstBld_TntYn${status.index}" value="3"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_TntYn() eq '3'}">checked="checked"
										</c:if>/>
										미확인&nbsp;&nbsp;
										<input type="radio" id="rstBld_TntYn${status.index}" name="rstBld_TntYn${status.index}" value="0"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_TntYn() eq '0' || getSuimSuit12DtlBld.getRstBld_TntYn() eq ''}">checked="checked"
										</c:if>/>
										해당없음
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ천막 위치</b></td>
									<td>
										<input type="text" id="rstBld_TntPst${status.index}" name="rstBld_TntPst${status.index}" style="width:90%" value="${getSuimSuit12DtlBld.getRstBld_TntPst()}"/>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ층별방화구획유무</b></td>
									<td>
										<input type="radio" id="rstBld_FlrFirZoneYn${status.index}" name="rstBld_FlrFirZoneYn${status.index}" value="1"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_FlrFirZoneYn() eq '1'}">checked="checked"
										</c:if>/>
										유&nbsp;&nbsp;
										<input type="radio" id="rstBld_FlrFirZoneYn${status.index}" name="rstBld_FlrFirZoneYn${status.index}" value="2"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_FlrFirZoneYn() eq '2'}">checked="checked"
										</c:if>/>
										무&nbsp;&nbsp;
										<input type="radio" id="rstBld_FlrFirZoneYn${status.index}" name="rstBld_FlrFirZoneYn${status.index}" value="3"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_FlrFirZoneYn() eq '3'}">checked="checked"
										</c:if>/>
										미확인&nbsp;&nbsp;
										<input type="radio" id="rstBld_FlrFirZoneYn${status.index}" name="rstBld_FlrFirZoneYn${status.index}" value="0"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_FlrFirZoneYn() eq '0' || getSuimSuit12DtlBld.getRstBld_FlrFirZoneYn() eq ''}">checked="checked"
										</c:if>/>
										해당없음
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ기타의견1</b></td>
									<td>
										<input type="text" id="rstBld_EtMtt1${status.index}" name="rstBld_EtMtt1${status.index}" style="width:90%" value="${getSuimSuit12DtlBld.getRstBld_EtMtt1()}"/>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ층별업종 지하</b></td>
									<td>
										<input type="text" id="rstBld_FlrBtpUndg${status.index}" name="rstBld_FlrBtpUndg${status.index}" style="width:90%" value="${getSuimSuit12DtlBld.getRstBld_FlrBtpUndg()}"/>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ층별업종 1층</b></td>
									<td>
										<input type="text" id="rstBld_FlrBtpFloor1${status.index}" name="rstBld_FlrBtpFloor1${status.index}" style="width:90%" value="${getSuimSuit12DtlBld.getRstBld_FlrBtpFloor1()}"/>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ층별업종 2층</b></td>
									<td>
										<input type="text" id="rstBld_FlrBtpFloor2${status.index}" name="rstBld_FlrBtpFloor2${status.index}" style="width:90%" value="${getSuimSuit12DtlBld.getRstBld_FlrBtpFloor2()}"/>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ층별업종 3층</b></td>
									<td>
										<input type="text" id="rstBld_FlrBtpFloor3${status.index}" name="rstBld_FlrBtpFloor3${status.index}" style="width:90%" value="${getSuimSuit12DtlBld.getRstBld_FlrBtpFloor3()}"/>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ판매시설 상설할인유무</b></td>
									<td>
										<input type="radio" id="rstBld_SlEqmtDcYn${status.index}" name="rstBld_SlEqmtDcYn${status.index}" value="1"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_SlEqmtDcYn() eq '1'}">checked="checked"
										</c:if>/>
										유&nbsp;&nbsp;
										<input type="radio" id="rstBld_SlEqmtDcYn${status.index}" name="rstBld_SlEqmtDcYn${status.index}" value="2"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_SlEqmtDcYn() eq '2'}">checked="checked"
										</c:if>/>
										무&nbsp;&nbsp;
										<input type="radio" id="rstBld_SlEqmtDcYn${status.index}" name="rstBld_SlEqmtDcYn${status.index}" value="3"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_SlEqmtDcYn() eq '3'}">checked="checked"
										</c:if>/>
										미확인&nbsp;&nbsp;
										<input type="radio" id="rstBld_SlEqmtDcYn${status.index}" name="rstBld_SlEqmtDcYn${status.index}" value="0"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_SlEqmtDcYn() eq '0' || getSuimSuit12DtlBld.getRstBld_SlEqmtDcYn() eq ''}">checked="checked"
										</c:if>/>
										해당없음
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ판매시설 재래시장유무</b></td>
									<td>
										<input type="radio" id="rstBld_MrkYn${status.index}" name="rstBld_MrkYn${status.index}" value="1"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_MrkYn() eq '1'}">checked="checked"
										</c:if>/>
										유&nbsp;&nbsp;
										<input type="radio" id="rstBld_MrkYn${status.index}" name="rstBld_MrkYn${status.index}" value="2"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_MrkYn() eq '2'}">checked="checked"
										</c:if>/>
										무&nbsp;&nbsp;
										<input type="radio" id="rstBld_MrkYn${status.index}" name="rstBld_MrkYn${status.index}" value="3"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_MrkYn() eq '3'}">checked="checked"
										</c:if>/>
										미확인&nbsp;&nbsp;
										<input type="radio" id="rstBld_MrkYn${status.index}" name="rstBld_MrkYn${status.index}" value="0"
										<c:if test="${getSuimSuit12DtlBld.getRstBld_MrkYn() eq '0' || getSuimSuit12DtlBld.getRstBld_MrkYn() eq ''}">checked="checked"
										</c:if>/>
										해당없음
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ기타의견2</b></td>
									<td>
										<input type="text" id="rstBld_EtMtt2${status.index}" name="rstBld_EtMtt2${status.index}" style="width:90%" value="${getSuimSuit12DtlBld.getRstBld_EtMtt2()}"/>
									</td>
								</tr>
							</c:forEach>
								
								
							</table>
						</div>
						<br>
						<div class= "tableStyle21">
							<table>
								<colgroup>
									<col width="25%">
									<col width="75%">
								</colgroup>
								<c:forEach items="${getSuimSuit12DtlOjList}" var="getSuimSuit12DtlOj" varStatus="status">
								
								<tr>
									<td bgcolor="#E4CAFF" colspan="2"><b>ㆍ목적물 ${status.index + 1} 계약사항</b>
										<input type="hidden" id="hiddenOjObjCnt" name="hiddenOjObjCnt" value="${getSuimSuit12DtlOjList.size()}" />
										<input type="hidden" id="serialNoOj${status.index}" name="serialNoOj${status.index}" value="${getSuimSuit12DtlOj.getSerialNo()}"/>
									</td>
								</tr>
								
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ목적물유형 일치여부</b></td>
									<td>
										<input type="radio" id="rstOj_OjTpEqalYn${status.index}" name="rstOj_OjTpEqalYn${status.index}" value="1"
										<c:if test="${getSuimSuit12DtlOj.getRstOj_OjTpEqalYn() eq '1'}">checked="checked"
										</c:if>/>
										일치&nbsp;&nbsp;
										<input type="radio" id="rstOj_OjTpEqalYn${status.index}" name="rstOj_OjTpEqalYn${status.index}" value="2"
										<c:if test="${getSuimSuit12DtlOj.getRstOj_OjTpEqalYn() eq '2'}">checked="checked"
										</c:if>/>
										불일치&nbsp;&nbsp;
										<input type="radio" id="rstOj_OjTpEqalYn${status.index}" name="rstOj_OjTpEqalYn${status.index}" value="3"
										<c:if test="${getSuimSuit12DtlOj.getRstOj_OjTpEqalYn() eq '3'}">checked="checked"
										</c:if>/>
										미확인&nbsp;&nbsp;
										<input type="radio" id="rstOj_OjTpEqalYn${status.index}" name="rstOj_OjTpEqalYn${status.index}" value="0"
										<c:if test="${getSuimSuit12DtlOj.getRstOj_OjTpEqalYn() eq '0' || getSuimSuit12DtlOj.getRstOj_OjTpEqalYn() eq ''}">checked="checked"
										</c:if>/>
										해당없음
									</td>
								</tr>
								
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ급수 일치여부</b></td>
									<td>
										<input type="radio" id="rstOj_RnkEqalYn${status.index}" name="rstOj_RnkEqalYn${status.index}" value="1"
										<c:if test="${getSuimSuit12DtlOj.getRstOj_RnkEqalYn() eq '1'}">checked="checked"
										</c:if>/>
										일치&nbsp;&nbsp;
										<input type="radio" id="rstOj_RnkEqalYn${status.index}" name="rstOj_RnkEqalYn${status.index}" value="2"
										<c:if test="${getSuimSuit12DtlOj.getRstOj_RnkEqalYn() eq '2'}">checked="checked"
										</c:if>/>
										불일치&nbsp;&nbsp;
										<input type="radio" id="rstOj_RnkEqalYn${status.index}" name="rstOj_RnkEqalYn${status.index}" value="3"
										<c:if test="${getSuimSuit12DtlOj.getRstOj_RnkEqalYn() eq '3'}">checked="checked"
										</c:if>/>
										미확인&nbsp;&nbsp;
										<input type="radio" id="rstOj_RnkEqalYn${status.index}" name="rstOj_RnkEqalYn${status.index}" value="0"
										<c:if test="${getSuimSuit12DtlOj.getRstOj_RnkEqalYn() eq '0' || getSuimSuit12DtlOj.getRstOj_RnkEqalYn() eq ''}">checked="checked"
										</c:if>/>
										해당없음
									</td>
								</tr>
								
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ세부사항 일치여부</b></td>
									<td>
										<input type="radio" id="rstOj_Dt_MttEqalYn${status.index}" name="rstOj_Dt_MttEqalYn${status.index}" value="1"
										<c:if test="${getSuimSuit12DtlOj.getRstOj_Dt_MttEqalYn() eq '1'}">checked="checked"
										</c:if>/>
										일치&nbsp;&nbsp;
										<input type="radio" id="rstOj_Dt_MttEqalYn${status.index}" name="rstOj_Dt_MttEqalYn${status.index}" value="2"
										<c:if test="${getSuimSuit12DtlOj.getRstOj_Dt_MttEqalYn() eq '2'}">checked="checked"
										</c:if>/>
										불일치&nbsp;&nbsp;
										<input type="radio" id="rstOj_Dt_MttEqalYn${status.index}" name="rstOj_Dt_MttEqalYn${status.index}" value="3"
										<c:if test="${getSuimSuit12DtlOj.getRstOj_Dt_MttEqalYn() eq '3'}">checked="checked"
										</c:if>/>
										미확인&nbsp;&nbsp;
										<input type="radio" id="rstOj_Dt_MttEqalYn${status.index}" name="rstOj_Dt_MttEqalYn${status.index}" value="0"
										<c:if test="${getSuimSuit12DtlOj.getRstOj_Dt_MttEqalYn() eq '0' || getSuimSuit12DtlOj.getRstOj_Dt_MttEqalYn() eq ''}">checked="checked"
										</c:if>/>
										해당없음
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ세부수용장소 일치여부</b></td>
									<td>
										<input type="radio" id="rstOj_Dt_AccptPlcEqalYn${status.index}" name="rstOj_Dt_AccptPlcEqalYn${status.index}" value="1"
										<c:if test="${getSuimSuit12DtlOj.getRstOj_Dt_AccptPlcEqalYn() eq '1'}">checked="checked"
										</c:if>/>
										일치&nbsp;&nbsp;
										<input type="radio" id="rstOj_Dt_AccptPlcEqalYn${status.index}" name="rstOj_Dt_AccptPlcEqalYn${status.index}" value="2"
										<c:if test="${getSuimSuit12DtlOj.getRstOj_Dt_AccptPlcEqalYn() eq '2'}">checked="checked"
										</c:if>/>
										불일치&nbsp;&nbsp;
										<input type="radio" id="rstOj_Dt_AccptPlcEqalYn${status.index}" name="rstOj_Dt_AccptPlcEqalYn${status.index}" value="3"
										<c:if test="${getSuimSuit12DtlOj.getRstOj_Dt_AccptPlcEqalYn() eq '3'}">checked="checked"
										</c:if>/>
										미확인&nbsp;&nbsp;
										<input type="radio" id="rstOj_Dt_AccptPlcEqalYn${status.index}" name="rstOj_Dt_AccptPlcEqalYn${status.index}" value="0"
										<c:if test="${getSuimSuit12DtlOj.getRstOj_Dt_AccptPlcEqalYn() eq '0' || getSuimSuit12DtlOj.getRstOj_Dt_AccptPlcEqalYn() eq ''}">checked="checked"
										</c:if>/>
										해당없음
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ수용장소구분 일치여부</b></td>
									<td>
										<input type="radio" id="rstOj_AccptPlcFlgcdEqalYn${status.index}" name="rstOj_AccptPlcFlgcdEqalYn${status.index}" value="1"
										<c:if test="${getSuimSuit12DtlOj.getRstOj_AccptPlcFlgcdEqalYn() eq '1'}">checked="checked"
										</c:if>/>
										일치&nbsp;&nbsp;
										<input type="radio" id="rstOj_AccptPlcFlgcdEqalYn${status.index}" name="rstOj_AccptPlcFlgcdEqalYn${status.index}" value="2"
										<c:if test="${getSuimSuit12DtlOj.getRstOj_AccptPlcFlgcdEqalYn() eq '2'}">checked="checked"
										</c:if>/>
										불일치&nbsp;&nbsp;
										<input type="radio" id="rstOj_AccptPlcFlgcdEqalYn${status.index}" name="rstOj_AccptPlcFlgcdEqalYn${status.index}" value="3"
										<c:if test="${getSuimSuit12DtlOj.getRstOj_AccptPlcFlgcdEqalYn() eq '3'}">checked="checked"
										</c:if>/>
										미확인&nbsp;&nbsp;
										<input type="radio" id="rstOj_AccptPlcFlgcdEqalYn${status.index}" name="rstOj_AccptPlcFlgcdEqalYn${status.index}" value="0"
										<c:if test="${getSuimSuit12DtlOj.getRstOj_AccptPlcFlgcdEqalYn() eq '0' || getSuimSuit12DtlOj.getRstOj_AccptPlcFlgcdEqalYn() eq ''}">checked="checked"
										</c:if>/>
										해당없음
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ야적물건구분 일치여부</b></td>
									<td>
										<input type="radio" id="rstOj_FldstObjFlgcdEqalYn${status.index}" name="rstOj_FldstObjFlgcdEqalYn${status.index}" value="1"
										<c:if test="${getSuimSuit12DtlOj.getRstOj_FldstObjFlgcdEqalYn() eq '1'}">checked="checked"
										</c:if>/>
										일치&nbsp;&nbsp;
										<input type="radio" id="rstOj_FldstObjFlgcdEqalYn${status.index}" name="rstOj_FldstObjFlgcdEqalYn${status.index}" value="2"
										<c:if test="${getSuimSuit12DtlOj.getRstOj_FldstObjFlgcdEqalYn() eq '2'}">checked="checked"
										</c:if>/>
										불일치&nbsp;&nbsp;
										<input type="radio" id="rstOj_FldstObjFlgcdEqalYn${status.index}" name="rstOj_FldstObjFlgcdEqalYn${status.index}" value="3"
										<c:if test="${getSuimSuit12DtlOj.getRstOj_FldstObjFlgcdEqalYn() eq '3'}">checked="checked"
										</c:if>/>
										미확인&nbsp;&nbsp;
										<input type="radio" id="rstOj_FldstObjFlgcdEqalYn${status.index}" name="rstOj_FldstObjFlgcdEqalYn${status.index}" value="0"
										<c:if test="${getSuimSuit12DtlOj.getRstOj_FldstObjFlgcdEqalYn() eq '0' || getSuimSuit12DtlOj.getRstOj_OjTpEqalYn() eq ''}">checked="checked"
										</c:if>/>
										해당없음
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ지하수용여부 일치여부</b></td>
									<td>
										<input type="radio" id="rstOj_UndgAccptYnEqalYn${status.index}" name="rstOj_UndgAccptYnEqalYn${status.index}" value="1"
										<c:if test="${getSuimSuit12DtlOj.getRstOj_UndgAccptYnEqalYn() eq '1'}">checked="checked"
										</c:if>/>
										일치&nbsp;&nbsp;
										<input type="radio" id="rstOj_UndgAccptYnEqalYn${status.index}" name="rstOj_UndgAccptYnEqalYn${status.index}" value="2"
										<c:if test="${getSuimSuit12DtlOj.getRstOj_UndgAccptYnEqalYn() eq '2'}">checked="checked"
										</c:if>/>
										불일치&nbsp;&nbsp;
										<input type="radio" id="rstOj_UndgAccptYnEqalYn${status.index}" name="rstOj_UndgAccptYnEqalYn${status.index}" value="3"
										<c:if test="${getSuimSuit12DtlOj.getRstOj_UndgAccptYnEqalYn() eq '3'}">checked="checked"
										</c:if>/>
										미확인&nbsp;&nbsp;
										<input type="radio" id="rstOj_UndgAccptYnEqalYn${status.index}" name="rstOj_UndgAccptYnEqalYn${status.index}" value="0"
										<c:if test="${getSuimSuit12DtlOj.getRstOj_UndgAccptYnEqalYn() eq '0' || getSuimSuit12DtlOj.getRstOj_OjTpEqalYn() eq ''}">checked="checked"
										</c:if>/>
										해당없음
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ기타의견</b></td>
									<td>
										<input type="text" id="rstOj_EtMtt${status.index}" name="rstOj_EtMtt${status.index}" style="width:90%" value="${getSuimSuit12DtlOj.getRstOj_EtMtt()}"/></td>
								</tr>
								</c:forEach>
							</table>
						</div>
						<p align="center">
							<img id="edite" src="./resources/ls_img/btn_ok.gif" alt="저장" style ="cursor:pointer" />
							<img id="cancel" src="./resources/ls_img/btn_cancel.gif" alt="취소" style ="cursor:pointer" />
						</p>
						</div><!-- //guestcnt5 -->

					</div><!-- //guest -->
				</div><!-- //bot1-3 -->
			</div><!-- //center_cnt -->
		</div><!-- //contetnsPop -->
	</div>
	<!--//center -->

	<!-- footer -->
	<c:import url="../top_main/top_pop_footer.jsp"></c:import>
	<!-- //footer -->

</body>

</html>
