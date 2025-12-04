<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/tooltipsy/tooltipsy.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>
<!-- 	<script src="./resources/wm_js/common.js"></script> -->
	<script>
		$(document).ready(function(){
			$("#rptState").select2();
			$("#speedType").select2();
			$("#srchTmId").select2();

			var tabCode = $("#code").val();
			var menuFlag = $("#flag").val();
			
			fnTabActive(tabCode);
			fnParamControl(tabCode,menuFlag,0);
			
			_initDatePicker();
			_initToolTip();
			_initTopMenuSlide();
			
			//폼에서 엔터 입력시 검색버튼 클릭
			$("#srchFrm input").keydown(function(e) {
				if( e.keyCode == 13 ){
					fnSearch();
				}					
			});
			
		});
		
		
		function spdCommentClose(index){
			$("#memoBtn"+index).attr("ViewYN","0");
			$("#spdCommentTr"+index).hide();			
		}
		
		function spdCommentView(index){
			if ( $("#memoBtn"+index).attr("ViewYN") == 0 ){
				$("#memoBtn"+index).attr("ViewYN","1");
				$("#spdCommentTr"+index).show();
				$("#speedCommentTxtArea"+index).focus();
			}else{
				spdCommentClose(index);
			}
		}
		
		function spdCommentUpdate(suimRptNo,index){
	        var param = {};
	        param.suimRptNo		= suimRptNo;
	        param.speedComment 	= $("#speedCommentTxtArea"+index).val();

	        var url = "./udtSpeedComment";
	        
	        $.ajax({
	            type: "POST",
	            url: url,
	            data: param,
	            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	            timeout: 20000,
	            dataType: "json", 
	            success: function(data){
	                if(data.result == "0000"){
	                    alert("메모가 저장 되었습니다..");
	                }else{
	                    alert("메모 저장을 실패 하였습니다..");
	                }
	            },
	            error: function(e){
	                alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
	            }
	            /*
				error : function( jqXHR, textStatus, errorThrown ) {
					
					alert( jqXHR.status );
					alert( jqXHR.statusText );
					alert( jqXHR.responseText );
					alert( jqXHR.readyState );

					alert( textStatus );
					alert( errorThrown );
				},
	            beforeSend: function(){
	                $('#div_prgss_edit').spin();
	                $("#loading").show();
	            }
				*/
	        });
		}
		
		/* 알림 리스트 열기 & 닫기 */
		function fnViewAlarm(suimRptNo){
			//화면이 닫혀있을때만 AJAX 작동
			if ( $("#spdAlarmTable"+suimRptNo).attr("ViewYN") == 0 ){
		        var param = {};
		        param.suimRptNo		= suimRptNo;
		        var url = "./getRptAlarmList";
		        $.ajax({
		            type: "POST",
		            url: url,
		            data: param,
		            dataType: "html",
		            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		            timeout: 20000,
		            async: true,
		            success: function(data){
		            	$("#rptAlarmListTbody"+suimRptNo).html("");
		            	$("#rptAlarmListTbody"+suimRptNo).html(data);
		            	_initDatePicker();
		            },
		            error: function(e){
		                alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		            }
		        });		 	
		        $("#spdAlarmTable"+suimRptNo).attr("ViewYN","1");
				$("#spdAlarmTable"+suimRptNo).show();	
				
			}else{
				
		        $("#spdAlarmTable"+suimRptNo).attr("ViewYN","0");
				$("#spdAlarmTable"+suimRptNo).hide();	
			}
		}
		/* 알림 저장 */
		function fnInsRptAlarm(suimRptNo){
	        var param = {};
	        param.suimRptNo		= suimRptNo;
	        param.alarmDate		= $("#insAlarmDate"+suimRptNo).val();
	        param.alarmComment	= $("#insAlarmComment"+suimRptNo).val();
	        if ( param.alarmDate == '' || param.alarmComment == ''){
	        	alert("알림일과 알림내용은 반드시 입력 되어야 합니다.");
	        	return;
	        }
	        var url = "./insRptAlarm";
	        $.ajax({
	            type: "POST",
	            url: url,
	            data: param,
	            dataType: "json",
	            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	            timeout: 20000,
	            success: function(data){
	                if(data.result == "0000"){
	                    alert("알림 저장이 완료되었습니다.");
		            	$("#spdAlarmTable"+suimRptNo).attr("ViewYN","0");
	            		fnViewAlarm(suimRptNo);
	                }else{
	                    alert("알림 저장에 실패 하였습니다.\n관리자에게 문의하세요.");
	                }
	            },
	            error: function(e){
	                alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
	            }
	        });		
		}
		
		/* 알림내용 수정 */
		function fnUdtRptAlarm(serialNo){
	        var param = {};
	        param.serialNo		= serialNo;
	        param.alarmComment	= $("#alarmComment"+serialNo).val();
	        var url = "./udtRptAlarm";
	        $.ajax({
	            type: "POST",
	            url: url,
	            data: param,
	            dataType: "json",
	            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	            timeout: 20000,
	            success: function(data){
	                if(data.result == "0000"){
	                    alert("알림 수정이 완료되었습니다.");
	                }else{
	                    alert("알림 수정에 실패 하였습니다.\n관리자에게 문의하세요.");
	                }
	            },
	            error: function(e){
	                alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
	            }
	        });		
		}
		
		/* 알림 완료 */
		function fnUdtRptAlarmConfirm(serialNo,suimRptNo){
			var r = confirm("해당 알림을 완료 하시겠습니까?");
			if (!r){
				return;
			}
			
	        var param = {};
	        param.serialNo		= serialNo;
	        var url = "./udtRptAlarmConfirm";
	        $.ajax({
	            type: "POST",
	            url: url,
	            data: param,
	            dataType: "json",
	            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	            timeout: 20000,
	            success: function(data){
	                if(data.result == "0000"){
	                    alert("완료처리 되었습니다.");
		            	$("#spdAlarmTable"+suimRptNo).attr("ViewYN","0");
	            		fnViewAlarm(suimRptNo);
	                }else{
	                    alert("완료처리에 실패 하였습니다.\n관리자에게 문의하세요.");
	                }
	            },
	            error: function(e){
	                alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
	            }
	        });		
		}
		
		/* 페이지네이션 페이지 이동 */
	    function fnGoPage(pageIdx) {
	        var frm = document.getElementById("srchFrm");
	        frm.method = "POST";
	        frm.action = "./speedMngList";
	        
	        $("#rptState").val("${srchParam.rptState}");
	        $("#speedType").val("${srchParam.speedType}");
	        $("#chkOneStop").val("${srchParam.chkOneStop}");
	        $("#suimStartDate").val("${srchParam.suimStartDate}");
	        $("#suimEndDate").val("${srchParam.suimEndDate}");
	        $("#alarmStartDate").val("${srchParam.alarmStartDate}");
	        $("#alarmEndDate").val("${srchParam.alarmEndDate}");
	        $("#srchAcceptNo").val("${srchParam.srchAcceptNo}");
	        $("#srchAccidentNo").val("${srchParam.srchAccidentNo}");
	        $("#srchPolicyNo").val("${srchParam.srchPolicyNo}");
	        $("#srchUserNm").val("${srchParam.srchUserNm}");
	        $("#srchPolicyNm").val("${srchParam.srchPolicyNm}");
	        $("#srchAlarm").val("${srchParam.srchAlarm}");
	        $("#srchMemo").val("${srchParam.srchMemo}");
	        $("#srchTmId").val("${srchParam.srchTmId}");
	        
	        $("#pageIdx").val(pageIdx);
	        frm.submit();
	    }
		
		/* 엑셀 다운로드 */
	    function fnExcelDown() {
	        var frm = document.getElementById("srchFrm");
	        frm.action = "./speedMngListExcelDown";
	        frm.submit();
	    }
	    
		/* 검색 */
	    function fnSearch() {
	        var frm = document.getElementById("srchFrm");
	        frm.action = "./speedMngList";
	        frm.submit();
	    }
	    
		/* 탭이동 */
		function fnGoTab(tabCode){
			var menuFlag = $("#flag").val();
	        var param = {};
	        param.code			= tabCode;
	        param.flag			= menuFlag;
	        
	        var url = "./getSpeedMngListTab";
	        $.ajax({
	            type: "POST",
	            url: url,
	            data: param,
	            dataType: "html",
	            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	            timeout: 20000,
	            success: function(data){
	    			
	    			fnTabActive(tabCode);
	    			fnParamControl(tabCode,menuFlag,1);
	    			
					$("#code").val(tabCode);
					
	            	$("#listTable").html("");
	            	$("#listTable").html(data);
	            	
	            },
	            error: function(e){
	                alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
	            }
	        });		
	        
		}
		
		/* 탭 활성화 처리 */
		function fnTabActive(tabFlag){
	    	// Tab Menu JS
			var $tabCate = $('.guestPopTap ul li');
			$tabCate.removeClass('on');
			$tabCate.eq(tabFlag).addClass('on');
		}
		
		/* 탭 이동 및 메뉴권한 별 파라미터 세팅 */
		function fnParamControl(tabCode,menuFlag,gubun){
			if (gubun == 1){
				//탭 변경시에만 초기화, 검색 후에는 파라미터가 보존 되어야 함
				$(".srchInput").val("");
				$(".srchInput2").val("");
			}
			
			tab = parseInt(tabCode);
			switch(tab){
				case 1 :	//미결 초기화
					$("#rptState").val('0');
					$("#rptState").prop("disabled", true).select2();
					
					$("#speedType").val('999');
					$("#srchTmId").val('999');
					
					$("#chkOneStop").prop("checked", false);
					$("#chkOneStop").attr("disabled", false);
					break;
					
				case 2 :  	//원스탑 파라미터
					$("#rptState").val('0');
					$("#rptState").prop("disabled", true).select2();
					
					$("#speedType").val('999');
					$("#srchTmId").val('999');
					
					$("#chkOneStop").prop("checked", true);
					$("#chkOneStop").attr("disabled", true);
					break;
					
				default :  	//파라미터 초기화
					$("#rptState").val('999');
					$("#speedType").val('999');
					$("#srchTmId").val('999');
				
					$("#rptState").prop("disabled", false).select2();
					$("#chkOneStop").prop("checked", false);
					$("#chkOneStop").attr("disabled", false);
					break;
			}			
			$("#rptState").trigger('change');
			$('#speedType').trigger('change');
			
			switch(menuFlag){
				case "user" :	//개인
					$("#srchTmId").val("${srchParam.team_id}");
					$("#srchTmId").prop("disabled", true).select2();
					$("#srchUserNm").val("${srchParam.user_nm}");
					$("#srchUserNm").attr("disabled",true);
					break;
					
				case "team" :  	//팀
					$("#srchTmId").val("${srchParam.team_id}");
					$("#srchTmId").prop("disabled", true).select2();
					break;
					
				case "admin" : 	//관리자
					break;
			}
			
			$('#srchTmId').trigger('change');
			
		}
		
		/* 수임대장 팝업 */
		function popSuimDtl(suim_rpt_no){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1010; //띄울 창의 넓이
			var sh=screen.availHeight;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('suimRptBscDtl?suim_rpt_no='+suim_rpt_no,suim_rpt_no,'width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=yes,scrollbars=yes');
		}
		
		/* 메모 TEXTAREA 크기 자동 조절 */
	    function fnAutoSize(s,obj) {
	        var m = 100;
	        if ( s >= m ) {
	            obj.style.pixelHeight = s +6;
	        } else {
	            obj.style.pixelHeight = m;
	        }
	    }
		
		/* DatePicker 적용 */
		function _initDatePicker(){
			$(".calendar").datepicker({ 
		    	   showOn: 'button',
		    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		    	   buttonImageOnly: true,
		    	   buttonText: "달력", 
		    	   changeMonth: true,
		    	   changeYear: true,
		    	   showButtonPanel: false
		    });
			
			$(".calendar").keypress(function(){
		 		if (event.keyCode == 8){ 
		 			return false;
		 		}
				if($(this).val().length == 4 || $(this).val().length == 7){
					$(this).val($(this).val()+"-")
				}
			});
		}
		
		/* tooltip 적용 */
		function _initToolTip(){
			$('.tooltip').tooltipsy({
			    offset: [0, 0],
			    show: function (e, $el) {
			        $el.css({
			            'left': parseInt($el[0].style.left.replace(/[a-z]/g, '')) - 50 + 'px',
			            'opacity': '0.0',
			            'display': 'block'
			        }).animate({
			            'left': parseInt($el[0].style.left.replace(/[a-z]/g, '')) + 50 + 'px',
			            'opacity': '1.0'
			        }, 300);
			    },
			    hide: function (e, $el) {
			        $el.slideUp(100);
			    },
			    css: {
			        'padding': '0px',
			        'max-width': '200px',
			        'color': '#303030',
			        'background-color': '#f5f5b5',
			        'border': '1px solid #deca7e',
			        '-moz-box-shadow': '0 0 10px rgba(0, 0, 0, .5)',
			        '-webkit-box-shadow': '0 0 10px rgba(0, 0, 0, .5)',
			        'box-shadow': '0 0 10px rgba(0, 0, 0, .5)',
			        'text-shadow': 'none'
			    }
			});
		}
		
		/* 상단 메뉴 슬라이스 적용 */
		/* 탭 내용 AJAX 처리를 위하여 wm_js/common.js 주석처리 */
		function _initTopMenuSlide(){
			$(".depth1").hover(function(){
				$(this).children("ul").slideDown(200);
				$(".depth1").not(this).children("ul").hide();
			},function(){
				$(this).children("ul").hide();
			});
		}
		
	</script>
	
	<style>
		.tooltip{cursor:pointer;}
		
      	.speedCommentTxtArea {
	      	OVERFLOW-Y:auto; OVERFLOW-X:hidden; padding:4px; word-break:break-all; line-height:120%; height:100px;
  			border: 2px solid #b3b3b3;
    		border-radius: 4px;
   		    font-size: 10pt;
    		font-family: 굴림,굴림체;
   		    line-height: 150%;
   		    color:black;
      	}
      	
      	.srchInput{
      		width:146px;
      	} 
      	.srchInput2 {width:73px;}
    	.center_cnt_1300_bot {height:100% !important;overflow:auto !important; margin-bottom: 5px;}
    	.guest .guestcnt4 {height:100% !important;margin-top:10px !important;padding:0 0 10px 0 !important;overflow:auto !important; }
	</style>
