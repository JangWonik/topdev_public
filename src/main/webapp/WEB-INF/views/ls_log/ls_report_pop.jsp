<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


				<div class="centercnt_top">
					<div class="nociteA log_top">
						<div class="search_bar">
							<%@ include file="log_member2_top.jsp" %>
						</div>
					</div>
				</div>

				<div class="centercnt_bot2">
					<div class="guest">
						
						<div class="guestcnt2" style="display:block;">
							<div class="tableStyle2">
								<table align="center" cellpadding="0" cellspacing="0" width="670">
	<tr>
		<td width="15" background="img/pop_box_4.gif">
			<p>&nbsp;</p>
		</td>
		<td>
			<table cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="600">
				<c:forEach var="vo" items="${reportpList}" varStatus="status">
				<tr>
					<td bgcolor="#EDEDED" class="td">
						<p>ㆍ접수번호</p>
                    </td>
					<td colspan="3" class="td">
						<table cellpadding="0" cellspacing="0" width="99%">
							<tr>
								<td><p><c:out value="${vo.getReport_id()}" />
									<a href="p_info.php?rid=#" target="_blank"><img src="./resources/ls_img/icon_print_info.gif" width="95" height="20" border="0" align="absmiddle"></a></p>
								</td>
								<td><p align="right">
									<a href="form_info.php?rid=#" onclick="NewPopUp(this.href,'Report_form_05','700','550','yes','center');return false" onfocus='this.blur()'><img src="./resources/ls_img/btn_edite.gif" width="45" height="18" border="0"></a></p>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				
				<tr>
					<td bgcolor="#EDEDED" class="td">
						<p>ㆍ보고서양식</p>
                    </td>
					<td colspan="3" class="td">
						<p><c:out value="${vo.getReport_type()}" /></p>
					</td>
				</tr>
				
				<tr>
					<td bgcolor="#EDEDED" class="td">
						<p>ㆍ현재상태</p>
					</td>
					<td class="td">
						<p>
							<c:choose>
								<c:when test="${vo.getReport_ch() == 1}">
									<c:when test="${vo.report_return() == 1}">반려</c:when>
									<c:otherwise>결재</c:otherwise>
								</c:when>
								<c:when test="${vo.getReport_ch() == 2}">종결</c:when>
								<c:when test="${vo.getReport_ch() == 3}">위임취소</c:when>
								<c:when test="${vo.getReport_ch() == 4}">소송</c:when>
								<c:otherwise>미결</c:otherwise>
							</c:choose>
						</p>
					</td>
					<td class="td" bgcolor="#EDEDED">
						<p align="center">민원관련</p>
					</td>
					<td class="td">
						<p>
							<c:choose>
								<c:when test="${vo.getMinwon() == 1}">민원 예상</c:when>
								<c:when test="${vo.getMinwon() == 2}">민원 발생</c:when>
								<c:otherwise>없음</c:otherwise>
							</c:choose>
						</p>
					</td>
				</tr>
				
				<tr>
					<td bgcolor="#EDEDED" class="td">
						<p>ㆍ종결일</p>
					</td>
					<td class="td">
						<p><c:out value="${vo.getEnd_date()}" /></p>
					</td>
					<td bgcolor="#EDEDED" class="td">
						<p align="center">승인일자(승인자)</p>
					</td>
					<td class="td">
						<p><c:out value="${vo.getOk_date()}" /></p>
					</td>
				</tr>
				
				<tr>
					<td bgcolor="#EDEDED" class="td">
						<p>ㆍ처리팀</p>
					</td>
					<td class="td">
						<p><c:out value=" " /></p>
					</td>
					<td bgcolor="#EDEDED" class="td">
						<p align="center">처리 담당자</p>
					</td>
					<td class="td">
						<p><c:out value=" " /><%-- <a href="pop_user_change.php?rid=<?=$row[rid]?>" onclick="NewPopUp(this.href,'User_change','470','500','yes','center');return false" onfocus='this.blur()'><img src="./resources/ls_img/icon_change.gif" border="0" align="absmiddle" width="14" height="14"></a> 
						<a href="../top_sms/pop_sms.php?rhp=<?=$user[handphone]?>" onclick="NewPopUp(this.href,'Sms','500','480','no','center');return false" onfocus="this.blur()"><img src="./resources/ls_img/icon_hp.gif" width="9" height="14" border="0"> --%> 
						</a></p>
					</td>
				</tr>
				<tr>
					<td bgcolor="#EDEDED" class="td">
						<p>ㆍ보험사</p>
					</td>
					<td class="td">
						<p><c:out value=" " /><a href='../ls_bin/ig_pds.php?ig_id=#' onclick=\"NewPopUp(this.href,'Ig_Pds','750','600','yes','center');return false\" onfocus='this.blur()'>
						<img src='./resources/ls_img/icon_ig_pds.gif' border=0 align=absmiddle>
						</a>
						</p>
					</td>
					<td bgcolor="#EDEDED" class="td">
						<p align="center">보험사 담당자</p>
					</td>
					<td class="td">
						<p><c:out value=" " /><a href="pop_ig_change.php?rid=#" onclick="NewPopUp(this.href,'Ig_change','570','500','yes','center');return false" onfocus='this.blur()'><img src="./resources/ls_img/icon_change.gif" border="0" align="absmiddle" width="14" height="14"></a> 
                        <a href="../top_sms/pop_sms.php?rhp=" onclick="NewPopUp(this.href,'Sms','500','480','no','center');return false" onfocus="this.blur()"><img src="./resources/ls_img/icon_hp.gif" width="9" height="14" border="0"></a> 
                        </p>
					</td>
				</tr>
				<tr>
					<td bgcolor="#EDEDED" class="td">
						<p>ㆍ담당부서</p>
					</td>
					<td colspan="3" class="td">
						<p><c:out value="${vo.getIg_team()}" /></p>
					</td>
				</tr>
				<tr>
					<td bgcolor="#EDEDED" class="td">
						<p>ㆍ구분</p>
					</td>
					<td colspan="3" class="td"><c:out value=" " />
						<!-- <p>
						if($row[report_type]=='1')echo "배상";
						else if($row[report_type]=='2')echo "재물";
						else if($row[report_type]=='3')echo "상해";
						else if($row[report_type]=='4')echo "질병";
						</p> -->
						<p>
							<c:choose>
								<c:when test="${vo.getReport_type() == 1 }">배상</c:when>
								<c:when test="${vo.getReport_type() == 2 }">재물</c:when>
								<c:when test="${vo.getReport_type() == 3 }">상해</c:when>
								<c:when test="${vo.getReport_type() == 4 }">질병</c:when>
							</c:choose>
						</p>
					</td>
				</tr>
				
				<tr>
					<td bgcolor="#EDEDED" class="td">
						<p>ㆍ상세구분</p>
					</td>
					<td colspan="3" class="td">
						<p><c:out value="${vo.getReport_type3()} " /></p>
					</td>
				</tr>

				<tr>
					<td bgcolor="#EDEDED" class="td">
						<p>ㆍ사고번호</p>
					</td>
					<td colspan="3" class="td">
						<p><c:out value="${vo.getReport_1()} " /></p>
					</td>
				</tr>
				<tr>
					<td bgcolor="#EDEDED" class="td">
						<p>ㆍ증권번호</p>
					</td>
					<td colspan="3" class="td">
						<p><c:out value="${vo.getReport_2()} " /></p>
					</td>
				</tr>
				<tr>
					<td bgcolor="#EDEDED" class="td">
						<p>ㆍ보험종목</p>
					</td>
					<td colspan="3" class="td">
						<p><c:out value="${vo.getReport_3()} " /></p>
					</td>
				</tr>
				<tr>
					<td bgcolor="#EDEDED" class="td" rowspan="2">
						<p>ㆍ계약자</p>
					</td>
					<td class="td" rowspan="2">
						<p><c:out value="${vo.getIg_client()} " /></p>
					</td>
					<td bgcolor="#EDEDED" class="td">
						<p align="center">연락처</p>
					</td>
					<td class="td">
						<p><c:out value="${vo.getIg_client_hp()} " /></p>
					</td>
				</tr>
				<tr>
					<td bgcolor="#EDEDED" class="td">
						<p align="center">주민번호</p>
					</td>
					<td class="td">
						<p><c:out value="${vo.getIg_client_hp()} " /></p>
					</td>
				</tr>
				<tr>
					<td bgcolor="#EDEDED" class="td" rowspan="2">
						<p>ㆍ피보험자</p>
					</td>
					<td class="td" rowspan="2">
						<p><c:out value="${vo.getIg_insured()} " /></p>
					</td>
					<td bgcolor="#EDEDED" class="td">
						<p align="center">연락처</p>
					</td>
					<td class="td">
						<p><c:out value="${vo.getIg_insured_hp()} " /></p>
					</td>
				</tr>
				<tr>
					<td bgcolor="#EDEDED" class="td">
						<p align="center">주민번호</p>
					</td>
					<td class="td">
						<p><c:out value="${vo.getIg_insured_ju()} " /></p>
					</td>
				</tr>
				
				<tr>
					<td bgcolor="#EDEDED" class="td">
						<p>ㆍ피해자/물</p>
					</td>
					<td class="td">
						<p><c:out value="${vo.getReport_4()} " /></p>
					</td>
					<td bgcolor="#EDEDED" class="td">
						<p align="center">연락처</p>
					</td>
					<td class="td">
						<p><c:out value="${vo.getReport_4_hp()} " /></p>
					</td>
				</tr>
				
				<tr>
					<td bgcolor="#EDEDED" class="td">
						<p>ㆍ수임유형1</p>
					</td>
					<td class="td">
						<p><c:out value="${vo.getReport_4()} " /></p>
					</td>
					<td bgcolor="#EDEDED" class="td">
						<p align="center">수임유형2</p>
					</td>
					<td class="td">
						<p><c:out value="${vo.getSuim_type()} " /></p>
					</td>
				</tr>
				<?}?>
				<tr>
					<td bgcolor="#EDEDED" class="td">
						<p>ㆍ사고내용</p>
					</td>
					<td colspan="3" class="td">
						<p><c:out value="${vo.getReport_5()} " /></p>
					</td>
				</tr>
				<tr>
					<td bgcolor="#EDEDED" class="td">
						<p>ㆍ사고일</p>
					</td>
					<td class="td">
						<p>
							<c:choose>
								<c:when test="${vo.trouble_date > 0}"><c:out value="${vo.getTrouble_date()} " /></c:when>
							</c:choose>
							<!-- ($row[trouble_date]>0)echo date("Y-m-d",$row[trouble_date])	 -->				
						</p>
					</td>
					<td bgcolor="#EDEDED" class="td">
						<p align="center">수임일</p>
					</td>
					<td class="td">
						<p>
							<c:choose>
								<c:when test="${vo.reg_date > 0}"><c:out value="${vo.getReg_date()} " /></c:when>
							</c:choose>
						
						<!-- ($row[reg_date]>0)echo date("Y-m-d",$row[reg_date]);($row[report_ch]=="2" && ($member[user_id]=='top0906' or $member[no]=='1')){ -->
						 <a href="pop_end_date.php?rid=<?=$rid?>" onclick="NewPopUp(this.href,'Report_End_date','350','180','no','center');return false" onfocus='this.blur()'><img src="./resources/ls_img/icon_change.gif" width="14" height="14" border="0" align="absmiddle"></a></p>
					</td>
				</tr>
				<tr>
					<td bgcolor="#EDEDED" class="td">
						<p>ㆍ현장제출일</p>
					</td>
					<td class="td">
						<p><c:out value="${vo.getSite_date()} " /></p>
					</td>
					<td bgcolor="#EDEDED" class="td">
						<p align="center">중간제출일</p>
					</td>
					<td class="td">
						<p><c:out value="${vo.getInterim_date()} " /></p>
					</td>
				</tr>
				<tr>
					<td bgcolor="#EDEDED" class="td" nowrap>
						<p>ㆍ추정손해액</p>
					</td>
					<td class="td">
						<p><c:out value="${vo.getPrice_estimated()} " />원</p>
					</td>
					<td bgcolor="#EDEDED" class="td">
						<p align="center" nowrap>추정수수료</p>
					</td>
					<td class="td">
						<p><c:out value="${vo.getPrice_top()} " />원</p>
					</td>
				</tr>
				<tr>
					<td bgcolor="#EDEDED" class="td">
						<p>ㆍ조사지역</p>
					</td>
					<td class="td" colspan="3">
						<p></p>
					</td>
				</tr>
				</c:forEach>
			</table>
								
								</div>
						</div>
						<div class="guestcnt">
						</div>
						<div class="guestcnt">
						</div>
						<div class="guestcnt">
						</div>
					</div>
				</div>
