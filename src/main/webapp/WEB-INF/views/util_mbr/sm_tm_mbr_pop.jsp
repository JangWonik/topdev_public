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
			$("#tid").select2();

			$("#memberSearchBtn").click(function(){
				$.post("./empNmlstSearch",
						{	ustat:$("#ustat").val()
							,tid:$("#tid").val()
							,searchStr:$("#searchStr").val()
							,gid:$("#tid option:selected").text().indexOf("└")
						},
						function(data,status){
							$("#searchTbody").empty();
							if(status == "success"){
								if(data.length == 0){
									alert("검색 결과가 없습니다.");
								}else{
	                        		$("#searchTbody").append('<tr>'
											+"<td>"+0+"</td>"
											+"<td><font color='red'>"+data[0].team_name+"</font></td>"
											+"<td><font color='red'>미지정</font></td>"
											+"<td><font color='red'>미지정</font></td>"
											+"<td><font color='red'>미지정</font></td>"
											+"<td><input type='button' class='buttonMini' id='selectBtn0' value='선택' /></td>"
	                                		+ '</tr>'
		   							);
	                        		$("#selectBtn0").bind("click",function(){
	                        			popSelect(data[0].team_id_main, 0);
	                        		});
	                        		
				                    $.each(data, function(index, entry) {
		                        		$("#searchTbody").append('<tr>'
												+"<td>"+(index+1) +"</td>"
												+"<td>"+entry.team_name+"</td>"
												+"<td>"+entry.work_level+"</td>"
												+"<td>"+entry.work_type+"</td>"
												+"<td>"+entry.user_name+"</td>"
												+"<td><input type='button' class='buttonMini' value='선택' id='selectBtn"+(index+1)+"'/></td>"
		                                		+ '</tr>'
			   							);
		                        		$("#selectBtn"+(index+1)).bind("click",function(){
		                        			popSelect(entry.team_id_main, entry.user_no);
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

		function popSelect(team_id_main, user_no){
			var tmp = window.confirm("담당자를 변경 하시겠습니까?");
			if(tmp == false){
				return;
			}

			$.post("./suimTmMbrChg",
					{	gbNo:$("#gbNo").val()
						,smNo:$("#smNo").val()
						,tmNo:team_id_main
						,mbrNo:user_no
					},
					function(data,status){
						if(status == "success"){
							if(data.length == 0){
								alert("담당자 변경을 실패 하였습니다.");
							}else if(data == 1){
								alert("담당자 변경을 성공 하였습니다.");
								window.opener.location.reload();
								window.self.close();
							}else{
			                    $.each(data, function(index, entry) {
			                    	$("#receiver").val(entry.hp);
			                    	$("#phone_no").val(entry.hp);
			                    	$("#message").val(entry.msg);
								});//each
								
								if($("#gbNo").val() < 300 && ptnrsms2.checked == true){
									mySMSSend();//정식 오픈 시, 주석 해제
								}
								alert("담당자 변경을 성공 하였습니다.");
								window.opener.location.reload();
								//window.self.close();
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					},"json"
			);//post
		}//popSelect

		function mySMSSend(){
			//document.charset = "EUC-KR";
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
					alert("처리 담당자에게 문자를 발송하였습니다.");
					$("#top_loading").hide();
					window.open('','_self').close();
				}
				
			});
		}
	</script>
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
	<!-- <form action=" http://munjamadang.co.kr/smsasp/smsasp.html" method="post" name="smsForm"> -->	
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
		
		<input type="hidden" id="send_time" name="send_time" value="">
		<input type="hidden" id="return_url" name="return_url" value="http://www.toplac.co.kr/smsClose"><!-- 정식 오픈 시, 수정 -->
		<input type="hidden" id="end_alert" name="end_alert" value="1" />
		<input type="hidden" id="msgfocus" name="msgfocus" id="msgfocus" value="0" />
		<input type="hidden" id="userid" name="userid" value="toplac" />
		<input type="hidden" id="passwd" name="passwd" value="toplac3000" />
		<input type="hidden" id="receiver" name="receiver" id="receiver" value="" />
		<input type="hidden" id="sender" name="sender" value="07082553000" />
		<input type="hidden" id="message" name="message" id="message" value="" />
	</form>

	<!-- header --><!--2016.01.14.rjh.수정.교체.-->
	<div id="headerpop">
		<div class="inner clear_v2">
			<h1>
				<img src="./resources/wm_img/common/logo.gif" height="39" alt="top - TRUST OBLIGATION PASSION" />
			</h1>
			<div style="text-align:center;padding-top:10px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
				<font color="white"><b><span style="font-size:11pt;"> 사 원 검 색</span></b></font>
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
						<th width="45%">팀명</th>
						<th width="45%">이름</th>
						<th width="10%"> - </th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="text-align:left;padding-left:5px;">
							<select id="tid" style="width:95%;">
								<option value="0" selected>전체</option>
								<c:forEach items="${teamList}" var = "teamVo">
									<option value="${teamVo.team_id}" <c:if test="${teamVo.team_id == tmNo}">selected</c:if> >
										<c:if test="${teamVo.team_level == 1}">&nbsp;└</c:if>
										<c:if test="${teamVo.team_level == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
										${teamVo.team_name}
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
		<c:if test="${gbNo < 300 && ptnrSMS2 == 1}">
			<input type="checkbox" name="ptnrsms2" id="ptnrsms2" checked />
			담당자 변경 시, 신규 담당자에게 배당 알림 문자를 발송합니다.
		</c:if>
		<!-- 검색 결과 테이블 -->
		<div class= "tableStyle2">

				<table>
					<thead>
						<tr>
							<th width="7%">No</th>
							<th width="30%">팀명</th>						
							<th width="15%">직위</th>
							<th width="15%">직급</th>
							<th width="25%">이름</th>
							<th width="8%">선택</th>
						</tr>
					</thead>
					<tbody id="searchTbody">
						<tr>
							<!--No-->
							<td><font color="red">0</font></td>
							<!--팀명-->
							<td><font color="red">${tmMbrList.get(0).team_name}</font></td>
							<!--직급-->
							<td><font color="red">미지정</font></td>
							<!--직책-->
							<td><font color="red">미지정</font></td>
							<!--이름-->
							<td><font color="red">미지정</font></td>
							<!--선택-->
							<td>								
								<input type="button" class="buttonMini" value="선택" id="selectBtn0" onClick="popSelect(${tmMbrList.get(0).team_id_main}, 0)">
							</td>
						</tr>
					
						<c:forEach items="${tmMbrList}" var="mbrVO" varStatus="status">
							<tr>
								<!--No-->
								<td>${status.count}</td>
								<!--팀명-->
								<td>${mbrVO.team_name}</td>
								<!--직급-->
								<td>${mbrVO.work_level}</td>
								<!--직책-->
								<td>${mbrVO.work_type}</td>
								<!--이름-->
								<td>${mbrVO.user_name}</td>
								<!--선택-->
								<td>									
									<input type="button" class="buttonMini" value="선택" id="selectBtn${status.index}" onClick="popSelect(${mbrVO.team_id_main}, ${mbrVO.user_no});">
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

</body>

</html>
