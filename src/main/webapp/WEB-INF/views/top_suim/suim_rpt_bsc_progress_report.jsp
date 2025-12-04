<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("#addPrgssRptBtn").click(function(){
			
			if($("#rptUserNameHidden").val() != 0){
				var cw=screen.availWidth;
				var ch=screen.availHeight;
				
				var sw=810; //띄울 창의 넓이
				var sh=740;  //띄울 창의 높이
		
				var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
				var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
				
				window.open('siteRptAdd?suimRptNo='+$("#suimRptNo").val()+'&interimFlag=prgss','_blank','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			}else{
				alert("처리 담당자 미배당 상태입니다.");
			}
			
		});
		
	});
	
	function prgssRptEdite(rptInterimNo){
		
		var cw=screen.availWidth;
		var ch=screen.availHeight;
		
		var sw=810; //띄울 창의 넓이
		var sh=740;  //띄울 창의 높이

		var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
		var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
		
		window.open('siteRptEdite?suimRptNo='+$("#suimRptNo").val()+'&rptSiteNo='+rptInterimNo+'&interimFlag=prgss','_blank','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
	}
	
	function prgssRptDel(rptSiteNo){
		if(confirm("삭제하시겠습니까?")){
			
			$.post("./siteRptDel",
					{	
						rptSiteNo 	  	:rptSiteNo  //
						
					},
					function(data,status){
						if(status == "success"){
							if(data != 0){
								$("#interim_"+rptSiteNo).html("");
								$("#interimFileUploadArea_"+rptSiteNo).html("");
								$("#interimFileDownArea_"+rptSiteNo).html("");
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
	
	function printPrgssWordBtn(rptSiteNo){
		
		var cw=screen.availWidth;
		var ch=screen.availHeight;
		
		var sw=1010; //띄울 창의 넓이
		var sh=740;  //띄울 창의 높이
	
		var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
		var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
		
		window.open('interimPrintPage?suimRptNo='+$("#suimRptNo").val()+'&rptSiteNo='+rptSiteNo+'&interimFlag=prgss&type=word','_blank','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
	}
	
	function printPrgssBtn(rptSiteNo){
		
		var cw=screen.availWidth;
		var ch=screen.availHeight;
		
		var sw=1010; //띄울 창의 넓이
		var sh=740;  //띄울 창의 높이
	
		var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
		var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
		
		window.open('interimPrintPage?suimRptNo='+$("#suimRptNo").val()+'&rptSiteNo='+rptSiteNo+'&interimFlag=prgss&type=print','_blank','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
	}
	
	/* 중간보고서 파일 업로드 */
	function interimRptFileUp(rptSiteNo){
		
        //$("#interimFileUploadTd_"+rptSiteNo).css("display","block");
        $("#interimFileUploadTd_"+rptSiteNo).show();

	}
	
</script>
<div style="margin-top:10px;">
    <table align="center">
        <colgroup>
            <col width="20%">
            <col width="20%">
            <col width="20%">
            <col width="40%">
        </colgroup>
        <thead>
        <tr>
            <td colspan="4">
                <b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;" /> 진행경과보고서</b>
                <c:if test="${(suimVO.suimRptState eq '0' and suimVO.editYN > 0) or endModFlag > 0}">
                    <img src="./resources/ls_img/btn_add_s.gif" title="진행경과보고서 추가" id = "addPrgssRptBtn" style="float:right; cursor:pointer; margin-right:10px;" />
                </c:if>
            </td>
        </tr>
        <tr>
            <th>작성일</th>
            <th>제출일</th>
            <th>보고서제출예정일자</th>
            <th>비고</th>
        </tr>
        </thead>
        <tbody align="center" id = "interimRptMainBody" >
        <c:forEach items="${prgssList}" var="interimVo">
            <tr id = "interim_${interimVo.rptSiteNo }">
                <td>${interimVo.siteDate}</td>
                <td id = "interimSubDate_${interimVo.rptSiteNo }">${interimVo.siteDate}</td>
                <td>${interimVo.submitPrarnDate}</td>
                <td>
                    <c:choose>
                        <c:when test="${suimVO.editYN > 0 or endModFlag > 0}">
                            <img src="./resources/ls_img/btn_word_s.gif" title="MS Word 인쇄" style="cursor:pointer;" onclick="printPrgssWordBtn('${interimVo.rptSiteNo}');"/>
                            <img src="./resources/ls_img/btn_print_s.gif" title="인쇄" style="cursor:pointer;" onclick="printPrgssBtn('${interimVo.rptSiteNo}');"/>
                        </c:when>
                        <c:otherwise>
                            -
                        </c:otherwise>
                    </c:choose>

                    <c:choose>
                        <c:when test="${(suimVO.suimRptState eq '0' and suimVO.editYN > 0) or endModFlag > 0}">
                            <img src="./resources/ls_img/btn_edit_s.gif" title="중간보고서 수정" style= "cursor:pointer;" id = "interimRptEditeBtn" onclick="prgssRptEdite('${interimVo.rptSiteNo}');" />
                            <img src='./resources/ls_img/btn_del_s.gif' title="중간보고서 삭제" style="cursor:pointer;" id = "interimRptDelBtn" onclick="prgssRptDel('${interimVo.rptSiteNo}');" />
                            <c:if test="${interimVo.fileName eq ''}">
                                <img src='./resources/ls_img/icon_disket.gif' title="중간보고서 제출" style="cursor:pointer;" id = "interimRptFileUpBtnID_${interimVo.rptSiteNo}" onclick="interimRptFileUp('${interimVo.rptSiteNo}');" />
                            </c:if>
                            <c:if test="${interimVo.fileName ne ''}">
                                <img src='./resources/ls_img/icon_disket.gif' title="중간보고서 제출" style="cursor:pointer; display:none;" id = "interimRptFileUpBtnID_${interimVo.rptSiteNo}" onclick="interimRptFileUp('${interimVo.rptSiteNo}');" />
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            -
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>

            <tr id ="interimFileUploadArea_${interimVo.rptSiteNo}" >
                <td colspan="4" id = "interimFileUploadTd_${interimVo.rptSiteNo}" style ="display:none;">
                    <%@include file="../include/uploadform_progressFile.jsp"%>
                </td>
            </tr>
            <tr id ='interimFileDownArea_${interimVo.rptSiteNo}'>
                <c:if test="${interimVo.fileName ne ''}">
                    <td align='center' colspan='4' > <%-- id ='siteFileDownAreaTd_${siteVo.rptSiteNo}'  --%>
                        <a href='fileDownload?key=${interimVo.rptSiteNo}&type=siteInterim'>
                                ${interimVo.fileName}
                        </a>
                        <img src='./resources/ls_img/btn_del_s.gif' id = 'interimFileDelBtn_${interimVo.rptSiteNo}' onclick="interimFileDel('${interimVo.rptSiteNo}');" style='cursor:pointer; margin-left:5px;'/>
                    </td>
                </c:if>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
