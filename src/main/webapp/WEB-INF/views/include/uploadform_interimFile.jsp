<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="./resources/ne_js/jquery.form.js"></script>

<script>
	$(document).ready(function(){
		$("#attchFileInterim_"+'${interimVo.rptSiteNo}').change(function(){
			$("#upInterimFileBtn_"+'${interimVo.rptSiteNo}').click();	
		});
		
	});

	$("#UploadFileFormInterim_"+'${interimVo.rptSiteNo}').ajaxForm({
		  dataType : 'text',
		  success:function(data) {
			  
			  /* 파라미터 설정 시작 : form 태그 내에 설정안된 파라미터는 본 스크립트에서 삭제해야함(에러발생방지) */
			  
			  var gubun =  1;
			  var func =  5;
			  
			  /* 파라미터 설정 끝 */
			  
			  if(gubun == "1"){
				  
				  if( (data != "0") && (data !="1") && (data !="9") ){
					    
					  var dataStream = data.split("+");
					  var siteRptNo = dataStream[0];
					  var siteSubDate = dataStream[2];
					  
					  var filename = $("#attchFileInterim_"+siteRptNo).val();
					  
					  var subfilename = filename.substr(filename.lastIndexOf("\\")+1);
					  
					  $("#interimFileDownArea_"+siteRptNo).append(
	        			
        				     "<td align='center' colspan='4' >" // id ='interimFileDownArea_"+siteRptNo+"'
	        				   + "<a href='fileDownload?key="+siteRptNo+"&type=siteInterim'>"
	        				   +  subfilename
	       					   + "</a>"
	       					   + "<img src='./resources/ls_img/btn_del_s.gif' id = 'interimFileDelBtn_"+siteRptNo+"' onclick=\"interimFileDel('"+siteRptNo+"');\" style='cursor:pointer; margin-left:5px;'/>"
        				   + "</td>"
        				
	        		   ); 

	        		   //$("#interimFileUploadTd_"+siteRptNo).css("display","none");
	        		   $("#interimFileUploadTd_"+siteRptNo).hide();
	        		   $("#interimRptFileUpBtnID_"+siteRptNo).css("display","none");
	        		   $("#interimFileDownArea_"+siteRptNo).show();
	        		   $("#interimSubDate_"+siteRptNo).html(siteSubDate);
	        		   
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
					  alert(" 파일이 형식 오류.[DOC]");
				  }else if(data == "0"){
					  alert("DB 등록 실패");
				  }else if(data == "9"){
					  alert("보고서를 암호화 후 업로드 해 주세요.");
				  }				  
			  }else if(gubun == "1"){
				  alert(" 파일이 형식 오류.[DOC]");
			  }else if(data == "9"){
				  alert("보고서를 암호화 후 업로드 해 주세요.");
			  }
		  }
	});
	
	function interimFileDel(siteRptNo){
		if(confirm("보고서 파일을 삭제하시겠습니까?")){
			$.post("./siteFileDelOk",
					{	
						siteRptNo 	:	siteRptNo  //						
					},
					function(data,status){
						if(status == "success"){
							if(data != 0){
								
								$("#interimFileDownArea_"+siteRptNo).html("");
								//$("#interimFileDownArea_"+siteRptNo).css("display","none");
								$("#interimRptFileUpBtnID_"+siteRptNo).css("display","inline");								
								$("#interimFileUploadTd_"+siteRptNo).css("display","none");
								$("#interimSubDate_"+siteRptNo).html("미제출");
								
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
	
</script>

<form name="UploadFileFormInterim_${interimVo.rptSiteNo}" id="UploadFileFormInterim_${interimVo.rptSiteNo}" method="POST" action="upload" enctype="multipart/form-data">
	
	<!-- 파일입력 -->
	<input type="file" name="attchFile" id="attchFileInterim_${interimVo.rptSiteNo}"  />
	
	<!-- 기능 명시 
		value = "0" : 내정보 > 내사진
		value = "1" : 내정보 > 내Sign
		value = "2" : ptnr small
		value = "3" : ptnr big
		value = "4" : site img
		value = "5" : site file
	-->
	<input  type="hidden" name = "func" value = "5"/>
	
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
	
	<input  type="hidden" name = "rptSiteNo" value = "${interimVo.rptSiteNo}"/>
	<input  type="hidden" name = "interimFlag" value = "interim"/> 
	
	<!-- 버튼 : 'jquery.form' 플러그인이 버튼의 submit 타입에서만 동작하여 숨겨놓고 file 태그의 값이 변하면 자동클릭 동작으로 구현 -->
	<input style ="display:none; visibility:hidden;" type="submit" id ="upInterimFileBtn_${interimVo.rptSiteNo}" class="btn" />
</form>

