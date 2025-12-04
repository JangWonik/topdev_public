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
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<%--<script src="./resources/daum/161109.js"></script>--%>
	<script src="./resources/daum/postcode.v2.js"></script>
	<script src='https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js'></script>
	
	<script>
		$(document).ready(function(){
			if('${mbrAuthVo_Session.user_no}' == null || '${mbrAuthVo_Session.mbr_pms_9}' == 0){
				window.opener.location.assign("./logout");
				window.self.close();
			}
		});//ready
	</script>
	<script>
	$(document).ready(function(){

		$.ajaxSetup({cache:false});

		$("#popptnrsave").click(function(){
			/* if($("#ptnr_dept_id").val() == '0'){
				alert("부서명을 선택하세요.");
				$("#ptnr_dept_id").focus();
				return;
			} */
			if($("#ptnr_mbr_work_type").val().trim() == ''){
				alert("종 구분을 선택하세요.");
				$("#ptnr_mbr_work_type").focus();
				return;
			}
			if($("#ptnr_mbr_nm").val().trim() == ''){
				alert("이름을 입력하세요.");
				$("#ptnr_mbr_nm").focus();
				return;
			}

			var ptnrId = $("#ptnr_id").val();
			
			$.post("./popPtnrAddOK",
					{	 ptnr_mbr_no            :$("#ptnr_mbr_no").val()
						,ptnr_id        		:ptnrId
						,ptnr_dept_id           :$("#ptnr_dept_id").val()	//dept_id
						,ptnr_dept_nm			:$("#ptnr_dept_id option:selected").text().trim() //detp_nm
						,ptnr_tm_nm       		:$("#ptnr_tm_nm").val()	//tm_nm
						,ptnr_mbr_nm    		:$("#ptnr_mbr_nm").val()
						,ptnr_mbr_work_type     :$(":input:radio[name=ptnr_mbr_work_type]:checked").val()
						,ptnr_mbr_position_nm   :$("#ptnr_mbr_position_nm").val()
						,ptnr_mbr_job_memo      :$("#ptnr_mbr_job_memo").val()
						,ptnr_mbr_hp        	:$("#ptnr_mbr_hp").val()
						,ptnr_mbr_office_tel    :$("#ptnr_mbr_office_tel").val()
						,ptnr_mbr_office_fax    :$("#ptnr_mbr_office_fax").val()
						,ptnr_mbr_office_email  :$("#ptnr_mbr_office_email").val()
						,ptnr_mbr_office_postcode   :$("#ptnr_mbr_office_postcode").val()
						,ptnr_mbr_office_addr1   :$("#ptnr_mbr_office_addr1").val()
						,ptnr_mbr_office_addr2   :$("#ptnr_mbr_office_addr2").val()
						,ptnr_mbr_work_memo   	:$("#ptnr_mbr_work_memo").val()
						,ptnr_tax_nm   	:$("#ptnr_tax_nm").val()
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("저장 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{
								alert("저장되었습니다.");
								window.opener.location.assign("./topPtnrDTL?ptnr_id="+ptnrId);
								window.self.close();
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}//function
			);//post

		});//$("#popptnrsave").click

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
					$("#ptnr_mbr_office_postcode").val(data.zonecode);
					$("#ptnr_mbr_office_addr1").val(data.roadAddress);
				}
			}).open();
		});//$("#postCodeBtn").click

	});//ready
	</script>
