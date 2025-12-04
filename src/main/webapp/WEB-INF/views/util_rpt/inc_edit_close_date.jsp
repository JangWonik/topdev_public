<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
<script src="./resources/jquery/jquery-ui.min.js"></script>
<script src="./resources/ne_js/calendar.js"></script>
<script>
$(document).ready(function(){
	$.ajaxSetup({cache:false});
	$("#inc_close_date").change(function(){
		var tmp = window.confirm("종결일을 "+$("#inc_close_date").val()+" 으로 변경 하시겠습니까?");
		if(tmp == false){
			return;
		}
		$.post("./incEditCloseDate",
				{	gbNo:$("#gbNoForPop").val()
					,smNo:$("#smNoForPop").val()
					,editCloseDate:$("#inc_close_date").val()
				},
				function(data,status){
					if(status == "success"){
						if(data.length == 0){
							alert("종결일 변경을 실패 하였습니다.");
						}else{
							alert("종결일 변경을 성공 하였습니다.");
							window.location.reload();
							window.opener.location.reload();
						}
					}else{
						alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
					}
				},"json"
		);//post
	});//$("#inc_close_date").change
});//$(document).ready
</script>
<input type="hidden" class="classCalendar" id="inc_close_date" name="inc_close_date" value="${primBizRptDtl.close_date_fmt}" />
