//-----------------------------------------------------------------------------
// 문자의 좌, 우 공백 제거
// @return : String
//-----------------------------------------------------------------------------

String.prototype.trim = function() {
    return this.replace(/(^\s*)|(\s*$)/g, "");
};

// -----------------------------------------------------------------------------
// 문자의 좌 공백 제거
// @return : String
// -----------------------------------------------------------------------------

String.prototype.ltrim = function() {
    return this.replace(/(^\s*)/, "");
};

// -----------------------------------------------------------------------------
// 문자의 우 공백 제거
// @return : String
// -----------------------------------------------------------------------------

String.prototype.rtrim = function() {
    return this.replace(/(\s*$)/, "");
};

// -----------------------------------------------------------------------------
// 주어진 문자열로 시작하는지 체크
// @return : boolean
// -----------------------------------------------------------------------------

String.prototype.startsWith = function(s) {
    return this.indexOf(s) == 0;
};

// -----------------------------------------------------------------------------
// 문자열의 byte 길이 반환
// @return : int
// -----------------------------------------------------------------------------

String.prototype.byteLengthUTF8 = function() {
    var cnt = 0;

    for ( var i = 0; i < this.length; i++) {
        if (this.charCodeAt(i) > 127) {
            //cnt += 2;
        	// utf-8 에서는 보통 한글은 3byte
        	cnt += 3;
        } else {
            cnt++;
        }
    }

    return cnt;
};

String.prototype.byteLength = function() {
    var cnt = 0;

    for ( var i = 0; i < this.length; i++) {
        if (this.charCodeAt(i) > 127) {
            cnt += 2;
        } else {
            cnt++;
        }
    }

    return cnt;
};

// -----------------------------------------------------------------------------
// 정수형으로 변환
// @return : String
// -----------------------------------------------------------------------------

String.prototype.numInt = function() {
    return parseInt(this.num());
};

// -----------------------------------------------------------------------------
// 정수형으로 변환
// @return : String
// -----------------------------------------------------------------------------

String.prototype.numDouble = function() {
    return parseFloat(this.numDecimal());
};

// -----------------------------------------------------------------------------
// 숫자만 가져 오기
// @return : String
// -----------------------------------------------------------------------------

String.prototype.num = function() {
    return (this.trim().replace(/[^0-9]/g, ""));
};

// -----------------------------------------------------------------------------
// 숫자만 가져 오기
// @return : String
// -----------------------------------------------------------------------------

String.prototype.numDecimal = function() {
    return (this.trim().replace(/[^0-9.]/g, ""));
};

// -----------------------------------------------------------------------------
// 숫자에 3자리마다 , 를 찍어서 반환
// @return : String
// -----------------------------------------------------------------------------

String.prototype.money = function() {
    var num = this.trim();

    while ((/(-?[0-9]+)([0-9]{3})/).test(num)) {
        num = num.replace((/(-?[0-9]+)([0-9]{3})/), "$1,$2");
    }

    return num;
};

// -----------------------------------------------------------------------------
// 숫자의 자리수(cnt)에 맞도록 반환
// @return : String
// -----------------------------------------------------------------------------

String.prototype.digits = function(cnt) {
    var digit = "";

    if (this.length < cnt) {
        for ( var i = 0; i < cnt - this.length; i++) {
            digit += "0";
        }
    }

    return digit + this;
};

// -----------------------------------------------------------------------------
// " -> &#34; ' -> &#39;로 바꾸어서 반환
// @return : String
// -----------------------------------------------------------------------------

