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
</head>

<script type="text/javascript">

	$(document).ready(function(){
	
		$.ajaxSetup({cache:false});
	
		$("#lockallbtn").click(function(){
				
				$.post("./primBizLockUdtOK",
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("변경 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									alert("변경되었습니다.");
									///location.href = "primBizSuimDtl?suim_rpt_no="+$("#suim_rpt_no").val();
									//window.opener.location.reload();
									window.location.reload();
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}//function
				);//post
			});
			/***** 엑셀다운로드 *****/
		$("#btn_excel").click(function(){
			//$("#mbrNo").val($("#mbrNo1").val());
			//$("#mbrNm").val($("#mbrNm1").val());
			$("#excelForm").attr("action","primBizLockList_Excel");
			excelForm.submit();
		});
		
	});//$(document).ready

	


</script>

<body>

<!-- wrapper -->
<div id="wrapper">
	<!-- skipnavi --><!-- header -->
	<c:import url="../top_main/top_sysadm_menu.jsp"></c:import>
	<!-- //skipnavi --><!-- //header -->

	<!-- contents -->
	<div id="container">
		<div class="contetns">

			<!-- centercnt_top -->
			<div class="center_cnt_1300">

				<!-- centercnt_bot -->
				<div class="center_cnt_1300_bot">
					<div class="guest">

						<div style="text-align:right;">
							<!-- <input type="image" src="./resources/ls_img/btn_excel.gif" id="btn_excel"/> -->
							<input type="button" id="lockallbtn" name="lockallbtn" value="전체 lock 설정"/>
							<form action="primBizLockList_Excel" method="get" id="excelForm">
									<input type="hidden" id="primbizlock" name="primbizlock" />
							</form>
						</div>
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">농작물 lock 관리</a></li>
							</ul>
						</div>
						

						<div class="guestcnt4" style="display:block;">
							<c:import url="../sysadm_report/prim_biz_lock_list.jsp"></c:import>
						</div>

					</div>
				</div>
				<!-- //centercnt_bot -->

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
