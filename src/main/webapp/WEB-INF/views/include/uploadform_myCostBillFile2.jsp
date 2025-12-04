<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="./resources/ne_js/jquery.form.js"></script>

<script>
	$(document).ready(function(){
		$("#attchFileMyCostBill2").change(function(){
			$("#myCostBillFileBtn2").click();
		});
		
	});

	$("#UploadFileFormMyCostBill2").ajaxForm({
		  dataType : 'text',
		  success:function(data) {
			  
			  /* 파라미터 설정 시작 : form 태그 내에 설정안된 파라미터는 본 스크립트에서 삭제해야함(에러발생방지) */
			  
			  var gubun =  0;
			  var func =  9;
			  
			  /* 파라미터 설정 끝 */
			  
			  if(gubun == "0"){
				  
				  if( (data != "0") && (data !="1") && (data !="9") ){
					   
					  var dataStream = data.split("+");
					  
					  var regDate = dataStream[0];
					  var fileSerial = dataStream[1];
					  var fileName = $("#attchFileMyCostBill2").val();
					  var subfilename = fileName.substr(fileName.lastIndexOf("\\")+1);
 
					  $("#myCostBillFileList2").append(
        				   	"<tr id = 'myCostBillFileOrgTr_"+fileSerial+"'>"
	       					+	"<td>"
	       					+ "<a href='myCostBillFileDownload?key="+fileSerial+"&type=rptOrigin&cost_deposit_no="+$("#cost_deposit_no").val()+"'>"
        				    +  	"<font color='blue'>" +subfilename+"</font>"
       					    + "</a>"
       					 	+"</td>"
	       					+	"<td>" +regDate 
	       					+   "<img src='./resources/ls_img/btn_del_s.gif' onclick=\"rptOrgFileDel('"+fileSerial+"');\" style='cursor:pointer; margin-left:5px;'/>"
	       					+"</td>"
	       					+"</tr>"
	        		   ); 
					  window.location.reload();
						/* 파일태그 초기화 */
	        			/* var fileList = document.getElementById("attchFileInterim_"+rptSiteNo);
	        			fileList[0].select();
	        		    document.selection.clear(); */
	        		   /* 파일태그 초기화 : 
	        			   1) 파일태그의 onchange로 업로드 동작을 수행하기에 동일파일명으로 재 업로드시 동작이 안걸리는 문제가 발생
	        			   2) ID 값으로 태그를 잡아서 value= '' 값을 넣어도 초기화 안됨 : 파일 태그가 기본적으로 readonly 속성이기 때문
	        			   3) 해결책으로 file 태그를 잡아서 clear 시키면 태그의 문자열이 초기화 되지만 이 후 submit 동작이 걸리면 브라우저에서 액세스 거부 오류 발생
	        			      : 파일 태그의 버그임
	        			   4) Todo : 동일 파일명으로 업로드하는 경우를 사용자 동작 예외로 하고 해결책 찾기 
	        			*/
	        		  
				  }else if(data == "1"){
					  alert(" 파일이 형식 오류");
				  }else if(data == "0"){
					  alert("DB 등록 실패");
				  }else if(data == "9"){
					  alert("보고서를 암호화 후 업로드 해 주세요.");
				  }				  
			  }else if(gubun == "1"){
				  alert(" 파일이 형식 오류");
			  }else if(data == "9"){
				  alert("보고서를 암호화 후 업로드 해 주세요.");
			  }
		  }
	});
	
</script>
<c:set value="${myCostBillFileList}" var="myCostBillFileList"/>
<form name="UploadFileFormMyCostBill2" id="UploadFileFormMyCostBill2" method="POST" action="upload" enctype="multipart/form-data">
	
	<!-- 파일입력 -->
	<input type="file" name="attchFile" id="attchFileMyCostBill2"  />
	
	<!-- 기능 명시 
		value = "0" : 내정보 > 내사진
		value = "1" : 내정보 > 내Sign
		value = "2" : ptnr small
		value = "3" : ptnr big
		value = "4" : site img
		value = "5" : site file
		value = "6" : 보고서 원본 파일
		value = "7" : 협조건  파일
		value = "8" : 농작물 보고서 원본 파일
		value = "9" : 나의 경비내역 영수증 파일
	-->
	<input  type="hidden" name = "func" value = "9"/>
	
	<!-- 
		이미지 업로드 경우 : value = "0" 
		파일 업로드 경우 : value = "1"
	-->
	<input  type="hidden" name = "gubun" value = "2"/> 
	
	<!-- 
		업로드 후 이미지를 화면에 바로 출력 할 경우 : value = "1"  
	      업로드 후 이미지를 화면에 바로 출력하지 않을 경우 : value = "0"  
	 -->
	<input  type="hidden" name = "imgpage" value = "0"/> 
	 
	<!-- DB 등록시 필요한 파라미터 설정-->
	
	<input  type="hidden" name = "cost_deposit_no" value = "${getMyCostDepositInfo.cost_deposit_no}"/>
	
	<!-- 버튼 : 'jquery.form' 플러그인이 버튼의 submit 타입에서만 동작하여 숨겨놓고 file 태그의 값이 변하면 자동클릭 동작으로 구현 -->
	<input style ="display:none; visibility:hidden;" type="submit" id ="myCostBillFileBtn2" class="btn" />
</form>