String.prototype.quota = function() {
    return this.replace(/"/g, "&#34;").replace(/'/g, "&#39;");
};

// -----------------------------------------------------------------------------
// \n -> <br>; 공백 -> &nbsp;로 바꾸어서 반환
// @return : String
// -----------------------------------------------------------------------------

String.prototype.textAreaToHtml = function() {
    return this.replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;');
};


// -----------------------------------------------------------------------------
// 파일 확장자만 가져오기
// @return : String
// -----------------------------------------------------------------------------

String.prototype.ext = function() {
    return (this.indexOf(".") < 0) ? "" : this.substring(this.lastIndexOf(".") + 1, this.length);
};

// -----------------------------------------------------------------------------
// URL에서 파라메터 제거한 순수한 url 얻기
// @return : String
// -----------------------------------------------------------------------------

String.prototype.uri = function() {
    var arr = this.split("?");

    arr = arr[0].split("#");

    return arr[0];
};

// -----------------------------------------------------------------------------
// 정규식에 쓰이는 특수문자를 찾아서 이스케이프 한다.
// @return : String
// -----------------------------------------------------------------------------
String.prototype.meta = function() {
    var str = this;
    var result = "";

    for ( var i = 0; i < str.length; i++) {
        if ((/([\$\(\)\*\+\.\[\]\?\\\^\{\}\|]{1})/).test(str.charAt(i))) {
            result += str.charAt(i).replace((/([\$\(\)\*\+\.\[\]\?\\\^\{\}\|]{1})/), "\\$1");
        } else {
            result += str.charAt(i);
        }
    }

    return result;
};

// -----------------------------------------------------------------------------
// 정규식에 쓰이는 특수문자를 찾아서 이스케이프 한다.
// @return : String
// -----------------------------------------------------------------------------

String.prototype.remove = function(pattern) {
    return (pattern == null) ? this : eval("this.replace(/[" + pattern.meta() + "]/g, \"\")");
};

// -----------------------------------------------------------------------------
// 최소 최대 길이인지 검증
// str.isLength(min [,max])
// @return : boolean
// -----------------------------------------------------------------------------

String.prototype.isLength = function() {
    var min = arguments[0];
    var max = arguments[1] ? arguments[1] : null;
    var success = true;

    if (this.length < min) {
        success = false;
    }

    if (max && this.length > max) {
        success = false;
    }

    return success;
};

// -----------------------------------------------------------------------------
// 최소 최대 바이트인지 검증
// str.isByteLength(min [,max])
// @return : boolean
// -----------------------------------------------------------------------------

String.prototype.isByteLength = function() {
    var min = arguments[0];
    var max = arguments[1] ? arguments[1] : null;
    var success = true;

    if (this.byteLength() < min) {
        success = false;
    }

    if (max && this.byteLength() > max) {
        success = false;
    }

    return success;
};

// -----------------------------------------------------------------------------
// 공백이나 널인지 확인
// @return : boolean
// -----------------------------------------------------------------------------

String.prototype.isBlank = function() {
    var str = this.trim();

    for ( var i = 0; i < str.length; i++) {
        if ((str.charAt(i) != "\t") && (str.charAt(i) != "\n") && (str.charAt(i) != "\r")) {

            return false;
        }
    }

    return true;
};

// -----------------------------------------------------------------------------
// 숫자로 구성되어 있는지 학인
// arguments[0] : 허용할 문자셋
// @return : boolean
// -----------------------------------------------------------------------------

String.prototype.isNumeric = function() {
    return (/^[0-9]+$/).test(this.remove(arguments[0])) ? true : false;
};

// -----------------------------------------------------------------------------
// 영어만 허용 - arguments[0] : 추가 허용할 문자들
// @return : boolean
// -----------------------------------------------------------------------------

String.prototype.isAlpha = function() {
    return (/^[a-zA-Z]+$/).test(this.remove(arguments[0])) ? true : false;
};

// -----------------------------------------------------------------------------
// 숫자와 영어만 허용 - arguments[0] : 추가 허용할 문자들
// @return : boolean
// -----------------------------------------------------------------------------

String.prototype.isAlphaNumeric = function() {
    return (/^[0-9a-zA-Z]+$/).test(this.remove(arguments[0])) ? true : false;
};

// -----------------------------------------------------------------------------
// 아이디 체크 소문자 영어와 숫자만 체크 첫글자는 영어로 시작 - arguments[0] : 추가 허용할 문자들
// @return : boolean
// -----------------------------------------------------------------------------

String.prototype.isUserid = function() {
    //return (/^[a-zA-z]{1}[0-9a-zA-Z]+$/).test(this.remove(arguments[0])) ? true : false;
    return (/^[a-z]{1}[0-9a-z]+$/).test(this.remove(arguments[0])) ? true : false;
};

// -----------------------------------------------------------------------------
// 한글 체크 - arguments[0] : 추가 허용할 문자들
// @return : boolean
// -----------------------------------------------------------------------------

String.prototype.isKorean = function() {
    return (/^[ㄱ-ㅎ가-힝]+$/).test(this.remove(arguments[0])) ? true : false;
};

//-----------------------------------------------------------------------------
//주민번호 체크 - arguments[0] : 주민번호 구분자
//XXXXXX-XXXXXXX
//@return : boolean
//-----------------------------------------------------------------------------

String.prototype.isSSN = function() {
 var arg = arguments[0] ? arguments[0] : "";

 var ssn = eval("this.match(/[0-9]{2}[01]{1}[0-9]{1}[0123]{1}[0-9]{1}" + arg + "[1234]{1}[0-9]{6}$/)");

 if (ssn == null) {
     return false;
 } else {
     ssn = ssn.toString().num().toString();
 }

 // 생년월일 체크
 var birthYY = (parseInt(ssn.charAt(6)) == (1 || 2)) ? "19" : "20";

 birthYY += ssn.substr(0, 2);

 var birthMM = ssn.substr(2, 2) - 1;
 var birthDD = ssn.substr(4, 2);
 var birthDay = new Date(birthYY, birthMM, birthDD);

 if (birthDay.getFullYear() % 100 != ssn.substr(0, 2) || birthDay.getMonth() != birthMM || birthDay.getDate() != birthDD) {

     return false;
 }

 var sum = 0;
 var num = [ 2, 3, 4, 5, 6, 7, 8, 9, 2, 3, 4, 5 ];
 var last = parseInt(ssn.charAt(12));

 for ( var i = 0; i < 12; i++) {
     sum += parseInt(ssn.charAt(i)) * num[i];
 }

 return ((11 - sum % 11) % 10 == last) ? true : false;
};

//-----------------------------------------------------------------------------
//외국인 등록번호 체크 - arguments[0] : 등록번호 구분자
//XXXXXX-XXXXXXX
//@return : boolean
//-----------------------------------------------------------------------------

String.prototype.isForeign = function() {
 var arg = arguments[0] ? arguments[0] : "";

 var foreign = eval("this.match(/[0-9]{2}[01]{1}[0-9]{1}[0123]{1}[0-9]{1}" + arg + "[5678]{1}[0-9]{1}[02468]{1}[0-9]{2}[6789]{1}[0-9]{1}$/)");

 if (foreign == null) {
     return false;
 } else {
     foreign = foreign.toString().num().toString();
 }

 // 생년월일 체크

 var birthYY = (parseInt(foreign.charAt(6)) == (5 || 6)) ? "19" : "20";

 birthYY += foreign.substr(0, 2);

 var birthMM = foreign.substr(2, 2) - 1;
 var birthDD = foreign.substr(4, 2);
 var birthDay = new Date(birthYY, birthMM, birthDD);

 if (birthDay.getFullYear() % 100 != foreign.substr(0, 2) || birthDay.getMonth() != birthMM || birthDay.getDate() != birthDD) {

     return false;
 }

 if ((parseInt(foreign.charAt(7)) * 10 + parseInt(foreign.charAt(8))) % 2 != 0) {
     return false;
 }

 var sum = 0;
 var num = [ 2, 3, 4, 5, 6, 7, 8, 9, 2, 3, 4, 5 ];
 var last = parseInt(foreign.charAt(12));

 for ( var i = 0; i < 12; i++) {
     sum += parseInt(foreign.charAt(i)) * num[i];
 }

 return (((11 - sum % 11) % 10) + 2 == last) ? true : false;

};

//-----------------------------------------------------------------------------
//사업자번호 체크 - arguments[0] : 등록번호 구분자
//XX-XXX-XXXXX
//@return : boolean
//-----------------------------------------------------------------------------

String.prototype.isBizNum = function() {
 var arg = arguments[0] ? arguments[0] : "";
 var biznum = eval("this.match(/[0-9]{3}" + arg + "[0-9]{2}" + arg + "[0-9]{5}$/)");

 if (biznum == null) {
     return false;
 } else {
     biznum = biznum.toString().num().toString();
 }

 var sum = parseInt(biznum.charAt(0));
 var num = [ 0, 3, 7, 1, 3, 7, 1, 3 ];

 for ( var i = 1; i < 8; i++) {
     sum += (parseInt(biznum.charAt(i)) * num[i]) % 10;
 }

 sum += Math.floor(parseInt(parseInt(biznum.charAt(8))) * 5 / 10);
 sum += (parseInt(biznum.charAt(8)) * 5) % 10 + parseInt(biznum.charAt(9));

 return (sum % 10 == 0) ? true : false;
};

//-----------------------------------------------------------------------------
//법인 등록번호 체크 - arguments[0] : 등록번호 구분자
//XXXXXX-XXXXXXX
//@return : boolean
//-----------------------------------------------------------------------------

String.prototype.isCorpNum = function() {
 var arg = arguments[0] ? arguments[0] : "";
 var corpnum = eval("this.match(/[0-9]{6}" + arg + "[0-9]{7}$/)");

 if (corpnum == null) {
     return false;
 } else {
     corpnum = corpnum.toString().num().toString();
 }

 var sum = 0;
 var num = [ 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2 ];
 var last = parseInt(corpnum.charAt(12));

 for ( var i = 0; i < 12; i++) {
     sum += parseInt(corpnum.charAt(i)) * num[i];
 }

 return ((10 - sum % 10) % 10 == last) ? true : false;
};

//-----------------------------------------------------------------------------
//이메일의 유효성을 체크
//@return : boolean
//-----------------------------------------------------------------------------
String.prototype.isEmail = function() {
 return (/\w+([-+.]\w+)*@\w+([-.]\w+)*\.[a-zA-Z]{2,4}$/).test(this.trim());
};

//-----------------------------------------------------------------------------
//URL 유효성을 체크
//@return : boolean
//-----------------------------------------------------------------------------
String.prototype.isURL = function() {
    return (/^(?:(?:https?|ftp):\/\/)(?:\S+(?::\S*)?@)?(?:(?!10(?:\.\d{1,3}){3})(?!127(?:\.\d{1,3}){3})(?!169\.254(?:\.\d{1,3}){2})(?!192\.168(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]+-?)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]+-?)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})))(?::\d{2,5})?(?:\/[^\s]*)?$/i).test(this.trim());
};


