<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>

	<script>
		$(document).ready(function(){

			$.ajaxSetup({cache:false});

			$("#memberSearchBtn").click(function(){
				
				//특수기호(') 콤마제거
				var paramSearchVal =  sqlRemoveText( $("#searchStr").val() );
				
				$.post("./empNmlstSearch",
						{	ustat:$("#ustat").val()
							,tid:$("#tid").val()
							,searchStr:paramSearchVal
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
												+"<td>"+entry.center_name+"</td>"
												+"<td>"+entry.team_name+"</td>"
												+"<td>"+entry.work_level+"</td>"
												+"<td>"+entry.work_type+"</td>"
												+"<td>"+entry.user_name+"</td>"
												+"<td><a href='#' onclick=" + "openSMS('" + entry.handphone + "')>" + "<img src='./resources/ls_img/top_team/icon_hp.gif'/></a></td>"
												+"<td>"+entry.handphone+"</td>"
												+"<td>"+entry.office_tel+"</td>"
												+"<td>"+entry.office_fax+"</td>"
												+"<td>"+entry.user_id+"</td>"
												+"<td>"+entry.user_state+"</td>"
												+"<td>"+"<img src='./resources/ls_img/member/btn_view.gif' id='afterSearchBtn"+index+"' style='cursor:pointer;' /></td>"
		                                		+ '</tr>'
			   							);
		                        		$("#afterSearchBtn"+index).bind("click",function(){
		                        			popMbrDetail(entry.user_no);
		                        		});
									});//each
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						},"json"
				);//post
				
			});//$("#memberSearchBtn").click
	
		});//$(document).ready
		
		function popMbrDetail(user_no){
			
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			
			var sw=1010; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이

			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			
			window.open('PopEmpNmlstDtl?user_no='+user_no,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}

        function openSMS(hpNo){

            var cw=screen.availWidth;
            var ch=screen.availHeight;

            var sw=380; //띄울 창의 넓이
            var sh=533;  //띄울 창의 높이

            var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
            var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치

            window.open('simpleSMSForm?hpNo='+hpNo,'simpleSMS','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
        }
        
      	//사원검색입력창에 엔터키눌렀을때 action
		function enterKey(){
			if(event.keyCode == 13){
				$("#memberSearchBtn").click();
			}
		}
	</script>

	<!-- 검색 조건 테이블 -->
	<div class= "tableStyle2">
	
			<table>
				<thead>
					<tr>
						<th width="25%">재직상태</th>
						<th width="25%">팀명</th>
						<th width="35%">검색어 (이름 or 전화번호 or 아이디)</th>
						<th width="15%">검색</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>
							<select id="ustat">
								<option value="10" selected>전체(근무자/발령대기자/퇴사자)</option>
								<option value="0">근무자</option>
								<option value="2">발령대기자</option>
								<option value="1">퇴사자</option>
								<option value="9">SA</option>
							</select>
						</td>
						<td>
							<select id="tid">
								<option value="0" selected>전체</option>
								<c:forEach items="${teamList}" var = "teamVo">
									<option value="${teamVo.team_id}">
										<c:if test="${teamVo.team_level == 1}">&nbsp;└</c:if>
										<c:if test="${teamVo.team_level == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
										${teamVo.team_name}
									</option>
								</c:forEach>
							</select>
						</td>
						<td>
							<input type="text" id="searchStr" name="searchStr" size="50" onkeydown="javascript:enterKey();"/>
						</td>
						<td>
							<input type="image" src="./resources/ls_img/btn_src.gif" id="memberSearchBtn" />
						</td>
					</tr>
				</tbody>
			</table>

	</div><!-- //tableStyle2 -->
	<!-- //검색 조건 테이블 -->
	<br />
	<!-- 검색 결과 테이블 -->
	<div class= "tableStyle2">

			<table>
				<thead>
					<tr>
						<th width="5%">No</th>
						<th width="11%">센터명</th>
						<th width="11%">부서명</th>
						<!-- 180108 직급/직책 에서 직위/직급으로 변경 -->
						<th width="6%">직위</th>
						<!-- <th width="8%">직급</th> -->
						<th width="8%">직책</th>
						<th width="8%">이름</th>
						<th width="3%">문자</th>
						<th width="9%">H.P</th>
						<th width="9%">직통전화</th>
						<th width="9%">팩스번호</th>
						<th width="7%">아이디</th>
						<th width="7%">현재상태</th>
						<th width="8%">비고</th>
					</tr>
				</thead>
				<tbody id="searchTbody">
					<tr>
					</tr>
				</tbody>
			</table>

	</div><!-- //tableStyle2 -->
	<!-- //검색 결과 테이블 -->

</body>

</html>