</head>
<c:set value="${ptnrList}" var="ptnrList"/>
<body>
	<!-- header --><!--2016.01.14.rjh.수정.교체.-->
	<div id="headerpop_mbr">
		<div class="inner clear_v2">
			<h1>
				<img src="./resources/wm_img/common/logo.gif" height="40" alt="top - TRUST OBLIGATION PASSION" />
			</h1>
			<div style="text-align:center;padding-top:10px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
				<font color="white"><b><span style="font-size:11pt;"> 관련업체 직원정보 관리</span></b></font>
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
								<li class="on"><a href="#">관련업체 직원정보 관리</a></li>
								
							</ul>
						</div>

						<!-- 관련업체 멤버 정보 컨텐츠 탭 -->
						<div class="guestcnt5" style="display:block;">

						<div class= "tableStyle2">
							<table cellpadding="0" cellspacing="0" width="100%">
									<tr>
										<th width="40%" class = "tdHead" bgcolor="#efefef">목록</th>
										<th width="60%" class = "tdHead" style="margin-left:10px;" bgcolor="#efefef">내용</th>
									</tr>
									
									<tr>
										<td  width="100" class = "tdHead">회사명</td>
										<td style="text-align:left;padding-left:10px">
											<c:out value="${ptnrInfo.ptnr_name}"/>
										</td>
									</tr>
									<tr>
										<td  width="100" class = "tdHead">부서</td>
										<td style="text-align:left;padding-left:10px">
											<select id="ptnr_dept_id">
												<option value="0" selected>없음</option>
												<c:forEach items="${ptnrDeptList}" var = "ptnrDeptVo">
													<option value="${ptnrDeptVo.ptnr_dept_id}">
													${ptnrDeptVo.ptnr_dept_nm}
													</option>
												</c:forEach>
											</select>
										</td>
									</tr>
									<tr>
										<td class = "tdHead">팀</td>
										<td style="text-align:left;padding-left:10px">
											<input type="text" name="ptnr_tm_nm" id="ptnr_tm_nm"/>
										</td>
									</tr>
									<tr>
										<td class = "tdHead">이름</td>
										<td style="text-align:left;padding-left:10px">
											<input type="text" name="ptnr_mbr_nm" id="ptnr_mbr_nm"/>
											&nbsp;
											<input type="radio" name="ptnr_mbr_work_type" id="ptnr_mbr_work_type" value="1" checked />1종
											&nbsp;
											<input type="radio" name="ptnr_mbr_work_type" id="ptnr_mbr_work_type" value="4" />4종
											&nbsp;
											<input type="radio" name="ptnr_mbr_work_type" id="ptnr_mbr_work_type" value="0" />1,4종 겸직
										</td>
									</tr>
									<tr>
										<td class = "tdHead">직위</td>
										<td style="text-align:left;padding-left:10px">
											<input type="text" name="ptnr_mbr_position_nm" id="ptnr_mbr_position_nm"/>
										</td>
									</tr>
									<tr>
										<td class = "tdHead">직책</td>
										<td style="text-align:left;padding-left:10px">
											<input type="text" name="ptnr_mbr_job_memo" id="ptnr_mbr_job_memo"/>
										</td>
									</tr>
									<tr>
										<td class = "tdHead">휴대전화</td>
										<td style="text-align:left;padding-left:10px">
											<input type="text" name="ptnr_mbr_hp" id="ptnr_mbr_hp"/>
										</td>
									</tr>
									<tr>
										<td class = "tdHead">직통전화</td>
										<td style="text-align:left;padding-left:10px">
											<input type="text" name="ptnr_mbr_office_tel" id="ptnr_mbr_office_tel"/>
										</td>
									</tr>
									<tr>
										<td class = "tdHead">팩스</td>
										<td style="text-align:left;padding-left:10px">
											<input type="text" name="ptnr_mbr_office_fax" id="ptnr_mbr_office_fax"/>
										</td>
									</tr>
									<tr>
										<td class = "tdHead">E-mail</td>
										<td style="text-align:left;padding-left:10px">
											<input type="text" name="ptnr_mbr_office_email" id="ptnr_mbr_office_email"/>
										</td>
									</tr>
									<tr>
										<td class = "tdHead">주소</td>
										<td style="text-align:left;padding-left:10px">
											<input type="text" name="ptnr_mbr_office_postcode" id="ptnr_mbr_office_postcode" size="10" readonly style="background-color:lightgrey;" />
											<input type="button" id="postCodeBtn" value="우편번호 찾기">
											<input type="text" name="ptnr_mbr_office_addr1" id="ptnr_mbr_office_addr1" size="30" readonly style="background-color:lightgrey;" />
											<input type="text" name="ptnr_mbr_office_addr2" id="ptnr_mbr_office_addr2" size="30" />
										</td>
									</tr>
									<tr>
										<td class = "tdHead">기타</td>
										<td style="text-align:left;padding-left:10px">
											<input type="text" name="ptnr_mbr_work_memo" id="ptnr_mbr_work_memo" size="50" />
											<input type="hidden" name="ptnr_id" id="ptnr_id" value="${ptnrInfo.ptnr_id}"/>
										</td>
									</tr>
									<tr>
										<td class = "tdHead">세금계산서 담당자</td>
										<td style="text-align:left;padding-left:10px">
											<input type="text" name="ptnr_tax_nm" id="ptnr_tax_nm"/>											
										</td>
									</tr>
							</table>
						</div>
						<br>
						<p align="center">
							<img id="popptnrsave" src="./resources/ls_img/icon_write.gif" alt="저장" style ="cursor:pointer" />
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