//-----------------------------------------------------------------------------
//전화번호 체크 - arguments[0] : 전화번호 구분자
//@return : boolean
//-----------------------------------------------------------------------------

String.prototype.isPhone = function() {
 var arg = arguments[0] ? arguments[0] : "";

 return eval("(/(02|0[3-9]{1}[0-9]{1})" + arg + "[1-9]{1}[0-9]{2,3}" + arg + "[0-9]{4}$/).test(this)");
};

//-----------------------------------------------------------------------------
//핸드폰번호 체크 - arguments[0] : 핸드폰 구분자
//@return : boolean
//-----------------------------------------------------------------------------

String.prototype.isMobile = function() {
 var arg = arguments[0] ? arguments[0] : "";

 return eval("(/01[016789]" + arg + "[1-9]{1}[0-9]{2,3}" + arg + "[0-9]{4}$/).test(this)");
};

//-----------------------------------------------------------------------------
//날짜형식 체크
//@return : boolean
//-----------------------------------------------------------------------------

String.prototype.isValidDate = function() {
 var date = this;

 date = date.replace(/-/g, "").replace(/\./g, "");

 var y = parseInt(date.substring(0, 4), 10);
 var m = parseInt(date.substring(4, 6), 10) - 1;
 var d = parseInt(date.substring(6, 8), 10);

 var dv = new Date(y, m, d);

 return (dv.getFullYear() == y && dv.getMonth() == m && dv.getDate() == d);
};

