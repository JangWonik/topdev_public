<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE HTML>
<html lang="ko">

<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" /><!--2016.01.14.rjh.수정.교체.-->
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css">
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script>
		

		$(document).ready(function(){
			
			if('${mbrVo_Session.user_state}' == null || ('${mbrVo_Session.user_state}' != 9)){
				alert("권한이 없습니다.");
				window.self.close();
			}
			
			$("#prm_link_name_select").change(function(){
				$.post("./prmNameSel",
						{
							plno : $("#prm_link_name_select").val()
						},
						function(data,status){
							if(status=='success'){
								if(data != ''){
									$("#igNameID").show();
									$("#igNameID").val(data.split("+")[0]);
									$("#prmUrlID").val(data.split("+")[1]);
									$("#igNameIDSpan").show();
									$("#delPrm").show();
								}else{
									alert("시스템 오류, 관리자에게 문의하세요.");
								}
							}
						}
					);
			});
			
			$("#prmWriteID").click(function(){
				
				var plname = "";
				var action = $("input:radio[name='addEditePrm']:checked").val();
				var plno = $("#prm_link_name_select").val();
				var pllink = $("#prmUrlID").val();
				
				if(action == 0){
					plname = $("#igNameID").val();
				}else{
					plname = $("#igInputNameID").val();
				}
				
				
				$.post("./prmOk",
					{
						action : action,
						plno : plno,
						plname : plname,
						pllink : $("#prmUrlID").val()
						
					},
					function(data,status){
						if(status=='success'){
							if(data > 0 ){
								alert("저장완료");
								location.reload();	
							}else{
								alert("시스템 오류, 관리자에게 문의하세요.");
							}
						}
					}
				);
			});
			
			$("#delPrm").click(function(){
				
				var plno = $("#prm_link_name_select").val();
				
				$.post("./prmDel",
						{
							plno : plno
						},
						function(data,status){
							if(status=='success'){
								if(data != ''){
									alert("삭제 완료");
									location.reload();	
								}else{
									alert("시스템 오류, 관리자에게 문의하세요.");
								}
							}
						}
					);
				
			});
			
			
		});//ready
		
		function changeState(obj){
			if(obj == 'edite'){
				$("#prm_link_name_select").show();
				$("#igInputNameID").hide();
				$("#igNameIDSpan").show();
				
				if($("#prm_link_name_select").val() != 0){
					$("#delPrm").show();	
				}
				
			}else{
				$("#prm_link_name_select").hide();
				$("#igInputNameID").show();
				$("#igNameIDSpan").hide();				
				$("#delPrm").hide();
				
			}
		}
	</script>

</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">

	<div id="headerpop">
		<div class="inner clear_v2">
			<h1>
				<img src="./resources/wm_img/common/logo.gif" height="39" alt="top - TRUST OBLIGATION PASSION" />
			</h1>
			<div style="text-align:center;padding-top:10px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0"><font color="white"><b><span style="font-size:11pt;"> PRM 링크 관리</span></b></font></div>
		</div>
	</div>
	<!-- //header -->
	<div style="margin:5px 5px 5px 5px;">
		<div class="tableStyle4"><!--tableStyle4--><!--2016.01.14.rjh.수정.삽입.-->
				<div style = "text-align: center;">
					<input type="radio" id = "editePrmID" name="addEditePrm" value ="0" checked="checked" onClick="changeState('edite');"/>수정
					<input type="radio" id = "addPrmID" name="addEditePrm" value ="1" onClick="changeState('add');"/>추가
				</div>
				<input type="hidden" id = "todayID" name= "today" value = ""/>
				<input type="hidden" id = "userID" name= "user" value = ""/>
				<input type="hidden" id = "userID" name= "pageFlag" value = "1"/>
				
					<table align="center" cellpadding="0" cellspacing="0" width="420" bordercolordark="white" bordercolorlight="#CCCCCC">
						<tr>
							<td bgcolor="#F8F8F8" class="td" width="80" height="30">
							<p align="center">보 &nbsp;&nbsp;험 &nbsp;&nbsp;사</p>
							</td>
							<td class="td" width="340">
								<select name="prm_link_name" id="prm_link_name_select" >
									<option value='0'>-보험사명-</option>
									<c:forEach items="${prmList}" var="prmVo">
										<option value='${prmVo.plno}'>${prmVo.plname}</option>	
									</c:forEach>	
								</select>
								<span id="igNameIDSpan" style="display:none;">보험사명 : <input type="text" id ="igNameID" name="igName" style="display:none;"/></span>
								<input type="text" id ="igInputNameID" name="igInputNameID" style="display:none;"size = "30"/>
								<img id="delPrm" src="./resources/ls_img/btn_del.gif" border="0" style="display:none; cursor: pointer;" >
							</td>
						</tr>
				
						<tr>
							<td bgcolor="#F8F8F8" class="td" width="80" height="30"><p align="center">링 크</p>
							</td>
							<td class="td" width="340">
								<input type="text" style = "width:200px;" name="prmUrl" id = "prmUrlID" />
								<img id="prmWriteID" name= "prmWrite" src="./resources/ls_img/icon_write.gif" width="75" height="23" border="0" style="cursor:pointer;" >
							</td>
						</tr>
					</table>
			</div><!--//tableStyle4--><!--2016.01.14.rjh.수정.삽입.-->
							<p style="line-height:50%; margin-top:0; margin-bottom:0;">&nbsp;</p>
													<p align="center"></p>
			</div>
				<table cellpadding="0" cellspacing="0" width="100%" background="./resources/ne_img/pop/bg_f_rjh.gif">
                    <tr>
                        <td width="80"><p>&nbsp;</p></td>
                        <td height="35"><p align="center">&nbsp;</p></td>
                        <td width="80"><p align="center"><A href="javascript:window.close();"><img src="./resources/ls_img/btn_close.gif" width="35" height="18" border="0"></A></p></td>
                    </tr>
                </table>

</body>

</html>
