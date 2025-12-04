<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
</head>

<body>

	<script>
		var dialog;
		var lineNo;
		$(document).ready(function(){
			
			$.ajaxSetup({cache:false});
			
			$("#memberSearchBtn").click(function(){


			});//$("#memberSearchBtn").click

//			function popSelect(user_no, user_nm){
//
//				$("#mbrNo"+lineNo).val(user_no);
//				$("#mbrNm"+lineNo).val(user_nm);
//
//				dialog.dialog( "close" );
//			}
			

			//form start
			dialog = $("#dialog-form").dialog({
				autoOpen: false,
				height: 700,
				width: 500,
				modal: true
			});
			//form end

			$(".popOpenBtn").click(function(){
				lineNo = $(this).val();
				$("#tid option[value='0']").attr('selected', 'selected');
				$("#searchStr").val('');
				$("#searchTbody").empty();
				dialog.dialog( "open" );
			});
			
			/* $("#popOpenBtn").click(function(){
				lineNo = $(this).val();
				$("#tid option[value='0']").attr('selected', 'selected');
				$("#searchStr").val('');
				$("#searchTbody").empty();
				dialog.dialog( "open" );
			}); */
			
			
		});//$(document).ready
		
		function keyDownEnter(){
			if( event.keyCode == 13 ){
				getMemeberList();
// 				event.preventDefault();
				return false;
			}					
		}
		
		function getMemeberList(){
			$.post("./empNmlstSearch",
					{	ustat:$("#ustat").val()
						,tid:$("#tid").val()
						,searchStr:$("#searchStr").val()
						,gid:$("#tid option:selected").text().indexOf("└")
					},
					function(data,status){
						$("#searchTbody").empty();
						if(status == "success"){
							if(data.length == 0){
								alert("검색 결과가 없습니다.");
							}else{
			                    $.each(data, function(index, entry) {
	                        		$("#searchTbody").append('<tr>'
											+"<td>"+entry.rownum+"</td>"
											+"<td>"+entry.team_name+"</td>"
											+"<td>"+entry.work_level+"</td>"
											+"<td>"+entry.work_type+"</td>"
											+"<td>"+entry.user_name+"</td>"
											+"<td><input type='button' id='selectBtn"+index+"' value='선택' /></td>"
	                                		+ '</tr>'
		   							);
	                        		$("#selectBtn"+index).bind("click",function(){
	                        			popSelect(entry.user_no, entry.user_name, entry.team_id_main, entry.team_name);
	                        		});
								});//each
			                   
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
						/*
						alert($("#searchStr").attr("style"));
						$("#searchStr").attr("style","");
						alert($("#searchStr").attr("style"));
						$("#searchStr").attr("style","ime-mode:active");
						alert($("#searchStr").attr("style"));
						$("#searchStr").val("헐");
						*/
					},"json"
			);//post
		}
		
		function popSelect(user_no, user_nm, team_id ,team_name){
			
			fnModalMbrPopCallBack(user_no, user_nm, team_id ,team_name);
			/* $("#mbrNo"+lineNo).val(user_no);
			$("#mbrNm"+lineNo).val(user_nm);
			$("#share_team_id"+lineNo).val(team_id); */

            //console.log("team_id:["+team_id+"]");
			dialog.dialog( "close" );
		}

	</script>

	<div id="dialog-form" title="Find Member">
		<!-- 검색 조건 테이블 -->
		<div class= "tableStyle2">
			<form>
				<table>
					<thead>
						<tr>
							<th width="40%">팀명</th>
							<th width="45%">이름</th>
							<th width="15%">검색</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								<select id="tid">
									<option value="0" selected>전체</option>
									<c:forEach items="${topTeamList}" var = "teamVo">
										<option value="${teamVo.team_id}">
											<c:if test="${teamVo.team_level == 1}">&nbsp;└</c:if>
											<c:if test="${teamVo.team_level == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
											${teamVo.team_name}
										</option>
									</c:forEach>
								</select>
							</td>
							<td style="text-align:center;">
								<input type="hidden" id="ustat" value="0" />
								<input type="hidden" id="tid" value="0" />
								<input type="text" id="searchStr" ONKEYDOWN="keyDownEnter(this);" size="25" style="ime-mode:active"/>
								<input type="text" id="notSubmit" style="width: 0px;height:0px;" />
							</td>
							<td width="20%">
								<img src="./resources/ls_img/btn_src.gif" id="memberSearchBtn" onClick="getMemeberList();" style="cursor:pointer;"/>
								 
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div><!-- //tableStyle2 -->
		<!-- //검색 조건 테이블 -->
		<br />
		<!-- 검색 결과 테이블 -->
		<div class= "tableStyle2">

				<table>
					<thead>
						<tr>
						<th width="5%">No</th>
						<th width="20%">팀명</th>
						<!-- 180108 직급/직책 에서 직위/직급으로 변경 -->
						<th width="10%">직위</th>
						<th width="10%">직급</th>
						<th width="10%">이름</th>
						<th width="5%">선택</th>
						</tr>
					</thead>
					<tbody id="searchTbody">
						<tr>
						</tr>
					</tbody>
				</table>

		</div><!-- //tableStyle2 -->
		<!-- //검색 결과 테이블 -->
	</div>

</body>

</html>
