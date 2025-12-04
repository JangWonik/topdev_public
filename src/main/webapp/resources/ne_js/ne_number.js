
/** KEYPRESS 방식에선 백스페이스가 먹히지 않아 KEYUP으로 돌리며 not USED, BY LDS - 170201
function onlyNumberFunc(){
	if( event.keyCode == 46 ){
		alert("소수점은 입력이 불가합니다.");
	}
	if(event.keyCode < 48 || event.keyCode > 57){
		event.returnValue=false;
	}
}//function onlyNumberFunc

function numberCommaFunc(write){
	var explo;
	var explo = write.value.length;
	var str = "";
	for (var k = (explo); k >= 0 ; k--) {
		if(write.value.substring(k-1,k) != ","){
			str = write.value.substring(k-1,k) + str;
		}
	}
	explo = str.length;
	var msg = "";
	var no =1;
	for (var k = (explo); k >= 0 ; k--) {
		if(no == 3 && k != 0){
			msg = str.substring(k-1,k) + "," + msg;
			no = 0;
		}else {
			msg = str.substring(k-1,k) + msg ;
		}
		no++;
	}
	write.value = msg;
	write.focus();
	return (false);
}//function numberCommaFunc
**/

//170208, keyDown시점에서 붙여넣기 이벤트를 잡지를 못함. notUsed
function onlyNumberFunc(write){//keyUp용 
	if( event.keyCode == 190 || event.keyCode == 110 ){
		alert("소수점은 입력이 불가합니다.");
	}
	//키보드 0~9, 키패드 0~9, 백스페이스가 아니면 리턴시키고, KEYUP이라 이미 들어온 쓰레기 값은 삭제
	//입력시 값이 없는 키들은 
	var tmp = 1;
	if(event.ctrlKey && event.keyCode == 86){
		tmp = 0;
	}else if(event.ctrlKey && event.keyCode == 67){
		tmp = 0;
	}
	
	
	if( (event.keyCode < 48 || event.keyCode > 57) 
		 && (event.keyCode < 96 || event.keyCode > 105 ) 
		 && event.keyCode != 8 	//백스페이스
		 && event.keyCode != 13 //엔터
		 && event.keyCode != 16	//쉬프트
		 && event.keyCode != 17 //좌컨트롤
		 && event.keyCode != 18	//좌알트
		 && event.keyCode != 19	//브레이크
		 && event.keyCode != 20 //캡스락
		 && event.keyCode != 21 //우알트
		 && event.keyCode != 25	//우컨트롤
		 && event.keyCode != 33 //페이지업
		 && event.keyCode != 34 //페이지다운
		 && event.keyCode != 35 //엔드
		 && event.keyCode != 36 //홈
		 && event.keyCode != 37 //좌방향키
		 && event.keyCode != 38 //상방향키
		 && event.keyCode != 39 //우방향키
		 && event.keyCode != 40 //하방향키
		 && event.keyCode != 45 //인서트
		 && event.keyCode != 46 //딜리트
		 && event.keyCode != 144//넘버락
		 && (event.keyCode < 112 || event.keyCode > 123) //F1~F12
		 && tmp == 1
	){
		event.returnValue=false;
		var explo = write.value.length;
		write.value = write.value.substring(0,explo-1);
	}
	
}//function onlyNumberFunc

function onlyNumberFunc2(write){//keyDown용
	if( event.keyCode == 190 || event.keyCode == 110 ){
		alert("소수점은 입력이 불가합니다.");
	}
	var tmp = 1;
	if(event.ctrlKey && event.keyCode == 86){
		tmp = 0;
	}else if(event.ctrlKey && event.keyCode == 67){
		tmp = 0;
	}
		
	if( (event.keyCode < 48 || event.keyCode > 57)
		&& (event.keyCode < 96 || event.keyCode > 105 ) 	
		&& event.keyCode != 8
		&& event.keyCode != 9 //탭키 적용
		&& tmp == 1)
	{
		event.returnValue=false;
	}
	
}//function onlyNumberFunc2


function numberCommaFunc(write){
	//엔터 입력시 무시
	if ( event.keyCode == 13 ){
		return false;
	}
	var explo;
	var explo = write.value.length;
	var str = "";
	for (var k = (explo); k >= 0 ; k--) {
		if(write.value.substring(k-1,k) != ","){
			str = write.value.substring(k-1,k) + str;
		}
	}
	explo = str.length;
	var msg = "";
	var no = 0;
	
	for (var k = (explo); k >= 0 ; k--) {
		if(no == 3 && k != 0){
			msg = str.substring(k-1,k) + "," + msg;
			no = 0;
		}else {
			msg = str.substring(k-1,k) + msg ;
		}
		no++;
	}
	write.value = msg;
	write.focus();
	return (false);
}//function numberCommaFunc


function removeCommaFunc(str)
{
	if(str != ""){
		n = parseInt(str.replace(/,/g,""));
	}else{
		n = "";
	}
	return n;
}//function removeComma



function phoneFomatter(num,type){
    var formatNum = '';
    
    if(num.length==11){
        if(type==0){
            formatNum = num.replace(/(\d{3})(\d{4})(\d{4})/, '$1-****-$3');
        }else{
            formatNum = num.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
        }
    }else if(num.length==8){
       formatNum = num.replace(/(\d{4})(\d{4})/, '$1-$2');
    }else if(num.length==7){
       formatNum = num.replace(/(\d{3})(\d{4})/, '$1-$2');
    }else{
        if(num.indexOf('02')==0){
            if(type==0){
                formatNum = num.replace(/(\d{2})(\d{4})(\d{4})/, '$1-****-$3');
            }else{
                formatNum = num.replace(/(\d{2})(\d{4})(\d{4})/, '$1-$2-$3');
            }
        }else{
            if(type==0){
                formatNum = num.replace(/(\d{3})(\d{3})(\d{4})/, '$1-***-$3');
            }else{
                formatNum = num.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
            }
        }
    }
    return formatNum;
}
/*
phoneFomatter('01000000000');   //010-0000-0000
phoneFomatter('01000000000',0); //010-****-0000
phoneFomatter('0100000000');    //010-000-0000
phoneFomatter('0100000000',0);  //010-***-0000
phoneFomatter('0200000000');    //02-0000-0000
phoneFomatter('0200000000',0);  //02-****-0000
phoneFomatter('0310000000');    //031-000-0000
phoneFomatter('0310000000',0);  //031-***-0000
phoneFomatter('16880000');      //1688-0000
*/

