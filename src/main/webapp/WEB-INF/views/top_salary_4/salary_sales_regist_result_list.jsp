<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
<script src="./resources/ne_js/calendar.js?v=20170321111520"></script><!-- calendar -->
<script src="./resources/ne_js/ne_number.js"></script>
<style>
	.btn-vacation-detail {
		font-weight:bold;
		text-decoration:none;
		font-family:Arial;
		text-indent:0px;
		line-height:0px;
		-moz-border-radius:5px;
		-webkit-border-radius:5px;
		border-radius:5px;
		text-align:center;
		vertical-align:middle;
		display:inline-block;
		font-size:12px;
		color:#696969  !important;
		width:60px;
		height:0px;
		padding:10px;
		border-color:#e1e1e1;
		border-width:1px;
		border-style:solid;
		background: #CEE3F6;
	}
</style>
<script>
	$(document).ready(function () {
		
		$("#srchResultTeamId").select2();
		$("#srchInsuType").select2();
		
		//폼에서 엔터 입력시 검색버튼 클릭
		$("form input").keydown(function(e) {
			if( e.keyCode == 13 ){
				doSalesResultSearch();
			}
		});
		
		//페이지 로딩 후 검색
		doSalesResultSearch();
	});
	
	function doSalesResultSearch(){
		var formData = $("#searchResultSalesFrm").serialize();
		
		$.ajax({
			type : "post",
			url : "salesResultMemberListAjax",
			data : formData,
			success : function(result){			
				//날짜수정 페이지를 가져온다.				
				$("#salesResultMemberList").html(result);	 				
			},
			error: function (request, status, error) {			
				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
			}
		});		
	}
	
	//실적수정폼 불러오기
	function doSalesMemberDetail( p_user_no, p_pkey, p_skey ){		
		
		var sales_date_val = $("#result_sales_date").val();
		var chk_edate_val = $("#result_chk_edate").val();
		var user_no_val = p_user_no;
		var pkey_val = p_pkey;
		var skey_val = p_skey;		
		
		var sUrl = "get_sales_member_result_detail";
		
		var param = {};
		param.user_no = user_no_val;
		param.sales_date = sales_date_val;
		param.chk_edate = chk_edate_val;
		param.pkey = pkey_val;
		param.skey = skey_val;
		
		$.ajax({
			type: "POST",
			url: sUrl,
			data: param,		         
			dataType: "JSON", 
			success: function(data){
				
				//alert(JSON.stringify(data));				
				
				$("#form_chk_sdate_view").text($("#chk_sdate").val());
				$("#form_chk_edate_view").text($("#chk_edate").val());
				$("#form_sales_date_view").text($("#sales_date").val());
				
				$("#form_team_name_view").text(data.team_name);
				$("#form_user_name_view").text(data.user_name);
				
				$("#form_insu_name_view").text(data.salary_4_insu_nm);
				$("#form_part_name_view").text(data.salary_4_part_nm);
				
				if( data.insu_type == 1 ){				//건수 기준
					$("#form_insu_type_view").html("<font color='blue'>종결건</font>");
					$("#form_sector_interval_1_view").text(data.base_count+" ~ "+data.count_chk_point_1);
					$("#form_sector_interval_2_view").text(data.count_chk_point_1+" ~ "+data.count_chk_point_2);
					$("#form_sector_interval_3_view").text(data.count_chk_point_2+" ~ "+data.count_chk_point_3);
					$("#form_sector_interval_4_view").text(data.count_chk_point_3+" 초과");
					$("#form_input_title_view").html("<font color='blue'>종결건</font>");
					$("#form_result_sales_view").hide();
					$("#form_result_count_view").show();
					//구간계산값 셋팅
					$("#cal_sector_interval_1_view").val(data.count_chk_point_1);
					$("#cal_sector_interval_2_view").val(data.count_chk_point_2);
					$("#cal_sector_interval_3_view").val(data.count_chk_point_3);
				}else{											//매출액 기준
					$("#form_insu_type_view").html("<font color='green'>매출액</font>");
					$("#form_sector_interval_1_view").text(data.base_sales+" ~ "+data.sales_chk_point_1);
					$("#form_sector_interval_2_view").text(data.sales_chk_point_1+" ~ "+data.sales_chk_point_2);
					$("#form_sector_interval_3_view").text(data.sales_chk_point_2+" ~ "+data.sales_chk_point_3);
					$("#form_sector_interval_4_view").text(data.sales_chk_point_3+" 초과");
					$("#form_input_title_view").html("<font color='green'>매출액</font>");
					$("#form_result_count_view").hide();
					$("#form_result_sales_view").show();
					//구간계산값 셋팅
					$("#cal_sector_interval_1_view").val(data.sales_chk_point_1);
					$("#cal_sector_interval_2_view").val(data.sales_chk_point_2);
					$("#cal_sector_interval_3_view").val(data.sales_chk_point_3);
				}				
				
				$("#form_total_work_month_view").text(data.total_work_month_text);
				$("#form_loss_rate_view").text(data.loss_rate);
				$("#form_unit_sales_view").text( data.unit_sales );
				$("#form_base_count_view").text( data.base_count );
				$("#form_base_sales_view").text( data.base_sales );
				
				$("#form_sector_per_1_view").text(data.payout_rate_1+"%");
				$("#form_sector_per_2_view").text(data.payout_rate_2+"%");
				$("#form_sector_per_3_view").text(data.payout_rate_3+"%");
				$("#form_sector_per_4_view").text(data.payout_rate_4+"%");
				$("#form_fail_rate_view").text(data.fail_rate+"%");
				
				//view 형태로 바꾸어야함
				$("#cal_reason_text_view").text(data.cal_reason_text);
				$("#self_option_pay_view").text(data.self_option_pay);
				$("#job_option_pay_view").text(data.job_option_pay);
				$("#etc1_option_pay_view").text(data.etc1_option_pay);
				$("#etc2_option_pay_view").text(data.etc2_option_pay);
				$("#etc_memo_view").html(data.etc_memo);
				$("#loss_rate_view").text(data.update_loss_rate);
				$("#minwon_cnt_view").text(data.minwon_cnt);
				$("#result_count_view").text(data.result_count);				
				$("#sales_val_view").text(data.cal_result_sales);				//직원 매출액
				$("#total_sales_view").text(data.sum_sales_pay);			//성과급 합계			
				//수정시에도 합계값을 초기화한다.
				
				$("#sales-detail-dialog").dialog({
					height: 650,
					width: 800,
					closeOnEscape : true,
					draggable : true,					
					title: "성과급 실적 조회",
					buttons:{						
						"닫기" : function(){
							$(this).dialog("close");
						}
					},
					modal: true,
					overlay:{ opacity: 0., background: '#000000'}
				});				
				
			},
			error: function(e){
			    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
			}
			
		});		
		
	}
