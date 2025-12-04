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
	
		var outRpt = new Array();
	
		$(document).ready(function(){
			_initDatePicker();
			_initTopMenuSlide();
			
			var tabCode = $("#code").val();
			var menuFlag = $("#flag").val();
			
			fnTabActive(tabCode);
// 			fnGoTab(tabCode);
			fnParamControl(tabCode,menuFlag,0);
			
		});
		
		/* 탭이동 */
		function fnGoTab(tabCode){
			var menuFlag = $("#flag").val();
	        var param = {};
	        param.code			= tabCode;
	        param.flag			= menuFlag;
	        
	     	//탭 이동시, 배열 초기화
	        outRpt= []; 
	        $(".chkCntSpan").html("선택한 보고서 : 0 개");
	        
	        var url = "./getRptMbrchgListTab";
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
	            /*
				error : function( jqXHR, textStatus, errorThrown ) {
					
					alert( jqXHR.status );
					alert( jqXHR.statusText );
					alert( jqXHR.responseText );
					alert( jqXHR.readyState );

					alert ( textStatus );
					alert( errorThrown );
				}
	            */
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
			
			$("#srchTmId").val('999');
			
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
				case "center" : //관리자
					break;					
				case "admin" : 	//관리자
					break;
			}
			
			switch( parseInt(tabCode) ){
				case 0 :	//조회
					$("#srchComment").show();
					$("#tabTr0").show();
					$("#tabTr1").hide();
					$("#tabTr2").hide();
					$(".logTd").css("visibility","hidden");
					break;
				case 1 :  	//이첩
					$("#srchComment").hide();
					$("#tabTr0").hide();
					$("#tabTr1").show();
					$("#tabTr2").hide();
					$(".logTd").css("visibility","hidden");
					break;
				case 2 : 	//내첩
					$("#srchComment").hide();
					$("#tabTr0").hide();
					$("#tabTr1").hide();
					$("#tabTr2").show();
					$(".logTd").css("visibility","hidden");
					break;					
				case 3 : 	//변경내역
					$("#srchComment").hide();
					$("#tabTr0").hide();
					$("#tabTr1").hide();
					$("#tabTr2").hide();
					$(".logTd").css("visibility","visible");
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
		
		/* 페이지네이션 페이지 이동 */
	    function fnGoPage(pageIdx) {
	        var frm = document.getElementById("srchFrm");
	        frm.method = "POST";
// 	        frm.action = "./rptMbrchgList";
	        
// 	        $("#srchAcceptNo").val("${srchParam.srchAcceptNo}");
// 	        $("#srchAccidentNo").val("${srchParam.srchAccidentNo}");
// 	        $("#srchPolicyNm").val("${srchParam.srchPolicyNm}");
// 	        $("#suimStartDate").val("${srchParam.suimStartDate}");
// 	        $("#suimEndDate").val("${srchParam.suimEndDate}");
// 	        $("#srchTmId").val("${srchParam.srchTmId}");
// 	        $("#srchUserNm").val("${srchParam.srchUserNm}");
// 	        $("#chgStartDate").val("${srchParam.chgStartDate}");
// 	        $("#chgEndDate").val("${srchParam.chgEndDate}");
	        
	        $("#pageIdx").val(pageIdx);
	        frm.submit();
	    }
	</script>
	
	<style>
    	.center_cnt_1300_bot {height:100% !important;overflow:auto !important; margin-bottom: 5px;}
    	.guest .guestcnt4 {height:100% !important;margin-top:10px !important;padding:0 0 10px 0 !important;overflow:auto !important; }
    	.chgTd {letter-spacing: 0px !important;}
    	.srchInput2 {width:73px;}
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
								<li class="on"><a href="#" id="tab0" onclick="fnGoTab(0)">조회</a></li>
								<li><a href="#" id="tab1" onclick="fnGoTab(1)">이첩</a></li>
								<li><a href="#" id="tab2" onclick="fnGoTab(2)">내첩</a></li>
								<li><a href="#" id="tab3" onclick="fnGoTab(3)">변경내역</a></li>
							</ul>
						</div>
						
						<div id="div_contents" class="guestcnt4" style="display:block;">
							<span id="srchTable">
								<c:import url="../top_rpt_mbrchg/rpt_mbrchg_search.jsp"></c:import>
							</span>
							<div class= "tableStyle2" id="listTable">
								<c:choose>
									<c:when test="${srchParam.code eq '0' }">
										<c:import url="../top_rpt_mbrchg/rpt_mbrchg_list.jsp"></c:import>										
									</c:when>
									<c:when test="${srchParam.code eq '3' }">
										<c:import url="../top_rpt_mbrchg/ajax/rpt_mbrchg_log_list_ajax.jsp"></c:import>					
									</c:when>
									<c:otherwise>
										<c:import url="../top_rpt_mbrchg/ajax/rpt_mbrchg_list_ajax.jsp"></c:import>
									</c:otherwise>
								</c:choose>
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
<script>
	$(document).ready(function(){
		
	});
	

</script>
</body>
</html>
