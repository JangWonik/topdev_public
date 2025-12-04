<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<script src="./resources/ne_js/jquery.form.js"></script>

<script>
	$(document).ready(function(){
		$.ajaxSetup({cache:false});
		
		$("#mmsAttchFile").change(function(){
			$("#btn_mms_submit").click();
		});
		
		if(${memberVo.mmsPicture != null && memberVo.mmsPicture != ''}){
			$("#mmsAttchFile").prop("disabled",true);
		}else{
			$("#mmsAttchFile").prop("disabled",false);
		}
		
	});

	function mmsDelete(userno){
		
		var delCheck = confirm("삭제하시겠습니까?");
		
		if(delCheck == true){
			var user_no =  document.mbrDetailFrm.user_no.value;
			
			$.ajax({
		           type:"post",
		           url:"deleteimg",
		           data: {func: "16", gubun: "0", user_no: user_no},  // func:"1" => 내사인 , gubun :"0" => 이미지
		           success : function(data) {
		        	   
		        	   if(data == 2){
			        	   
			        	   $("#div_mms_item").hide();
			        	   $("#mmsAttchFile").prop("disabled",false);
		        	   }
		           }
		     }); 	
		}
		
	}
	
	$("#mmsUploadForm").ajaxForm({
		  dataType : 'text',
		  success:function(data) {
			  
			  /* 파라미터 설정 시작 : form 태그 내에 설정안된 파라미터는 본 스크립트에서 삭제해야함(에러발생방지) */
			  var no =  document.mbrDetailFrm.user_no.value;
			  var imgpage =  document.mmsUploadForm.imgpage.value;
			  var func =  document.mmsUploadForm.func.value;
			  /* 파라미터 설정 끝 */
			  
			  if( (data != "0") && (data !="1") && (data !="9") ){
				  
				  /* 업로드 후 이미지를 화면에 바로 출력 할 경우 시작*/
				  if(imgpage =="1"){
					  
					  var filename = data;
					  var filenameonly = data.split(".");
					  
					  $.ajax({
				           type:"post",
				           cache: false,
				           url:"getimgstream",
				           data: {no:no, func:func, filename : filename}, // func:"기능명" 
				           success : function(data) {
				        	   var imgStream = data;

							   var newimg =
									"<div id = 'div_mms_item'>"
								  +	"<img id ='img_mms_item' style = 'margin-top:5px; margin-left:2px;' src='' border='0' height='40' width='65' />"
								  + "<img style ='cursor:pointer; margin-top:5px; vertical-align: top;' src='./resources/ls_img/member/btn_del.gif' alt='삭제' onclick='mmsDelete("+no+")'/>"
								  + "</div>";

								$("#div_mms").append(newimg);
								$("#img_mms_item").attr("src",imgStream);
								$("#mmsAttchFile").prop("disabled",true);
				        		    
				           }
				     }); 
				  }
				  /* 업로드 후 이미지를 화면에 바로 출력 할 경우 끝*/
				  
			  }else if(data == "1"){
				  alert("이미지 파일이 아닙니다.[JPG/GIF/BMP/PNG]");
			  }else if(data == "0"){
				  alert("DB 등록 실패");
			  }	else if(data == "9"){
				  alert("암호화 된 이미지를 업로드 하였습니다.\n암호화 해제 후 다시 업로드 해 주세요.");
			  }				  
			  
		  }
	});
	
</script>


<form style = "display:inline;" name="mmsUploadForm" id="mmsUploadForm" method="POST" action="upload" enctype="multipart/form-data">

	<input type="file" name="attchFile" id="mmsAttchFile" accept=".jpg"/>
	
	<!-- 기능 명시 -->
	<input  type="hidden" name = "func" value = "16"/>
	
	<!-- 
		이미지 업로드 경우 : value = "0" 
		파일 업로드 경우 : value = "1"
	-->
	<input  type="hidden" name = "gubun" value = "0"/> 
	
	<!-- 
		업로드 후 이미지를 화면에 바로 출력 할 경우 : value = "1"  
	      업로드 후 이미지를 화면에 바로 출력하지 않을 경우 : value = "0"  
	 -->
	<input  type="hidden" name = "imgpage" id = "imgpage" value = "1"/> 
	
	<!-- 파라미터 전달 -->
	<input  type="hidden" name = "no" value = "${memberVo.user_no}"/>
	
	<!-- 버튼 : 'jquery.form' 플러그인이 버튼의 submit 타입에서만 동작하여 숨겨놓고 file 태그의 값이 변하면 자동클릭 동작으로 구현 -->
	<input style ="display:none; visibility:hidden;" type="submit" id ="btn_mms_submit" class="btn" />
</form>

<div id = "div_mms" >
	<!-- 기존사인 -->
	<c:if test="${memberVo.mmsPicture != null && memberVo.mmsPicture != ''}">
		<div id = "div_mms_item">
			<img style = "margin-top:5px;" src="${mmsImageBase64}" alt="" border="0" height="40" width="65" />
			<img style = "cursor:pointer; margin-top:5px; vertical-align: top; " src="./resources/ls_img/member/btn_del.gif" alt="삭제" onclick="mmsDelete('${memberVo.user_no}')"/>
		</div>
	</c:if>
</div>	

