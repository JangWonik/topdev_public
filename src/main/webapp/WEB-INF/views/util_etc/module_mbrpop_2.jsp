<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<script>
	$(document).ready(function(){
		
		$.ajaxSetup({cache:false});
		$(document).on("keyup", "#searchStr",function() {
			if ($(this).val().length > 0) {
				dupLoginSearch();
			} 
		});
		
		
		$("#memberSearchBtn").click(function(){
			dupLoginSearch();
			
			var searchStr = $("#searchStr").val();
			if (!searchStr) {
	        	$("#resultMsg").html("검색어를 입력해주세요.");
			}else {
				dupLoginSearch();
		}
	});//$("#memberSearchBtn").click
	
	function dupLoginSearch() {
		$.post("./topDupLoginSearch",
				{	ustat:$("#ustat").val()
					,tid:$("#tid").val()
					,searchStr:$("#searchStr").val()
					,gid:$("#tid option:selected").text().indexOf("└")
				},
				function(data,status){
					$("#searchTbody").empty();
					if(status == "success"){
						if(data.length == 0){
				        	$("#resultMsg").html("검색 결과가 없습니다.");
						}else{
		                    $.each(data, function(index, entry) {
                        		$("#searchTbody").append('<tr>'
										+"<td>"+entry.rownum+"</td>"
										+"<td>"+entry.team_name+"</td>"
										+"<td>"+entry.work_level+"</td>"
										+"<td>"+entry.work_type+"</td>"
										+"<td>"+entry.user_name+"</td>"
										+"<td><input type='button'  onclick='userContent1("+entry.user_no+")'  value='로그아웃' /></td>"
                                		+ '</tr>'
	   							);
							});//each
				        	$("#resultMsg").html("사용자를 검색하였습니다.");
						}
					}else{
				alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
					}
				},"json"
		);//post
	}
	
		function popSelect(user_no, user_nm, team_id){
			$("#mbrNo"+lineNo).val(user_no);
			$("#mbrNm"+lineNo).val(user_nm);
			$("#share_team_id"+lineNo).val(team_id);
			dialog.dialog( "close" );
		}


		$(".popOpenBtn").click(function(){
			lineNo = $(this).val();
			$("#tid option[value='0']").attr('selected', 'selected');
			$("#searchStr").val('');
			$("#searchTbody").empty();
			dialog.dialog( "open" );
		});
	});//$(document).ready

	function memberSearchBtnClick(){
		$.post("./topDupLoginSearch",
				{	ustat:$("#ustat").val()
					,tid:$("#tid").val()
					,searchStr:$("#searchStr").val()
					,gid:$("#tid option:selected").text().indexOf("└")
				},
				function(data,status){
					$("#searchTbody").empty();
					if(status == "success"){
						if(data.length == 0){
				        	$("#resultMsg").html("검색 결과가 없습니다.");
						}else{
		                    $.each(data, function(index, entry) {
                        		$("#searchTbody").append('<tr>'
										+"<td>"+entry.rownum+"</td>"
										+"<td>"+entry.team_name+"</td>"
										+"<td>"+entry.work_level+"</td>"
										+"<td>"+entry.work_type+"</td>"
										+"<td>"+entry.user_name+"</td>"
										+"<td><input type='button'  onclick='userContent1("+entry.user_no+")'  value='로그아웃' /></td>"
                                		+ '</tr>'
	   							);
							});//each
				        	$("#resultMsg").html("사용자를 검색하였습니다.");
						}
					}else{
				alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
					}
				},"json"
		);//post
	}
</script>

	<div id="dialog-form" title="Find Member">
		<!-- 검색 조건 테이블 -->
		<div class= "tableStyle2">

			<table>
				<colgroup>
					<col width="45%" />
					<col width="15%" />
					<col width="40%" />
				</colgroup>
				<thead>
					<tr>
						<th colspan="2">이름</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="border-right: 0px;">
							<input type="hidden" id="ustat" value="0" />
							<input type="hidden" id="tid" value="0" />
							<input type="text" id="searchStr" name="searchStr" size="25"  onKeydown="javascript:memberSearchBtnClick();" />
						</td>
						<td><span id="resultMsg" style="text-align: left;" >검색어를 입력하세요.</span></td>
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
					<th width="10%">팀명</th>
					<!-- 180108 직급/직책 에서 직위/직급으로 변경 -->
					<th width="20%">직위</th>
					<th width="10%">직급</th>
					<th width="15%">이름</th>
					<th width="10%">로그아웃 요청</th>
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


