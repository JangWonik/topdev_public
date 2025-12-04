<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar-rptinv.js"></script>
	<script>
		$(document).ready(function(){
			if('${mbrVo_Session.user_no}' == null || '${mbrVo_Session.user_no}'.trim() == ''){
				alert("로그아웃 상태입니다. 재로그인 하십시오.");
				window.location.assign("./logout");
			}
		});//ready

		function noSiteMngTmList(tmNo){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1120; //띄울 창의 넓이
			var sh=ch;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('noSiteMngTmListPop?tmNo='+tmNo,'noSiteMngTmListPop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=no');
		}
		
		function windowSet(win) {						
	        //var winBody = win.document.body;	        
	        //var wid = winBody.scrollWidth + 16;
	        //var hei = winBody.clientHeight + 70;
	        
	        win.resizeTo(1130, 1600);
	    }
	</script>
	
 
</head>

<body OnLoad="windowSet(this)">

<!-- wrapper -->
	<!-- contents -->
	<div id="container">
		<div class="noSitePop">
			<!-- nosite_mng_pop_cnt -->
			<div class="nosite_mng_pop_cnt">
				<div class="tArea">
					<p class="suttl">팀별 진행관리 및 보고서제출 현황</p>
					<div class="tableStyle3" style="width:1050px;">
                        <div>
                            <table cellpadding="0" cellspacing="0" summary="team조사" >                                
                                <tr>
                                    <th width="110px;">팀명</th>
                                    <th width="90px;">현장제출<br/>3일전</th>
                                    <th width="90px;">중간제출<br/>5일전</th>
                                    <th width="90px;">진행경과제출<br/>5일전</th>
                                    <th width="90px;">현장제출<br/>3일초과</th>
                                    <th width="90px;">중간제출<br/>초과</th>
                                    <th width="90px;">진행경과제출<br/>초과</th>
                                    <th width="90px;">사고처리</th>
                                    <th width="90px;">미결사유</th>
                                    <th width="90px;">문제점</th>
                                    <th width="90px;">향후처리방안</th>
                                    <th width="15px;"></th>
                                </tr>
							</table>  
							<div class="tableStyle3" style="height:810px;width:1050px; overflow-x: hidden; overflow-y: auto;border-top:0px;">
								<table>                                
	                                <c:forEach items="${noSiteMngList}" var="noSiteMngVO" varStatus="status" >
	                                    <tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
	                                        style ="cursor:pointer;" onclick="noSiteMngTmList('${noSiteMngVO.teamId}')">
	                                        <!-- 팀명 -->
	                                        <td width="110px;" style="letter-spacing:-1px;">${noSiteMngVO.teamName}</td>
	                                        <!-- 현장제출 3일전 -->
	                                        <td width="90px;">${noSiteMngVO.fieldNotCnt}</td>
	                                        <!-- 중간제출 5일전 -->
	                                        <td width="90px;">${noSiteMngVO.middle5dayNotCnt}</td>
	                                        <!-- 진행경과 5일전 -->
	                                        <td width="90px;">${noSiteMngVO.middle5dayCnt}</td>
	                                        <!-- 현장제출 3일 초과 -->
	                                        <td width="90px;">${noSiteMngVO.fieldOverCnt}</td>
	                                        <!-- 중간제출 초과 -->
	                                        <td width="90px;">${noSiteMngVO.middleNotCnt}</td>
	                                        <!-- 진행경과 초과 -->
	                                        <td width="90px;">${noSiteMngVO.middleCnt}</td>
	                                        <!-- 사고처리과정 -->
	                                        <td width="90px;">${noSiteMngVO.sagoNotCnt}</td>
	                                        <!-- 미결사유 -->
	                                        <td width="90px;">${noSiteMngVO.nowNotCnt}</td>
	                                        <!-- 문제점 -->
	                                        <td width="90px;">${noSiteMngVO.prbNotCnt}</td>
	                                        <!-- 향후처리방안 -->
	                                        <td width="90px;">${noSiteMngVO.plnNotCnt}</td>
	                                    </tr>
	                                </c:forEach>                                
                            	</table>
							</div>
                        </div>
					</div><!-- //tableStyle3  -->
				</div><!-- //tArea -->
			</div><!-- //nosite_mng_pop_cnt -->
		</div><!-- //contetns -->
	</div><!-- //contents -->
</body>
</html>
 