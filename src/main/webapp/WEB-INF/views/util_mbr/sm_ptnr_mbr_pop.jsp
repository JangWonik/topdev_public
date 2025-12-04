<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE HTML>
<html lang="ko">

<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" /><!--2016.01.14.rjh.수정.교체.-->
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css">
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>
	<script language="javascript" src="./resources/sms/nscript.js"></script>	
	<style>
		.td-overflow-none{
			text-overflow : ellipsis;
			overflow : hidden;
			white-space : nowrap;
			word-wrap:normal;
		}
		
		.buttonMini{
			width:40px;
			height:20px;
		    background-color:#CEE3F6;
		    color:#666;
		    text-align: center;
			border-radius:5px;
		    font-size: 11px;
		    font-weight: bold;
		    cursor: pointer;
		    text-decoration:none;
		    border: solid 0px grey;		    
		}
		
		.buttonSearchMini{
			width:50px;
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
	</style>
	<script>
		$(document).ready(function(){
			
			if('${mbrVo_Session.user_no}' == null || '${mbrVo_Session.user_no}'.trim() == ''){
				window.opener.location.assign("./logout");
				window.self.close();
			}

			$.ajaxSetup({cache:false});
			
			$("#searchStr").focus();
			$("#ptnrSelect").select2();

			$("#memberSearchBtn").click(function(){
				$.post("./suimPtnrMbrPopSearch",
						{	ptnr:$("#ptnrSelect option:selected").val()
							,gb:$("#ptnrSelect option:selected").text().indexOf("└")
							,str:$("#searchStr").val()
						},
						function(data,status){
							$("#searchTbody").empty();
							if(status == "success"){
								if(data.length == 0){
									alert("검색 결과가 없습니다.");
								}else{
				                    $.each(data, function(index, entry) {
				                    	
				                    	//부서명에 팀명이 없는경우
				                    	if( entry.ptnr_tm2_nm == '' ){
				                    		$("#searchTbody").append('<tr>'
													+"<td class='td-overflow-none'>"+entry.ptnr_nick+"</td>"												
													+"<td class='td-overflow-none' style='text-align:left;padding-left:5px;'>"+entry.ptnr_tm_nm+"</td>"
													+"<td class='td-overflow-none'>"+entry.ptnr_mbr_position_nm+"</td>"
													+"<td class='td-overflow-none' style='text-align:left;padding-left:5px;'>"+entry.ptnr_mbr_nm+"</td>"
													+"<td class='td-overflow-none' style='text-align:left;padding-left:5px;'>"+entry.ptnr_mbr_office_tel+"</td>"
													+"<td><input type='button' class='buttonMini' value='선택' id='selectBtn"+index+"' /></td>"												
			                                		+ '</tr>'
				   							);
				                    	}else{
				                    		$("#searchTbody").append('<tr>'
													+"<td class='td-overflow-none'>"+entry.ptnr_nick+"</td>"												
													+"<td class='td-overflow-none' style='text-align:left;padding-left:5px;'>"+entry.ptnr_tm_nm+"("+entry.ptnr_tm2_nm+")</td>"
													+"<td class='td-overflow-none'>"+entry.ptnr_mbr_position_nm+"</td>"
													+"<td class='td-overflow-none' style='text-align:left;padding-left:5px;'>"+entry.ptnr_mbr_nm+"</td>"
													+"<td class='td-overflow-none' style='text-align:left;padding-left:5px;'>"+entry.ptnr_mbr_office_tel+"</td>"
													+"<td><input type='button' class='buttonMini' value='선택' id='selectBtn"+index+"' /></td>"												
			                                		+ '</tr>'
				   							);
				                    	}
		                        		$("#selectBtn"+index).bind("click",function(){
		                        			popSelect(entry.ptnr_id, entry.ptnr_dept_id, entry.ptnr_mbr_no);
		                        		});
									});//each
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						},"json"
				);//post

			});//$("#memberSearchBtn").click			

		});//ready
		
		function memberSearchBtnClick(){
			$("#memberSearchBtn").click();
		}

		function popSelect(ptnr_id, ptnr_dept_id, ptnr_mbr_no){
			
			var tmp = window.confirm("담당자를 변경 하시겠습니까?");
			if(tmp == false){
				return;
			}
			
			var smsFlag = "0";
			var receiver = "" ;
			var msg = "" ;
			if ( $("#smsChk").is(":checked") ){
				smsFlag = $("#smsChk:checked").val();
			}

			$.post("./suimPtnrMbrChg",
					{	 gbNo	:$("#gbNo").val()
						,smNo	:$("#smNo").val()
						,ptnrNo	:ptnr_id
						,deptNo	:ptnr_dept_id
						,mbrNo	:ptnr_mbr_no
						,smsFlag:smsFlag
					},
					function(data,status){
						
						var acceptNo = data.suimAcceptNo;
						var ptnrMbrNm = data.ptnrMbrNm;
						var ptnrPositionNm = data.ptnrMbrPositionNm;
						var beneficiaryNm = data.beneficiaryNm;
						var handphone = data.handphone;
						
						if(status == "success"){
							if(data.result == "9999"){
								alert("담당자 변경을 실패 하였습니다.");
							}else{
								alert("담당자 변경을 성공 하였습니다.");

								if (smsFlag == "onestop") {
									var msg = acceptNo +" 메리츠 One-stop 조사건\n";
									msg += "일반위임조사 전환\n[보험사담당자:"+ptnrMbrNm+ptnrPositionNm+"]";
			                    	$("#receiver").val(handphone);
			                    	$("#phone_no").val(handphone);
			                    	$("#message").val(msg); 
			                    	mySMSSend();
			                    	
								} else if (smsFlag == "suim") {
									var msg = acceptNo +" 피보험자 "+beneficiaryNm+"건\n";
									msg += "보험사담당자 "+ptnrMbrNm+ptnrPositionNm+"으로 변경되었습니다";
			                    	$("#receiver").val(handphone);
			                    	$("#phone_no").val(handphone);
			                    	$("#message").val(msg);			
			                    	mySMSSend();
								}
								window.opener.location.reload();
								window.self.close();
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					},"json"
			);//post
		}//popSelect
		
		function mySMSSend(){			
			//document.smsForm.submit();
			
			var param = {};
            
			param.api_key = $("#api_key").val();
			param.m_user_id = $("#m_user_id").val();
			param.phone_no = $("#receiver").val();
			param.name_replace = $("#name_replace").val();
			param.DATE = $("#DATE").val();
			param.return_url = $("#return_url").val();
			param.end_alert = $("#end_alert").val();
			param.msgfocus = $("#msgfocus").val();
			param.userid = $("#userid").val();
			param.passwd = $("#passwd").val();
			param.message = $("#message").val();
			param.callback_no = $("#callback_no").val();
			param.SEND_TYPE = "N";
        	param.send_time = "";
        	
        	$("#top_loading").show();
        	
        	$.ajax({
				type: "POST",
				url: "https://api.munjamoa.co.kr/message/toplac/sendMsg",
				data: param,
				success: function(){},
				dataType: "json",
				contentType : "application/x-www-form-urlencoded",
				success: function(data){
					if(data.result == "success"){
						alert("문자발송에 성공하였습니다.");
						$("#top_loading").hide();
						window.open('','_self').close();
					}else{
						alert("문자발송에 실패하였습니다.\nIT정보보호파트로 연락하세요. (ERROR : "+data.code+")");								
					}
				},
				error: function(e){
					alert("문자발송에 성공하였습니다.");
					$("#top_loading").hide();
					window.open('','_self').close();
				}
				
			});
			
			
		}
	</script>
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">

	<!-- <form action=" http://munjamadang.co.kr/smsasp/smsasp.html" method="post" name="smsForm" id="smsForm"> -->
	<form action="https://api.munjamoa.co.kr/message/toplac/sendMsg" method="post" name="smsForm" id="smsForm">	
	<!-- 신규정보 추가 시작-->
		<input type="hidden" id="api_key" name="api_key" value="SYhfQxLgaANtMSfdH93staNmfM6ybDQcMsdXdFhkTQMIiYZ9Y8KNZRM2jlfBmLhKAWAumahJh1m0joPiOg04BPgIedOW4FnN7JfV">
		<input type="hidden" id="m_user_id" name="m_user_id" value="toplac">
		<input type="hidden" id="phone_no" name="phone_no" />
		<input type="hidden" id="name_replace" name="name_replace" value="N"/>
		<input type="hidden" id="SEND_TYPE" name="SEND_TYPE" value="N"/>
		<input type="hidden" id="DATE" name="DATE" />
		<input type="hidden" id="callback_no" name="callback_no" value="0260774600"/>
		<!-- 신규정보 추가 끝-->
		
		<input type="hidden" name="send_time" value="">
		<input type="hidden" name="return_url" value="http://www.toplac.co.kr/smsClose"><!-- 정식 오픈 시, 수정 -->
		<input type="hidden" name="end_alert" value="1" />
		<input type="hidden" name="msgfocus" id="msgfocus" value="0" />
		<input type="hidden" name="userid" value="toplac" />
		<input type="hidden" name="passwd" value="toplac3000" />
		<input type="hidden" name="receiver" id="receiver" value="" />
		<input type="hidden" name="sender" value="0260774600" />
		<input type="hidden" name="message" id="message" value="" />
	</form>

	<!-- header --><!--2016.01.14.rjh.수정.교체.-->
	<div id="headerpop">
		<div class="inner clear_v2">
			<h1>
				<img src="./resources/wm_img/common/logo.gif" height="39" alt="top - TRUST OBLIGATION PASSION" />
			</h1>
			<div style="text-align:center;padding-top:10px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
				<font color="white"><b><span style="font-size:11pt;"> 보 험 사 직 원 검 색</span></b></font>
			</div>
		</div>
	</div>
	<!-- //header -->
	<div style="margin:10px 5px 0px 5px;">

		<input type="hidden" name="gbNo" id="gbNo" value="${gbNo}" />
		<input type="hidden" name="smNo" id="smNo" value="${smNo}" />
		<!-- 검색 조건 테이블 -->
		<div class= "tableStyle2">

			<table>
				<thead>
					<tr>
						<th width="45%">보험사명</th>
						<th width="45%">이름</th>
						<th width="10%"> - </th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="text-align:left;padding-left:5px;">
							<select id="ptnrSelect" name="ptnrSelect" style="width:95%;">
								<option value="0" selected>전체</option>
								<c:forEach items="${ptnrList}" var = "ptnrVo">
									<option value="${ptnrVo.ptnr_id}"
										<c:if test="${ptnrVo.ptnr_id == ptnrNo}">selected</c:if>
									>
										<c:if test="${ptnrVo.ptnr_level == 1}">&nbsp;└</c:if>
										${ptnrVo.ptnr_nick}
									</option>
								</c:forEach>
							</select>
						</td>
						<td style="text-align:center;">
							<input type="hidden" id="ustat" value="0" />
							<input type="hidden" id="tid" value="0" />							
							<input type="text" id="searchStr" name="searchStr" size="25" style="width:90%;" onKeydown="javascript:if(event.keyCode == 13) memberSearchBtnClick();" />
						</td>
						<td width="20%">							
							<input class="buttonSearchMini" id="memberSearchBtn" type="button" value="검 색">
						</td>
					</tr>
				</tbody>
			</table>

		</div><!-- //tableStyle2 -->
		<!-- //검색 조건 테이블 -->
		<br />
		
		<c:if test="${gbNo eq '1'}">
			<c:choose>
				<c:when test="${ptnrDeptNo eq '733'}">
					<input type="checkbox" name="smsChk" id="smsChk" value="onestop" checked="checked"/>
				</c:when>
				<c:otherwise>
					<input type="checkbox" name="smsChk" id="smsChk" value="suim" checked="checked"/>
				</c:otherwise>
			</c:choose>
		</c:if>
		보험사 담당자 변경 시, 처리 담당자에게 담당자 변경 안내 문자를 발송합니다.
			
		<!-- 검색 결과 테이블 -->
		<div class= "tableStyle2">
				<table>
					<thead>
						<tr>
						<th width="15%">보험사명</th>
						<th width="30%">부서명(팀명)</th>
						<th width="7%">직위</th>
						<th width="23%">이름</th>
						<th width="17%">직통전화</th>
						<th width="8%">선택</th>
						</tr>
					</thead>
					<tbody id="searchTbody">
						<c:forEach items="${ptnrMbrList}" var="mbrVO" varStatus="status">
							<tr>
								<!--보험사명-->
								<td class="td-overflow-none">${mbrVO.ptnr_nick}</td>
								<!--부서명(팀명)-->
								<td class="td-overflow-none" style="text-align:left;padding-left:5px;">
									${mbrVO.ptnr_tm_nm}
									<c:if test="${mbrVO.ptnr_tm2_nm ne ''}">
										(${mbrVO.ptnr_tm2_nm})	
									</c:if>
								</td>
								<!--직급-->
								<td class="td-overflow-none">${mbrVO.ptnr_mbr_position_nm}</td>
								<!--이름-->
								<td class="td-overflow-none" style="text-align:left;padding-left:5px;">${mbrVO.ptnr_mbr_nm}</td>
								<!--휴대폰-->
								<td class="td-overflow-none" style="text-align:left;padding-left:5px;">${mbrVO.ptnr_mbr_office_tel}</td>
								<!--선택-->
								<td>									
									<input type="button" class="buttonMini" value="선택" id="selectBtn${status.index}" onClick="javascript:popSelect(${mbrVO.ptnr_id}, ${mbrVO.ptnr_dept_id}, ${mbrVO.ptnr_mbr_no});">
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

		</div><!-- //tableStyle2 -->
		<!-- //검색 결과 테이블 -->

	</div>

	<p>&nbsp;</p>

	<table cellpadding="0" cellspacing="0" width="100%" background="./resources/ne_img/pop/bg_f_rjh.gif">
        <tr>
            <td width="80"><p>&nbsp;</p></td>
            <td height="35"><p align="center">&nbsp;</p></td>
            <td width="80"><p align="center"><A href="javascript:window.close();"><img src="./resources/ls_img/btn_close.gif" width="35" height="18" border="0"></A></p></td>
        </tr>
    </table>
    <!-- //통합로딩바 -->
	<div id="top_loading" style="display: none;">
		<img id="loading-image" src="/resources/cmm/images/spinner.gif" alt="Loading..." />
	</div>
	<!-- //통합로딩바끝 -->

</body>

</html>
