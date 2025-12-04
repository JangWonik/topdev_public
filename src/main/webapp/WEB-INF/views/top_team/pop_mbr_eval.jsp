<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="insaEvalVO" value="${insaEvalVO}" />
<c:set var="user_no" value="${user_no}" />
<c:set var="yearInt" value="${yearInt}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>

	<script>
		$(document).ready(function(){

			$.ajaxSetup({cache:false});

			$("#popmbrevalsave").click(function(){
				if($("#suim_goal_cnt").val().trim() == ""){
					alert("목표 건수를 입력해 주세요.");
					$("#suim_goal_cnt").focus();
					return;
				}
				if($("#suim_goal_amt").val().trim() == ""){
					alert("목표 금액을 입력해 주세요.");
					$("#suim_goal_amt").focus();
					return;
				}
				if($("#salary_desired").val().trim() == ""){
					alert("적정 연봉을 입력해 주세요.");
					$("#salary_desired").focus();
					return;
				}
				if($("#tm_mngr_eval_sal").val().trim() == ""){
					$("#tm_mngr_eval_sal").val("0");
				}
				if(!confirm("저장 하시겠습니까?")){
					return;
				}	
				$.post("./insertMemberEvaluation",
						{	 cnt              :$("#cnt").val()
							,serial_no        :$("#serial_no").val()
							,user_no          :$("#user_no").val()
							,eval_year        :$("#eval_year").val()
							,suim_goal_cnt    :$("#suim_goal_cnt").val()
							,suim_goal_amt    :$("#suim_goal_amt").val()
							,salary_desired   :$("#salary_desired").val()
							,work_level       :$("#work_level").val()
							,work_type        :$("#work_type").val()
							,career_year      :$("#career_year").val()
							,promotion_date   :$("#promotion_date").val()
							,achievement      :$("#achievement").val()
							,improvement      :$("#improvement").val()
							,next_year_task   :$("#next_year_task").val()
							,tm_mngr_eval_sal :$("#tm_mngr_eval_sal").val()
							,tm_mngr_eval_grd :$("#tm_mngr_eval_grd").val()
							,tm_mngr_eval     :$("#tm_mngr_eval").val()
							,mng_director_eval:$("#mng_director_eval").val()
							,reg_date         :$("#reg_date").val()
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("저장에 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									alert(data + "건의 자료가 저장 되었습니다.");
									window.location.assign("./popMbrDetail?user_no=${insaEvalVO.getUser_no()}");
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post

			});//$("#memberSearchBtn").click

			$(".tmpclassforradio").click(
					function(){
						$("#tm_mngr_eval_grd").val($(this).val());
					}
			);//click

		});//$(document).ready
	</script>

	<input type="hidden" name="user_no" id="user_no" value="${user_no}"/>
	<input type="hidden" name="cnt" id="cnt" value="${insaEvalVO.getCnt()}"/>
	<input type="hidden" name="serial_no" id="serial_no" value="${insaEvalVO.getSerial_no()}"/>
	<input type="hidden" name="work_type" id="work_type" value="${insaEvalVO.getWork_type()}"/>
	<input type="hidden" name="work_level" id="work_level" value="${insaEvalVO.getWork_level()}"/>
	<input type="hidden" id="tm_mngr_eval_grd" />
	<input type="hidden" name="eval_year" id="eval_year" value="${yearInt}"/>

	<div class= "tableStyle2">

		<table>
			<thead>
				<tr>
					<th width="5%" bgcolor="#efefef">성명</th>
					<!-- 180108 직급/직책 에서 직위/직급으로 변경 -->
					<th width="5%" bgcolor="#efefef">직위</th>
					<th width="5%" bgcolor="#efefef">직급</th>
					<th width="5%" bgcolor="#efefef">입사일</th>
					<th width="5%" bgcolor="#efefef">최근승격일</th>
					<th width="5%" bgcolor="#efefef">생년월일</th>
					<th width="5%" bgcolor="#efefef">손사경력</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><c:out value="${insaEvalVO.getUser_name()}"/></td>
					<td><c:out value="${insaEvalVO.getWork_type_nm()}"/></td>
					<td><c:out value="${insaEvalVO.getWork_level_nm()}"/></td>
					<td><c:out value="${insaEvalVO.getJoin_date()}"/></td>
					<td><input type="text" name="promotion_date" id="promotion_date" value="${insaEvalVO.getPromotion_date()}" maxlength="10" ></td>
					<td><c:out value="${insaEvalVO.getJumin_no1()}"/></td>
					<td><input type="text" name="career_year" id="career_year" value="${insaEvalVO.getCareer_year()}" maxlength="10"></td>
				</tr>
			</tbody>
			
		</table>

	</div>

	<div class= "tableStyle2" style="margin-top:10px;">

		<table>
			<thead>
				<tr>
					<th width="5%" bgcolor="#efefef">수임건수</th>
					<th width="5%" bgcolor="#efefef">처리건수<br />(절대건수)</th>
					<th width="5%" bgcolor="#efefef">처리건수<br />(평가건수)</th>
					<th width="5%" bgcolor="#efefef">목표건수</th>
					<th width="5%" bgcolor="#efefef">목표건수<br />(달성률)</th>
					<th width="5%" bgcolor="#efefef">처리금액</th>
					<th width="5%" bgcolor="#efefef">목표금액</th>
					<th width="5%" bgcolor="#efefef">목표금액<br />(달성률)</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><c:out value=""/></td>
					<td><c:out value=""/></td>
					<td><c:out value=""/></td>
					<td><input type="text" name="suim_goal_cnt" id="suim_goal_cnt" value="${insaEvalVO.getSuim_goal_cnt()}" style="width:90px"> 건</td>
					<td><c:out value=""/></td>
					<td><c:out value=""/></td>
					<td><input type="text" name="suim_goal_amt" id="suim_goal_amt" value="${insaEvalVO.getSuim_goal_amt()}" style="width:85px"> 만원</td>
					<td><c:out value=""/></td>
				</tr>
			</tbody>
			
		</table>

	</div>

	<div class= "tableStyle2" style="margin-top:10px;">

		<table>
			<tr>
				<th width="20%" bgcolor="#efefef">공적사항</th>
				<td colspan="5">
					<textarea style="width:98%" name="achievement" id="achievement" >${insaEvalVO.getAchievement()}</textarea>
				</td>
			</tr>
			<tr>
				<th width="20%" bgcolor="#efefef">개선사항</th>
				<td colspan="5">
					<textarea style="width:98%" name="improvement" id="improvement" >${insaEvalVO.getImprovement()}</textarea>
				</td>
			</tr>
			<tr>
				<th width="20%" bgcolor="#efefef">차기 연도 중점 추진사항</th>
				<td colspan="5">
					<textarea style="width:98%" name="next_year_task" id="next_year_task" >${insaEvalVO.getNext_year_task()}</textarea>
				</td>
			</tr>
			<tr>
				<th width="20%" bgcolor="#efefef">본인평가 적정연봉</th>
				<td colspan="5" style="text-align:left;">&nbsp;&nbsp;
					<input type="text" name="salary_desired" id="salary_desired" value="${insaEvalVO.getSalary_desired()}"> 만원
				</td>
			</tr>
			<tr>
				<th width="20%" bgcolor="#efefef">팀장평가 등급</th>
				<td>
					S&nbsp;&nbsp;<input type="radio" name="tm_mngr_eval_grd" class="tmpclassforradio" value="S"
						<c:if test="${insaEvalVO.getTm_mngr_eval_grd() == 'S'}"> checked </c:if> > 매우우수
				</td>
				<td>	 
					A&nbsp;&nbsp;<input type="radio" name="tm_mngr_eval_grd" class="tmpclassforradio" value="A"
					<c:if test="${insaEvalVO.getTm_mngr_eval_grd() == 'A'}"> checked </c:if> > 우수
				</td>
				<td> 
					B&nbsp;&nbsp;<input type="radio" name="tm_mngr_eval_grd" class="tmpclassforradio" value="B"
					<c:if test="${insaEvalVO.getTm_mngr_eval_grd() == null || insaEvalVO.getTm_mngr_eval_grd() == 'B'}"> checked </c:if> > 보통
				</td>
				<td> 
					C&nbsp;&nbsp;<input type="radio" name="tm_mngr_eval_grd" class="tmpclassforradio" value="C"
					<c:if test="${insaEvalVO.getTm_mngr_eval_grd() == 'C'}"> checked </c:if> > 노력요함
				</td>
				<td> 
					D&nbsp;&nbsp;<input type="radio" name="tm_mngr_eval_grd" class="tmpclassforradio" value="D"
					<c:if test="${insaEvalVO.getTm_mngr_eval_grd() == 'D'}"> checked </c:if> > 매우노력요함 
				</td>
			</tr>
			<tr>
				<th width="20%" bgcolor="#efefef">팀장평가 적정연봉</th>
				<td colspan="5" style="text-align:left;">&nbsp;&nbsp;
					<input type="text" name="tm_mngr_eval_sal" id="tm_mngr_eval_sal" id="tm_mngr_eval_sal" value="${insaEvalVO.getTm_mngr_eval_sal()}"> 만원
				</td>
			</tr>
			<tr>
				<th width="20%" bgcolor="#efefef">팀장의견</th>
				<td colspan="5">
					<textarea style="width:98%" name="tm_mngr_eval" id="tm_mngr_eval" >${insaEvalVO.getTm_mngr_eval()}</textarea>
				</td>
			</tr>
			<tr>
				<th width="20%" bgcolor="#efefef">담당 임원 의견</th>
				<td colspan="5">
					<textarea style="width:98%" name="mng_director_eval" id="mng_director_eval" >${insaEvalVO.getMng_director_eval()}</textarea>
				</td>
			</tr>
		</table>

	</div>
	<br />
	<p align="center">
		<img id="popmbrevalsave" src="./resources/ls_img/icon_write.gif" alt="저장" style ="cursor:pointer" />
	</p>

</body>

</html>
