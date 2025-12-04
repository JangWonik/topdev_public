<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>반려 사유</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	
	<script src="./resources/ne_js/calendar.js"></script>
	<script>
		$(document).ready(function(){
			if('${mbrAuthVo_Session.user_no}' == null){
				window.opener.location.assign("./logout");
				window.self.close();
			}
		});//ready
	</script>
	<c:set var="rpt_invoice_no" value="${invoiceDtl.getRpt_invoice_no()}"/>
	<script>
	$(document).ready(function(){
		$.ajaxSetup({cache:false});
		if('${mbrVo_Session.user_no}' == null){
			window.location.assign("./logout");
		}
		
		$(".lectureRoomReturn").click(function(){
			if($("#return_reason").val() == ""){
				alert("반려사유를 입력해주세요.");
				$("#return_reason").focus();
				return;
			}	
			$.post("./udtLectureRoomReturnReason",
					{
						serial_no					:$("#serial_no").val(),
						return_reason				:$("#return_reason").val(),
						currentIdx					:$("#currentIdx").val(),
						state							:$("#hiddenState").val()
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("반려사유 등록이 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{
								alert("반려하였습니다.");
								window.self.close();
								
								<c:choose>
									<c:when test="${srchArg.state == 0}">
										window.opener.location.assign("./lectureRoomApproveList?pageIdx=${currentIdx}&state=0");
									</c:when>
									<c:otherwise>
										window.opener.location.assign("./lectureRoomApproveList?pageIdx=${currentIdx}");
									</c:otherwise>
								</c:choose>
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}//function
					
			);//post
		})		
	});//ready
	</script>
</head>
<body>
	<!-- header --><!--2016.01.14.rjh.수정.교체.-->
	<div id="headerpop_mbr">
		<div class="inner clear_v2">
			<h1>
				<img src="./resources/wm_img/common/logo.gif" height="40" alt="top - TRUST OBLIGATION PASSION" />
			</h1>
			<div style="text-align:center;padding-top:10px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
				<font color="white"><b><span style="font-size:11pt;"> 강의실 신청 </span></b></font>
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
								<li class="on"><a href="#">&nbsp;반려하기</a></li>
							</ul>
						</div>
						<!-- 관련업체 멤버 정보 컨텐츠 탭 -->
						<div class="guestcnt5" style="display:block;">
							<div class= "tableStyle2">
								<table cellpadding="0" cellspacing="0">
									<colgroup>
										<col width="20%">
										<col width="80%">
									</colgroup>
									<tr>
					                   <td bgcolor="#F8F8F8" class="td" height="28">
					                       <p align="center"><b>반려 사유</b></p>
					                   </td>
					                   <td>
					                   		<input type="text" id="return_reason" name="return_reason" value="" style="width:95%;">
					                    </td>
					                 </tr>
								</table>
		                         <input type="hidden"  id="hiddenState" name="hiddenState" value="${srchArg.state}"/>
		                         <input type="hidden" id="currentIdx" name="currentIdx" value="${pageInfo.currentPageNo}"/>
		                         <input type="hidden" id="serial_no" name="serial_no" value="${serial_no}"/>
							</div>
						<br>
						<p align="center">
							<input type="image" src="./resources/ls_img/ls_report/btn_rch_return.gif" class="lectureRoomReturn"/>
						</p>
					</div>
				</div><!-- //guest -->
			</div><!-- //bot1-3 -->
		</div>
	</div>
</div>
	<!--//center -->
</body>
