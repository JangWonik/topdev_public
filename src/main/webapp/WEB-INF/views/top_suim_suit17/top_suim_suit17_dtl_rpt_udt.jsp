<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
	<script src="./resources/ne_js/calendar.js"></script>
	<%--<script src="./resources/daum/161109.js"></script>--%>
	<script src="./resources/daum/postcode.v2.js"></script>
	<script src='https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js'></script>
	
</head>

<script>
	$(document).ready(function(){
		if ( "${getSuimSuit17DtlBsc.editYN2}" < 1 ){
			alert("접근 권한이 없습니다.");
			window.close();
			return false;
		}
		
		$.ajaxSetup({cache:false});
		$("#suimTmMbrPopBtn").click(function(){//담당 팀, 담당 직원 바꾸기 팝업
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=500; //띄울 창의 넓이
			var sh=550;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('suimTmMbrPop?gbNo='+$("#gbNoForPop").val()+'&smNo='+$("#smNoForPop").val()+'&tmNo='+$("#tmNoForPop").val(),'SuimTmMbrPop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		});//$("#suimTmMbrPopBtn").click

		$("#suimPtnrMbrPopBtn").click(function(){//담당 팀, 담당 직원 바꾸기 팝업
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=500; //띄울 창의 넓이
			var sh=550;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('suimPtnrMbrPop?gbNo='+$("#gbNoForPop").val()+'&smNo='+$("#smNoForPop").val()+'&ptnrNo='+$("#ptnrNoForPop").val(),'SuimTmMbrPop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		});//$("#suimPtnrMbrPopBtn").click

	});//$(document).ready

	function openSMS(hpNo){
		var cw=screen.availWidth;
		var ch=screen.availHeight;
		var sw=380; //띄울 창의 넓이
		var sh=533;  //띄울 창의 높이
		var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
		var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
		window.open('simpleSMSForm?hpNo='+hpNo,'simpleSMS','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
	}//openSMS

	function openBrdRefPtnr(ptnrSearch){
		var cw=screen.availWidth;
		var ch=screen.availHeight;
		var sw=1010; //띄울 창의 넓이
		var sh=740;  //띄울 창의 높이
		var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
		var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
		window.open('referencePtnrBoardListPop?ptnrSearch='+ptnrSearch,'simpleSMS','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
	}//openSMS
	
	function SuimSuit17RptFileDel(serialNo){
		if(confirm("보고서 원본 파일을 삭제하시겠습니까?")){
			$.post("./suimSuit17RptFileDel",
					{	
						serialNo 	:	serialNo  //						
					},
					function(data,status){
						if(status == "success"){
							if(data != 0){
								$("#suimSuit17RptFileOrgTr_"+serialNo).css("display","none");
								$("#suimSuit17DtlRptDelForm").submit();
							}else{
								alert("시스템 오류입니다. 잠시 후 재시도 해주세요.");	
							}
						}else{
							alert("시스템 오류입니다. 잠시 후 재시도 해주세요.");
						}
					}
				);
			}
		}
	
	$(document).ready(function(){
		
	/* 취소 버튼 동작 */
	$("#cancel").click(function(){
		history.back();
	});	
	/* 수정 확인 버튼 동작 */
	$("#edite").click(function(){
		
		$.post("./suimSuit17DtlRptUdtOK",
				{	
					suimRptNo       :$("#suimRptNo").val()  //
					,d18         	:$("#d18").val()  //
					,b2code			:$("#b2code").val()  //
					,d19         	:$("#d19").val()  //
					,d20         	:$("#d20").val()  //
					,reG         	:"${getSuimSuit17DtlBsc.reG}"  //건물급수 - 조사에서 수정하여 고정값
					,d1        		:$("#d1").val()  //건물급수에 대한 조사의견
					,d2        		:$("input:radio[name='d2']:checked").val()  // 
					,d3         	:$("#d3").val()  //
					,d4        		:$("input:radio[name='d4']:checked").val()  // 
					,d5         	:$("#d5").val()  //
					,d16         	:$("#d16").val()  //
					,d8         	:$("#d8").val()  //
					,d9         	:$("#d9").val()  //
					,d10         	:$("#d10").val()  //
					,d11         	:$("#d11").val()  //
					,d12         	:$("#d12").val()  //
					,d13         	:$("#d13").val()  //
					,d17         	:$("#d17").val()  //
					
				},
				function(data,status){
					if(status == "success"){
						if(data == 0){
							alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
						}else{
							alert("수정되었습니다.");
							location.href = "topSuimSuit17Dtl?suimRptNo="+$("#suimRptNo").val();
							window.opener.location.reload();
							//window.location.reload();
						}
					}else{
						alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
					}
				}//function
		);//post
	});
	});//$(document).ready
	
	
</script>

<!-- 파일 다운로드 후 새로고침용 form -->
<form id="suimSuit17DtlRptDelForm" action="suimSuit17DtlRptUdt" method="POST" id="fileDelsubmit">
	<input type="hidden" name="suimRptNo" value="${suimRptNo}" />
</form>

<c:set var="suimRptNo" value="${suimRptNo}"/>
<body>

	<!-- header -->
	<div id="headerpop_mbr">
		<div class="inner clear_v2">
			<h1>
				<img src="./resources/wm_img/common/logo.gif" height="40" alt="top - TRUST OBLIGATION PASSION" />
			</h1>
			<div style="text-align:center;padding-top:10px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
				<font color="white"><b><span style="font-size:11pt;"> 장기 물보험 적부 시스템</span></b></font>
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
								<li class="on"><a href="#">적부(흥국) 기본정보</a></li>
							</ul>
						</div>

						<div class="guestcnt5" style="display:block;">
						<b>1. 계약사항</b>
						<div class= "tableStyle4">
							<table>
								<colgroup>
									<col width="5%">
									<col width="35%">
									<col width="30%">
									<col width="30%">
								</colgroup>
								<tr>
									<td bgcolor="#E7ECF1" align="center"><b>구분</b></td>
									<td bgcolor="#E7ECF1" colspan="3" align="center"><b>계약사항</b></td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1" align="center">계약자명</td>
									<td colspan="3">${getSuimSuit17DtlBsc.policyholderNm}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1" align="center">소유자명</td>
									<td colspan="3">${getSuimSuit17DtlBsc.infoAd}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1" align="center">소재지</td>
									<td colspan="3">${getSuimSuit17DtlBsc.infoAb}&nbsp;&nbsp;${getSuimSuit17DtlBsc.infoAc}</td>
								</tr>
							</table>
						</div>
						<br>
						<b>2. 실사사항</b>
						<div class= "tableStyle4">
							<table>
								<colgroup>
									<col width="15%">
									<col width="50%">
									<col width="15%">
									<col width="20%">
								</colgroup>
								<tr>
									<td bgcolor="#E7ECF1" align="center"><b>구분</b></td>
									<td bgcolor="#E7ECF1" colspan="3" align="center"><b>내용</b></td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1" align="center">실사일시</td>
									<td>${getSuimSuit17DtlBsc.reC}</td>
									<td bgcolor="#E7ECF1" align="center">실사자</td>
									<td>${getSuimSuit17DtlBsc.userName}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1" align="center">면담자(관계)</td>
									<td>
										<input type="text" id="d18" name="d18" style="width:60%"value="${getSuimSuit17DtlBsc.d18}"/>
										(
										<select id="b2code" name="b2code">
											<c:forEach items="${b2CodeList}" var = "b2CodeVo">
											<option value="${b2CodeVo.col_cd}"
												<c:if test="${getSuimSuit17DtlBsc.b2code == b2CodeVo.col_cd}">selected</c:if>>
											${b2CodeVo.col_val}
											</option>
											</c:forEach>
										</select>
										)
										
									</td>
									<td bgcolor="#E7ECF1" align="center">면담자 연락처</td>
									<td><input type="text" id="d19" name="d19" value="${getSuimSuit17DtlBsc.d19}"/></td>
								</tr>
							</table>
						</div>
						<br>
						<b>3. 계약사항과 실사사항 비교</b>
						<div class= "tableStyle4">
							<table>
								<colgroup>
									<col width="15%">
									<col width="60%">
									<col width="15%">
									<col width="10%">
								</colgroup>
								<tr>
									<td bgcolor="#E7ECF1" align="center"><b>구분</b></td>
									<td bgcolor="#E7ECF1" align="center"><b>계약사항</b></td>
									<td bgcolor="#E7ECF1" align="center"><b>확인사항</b></td>
									<td bgcolor="#E7ECF1" align="center"><b>일치여부</b></td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1" align="center">건물급수</td>
									<td>${getSuimSuit17DtlBsc.infoN}</td>
									<td>${getSuimSuit17DtlBsc.reG}급</td>
									<td>${getSuimSuit17DtlBsc.reH}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1" align="center">실제업종</td>
									<td>${getSuimSuit17DtlBsc.infoO}</td>
									<td>${getSuimSuit17DtlBsc.reI}</td>
									<td>${getSuimSuit17DtlBsc.reJ}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1" align="center">요율업종</td>
									<td>${getSuimSuit17DtlBsc.infoP}</td>
									<td>${getSuimSuit17DtlBsc.reK}</td>
									<td>${getSuimSuit17DtlBsc.reL}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1" align="center">소재지</td>
									<td>${getSuimSuit17DtlBsc.infoAb}<br>${getSuimSuit17DtlBsc.infoAc}</td>
									<td>${getSuimSuit17DtlBsc.reAc}</td>
									<td>${getSuimSuit17DtlBsc.reP}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1" align="center">피보험자(소유자)</td>
									<td>${getSuimSuit17DtlBsc.infoAd}</td>
									<td>${getSuimSuit17DtlBsc.reQ}</td>
									<td>${getSuimSuit17DtlBsc.reR}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1" align="center">중점요청사항</td>
									<td>${getSuimSuit17DtlBsc.infoAe}</td>
									<td><input type="text" id="d20" name="d20" value="${getSuimSuit17DtlBsc.d20}"/></td>
									<td>${getSuimSuit17DtlBsc.reT}</td>
								</tr>
							</table>
						</div>
						<br>
						<b>4. 조사의견</b>
						<div class= "tableStyle4">
							<table>
								<colgroup>
									<col width="5%">
									<col width="7%">
									<col width="43%">
									<col width="45%">
								</colgroup>
								<tr>
									<td bgcolor="#E7ECF1" colspan="2" align="center"><b>구분</b></td>
									<td bgcolor="#E7ECF1" colspan="2" align="center"><b>조사의견</b></td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1" rowspan="3" align="center">구조</td>
									<td bgcolor="#E7ECF1" align="center">건물구조</td>
									<td colspan="2">
									${getSuimSuit17DtlBsc.reG}급(<input type="text" id="d1" name="d1" style="width:80%" value="${getSuimSuit17DtlBsc.d1}"/>)<br>
									판넬사용여부(
									<input type="radio" id="d2" name="d2" value="1" <c:if test="${getSuimSuit17DtlBsc.d2 eq '1'}">checked="checked"</c:if>  />유
									<input type="radio" id="d2" name="d2" value=""  <c:if test="${getSuimSuit17DtlBsc.d2 ne '1'}">checked="checked"</c:if> />무
									/&nbsp;위치&nbsp;:&nbsp;<input type="text" id="d3" name="d3" style="width:60%" value="${getSuimSuit17DtlBsc.d3}"/>
									)<br>
									천막사용여부(
									<input type="radio" id="d4" name="d4" value="1" <c:if test="${getSuimSuit17DtlBsc.d4 eq '1'}">checked="checked"</c:if> />유
									<input type="radio" id="d4" name="d4" value=""  <c:if test="${getSuimSuit17DtlBsc.d4 ne '1'}">checked="checked"</c:if> />무
									/&nbsp;위치&nbsp;:&nbsp;<input type="text" id="d5" name="d5" style="width:60%" value="${getSuimSuit17DtlBsc.d5}"/>
									)
									</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1" align="center">방화구획</td>
									<td colspan="2">
										<c:if test="${getSuimSuit17DtlBsc.reV eq 'Y'}">■ 구획&nbsp; □ 미구획</c:if>
										<c:if test="${getSuimSuit17DtlBsc.reV eq 'N'}">□ 구획&nbsp; ■ 미구획</c:if>
										<c:if test="${(getSuimSuit17DtlBsc.reV eq 'Y') && (getSuimSuit17DtlBsc.reV eq 'N')}">□ 구획&nbsp; □ 미구획</c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1" align="center">확인의견</td>
									<td colspan="2">${getSuimSuit17DtlBsc.reW}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1" rowspan="2" align="center">업종</td>
									<td bgcolor="#E7ECF1" align="center">층별업종</td>
									<td colspan="2">
									지층&nbsp;:&nbsp;<input type="text" id="d16" name="d16" style="width:90%" value="${getSuimSuit17DtlBsc.d16}"/><br>
									1층&nbsp;:&nbsp;<input type="text" id="d8" name="d8" style="width:90%" value="${getSuimSuit17DtlBsc.d8}"/><br>
									2층&nbsp;:&nbsp;<input type="text" id="d9" name="d9" style="width:90%" value="${getSuimSuit17DtlBsc.d9}"/><br>
									3층&nbsp;:&nbsp;<input type="text" id="d10" name="d10" style="width:90%" value="${getSuimSuit17DtlBsc.d10}"/><br>
									4층&nbsp;:&nbsp;<input type="text" id="d11" name="d11" style="width:90%" value="${getSuimSuit17DtlBsc.d11}"/><br>
									5층&nbsp;:&nbsp;<input type="text" id="d12" name="d12" style="width:90%" value="${getSuimSuit17DtlBsc.d12}"/><br>
									5층이상&nbsp;:&nbsp;<input type="text" id="d13" name="d13" style="width:90%" value="${getSuimSuit17DtlBsc.d13}"/>
									</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1" align="center">확인의견</td>
									<td colspan="2">${getSuimSuit17DtlBsc.reK}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1" colspan="2" align="center">소재지 확인의견</td>
									<td colspan="2">${getSuimSuit17DtlBsc.reAc}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1" colspan="2" align="center">기타 특이사항</td>
									<td colspan="2">
										<input type="text" id="d17" name="d17" style="width:90%" value="${getSuimSuit17DtlBsc.d17}"/>
										<input type="hidden" id="suimRptNo" name="suimRptNo" value="${getSuimSuit17DtlBsc.suimRptNo}"/>
									</td>
								</tr>
							</table>
						</div>
						<br>
						<b>5. 실사 사진 </b>
						<div class= "tableStyle4">
							<table align="center" cellpadding="0" cellspacing="0" class="suitRptTable">
								<tr>
									<td width="30%" align="center">
										<b>※ 파일 선택</b>
									</td>
									<td>
										<%@include file="../include/uploadform_suimSuit17RptFile.jsp"%>
									</td>
								</tr>
							</table>
							<table  align="center" cellpadding="0" cellspacing="0" class="suitRptTable">
								<colgroup>
									<col width="70%">
									<col width="30%">
								</colgroup>
								<tr>
									<td colspan="2" align="center"><font color="blue">사진 목록</font></td>
								</tr>
								<input type="hidden" id="fileListSize" value="${fileListSize}" />		
								<tbody id = "suit17FileListBody" style="margin-bottom:20px;">
									<c:forEach items="${suimSuit17FileList}" var="suit17FileVo">
										<tr id = "suit17ImgTr_${suit17FileVo.serialNo}">
											<td align="center" class="suit17Preview"> 
												${suit17FileVo.fileName}
											</td>
											<td align="center">
	 											<img src='./resources/ls_img/btn_del.gif' id = 'suit17ImgDelBtn_${suit17FileVo.serialNo}' 
	 												onclick="suit17ImgSubDel('${suit17FileVo.serialNo}','${suit17FileVo.suimRptNo}','${suit17FileVo.fileName}');" style='cursor:pointer;'/>
											</td>
										</tr>
									</c:forEach>												
								</tbody>
							</table>
						</div>
						
						<!-- 
						<div class= "tableStyle4">
						
							<table align="center" style="margin-top:10px;">
								<colgroup>
									<col width="60%">
									<col width="40%">
								</colgroup>
								<thead>
									<tr>
										<td colspan="4" align="center">
											<b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;" /> 실사 사진</b>
										</td>
									</tr>
									<tr>
										<th>파일명</th>
										<th>등록일</th>
									</tr>
								</thead>
								<tbody align="center" id = "rptOrgFileList">
									<input type="hidden" id="fileListSize" value="${fileListSize}"/>
									<c:forEach items="${suimSuit17FileList}" var="orgFileVo">
										<tr id = "rptFileOrgTr_${orgFileVo.serialNo}">
											<td>
												<c:choose>
													<c:when test="${getSuimSuit17DtlBsc.editYN2 > 0}">
														<a href="suimSuit17RptFileDownload?key=${orgFileVo.serialNo}&type=rptOrigin&suimRptNo=${getSuimSuit17DtlBsc.suimRptNo}">
								        				   <font color="blue"> ${orgFileVo.fileName} </font>
								  					    </a>
													</c:when>
													<c:otherwise>
														${orgFileVo.fileName}
													</c:otherwise>
												</c:choose>
											</td>
											<td>
												${orgFileVo.regDate}
												<c:if test="${getSuimSuit17DtlBsc.suimRptState eq '0' and getSuimSuit17DtlBsc.editYN2 > 0}">
													<img src='./resources/ls_img/btn_del_s.gif' onclick="SuimSuit17RptFileDel('${orgFileVo.serialNo}');" style='cursor:pointer; margin-left:5px;'/>
												</c:if>
											</td>
										</tr>
									</c:forEach>
								</tbody>
								<tr>
									<td colspan="2" align="center">
									<c:choose>
										<c:when test="${getSuimSuit17DtlBsc.suimRptState eq '0' and getSuimSuit17DtlBsc.editYN2 > 0}">
										</c:when>
										<c:otherwise>
											<font color="red">
												※ 담당건이 아니거나 상신 이후에는 원본 파일 업로드를 할 수 없습니다.
											</font>
										</c:otherwise>
									</c:choose>
									</td>
								</tr>
									
							</table>
						</div>
						
						-->
						
						<br>
						<p align="center">
							<img id="edite" src="./resources/ls_img/btn_ok.gif" alt="저장" style ="cursor:pointer" />
							<img id="cancel" src="./resources/ls_img/btn_cancel.gif" alt="취소" style ="cursor:pointer" />
						</p>
						</div><!-- //guestcnt5 -->

					</div><!-- //guest -->
				</div><!-- //bot1-3 -->
			</div><!-- //center_cnt -->
		</div><!-- //contetnsPop -->
	</div>
	<!--//center -->

	<!-- footer -->
	<c:import url="../top_main/top_pop_footer.jsp"></c:import>
	<!-- //footer -->

</body>

</html>
