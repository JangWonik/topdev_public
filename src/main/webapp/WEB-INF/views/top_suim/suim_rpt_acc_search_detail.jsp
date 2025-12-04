<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>사고번호 상세검색</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css?v=201705231112" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js?v=201706141814"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>    
    
	<!-- modal용 css 끝 -->    
    <style type="text/css">
		.buttonSearchMini{
			width:50px;
			height:23px;
		    background-color:#2E7EE8;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		    }		
	</style>    
	<script>
	$(document).ready(function(){

		$("#accident_no").focus();

		$("#searchAccBtn").click(function(){
			doSearch();
		});
		
		//엔터키 눌렀을때 검색
		
		$("#accident_no").keydown(function(key){
			if( key.keyCode == 13 ){
				doSearch();
			}			
		});		
		
	});//$(document).ready
	
	function doSearch(){		
		
		var accident_no_val = $("#accident_no").val();
		
		if( accident_no_val == '' ){
			alert('사고번호를 입력해주세요.');
			return;
			$("#accident_no").focus();
		}
		
		var param = {};
		param.accident_no = accident_no_val;
		
		$.ajax({
			type : "POST",
			url : "accSearchListAjax",
			data : param,
			success : function(result){										
				//검색결과 페이지를 가져온다.				
				$("#searchResultList").html(result);	 				
			},
			error: function (request, status, error) {			
				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
			}
		});
		
	}
	</script>
</head>
<body>	<!-- center -->
<div class="tableStyle21">
	<table>	
		<tr>
			<th width="25%"><img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0"> 사고번호</th>
			<td width="35%">
				<input type="text" id="accident_no" name="accident_no" style="width:190px;"/>
			</td>
			<td  width="40%">
				<input class="buttonSearchMini" id="searchAccBtn" type="button" value="검색"/>
			</td>
		</tr>
		<tr>
			<td colspan="3" style="text-align:left;padding-left:5px;"> * 검색은 최근 보고서 우선순위로 최대 100개 까지 검색 됩니다.</td>
		</tr>			
	</table>
</div>
<div id="searchResultList"></div>
</body>
</html>