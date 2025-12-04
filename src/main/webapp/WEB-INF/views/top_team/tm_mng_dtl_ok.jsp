<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<title>${title_Session}</title>
<script src="./resources/jquery/jquery.min_1_12.js"></script>
<script>

	$(document).ready(function(){
		
		var result = ${result};
		var action = '${action}';
		
		if(result == '1' && action == 'add'){
			alert("추가 되었습니다.");
		}else if(result == '1' && action == 'modify'){
			alert("수정 되었습니다.");
		}else if(result == '1' && action == 'delete'){
			alert("삭제 되었습니다.");
		}else{
			alert("DB 작업에 실패하였습니다.");			
		}
		location.href = "./teamlist?selTab=${selTab}";
		
	});
</script>

</head>
<body>

</body>
</html>