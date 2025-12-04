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
	
	<script>
		$(document).ready(function(){

			$.ajaxSetup({cache:false});

			if(('${authFlag}' == 'fail') || '${primBizRptDtl.read_yn}' == 0){
				alert("열람권한이 없습니다.");
				window.close();
			}else if('${authFlag}' == 'logout'){
				alert("로그아웃 상태입니다. 재로그인 하십시오.");
				window.close();
				window.opener.location.assign("./logout");
			}

			if('${saveFlag}' == 'bsc'){
				alert("보고서 기본 정보 수정을 성공 하였습니다.");
			}else if('${saveFlag}' == 'inv'){
				alert("종결 및 인보이스 정보 수정을 성공 하였습니다.");
			}
		});//$(document).ready

		function primBizRptStateChange(reqMapNm){
			var actMsg;
			if(reqMapNm == 'primBizRptStateChgUnLock'){
				actMsg = "잠금해제를";
			}else if(reqMapNm == 'primBizRptStateChgSubmitX'){
				actMsg = "상신취소를";
			}else if(reqMapNm == 'primBizRptStateChgReturn'){
				actMsg = "반려를";
			}else if(reqMapNm == 'primBizRptStateChgReturnX'){
				actMsg = "재상신을";
			}else if(reqMapNm == 'primBizRptStateChgClose'){
				actMsg = "종결을";
			}else if(reqMapNm == 'primBizRptStateChgCloseX'){
				actMsg = "종결취소를";
			}else if(reqMapNm == 'primBizRptStateChgCancel'){
				actMsg = "위임취소를";
			}else if(reqMapNm == 'primBizRptStateChgCancelX'){
				actMsg = "재위임을";
			}else if(reqMapNm == 'primBizRptStateChgDel'){
				actMsg = "삭제를";
			}
			var tmp = window.confirm("보고서 "+actMsg+" 하시겠습니까?");
			if(tmp == false){
				return;
			}
			
			//종결 상태이면서 기본보수의 합계가 서로 상이할 경우 종결 X
			if( reqMapNm == 'primBizRptStateChgClose' && ($("#amtBasicSum").val() != "${primBizRptDtl.amt_basic}") ){
				alert("인보이스의 기본보수와 공동조사자 기본보수의 합계가 다릅니다.");
				return;
			}
			
			
			$.post(reqMapNm,
					{	suimRptNo:$("#suimRptNo").val()
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("보고서 "+actMsg+" 실패 하였습니다.");
							}else{
								alert("보고서 "+actMsg+" 성공 하였습니다.");
								window.opener.location.reload();
								if(reqMapNm == 'primBizRptStateChgDel'){
									window.self.close();
								}else{
									window.location.reload();
								}
							}//if(data.length == 0){
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}
			);//post
		}//primBizRptStateChange

		function primBizRptStateChange2(reqMapNm){
			var actMsg;
			if(reqMapNm == 'primBizRptStateChgSubmit'){
				actMsg = "상신을";
			}
			var tmp = window.confirm("보고서 "+actMsg+" 하시겠습니까?");
			if(tmp == false){
				return;
			}
			
// 			alert("기본료"+$("#amtBasicSum").val() + " : " + "${primBizRptDtl.amt_basic}");
// 			alert("일비"+$("#amtDailySum").val() + " : " + "${primBizRptDtl.amt_daily}");
// 			alert("기타"+$("#amtEtcSum").val() + " : " + "${primBizRptDtl.amt_etc}");
// 			alert("교통비"+$("#amtTrafficeSum").val() + " : " + "${primBizRptDtl.amt_traffic}");
// 			alert("자문료"+$("#amtCounselSum").val() + " : " + "${primBizRptDtl.amt_counsel}");
// 			alert("합계"+$("#amtTotalSum").val() + " : " + "${primBizRptDtl.amt_total}");
// 			alert("종결건수"+$("#amtEaSum").val() + " : " + "${primBizRptDtl.suim_rpt_ea}");

			if( $("#amtBasicSum").val() != "${primBizRptDtl.amt_basic}" ){
				alert("인보이스의 기본보수와 공동조사자 기본보수의 합계가 다릅니다.");
				return;
			}else if($("#amtDailySum").val() != "${primBizRptDtl.amt_daily}"){
				alert("인보이스의 일비와 공동조사자 일비의 합계가 다릅니다.");
				return;
			}else if($("#amtEtcSum").val() != "${primBizRptDtl.amt_etc}"){
				alert("인보이스의 기타와 공동조사자 기타의 합계가 다릅니다.");
				return;
				
			}else if($("#amtTrafficeSum").val() != "${primBizRptDtl.amt_traffic}"){
				alert("인보이스의 교통비와 공동조사자 교통비의 합계가 다릅니다.");
				return;
				
			}else if($("#amtCounselSum").val() != "${primBizRptDtl.amt_counsel}"){
				alert("인보이스의 자문료와 공동조사자 자문료의 합계가 다릅니다.");
				return;
				
			}else if($("#amtTotalSum").val() != "${primBizRptDtl.amt_total}"){
				alert("인보이스의 합계와와 공동조사자 합계 금액이 다릅니다.");
				return;
				
			}else if( parseFloat($("#amtEaSum").val()) != parseFloat("${primBizRptDtl.suim_rpt_ea}") ){//#amtEaSum이 소수값이 나옴
				alert("인보이스의 종결건수와 공동조사자 종결건수의 합계가 다릅니다.");
				return;
			}
			
			if ("${primBizRptDtl.workloadUseAt}" == 1){
				if( parseFloat($("#amtWorkloadEaSum").val()) != parseFloat("${primBizRptDtl.workloadEa}") ){//#amtEaSum이 소수값이 나옴
					alert("기준업무량 종결건수와\n공동조사자 기준업무량 종결건수의 합계가 서로 다릅니다.");
					return;
				}
			}
			
			$.post(reqMapNm,
					{	suimRptNo:$("#suimRptNo").val()
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("보고서 "+actMsg+" 실패 하였습니다.");
							}else if(data == 2){
								alert("인보이스와 공동조사자 내역이 상이합니다.");
							}else if(data == 9){
								alert("권한이 없습니다. 권한을 확인해 주세요.");
							}else{
								alert("보고서 "+actMsg+" 성공 하였습니다.");
								window.opener.location.reload();
								window.location.reload();
							}//if(data.length == 0){
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}
			);//post
		}//primBizRptStateChange
		
		function primBizRptSingleSubmit(){
			var confirmMsg = confirm("단독 조사 상신을 하시겠습니까?\n(현재 작성된 인보이스 기반으로 공동 조사자 등록을 합니다)");
			if ( !confirmMsg ){
				return;
			}
			
			if ( "${primBizRptDtl.amt_total}" == 0 ){
				alert("인보이스 합계가 0원 입니다.. ");
				return; 
			}else if ( "${primBizRptDtl.suim_rpt_ea}" == 0 ){
				alert("종결건수가 0건 입니다.. ");
				return;
			}else if ("${primBizRptDtl.workloadEa}" == ""){
				alert("기준업무량 종결건수를 입력 해 주세요..");
				return;
			}
			
			
			var param = {};
			param.rpt_invoice_no = $("#rpt_invoice_no").val(); 
			param.suim_rpt_no 	= $("#suim_rpt_no").val();
			
			param.share_amt_basic 		= "${primBizRptDtl.amt_basic}";
			param.share_amt_daily		= "${primBizRptDtl.amt_daily}";
			param.share_amt_etc			= "${primBizRptDtl.amt_etc}";
			param.share_amt_traffic		= "${primBizRptDtl.amt_traffic}";
			param.share_amt_counsel		= "${primBizRptDtl.amt_counsel}";
			param.amtTotal				= "${primBizRptDtl.amt_total}";
			param.share_ea				= "${primBizRptDtl.suim_rpt_ea}";
			param.share_workload_ea		= "${primBizRptDtl.workloadEa}";
			
			var url = "/primBizRptSingleSubmit";
			$.ajax({
				type: "POST",
				url: url,
				data: param,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				timeout: 20000,
				dataType: "json",
				success: function(data){
					if(data.result == 9001){
						alert("공동조사자 입력에 실패하였습니다.\n관리자에게 문의 해 주세요..");
						location.reload();
					}else if(data.result == 9002){
						alert("인보이스 내용과 공동조사자 입력 내용이 상이합니다.\n관리자에게 문의 해 주세요..");
						location.reload();
					}else if (data.result == 0000){
						alert("공동조사자 입력 및 상신이 완료되었습니다.");
						location.reload();
					}
				},
				error: function(e){
					alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
				}
			});
			
		}
		
	</script>
