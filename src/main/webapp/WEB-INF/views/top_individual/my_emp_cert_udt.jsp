<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
			
			$("#certUdt").click(function(){
				
				if( $("#issue_state").val() ){
						
						$.post("myCertUdtTb",
					
							{	
								 serial_no:$("#serial_no").val()
								,issue_state:$("#issue_state").val()
								
							},
							function(data,status){
								if(data == 1){
									alert("수정 되었습니다.");
									window.opener.location.reload();
								}else{
									alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
								}
							}
					);//post
					
				}else{					
					alert("상태를 확인해 주세요.");
				}
			});//click
			
		});
		
		function stateChange(obj){
			
			$("#issue_state").val(obj);
		}
		
	</script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
</head>
<body>
	<!-- header --><!--2016.01.14.rjh.수정.교체.-->
	<div id="headerpop">
		<div class="inner clear_v2">
			<h1>
				<img src="./resources/wm_img/common/logo.gif" height="39" alt="top - TRUST OBLIGATION PASSION" />
			</h1>
			<div style="text-align:center;padding-top:10px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
				<font color="white"><b><span style="font-size:11pt;"> 재직증명 요청 수정</span></b></font>
			</div>
		</div>
	</div>
	<!-- //header -->
	<div style="margin:10px 5px 0px 5px;">

		<form name="formtag" method="post">
			<input type="hidden" name="work_level_cd" id="work_level_cd" value="${myInfoVo.work_level_cd}" />
			<input type="hidden" name="user_no" id="user_no" value="${myInfoVo.user_no}" />
			<input type="hidden" name="team_id_loc" id="team_id_loc" value="${myInfoVo.team_id_loc}" />
			<input type="hidden" name="issue_state" id="issue_state" value="${myCertForUdt.issue_state}" />
			<input type="hidden" name="serial_no" id="serial_no" value="${myCertForUdt.serial_no}" />

			<div class="tableStyle4"><!--tableStyle4--><!--2016.01.14.rjh.수정.삽입.-->

				<table align="center" cellpadding="0" cellspacing="0" width="400">
				<tr>
					<td  width="18%" height="15" bgcolor="#EDEDED">
						<p align="center">상 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;태</p>
					</td>
					<td>
						신청 : <input type="radio"  name = "statChg" value = "0" checked="checked" onclick="stateChange(0);" />
						취소 : <input type="radio"  name = "statChg" value = "1" onclick="stateChange(1);"/>
					</td>
				</tr>
                <tr>
                    <td width="18%" height="15" bgcolor="#EDEDED" >
                        <p align="center">용 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;도</p>
                    </td>
                    <td width="78%" height="15" >
						<p>${myCertForUdt.issue_reason}</p>
                    </td>
                </tr>
                <tr>
                    <td width="18%" height="15" bgcolor="#EDEDED" >
                        <p align="center">유&nbsp;효&nbsp;날&nbsp;짜&nbsp;</p>
                    </td>
                    <td width="78%" height="15" >
						${myCertForUdt.expiry_date}
                    </td>
                </tr>
                <tr>
                    <td width="18%" height="15" bgcolor="#EDEDED" >
                        <p align="center">이 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름</p>
                    </td>
                    <td width="78%" height="15" >
						<p>${myInfoVo.user_name}</p>
                    </td>
                </tr>
                <tr>
                    <td width="18%" height="15" bgcolor="#EDEDED" >
                        <p align="center">주 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</p>
                    </td>
                    <td width="78%" height="15" >
						<p>${myInfoVo.home_address}</p>
                    </td>
                </tr>
                <tr>
                    <td width="18%" height="15" bgcolor="#EDEDED" >
                        <p align="center">근 무 부 서</p>
                    </td>
                    <td width="78%" height="15" >
						<p>${myInfoVo.team_name}</p>
                    </td>
                </tr>
                <tr>
                    <td width="18%" height="15" bgcolor="#EDEDED" >
                        <p align="center">직 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;위</p>
                    </td>
                    <td width="78%" height="15" >
						<p>${myInfoVo.work_level}</p>
                    </td>
                </tr>
                <tr>
                    <td width="18%" height="15" bgcolor="#EDEDED" >
                        <p align="center">근 무 기 간</p>
                    </td>
                    <td width="78%" height="15" >
						<p>${myInfoVo.join_date} 부터</p>
                    </td>
                </tr>
			</table>
			</div><!--//tableStyle4--><!--2016.01.14.rjh.수정.삽입.-->
		<p>&nbsp;</p>
		
		<p align="center"><img id = "certUdt" style="cursor:pointer;" src="./resources/ls_img/btn_write_ok.gif" /></p>
		
		</form>
	</div>

	<p>&nbsp;</p>
</body>