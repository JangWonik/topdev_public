<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="./resources/ne_js/jquery.form.js"></script>

<script>
	$(document).ready(function(){
		$("#attchFileRptIssue").change(function(){			
			$("#rptIssueFileBtn").click();			
		});		
	});

	$("#UploadFileFormRptIssue").ajaxForm({
		  dataType : 'text',
		  success:function(data) {
			  
			  /* 파라미터 설정 시작 : form 태그 내에 설정안된 파라미터는 본 스크립트에서 삭제해야함(에러발생방지) */
			  
			  var func = 17;
			  
			  /* 파라미터 설정 끝 */
				  
				  if( (data != "0") && (data !="1") && (data !="9") ){
					  //업로드가 끝나면 교부 ajax 호출
					  getSendList();
					   
					  /* var dataStream = data.split("+");
					  
					  var regDate = dataStream[0];
					  var fileSerial = dataStream[1];

					  var fileName = $("#attchFileRptIssue").val();
					  var subfilename = fileName.substr(fileName.lastIndexOf("\\")+1);

					  $("#RptIssueFileList").append(
        				   	"<tr id = 'rptFileOrgTr_"+fileSerial+"'>"
	       					+	"<td>"
	       					+ "<a href='fileDownload?key="+fileSerial+"&type=rptIssue&suimRptNo="+$("#suimRptNo").val()+"'>"
        				    +  	"<font color='blue'>" +subfilename+"</font>"
       					    + "</a>"
       					 	+"</td>"
	       					+	"<td>"+regDate
	       					+   "<img src='./resources/ls_img/btn_del_s.gif' onclick=\"RptIssueFileDel('"+fileSerial+"');\" style='cursor:pointer; margin-left:5px;'/>"
	       					+"</td>"
	       					+"</tr>"
	        		   ); */
	        		  
				  }else if(data == "1"){
					  alert(" 파일 형식이 오류입니다.\n (PDF, XLS, DOC, HWP, DOCX, XLSX 만 가능합니다.)");
				  }else if(data == "0"){
					  alert("DB 등록 실패");
				  }	else if(data == "9"){
					  alert("파일을 암호화 후 업로드 해 주세요.");
				  }			  
		  }
	});
	
</script>

<form name="UploadFileFormRptIssue" id="UploadFileFormRptIssue" method="POST" action="upload" enctype="multipart/form-data">
	
	<!-- 파일입력 -->
	<input type="file" name="attchFile" id="attchFileRptIssue"  />
	
	<!-- 기능 명시 
		value = "0" : 내정보 > 내사진
		value = "1" : 내정보 > 내Sign
		value = "2" : ptnr small
		value = "3" : ptnr big
		value = "4" : site img
		value = "5" : site file
		value = "6" : 보고서 원본 파일
		value = "17" : 손해사정서 동의서파일
	-->
	<input  type="hidden" name = "func" value = "17"/>
	
	<!-- 
		이미지 업로드 경우 : value = "0" 
		파일 업로드 경우 : value = "1"
		이미지 또는 파일 업로드 경우 : value = "2"
	-->
	<input  type="hidden" name = "gubun" value = "2"/> 
	
	<!-- 
		업로드 후 이미지를 화면에 바로 출력 할 경우 : value = "1"  
	      업로드 후 이미지를 화면에 바로 출력하지 않을 경우 : value = "0"  
	 -->
	<input  type="hidden" name = "imgpage" value = "0"/> 
	 
	<!-- DB 등록시 필요한 파라미터 설정-->
	
	<input  type="hidden" name = "suimRptNo" value = "${suimVO.suim_rpt_no}"/>
	
	<!-- 버튼 : 'jquery.form' 플러그인이 버튼의 submit 타입에서만 동작하여 숨겨놓고 file 태그의 값이 변하면 자동클릭 동작으로 구현 -->
	<input style ="display:none; visibility:hidden;" type="submit" id ="rptIssueFileBtn" class="btn" />
</form>