String.prototype.isValidFullDate = function() {
    //2015-10-23 15:07:49

    var date = this;

    date = date.replace(/-/g, "").replace(/\./g, "").replace(/\:/g, "").replace(/(\s*)/g, "");

    var y = parseInt(date.substring(0, 4), 10);
    var m = parseInt(date.substring(4, 6), 10) - 1;
    var d = parseInt(date.substring(6, 8), 10);

    var HH = parseInt(date.substring(8, 10), 10);
    var mm = parseInt(date.substring(10, 12), 10);
    var ss = parseInt(date.substring(12, 14), 10);

    //console.log("y=" + y);
    //console.log("m=" + m);
    //console.log("d=" + d);
    //console.log("hh=" + HH);
    //console.log("mm=" + mm);
    //console.log("ss=" + ss);

    var dv = new Date(y, m, d, HH, mm, ss);

    //console.log("============================");
    //console.log("y=" + dv.getFullYear());
    //console.log("m=" + dv.getMonth());
    //console.log("d=" + dv.getDate());
    //console.log("hh=" + dv.getHours());
    //console.log("mm=" + dv.getMinutes());
    //console.log("ss=" + dv.getSeconds());


    return (dv.getFullYear() == y && dv.getMonth() == m && dv.getDate() == d && dv.getHours() == HH && dv.getMinutes() == mm && dv.getSeconds() == ss);
};

//-----------------------------------------------------------------------------
//날짜형식 문자열을 날짜객체로 변환
//@return : Date
//-----------------------------------------------------------------------------

