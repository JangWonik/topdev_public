<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>수임 등록</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<%--<script src="./resources/daum/161109.js"></script>--%>
	<script src="./resources/daum/postcode.v2.js"></script>
	<script src='https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js'></script>
	
	<script>
		$(document).ready(function(){
			
			if(('${mbrAuthVo_Session.user_no}' == null) || ('${mbrAuthVo_Session.mbr_pms_1}' == 0)){
				window.location.assign("./logout");
			}
			
			/* 계약적부 수수료  필드 비활성화 */
			$("#suitability_fee1").prop("disabled",true);
			$("#suitability_fee2").prop("disabled",true);
			$("#suitability_fee1").css("background-color","gray");
			$("#suitability_fee2").css("background-color","gray");

			/* 통계여부 초기 값 세팅 */
			$("input:radio[name='statistics_yn']:input[value='0']").prop("checked", true);	
			
			
			/* 세금계산서 여부 초기 값 세팅 */
			$("input:radio[name='issue_tax_invoice']:input[value='0']").prop("checked", true);				
			
			
			/* 계약적부 초기 값 세팅 */
			$("input:checkbox[name='suitability_yn']").prop("checked", false);				
			
			
			/* 입금은행 : 하나 은행으로 초기 세팅 */
			$("input:radio[name='top_accnt_id']:input[value='6']").prop("checked", true);				
			
			/* TYPE 세팅 : 순서대로 손해, 생명, 협회, 공제, 기타*/
			if(('${ptnr_type}' != null) && ('${ptnr_type}' != '')){
				if('${ptnr_type}' == 1){
					$("input:radio[name='ptnr_type']:input[value='1']").prop("checked", true);				
				}else if ('${ptnr_type}' == 2){
					$("input:radio[name='ptnr_type']:input[value='2']").prop("checked", true);
				}else if ('${ptnr_type}' == 3){
					$("input:radio[name='ptnr_type']:input[value='3']").prop("checked", true);
				}else if ('${ptnr_type}' == 4){
					$("input:radio[name='ptnr_type']:input[value='4']").prop("checked", true);
				}else if ('${ptnr_type}' == 5){
					$("input:radio[name='ptnr_type']:input[value='5']").prop("checked", true);
				}
			}else{
				
				$("input:radio[name='ptnr_type']:input[value='1']").prop("checked", true);
			}
			
			/* 문자 발송 설정 : 조사자 초기 세팅*/
			$("input:checkbox[name='ptnr_sms2']").prop("checked", true);
			$("#ptnr_sms2_msg").val('배당알림 - [ig]의 피보험자 [insured]님건 보험사담당자는 [igm]입니다.');

			/* 업데이트 동작 */
			$("#btnOk").click(function(){
				
				if($("#blockTag").val() == 'block'){
					alert(" 코드 입력값을 확인하세요");
					$("#ptnr_id").focus();
					return;
				}
				
				if($("#ptnr_id").val() == ''){
					alert("보험사 코드는 필수 입력 사항입니다.");
					$("#ptnr_id").focus();
					return;
				}
				
				if($("#ptnr_order").val() == ''){
					alert("Order 는 필수 입력 사항입니다.");
					$("#ptnr_order").focus();
					return;
				}
				
				if($("#ptnr_nick").val() == ''){
					alert("사명(줄임) 은 필수 입력 사항입니다.");
					$("#ptnr_nick").focus();
					return;
				}
				
				if($("#ptnr_name").val() == ''){
					alert("사명(정식) 은 필수 입력 사항입니다.");
					$("#ptnr_name").focus();
					return;
				}
				
				if($("#ptnr_biz_reg_no").val() == ''){
					alert("등록 번호는 필수 입력 사항입니다.");
					$("#ptnr_biz_reg_no").focus();
					return;
				}
				
				if($("#ptnr_ceo_nm").val() == ''){
					alert("대표자 성명은 필수 입력 사항입니다.");
					$("#ptnr_ceo_nm").focus();
					return;
				}
				
				
				
				$.post("./ptnrAdd",
						{	
							ptnr_level:$("#ptnr_level").val()
							,ptnr_group_order:$("#ptnr_group_order").val()
							,ptnr_order:$("#ptnr_order").val()
							,statistics_yn:$("input:radio[name='statistics_yn']:checked").val()
							,ptnr_type:$("input:radio[name='ptnr_type']:checked").val()
							,ptnr_nick:$("#ptnr_nick").val()
							,ptnr_name:$("#ptnr_name").val()
							,ptnr_biz_reg_no:$("#ptnr_biz_reg_no").val()
							,ptnr_ceo_nm:$("#ptnr_ceo_nm").val()
							,ptnr_biz_type1:$("#ptnr_biz_type1").val()
							,ptnr_biz_type2:$("#ptnr_biz_type2").val()
							,ptnr_tel:$("#ptnr_tel").val()
							,ptnr_addr:$("#ptnr_addr").val()
							,ptnr_addr1:$("#ptnr_addr1").val()
							,ptnr_postcode:$("#ptnr_postcode").val()
							,ptnr_url:$("#ptnr_url").val()  
							,ptnr_sms1:$("input:checkbox[name='ptnr_sms1']:checked").val()
							,ptnr_sms1_msg:$("#ptnr_sms1_msg").val()
							,ptnr_sms2:$("input:checkbox[name='ptnr_sms2']:checked").val()
							,ptnr_sms2_msg:$("#ptnr_sms2_msg").val()
							,ptnr_sms3:$("input:checkbox[name='ptnr_sms3']:checked").val()
							,ptnr_sms3_msg:$("#ptnr_sms3_msg").val()  
							,issue_tax_invoice:$("input:radio[name='issue_tax_invoice']:checked").val() 
							,top_accnt_id:$("input:radio[name='top_accnt_id']:checked").val() 
							,suitability_yn:$("input:checkbox[name='suitability_yn']:checked").val()
							,suitability_fee1:$("#suitability_fee1").val()
							,suitability_fee2:$("#suitability_fee2").val()
						},
						function(data,status){
							if(data == 1){
								alert("보험사 정보 입력이 완료 되었습니다.");
								location.href = "topPtrMng?fromPage="+$("input:radio[name='ptnr_type']:checked").val();
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post

			});// btnOk click
			
			/* btnCancel Click*/
			$("#btnCancel").click(function(){
				history.back();
			}); //btnCancel Click
			
			/* 계약적부  수수료 비활성화 */
			$("#suitability_yn").click(function(){
				
				if($("#suitability_yn").is(':checked')){
					$("#suitability_fee1").prop("disabled",false);
					$("#suitability_fee2").prop("disabled",false);
					$("#suitability_fee1").css("background-color","#FFFFFF");
					$("#suitability_fee2").css("background-color","#FFFFFF");
				}else{
					$("#suitability_fee1").prop("disabled",true);
					$("#suitability_fee2").prop("disabled",true);
					$("#suitability_fee1").css("background-color","gray");
					$("#suitability_fee2").css("background-color","gray");
					$("#suitability_fee2").val('');
					$("#suitability_fee2").val('');
				}
				
			});
			
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
		
		/* id 중복검사 */
		function chkPtnrId(ptnr_id){
			$.post("./ptnrIdCheck",
					{	ptnr_id:$("#ptnr_id").val()
						
					},
					function(data,status){
						if(data == 1){
							$("#checkCodeText").text("중복된 코드입니다.");
							$("#blockTag").val('block');
							
						}else{
							$("#blockTag").val('');
							$("#checkCodeText").text('');
						}
					}
			);//post	
		} 
		
	</script>
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

			<!-- left_cnt -->
			<c:import url="../top_main/top_main_left.jsp"></c:import>
			<!-- //left_cnt -->

			<!-- centercnt_top -->
			<div class="center_cnt">

				<!-- centercnt_bot -->
				<div class="centercnt_bot1-2">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">수임 등록</a></li>
							</ul>
						</div>
						<c:if test="${mbrAuthVo_Session.mbr_pms_1 == 1 }">
							<div class="guestcnt4" style="display:block;">
								<c:import url="../top_suim/suim_reg_ins.jsp"></c:import>
							</div><!-- //guestcnt5 -->
						</c:if>
					</div> <!-- //guest -->
				</div>
				<!-- //centercnt_bot -->

				<!-- banner -->
				<c:import url="../top_main/top_main_banner.jsp"></c:import>
				<!-- //banner -->

			</div>
			<!-- //center_cnt -->
		</div>
	</div>
	<!-- //contents -->

	<!-- footer -->
	<c:import url="../top_main/top_main_footer.jsp"></c:import>
	<!-- //footer -->

</div>
<!-- //wrapper -->

</body>
</html>
