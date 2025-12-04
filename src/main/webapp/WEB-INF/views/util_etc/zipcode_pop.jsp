<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<title> 우편번호 검색 </title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="./resources/jquery/themes/smoothness/jquery-ui.css">
		<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<link rel="stylesheet" href="./resources/ls_css/style_pop.css">
	
	
	<script>
		$(document).ready(function(){
			$("#searchBtn").click(function(){
				$("#searchStr").val($.trim( $("#searchStr").val() ));
				if ($("#searchStr").val() == "" ){
					alert("주소를 입력하세요.");
					return false;
				}
				$.post("zipcodeSearch",
						{searchStr : $("#searchStr").val()},
						function(data,status){
							$("#addrList").empty();
		                    $.each(data, function(index, entry) {
                        		$("#addrList").append(
                       				"<tr >"
										+"<td width='80' class='td'><p align='center'>"+entry.zipcode+"</p></td>"
										+"<td width='370' class='td' id='addr"+index+"' style='cursor:pointer;'>"
											+"<p align='center'>"
												+entry.addr1
											+"</p>"
										+"</td>"
                               		+ "</tr>"
	   							);
                        		
                        		$("#addr"+index).bind("click",function(){
                        			copy(entry.zipcode,entry.addr1);
                        		});
                        		
							});//each	
							
						},"json"
				)
			});
		});
		
		function copy(zipcode,addr1) {
			$("#postcode1",opener.document).val(zipcode); 
			$("#addr_1st",opener.document).val(addr1); 
            window.close();
		}
	</script>
	
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" >
	<p style="line-height:50%; margin-top:0; margin-bottom:0;" align="center">&nbsp;</p>
	<p align="center"><img src="./resources/ls_img/pt_bgpt_zipcode.gif" width="470" height="60" border="0"></p>
	<table align="center" cellpadding="5" cellspacing="0" width="470">
    	<tr>
	        <td width="100%">
                <p align="center">찾고 싶으신 주소의 명칭을 입력하세요.</p>
	            <p align="center">
	            	<font color="#0066FF">예)</font> 종로구, 압구정동, 수지읍
            	</p>
	            <hr align="center" size="1" width="80%" noshade color="#DDDDDD">                                    
	           	<p align="center">
	           		<input type=text name="searchStr" id="searchStr" size="15" style='height:18px;border:1 solid cccccc' value="" />
	           		<input type=image id="searchBtn" src="./resources/ls_img/icon_src_add.gif" align="absmiddle" width="85" height="20" border="0" class="btn" />
	           	</p>
	            <hr align="center" size="1" width="80%" noshade color="#DDDDDD">
	            <p align="center">
	            	<font color="#FF0066">↓</font>검색 결과중 해당되는 주소를 <font color="#0066FF">클릭</font>하시면 자동입력됩니다.
	            </p>
			</td>
	    </tr>
	</table>
	
	<table align="center" cellpadding="10" cellspacing="0" width="470">
	    <tr>
	        <td width="100%">
	            <table align="center" cellpadding="0" cellspacing="0" width="100%" bordercolordark="white" bordercolorlight="#CCCCCC">
	                <tr>
	                    <td width="18%" class="td">
	                        <p align="center"><FONT color="black"><b>우편번호</b></FONT></p>
	                    </td>
	                    <td width="82%" class="td">
	                        <p align="center"><FONT color="black"><b>주소</b></FONT></p>
	                    </td>
	                </tr>
	                <tbody id="addrList">
		                <tr>
		                    <td width="450" colspan="2" class="td">
		                        <p align="center">&nbsp;</p>
		                        <p align="center">검색어를 입력해 주세요~!</p>
		                        <p align="center">&nbsp;</p>
		                    </td>
		                </tr>
	                </tbody>
	            </table>
	        </td>
	    </tr>
	</table>
	
</body>

</html>
