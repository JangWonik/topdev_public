<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="./resources/ne_js/jquery.form.js"></script>

<script>
	$(document).ready(function(){
		$.ajaxSetup({cache:false});
		$("#attchFile").change(function(){
			$("#upbtn").click();			
		});
		
	});
	
	function siteImgSubEdit(imgSerial){
		$("#siteImgEx_"+imgSerial).prop("disabled",false);
		$("#siteImgEditBtn_"+imgSerial).css("display","none");
		$("#siteImgDelBtn_"+imgSerial).css("display","none");
		$("#siteImgEditOkBtn_"+imgSerial).css("display","block");
		
	}
	
	function siteImgEditOk(imgSerial){
		$.post("./siteImgEditOk",
				{	
					imgSerial 	:	imgSerial  //
					, subject 	:	$("#siteImgEx_"+imgSerial).html()  //
					
				},
				function(data,status){
					if(status == "success"){
						if(data != 0){
							
							$("#siteImgEx_"+imgSerial).prop("disabled",true);
							$("#siteImgEditBtn_"+imgSerial).css("display","inline");
							$("#siteImgDelBtn_"+imgSerial).css("display","inline");
							$("#siteImgEditOkBtn_"+imgSerial).css("display","none");
							
						}else{
							alert("시스템 오류입니다. 잠시 후 재시도 해주세요.");	
						}
					}else{
						alert("시스템 오류입니다. 잠시 후 재시도 해주세요.");
					}
				}
		);
		
	}
	
	function siteImgSubDel(imgSerial){
		if(confirm("이미지를 삭제하시겠습니까?")){
			$.post("./siteImgDelOk",
					{	
						imgSerial 	:	imgSerial  //						
					},
					function(data,status){
						if(status == "success"){
							if(data != 0){
								
								$("#siteImgTr_"+imgSerial).html("");
								
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
					  
					  /* 업로드 후 이미지를 화면에 바로 출력 할 경우 시작*/
					  if(imgpage =="1"){
						  
						  var dataStream = data.split("+");
						  var serialNo = dataStream[0];
						  var path = dataStream[1];
						  var filename = dataStream[2];
						  
						  $.ajax({
					           type:"post",
					           url:"getimgstream",
					           data: {no:serialNo, path: path,func:"4", filename : filename},
					           success : function(imgstream) {
					        	   if(imgstream != ""){
					        		   
					        		   $("#attachedImg").append(
					        			
					        				   "<tr id = 'siteImgTr_"+serialNo+"'>"
					        				   + "<td align='center'>"
					        				   + "<textarea style='margin-top: 5px;' disabled='disabled' rows='10' cols='25' id = 'siteImgEx_"+serialNo+"' title='사진 설명' >"+$("#rptSiteImgExplain").html()+"</textarea>"
					        				   + "<img src='./resources/ls_img/btn_edite.gif' id = 'siteImgEditBtn_"+serialNo+"' onclick=\"siteImgSubEdit('"+serialNo+"');\" style='cursor:pointer; margin-top:5px;'/>"
					        				   + "<img src='./resources/ls_img/btn_del.gif' id = 'siteImgDelBtn_"+serialNo+"' onclick=\"siteImgSubDel('"+serialNo+"');\" style='cursor:pointer; margin-top:5px;'/>"
					        				   + "<img src='./resources/ls_img/btn_check_s.gif' id = 'siteImgEditOkBtn_"+serialNo+"' onclick=\"siteImgEditOk('"+serialNo+"');\" style='cursor:pointer; margin-top:5px; display:none;'/>"
					        				   + "</td>"
					        				   + "<td align='center'>"
					        				   + "<img src='' id ='siteImgStream_"+serialNo+"' width='369' height='206' style='vertical-align:middle;' />"
					        				   + "</td>"
					        				   + "</tr>"
					        		   
					        		   ); // $("#기능명")
					        		   $("#siteImgStream_"+serialNo).attr("src",imgstream); // 
					        		   $("#attachedImg").css("display","block");
					        		   $("#rptSiteImgExplain").html("");
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
				  }	else if(data == "9"){
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
	<input type="file" name="attchFile" id="attchFile" onclick ="fileSearch();"/>
	
	<!-- 기능 명시 
		value = "0" : 내정보 > 내사진
		value = "1" : 내정보 > 내Sign
		value = "2" : ptnr small
		value = "3" : ptnr big
		value = "4" : site img
	-->
	<input  type="hidden" name = "func" value = "4"/>
	
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
	<input  type="hidden" name = "no" value = "${memberVo.user_no}"/>
	 
	<input  type="hidden" name = "rptSiteNo" value = "${suimRptSiteVo.rptSiteNo}"/>
	<input  type="hidden" name = "suimRptNo" value = "${suimListDtl.suimRptNo}"/> 
	<input  type="hidden" name = "interimFlag" value = "${interimFlag}"/> 
	
	<br />
	<textarea style="margin-top: 5px;" rows="2" cols="40" name = "rptSiteImgExplain" id="rptSiteImgExplain" title="사진 설명" ></textarea>
	
	<!-- 버튼 : 'jquery.form' 플러그인이 버튼의 submit 타입에서만 동작하여 숨겨놓고 file 태그의 값이 변하면 자동클릭 동작으로 구현 -->
	<input style ="display:none; visibility:hidden;" type="submit" id ="upbtn" class="btn" />
</form>
