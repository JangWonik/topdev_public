function OnlyNumber(){
	if (!((event.keyCode == 8)||(event.keyCode == 9)||(event.keyCode == 13)||(event.keyCode == 46))){
		if ((event.keyCode<48)||(event.keyCode>57)){    // 키판의 숫자코드
			if ((event.keyCode<96)||(event.keyCode>105)){   //숫자판 숫자코드
				alert("숫자만 입력가능합니다.");
				event.returnValue=false;
			}	
		}
	}	
}

function oForm(){ return document.smsForm; }
function funAnyshot_Emoti_OnClick(th){

	var smslengths=oForm().smssizelenght.value;

	var vEmoti = th.innerText
	oTextMess().value = oTextMess().value + vEmoti ;
	funStringByteCheck(oTextByte(), oTextMess());
	if(parseInt(oTextByte().value) == smslengths){
		funEmotiWin_Hidden() ;
	}
}

function oTextMess(){ // 문자 전송 내용 넣는 객체

   if (oForm().msgfocus.value == '0'){
     return oForm().message ;
   }

}    

function oTextByte(){ //문자 전송 카운트 넣는 객체

   if (oForm().msgfocus.value == '0'){
     return oForm().lblByte0 ;
   }
}    

function funMsgFocus(sFocus){
  
    document.smsForm.msgfocus.value = sFocus ;
  
}
//메시지 입력시 string() byte check

function funStringByteCheck(objBytebox, objTextBox){
	var V = objTextBox.value ;
		var i = 0  ;
	var C = '' ;
	var intByte  = 0 ;
	var intLByte = 0 ;
	while( i < V.length){
		C = V.charAt(i) ;
		if(escape(C).length > 4){
			intByte+=2 ;
		}else if(C!='\r'){
			intByte++ ;
		}

		if (C=='\r' && intByte>79)
		{
			objTextBox.value = objTextBox.value.substr(0,i);
		}
		
		//80byte가 넘어가는 경우 LMS로 변경되도록 수정 by top3009
		
		/*if(intByte > 80){
			objBytebox.value = intByte ;
			alert("메시지란에 허용 길이 이상의 글을 쓰셨습니다.\n메시지는 최대 80 Byte까지만 작성하실 수 있습니다.");
			objTextBox.value = V.substr(0,i) ;
			intByte = intLByte ;
			break ;
		}*/			
		
		intLByte = intByte ;
		i++ ;
	}
	objBytebox.value = intByte ;
}

function oEmotiForm() { return document.all['oEmotiStringForm'] ; }   // 이모티콘/특수문자 레이어객체
function funEmotiWin_View(){    // 이모티콘/특수문자 창 보기	
	if(oEmotiForm().style.display == 'none'){
		oEmotiForm().style.display = '' ;
	}else{
		oEmotiForm().style.display = 'none' ;
	}
	oEmotiForm().style.top = 10 ;
	oEmotiForm().style.left = 200 ;
}
function funEmotiWin_Hidden(){    // 이모티콘/특수문자 창 숨기기
	oEmotiForm().style.display = 'none' ;
	oEmotiForm().style.top = 10 ;
	oEmotiForm().style.left = 200 ;
}

function oEmotiForm2() { return document.all['oEmotiStringForm2'] ; }   // 이모티콘/특수문자 레이어객체
function funEmotiWin_View2(){    // 이모티콘/특수문자 창 보기	
	if(oEmotiForm2().style.display == 'none'){
		oEmotiForm2().style.display = '' ;
	}else{
		oEmotiForm2().style.display = 'none' ;
	}
	oEmotiForm2().style.top = 235 ;
	oEmotiForm2().style.left = 200 ;
}
function funEmotiWin_Hidden2(){    // 이모티콘/특수문자 창 숨기기
	oEmotiForm2().style.display = 'none' ;
	oEmotiForm2().style.top = 235 ;
	oEmotiForm2().style.left = 200 ;
}

