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
	<title>휴가 신청</title>
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

		$("#dayoffToDate").change(function(){
			//날자 계산 시작
			$.post("./calcDayoffCnt",
					{	dayoffFromDate:$("#dayoffFromDate").val()
						,dayoffToDate:$("#dayoffToDate").val()
					},
					function(data,status){
						if(status == "success"){
							if(data <= 0){
								alert("입력하신 날자를 확인해 주세요.");
							}else{
			                    $("#dayoffCnt").val(data);
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}
			);//post
//날자 계산 끝
		});

	});//ready
	
	function mydayoffins(){
		if($("#title").val() == ""){
			alert("사유를 입력해주세요.");
			$("#title").focus();
			return;
		}
		if($.trim($("#dayoffFromDate").val()) == ""){
			alert("휴가 기간을 입력해 주세요.");
			$("#dayoffFromDate").focus();
			return;
		}
		if($.trim($("#dayoffToDate").val()) == ""){
			alert("휴가 기간을 입력해 주세요.");
			$("#dayoffToDate").focus();
			return;
		}
		if($("#dayoff_type").val() == ""){
			alert("휴가 종류를 선택해 주세요.");
			$("#dayoff_type").focus();
			return;
		}
		/* if($(":radio[name=dayoff_type]:checked").val() == 1){
			if(parseInt($("#dayoffCnt").val()) > parseInt($("#notUsed").val())){
				alert("사용하려는 휴가 갯수가 남은 휴가 갯수보다 많습니다.");
				return;
			}
		} */
		
		$.post("./mydayoffinsOK",
				{
					title					:$("#title").val()
					,dayoffFromDate   		:$("#dayoffFromDate").val()
					,dayoffToDate	   		:$("#dayoffToDate").val()
					,user_no	   			:$("#user_no").val()
					,team_id	   			:$("#team_id").val()
					,dayoffCnt	   			:$("#dayoffCnt").val()
					,dayoff_type	   		:$(":input:radio[name=dayoff_type]:checked").val()
					,work_level	   			:$("#work_level").val()
					,team_manager	   		:$("#team_manager").val()
					,toServerYear	   		:$("#toServerYear").val()
				},
				function(data,status){
					if(status == "success"){
						if(data == 0){
							alert("신청에 실패하였습니다. 관리자에게 문의해 주세요.");
						}else{
							alert("신청되었습니다..");
							window.self.close();
							window.opener.location.assign("./myDayoffInsList");
						}
					}else{
						alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
					}
				}//function
				
		);//post

	}

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
				<font color="white"><b><span style="font-size:11pt;"> 휴가 신청 </span></b></font>
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
								<li class="on"><a href="#">&nbsp;${user_name} 휴가신청</a></li>
							</ul>
						</div>
						
						<!-- 관련업체 멤버 정보 컨텐츠 탭 -->
						<div class="guestcnt5" style="display:block;">
						<div class= "tableStyle2">
							<input type="hidden" id="dayoffCnt" name="dayoffCnt" />
							<input type="hidden" id="work_level" name="work_level" value="${work_level}" />
							<input type="hidden" id="team_id" name="team_id" value="${team_id}" />
							<input type="hidden" id="team_manager" name="team_manager" value="${myDayoffInfo.team_manager}" />
							<input type="hidden" id="notUsed" name="notUsed" value="${myDayoffsel.notUsed}" />
							<input type="hidden" id="toServerYear" name="toServerYear" value="${toServerYear}"/>
							<table cellpadding="0" cellspacing="0">
									<colgroup>
												<col width="30%">
												<col width="70%">
												
											</colgroup>
									<%-- <tr>
				                        <td bgcolor="#F8F8F8" class="td" height="28">
				                            <p align="center"><b>현재사용내역</b></p>
				                        </td>
				                        <td>
				                        	총 : <c:out value="${myDayoffsel.total}"/>&nbsp;&nbsp;&nbsp;
				                        	사용갯수 : <c:out value="${myDayoffsel.used}"/>
				                        </td>
				                    </tr> --%>
									<tr>
				                        <td bgcolor="#F8F8F8" class="td" height="28">
				                            <p align="center"><b>종류</b></p>
				                        </td>
				                        <td style="text-align:left;">
				                        	<style>
				                        		#ul_type li {float:left; width:150px;}
				                        	</style>
				                        	<ul id="ul_type" style="padding-left:40px;">
					                        	<li><input type="radio" id="dayoff_type" name="dayoff_type" value="1" />&nbsp;연차</li>
					                        	<li><input type="radio" id="dayoff_type" name="dayoff_type" value="2" />&nbsp;경조사</li>
					                        	<li><input type="radio" id="dayoff_type" name="dayoff_type" value="3" />&nbsp;예비군(민방위)</li>
					                        	<li><input type="radio" id="dayoff_type" name="dayoff_type" value="4" />&nbsp;배우자 출산</li>
					                        	<li><input type="radio" id="dayoff_type" name="dayoff_type" value="5" />&nbsp;출산 전ㆍ후</li>
					                        	<li><input type="radio" id="dayoff_type" name="dayoff_type" value="6" />&nbsp;유ㆍ사산</li>
					                        	<!-- <li><input type="radio" id="dayoff_type" name="dayoff_type" value="7" />&nbsp;기타</li> -->
				                        	</ul>
				                        </td>
				                    </tr>
									<tr>
				                        <td bgcolor="#F8F8F8" class="td" height="28">
				                            <p align="center"><b>사유</b></p>
				                        </td>
				                        <td>
				                        	<input type="text" id="title" name="title" style="width:95%;"/>
				                        	<br>
				                        	<font color="red"><b>사유 간략히 기재, 단 "월차","정기휴가" 라고 입력하지 말 것</b></font>
				                        </td>
				                    </tr>
				                    <tr>
				                        <td bgcolor="#F8F8F8" class="td" height="28">
				                            <p align="center"><b><font color="#003399">기간</font></b></p>
				                        </td>
				                        <td style="text-align:center;">
				                        	<input type="text" id="dayoffFromDate" name="dayoffFromDate" value="${strToday}" style="width:80px;"/>
				                        	 &nbsp;~&nbsp; 
				                        	<input type="text" id="dayoffToDate" name="dayoffToDate" style="width:80px;"/>
				                        </td>
				                    </tr>
				                    <tr>
				                        <td bgcolor="#F8F8F8" class="td" height="28">
				                            <p align="center"><b><font color="#003399">이름</font></b></p>
				                        </td>
				                        <td>${myDayoffInfo.user_name}</td>
				                    </tr>
				                    <tr>
				                        <td bgcolor="#F8F8F8" class="td" height="28">
				                            <p align="center"><b><font color="#003399">주소</font></b></p>
				                        </td>
				                        <td>${myDayoffInfo.team_addr}</td>
				                    </tr>
				                    <tr>
				                        <td bgcolor="#F8F8F8" class="td" height="28">
				                            <p align="center"><b><font color="#003399">근무부서</font></b></p>
				                        </td>
				                        <td>${myDayoffInfo.team_name}</td>
				                    </tr>
				                    <tr>
				                        <td bgcolor="#F8F8F8" class="td" height="28">
				                            <p align="center"><b><font color="#003399">직위</font></b></p>
				                        </td>
				                        <td>${myDayoffInfo.work_level_Nm}</td>
				                    </tr>
				                    <tr>
				                        <td bgcolor="#F8F8F8" class="td" height="28">
				                            <p align="center"><b><font color="#003399">결재자</font></b></p>
				                        </td>
				                        <td>${myDayoffInfo.team_manager_Nm}</td>
				                    </tr>
				                       
				                    
							</table>
						</div>
						<br>
						<p align="center">
							<img src="./resources/ls_img/btn_request.gif" onclick="mydayoffins()" style="cursor:pointer;"/>
						</p>
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

</body>
