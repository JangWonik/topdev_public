<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		
			
	<%--<script src="./resources/daum/161109.js"></script>--%>
	<script src="./resources/daum/postcode.v2.js"></script>
	<script src='https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js'></script>

	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	
	<script src="./resources/ne_js/ne_number.js"></script>
	
	<%--spiner start--%>
    <script src="/resources/jquery/spin.js"></script>
    <script src="/resources/jquery/jquery.spin.js"></script>
    <%--spiner end --%>
	
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>
	
	<script>
		$(document).ready(function(){			
			$("input:radio[name='gubun_rpt1']:radio[value='11']").click();
			
			/** 셀렉트박스 검색기능 플러그인 추가 **/
			$("#topTeamId").select2();
			$("#topMbr").select2();
			$("#onestopTeamId").select2();
			$("#onestopMbrNo").select2();
			
			$("#ptnrId").select2();
			$("#ptnrDeptMbr").select2();
			
			$("#speed_type").select2();
			
			$.ajaxSetup({cache:false});
			
			
			/**** 오늘 날짜 세팅 ****/
			var nowDate = new Date();
			var nowYear = nowDate.getFullYear();
			var nowMonth = nowDate.getMonth() +1;
			var nowDay = nowDate.getDate();
			if(nowMonth < 10 ){
				nowMonth = "0" +nowMonth;
			}
			
			if(nowDay < 10 ){
				nowDay = "0" +nowDay;
			}
			var todayDate = nowYear + "-"+ nowMonth + "-" + nowDay;
			
			//수임일 오늘로 세팅
			$("#suim_time").val(todayDate);
			
			/***  우편번호 검색  ***/
			$("#postCodeBtnSuim2").click(function(){
				var cw=screen.availWidth;
				var ch=screen.availHeight;
				var sw=500; //띄울 창의 넓이
				var sh=350;  //띄울 창의 높이
				var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
				var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
				window.open('zipcodePop','zipcodepop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			});
			
			$("#postCodeBtnSuim1").click(function(){
				var themeObj = {
						   bgColor: "#C00C0C", //바탕 배경색
						   //searchBgColor: "", //검색창 배경색
						   //contentBgColor: "", //본문 배경색(검색결과,결과없음,첫화면,검색서제스트)
						   //pageBgColor: "", //페이지 배경색
						   //textColor: "", //기본 글자색
						   //queryTextColor: "", //검색창 글자색
						   //postcodeTextColor: "", //우편번호 글자색
						   emphTextColor: "#C01160" //강조 글자색
						   //outlineColor: "", //테두리
						};
				new daum.Postcode({
					theme: themeObj,
					
					oncomplete: function(data) {
						$("#postcode1").val(data.zonecode);
// 						$("#addr_1st").val(data.roadAddress);
						$("#addr_1st").val(data.sido+" "+data.sigungu+" "+data.bname );
					}
				}).open();
			});//$("#postCodeBtn").click
			  
			
			/* 처리팀 지정 */
			$("#topTeamId").change(function(){ 

				var team_id = $("#topTeamId option:selected").val();
				var team_level = $("#topTeamId option:selected").attr("level");
				
				if (team_level == 0){
					alert("부서선택이 잘못 되었습니다.");
					$("#topTeamId").select2().select2('val', '0');		
					return;
				}
				
				
				$.post("topMbrForSelectedTeam",
							{	
								team_id : team_id
							},
							function(data,status){

								if(status == "success"){
									$("#topMbr").empty();
									if(data.length == 0){
										
										$("#topMbr").append(
											"<option value='0'>"
												+"직원 없음"
											+"</option>"
										);
										
									}else{
										$("#topMbr").append(
		                    				
			                    			"<option value = '0'>담당자 미지정</option>"
			   						);
										
					                    $.each(data, function(index, entry) {
					                    	
					                    		$("#topMbr").append(
					                    				
					                    				"<option value = '"+entry.user_no+"'>"
														
														+entry.user_name
														
				                                		+ "</option>"
					   							);
					                    		
										});//each
										
					                    if($("#mbrIdBySrc").val() != ''){	
					        				$("#topMbr").val($("#mbrIdBySrc").val());
					        				$("#mbrIdBySrc").val("");
					        			}
										
									}
								}else{
									alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
								}
							},"json"
					);//post
							
			});
			
			/* 보험사 지정 */
			$("#ptnrId").change(function(){
				
        		$("#ptnrDeptNm").html("");
        		$("#ptnrDeptId").val("0");
				var ptnr_id = $("#ptnrId option:selected").val();
				
				if ( ptnr_id == 1){
					return;
				}
				
				if(ptnr_id == 34){
					$("#suhyupDetail").show();
					$("#suitDetail").hide();

					$("#ptnrLotte").hide();
					$("#ptnrHeung").hide();
					$("#ptnrMeritz").hide();
					$("#ptnrLH").hide();
				}else{					
					$("#suhyupDetail").hide();
				}
								
				if(ptnr_id == 27 || ptnr_id == 17){ // 흥생, 흥화 
					$("#ptnrLotte").css("display","none");
					$("#ptnrHeung").css("display","inline");
					$("#ptnrNormal").css("display","inline");
					$("#ptnrMeritz").css("display","none");
					$("#ptnrLH").css("display","none");
					$("input:radio[name='gubun_rpt2']:radio[value='17']").prop('checked', true);
				}else if(ptnr_id == 9){ // 롯데
					$("#ptnrLotte").css("display","inline");
					$("#ptnrHeung").css("display","none");
					$("#ptnrNormal").css("display","inline");
					$("#ptnrMeritz").css("display","none");
					$("#ptnrLH").css("display","none");
					$("input:radio[name='gubun_rpt2']:radio[value='9']").prop('checked', true);
				}else if(ptnr_id == 6){ // 농협
					$("#ptnrLotte").css("display","none");
					$("#ptnrHeung").css("display","none");
					$("#ptnrNormal").css("display","inline");
					$("#ptnrMeritz").css("display","none");
					$("#ptnrLH").css("display","inline");
					$("input:radio[name='gubun_rpt2']:radio[value='6']").prop('checked', true);
				}else if(ptnr_id == 16){ // 메리츠
					$("#ptnrLotte").css("display","none");
					$("#ptnrHeung").css("display","none");
					$("#ptnrNormal").css("display","inline");
					$("#ptnrMeritz").css("display","inline");
					$("#ptnrLH").css("display","none");
					if($("input:radio[name='gubun_rpt1']:checked").val() == 14){
						$("input:radio[name='gubun_rpt2']:radio[value='1']").prop('checked', true);	
					}else{
						$("input:radio[name='gubun_rpt2']:radio[value='16']").prop('checked', true);						
					}
				}else if(ptnr_id == 30){
					$("input:radio[name='gubun_rpt2']:radio[value='3001']").prop('checked', true);
				}else{
					$("#ptnrLotte").css("display","none");
					$("#ptnrHeung").css("display","none");
					$("#ptnrNormal").css("display","inline");
					$("#ptnrMeritz").css("display","none");
					$("#ptnrLH").css("display","none");
					$("input:radio[name='gubun_rpt2']:radio[value='1']").prop('checked', true);
				}
				var gubun_rpt1_val = $("input:radio[name='gubun_rpt1']:checked").val();
				if(gubun_rpt1_val != 11 && gubun_rpt1_val != 12 && gubun_rpt1_val != 13 && gubun_rpt1_val != 2){
					$("#pendncyTrgetAtShow").hide();
				}
				if(gubun_rpt1_val == 11 || gubun_rpt1_val == 12 || gubun_rpt1_val == 13 || gubun_rpt1_val == 2){
					$("#pendncyTrgetAtShow").show();
				}
				
				//스피드 일 경우 보험사 셀렉트 안해옴
				var rpt1 = $("input:radio[name='gubun_rpt1']:checked").val();
				
				if(ptnr_id != 0){
			        var param = {};
			        param.ptnr_id		= ptnr_id;
			        param.suimGubun 	= rpt1;
			        
			        //스피드건일 경우 직원 번호를 넘겨서 해당 직원만 선택 가능하도록 한다.
			        if (rpt1 == 14 && ptnr_id == 16){
			        	/******** 스피드팀 요청에 의해 보험사 담당자 고정 세팅 *******/
/* 			        	param.ptnrMbrNo = new Array("1547","4156"); */
			        	/******** 스피드팀 요청에 의해 보험사 담당자 고정 세팅 2019-01-16 안광관->정선윤으로 변경 *******/
						//param.ptnrMbrNo = new Array("6130","4156");
			        	
			        	/******** 스피드팀 요청에 의해 보험사 담당자 고정 세팅 2019-11-21 정선윤->황현수로 변경 by top3009 *******/
			        	//param.ptnrMbrNo = new Array("1538","4156");
			        	
			        	//안광선 > 윤현철, 황현수 > 송민우 로 보험사 담당자 변경
			        	//송민우를 장성기 로 보험사 담당자 변경
			        	//장성기를 김현수(hs.kim) 으로 보험사 담당자 변경			        	
			        	//param.ptnrMbrNo = new Array("1598","6763");
			        	//param.ptnrMbrNo = new Array("1598","9028");			        	
			        	param.ptnrMbrNo = new Array("1598","6608");				//김현수를 조재홍으로 변경 by top3009 (20240108 : 김규이사님 요청사항)
			        }

			        var url = "./getPtnrMbrInfo";
			        
			        $.ajax({
			            type: "POST",
			            url: url,
			            data: param,
			            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			            timeout: 20000,
			            dataType: "json", 
			            success: function(data){
							$("#ptnrDeptId").html("0");
							$("#ptnrDeptMbr").empty();
							if ( JSON.stringify(data).length == 2 ){//보험사 담당자 지원이 없을 시 '{}' 리턴 ->length == 2
								$("#ptnrDeptMbr").append(
									"<option value='0'>"
										+"보험사 담당자 없음"
									+"</option>"
								);
							}else{
								$("#ptnrDeptMbr").append(
                   					"<option value = '0'>담당자 미지정</option>"
  								);
								
			                    $.each(data.list, function(i, n) {
		                    		$("#ptnrDeptMbr").append(
	                    				"<option deptId='"+n.ptnr_dept_id+"' deptNm='"+n.ptnr_dept_nm+"' deptNm2='"+n.ptnr_tm2_nm+"' value='"+n.ptnr_mbr_no+"' >"
											+n.ptnr_mbr_nm
	                             		+ "</option>"
	   								);
								});//each
								
								if($("#ptnrDeptMbrIdBySrc").val() != ''){
		      						$("#ptnrDeptMbr").val($("#ptnrDeptMbrIdBySrc").val());
		      						$("#ptnrDeptMbrIdBySrc").val("");
		      					}
							}
			            },
			            error: function(e){
			                alert("네트웍 상태가 불안정합니다. 잠시 후 다시 시도해 주십시요.");
			            },
			            beforeSend: function(){
			                //$('#div_prgss_edit').spin();
			                //$("#loading").show();
			            }
			        });
					
				}else{ //보험사 미지정 선택시
					$("#ptnrDeptId").html("0");
					$("#ptnrDeptMbr").empty();
					$("#ptnrDeptMbr").append(
							"<option value='0'>"
								+"보험사 미지정"
							+"</option>"
					);
				}
				
				//보험사가 변경되면 세부 구분 값을 다시 불러온다.				
				//처리구분 (배상(대인), 배상(대물), 전문, 재물)에 따라 부서상세 구분, 계약기간 구분 표기되고 기본값으로 설정되도록 수정 by top3009 20230628
				if( rpt1 == 11 || rpt1 == 12 || rpt1 == 13 || rpt1 == 2 ){
					getPtnrIdSubForm();
					getPeriodFlagForm();
				}else{
					getPtnrIdSubFormDisable();
					getPeriodFlagFormDisable();
				}								
			});			
			
			
			/* 보험사 담당자 지정 */
			$("#ptnrDeptMbr").change(function(){
				var ptnrMbrNo = $("#ptnrDeptMbr option:selected").val();
				var deptId = $("#ptnrDeptMbr option:selected").attr("deptId");
				var deptNm = $("#ptnrDeptMbr option:selected").attr("deptNm");
				var deptNm2 = $("#ptnrDeptMbr option:selected").attr("deptNm2");
				
				if (ptnrMbrNo == 0){
	    			$("#ptnrDeptNm").html("");
	    			$("#ptnrDeptId").val();
	    			return;
				}
				
				/** 인보험기획팀(김철민대리 요청사항) by lds **/
				/** 롯데 - 박찬열 사원 선택 시, 단순보고서 체크 **/
				if (ptnrMbrNo == "5995"){
					$("input:radio[name='gubun_rpt2']:radio[value='1001']").prop('checked', true);
				}
				
				$("#ptnrDeptNm").html("");
				if (deptNm2 == ""){
					var tmpDeptNm = deptNm;
				}else{
					var tmpDeptNm = deptNm +"("+deptNm2+")";
				}
				
    			$("#ptnrDeptNm").html(tmpDeptNm);
    			$("#ptnrDeptId").val(deptId);
				
// 				$.post(
// 					"topPtnrDeptForSelectedPtnr"
// 					, { ptnr_mbr_no : ptnr_mbr_no }
// 					, function(data,status){
// 						if(status == "success"){
// 							$("#ptnrDeptNm").html("");
// 		            		$.each(data, function(index, entry) {
// 			            		if (entry.ptnr_tm2_nm == null){
// 				            		var tmp = entry.ptnr_dept_nm;
// 			            		}else{
// 			            			var tmp = entry.ptnr_dept_nm +"("+entry.ptnr_tm2_nm+")";
// 			            		}
// 		            			$("#ptnrDeptNm").html(tmp);
// 		            			$("#ptnrDeptId").val(entry.ptnr_dept_id);
// 							});//each
// 		                   if($("#ptnrDeptIdBySrc").val() != ''){
// 		      					$("#ptnrDeptId").val($("#ptnrDeptIdBySrc").val());
// 		      					$("#ptnrDeptIdBySrc").val("");
// 		      					$("#ptnrDeptId").change();
// 		      				}
// 						}else{
// 							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
// 						}
// 					},"json"
// 				);//post
			});
			
			
			/* 처리팀 지정 */
			$("#onestopTeamId").change(function(){ 

				var team_id = $("#onestopTeamId option:selected").val();
				
				$.post("topMbrForSelectedTeam",
							{	
								team_id : team_id
							},
							function(data,status){

								if(status == "success"){
									$("#onestopMbrNo").empty();
									if(data.length == 0){
										
										$("#onestopMbrNo").append(
											"<option value='0'>"
												+"직원 없음"
											+"</option>"
										);
										
									}else{
										$("#onestopMbrNo").append(
		                    				
			                    			"<option value = '0'>담당자 미지정</option>"
			   						);
										
					                    $.each(data, function(index, entry) {
					                    	
					                    		$("#onestopMbrNo").append(
					                    				
					                    				"<option value = '"+entry.user_no+"'>"
														
														+entry.user_name
														
				                                		+ "</option>"
					   							);
					                    		
										});//each
										
									}
								}else{
									alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
								}
							},"json"
					);//post
							
			});			
			
			
			
			$("#btnOk").click(function(){
				
				var rpt1 = $("input:radio[name='gubun_rpt1']:checked").val();
				
				if($("input:radio[name='gubun_rpt1']:checked").val() == null){
					alert("보험 구분을 선택하세요.");
					return;
				}

				if(rpt1 == 6 
					|| rpt1 == 7
					|| rpt1 == 8
					|| rpt1 == 9
					|| rpt1 == 10
						){
					
					if( $("#suitFromDateForSuim") == '' || $("#suitToDateForSuim") == ''){
						alert("적부 적용 기간을 입력하세요.");
						$("#suitFromDateForSuim").focus();
						return;
					}
					
				}
				
				if($("#topTeamId option:selected").val() == 0){
					alert("담당팀을 지정하세요.");
					$("#topTeamId").focus();
					return;
				}
				
				//보험사 중 손해보험 선택불가
				if($("#ptnrId option:selected").val() == 0 || $("#ptnrId option:selected").val() == 1){
					alert("보험사를 지정하세요.");
					$("#ptnrId").focus();
					return;
				}
				
// 				if($("#ptnrDeptMbr option:selected").val() == 0){
// 					alert("보험사 담당 직원을 지정하세요.");
// 					$("#ptnrDeptMbr").focus();
// 					return;
// 				}
				
				if($("#suim_time").val() != '' || $("#suim_time").val().length == 10 ){ //수임일 자릿수 체크
					if( 0 < $("#suim_time").val().substr(5,2) && $("#suim_time").val().substr(5,2) <= 12 && 
						0 < $("#suim_time").val().substr(8,2) && $("#suim_time").val().substr(8,2) <= 31 ){ //날짜 정상 체크
					}else{
						alert("수임일의 날짜를 정확히 입력하세요.");
						$("#suim_time").focus();
						return;
					}
				}else{
					alert("수임일을 정확히 입력하세요.");
					$("#suim_time").focus();
					return;
				}


				if($("#sago_time").val() != '' || $("#sago_time").val().length == 10 ){ //수임일 자릿수 체크
					if( 0 < $("#sago_time").val().substr(5,2) && $("#sago_time").val().substr(5,2) <= 12 && 
						0 < $("#sago_time").val().substr(8,2) && $("#sago_time").val().substr(8,2) <= 31 ){ //날짜 정상 체크
					}else{
						alert("사고일의 날짜를 정확히 입력하세요.");
						$("#sago_time").focus();
						return;
					}
				}else{
					alert("사고일을 정확히 입력하세요.");
					$("#sago_time").focus();
					return;
				}
				
				/* 180117 gubun_rpt2 는 보고서구분, 해당 내용은 인보험에서만 사용하여 화면에서 hide처리함
				if($("input:radio[name='gubun_rpt2']:checked").val() == null){
					alert("보고서 종류 구분을 선택하세요.");
					return;
				}

				if($("input:radio[name='gubun_rpt1']:checked").val() == 5 && $("input:radio[name='gubun_rpt2']:checked").val() ==1){
					alert("보험 구분이 농작물일 경우 '보험 종류 구분'을 농협으로 선택하십시오.");
					return;
				}
				
				if($("input:radio[name='gubun_rpt1']:checked").val() != 5 && $("input:radio[name='gubun_rpt2']:checked").val() == 6){
					alert("보험 구분이 '농작물'이 아닐 경우 '보험 종류 구분'을 '일반'으로 선택하십시오.");
					return;
				}
			
				
				if($("input:radio[name='gubun_rpt1']:checked").val() == 14 && $("input:radio[name='gubun_rpt2']:checked").val() !=1){
					alert("보험 구분이 '스피드 접수/종결'일 경우 '보험 종류 구분'을 '일반'으로 선택하십시오.");
					return;
				}
				if( $("input:radio[name='gubun_rpt1']:checked").val() == 14 && $("#ptnrId option:selected").val() != 16){
					alert("스피드 접수는 보험사가 오직 메리츠 만 가능합니다.");
					$("#ptnrId").val("16");
 					$("#ptnrId").change();
 					return;
				}
				*/
				
				if( $("input:radio[name='gubun_rpt1']:checked").val() == 14 && $("#suim_time").val() != todayDate){
					alert("서면심사의 수임일은 오직  오늘날짜만 가능합니다.");
					$("#suim_time").val(todayDate);
					return;
				}
				
				//스피드이면서 담당직원이 없으면 등록 안됨
				if( $("input:radio[name='gubun_rpt1']:checked").val() == 14 && $("#topMbr").val() == 0 ){
					alert("서면심사의 경우 반드시 처리 담당자가 필요합니다.");
					return;
				}
				
				if (!workloadValid){
					alert("기준업무량 상세 구분을 체크 해 주세요..");
					return;
				}
				
				//4종 지정건 구분 및 보험사 상세구분 
				if(rpt1 == 3 || rpt1 == 4){					
					//보고서 구분 체크 여부 확인
					if (!$("input:radio[name='gubun_rpt2']").is(":checked")){
						alert("보고서 구분을 선택 해 주세요..");
						return;
					}
					if (!$("input:radio[name='ptnrAssignGubun']").is(":checked")){
						alert("지정건 구분을 선택 해 주세요..");
						return;
					}
					if (!$("input:radio[name='ptnrDetailGubun']").is(":checked")){
						alert("보험사 상세 구분을 선택 해 주세요..");
						return;
					}
				}else{
					$("input:radio[name='ptnrAssignGubun']").prop("checked",false);
					$("input:radio[name='ptnrDetailGubun']").prop("checked",false);
				}
								
				//부서상세 구분 값의 계약기간 선택이 여러개 인 경우 없음을 선택할 수 없도록 한다.
				var periodFlagChkVal = $("#periodFlagChk").val();
				var periodFlagVal = "";
				
				if( periodFlagChkVal == 1 ){
					periodFlagVal = $("input:radio[name='periodFlag']:checked").val();					
					if( periodFlagVal == 0 ){
						alert("장기/일반 구분을 선택해주세요.(장기 또는 일반 체크)");
						return;
					}
				}
				
				//사고번호 보험 증권번호 중복체크
				var chkOverlap = "";
				
				var p_conNo = $("#conNo").val();												//증권번호
				var p_accDate = $("#sago_time").val();										//사고일
				
				//증권번호 사고번호가 입력된 경우 체크
				if( p_conNo != "" && p_accDate != "" ){
					chkOverlap = getAcceptNoInfo( p_conNo, p_accDate, rpt1 );				//증권번호, 사고일, 보고서 타입	
				}
				
				if( chkOverlap != "" ){
					if( !confirm("접수번호 : "+chkOverlap+"으로 등록된 보고서가 있습니다. \n수임등록을 진행하시겠습니까?") ){
						alert("등록이 취소 되었습니다.");
						return;
					}
				}				
				
				$("#suimInsForm").submit();
				
			});
			
			/* 해당 내용 서면심사 사고유형 변경으로 인하여 미사용 171231 by lds
			$("input:radio[name='speed_type']").change(function(){
				
				var checkedVal = $("input:radio[name='speed_type']:checked").val();
				
				if (checkedVal == 6){
					$("#reportEa").val("0.033");	
				}else{
					$("#reportEa").val("0.1");
				}
				
				if(checkedVal ==1){
					$("#amtBasic").val("40000");
				}else if(checkedVal ==2){
					$("#amtBasic").val("80000");
				}else if(checkedVal ==3){
					$("#amtBasic").val("70000");
				}else if(checkedVal ==4){
					$("#amtBasic").val("70000");
				}else if(checkedVal ==5){
					$("#amtBasic").val("80000");
				}else if(checkedVal ==6){
					$("#amtBasic").val("20000");
				}
			});
			*/
			
			//부서상세 구분 셋팅
			//getPtnrIdSubForm();			
			
		}); //ready
		
		//사고일자, 증권번호로 기존 보고서의 접수번호를 불러온다.
		function getAcceptNoInfo( p_conNo, p_accDate, p_suimRptType1 ){
			
			var acceptNoVal;
			
			var param = {};
			param.suim_rpt_type1 = p_suimRptType1;		//보고서 타입 (5 : 농작물인경우만 별도처리)
			param.policy_no = p_conNo;							//증권번호
			param.accident_date = p_accDate;						//사고번호

			var url = "./getAcceptNoInfoByAcc";
	        
	        $.ajax({
	            type: "POST",
	            url: url,
	            data: param,
	            async: false,
	            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	            timeout: 20000,
	            dataType: "html",	            
	            success: function(data){
	            	acceptNoVal = data;
	            },
	            error: function(e){
	                alert("네트웍 상태가 불안정합니다. 잠시 후 다시 시도해 주십시요.");
	            }
	        });
	        
	        return acceptNoVal;			
		}
		
		//부서상세 구분 값이 변경될 때 기간설정 폼을 새로 불러온다.
		function fnClickPtnrSub(){
			getPeriodFlagForm();
		}
		
		//보험사 계약기간 구분 시작
		function getPeriodFlagForm(){
			
			var ptnrIdVal = $("#ptnrId").val();
			var ptnrIdSubVal = $("input:radio[name='ptnrIdSub']:checked").val();			
			
			var param = {};
			param.ptnr_id = ptnrIdVal;
			param.ptnr_id_sub = ptnrIdSubVal;

			var url = "./getPeriodFlagInfo";
	        
	        $.ajax({
	            type: "POST",
	            url: url,
	            data: param,
	            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	            timeout: 20000,
	            dataType: "html", 
	            success: function(data){
	            	$("#periodFlagForm").html(data);
	            },
	            error: function(e){
	                alert("네트웍 상태가 불안정합니다. 잠시 후 다시 시도해 주십시요.");
	            }
	        });			
		}
		
		//보험사 계약기간 구분 시작
		function getPeriodFlagFormDisable(){
			$("#periodFlagForm").html("");
		}
		
		
		//부서상세 구분 시작
		function getPtnrIdSubForm(){
			var ptnrIdVal = $("#ptnrId").val();
			
			var param = {};
			param.ptnr_id = ptnrIdVal;

			var url = "./getPtnrIdSubInfo";
	        
	        $.ajax({
	            type: "POST",
	            url: url,
	            data: param,
	            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	            timeout: 20000,
	            dataType: "html", 
	            success: function(data){
	            	$("#ptnrIdSubForm").html(data);
	            },
	            error: function(e){
	                alert("네트웍 상태가 불안정합니다. 잠시 후 다시 시도해 주십시요.");
	            }
	        });
		}
		
		//부서상세 구분 미표시
		function getPtnrIdSubFormDisable(){			
	        $("#ptnrIdSubForm").html("");	        
		}
		
		//계약자와 사고일자 동일 여부 체크
		function chkConByAccDate(){
			
			var conName = $("#conName").val();
			var sago_time = $("#sago_time").val();
			
			//계약자와 사고일자가 입력된 경우만 중복체크한다.			
			if( conName != "" && sago_time != "" ){				
				
				var param = {};
				param.policyholder_nm = conName;
				param.accident_date = sago_time;
				
				var url = "./checkConNmAccDateForHead";
				
				$.ajax({
		            type: "POST",
		            url: url,
		            data: param,
		            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		            timeout: 20000,
		            dataType: "json", 
		            success: function(data){		            	
		            	if( data.msg == "" ){		            		
		            		$("#conNameWarn").hide();
		            	}else{		            		
		            		$("#conNameWarn").show();
							$("#conNameWarn").html("");
							$("#conNameWarn").append(
								"<br/><font color='red'> ※ "+data.msg+"</font>"	
							);
		            	}
		            },
		            error: function(e){
		                alert("네트웍 상태가 불안정합니다. 잠시 후 다시 시도해 주십시요.");
		            }
		        });
				
			}
			
		}
		
		function checkAccNum(){
			
			var accNo = $("#accNo").val();
			
			if( accNo == '' ){				//입력창이 clear 된 경우 다시 초기화 by top3009
				$("#accNoWarn").hide();
				$("#btnOk").show();				
			}else{				//사고번호 중복 허용 및 내용 확인하는 방식으로 변경 
				
				var param = {};
		        param.accNo		= accNo;		        
				
				var url = "./checkAccNoForHeadIns";
				
				$.ajax({
		            type: "POST",
		            url: url,
		            data: param,
		            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		            timeout: 20000,
		            dataType: "json", 
		            success: function(data){		            	
		            	if( data.msg == "" ){		            		
		            		$("#accNoWarn").hide();
		            	}else{		            		
		            		$("#accNoWarn").show();
							$("#accNoWarn").html("");
							$("#accNoWarn").append(
								"<font color='red'> ※ "+data.msg+"</font>"	
							);
		            	}
		            },
		            error: function(e){
		                alert("네트웍 상태가 불안정합니다. 잠시 후 다시 시도해 주십시요.");
		            }
		        });
			}
			
			/** 서면심사 메리츠 사고번호 중복차단 기능 제거
			if($("input:radio[name='gubun_rpt1']:checked").val() ==14){				
				
				$.post("./checkAccNoForSpeedIns",
						{	 
							accNo  	:	accNo //사고번호
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									$("#accNoWarn").hide();
									$("#btnOk").show();
								}else{
									$("#accNoWarn").show();
									$("#accNoWarn").html("");
									$("#accNoWarn").append(
										"<font color='red'> ※ 이미 등록된 사고번호 입니다.</font>"	
									);
									
									$("#btnOk").hide();
								}
							}else{
								alert("시스템 에러. 관리자에게 문의하세요.");
							}
						}//function
				);//post
				
			}else if( accNo == '' ){				//입력창이 clear 된 경우 다시 초기화 by top3009
				$("#accNoWarn").hide();
				$("#btnOk").show();				
			}else{				//메리츠 서면심사외 등록건의 사고번호 체크 로직 추가 by top3009
				
				var param = {};
		        param.accNo		= accNo;		        
				
				var url = "./checkAccNoForHeadIns";
				
				$.ajax({
		            type: "POST",
		            url: url,
		            data: param,
		            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		            timeout: 20000,
		            dataType: "json", 
		            success: function(data){		            	
		            	if( data.msg == "" ){		            		
		            		$("#accNoWarn").hide();
		            	}else{		            		
		            		$("#accNoWarn").show();
							$("#accNoWarn").html("");
							$("#accNoWarn").append(
								"<font color='red'> ※ "+data.msg+"</font>"	
							);
		            	}
		            },
		            error: function(e){
		                alert("네트웍 상태가 불안정합니다. 잠시 후 다시 시도해 주십시요.");
		            }
		        });
			}
			**/
		}
		
		//뒤로가기 방지코드
		document.onkeydown=__cancelkey;
		function __cancelkey(){
			if(event.keyCode == "8"){
	   			event.keyCode = 0;
		 	}
		}
		
		var submitcount=0;
		
		function checkFields() {
			if (submitcount == 0) {
		    	submitcount++;
		    	return true;
			}else{
				alert("처리중 입니다. 잠시 기다려주세요.");
				return false;
			}
	    }
		
		
		function fnShowOnestopTeam(that){
			if ( $(that).is(":checked") ){
				$(".onestopTeamTr").show();				
			}else{
				$(".onestopTeamTr").hide();
				
			}
		}
		
		//서면심사 사고유형 SELECT BOX 변경 시, 종결건수, 청구수수료 변경
		function fnChgSpeedType(that){
			
			var checkedVal = that.value;
			
			//alert("checkedVal : "+checkedVal);
			
			switch(checkedVal){
				case "1" : $("#reportEa").val("0.1"); $("#amtBasic").val("40000"); break;	//간이(단순입력)	
				case "11" : $("#reportEa").val("0.1"); $("#amtBasic").val("40000"); break;	//간이(타사)
				case "12" : $("#reportEa").val("0.1"); $("#amtBasic").val("40000"); break;	//간이(구내치료비)
				case "13" : $("#reportEa").val("0.1"); $("#amtBasic").val("40000"); break;	//간이(홀인원)
				//case "2" : $("#reportEa").val("0.1"); $("#amtBasic").val("100000"); break;	//대인
				case "2" : $("#reportEa").val("0.1"); $("#amtBasic").val("70000"); break;	//대인
				//case "3" : $("#reportEa").val("0.1"); $("#amtBasic").val("80000"); break;	//대물
				case "3" : $("#reportEa").val("0.1"); $("#amtBasic").val("70000"); break;	//대물
				case "4" : $("#reportEa").val("0.1"); $("#amtBasic").val("80000"); break;	//재물
				//case "41" : $("#reportEa").val("0.1"); $("#amtBasic").val("80000"); break;	//재물(6대가전)
				case "41" : $("#reportEa").val("0.1"); $("#amtBasic").val("70000"); break;	//재물(6대가전)
				//case "42" : $("#reportEa").val("0.1"); $("#amtBasic").val("80000"); break;	//재물(도난)
				case "42" : $("#reportEa").val("0.1"); $("#amtBasic").val("70000"); break;	//재물(도난)
				//case "43" : $("#reportEa").val("0.1"); $("#amtBasic").val("80000"); break;	//재물(골프용품)
				case "43" : $("#reportEa").val("0.1"); $("#amtBasic").val("70000"); break;	//재물(골프용품)
				//case "44" : $("#reportEa").val("0.1"); $("#amtBasic").val("80000"); break;	//재물(풍수재)
				case "44" : $("#reportEa").val("0.1"); $("#amtBasic").val("70000"); break;	//재물(풍수재)
				//case "45" : $("#reportEa").val("0.1"); $("#amtBasic").val("80000"); break;	//재물(여행자)
				case "45" : $("#reportEa").val("0.1"); $("#amtBasic").val("70000"); break;	//재물(여행자)
				//case "46" : $("#reportEa").val("0.1"); $("#amtBasic").val("80000"); break;	//재물(위로금)
				case "46" : $("#reportEa").val("0.1"); $("#amtBasic").val("70000"); break;	//재물(위로금)
				//case "47" : $("#reportEa").val("0.1"); $("#amtBasic").val("80000"); break;	//재물(일반)
				case "47" : $("#reportEa").val("0.1"); $("#amtBasic").val("70000"); break;	//재물(일반)
				//case "5" : $("#reportEa").val("0.1"); $("#amtBasic").val("100000"); break;	//대인+대물
				case "5" : $("#reportEa").val("0.1"); $("#amtBasic").val("70000"); break;	//대인+대물
				case "7" : $("#reportEa").val("0.1"); $("#amtBasic").val("40000"); break;	//면책
				//case "6" : $("#reportEa").val("0.033"); $("#amtBasic").val("20000"); break;	//임의종결 삭제
			}
		}		
		
		function fnChgRpt1(that){
						
			var rpt1 = that.value;
			$("#ptnrId").select2().select2('val', '1');
			
			if( 
				(rpt1 == 6) ||
				(rpt1 == 7) ||
				(rpt1 == 8) ||
				(rpt1 == 9) ||
				(rpt1 == 10)
			){
				//$("#suitDetail").css("display","block");
				$("#suitDetail").show();				

				if(rpt1 == 6){
					$("#ptnrId option[value='18']").attr("selected", true);
					$("#ptnrId").change();
//						$("#ptnrId").prop("disabled",true);	
				}else if(rpt1 == 7){
					$("#ptnrId option[value='10']").attr("selected", true);
					$("#ptnrId").change();
//						$("#ptnrId").prop("disabled",true);
				}else if(rpt1 == 8){
					$("#ptnrId option[value='12']").attr("selected", true);
					$("#ptnrId").change();
//						$("#ptnrId").prop("disabled",true);
				}else if(rpt1 == 9){
					$("#ptnrId option[value='18']").attr("selected", true);
					$("#ptnrId").change();
//						$("#ptnrId").prop("disabled",true);
				}else if(rpt1 == 10){
					$("#ptnrId option[value='17']").attr("selected", true);
					$("#ptnrId").change();
//						$("#ptnrId").prop("disabled",false);
				}
				
				//$("#suhyupDetail").css("display","none");
				$("#suhyupDetail").hide();

				$("input:radio[name='gubun_rpt2']:radio[value='1']").prop('checked', true);
				
				
				$("#speedTypeTr").hide();
				
				$(".rptInsBodyNoneSpeed").show();
				$(".rptInsBodySpeed").hide();
				
				$(".phoneClass").prop("readonly",false);
				$(".phoneClass").css("background-color",'white');
				
				//처리팀 담당부서 초기화
				$("#topTeamId").val(0);				
				$("#topTeamId").change();
				
				setTimeout(function(){
					$("#topMbr").val(0);
					$("#topMbr").change();
				}, 100)
				
			}else if(rpt1 == 5){
				
				//$("input:radio[name='gubun_rpt2']:radio[value='6']").prop('checked', true);
				
// 				$("#ptnrId option[value='6']").change();
// 				$("#ptnrId").change();
				$("#ptnrId").select2().select2('val', '6');

//					$("#ptnrId").prop("disabled",true);
				//$("#suitDetail").css("display","none");
				$("#suitDetail").hide();

				$("#speedTypeTr").hide();
				
				$(".rptInsBodyNoneSpeed").show();
				$(".rptInsBodySpeed").hide();
				
				$(".phoneClass").prop("readonly",false);
				$(".phoneClass").css("background-color",'white');
				
				//처리팀 담당부서 초기화
				$("#topTeamId").val(0);				
				$("#topTeamId").change();
				
				setTimeout(function(){
					$("#topMbr").val(0);
					$("#topMbr").change();
				}, 100)
				
			//}else if(rpt1 == 14){					//서면심사 처리분류 추가로인해 수정
			}else if(rpt1 == 14 || rpt1 == 15 || rpt1 == 16 || rpt1 == 17 || rpt1 == 18 || rpt1 == 19){					//서면심사 처리분류 추가로인해 수정 //서면심사(DB)추가
				//서면심사 접수				
				$("#speedTypeTr").show();
				
				$(".rptInsBodyNoneSpeed").hide();
				$(".rptInsBodySpeed").show();
				
				//서면심사 처리분류 추가로 인해 수정
				if( rpt1 == 14 ){			//메리츠(장기)
					$("#ptnrId option[value='16']").attr("selected", true);	
				}else if( rpt1 == 15 ){				//흥국
					$("#ptnrId option[value='17']").attr("selected", true);
				}else if( rpt1 == 16 ){				//롯데
					$("#ptnrId option[value='9']").attr("selected", true);
				}else if( rpt1 == 17 ){				//농협
					$("#ptnrId option[value='6']").attr("selected", true);
				}else if( rpt1 == 18 ){			//메리츠(일반)
					$("#ptnrId option[value='16']").attr("selected", true);
				}else if( rpt1 == 19 ){			//서면심사(DB)
					$("#ptnrId option[value='7']").attr("selected", true);
				}				
				
				$("#ptnrId").change();

				$("input:radio[name='gubun_rpt2']:radio[value='1']").prop('checked', true);
				//$("#suitDetail").css("display","none");
				$("#suitDetail").hide();

				$("#reportEa").val("0.1");
				$("#amtBasic").val("40000");
				
				//180724 김규차장님 요청
				//서면심사 접수 선택 시, 접속자 정보 세팅
				var sessTeamId = $("#sessionTeamId").val();
				var sessUserNo = $("#sessionUserNo").val();				
				
				$("#topTeamId").val(sessTeamId);				
				$("#topTeamId").change();
				
				setTimeout(function(){
					$("#topMbr").val(sessUserNo);
					$("#topMbr").change();
				}, 100)
				
			}else{
				$("#speedTypeTr").hide();
				
				$(".rptInsBodyNoneSpeed").show();
				$(".rptInsBodySpeed").hide();
				
				$(".phoneClass").prop("readonly",false);
				$(".phoneClass").css("background-color",'white');
				
				//$("#suitDetail").css("display","none");
				$("#suitDetail").hide();
				$("#ptnrId").change();
//					$("#ptnrId").prop("disabled",false);

				//처리팀 담당부서 초기화
				$("#topTeamId").val(0);				
				$("#topTeamId").change();
				
				setTimeout(function(){
					$("#topMbr").val(0);
					$("#topMbr").change();
				}, 100)
			}
			
			if (rpt1 == 3 || rpt1 == 4 ){
				$(".kind4Only").show();
			}else{
				$(".kind4Only").hide();
			}				
			
			
		}
		
		//====================================================
		// 기준업무량 관련 스크립트 180110, by lds
		//====================================================
		var workloadValid = true;
		
		function fnShowWorkload(gubunRpt1){
			$(".workload_type_tr").hide();
			$("#workload_type_tr_"+gubunRpt1).show();
			
			$("input:radio[name='workload_type']").prop("checked",false);
			
			
			//기준업무량 코드가 있는 처리구분 선택 시, validation 값 세팅
			var workloadKind = $("#workloadKind").val().split(",");
			for ( var i in workloadKind ) {
				if ( workloadKind[i] == gubunRpt1){
					workloadValid = false; 
					break;
				}else{
					workloadValid = true;
				}
			}
			
			if (gubunRpt1 == 14){			
				$("#workload_type14_5").click();
			}else if (gubunRpt1 == 13){
				$("#workload_type13_5").click();
			}else if (gubunRpt1 == 15){
				$("#workload_type15_5").click();
			}else if (gubunRpt1 == 16){
				$("#workload_type16_5").click();
			}else if (gubunRpt1 == 17){
				$("#workload_type17_5").click();
			}else if (gubunRpt1 == 18){
				$("#workload_type18_5").click();
			}else if (gubunRpt1 == 19){
				$("#workload_type19_5").click();
			}
			
			//처리구분 (배상(대인), 배상(대물), 전문, 재물)에 따라 부서상세 구분, 계약기간 구분 표기되고 기본값으로 설정되도록 수정 by top3009 20230628
			if( gubunRpt1 == 11 || gubunRpt1 == 12 || gubunRpt1 == 13 || gubunRpt1 == 2 ){
				getPtnrIdSubForm();				
			}else{				
				getPtnrIdSubFormDisable();
				getPeriodFlagFormDisable();
			}			
		} 
		
		function fnValidWorkload(col_cd1,col_cd2){
			/* 간혹 Ajax가 통신속도차이로 인해 workload값을 못가져오는 경우가 있어서 임시로 하드코딩으로 변경함 180327.lds
			*/
			
			//서면심사(메리츠/장기) 청구수수료 변경요청 처리 (20240111)
			if( col_cd1 == 14 ){
				fnChgAmtBasic14( col_cd1, col_cd2 );
			}
			
			//서면심사(DB)는 청구수수료를 변경해준다.
			if( col_cd1 == 19 ){
				fnChgAmtBasic( col_cd1, col_cd2 );
			}
			
			var param = {};
			param.col_cd1 = col_cd1;
			param.col_cd2 = col_cd2;
			
		    var url = "/getWorkloadEaGubun";
		    $.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        dataType: "JSON", 
		        success: function(data){
		        	$("#workload_ea").val( data.workloadEa );
		        	
		        	workloadValid = true;
		        },
	            beforeSend: function(){
	            $('body').spin();
		        },
		        complete: function(){
		            $('body').spin(false);
		        }
		        
		    });
			
			/*
			var workloadType = col_cd1+"-"+col_cd2;
			var workloadEa = 0;
			switch (workloadType){
				case "2-5" : workloadEa = 1; break; 		//재물(화재 등)
				case "2-10" : workloadEa = 0.5; break;		//메리츠 One-Stop(재물)
				//case "2-15" : workloadEa = 1; break;		//정책(화재 등)
				case "2-20" : workloadEa = 1; break;		//정책(가축재해-일반)
				case "2-25" : workloadEa = 0.22; break;		//정책(가축재해-소)
				case "2-30" : workloadEa = 0.275; break;	//농기계(간편심사)
				case "2-35" : workloadEa = 0.183; break;	//농기계(전수조사)
				case "2-40" : workloadEa = 0.917; break;	//수협(양식보험)
				case "2-45" : workloadEa = 0.647; break;	//재물(풍수재)
				case "2-50" : workloadEa = 0.647; break;	//재물(홀인원)
				case "2-55" : workloadEa = 0.647; break;	//재물(골프용품)
				case "2-60" : workloadEa = 0; break;		//서면심사(신차)
				case "2-65" : workloadEa = 0; break;		//서면심사(맥도날드/재물)
				case "2-99" : workloadEa = 0.3; break;		//퇴사자 종결 후 추가 청구(재물)
				case "5-5" : workloadEa = 1; break;			//농작물(착과수, 벼 등)
				case "5-10" : workloadEa = 1; break;		//원예시설
				case "11-5" : workloadEa = 1; break;		//대인(일반)
				case "11-10" : workloadEa = 0.1; break;		//대인(이랜드/구내치료비)
				case "11-15" : workloadEa = 0.5; break;		//메리츠 One-Stop(대인)
				case "11-20" : workloadEa = 1; break;		//정책(농기계-일반/대인)
				case "11-25" : workloadEa = 0; break;		//서면심사(w.c/대인)
				case "11-30" : workloadEa = 0; break;		//서면심사(맥도날드/대인)
				case "11-99" : workloadEa = 0.3; break;		//퇴사자 종결 후 추가 청구(대인)
				case "12-5" : workloadEa = 1; break;		//대물(일반)
				case "12-10" : workloadEa = 0.5; break;		//메리츠 One-Stop(대물)
				case "12-15" : workloadEa = 1; break;		//정책(농기계-일반/대물,자차)
				case "12-20" : workloadEa = 0; break;		//서면심사(맥도날드/대물)
				case "12-99" : workloadEa = 0.3; break;		//퇴사자 종결 후 추가 청구(대물)
				case "13-5" : workloadEa = 1; break;		//신종(일반)
				case "13-99" : workloadEa = 0.3; break;		//퇴사자 종결 후 추가 청구(신종)
				case "14-5" : workloadEa = 1; break;		//서면심사(메리츠)
				case "14-10" : workloadEa = 0; break;		//서면심사(흥국)
				case "14-15" : workloadEa = 0; break;		//서면심사(롯데)
				case "14_99" : workloadEa = 0.3; break;	//퇴사자 종결 후 추가 청구(서면심사)
			}
			$("#workload_ea").val( workloadEa );
			workloadValid = true;
			*/
		}
		
		//서면심사(메리츠/장기) : p_col_cd1 == 14인 경우 청구수수료 변경 
		function fnChgAmtBasic14( p_col_cd1, p_col_cd2 ){
			
			switch( p_col_cd2 ){
				case "5" : $("#amtBasic").val("60000");	break;		//서면심사(메리츠/장기-비누수)
				case "20" : $("#amtBasic").val("60000"); break;		//서면심사(메리츠/장기-누수)
				default : $("#amtBasic").val("0"); break;				//본인추가건, 퇴사자 종결 후 추가청구
			}
			
		}
		
		//서면심사(DB) : p_col_cd1 == 19인 경우 청구수수료 변경 
		function fnChgAmtBasic( p_col_cd1, p_col_cd2 ){
			
			switch( p_col_cd2 ){
				case "5" : $("#amtBasic").val("80000");	break;		//서면심사(DB/전문심사)
				case "10" : $("#amtBasic").val("12000"); break;		//서면심사(DB/간편심사)
				default : $("#amtBasic").val("0"); break;				//본인추가건, 퇴사자 종결 후 추가청구
			}
			
		}
		
	</script>
	<style>
		.head1{
			/*width:15%;*/
			/*text-align:left;*/
			padding: 4px 0 4px 5px;
			background-color:#EDEDED;
		}
		
	</style>
</head>

<body id="suim_reg_body">
	<div class= "tableStyle6">
	<form action="suimAdd" id="suimInsForm" method="POST" onSubmit="return checkFields()">
		<input type="hidden" name="popSuimDtl" id="popSuimDtl" value=""/> 
		<input type="hidden" name="workload_ea" id="workload_ea" value=""/> 
		<Input type="hidden" id="sessionTeamId" value="${mbrVo_Session.team_id_main}" />
		<Input type="hidden" id="sessionUserNo" value="${mbrVo_Session.user_no}" />		
		
		<table align="center" style = "margin-top:10px;width:100%;" >
			<colgroup>
				<col width="15%">
				<col width="35%">
				<col width="15%">
				<col width="25%">
			</colgroup>
			<tbody>

				<tr>
					<td class="head1">ㆍ처리 구분</td>
					<td colspan="3">
						<input type="radio" name = "gubun_rpt1" id="gubun_rpt1" value = "11" onclick="fnChgRpt1(this);fnShowWorkload(11);" /> <label for='gubun_rpt1'><b>배상(대인)</b></label>
						<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
						<input type="radio" name = "gubun_rpt1" id="gubun_rpt2" value = "12" onclick="fnChgRpt1(this);fnShowWorkload(12);"/> <label for='gubun_rpt2'><b>배상(대물)</b></label>
						<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
						<input type="radio" name = "gubun_rpt1" id="gubun_rpt3" value = "13" onclick="fnChgRpt1(this);fnShowWorkload(13);"/> <label for='gubun_rpt3'><b>전문</b></label>
						<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
						<input type="radio" name = "gubun_rpt1" id="gubun_rpt4" value = "2" onclick="fnChgRpt1(this);fnShowWorkload(2);"/> <label for='gubun_rpt4'><b>재물</b></label>
						<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
						<input type="radio" name = "gubun_rpt1" id="gubun_rpt5" value = "3" onclick="fnChgRpt1(this);fnShowWorkload(3);"/> <label for='gubun_rpt5'><b>상해</b></label>
						<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
						<input type="radio" name = "gubun_rpt1" id="gubun_rpt6" value = "4" onclick="fnChgRpt1(this);fnShowWorkload(4);"/> <label for='gubun_rpt6'><b>질병</b></label>
						<br />
						<!-- <input type="radio" name = "gubun_rpt1" id="gubun_rpt7" value = "14" onclick="fnChgRpt1(this);fnShowWorkload(14);"/> <label for='gubun_rpt7'><b>서면심사 접수</b></label> -->
						<!-- 20190919 기준업무량 분류 변경요청 처리 by top3009 -->
						<input type="radio" name = "gubun_rpt1" id="gubun_rpt7" value = "14" onclick="fnChgRpt1(this);fnShowWorkload(14);"/> <label for='gubun_rpt7'><b>서면심사(메리츠/장기)</b></label>
						<!-- 추가 -->
						<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
						<input type="radio" name = "gubun_rpt1" id="gubun_rpt15" value = "15" onclick="fnChgRpt1(this);fnShowWorkload(15);"/> <label for='gubun_rpt15'><b>서면심사(흥국)</b></label>
						<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
						<input type="radio" name = "gubun_rpt1" id="gubun_rpt16" value = "16" onclick="fnChgRpt1(this);fnShowWorkload(16);"/> <label for='gubun_rpt16'><b>서면심사(롯데)</b></label>
						<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
						<input type="radio" name = "gubun_rpt1" id="gubun_rpt17" value = "17" onclick="fnChgRpt1(this);fnShowWorkload(17);"/> <label for='gubun_rpt17'><b>서면심사(농협)</b></label>						
						<br />
						<!-- 서면심사(일반) 장기와 분리하여 신규 추가 by top3009 -->
						<input type="radio" name = "gubun_rpt1" id="gubun_rpt18" value = "18" onclick="fnChgRpt1(this);fnShowWorkload(18);"/> <label for='gubun_rpt18'><b>서면심사(메리츠/일반)</b></label>
						<!-- 서면심사(DB) 신규 추가 by top3009 -->
						<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
						<input type="radio" name = "gubun_rpt1" id="gubun_rpt19" value = "19" onclick="fnChgRpt1(this);fnShowWorkload(19);"/> <label for='gubun_rpt19'><b>서면심사(DB)</b></label>
						<br />
						<input type="radio" name = "gubun_rpt1" id="gubun_rpt8" value = "5" onclick="fnChgRpt1(this);fnShowWorkload(5);"/> <label for='gubun_rpt8'><b>농업</b></label>
						<br />
				    	<input type="radio" name = "gubun_rpt1" id="gubun_rpt9" value = "6" onclick="fnChgRpt1(this);fnShowWorkload(6);"/> <label for='gubun_rpt9'><b>삼성 적부</b></label>
						<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
						<input type="radio" name = "gubun_rpt1" id="gubun_rpt10" value = "7" onclick="fnChgRpt1(this);fnShowWorkload(7);"/> <label for='gubun_rpt10'><b>KB 적부</b></label>
						<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
						<input type="radio" name = "gubun_rpt1" id="gubun_rpt11" value = "8" onclick="fnChgRpt1(this);fnShowWorkload(8);"/> <label for='gubun_rpt11'><b>한화 적부</b></label>
						<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
						<input type="radio" name = "gubun_rpt1" id="gubun_rpt12" value = "9" onclick="fnChgRpt1(this);fnShowWorkload(9);"/> <label for='gubun_rpt12'><b>삼성스마트 적부</b></label>
						<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
						<input type="radio" name = "gubun_rpt1" id="gubun_rpt13" value = "10" onclick="fnChgRpt1(this);fnShowWorkload(10);"/> <label for='gubun_rpt13'><b>흥국 적부</b></label>
						<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
						<input type="radio" name = "gubun_rpt1" id="gubun_rpt14" value = "99" onclick="fnChgRpt1(this);fnShowWorkload(99);"/> <label for='gubun_rpt14'><b>기타 적부</b></label>
					</td>
				</tr>
				
				
				<!-- 
				--
				--  기준업무량 상세구분
				--
				 -->
				<c:set var="bef_workload_type" value="0"/>
				<c:set var="workloadKind" value=""/> <!-- 기준업무량이 설정된 처리 구분 값들 ex)14,12,11,2, 식으로 저장됨 -->
				
				<c:forEach items="${workloadTypeList}" var="item" varStatus="status">
					<c:if test="${bef_workload_type != item.col_cd1}">
						<c:set var="curr_cnt" value="1"/>
						<c:set var="workloadKind" value="${item.col_cd1},${workloadKind}" />
						<tr class="workload_type_tr" id="workload_type_tr_${item.col_cd1}">
							<td class="head1">ㆍ기준업무량 상세구분</td>
							<td colspan="3" id="workload_type${item.col_cd1}">
					</c:if>
					
					<input type="radio" name="workload_type" id="workload_type${item.col_cd1}_${item.col_cd2}" value = "${item.col_cd2}" onclick="fnValidWorkload('${item.col_cd1}','${item.col_cd2}');"/> 
					<label for='workload_type${item.col_cd1}_${item.col_cd2}'><b>${item.col_val}</b></label>
					
					<c:if test="${curr_cnt == 4}">
						<br/>
						<c:set var="curr_cnt" value="0"/>
					</c:if>
					
					<c:if test="${item.col_cd1 == workloadTypeList[status.count].col_cd1 and curr_cnt != 4 and curr_cnt != 0}">
						<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>	
					</c:if>
						
					<c:if test="${item.col_cd1 != workloadTypeList[status.count].col_cd1}">
							</td>
						</tr>
					</c:if>
					
					<c:set var="curr_cnt" value="${curr_cnt+1}"/>
					<c:set var="bef_workload_type" value="${item.col_cd1}"/>
				</c:forEach>
					
                <tr class = "kind4Only" style="display: none;">
                	
                    <td class="head1">ㆍ보고서 구분 </td>
                    <td colspan="3">
						<span id="ptnrNormal">
							<input type="radio" id="gubun_rpt21" name = "gubun_rpt2" value = "1"/> <label for='gubun_rpt21'><b>일반</b></label>
							<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
							<input type="radio" id="gubun_rpt22" name = "gubun_rpt2" value = "1001"/> <label for='gubun_rpt22'><b>단순</b></label>
							<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
							<input type="radio" id="gubun_rpt28" name = "gubun_rpt2" value = "3001"/> <label for='gubun_rpt28'><b>건설공제</b></label>
						</span>
						<span id="ptnrLH" style="display: none;">
							<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
							<input type="radio" id="gubun_rpt23" name = "gubun_rpt2" value = "6"/> <label for='gubun_rpt23'><b>농협</b></label>
						</span>
						<span id="ptnrLotte" style="display: none;">
							<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
							<input type="radio" id="gubun_rpt24" name = "gubun_rpt2" value = "9"/> <label for='gubun_rpt24'><b>롯데</b></label>
						</span>
						<span id="ptnrMeritz" style="display: none;">
							<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
							<input type="radio" id="gubun_rpt25" name = "gubun_rpt2" value = "16"/> <label for='gubun_rpt25'><b>메리츠</b></label>
						</span>
						<span id="ptnrHeung" style="display: none;">
							<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
							<input type="radio" id="gubun_rpt26" name = "gubun_rpt2" value = "17"/> <label for='gubun_rpt26'><b>흥국(일반)</b></label>
							<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
							<input type="radio" id="gubun_rpt27" name = "gubun_rpt2" value = "1700"/> <label for='gubun_rpt27'><b>흥국(의료)</b></label>
						</span>
                        <!-- <select id="gubun_rpt2" >
                            <option value="1">일반</option>
                            <option value="9">롯데</option>
                            <option value="17">흥국(일반)</option>
                            <option value="1700">흥국(의료)</option>
                        </select> -->
                    </td>
                </tr>
				<tr id = "pendncyTrgetAtShow">
                	<td class="head1">ㆍ필수업무프로세스</td>
                    <td colspan="3">
						<input type="radio" id="pendncyTrgetAt1" name = "pendncyTrgetAt" value = "1" checked="checked"/><label for="pendncyTrgetAt1">&nbsp;<b>대상</b></label>
						<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
						<input type="radio" id="pendncyTrgetAt2" name = "pendncyTrgetAt" value = "2"/><label for="pendncyTrgetAt2">&nbsp;<b>비대상</b></label>
                        <b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
						<input type="radio" id="pendncyTrgetAt3" name = "pendncyTrgetAt" value = "3"/><label for="pendncyTrgetAt3">&nbsp;<b>과정관리</b></label>
                        <b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
						<input type="radio" id="pendncyTrgetAt4" name = "pendncyTrgetAt" value = "4"/><label for="pendncyTrgetAt4">&nbsp;<b>현장+과정관리</b></label>
                    </td>
                </tr>
                
                <!-- 180709 4종 보험사 지정건 구분 추가 -->
                <tr  class = "kind4Only" style="display: none;">
                	<td class="head1">ㆍ지정건 구분</td>
                    <td colspan="3">
						<input type="radio" id="ptnrAssignGubun1" name="ptnrAssignGubun" value = "1" /><label for="ptnrAssignGubun1">&nbsp;<b>지정</b></label>
						<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
						<input type="radio" id="ptnrAssignGubun0" name="ptnrAssignGubun" value = "0"/><label for="ptnrAssignGubun0">&nbsp;<b>비지정</b></label>                    
                    </td>
                </tr>
                
				<tr id = "speedTypeTr" style="display:none;">
					<td class="head1">ㆍ사고 유형<!-- 이전 용어, 스피드 구분 --></td>
					<td colspan="3">
						<select id="speed_type" name="speed_type" onchange="fnChgSpeedType(this);" style="width: 200px;">