</head>

<body>

<!-- wrapper -->
<div id="wrapper">
	<!-- skipnavi --><!-- header -->
	<c:import url="../top_main/top_main_menu.jsp"></c:import>
	<!-- //skipnavi --><!-- //header -->

	<!-- contents -->
	<div id="container">
	
		<div class="contetns">
			<!-- centercnt_top -->
			<div class="center_cnt_1300">

				<!-- centercnt_bot -->
				<div class="center_cnt_1300_bot">
					<div class="guest">
						<div class="guestPopTap" >
							<ul>
								<li class="on"><a href="#" onclick="fnGoTab(0)">전체</a></li>
								<li><a href="#" onclick="fnGoTab(1)">미결</a></li>
								<li><a href="#" onclick="fnGoTab(2)">원스탑</a></li>
								<li><a href="#" onclick="fnGoTab(3)">오늘 할 일</a></li>
							</ul>
						</div>
						
						<div id="div_contents" class="guestcnt4" style="display:block;">
							<c:import url="../top_rpt_alarm/speed_mng_search.jsp"></c:import>
							
							<div class= "tableStyle2" id="listTable">
								<c:import url="../top_rpt_alarm/speed_mng_list.jsp"></c:import>
							</div>
						</div><!-- //tableStyle2 -->
						
					</div><!-- //guest -->
				</div>
			</div>
			<!-- //center_cnt_1300 -->
		</div>
		<!-- //content -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrapper -->

</body>
</html>
