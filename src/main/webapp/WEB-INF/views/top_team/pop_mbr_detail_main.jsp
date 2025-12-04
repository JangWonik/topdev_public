<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css?v=2" />
	
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/ne_js/ne_number.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/><!-- calendar -->
	<script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
	<script src="./resources/ne_js/calendar.js"></script><!-- calendar -->
	<script src="./resources/wm_js/common.js"></script>
	
	<script defer src="./resources/fontawesome_5.0/svg-with-js/js/fontawesome-all.js"></script>
	
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>
	
	<style>
		.memberDetailTable tr td{
			letter-spacing: 0px;
			height: 23px;
		}
		
		/* 모달창 셀렉트 박스 */
		.select2-container--default{
			text-align : left;
			font-color:#444;
			font-size:12px;
		}
		
		.memoTextarea{
	      	OVERFLOW-Y:auto; OVERFLOW-X:hidden; width:780px; padding:2px; word-break:break-all; line-height:120%; height:100px;
  			border: 1px solid #b3b3b3;
    		border-radius: 2px;
   		    font-size: 10pt;
    		font-family: 굴림,굴림체;
   		    line-height: 140%;
		}
		
		@media (max-width: 1080px){
			body{height:1800px;}
			#container{height:100% !important;}
			.centercnt_bot1-3{width:1060px !important;height:100% !important;}
			.contetnsPop{width:1060px !important;}
			.center_cnt{height:99%;}
			.guestcnt7{height:1630px !important; }
			
			
		}
	</style>
	
	<script>
		$(document).ready(function(){
			var a = document.body.offsetWidth 
			var b = document.body.scrollWidth // (문서 전체의 크기)
			var c = document.body.clientWidth // (창의 크기)
			
			if('${mbrAuthVo_Session.user_no}' == null || ('${mbrAuthVo_Session.mbr_pms_14}' == 0 && '${mbrAuthVo_Session.mbr_pms_15}' == 0)){
				window.opener.location.assign("./logout");
				window.self.close();
			}
			
			
 			/* 비밀번호 초기화 */ 
 			$("#initialPw").click(function(){
 				
 				var sUser_name = $("#user_name").val();
 				var sUser_no = $("#user_no").val();
 				var sHandphone = $("#handphone_1").val()+"-"+$("#handphone_2").val()+"-"+$("#handphone_3").val();
 				var sComment = sUser_name + "님의 비밀번호를 초기화 하시겠습니까?"; 				
 				
 				if(confirm(sComment)){
 					
 					var param = {};
 		            param.user_name = sUser_name;
 		            param.user_no = sUser_no;
 		            param.mobile = sHandphone; 

 		            var url = "/refleshPwKakao";
 					
 					$.ajax({
 		                type: "POST",
 		                url: url,
 		                data: param,
 		                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
 		                dataType: "json",
 		                timeout: 20000,
 		                success: function(data){ 		                	
 		                	var reCode = data.RSLT_CODE; 		                	
 		                	if( reCode == "K" ){
 		                		alert("비밀번호 초기화 정보를 카카오톡으로 발송요청 하였습니다");
 		                	}else if( reCode == "M" ){
 		                		alert("비밀번호 초기화 정보를 SMS로 발송요청 하였습니다");
 		                	}else if( reCode == "L" ){
 		                		alert("비밀번호 초기화 정보를 카카오톡(문자) 발송요청 하였습니다");
 		                	}else{
 		                		alert( reCode );
 		                	} 		                	
 		                },
 		                error: function(xhr, status, error){
 		                    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.!!!!!");
 		                }
 		            });
 					
 					/* $.post("./initializePw",
 	 						{	
 	 							user_no : sUser_no
 	 						},
 	 						function(data,status){

 	 							if(status == "success"){
 	 								if(data == 0){
 	 									alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
 	 								}else{
 	 									$("#message").val("Top PassWord : "+data);
 	 									resFrom.submit();
 	 									alert("비밀번호가 초기화 되었습니다. 임시 비밀번호가 "+sUser_name+"님에게 SMS로 전송되었습니다.");
 	 									location.href = "popMbrDetail?user_no="+sUser_no;
 	 								}
 	 							}else{
 	 								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
 	 							}
 	 						}
 	 				);//post */
 				}
 			});
 			
 			$("#myimageDel").click(function(){
 				var r = confirm("사진을 삭제 하시겠습니까?");
 				if (!r){
 					return false;
 				}
				$.post("popMemberDtlImgDel",
						{user_no : $("#user_no").val()},
						function(data,status){
							if(data == 1 && status == 'success'){
								alert("사진을 삭제하였습니다.");
								location.reload();
								/*
								$("#myimage").attr("src","");
								$("#myimageDel").css("display","none");
								*/
							}else{
								alert("삭제에 실패했습니다. 잠시 후 시도해주세요.")
								
							}
						}
				);
 				
 			});
		});
	</script>
		
	<style>
		#initialPw {
			border:1x solid #ff0080;    /*---테두리 정의---*/
			background-Color:#ffe6f2;   /*--백그라운드 정의---*/
			font:12px 굴림;      /*--폰트 정의---*/
			font-weight:bold;   /*--폰트 굵기---*/
			color:#ff0080;    /*--폰트 색깔---*/
			width:130;height:30;  /*--버튼 크기---*/
			margin-left:10px;
		}
		
		.ui-button-text-only {
			height:2.1em !important;
		}
		
	</style>
