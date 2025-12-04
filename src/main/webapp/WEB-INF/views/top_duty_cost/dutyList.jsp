<%--
  Created by IntelliJ IDEA.
  User: hongkihun
  Date: 2017. 08. 010.
  Time:  오전 09:53
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css">


	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/ne_js/ne_number.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/><!-- calendar -->
	<script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
	<script src="./resources/ne_js/calendar.js"></script><!-- calendar -->
<!-- 	<script src="./resources/wm_js/common.js"></script> -->
<style type="text/css">
.ClassButton {
	font-weight:bold;
	text-decoration:none;
	font-family:Arial;
	box-shadow:inset #d1d1d1 0px 5px 4px -1px,#cccccc 0px 2px 4px;
	o-box-shadow:inset #d1d1d1 0px 5px 4px -1px,#cccccc 0px 2px 4px;
	-moz-box-shadow:inset #d1d1d1 0px 5px 4px -1px,#cccccc 0px 2px 4px;
	-webkit-box-shadow:inset #d1d1d1 0px 5px 4px -1px,#cccccc 0px 2px 4px;
	background:#ffffff;
	background:-o-linear-gradient(90deg, #ffffff, #adadad);
	background:-moz-linear-gradient( center top, #ffffff 5%, #adadad 100% );
	background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #ffffff), color-stop(1, #adadad) );
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff', endColorstr='#adadad');
	background:-webkit-linear-gradient(#ffffff, #adadad);
	background:-ms-linear-gradient(#ffffff, #adadad);
	background:linear-gradient(#ffffff, #adadad);
	text-indent:0px;
	line-height:20px;
	-moz-border-radius:3px;
	-webkit-border-radius:3px;
	border-radius:3px;
	text-align:center;
	vertical-align:middle;
	display:inline-block;
	font-size:11px;
	color:#303030;
	width:56px;
	height:18px;
	padding:0px;
	border-color:#b8b8b8;
	border-width:1px;
	border-style:solid;
}

.ClassButton:active {
	box-shadow:inset #d1d1d1 0px 5px 4px -1px,#cccccc 0px 0 4px;
	o-box-shadow:inset #d1d1d1 0px 5px 4px -1px,#cccccc 0px 0 4px;
	-moz-box-shadow:inset #d1d1d1 0px 5px 4px -1px,#cccccc 0px 0 4px;
	-webkit-box-shadow:inset #d1d1d1 0px 5px 4px -1px,#cccccc 0px 0 4px;
	position:relative;
	top:2px
}

.ClassButton:hover {
	background:#adadad;
	background:-o-linear-gradient(90deg, #adadad, #ffffff);
	background:-moz-linear-gradient( center top, #adadad 5%, #ffffff 100% );
	background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #adadad), color-stop(1, #ffffff) );
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#adadad', endColorstr='#ffffff');
	background:-webkit-linear-gradient(#adadad, #ffffff);
	background:-ms-linear-gradient(#adadad, #ffffff);
	background:linear-gradient(#adadad, #ffffff);
}
</style>	
	<script type="text/javascript">
	$(document).ready(function(){
		
		/* gnb */
		$(".depth1").hover(function(){
			$(this).children("ul").slideDown(200);
			$(".depth1").not(this).children("ul").hide();
		},function(){
			$(this).children("ul").hide();
		});
		
	    
		$("#yearprev").click(function(){
	        var imsiyeartxt = $("#yeartxt").text();
	        imsiyeartxt--;
	        $("#yearMonth").val(imsiyeartxt + "12");  //201612
	        $("#excelYN").val("N");
        	dutyList.submit();
	    });
	    
	    $("#yearnext").click(function(){
	        var imsiyeartxt = $("#yeartxt").text();
	        imsiyeartxt++;
	        $("#yearMonth").val(imsiyeartxt + "01");  //201801
	        $("#excelYN").val("N");
        	dutyList.submit();
	    });


	    //월별 선택 버튼 클릭시 해당월에 해당하는 날짜 text 입력  imsimonth = 10 imsiMonthStart = 10
	    $(".monthbtn").click(function(){
	    	var imsimonth = $(this).attr("id");
	    	if(imsimonth.length < 2){
	    		imsimonth = "0" + imsimonth;
	    	}
	    		    	
        	$("#yearMonth").val($("#yeartxt").text() + imsimonth);  //2017-10-01
        	$("#excelYN").val("N");
        	dutyList.submit();
	    });//monthbtn.click

	});//$(document).ready
	
	</script>
<style type="text/css">
	.dutylist, th, td {
		 border: 1px solid black;
    	 border-collapse: collapse;
 	  	 padding: 5px;
   		 text-align: center;
   		 margin-top: 2%;
 
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
						<div class="search_bar" style="height:25px;">
							
							<div style="float: left;">
								<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0">
								&nbsp;<b>당직자 현황</b>&nbsp;(<i style="color:blue">파랑:결재대기</i>&nbsp;&nbsp;<i style="color:green">녹색:입금대기</i>&nbsp;&nbsp;<i style="color:red">빨강:입금완료</i>&nbsp;)
							</div>												
							<div style="text-align: right;">
								<a id="btn_excel" href="#noloc">									
									<img src="./resources/ls_img/btn_excel.gif">
								</a>&nbsp;		
								<a id="yearprev" href="#noloc">
									<img src="./resources/ne_img/icon_prev.gif" width="17" height="13" border="0">
								</a>
								<span id="yeartxt">${srchArg.yearMonth.substring(0,4)}</span>
								<a id="yearnext" href="#noloc">
									<img src="./resources/ne_img/icon_next.gif" width="17" height="13" border="0">
								</a>
								<c:forEach var="i" begin="1" end="12" step="1" varStatus="">
									<input id="${i}" class="monthbtn" type="button" value="${i}월" />
								</c:forEach>
							</div>
						    <form id="dutyList" name="dutyList" method="get" action="/dutyList">
						    	<input type="hidden" id="yearMonth" name="yearMonth" value="${srchArg.yearMonth}">
						    	<input type="hidden" id="excelYN" name="excelYN"/>                           
                            </form>								
							
						</div>
					</div>
				</div>
				
				<div class="center_cnt_1300_bot" >
					<div class="guest">

						<div class="guestTap">
							<ul>
								<!-- <li class="on" style="width: 90%;"><a href="#">당직 현황</a></li> -->
								<li class="on"><a href="#noloc">당직자 현황</a></li>
								<li><a href="#noloc" onclick="location.href='./dutyCostList'">당직비 신청 리스트</a></li>
								<c:if test="${mbrAuthVo_Session.mbr_pms_22 == 1}">
									<li><a href="#noloc" onclick="location.href='./dutyAppList'">당직비 신청 결재</a></li>
								</c:if>
								<c:if test="${mbrAuthVo_Session.mbr_pms_18 == 1}">
									<li><a href="#noloc" onclick="location.href='./dutyDepList?type=wait'">당직비 지급</a></li>	
									<li><a href="#noloc" onclick="location.href='./dutyDepList?type=complete'">당직비 입금완료</a></li>								
 								</c:if>
 								<c:if test="${mbrAuthVo_Session.mbr_pms_23 == 1}">
	 								<li style="width: 6%; float: right;">
										<button id="btn_write" class='ClassButton' style="line-height: 100%;">당직등록</button>									 
									</li>
								</c:if> 
<!-- 								<li style="width: 10%; text-align: right;">
									<button style="line-height: 100%;" onclick = "location.href='./dutyCostList'" >당직리스</button>
								</li> -->
							</ul>							
						</div>
						
						<div id="div_duty_write" style="display: none; ">
							<div class="tableStyle2">
								<form id="newfrm" name="newfrm" method="POST" action="dutyInsert">
									<table>
										<colgroup>
										<col style="width: 20%">
										<col style="width: 20%">
										<col style="width: 5%">
										<col style="width: 15%">
										<col style="width: 15%">
										<col style="width: 10%">
										<col style="width: 15%">
										</colgroup>
										<tr>
											<th>팀명</th>
											<th>이름</th>
											<th>검색</th>
											<th>당직일</th>
											<th>구분</th>
											<th>보험사</th>
											<th>비고</th>
										</tr>
																			
										<tr>												
											<td>
												<input type="hidden" id="teamId" name="teamId" value=""/>
												<input type="text" id="teamName"  value="" readonly="readonly"/>
											</td>					
											<td>
												<input type="hidden" id="userNo" name="userNo" value=""/>
												<input type="text" id="userName"  value="" readonly="readonly"/>
											</td>
											<td>
												<img src='./resources/ls_img/btn_edit_s.gif' class="popOpenBtn" /> 
											</td>
											<td>
												<input type="text" class="classCalendar" size="15" id="dutyDe" name="dutyDe" value="" maxlength="10" readonly="readonly" />
											</td>	
											<td>
												<select id="dutyType" name="dutyType">
													<option value="1">전화당직(평일)</option>
													<option value="2">전화당직(휴일)</option>
													<option value="3">출동대기</option>
													<option value="4">출동</option>
													<option value="5">출동대기+ 출동</option>
												</select>
											</td>
											<td>
												<select id="ptnrId" name="ptnrId">
                                                    <option value="6">농협</option>
                                                    <option value="7">동부</option>
													<option value="18">삼성</option>
												</select>
											</td>
											<td>
												<p  align="center">
													<a id="btn_save" href="#noloc"><img src="./resources/ls_img/btn_ok.gif" alt="저장" border="0"/></a>
													<a id="btn_cancel" href="#noloc"><img src="./resources/ls_img/btn_cancel.gif" alt="취소" border="0"/></a>										
												</p>
											</td>					
										</tr>
										
									</table>
								</form>
							</div>							
						</div>
						<div id="div_duty_edit" style="display: none; margin-top: 10px;">
							<div class="tableStyle2">
								<form id="editFrm" name="editFrm" method="POST" action="dutyUpdate">
									<input type="hidden" id="e_dutyId" name="dutyId"/>
									<input type="hidden" id="e_dutyStatus"/>
									<table>
										<colgroup>
										<col style="width: 20%">
										<col style="width: 20%">
										<col style="width: 5%">
										<col style="width: 15%">
										<col style="width: 15%">
										<col style="width: 10%">
										<col style="width: 15%">
										</colgroup>
										<tr>
											<th>팀명</th>
											<th>이름</th>
											<th>검색</th>
											<th>당직일</th>
											<th>구분</th>
											<th>보험사</th>
											<th>비고</th>
										</tr>
																			
										<tr>												
											<td>
												<input type="hidden" id="e_teamId" name="teamId" value=""/>
												<input type="text" id="e_teamName"  value="" readonly="readonly"/>
											</td> 					
											<td>
												<input type="hidden" id="e_userNo" name="userNo" value=""/>
												<input type="text" id="e_userName"  value="" readonly="readonly"/>
											</td>
											<td>
												<img src='./resources/ls_img/btn_edit_s.gif' class="popOpenBtn" /> 
											</td>
											<td>
												<input type="text" size="15" id="e_dutyDe" name="dutyDe" value="" maxlength="10" readonly="readonly" />
											</td>	
											<td>
												<select id="e_dutyType" name="dutyType">
													<option value="1">전화당직(평일)</option>
													<option value="2">전화당직(휴일)</option>
													<option value="3">출동대기</option>
													<option value="4">출동</option>
													<option value="5">출동대기+ 출동</option>
												</select>
											</td>
											<td>
												<select id="e_ptnrId" name="ptnrId">
                                                    <option value="6">농협</option>
                                                    <option value="7">동부</option>
													<option value="18">삼성</option>
												</select>
											</td>
											<td>
												<p  align="center">
													<a id="btn_edit_save" href="#noloc">수정&nbsp;</a>
													<a id="btn_delete" href="#noloc">삭제&nbsp;</a>
													<a id="btn_cancel2" href="#noloc">취소</a>										
												</p>
											</td>					
										</tr>
										
									</table>
								</form>
							</div>							
						</div>						
						<div id="abc" class="guestcnt4" style="display:block;">
							<c:import url="./dutyList1.jsp"></c:import>
						</div> 
					</div><!-- //guest -->
				</div><!-- centercnt_bot2 -->
			</div><!-- //center_cnt -->
		</div><!-- //contents -->
	</div><!-- //container -->

	<!-- footer -->
	<c:import url="../top_statistics/statistics_footer.jsp"></c:import>
	<!-- //footer -->

</div><!-- //wrapper -->
<c:import url="../util_etc/module_mbrpop_1_duty.jsp"></c:import>
<script type="text/javascript">
	var editMode = 0;
	$(document).ready(function () {
	    _initButton();
	});
	
    //버튼 이벤트
    function _initButton() {
        $("#btn_save").on("click", function () {
            fnSave();
        });

        $("#btn_cancel").on("click", function () {
            fnCancel();
        });
        
        $("#btn_cancel2").on("click", function () {
            fnCancel();
        });  
            
        
		$("#btn_write").on("click", function (event) {			
	    	event.stopPropagation();		
			fnWrite();
		});
		
        $("#btn_edit_save").on("click", function () {
            fnEditSave();
        });
        
        $("#btn_delete").on("click", function () {
            fnDelete();
        });
        
        
		$("#btn_excel").on("click", function(){
			fnExcel();
		});	         
		
    }
    
    function fnSave() {
        if ($("#userNo").val() == ''){
        	alert("당직자를 선택해 주세요.");
        	$(".popOpenBtn").trigger("click"); //trigger = 이벤트를 발생시켜라
        	
        	return;
        	
        }
    	
    	if ($("#dutyDe").val() == '') {
            alert("일자를 입력해 주세요.");
            $("#dutyDe").focus();
            
            return;	
  	    }

  	    if(!fnDutyTypeChk('A')){
            alert("전화당직은 농협만 선택할수 있습니다.");
            $("#dutyType").focus();
            return;
        }


        
        $("#newfrm").submit();
        
	}
    
    function fnCancel() {
		$("#div_duty_write").hide();
		$("#div_duty_edit").hide();
		$("#btn_write").show();		
	}
    
    
    function fnWrite() {
		editMode = 0;
		$("#div_duty_write").show();
		$("#div_duty_edit").hide();
 		$("#btn_write").hide();

	}

	
    function fnEdit(){
    	editMode = 1;
		$("#div_duty_edit").show();
		$("#div_duty_write").hide();
 		$("#btn_write").show(); 
    }
    
    function fnEditDataCall(dutyId){
    	
        var param = {};
        param.dutyId           = dutyId;

        var url = "./duty_cost_info";

        $.ajax({
            type: "POST",
            url: url,
            data: param,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            dataType: "json",
            timeout: 20000,
            success: function(data){
                if(data.RSLTCODE == '0'){
                	fnEditDataSet(data.dutyVo);
                }else{
                	alert("데이터가 존재하지 않습니다.");
                	window.location.reload();
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
    
    function fnEditDataSet(dataVo){
    	$("#e_dutyId").val(dataVo.dutyId);
    	$("#e_teamId").val(dataVo.teamId);
    	$("#e_userNo").val(dataVo.userNo);
    	$("#e_userName").val(dataVo.userName);
    	$("#e_teamName").val(dataVo.teamName);
    	$("#e_dutyDe").val(dataVo.dutyDe);
    	
    	$("#e_dutyStatus").val(dataVo.dutyStatus);
    	
    	$("#e_ptnrId").val(dataVo.ptnrId).prop("selected", true);
    	$("#e_dutyType").val(dataVo.dutyType).prop("selected", true);
    	
    }
    
    function fnEditSave(){
         if ($("#e_userNo").val() == ''){
        	alert("당직자를 선택해 주세요.");
        	$(".popOpenBtn").trigger("click"); //trigger = 이벤트를 발생시켜라
        	
        	return;
        	
        }
    	
    	if ($("#e_dutyDe").val() == '') {
            alert("일자를 입력해 주세요.");
            $("#e_dutyDe").focus();
            
            return;	
  	    }

        if(!fnDutyTypeChk('U')){
            alert("전화당직은 농협만 선택할수 있습니다.");
            $("#e_dutyType").focus();
            return;
        }


        
        $("#editFrm").submit();    	
    }
    
    function fnDelete() {
        if (confirm("삭제하시겠습니까?")){
            var editFrm = document.getElementById("editFrm");
            editFrm.action = "/dutyCostDelete";
            //frm.method = "post"
            editFrm.submit();
        }
    }
 
    
    function fnModalMbrPopCallBack(user_no, user_nm, team_id ,team_name){
    	
    	if(editMode == 0){
        	$("#userNo").val(user_no);
        	$("#userName").val(user_nm);
        	$("#teamId").val(team_id);
        	$("#teamName").val(team_name);    		
    	}else{
        	$("#e_userNo").val(user_no);
        	$("#e_userName").val(user_nm);
        	$("#e_teamId").val(team_id);
        	$("#e_teamName").val(team_name);     		
    	}
    		

    }

    function fnExcel(){
        var frm = document.getElementById("dutyList");
        frm.method = "post";
        frm.action = "./dutyList";
        $("#pageIdx").val(1);
        $("#excelYN").val("Y");
        frm.submit();    	
    }


    function fnDutyTypeChk(cmd){
        var duty_type = "";
        var duty_ptnrId = "";

        if(cmd == 'A'){
            duty_type = $("#dutyType option:selected").val();
            duty_ptnrId = $("#ptnrId option:selected").val();
        }else if(cmd == 'U'){
            duty_type = $("#e_dutyType option:selected").val();
            duty_ptnrId = $("#e_ptnrId option:selected").val();
        }

        if( (duty_ptnrId == '7' || duty_ptnrId == '18') && (duty_type == '1' || duty_type == '2')) {
            return false;
        }else{
            return true;
        }

	}
    
    
    
</script>	
<%
    //============================================================
    //  에러 메시지 처리
    //============================================================
    if(session.getAttribute("sERRORMSG") != null){
        out.println("<script type=\"text/javascript\">alert('"+session.getAttribute("sERRORMSG")+"');</script>");
        session.removeAttribute("sERRORMSG");
    }
%> 
</body>
</html>