</script>

<div style="text-align:left;padding: 0 0 10px 5px;">
	<img src="./resources/wm_img/common/dot_bg.png" /> <b>정산일자 : <span id="result_sales_date_text">${srchParam.sales_date}</span></b>
</div>
<!-- 검색창 추가시 사용 -->
<form id=searchResultSalesFrm name="searchResultSalesFrm" method="post">
<div class="tableStyle99">
	<input type="hidden" id="result_sales_date" name="result_sales_date" value="${srchParam.sales_date}"/>
	<table>								
		<tr>			
			<th width="8%">
				실적 기준일자
			</th>
			<td align="center" width="15%">
				<input type="text" id="result_chk_sdate" name="result_chk_sdate" value="${srchParam.chk_sdate}" readonly style="width:70px;"/> ~ 
				<input type="text" id="result_chk_edate" name="result_chk_edate" value="${srchParam.chk_edate}" readonly style="width:70px;"/>				
			</td>
			<th width="8%">부서</th>
			<td width="17%" style="text-align:left;padding-left:10px;">
				<span style="text-align: left !important;">
					<select id="srchResultTeamId" name="srchResultTeamId" style="width: 195px;">
						<option value="0">- 전체 -</option>
						<c:forEach items="${teamList}" var="teamVo">
							<c:choose>
								<c:when test="${srchTeamId == teamVo.team_id}">
									<option value="${teamVo.team_id}" selected="selected">
								</c:when>
								<c:otherwise>
									<option value="${teamVo.team_id}">
								</c:otherwise>
							</c:choose>																
								<c:if test="${teamVo.team_level == 1}">&nbsp;└</c:if>
								<c:if test="${teamVo.team_level == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
								${teamVo.team_name}																
						</c:forEach>
					</select>
				</span>
			</td>
			<th width="8%">이름</th>
			<td width="12%" style="text-align:left;padding-left:10px;">
				<input type="text" style="width: 130px;" id="srchResultUserName" name="srchResultUserName" value="${srchParam.srchUserName }"/>	
			</td>
			<th width="8%">정산방식</th>
			<td width="14%" style="text-align:left;padding-left:10px;">
				<select id="srchInsuType" name="srchInsuType" style="width: 156px;">																											
					<option value="0" <c:if test="${srchParam.srchInsuType eq '0'}">selected</c:if> >- 전체 -</option>
					<option value="1" <c:if test="${srchParam.srchInsuType eq '1'}">selected</c:if>>종결건</option>
					<option value="2" <c:if test="${srchParam.srchInsuType eq '2'}">selected</c:if>>매출액</option>																		
				</select>													
			</td>
			<td align="center" width="10%">
				<a href="#noloc" class="btn-vacation-aprv" id="btn-search" onclick='doSalesResultSearch();'>검색</a>
			</td>
		</tr>
	</table>
