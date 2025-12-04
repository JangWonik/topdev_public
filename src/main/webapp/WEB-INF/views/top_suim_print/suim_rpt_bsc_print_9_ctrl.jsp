<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">


<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
         <p>&nbsp;</p>
			<table cellpadding="0" cellspacing="0" width="640" align="center">
				<tr>
					<td width="635" height="45" class="td">
						<p style="line-height:200%;" align="center"><font size="5"><b>사 고 처 리 과 정 표</b></font></p>
					</td>
				</tr>
			</table>
            
            <br/>
       		<p style="font-size:large;">
				<b>1. 일반사항</b>
			</p>
            <table cellpadding="0" cellspacing="0" align="center" width="640">
               <tr>
	               <td class="td" bgcolor="#ECECEC">
						<p align="center">보 험&nbsp;종 목</p>
	               </td>
	               <td class="td">
	                   	<p align="center">${suimVO.getInsurance_nm()}</p>
	               </td>
	               <td class="td" bgcolor="#ECECEC">
						<p align="center">피 보 험 자</p>
	               </td>
	               <td class="td">
	                  	<p align="center">${suimVO.getBeneficiary_nm()}</p>
	               </td>
				</tr>
                <tr>
                    <td class="td" bgcolor="#ECECEC">
						<p align="center">사 고 일 시</p>
                    </td>
                    <td class="td">
                        <p align="center">${suimVO.accident_date}</p>
                    </td>
                    <td class="td" bgcolor="#ECECEC" nowrap>
						<p align="center">보험사담당자</p>
                    </td>
                    <td class="td">
                        <p align="center">${suimVO.ptnr_mbr_nm}</p>
                    </td>
				</tr>
                <tr>
                    <td class="td" bgcolor="#ECECEC" nowrap>
						<p align="center">보고서접수일</p>
                    </td>
                    <td class="td">
                        <p align="center">${suimVO.getReg_date()}</p>
                    </td>
                    <td class="td" bgcolor="#ECECEC">
						<p align="center">조 &nbsp;&nbsp;사 &nbsp;&nbsp;자</p>
                    </td>
                    <td class="td">
                        <p align="center">${suimVO.user_name}</p>
                    </td>
				</tr>
            </table>
            <br/>
			<input type="hidden" id="printCtrlSize" value="${print_9_ctrl.size()}"/><!-- 이벤트 발생용 구분값 -->
			<span id="printCtrlOutSpan">   
				<c:import url="../top_suim_print/suim_rpt_bsc_print_9_printCtrlLotte.jsp"></c:import>
				
				<!-- 170623, 롯데 보험사측 요청에 의해 변경
				<table align="center" cellpadding="0" cellspacing="0" width="640">
					<tr>
						<td height="25" width="50%">
							<p class="p2"><b>2. 처리과정</b></p>
						</td>
						<td height="25" width="50%">
							<p>&nbsp;</p>
						</td>
					</tr>
				</table>
				
					<p style="font-size:large;">
						<b>2. 처리과정</b>
						<img src="./resources/ls_img/ls_body/btn_add.gif" title="추가" id="printCtrlAddBtn" onclick="javascript:printCtrlLotteAddView();" style="float:right; cursor:pointer;" />
					</p>
				
				
				<table cellSpacing=0 cellPadding="0" width="635" align="center" >
					<tr>
						<td bgcolor="#ECECEC" class="td" width="200">
							<p align="center"><b>일 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;자</b></td>
						<td bgcolor="#ECECEC" class="td" width="204">
							<p align="center"><b>항 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</b></td>
						<td bgcolor="#ECECEC" class="td" width="215">
							<p align="center"><b>처 &nbsp;리 &nbsp;내 &nbsp;용</b></p>
						</td>
					</tr>
					<tbody id="print9_Ctrl">
					<c:forEach items="${sagoList }" var="sagoVo">
						<tr id = "print9_Ctrl_${sagoVo.sagoNo }">
							<td class="td">
								<p align="center">${sagoVo.regDate }</p></td>
							<td class="td">
								<p align="center">${sagoVo.item }</p></td>
							<td class="td">
								<p align="center">${sagoVo.content }</p>
							</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			 -->
			</span>
</body>
