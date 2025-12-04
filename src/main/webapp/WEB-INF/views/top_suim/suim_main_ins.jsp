<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>수임 등록</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css?v=2" />
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/vertical.css?v=2" />
	
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<!-- <script src="./resources/daum/161109.js"></script>
	<script src="./resources/daum/postcode.v2.js"></script>
	<script src='https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js'></script> -->
	<script>
		$(document).ready(function(){

			$.ajaxSetup({cache:false});

			if(('${mbrAuthVo_Session.user_no}' == null) || ('${mbrAuthVo_Session.mbr_pms_1}' == 0)){
				window.location.assign("./logout");
			}
			
			$("#postCodeBtn").click(function(){
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
						$("#ptnr_postcode").val(data.zonecode);
						$("#ptnr_addr1").val(data.roadAddress);
					}
				}).open();
			});//$("#postCodeBtn").click
			
			
			
		}); //ready
		
		
		/* 수임 등록건 조회에서 건 클릭시 입력 화면으로 넘겨주는 동작 */
		function putSuimIns(rpt_no, team_id, user_no, ptnr_id, ptnr_dept_id, ptnr_mbr_no, rpt_type1){
			
			$("#insTab").click();

			$("#ptnrId").val(ptnr_id);
			$("#ptnrDeptIdBySrc").val(ptnr_dept_id);
			$("#ptnrId").change();
			
			$("#ptnrDeptMbrIdBySrc").val(ptnr_mbr_no);

			$("#topTeamId").val(team_id);
			$("#mbrIdBySrc").val(user_no);
			$("#topTeamId").change();
			
			$.post("./dataFromSearchTab",
					{	
						rpt_no:rpt_no
					},
					function(data,status){
						
						if(status == "success"){
							
							if(data.length == 0){
								
								alert("시스템 오류입니다. 재시도하십시오.");
								
							}else{
			                    $.each(data, function(index, entry) {
			                    	
		                    		if(entry.policyholderTel != ''){
		                    			if(entry.policyholderTel.split('-').length == 3){
			                    			var polTel = entry.policyholderTel.split('-');
				                    			$("#conPhone1").val(polTel[0]);
					                    	 	$("#conPhone2").val(polTel[1]);
					                    	 	$("#conPhone3").val(polTel[2]); //계약자 폰
		                    			}else{
		                    				$("#conPhone1").val('');
				                    	 	$("#conPhone2").val('');
				                    	 	$("#conPhone3").val(''); //계약자 폰
		                    			}
		                    		}else{
		                    			$("#conPhone1").val('');
			                    	 	$("#conPhone2").val('');
			                    	 	$("#conPhone3").val(''); //계약자 폰
		                    		}
		                    		
		                    		if(entry.beneficiaryTel != ''){
		                    			if(entry.beneficiaryTel.split('-').length == 3){
			                    			var bebTel = entry.beneficiaryTel.split('-');
				                    			$("#insPhone1").val(bebTel[0]);
					                    	 	$("#insPhone2").val(bebTel[1]);
					                    	 	$("#insPhone3").val(bebTel[2]); // 피보험자 폰
		                    			}else{
		                    				$("#insPhone1").val('');
				                    	 	$("#insPhone2").val('');
				                    	 	$("#insPhone3").val(''); // 피보험자 폰
		                    			}
		                    		}else{
		                    			$("#insPhone1").val('');
			                    	 	$("#insPhone2").val('');
			                    	 	$("#insPhone3").val(''); // 피보험자 폰
		                    		}
		                    		
		                    		if(entry.damagedTel != ''){
		                    			if(entry.damagedTel.split('-').length == 3){
			                    			var dmgTel = entry.damagedTel.split('-');
				                    			$("#insItemPhone1").val(dmgTel[0]);
					                    	 	$("#insItemPhone2").val(dmgTel[1]);
					                    	 	$("#insItemPhone3").val(dmgTel[2]);  // 물 폰
		                    			}else{
		                    				$("#insItemPhone1").val('');
				                    	 	$("#insItemPhone2").val('');
				                    	 	$("#insItemPhone3").val('');  // 물 폰
		                    			}
		                    		}else{
		                    			$("#insItemPhone1").val('');
			                    	 	$("#insItemPhone2").val('');
			                    	 	$("#insItemPhone3").val('');  // 물 폰
		                    		}
		                    		
		                    		if( (entry.suimRptType1 != 6) &&
		                    				(entry.suimRptType1 != 7) &&
		                    				(entry.suimRptType1 != 8) &&
		                    				(entry.suimRptType1 != 9) &&
		                    				(entry.suimRptType1 != 10) 
		                    				){
		                    			$("#suitDetail").css("display","none");
		                    		}else{
		                    			$("#suitDetail").css("display","block");
		                    		}
		                    		
		                    		if(ptnr_id == 34){
		            					$("#suhyupDetail").css("display","block");
		            					$("#suitDetail").css("display","none");
		            				}else{
		            					$("#suhyupDetail").css("display","none");
		            					$("#ptnrId").prop("disabled",false);	
		            				}
		                    		
		                    	 	//$("#gubun_rpt1").val(entry.suimRptType1); 보험구분
		                    	 	
		                    	 	//$("input:radio[name='gubun_rpt1']:radio[value='"+entry.suimRptType1+"']").attr('checked', true); 
		                    	 	$("input:radio[name='gubun_rpt1']:radio[value='"+entry.suimRptType1+"']").prop('checked', true);
		                    	 	
		                    	 	// $("#gubun_rpt2").val(entry.suimRptType2); 보고서 구분
		                    	 	$("input:radio[name='gubun_rpt2']:radio[value='"+entry.suimRptType2+"']").prop('checked', true);
		                    	 	
		                    	 	$("#topTeamId option[value="+entry.teamId+"]").attr("selected", "true");
		                    	 	$("#ptnrId option[value="+entry.ptnrId+"]").attr("selected", "true");

		                    	 	$("#conName").val('');
		                    	 	$("#conName").val(entry.policyholderNm); // 계약자 이름
		                    	 	$("#insName").val('');
		                    	 	$("#insName").val(entry.beneficiaryNm); // 피보험자 이름
		                    	 	$("#insItem").val('');
		                    	 	$("#insItem").val(entry.damagedNm); // 피해자 / 물
		                    	 	$("#sago_time").val(entry.accidentDate); // 사고일
		                    	 	$("#suim_time").val(entry.regDate); // 수임일
		                    	 	$("#accNo").val('');
		                    	 	$("#accNo").val(entry.accidentNo); // 사고번호
		                    	 	$("#conNo").val('');
		                    	 	$("#conNo").val(entry.policyNo);// 증권번호
		                    	 	$("#accType").val('');
		                    	 	$("#accType").val(entry.insuranceNm); // 보험 종목
		                    	 	$("#accContent").val('');
									$("#accContent").val(entry.accidentFacts); // 사고 내용
									$("#postcode1").val(entry.investigatePostcode); // 조사지역 우편번호
									$("#addr_1st").val(entry.investigateAddr1); // 조사지역 주소1
									$("#addr_1st_1").val(entry.investigateAddr2); //조사지역 주소2
									$("#estLoss").val(entry.damagedAmtEstimated); // 추정 손해액 
									$("#estFee").val(entry.commissionEstimated);  // 추정 수수료
									
									
									
									//처리구분 (배상(대인), 배상(대물), 전문, 재물)에 따라 부서상세 구분, 계약기간 구분 표기되고 기본값으로 설정되도록 수정 by top3009 20230628
									if( rpt_type1 == 11 || rpt_type1 == 12 || rpt_type1 == 13 || rpt_type1 == 2 ){
										getPtnrIdSubForm();
										getPeriodFlagForm();
										//보험사 세부코드 설정
										$("input:radio[name='ptnrIdSub']:radio[value='"+entry.ptnrIdSub+"']").prop('checked',true);										
										//보험사 계약기간 설정
										$("input:radio[name='periodFlag']:radio[value='"+entry.periodFlag+"']").prop('checked',true);
									}else{
										getPtnrIdSubFormDisable();
										getPeriodFlagFormDisable();
									}
									
							});//each
						}
                   	 	
					}else{
						alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
					}
				},"json"
			);//post

		} //  end put
		
		
	</script>
