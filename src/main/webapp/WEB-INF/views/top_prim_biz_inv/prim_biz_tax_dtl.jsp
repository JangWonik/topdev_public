<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar-rptinv.js"></script>
	<script src="./resources/ne_js/ne_number.js"></script>
	<script src="./resources/jquery/jquery.mask.min.js"></script>
	
	<script>
		$(document).ready(function(){
			if('${mbrAuthVo_Session.user_no}' == null || '${mbrAuthVo_Session.mbr_pms_8}' == 0){
				window.opener.location.assign("./logout");
				window.self.close();
			}
			
			_initMask();
			_initCalendar();
			
			//세금계산서 목록을 불러온다.
			getContList();
			
		});//ready
		
		function fnIssueContractEdit(){		
		    $("#btn_issue_cont_edit").hide();
		    $("#btn_issue_cont_save").show();
		    $("#btn_issue_cont_cancel").show();	    
		    	    
		    $("#cont_edit_type").val("edit");		//모드를 에디트모드로 변경한다.
		  	getContList();	    	    
		}
		
		function fnIssueContractCancel() {			
			//기존 입력 갯수로 카운트 초기화
			var formData = $("#taxForm").serialize();
			$.ajax({
				type : "post",
				url : "invTaxCnt",				
				data : formData,
				success : function(result){					
					TaxForm_Cnt = result;
				},
				error: function (request, status, error) {			
					console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
				}
			});
			
		    $("#btn_issue_cont_edit").show();
		    $("#btn_issue_cont_save").hide();
		    $("#btn_issue_cont_cancel").hide();
		    
		    $("#cont_edit_type").val("view");		//모드를 에디트모드로 변경한다.
		  	getContList();		
		}
		
		function fnIssueContractSave(){
			if(confirm("입력하신 세금계산서 정보를 저장하시겠습니까?")){			
				var sForm = document.taxEditForm;				
				var nCnt = 0;
				
				var arrList = new Array();
				
				//폼 시작
				nCnt = $("input[name='publish_date']").length;		// row수를 계산한다.				
				
				if( nCnt == 1 ){			//한개일때는 배열로 인식을 못함					
					arrList[0] = sForm.publish_date.value +"|"+sForm.publish_amount.value+"|"+sForm.deposit_date.value+"|"+sForm.deposit_amount.value;	
				}else{
					for( var i=0; i < nCnt; i++ ){						
						arrList[i] = sForm.publish_date[i].value +"|"+sForm.publish_amount[i].value+"|"+sForm.deposit_date[i].value+"|"+sForm.deposit_amount[i].value;
					}					
				}
				
				var param = {};
	            param.suim_rpt_no       	= sForm.suim_rpt_no.value;	                       
	            param.taxList					= arrList;						//세금계산서 정보를 배열형태로 넘김	            
	            
	            //var url = "./invTaxUpdate";
	            var url = "./invPrimTaxUpdate";

	            $.ajax({
	                type: "POST",
	                url: url,
	                data: param,
	                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	                dataType: "html",
	                traditional: true,						//배열허용
	                timeout: 20000,
	                success: function(data){
	                	
	                	alert(data+" 건의 계산서 정보가 추가되었습니다.");
                		$("#cont_edit_type").val("view");		//모드를 에디트모드로 변경한다.
                	  	getContList();
                		fnIssueContractCancel();
	                	                	
	                }
	            });
			}		
		}
		
		function getContList(){			//계약사항 표 불러오기
			
			var formData = $("#taxForm").serialize();
			$.ajax({
				type : "post",
				url : "./ajax/ajax_prim_biz_tax_dtl",				
				data : formData,
				success : function(result){			
					//보험목적물 페이지를 가져온다.		
					//alert('result='+result);				
					$("#cont_list").html(result);				
				},
				error: function (request, status, error) {			
					console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
				}
			});
		}
		
		function _initMask(){
		    var options = {
			onKeyPress : function(cep, event, currentField, options){
				
			    var tid = event.currentTarget.id;
			    var tidx = tid.substr(tid.length - 1, 1);
			    
			},
			reverse : true
		    };
		    
		    $('input.calendar').mask('0000-00-00',options);
		    $('input.money').mask('#,###,###',options);
		    $('td.money').mask('#,##0',{reverse:true});
		    $('div.money').mask('#,##0',{reverse:true});
		    $('span.money').mask('#,##0',{reverse:true});
		}
		
		function _initCalendar(){    	 
	  		$('.calendar').datepicker({
	  			showOn: 'button',
	  			buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
	  			buttonImageOnly: true,
	  			buttonText: "달력", 
	  			changeMonth: true,
	  			changeYear: true,	    	   
	  			showButtonPanel: false,
	  			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	  			dayNamesMin: ['일','월','화','수','목','금','토'],
	  			dateFormat: 'yy-mm-dd',
	  			firstDay: 0,
	  			isRTL: false,
	  			showMonthAfterYear: true
	  	    }); 		
	  		
	  	}
		
		//숫자입력만 가능하도록 이벤트 추가 by top3009
		function showKeyCode(event) {
			event = event || window.event;
			var keyID = (event.which) ? event.which : event.keyCode;
			if( ( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 || keyID == 9 ) ){
				return;
			}else{
				return false;
			}
		}
		
		var TaxForm_Cnt = ${taxListCnt};		//세금계산서 row		
		
		function fnTaxform_add(){
			
			//변경가능
			if( TaxForm_Cnt > 19){
				alert("세금계산서 내용은 20개까지 추가가 가능합니다.");
				return;
			}
			
			TaxForm_Cnt++;		
			
			var addContTr = "";
				
			addContTr = '<tr id='+TaxForm_Cnt+'>'+
				'<td align="center">'+
					'<input type="text" class="calendar" id="publish_date_'+TaxForm_Cnt+'" name="publish_date"  style="width: 50%;"/>'+	        		
	        	'</td>'+	        	
	        	'<td style="text-align: right;padding-right:5px;">'+
	        		'<input type="text" class="amt" id="publish_amount" name="publish_amount" value="0" style="text-align: right;padding-right:5px;" ONKEYUP="javascript:numberCommaFunc(this);"> 원'+
	        	'</td>'+
	        	'<td align="center">'+
					'<input type="text" class="calendar" id="deposit_date_'+TaxForm_Cnt+'" name="deposit_date"  style="width: 50%;"/>'+	        		
	        	'</td>'+	        	
	        	'<td style="text-align: right;padding-right:5px;">'+
	        		'<input type="text" class="amt" id="deposit_amount" name="deposit_amount" value="0" style="text-align: right;padding-right:5px;" ONKEYUP="javascript:numberCommaFunc(this);"> 원'+
	        	'</td>'+
	        	'<td align="center">'+
					'<img src="./resources/ls_img/btn_del_s.gif" border="0" style="cursor:pointer" onclick="fnTaxForm_del('+TaxForm_Cnt+');"/>'+
				'</td>'+
			'</tr>';
				
			var trHtml = $( "tr[name=tax_tr]:last" );
			trHtml.after(addContTr);
			
			_initCalendar();
		}
		
		function fnTaxForm_del(param){		//브라우저에서 삭제하는 경우		
			var trHtml = $( "tr[id='"+param+"']" );		
			TaxForm_Cnt--;
			trHtml.remove();
		}		
		
		function fnTaxForm_del_data(tax_no){
			if(confirm("해당 세금계산서 정보를 삭제 하시겠습니까?")){		//기존에 입력되어있는 DB 값 삭제
				var param = {};
	            param.tax_no       			= tax_no;	                                    
	            
	            //var url = "./invTaxDelete";
	            var url = "./invPrimTaxDelete";

	            $.ajax({
	                type: "POST",
	                url: url,
	                data: param,
	                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	                dataType: "html",
	                traditional: true,						//배열허용
	                timeout: 20000,
	                success: function(data){
	                	if( data ){		//1인 경우 성공 
	                		$("#cont_edit_type").val("edit");		//모드를 에디트모드로 불러온다.
	                		getContList();
	                	}                	
	                }                
	            });	
			}		
		}
	</script>
