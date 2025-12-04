<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<script type="text/javascript">
	$(document).ready(function(){
		
		/* 현재 진행 상황 추가 시작 */
		$("#nowRptInsBtn").click(function(){
			
            if($("#now_regDate").val() == "") {
                alert("일자를 입력해 주세요.");
                $("#now_regDate").focus();
                return;
            }

            if(!$("#now_regDate").val().isValidDate()) {
                alert("날짜 형식이 올바르지 않습니다.");
                $("#now_regDate").focus();
                return;
            }

			if($("#now_contents").val() == ''){
				alert("내용을 입력하세요.");
                $("#now_contents").focus();
				return;
			}

            if($("#closePrarnDate").val() == "") {
                alert("종료예정일을 입력해 주세요.");
                $("#closePrarnDate").focus();
                return;
            }

            if(!$("#closePrarnDate").val().isValidDate()) {
                alert("종료예정일 날짜 형식이 올바르지 않습니다.");
                $("#closePrarnDate").focus();
                return;
            }

			$.post("./nowRptIns",
					{	
						 suimRptNo   	:$("#suimRptNo").val()  //
						,content       	:$("#now_contents").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;') //
						,regDate       	:$("#now_regDate").val() //
                        ,closePrarnDate :$("#closePrarnDate").val()
						
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("저장 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{
								 $.each(data, function(index, entry) {
									alert("저장 완료");
									
									$("#nowList").append(
										"<tr id='now_"+entry.nowNo+"'>"
											+ "<td>" + entry.regDate + "</td>"
											+ "<td align='left'>" + decodeURIComponent(entry.content) + "</td>"
                                            + "<td>" + entry.closePrarnDate + "</td>"
											+ "<td>" + "<img src='./resources/ls_img/btn_edit_s.gif' onclick=\"nowEdit('"+entry.nowNo+"','"+entry.regDate+"','"+entry.content+"','"+entry.closePrarnDate+"');\" style='cursor:pointer;'/>"
													 + "   <img src='./resources/ls_img/btn_del_s.gif' onclick='nowDel("+entry.nowNo+");' style='cursor:pointer;'/>"
											+ "</td>"
										+"</tr>"
									);
								 });
								 
								 //$("#nowAddAreaId").css("display","none");
								 //$("#hideNowAddAreaBtn").css("display","none");
								 //$("#showNowAddAreaBtn").css("display","block");
								 $("#nowAddAreaId").hide();
								 $("#hideNowAddAreaBtn").hide();
								 $("#showNowAddAreaBtn").show();
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					},"json"
			);//post
		});
		/* 현재 진행 상황  추가 끝 */
		
	});
	
	/* 현재 진행 상황 수정 동작 요청 시작 */
	function nowEdit(nowNo,regDate, content, closePrarnDate){
        var contents = decodeURIComponent(content);
        var encContents = contents.replace(/<br>/g,"\n").replace(/&nbsp;/g,"\u0020");

		$("#now_"+nowNo).html("");
		$("#now_"+nowNo).append(
				"<td>"
				+ "<input type='text' style='width: 80%;' value = '"+regDate+"' id='now_regDate_Edit_"+nowNo+"' onkeypress='fnDateFormat(this);'/>"
				+ "</td>"
				+ "<td>"
				+ "<textarea id='now_contents_Edit_"+nowNo+"' rows='5' style='width: 100%;'>"+decodeURIComponent(encContents)+"</textarea>"
				+ "</td>"
                + "<td>"
                + "<input type='text' style='width: 80%;' value = '"+closePrarnDate+"' id='now_closePrarnDate_Edit_"+nowNo+"' onkeypress='fnDateFormat(this);'/>"
                + "</td>"
				+ "<td>"
				+ "<img src='./resources/ls_img/btn_edite.gif' style='cursor:pointer;' onclick='nowEditOk("+nowNo+");'/>"
				+ "</td>"
		);
		
		$('#now_regDate_Edit_'+nowNo).datepicker({ 
	    	   showOn: 'button',
	    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
	    	   buttonImageOnly: true,
	    	   buttonText: "달력", 
	    	   changeMonth: true,
	    	   changeYear: true,
	    	   showButtonPanel: false
	    });

		$('#now_closePrarnDate_Edit_'+nowNo).datepicker({
	    	   showOn: 'button',
	    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
	    	   buttonImageOnly: true,
	    	   buttonText: "달력",
	    	   changeMonth: true,
	    	   changeYear: true,
	    	   showButtonPanel: false
	    });

		$("#now_contents_Edit_"+nowNo).focus();
	}
	/* 현재 진행 상황 수정 동작 요청 끝 */
	
	/* 현재 진행 상황 변경 시작*/
	function nowEditOk(nowNo){

        if($("#now_regDate_Edit_"+nowNo).val() == "") {
            alert("일자를 입력해 주세요.");
            $("#now_regDate_Edit_"+nowNo).focus();
            return;
        }

        if(!$("#now_regDate_Edit_"+nowNo).val().isValidDate()) {
            alert("날짜 형식이 올바르지 않습니다.");
            $("#now_regDate_Edit_"+nowNo).focus();
            return;
        }

        if($("#now_contents_Edit_"+nowNo).val() == ''){
            alert("내용을 입력하세요.");
            $("#now_contents_Edit_"+nowNo).focus();
            return;
        }

        if($("#now_closePrarnDate_Edit_"+nowNo).val() == "") {
            alert("종료예정일을 입력해 주세요.");
            $("#now_closePrarnDate_Edit_"+nowNo).focus();
            return;
        }

        if(!$("#now_closePrarnDate_Edit_"+nowNo).val().isValidDate()) {
            alert("종료예정일 날짜 형식이 올바르지 않습니다.");
            $("#now_closePrarnDate_Edit_"+nowNo).focus();
            return;
        }


		
		$.post("./nowRptUdt",
				{	
					 nowNo 	  		:nowNo  //
					,content       	:$("#now_contents_Edit_"+nowNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;') //
					,regDate       	:$("#now_regDate_Edit_"+nowNo).val() //
                    ,closePrarnDate :$("#now_closePrarnDate_Edit_"+nowNo).val() //
					
				},
				function(data,status){
					if(status == "success"){
						if(data == 0){
							alert("저장 실패하였습니다. 관리자에게 문의해 주세요.");
						}else{
							
							 $.each(data, function(index, entry) {
								 
								var regDate = entry.regDate;
								var content = entry.content;
                                var closePrarnDate = entry.closePrarnDate;
							
								$("#now_"+nowNo).html("");
								$("#now_"+nowNo).append(
									
									  "<td>" + entry.regDate + "</td>"
									+ "<td align='left'>" + decodeURIComponent(entry.content) + "</td>"
                                    + "<td>" + entry.closePrarnDate + "</td>"
									+ "<td>" + "<img src='./resources/ls_img/btn_edit_s.gif' onclick=\"nowEdit('"+entry.nowNo+"','"+regDate+"','"+content+"','"+closePrarnDate+"');\" style='cursor:pointer;'/>"
											 + "   <img src='./resources/ls_img/btn_del_s.gif' onclick='nowDel("+entry.nowNo+");' style='cursor:pointer;'/>"
									+ "</td>"
									
								);
							 });
						}
					}else{
						alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
					}
				},"json"
		);//post
	};
	/* 현재 진행 상황 변경 끝*/
	
	/* 현재 진행 상황 삭제 시작 */
	function nowDel(nowNo){
		if(confirm("삭제하시겠습니까?")){
			
			$.post("./nowRptDel",
					{	
						nowNo 	  	:nowNo  //
						
					},
					function(data,status){
						if(status == "success"){
							if(data != 0){
								$("#now_"+nowNo).html("");									
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
	/* 현재 진행 상황 1행 삭제 끝*/
	
	function showNowAddArea(){
		//$("#nowAddAreaId").css("display","block");
		//$("#showNowAddAreaBtn").css("display","none");
		//$("#hideNowAddAreaBtn").css("display","block");

		if( !fnChkListSave()){
			alert("체크리스트 내용을 먼저 입력해 주세요.");
			fnPrgssModifyFrm();
			$("#p_amtEstimatedDamage").focus();
			return;
		}

		$("#nowAddAreaId").show();
		$("#showNowAddAreaBtn").hide();
		$("#hideNowAddAreaBtn").show();

		/* 일자에 오늘 날짜 자동 입력 */
		var currentDate = new Date();
		var month = currentDate.getMonth() + 1 + "";
		
		if(month.length ==1){
			month = "0"+month;
		}
		
		var day = currentDate.getDate() + "";
		
		if(day.length ==1){
			day = "0"+day;
		}
		
		var year = currentDate.getFullYear();
		
		var today = year+"-"+month+"-"+day;

		$("#now_regDate").val(today);
		$('#now_regDate').datepicker({
	    	   showOn: 'button',
	    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
	    	   buttonImageOnly: true,
	    	   buttonText: "달력",
	    	   changeMonth: true,
	    	   changeYear: true,
	    	   showButtonPanel: false
        });
		$('#closePrarnDate').datepicker({
	    	   showOn: 'button',
	    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
	    	   buttonImageOnly: true,
	    	   buttonText: "달력",
	    	   changeMonth: true,
	    	   changeYear: true,
	    	   showButtonPanel: false
        });
		$("#now_contents").focus();
	}
	
	function hideNowAddArea(){
		
		//$("#showNowAddAreaBtn").css("display","block");
		//$("#hideNowAddAreaBtn").css("display","none");
		//$("#nowAddAreaId").css("display","none");

		$("#showNowAddAreaBtn").show();
		$("#hideNowAddAreaBtn").hide();
		$("#nowAddAreaId").hide();

	}

    function fnDateFormat(that){
        if (event.keyCode == 8){
            return false;
        }
        if($(that).val().length == 4 || $(that).val().length == 7){
            $(that).val($(that).val()+"-")
        }
    }
	
</script>
</head>
<body>
	<!-- 현재 진행 상황 입력 --> 
	<table align="center" style="margin-top:10px;">
		<colgroup>
			<col width="20%">
			<col width="40%">
			<col width="20%">
			<col width="20%">
		</colgroup>
		<thead>
			<tr>
				<td colspan="4">
					<b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;" /> 2-3. 미결사유</b>
					<c:if test="${(suimVO.suimRptState eq '0' and suimVO.editYN > 0) or endModFlag > 0}">
						<img src="./resources/ls_img/btn_add_s.gif" title="추가" id = "showNowAddAreaBtn" style="float:right; cursor:pointer; margin-right:10px;" onclick="showNowAddArea();"/>
						<img src="./resources/ls_img/btn_close.gif" title="추가 취소" id = "hideNowAddAreaBtn" style="float:right; cursor:pointer; margin-right:10px; display:none;" onclick="hideNowAddArea();"/>
					</c:if>
				</td>
			</tr>
			<tr>
				<th>일자</th>
				<th >내용</th>
				<th >종결예정일</th>
				<th >비고</th>
			</tr>
		</thead>
		<tbody align="center" id = "nowList">
			<c:forEach items="${nowList}" var="nowRptVo">
				<tr id = "now_${nowRptVo.nowNo}" >
					<td>${nowRptVo.regDate}</td>
					<td align="left">${nowRptVo.content}</td>
					<td>${nowRptVo.closePrarnDate}</td>
					<td>
					
					<c:choose>
						<c:when test="${suimVO.suimRptState eq '0' or suimVO.suimRptState eq '11' }">
							<c:choose>
								<c:when test="${suimVO.editYN > 0 or endModFlag > 0}">
									<img src="./resources/ls_img/btn_edit_s.gif" onclick="nowEdit('${nowRptVo.nowNo}','${nowRptVo.regDate}','${nowRptVo.content}', '${nowRptVo.closePrarnDate}');" style='cursor:pointer;' />
									<img src="./resources/ls_img/btn_del_s.gif"onclick="nowDel('${nowRptVo.nowNo}');" style='cursor:pointer;' />
								</c:when>
								<c:otherwise>
									-
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${endModFlag > 0}">
									<img src="./resources/ls_img/btn_edit_s.gif" onclick="nowEdit('${nowRptVo.nowNo}','${nowRptVo.regDate}','${nowRptVo.content}', '${nowRptVo.closePrarnDate}');" style='cursor:pointer;' />
									<img src="./resources/ls_img/btn_del_s.gif"onclick="nowDel('${nowRptVo.nowNo}');" style='cursor:pointer;' />
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
            <tr align="center" id = "nowAddAreaId" style="display:none;">
                <td>
                    <input type="text" id="now_regDate"  style="width: 80%;" maxlength="10" onkeypress="fnDateFormat(this);"/>
                </td>
                <td>
                    <textarea type="text"  rows='5' style='width: 100%;' id="now_contents"></textarea>
                </td>
                <td>
                    <input type="text" id="closePrarnDate" style="width: 80%;" maxlength="10" onkeypress="fnDateFormat(this);"/>
                </td>
                <td>
                    <img src="./resources/ls_img/btn_add.gif" id="nowRptInsBtn" style="cursor:pointer;"/>
                </td>
            </tr>
        </tbody>
	</table>