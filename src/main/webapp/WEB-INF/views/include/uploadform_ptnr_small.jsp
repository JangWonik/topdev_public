<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="./resources/ne_js/jquery.form.js"></script>

<script>
	$(document).ready(function(){
		$("#attchFile").change(function(){
			$("#upbtn").click();			
		});
	});

	$("#UploadForm").ajaxForm({
		  dataType : 'text',
		  success:function(data) {
		   	  
			  /* 파라미터 설정 시작 : form 태그 내에 설정안된 파라미터는 본 스크립트에서 삭제해야함(에러발생방지) */
			  var id =  document.textContentsForm.ptnr_id.value;
			  var gubun =  document.UploadForm.gubun.value;
			  var imgpage =  document.UploadForm.imgpage.value;
			  var func =  document.UploadForm.func.value;
			  
			  /* 파라미터 설정 끝 */
			  
			  if(gubun == "0"){
				  
				  if( (data != "0") && (data !="1") && (data !="9") ){
					  
					  /* 업로드 후 이미지를 화면에 바로 출력 할 경우 시작*/
					  if(imgpage =="1"){
						  
						  var filename = data;
						  
						  $.ajax({
					           type:"post",
					           url:"getimgstream",
					           data: {id:id, func:"2", filename : filename},  // func:"2" => ig 작은 사진 
					           success : function(imgstream) {
					        	   if(imgstream != ""){
					        		   $("#sImg").attr("src",imgstream); // $("#기능명")
									}else{
										alert('화면출력 실패');
									}
					           }
					     }); 
					  }
					  /* 업로드 후 이미지를 화면에 바로 출력 할 경우 끝*/
					  
				  }else if(data == "1"){
					  alert("이미지 파일이 아닙니다.[JSP/GIF/BMP/PNG]");
				  }else if(data == "0"){
					  alert("DB 등록 실패");
				  }else if(data == "9"){
					  alert("암호화 된 이미지를 업로드 하였습니다.\n암호화 해제 후 다시 업로드 해 주세요.");
				  }				  
			  }else if(gubun == "1"){
				  alert("파일입니다.");
			  }else if(data == "9"){
				  alert("암호화 된 이미지를 업로드 하였습니다.\n암호화 해제 후 다시 업로드 해 주세요.");
			  }
		  }
	});
	
</script>


<form name="UploadForm" id="UploadForm" method="POST" action="upload" enctype="multipart/form-data">
	
	<!-- 파일입력 -->
	<input type="file" name="attchFile" id="attchFile"/>
	
	<!-- 기능 명시 
		value = "0" : 내정보 > 내사진
		value = "1" : 내정보 > 내Sign
		value = "2" : 보험사 정보 > 작은 이미지 
	-->
	<input  type="hidden" name = "func" value = "2"/>
	
	<!-- 
		이미지 업로드 경우 : value = "0" 
		파일 업로드 경우 : value = "1"
	-->
	<input  type="hidden" name = "gubun" value = "0"/> 
	
	<!-- 
		업로드 후 이미지를 화면에 바로 출력 할 경우 : value = "1"  
	      업로드 후 이미지를 화면에 바로 출력하지 않을 경우 : value = "0"  
	 -->
	<input  type="hidden" id = "imgpage" name = "imgpage" value = "1"/> 
	 
	<!-- DB 등록시 필요한 파라미터 설정-->
	<input  type="hidden" name = "id" value = "${ptnrVo.ptnr_id}"/> 
	
	<!-- 버튼 : 'jquery.form' 플러그인이 버튼의 submit 타입에서만 동작하여 숨겨놓고 file 태그의 값이 변하면 자동클릭 동작으로 구현 -->
	<input style ="display:none; visibility:hidden;" type="submit" id ="upbtn" class="btn" />
</form>
