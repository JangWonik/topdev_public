<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="./resources/ne_js/jquery.form.js"></script>

<script>
	$(document).ready(function(){
		$("#attchFilePrint1").change(function(){
			$("#upbtnPrint1").click();			
		});
		
	});
	
	function print1ImgTest(){
		
		if( ($("#rptprint1ImgExplain").val() == '') || ($("#imgRank").val() == '') ){
			$("#attchFilePrint1").prop("disabled",true);
			return;
		}else{
			$("#attchFilePrint1").prop("disabled",false);
		}
	}
	
	function print1ImgSubEdit(imgSerial){
		
		$("#print1ImgEx_"+imgSerial).prop("readonly",false);
		$("#print1ImgRank_"+imgSerial).prop("readonly",false);
		$("#print1ImgEditOkBtn_"+imgSerial).show();
		
		$("#print1ImgRank_"+imgSerial).focus();
		
	}
	
	function print1ImgEditOk(imgSerial){
		
		$.post("./print1ImgEditOk",
				{	
					 serialNo 	:	imgSerial  //
					,imgMemo 	:	$("#print1ImgEx_"+imgSerial).val()  //
					,imgRank 	:	$("#print1ImgRank_"+imgSerial).val()  //
					
				},
				function(data,status){
					if(status == "success"){
						if(data != 0){
							
							$("#print1ImgEx_"+imgSerial).prop("readonly",true);
							$("#print1ImgRank_"+imgSerial).prop("readonly",true);
							$("#print1ImgEditOkBtn_"+imgSerial).hide();
							
						}else{
							alert("시스템 오류입니다. 잠시 후 재시도 해주세요.");	
						}
					}else{
						alert("시스템 오류입니다. 잠시 후 재시도 해주세요.");
					}
				}
		);
		
	}
	
	function print1ImgSubDel(imgSerial,imgName){
		
		if(confirm("이미지를 삭제하시겠습니까?")){
			$.post("./print1ImgDelOk",
					{	
						imgSerial 	:	imgSerial  //	
						,suimRptNo 	:	$("#suimRptNo").val()
						,imgName	:	imgName
					},
					function(data,status){
						if(status == "success"){
							if(data != 0){
								
								$("#print1ImgTr_"+imgSerial).remove();
								
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
						  var filename = dataStream[1];
						  var suimRptNo = $("#suimRptNo").val();
						  
						  $.ajax({
					           type:"post",
					           url:"getimgstream",
					           data: {suimRptNo: suimRptNo,no:serialNo, func:"10", filename : filename},  //  func:"10" => Print1 
					           success : function(imgstream) {
					        	   if(imgstream != ""){
					        		   
					        		   $("#print1ImgList").append(
					        			
				        				   	"<div align='center' style='width:50%; float:left; margin-bottom:10px;' id = 'print1ImgTr_"+serialNo+"'>"
					        				+ 	"<img src='' id ='print1ImgStream_"+serialNo+"' width='50%' height='150' style='vertical-align:middle;' />"
					        				+	"<br />순서 : <input type='text' size='5' readonly='readonly' id = 'print1ImgRank_"+serialNo+"' title='사진 순서' onfocus=\"this.select();\" value='"+$("#imgRank").val()+"'/>"
					        				+	"<br />설명 : <input type='text' readonly='readonly' style='margin-bottom:5px;' id = 'print1ImgEx_"+serialNo+"' title='사진 설명' onfocus=\"this.select();\" value='"+$("#rptprint1ImgExplain").val()+"'/><br />"
					        				+ 	"<img src='./resources/ls_img/btn_edite.gif' id = 'print1ImgEditBtn_"+serialNo+"' onclick=\"print1ImgSubEdit('"+serialNo+"');\" style='cursor:pointer;'/>"
					        				+ 	"<img src='./resources/ls_img/btn_del.gif' id = 'print1ImgDelBtn_"+serialNo+"' onclick=\"print1ImgSubDel('"+serialNo+"','"+filename+"');\" style='cursor:pointer; '/>"
					        				+ 	"<img src='./resources/ls_img/btn_check_s.gif' id = 'print1ImgEditOkBtn_"+serialNo+"' onclick=\"print1ImgEditOk('"+serialNo+"');\" style='cursor:pointer;  display:none;'/>"
					         				+"</div>"
					        		   
					        		   ); // $("#기능명")
					        		   $("#print1ImgStream_"+serialNo).attr("src",imgstream); // 
					        		   //$("#attachedImg").css("display","block");
					        		   $("#rptprint1ImgExplain").html("");
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
	
	
	
	<!-- 기능 명시 
		value = "0" : 내정보 > 내사진
		value = "1" : 내정보 > 내Sign
		value = "2" : ptnr small
		value = "3" : ptnr big
		value = "4" : site img
		value = "10" : print1 img
	-->
	<input  type="hidden" name = "func" value = "10"/>
	
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
	<input  type="hidden" name = "suimRptNo" id = "suimRptNo" value = "${suimVO.suim_rpt_no}"/>
	 
	<br />
	
	<table style="margin-bottom:10px; width:648;" >
		<tr align="center">
			<th class="td" width="280"  bgcolor="#ECECEC" >사진설명</th>
			<th class="td" width="80"  bgcolor="#ECECEC" >출력순서</th>
			<th class="td" width="280"  bgcolor="#ECECEC" >비고</th>
		</tr>
		<tr align="center">
			<td class="td" align="center" >
				<input name = "rptprint1ImgExplain" size="36" id="rptprint1ImgExplain" title="사진 설명" onkeyup="print1ImgTest();" ></input>
			</td>
			<td class="td" align="center">
				<input type="text" size="7" name = "imgRank" id="imgRank" onkeyup="print1ImgTest();"/>
			</td>
			<td class="td" align="center">
				<!-- 파일입력 -->
				<input type="file" name="attchFile" id="attchFilePrint1" disabled="disabled" onclick ="fileSearch();"/>
			</td>
		</tr>
	</table>
	
	<!-- 버튼 : 'jquery.form' 플러그인이 버튼의 submit 타입에서만 동작하여 숨겨놓고 file 태그의 값이 변하면 자동클릭 동작으로 구현 -->
	<input style ="display:none; visibility:hidden;" type="submit" id ="upbtnPrint1" class="btn" />
</form>
