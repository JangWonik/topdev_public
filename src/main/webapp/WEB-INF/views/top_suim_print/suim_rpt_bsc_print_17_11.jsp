<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%
    pageContext.setAttribute("cr", "\r"); //Space
    pageContext.setAttribute("cn", "\n"); //Enter
    pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
    pageContext.setAttribute("br", "<br/>"); //br 태그
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
	<script>
		$(document).ready(function(){
			
			$("input:radio[name='checkTerms11']:radio[value='${suimRptBody17_1356891112Vo.checkTerms11}']").prop('checked', true);
			$("input:radio[name='checkExplain11']:radio[value='${suimRptBody17_1356891112Vo.checkExplain11}']").prop('checked', true);
			$("input:radio[name='checkApply11']:radio[value='${suimRptBody17_1356891112Vo.checkApply11}']").prop('checked', true);
			$("input:radio[name='checkDoc11']:radio[value='${suimRptBody17_1356891112Vo.checkDoc11}']").prop('checked', true);
			$("input:radio[name='checkFigure11']:radio[value='${suimRptBody17_1356891112Vo.checkFigure11}']").prop('checked', true);
			$("input:radio[name='checkDis11']:radio[value='${suimRptBody17_1356891112Vo.checkDis11}']").prop('checked', true);
			$("input:radio[name='checkPrecedent11']:radio[value='${suimRptBody17_1356891112Vo.checkPrecedent11}']").prop('checked', true);
			$("input:radio[name='checkReYn11']:radio[value='${suimRptBody17_1356891112Vo.checkReYn11}']").prop('checked', true);
			
			/* 1. 현장조사결과 체크리스트 취소하기 */
			$("#editeBody17_11ContentsCancelBtnId").click(function(){
				
				//$(".print17_11SpanClass").css("display","inline");
				//$(".print17_11InputClass").css("disabled","disabled");
				$(".radioBtns").prop("disabled",true);	
				$("#editeBody17_11ContentsCancelBtnId").css("display","none");
				$("#editeBody17_11ContentsOkBtnId").css("display","none");
				$("#rptBody17_11UdtActionBtn").css("display","inline");
				
			});
			
			/* 현장조사결과 체크리스트 수정 Ok 하기 */
			$("#editeBody17_11ContentsOkBtnId").click(function(){
				
				if($("input:radio[name='checkTerms11']:checked").val() == 0  ||
				   $("input:radio[name='checkExplain11']:checked").val() == 0 ||
				   $("input:radio[name='checkApply11']:checked").val() == 0 ||
				   $("input:radio[name='checkDoc11']:checked").val() == 0 ||
				   $("input:radio[name='checkFigure11']:checked").val() == 0 ||
				   $("input:radio[name='checkDis11']:checked").val() == 0 ||
				   $("input:radio[name='checkPrecedent11']:checked").val() == 0 ||
				   $("input:radio[name='checkReYn11']:checked").val() == 0 ){
				
					alert("모두 체크 하셔야 합니다.");
					return;
				}
				
				$.post("./editeBody17_11Ok",
						{	
							 suimRptNo				: "${suimRptBody17_1356891112Vo.suimRptNo}"
							,checkTerms11 			: $("input:radio[name='checkTerms11']:checked").val()
							,checkExplain11 		: $("input:radio[name='checkExplain11']:checked").val()
							,checkApply11 			: $("input:radio[name='checkApply11']:checked").val()
							,checkDoc11 			: $("input:radio[name='checkDoc11']:checked").val()
							,checkFigure11 			: $("input:radio[name='checkFigure11']:checked").val()
							,checkDis11 			: $("input:radio[name='checkDis11']:checked").val()
							,checkPrecedent11 		: $("input:radio[name='checkPrecedent11']:checked").val()
							,checkReYn11 			: $("input:radio[name='checkReYn11']:checked").val()
							
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									 
									$("#editeBody17_11ContentsCancelBtnId").css("display","none");
									$("#editeBody17_11ContentsOkBtnId").css("display","none");
									$("#rptBody17_11UdtActionBtn").css("display","inline");
									
									$(".radioBtns").prop("disabled",true);
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			});
			
		});
		
		function rptBody17_11UdtAction(){
			
			$(".radioBtns").prop("disabled",false);
			$("#rptBody17_11UdtActionBtn").css("display","none");
			$("#editeBody17_11ContentsCancelBtnId").css("display","inline");
			$("#editeBody17_11ContentsOkBtnId").css("display","inline");
			
		}
	</script>
	
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
        <hr size="1" noshade color="black">
		<table align="center" cellpadding="0" cellspacing="0" width="640">
           <tr>
	           <td height="25" width="50%">
					<p class="p2"><B>11. 현장조사결과 체크리스트</B></p>
	           </td>
	           <td height="25" width="50%">
					<p align="right">
					<c:if test="${suimVO.suimRptState eq 0}">
						<img style = "cursor:pointer; float:right; " id= "rptBody17_11UdtActionBtn" src="./resources/ls_img/btn_edite.gif" onclick="rptBody17_11UdtAction();"/>
						<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody17_11ContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
						<img src="./resources/ls_img/icon_write.gif" title="저장" id = "editeBody17_11ContentsOkBtnId" style="float:right; display:none; cursor:pointer; margin-right:5px;" />
					</c:if>
					</p>
	           </td>
	       </tr>
	    </table>
	<table cellpadding="0" cellspacing="0" align="center" width="640">
		<tr>
	       <td bgcolor="#ECECEC" class="td" width="225">
				<p align="center"><B>항목</B></p>
	       </td>
	       <td bgcolor="#ECECEC" class="td" width="20">
	            <p align="center"><B>無</B></p>
	       </td>
	       <td class="td" bgcolor="#ECECEC" width="240">
				<p align="center"><B>확인사항</B></p>
	       </td>
		</tr>
		<tr>
		    <td class="td" >
				<p>
					약관전달 여부
	            </p>
		    </td>
		    <td class="td" align="center">
				<p>
					<input type="radio" disabled="disabled" class="radioBtns"  name="checkTerms11" value="0"/>
	            </p>
		    </td>
		    <td class="td" >
				<p>
					<input type="radio" disabled="disabled" class="radioBtns" name="checkTerms11" value="1"/>적정
					<input type="radio" disabled="disabled" class="radioBtns" name="checkTerms11" value="2"/>우편
					<input type="radio" disabled="disabled" class="radioBtns" name="checkTerms11" value="3"/>확인안됨
	            </p>
		    </td>
		</tr>
		<tr>
		    <td class="td">
				<p>
					상품판매시 면책약관 설명방법
	            </p>
		    </td>
		    <td class="td" align="center">
				<p>
					<input type="radio" disabled="disabled" class="radioBtns" name="checkExplain11" value="0"/>
	            </p>
		    </td>
		    <td class="td">
				<p>
					<input type="radio" disabled="disabled" class="radioBtns" name="checkExplain11" value="1"/>면담
					<input type="radio" disabled="disabled" class="radioBtns" name="checkExplain11" value="2"/>유선
					<input type="radio" disabled="disabled" class="radioBtns" name="checkExplain11" value="3"/>인터넷
	            </p>
		    </td>
		</tr>
		<tr>
		    <td class="td">
				<p>
					면책약관 적용의 합리성
	            </p>
		    </td>
		   	<td class="td" align="center">
				<p>
					<input type="radio" disabled="disabled" class="radioBtns" name="checkApply11" value="0"/>
	            </p>
		    </td>
		    <td class="td">
				<p>
					<input type="radio" disabled="disabled" class="radioBtns" name="checkApply11" value="1"/>적정
					<input type="radio" disabled="disabled" class="radioBtns" name="checkApply11" value="2"/>보험사 유리
					<input type="radio" disabled="disabled" class="radioBtns" name="checkApply11" value="3"/>소비자 유리
	            </p>
		    </td>
		</tr>
		<tr>
		    <td class="td">
				<p>
					면부책 판단 구비서류 적정여부
	            </p>
		    </td>
		    <td class="td" align="center">
				<p>
					<input type="radio" disabled="disabled" class="radioBtns" name="checkDoc11" value="0"/>
	            </p>
		    </td>
		    <td class="td">
				<p>
					<input type="radio" disabled="disabled" class="radioBtns" name="checkDoc11" value="1"/>적정
					<input type="radio" disabled="disabled" class="radioBtns" name="checkDoc11" value="2"/>일부미흡
					<input type="radio" disabled="disabled" class="radioBtns" name="checkDoc11" value="3"/>미흡
	            </p>
		    </td>
		</tr>
		<tr>
		    <td class="td">
				<p>
					면책약관의 이해도
	            </p>
		    </td>
		    <td class="td" align="center">
				<p>
					<input type="radio" disabled="disabled" class="radioBtns" name="checkFigure11" value="0"/>
	            </p>
		    </td>
		    <td class="td">
				<p>
					<input type="radio" disabled="disabled" class="radioBtns" name="checkFigure11" value="1"/>높음
					<input type="radio" disabled="disabled" class="radioBtns" name="checkFigure11" value="2"/>보통
					<input type="radio" disabled="disabled" class="radioBtns" name="checkFigure11" value="3"/>낮음
	            </p>
		    </td>
		</tr>
		<tr>
		    <td class="td">
				<p>
					작성자 불이익 원칙 적용
	            </p>
		    </td>
		    <td class="td" align="center">
				<p>
					<input type="radio" disabled="disabled" class="radioBtns" name="checkDis11" value="0"/>
	            </p>
		    </td>
		    <td class="td">
				<p>
					<input type="radio" disabled="disabled" class="radioBtns" name="checkDis11" value="1"/>적용대상
					<input type="radio" disabled="disabled" class="radioBtns" name="checkDis11" value="2"/>미대상
	            </p>
		    </td>
		</tr>
		<tr>
		    <td class="td">
				<p>
					상반되는 판례
	            </p>
		    </td>
		    <td class="td" align="center">
				<p>
					<input type="radio" disabled="disabled" class="radioBtns" name="checkPrecedent11" value="0"/>
	            </p>
		    </td>
		    <td class="td">
				<p>
					<input type="radio" disabled="disabled" class="radioBtns" disabled="disabled" class="radioBtns" name="checkPrecedent11" value="1"/>없음
					<input type="radio" disabled="disabled" class="radioBtns" name="checkPrecedent11" value="2"/>일부상반
					<input type="radio" disabled="disabled" class="radioBtns" name="checkPrecedent11" value="3"/>있음
	            </p>
		    </td>
		</tr>
		<tr>
		    <td class="td">
				<p>
					재검토 가능요소
	            </p>
		    </td>
		    <td class="td" align="center">
				<p>
					<input type="radio" disabled="disabled" class="radioBtns" name="checkReYn11" value="0"/>
	            </p>
		    </td>
		    <td class="td">
				<p>
					<input type="radio" disabled="disabled" class="radioBtns" name="checkReYn11" value="1"/>있음
					<input type="radio" disabled="disabled" class="radioBtns" name="checkReYn11" value="2"/>없음
	            </p>
		    </td>
		</tr>
	</table>
</body>
<p>&nbsp;</p>