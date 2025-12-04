
	$(document).ready(function(){
			//ajax 중복 호출을 위한 cache:false
			$.ajaxSetup({cache:false});
			
			/** 메뉴 출력 플래그 **/
			fnRaidoViewCtrl("sagoDoc",$("#sagoDocFlag").val());
			fnRaidoViewCtrl("job",$("#jobUseFlag").val());
			fnRaidoViewCtrl("accident",$("#accidentUseFlag").val());
			fnRaidoViewCtrl("hospital",$("#hospitalUseFlag").val());
			fnRaidoViewCtrl("advice",$("#adviceUseFlag").val());
			
			//jobContent 초기값
			//초기값 세팅시 			
			if ($("#jobContent").val() == null || $("#jobContent").val() == ""){
				var htmlJob = replaceHtml( $("#faceInsuredJob6").val() );
				var str = "계약&nbsp;시&nbsp;:&nbsp;"+htmlJob+"<br>사고&nbsp;시&nbsp;:&nbsp;"+htmlJob+"<br>현&nbsp;&nbsp;&nbsp;&nbsp;재&nbsp;:&nbsp;"+htmlJob; 
				$("#jobDtlSpan").html(str);
				$("#jobDtlTxtArea").html(str);
			}
			
			
			/***** 1. 계약확인사항  *****/
			$("#SimpleMod1Btn").click(function(){//수정버튼
			
				/****** 버튼  visible 조작 ******/
				$("#SimpleMod1Btn").hide();
				$("#SimpleCancel1Btn").show();
				$("#SimpleSave1Btn").show();
				
				/****** 출력데이터 visible 조작 ******/
				$(".1Span").hide();
				$(".simple1Txt").show();
			});
			
			$("#SimpleCancel1Btn").click(function(){//취소버튼
				/****** 버튼  visible 조작 ******/
				$("#SimpleMod1Btn").show();
				$("#SimpleCancel1Btn").hide();
				$("#SimpleSave1Btn").hide();
				
				/****** 출력데이터 visible 조작 ******/
				$(".1Span").show();
				$(".simple1Txt").hide();
			});
			
			$("#SimpleSave1Btn").click(function(){//저장하기버튼
				$.post("./udtPrint1001One"
						,{
							 suimRptNo : $("#suimRptNo").val()
							,rptPrintNo : $("#rptPrintNo").val() 
							,insuNm : $("#insuNm1Txt").val()
							,policyNo : $("#policyNo1Txt").val()  
							,insuTerm1 : $("#insuTerm1Txt").val()
							,insuMortgage1 : $("#mortgage1Txt").val()  
							,faceInsuredJob6 : $("#jobChk1Txt").val() 
						},
						function(data,status){
							if (data == 1 && status == 'success'){
								$("#insuNm1Span").html( $("#insuNm1Txt").val() );
								$("#policyNo1Span").html( $("#policyNo1Txt").val() );
								$("#insuTerm1Span").html( $("#insuTerm1Txt").val() );
								$("#mortgage1Span").html( $("#mortgage1Txt").val() );
								$("#jobChk1Span").html( $("#jobChk1Txt").val() );
								$("#SimpleCancel1Btn").click();
							}else{
								alert("저장에 실패하였습니다. 잠시후 시도해주세요..");
							}
						}
				);// $.post("./udtPrint1001One")
			});// $("#SimpleSave1Btn").click()
			/***** 1. 계약확인사항 끝 *****/
			
			/***** 2. 청구사항  *****/
			$("#claimModBtn").click(function(){//수정버튼
				/****** 버튼  visible 조작 ******/
				$("#claimModBtn").hide();
				$("#claimCancelBtn").show();
				$("#claimSaveBtn").show();
				
				/****** 출력데이터 visible 조작 ******/
				$(".claimSpan").hide();
				$(".claimTxt").show();
			});
			
			$("#claimCancelBtn").click(function(){//취소버튼
				/****** 버튼  visible 조작 ******/
				$("#claimModBtn").show();
				$("#claimCancelBtn").hide();
				$("#claimSaveBtn").hide();
				
				/****** 출력데이터 visible 조작 ******/
				$(".claimSpan").show();
				$(".claimTxt").hide();
			});
			
			$("#claimSaveBtn").click(function(){//저장하기버튼
				$.post("./udt1001claim"
						,{
							 suimRptNo : $("#suimRptNo").val()
							,rptPrintNo : $("#rptPrintNo").val() 
							,diagnosisDisease3 : $("#diseaseClaimTxt").val()  
							,diagnosisHospital3 : $("#hospitalClaimTxt").val() 
						},
						function(data,status){
							if (data == 1 && status == 'success'){
								$("#diseaseClaimSpan").html( $("#diseaseClaimTxt").val() );
								$("#hospitalClaimSpan").html( $("#hospitalClaimTxt").val() );
								$("#claimCancelBtn").click();
							}else{
								alert("저장에 실패하였습니다. 잠시후 시도해주세요..");
							}
						}
				);// $.post("./udt1001claim")
			});// $("#claimSaveBtn").click()
			/***** end 2. 청구사항  *****/
			
			//===========================================
			//=========== 4. 중점 조사사항 및 조사결과 ===========
			//===========================================
				
			//중점 조사사항 - 수정버튼
			$("#inspectPointModBtn").click(function(){
 				//버튼영역 조작
				$("#ModBtnInspectPointSpan").hide();
				$("#ModAftBtnInspectPointSpan").show();
				
				//입력창 조작
				$("#inspectPointSpan").hide();
				$("#inspectPointTxtArea").show();
				$("#inspectPointTxtArea").val( replaceTextArea($("#inspectPointTxtArea").val()) );
				
				//조사사항 리스트추가 화면 출력
				$("#pointBtnTr").show();
				
				//
				$("#inspectPointTxtArea").focus();
				$(this).focus();
				
			});
			
			//중점 조사사항 - 추가버튼
			$("#inspectPointAddBtn").click(function(){
				var value = $("#pointSelect").val();
				var text = $("#pointSelect :selected").text();
				var tmpStr = $("#inspectPointTxtArea").val();
				
				if( value != 0){
					tmpStr += text+"\n";
					$("#inspectPointTxtArea").val(tmpStr);
					$("#inspectPointTxtArea").focus();
					$(this).focus();
				}else{
					$("#inspectPointTxtArea").focus();
					$("#inspectPointTxtArea").val(tmpStr);
				}
			});
			
			//중점 조사사항 - 닫기버튼
			$("#inspectPointCloseBtn").click(function(){
 				//버튼영역 조작
				$("#ModBtnInspectPointSpan").show();
				$("#ModAftBtnInspectPointSpan").hide();
				
				//입력창 조작
				$("#inspectPointSpan").show();
				$("#inspectPointTxtArea").hide();
				
				$("#pointBtnTr").hide();
			});
			
			//중점 조사사항 - 저장버튼
			$("#inspectPointSaveBtn").click(function(){
				$.post("./udt1001inspectPoint"
						,{
							 suimRptNo : $("#suimRptNo").val()
							,rptPrintNo : $("#rptPrintNo").val() 
							,inspectPoint4: replaceHtml($("#inspectPointTxtArea").val())  
						},
						function(data,status){
							if (data == 1 && status == 'success'){
								$("#inspectPointSpan").html( replaceHtml($("#inspectPointTxtArea").val()) );
								$("#inspectPointCloseBtn").click();
							}else{
								alert("저장에 실패하였습니다. 잠시후 시도해주세요..");
							}
						}
				);// $.post("./udt1001claim")
			});
			
			//조사결과 - 수정버튼
			$("#inspectResultModBtn").click(function(){
 				//버튼영역 조작
				$("#ModBtnInspectResultSpan").hide();
				$("#ModAftBtnInspectResultSpan").show();
				
				//입력창 조작
				$("#inspectResultSpan").hide();
				$("#inspectResultTxtArea").show();
				$("#inspectResultTxtArea").val( replaceTextArea($("#inspectResultTxtArea").val()) );
				
				//조사사항 리스트추가 화면 출력
				$("#resultBtnTr").show();
				
				$("#inspectResultTxtArea").focus();
				$(this).focus();
			});
			
			//조사결과 - 추가버튼
			$("#inspectResultAddBtn").click(function(){
				var value = $("#resultSelect").val();
				var text = $("#resultSelect :selected").text();
				var tmpStr = $("#inspectResultTxtArea").val();
				
				if( value != 0){
					var resultStr = "금번 보험금 청구에 대한 확인 결과,\n"+text+"\n귀사의 최종 검토 요청의견임.";
					$("#inspectResultTxtArea").val(resultStr);
					$("#inspectResultTxtArea").focus();
					$(this).focus();
				}else{
					var resultStr = "금번 보험금 청구에 대한 확인 결과,\n\n귀사의 최종 검토 요청의견임.";
					$("#inspectResultTxtArea").focus();
					$("#inspectResultTxtArea").val(resultStr);
				}
			});
			
			//조사결과 - 닫기버튼
			$("#inspectResultCloseBtn").click(function(){
 				//버튼영역 조작
				$("#ModBtnInspectResultSpan").show();
				$("#ModAftBtnInspectResultSpan").hide();
				
				//입력창 조작
				$("#inspectResultSpan").show();
				$("#inspectResultTxtArea").hide();
				
				$("#resultBtnTr").hide();
			});
			
			//조사결과 - 저장버튼
			$("#inspectResultSaveBtn").click(function(){
				$.post("./udt1001inspectResult"
						,{
							 suimRptNo : $("#suimRptNo").val()
							,rptPrintNo : $("#rptPrintNo").val() 
							,inspectResult4: replaceHtml($("#inspectResultTxtArea").val())  
						},
						function(data,status){
							if (data == 1 && status == 'success'){
								$("#inspectResultSpan").html( replaceHtml($("#inspectResultTxtArea").val()) );
								$("#inspectResultCloseBtn").click();
							}else{
								alert("저장에 실패하였습니다. 잠시후 시도해주세요..");
							}
						}
				);// $.post("./udt1001claim")
			});
			
		});//documnet
		
		
	  	//=================================
	  	//	2. 청구사항 - 담보내역 관련 이벤트
	  	//=================================
	  	//화면 추가.
	  	function assureAddView(){
	  		$("#assureAddBtn").hide();
	  		
	  		var addIndex = $("#assureSize").val();
			$("#assureTbody").append(
				"<tr id='assureTr"+addIndex+"' index="+addIndex+">"
				+	"<td class='td' align='center' style='border-left: 0px;'>"
				+		"<span class='assureSpan' id='dtlAssureSpan"+addIndex+"' style='display:none;'></span>"
				+		"<input type='text' class='assureTxt' id='dtlAssureTxt"+addIndex+"' value='' style='width:120px;''/>"				
				+	"</td>"
				
				+	"<td class='td' align='center'>"
				+		"<span class= 'assureSpan' id='joinAmountAssureSpan"+addIndex+"' style='display:none;'></span>"
				+		"<input  type='text' class='assureTxt' id='joinAmountAssureTxt"+addIndex+"'"
				+				"value='' style='width:120px;IME-MODE: disabled;'"
				+				"ONKEYDOWN='javascript:onlyNumberFunc2(this);' ONKEYUP='javascript:numberCommaFunc(this);'/>"
				+	"</td>"
				
				+	"<td class='td' align='center'>"
				+		"<span class= 'assureSpan' id='estimationAmoutAssureSpan"+addIndex+"' style='display:none;'></span>"
				+		"<input  type='text' class='assureTxt' id='estimationAmoutAssureTxt"+addIndex+"'"
				+				"value='' style='width:120px;IME-MODE: disabled;'"
				+				"ONKEYDOWN='javascript:onlyNumberFunc2(this);' ONKEYUP='javascript:numberCommaFunc(this);'/>"				
				+	"</td>"
				
				+	"<td class='td' align='center'>"
				+		"<span class='assureSpan' id='SaveBtnAssureSpan"+addIndex+"' >"			
				+			"<img src='./resources/ne_img/btn/btn_save.gif' class='assureSaveBtn' onclick='javascript:assureInsert("+addIndex+");' style='cursor:pointer;'/>"
				+			"<br/><img src='./resources/ne_img/btn/btn_close.gif' onclick='javascript:assureAddClose("+addIndex+");' serialNo='' style='cursor:pointer;margin-top:5px;'/>"
				+		"</span>"
				
				+	"</td>"
				+"</tr>"
			); 
			//화면 작성 후 인덱스 값을 늘려야 이벤트가 구분됨.
			$("#assureSize").val( parseInt($("#assureSize").val())+1 );
	  	}
		
	  	//추가 - 닫기
	  	function assureAddClose(index){
	  		$("#assureAddBtn").show();
	  		
			$("#assureTr"+index).html("");
	  	}
	  	
		//추가 - 저장
		function assureInsert(index){
			$.post("./ins1001Assure"
					,{
						 rptPrintNo : $("#rptPrintNo").val()
						,assureDtl : $("#dtlAssureTxt"+index).val()
						,joinAmount : removeCommaFunc($("#joinAmountAssureTxt"+index).val())
						,estimationAmount : removeCommaFunc($("#estimationAmoutAssureTxt"+index).val())
					},
					function(data,status){
						$("#assureAddBtn").show();
						if (data.trim() != "ERROR" && status == 'success'){
							$("#assureTableTd").html("");
							$("#assureTableTd").html(data);
							
							alert("저장에 성공하였습니다.");
							
						}else{
							alert("저장에 실패하였습니다. 잠시후 시도해주세요..");
						}
					}
			);// $.post("./insPrint1001Three1")
		}
		
		//수정
		function assureModifyView(index){
			//버튼 변경
			$("#ModBtnAssureSpan"+index).hide();
			$("#ModAftSaveBtnAssureSpan"+index).show();
			
			//입력 화면 출력
			$("#dtlAssureTxt"+index).show();
			$("#joinAmountAssureTxt"+index).show();
			$("#estimationAmoutAssureTxt"+index).show();
			
			//입력완료 화면 삭제
			$("#dtlAssureSpan"+index).hide();
			$("#joinAmountAssureSpan"+index).hide();
			$("#estimationAmoutAssureSpan"+index).hide();
			
			$("#assureAddBtn").hide();
		}
		
		//수정 - 취소
		function assureModifyClose(index){
			//버튼
			$("#ModBtnAssureSpan"+index).show();
			$("#ModAftSaveBtnAssureSpan"+index).hide();
			
			//TXT 삭제
			$("#dtlAssureTxt"+index).hide();
			$("#joinAmountAssureTxt"+index).hide();
			$("#estimationAmoutAssureTxt"+index).hide();
			
			//SPAN 출력
			$("#dtlAssureSpan"+index).show();
			$("#joinAmountAssureSpan"+index).show();
			$("#estimationAmoutAssureSpan"+index).show();
			
			$("#assureAddBtn").show();
		}
		
		//수정
		function assureUpdate(index,serialNo){
			$.post(
					"udt1001Assure",
					{
						 rptPrintNo : $("#rptPrintNo").val()
						,serialNo : serialNo
						,assureDtl : $("#dtlAssureTxt"+index).val()
						,joinAmount : removeCommaFunc($("#joinAmountAssureTxt"+index).val())
						,estimationAmount : removeCommaFunc($("#estimationAmoutAssureTxt"+index).val())
					},
					function(data,status){
						$("#assureAddBtn").show();
						if (data.trim() != "ERROR" && status == 'success'){
							$("#assureTableTd").html("");
							$("#assureTableTd").html(data);
						}
					}
			);
		}
		
		//삭제
		function assureDelete(serialNo){
			var r = confirm("삭제 하시겠습니까?");
			if( r == false){
				return;
			}
			$.post("del1001Assure",
				{ 
				 	 rptPrintNo : $("#rptPrintNo").val()
					,serialNo : serialNo
				},
				function(data,status){
					if (data.trim() != "ERROR" && status == 'success'){
						$("#assureTableTd").html("");
						$("#assureTableTd").html(data);
					}else{
						alert("삭제에 실패하였습니다. 잠시후 시도해주세요..");
					}			   
				}
			);
		}
		
	  	//=================================
	  	//	3. 타보험사 계약 및 지급사항
	  	//=================================
	  		
	  	//추가
		function otherInsuAddView(){
			$("#otherInsuAddBtn").hide();
	  		var index = $("#otherInsuSize").val();
			$("#otherInsuTbody").append(
				"<tr id='otherInsuTr"+index+"'>"
				
				+	"<td class='td'>"
				+		"<p align='center'>"
				+			"<span class='otherInsuSpan' id='InsuComSpan"+index+"'></span>"
				+			"<input class='otherInsuTxt' type='text' id='InsuComTxt"+index+"' value='' style='width:75px;'/>"
				+		"</p>"
				+	"</td>"
				+	"<td class='td'>"
				+		"<p align='center'>"
				+			"<span class='otherInsuSpan' id='InsuContSpan"+index+"'></span>"
				+			"<input class='otherInsuTxt' type='text' id='InsuContTxt"+index+"' value='' style='width:115px;' />"
				+		"</p>"
				+	"</td>"
				+	"<td class='td'>"
				+		"<p align='center'>"
				+			"<span class='otherInsuSpan' id='InsuDtlSpan"+index+"'></span>"
				+			"<input class='otherInsuTxt' type='text' id='InsuDtlTxt"+index+"' value='' style='width:325px;'/>"
				+		"</p>"
				+	"</td>"
				
				+	"<td class='td'>"
				+		"<p align='center'>"
				+			"<span class='otherInsuSpan' id='SaveBtnOtherInsuSpan"+index+"'>"			
				+				"<img src='./resources/ne_img/btn/btn_save.gif' onclick='javascript:otherInsuInsert("+index+");' style='cursor:pointer;'/>"
				+				"<br/><img src='./resources/ne_img/btn/btn_close.gif' onclick='javascript:otherInsuAddClose("+index+");' serialNo='' style='cursor:pointer;margin-top:5px;'/>"
				+			"</span>"
				
				+		"</p>"
				+	"</td>"
				+"<tr>"
			); 
			//화면 작성 후 인덱스 값을 늘려야 이벤트가 구분됨.
			$("#otherInsuSize").val( parseInt($("#otherInsuSize").val())+1 );
	  	}
	  	
	  	//추가 - 닫기
	  	function otherInsuAddClose(index){
	  		$("#otherInsuAddBtn").show();
	  		$("#otherInsuTr"+index).html("");
	  	}
		
		//추가 - 저장
		function otherInsuInsert(index){
			$.post("./ins1001otherInsu"
					,{
						 rptPrintNo : $("#rptPrintNo").val()
						,otherInsuCom : $("#InsuComTxt"+index).val()
						,otherInsuContract : $("#InsuContTxt"+index).val()
						,otherInsuDtl : $("#InsuDtlTxt"+index).val()
					},
					function(data,status){
						$("#otherInsuAddBtn").show();
						
						if (data.trim() != "ERROR" && status == 'success'){
							$("#otherInsuTbody").html("");
							$("#otherInsuTbody").html(data);
							
							alert("저장에 성공하였습니다.");
						}else{
							alert("저장에 실패하였습니다. 잠시후 시도해주세요..");
						}
					}
			);// $.post("./insPrint1001Three1")
		}
	  	
		//삭제
		function otherInsuDelete(serialNo){
			var r = confirm("삭제 하시겠습니까?");
			if( r == false){
				return;
			}
			$.post("del1001otherInsu",
				{ 
				 	 rptPrintNo : $("#rptPrintNo").val()
					,serialNo : serialNo
				},
				function(data,status){
					if (data.trim() != "ERROR" && status == 'success'){
						$("#otherInsuTbody").html("");
						$("#otherInsuTbody").html(data);
						
						alert("삭제에 성공하였습니다.");
					}else{
						alert("삭제에 실패하였습니다. 잠시후 시도해주세요..");
					}
				}
			);
		}	  	
		
		//수정 - 입력화면 출력
		function otherInsuModifyView(index){
			//버튼 변경
			$("#ModBtnOtherInsuSpan"+index).hide();
			$("#ModAftSaveBtnOtherInsuSpan"+index).show();
			$("#otherInsuAddBtn").hide();
			
			//입력 화면 출력
			$("#InsuComTxt"+index).show();
			$("#InsuContTxt"+index).show();
			$("#InsuDtlTxt"+index).show();
			
			//입력완료 화면 삭제
			$("#InsuComSpan"+index).hide();
			$("#InsuContSpan"+index).hide();
			$("#InsuDtlSpan"+index).hide();
		}
		
		//수정 - 취소
		function otherInsuModifyClose(index){
			//버튼
			$("#ModBtnOtherInsuSpan"+index).show();
			$("#ModAftSaveBtnOtherInsuSpan"+index).hide();
			
			//TXT 삭제
			$("#InsuComTxt"+index).hide();
			$("#InsuContTxt"+index).hide();
			$("#InsuDtlTxt"+index).hide();
			
			//SPAN 출력
			$("#InsuComSpan"+index).show();
			$("#InsuContSpan"+index).show();
			$("#InsuDtlSpan"+index).show();
			
			$("#otherInsuAddBtn").show();
		}	  	
	  	
		//수정
		function otherInsuUpdate(index,serialNo){
			$.post(
					"udt1001otherInsu",
					{
						 rptPrintNo : $("#rptPrintNo").val()
						,serialNo : serialNo
						,otherInsuCom : $("#InsuComTxt"+index).val()
						,otherInsuContract : $("#InsuContTxt"+index).val()
						,otherInsuDtl : $("#InsuDtlTxt"+index).val()
						
					},
					function(data,status){
						$("#otherInsuAddBtn").show();
						
						if (data.trim() != "ERROR" && status == 'success'){
							$("#otherInsuTbody").html("");
							$("#otherInsuTbody").html(data);
						}else{
							alert("수정에 실패하였습니다. 잠시 후 시도해주세요..");
						}
					}
			);
		}
		
	  	//=================================
	  	//	5. 총괄 경과표
	  	//=================================
	  	//추가
		function passTableAddView(){
			$("#passTableAddBtn").hide();
	  		var index = $("#passTableSize").val();
			$("#passTableTbody").append(
				"<tr id='passTableTr"+index+"'>"
				+	"<td class='td'>"
				+		"<p align='center'>"
				+			"<span class='passTableInputSpan'>"
				+				"<input type='text' class='passTableDateTxt' id='passTableToDateTxt"+index+"' maxlength='10' value='' />"
				+				"<br/>~ &nbsp;"
				+				"<input type='text' class='passTableDateTxt' id='passTableFromDateTxt"+index+"' maxlength='10' value='' style='margin-top:5px;'/>"
				+				"<br/><br/>"
				+				"<input type='radio' name='passTableGubun' onclick='fnPassTableGubun(1,"+index+")' value = '1'/> 입원"
				+				"<input type='radio' name='passTableGubun' onclick='fnPassTableGubun(2,"+index+")' value = '2'/> 통원"
				+				"<br/>"
				+				"<input type='text' id='passTableGubunTxt"+index+"' value='' style='width:100px;'/>"
				+			"</span>"
				+		"</p>"
				+	"</td>"
				+	"<td class='td'>"
				+		"<p align='center'>"
				+			"<textarea class='passTableTxtArea' id='passTableDtlTxtArea"+index+"' style='width:318px;'"
				+	  				   "onfocus='javascript:fnAutoSize(this.scrollHeight,this);'"
			   	+ 	  				   "onKeyUP='javascript:fnAutoSize(this.scrollHeight,this);'"
			 	+	  				   "onKeyDown='javascript:fnAutoSize(this.scrollHeight,this);'>"
		 		+					   "-&nbsp;내원경위&nbsp;:&nbsp;\n-&nbsp;검사사항&nbsp;:&nbsp;\n-&nbsp;진단병명&nbsp;:&nbsp;\n-&nbsp;치료사항&nbsp;:&nbsp;"
		 		+			"</textarea>"
				+		"</p>"
				+	"</td>"
				
				+	"<td class='td'>"
				+		"<p align='center'>"			
				+			"<input class='passTableTxt' type='text' id='passTableNoteTxt"+index+"' value='' style='width:108px;'/>"
				+		"</p>"	
				+	"</td>"
 
				
				+	"<td class='td'>"
				+		"<p align='center'>"
				+			"<span class='otherInsuSpan' id='SaveBtnPassTableSpan"+index+"'>"			
				+				"<img src='./resources/ne_img/btn/btn_save.gif' onclick='javascript:passTableInsert("+index+");' style='cursor:pointer;'/>"
				+				"<br/><img src='./resources/ne_img/btn/btn_close.gif' onclick='javascript:passTableAddClose("+index+");' serialNo='' style='cursor:pointer;margin-top:5px;'/>"
				+			"</span>"
				
				+		"</p>"
				+	"</td>"
				+"<tr>"
			); 
			
			$('#passTableToDateTxt'+index).datepicker({ 
		    	   showOn: 'button',
		    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		    	   buttonImageOnly: true,
		    	   buttonText: "달력", 
		    	   changeMonth: true,
		    	   changeYear: true,
		    	   showButtonPanel: false
		    });
			
			$('#passTableFromDateTxt'+index).datepicker({ 
		    	   showOn: 'button',
		    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		    	   buttonImageOnly: true,
		    	   buttonText: "달력", 
		    	   changeMonth: true,
		    	   changeYear: true,
		    	   showButtonPanel: false
		    });
			
		 	$('.passTableDateTxt').keypress(function(){
		 		if (event.keyCode == 8){
		 			return false;
		 		}
				if($(this).val().length == 4 || $(this).val().length == 7){
					$(this).val($(this).val()+"-")
				}
			});
			
			
			//화면 작성 후 인덱스 값을 늘려야 이벤트가 구분됨.
			$("#passTableSize").val( parseInt($("#passTableSize").val())+1 );
	  	}
		
		//추가 - 닫기
		function passTableAddClose(index){
	  		$("#passTableAddBtn").show();
	  		$("#passTableTr"+index).html("");
		}
		
		//추가 - 저장
		function passTableInsert(index){
			$.post("./ins1001passTable"
					,{
						 rptPrintNo : $("#rptPrintNo").val()
						,investigateToDate : $("#passTableToDateTxt"+index).val()
						,investigateFromDate : $("#passTableFromDateTxt"+index).val()
						,investigateDtl : replaceHtml( $("#passTableDtlTxtArea"+index).val() )
						,investigateOutline : $("#passTableNoteTxt"+index).val()
						,investigateDateDtl : $("#passTableGubunTxt"+index).val()
					},
					function(data,status){
						$("#passTableAddBtn").show();
						if (data.trim() != "ERROR" && status == 'success'){
							$("#passTableTbody").html("");
							$("#passTableTbody").html(data);
							
							alert("저장에 성공하였습니다.");
							
						}else{
							alert("저장에 실패하였습니다. 잠시후 시도해주세요..");
						}
					}
			);// $.post("./insPrint1001Three1")
		}
		
		//삭제
		function passTableDelete(serialNo){
			var r = confirm("삭제 하시겠습니까?");
			if( r == false){
				return;
			}
			$.post("del1001passTable",
				{ 
				 	 rptPrintNo : $("#rptPrintNo").val()
					,serialNo : serialNo
				},
				function(data,status){
					$("#passTableAddBtn").show();
					if (data.trim() != "ERROR" && status == 'success'){
						$("#passTableTbody").html("");
						$("#passTableTbody").html(data);
						
						alert("삭제에 성공하였습니다.");
					}else{
						alert("삭제에 실패하였습니다. 잠시후 시도해주세요..");
					}
				}
			);
		}	
		
		
		//수정 - 입력화면 출력
		function passTableModifyView(index){
			//버튼 변경
			$("#ModBtnPassTableSpan"+index).hide();
			$("#ModAftSaveBtnPassTableSpan"+index).show();
			$("#passTableAddBtn").hide();
			
			//입력 화면 출력
			$("#passTalbeDateInputSpan"+index).show();
			$("#passTableDtlTxtArea"+index).val( replaceTextArea($("#passTableDtlTxtArea"+index).val()) );
			$("#passTableDtlTxtArea"+index).show();
			$("#passTableNoteTxt"+index).show();
			
			//입력완료 화면 삭제
			$("#passTableDateSpan"+index).hide();
			$("#passTableDtlSpan"+index).hide();
			$("#passTableNoteSpan"+index).hide();
			
			//DatePicker 로드
			$('#passTableToDateTxt'+index).datepicker({ 
		    	   showOn: 'button',
		    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		    	   buttonImageOnly: true,
		    	   buttonText: "달력", 
		    	   changeMonth: true,
		    	   changeYear: true,
		    	   showButtonPanel: false
		    });
			
			$('#passTableFromDateTxt'+index).datepicker({ 
		    	   showOn: 'button',
		    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		    	   buttonImageOnly: true,
		    	   buttonText: "달력", 
		    	   changeMonth: true,
		    	   changeYear: true,
		    	   showButtonPanel: false
		    });
			
		 	$('.passTableDateTxt').keypress(function(){
		 		if (event.keyCode == 8){
		 			return false;
		 		}
				if($(this).val().length == 4 || $(this).val().length == 7){
					$(this).val($(this).val()+"-")
				}
			});
			
			$("#passTableDtlTxtArea"+index).focus();
		}
		
		//수정 - 취소
		function passTableModifyClose(index){
			//버튼
			$("#ModBtnPassTableSpan"+index).show();
			$("#ModAftSaveBtnPassTableSpan"+index).hide();
			$("#passTableAddBtn").show();
			
			//TXT 삭제
			$("#passTalbeDateInputSpan"+index).hide();
			$("#passTableDtlTxtArea"+index).hide();
			$("#passTableNoteTxt"+index).hide();
			
			//SPAN 출력
			$("#passTableDateSpan"+index).show();
			$("#passTableDtlSpan"+index).show();
			$("#passTableNoteSpan"+index).show();
		}	
		
		//수정
		function passTableUpdate(index,serialNo){
			$.post("./udt1001passTable"
					,{
						 rptPrintNo : $("#rptPrintNo").val()
						,serialNo : serialNo
						,investigateToDate : $("#passTableToDateTxt"+index).val()
						,investigateFromDate : $("#passTableFromDateTxt"+index).val()
						,investigateDateDtl : $("#passTableGubunTxt"+index).val()
						,investigateDtl : replaceHtml( $("#passTableDtlTxtArea"+index).val() )
						,investigateOutline : $("#passTableNoteTxt"+index).val()
						
					},
					function(data,status){
						$("#passTableAddBtn").show();
						if (data.trim() != "ERROR" && status == 'success'){
							$("#passTableTbody").html("");
							$("#passTableTbody").html(data);
						}else{
							alert("수정에 실패하였습니다. 잠시 후 시도해주세요..");
						}
					}
			);
		}
		
		//DateDtl값 생성
		function fnPassTableGubun(gubun,index){
			var strDate1 = $("#passTableToDateTxt"+index).val();
			var strDate2 = $("#passTableFromDateTxt"+index).val();
			var arr1 = strDate1.split('-');
			var arr2 = strDate2.split('-');
			var dat1 = new Date(arr1[0], arr1[1], arr1[2]);
			var dat2 = new Date(arr2[0], arr2[1], arr2[2]);

			var diff = dat2 - dat1;
			
			var currDay = 24 * 60 * 60 * 1000;// 시 * 분 * 초 * 밀리세컨
			var currMonth = currDay * 30;// 월 만듬
			var currYear = currMonth * 12; // 년 만듬
			
			var diffDay =  parseInt(diff/currDay+1);
			
			if (gubun == 1){
				$("#passTableGubunTxt"+index).val("입원 "+diffDay+"일");
			}else{
				$("#passTableGubunTxt"+index).val("통원 "+diffDay+"회");
			}
		}
		
	  	//=================================
	  	//	사고처리과정표 - 처리과정
	  	//=================================		

		function printCtrlAddView(){
	  		$.post("getPrintCtrlList"
	  				,{
						 rptPrintNo : $("#rptPrintNo").val()
						,ptnrName : $("#ptnrName").val()
  					}
	  				,function(data,status){
	  					if (data != null && data != "" && status == "success"){
		  					subjectItems = "<option value=''>--- 선택 ---</option>";
		  					for (var i = 0; i < data.printList.length; i++) {
		  						subjectItems += "<option value='" + data.printList[i].col_val + "'>" + data.printList[i].col_val + "</option>";
		  					}
		  					subjectItems += "<option value='999'>직접입력</option>";
		  					
		  					memoItems = "<option value=''>--- 선택 ---</option>";
		  					for (var i = 0; i < data.memoList.length; i++) {
		  						memoItems += "<option value='" + data.memoList[i].col_val + "'>" + data.memoList[i].col_val + "</option>";
		  					}
		  					memoItems += "<option value='999'>직접입력</option>";
		  					
		  					
		  					$("#printCtrlAddBtn").hide();
		  			  		var index = $("#printCtrlSize").val();
		  					$("#printCtrlTbody").append(
		  						"<tr id='printCtrlTr"+index+"'>"
		  						+	"<td class='td'>"
		  						+		"<p align='center'>"
		  						+			"<input type='text' class='printCtrlTxt' id='printCtrlDateTxt"+index+"' maxlength='10' value='' style='width:90px; font-size:15px;'/>"
		  						+		"</p>"
		  						+	"</td>"
		  						+	"<td class='td'>"
		  						+		"<p align='center'>"
		  						
		  						+			"<select id='printCtrlSubjectSelect"+index+"' onchange='javascript:fnSelectPick(this,1,"+index+");' style='width:180px;' >"
		  						+				subjectItems
		  						+			"</select>"
		  						
		  						+			"<input type='text' class='printCtrlTxt' id='printCtrlSubjectTxt"+index+"' maxlength='10' value='' style='width:180px;display:none;' />"								
		  						+		"</p>"
		  						+	"</td>"
		  						
		  						+	"<td class='td'>"
		  						+		"<p align='center'>"
		  						+			"<select id='printCtrlMemoSelect"+index+"' onchange='javascript:fnSelectPick(this,2,"+index+");' style='width:180px;' >"
		  						+				memoItems
		  						+			"</select>"				
		  						
		  						+			"<input class='printCtrlTxt' type='text' id='printCtrlMemoTxt"+index+"' value='' style='width:180px;display:none;' />"
		  						+		"</p>"		
		  						+	"</td>"
		  						
		  						+	"<td class='td'>"
		  						+		"<p align='center'>"
		  						+			"<span class='printCtrlSpan' id='SaveBtnPrintCtrlSpan"+index+"'>"			
		  						+				"<img src='./resources/ne_img/btn/btn_save.gif' onclick='javascript:printCtrlInsert("+index+",\"1001\");' style='cursor:pointer;'/>"
		  						+				"<br/><img src='./resources/ne_img/btn/btn_close.gif' onclick='javascript:printCtrlAddClose("+index+");' serialNo='' style='cursor:pointer;margin-top:5px;'/>"
		  						+			"</span>"
		  						+		"</p>"
		  						+	"</td>"
		  						+"<tr>"
		  						
		  					); 
		  					
		  					$('#printCtrlDateTxt'+index).datepicker({ 
		  				    	   showOn: 'button',
		  				    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		  				    	   buttonImageOnly: true,
		  				    	   buttonText: "달력", 
		  				    	   changeMonth: true,
		  				    	   changeYear: true,
		  				    	   showButtonPanel: false
		  				    });
		  					
		  					$("#printCtrlSize").val( parseInt($("#printCtrlSize").val())+1);
		  					
	  					}else{
	  						alert("잠시 후 시도 해주세요..");
	  					}
	  				},"json"
	  		);
	  	}
	  	
	  	
	  	
		function fnSelectPick(obj,gubun,index){
			if(gubun == "1"){//사고처리과정표 - 항목
				if(obj.value == "999"){
					$("#printCtrlSubjectTxt"+index).val("");
					$("#printCtrlSubjectTxt"+index).show();
					$("#printCtrlSubjectTxt"+index).focus();
				}else{
					$("#printCtrlSubjectTxt"+index).val(obj.value);
					$("#printCtrlSubjectTxt"+index).hide();
				}
			}else if(gubun == "2"){//사고처리과정표 - 처리내용
				if(obj.value == "999"){
					$("#printCtrlMemoTxt"+index).val("");
					$("#printCtrlMemoTxt"+index).show();
					$("#printCtrlMemoTxt"+index).focus();
				}else{
					$("#printCtrlMemoTxt"+index).val(obj.value);
					$("#printCtrlMemoTxt"+index).hide();
				}				
			}else if(gubun == "3"){//첨부류 - 비고
				if(obj.value == "999"){
					$("#sagoDocNoteTxt"+index).val("");
					$("#sagoDocNoteTxt"+index).show();
					$("#sagoDocNoteTxt"+index).focus();
				}else{
					$("#sagoDocNoteTxt"+index).val(obj.value);
					$("#sagoDocNoteTxt"+index).hide();
				}	
			}
		}
		
	  	
		//추가 - 닫기
		function printCtrlAddClose(index){
	  		$("#printCtrlAddBtn").show();
	  		$("#printCtrlTr"+index).html("");
		}
		
		//추가 - 저장
		function printCtrlInsert(index, flag){
			var controlEndDate = "";
			var controlDelayAgent = 0;
			var controlDateCnt = "";
			var controlDelayCnt = "";
			
			if (flag == "lotte"){
				controlEndDate = $("#printCtrlEndDateTxt"+index).val();
				controlDelayAgent = $("#printCtrlDelayAgentSelect"+index).val();
				controlDateCnt = $("#printCtrlDateCntTxt"+index).val();
				controlDelayCnt = $("#printCtrlDelayCntTxt"+index).val();
			}
			
			$.post("./ins1001printCtrl"
					,{
						 rptPrintNo : $("#rptPrintNo").val()
						,controlDate: $("#printCtrlDateTxt"+index).val()
						,controlSubject: $("#printCtrlSubjectTxt"+index).val()
						,controlMemo: $("#printCtrlMemoTxt"+index).val()
						,controlEndDate : controlEndDate
						,controlDelayAgent : controlDelayAgent
						,controlDateCnt : controlDateCnt
						,controlDelayCnt : controlDelayCnt
						,flag : flag
					},
					function(data,status){
						$("#printCtrlAddBtn").show();
						if (data.trim() != "ERROR" && status == 'success'){
							if (flag == "lotte"){
								$("#printCtrlOutSpan").html("");
								$("#printCtrlOutSpan").html(data);
							}else{
								$("#printCtrlTbody").html("");
								$("#printCtrlTbody").html(data);
							}
							
							alert("저장에 성공하였습니다.");
							
						}else{
							alert("저장에 실패하였습니다. 잠시후 시도해주세요..");
						}
					}
			);// $.post("./insPrint1001Three1")
		}
		
		//삭제
		function printCtrlDelete(serialNo,flag){
			var r = confirm("삭제 하시겠습니까?");
			if( r == false){
				return;
			}
			$.post("del1001printCtrl",
				{ 
				 	 rptPrintNo : $("#rptPrintNo").val()
					,serialNo : serialNo
					,flag : flag
				},
				function(data,status){
					if (data.trim() != "ERROR" && status == 'success'){
						if (flag == "lotte"){
							$("#printCtrlOutSpan").html("");
							$("#printCtrlOutSpan").html(data);
						}else{
							$("#printCtrlTbody").html("");
							$("#printCtrlTbody").html(data);
						}
						alert("삭제에 성공하였습니다.");
					}else{
						alert("삭제에 실패하였습니다. 잠시후 시도해주세요..");
					}
				}
			);
		}
		
		function printCtrlModifyView(index,subject,memo,delayAgent){
			//버튼 변경
			$("#ModBtnPrintCtrlSpan"+index).hide();
			$("#ModAftSaveBtnPrintCtrlSpan"+index).show();
			$("#printCtrlAddBtn").hide();
			
			//입력 화면 출력
			$("#printCtrlDateInputSpan"+index).show();
			$("#printCtrlSubjectInputSpan"+index).show();
			$("#printCtrlMemoInputSpan"+index).show();
			
			//입력완료 화면 삭제
			$("#printCtrlDateSpan"+index).hide();
			$("#printCtrlSubjectSpan"+index).hide();
			$("#printCtrlMemoSpan"+index).hide();
			
			//롯데 초기화
			$("#printCtrlDelayAgentSpan"+index).hide();
			$("#printCtrlDelayAgentInputSpan"+index).show();
			$("#printCtrlDelayAgentSelect"+index).val(delayAgent);
			
			$("#printCtrlDateCntSpan"+index).hide();
			$("#printCtrlDateCntInputSpan"+index).show();
			
			$("#printCtrlDelayCntSpan"+index).hide();
			$("#printCtrlDelayCntInputSpan"+index).show();
			
			
			//DatePicker 로드
			$('#printCtrlDateTxt'+index).datepicker({ 
		    	   showOn: 'button',
		    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		    	   buttonImageOnly: true,
		    	   buttonText: "달력", 
		    	   changeMonth: true,
		    	   changeYear: true,
		    	   showButtonPanel: false
		    });
			
			//DatePicker 로드
			$('#printCtrlEndDateTxt'+index).datepicker({ 
		    	   showOn: 'button',
		    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		    	   buttonImageOnly: true,
		    	   buttonText: "달력", 
		    	   changeMonth: true,
		    	   changeYear: true,
		    	   showButtonPanel: false
		    });
			

	  		$.post("getPrintCtrlList"
	  				,{
						 rptPrintNo : $("#rptPrintNo").val()
						,ptnrName : $("#ptnrName").val()
  					}
	  				,function(data,status){
	  					if (data != null && data != "" && status == "success"){
	  						var subjectFlag = 0;
	  						var memoFlag = 0;
	  						
		  					subjectItems = "<option value=''>--- 선택 ---</option>";
		  					for (var i = 0; i < data.printList.length; i++) {
		  						if ( subject == data.printList[i].col_val ){
		  							subjectFlag = 1;
		  							subjectItems += "<option value='" + data.printList[i].col_val + "' selected>" + data.printList[i].col_val + "</option>";
		  						}else{
		  							subjectItems += "<option value='" + data.printList[i].col_val + "'>" + data.printList[i].col_val + "</option>";
		  						}
		  					}
		  					if (subjectFlag == 0){
		  						subjectItems += "<option value='999' selected>직접입력</option>";
		  						$("#printCtrlSubjectTxt"+index).show();
		  					}else{
		  						subjectItems += "<option value='999'>직접입력</option>";
		  					}
		  					
		  					
		  					memoItems = "<option value=''>--- 선택 ---</option>";
		  					for (var i = 0; i < data.memoList.length; i++){
		  						if (memo == data.memoList[i].col_val){
		  							memoFlag = 1;
		  							memoItems += "<option value='" + data.memoList[i].col_val + "' selected>" + data.memoList[i].col_val + "</option>";
		  						}else{
		  							memoItems += "<option value='" + data.memoList[i].col_val + "'>" + data.memoList[i].col_val + "</option>";
		  						}
		  					}
		  					
		  					if (memoFlag == 0){
		  						memoItems += "<option value='999' selected>직접입력</option>";
		  						$("#printCtrlMemoTxt"+index).show();
		  					}else{
		  						memoItems += "<option value='999'>직접입력</option>";
		  					}
		  					
		  					$("#printCtrlMemoSelect"+index).html("");
		  					$("#printCtrlSubjectSelect"+index).html("");
		  					$("#printCtrlMemoSelect"+index).append(memoItems);
		  					$("#printCtrlSubjectSelect"+index).append(subjectItems);
	  					}
	  				},"json"
			);
	  		
		}
		
		function printCtrlUpdate(index,serialNo,flag){
			var controlEndDate = "";
			var controlDelayAgent = 0;
			var controlDateCnt = "";
			var controlDelayCnt = "";
			
			if (flag == "lotte"){
				controlEndDate = $("#printCtrlEndDateTxt"+index).val();
				controlDelayAgent = $("#printCtrlDelayAgentSelect"+index).val();
				controlDateCnt = $("#printCtrlDateCntTxt"+index).val();
				controlDelayCnt = $("#printCtrlDelayCntTxt"+index).val();
			}
			
			$.post("./udt1001printCtrl"
					,{
						 rptPrintNo : $("#rptPrintNo").val()
						,serialNo : serialNo
						,controlDate: $("#printCtrlDateTxt"+index).val()
						,controlSubject: $("#printCtrlSubjectTxt"+index).val()
						,controlMemo: $("#printCtrlMemoTxt"+index).val()
						,controlEndDate : controlEndDate
						,controlDelayAgent : controlDelayAgent
						,controlDateCnt : controlDateCnt
						,controlDelayCnt : controlDelayCnt
						,flag : flag
					},
					function(data,status){
						if (data.trim() != "ERROR" && status == 'success'){
							if (flag == "lotte"){
								$("#printCtrlOutSpan").html("");
								$("#printCtrlOutSpan").html(data);
							}else{
								$("#printCtrlTbody").html("");
								$("#printCtrlTbody").html(data);
							}
							alert("수정에 성공하였습니다.");
							
						}else{
							alert("수정에 실패하였습니다. 잠시후 시도해주세요..");
						}
					}
			);
		}
		
		
		//수정 - 취소
		function printCtrlModifyClose(index){
			//버튼 변경
			$("#ModBtnPrintCtrlSpan"+index).show();
			$("#ModAftSaveBtnPrintCtrlSpan"+index).hide();
			$("#printCtrlAddBtn").show();
			
			//입력완료 화면 삭제
			$("#printCtrlDateInputSpan"+index).hide();
			$("#printCtrlSubjectInputSpan"+index).hide();
			$("#printCtrlMemoInputSpan"+index).hide();
			
			//입력 완료 출력
			$("#printCtrlDateSpan"+index).show();
			$("#printCtrlSubjectSpan"+index).show();
			$("#printCtrlMemoSpan"+index).show();
			
			//롯데 - 지연주체 
			$("#printCtrlDelayAgentSpan"+index).show();
			$("#printCtrlDelayAgentInputSpan"+index).hide();
			
			//롯데 - 일수
			$("#printCtrlDateCntSpan"+index).show();
			$("#printCtrlDateCntInputSpan"+index).hide();
			
			//롯데 - 지연일수
			$("#printCtrlDelayCntSpan"+index).show();
			$("#printCtrlDelayCntInputSpan"+index).hide();
		}	
		
		
		
		function printCtrlDelayModifyView(){
			//버튼 변경
			$("#ModBtnPrintCtrlDelaySpan").hide();
			$("#ModAftSaveBtnPrintCtrlDelaySpan").show();
			$("#printCtrlAddBtn").hide();
			
			//입력 화면 출력
			$("#printCtrlAllDelayInputSpan").show();
			$("#printCtrlNotInsuInputSpan").show();
			$("#printCtrlInsuInputSpan").show();
			
			//입력완료 화면 삭제
			$("#printCtrlAllDelaySpan").hide();
			$("#printCtrlNotInsuSpan").hide();
			$("#printCtrlInsuSpan").hide();
		}
		
		function printCtrlDelayModifyClose(){
			//버튼 변경
			$("#ModBtnPrintCtrlDelaySpan").show();
			$("#ModAftSaveBtnPrintCtrlDelaySpan").hide();
			$("#printCtrlAddBtn").show();
			
			//입력 완료 출력
			$("#printCtrlAllDelayInputSpan").hide();
			$("#printCtrlNotInsuInputSpan").hide();
			$("#printCtrlInsuInputSpan").hide();
			
			//입력 화면 삭제
			$("#printCtrlAllDelaySpan").show();
			$("#printCtrlNotInsuSpan").show();
			$("#printCtrlInsuSpan").show();
		}
		
		function printCtrlDelayUpdate(){
			$.post("./udt1001printCtrlDelay"
					,{
						 rptPrintNo : $("#rptPrintNo").val()
						,allDelayCnt: $("#printCtrlAllDelayTxt").val()
						,insuDelayCnt: $("#printCtrlInsuTxt").val()
						,notInsuDelayCnt : $("#printCtrlNotInsuTxt").val()
					},
					function(data,status){
						if (data.trim() != "ERROR" && status == 'success'){
							$("#printCtrlOutSpan").html("");
							$("#printCtrlOutSpan").html(data);
							alert("수정에 성공하였습니다.");
						}else{
							alert("수정에 실패하였습니다. 잠시후 시도해주세요..");
						}
					}
			);
		}
		
	  	//=================================
	  	//	사고처리과정표 - 2.처리과정(롯데)
	  	//=================================	
		
		
		function printCtrlLotteAddView(){
	  		$.post("getPrintCtrlList"
	  				,{
						 rptPrintNo : $("#rptPrintNo").val()
						,ptnrName : $("#ptnrName").val()
  					}
	  				,function(data,status){
	  					if (data != null && data != "" && status == "success"){
		  					subjectItems = "<option value=''>--- 선택 ---</option>";
		  					for (var i = 0; i < data.printList.length; i++) {
		  						subjectItems += "<option value='" + data.printList[i].col_val + "'>" + data.printList[i].col_val + "</option>";
		  					}
		  					subjectItems += "<option value='999'>직접입력</option>";
		  					
		  					memoItems = "<option value=''>--- 선택 ---</option>";
		  					for (var i = 0; i < data.memoList.length; i++) {
		  						memoItems += "<option value='" + data.memoList[i].col_val + "'>" + data.memoList[i].col_val + "</option>";
		  					}
		  					memoItems += "<option value='999'>직접입력</option>";
		  					
		  					
		  					$("#printCtrlAddBtn").hide();
		  					
		  			  		var index = $("#printCtrlSize").val();
		  			  		
		  			  		
		  					$("#printCtrlTbody").append(	
		  						"<tr id='printCtrlTr"+index+"'>"
		  						//일자
		  						+	"<td class='td'>"
		  						+		"<p align='center'>"
		  						+			"<input type='text' class='printCtrlDateTxt' id='printCtrlDateTxt"+index+"' maxlength='10' value='' /><br/>"
		  						+			"~ <input type='text' class='printCtrlEndDateTxt' onchange='calcDateCnt("+index+")' id='printCtrlEndDateTxt"+index+"' maxlength='10' value='' style='margin-top:5px;'/>"
		  						+		"</p>"
		  						+	"</td>"
		  						
		  						//일수
		  						+	"<td class='td'>"
		  						+		"<p align='center'>"
		  						+			"<input type='text' class='printCtrlDateCnt onlyNumber' id='printCtrlDateCntTxt"+index+"' size='3' maxlength='4' />"
		  						+		"</p>"
		  						+	"</td>"
		  						
		  						//업무내용
		  						+	"<td class='td'>"
		  						+		"<p align='center'>"
		  						+			"<select id='printCtrlSubjectSelect"+index+"' onchange='javascript:fnSelectPick(this,1,"+index+");' style='width:140px;' >"
		  						+				subjectItems
		  						+			"</select>"
		  						+			"<input type='text' class='printCtrlTxt' id='printCtrlSubjectTxt"+index+"' value='' style='width:130px;display:none;' />"								
		  						+		"</p>"
		  						+	"</td>"
		  						
		  						//세부내용
		  						+	"<td class='td'>"
		  						+		"<p align='center'>"
		  						+			"<select id='printCtrlMemoSelect"+index+"' onchange='javascript:fnSelectPick(this,2,"+index+");' style='width:140px;' >"
		  						+				memoItems
		  						+			"</select>"				
		  						+			"<input class='printCtrlTxt' type='text' id='printCtrlMemoTxt"+index+"' value='' style='width:130px;display:none;' />"
		  						+		"</p>"		
		  						+	"</td>"
		  						
		  						//지연주체
		  						+	"<td class='td'>" 
		  						+		"<p align='center'>"
		  						+			"<select id='printCtrlDelayAgentSelect"+index+"' onchange='' style='width:65px;' >"
		  						+				"<option value='0'>- 선택 -</option>"
		  						+				"<option value='1'>보험사</option>"
		  						+				"<option value='2'>수익자</option>"
		  						+				"<option value='3'>계약자</option>"
		  						+				"<option value='4'>피보험자</option>"
		  						+			"</select>"	
		  						+		"</p>"
		  						+	"</td>"
		  						
		  						//지연일수
		  						+	"<td class='td'>"
		  						+		"<p align='center'>"
		  						+			"<input type='text' class='printCtrlDelayCnt onlyNumber' id='printCtrlDelayCntTxt"+index+"' size='3' maxlength='4' />"
		  						+		"</p>"
		  						+	"</td>"
		  						
		  						//버튼
		  						+	"<td class='td'>"
		  						+		"<p align='center'>"
		  						+			"<span class='printCtrlSpan' id='SaveBtnPrintCtrlSpan"+index+"'>"			
		  						+				"<img src='./resources/ne_img/btn/btn_save.gif' onclick='javascript:printCtrlInsert("+index+",\"lotte\");' style='cursor:pointer;'/>"
		  						+				"<br/><img src='./resources/ne_img/btn/btn_close.gif' onclick='javascript:printCtrlAddClose("+index+");' serialNo='' style='cursor:pointer;margin-top:5px;'/>"
		  						+			"</span>"
		  						+		"</p>"
		  						+	"</td>"
		  						+"<tr>"
		  					);  
		  					
		  					$('#printCtrlDateTxt'+index).datepicker({ 
		  				    	   showOn: 'button',
		  				    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		  				    	   buttonImageOnly: true,
		  				    	   buttonText: "달력", 
		  				    	   changeMonth: true,
		  				    	   changeYear: true,
		  				    	   showButtonPanel: false
		  				    });
		  					
		  					$('#printCtrlEndDateTxt'+index).datepicker({ 
		  				    	   showOn: 'button',
		  				    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		  				    	   buttonImageOnly: true,
		  				    	   buttonText: "달력", 
		  				    	   changeMonth: true,
		  				    	   changeYear: true,
		  				    	   showButtonPanel: false
		  				    });
		  					$("#printCtrlSize").val( parseInt($("#printCtrlSize").val())+1 );
		  					
	  					}else{
	  						alert("잠시 후 시도 해주세요..");
	  					}
	  				},"json"
	  		);
	  	}
		
		
	  	//=================================
	  	//	사고처리과정표 - 첨부서류
	  	//=================================		
	  		
		function sagoDocAddView(CD,NM){
			var sagoDocNoteItems = '';
			var index = $("#SagoDocSize").val();
			var order = parseInt(index)+1; //순번
			var docCnt = '1'; //부수
			var docNote = ''; //비고
			
	  		$.post("getSagoDocSubjectList"
	  				,{
						 rptPrintNo : $("#rptPrintNo").val()
  					}
	  				,function(data,status){
	  					if (data != null && data != "" && status == "success"){
	  						sagoDocNoteItems = "<option value=''>--- 선택 ---</option>";
		  					for (var i = 0; i < data.sagoDocSubjectList.length; i++) {
		  						sagoDocNoteItems += "<option value='" + data.sagoDocSubjectList[i].col_val + "'>" + data.sagoDocSubjectList[i].col_val + "</option>";
		  					}
		  					sagoDocNoteItems += "<option value='999'>직접입력</option>";
		  					
		  					$("#sagoDocTbody").append(
		  							"<tr id='sagoDocTr"+index+"'>"
		  							+	"<td class='td'>"
		  							+		"<p align='center'>"
		  							+			"<span class='sagoDocSpan' id='sagoDocOrderSpan"+index+"'>"+order+"</span>"
		  							+		"</p>"
		  							+	"</td>"
		  							
		  							+	"<td class='td'>"
		  							+		"<p>"
		  							+			"<input class='sagoDocTxt' type='text' id='sagoDocNmTxt"+index+"' value='"+NM+"' style='width:219px;' />"
		  							+		"</p>"
		  							+	"</td>"
		  							+	"<td class='td'>"
		  							+		"<p align='center'>"
		  							+			"<input class='sagoDocTxt' type='text' id='sagoDocCntTxt"+index+"' value='"+docCnt+"' style='width:29px;'/>"
		  							+		"</p>"					
		  							+	"</td>"
		  							
		  							+	"<td class='td'>"
		  							+		"<p>"					
		  							+			"<select id='sagoDocNoteSelect"+index+"' onchange='javascript:fnSelectPick(this,3,"+index+");' style='width:229px;' >"
		  							+				sagoDocNoteItems
		  							+			"</select>"
		  							+			"<input class='sagoDocTxt' type='text' id='sagoDocNoteTxt"+index+"' value='"+docNote+"' style='width:229px;display:none;'/>"
		  							+		"</p>"					
		  							+	"</td>"
		  							
		  							+	"<td class='td'>"
		  							+		"<p align='center'>"
		  							+			"<span class='sagoDocSpan' id='sagoDocSaveBtnSpan"+index+"'>"			
		  							+				"<img src='./resources/ne_img/btn/btn_save.gif' class='sagoDocSaveBtn' onclick='sagoDocInsert("+index+")'id='sagoDocSaveBtn"+index+"' style='cursor:pointer;'/>"
		  							+				"<br/><img src='./resources/ne_img/btn/btn_close.gif' onclick='javascript:sagoDocAddClose("+index+");' serialNo='' style='cursor:pointer;margin-top:5px;'/>"					
		  							+			"</span>"
		  							+		"</p>"					
		  							+	"</td>"
		  							+"<tr>"
		  					);
		  					
		  					location.href="#sagoFocus";
		  					
		  					$("#SagoDocSize").val(parseInt($("#SagoDocSize").val())+1);
		  					$(".sagoDocAddBtn").attr("disabled",true);
		  					
	  					}else{
	  						alert("잠시 후 시도 해주세요..");
	  					}
	  				},"JSON"
	  				
	  				
  			);

	  	}
		
		//추가 - 닫기
		function sagoDocAddClose(index){
			$(".sagoDocAddBtn").attr("disabled",false);
	  		$("#sagoDocTr"+index).html("");
		}
		
		//추가 - 저장
		function sagoDocInsert(index){
			$.post("./ins1001sagoDoc"
					,{
						 rptPrintNo : $("#rptPrintNo").val()
						,attachName : $("#sagoDocNmTxt"+index).val()
						,attachCopy : $("#sagoDocCntTxt"+index).val()
						,attachEtcMemo : $("#sagoDocNoteTxt"+index).val()
					},
					function(data,status){
						$(".sagoDocAddBtn").attr("disabled",false);
						if (data.trim() != "ERROR" && status == 'success'){
							$("#sagoDocTbody").html("");
							$("#sagoDocTbody").html(data);
								
							alert("저장에 성공하였습니다.");
							
						}else{
							alert("저장에 실패하였습니다. 잠시후 시도해주세요..");
						}
					}
			);// $.post("./ins1001sagoDoc")
		}
		
		//삭제
		function sagoDocDelete(serialNo){
			var r = confirm("삭제 하시겠습니까?");
			if( r == false){
				return;
			}
			$.post("del1001sagoDoc",
				{ 
				 	 rptPrintNo : $("#rptPrintNo").val()
					,serialNo : serialNo
				},
				function(data,status){
					$(".sagoDocAddBtn").attr("disabled",false);
					if (data.trim() != "ERROR" && status == 'success'){
						$("#sagoDocTbody").html("");
						$("#sagoDocTbody").html(data);
						
						alert("삭제에 성공하였습니다.");
					}else{
						alert("삭제에 실패하였습니다. 잠시후 시도해주세요..");
					}
				}
			);
		}
		
		//수정 화면 변경
		function sagoDocModifyView(index){
			//버튼 변경
			$("#ModBtnSagoDocSpan"+index).hide();
			$("#ModAftSaveBtnSagoDocSpan"+index).show();
			$(".sagoDocAddBtn").attr("disabled",true);
			  
			//입력 화면 출력
			$("#sagoDocNmTxt"+index).show();
			$("#sagoDocCntTxt"+index).show();
			$("#sagoDocNoteInputSpan"+index).show();
			
			//입력완료 화면 삭제
			$("#sagoDocNmSpan"+index).hide();
			$("#sagoDocCntSpan"+index).hide();
			$("#sagoDocNoteSpan"+index).hide();
			
	  		$.post("getSagoDocSubjectList"
	  				,{
						 rptPrintNo : $("#rptPrintNo").val()
  					}
	  				,function(data,status){
	  					if (data != null && data != "" && status == "success"){
	  						sagoDocNoteItems = "<option value=''>--- 선택 ---</option>";
		  					for (var i = 0; i < data.sagoDocSubjectList.length; i++) {
		  						sagoDocNoteItems += "<option value='" + data.sagoDocSubjectList[i].col_val + "'>" + data.sagoDocSubjectList[i].col_val + "</option>";
		  					}
		  					sagoDocNoteItems += "<option value='999'>직접입력</option>";
		  					$("#sagoDocNoteSelect"+index).html("");
		  					$("#sagoDocNoteSelect"+index).append(sagoDocNoteItems);
	  					}
	  				},"json"
			);
		}
		
		//수정 - 취소
		function sagoDocModifyClose(index){
			//버튼 변경
			$("#ModBtnSagoDocSpan"+index).show();
			$("#ModAftSaveBtnSagoDocSpan"+index).hide();
			$(".sagoDocAddBtn").attr("disabled",false);
			  
			//입력 화면 출력
			$("#sagoDocNmTxt"+index).hide();
			$("#sagoDocCntTxt"+index).hide();
			$("#sagoDocNoteInputSpan"+index).hide();
			
			//입력완료 화면 삭제
			$("#sagoDocNmSpan"+index).show();
			$("#sagoDocCntSpan"+index).show();
			$("#sagoDocNoteSpan"+index).show();
		}
		
		//수정
		function sagoDocUpdate(index,serialNo){
			$.post("./udt1001sagoDoc"
					,{
						 rptPrintNo : $("#rptPrintNo").val()
						,serialNo : serialNo
						,attachName : $("#sagoDocNmTxt"+index).val()
						,attachCopy : $("#sagoDocCntTxt"+index).val()
						,attachEtcMemo : $("#sagoDocNoteTxt"+index).val()
						
					},
					function(data,status){
						if (data.trim() != "ERROR" && status == 'success'){
							$(".sagoDocAddBtn").attr("disabled",false);
							$("#sagoDocTbody").html("");
							$("#sagoDocTbody").html(data);
						}else{
							alert("수정에 실패하였습니다. 잠시후 시도해주세요..");
						}
					}
			);
		}

	  	//=================================
	  	//	상세 확인사항 - 고정메뉴
	  	//=================================		
		function dtlChkModifyView(gubun){
			//버튼 화면 처리
			$("#"+gubun+"ModViewBtn").hide();
			$("#"+gubun+"SaveBtn").show();
			$("#"+gubun+"SaveCloseBtn").show();
			
			//입력 화면 처리
			$("#"+gubun+"ViewSpan").hide();
			$("#"+gubun+"InputSpan").show();
			
			$("#"+gubun+"DtlTxtArea").val(  replaceTextArea( $("#"+gubun+"DtlSpan").html() ) );
			$("#"+gubun+"DtlTxtArea").focus();
			
		}
		
	  	//추가
		function dtlChkInsert(gubun){
	  		$.post("dtlChkInsert"
	  				,{
						 rptPrintNo : $("#rptPrintNo").val()
					 	,detailGubun : gubun
					 	,detailContentSub : $("#"+gubun+"SubDtlTxt").val()
					 	,detailContent : replaceHtml($("#"+gubun+"DtlTxtArea").html())
					 		
  					}
	  				,function(data,status){
	  					if (data == 1 && status == "success"){
	  						$("#"+gubun+"SubSpan").html( $("#"+gubun+"SubDtlTxt").val());
	  						$("#"+gubun+"DtlSpan").html( replaceHtml($("#"+gubun+"DtlTxtArea").html()));
	  						dtlChkClose(gubun);
	  					} 
	  				}
			);
		}
	  	
		//추가 - 닫기
		function dtlChkClose(gubun){
			//버튼 화면 처리
			$("#"+gubun+"ModViewBtn").show();
			$("#"+gubun+"SaveBtn").hide();
			$("#"+gubun+"SaveCloseBtn").hide();
			

			//입력 화면 처리
			$("#"+gubun+"ViewSpan").show();
			$("#"+gubun+"InputSpan").hide();
		}
		
		//클릭값 전송
		function dtlAddSubTxt(gubun, obj){
			if ( $("#"+gubun+"SubDtlTxt").val() == "" ){
				$("#"+gubun+"SubDtlTxt").val( obj.value );
			}else{
				var tmpStr = $("#"+gubun+"SubDtlTxt").val()+ ", " + obj.value
				$("#"+gubun+"SubDtlTxt").val( tmpStr );
			}
		}
		
	  	//=================================
	  	//	상세 확인사항 - 추가메뉴
	  	//=================================
	  		
	  	//화면 추가
	  	function dtlChkAddView(){
	  		$("#dtlChkAddBtn").hide();
	  		var index = $("#dtlChkSize").val();
	  		
	  		$("#etcDtlChkTbody").append(
  				"<tr id='"+index+"DtlChkTr1'><td>&nbsp;</td></tr>"
  				
				+"<tr id='"+index+"DtlChkTr2' class='td' bgcolor='#ECECEC'>"
  				+	"<td style='font-size:16px;font-weight:bold;padding:10px;' colspan='2'>"
  				+		"<input type='text' class='dtlTitleTxt' id='"+index+"DtlTitleTxt' placeholder='제목입력'/>"
  				+	"</td>"
  				+"</tr>"
  				
  				
  				+"<tr id='"+index+"DtlChkTr3'>"
				+	"<td class='td' colspan='2' style='padding: 0px;'>"
				+		"<table cellpadding='0' cellspacing='0' >"
				+			"<colgroup>"
				+				"<col width='100'></col>"
				+				"<col width='490'></col>"
				+				"<col width='50'></col>"
				+			"</colgroup>"

				+			"<tr>"
				+				"<td colspan='2' style='padding: 5px;'>"
				+					"<span id='"+index+"InputSpan'>"
				+						"<textarea class='dtlTxtArea' id='"+index+"DtlTxtArea' style='width:575px;'"
				+						  		  "onfocus='javascript:fnAutoSize(this.scrollHeight,this);'" 
				+								  "onKeyUP='javascript:fnAutoSize(this.scrollHeight,this);'"
				+								  "onKeyDown='javascript:fnAutoSize(this.scrollHeight,this);'></textarea>"
				+					"</span>"
				+				"</td>"
				
				+				"<td align='center'>"
				+					"<img src='./resources/ne_img/btn/btn_save.gif' class='dtlChkSaveBtn' onclick='javascript:etcDtlChkInsert("+index+")'id='dtlChkSaveBtn"+index+"' style='cursor:pointer;'/>"
				+					"<br/><img src='./resources/ne_img/btn/btn_close.gif' onclick='javascript:etcDtlChkAddClose("+index+");' style='cursor:pointer;margin-top:5px;'/>"		
				+				"</td>"
				
				+			"</tr>"
				+		"</table>"
				+	"</td>"
				+"</tr>"
	  		);
	  		location.href="#"+index+"DtlTitleTxt";
	  		
	  		$("#dtlChkSize").val( parseInt($("#dtlChkSize").val())+1 );
	  	}
	  	
		//추가 - 닫기
		function etcDtlChkAddClose(index){
	  		$("#"+index+"DtlChkTr1").html("");
	  		$("#"+index+"DtlChkTr2").html("");
	  		$("#"+index+"DtlChkTr3").html("");
	  		
			$("#dtlChkAddBtn").show();
		}
		
		//추가 - 저장
		function etcDtlChkInsert(index){
			$.post("./ins1001etcDtlChk"
					,{
						 rptPrintNo : $("#rptPrintNo").val()
					 	,detailTitle : $("#"+index+"DtlTitleTxt").val()
					 	,detailContent : replaceHtml($("#"+index+"DtlTxtArea").html())
					},
					function(data,status){
						$("#dtlChkAddBtn").show();
						if (data.trim() != "ERROR" && status == 'success'){
							$("#etcDtlChkTbody").html("");
							$("#etcDtlChkTbody").html(data);
								
							alert("저장에 성공하였습니다.");
							
						}else{
							alert("저장에 실패하였습니다. 잠시후 시도해주세요..");
						}
					}
			);// $.post("./ins1001sagoDoc")
		}
		
		//추가 - 삭제
		function etcDtlChkDelete(serialNo){
			var r = confirm("삭제 하시겠습니까?");
			if( r == false){
				return;
			}
			$.post("del1001etcDtlChk",
				{ 
				 	 rptPrintNo : $("#rptPrintNo").val()
					,serialNo : serialNo
				},
				function(data,status){
					$("#dtlChkAddBtn").show();
					if (data.trim() != "ERROR" && status == 'success'){
						$("#etcDtlChkTbody").html("");
						$("#etcDtlChkTbody").html(data);
							
						alert("삭제에 성공하였습니다.");
						
					}else{
						alert("삭제에 실패하였습니다. 잠시후 시도해주세요..");
					}
				}
			);
		}
		
		//수정
		function etcDtlChkModifyView(index){
			//버튼 화면 처리
			$("#ModBtnEtcDtlChkSpan"+index).hide();
			$("#ModAftSaveBtnEtcDtlChkSpan"+index).show();
			
			//입력 화면 처리
			$("#"+index+"DtlTitleSpan").hide();
			$("#"+index+"ViewSpan").hide();
			
			$("#"+index+"DtlTitleTxt").show();
			$("#"+index+"InputSpan").show();
			
			
			$("#"+index+"DtlTxtArea").val( replaceTextArea($("#"+index+"ViewSpan").html()) );
			$("#"+index+"DtlTxtArea").focus();
			
			
		}
		
		//수정 - 저장
		function etcDtlChkUpdate(index,serialNo){
			$.post("./udt1001etcDtlChk"
					,{
						 rptPrintNo : $("#rptPrintNo").val()
						,serialNo : serialNo
					 	,detailTitle : $("#"+index+"DtlTitleTxt").val()
					 	,detailContent : replaceHtml($("#"+index+"DtlTxtArea").html())
						
					},
					function(data,status){
						if (data.trim() != "ERROR" && status == 'success'){
							$("#etcDtlChkTbody").html("");
							$("#etcDtlChkTbody").html(data);
						}
					}
			);
		}
		
		//수정 닫기
		function etcDtlChkModifyClose(index){
			//버튼 화면 처리
			$("#ModBtnEtcDtlChkSpan"+index).show();
			$("#ModAftSaveBtnEtcDtlChkSpan"+index).hide();
			
			//입력 화면 처리
			$("#"+index+"DtlTitleSpan").show();
			$("#"+index+"ViewSpan").show();
			
			$("#"+index+"DtlTitleTxt").hide();
			$("#"+index+"InputSpan").hide();
			
		}
		
		
		
	    function fnAutoSize(s,obj) {
	        var m = 100;
	        if ( s >= m ) {
	            obj.style.pixelHeight = s +6;
	        } else {
	            obj.style.pixelHeight = m;
	        }
	    }
		
		function commaTotal(str) {
		    str = String(str);
		    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');			
		}
		
	    //textArea 엔터, 공백, " 값 치환
	    function replaceTextArea(str){
	    	changStr = str.replace(/<br>/g,"\n").replace(/&nbsp;/g,"\u0020").replace(/&quot/g,"\u0022");
			return changStr;	    	
	    }
	    
	  	//html 엔터, 공백, " 값 치환
	    function replaceHtml(str){
	    	changStr = str.replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;').replace(/\u0022/g, '&quot;')
			return changStr;	    	
	    }
		
	  	function fnRadioFlag(obj,gubun){
	  		$.post("upt1001Flag"
	  			   ,{
	  					 gubun : gubun
	  					,flag : obj.value
	  					,rptPrintNo : $("#rptPrintNo").val()
			  		}
	  			   ,function(data,status){
	  				   if (data == 1 && status == 'success'){
	  					 fnRaidoViewCtrl(gubun,obj.value);
	  				   }else{
	  					   alert("잠시 후 시도 해주세요..");
	  				   }
	  			   }
			);
	  	}
	  	
	  	function fnRaidoViewCtrl(gubun,flag){
	  		if (gubun == "sagoDoc"){
		  		if (flag == 0){
					$(".sagoDocTable").hide();
					$(':radio[name="sagoDocFlag"]:radio[value="0"]').attr('checked',true);
		  		}else{
					$(".sagoDocTable").show();
					$(':radio[name="sagoDocFlag"]:radio[value="1"]').attr('checked',true);
		  		}
	  		}else{
		  		if (flag == 0){
		  			$("#"+gubun+"DtlChkTr").hide();
		  			$(':radio[name="'+gubun+'ChkFlag"]:radio[value="0"]').attr('checked',true);
		  		}else{
		  			$("#"+gubun+"DtlChkTr").show();
		  			$(':radio[name="'+gubun+'ChkFlag"]:radio[value="1"]').attr('checked',true);
		  		}
		  		
	  		}
	  	}
	  	
	    /* mask 처리 */
	    function _initMask(){
	        var options = {
	            onKeyPress : function(cep, event, currentField, options){
	                var tid = event.currentTarget.id;
	                var tidx = tid.substr(tid.length - 1, 1);
	                //console.log(tidx);
	                //fnCaculateTotal(tidx);
	            },
	            reverse : true
	        };

	        $('input.onlyNumber').mask('#######',options);
	        $('div.onlyNumber').mask('999999999',{reverse:true});
	    }