String.prototype.toDate = function(f) {
 if (!this.isValidDate()) {
     if (f) {
         return null;
     } else {
         return new Date();
     }
 }

 var date = this;

 date = date.replace(/-/g, "").replace(/\./g, "");

 var y = parseInt(date.substring(0, 4), 10);
 var m = parseInt(date.substring(4, 6), 10) - 1;
 var d = parseInt(date.substring(6, 8), 10);

 return new Date(y, m, d);
};

//-----------------------------------------------------------------------------
//현재 문자의 문자열을 길이(len)만큼 생성
//@return : String
//-----------------------------------------------------------------------------

String.prototype.string = function(len) {
 var s = "", i = 0;

 while (i++ < len) {
     s += this;
 }

 return s;
};

//-----------------------------------------------------------------------------
//문자열을 주어진 길이(len)만큼 zero-padding
//@return : String
//-----------------------------------------------------------------------------

String.prototype.zf = function(len) {
 return "0".string(len - this.length) + this;
};

//-----------------------------------------------------------------------------
//날짜를 주어진 포멧에 맞추어 문자열로 변환
//- yyyy: 년도(4자리)
//- MM  : 월
//- dd  : 일
//- HH  : 시간(24시간)
//- mm  : 분
//- ss  : 초
//@return : String
//-----------------------------------------------------------------------------

Date.prototype.format = function(f) {
 if (!this.valueOf()) {
     return "";
 }

 var d = this;

 return f.replace(/(yyyy|MM|dd|hh|HH|mm|ss|)/gi, function($1) {
     switch ($1) {
     case "yyyy":
         return d.getFullYear();
     case "MM":
         return new String(d.getMonth() + 1).zf(2);
     case "dd":
         return new String(d.getDate()).zf(2);
     case "hh":
         return new String(((h = d.getHours() % 12) ? h : 12)).zf(2);
     case "HH":
         return new String(d.getHours()).zf(2);
     case "mm":
         return new String(d.getMinutes()).zf(2);
     case "ss":
         return new String(d.getSeconds()).zf(2);
     }

     return "";
 });
};

//-----------------------------------------------------------------------------
//배열의 끝에 새로운 요소를 추가
//@return : Object
//-----------------------------------------------------------------------------

Array.prototype.add = function(o) {
 this.push(o);

 return o;
};

//-----------------------------------------------------------------------------
//배열에서 특정 객체를 삭제
//@return : Object
//-----------------------------------------------------------------------------

Array.prototype.remove = function(o) {
 var i;

 for (i = 0; i < this.length; i++) {
     if (this[i] == o) {
         this.pop(i);
     }
 }

 return o;
};

//-----------------------------------------------------------------------------
//특정 객체의 값이 비었는지 여부를 확인
//@return : boolean
//-----------------------------------------------------------------------------

function isEmptyOrNull(o) {
 if (o == undefined || o == null) {
     return true;
 }

 if (typeof(o) == "string") {
     return o.trim().length == 0;
 } else {
     return $(o).val().trim().length == 0;
 }
}

//-----------------------------------------------------------------------------
//주어진 폼(form)의 필수 입력 필드 누락여부를 확인
//@return : none
//-----------------------------------------------------------------------------

function validateRequiredFields(form) {
 var fields = $("input.required", form);

 for (var i = 0; i < fields.length; i++) {
     var o = fields[i];
     if (isEmptyOrNull($(o))) {
         alert("필수값의 입력이 누락되었습니다.\n[필드명: " + $(o).attr("placeholder") + "]");
         $(o).focus();
         return false;
     }
 }

 return true;
}

function validateRequiredFields2(form) {
    var fields = $("input.required", form);

    for (var i = 0; i < fields.length; i++) {
        var o = fields[i];
        if (isEmptyOrNull($(o))) {
            alert("필수값의 입력이 누락되었습니다.\n[필드명: " + $(o).attr("title") + "]");
            $(o).focus();
            return false;
        }
    }

    return true;
}


//-----------------------------------------------------------------------------
//날짜 형식 체크
//@return : boolean
//-----------------------------------------------------------------------------