</head>

<body>
<input type="hidden" id = "mbrIdBySrc" />
<input type="hidden" id = "ptnrDeptIdBySrc" />
<input type="hidden" id = "ptnrDeptMbrIdBySrc" />
<!-- wrapper -->
<div id="wrapper">
	<!-- skipnavi --><!-- header -->
	<c:import url="../top_main/top_main_menu.jsp"></c:import>
	<!-- //skipnavi --><!-- //header -->

	<!-- contents -->
	<div id="container">
		<div class="contetns" style="padding: 8px 0 100px 0 !important;">

			<!-- centercnt_top -->
			<div class="center_cnt_1300">

				<!-- centercnt_bot -->
				<div class="center_cnt_1300_bot" style="height: 820px !important;">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on" id ="insTab"><a href="#">수임 등록</a></li>
								<li ><a href="#">수임 등록건 조회</a></li>
								<li ><a href="#">계약 적부 등록</a></li>
								<!-- 171117 주석 석진성,유미성,박우현 -->
								<li ><a href="#">메리츠 일괄 등록</a></li> 
							</ul>
						</div>
						
						<c:if test="${mbrAuthVo_Session.mbr_pms_1 == 1 }">
							<div class="guestcntSearchExt" style="display:block;">
								<c:import url="../top_suim/suim_reg_ins.jsp"></c:import>
							</div><!-- //guestcnt4 -->
						</c:if>
						<c:if test="${mbrAuthVo_Session.mbr_pms_1 == 1 }">
							<div class="guestcntSearchExt" style="display:none;">
								<c:import url="../top_suim/suim_reg_ins_src.jsp"></c:import>
							</div><!-- //guestcnt4 -->
						</c:if>
						<c:if test="${mbrAuthVo_Session.mbr_pms_1 == 1 }">
							<div class="guestcntSearchExt" style="display:none;">
								<c:import url="../top_suim/suim_suit.jsp"></c:import>
							</div><!-- //guestcnt4 -->
						</c:if>
						
						<c:if test="${mbrAuthVo_Session.mbr_pms_1 == 1 }">
							<div class="guestcntSearchExt" style="display:none;">
								<c:import url="../top_suim/suim_reg_meritz_all.jsp"></c:import>
							</div>
						</c:if>
					</div> <!-- //guest -->
				</div>
				<!-- //centercnt_bot -->

			</div>
			<!-- //center_cnt -->
		</div>
	</div>
	<!-- //contents -->

	<!-- footer -->
<%-- 	<c:import url="../top_main/top_main_footer.jsp"></c:import> --%>
	<!-- //footer -->

</div>
<!-- //wrapper -->

</body>
</html>
