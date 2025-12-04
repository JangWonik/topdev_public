<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="true" %>
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
	
	<!-- 
	<%--<script src="./resources/daum/161109.js"></script>--%>
	<script src="./resources/daum/postcode.v2.js"></script>
	<script src='https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js'></script> -->

	<script>
	
		$(document).ready(function(){
			
			//우클릭방지
			document.oncontextmenu = function(){alert('보안정책으로 인해 우클릭 사용이 불가합니다.'); return false;}
			
			if ( "${suimSuit_18Vo.editYN2}" <  1 ){
				alert("접근 권한이 없습니다.");
				window.close();
				return false;
			}
			
			/* 조사 조기값 셋팅 시작*/
			$("input:radio[name='report1']:radio[value='${suimSuit_18Vo.report1}']").prop('checked', true);
			$("input:radio[name='report2']:radio[value='${suimSuit_18Vo.report2}']").prop('checked', true);
			$("input:radio[name='report3']:radio[value='${suimSuit_18Vo.report3}']").prop('checked', true);
			$("input:radio[name='report4']:radio[value='${suimSuit_18Vo.report4}']").prop('checked', true);
			$("input:radio[name='report5']:radio[value='${suimSuit_18Vo.report5}']").prop('checked', true);
			$("input:radio[name='report6']:radio[value='${suimSuit_18Vo.report6}']").prop('checked', true);
			$("input:radio[name='report7']:radio[value='${suimSuit_18Vo.report7}']").prop('checked', true);
			$("input:radio[name='report8']:radio[value='${suimSuit_18Vo.report8}']").prop('checked', true);
			$("input:radio[name='report9']:radio[value='${suimSuit_18Vo.report9}']").prop('checked', true);
			
			$("#inputIdbd1O option[value='${suimSuit_18Vo.bd1O}']").attr("selected", true); //소유자 계약자 관계
			
			/* 조사 조기값 셋팅 끝*/
			
			$(".inputJosaClass18").hide();
			
			$("#josaEditeBtn").click(function(){
				if("${suimSuit_18Vo.suimRptState}" != 0 && "${suimSuit_18Vo.suimRptState}" != 11 && ("${mbrVo_Session.user_no}" != "1305") && ("${mbrVo_Session.user_no}" != "1117") && ("${mbrVo_Session.user_no}" != "1337") && ("${mbrVo_Session.user_no}" != "2737")){
					alert("상신 이후 수정할 수 없습니다. '상신 취소'를 하거나 결재자에게 '결재 취소'를 받으십시오.");
					return;
				}
				
				if("${suimSuit_18Vo.delDate}" > 0){
					alert("삭제된 보고서는 수정할 수 없습니다.");
					return;
				} 
				
				$("#josaEditeBtn").hide();
				$("#rptEditeBtn").hide();
				$("#josaEditeCancelBtn").show();
				$("#josaEditeOkBtn").show();
				
				$(".spanJosaClass18").hide();
				$(".inputJosaClass18").show();
				
				$("#inputIdbd1J").datepicker({ 
			    	   showOn: 'button',
			    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
			    	   buttonImageOnly: true,
			    	   buttonText: "달력", 
			    	   changeMonth: true,
			    	   changeYear: true,
			    	   showButtonPanel: false
			    });
				
				$("#inputIdbd2J").datepicker({ 
			    	   showOn: 'button',
			    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
			    	   buttonImageOnly: true,
			    	   buttonText: "달력", 
			    	   changeMonth: true,
			    	   changeYear: true,
			    	   showButtonPanel: false
			    });
				
				$("#inputIdbd3J").datepicker({ 
			    	   showOn: 'button',
			    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
			    	   buttonImageOnly: true,
			    	   buttonText: "달력", 
			    	   changeMonth: true,
			    	   changeYear: true,
			    	   showButtonPanel: false
			    });
				
			});
			
			$("#josaEditeCancelBtn").click(function(){
				$("#rptEditeBtn").show();
				$("#josaEditeBtn").show();
				$("#josaEditeCancelBtn").hide();
				$("#josaEditeOkBtn").hide();
				
				$(".spanJosaClass18").show();
				$(".inputJosaClass18").hide();
				
			});
			
			$("#josaEditeOkBtn").click(function(){
				
				var ptnrDeptNm = $("#ptnrDeptNmInput").val();
				
				var r1 = $("input:radio[name='report1']:checked").val();
				var r2 = $("input:radio[name='report2']:checked").val();
				var r3 = $("input:radio[name='report3']:checked").val();
				var r4 = $("input:radio[name='report4']:checked").val();
				var r5 = $("input:radio[name='report5']:checked").val();
				var r6 = $("input:radio[name='report6']:checked").val();
				var r7 = $("input:radio[name='report7']:checked").val();
				var r8 = $("input:radio[name='report8']:checked").val();
				var r9 = $("input:radio[name='report9']:checked").val();
				var r10 = $("#report10").val();
				
				var inputIdbd1N = $("#inputIdbd1N").val();
				var inputIdbd1O = $("#inputIdbd1O option:selected").val();
				var inputIdbd1K = $("#inputIdbd1K").val();
				var inputIdbd1L = $("#inputIdbd1L").val();
				var inputIdbd1M = $("#inputIdbd1M").val();
				var inputIdbd1I = $("#inputIdbd1I").val();
				var inputIdbd1J = $("#inputIdbd1J").val();
				
				var inputIdbd2N = $("#inputIdbd2N").val();
				var inputIdbd2O = $("#inputIdbd2O option:selected").val();
				var inputIdbd2K = $("#inputIdbd2K").val();
				var inputIdbd2L = $("#inputIdbd2L").val();
				var inputIdbd2M = $("#inputIdbd2M").val();
				var inputIdbd2I = $("#inputIdbd2I").val();
				var inputIdbd2J = $("#inputIdbd2J").val();
				
				var inputIdbd3N = $("#inputIdbd3N").val();
				var inputIdbd3O = $("#inputIdbd3O option:selected").val();
				var inputIdbd3K = $("#inputIdbd3K").val();
				var inputIdbd3L = $("#inputIdbd3L").val();
				var inputIdbd3M = $("#inputIdbd3M").val();
				var inputIdbd3I = $("#inputIdbd3I").val();
				var inputIdbd3J = $("#inputIdbd3J").val();
				

				$.post("./josa18EditeOk",
						
						{	 
							 suimRptNo	         	:'${suimSuit_18Vo.suimRptNo}'
							,report1 	        	:r1
							,report2 	        	:r2
							,report3 	        	:r3
							,report4 	        	:r4
							,report5 	        	:r5
							,report6 	        	:r6
							,report7 	        	:r7
							,report8 	        	:r8
							,report9 	        	:r9
							,report10 	        	:$.trim(r10)
							
							,ptnrDeptNm				:ptnrDeptNm
							
							,bd1N 	        :inputIdbd1N
							,bd1O 	        :inputIdbd1O
							,bd1K 	        :inputIdbd1K
							,bd1L 	        :inputIdbd1L
							,bd1M 	        :inputIdbd1M
							,bd1I 	        :inputIdbd1I
							,bd1J 	        :inputIdbd1J
							
							,bd2N 	        :inputIdbd2N
							,bd2O 	        :inputIdbd2O
							,bd2K 	        :inputIdbd2K
							,bd2L 	        :inputIdbd2L
							,bd2M 	        :inputIdbd2M
							,bd2I 	        :inputIdbd2I
							,bd2J 	        :inputIdbd2J
							
							,bd3N 	        :inputIdbd3N
							,bd3O 	        :inputIdbd3O
							,bd3K 	        :inputIdbd3K
							,bd3L 	        :inputIdbd3L
							,bd3M 	        :inputIdbd3M
							,bd3I 	        :inputIdbd3I
							,bd3J 	        :inputIdbd3J
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("저장 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									alert("저장되었습니다.");
									location.reload();
									
									
									/* 버튼 처리 */
									/* 170116
									/* ajax후 결재가 정상적으로 이뤄지지 않음. reload로 변경 하여 notUSED
									$("#rptEditeBtn").show();
									$("#josaEditeBtn").show();
									$("#josaEditeCancelBtn").hide();
									$("#josaEditeOkBtn").hide();
									$(".spanJosaClass18").show();
									$(".inputJosaClass18").hide();
									*/
									/* 수정된 값 셋팅 */
									/*
									$("#ptnrDeptNmSpan").html(ptnrDeptNm);
									$("#spanIdReport1").html(getValForJosa1(r1));
									$("#spanIdReport2").html(getValForJosa2(r2));
									$("#spanIdReport3").html(getValForJosa3(r3));
									$("#spanIdReport4").html(getValForJosa45678911(r4));
									$("#spanIdReport5").html(getValForJosa45678911(r5));
									$("#spanIdReport6").html(getValForJosa45678911(r6));
									$("#spanIdReport7").html(getValForJosa45678911(r7));
									$("#spanIdReport8").html(getValForJosa45678911(r8));
									$("#spanIdReport9").html(getValForJosa45678911(r9));
									$("#spanIdReport10").html(r10);
									
									$("#spanIdbd1N").html(inputIdbd1N);
									$("#spanIdbd1O").html(getValForJosaSo(inputIdbd1O));
									$("#spanIdbd1K").html(inputIdbd1K);
									$("#spanIdbd1L").html(inputIdbd1L);
									$("#spanIdbd1M").html(inputIdbd1M);
									$("#spanIdbd1I").html(inputIdbd1I);
									$("#spanIdbd1J").html(inputIdbd1J);
									
									$("#spanIdbd2N").html(inputIdbd2N);
									$("#spanIdbd2O").html(getValForJosaSo(inputIdbd2O));
									$("#spanIdbd2K").html(inputIdbd2K);
									$("#spanIdbd2L").html(inputIdbd2L);
									$("#spanIdbd2M").html(inputIdbd2M);
									$("#spanIdbd2I").html(inputIdbd2I);
									$("#spanIdbd2J").html(inputIdbd2J);
									
									$("#spanIdbd3N").html(inputIdbd3N);
									$("#spanIdbd3O").html(getValForJosaSo(inputIdbd3O));
									$("#spanIdbd3K").html(inputIdbd3K);
									$("#spanIdbd3L").html(inputIdbd3L);
									$("#spanIdbd3M").html(inputIdbd3M);
									$("#spanIdbd3I").html(inputIdbd3I);
									$("#spanIdbd3J").html(inputIdbd3J);
									*/									
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}//function
				);//post
			});
			
			$("#rptEditeBtn").click(function(){
				
				if("${suimSuit_18Vo.suimRptState}" != 0 && "${suimSuit_18Vo.suimRptState}" != 11 && ("${mbrVo_Session.user_no}" != "1305") && ("${mbrVo_Session.user_no}" != "1117") && ("${mbrVo_Session.user_no}" != "1337") && ("${mbrVo_Session.user_no}" != "2737")){
					alert("상신 이후 수정할 수 없습니다. '상신 취소'를 하거나 결재자에게 '결재 취소'를 받으십시오.");
					return;
				}
				
				if("${suimSuit_18Vo.delDate}" > 0){
					alert("삭제된 보고서는 수정할 수 없습니다.");
					return;
				} 
				
				rpt18EditePop('${suimSuit_18Vo.suimRptNo}');
			});
			
			/* 워드 다운 DB 호출 방식으로 수정*/
			$("#suit18Word").click(function (){				
				
				var url = "suitWorkAuthChk";
				
				var param = {};
								
				param.suim_rpt_state = "${suimSuit_18Vo.suimRptState}";				//보고서 종결상태
				
				$.ajax({
		       	        type: "POST",
		       	        url: url,
		       	        data: param,
		       	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		       	        timeout: 20000,
		       	        async: false,
		       	        dataType: "html", 
		       	        success: function(data){
		       	        	
		       	        	if (data == 1){			//권한이 있거나 미결인 경우
		       	        		suit18Word("${suimSuit_18Vo.suimRptNo}");
		       	        	}else if(data == 9){	//종결로인해 전환이 불가능한 경우
		       	        		alert("종결건은 워드전환이 불가능합니다.\n인보험기획팀에 문의하세요.");    		
		       	        	}else{
		       	        		alert("워드전환 권한이 없습니다.\n인보험기획팀에 문의하세요.");
		       	        	}
		       	        	
		       	        }
		       	    });
			});
			
			/* 응답전문 다운 */
			$("#suit18Rs").click(function (){
				if("${suimSuit_18Vo.suimRptState}" != 2){
					alert("종결건만 가능합니다.");
					return;
				}
				
				$.get("./suit18Rs",
						{
							suim_rpt_no : "${suimSuit_18Vo.suimRptNo}"
						},
						function(data,status){
							if(status == "success"){
								
								if(data == 1){
									alert("전문전송 실패, 시스템 관리자에게 문의하세요.");
									
								}else{
									alert("전문 전송 완료.")	
								}
							}
						}
				);
				
				//suit18Rs("${suimSuit_18Vo.suimRptNo}");
			});
			
			$("#sms1").click(function(){
				
				samsungSMS(1,"${suimSuit_18Vo.suimRptNo}");
				
			});
			
			$("#sms2").click(function(){
				samsungSMS(2,"${suimSuit_18Vo.suimRptNo}");
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
			
			$("#suimPtnrMbrPopBtn").click(function(){//보험사, 보험사 직원 바꾸기 팝업
				var cw=screen.availWidth;
				var ch=screen.availHeight;
				var sw=500; //띄울 창의 넓이
				var sh=550;  //띄울 창의 높이
				var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
				var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
				window.open('suimPtnrMbrPop?gbNo='+$("#gbNoForPop").val()+'&smNo='+$("#smNoForPop").val()+'&ptnrNo='+$("#ptnrNoForPop").val(),'SuimTmMbrPop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			});//$("#suimPtnrMbrPopBtn").click
			
			/* 종결일 수정 */
			$("#endDateBtn").click(function(){
				
				if(!("${suimSuit_18Vo.close_date}" > 0) ){
					alert("종결건이 아니거나, 종결일 정보가 없습니다.");
					return;
				}
				
				var cw=screen.availWidth;
				var ch=screen.availHeight;
				var sw=350; //띄울 창의 넓이
				var sh=200;  //띄울 창의 높이
				var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
				var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
				window.open('endDateUdt?suimRptNo='+"${suimSuit_18Vo.suimRptNo}"+"&accNo="+"${suimSuit_18Vo.suimAcceptNo}"+"&endDate="+"${suimSuit_18Vo.closeDate}",'endDateUdt','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			});
			
			//적부 보안데이터 팝업창 버튼
			$(".popView").click(function(){
				
				var param = {};
				param.suimRptNo = $(this).attr("suimRptNo");
				param.ptnrId	= $(this).attr("ptnrId");
				param.target	= $(this).attr("target");
				param.suitFlag	= "18";
				
		        var url = "./getContractInfo";

		        $.ajax({
		            type: "POST",
		            url: url,
		            data: param,
		            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		            dataType: "json",
		            timeout: 20000,
		            success: function(data){
		                if(data.result == "0000"){
		     				$("#secuDataHead").html(data.title);
		     				$("#secuDataContent").html(data.contents);
		     				
		     				fnOpenSecuData();
		                }else{
		                    alert("입력된 데이터가 없습니다.");
		                }
		            },
		            error: function(e){
		                alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		            }
		        });
				
// 				var suimRptNo = $(this).attr("suimRptNo");
// 				var ptnrId= $(this).attr("ptnrId");
// 				var target = $(this).attr("target");
				
// 				var cw=screen.availWidth;
// 				var ch=screen.availHeight;
// 				var sw=540; //띄울 창의 넓이
// 				var sh=160;  //띄울 창의 높이
// 				var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
// 				var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
//  				window.open('getContractInfo?suimRptNo='+suimRptNo+'&ptnrId='+ptnrId+'&target='+target+'&suitFlag='+18,'_blank','width='+sw+',height='+sh+',top='+mt+',left='+ml+'scrollbars=no,resizable=no');
				
			});
			
		}); //document.ready
		
		function samsungSMS(smsType,suimRptNo){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=380; //띄울 창의 넓이
			var sh=233;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('smsPageCall?smsType='+smsType+'&suimRptNo='+suimRptNo,'samsungSMS','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}//openSMS
		
		function suit18Word(suimRptNo){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1010; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('suit18Word?suim_rpt_no='+suimRptNo,'rptEditePop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}//suit18Word
		
		function suit18Rs(suimRptNo){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1010; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('suit18Rs?suim_rpt_no='+suimRptNo,'rptEditePop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}//suit18Rs
		
		function getValForJosa45678911(obj){
			
			var str ='';
			
			if(obj == '1'){
				str = '일치';
			}else if(obj == '2'){
				str = '불일치';
			}else if(obj == '3'){
				str = '미확인';
			}
			return str;
		}
		
		function getValForJosa1(obj){
			
			var str ='';
			
			if(obj == '01'){
				str = '조사완료';
			}else if(obj == '02'){
				str = '조사실패';
			}
			return str;
		}
		
		function getValForJosa2(obj){
			
			var str ='';
			
			if(obj == '00'){
				str = '정상';
			}else if(obj == '01'){
				str = '전화연락 안됨(3회이상)';
			}else if(obj == '02'){
				str = '방문 자체에 불만표시';
			}else if(obj == '03'){
				str = '방문은 허용하였으나 조사에 불만표시';
			}else if(obj == '04'){
				str = 'RC거절';
			}else if(obj == '05'){
				str = '기타';
			}
			
			return str;
		}
		
		function getValForJosa3(obj){
			
			var str ='';
			
			if(obj == '1'){
				str = '전부일치';
			}else if(obj == '2'){
				str = '일부일치';
			}else if(obj == '9'){
				str = '조사실패';
			}
			return str;
		}
		
		function getValForJosaSo(obj){
			
			var str ='';
			
			if(obj == '00'){
				str = '';
			}else if(obj == '01'){
				str = '본인';
			}else if(obj == '02'){
				str = '배우자';
			}else if(obj == '03'){
				str = '자녀';
			}else if(obj == '04'){
				str = '부모';
			}else if(obj == '05'){
				str = '기타가족';
			}else if(obj == '06'){
				str = '친족';
			}else if(obj == '07'){
				str = '고용관계';
			}else if(obj == '08'){
				str = '계열사관계';
			}else if(obj == '99'){
				str = '기타';
			}
			return str;
			
		}
		
		function rpt18EditePop(suimRptNo){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1010; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('rpt18EditePop?suim_rpt_no='+suimRptNo,'rptEditePop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}//rptEdite
		
		function openSMS(hpNo){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=450; //띄울 창의 넓이
			var sh=533;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('simpleSMSForm?hpNo='+hpNo,'simpleSMS','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}//openSMS
		
		function subEndPass(){
			
			var bd1I = "${suimSuit_18Vo.bd1I}";
			var bd2I = "${suimSuit_18Vo.bd2I}";
			var bd3I = "${suimSuit_18Vo.bd3I}";
			
			var bd1J = "${suimSuit_18Vo.bd1J}";
			var bd2J = "${suimSuit_18Vo.bd2J}";
			var bd3J = "${suimSuit_18Vo.bd3J}";
			
			var bd1A = "${suimSuit_18Vo.bd1A}"; 
			var bd2A = "${suimSuit_18Vo.bd2A}";
			var bd3A = "${suimSuit_18Vo.bd3A}";
			
			var bd1N = "${suimSuit_18Vo.bd1N}";
			var bd1O = "${suimSuit_18Vo.bd1O}";
			var bd1K = "${suimSuit_18Vo.bd1K}";
			var bd1L = "${suimSuit_18Vo.bd1L}";
			var bd1M = "${suimSuit_18Vo.bd1M}";
			
			var bd2N = "${suimSuit_18Vo.bd2N}";
			var bd2O = "${suimSuit_18Vo.bd2O}";
			var bd2K = "${suimSuit_18Vo.bd2K}";
			var bd2L = "${suimSuit_18Vo.bd2L}";
			var bd2M = "${suimSuit_18Vo.bd2M}";
			
			var bd3N = "${suimSuit_18Vo.bd3N}";
			var bd3O = "${suimSuit_18Vo.bd3O}";
			var bd3K = "${suimSuit_18Vo.bd3K}";
			var bd3L = "${suimSuit_18Vo.bd3L}";
			var bd3M = "${suimSuit_18Vo.bd3M}";
			
			var r1 = $("#spanIdReport1").html();
			var r2 = $("#spanIdReport2").html();
			var r3 = $("#spanIdReport3").html();
			var r4 = $("#spanIdReport4").html();
			var r5 = $("#spanIdReport5").html();
			var r6 = $("#spanIdReport6").html();
			var r7 = $("#spanIdReport7").html();
			var r8 = $("#spanIdReport8").html();
			var r9 = $("#spanIdReport9").html();
			var r10 = $("#spanIdReport10").html();
			
			if( bd1N = '' || (bd2A != '' && bd2N == '') || (bd3A != '' && bd3N == '') ){
				alert("소유자명이 없습니다!");
				return false;
			}
			
			if( bd1O = '' || (bd2A != '' && bd2O == '') || (bd3A != '' && bd3O == '') ){
				alert("소유자와의 관계가 없습니다!");
				return false;
			}
			
			if( bd1K = '' || (bd2A != '' && bd2K == '') || (bd3A != '' && bd3K == '') ){
				alert("건물급수가 없습니다!");
				return false;
			}
			
			if( bd1L = '' || (bd2A != '' && bd2L == '') || (bd3A != '' && bd3L == '') ){
				alert("가입업종이 없습니다!");
				return false;
			}
			
			if( bd1M = '' || (bd2A != '' && bd2M == '') || (bd3A != '' && bd3M == '') ){
				alert("요율업종이 없습니다!");
				return false;
			}
			
			var cnt =0;
			if( bd1A != '' && ( bd1I == '' || bd1J < 1 ) ){
				cnt++;
			}
			
			if( bd2A != '' && ( bd2I == '' || bd2J < 1 ) ){
				cnt++;
			}
			
			if( bd3A != '' && ( bd3I == '' || bd3J < 1 ) ){
				cnt++;
			}
			
			if(cnt > 0){
				alert("실사일 또는 면담자가 없습니다!");
				return false;
			}
			
			
			if(r3 ==1 &&
				(r4 !=1 || r5 !=1 || r6 !=1 || r7 !=1 || r8 != 1 || r9 != 1)		
			){
				alert("조사결과가 전부일치하지 않습니다!!!");
				return false;
			}
			
			if(r3 !=1 &&
				(r4 ==1 || r5 ==1 || r6 ==1 || r7 ==1 || r8 == 1 || r9 == 1)		
			){
				alert("조사결과가 전부일치하지 않습니다!!!");
				return false;
			}
			
			if( (r1=='02' && r2 != '' && r3 == 9 ) || (r1 != '' && r2 != '' && r3 != '' && r4 != '' && r5 != '' && r6 != ''
					&& r7 != '' && r8 != '' && r9 != '' && r10 != '') ){
				return true;
			}else{
				alert("처리결과가 완전하지 않습니다.!!!");
				return false;
			}
			
		}
		
		function action_report(action){
			
			if(action =='end') {
				if(!confirm("종결 하시겠습니까?")){
					return;
				}	
			}else if(action =='returnRpt'){
				if(!confirm("반려 하시겠습니까?")){
					return;
				}
			}else if(action =='return_x'){
				if(!confirm("반려건을 재결재 하시겠습니까?")){
					return;
				}
			}else if(action =='submit_x'){
				if(!confirm("결재 상신을 취소 하시겠습니까?")){
					return;
				}
			}else if(action =='submit'){
				if(!confirm("결재를 올리겠습니까?")){
					return;
				}
			}else if(action == 'submit_e_x'){
				if(!confirm("종결 취소하시겠습니까?")){
					return;
				}
			}else if(action == 'report_del'){
				if(!confirm("보고서를 삭제 하시겠습니까?")){
					return;
				}
			}else if(action == 'cancel'){
				if(!confirm("위임 취소 하시겠습니까?")){
					return;
				}
			}else if(action == 'cancel_x'){
				if(!confirm("위임 취소를 취소 하시겠습니까?")){
					return;
				}
			}
			
			if(action == 'submit'){ /* 결재하기 시작 */
				
				if(!subEndPass()){
					return;	
				}
				
			}else if(action == 'end'){ /* 종결하기 시작 */
				
				if(!subEndPass()){
					return;	
				}
			}
			
			/* 결재 취소 submit_x : 유효 검사 없음 */
			/* 반려하기 returnRpt : 유효 검사 없음 */
			
			$.post("./actionSuit18ReportOk",
					{	
						 action  		:action
				 		,suimRptNo   	:"${suimSuit_18Vo.suimRptNo}"  
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("실패하였습니다. 관리자에게 문의해 주세요.");
							}else if(data ==1){
								
								if(action == 'submit'){
									alert("결재 완료 하였습니다.");
								}else if(action == 'submit_x'){
									alert("결재 취소 하였습니다.");
								}else if(action == 'returnRpt'){
									alert("반려 하였습니다.");
								}else if(action == 'return_x'){
									alert("재결재 하였습니다.");
								}else if(action == 'end'){
									alert("종결 하였습니다.");
								}else if(action == 'submit_e_x'){
									alert("종결 취소 하였습니다.");
								}else if(action == 'cancel'){
									alert("위임 취소 하였습니다.");
								}else if(action == 'cancel_x'){
									alert("위임 취소를 취소 하였습니다. 최초 수임 상태로 되돌아갑니다.");
								}else if(action == 'report_del'){
									alert("보고서를 삭제하였습니다.");
								}
							}
							window.opener.location.reload();	
							location.reload();								
							
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}
			);//post
		}
		

		function getBytes(str) {
		    var contents = new String( str );
		    var str_character;
		    var int_char_count;
		    var int_contents_length;

		    int_char_count = 0;
		    int_contents_length = contents.length;

		    for (k = 0; k < int_contents_length; k++) {
		        str_character = contents.charAt(k);
		        if (escape(str_character).length > 4){
		            int_char_count += 2;
		        }else{
		            int_char_count++;
		        }
		    }
		    return int_char_count;
		}
		
		function fnStrLengthChk(obj){
			var str = obj.value;
			var strLength = getBytes(str);
			
			if (strLength >= 20){
				if (event.keyCode != 8){
					event.returnValue=false;
					alert("글자가 깁니다..");
				}
			}
		}
		
		function fnOpenSecuData(){
			$("#secu-dialog").dialog({
				height: 200,
				width: 500,
				closeOnEscape : true,
				draggable : false,
				buttons:{
					"취소" : function(){
						$(this).dialog("close");
					}
				},
				modal: true,
				overlay:{ opacity: 0., background: '#000000'}
			});
		}

	</script>
	<style>
		.tableStyle2 td{
			letter-spacing: 0px !important;
		}
		
		.ui-button-text-only {
			height:2.1em !important;
		}
		.ui-widget-overlay{
			opacity: 1.0;
			background: '#000000'
		}
		
	</style>
</head>
<body>
	<input type="hidden" name="gbNoForPop" id="gbNoForPop" value="318" />
	<input type="hidden" name="ptnrNoForPop" id="ptnrNoForPop" value="${suimSuit_18Vo.ptnrId}" />
	<input type="hidden" name="smNoForPop" id="smNoForPop" value="${suimSuit_18Vo.suimRptNo}" />
	<input type="hidden" name="tmNoForPop" id="tmNoForPop" value="${suimSuit_18Vo.teamId}" />
	<!-- header --><!--2016.01.14.rjh.수정.교체.-->
	<div id="headerpop_mbr">
		<div class="inner clear_v2">
			<h1>
				<img src="./resources/wm_img/common/logo.gif" height="40" alt="top - TRUST OBLIGATION PASSION" />
			</h1>
			<div style="text-align:center;padding-top:10px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
				<font color="white"><b><span style="font-size:11pt;"> 장기 물보험 적부 시스템 - 삼성</span></b></font>
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
								<li class="on" id="rptBase"><a href="#">보고서 기본정보</a></li>
								<li><a href="#">이미지 파일</a></li>
							</ul>
						</div>

						<div class="guestcnt5" style="display:block;">

							<div class= "tableStyle6">
								<input type="hidden" id = "suimRptNo" value= "${suimSuit_18Vo.suimRptNo}"/>
								<input type="hidden" id = "suimRptTopTm" value= "${suimSuit_18Vo.teamId}"/>
								
								<table align="center" style = "margin-top:10px;" >
								
									<colgroup>
										<col width="25%">
										<col width="30%">
										<col width="20%">
										<col width="25%">
									</colgroup>
									<tr>
										<td colspan="2" align="left" style="border-right:0px;">
											<b> 보고서 기본 정보
											</b>
										</td>
										<td colspan="2" align="right" style="border-left:0px;" >
											<c:choose>
												<c:when test="${suimSuit_18Vo.delDate != 0 }">
													<font color="red"><b>※ 삭제된 보고서 입니다.</b></font>
												</c:when>
												<c:otherwise>
													<!-- 결재하기 -->
													<c:if test="${suimSuit_18Vo.suimRptState eq '0'}"> <!-- $_a_work5_w -->
														<c:if test="${suimSuit_18Vo.editYN2 > 0 or (mbrVo.user_no eq '1337' or mbrVo.user_no eq '2737' or mbrVo.user_no eq '1305')  }">
															<img src="./resources/ls_img/report/btn_rch_1.gif" onclick="action_report('submit');" style="cursor:pointer;"/>
														</c:if>
													</c:if>
													
													<!-- 결재취소하기 -->
													<c:if test="${suimSuit_18Vo.suimRptState eq '1'}"> <!-- $_a_work6_w -->
														<c:if test="${suimSuit_18Vo.editYN2 > 0 or (mbrVo.user_no eq '1337' or mbrVo.user_no eq '2737' or mbrVo.user_no eq '1305')  }">
															<img src="./resources/ls_img/report/btn_rch_1x.gif" onclick="action_report('submit_x');" style="cursor:pointer;"/>
														</c:if>
														<c:if test="${suimSuit_18Vo.suimRptState eq '11'}"> <!-- 반려건인지 확인 -->
															<c:if test="${suimSuit_18Vo.editYN2 > 0 or (mbrVo.user_no eq '1337' or mbrVo.user_no eq '2737' or mbrVo.user_no eq '1305')  }">
																<img src="./resources/ls_img/report/btn_rch_return_x.gif" onclick="action_report('return_x');" style="cursor:pointer;"/>												
															</c:if>
														</c:if>																										
													</c:if>
													
													<c:if test="${suimSuit_18Vo.suimRptState eq '11'}">
														<c:if test="${mbrVo.user_no eq suimSuit_18Vo.userNo or (mbrVo.user_no eq '1337' or mbrVo.user_no eq '2737' or mbrVo.user_no eq '1305') }">
															<img src="./resources/ls_img/report/btn_rch_1x.gif" onclick="action_report('submit_x');" style="cursor:pointer;"/>
															<img src="./resources/ls_img/report/btn_rch_return_x.gif" onclick="action_report('return_x');" style="cursor:pointer;"/>	
														</c:if>
													</c:if>
													
													<!-- 종결하기 -->
													<c:if test="${suimSuit_18Vo.suimRptState eq '1'}"> <!-- 건상태가 진행중이면 -->
														<c:if test="${mbrVo.user_no eq '1337' or mbrVo.user_no eq '2737' or mbrVo.user_no eq '1305' }" >
														<%-- <c:if test="${suimSuit_18Vo.suimRptAprvUserNo eq mbrVo.user_no}"> --%> <!-- and mbrAuthSessionVo.mbr_pms_4 eq '1'  -->
															<img src="./resources/ls_img/report/btn_rch_return.gif" border=0 onclick="action_report('returnRpt');" style="cursor:pointer;"/>
															<img src="./resources/ls_img/report/btn_rch_2.gif" border=0 onclick="action_report('end');" style="cursor:pointer;"/>
														<%-- </c:if> --%>
														</c:if>
													</c:if>
													
													<!-- 종결취소하기 -->
													<c:if test="${suimSuit_18Vo.suimRptState eq '2'  }"> <!-- and suimSuit_18Vo.suimRptAprvUserNo eq mbrVo.user_no --> <!-- and mbrAuthSessionVo.mbr_pms_4 eq '1' -->
														<c:if test="${mbrVo.user_no eq '1337' or mbrVo.user_no eq '2737' or mbrVo.user_no eq '1305'}" >
															<img src="./resources/ls_img/report/btn_rch_2x.gif" border=0 onclick="action_report('submit_e_x');" style="cursor:pointer;"/>
														</c:if>
													</c:if>	
													
													<!-- 위임취소하기 -->
													<c:if test="${suimSuit_18Vo.suimRptState ne '3' and suimSuit_18Vo.suimRptState ne '4' and suimSuit_18Vo.suimRptState ne '2' and  mbrAuthVo.mbr_pms_4 eq '1' }">
														<img src="./resources/ls_img/report/btn_rch_3.gif" border=0 onclick="action_report('cancel');" style="cursor:pointer;"/>
													</c:if>
													
													<!-- 위임취소하기를 취소하기 -->
													<c:if test="${suimSuit_18Vo.suimRptState eq '3' and mbrAuthVo.mbr_pms_4 eq '1' }">
														<img src="./resources/ls_img/report/btn_rch_3x.gif" border=0 onclick="action_report('cancel_x');" style="cursor:pointer;"/>
													</c:if>
													
													<!-- 보고서 삭제하기 -->
													<c:if test="${suimSuit_18Vo.suimRptState ne '2' and mbrAuthVo.mbr_pms_3 eq '1'}">
														<img src="./resources/ls_img/report/btn_report_del.gif" border=0 onclick="action_report('report_del');" style="cursor:pointer;"/>
													</c:if>
												</c:otherwise>
											</c:choose>
											
												
										</td>
										<!-- 보고서 상태 값 변경 관리 끝 -->
									</tr>
									<tr>
										<td bgcolor="#E7ECF1"><b>ㆍ접수번호</b></td>
										<td colspan="3">
											${suimSuit_18Vo.suimAcceptNo}
											<c:if test="${mbrVo.user_state eq 9}">
												<img src="./resources/ls_img/report/icon_change.gif" id="endDateBtn" style="cursor:pointer;" border="0" width="14" height="14">											
											</c:if>
										</td>
									</tr>
									<tr>
										<td bgcolor="#E7ECF1"><b>ㆍ처리팀</b></td>
										<td>${suimSuit_18Vo.teamName}</td>
										<td bgcolor="#E7ECF1"><b>ㆍ처리 담당자</b></td>
										<td >
											<c:if test="${suimSuit_18Vo.mbrChgYN > '0'}">
												<img src="./resources/ls_img/report/icon_change.gif" id="suimTmMbrPopBtn" style="cursor:pointer;" border="0" width="14" height="14">
											</c:if>
											${suimSuit_18Vo.userName}
											<c:if test="${suimSuit_18Vo.handphone != ''}">
												&nbsp;<img src="./resources/ls_img/report/icon_hp.gif" style="cursor:pointer;" onclick="openSMS('${suimSuit_18Vo.handphone}');" />
												${suimSuit_18Vo.handphone}
											</c:if>
										</td>
									</tr>
									<tr>
										<td bgcolor="#E7ECF1"><b>ㆍ보험사</b></td>
										<td>
											${suimSuit_18Vo.ptnrName}
										</td>
										<td bgcolor="#E7ECF1"><b>ㆍ보험사 담당자</b></td>
										<td>
											<c:if test="${suimSuit_18Vo.suimRptState != 2
												&& suimSuit_18Vo.teamId == mbrVo_Session.team_id_main
												&& (mbrVo_Session.work_type_cd == 3 || mbrVo_Session.work_type_cd == 4
													|| mbrVo_Session.work_type_cd == 7 || mbrVo_Session.work_type_cd == 8)}">
												<img src="./resources/ls_img/report/icon_change.gif" id="suimPtnrMbrPopBtn" style="cursor:pointer;" border="0" width="14" height="14">
											</c:if>
											${suimSuit_18Vo.ptnrMbrNm}
											<c:if test="${suimSuit_18Vo.ptnrMbrOfficeTel != ''}">
												&nbsp;<img src="./resources/ls_img/report/icon_hp.gif" style="cursor:pointer;" onclick="openSMS('${suimSuit_18Vo.ptnrMbrOfficeTel}');" />
												${suimSuit_18Vo.ptnrMbrOfficeTel}
											</c:if>
										</td>
									</tr>
									<tr>
										<td bgcolor="#E7ECF1"><b>ㆍ보험사 담당부서</b></td>
										<td colspan="3">
											<span class="spanJosaClass18" id = "ptnrDeptNmSpan">
												${suimSuit_18Vo.ptnrDeptNm}
											</span>
											<span class = "inputJosaClass18">
												<input type="text" size="20" id = "ptnrDeptNmInput" value= "${suimSuit_18Vo.ptnrDeptNm}"/>
											</span>
										</td>
									</tr>
									<tr>
										<td bgcolor="#E7ECF1"><b>ㆍ조사내용</b></td>
										<td >
											<c:if test="${suimSuit_18Vo.editYN2 > 0}">
												<img src="./resources/ls_img/report/icon_contract_josa.gif" id="josaEditeBtn" style="cursor:pointer; margin-right:5px;" border="0" >
												<img src="./resources/ls_img/report/icon_contract_report.gif" id="rptEditeBtn" style="cursor:pointer;" border="0" >
											</c:if>
											
											<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "josaEditeCancelBtn" style="display:none; cursor:pointer; " />
											<img src="./resources/ls_img/icon_write.gif" title="저장" id = "josaEditeOkBtn" style=" display:none; cursor:pointer; margin-right:5px;" />
										</td>
										<td bgcolor="#E7ECF1"><b>ㆍ처리결과</b></td>
										<td style="text-align:center;">
<%-- 											<c:if test="${mbrAuthVo.mbr_pms_19 == 1}"> --%>
											<img src="./resources/ls_img/report/icon_word.gif" id="suit18Word" style="cursor:pointer; margin-right:5px;" border="0" >
<%-- 											</c:if> --%>
											<c:if test="${mbrAuthVo.mbr_pms_20 == 1}">
												<img src="./resources/ls_img/report/icon_contract_rs.gif" id = "suit18Rs" style="cursor:pointer;" border="0" >
											</c:if>
										</td>
									</tr>
									<!-- <?if($row[end_date]<1 && $row[cancel_date]<1){?> -->
									<tr>
										<td bgcolor="#EDEDED" class="td" height="25">
											<p><b>ㆍsms(보험취급자)</b></p>
										</td>
										<td class="td">
											<p>
											<c:choose>
												<c:when test="${conCnt1 > 0 }">
													발송완료
												</c:when>
												<c:otherwise>
													<c:choose>
														<c:when test="${suimSuit_18Vo.clerkHndPhoneNo ne '' 
														and (
																(fn:substring(suimSuit_18Vo.clerkHndPhoneNo,0,3) eq '010') or 
																(fn:substring(suimSuit_18Vo.clerkHndPhoneNo,0,3) eq '011') or 
																(fn:substring(suimSuit_18Vo.clerkHndPhoneNo,0,3) eq '016') or
																(fn:substring(suimSuit_18Vo.clerkHndPhoneNo,0,3) eq '017') or
																(fn:substring(suimSuit_18Vo.clerkHndPhoneNo,0,3) eq '018') or
																(fn:substring(suimSuit_18Vo.clerkHndPhoneNo,0,3) eq '019')
															) 
														
														}">
														<img src="./resources/ls_img/btn_sms_s.gif" id="sms1" title="클릭시 자동 발송됩니다." style="cursor:pointer;"/>
														</c:when>
														<c:otherwise>
															<font color='#cccccc'>해당無</font>
														</c:otherwise>
													</c:choose>
												</c:otherwise> 
											</c:choose>
											</p>
										</td>
										<td bgcolor="#EDEDED" class="td" height="25" align="center">
											<p><b>sms(보험계약자)</b></p>
										</td>
										<td class="td">
											<p>
												<c:choose>
													<c:when test="${conCnt2 > 0 }">
														발송완료
													</c:when>
													<c:otherwise>
												
														<c:choose>
															<c:when test="${suimSuit_18Vo.conHndPhoneNo ne '' 
															and (
																	(fn:substring(suimSuit_18Vo.conHndPhoneNo,0,3) eq '010') or 
																	(fn:substring(suimSuit_18Vo.conHndPhoneNo,0,3) eq '011') or 
																	(fn:substring(suimSuit_18Vo.conHndPhoneNo,0,3) eq '016') or
																	(fn:substring(suimSuit_18Vo.conHndPhoneNo,0,3) eq '017') or
																	(fn:substring(suimSuit_18Vo.conHndPhoneNo,0,3) eq '018') or
																	(fn:substring(suimSuit_18Vo.conHndPhoneNo,0,3) eq '019')
																) 
															}">
																<c:choose>
																	<c:when test="${ (conCnt1 > 0 and timeDiffer > 3600) or (cn1Ok eq 'ok')}">
																		<img src="./resources/ls_img/btn_sms_s.gif" id="sms2" title="클릭시 자동 발송됩니다." style="cursor:pointer;"/>
																	</c:when>
																	<c:otherwise>
																		<img src='./resources/ls_img/btn_sms_r.gif' border=0 title='취급자에게 문자 발송 후 1시간 이후에 발송가능합니다.'>
																	</c:otherwise>
																</c:choose>
															</c:when>
															
															<c:otherwise>
																<font color='#cccccc'>해당無</font>
															</c:otherwise>
															
														</c:choose>
													
												</c:otherwise> 
											</c:choose>
											</p>
										</td>
									</tr>
									<tr>
					                    <td bgcolor="#DCFFDC" class="td" height="25">
											<p><b>ㆍ<input type="radio" class = "inputJosaClass18" name = "report1"  value=""/>조사완료여부</b></p>
					                    </td>
					                    <td class="td" colspan="3">
											<p>
												<span class="spanJosaClass18" id = "spanIdReport1">
													<c:choose>
														<c:when test="${suimSuit_18Vo.report1 eq '01'}">조사완료</c:when>
														<c:when test="${suimSuit_18Vo.report1 eq '02'}">조사실패</c:when>
													</c:choose>											
												</span>
												<span class = "inputJosaClass18">
													<input type="radio" name = "report1"  value="01"/> 조사완료
													<input type="radio" name = "report1"  value="02"/> 조사실패
												</span>										
											</p>
					                    </td>
									</tr>
					                <tr>
					                    <td bgcolor="#DCFFDC" class="td" height="25">
											<p><b>ㆍ<input type="radio" class = "inputJosaClass18" name="report2"  value=''>방문승낙,거절사유</b></p>
					                    </td>
					                    <td class="td" colspan="3">
					                    	<p>
												<span class="spanJosaClass18" id = "spanIdReport2">
													<c:choose>
														<c:when test="${suimSuit_18Vo.report2 eq '00'}">정상</c:when>
														<c:when test="${suimSuit_18Vo.report2 eq '01'}">전화연락 안됨(3회이상)</c:when>
														<c:when test="${suimSuit_18Vo.report2 eq '02'}">방문자체에 불만표시</c:when>
														<c:when test="${suimSuit_18Vo.report2 eq '03'}">방문은 허용하였으나 조사에 불만표시</c:when>
														<c:when test="${suimSuit_18Vo.report2 eq '04'}">RC거절</c:when>
														<c:when test="${suimSuit_18Vo.report2 eq '05'}">기타</c:when>
													</c:choose>											
												</span>
												<span class = "inputJosaClass18">
													<input type="radio" name="report2"  value='00'> 정상
													<input type="radio" name="report2"  value='01'> 전화연락 안됨(3회이상)
													<input type="radio" name="report2"  value='02'> 방문자체에 불만표시 <br />
													<input type="radio" name="report2"  value='03'> 방문은 허용하였으나 조사에 불만표시
													<input type="radio" name="report2"  value='04'> RC거절
													<input type="radio" name="report2"  value='05'> 기타
												</span>
											</p>
					                    </td>
									</tr>
					                <tr>
					                    <td bgcolor="#DCFFDC" class="td" height="25">
											<p><b>ㆍ<input type="radio" class = "inputJosaClass18" name="report3"  value='' >조사결과</b></p>
					                    </td>
					                    <td class="td" colspan="3">
											<p>
												<span class="spanJosaClass18" id = "spanIdReport3">
													<c:choose>
														<c:when test="${suimSuit_18Vo.report3 eq '1'}">전부일치</c:when>
														<c:when test="${suimSuit_18Vo.report3 eq '2'}">일부일치</c:when>
														<c:when test="${suimSuit_18Vo.report3 eq '9'}">조사실패</c:when>
													</c:choose>											
												</span>
												<span class = "inputJosaClass18">
													<input type="radio" name="report3"  value='1' > 전부일치
													<input type="radio" name="report3"  value='2' > 일부일치
													<input type="radio" name="report3"  value='9' > 조사실패
												</span>
											</p>
					                    </td>
									</tr>
					                <tr>
					                    <td bgcolor="#DCFFDC" class="td" height="25">
											<p><b>ㆍ<input type="radio" class = "inputJosaClass18" name="report4"  value='' >소유자 일치여부</b></p>
					                    </td>
					                    <td class="td" colspan="3">
					                    	<p>
												<span class="spanJosaClass18" id = "spanIdReport4">
													<c:choose>
														<c:when test="${suimSuit_18Vo.report4 eq '1'}">일치</c:when>
														<c:when test="${suimSuit_18Vo.report4 eq '2'}">불일치</c:when>
														<c:when test="${suimSuit_18Vo.report4 eq '3'}">미확인</c:when>
													</c:choose>											
												</span>
												<span class = "inputJosaClass18">
													<input type="radio" name="report4"  value='1' > 일치
													<input type="radio" name="report4"  value='2' > 불일치
													<input type="radio" name="report4"  value='3' > 미확인
												</span>
											</p>
					                    </td>
									</tr>
					                <tr>
					                    <td bgcolor="#DCFFDC" class="td" height="25">
											<p><b>ㆍ<input type="radio" class = "inputJosaClass18" name="report5"  value='' >소재지 일치여부</b></p>
					                    </td>
					                    <td class="td" colspan="3">
											<p>
												<span class="spanJosaClass18" id = "spanIdReport5">
													<c:choose>
														<c:when test="${suimSuit_18Vo.report5 eq '1'}">일치</c:when>
														<c:when test="${suimSuit_18Vo.report5 eq '2'}">불일치</c:when>
														<c:when test="${suimSuit_18Vo.report5 eq '3'}">미확인</c:when>
													</c:choose>											
												</span>
												<span class = "inputJosaClass18">
													<input type="radio" name="report5"  value='1' > 일치
													<input type="radio" name="report5"  value='2' > 불일치
													<input type="radio" name="report5"  value='3' > 미확인
												</span>
											</p>
					                    </td>
									</tr>
					                <tr>
					                    <td bgcolor="#DCFFDC" class="td" height="25">
											<p><b>ㆍ<input type="radio" class = "inputJosaClass18" name="report6"  value='' >건물급수 일치여부</b></p>
					                    </td>
					                    <td class="td" colspan="3">
											<p>
												<span class="spanJosaClass18" id = "spanIdReport6">
													<c:choose>
														<c:when test="${suimSuit_18Vo.report6 eq '1'}">일치</c:when>
														<c:when test="${suimSuit_18Vo.report6 eq '2'}">불일치</c:when>
														<c:when test="${suimSuit_18Vo.report6 eq '3'}">미확인</c:when>
													</c:choose>											
												</span>
												<span class = "inputJosaClass18">
													<input type="radio" name="report6"  value='1' > 일치
													<input type="radio" name="report6"  value='2' > 불일치
													<input type="radio" name="report6"  value='3' > 미확인
												</span>
											</p>
					                    </td>
									</tr>
					                <tr>
					                    <td bgcolor="#DCFFDC" class="td" height="25">
											<p><b>ㆍ<input type="radio" class = "inputJosaClass18" name="report7"  value='' >가입업종 일치여부</b></p>
					                    </td>
					                    <td class="td" colspan="3">
											<p>
												<span class="spanJosaClass18" id = "spanIdReport7">
													<c:choose>
														<c:when test="${suimSuit_18Vo.report7 eq '1'}">일치</c:when>
														<c:when test="${suimSuit_18Vo.report7 eq '2'}">불일치</c:when>
														<c:when test="${suimSuit_18Vo.report7 eq '3'}">미확인</c:when>
													</c:choose>											
												</span>
												<span class = "inputJosaClass18">
													<input type="radio" name="report7"  value='1' > 일치
													<input type="radio" name="report7"  value='2' > 불일치
													<input type="radio" name="report7"  value='3' > 미확인
												</span>
											</p>
					                    </td>
									</tr>
					                <tr>
					                    <td bgcolor="#DCFFDC" class="td" height="25">
											<p><b>ㆍ<input type="radio" class = "inputJosaClass18" name="report8"  value='' >요율업종 일치여부</b></p>
					                    </td>
					                    <td class="td" colspan="3">
											<p>
												<span class="spanJosaClass18" id = "spanIdReport8">
													<c:choose>
														<c:when test="${suimSuit_18Vo.report8 eq '1'}">일치</c:when>
														<c:when test="${suimSuit_18Vo.report8 eq '2'}">불일치</c:when>
														<c:when test="${suimSuit_18Vo.report8 eq '3'}">미확인</c:when>
													</c:choose>											
												</span>
												<span class = "inputJosaClass18">
													<input type="radio" name="report8"  value='1' > 일치
													<input type="radio" name="report8"  value='2' > 불일치
													<input type="radio" name="report8"  value='3' > 미확인
												</span>
											</p>
					                    </td>
									</tr>
					                <tr>
					                    <td bgcolor="#DCFFDC" class="td" height="25">
											<p><b>ㆍ<input type="radio" class = "inputJosaClass18" name="report9"  value='' >야적동산 일치여부</b></p>
					                    </td>
					                    <td class="td" colspan="3">
											<p>
												<span class="spanJosaClass18" id = "spanIdReport9">
													<c:choose>
														<c:when test="${suimSuit_18Vo.report9 eq '1'}">일치</c:when>
														<c:when test="${suimSuit_18Vo.report9 eq '2'}">불일치</c:when>
														<c:when test="${suimSuit_18Vo.report9 eq '3'}">미확인</c:when>
													</c:choose>											
												</span>
												<span class = "inputJosaClass18">
													<input type="radio" name="report9"  value='1' > 일치
													<input type="radio" name="report9"  value='2' > 불일치
													<input type="radio" name="report9"  value='3' > 미확인
												</span>
											</p>
					                    </td>
									</tr>
					                <tr>
					                    <td bgcolor="#DCFFDC" class="td" height="25">
											<p><b>ㆍ조사결과 텍스트</b></p>
					                    </td>
					                    <td class="td" colspan="3">
											<p>
												<span class="spanJosaClass18" id = "spanIdReport10">
													${suimSuit_18Vo.report10}
												</span>
												<span class = "inputJosaClass18">
													<input type="text" name="report10" id="report10" value='${suimSuit_18Vo.report10}'size="50" maxlength="300" >
												</span>
											</p>
					                    </td>
									</tr>
								</table>
								
								<!-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& -->
								<p>&nbsp;</p>
					            <table cellpadding="0" cellspacing="0" align="center" width="600">
					           		<colgroup>
										<col width="25%">
										<col width="75%">
									</colgroup>
	                                <tr>
					                    <td bgcolor="#EDEDED" class="td" width="125" height="25">
											<p><b>ㆍ신청구분</b></p>
					                    </td>
					                    <td class="td" width="475">
											<p>
												<c:choose>
													<c:when test="${suimSuit_18Vo.medType eq 11}">
														재산보험 적부
													</c:when>
													<c:otherwise>
														${suimSuit_18Vo.medType}
													</c:otherwise>
												</c:choose>
											</p>
					                    </td>
									</tr>
	                                <tr>
					                    <td bgcolor="#EDEDED" class="td" width="125" height="25">
											<p><b>ㆍ전문발송일</b></p>
					                    </td>
					                    <td class="td" width="475">
											<p>${suimSuit_18Vo.sendDate}</p>
					                    </td>
									</tr>
	                                <tr>
					                    <td bgcolor="#EDEDED" class="td" height="25">
											<p><b>ㆍ적부업체</b></p>
					                    </td>
					                    <td class="td">
											<p>
												<c:choose>
													<c:when test="${suimSuit_18Vo.ivstComName eq '01'}">
														탑
													</c:when>
													<c:otherwise>
														다스카
													</c:otherwise>
												</c:choose>
											</p>
					                    </td>
									</tr>
	                                <tr>
					                    <td bgcolor="#EDEDED" class="td" height="25">
											<p><b>ㆍ증권번호</b></p>
					                    </td>
					                    <td class="td">
											<p>${suimSuit_18Vo.plcyNo}</p>
					                    </td>
									</tr>
									<tr>
					                    <td bgcolor="#EDEDED" class="td" height="25">
											<p><b>ㆍ설계번호</b></p>
					                    </td>
					                    <td class="td">
											<p>
												${suimSuit_18Vo.entyDsgnNo}
											</p>
					                    </td>
									</tr>
									<tr>
					                    <td bgcolor="#EDEDED" class="td" height="25">
											<p><b>ㆍ상품명</b></p>
					                    </td>
					                    <td class="td">
											<p>
												${suimSuit_18Vo.pkgName}
											</p>
					                    </td>
									</tr>
	                                <tr>
					                    <td bgcolor="#EDEDED" class="td" height="25">
											<p><b>ㆍ청약일자</b></p>
					                    </td>
					                    <td class="td">
											<p>${suimSuit_18Vo.agrmDate}</p>
					                    </td>
									</tr>
									<tr>
					                    <td bgcolor="#EDEDED" class="td" height="25">
											<p><b>ㆍ계약자명</b></p>
					                    </td>
					                    <td class="td">
											<p>
												<img class="popView" suimRptNo="${suimSuit_18Vo.suimRptNo}" ptnrId="${suimSuit_18Vo.ptnrId}" target="contractorName" src="./resources/ls_img/btns_view.gif" width="30" height="18" border="0" style="cursor:pointer;">
											</p>
					                    </td>
									</tr>
									<tr>
					                    <td bgcolor="#EDEDED" class="td" height="25">
											<p><b>ㆍ계약자핸드폰</b></p>
					                    </td>
					                    <td class="td">
											<p>
												<img class="popView" style="cursor:pointer;" suimRptNo="${suimSuit_18Vo.suimRptNo}" ptnrId="${suimSuit_18Vo.ptnrId}" target="conHndPhoneNo"  src="./resources/ls_img/btns_view.gif" width="30" height="18" border="0">
											</p>
					                    </td>
									</tr>
									<tr>
					                    <td bgcolor="#EDEDED" class="td" height="25">
											<p><b>ㆍ계약자자택</b></p>
					                    </td>
					                    <td class="td">
											<p>
													<img class="popView" style="cursor:pointer;" suimRptNo="${suimSuit_18Vo.suimRptNo}" ptnrId="${suimSuit_18Vo.ptnrId}" target="conHomeTelNo" src="./resources/ls_img/btns_view.gif" width="30" height="18" border="0">
												</a>
											</p>
					                    </td>
									</tr>
									<p>&nbsp;</p>
            						<table cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="599">
	            						<colgroup>
											<col width="25%">
											<col width="75%">
										</colgroup>
                                		<tr>
						                    <td bgcolor="#E4CAFF" class="td" colspan="2" width="591">
												<p><B><font color="black">ㆍ건물 1</font></B></p>
						                    </td>
										</tr>
                              			<tr>
						                    <td bgcolor="#EDEDED" class="td" width="147" height="25">
												<p>ㆍ소유자명</p>
						                    </td>
									        <td class="td" width="437">
												<p>
													<img class="popView" style="cursor:pointer;" suimRptNo="${suimSuit_18Vo.suimRptNo}" ptnrId="${suimSuit_18Vo.ptnrId}" target="bd1_a" src="./resources/ls_img/btns_view.gif" width="30" height="18" border="0">
												</p>
									        </td>
										</tr>
                               			<tr>
						                    <td bgcolor="#EDEDED" class="td" width="147" height="25">
												<p>ㆍ소유자 핸드폰</p>
						                    </td>
						                    <td class="td" width="437">
												<p>
													<img class="popView" style="cursor:pointer;" suimRptNo="${suimSuit_18Vo.suimRptNo}" ptnrId="${suimSuit_18Vo.ptnrId}" target="bd1_b" src="./resources/ls_img/btns_view.gif" width="30" height="18" border="0">
												</p>
						                    </td>
										</tr>
		                                <tr>
						                    <td bgcolor="#EDEDED" class="td" width="147" height="25">
												<p>ㆍ우편번호</p>
						                    </td>
						                    <td class="td" width="437">
												<p>${suimSuit_18Vo.bd1C}</p>
						                    </td>
										</tr>
		                                <tr>
						                    <td bgcolor="#EDEDED" class="td" width="147" height="25">
												<p>ㆍ소재지명</p>
						                    </td>
						                    <td class="td" width="437">
												<p>
													<img class="popView" style="cursor:pointer;" suimRptNo="${suimSuit_18Vo.suimRptNo}" ptnrId="${suimSuit_18Vo.ptnrId}" target="bd1_d" src="./resources/ls_img/btns_view.gif" width="30" height="18" border="0">
												</p>
						                    </td>
										</tr>
		                                <tr>
						                    <td bgcolor="#EDEDED" class="td" width="147" height="25">
												<p>ㆍ소유자 계약자와 관계</p>
						                    </td>
						                    <td class="td" width="437">
												<p>			
													<c:choose>
														<c:when test="${suimSuit_18Vo.bd1E eq '00'}"></c:when>	
														<c:when test="${suimSuit_18Vo.bd1E eq '01'}">본인</c:when>
														<c:when test="${suimSuit_18Vo.bd1E eq '02'}">배우자</c:when>
														<c:when test="${suimSuit_18Vo.bd1E eq '03'}">자녀</c:when>
														<c:when test="${suimSuit_18Vo.bd1E eq '04'}">부모</c:when>
														<c:when test="${suimSuit_18Vo.bd1E eq '05'}">기타가족</c:when>
														<c:when test="${suimSuit_18Vo.bd1E eq '06'}">친족</c:when>
														<c:when test="${suimSuit_18Vo.bd1E eq '07'}">고용관계</c:when>
														<c:when test="${suimSuit_18Vo.bd1E eq '08'}">계열사관계</c:when>
														<c:when test="${suimSuit_18Vo.bd1E eq '99'}">기타</c:when>
													</c:choose>
												</p>
									         </td>
										</tr>
		                                <tr>
						                    <td bgcolor="#EDEDED" class="td" width="147" height="25">
												<p>ㆍ건물급수</p>
						                    </td>
						                    <td class="td" width="437">
												<p>
													<c:if test="${suimSuit_18Vo.bd1F ne ''}">${suimSuit_18Vo.bd1F} 급</c:if>
												</p>
						                    </td>
										</tr>
		                                <tr>
						                    <td bgcolor="#EDEDED" class="td" width="147" height="25">
												<p>ㆍ가입업종명</p>
						                    </td>
						                    <td class="td" width="437">
												<p>${suimSuit_18Vo.bd1G }</p>
						                    </td>
										</tr>
                                		<tr>
						                    <td bgcolor="#EDEDED" class="td" width="147" height="25">
												<p>ㆍ요율업종명</p>
						                    </td>
						                    <td class="td" width="437">
												<p>${suimSuit_18Vo.bd1H }</p>
						                    </td>
										</tr>
										<tr>
											<td bgcolor="#DCFFDC" class="td" width="147" height="25">
												<p>ㆍ소유자명</p>
											</td>
											<td class="td" width="437">
												<span class="spanJosaClass18" id = "spanIdbd1N">
													${suimSuit_18Vo.bd1N }									
												</span>
												<span class = "inputJosaClass18">
													<input type="text" size="20" id = "inputIdbd1N" onkeydown="fnStrLengthChk(this,20);" value="${suimSuit_18Vo.bd1N}" /> <font color="#CC3300">&nbsp;&lt;- 실명기재(일치,불일치 금지)</font>
												</span>
											</td>
										</tr>
										<tr>
											<td bgcolor="#DCFFDC" class="td" width="147" height="25">
												<p>ㆍ소유자와관계</p>
											</td>
											<td class="td" width="437">
												<p>
													<span class="spanJosaClass18" id = "spanIdbd1O">
														<c:choose>
															<c:when test="${suimSuit_18Vo.bd1O eq '00'}"></c:when>	
															<c:when test="${suimSuit_18Vo.bd1O eq '01'}">본인</c:when>
															<c:when test="${suimSuit_18Vo.bd1O eq '02'}">배우자</c:when>
															<c:when test="${suimSuit_18Vo.bd1O eq '03'}">자녀</c:when>
															<c:when test="${suimSuit_18Vo.bd1O eq '04'}">부모</c:when>
															<c:when test="${suimSuit_18Vo.bd1O eq '05'}">기타가족</c:when>
															<c:when test="${suimSuit_18Vo.bd1O eq '06'}">친족</c:when>
															<c:when test="${suimSuit_18Vo.bd1O eq '07'}">고용관계</c:when>
															<c:when test="${suimSuit_18Vo.bd1O eq '08'}">계열사관계</c:when>
															<c:when test="${suimSuit_18Vo.bd1O eq '99'}">기타</c:when>
														</c:choose>	
													</span>
													<span class = "inputJosaClass18">
														<select id="inputIdbd1O">
															<option value="00"></option>
															<option value="01">본인</option>
															<option value="02">배우자</option>
															<option value="03">자녀</option>
															<option value="04">부모</option>
															<option value="05">기타가족</option>
															<option value="06">친족</option>
															<option value="07">고용관계</option>
															<option value="08">계열사관계</option>
															<option value="99">기타</option>
														</select>
													</span>
												</p>
											</td>
										</tr>
										<tr>
											<td bgcolor="#DCFFDC" class="td" width="147" height="25">
												<p>ㆍ급수</p>
											</td>
											<td class="td" width="437">
												<p>
													<span class="spanJosaClass18" id = "spanIdbd1K">
														<c:if test="${suimSuit_18Vo.bd1K ne ''}">${suimSuit_18Vo.bd1K} 급</c:if>
													</span>
													<span class = "inputJosaClass18" >
														<input type="text" size="3" id = "inputIdbd1K" value="${suimSuit_18Vo.bd1K}"/> 급
														<font color="#CC3300">&nbsp;&lt;- 숫자만입력</font>
													</span>
												</p>
											</td>
										</tr>
										<tr>
											<td bgcolor="#DCFFDC" class="td" width="147" height="25">
												<p>ㆍ가입업종명</p>
											</td>
											<td class="td" width="437">
												<span class="spanJosaClass18" id = "spanIdbd1L">
													${suimSuit_18Vo.bd1L}
												</span>
												<span class = "inputJosaClass18" >
													<input type="text" size="20" id = "inputIdbd1L" value="${suimSuit_18Vo.bd1L}"/> 
													<font color="#CC3300">&nbsp;&lt;- 가입업종입력(일치,불일치 금지)</font>
												</span>
											</td>
										</tr>
										<tr>
											<td bgcolor="#DCFFDC" class="td" width="147" height="25">
												<p>ㆍ요율업종</p>
											</td>
											<td class="td" width="437">
												<span class="spanJosaClass18" id = "spanIdbd1M">
													${suimSuit_18Vo.bd1M}
												</span>
												<span class = "inputJosaClass18" >
													<input type="text" size="20" id = "inputIdbd1M" value="${suimSuit_18Vo.bd1M}"/> 
													<font color="#CC3300">&nbsp;&lt;- 요율업종입력(일치,불일치 금지)</font>
												</span>
											</td>
										</tr>
										<tr>
											<td bgcolor="#DCFFDC" class="td" width="147" height="25">
												<p>ㆍ면담자명</p>
											</td>
											<td class="td" width="437">
												<p>
													<span class="spanJosaClass18" id = "spanIdbd1I">
														${suimSuit_18Vo.bd1I}
													</span>
													<span class = "inputJosaClass18" >
														<input type="text" size="20" id = "inputIdbd1I" onkeydown="fnStrLengthChk(this,20);" value="${suimSuit_18Vo.bd1I}"/> 
														<font color="#CC3300">&nbsp;&lt;- 실명(관계) <b>예) 홍길동(본인)</b></font>
													</span>
												</p>
											</td>
										</tr>
										<tr>
											<td bgcolor="#DCFFDC" class="td" width="147" height="25">
												<p>ㆍ실사일</p>
											</td>
											<td class="td" width="437">
												<p>
													<span class="spanJosaClass18" id = "spanIdbd1J">
														${suimSuit_18Vo.bd1J}
													</span>
													<span class = "inputJosaClass18" >
														<input type="text" size="10" id = "inputIdbd1J" value="${suimSuit_18Vo.bd1J}"/> 
													</span>
												</p>
											</td>
										</tr>
										<tr>
						                    <td bgcolor="#E4CAFF" class="td" colspan="2" width="591">
												<p><B><font color="black">ㆍ건물 2</font></B></p>
						                    </td>
										</tr>
										<tr>
						                    <td bgcolor="#EDEDED" class="td" width="147" height="25">
												<p>ㆍ소유자명</p>
						                    </td>
									        <td class="td" width="437">
												<p>
													<img class="popView" style="cursor:pointer;" suimRptNo="${suimSuit_18Vo.suimRptNo}" ptnrId="${suimSuit_18Vo.ptnrId}" target="bd2_a" src="./resources/ls_img/btns_view.gif" width="30" height="18" border="0">
												</p>
									        </td>
										</tr>
                               			<tr>
						                    <td bgcolor="#EDEDED" class="td" width="147" height="25">
												<p>ㆍ소유자 핸드폰</p>
						                    </td>
						                    <td class="td" width="437">
												<p>
													<img class="popView" style="cursor:pointer;" suimRptNo="${suimSuit_18Vo.suimRptNo}" ptnrId="${suimSuit_18Vo.ptnrId}" target="bd2_b" src="./resources/ls_img/btns_view.gif" width="30" height="18" border="0">
												</p>
						                    </td>
										</tr>
		                                <tr>
						                    <td bgcolor="#EDEDED" class="td" width="147" height="25">
												<p>ㆍ우편번호</p>
						                    </td>
						                    <td class="td" width="437">
												<p>${suimSuit_18Vo.bd2C}</p>
						                    </td>
										</tr>
		                                <tr>
						                    <td bgcolor="#EDEDED" class="td" width="147" height="25">
												<p>ㆍ소재지명</p>
						                    </td>
						                    <td class="td" width="437">
												<p>
													<img class="popView" style="cursor:pointer;" suimRptNo="${suimSuit_18Vo.suimRptNo}" ptnrId="${suimSuit_18Vo.ptnrId}" target="bd2_d" src="./resources/ls_img/btns_view.gif" width="30" height="18" border="0">
												</p>
						                    </td>
										</tr>
		                                <tr>
						                    <td bgcolor="#EDEDED" class="td" width="147" height="25">
												<p>ㆍ소유자 계약자와 관계</p>
						                    </td>
						                    <td class="td" width="437">
												<p>			
													<c:choose>
														<c:when test="${suimSuit_18Vo.bd2E eq '00'}"></c:when>	
														<c:when test="${suimSuit_18Vo.bd2E eq '01'}">본인</c:when>
														<c:when test="${suimSuit_18Vo.bd2E eq '02'}">배우자</c:when>
														<c:when test="${suimSuit_18Vo.bd2E eq '03'}">자녀</c:when>
														<c:when test="${suimSuit_18Vo.bd2E eq '04'}">부모</c:when>
														<c:when test="${suimSuit_18Vo.bd2E eq '05'}">기타가족</c:when>
														<c:when test="${suimSuit_18Vo.bd2E eq '06'}">친족</c:when>
														<c:when test="${suimSuit_18Vo.bd2E eq '07'}">고용관계</c:when>
														<c:when test="${suimSuit_18Vo.bd2E eq '08'}">계열사관계</c:when>
														<c:when test="${suimSuit_18Vo.bd2E eq '99'}">기타</c:when>
													</c:choose>
												</p>
									         </td>
										</tr>
		                                <tr>
						                    <td bgcolor="#EDEDED" class="td" width="147" height="25">
												<p>ㆍ건물급수</p>
						                    </td>
						                    <td class="td" width="437">
												<p>
													<c:if test="${suimSuit_18Vo.bd2F ne ''}">${suimSuit_18Vo.bd2F} 급</c:if>
												</p>
						                    </td>
										</tr>
		                                <tr>
						                    <td bgcolor="#EDEDED" class="td" width="147" height="25">
												<p>ㆍ가입업종명</p>
						                    </td>
						                    <td class="td" width="437">
												<p>${suimSuit_18Vo.bd2G }</p>
						                    </td>
										</tr>
                                		<tr>
						                    <td bgcolor="#EDEDED" class="td" width="147" height="25">
												<p>ㆍ요율업종명</p>
						                    </td>
						                    <td class="td" width="437">
												<p>${suimSuit_18Vo.bd2H }</p>
						                    </td>
										</tr>
										<tr>
											<td bgcolor="#DCFFDC" class="td" width="147" height="25">
												<p>ㆍ소유자명</p>
											</td>
											<td class="td" width="437">
												<span class="spanJosaClass18" id = "spanIdbd2N">
													${suimSuit_18Vo.bd2N}									
												</span>
												<span class = "inputJosaClass18">
													<input type="text" size="20" onkeydown="fnStrLengthChk(this,20);" id = "inputIdbd2N" value= "${suimSuit_18Vo.bd2N}"/> 
												</span>
											</td>
										</tr>
										<tr>
											<td bgcolor="#DCFFDC" class="td" width="147" height="25">
												<p>ㆍ소유자와관계</p>
											</td>
											<td class="td" width="437">
												<p>
													<span class="spanJosaClass18" id = "spanIdbd2O">
														<c:choose>
															<c:when test="${suimSuit_18Vo.bd2O eq '00'}"></c:when>	
															<c:when test="${suimSuit_18Vo.bd2O eq '01'}">본인</c:when>
															<c:when test="${suimSuit_18Vo.bd2O eq '02'}">배우자</c:when>
															<c:when test="${suimSuit_18Vo.bd2O eq '03'}">자녀</c:when>
															<c:when test="${suimSuit_18Vo.bd2O eq '04'}">부모</c:when>
															<c:when test="${suimSuit_18Vo.bd2O eq '05'}">기타가족</c:when>
															<c:when test="${suimSuit_18Vo.bd2O eq '06'}">친족</c:when>
															<c:when test="${suimSuit_18Vo.bd2O eq '07'}">고용관계</c:when>
															<c:when test="${suimSuit_18Vo.bd2O eq '08'}">계열사관계</c:when>
															<c:when test="${suimSuit_18Vo.bd2O eq '99'}">기타</c:when>
														</c:choose>	
													</span>
													<span class = "inputJosaClass18">
														<select id="inputIdbd2O">
															<option value="00"></option>
															<option value="01">본인</option>
															<option value="02">배우자</option>
															<option value="03">자녀</option>
															<option value="04">부모</option>
															<option value="05">기타가족</option>
															<option value="06">친족</option>
															<option value="07">고용관계</option>
															<option value="08">계열사관계</option>
															<option value="99">기타</option>
														</select>
													</span>
												</p>
											</td>
										</tr>
										<tr>
											<td bgcolor="#DCFFDC" class="td" width="147" height="25">
												<p>ㆍ급수</p>
											</td>
											<td class="td" width="437">
												<p>
													<span class="spanJosaClass18" id = "spanIdbd2K">
														<c:if test="${suimSuit_18Vo.bd2K ne ''}">${suimSuit_18Vo.bd2K} 급</c:if>
													</span>
													<span class = "inputJosaClass18" >
														<input type="text" size="3" id = "inputIdbd2K" value="${suimSuit_18Vo.bd2K}"/> 급
													</span>
												</p>
											</td>
										</tr>
										<tr>
											<td bgcolor="#DCFFDC" class="td" width="147" height="25">
												<p>ㆍ가입업종명</p>
											</td>
											<td class="td" width="437">
												<span class="spanJosaClass18" id = "spanIdbd2L">
													${suimSuit_18Vo.bd2L}
												</span>
												<span class = "inputJosaClass18" >
													<input type="text" size="20" id = "inputIdbd2L" value="${suimSuit_18Vo.bd2L}"/> 
												</span>
											</td>
										</tr>
										<tr>
											<td bgcolor="#DCFFDC" class="td" width="147" height="25">
												<p>ㆍ요율업종</p>
											</td>
											<td class="td" width="437">
												<span class="spanJosaClass18" id = "spanIdbd2M">
													${suimSuit_18Vo.bd2M}
												</span>
												<span class = "inputJosaClass18" >
													<input type="text" size="20" id = "inputIdbd2M" value="${suimSuit_18Vo.bd2M}"/> 
												</span>
											</td>
										</tr>
										<tr>
											<td bgcolor="#DCFFDC" class="td" width="147" height="25">
												<p>ㆍ면담자명</p>
											</td>
											<td class="td" width="437">
												<p>
													<span class="spanJosaClass18" id = "spanIdbd2I">
														${suimSuit_18Vo.bd2I}
													</span>
													<span class = "inputJosaClass18" >
														<input type="text" size="20" onkeydown="fnStrLengthChk(this,20);" id = "inputIdbd2I" value="${suimSuit_18Vo.bd2I}"/> 
													</span>
												</p>
											</td>
										</tr>
										<tr>
											<td bgcolor="#DCFFDC" class="td" width="147" height="25">
												<p>ㆍ실사일</p>
											</td>
											<td class="td" width="437">
												<p>
													<span class="spanJosaClass18" id = "spanIdbd2J">
														${suimSuit_18Vo.bd2J}
													</span>
													<span class = "inputJosaClass18" >
														<input type="text" size="10" id = "inputIdbd2J" value="${suimSuit_18Vo.bd2J}"/> 
													</span>
												</p>
											</td>
										</tr>
                                
		                                <tr>
						                    <td bgcolor="#E4CAFF" class="td" colspan="2" width="591">
												<p><B><font color="black">ㆍ건물 3</font></B></p>
						                    </td>
										</tr>
										<tr>
						                    <td bgcolor="#EDEDED" class="td" width="147" height="25">
												<p>ㆍ소유자명</p>
						                    </td>
									        <td class="td" width="437">
												<p>
													<img class="popView" style="cursor:pointer;" suimRptNo="${suimSuit_18Vo.suimRptNo}" ptnrId="${suimSuit_18Vo.ptnrId}" target="bd3_a" src="./resources/ls_img/btns_view.gif" width="30" height="18" border="0">
												</p>
									        </td>
										</tr>
                               			<tr>
						                    <td bgcolor="#EDEDED" class="td" width="147" height="25">
												<p>ㆍ소유자 핸드폰</p>
						                    </td>
						                    <td class="td" width="437">
												<p>
													<img class="popView" style="cursor:pointer;" suimRptNo="${suimSuit_18Vo.suimRptNo}" ptnrId="${suimSuit_18Vo.ptnrId}" target="bd3_b" src="./resources/ls_img/btns_view.gif" width="30" height="18" border="0">
												</p>
						                    </td>
										</tr>
		                                <tr>
						                    <td bgcolor="#EDEDED" class="td" width="147" height="25">
												<p>ㆍ우편번호</p>
						                    </td>
						                    <td class="td" width="437">
												<p>${suimSuit_18Vo.bd3C}</p>
						                    </td>
										</tr>
		                                <tr>
						                    <td bgcolor="#EDEDED" class="td" width="147" height="25">
												<p>ㆍ소재지명</p>
						                    </td>
						                    <td class="td" width="437">
												<p>
													<img class="popView" style="cursor:pointer;" suimRptNo="${suimSuit_18Vo.suimRptNo}" ptnrId="${suimSuit_18Vo.ptnrId}" target="bd3_d" src="./resources/ls_img/btns_view.gif" width="30" height="18" border="0">
												</p>
						                    </td>
										</tr>
		                                <tr>
						                    <td bgcolor="#EDEDED" class="td" width="147" height="25">
												<p>ㆍ소유자 계약자와 관계</p>
						                    </td>
						                    <td class="td" width="437">
												<p>			
													<c:choose>
														<c:when test="${suimSuit_18Vo.bd3E eq '00'}"></c:when>	
														<c:when test="${suimSuit_18Vo.bd3E eq '01'}">본인</c:when>
														<c:when test="${suimSuit_18Vo.bd3E eq '02'}">배우자</c:when>
														<c:when test="${suimSuit_18Vo.bd3E eq '03'}">자녀</c:when>
														<c:when test="${suimSuit_18Vo.bd3E eq '04'}">부모</c:when>
														<c:when test="${suimSuit_18Vo.bd3E eq '05'}">기타가족</c:when>
														<c:when test="${suimSuit_18Vo.bd3E eq '06'}">친족</c:when>
														<c:when test="${suimSuit_18Vo.bd3E eq '07'}">고용관계</c:when>
														<c:when test="${suimSuit_18Vo.bd3E eq '08'}">계열사관계</c:when>
														<c:when test="${suimSuit_18Vo.bd3E eq '99'}">기타</c:when>
													</c:choose>
												</p>
									         </td>
										</tr>
		                                <tr>
						                    <td bgcolor="#EDEDED" class="td" width="147" height="25">
												<p>ㆍ건물급수</p>
						                    </td>
						                    <td class="td" width="437">
												<p>
													<c:if test="${suimSuit_18Vo.bd3F ne ''}">${suimSuit_18Vo.bd3F} 급</c:if>
												</p>
						                    </td>
										</tr>
		                                <tr>
						                    <td bgcolor="#EDEDED" class="td" width="147" height="25">
												<p>ㆍ가입업종명</p>
						                    </td>
						                    <td class="td" width="437">
												<p>${suimSuit_18Vo.bd3G }</p>
						                    </td>
										</tr>
                                		<tr>
						                    <td bgcolor="#EDEDED" class="td" width="147" height="25">
												<p>ㆍ요율업종명</p>
						                    </td>
						                    <td class="td" width="437">
												<p>${suimSuit_18Vo.bd3H }</p>
						                    </td>
										</tr>
										<tr>
											<td bgcolor="#DCFFDC" class="td" width="147" height="25">
												<p>ㆍ소유자명</p>
											</td>
											<td class="td" width="437">
												<span class="spanJosaClass18" id = "spanIdbd3N">
													${suimSuit_18Vo.bd3N }									
												</span>
												<span class = "inputJosaClass18">
													<input type="text" size="20" onkeydown="fnStrLengthChk(this,20);" id = "inputIdbd3N" value= "${suimSuit_18Vo.bd3N}"/> 
												</span>
											</td>
										</tr>
										<tr>
											<td bgcolor="#DCFFDC" class="td" width="147" height="25">
												<p>ㆍ소유자와관계</p>
											</td>
											<td class="td" width="437">
												<p>
													<span class="spanJosaClass18" id = "spanIdbd3O">
														<c:choose>
															<c:when test="${suimSuit_18Vo.bd3O eq '00'}"></c:when>	
															<c:when test="${suimSuit_18Vo.bd3O eq '01'}">본인</c:when>
															<c:when test="${suimSuit_18Vo.bd3O eq '02'}">배우자</c:when>
															<c:when test="${suimSuit_18Vo.bd3O eq '03'}">자녀</c:when>
															<c:when test="${suimSuit_18Vo.bd3O eq '04'}">부모</c:when>
															<c:when test="${suimSuit_18Vo.bd3O eq '05'}">기타가족</c:when>
															<c:when test="${suimSuit_18Vo.bd3O eq '06'}">친족</c:when>
															<c:when test="${suimSuit_18Vo.bd3O eq '07'}">고용관계</c:when>
															<c:when test="${suimSuit_18Vo.bd3O eq '08'}">계열사관계</c:when>
															<c:when test="${suimSuit_18Vo.bd3O eq '99'}">기타</c:when>
														</c:choose>	
													</span>
													<span class = "inputJosaClass18">
														<select id="inputIdbd3O">
															<option value="00"></option>
															<option value="01">본인</option>
															<option value="02">배우자</option>
															<option value="03">자녀</option>
															<option value="04">부모</option>
															<option value="05">기타가족</option>
															<option value="06">친족</option>
															<option value="07">고용관계</option>
															<option value="08">계열사관계</option>
															<option value="99">기타</option>
														</select>
													</span>
												</p>
											</td>
										</tr>
										<tr>
											<td bgcolor="#DCFFDC" class="td" width="147" height="25">
												<p>ㆍ급수</p>
											</td>
											<td class="td" width="437">
												<p>
													<span class="spanJosaClass18" id = "spanIdbd3K">
														<c:if test="${suimSuit_18Vo.bd3K ne ''}">${suimSuit_18Vo.bd3K} 급</c:if>
													</span>
													<span class = "inputJosaClass18" >
														<input type="text" size="3" id = "inputIdbd3K" value="${suimSuit_18Vo.bd3K}"/> 급
													</span>
												</p>
											</td>
										</tr>
										<tr>
											<td bgcolor="#DCFFDC" class="td" width="147" height="25">
												<p>ㆍ가입업종명</p>
											</td>
											<td class="td" width="437">
												<span class="spanJosaClass18" id = "spanIdbd3L">
													${suimSuit_18Vo.bd3L}
												</span>
												<span class = "inputJosaClass18" >
													<input type="text" size="20" id = "inputIdbd3L" value="${suimSuit_18Vo.bd3L}"/> 
												</span>
											</td>
										</tr>
										<tr>
											<td bgcolor="#DCFFDC" class="td" width="147" height="25">
												<p>ㆍ요율업종</p>
											</td>
											<td class="td" width="437">
												<span class="spanJosaClass18" id = "spanIdbd3M">
													${suimSuit_18Vo.bd3M}
												</span>
												<span class = "inputJosaClass18" >
													<input type="text" size="20" id = "inputIdbd3M" value="${suimSuit_18Vo.bd3M}"/> 
												</span>
											</td>
										</tr>
										<tr>
											<td bgcolor="#DCFFDC" class="td" width="147" height="25">
												<p>ㆍ면담자명</p>
											</td>
											<td class="td" width="437">
												<p>
													<span class="spanJosaClass18" id = "spanIdbd3I">
														${suimSuit_18Vo.bd3I}
													</span>
													<span class = "inputJosaClass18" >
														<input type="text" size="20" onkeydown="fnStrLengthChk(this,20);" id = "inputIdbd3I" value="${suimSuit_18Vo.bd3I}"/> 
													</span>
												</p>
											</td>
										</tr>
										<tr>
											<td bgcolor="#DCFFDC" class="td" width="147" height="25">
												<p>ㆍ실사일</p>
											</td>
											<td class="td" width="437">
												<p>
													<span class="spanJosaClass18" id = "spanIdbd3J">
														${suimSuit_18Vo.bd3J}
													</span>
													<span class = "inputJosaClass18" >
														<input type="text" size="10" id = "inputIdbd3J" value="${suimSuit_18Vo.bd3J}"/> 
													</span>
												</p>
											</td>
										</tr>
            						</table>
						            <p>&nbsp;</p>
						            <table cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="599">
										<tr>
						                    <td bgcolor="#EDEDED" class="td" width="147" height="25">
												<p>ㆍ일반/공장구분</p>
						                    </td>
						                    <td class="td" width="437">
												<p>
													<c:choose>
														<c:when test="${suimSuit_18Vo.bdType eq 1}">일반</c:when>
														<c:otherwise>공장</c:otherwise>
													</c:choose>
												</p>
						                    </td>
										</tr>
						                <tr>
						                    <td bgcolor="#EDEDED" class="td" width="147" height="25">
												<p>ㆍ야적여부</p>
						                    </td>
						                    <td class="td" width="437">
												<p>
													<c:choose>
														<c:when test="${suimSuit_18Vo.bdItem eq 1}">없음</c:when>
														<c:otherwise>있음</c:otherwise>
													</c:choose>
												</p>
						                    </td>
										</tr>
						                <tr>
						                    <td bgcolor="#EDEDED" class="td" width="147" height="25">
												<p>ㆍ심사자요청사항1</p>
						                    </td>
						                    <td class="td" width="437">
												<p>${suimSuit_18Vo.memo1}</p>
						                    </td>
										</tr>
						                <tr>
						                    <td bgcolor="#EDEDED" class="td" width="147" height="25">
												<p>ㆍ심사자요청사항2</p>
						                    </td>
						                    <td class="td" width="437">
												<p>${suimSuit_18Vo.memo2}</p>
						                    </td>
										</tr>
						                <tr>
						                    <td bgcolor="#EDEDED" class="td" width="147" height="25">
												<p>ㆍ취급자성명</p>
						                    </td>
						                    <td class="td" width="437">
												<p>${suimSuit_18Vo.clerkName}</p>
						                    </td>
										</tr>
						                <tr>
						                    <td bgcolor="#EDEDED" class="td" width="147" height="25">
												<p>ㆍ취급자소속지역단명</p>
						                    </td>
						                    <td class="td" width="437">
												<p>${suimSuit_18Vo.clerkDeptName}</p>
						                    </td>
										</tr>
						                <tr>
						                    <td bgcolor="#EDEDED" class="td" width="147" height="25">
												<p>ㆍ취급자소속지점명</p>
						                    </td>
						                    <td class="td" width="437">
												<p>${suimSuit_18Vo.clerkSectName}</p>
						                    </td>
										</tr>
						                <tr>
						                    <td bgcolor="#EDEDED" class="td" width="147" height="25">
												<p>ㆍ취급자전화번호(직장)</p>
						                    </td>
						                    <td class="td" width="437">
												<p>${suimSuit_18Vo.clerkOfcTelNo}</p>
						                    </td>
										</tr>
										<tr>
						                    <td bgcolor="#EDEDED" class="td" width="147" height="25">
												<p>ㆍ취급자전화번호(휴대폰)</p>
						                    </td>
						                    <td class="td" width="437">
												<p>${suimSuit_18Vo.clerkHndPhoneNo}</p>
						                    </td>
										</tr>
									</table>
						            <p>&nbsp;</p>
									<table border=0 align="center" width="599">
										<tr>
											<td>
												<p>■ <b>문자 발송 내역</b></p>
						                    </td>
										</tr>
									</table>
									<table cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="599">
										<tr bgcolor="#EDEDED" align="center" height="25">
											<td class="td" nowrap>받는이</td>
											<td class="td" nowrap>받는번호<br>보낸번호</td>
											<td class="td" nowrap>내용</td>
											<td class="td" nowrap>시간</td>
										</tr>
										<c:forEach items="${samsungSmsList}" var="sms">
											<tr height="25" align="center">
												<td class="td" nowrap rowspan="2">
													<c:choose>
														<c:when test="${sms.smsType eq 1 }">
															취급자
														</c:when>
														<c:when test="${sms.smsType eq 2 }">
															계약자
														</c:when>
													</c:choose>
												</td>
												<td class="td" nowrap>${sms.rHp}</td>
												<td class="td" rowspan="2" align="left">${sms.rMsg}</td>
												<td class="td" nowrap rowspan="2">${fn:split(sms.sDate,',')[0]}<br>${fn:split(sms.sDate,',')[1]}</td>
											</tr>
											<tr height="25" align="center">
												<td class="td" nowrap>${sms.sHp}</td>
											</tr>
										</c:forEach>
										
									</table>
									<p>&nbsp;</p>
					            </table>
					            <p>&nbsp;</p>
							</div>
						<br>
						</div> <!-- guestcnt5 -->
						<div class="guestcnt5" >
							<div class= "tableStyle6">
								
								<table align="center" cellpadding="0" cellspacing="0" >
									<colgroup>
										<col width="30%">
										<col width="70%">
									</colgroup>
									<tr>
										<td colspan="2">
											<p><B><font color="black"> ※ 이미지 파일 전송 </font></B></p>
										</td>
									</tr>
									<tr>
										<td  align="center">
											<b>※ 파일 선택</b>
										</td>
										<td>
											<%@include file="../include/uploadform_suit18_img_send.jsp"%>
										</td>
									</tr>
								</table>
								<table  align="center" cellpadding="0" cellspacing="0" >
									
									<tr>
										<td colspan="2" align="center"><font color="blue">사진 목록</font></td>
									</tr>
									<tbody id = "suit18FileListBodySend" style="margin-bottom:20px;">
										<c:forEach items="${suimSuit_18_FileSendList}" var="suit18FileSendVo">
											<tr id = "suit18ImgSendTr_${suit18FileSendVo.serialNo}">
												<td>
													${suit18FileSendVo.fileCode}
												</td>
												<td align="center">
		 											<%-- <img src='./resources/ls_img/btn_del.gif' id = 'suit18ImgSendDelBtn_${suit18FileSendVo.serialNo}' 
		 												onclick="suit18ImgSendSubDel('${suit18FileSendVo.serialNo}','${suit18FileSendVo.suimRptNo}','${suit18FileSendVo.fileName}');" style='cursor:pointer;'/> --%>
		 												<font color="red"><b>전송완료</b></font>
												</td>
											</tr>
										</c:forEach>												
									</tbody>
								</table>
								
								<!-- 보안데이터 출력 모달 -->
								<div id="secu-dialog" title="보안 데이터 확인" style="font-size: 15px;display:none;" align="center">
									<br/>
									<div style="width: 380px;">
										<table border="1">
											<tr height="30">
												<th align="center" id="secuDataHead"  bgcolor="white"></th>
											<tr>
												<td align="center" id="secuDataContent" bgcolor="white" style="padding:3px;">
												</td>
											</tr>
										</table>
									</div>
								</div>
								
							</div>
						</div>
					</div><!-- //guest -->
				</div><!-- //bot1-3 -->
			</div>
		</div>
	</div>
	<!--//center -->

	<!-- footer -->
	<c:import url="../top_main/top_pop_footer.jsp"></c:import>
	<!-- //footer -->
	
	<!-- 공동수행자 사원 찾기 다이어로그 -->
	<c:import url="../util_etc/module_mbrpop_1_rptdtl.jsp"></c:import>
</body>