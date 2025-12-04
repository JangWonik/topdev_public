<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	
	<script>
		$(document).ready(function(){
			
			$("#editeBody16_2ContentsCancelBtnId").click(function(){
				
				$(".print16_2SpanClass").show();
				$(".print16_2InputClass").hide();
				
				$("#editeBody16_2ContentsCancelBtnId").hide();
				$("#editeBody16_2ContentsOkBtnId").hide();
				
				$("#rptBody16_2UdtActionBtnId").show();
			});
			
			/* 1.계약사항 update */ 
			$("#editeBody16_2ContentsOkBtnId").click(function(){
				
				$.post("./editeBody16_2Ok",
						{	
							 rptPrintNo					:"${suimRptBody16_1267Vo.rptPrintNo}"
							,claimDtl2  				:$("#claimDtl2").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')					//보험시기
							,complaintAvoidActivity2  	:$("#complaintAvoidActivity2").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')	//보험종기
							,inspectResult2  			:$("#inspectResult2").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')				//계약상태
							,contractKeepYn2  			:$("#contractKeepYn2").val()			//사고유형
							,minwonDtl2  				:$("#minwonDtl2").val()					//진단코드
							
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("불러오기를 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									$(".print16_2SpanClass").css("display","inline");
									$(".print16_2InputClass").css("display","none");	
									$("#editeBody16_2ContentsCancelBtnId").css("display","none");
									$("#editeBody16_2ContentsOkBtnId").css("display","none");
									$("#rptBody16_2UdtActionBtnId").css("display","inline");
									
									$("#claimDtl2Span").html($("#claimDtl2").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#complaintAvoidActivity2Span").html($("#complaintAvoidActivity2").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#inspectResult2Span").html($("#inspectResult2").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#contractKeepYn2Span").html($("#contractKeepYn2").val());
									$("#minwonDtl2Span").html($("#minwonDtl2").val());
									
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			});
		});
		
		/* Print_16_2 수정동작 */
		function rptBody16_2UdtAction(){
			
			$("#rptBody16_2UdtActionBtnId").hide();
			$(".print16_2SpanClass").hide();
			$(".print16_2InputClass").show();
			
			$("#editeBody16_2ContentsCancelBtnId").show();
			$("#editeBody16_2ContentsOkBtnId").show();
		}
	</script>
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
	<table align="center" cellpadding="0" cellspacing="0" width="100%" bgcolor="white">
		<tr>
			<td width="50%" height="30">
				<p><font color="#113F7D">▣ <b>청구내용 및 조사결과</b></font></p>
			</td>
			<td width="50%" height="30">
				<p align="right">
					<c:if test="${suimVO.suimRptState eq 0}">
						<img style = "cursor:pointer; float:right; " id = "rptBody16_2UdtActionBtnId"src="./resources/ls_img/btn_edite.gif" onclick="rptBody16_2UdtAction();"/>
						<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody16_2ContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
						<img src="./resources/ls_img/icon_write.gif" title="저장" id = "editeBody16_2ContentsOkBtnId" style="float:right; display:none; cursor:pointer; margin-right:5px;" />
					</c:if>
				</p> 
			</td>
		</tr>
		<tr><td width="100%" height="1" colspan="2" bgcolor="#0077B1"></td></tr>
	</table>
	<table align="center" width="640">
		<tr>
			<td width="100" align="center" bgcolor="#EFEFEF" class="td"><p>청구내용<br>(조사한 내용을<br>상세히 기술)</p></td>
			<td class="td" colspan="4">
				<p>
					<span class="print16_2SpanClass" id = "claimDtl2Span">${ suimRptBody16_1267Vo.claimDtl2Span}</span>
								<textarea style="width:99%;height:55px;overflow:visible; display:none;" 
                   			class="print16_2InputClass" id = "claimDtl2">${suimRptBody16_1267Vo.claimDtl2}</textarea>
				</p>
			</td>
		</tr>
		<tr>
			<td width="100" align="center" bgcolor="#EFEFEF" class="td"><p>민원예방활동</p></td>
			<td class="td" colspan="4">
				<p>
					<span class="print16_2SpanClass" id = "complaintAvoidActivity2Span">${ suimRptBody16_1267Vo.complaintAvoidActivity2Span}</span>
								<textarea style="width:99%;height:55px;overflow:visible; display:none;" 
                   			class="print16_2InputClass" id = "complaintAvoidActivity2">${suimRptBody16_1267Vo.complaintAvoidActivity2}</textarea>
				</p>
			</td>
		</tr>
		<tr>
			<td width="100" align="center" bgcolor="#EFEFEF" class="td" rowspan="2"><p>조사자의견<br>및<br>조사결과</p></td>
			<td class="td" colspan="4">
				<p>
					<span class="print16_2SpanClass" id = "inspectResult2Span">${ suimRptBody16_1267Vo.inspectResult2Span}</span>
								<textarea style="width:99%;height:55px;overflow:visible; display:none;" 
                   			class="print16_2InputClass" id = "inspectResult2">${suimRptBody16_1267Vo.inspectResult2}</textarea>
				</p>
			</td>
		</tr>
		<tr align="center">
			<td bgcolor="#EFEFEF" class="td" nowrap><p>계약유지</p></td>
			<td class="td">
				<p>
					<span class="print16_2SpanClass" id = "contractKeepYn2Span">${ suimRptBody16_1267Vo.contractKeepYn2Span}</span>
					<input type="text" size="15" style="display:none;" 
					id = "contractKeepYn2" class="print16_2InputClass" value = "${suimRptBody16_1267Vo.contractKeepYn2}" />
				</p>
			</td>
			<td bgcolor="#EFEFEF" class="td" nowrap><p>민원여부</p></td>
			<td class="td">
				<p>
					<span class="print16_2SpanClass" id = "minwonDtl2Span">${ suimRptBody16_1267Vo.minwonDtl2Span}</span>
					<input type="text" size="15" style="display:none;" 
					id = "minwonDtl2" class="print16_2InputClass" value = "${suimRptBody16_1267Vo.minwonDtl2}" />
				</p>
			</td>
		</tr>
	</table>
	<p>&nbsp;</p>
</body>