<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
		
	<script>
		$(document).ready(function(){
			if('${authFlag}' == 'logout'){
				alert("로그아웃 상태입니다. 재로그인 하십시오.");
				window.close();
				window.location.assign("./logout");
			}
		});
	</script>
	
	<script>
		function fnRptCancelDirectApproval(gubun,suimRptNo,serialNo){
			var r = confirm("해당 건을 위임취소 하시겠습니까?");
			if (!r){
				return false;	
			}
			
			if (gubun == 1){
				$("#rptCancelSuimRptNo").val(suimRptNo);
			}else{
				$("#rptCancelPrimRptNo").val(suimRptNo);
			}
			
			$("#processChk").val(gubun);				
			$("#rptCancelSerialNo").val(serialNo);
			
			$("#rptCancelForm").attr("action","approvRptCancel");
			$("#rptCancelForm").submit();
		}	
	
		function fnRptCancelDirectReturn(gubun,suimRptNo,serialNo){
			var r = confirm("해당 건을 반려 하시겠습니까?");
			if (!r){
				return false;	
			}
			
			if (gubun == 1){
				$("#rptCancelSuimRptNo").val(suimRptNo);
			}else{
				$("#rptCancelPrimRptNo").val(suimRptNo);
			}
			
			$("#processChk").val(gubun);				
			$("#rptCancelSerialNo").val(serialNo);
			
			$("#rptCancelForm").attr("action","returnRptCancel");
			$("#rptCancelForm").submit();
		}			
		
		function popSuimDtl(suim_rpt_no){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1010; //띄울 창의 넓이
			//var sh=screen.availHeight;  //띄울 창의 높이
			var sh=780;  //띄울 창의 높이(고정값으로 변경)
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('suimRptBscDtl?suim_rpt_no='+suim_rpt_no,suim_rpt_no,'width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=yes,scrollbars=yes');
		}
		
		
		function popPrimBizDtl(suim_rpt_no){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1010; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('primBizRptDtl?suim_rpt_no='+suim_rpt_no,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}
		
		
		function windowSet(win) { 
	        var winBody = win.document.body;
	        var wid = winBody.scrollWidth + 16;
	        var hei = winBody.clientHeight + 70;
	        
	        win.resizeTo(wid, hei);
	    }
	</script>
	<style>
		.center_cnt_1300_bot {height:100%;overflow:auto;}
		.guest .guestcnt4 {height:100%;display:block;margin-top:10px;padding:0 0 10px 0;overflow:auto;}
	</style>
</head>

<body OnLoad="windowSet(this)">

<!-- wrapper -->
<div id="wrapper">

	<!-- contents -->
	<div id="container">
		<div class="contetns">

			<!-- centercnt_top -->
			<div class="center_cnt_1300">

				<!-- centercnt_bot -->
				<div class="center_cnt_1300_bot">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on">
									<a href="#">
										위임취소 요청
									</a>
								</li>
							</ul>
						</div>
						<div class="guestcnt4" style="display:block;">
							<div class= "tableStyle2">
								<table>
									<colgroup>
										<col width="5%" /> 
									</colgroup>
									<thead>
										<tr>
											<th>no.</th>
											<th>구분</th>
											<th>접수번호</th>
											<th>보험사</th>
											<th>보험팀</th>
											<th>보험담당</th>
											<th>처리팀</th>
											<th>담당자</th>
											<th>종결일</th>
											<th>입금일</th>
											<th>결재</th>
										</tr>
									</thead>
									<tbody>
										<!-- 일반 수임 -->
										<c:forEach items="${suimRptCancelApprovList}" var="cancelList" varStatus="cancelListStatus">
											<tr>
												<td rowspan="2">${cancelListStatus.count}</td>
												<td>${cancelList.suim_rpt_type1_nm}</td>
												<td style ="cursor:pointer;" onclick="popSuimDtl('${cancelList.suim_rpt_no}')">${cancelList.suim_accept_no}</td>
												<td>${cancelList.ptnr_nick}</td>
												<td>${cancelList.ptnr_dept_nm}</td>
												<td>${cancelList.ptnr_mbr_nm}</td>
												<td>${cancelList.team_name}</td>
												<td>${cancelList.user_name}</td>
												<td>${cancelList.closeDate}</td>
												<td>${cancelList.depositDate}</td>
												<td>
													<img src="./resources/ne_img/btn/btn_aprv_cancel.gif" onclick="fnRptCancelDirectApproval('1',${cancelList.suim_rpt_no},${cancelList.serial_no});" style="cursor:pointer;"/>
													<br><img src="./resources/ne_img/btn/btn_return_cancel.gif" onclick="fnRptCancelDirectReturn('1',${cancelList.suim_rpt_no},${cancelList.serial_no});" style="cursor:pointer;margin-top:3px;"/>
													
												</td>
											</tr>
											<tr>
												<td colspan="10">
													<c:choose>
														<c:when test="${cancelList.cancelGubun eq '1'}"><b>[단순위임취소]</b><br/></c:when>
														<c:when test="${cancelList.cancelGubun eq '2'}"><b>[서면→일반전환건]</b><br/></c:when>
														<c:otherwise></c:otherwise>
													</c:choose>
													${cancelList.cancelReason}
												</td>
											</tr>										
										</c:forEach>
										
										<c:set var="listCnt" value="${suimRptCancelApprovList.size()}" />
										
										<!-- 농작물 -->
										<c:forEach items="${primRptCancelApprovList}" var="cancelList" varStatus="cancelListStatus">
											<tr>
												<td rowspan="2">${cancelListStatus.count + listCnt}</td>
												<td>${cancelList.suim_rpt_type1_nm}</td>
												<td style ="cursor:pointer;" onclick="popPrimBizDtl('${cancelList.suim_rpt_no}')">${cancelList.suim_accept_no}</td>
												<td>${cancelList.ptnr_nick}</td>
												<td>${cancelList.ptnr_dept_nm}</td>
												<td>${cancelList.ptnr_mbr_nm}</td>
												<td>${cancelList.team_name}</td>
												<td>${cancelList.user_name}</td>
												<td>${cancelList.closeDate}</td>
												<td>${cancelList.depositDate}</td>
												<td>
													<img src="./resources/ne_img/btn/btn_aprv_cancel.gif" onclick="fnRptCancelDirectApproval('2',${cancelList.suim_rpt_no},${cancelList.serial_no});" style="cursor:pointer;"/>
													<br><img src="./resources/ne_img/btn/btn_return_cancel.gif" onclick="fnRptCancelDirectReturn('2',${cancelList.suim_rpt_no},${cancelList.serial_no});" style="cursor:pointer; margin-top:3px;"/>
												</td>
											</tr>
											<tr>
												<td colspan="10">
													<c:choose>
														<c:when test="${cancelList.cancelGubun eq '1'}"><b>[단순위임취소]</b><br/></c:when>
														<c:when test="${cancelList.cancelGubun eq '2'}"><b>[서면→일반전환건]</b><br/></c:when>
														<c:otherwise></c:otherwise>
													</c:choose>
													${cancelList.cancelReason}
												</td>
											</tr>										
										</c:forEach>
										<!-- 손해보험 출력 끝 -->
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
							
							<!-- 위임취소 프로세스용 모달 -->
							<c:import url="../top_suim/suim_rpt_cancel_modal.jsp"></c:import>
							<!-- 위임취소 프로세스용 모달 끝-->

						</div><!-- //guestcnt4 -->

					</div>
				</div>
				<!-- //centercnt_bot -->

			</div>
			<!-- //center_cnt -->
		</div>
	</div>
	<!-- //contents -->

</div>
<!-- //wrapper -->

</body>
</html>