</head>
<body>
	<!-- header -->
	<div id="headerpop_mbr">
		<div class="inner clear_v2">
			<h1>
				<img src="./resources/wm_img/common/logo.gif" height="40" alt="top - TRUST OBLIGATION PASSION" />
			</h1>
			<div style="text-align:center;padding-top:10px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
				<font color="white"><b><span style="font-size:11pt;"> 세금계산서 상세 </span></b></font>
			</div>
		</div>
	</div>
	<!-- //header -->
	
	<!-- center -->
	<div id ="container">
		<div class="contetnsPop">
			<div class="center_cnt">
				<div class="centercnt_bot1-3" style="height: 678px !important;">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">세금계산서 관리</a></li>								
							</ul>
						</div><!-- //guestTap -->

						<div class="guestcnt5" style="height: 600px;">
							<div class= "tableStyle22">
								<form id="taxForm" name="taxForm">
								<input type="hidden" id="rptInvNo" name="rptInvNo" value="${invoiceDtl.getRpt_invoice_no()}" />
								<input type="hidden" id="suimRptNo" name="suimRptNo" value="${invoiceDtl.getSuim_rpt_no()}" />
								<input type="hidden" id="rptAmtTotal" name="rptAmtTotal" value="${invoiceDtl.getAmt_total()}"/>
								<input type="hidden" id="cont_edit_type" name="cont_edit_type" value="${cont_edit_type}"/>
								<input type="hidden" id="tax_edit_end" name="tax_edit_end" value="${invoiceDtl.getTax_edit_end()}"/>
								</form>
								<table cellpadding="0" cellspacing="0">
									<tr>
										<th>보험사</th>
										<th>접수번호</th>
										<th>피보험자</th>										
									</tr>						
									<tr>
										<td style="text-align:center;">${invoiceDtl.getPtnr_name()}</td>
										<td style="text-align:center;">${invoiceDtl.getSuim_accept_no()}</td>
										<td style="text-align:center;">${invoiceDtl.getBeneficiary_nm()}</td>
									</tr>			
								</table>
							</div>
							<!-- 계산서 등록 수정 시작 -->
							<div class="display-table" style="margin-top: 10px;margin-bottom: 10px;text-align:right;">
				               <a id="btn_issue_cont_edit" href="#noloc" onclick="fnIssueContractEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a>
				               <a id="btn_issue_cont_save" href="#noloc" style="display: none" onclick="fnIssueContractSave();"><img src="./resources/ls_img/icon_write.gif"/></a>
				               <a id="btn_issue_cont_cancel" href="#noloc" onclick="fnIssueContractCancel();" style="display: none"><img src="./resources/ls_img/btn_write_cancel.gif"/></a>
					       	</div>	
							<div id="cont_list"></div>
							<!-- 계산서 등록 수정 끝 -->
						</div><!-- //guestcnt5 -->						
					</div><!-- //guest -->
				</div><!-- //bot1-3 -->
			</div>
		</div>
	</div>
	<!--//center -->
</body>