<!-- 							<option value="1">간이</option> -->
							<option value="11">간이(타사중복)</option>
							<option value="12">간이(구내치료비)</option>
							<option value="13">간이(홀인원)</option>
							<option value="2">대인</option>
							<option value="3">대물</option>
<!-- 							<option value="4">재물</option> -->
							<option value="41">재물(6대가전)</option>
							<option value="42">재물(도난)</option>
							<option value="43">재물(골프용품)</option>
							<option value="44">재물(풍수재)</option>
							<option value="45">재물(여행자)</option>
							<option value="46">재물(위로금)</option>
							<option value="47">재물(일반)</option>
							<option value="5">대인+대물</option>
							<option value="7">면책</option>
							<!-- <option value="6">임의종결</option> -->
						</select> 
						<!-- 단순입력(비례보상) 0:스피드아님 1:단순입력 2:대인 3:대물 4:재물 5:대인+대물 -->
<!-- 						<span > -->
<!-- 							<input type="radio" id="speed_type1" name="speed_type" value = "1"/> <label for='speed_type1'><b>단순입력</b></label> -->
<!-- 						</span> -->
<!-- 						<span > -->
<!-- 							<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b> -->
<!-- 							<input type="radio" id="speed_type2" name = "speed_type"  value = "2"/> <label for='speed_type2'><b>대인</b></label> -->
<!-- 						</span> -->
<!-- 						<span > -->
<!-- 							<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b> -->
<!-- 							<input type="radio" id="speed_type3" name = "speed_type"  value = "3"/> <label for='speed_type3'><b>대물</b></label> -->
<!-- 						</span> -->
<!-- 						<span > -->
<!-- 							<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b> -->
<!-- 							<input type="radio" id="speed_type4" name = "speed_type"  value = "4"/> <label for='speed_type4'><b>재물</b></label> -->
<!-- 						</span> -->
<!-- 						<span > -->
<!-- 							<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b> -->
<!-- 							<input type="radio" id="speed_type5" name = "speed_type"  value = "5"/> <label for='speed_type5'><b>대인+대물</b></label> -->
<!-- 						</span> -->
<!-- 						<span > -->
<!-- 							<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b> -->
<!-- 							<input type="radio" id="speed_type6" name = "speed_type"  value = "6"/> <label for='speed_type6'><b>임의종결</b></label> -->
<!-- 						</span> -->
					</td>
				</tr>
				<tr>
					<td class="head1">ㆍ처리팀</td>
					<td>
						<select name="topTeamId" id="topTeamId" style="width:200px;" >
							<option value="0" selected>담당부서 미지정</option>
							<c:forEach items="${topTeamList}" var = "topTeamVo">
								<option value="${topTeamVo.team_id}" level="${topTeamVo.team_level}" >
								<c:if test="${topTeamVo.team_level eq 1}">&nbsp;&nbsp;└</c:if>
								<c:if test="${topTeamVo.team_level eq 2}">&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
								${topTeamVo.team_name}
								</option>
							</c:forEach>
						</select>
					</td>
					<td class="head1">ㆍ처리 담당자</td>
					<td>
						<select name="topMbr" id="topMbr" style="width:200px;">
							<option value="0">담당부서 미지정</option>
						</select>
					</td>
				</tr>

				<tr>
					<td class="head1">ㆍ보험사</td>
					
					<td>
						<select name="ptnrId" id="ptnrId" style="width:200px;">
							<c:forEach items="${ptnrList}" var = "ptnrVo">
								<option value="${ptnrVo.ptnr_id}">
								<c:if test="${ptnrVo.ptnr_level eq 1}">&nbsp;&nbsp;└</c:if>
								${ptnrVo.ptnr_nick}
								</option>
							</c:forEach>
						</select>
						<span class="kind4Only" id="ptnr_detail_gubun_span" style="margin-left: 15px;">
							<input type="radio" id="ptnrDetailGubun1" name="ptnrDetailGubun" value = "1" /><label for="ptnrDetailGubun1">&nbsp;<b>원수사</b></label>
							<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
							<input type="radio" id="ptnrDetailGubun2" name="ptnrDetailGubun" value = "2"/><label for="ptnrDetailGubun2">&nbsp;<b>자회사</b></label>
							<b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</b>
							<input type="radio" id="ptnrDetailGubun3" name="ptnrDetailGubun" value = "3"/><label for="ptnrDetailGubun3">&nbsp;<b>외주사</b></label>
						</span>
					</td>
					<!-- 부서상세 구분 시작 -->
					<td class="head1">ㆍ부서상세 구분</td>
						
					<td>
						<div id="ptnrIdSubForm"></div>
						<!-- <input type="radio" name="ptnrIdSub" id="ptnrIdSub0" value="0"/> 본체 -->					
					</td>
					<!-- 부서상세 구분 끝 -->						
				</tr>
				
				<tr>
					<td class="head1">ㆍ보험사 담당자 / 담당부서</td>
					<td>
						<select id="ptnrDeptMbr" name="ptnrDeptMbr" style="width:200px;">
							<option value="0" selected>보험사 미지정</option>
						</select>
						 / 
						<span id="ptnrDeptNm">
						</span>

						<input type="hidden" name="ptnrDeptId" id="ptnrDeptId" value="0">

					</td>
					<td class="head1">ㆍ장기/일반 구분</td>
					<td>
						<div id="periodFlagForm"></div>
						<!-- <input type="radio" name="periodFlag" id="periodFlag0" value="0"/> 없음 &nbsp;
						<input type="radio" name="periodFlag" id="periodFlag1" value="1"/> 장기 &nbsp;
						<input type="radio" name="periodFlag" id="periodFlag2" value="2"/> 일반 -->
					</td>
				</tr>
				<!-- <tr>
					<td class="head1">ㆍ담당부서</td>
					<td  >
						<span id="ptnrDeptNm">
						</span>

						<input type="hidden" name="ptnrDeptId" id="ptnrDeptId" value="0">

					</td>
					<td class="head1">ㆍ보험사 담당자</td>
					<td >
						<select id="ptnrDeptMbr" name="ptnrDeptMbr" style="width:200px;">
							<option value="0" selected>보험사 미지정</option>
						</select>
					</td>
				</tr> -->


					<tr id = "suitDetail" style= "display:none;">
						<td class="head1">ㆍ적부 적용기간</td>
						<td colspan="3">

							<input type="text" size="10" id = "suitFromDateForSuim" name = "suitFromDateForSuim"/> ~
							<input type="text" size="10" id = "suitToDateForSuim" name = "suitToDateForSuim"/> 까지 종결건

						</td>
					</tr>

					<tr id = "suhyupDetail" style = "display:none;">
						<td class="head1">ㆍ수협 상세</td>
						<td colspan="3">
							<input type="radio" value = "1" name = "reportType3" checked="checked"/> 재물화재/대물/전자금융
							<input type="radio" value = "2" name = "reportType3"/> 생명/대인
							<input type="radio" value = "3" name = "reportType3"/> 양식
							<input type="radio" value = "4" name = "reportType3"/> 단순진행
						</td>
					</tr>
					
					<tr class = "rptInsBodySpeed" style="display:none;">
						<td class="head1">ㆍOne Stop 체크</td>
						<td colspan="3" >
							<input  type="checkbox" id="chkSpeedOnestop" onclick="fnShowOnestopTeam(this);" name="chkSpeedOnestop" value="1" />
						</td>
					</tr>
					
					<tr class="onestopTeamTr" style="display:none;">
						<td class="head1">ㆍ현장조사 담당 부서</td>
						<td>
							<select name="onestopTeamId" id="onestopTeamId" style="width:200px;" >
								<option value="0" selected>담당부서 미지정</option>
								<c:forEach items="${topTeamList}" var = "topTeamVo">
									<option value="${topTeamVo.team_id}" level="${topTeamVo.team_level}">
									<c:if test="${topTeamVo.team_level eq 1}">&nbsp;&nbsp;└</c:if>
									<c:if test="${topTeamVo.team_level eq 2}">&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
									${topTeamVo.team_name}
									</option>
								</c:forEach>
							</select>
						</td>
						<td class="head1">ㆍ현장조사 담당자</td>
						<td>
							<select name="onestopMbrNo" id="onestopMbrNo" style="width:200px;">
								<option value="0">담당부서 미지정</option>
							</select>
						</td>
					</tr>
					
					<tr>
						<td class="head1">ㆍ사고번호</td>
						<td colspan="3">
							<input type="text" id="accNo"  name="accNo"size="30" onkeyup="checkAccNum();"/>
							<span id = "accNoWarn"></span>
						</td>
					</tr>
					
					<tr>
						<td class="head1">ㆍ증권번호</td>
						<td colspan="3" >
							<input type="text" id="conNo" name="conNo" size="30" onchange="fnPtnrMbrSelect();"/>
						</td>
					</tr>
					
					<tr class="rptInsBodyNoneSpeed">
						<td class="head1">ㆍ보험종목</td>
						<td colspan="3" >
							<input  type="text" id="accType"  name="accType" size="30" />
						</td>
					</tr>
					
					<tr>
						<td class="head1">ㆍ계약자</td>
						<td >
							<input type="text" id="conName" name="conName" size="20" onkeyup="chkConByAccDate();"/>
							<span id = "conNameWarn"></span>
						</td >
						<td class="head1">ㆍ연락처</td>
						<td>
							<input type="text" size="5" maxlength="4" class= "phoneClass" id = "conPhone1" name ="conPhone1"/> -
							<input type="text" size="5" maxlength="4" class= "phoneClass" id = "conPhone2" name ="conPhone2"/> -
							<input type="text" size="5" maxlength="4" class= "phoneClass" id = "conPhone3" name ="conPhone3"/> 
						</td>
					</tr>
					
					<tr>
						<td class="head1">ㆍ피보험자</td>
						<td >
							<input type="text" id="insName" name="insName" size="20"/>
						</td>
						<td class="head1">ㆍ연락처</td>
						<td>
							<input type="text" size="5" maxlength="4" class= "phoneClass" id = "insPhone1"  name = "insPhone1"/> -
							<input type="text" size="5" maxlength="4" class="phoneClass" id = "insPhone2"  name = "insPhone2"/> -
							<input type="text" size="5" maxlength="4" class="phoneClass" id = "insPhone3" name = "insPhone3"/> 
						</td>
					</tr>
					
					<tr>
						<td class="head1">ㆍ피해자/물</td>
						<td >
							<input type="text" id = "insItem" name = "insItem" size="30"/>
						</td>
						<td class="head1">ㆍ연락처</td>
						<td>
							<input type="text" size="5" maxlength="4" class= "phoneClass" id = "insItemPhone1"  name = "insItemPhone1"/> -
							<input type="text" size="5" maxlength="4" class= "phoneClass" id = "insItemPhone2" name = "insItemPhone2"/> -
							<input type="text" size="5" maxlength="4" class= "phoneClass" id = "insItemPhone3" name = "insItemPhone3"/> 
						</td>
					</tr>
					
					<tr>
						<td class="head1">ㆍ사고일</td>
						<td >
							<input type="text" class="classCalendar" size="15" id="sago_time" name="sago_time" value="" maxlength="10"  onchange="chkConByAccDate();" onkeyup="chkConByAccDate();"/>
						</td>
						<td class="head1">ㆍ수임일</td>
						<td>
							<input type="text" class="classCalendar" size="15" id="suim_time" name="suim_time" value="" maxlength="10" />
						</td>
					</tr>