function formSend(fm,stype){    
		var oj1=fm.receiver.value;
		var stype;

		//if(fm.userid.value==""){ alert('아이디를 입력해 주세요');fm.userid.focus(); return false;}
		//if(fm.passwd.value==""){ alert('비밀번호를 입력해 주세요');fm.passwd.focus(); return false;}
		//if(fm.message.value==""){ alert('메시지를 입력해 주세요');fm.message.focus(); return false;}
		
		if(fm.phone_no.value==""){ alert('받는번호를 입력해 주세요.');fm.phone_no.focus(); return false;}
		if(fm.callback_no.value==""){ alert('보낸번호를 입력해 주세요');fm.sender.focus(); return false;}
		if(fm.message.value==""){ alert('문자내용을 입력해 주세요');fm.message.focus(); return false;}

		if(!(fm.receiver.value.length == 10 || fm.receiver.value.length == 11) && (oj1.substr(0,3)== "010" || oj1.substr(0,3)== "011" || oj1.substr(0,3)== "017" || oj1.substr(0,3)== "016" || oj1.substr(0,3)== "018" || oj1.substr(0,3)== "019" || oj1.substr(0,3)== "070" )) {
			fm.receiver.value = "";  alert('받는번호를 잘못 입력하셨습니다.');fm.receiver.focus(); return false; 
		} 

		//if(fm.sender.value==""){ alert('보낸번호를 입력해 주세요');fm.sender.focus(); return false;}

		if(stype=="1"){
			
			fm.SEND_TYPE.value = "N";
			
			fm.send_time.value="";
			Chk2 = confirm("발송 하시겠습니까?");

			if (Chk2==true) {
				fm.submit();
				alert("발송하였습니다.");
				return true;
			} else {
				return false;
			}
		} else {
			
			//예약발송 파라미터 추가
			fm.SEND_TYPE.value = "R";
			
			if(fm.days.value==""){ alert('예약날짜를 입력해 주세요');fm.days.focus(); return false;}
			if(fm.days.value.length != 8) { alert('예약날짜를 잘못입력하셨습니다.');fm.days.value = ""; fm.days.focus(); return false;}
			days1 = fm.days.value;
			//days2 = days1.replace("-","");
			days2 = days1.substring(0,4)+"-"+days1.substring(4,6)+"-"+days1.substring(6,8);		//날짜 패턴수정
			
			//fm.send_time.value=days2+""+fm.dhour.value+""+fm.dmin.value;
			fm.DATE.value=days2+" "+fm.dhour.value+":"+fm.dmin.value;		//예약발송시 사용 날짜			

			Chk2 = confirm("발송예약 하시겠습니까?");

			if (Chk2==true) {
				fm.submit();
				alert("발송예약하였습니다.");				
				return true;
			} else {
				return false;
			}
		}
}//formSend

function groupFormSend(fm,stype){    
	//var oj1=fm.receiver.value;
	var oj1=fm.phone_no.value;
	var stype;	

	//if(fm.userid.value==""){ alert('아이디를 입력해 주세요');fm.userid.focus(); return false;}
	//if(fm.passwd.value==""){ alert('비밀번호를 입력해 주세요');fm.passwd.focus(); return false;}
	//if(fm.message.value==""){ alert('메시지를 입력해 주세요');fm.message.focus(); return false;}

//	if(!(fm.receiver.value.length == 10 || fm.receiver.value.length == 11) && (oj1.substr(0,3)== "010" || oj1.substr(0,3)== "011" || oj1.substr(0,3)== "017" || oj1.substr(0,3)== "016" || oj1.substr(0,3)== "018" || oj1.substr(0,3)== "019" || oj1.substr(0,3)== "070" )) {
//		fm.receiver.value = "";  alert('받는번호를 잘못 입력하셨습니다.');fm.receiver.focus(); return false; 
//	} 

	//if(fm.receiver.value==""){ alert('받는번호를 입력해 주세요.');fm.receiver.focus(); return false;}
	//if(fm.sender.value==""){ alert('보낸번호를 입력해 주세요');fm.sender.focus(); return false;}
	
	if(fm.phone_no.value==""){ alert('받는번호를 입력해 주세요.');fm.phone_no.focus(); return false;}
	if(fm.callback_no.value==""){ alert('보낸번호를 입력해 주세요');fm.sender.focus(); return false;}
	if(fm.message.value==""){ alert('문자내용을 입력해 주세요');fm.message.focus(); return false;}

	if(stype=="1"){
		fm.SEND_TYPE.value = "N";
		
		fm.send_time.value="";
		Chk2 = confirm("발송 하시겠습니까?");

		if (Chk2==true) {
			fm.submit();
			alert("발송하였습니다.");
			return true;
		} else {
			return false;
		}
	} else {
		//예약발송 파라미터 추가
		fm.SEND_TYPE.value = "R";
		
		if(fm.days.value==""){ alert('예약날짜를 입력해 주세요');fm.days.focus(); return false;}
		if(fm.days.value.length != 8) { alert('예약날짜를 잘못입력하셨습니다.');fm.days.value = ""; fm.days.focus(); return false;}
		days1 = fm.days.value;
		//days2 = days1.replace("-","");
		days2 = days1.substring(0,4)+"-"+days1.substring(4,6)+"-"+days1.substring(6,8);		//날짜 패턴수정
		
		//fm.send_time.value=days2+" "+fm.dhour.value+":"+fm.dmin.value;
		fm.DATE.value=days2+" "+fm.dhour.value+":"+fm.dmin.value;		//예약발송시 사용 날짜		

		Chk2 = confirm("발송예약 하시겠습니까?");

		if (Chk2==true) {
			fm.submit();
			alert("발송예약하였습니다.");
			return true;
		} else {
			return false;
		}
	}
}//groupFormSend