<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<%--<script src="./resources/daum/161109.js"></script>--%>
	<script src="./resources/daum/postcode.v2.js"></script>
	<script src='https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js'></script>
	
	<script>
		$(document).ready(function(){
			
			if(('${mbrAuthVo_Session.user_no}' == null) || ('${mbrAuthVo_Session.mbr_pms_9}' == 0)){
				window.location.assign("./logout");
			}
			

			/* 통계여부 값 세팅 */
			if('${ptnrVo.statistics_yn}' != null){
				if('${ptnrVo.statistics_yn}' == 0){
					$("input:radio[name='statistics_yn']:input[value='0']").prop("checked", true);				
				}else{
					$("input:radio[name='statistics_yn']:input[value='1']").prop("checked", true);
				}
			}
			
			/* 통계 심사표시여부 값 세팅 */
			if('${ptnrVo.statistics_written_yn}' != null){
				if('${ptnrVo.statistics_written_yn}' == 0){
					$("input:radio[name='statistics_written_yn']:input[value='0']").prop("checked", true);				
				}else{
					$("input:radio[name='statistics_written_yn']:input[value='1']").prop("checked", true);
				}
			}
			
			/* 세금계산서 */
			if('${ptnrVo.issue_tax_invoice}' != null){
				if('${ptnrVo.issue_tax_invoice}' == 0){
					$("input:radio[name='issue_tax_invoice']:input[value='0']").prop("checked", true);				
				}else{
					$("input:radio[name='issue_tax_invoice']:input[value='1']").prop("checked", true);
				}
			}
			
			/* 계약적부 */
			if('${ptnrVo.suitability_yn}' != ''){
				if('${ptnrVo.suitability_yn}' == 0){
					$("input:checkbox[name='suitability_yn']").prop("checked", false);				
				}else if('${ptnrVo.suitability_yn}' == 1){
					$("input:checkbox[name='suitability_yn']").prop("checked", true);
				}
			}
			
			/* 입금은행 : 하나 6, 농혐 9, 새마을 8, KB 10, 신용협동조함 7 */
			if('${ptnrVo.top_accnt_id}' != null){
				if('${ptnrVo.top_accnt_id}' == 6){
					$("input:radio[name='top_accnt_id']:input[value='6']").prop("checked", true);				
				}else if('${ptnrVo.top_accnt_id}' == 7){
					$("input:radio[name='top_accnt_id']:input[value='7']").prop("checked", true);
				}else if('${ptnrVo.top_accnt_id}' == 8){
					$("input:radio[name='top_accnt_id']:input[value='8']").prop("checked", true);
				}else if('${ptnrVo.top_accnt_id}' == 9){
					$("input:radio[name='top_accnt_id']:input[value='9']").prop("checked", true);
				}else if('${ptnrVo.top_accnt_id}' == 10){
					$("input:radio[name='top_accnt_id']:input[value='10']").prop("checked", true);
				}else if('${ptnrVo.top_accnt_id}' == 11){
					$("input:radio[name='top_accnt_id']:input[value='11']").prop("checked", true);
				}				
				
			}
			
			/* TYPE 세팅 : 순서대로 손해, 생명, 협회, 공제, 기타*/
			if('${ptnrVo.ptnr_type}' != null){
				if('${ptnrVo.ptnr_type}' == 1){
					$("input:radio[name='ptnr_type']:input[value='1']").prop("checked", true);				
				}else if ('${ptnrVo.ptnr_type}' == 2){
					$("input:radio[name='ptnr_type']:input[value='2']").prop("checked", true);
				}else if ('${ptnrVo.ptnr_type}' == 3){
					$("input:radio[name='ptnr_type']:input[value='3']").prop("checked", true);
				}else if ('${ptnrVo.ptnr_type}' == 4){
					$("input:radio[name='ptnr_type']:input[value='4']").prop("checked", true);
				}else if ('${ptnrVo.ptnr_type}' == 5){
					$("input:radio[name='ptnr_type']:input[value='5']").prop("checked", true);
				}
			}
			
			/* 문자 발송 설정 : 보험사*/
			if('${ptnrVo.ptnr_sms1}' != ''){
				if('${ptnrVo.ptnr_sms1}' == 0){
					$("input:checkbox[name='ptnr_sms1']").prop("checked", false);				
				}else if('${ptnrVo.ptnr_sms1}' == 1){
					$("input:checkbox[name='ptnr_sms1']").prop("checked", true);
				}
			}
			
			/* 문자 발송 설정 : 조사자*/
			if('${ptnrVo.ptnr_sms2}' != ''){
				if('${ptnrVo.ptnr_sms2}' == 0){
					$("input:checkbox[name='ptnr_sms2']").prop("checked", false);				
				}else if('${ptnrVo.ptnr_sms2}' == 1){
					$("input:checkbox[name='ptnr_sms2']").prop("checked", true);
				}
			}
			
			/* 문자 발송 설정 : 피보험자*/
			if('${ptnrVo.ptnr_sms3}' != ''){
				if('${ptnrVo.ptnr_sms3}' == 0){
					$("input:checkbox[name='ptnr_sms3']").prop("checked", false);				
				}else if('${ptnrVo.ptnr_sms3}' == 1){
					$("input:checkbox[name='ptnr_sms3']").prop("checked", true);
				}
			}
			
			
			/* 업데이트 동작 */
			$("#btnOk").click(function(){
				$.post("./ptnrUdt",
						{	ptnr_id:$("#ptnr_id").val()
							,statistics_yn:$("input:radio[name='statistics_yn']:checked").val()
							,statistics_written_yn:$("input:radio[name='statistics_written_yn']:checked").val()
							,ptnr_type:$("input:radio[name='ptnr_type']:checked").val()
							,ptnr_nick:$("#ptnr_nick").val()
							,ptnr_name:$("#ptnr_name").val()
							,ptnr_biz_reg_no:$("#ptnr_biz_reg_no").val()
							,ptnr_ceo_nm:$("#ptnr_ceo_nm").val()
							,ptnr_biz_type1:$("#ptnr_biz_type1").val()
							,ptnr_biz_type2:$("#ptnr_biz_type2").val()
							,ptnr_tel:$("#ptnr_tel").val()
							,ptnr_addr:$("#ptnr_addr").val()
							,ptnr_postcode:$("#ptnr_postcode").val()
							,ptnr_addr1:$("#ptnr_addr1").val()
							,ptnr_homepage:$("#ptnr_homepage").val()  
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
								alert("보험사 정보 변경이 완료 되었습니다.");
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
			
			/* 계약적부 초기 값 세팅 */
			if('${ptnrVo.suitability_yn}' == 0){
				$("input:checkbox[name='suitability_yn']").prop("checked", false);
				$("#suitability_fee1").css("background-color","gray");
				$("#suitability_fee2").css("background-color","gray");
				$("#suitability_fee1").val('');
				$("#suitability_fee2").val('');
			}
			
			
			/* 계약적부  수수료 비활성화 */
			$("#suitability_yn").click(function(){
				
				if($("#suitability_yn").is(':checked')){
					$("#suitability_fee1").prop("disabled",false);
					$("#suitability_fee2").prop("disabled",false);
					$("#suitability_fee1").css("background-color","#FFFFFF");
					$("#suitability_fee2").css("background-color","#FFFFFF");
					$("#suitability_fee1").focus();
				}else{
					$("#suitability_fee1").prop("disabled",true);
					$("#suitability_fee2").prop("disabled",true);
					$("#suitability_fee1").css("background-color","gray");
					$("#suitability_fee2").css("background-color","gray");
					$("#suitability_fee1").val('');
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
	</script>
</head>

<body>

<!-- wrapper -->
<div id="wrapper">
	<!-- skipnavi --><!-- header -->
	<c:import url="../top_main/top_sysadm_menu.jsp"></c:import>
	<!-- //skipnavi --><!-- //header -->

	<!-- contents -->
	<div id="container">
		<div class="contetns">

			<!-- left_cnt -->
			<c:import url="../top_main/top_sysadm_left.jsp"></c:import>
			<!-- //left_cnt -->

			<!-- centercnt_top -->
			<div class="center_cnt">

				<!-- centercnt_bot -->
				<div class="centercnt_bot1-2">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">보험사 정보 수정</a></li>
							</ul>
						</div>
						<div class="guestcnt4" style="display:block;">
							<div class= "tableStyle2" >
								<form action="" name = "textContentsForm">
								<input type="hidden" id = "ptnr_id" name = "ptnr_id" value = "${ptnrVo.ptnr_id}"/>
									<table>
										<thead>
											<tr>
												<th width="15%">목록</th>
												<th width="85%">내용</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>통계적용</td>
												<td style = "text-align:left; padding-left:5px;">
													<input type="radio" name = "statistics_yn" value = "1"/> On
													<input type="radio" name = "statistics_yn" value = "0"/> Off
												</td>
											</tr> 
											<!-- //통계 -->
											
											<!-- //심사통계표시여부 -->
											<tr>
												<td>심사통계표시</td>
												<td style = "text-align:left; padding-left:5px;">
													<input type="radio" name = "statistics_written_yn" value = "1"/> On
													<input type="radio" name = "statistics_written_yn" value = "0"/> Off
												</td>
											</tr>
											
											<tr>
												<td>TYPE</td>
												<td style = "text-align:left; padding-left:5px;">
													<input type="radio" name = "ptnr_type" value = "1"/> 손해보험
													<input type="radio" name = "ptnr_type" value = "2"/> 생명보험
													<input type="radio" name = "ptnr_type" value = "3"/> 공제
													<input type="radio" name = "ptnr_type" value = "4"/> 협회
													<input type="radio" name = "ptnr_type" value = "5"/> 기타
												</td>
											</tr>
											<!-- //TYPE -->
											
											<tr>
												<td>사명(줄임)</td>
												<td style = "text-align:left; padding-left:5px;">
													<input type="text" id = "ptnr_nick" name = "ptnr_nick" value = "${ptnrVo.ptnr_nick}"/> 
												</td>
											</tr>
											<!-- //사명(줄임) -->
											
											<tr>
												<td>사명(정식)</td>
												<td style = "text-align:left; padding-left:5px;">
													<input type="text" id = "ptnr_name" name = "ptnr_name" size="70" value = "${ptnrVo.ptnr_name}"/> 
												</td>
											</tr>
											<!-- //사명(정식) -->
											
											<tr>
												<td>등록번호</td>
												<td style = "text-align:left; padding-left:5px;">
													<input type="text" id = "ptnr_biz_reg_no"name = "ptnr_biz_reg_no" value = "${ptnrVo.ptnr_biz_reg_no}"/>
													( 대표자 성명 : <input type="text" id = "ptnr_ceo_nm" name = "ptnr_ceo_nm" value = "${ptnrVo.ptnr_ceo_nm}"/>) 
												</td>
											</tr>
											<!-- //등록번호(대표자 성명) -->
											
											<tr>
												<td>업태</td>
												<td style = "text-align:left; padding-left:5px;">
													<input type="text" id = "ptnr_biz_type1" name = "ptnr_biz_type1" value = "${ptnrVo.ptnr_biz_type1}"/>
													( 종목 : <input type="text" id = "ptnr_biz_type2" name = "ptnr_biz_type2" value = "${ptnrVo.ptnr_biz_type2}"/>) 
												</td>
											</tr>
											<!-- //업태(종목) -->
											
											<tr>
												<td>전화</td>
												<td style = "text-align:left; padding-left:5px;">
													<input type="text" id = "ptnr_tel" name = "ptnr_tel" value = "${ptnrVo.ptnr_tel}"/>
												</td>
											</tr>
											<!-- //전화 -->
											
											<tr>
												<td>주소</td>
												<td style = "text-align:left; padding-left:5px;">
													<input type="text" name="ptnr_postcode" id="ptnr_postcode" size="10" value = "${ptnrVo.ptnr_postcode}" readonly style="background-color:lightgrey;" />
													<input type="button" id="postCodeBtn" value="우편번호 찾기">
													<input type="text" name="ptnr_addr1" id="ptnr_addr1"  value = "${ptnrVo.ptnr_addr1}" size="50" readonly style="background-color:lightgrey;" />
													<c:choose>
														<c:when test="${ptnrVo.ptnr_postcode eq '' }">
															<input type="text" name="ptnr_addr" id="ptnr_addr" value = "${ptnrVo.ptnr_addr2}" size="50" />
														</c:when>
														<c:otherwise>
															<input type="text" name="ptnr_addr" id="ptnr_addr" value = "${ptnrVo.ptnr_addr}"  size="50" />												
														</c:otherwise>
													</c:choose>
													
												</td>
											</tr>
											<!-- //주소 -->
											
											<tr>
												<td>PRM</td>
												<td style = "text-align:left; padding-left:5px;">
													<input type="text" id = "ptnr_url" name = "ptnr_url" size="50" value = "${ptnrVo.ptnr_url}"/>
												</td>
											</tr>
											<!-- //PRM -->
											
											<tr>
												<td>홈페이지</td>
												<td style = "text-align:left; padding-left:5px;">
													<input type="text" id = "ptnr_homepage" name = "ptnr_homepage" size="50" value = "${ptnrVo.ptnr_homepage}"/>
												</td>
											</tr>
											<!-- //홈페이지 -->
											
											<tr>
												<td>문자설정</td>
												<td style = "text-align:left; padding-left:5px;">
													<input type="checkbox" name = "ptnr_sms1"/> 보험사 :  <input type="text" size="100" id = "ptnr_sms1_msg" name = "ptnr_sms1_msg" value = "${ptnrVo.ptnr_sms1_msg }"/><br />
													<input type="checkbox" name = "ptnr_sms2"/> 조사자 :  <input type="text" size="100" id = "ptnr_sms2_msg" name = "ptnr_sms2_msg" value = "${ptnrVo.ptnr_sms2_msg }"/><br />
													<input type="checkbox" name = "ptnr_sms3"/> 피보험자 :  <input type="text" size="98" id = "ptnr_sms3_msg" name = "ptnr_sms3_msg" value = "${ptnrVo.ptnr_sms3_msg }"/><br />
													※ 문구설정 : ㆍ보험사<b>[ig]</b>ㆍ보험사담당자<b>[igm]</b>ㆍ조사자<b>[user]</b>ㆍ피보험자<b>[insured]</b>ㆍ계약자: <b>[client]</b>ㆍ사고번호: <b>[trouble]</b>
												</td>
											</tr>
											<!-- //문자설정 -->
											
											<tr>
												<td>세금계산서</td>
												<td style = "text-align:left; padding-left:5px;">
													<input type="radio" name = "issue_tax_invoice" value = "1"/> 발행
													<input type="radio" name = "issue_tax_invoice" value = "0"/> 미발행
												</td>
											</tr> 
											<!-- //세금계산서 -->
											
											<tr>
												<td>입금은행</td>
												<td style = "text-align:left; padding-left:5px;">
													<input type="radio" name = "top_accnt_id" value = "6"/> 하나
													<input type="radio" name = "top_accnt_id" value = "9"/> 농협
													<input type="radio" name = "top_accnt_id" value = "10"/> KB국민
													<input type="radio" name = "top_accnt_id" value = "7"/> 신용협동조합
													<input type="radio" name = "top_accnt_id" value = "8"/> 새마을금고
													<input type="radio" name = "top_accnt_id" value = "11"/> 수협
												</td>
											</tr>
											<!-- //입금은행 -->
											
											<tr >
												<td rowspan="2">계약적부</td>
												<td style = "text-align:left; padding-left:5px;">
													<input type="checkbox" id = "suitability_yn" name = "suitability_yn" /> 거래함
												</td>
											</tr>
											
											<tr >
												<td style = "text-align:left; padding-left:5px;">
													수수료 : <br />
													<b> ⊙  일반</b>: <input type="text" style="text-align:right;" id = "suitability_fee1" name="suitability_fee1" value = "${ptnrVo.suitability_fee1 }"/>원 <br />
													<b> ⊙ 공장</b>: <input type="text" style="text-align:right;" id = "suitability_fee2" name="suitability_fee2" value = "${ptnrVo.suitability_fee2 }"/>원
												</td>
											</tr>
											<!-- //계약적부 -->
											
											
										</tbody>
									</table>
										
								</form> <!-- //본문 form -->
								
								<table>
									<tbody>
										<tr >
											<td width="15%">로고 小</td>
											<td width="85%" style = "text-align:center; ">
												<c:import url="../include/uploadform_ptnr_small.jsp"></c:import>
												<img src="${ptnrVo.imgStream_s}" width="50" height="16" id = "sImg" alt="사진 미리보기" /> ${ptnrVo.ptnr_img_small}
											</td>
										</tr>
										<!-- //작은 사진 올리기 -->
									</tbody>
								</table>
								
									
								<table>
									<tbody>		
										<tr >
											<td width="15%">로고 大</td>
											<td width="85%" style = "text-align:center; ">
												<c:import url="../include/uploadform_ptnr_big.jsp"></c:import>
												<img src="${ptnrVo.imgStream_b}" width="200" height="72" id = "bImg" alt="사진 미리보기" /> ${ptnrVo.ptnr_img_big}
												
											</td>
										</tr>
										
										<tr>
											<td colspan="2" style ="border:0;">
												<img src="./resources/ls_img/btn_ok.gif" id ="btnOk" style = "cursor:pointer;" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												<img src="./resources/ls_img/btn_cancel.gif" id = "btnCancel"  style = "cursor:pointer;" />
											</td>
										</tr>
										<!-- 버튼 -->
									</tbody>
								</table>
								
								
							</div><!-- //tableStyle2 -->
							
							
							
						</div><!-- //guestcnt4 -->
						
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
