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
		var tname = '${tname}';
		var cname = '${cname}';
		
		if(result == '1'){
			alert("삭제 완료!");
			location.href = "./topSysAdmCode?tname="+tname+"&cname="+cname;
		}else{
			alert("삭제 실패!!");
			history.back();
		}
		
	});

</script>

</head>
<body>

</body>
</html>