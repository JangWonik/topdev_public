<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="./resources/ne_js/jquery.form.js"></script>

<script>
	$(document).ready(function(){
		$("#attchFileSuit17").change(function(){
			$("#suimSuit17RptOrgFileBtn").click();			
		});
		
		if($("#fileListSize").val() == "20"){
			$("#attchFileSuit17").css("display","none");						  
		}
		
	});
	
	function suit17ImgSubDel(imgSerial,suimRptNo,imgName){
		if(confirm("이미지를 삭제하시겠습니까?")){
			$.post("./suit17ImgDelOk",
					{	
						serialNo 	:	imgSerial  //	
						,suimRptNo	: 	suimRptNo
						,fileName	: 	imgName
						
					},
					function(data,status){
						if(status == "success"){
							if(data != 0){
								$("#suit17ImgTr_"+imgSerial).remove();
								$("#fileListSize").val( parseInt($("#fileListSize").val())-1 );
								
								if( parseInt($("#fileListSize").val()) < 10){
									$("#attchFileSuit17").css("display","block");						  
								}
							}else{
								alert("시스템 오류입니다. 잠시 후 재시도 해주세요.");	
							}
						}else{
							alert("시스템 오류입니다. 잠시 후 재시도 해주세요.");
						}
					}
			);		
		}
	}

	$("#UploadForm").ajaxForm({
		dataType : 'text',
		success:function(data) {
			/* 파라미터 설정 시작 : form 태그 내에 설정안된 파라미터는 본 스크립트에서 삭제해야함(에러발생방지) */
			
			var gubun =  document.UploadForm.gubun.value;
			var imgpage =  document.UploadForm.imgpage.value;
			var func =  document.UploadForm.func.value;
				  
			/* 파라미터 설정 끝 */
			
			if(gubun == "0"){
				if( (data != "0") && (data !="1") && (data !="9") ){
					$("#suit17FileListBody").append(
					 "<tr id = 'suit17ImgTr_"+data.split("+")[0]+"'>"
					+	"<td width='70%' align='center'>"+data.split("+")[1]+"</td>"
					+	"<td align='center'>"
					+		"<img src='./resources/ls_img/btn_del.gif' id = 'suit17ImgDelBtn_"+data.split("+")[0]+"' onclick=\"suit17ImgSubDel('"+data.split("+")[0]+"','${suimSuit_17Vo.suimRptNo}','"+data.split("+")[1]+"');\" style='cursor:pointer;'/>"
					+	"</td>"
					+"</tr>"  
					);
						  
					$("#fileListSize").val( parseInt($("#fileListSize").val())+1 ); 
					if($("#fileListSize").val() == "10"){
						$("#attchFileSuit17").css("display","none");						  
					}
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
	<input type="file" name="attchFile" id="attchFileSuit17"  />
	
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
	-->
	<input  type="hidden" name = "func" value = "11"/>
	
	<!-- 
		이미지 업로드 경우 : value = "0" 
		파일 업로드 경우 : value = "1"
	-->
	<input  type="hidden" name = "gubun" value = "0"/> 
	<!-- 
		업로드 후 이미지를 화면에 바로 출력 할 경우 : value = "1"  
	      업로드 후 이미지를 화면에 바로 출력하지 않을 경우 : value = "0"  
	 -->
	<input  type="hidden" name = "imgpage" value = "0"/> 
	 
	<!-- DB 등록시 필요한 파라미터 설정-->
	
	<input  type="hidden" name = "suimRptNo" value = "${getSuimSuit17DtlBsc.suimRptNo}"/>
	
	<!-- 버튼 : 'jquery.form' 플러그인이 버튼의 submit 타입에서만 동작하여 숨겨놓고 file 태그의 값이 변하면 자동클릭 동작으로 구현 -->
	<input style ="display:none; visibility:hidden;" type="submit" id ="suimSuit17RptOrgFileBtn" class="btn" />
</form>