function isValidDate(date) {
 if (!date) {
     return false;
 } else if (typeof (date) == "object") {
     if (!date.format) {
         return false;
     } else {
         date = date.format("yyyyMMdd");
     }
 }

 date = date.replace(/-/g, "").replace(/\./g, "");

 var y = parseInt(date.substring(0, 4), 10);
 var m = parseInt(date.substring(4, 6), 10) - 1;
 var d = parseInt(date.substring(6, 8), 10);

 var dv = new Date(y, m, d);

 return (dv.getFullYear() == y && dv.getMonth() == m && dv.getDate() == d);
}

//-----------------------------------------------------------------------------
//주어진 두 날짜값을 비교
//@return : int
//-----------------------------------------------------------------------------

function compareDate(date1, date2) {
 if (!date1) {
     alert("compareDate(): The parameter \"date1\" is null.");
     return 0;
 } else if (typeof (date1) == "object") {
     if (!date1.format) {
         alert("compareDate(): The parameter \"date1\" is no date object or string.");
         return 0;
     } else {
         date1 = date1.format("yyyyMMdd");
     }
 }

 if (!date2) {
     alert("compareDate(): The parameter \"date2\" is null.");
     return 0;
 } else if (typeof (date2) == "object") {
     if (!date2.format) {
         alert("compareDate(): The parameter \"date2\" is no date object or string.");
         return 0;
     } else {
         date2 = date2.format("yyyyMMdd");
     }
 }

 date1 = date1.replace(/-/g, "").replace(/\./g, "");
 date2 = date2.replace(/-/g, "").replace(/\./g, "");

 var y1 = parseInt(date1.substring(0, 4), 10);
 var m1 = parseInt(date1.substring(4, 6), 10) - 1;
 var d1 = parseInt(date1.substring(6, 8), 10);

 var y2 = parseInt(date2.substring(0, 4), 10);
 var m2 = parseInt(date2.substring(4, 6), 10) - 1;
 var d2 = parseInt(date2.substring(6, 8), 10);

 var dt1 = new Date(y1, m1, d1);
 var dt2 = new Date(y2, m2, d2);

 return dt2.getTime() - dt1.getTime();
}

//-----------------------------------------------------------------------------
//date1 < date2 인지를 비교
//@return : boolean
//-----------------------------------------------------------------------------

function isBeforeDate(date1, date2) {
 if (!isValidDate(date1)) {
     return false;
 } else if (!isValidDate(date2)) {
     return false;
 }

 return compareDate(date1, date2) > 0;
}

//-----------------------------------------------------------------------------
//date1 > date2 인지를 비교
//@return : boolean
//-----------------------------------------------------------------------------

function isAfterDate(date1, date2) {
 if (!isValidDate(date1)) {
     return false;
 } else if (!isValidDate(date2)) {
     return false;
 }

 return compareDate(date1, date2) < 0;
}

//-----------------------------------------------------------------------------
//date1 == date2 인지를 비교
//@return : boolean
//-----------------------------------------------------------------------------

function isSameDate(date1, date2) {
 if (!isValidDate(date1)) {
     return false;
 } else if (!isValidDate(date2)) {
     return false;
 }

 return compareDate(date1, date2) == 0;
}

//-----------------------------------------------------------------------------
//주어진 두 날짜의 차이를 구한다.
//@return : int
//-----------------------------------------------------------------------------

function getDiffDays(date1, date2) {
 if (!date1) {
     alert("getDiffDays(): The parameter \"date1\" is null.");
     return 0;
 } else if (typeof (date1) == "string") {
     date1 = date1.toDate();
     if (date1 == null) {
         alert("getDiffDays(): The parameter \"date1\" is not valid date string.");
         return 0;
     }
 } else if (typeof (date1) == "object") {
     if (!date1.format) {
         alert("getDiffDays(): The parameter \"date1\" is no date object or string");
         return 0;
     }
 }

 if (!date2) {
     alert("getDiffDays(): The parameter \"date2\" is null.");
     return 0;
 } else if (typeof (date2) == "string") {
     date2 = date2.toDate();
     if (date2 == null) {
         alert("getDiffDays(): The parameter \"date2\" is not valid date string.");
         return 0;
     }
 } else if (typeof (date2) == "object") {
     if (!date2.format) {
         alert("getDiffDays(): The parameter \"date2\" is no date object or string");
         return 0;
     }
 }

 return Math.abs((date2.getTime() - date1.getTime()) / 1000 / 60 / 60 / 24);
}

