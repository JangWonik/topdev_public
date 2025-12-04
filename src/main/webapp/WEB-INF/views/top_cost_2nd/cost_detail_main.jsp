<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE HTML>
<html lang="ko">

<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	
	<title>${title_Session}</title>
	
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css">
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/jquery/jquery.mask.min.js"></script>	
		
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/><!-- calendar -->
	<script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
	<script src="./resources/ne_js/calendar.js"></script><!-- calendar -->
	
	<%--spiner start--%>
    <script src="/resources/jquery/spin.js"></script>
    <script src="/resources/jquery/jquery.spin.js"></script>
    <%--spiner end --%>
	
	<script src="./resources/wm_js/common.js"></script>
	<script src="./resources/cmm/js/common.js"></script>	


	<style>
		.cost_detail_tbl tr td input{
			width: 90%;
		}
		
		.cost_detail_tbl tr td, span{
			letter-spacing: 0px;
		}
		
		#helpTable tr td{
			letter-spacing: 0px;
		}
	</style>	

</head>

<body>

<!-- wrapper -->
<div id="wrapper">

	<!-- header -->
	<c:import url="../top_main/top_main_menu.jsp"></c:import>
	<!-- //header -->

	<!-- contents -->
	<div id="container">
		<div class="contetns">
			<div class="center_cnt_1300">

				<div class="centercnt_top">
					<div class="nociteA log_top">
						<div class="search_bar">

							<div style="float: left;">
								<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0">
								&nbsp;<b>${userInfo.team_name} ${userInfo.user_name} 경비내역</b>
							</div>

							<div style="text-align: right;">
								<img onclick="fnYearPrev()" src="./resources/ne_img/icon_prev.gif" width="17" height="13" border="0">
								<a id="year_txt" href="#">${srchArg.endDe.substring(0,4)}</a>
								<img onclick="fnYearNext()" src="./resources/ne_img/icon_next.gif" width="17" height="13" border="0">
								<c:forEach var="i" begin="1" end="12" step="1" varStatus="">
									<input id="${i}" class="monthbtn" type="button" value="${i}월" />
								</c:forEach>
							</div>

							<form name="cost_detail_form" id="cost_detail_form" method="POST" action="./cost_detail">
							
								<input type="hidden" id="user_no" name="user_no" value="${userInfo.user_no}" />
								<input type="hidden" id="team_id" name="team_id" value="${userInfo.team_id}" />
								<input type="hidden" id="team_name" name="team_name" value="${userInfo.team_name}" />
								<input type="hidden" id="team_type" name="team_type" value="${userInfo.team_type}" />
								<input type="hidden" id="gubun" name="gubun" value="${srchArg.gubun}" />
								
								<input type="hidden" id="cost_kind" name="cost_kind" value="${srchArg.cost_kind}"/>
								<input type="hidden" id="cost_year_month" name="cost_year_month" value="${srchArg.yearMonth}"/>
								<input type="hidden" id="hid_cost_class_no" name="hid_cost_class_no" value="${srchArg.cost_class_no}"/>
								
								<input type="hidden" id="hid_bgnDe" name="hid_bgnDe" value="${srchArg.bgnDe}" />
								<input type="hidden" id="hid_endDe" name="hid_endDe" value="${srchArg.endDe}" />
 								
 								<input type="hidden" id="hid_stdBgnde" name="stdBgnde" value="${srchArg.stdBgnde}" />
 								<input type="hidden" id="hid_stdEndde" name="stdEndde" value="${srchArg.stdEndde}" />
 								
								<b>${srchArg.stdBgnde}</b>
								<b><font color="#0066CC">부터</font></b>&nbsp;&nbsp;
								<b>${srchArg.stdEndde}</b>
								<b><font color="#0066CC">까지</font></b>&nbsp;&nbsp;
										
								<select id="cost_class_no" name="cost_class_no" onchange="fnCostDetailContents(0)">
									<option value="${item.col_cd2}" costKind="0">- 전체 -</option>
									<c:forEach items="${costClassNoList}" var="item" varStatus="status">
										<option value="${item.col_cd2}" costKind="${item.col_cd1}">${item.col_val}</option>
									</c:forEach>
								</select>
								
							</form>

							<p style="display: inline; float: right;">
								<img src="./resources/ls_img/icon_print.gif" id="btn_cost_print" style = "cursor:pointer; float:right;" />
							</p>

							<br/>

						</div>
					</div>
				</div><!-- //centercnt_top -->

				<div class="center_cnt_1300_bot" >
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on" id="tab1" onclick="fnCostDetailContents(1);">
									<a href="#" >경비내역</a>
								</li>
								<li id="tab2" onclick="fnCostDetailContents(2);">
									<a href="#" >추가 경비내역</a>
								</li>
								<li id="tab3" onclick="fnCostDetailContents(3);">
									<a href="#">클레임 교통비 내역</a>
								</li>
							</ul>
							
							<div class="guestcnt4" id="costcnt1" style="display:block;">
							</div>
							
							<div class="guestcnt4" id="costcnt2" style="display:none;">
							</div>
							
							<div class="guestcnt4" id="costcnt3" style="display:none;">
							</div>
							
						</div>
					</div><!-- //guest -->
				</div><!-- centercnt_bot2 -->
			</div><!-- //center_cnt -->
		</div><!-- //contents -->
	</div><!-- //container -->
	
	<script>
		$(document).ready(function(){
			
			if('${mbrVo_Session.user_no}' == null || '${mbrVo_Session.user_no}'.trim() == ''){
				alert("로그아웃 상태입니다. 재로그인 하십시오.");
				window.location.assign("./logout");
			}
			
			fnCostDetailContents(1);
			
			$("#btn_cost_print").on("click", function(){
   	     		fnPopCostDetailPrint();
	     	}); 
		});
		
		/* 협조건 내역 상세보기 */
		function viewhelpbtn(serial_no){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1010; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('helpRptBscDtl?serialNo='+serial_no+'&viewFromDate='+$("#viewFromDate").val()+'&viewToDate='+$("#viewToDate").val(),'_blank','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}
		

		/* mask 처리 */
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
		
		function _initCalendar(cost_kind){
			var bgnDe = $("#hid_stdBgnde").val();
			var bgnDeArr = bgnDe.split('-');
			var endDe = $("#hid_stdEndde").val();
			
			if ( cost_kind == 2 ){
			 	$('.calendar').datepicker({ 
			    	   showOn: 'button',
			    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
			    	   buttonImageOnly: true,
			    	   buttonText: "달력", 
			    	   changeMonth: true,
			    	   changeYear: true,
			    	   maxDate: new Date(bgnDeArr[0],bgnDeArr[1]-1,bgnDeArr[2]-1),
			    	   showButtonPanel: false
			    });
			}else{
			 	$('.calendar').datepicker({ 
			    	   showOn: 'button',
			    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
			    	   buttonImageOnly: true,
			    	   buttonText: "달력", 
			    	   changeMonth: true,
			    	   changeYear: true,
			    	   minDate: new Date(bgnDe),
			    	   maxDate: new Date(endDe),		    	   
			    	   showButtonPanel: false
			    });				
			}
		}
		
		function fnCostDetailContents(cost_kind){
			var param = {};
        	param.user_no = $("#user_no").val();
        	param.team_type = $("#team_type").val();
        	param.bgnDe = $("#hid_bgnDe").val();
        	param.endDe = $("#hid_endDe").val();
        	param.gubun = $("#gubun").val();
        	param.cost_year_month = $("#cost_year_month").val();
        	param.cost_class_no = $("#cost_class_no").val();
        	
        	if (cost_kind != 0){
	        	param.cost_kind = cost_kind;
        	}else{
        		param.cost_kind = $("#cost_kind").val();
        		cost_kind = $("#cost_kind").val();
        	}
        	
	    	var url = "/cost_detail_contents";
	    	
       	    $.ajax({
       	        type: "POST",
       	        url: url,
       	        data: param,
       	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
       	        timeout: 20000,
       	        async: false,
       	        dataType: "HTML", 
       	        success: function(data){
					$("#costcnt1").html("");
					$("#costcnt2").html("");
					$("#costcnt3").html("");
					$("#costcnt"+cost_kind).html(data);
					
					$("#cost_kind").val(cost_kind);
					
					fnSelectCostClass(cost_kind);
					
       	        	_initButton();
       	    		_initCalendar(cost_kind);
       	    		_initMask();
       	        }			
       	    });
		}
		
		function fnSelectCostClass(cost_kind){
        	param = {};
        	param.cost_kind = cost_kind
        	
        	var cost_class_no = $("#cost_class_no").val();
        	
	    	var url = "/select_cost_class_list";
	    	
       	    $.ajax({
       	        type: "POST",
       	        url: url,
       	        data: param,
       	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
       	        timeout: 20000,
       	        async: false,
       	        dataType: "JSON", 
       	        success: function(data){
					$("#cost_class_no option").remove();
					$("#cost_class_no").prepend("<option value='0'>- 전체 -</option>");
					
					$.each(data, function(key, value){
						if (value.col_cd2 != cost_class_no){
							$("#cost_class_no").append("<option value='"+value.col_cd2+"'>"+value.col_val+"</option>");
						}else{
							$("#cost_class_no").append("<option value='"+value.col_cd2+"' selected='selected'>"+value.col_val+"</option>");
						}
					});
       	        }
       	    });  
		}
		
  	    //버튼 이벤트
   	    function _initButton() {

   	        $("#year_txt").on("click", function () {
   	            fnYear();
   	        });

   	        $("#btn_year_prev").on("click", function () {
   	            fnYearPrev();
   	        });
   	        $("#btn_year_next").on("click", function () {
   	            fnYearNext();
   	        });
   	        
   	     	$(".btn_cost_detail_del").on("click", function(){
   	     		var cost_no = $(this).data("cost_no");   	     		
   	     		fnCostItemDelete(cost_no);
   	     	});
 
   	     	$(".btn_cost_detail_mod").on("click", function(){
   	     		var idx = $(this).data("idx");   	     
   	     		var cost_no = $(this).data("cost_no");   	  
   	     		fnCostItemUpdate(idx,cost_no);
   	     	});
   	     	
   	     	$(".btn_tm_aprv").on("click", function(){
	     		var aprv_state = $(this).data("aprv_state");   	   
	     		var cost_kind = $(this).data("cost_kind");   	   
	     		
	     		fnCostItemTmAprv(aprv_state,cost_kind);
	     		
	     		//팀장결재시 합계금액이 update 되지 않는 문제 수정 (결재시 금액수정 스크립트를 호출함) by top3009
	     		var idx = $(this).data("idx");   	     
	     		var cost_no = $(this).data("cost_no");   	  
	     		fnCostItemUpdate(idx,cost_no);
	     		
	     	});   	     	
   	     	
   	        //월별 선택 버튼 클릭시 해당월에 해당하는 날짜 text 입력
   	        $(".monthbtn").click(function(){

   	            var imsimonth = $(this).attr("id");
   	            var imsiMonthStart = imsimonth -1;

   	            if(imsimonth.length < 2){
   	                imsimonth = "0" + imsimonth;
   	            }

   	            var imsiMonthStartStr = "0" + imsiMonthStart;

   	            if(imsiMonthStartStr.length > 2) {
   	                imsiMonthStartStr = imsiMonthStartStr.substring(1, imsiMonthStartStr.length);
   	            }

   	            $("#hid_stdBgnde").val($("#year_txt").text() + "-" + imsiMonthStartStr + "-" + "16");
   	            $("#hid_stdEndde").val($("#year_txt").text() + "-" + imsimonth + "-" + "15");

   	            if(imsimonth == 1){
   	                $("#hid_stdBgnde").val(($("#year_txt").text()-1) + "-" + "12" + "-" + "16");
   	            }

   	            fnSearch();
   	        });


   	    }

        function fnYearPrev(){
            var imsiyeartxt = $("#year_txt").text();
            $("#year_txt").text(--imsiyeartxt);
            $("#hid_stdBgnde").val(--imsiyeartxt+"-12-16");
            $("#hid_stdEndde").val($("#year_txt").text()+"-12-15");
        }

        function fnYearNext(){
            var imsiyeartxt = $("#year_txt").text();
            $("#year_txt").text(++imsiyeartxt);
            $("#hid_stdBgnde").val(--imsiyeartxt + "-12-16");
            $("#hid_stdEndde").val($("#year_txt").text()+"-12-15");
        }
        
        function fnSearch(){
            $("#loading").show();

            $("#srchExcelYN").val("N");
            var frm = document.getElementById("cost_detail_form");
            frm.submit();
        }
        
		function fnPopCostDetailPrint(){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1010; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			//window.open('cost_detail_print?user_no='+$("#user_no").val()+'&cost_year_month='+$("#cost_year_month").val()+'&bgnDe='+$("#hid_stdBgnde").val()+'&endDe='+$("#hid_stdEndde").val()+ '&excelYN=N','_blank','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			window.open('cost_detail_print?user_no='+$("#user_no").val()+'&cost_year_month='+$("#cost_year_month").val()+'&bgnDe='+$("#hid_stdBgnde").val()+'&endDe='+$("#hid_endDe").val()+ '&excelYN=N','_blank','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}
	</script>



	<script>
		function fnCostItemUpdate(idx,cost_no){
			
			var cost_kind = $("#cost_kind").val();
			
	    	if (fnCostItemValid(idx,cost_kind)){
	    		return;
	    	}
	    	
	    	var param = fnCostItemParamSetting(idx,cost_kind);
	    	param.cost_kind 		= cost_kind;
	    	param.cost_no 			= cost_no;
	    	param.action 			= "U";
	    	
	    	actionCostItem(param);
		}
	
		function fnCostItemDelete(cost_no){
			var r = confirm("해당 경비내역을 삭제 하시겠습니까?");
			if (!r) return;			
			
			var param = {};
	    	param.user_no			= $("#user_no").val();
	    	param.cost_kind			= $("#cost_kind").val();
	    	param.cost_occur_date 	= $("#hid_stdEndde").val();
	    	param.cost_class_no 	= $("#cost_class_no").val();
	    	param.cost_year_month	= $("#cost_year_month").val();
	    	
			param.cost_no 	= cost_no;
			param.action 	= "D";
			
			actionCostItem(param);
		}
		
	    function fnCostItemInsert(cost_kind){
	    	if (fnCostItemValid('insert',cost_kind)){
	    		return;
	    	}
	    	
	    	var param = fnCostItemParamSetting('insert',cost_kind);
	    	param.cost_kind 		= cost_kind;
	    	param.action 			= "C";
	    	
	    	actionCostItem(param);
	    } 
	    
	    function actionCostItem( param ){
	    	var actionFlag = true;
	    	
	    	var url = "valid_cost_item";
       	    $.ajax({
       	        type: "POST",
       	        url: url,
       	        data: param,
       	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
       	        timeout: 20000,
       	        async: false,
       	        dataType: "JSON", 
       	        success: function(data){
					if (data.result_code == "0001"){
						alert(data.result_msg);
						actionFlag = false;
					}
       	        }
       	    });				
       	    
       	    
       	    
       	  	if (actionFlag){
		    	var url = "/action_cost_item";
		    	
	       	    $.ajax({
	       	        type: "POST",
	       	        url: url,
	       	        data: param,
	       	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	       	        timeout: 20000,
	       	        async: false,
	       	        dataType: "HTML", 
	       	        success: function(data){
	       	        	var cost_kind = "";
	       	        	if (param.cost_kind == 1){
	       	        		cost_kind = "경비내역";
	       	        	}else if (param.cost_kind == 2){
	       	        		cost_kind = "추가경비내역";
	       	        	}else{
	       	        		cost_kind = "클레임 교통비 내역";
	       	        	}
	       	        	
	       	        	if (param.action == "C"){
							alert(cost_kind+" 입력에 성공하였습니다.");		     
							$("#cost_class_no").val(0);
	       	        	}else if (param.action == "D"){
	       	        		alert(cost_kind+" 삭제에 성공하였습니다.");
	       	        	}else if (param.action == "U"){
	       	        		alert(cost_kind+" 수정에 성공하였습니다.");
	       	        	}
	       	        	
	   	        		$("#costcnt"+param.cost_kind).html("");
	       	        	$("#costcnt"+param.cost_kind).html(data);
	       	        	fnSelectCostClass(param.cost_kind);
	       	        		
	       	        	_initButton();
	       	    		_initCalendar(param.cost_kind);
	       	    		_initMask();
	       	        }
	       	    });  
       	  	}
	    }
	    
		function fnCostItemValid(idx,cost_kind){
			
			var bgnDe = $("#hid_stdBgnde").val().toDate();
			var endDe = $("#hid_stdEndde").val().toDate();
	    	var insertDe = $("#cost_occur_date_"+idx).val().toDate();
	    	
	    	if( !dates.inRange(insertDe,bgnDe,endDe) && cost_kind != 2){
				alert("입력 가능한 날짜 범위를 벗어났습니다.\n경비발생일은 해당 기간에서만 가능합니다."); 
				$("#cost_occur_date_"+idx).focus();
				return true;				    		
	    	}
	    	
			if($("#cost_occur_date_"+idx).val().trim() == ''){
				alert("날짜를 선택하세요."); 
				$("#cost_occur_date_"+idx).focus();
				return true;
			}
				
	    	if($("#cost_class_no_"+idx).val().trim() == ''){
				alert("계정명을 선택하세요.");
				$("#cost_class_no_"+idx).focus();
				return true;
			}
	    	
			if($("#cost_pay_type_"+idx).val().trim() == ''){
				alert("구분을 선택하세요.");
				$("#cost_pay_type_"+idx).focus();
				return true;
			}
			
			if($("#cost_bill_ea_"+idx).val().trim() == ''){
				alert("영수증 수를 입력하세요.");
				$("#cost_bill_ea_"+idx).focus();
				return true;
			}
			
			if($("#cost_pay_amt_"+idx).val().trim() == ''){ 
				alert("금액을 입력하세요.");
				$("#cost_pay_amt_"+idx).focus();
				return true;
			}
			
		}
		
		function fnCostItemParamSetting(idx,cost_kind){
	    	var param = {};
	    	
	    	if (cost_kind == 3){
				param.cost_suim_accept_no 	= $("#cost_suim_accept_no_"+idx).val();
				param.cost_distance 		= $("#cost_distance_"+idx).val();			
	    	}else{
				param.cost_suim_accept_no 	= "";
				param.cost_distance 		= "";	
	    	}
	    	
	    	if (idx != 'aprv'){
		    	param.cost_occur_date 	= $("#cost_occur_date_"+idx).val();
		    	param.cost_class_no 	= $("#cost_class_no_"+idx).val();
		    	param.cost_pay_type 	= $("#cost_pay_type_"+idx).val();
		    	param.cost_bill_ea 		= $("#cost_bill_ea_"+idx).val();
		    	param.cost_pay_amt 		= $("#cost_pay_amt_"+idx).val().num();
		    	param.cost_pay_place 	= $("#cost_pay_place_"+idx).val();
		    	param.cost_involved_com = $("#cost_involved_com_"+idx).val();
		    	param.cost_involved_man = $("#cost_involved_man_"+idx).val();
		    	param.cost_memo 		= $("#cost_memo_"+idx).val();
	    	}
	    	
        	param.bgnDe				= $("#hid_bgnDe").val();
        	param.endDe 			= $("#hid_endDe").val();
	    	param.cost_year_month	= $("#cost_year_month").val();
	    	param.team_id 			= $("#team_id").val();
	    	param.user_no 			= $("#user_no").val();
	    	
	    	return param;
		}
	    
		
		function fnCostItemTmAprv(aprv_state,cost_kind){
			if (aprv_state == 1){
				var r = confirm("경비내역을 결재 하시겠습니까?");
			}else{
				var r = confirm("경비내역을 결재 취소 하시겠습니까?");
			}
			if (!r){
				return;
			}
			
		 	var param = fnCostItemParamSetting('aprv',cost_kind);
			param.aprv_state 	= aprv_state;
			param.cost_kind		= cost_kind;
			
	    	var url = "/aprv_cost_item";
		
	    	
       	    $.ajax({
       	        type: "POST",
       	        url: url,
       	        data: param,
       	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
       	        timeout: 20000,
       	        async: false,
       	        dataType: "HTML", 
       	        success: function(data){
       	        	var cost_kind = "";
       	        	if (param.cost_kind == 1){
       	        		cost_kind = "경비내역";
       	        	}else if (param.cost_kind == 2){
       	        		cost_kind = "추가경비내역";
       	        	}else{
       	        		cost_kind = "클레임 교통비 내역";
       	        	}
       	        	
       	        	if (aprv_state == 1){
						alert(cost_kind+" 결재에 성공하였습니다.");
       	        	}else{
       	        		alert(cost_kind+" 결재취소에 성공하였습니다.");
       	        	}
       	        
       	        	
   	        		$("#costcnt"+param.cost_kind).html("");
       	        	$("#costcnt"+param.cost_kind).html(data);
       	        	fnSelectCostClass(param.cost_kind);
       	        		
       	        	_initButton();
       	    		_initCalendar(param.cost_kind);
       	    		_initMask();
       	        }
       	    });  
		}
		
	    
	</script>


	<!-- footer -->
	<c:import url="../top_main/top_main_footer.jsp"></c:import>
	<!-- //footer -->

</div>
<!-- //wrapper -->

</body>

</html>
