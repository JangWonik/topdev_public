<%@ page	language="java"	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css">
	<!--<link rel="stylesheet" type="text/css" href="./resources/ne_css/style2.css">-->
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/><!-- calendar -->
	<script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
	<script src="./resources/ne_js/calendar.js"></script><!-- calendar -->
	<script src="./resources/wm_js/common.js"></script>
</head>
<style>
	.buttonEduView{
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
			color:#FFFFFF  !important;
			width:60px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #3232FF;
		    }
		    
		.buttonEduDown{
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
			color:#FFFFFF  !important;
			width:60px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #FF0099;
		    }
		    
		/*보기 회색 버튼*/
		.btn-equipment-gray {
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
			color:#FFFFFF  !important;
			width:70px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #666666;
		}
		
		/*수정 버튼*/
		.btn-equipment-mod {
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
			color:#FFFFFF  !important;
			width:70px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #0033FF;
		}
		
		.buttonMenuLec{
			width:275px;
			height:30px;
		    /* background-color:#2E7EE8; */
		    background-color:#013469;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 14px;
		    font-weight:bold;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		    }
		.buttonMenuLec:hover{
			background-color:#FFA500;
		}
		
		.buttonIngFlag{
		width:70px;
		height:23px;
	    background-color:#2E7EE8;
	    color:#FFFFFF;
	    text-align: center;
		border-radius:5px;
	    font-size: 13px;
	    cursor: pointer;
	    text-decoration:none;
	    border: none;
	    }
	    
		.buttonReadyFlag{
			width:70px;
			height:23px;
		    background-color:#FFA500;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		}
		    
		.buttonEndFlag{
			width:70px;
			height:23px;
		    background-color:#666;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		}
		
		.buttonDoneFlag{
			width:70px;
			height:23px;
		    background-color:#00a000;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		}
		
		.buttonShowFlag{
			width:70px;
			height:23px;
		    background-color:#3232FF;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		}
				    
		.buttonRejectFlag{
			width:70px;
			height:23px;
		    background-color:#FF4040;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		}
		
		.buttonMiniView{
			width:80px;
			height:20px;
		    background-color:#F7F7F7;
		    color:#666;
		    text-align: center;
			border-radius:5px;
		    font-size: 11px;
		    cursor: pointer;
		    text-decoration:none;
		    border: solid 1px grey;		    
		}
</style>
<script>
$(document).ready(function(){
	//진행중인 교육과정 목록을 불러온다.
	getProcessList('Ing');
	
	//진도율 동적체크
	$("#myProgress").val(${allProgressPer});
});

//교육과정 진도율 가져오기
function getProcessList(p_type){	
	
	var url = "./getProcessListFront";
	
	var param = {};
	param.ptype = p_type;			//All, Ing, Done, End 플래그	
	
	$.ajax({
        type: "POST",
        url: url,
        data: param,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        timeout: 20000,
        dataType: "HTML", 
        success: function(data){        	
        	$("#divProcessList").html(data);        	
        },
        error: function(e){
            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
        }
    });
}
</script>
<!-- 시작 -->
<div class="centercnt_top"><!-- centercnt_top -->
	<table>
		<tbody>
		<tr>
			<td>
				<div class="nociteA nocite" style="height: 400px;width: 286px;">
				<div class="notice_top" style="height: 170px;width: 286px;">														
					<div class="notice" style="height: 35px;width: 286px;padding:10px 5px 0 5px;">
						<input class="buttonMenuLec" type="button" value="전체 교육과정 : ${allCnt} 개" onclick="javascript:getProcessList('All')">														
					</div>
					<div class="notice" style="height: 35px;width: 286px;padding:5px 5px 0 5px;">
						<input class="buttonMenuLec" type="button" value="진행중인 교육과정 : ${ingCnt} 개" onclick="javascript:getProcessList('Ing')">														
					</div>
					<div class="notice" style="height: 35px;width: 286px;padding:5px 5px 0 5px;">
						<input class="buttonMenuLec" type="button" value="완료된 교육과정 : ${doneCnt} 개" onclick="javascript:getProcessList('Done')">														
					</div>
					<div class="notice" style="height: 35px;width: 286px;padding:5px 5px 0 5px;">
						<input class="buttonMenuLec" type="button" value="종료된 교육과정 : ${endCnt} 개" onclick="javascript:getProcessList('End')">														
					</div>
					<div class="tableStyle99" style="padding:10px 5px 5px 5px;">
					<h3>나의 교육정보</h3>
						<table>
							<tr>
								<th height="25">교육과정 진도율</th>
								<th title="교육기간 내 포함된 교육과정에 대한 교육진도율 입니다."><font color="blue" size="3">${allProgressPer} %</font></th>																
							</tr>
							<tr>
								<td style="padding-top:10px;" colspan="2">	
									<progress value="0" max="100" id="myProgress" style="height:20px;width:100%;valign:middle;"></progress>
								</td>
							</tr>
							<tr>
								<th>총 교육받은 시간</th>
								<td align="center">
									<c:choose>
										<c:when test="${MyDetailInfo.total_time > 0 }">
											${MyDetailInfo.total_time_fmt}
										</c:when>
										<c:otherwise> 0 시간</c:otherwise>
									</c:choose>
								</td>
							</tr>
							<tr>
								<th>시청중 / 전체</th>
								<td align="center">${MyDetailInfo.info_ing_cnt} / ${MyDetailInfo.info_total_cnt}</td>
							</tr>
							<tr>
								<th>시청완료 / 전체</th>
								<td align="center">${MyDetailInfo.info_end_cnt} / ${MyDetailInfo.info_total_cnt}</td>
							</tr>
						</table>
					</div>
				</div>													
			</div>
			</td>
		</tr>						
	</tbody>
	</table>
</div>