$(function(){
	   $.datepicker.regional['ko'] = {
	   closeText: '닫기',
	   prevText: '이전달',
	   nextText: '다음달',
	   currentText: '오늘',
	   monthNames: ['1월(JAN)','2월(FEB)','3월(MAR)','4월(APR)','5월(MAY)','6월(JUN)',
	   '7월(JUL)','8월(AUG)','9월(SEP)','10월(OCT)','11월(NOV)','12월(DEC)'],
	   monthNamesShort: ['1월','2월','3월','4월','5월','6월',
	   '7월','8월','9월','10월','11월','12월'],
	   dayNames: ['일','월','화','수','목','금','토'],
	   dayNamesShort: ['일','월','화','수','목','금','토'],
	   dayNamesMin: ['일','월','화','수','목','금','토'],
	   weekHeader: 'Wk',
	   dateFormat: 'yy-mm-dd',
	   firstDay: 0,
	   isRTL: false,
	   showMonthAfterYear: true,
	   yearSuffix: ''};
	   $.datepicker.setDefaults($.datepicker.regional['ko']);

  $('#selectorFrom').datepicker({ 
	   showOn: 'button',
	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
	   buttonImageOnly: true,
	   buttonText: "달력", 
	   changeMonth: true,
	   changeYear: true,
	   showButtonPanel: false
    });
  
  $('#selectorTo').datepicker({ 
	   showOn: 'button',
	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
	   buttonImageOnly: true,
	   buttonText: "달력", 
	   changeMonth: true,
	   changeYear: true,
	   showButtonPanel: false
	});
  
  $('#join_date').datepicker({ 
	   showOn: 'button',
	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
	   buttonImageOnly: true,
	   buttonText: "달력", 
	   changeMonth: true,
	   changeYear: true,
	   showButtonPanel: false
	});
 
 $('#out_date').datepicker({ 
	   showOn: 'button',
	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
	   buttonImageOnly: true,
	   buttonText: "달력", 
	   changeMonth: true,
	   changeYear: true,
	   showButtonPanel: false
	});
 
 $('#probation_date').datepicker({ 
	   showOn: 'button',
	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
	   buttonImageOnly: true,
	   buttonText: "달력", 
	   changeMonth: true,
	   changeYear: true,
	   showButtonPanel: false
	});
 
 
 $('#expiry_date').datepicker({ 
	   showOn: 'button',
	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
	   buttonImageOnly: true,
	   buttonText: "달력", 
	   changeMonth: true,
	   changeYear: true,
	   showButtonPanel: false
	});
/* not use - delete please
 	$('#sago_time').datepicker({ 
	   showOn: 'button',
	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
	   buttonImageOnly: true,
	   buttonText: "달력", 
	   changeMonth: true,
	   changeYear: true,
	   showButtonPanel: false
	});

 	$('#suim_time').datepicker({ 
	   showOn: 'button',
	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
	   buttonImageOnly: true,
	   buttonText: "달력", 
	   changeMonth: true,
	   changeYear: true,
	   showButtonPanel: false
	});
*/
 	$('#suitFromDateForSuim').datepicker({ 
 	   showOn: 'button',
 	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
 	   buttonImageOnly: true,
 	   buttonText: "달력", 
 	   changeMonth: true,
 	   changeYear: true,
 	   showButtonPanel: false
 	});
 	
 	$('#suitToDateForSuim').datepicker({ 
  	   showOn: 'button',
  	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
  	   buttonImageOnly: true,
  	   buttonText: "달력", 
  	   changeMonth: true,
  	   changeYear: true,
  	   showButtonPanel: false
  	});
 	
 	$('#siteDate').datepicker({ 
  	   showOn: 'button',
  	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
  	   buttonImageOnly: true,
  	   buttonText: "달력", 
  	   changeMonth: true,
  	   changeYear: true,
  	   showButtonPanel: false
  	});
 	
 	$('#accidentDate').datepicker({ 
   	   showOn: 'button',
   	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
   	   buttonImageOnly: true,
   	   buttonText: "달력", 
   	   changeMonth: true,
   	   changeYear: true,
   	   showButtonPanel: false
   	});
/*
 	$('#invoice_date').datepicker({ 
    	   showOn: 'button',
    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
    	   buttonImageOnly: true,
    	   buttonText: "달력", 
    	   changeMonth: true,
    	   changeYear: true,
    	   showButtonPanel: false
    });
 	
 	$('#deposit_date').datepicker({ 
    	   showOn: 'button',
    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
    	   buttonImageOnly: true,
    	   buttonText: "달력", 
    	   changeMonth: true,
    	   changeYear: true,
    	   showButtonPanel: false
    });
 	
 	$('#tax_date').datepicker({ 
    	   showOn: 'button',
    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
    	   buttonImageOnly: true,
    	   buttonText: "달력", 
    	   changeMonth: true,
    	   changeYear: true,
    	   showButtonPanel: false
    });
*/
 	$('.classCalendar').datepicker({ 
    	   showOn: 'button',
    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
    	   buttonImageOnly: true,
    	   buttonText: "달력", 
    	   changeMonth: true,
    	   changeYear: true,
    	   showButtonPanel: false
    });

 	$('.classCalendar').keypress(function(){
 		if (event.keyCode == 8){
 			return false;
 		}
		if($(this).val().length == 4 || $(this).val().length == 7){
			$(this).val($(this).val()+"-")
		}
	});

	$('#reC').datepicker({ 
 	   showOn: 'button',
 	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
 	   buttonImageOnly: true,
 	   buttonText: "달력", 
 	   changeMonth: true,
 	   changeYear: true,
 	   showButtonPanel: false
 	});

 	$('.rstBld_RcnDt').datepicker({ 
  	   showOn: 'button',
  	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
  	   buttonImageOnly: true,
  	   buttonText: "달력", 
  	   changeMonth: true,
  	   changeYear: true,
  	   showButtonPanel: false
  	});

 	
 	
    $('#stdBgnde').datepicker({
        showOn: 'button',
        buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
        buttonImageOnly: true,
        buttonText: "달력",
        changeMonth: true,
        changeYear: true,
        showButtonPanel: false
    });
    $('#stdEndde').datepicker({
        showOn: 'button',
        buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
        buttonImageOnly: true,
        buttonText: "달력",
        changeMonth: true,
        changeYear: true,
        showButtonPanel: false
    });
    
    
    

 	 $('#calKb').datepicker({ 
		   showOn: 'button',
		   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		   buttonImageOnly: true,
		   buttonText: "달력", 
		   changeMonth: true,
		   changeYear: true,
		   showButtonPanel: false
	  });
	 
	 $('#calHan').datepicker({ 
		   showOn: 'button',
		   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		   buttonImageOnly: true,
		   buttonText: "달력", 
		   changeMonth: true,
		   changeYear: true,
		   showButtonPanel: false
	  });
	 $('#cost_occur_date').datepicker({ 
	  	   showOn: 'button',
	  	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
	  	   buttonImageOnly: true,
	  	   buttonText: "달력", 
	  	   changeMonth: true,
	  	   changeYear: true,
	  	   showButtonPanel: false
	  	});
	 	
	  	$('.cost_occur_date').datepicker({ 
	   	   showOn: 'button',
	   	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
	   	   buttonImageOnly: true,
	   	   buttonText: "달력", 
	   	   changeMonth: true,
	   	   changeYear: true,
	   	   showButtonPanel: false
	   	});
	  	
	  	$('#cost_occur_date2').datepicker({ 
		  	   showOn: 'button',
		  	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		  	   buttonImageOnly: true,
		  	   buttonText: "달력", 
		  	   changeMonth: true,
		  	   changeYear: true,
		  	   showButtonPanel: false
		  	});
		 	
		  	$('.cost_occur_date2').datepicker({ 
		   	   showOn: 'button',
		   	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		   	   buttonImageOnly: true,
		   	   buttonText: "달력", 
		   	   changeMonth: true,
		   	   changeYear: true,
		   	   showButtonPanel: false
		   	});
		  	$('#cost_apply_date3').datepicker({ 
		  		showOn: 'button',
		  		buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		  		buttonImageOnly: true,
		  		buttonText: "달력", 
		  		changeMonth: true,
		  		changeYear: true,
		  		showButtonPanel: false
		  	});
		  	
		  	$('.cost_apply_date3').datepicker({ 
		  		showOn: 'button',
		  		buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		  		buttonImageOnly: true,
		  		buttonText: "달력", 
		  		changeMonth: true,
		  		changeYear: true,
		  		showButtonPanel: false
		  	});
		  	
		  	$('.cost_apply_date').datepicker({ 
		  		showOn: 'button',
		  		buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		  		buttonImageOnly: true,
		  		buttonText: "달력", 
		  		changeMonth: true,
		  		changeYear: true,
		  		showButtonPanel: false
		  	});
		  	
		  	$('#cost_apply_date').datepicker({ 
		  		showOn: 'button',
		  		buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		  		buttonImageOnly: true,
		  		buttonText: "달력", 
		  		changeMonth: true,
		  		changeYear: true,
		  		showButtonPanel: false
		  	});
	  	
	  	$('#date_deposit').datepicker({ 
	    	   showOn: 'button',
	    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
	    	   buttonImageOnly: true,
	    	   buttonText: "달력", 
	    	   changeMonth: true,
	    	   changeYear: true,
	    	   showButtonPanel: false
	    });
	  	
	  	$('#dayoffFromDate').datepicker({ 
		 	   showOn: 'button',
		 	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		 	   buttonImageOnly: true,
		 	   buttonText: "달력", 
		 	   changeMonth: true,
		 	   changeYear: true,
		 	   showButtonPanel: false
		});
		   
		$('#dayoffToDate').datepicker({ 
		 	   showOn: 'button',
		 	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		 	   buttonImageOnly: true,
		 	   buttonText: "달력", 
		 	   changeMonth: true,
		 	   changeYear: true,
		 	   showButtonPanel: false
		});

		$('#appoint_date').datepicker({ 
		 	   showOn: 'button',
		 	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		 	   buttonImageOnly: true,
		 	   buttonText: "달력", 
		 	   changeMonth: true,
		 	   changeYear: true,
		 	   showButtonPanel: false
		});
		
		$('.appoint_date').datepicker({ 
		 	   showOn: 'button',
		 	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		 	   buttonImageOnly: true,
		 	   buttonText: "달력", 
		 	   changeMonth: true,
		 	   changeYear: true,
		 	   showButtonPanel: false
		});
		   
		$('#position_date').datepicker({ 
		 	   showOn: 'button',
		 	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		 	   buttonImageOnly: true,
		 	   buttonText: "달력", 
		 	   changeMonth: true,
		 	   changeYear: true,
		 	   showButtonPanel: false
		});
		
		$('.position_date').datepicker({ 
		 	   showOn: 'button',
		 	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		 	   buttonImageOnly: true,
		 	   buttonText: "달력", 
		 	   changeMonth: true,
		 	   changeYear: true,
		 	   showButtonPanel: false
		});
		
		$('#career_start_date').datepicker({ 
		 	   showOn: 'button',
		 	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		 	   buttonImageOnly: true,
		 	   buttonText: "달력", 
		 	   changeMonth: true,
		 	   changeYear: true,
		 	   showButtonPanel: false
		});
		
		$('.career_start_date').datepicker({ 
		 	   showOn: 'button',
		 	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		 	   buttonImageOnly: true,
		 	   buttonText: "달력", 
		 	   changeMonth: true,
		 	   changeYear: true,
		 	   showButtonPanel: false
		});
		
		$('#career_end_date').datepicker({ 
		 	   showOn: 'button',
		 	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		 	   buttonImageOnly: true,
		 	   buttonText: "달력", 
		 	   changeMonth: true,
		 	   changeYear: true,
		 	   showButtonPanel: false
		});
		
		$('.career_end_date').datepicker({ 
		 	   showOn: 'button',
		 	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		 	   buttonImageOnly: true,
		 	   buttonText: "달력", 
		 	   changeMonth: true,
		 	   changeYear: true,
		 	   showButtonPanel: false
		});
		
		$('#license_acquire_date').datepicker({ 
		 	   showOn: 'button',
		 	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		 	   buttonImageOnly: true,
		 	   buttonText: "달력", 
		 	   changeMonth: true,
		 	   changeYear: true,
		 	   showButtonPanel: false
		});
		
		$('.license_acquire_date').datepicker({ 
		 	   showOn: 'button',
		 	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		 	   buttonImageOnly: true,
		 	   buttonText: "달력", 
		 	   changeMonth: true,
		 	   changeYear: true,
		 	   showButtonPanel: false
		});
		
		$('#education_start_date').datepicker({ 
		 	   showOn: 'button',
		 	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		 	   buttonImageOnly: true,
		 	   buttonText: "달력", 
		 	   changeMonth: true,
		 	   changeYear: true,
		 	   showButtonPanel: false
		});
		
		$('.education_start_date').datepicker({ 
		 	   showOn: 'button',
		 	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		 	   buttonImageOnly: true,
		 	   buttonText: "달력", 
		 	   changeMonth: true,
		 	   changeYear: true,
		 	   showButtonPanel: false
		});
		
		$('#education_end_date').datepicker({ 
		 	   showOn: 'button',
		 	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		 	   buttonImageOnly: true,
		 	   buttonText: "달력", 
		 	   changeMonth: true,
		 	   changeYear: true,
		 	   showButtonPanel: false
		});
		
		$('.education_end_date').datepicker({ 
		 	   showOn: 'button',
		 	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		 	   buttonImageOnly: true,
		 	   buttonText: "달력", 
		 	   changeMonth: true,
		 	   changeYear: true,
		 	   showButtonPanel: false
		});
		
		$('#class_start_date').datepicker({ 
		 	   showOn: 'button',
		 	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		 	   buttonImageOnly: true,
		 	   buttonText: "달력", 
		 	   changeMonth: true,
		 	   changeYear: true,
		 	   showButtonPanel: false
		});
		
		$('.class_start_date').datepicker({ 
		 	   showOn: 'button',
		 	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		 	   buttonImageOnly: true,
		 	   buttonText: "달력", 
		 	   changeMonth: true,
		 	   changeYear: true,
		 	   showButtonPanel: false
		});
		
		$('#class_end_date').datepicker({ 
		 	   showOn: 'button',
		 	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		 	   buttonImageOnly: true,
		 	   buttonText: "달력", 
		 	   changeMonth: true,
		 	   changeYear: true,
		 	   showButtonPanel: false
		});
		
		$('.class_end_date').datepicker({ 
		 	   showOn: 'button',
		 	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		 	   buttonImageOnly: true,
		 	   buttonText: "달력", 
		 	   changeMonth: true,
		 	   changeYear: true,
		 	   showButtonPanel: false
		});
		



 });