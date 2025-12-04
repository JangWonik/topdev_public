<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	
	<script src="./resources/ne_js/calendar.js"></script>

	<script>
		$(document).ready(function(){
			if('${mbrAuthVo_Session.user_no}' == null || '${mbrAuthVo_Session.mbr_pms_7}' == 0){
				window.opener.location.assign("./logout");
				window.self.close();
			}
		});//ready
	</script>
	<c:set var="rpt_invoice_no" value="${invoiceDtl.getRpt_invoice_no()}"/>
	<script>
	$(document).ready(function(){

		$.ajaxSetup({cache:false});
		
		$("#invmemoeditsave").click(function(){
			
			
			$.post("./rptInvMemoUdtOK",
					{
						rpt_invoice_no				:$("#rpt_invoice_no").val()
						,rpt_invoice_memo   		:$("#rpt_invoice_memo").val()
						,suim_rpt_no	   			:$("#suim_rpt_no").val()
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("수정이 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{
								alert("수정되었습니다.");
								//window.opener.location.assign("./topPtnrDTL?rpt_invoice_no=${rpt_invoice_no}");
								window.self.close();
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}//function
					
			);//post

		});//$("#popptnrsave").click

		

	});//ready
	</script>
</head>
<c:set value="${ptnrMbr}" var="ptnrMbr"/>
<c:set value="${ptnrList}" var="ptnrList"/>
<body>
	<!-- header --><!--2016.01.14.rjh.수정.교체.-->
	<div id="headerpop_mbr">
		<div class="inner clear_v2">
			<h1>
				<img src="./resources/wm_img/common/logo.gif" height="40" alt="top - TRUST OBLIGATION PASSION" />
			</h1>
			<div style="text-align:center;padding-top:10px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
				<font color="white"><b><span style="font-size:11pt;"> INVOICE 수정 </span></b></font>
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
								<li class="on"><a href="#">조사 보고서</a></li>
							</ul>
						</div>
						
						<!-- 관련업체 멤버 정보 컨텐츠 탭 -->
						<div class="guestcnt5" style="display:block;">
						<c:set var="invoiceMemo" value="${invoiceMemo}"/>
						<div class= "tableStyle4">
							<table cellpadding="0" cellspacing="0">
									
									<tr>
				                        <th bgcolor="#F8F8F8" height="28">
				                            <p align="center"><font color="#003399">지점</font></p>
				                        </th>
				                        <th bgcolor="#F8F8F8">
				                            <p align="center"><font color="#003399">조사자</font></p>
				                        </th>
				                        <th bgcolor="#F8F8F8">
				                            <p align="center"><font color="#003399">합계 금액</font></p>
				                        </th>
				                    </tr>
				                    <tr>
				                    	<td align="center"><c:out value="${invoiceMemo.getTeam_id()}"/></td>
				                    	<td align="center"><c:out value="${invoiceMemo.getUser_name()}"/></td>
				                    	<td align="center"><fmt:formatNumber value="${invoiceMemo.getAmt_total()}" pattern="###,###,##0.##"/></td>
				                    </tr>
				                   
				                    <tr>
				                        <th bgcolor="#F8F8F8" height="28">
				                            <font color="#003399">보험사</font>
				                        </th>
				                        <th bgcolor="#F8F8F8" height="21">
				                            <font color="#003399">보험사담당자</font>
				                        </th>
				                        <th bgcolor="#F8F8F8" height="21">
				                            <font color="#003399">피보험자</font>
				                        </th>
				                    </tr>
				                    <tr>
				                    	<td align="center"><c:out value="${invoiceMemo.getPtnr_name()}"/></td>
				                    	<td align="center"><c:out value="${invoiceMemo.getPtnr_mbr_name()}"/></td>
				                    	<td align="center"><c:out value="${invoiceMemo.getBeneficiary_nm()}"/></td>
				                    </tr>
				                    <tr>
				                    	<td colspan="3">
				                    		<textarea style="width:100%" rows="10" id="rpt_invoice_memo" name="rpt_invoice_memo" ><c:out value="${invoiceMemo.getRpt_invoice_memo()}"/></textarea>
				                    		<input type="hidden" id="rpt_invoice_no" name="rpt_invoice_no" value="${invoiceMemo.getRpt_invoice_no()}" />
				                    		<input type="hidden" id="suim_rpt_no" name="suim_rpt_no" value="${invoiceMemo.getSuim_rpt_no()}" />
				                    	</td>
									</tr>
							</table>
						</div>
						<br>
						<p align="center">
							<img id="invmemoeditsave" src="./resources/ls_img/icon_write.gif" alt="저장" style ="cursor:pointer" />
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
