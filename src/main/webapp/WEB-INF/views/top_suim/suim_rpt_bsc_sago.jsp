<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<script>
	
	$(document).ready(function(){
		
		/* 사고처리 과정표 1행 추가 시작 */
		$("#sagoRptInsBtn").click(function(){

			if($("#sago_regDate").val() == ''){
				alert("일자를 입력하세요.");
				return;
			}
			
			if($("#sago_item").val() == ''){
				alert("항목을 입력하세요.");
				return;
			}
			
			if($("#sago_contents").val() == ''){
				alert("내용을 입력하세요.");
				return;
			}
			
			$.post("./sagoRptIns",
					{	
						 suimRptNo   	:$("#suimRptNo").val()  //
						,item	       	:$("#sago_item").val()  //
						,content       	:$("#sago_contents").val() // 
						,regDate       	:$("#sago_regDate").val() //
						
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("저장 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{
								alert("저장 완료");
								$("#sagoList").append(
									"<tr id='"+data+"'>"
										+ "<td>" + $("#sago_regDate").val() + "</td>"
										+ "<td>" + $("#sago_item").val() + "</td>"
										+ "<td>" + $("#sago_contents").val() + "</td>"
										+ "<td>" + "<img src='./resources/ls_img/btn_edit_s.gif' onclick=\"sagoEdit('"+data+"','"+$("#sago_regDate").val()+"','"+$("#sago_item").val()+"','"+$("#sago_contents").val()+"');\" style='cursor:pointer;'/>"
												 + "   <img src='./resources/ls_img/btn_del_s.gif' onclick='sagoDel("+data+");' style='cursor:pointer;'/>"
										+ "</td>"
									+"</tr>"
								);
								$("#sagoAddAreaId").css("display","none");
								$("#hideSagoAddAreaBtn").css("display","none");
								$("#showSagoAddAreaBtn").css("display","block");
								
								if("${suimVO.suim_rpt_type2 }" == 1){
									$("#print1_Ctrl").append(
										"<tr id = 'print1_Ctrl_"+data+"'>"
										+	"<td class='td'>"
										+		"<p align='center'>"+$("#sago_regDate").val()+"</p></td>"
										+	"<td class='td'>"
										+		"<p align='center'>"+$("#sago_item").val()+"</p></td>"
										+	"<td class='td'>"
										+		"<p align='center'>"+$("#sago_contents").val()+"</p>"
										+	"</td>"
										+"</tr>"	
									);									
								}else if("${suimVO.suim_rpt_type2 }" == 9){
									$("#print9_Ctrl").append(
											"<tr id = 'print9_Ctrl_"+data+"'>"
											+	"<td class='td'>"
											+		"<p align='center'>"+$("#sago_regDate").val()+"</p></td>"
											+	"<td class='td'>"
											+		"<p align='center'>"+$("#sago_item").val()+"</p></td>"
											+	"<td class='td'>"
											+		"<p align='center'>"+$("#sago_contents").val()+"</p>"
											+	"</td>"
											+"</tr>"	
										);	
								}else if("${suimVO.suim_rpt_type2 }" == 17){
									$("#print17_Ctrl").append(
											"<tr id = 'print17_Ctrl_"+data+"'>"
											+	"<td class='td'>"
											+		"<p align='center'>"+$("#sago_regDate").val()+"</p></td>"
											+	"<td class='td'>"
											+		"<p align='center'>"+$("#sago_item").val()+"</p></td>"
											+	"<td class='td'>"
											+		"<p align='center'>"+$("#sago_contents").val()+"</p>"
											+	"</td>"
											+"</tr>"	
										);	
								}else if("${suimVO.suim_rpt_type2 }" == 1700){ //print1700_Ctrl
									$("#print1700_Ctrl").append(
											"<tr id = 'print1700_Ctrl_"+data+"'>"
											+	"<td class='td'>"
											+		"<p align='center'>"+$("#sago_regDate").val()+"</p></td>"
											+	"<td class='td'>"
											+		"<p align='center'>"+$("#sago_item").val()+"</p></td>"
											+	"<td class='td'>"
											+		"<p align='center'>"+$("#sago_contents").val()+"</p>"
											+	"</td>"
											+"</tr>"	
										);	
								}
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}//function
			);//post
		});
		/* 사고처리 과정표 1행 추가 끝 */
		
	});
	
	/* 사고처리 과정표 수정 동작 요청 시작 */
	function sagoEdit(sagoNo,regDate,item,content){
		
		$("#"+sagoNo).html("");
		$("#"+sagoNo).append(
				"<td>"
				+ "<input type='text' size='13' value = '"+regDate+"' class='classCalendar' id='sago_regDate_Edit_"+sagoNo+"'/>"
				+ "</td>"
				+ "<td>"
				+ "<input type='text' size='15' value = '"+item+"' id='sago_item_Edit_"+sagoNo+"'/>"
				+ "</td>"
				+ "<td>"
				+ "<input type='text' size='35' value = '"+content+"' id='sago_contents_Edit_"+sagoNo+"' onfocus = 'this.select()' />"
				+ "</td>"
				+ "<td>"
				+ "<img src='./resources/ls_img/btn_edite.gif' style='cursor:pointer;' onclick='sagoEditOk("+sagoNo+");'/>"
				+ "</td>"
		);
		
		$('#sago_regDate_Edit_'+sagoNo).datepicker({ 
	    	   showOn: 'button',
	    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
	    	   buttonImageOnly: true,
	    	   buttonText: "달력", 
	    	   changeMonth: true,
	    	   changeYear: true,
	    	   showButtonPanel: false
	    });
		
		$("#sago_contents_Edit_"+sagoNo).focus();
	}
	/* 사고처리 과정표 수정 동작 요청 끝 */
	
	/* 사고처리 과정표 변경 시작*/
	function sagoEditOk(sagoNo){
	
		$.post("./sagoRptUdt",
				{	
					 sagoNo 	  	:sagoNo  //
					,item	       	:$("#sago_item_Edit_"+sagoNo).val()  //
					,content       	:$("#sago_contents_Edit_"+sagoNo).val() // 
					,regDate       	:$("#sago_regDate_Edit_"+sagoNo).val() //
					
				},
				function(data,status){
					if(status == "success"){
						if(data == 0){
							alert("저장 실패하였습니다. 관리자에게 문의해 주세요.");
						}else{
							
							 $.each(data, function(index, entry) {
								 
								var regDate = entry.regDate;
								var item = entry.item;
								var content = entry.content;
							
								$("#"+sagoNo).html("");
								$("#"+sagoNo).append(
									
									  "<td>" + entry.regDate + "</td>"
									+ "<td>" + entry.item + "</td>"
									+ "<td>" + entry.content + "</td>"
									+ "<td>" + "<img src='./resources/ls_img/btn_edit_s.gif' onclick=\"sagoEdit('"+entry.sagoNo+"','"+regDate+"','"+item+"','"+content+"');\" style='cursor:pointer;'/>"
											 + "   <img src='./resources/ls_img/btn_del_s.gif' onclick='sagoDel("+entry.sagoNo+");' style='cursor:pointer;'/>"
									+ "</td>"
									
								);
								
								if("${suimVO.suim_rpt_type2 }" == 1){
									$("#print1_Ctrl_"+sagoNo).html("");
									$("#print1_Ctrl_"+sagoNo).append(
	
										"<td class='td'>"
										+	"<p align='center'>"+entry.regDate+"</p></td>"
										+"<td class='td'>"
										+	"<p align='center'>"+entry.item+"</p></td>"
										+"<td class='td'>"
										+	"<p align='center'>"+entry.content+"</p>"
										+"</td>"
									);									
								}else if("${suimVO.suim_rpt_type2 }" == 9){
									$("#print9_Ctrl_"+sagoNo).html("");
									$("#print9_Ctrl_"+sagoNo).append(
	
										"<td class='td'>"
										+	"<p align='center'>"+entry.regDate+"</p></td>"
										+"<td class='td'>"
										+	"<p align='center'>"+entry.item+"</p></td>"
										+"<td class='td'>"
										+	"<p align='center'>"+entry.content+"</p>"
										+"</td>"
									);		
								}else if("${suimVO.suim_rpt_type2 }" == 17){
									$("#print17_Ctrl_"+sagoNo).html("");
									$("#print17_Ctrl_"+sagoNo).append(
	
										"<td class='td'>"
										+	"<p align='center'>"+entry.regDate+"</p></td>"
										+"<td class='td'>"
										+	"<p align='center'>"+entry.item+"</p></td>"
										+"<td class='td'>"
										+	"<p align='center'>"+entry.content+"</p>"
										+"</td>"
									);		
								}else if("${suimVO.suim_rpt_type2 }" == 1700){
									$("#print1700_Ctrl_"+sagoNo).html("");
									$("#print1700_Ctrl_"+sagoNo).append(
	
										"<td class='td'>"
										+	"<p align='center'>"+entry.regDate+"</p></td>"
										+"<td class='td'>"
										+	"<p align='center'>"+entry.item+"</p></td>"
										+"<td class='td'>"
										+	"<p align='center'>"+entry.content+"</p>"
										+"</td>"
									);		
								}
							 });
						}
					}else{
						alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
					}
				},"json"
		);//post
	};
	/* 사고처리 과정표 변경 끝*/
	
	/* 사고처리 과정표 1행 삭제 시작 */
	function sagoDel(sagoNo){
		if(confirm("삭제하시겠습니까?")){
			
			$.post("./sagoRptDel",
					{	
						 sagoNo 	  	:sagoNo  //
						
					},
					function(data,status){
						if(status == "success"){
							if(data != 0){
								$("#"+sagoNo).html("");
								if("${suimVO.suim_rpt_type2 }" == 1){
									$("#print1_Ctrl_"+sagoNo).html("");										
								}else if("${suimVO.suim_rpt_type2 }" == 9){
									$("#print9_Ctrl_"+sagoNo).html("");	
								}else if("${suimVO.suim_rpt_type2 }" == 17){
									$("#print17_Ctrl_"+sagoNo).html("");	
								}else if("${suimVO.suim_rpt_type2 }" == 1700){
									$("#print1700_Ctrl_"+sagoNo).html("");	
								}
							}else{
								alert("시스템 오류입니다. 잠시 후 재시도 해주세요.");	
							}
						}else{
							alert("시스템 오류입니다. 잠시 후 재시도 해주세요.");
						}
					}
			);
			
		}
	}
	/* 사고처리 과정표 1행 삭제 끝*/
	
	/* 사고처리 과정표 인쇄 시작 */
	function sagoPrint(rptNo){
		
		var cw=screen.availWidth;
		var ch=screen.availHeight;
		
		var sw=1010; //띄울 창의 넓이
		var sh=740;  //띄울 창의 높이
	
		var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
		var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
		
		window.open('sagoPrintPage?suimRptNo='+rptNo+'&type2=','_blank','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
	}
	/* 사고처리 과정표 인쇄 끝 */
	
	/* 사고처리 과정표 추가 영역 보이기 시작 */
	function showSagoAddArea(){

        if( !fnChkListSave()){
            alert("체크리스트 내용을 먼저 입력해 주세요.");
            fnPrgssModifyFrm();
            $("#p_amtEstimatedDamage").focus();
            return;
        }

//		$("#sagoAddAreaId").css("display","block");
//		$("#showSagoAddAreaBtn").css("display","none");
//		$("#hideSagoAddAreaBtn").css("display","block");

		$("#sagoAddAreaId").show();
		$("#showSagoAddAreaBtn").hide();
		$("#hideSagoAddAreaBtn").show();

		/* 일자에 오늘 날짜 자동 입력 */
		var currentDate = new Date();
		var month = currentDate.getMonth() + 1+"";
		
		if(month.length ==1){
			month = "0"+month;
		}
		
		var day = currentDate.getDate() + "";
		
		if(day.length ==1){
			day = "0"+day;
		}
		
		var year = currentDate.getFullYear();
		
		var today = year+"-"+month+"-"+day;

		$("#sago_regDate").val(today);
		$('#sago_regDate').datepicker({ 
		   	   showOn: 'button',
		   	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		   	   buttonImageOnly: true,
		   	   buttonText: "달력", 
		   	   changeMonth: true,
		   	   changeYear: true,
		   	   showButtonPanel: false
		   	});
		
		$("#sago_contents").focus();
	}
	/* 사고처리 과정표 추가 영역 보이기 끝*/
	
	/* 사고처리 과정표 추가 영역 숨기기 시작 */
	function hideSagoAddArea(){
		
//		$("#showSagoAddAreaBtn").css("display","block");
//		$("#hideSagoAddAreaBtn").css("display","none");
//		$("#sagoAddAreaId").css("display","none");

		$("#showSagoAddAreaBtn").show();
		$("#hideSagoAddAreaBtn").hide();
		$("#sagoAddAreaId").hide();

	}
	/* 사고처리 과정표 추가 영역 숨기기 끝 */

</script>
</head>
<body>
	<!-- 사고처리 과정표 입력 --> 
	<table align="center" style="margin-top:10px;">
		<colgroup>
			<col width="20%">
			<col width="20%">
			<col width="40%">
			<col width="20%">
		</colgroup>
		<thead>
			<tr>
				<td colspan="4">
					<b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;" /> 2-2. 사고처리 과정표</b>
					<img src="./resources/ls_img/btn_print_s.gif" title="인쇄" style="cursor:pointer;" onclick="sagoPrint('${suimRptNoFromServer}');"/>
					<c:if test="${(suimVO.suimRptState eq '0' and suimVO.editYN > 0) or endModFlag > 0}">
						<img src="./resources/ls_img/btn_add_s.gif" title="추가" id = "showSagoAddAreaBtn" style="float:right; cursor:pointer; margin-right:10px;" onclick="showSagoAddArea();"/>
						<img src="./resources/ls_img/btn_close.gif" title="추가 취소" id = "hideSagoAddAreaBtn" style="float:right; cursor:pointer; margin-right:10px; display:none;" onclick="hideSagoAddArea();"/>
					</c:if>
				</td>
			</tr>
			<tr>
				<th>일자</th>
				<th>항목</th>
				<th >처리내용</th>
				<th >비고</th>
			</tr>
		</thead>
		<tbody align="center" id = "sagoList">
			<c:forEach items="${sagoList}" var="sagoRptVo">
				<tr id = "${sagoRptVo.sagoNo}" >
					<td>
						${sagoRptVo.regDate}
					</td>
					<td>
						${sagoRptVo.item}
					</td>
					<td>
						${sagoRptVo.content}
					</td>
					<td>
					<c:choose>
						<c:when test="${suimVO.suimRptState eq '0' or suimVO.suimRptState eq '11' }">
							<c:choose>
								<c:when test="${suimVO.editYN > 0 or endModFlag > 0}">
									<img src="./resources/ls_img/btn_edit_s.gif" onclick="sagoEdit('${sagoRptVo.sagoNo}','${sagoRptVo.regDate}','${sagoRptVo.item}','${sagoRptVo.content}');" style='cursor:pointer;' />
									<img src="./resources/ls_img/btn_del_s.gif"onclick="sagoDel('${sagoRptVo.sagoNo}');" style='cursor:pointer;' />
								</c:when>
								<c:otherwise>
									-
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<!-- 종결 후 수정 -->
							<c:choose>
								<c:when test="${endModFlag > 0}">
									<img src="./resources/ls_img/btn_edit_s.gif" onclick="sagoEdit('${sagoRptVo.sagoNo}','${sagoRptVo.regDate}','${sagoRptVo.item}','${sagoRptVo.content}');" style='cursor:pointer;' />
									<img src="./resources/ls_img/btn_del_s.gif"onclick="sagoDel('${sagoRptVo.sagoNo}');" style='cursor:pointer;' />
								</c:when>
								<c:otherwise>
									-
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
					</td>
				</tr>
			</c:forEach>
		</tbody>
		<tr align="center" style="display:none;" id = "sagoAddAreaId">
			<td>
				<input type="text" size="13" id="sago_regDate"/>
			</td>
			<td>
				<input type="text" size="15"  id="sago_item"/>
			</td>
			<td>
				<input type="text" size="35" id="sago_contents"/>
			</td>
			<td>
				<img src="./resources/ls_img/btn_add.gif" id="sagoRptInsBtn" style="cursor:pointer;"/>
			</td>
		</tr>	
	</table>
</body>