</head>

<body>

	<!-- header -->
	<div id="headerpop_mbr">
		<div class="inner clear_v2">
			<h1>
				<img src="./resources/wm_img/common/logo.gif" height="40" alt="top - TRUST OBLIGATION PASSION" />
			</h1>
			<div style="text-align:center;padding-top:10px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
				<font color="white"><b><span style="font-size:11pt;"> 수임건 정보</span></b></font>
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
								<li class="on" id="infoPrimBizRptTab"><a href="#">수임건 정보</a></li>
								<c:if test="${(primBizRptDtl.suim_rpt_state == 0 && primBizRptDtl.edit_yn > 0)
											or (primBizRptDtl.suim_rpt_state != 0 && primBizRptDtl.endModAuth > 0)}">
									<li id="editPrimBizRptBscTab"><a href="#">보고서 기본 정보 수정</a></li>
									<li id="editPrimBizRptInvTab"><a href="#">종결 및 인보이스 수정</a></li>
								</c:if>
							</ul>
						</div>

						<div class="guestcnt5" style="display:block;">
							<input type="hidden" id="suimRptNo" value="${primBizRptDtl.suim_rpt_no}"/>
							<input type="hidden" id="rpt_invoice_no" value="${primBizRptDtl.rpt_invoice_no}"/>
							<input type="hidden" id="suim_rpt_no" value="${primBizRptDtl.suim_rpt_no}"/>
							<c:import url="../top_prim_biz/prim_biz_rpt_dtl_bsc.jsp"></c:import>
							<br />
							<c:import url="../top_prim_biz/prim_biz_rpt_dtl_inv.jsp"></c:import>
							<br />
							<c:import url="../top_prim_biz/prim_biz_rpt_dtl_sha.jsp"></c:import>
							<br />
							<!-- memo -->
							<input type="hidden" id="targetStr" value="TopPrimBiz" />
							<input type="hidden" id="linkNo" value="${primBizRptDtl.suim_rpt_no}" />
							<c:import url="../util_memo/module_memo_1.jsp"></c:import>
							<!-- //memo -->
							<br />
							<c:import url="../top_prim_biz/prim_biz_rpt_dtl_file.jsp"></c:import>
						</div><!-- //guestcnt5 -->

						<c:if test="${(primBizRptDtl.suim_rpt_state == 0 && primBizRptDtl.edit_yn > 0)
									or (primBizRptDtl.suim_rpt_state != 0 && primBizRptDtl.endModAuth > 0)}">
							<div class="guestcnt5" style="display:none;">
								<c:import url="../top_prim_biz/prim_biz_rpt_dtl_bsc_udt.jsp"></c:import>
							</div><!-- //guestcnt5 -->
							<div class="guestcnt5" style="display:none;">
								<c:import url="../top_prim_biz/prim_biz_rpt_dtl_inv_udt.jsp"></c:import>
							</div><!-- //guestcnt5 -->
						</c:if>
						<c:import url="../top_suim/suim_rpt_cancel_modal.jsp"></c:import>
						
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