//-----------------------------------------------------------------------------
//Date 날짜 계산 헬퍼.
//- field     : "D" - 일, "W" - 주, "M" - 월, "Y" - 년 (대소문자 구분 없음)
//- amount    : DIFF 값
//- dateParam : 날짜 (string형);
//- format    : 날짜 포맷
//- "yyyy" - 년
//- "MM" - 월
//- "dd" - 일
//- "hh" - 시
//- "mm" - 분
//- "ss" - 초
//@return : 날짜
//-----------------------------------------------------------------------------
function getDateGap(field, amount, dateParam, format) {
 var date1;
 var format;

 if (!(new RegExp(/^[YMWD]$/i).test(field))) {
     alert("getDateGap(): Invaild field mark specified.");
     return;
 }

 if (!dateParam) {
     alert("getDateGap(): date param is null.");
     return;
 }

 if (typeof (dateParam) == "string") {
     date1 = dateParam.toDate();
 }

 var instrestedDate = date1;

 format = (format) ? format : "yyyy-MM-dd";
 field = field.toUpperCase();

 switch (field) {
 case "Y":
     instrestedDate.setYear(instrestedDate.getFullYear() + amount);
     break;

 case "M":
     instrestedDate.setMonth(instrestedDate.getMonth() + amount);
     break;

 case "W":
     instrestedDate.setDate(instrestedDate.getDate() + (amount * 7));
     break;

 case "D":
     instrestedDate.setDate(instrestedDate.getDate() + amount);
     break;
 }

 return instrestedDate.format(format);
}

//-----------------------------------------------------------------------------
//허용된 파일 형식인지 체크
//@return : int
//-----------------------------------------------------------------------------

function isAllowsFileType (file, arry) {
  var allowFileTypes = ["txt","xls","xlsx","doc","docx","ppt","pptx","pps","ppsx","hwp","pdf","zip","jpg","jpeg","png","gif","bmp"];
  var index = file.lastIndexOf('.');
  var type = file.substring(index+1, file.length);
  type = type.toLowerCase();   
  
  if((arry !== undefined) && (arry !== null)){
      return $.inArray(type, arry);
  }else{
      return $.inArray(type, allowFileTypes);
  }
  
  
};

//-----------------------------------------------------------------------------
//주어진 폼(form)의 maxlength 체크
//@return : none
//-----------------------------------------------------------------------------
function validateByteLength(form) {
	var fields = $("input.byteLength", form);
	 
	var str;
	var max;
	var hanMax;	 

	 for (var i = 0; i < fields.length; i++) {
		//utf-8 에서는 보통 한글은 3byte
		 var o = fields[i];
		if ( $(o).attr("maxlength") > 0 ) {
			str = $(o).val();
			max = $(o).attr("maxlength");
			hanMax = parseInt(max/3);
			
			if( str.isByteLength(0, max) == false ) {
				alert("최대 " + max + "자(한글 : "+ hanMax +") 까지 입력 가능합니다.\n[필드명: " + $(o).attr("title") + "]");
				$(o).focus();
				return false;						
			}
		}
	 }

	 return true;
}

//-----------------------------------------------------------------------------
//숫자만 입력되도록 체크
//@return : none
//-----------------------------------------------------------------------------
function digitOnly(that){
    if(that.value != "" & !that.value.isNumeric()){
        alert("숫자만 입력가능합니다.");
        that.value = that.value.replace(/[^0-9]/g, "");
        return false;
    }
    return true;
}
function digitOnly1(e){
	if(e.keyCode==8){
		return false;
	}
}

//-----------------------------------------------------------------------------
//숫자 소수점 만 입력되도록 체크
//@return : none
//-----------------------------------------------------------------------------
function decimalPointOnly(that){
  if(that.value != "" & !that.value.isNumeric(".")){
      alert("숫자, 소수점만 입력가능합니다.");
      that.value = that.value.replace(/[^0-9.]/g, "");
      return false;
  }
  return true;
}

//-----------------------------------------------------------------------------
//숫자 소수점 음수만  입력되도록 체크
//@return : none
//-----------------------------------------------------------------------------
function negativePointOnly(that){
	  if(that.value != "" & !that.value.isNegativeNumeric(".")){
        alert("숫자, 소수점, (-)만 입력가능합니다.");
        that.value = that.value.replace(/[^0-9.-]/g, "");
        return false;
    }
    return true;
}

//-----------------------------------------------------------------------------
//숫자와 -만 허용 - arguments[0] : 추가 허용할 문자들
//@return : boolean
//-----------------------------------------------------------------------------