</head>
<body>
	<!-- header --><!--2016.01.14.rjh.수정.교체.-->
	<div id="headerpop_mbr">
		<div class="inner clear_v2">
			<h1>
				<img src="./resources/wm_img/common/logo.gif" height="40" alt="top - TRUST OBLIGATION PASSION" />
			</h1>
			<div style="text-align:center;padding-top:10px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
				<font color="white"><b><span style="font-size:11pt;"> 인 사 관 리</span></b></font>
			</div>
		</div>
	</div>
	<!-- //header -->
	
	<!-- center -->
	<div id ="container" style="height: 860px ; overflow-Y:hidden;">
		<div class="contetnsPop" style="width: 1480px;">
			<div class="center_cnt">
				<div class="centercnt_bot1-3" style="width:1480px; height:820px;">
					<div class="guest">
						<div class="guestTap">
							<ul>
							
								<li class="on"><a href="#">사원 정보</a></li>								
								<!-- IT지원파트(홍기헌,장원익), 윤경수전무님-->
								<%-- <c:if test="${mbrVo_Session.user_state == 9 or mbrVo_Session.user_no == 62}"> --%>
								<c:if test="${mbrVo_Session.user_no == 670 or mbrVo_Session.user_no == 1786 or mbrVo_Session.user_no == 62}">
									<li id="authIns"><a href="#">전산권한관리</a></li>
									<li id="authLog"><a href="#">전산권한변경내역</a></li>
								</c:if>
								
								<c:if test="${mbrAuthVo_Session.mbr_pms_15 == 1 }">
									<c:if test="${mbrAuthVo_Session.mbr_pms_40 == 1 }">
										<li id="appoint"><a href="#">발령, 진급 및 휴직,상/벌</a></li>
									</c:if>
									<c:if test="${mbrAuthVo_Session.mbr_pms_42 == 1 }">
										<li id="career"><a href="#">경력 및 자격</a></li>
									</c:if>
									<c:if test="${mbrAuthVo_Session.mbr_pms_43 == 1 }">
										<li id="education"><a href="#">교육 및 강의이력</a></li>
									</c:if>
									<c:if test="${mbrAuthVo_Session.mbr_pms_44 == 1 }">
										<li id="family"><a href="#">학력 및 가족관계</a></li>
									</c:if>
								</c:if>
								
								<c:if test="${mbrAuthVo_Session.mbr_pms_14 == 1 }">
									<li id="doc"><a href="#">인사서식관리</a></li>	
								</c:if>
								
							</ul>
						</div>
						<form action="./popMbrDetail" name="popMbrDetail" method="get">
							<input type="hidden" name="tabGubun" id="tabGubun" value="" />
							<input type="hidden" name="user_no" id="user_no" value="${userNo}" />
						</form>
						
						<!-- 사원 정보 컨텐츠 탭 -->
						<div class="guestcnt7" style="display: block;">
							<c:import url="/popMbrDetailInfo">
								<c:param name="userNo" value="${userNo}" />
							</c:import>
						</div>
						
						<c:if test="${mbrVo_Session.user_state == 9 or mbrVo_Session.user_no == 62}">
							<div class="guestcnt7" style="display:none;">
								<c:import url="/popMbrDetailAuthIns">
									<c:param name="userNo" value="${userNo}" />
								</c:import>
							</div><!-- //guestcnt7 -->
							<div class="guestcnt7" style="display:none;">
								<c:import url="/popMbrDetailAuthLog">
									<c:param name="userNo" value="${userNo}" />
								</c:import>							
							</div><!-- //guestcnt7 -->
						</c:if>	

						<c:if test="${mbrAuthVo_Session.mbr_pms_15 == 1}">
							<c:if test="${mbrAuthVo_Session.mbr_pms_40 == 1 }">
								<div class="guestcnt7" style="display:none;">
									<c:import url="/popMbrDetailAppointList">
										<c:param name="userNo" value="${userNo}" />
									</c:import>									
								</div>
							</c:if>
							
							<c:if test="${mbrAuthVo_Session.mbr_pms_42 == 1 }">
								<div class="guestcnt7" style="display:none;">
									<c:import url="/popMbrDetailCareerList">
										<c:param name="userNo" value="${userNo}" />
									</c:import>					
								</div>
							</c:if>
							
							<c:if test="${mbrAuthVo_Session.mbr_pms_43 == 1 }">
								<div class="guestcnt7" style="display:none;">
									<c:import url="/popMbrDetailEducationList">
										<c:param name="userNo" value="${userNo}" />
									</c:import>							
	  							</div>
  							</c:if>
							
							<c:if test="${mbrAuthVo_Session.mbr_pms_44 == 1 }">
								<div class="guestcnt7" style="display:none;">
									<c:import url="/popMbrDetailFamilyList">
										<c:param name="userNo" value="${userNo}" />
									</c:import>		
								</div>
							</c:if>
						</c:if>
						
						<!-- 품의서 관리 -->
						<c:if test="${mbrAuthVo_Session.mbr_pms_14 == 1 }">
							<div class="guestcnt7" style="display:none;">
								<c:import url="/popMbrDetailDocList">
									<c:param name="userNo" value="${userNo}" />
								</c:import>		
							</div><!-- //guestcnt7 -->
						</c:if>
						
					</div><!-- //guest -->
				</div><!-- //bot1-3 -->
			</div>
		</div>
	</div>
	<!--//center -->

	<!-- footer -->
<%-- 	<c:import url="../top_main/top_pop_footer.jsp"></c:import> --%>
	<!-- //footer -->
	
<script type="text/javascript">
    $(document).ready(function () {
		$("#"+"${tabGubun}").click();
		
		//담당손해사정사 선택 폼 활성화
		$("#certiManagerSearch").select2({
			placeholder: " 검색할 손해사정사 정보를 선택해주세요.",
		    allowClear: true,		    		    
		});
		
		var userCkeys = '${userCkeys}';		
		
		if( userCkeys != '' ){
			$("#certiManagerSearch").select2().val([${userCkeys}]).trigger("change");	
		}				
		
    });
</script>

</body>
