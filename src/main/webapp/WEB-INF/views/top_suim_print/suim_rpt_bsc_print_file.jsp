<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<script>
		$(document).ready(function(){
			
		});
	</script>
	
</head>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
	<table align="center" cellpadding="0" cellspacing="0" width="648">
		<tr>
			<td height="25" width="50%">
				<p class="p2"><b>&lt; 첨부 사진 &gt;</b></p>
			</td>
		</tr>
		<tr>
			<td id = "attachSiteImg" height="25" width="50%">
				<p align="right">
					<%@include file="../include/uploadform_print_1.jsp"%>
				</p>
			</td>
		</tr>
	</table>

	<div style="width:650;" id = "print1ImgList" >
		<c:forEach items="${suimRptImgPrint_1List}" var="attachPrint1ImgVo">
			 <div align="center" style="width:50%; float:left;margin-bottom:10px;" id = 'print1ImgTr_${attachPrint1ImgVo.serialNo}'>
				 	<img src='${attachPrint1ImgVo.imgStream}' id ='print1ImgStream_${attachPrint1ImgVo.serialNo}' width='50%' height='150' style='vertical-align:middle;' />
				 	<br />순서 : <input type="text" readonly="readonly" size="5" id = 'print1ImgRank_${attachPrint1ImgVo.serialNo}' title='사진 순서' onfocus="this.select();" value="${attachPrint1ImgVo.imgRank}"/>
				 	<br />설명 : <input type="text" readonly="readonly" style="margin-bottom:5px;" id = 'print1ImgEx_${attachPrint1ImgVo.serialNo}' title='사진 설명' onfocus="this.select();" value="${attachPrint1ImgVo.imgMemo}"/><br />
				 	<img src='./resources/ls_img/btn_edite.gif' id = "print1ImgEditBtn_${attachPrint1ImgVo.serialNo}" onclick="print1ImgSubEdit('${attachPrint1ImgVo.serialNo}');" style='cursor:pointer;'/>
				 	<img src='./resources/ls_img/btn_del.gif' id = 'print1ImgDelBtn_${attachPrint1ImgVo.serialNo}' onclick="print1ImgSubDel('${attachPrint1ImgVo.serialNo}','${attachPrint1ImgVo.imgName}');" style='cursor:pointer;'/>
				 	<img src='./resources/ls_img/btn_check_s.gif' id = 'print1ImgEditOkBtn_${attachPrint1ImgVo.serialNo}' onclick="print1ImgEditOk('${attachPrint1ImgVo.serialNo}');" style='cursor:pointer; margin-top:5px; display:none;'/>
 				 </div>
		</c:forEach>
 	</div>
</body>