String.prototype.isNegativeNumeric = function() {
 return (/^[0-9-]+$/).test(this.remove(arguments[0])) ? true : false;
};

//-----------------------------------------------------------------------------
//지정한 url로 이동 
//@param : url 이동할 주소 
//-----------------------------------------------------------------------------
function fnGoUrl(url){
    location.href = url;
}

//-----------------------------------------------------------------------------
//배너 이동 함수
//@param : url 이동할 주소
//@param : nwdAt 새창여부
//-----------------------------------------------------------------------------
function fnBanner(url, nwdAt){

    if(nwdAt == 'Y') {
        var cw = screen.availWidth;     //화면 넓이
        var ch = screen.availHeight;    //화면 높이
        var sw = 800;    //띄울 창의 넓이
        var sh = 600;    //띄울 창의 높이
        var ml = (cw-sw)/2;        //가운데 띄우기위한 창의 x위치
        var mt = (ch-sh)/2;         //가운데 띄우기위한 창의 y위치

        var win = window.open(url ,'code',' scrollbars=yes, resizable=yes, status=yes, left='+ml+', top='+mt+', width='+sw+',height='+sh);
        if(win != null) {
            win.focus();
        }
    }else{
        location.href = url;
    }

}

//-----------------------------------------------------------------------------
// 쿠키생성
// @param : url 이동할 주소
//-----------------------------------------------------------------------------

function fnSetCookie(cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays*24*60*60*1000));
    var expires = "expires="+ d.toUTCString();
    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}

// function setCookie(cName, cValue, cDay){
//     var expire = new Date();
//     expire.setDate(expire.getDate() + cDay);
//     cookies = cName + '=' + escape(cValue) + '; path=/ '; // 한글 깨짐을 막기위해 escape(cValue)를 합니다.
//     if(typeof cDay != 'undefined') cookies += ';expires=' + expire.toGMTString() + ';';
//     document.cookie = cookies;
// }

//-----------------------------------------------------------------------------
// 쿠키가져오기
// @param : url 이동할 주소
//-----------------------------------------------------------------------------
function fnGetCookie(cName) {
    cName = cName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cName);
    var cValue = '';
    if(start != -1){
        start += cName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cValue = cookieData.substring(start, end);
    }
    return unescape(cValue);
}

//-----------------------------------------------------------------------------
//날짜 비교용
//
//-----------------------------------------------------------------------------
var dates = {
	    convert:function(d) {
	        // Converts the date in d to a date-object. The input can be:
	        //   a date object: returned without modification
	        //  an array      : Interpreted as [year,month,day]. NOTE: month is 0-11.
	        //   a number     : Interpreted as number of milliseconds
	        //                  since 1 Jan 1970 (a timestamp) 
	        //   a string     : Any format supported by the javascript engine, like
	        //                  "YYYY/MM/DD", "MM/DD/YYYY", "Jan 31 2009" etc.
	        //  an object     : Interpreted as an object with year, month and date
	        //                  attributes.  **NOTE** month is 0-11.
	        return (
	            d.constructor === Date ? d :
	            d.constructor === Array ? new Date(d[0],d[1],d[2]) :
	            d.constructor === Number ? new Date(d) :
	            d.constructor === String ? new Date(d) :
	            typeof d === "object" ? new Date(d.year,d.month,d.date) :
	            NaN
	        );
	    },
	    compare:function(a,b) {
	        // Compare two dates (could be of any type supported by the convert
	        // function above) and returns:
	        //  -1 : if a < b
	        //   0 : if a = b
	        //   1 : if a > b
	        // NaN : if a or b is an illegal date
	        // NOTE: The code inside isFinite does an assignment (=).
	        return (
	            isFinite(a=this.convert(a).valueOf()) &&
	            isFinite(b=this.convert(b).valueOf()) ?
	            (a>b)-(a<b) :
	            NaN
	        );
	    },
	    inRange:function(d,start,end) {
	        // Checks if date in d is between dates in start and end.
	        // Returns a boolean or NaN:
	        //    true  : if d is between start and end (inclusive)
	        //    false : if d is before start or after end
	        //    NaN   : if one or more of the dates is illegal.
	        // NOTE: The code inside isFinite does an assignment (=).
	       return (
	            isFinite(d=this.convert(d).valueOf()) &&
	            isFinite(start=this.convert(start).valueOf()) &&
	            isFinite(end=this.convert(end).valueOf()) ?
	            start <= d && d <= end :
	            NaN
	        );
	    }
	}