<%--

					<tr class="rptInsBodyNoneSpeed">
						<td class="head1">추정손해액</td>
						<td >
							<input style="text-align:right;" type="text" id = "estLoss"  name = "estLoss" size="20" ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);" >원
						</td>
						<td class="head1">추정수수료</td>
						<td>
							<input style="text-align:right;" type="text" id = "estFee" name = "estFee" size="20" ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);" >원
						</td>
					</tr>
--%>
					
					
					<tr class="rptInsBodySpeed" style="display:none;">
						<td class="head1">ㆍ평가건수</td>
						<td >
							<input style="text-align:right;" type="text" id = "reportEa" name= "reportEa" size="10"/>건 
						</td>
						<td class="head1">ㆍ청구수수료</td>
						<td>
							<input style="text-align:right;" type="text" id = "amtBasic" name = "amtBasic" size="20"/>원 
						</td>
					</tr>
					<!-- 
					<tr class="rptInsBodySpeed" style="display:none;">
						<td class="head1">ㆍ종결구분</td>
						<td >
							<select name="suimRptType1Close12" id="suimRptType1Close12" name="suimRptType1Close12">
								<option value="1">부책</option>
								<option value="2">면책</option>
								<option value="3">청구포기</option>
								<option value="4">구내치료비</option>
								<option value="5">모럴</option>
								<option value="6">소송</option>
							</select>
						</td>
						<td class="head1">ㆍ지급보험금</td>
						<td>
							<input style="text-align:right;" type="text" id = "amtInsuPayment"  name = "amtInsuPayment"size="20"/>원 
						</td>
					</tr>
					 -->
					<tr class="rptInsBodyNoneSpeed">
						<td class="head1">ㆍ사고장소</td>
						<td colspan="3" >
							우편번호 : <input type="text" name="postcode1" id="postcode1" size="10" readonly style="background-color:lightgrey;" />
								  <input type="button" id="postCodeBtnSuim1" value="도로명주소 찾기">
								  <input type="button" id="postCodeBtnSuim2" value="구우편번호 찾기"><br />
								  
							      <input type="text" name="addr_1st" id="addr_1st"  size="40" readonly style="background-color:lightgrey;" />
						          <input type="text" name="addr_1st_1" id="addr_1st_1"  size="50" />
						</td>
					</tr>
					<tr class="rptInsBodyNoneSpeed">
						<td class="head1">ㆍ사고내용</td>
						<td colspan="3">
							<textarea rows="3" style="width:560px;" id = "accContent" name="accContent" cols="1" ></textarea>
						</td>
					</tr>
 				
			</tbody>
		</table>
	</form>
	</div>
	
	<script type="text/javascript">
	//김규차장님 요청사항: 서면심사보고서 등록시 증권번호 시작번호가 6일때:공영선 1일때:안광선 보험사담당자 지정 
	//20190116 요청사항: 서면심사보고서 등록시 증권번호 시작번호가 6일때:장성윤 1일때:안광선 보험사담당자 지정
	//20191121 요청사항: 서면심사보고서 등록시 증권번호 시작번호가 6일때:장성윤 > 황현수로 변경 
	//20200702 요청사항 : 
	function fnPtnrMbrSelect(){

		var conNo = $("#conNo").val();	
		var ptnr_id = $("#ptnrId option:selected").val();
		var rpt1 = $("input:radio[name='gubun_rpt1']:checked").val();
		
		if(ptnr_id == 16 && rpt1 == 14){
			if(conNo.charAt(0) == '6'){
				//$("#ptnrDeptMbr").val("6130");		//장성윤
				//$("#ptnrDeptMbr").val("1538");			//황현수(hshwang)로 변경 by top3009
				//$("#ptnrDeptMbr").val("2655");			//송민후 로 변경 by top3009
				//$("#ptnrDeptMbr").val("6763");			//송민후를 장성기로 변경 by top3009
				//$("#ptnrDeptMbr").val("9028");			//장성기를 김현수로 변경 by top3009
				$("#ptnrDeptMbr").val("6608");				//김현수를 조재홍으로 변경 by top3009 (20240108 : 김규이사님 요청사항)
			}else if(conNo.charAt(0) == '1'){
				//$("#ptnrDeptMbr").val("4156");
				$("#ptnrDeptMbr").val("1598");			//안광선 > 윤현철로 변경 by top3009
			}else{
				$("#ptnrDeptMbr").val("0");
			}
			$("#ptnrDeptMbr").change();
		}
	}		
	</script>	

	<div style ="text-align:center; margin-top:10px;">	
		<input type="hidden" id="workloadKind" name="workloadKind" value="${workloadKind}" /> <!-- 기준업무량 종류 -->
		<img src="./resources/ls_img/btn_ok.gif" id ="btnOk" style = "cursor:pointer;" /><!-- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!-- 		<img src="./resources/ls_img/btn_cancel.gif" id = "input"  style = "cursor:pointer;" /> -->
	</div>

</body>

</html>