</div>	
</form>
<br/>
<div class="tableStyle99">
	<table>
		<tr>
			<th width="4%">No</th>
			<th width="11%">팀명</th>
			<th width="4%">직급</th>
			<th width="10%">이름</th>									
			<th width="4%">손감</th>
			<th width="4%">민원</th>
			<th width="5%">정산방식</th>
			<th width="5%">정산구간</th>
			<th width="8%">기준 매출액</th>
			<th width="8%">직원 매출액</th>
			<th width="8%">구간 성과급</th>			
			<th width="8%">시상비 합계</th>
			<th width="8%">성과급 합계</th>			
			<th width="12%">-</th>
		</tr>
	</table>
	<div id="salesResultMemberList"></div>
</div>
<!-- 상세보기 시작 -->
<div id="sales-detail-dialog" title="실적 조회" style="font-size: 15px;display:none;" align="center">		
	<div class="tableStyle2" style="width: 750px;">
		<table class="vacation-ins-table">
			<tr>
				<th width="25%">실적기준일자</th>
				<td width="25%"><span id="form_chk_sdate_view"></span> ~ <span id="form_chk_edate_view"></span></td>
				<th width="25%">정산일자</th>
				<td width="25%"><span id="form_sales_date_view"></span></td>
			</tr>				
			<tr>
				<th>팀명</th>
				<td><span id="form_team_name_view"></span></td>
				<th>이름</th>
				<td><span id="form_user_name_view"></span></td>
			</tr>
			<tr>
				<th>보험사명</th>
				<td><span id="form_insu_name_view"></span></td>
				<th>직무명</th>
				<td><span id="form_part_name_view"></span></td>
			</tr>
			<tr>					
				<th>성과급 기준</th>
				<td><span id="form_insu_type_view"></span></td>
				<th>경력(연차)</th>
				<td><span id="form_total_work_month_view"></span></td>
			</tr>
			<tr>					
				<th>기준손감율</th>
				<td><span id="form_loss_rate_view"></span></td>
				<th>건당금액</th>
				<td><span id="form_unit_sales_view"></span> 원</td>
			</tr>
			<tr>					
				<th>(최소)기본건수</th>
				<td><span id="form_base_count_view"></span> 건</td>
				<th>(최소)기본 매출액</th>
				<td><span id="form_base_sales_view"></span> 원</td>
			</tr>
			<tr>
				<td colspan="4" style="border:0px;"></td>
			</tr>
			<tr>
				<th colspan="4">구간별 지급율</th>
			</tr>
			<tr>
				<th>1구간 (<span id="form_sector_per_1_view"></span>)</th>
				<th>2구간 (<span id="form_sector_per_2_view"></span>)</th>
				<th>3구간 (<span id="form_sector_per_3_view"></span>)</th>
				<th>4구간 (<span id="form_sector_per_4_view"></span>)</th>
			</tr>
			<tr>
				<td align="center"><span id="form_sector_interval_1_view"></span></td>
				<td align="center"><span id="form_sector_interval_2_view"></span></td>
				<td align="center"><span id="form_sector_interval_3_view"></span></td>
				<td align="center"><span id="form_sector_interval_4_view"></span></td>
			</tr>
			<tr>
				<td colspan="2" style="text-align:left;padding-left:5px;">&#8251; 손감미만 또는 민원발생시 지급율 : <b><span id="form_fail_rate_view"></span></b></td>
				<th>성과 구간</th>
				<td><font color="red"><b><span id="cal_reason_text_view"></span></b></font></td>
			</tr>
			<tr>
				<td colspan="4" style="border:0px;"></td>
			</tr>
			<tr>
				<th>본인부담금 시상비</th>
				<th>직업변경 시상비</th>
				<th>기타1</th>
				<th>기타2</th>
			</tr>
			<tr>
				<td><span id="self_option_pay_view"></span> 원</td>
				<td><span id="job_option_pay_view"></span> 원</td>
				<td><span id="etc1_option_pay_view"></span> 원</td>
				<td><span id="etc2_option_pay_view"></span> 원</td>
			</tr>			
			<tr>
				<td colspan="4" style="border:0px;"></td>
			</tr>
			<tr>
				<th>손감율</th>
				<th>민원발생</th>
				<th>직원 매출액</th>
				<th>성과급 합계</th>
			</tr>
			<tr>
				<td><span id="loss_rate_view"></span> %</td>
				<td><span id="minwon_cnt_view"></span> 건</td>
				<td><font color="green"><b><span id="sales_val_view"></span> 원</b></font></td>
				<td><font color="blue"><b><span id="total_sales_view"></span> 원</b></font></td>				
			</tr>
			<tr>
				<th height="80">비 고</th>
				<td colspan="3" align="left" style="text-align:left;padding-left:10px;">
					<span id="etc_memo_view"></span>					
				</td>
			</tr>			
		</table>			
	</div>		
</div>
<!-- 상세보기 끝 -->