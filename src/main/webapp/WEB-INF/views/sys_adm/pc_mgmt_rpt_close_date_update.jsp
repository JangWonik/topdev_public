
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=iso-8859-1" />
<title>${title_Session}</title>
<style>

body {
    font-family: "Lucida Grande", Helvetica, Verdana, sans-serif;
    font-size: 10pt;
    line-height: 14pt;
}

h1 {
    line-height: 30px;
}

.data-table, .data-table td, .data-table th {
    border-color: black;
    border-style: solid;
}

.data-table {
    border-width: 0 0 0px 0px;  
    border-spacing: 0;
    border-collapse: collapse; 
    margin: 0;
}

.data-table td, .data-table th {
    margin: 0px;
    padding: 6px;
    border-width: 1px;
    vertical-align: top;
}

.data-table th {
    background-color: gold; 
}


</style>


    <link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css?v=20170411111520" />
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/><!-- calendar -->
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/><!-- calendar -->
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/><!-- calendar -->
    <script src="./resources/jquery/jquery.min_1_12.js"></script>

    <script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
    <script src="./resources/ne_js/calendar.js?v=20170321111520"></script><!-- calendar -->
    <script src="./resources/wm_js/common.js"></script>
    <script src="./resources/cmm/js/common.js"></script>



	<script type="text/javascript">
	
		$(document).ready(function(){
		});
		
		function fnUpdateCloseDate(suimRptNo, idx){
			var param = {};
			param.suim_rpt_no = suimRptNo;
			param.close_date = $("#close_date_"+idx).val();
			
			var url = "/update_rpt_close_date";
			
       	    $.ajax({
       	        type: "POST",
       	        url: url,
       	        data: param,
       	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
       	        timeout: 20000,
       	        async: false,
       	        dataType: "html", 
       	        success: function(data){
       	        	if (data == 1){
						alert("종결일 변경 성공 했습니다. ");       	        		
       	        	}else{
       	        		alert("변경 실패..");
       	        	}       	        	
       	        }
       	    });  
			
			
		}
		
	</script>

</head>
<body>

<!-- wrapper -->
<div id="wrapper">
	<!-- skipnavi --><!-- header -->
	<c:import url="../top_main/top_sysadm_menu.jsp"></c:import>
	<!-- //skipnavi --><!-- //header -->

	<!-- contents -->
	<div id="container">
		<div class="contetns">

			<!-- centercnt_top -->
			<div class="center_cnt_1300_ds">

				<!-- centercnt_bot -->
				<div class="centercnt_1300_bot1-2_ds">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">보고서 종결일 수정</a></li>
							</ul>
						</div>

						<div class="guestcnt_1300_ds" style="display:block; height:700px !important;">
						
							<div class="tableStyle4">
								<form>
									<table>
										<tr>
											<td></td>
											<th>접수번호</th>
											<td>
												<input type="text" id="suim_accept_no" name="suim_accept_no" size="30"/> <button type="submit">검색</button>
											</td>
											<td></td>
										</tr>
										
										<tr>
											<td> </td>
											<td> </td>
											<td> </td>
											<td> </td>
										</tr>
										
									</table>
								</form>
								
								<table>
									<tr>
										<th>접수번호</th>
										<th>현재 종결일</th>
										<th>변경 종결일</th>
										<th>-</th>
									</tr>									
									<c:forEach items="${rptList}" var="item" varStatus="status">
										<tr>
											<td align="center">${item.suim_accept_no}</td>
											<td align="center">${item.close_date}</td>
											<td align="center">
												<input type="text" id="close_date_${status.index}" name="close_date" size="30"/>
											</td>
											<td align="center">
												<button type="button" onclick="fnUpdateCloseDate(${item.suim_rpt_no},${status.index})">변경</button>
											</td>
										</tr>
									</c:forEach>
									
								</table>
							</div>				
						
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>



</body>
</html>
