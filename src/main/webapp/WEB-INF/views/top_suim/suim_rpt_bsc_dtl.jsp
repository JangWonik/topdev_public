<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>보고서 상세</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css?v=201705231112" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js?v=201706141814"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/jquery/jquery.mask.min.js"></script>

	<%--spiner start--%>
    <script src="/resources/jquery/spin.js"></script>
    <script src="/resources/jquery/jquery.spin.js"></script>
    <%--spiner end --%>

	<script src="./resources/ne_js/calendar.js"></script>
	<%--<script src="./resources/daum/161109.js"></script>--%>
	<script src="./resources/daum/postcode.v2.js"></script>
	<script src='https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js'></script>
	
	
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>

    <script src="./resources/cmm/js/common.js?v=201707311012"></script>
    
    <style type="text/css">
		.buttonAssistance{
			width:50px;
			height:23px;
		    background-color:#2E7EE8;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		    }
		
		.buttonAssistanceEmail{
			width:60px;
			height:23px;
		    background-color:darkCyan;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		    }
		    
		 .buttonAssistanceDocu{
			width:60px;
			height:23px;
		    background-color:#9900CC;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		    }
		.buttonMini{
				width:100px;
				height:18px;
			    background-color:#D8F6CE;
			    color:#666;
			    text-align: center;
				border-radius:5px;
			    font-size: 11px;
			    cursor: pointer;
			    text-decoration:none;
			    border: solid 1px grey;		    
			}
	</style>
	
	<c:set var="mbrVo" value="${mbrVo_Session}"></c:set>	
 
	<script>
		$(document).ready(function(){
			
			//날짜입력 패턴 추가 시작
			var options = {
				onKeyPress : function(cep, event, currentField, options){
				
			    var tid = event.currentTarget.id;
			    var tidx = tid.substr(tid.length - 1, 1);
			    
				},
				reverse : true
		    };		    
		    
		    $('input.hasDatepicker').mask('0000-00-00',options);		    
		  	//날짜입력 패턴 추가 끝
			
			if('${authFlag}' == 'logout'){
				alert("로그아웃 상태입니다. 재로그인 하십시오.");
				window.close();
				window.opener.location.assign("./logout");
			}

			if(('${suimVO.editYN}' <= 0)){
				alert("열람권한이 없습니다.");
				window.close();
				return false;
			}

			$("#rptAprvUserNo").select2();
			
			//보험사 공지사항 스크립트 시작
			if(parseInt("${suimVO.ptnr_notice_yn}") > 0){
				var p_suimRptType1 = ${suimVO.suim_rpt_type1};
				var p_ptnrId = ${suimVO.ptnr_id};
				
				//공지팝업 호출
				if( getCookieTodayInsuNoti() ){				//오늘하루 열지 않기 했는지 확인(보고서기준)
					doShowInsuNoti( p_suimRptType1, p_ptnrId );	
				}								
			}						
			//보험사 공지사항 스크립트 끝
			
			/*
			if(parseInt("${suimVO.ptnr_notice_yn}") > 0){
				var cw=screen.availWidth;
				var ch=screen.availHeight;
				var sw=500; //띄울 창의 넓이
				var sh=550;  //띄울 창의 높이
				var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
				var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
				window.open('suimPtnrNoticePop?type=${suimVO.suim_rpt_type1}&id=${suimVO.ptnr_id}','SuimPtnrNoticePop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			}	
			*/

			$("#suimTmMbrPopBtn").click(function(){//담당 팀, 담당 직원 바꾸기 팝업
				var cw=screen.availWidth;
				var ch=screen.availHeight;
				var sw=650; //띄울 창의 넓이
				var sh=550;  //띄울 창의 높이
				var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
				var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
				window.open('suimTmMbrPop?gbNo='+$("#gbNoForPop").val()+'&smNo='+$("#smNoForPop").val()+'&tmNo='+$("#tmNoForPop").val(),'SuimTmMbrPop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			});//$("#suimTmMbrPopBtn").click

			$("#onestopTmMbrPopBtn").click(function(){//원스탑 현장 조사 담당자 직원 바꾸기 팝업, 171228 lds
				var cw=screen.availWidth;
				var ch=screen.availHeight;
				var sw=500; //띄울 창의 넓이
				var sh=550;  //띄울 창의 높이
				var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
				var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
				window.open('suimTmMbrPop?gbNo=5&smNo='+$("#smNoForPop").val()+'&tmNo='+$("#tmNoForPop").val(),'SuimTmMbrPop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			});//$("#suimTmMbrPopBtn").click
			
			
			$("#suimPtnrMbrPopBtn").click(function(){//보험사, 보험사 직원 바꾸기 팝업
				var cw=screen.availWidth;
				var ch=screen.availHeight;
				var sw=750; //띄울 창의 넓이
				var sh=550;  //띄울 창의 높이
				var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
				var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
				window.open('suimPtnrMbrPop?gbNo='+$("#gbNoForPop").val()+'&smNo='+$("#smNoForPop").val()+'&ptnrNo='+$("#ptnrNoForPop").val()+'&ptnrDeptNo='+$("#suimRptPtnrDeptTm").val(),'SuimTmMbrPop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			});//$("#suimPtnrMbrPopBtn").click
			
			$("#printRptDoc").click(function(){
				var cw=screen.availWidth;
				var ch=screen.availHeight;
				var sw=1010; //띄울 창의 넓이
				var sh=740;  //띄울 창의 높이
				var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
				var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
				window.open('printRptDoc?suim_rpt_no='+$("#suimRptNo").val(),'_blank','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			});

			/* 보고서 기본정보의 처리 담당자 변경 동작 호출 */
			$("#rptUserNoChangeBtn").click(function(){
				
				$.post("./suimRptUserNoEdite",
						{	
					 		topTeamId  	:$("#suimRptTopTm").val() 
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("불러오기를 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									$("#rptUserNoChange").css("display","inline");
									$("#rptUserNoChangeBtn").css("display","none");
									$("#rptUserName").css("display","none");
									
									$("#rptUserNoChange").html("");
									
									$.each(data, function(index, entry) {
										$("#rptUserNoChange").append(
											"<option value='"+entry.user_no+"'>"+entry.user_name+"</option>"	
										);
									});
									
									$("#rptUserNoChange").val($("#rptUserNameHidden").val());
									$("#changeRptTopUserOkBtn").css("display","inline");
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						},"json"
				);//post	
			});

			/* 보고서 기본정보의 처리 담당자 변경 */ 
			$("#changeRptTopUserOkBtn").click(function(){
				
				$.post("./suimRptUserNoEditeOk",
						{	
					 		 topUserNo  	:$("#rptUserNoChange").val()
					 		,suimRptNo   	:$("#suimRptNo").val()  //
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("저장 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									
									$("#rptUserNoChange").css("display","none");
									$("#rptUserNoChangeBtn").css("display","inline");
									$("#rptUserName").css("display","inline");
									
									$("#rptUserName").html($("#rptUserNoChange option:selected").html());
									
									$("#changeRptTopUserOkBtn").css("display","none");
									$("#rptUserNameHidden").val($("#rptUserNoChange option:selected").val());
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			});

			/* 보고서 기본정보의 보험사 담당자 변경 동작 호출 */ 
			$("#rptPtnrMbrChangeBtn").click(function(){
				$.post("./suimRptPtnrDeptMbrNoEdite",
						{	
					 		ptnrDeptId  :$("#suimRptPtnrDeptTm").val() 
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("불러오기를 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									$("#rptPtnrNoChange").css("display","inline");
									$("#rptPtnrMbrChangeBtn").css("display","none");
									$("#rptPtnrName").css("display","none");
									
									$("#rptPtnrNoChange").html("");
									
									$.each(data, function(index, entry) {
										$("#rptPtnrNoChange").append(
											"<option value='"+entry.user_no+"'>"+entry.user_name+"</option>"	
										);
									});
									
									$("#rptPtnrNoChange").val($("#rptPtnrNameHidden").val());
									$("#changeRptTopPtnrOkBtn").css("display","inline");
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						},"json"
				);//post	
			});

			/* 보고서 기본정보의 보험사 담당자 변경 */ 
			$("#changeRptTopPtnrOkBtn").click(function(){
				
				$.post("./suimRptPtnrMbrNoEditeOk",
						{	
					 		 ptnrUserNo  	:$("#rptPtnrNoChange").val()
					 		,suimRptNo   	:$("#suimRptNo").val()  //
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("저장 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									
									$("#rptPtnrNoChange").css("display","none");
									$("#rptPtnrMbrChangeBtn").css("display","inline");
									$("#rptPtnrName").css("display","inline");
									
									$("#rptPtnrName").html($("#rptPtnrNoChange option:selected").html());
									
									$("#changeRptTopPtnrOkBtn").css("display","none");
									$("#rptPtnrNameHidden").val($("#rptPtnrNoChange option:selected").val());
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			});

			//4종 수임건 결재자 정보 수정
			$("#rptAprvUdt").click(function(){
				var r = confirm("결재자를 수정하시겠습니까?");
				if (r == false){
					return false;
				}
				$.post("./setSuim4rptAprvUser",
					  { 
						 suimRptNo : $("#suimRptNo").val()
						,rptAprvUserNo : $("#rptAprvUserNo").val()
					  },
					  function (data,status){
						  if (data == 1 && status == 'success'){
							alert("해당 직원을 결재자로 설정하였습니다.")							  
						  }
					  }
				);
			});
			
			//alert('test='+localStorage.getItem('activeTab'))
			
			//새로고침 후에도 탭메뉴를 유지하기위한 수정 시작 by oniku
			
			$("#rptBase").click(function(){				
				localStorage.setItem('activeTab','1');				
				$(".guestcnt6").css("display","");
				$(".guestcnt7_1").css("display","none");
				$(".guestcnt8_1").css("display","none");
				$(".guestcnt9").css("display","none");
				$(".guestcnt10").css("display","none");
				//20200115 첨부파일 갯수를 다시 체크해서 가져온다. 첨부파일 체크 후 종결시 해제 by top3009
				//chkIssueFile();
				//다른탭에서 변경된 값을 새로가져온다.
				location.reload();
			});
			
			$("#rptResultSend").click(function(){				
				localStorage.setItem('activeTab','2');
				$(".guestcnt6").css("display","none");	
				$(".guestcnt7_1").css("display","");
				$(".guestcnt8_1").css("display","none");				
				$(".guestcnt9").css("display","none");	
				$(".guestcnt10").css("display","none");
			});
			
			$("#logResult").click(function(){				
				localStorage.setItem('activeTab','3');
				$(".guestcnt6").css("display","none");
				$(".guestcnt7_1").css("display","none");				
				$(".guestcnt8_1").css("display","");
				$(".guestcnt9").css("display","none");
				$(".guestcnt10").css("display","none");
			});
			
			//보고서 작성 탭 추가.
			$("#rptWrite").click(function(){				
				localStorage.setItem('activeTab','4');
				$(".guestcnt6").css("display","none");
				$(".guestcnt7_1").css("display","none");				
				$(".guestcnt8_1").css("display","none");
				$(".guestcnt9").css("display","");
				$(".guestcnt10").css("display","none");
				location.reload();
			});
			
			//메리츠 중간 보고서 작성 탭 추가. by top3009
			$("#rptMidWrite").click(function(){				
				localStorage.setItem('activeTab','5');
				$(".guestcnt6").css("display","none");
				$(".guestcnt7_1").css("display","none");				
				$(".guestcnt8_1").css("display","none");
				$(".guestcnt9").css("display","none");
				$(".guestcnt10").css("display","");
			});
			
			var sTab = localStorage.getItem('activeTab');			
			
			if( sTab == '2' ){									//3번째 탭 선택
				$("#rptResultSend").addClass('on');
				$(".guestcnt7_1").css("display","");
				$(".guestcnt6").css("display","none");
				$(".guestcnt8_1").css("display","none");
				$(".guestcnt9").css("display","none");	
				$(".guestcnt10").css("display","none");
			}else if(sTab == '3' ){							//4번째 탭 선택
				$("#logResult").addClass('on');
				$(".guestcnt7_1").css("display","none");
				$(".guestcnt6").css("display","none");
				$(".guestcnt8_1").css("display","");
				$(".guestcnt9").css("display","none");
				$(".guestcnt10").css("display","none");
			}else if(sTab == '4'){							//기본 2번째 탭 선택				
				$("#rptWrite").addClass('on');
				$(".guestcnt7_1").css("display","none");
				$(".guestcnt6").css("display","none");
				$(".guestcnt8_1").css("display","none");
				$(".guestcnt9").css("display","");
				$(".guestcnt10").css("display","none");
			}else if(sTab == '5'){						//2번째탭 (메리츠 중간보고서 추가 보고서 전으로 탭추가)
				$("#rptMidWrite").addClass('on');
				$(".guestcnt7_1").css("display","none");
				$(".guestcnt6").css("display","none");
				$(".guestcnt8_1").css("display","none");
				$(".guestcnt9").css("display","none");
				$(".guestcnt10").css("display","");
			}else{												//기본 1번째 탭
				$("#rptBase").addClass('on');
				$(".guestcnt7_1").css("display","none");
				$(".guestcnt6").css("display","");
				$(".guestcnt8_1").css("display","none");
				$(".guestcnt9").css("display","none");
				$(".guestcnt10").css("display","none");
			}
			
			//종결구분으로 소송건이면 손해사정서 탭메뉴가 보이지 않음
			var suimRptType1Close12 = $("#suimRptType1Close12Val").val();			
			
			//특정 팀과 특정 보험사는 손해사정서 탭메뉴가 보이지 않음
			var sTeam_id = $("#tmNoForPop").val();		//팀아이디			
			var sPassTeam = [ '87','26','42','46','47','49','50','53','59','67','68','82','83','84','85','135','136','137','138','210','215','216','217','218','219','220','221','222','1850','1860','1870','1880','1900','119','123','65','134','223','18100','18200','29','61','80','124','18000','22114','220216' ];
			
			var sPtnr_id = $("#ptnrNoForPop").val();			
			//var sPassPtnr = [ '9','10','18','29' ];					//보험사아이디 (삼성, 롯데, KB의 경우 제외)			
			//var sPassPtnr = [ '10','18','29' ];					//롯데인경우 해제 (롯데 : 9)
			//var sPassPtnr = [ '10','29' ];					//삼성인경우 해제 (삼성 : 18)			
			//var sPassPtnr = [ '10','29','18' ];				//삼성인경우 손해사정서 탭 제거 (삼성 : 18) 20250930
			//var sPassPtnr = [ '18' ];				//삼성만 제외하고 나머지는 포함 (삼성 : 18) 20251001
			var sPassPtnr = [ '18','50','51','45','48','26','30','33','25','34','36' ];		//한국사회복지공제회,어린이집안전공제회,방위산업공제,전문건설,전기공사공제조함,새마을,건설공제,교육시설,신협,수협 추가
			
			//alert('sPtnr_id='+sPtnr_id+" : sTeam_id="+sTeam_id);
			
			//sPasschk 가 '-1' 이면 포함안됨
			var sPassChk = $.inArray(sTeam_id,sPassTeam);
			var sPtnrChk = $.inArray(sPtnr_id,sPassPtnr);
			
			/* alert('sPtnrChk='+sPtnrChk);
			alert('sPassChk='+sPassChk); */

			//손해사정서 교부대상자 예외팀에 포함되어있지 않으면 체크 한다. 
			//종결구분이 소송건이면 예외팀과 동일하게 처리한다. 
			if( sPassChk != '-1' || sPtnrChk !='-1' || suimRptType1Close12 == '6' ){				
				$("#rptResultSend").hide();
			}
			
			//20200115 손해사정서 첨부파일 갯수를 가져와서 변수에 셋팅한다.
			//chkIssueFile();
						
		}); //document.ready
		
		function openSMS(hpNo){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=450; //띄울 창의 넓이
			var sh=533;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('simpleSMSForm?hpNo='+hpNo,'simpleSMS','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}//openSMS

		function openBrdRefPtnr(ptnrSearch){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1200; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('referencePtnrBoardListPop?ptnrSearch='+ptnrSearch,'simpleSMS','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=yes,scrollbars=no');
		}//openBrdRefPtnr

		function suimFldRptPop(suim_rpt_no){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1010; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('suimFldRptPop?suim_rpt_no='+suim_rpt_no,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}

		/* 세금계산서 발행 */
		function taxPop(rptInvNo){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=650; //띄울 창의 넓이
			var sh=500;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('taxInvDtlPop?rpt_invoice_no='+rptInvNo,'_blank','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}

		/* 기본정보 수정 페이지 이동 */
		function rptBscUdtPage(suim_rpt_no){			
			location.href = "suimRptBscUdtPage?rid="+suim_rpt_no;
		}
		/*기본정보 수정 페이지 이동 */

		/* 보고서 결재 동작 시작 */
		function action_report(action){	
			
			if(action == 'end19'){
				if(!confirm("AIA생명보험 종결을 진행하시겠습니까?")){
					return;
				}
				
				if( ("${topEndSetupVo.closeRptYn1}" == 1 )){
					alert("보고서가 종결 금지 상태입니다. 시스템 관리자에게 문의하세요.");
					return;						
				}
				
			}else if(action =='end') {
				if(!confirm("종결 하시겠습니까? \n종결 전 종결 내용 및 인보이스 정보를 다시 한번 확인해 주십시오.")){
					return;
				}	
				
				if( (('${suimVO.suim_rpt_type1}' == 3) || ('${suimVO.suim_rpt_type1}' == 4))){
					if( ("${topEndSetupVo.closeRptYn4}" == 1 )){
						alert("인보험 보고서가 종결 금지 상태입니다. 시스템 관리자에게 문의하세요.");
						return;						
					}
				}else{
					if( ("${topEndSetupVo.closeRptYn1}" == 1 )){
						alert("보고서가 종결 금지 상태입니다. 시스템 관리자에게 문의하세요.");
						return;						
					}
				}
				
			}else if(action =='returnRpt'){
				if(!confirm("반려 하시겠습니까?")){
					return;
				}
			}else if(action =='return_x'){
				if(!confirm("반려건을 재결재 하시겠습니까?")){
					return;
				}
			}else if(action =='submit_x'){
				if(!confirm("상신 취소 하시겠습니까?")){
					return;
				}
			}else if(action =='submit'){
				if(!confirm("상신 하시겠습니까?\n상신 전 보고서 종결 내용 및 인보이스 정보를 다시 한번 확인해 주십시오.")){
					return;
				}
			}else if(action == 'submit_e_x'){
				if(!confirm("종결 취소하시겠습니까?")){
					return;
				}
			}else if(action == 'report_supp'){
				if(!confirm("보완 요청 하시겠습니까?")){
					return;
				}
			}else if(action == 'report_supp_ok'){
				if(!confirm("보완 완료 하시겠습니까?")){
					return;
				}
			}else if(action == 'report_del'){
				if(!confirm("보고서를 삭제 하시겠습니까?")){
					return;
				}
			}else if(action == 'cancel_x'){
				if(!confirm("위임 취소를 취소 하시겠습니까?")){
					return;
				}
			}else if(action == 'cancel'){
				if(!confirm("위임 취소 하시겠습니까?")){
					return;
				}
			}
			
			/* 종결일 경우 유효성 검사 */
			if( (action == 'end') || (action == 'end19') ){
				
				if ( $("#rptPtnrNameHidden").val() == 0 ){
					alert("보험사 담당자가 없습니다.");
					return;
				}
				
				//인보험 (삭감)
				if( 
					(('${suimVO.suim_rpt_type1}' == 3) || ('${suimVO.suim_rpt_type1}' == 4)) && 
					(($("#suimRptType1Close").val() =='2') || ($("#suimRptType1Close").val() =='5') || ($("#suimRptType1Close").val() =='8')) &&
					(parseInt(uncomma($("#amtEstimatedDamage").val())) <= parseInt(uncomma($("#amtReduction").val())))
				){ //if
					alert("절감액이 청구금액보다 크거나 같습니다.");
					return;
					
				}else if(
				//인보험 (면책)
					(('${suimVO.suim_rpt_type1}' == 3) || ('${suimVO.suim_rpt_type1}' == 4)) && 
					(($("#suimRptType1Close").val() =='3') || ($("#suimRptType1Close").val() =='6') || ($("#suimRptType1Close").val() =='9')) &&
					(uncomma($("#amtClaimed").val()) != uncomma($("#amtReduction").val()))	
				){ //if
					alert("청구금액과 절감액이 다름니다.");
					return;
				
				}else if(
				//인보험 (청구액)
					(('${suimVO.suim_rpt_type1}' == 3) || ('${suimVO.suim_rpt_type1}' == 4)) && 
					(parseInt(uncomma($("#amtClaimed").val())) < 1)	
				){ //if
					//alert("청구금액이 없습니다.");//4종은 청구금액을 사용하지 않음. 2016.12.27.
					//return;	
					
				}else if(
				//배상 종결일 때 필수 항목 체크
					(('${suimVO.suim_rpt_type1}' == 1) || ('${suimVO.suim_rpt_type1}' == 2)) && 
					(parseInt(uncomma( $("#amtEstimatedDamage").val())) < 1)	
				){ //if
					alert("손해액이 없습니다.");
					return;	
					
				}else if(
				//전체 종결일 사고번호 체크
					$("#accidentNoForEnd").html() == ''	
				){ //if
					alert("사고번호가 없습니다.");
					return;		
					
				}else if(
				//전체 종결일 증권번호 체크
					$("#policyNoForEnd").html() == ''	
				){ //if
					alert("증권번호가 없습니다.");
					return;	
					
					
				}else if ( ('${suimVO.suim_rpt_type1}' == 14 || '${suimVO.suim_rpt_type1}' == 18 || '${suimVO.suim_rpt_type1}' == 19 ) && $("#suimRptType1Close12 option:selected").val() == 0 ){//서면심사일 경우, 종결구분 체크
					alert("종결 구분을 확인하세요.");
					return;
					
				}else if ( ('${suimVO.suim_rpt_type1}' == 14 || '${suimVO.suim_rpt_type1}' == 18 || '${suimVO.suim_rpt_type1}' == 19 ) && "${suimVO.getPolicyholder_nm()}" == "" ){//서면심사일 경우, 계약자 명 체크
					alert("계약자명이 없습니다.");
					return;
					
				}
				
				// 종결구분으로 소송건이면 손해사정서 첨부제외처리
				var suimRptType1Close12 = $("#suimRptType1Close12Val").val();
								
				// 종결의 경우 손해사정서 교부의 교부동의서 첨부확인 시작 by top3009
				var sTeam_id = $("#tmNoForPop").val();		//팀아이디
				
				//손해사정서 교부대상자 예외 팀 아이디 목록 (테스트팀 id : 126)
				var sPassTeam = [ '87','26','42','46','47','49','50','53','59','67','68','82','83','84','85','135','136','137','138','210','215','216','217','218','219','220','221','222','1850','1860','1870','1880','1900','119','123','65','134','223','18100','18200','29','61','80','124','18000','22114','220216' ];
								
				var sPtnr_id = $("#ptnrNoForPop").val();				
				//var sPassPtnr = [ '18' ];					//삼성인경우 해제 (삼성 : 18)
				var sPassPtnr = [ '18','50','51','45','48','26','30','33','25','34','36' ];		//한국사회복지공제회,어린이집안전공제회,방위산업공제,전문건설,전기공사공제조함,새마을,건설공제,교육시설,신협,수협 추가				
				
				//sPasschk 가 '-1' 이면 포함안됨
				var sPassChk = $.inArray(sTeam_id,sPassTeam);
				var sPtnrChk = $.inArray(sPtnr_id,sPassPtnr);				
				
				//손해사정서 교부대상자 예외팀에 포함되어있지 않으면 체크 한다.
				if( sPassChk == '-1' && sPtnrChk == '-1' && suimRptType1Close12 != '6' ){
					
					if( ${sendListCnt} == 0 ){
						alert('손해사정서 교부 대상자 등록이 필요합니다.');
						return;
					}				
					//alert("cnt="+$("#reportIssueAttachCnt").val());					
					//손해사정서 동의 첨부파일 갯수를 체크한다.					
					//if( $("#reportIssueAttachCnt").val() == 0 ){
						//alert("손해사정서 교부 탭의 교부동의서를 첨부해야 종결처리가 가능합니다.");
						//return;
					//}					
				}				
				// 종결의 경우 손해사정서 교부의 교부동의서 첨부확인 끝 by top3009
				
				/* 종결일 경우 유효성 검사 끝 */
			
			}else if(action == 'submit'){
					
				if ( $("#rptPtnrNameHidden").val() == 0 ){
					alert("보험사 담당자가 없습니다.");
					return;
				}
				
				//종결구분으로 소송건이면 교부대상자 등록을 체크한다.
				var suimRptType1Close12 = $("#suimRptType1Close12Val").val();
				
				// team_id 값에 따라서 손해사정서 교부대상자 등록여부를 체크시작. by top3009
				var sTeam_id = $("#tmNoForPop").val();		//팀아이디
				
				//손해사정서 교부대상자 예외 팀 아이디 목록 (테스트팀 id : 126)
				var sPassTeam = [ '87','26','42','46','47','49','50','53','59','67','68','82','83','84','85','135','136','137','138','210','215','216','217','218','219','220','221','222','1850','1860','1870','1880','1900','119','123','65','134','223','18100','18200','29','61','80','124','18000','22114','220216' ];
								
				var sPtnr_id = $("#ptnrNoForPop").val();			
				//var sPassPtnr = [ '9','10','18','29' ];					//보험사아이디 (삼성, 롯데, KB의 경우 제외)			
				//var sPassPtnr = [ '10','18','29' ];					//롯데인경우 해제 (롯데 : 9)
				//var sPassPtnr = [ '10','29' ];					//삼성인경우 해제 (삼성 : 18)
				//var sPassPtnr = [ '10','29','18' ];				//삼성인경우 손해사정서 탭 제거 (삼성 : 18) 20250930
				//var sPassPtnr = [ '18' ];				//삼성만 제외하고 나머지는 포함 (삼성 : 18) 20251001
				var sPassPtnr = [ '18','50','51','45','48','26','30','33','25','34','36' ];		//한국사회복지공제회,어린이집안전공제회,방위산업공제,전문건설,전기공사공제조함,새마을,건설공제,교육시설,신협,수협 추가
				
				//sPasschk 가 '-1' 이면 포함안됨
				var sPassChk = $.inArray(sTeam_id,sPassTeam);
				var sPtnrChk = $.inArray(sPtnr_id,sPassPtnr);
				
				//손해사정서 교부대상자 예외팀에 포함되어있지 않으면 체크 한다.
				if( sPassChk == '-1' && sPtnrChk == '-1' && suimRptType1Close12 != '6' ){
					
					if( ${sendListCnt} == 0 ){
						alert('손해사정서 교부 대상자 등록이 필요합니다.');					
						return;						
					}
					// 3. 손해액 및 보험금 사정에 크게 영향을 미친사항 // by top3009					
					//if( sPtnr_id != '41'){				//ABL 생명보고서가 아닌경우만 체크한다.
					
					/**
					if( '${suimVO.suim_rpt_type1}' == 3 || '${suimVO.suim_rpt_type1}' == 4 ){
						//인보험 보고서	
					}else{									
						
						//ABL, 삼성, 롯데, 흥국, AIA, AXA 예외처리 
						if( sPtnr_id != '9' && sPtnr_id != '16' && sPtnr_id != '17' && sPtnr_id != '18' && sPtnr_id != '19' && sPtnr_id != '41' && sPtnr_id != '23' ){				//ABL 생명보고서가 아니거나 4종 보고서가 아닌경우만 체크한다.
							
							var lawSubjectVal = $("#law_subject_text").text();
							var lawEtcTextVal = $("#law_etc_text").text();
							var reparationLiabilityTypeVal = $("#reparationLiabilityType").val();
							
							/* 손해사정서 체크제거 20251001
							if( lawSubjectVal == '' ){
								alert("손해사정서 교부 > 3. 손해사정 시 적용된 관계 법규 및 약관의 관련법규를 입력해주세요.");
								return;
							}
							
							if( lawEtcTextVal == '' ){
								alert("손해사정서 교부 > 3. 손해사정 시 적용된 관계 법규 및 약관의 관련약관을 입력해주세요.");
								return;
							}
														
							if( reparationLiabilityTypeVal == 0 || reparationLiabilityTypeVal == '' ){
								alert("손해사정서 교부 > 4. 약관상 보험자 지급책임의 범위의 지급책임여부를 선택해주세요.");
								return;
							}
							*/
							
							/*	여기 확인해서 수정해야함.
							if( $("#reparationLiabilityType").val() < 1 ){
								alert("손해사정서 교부의 3번 항목을 입력해 주세요. ");
								return;	
							}
													
						}	
					}
					*/					
				}
				// team_id 값에 따라서 손해사정서 교부대상자 등록여부를 체크 끝. by top3009
				
				//서면심사가 아닌경우만 체크한다.				
				if( ('${suimVO.suim_rpt_type1}' != 14 && '${suimVO.suim_rpt_type1}' != 18 && '${suimVO.suim_rpt_type1}' != 19 ) ){
					
					if($("#moralFlagForSubmit").val() == 0){
						alert("CheckList의 보험사기를 확인해주세요!");
						return;
					}
						
					/* 추정손해액 유무 확인 */
					if((parseInt(uncomma( $("#amtEstimatedDamage").val())) < 1) ){
						alert("추정 손해액이 없습니다.");
						return;				
					}
					
					/* 전체 종결일 사고번호 체크 */
					if($("#accidentNoForEnd").html() == ''){ //if
						alert("사고번호가 없습니다.");
						return;				
					}

					//170414, 강창묵 부장님 요청에 의해 종결구분 없음시 결재 진행 불가하게 변경
					if ("${suimVO.suimRptType1}" == 4 || "${suimVO.suimRptType1}" == 3){
						if ($("#suimRptType1Close34 option:selected").val() == 0){
							alert("종결 구분을 확인하세요.");
							return;
						}
					} 

					if ("${suimVO.suimRptType1}" != 3 && "${suimVO.suimRptType1}" != 4){
						if ($("#suimRptType1Close12 option:selected").val() == 0){
							alert("종결 구분을 확인하세요.");
							return;
						}
					}
					
					if( $("#suimRptEa").val() < 0 || $("#suimRptEa").val() == ''){
						alert('종결 건수를 확인하세요.');
						return;
					}
					
				}
				
				//현장조사보고서 상태가 결재완료인지 상태확인 (조건 : suim_rpt_type1 : 1,2,11,12,13 // pendncyTrgetAt : 1, 4)
				if( '${suimVO.suim_rpt_type1}' == 1 || '${suimVO.suim_rpt_type1}' == 2 || '${suimVO.suim_rpt_type1}' == 11 || '${suimVO.suim_rpt_type1}' == 12 || '${suimVO.suim_rpt_type1}' == 13 ){
					if( ${suimVO.pendncyTrgetAt} == 1 || ${suimVO.pendncyTrgetAt} == 4 ){
						if( ${suimVO.site_rpt_state < 2} ){
							alert('3-1. 현장보고서 결재완료 후 보고서 결재요청이 가능합니다.');
							return;
						}
					}
				}
				
			}else if( action == 'site_submit' ){			//현장보고서 결재 올리기
				//첨부파일이 있는 현장보고서 존재유무 확인
				var site_cnt = $("#siteCnt").val();
				if( site_cnt == 0 ){
					alert("현장조사보고서를 등록해주세요. \n(보고서 파일업로드가 필요합니다.) ")
					return;
				}
			}else if( action == 'site_submit_x' ){			//현장보고서 결재요청 취소
				if(!confirm("현장조사보고서 상신을 취소하시겠습니까?")){
					return;
				}
			}else if( action == 'site_end' ){				//현장보고서 결재완료
				
				//var confirm_site_cnt = $("#siteCnt").val();
				if(!confirm("현장조사보고서를 결재하시겠습니까?")){
					return;
				}
				
			}else if( action == 'site_e_x' ){
				if(!confirm("현장조사보고서 결재를 취소하시겠습니까?")){
					return;
				}
			}
//2016.12.29 end
			

			$.post("./actionReportOk",
					{	
						 action  		:action
				 		,suimRptNo   	:$("#suimRptNo").val()  //
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("저장 실패하였습니다. 관리자에게 문의해 주세요.");
							}else if(data == 2){
								alert("미완료 협조건이 존재합니다. 협조건 완료 후 다시 시도해주세요.");
							}else if(data == 3){
								alert("협조건이 있으나 공동조사자 정보가 없습니다. \n 공동 조사자 추가 후 다시 시도해주세요.");
							}else if(data == 4){
								alert("결재상신 건수를 넘었습니다. \n\n 매월 1일~15일 사이에는 하루 5건이상 결재상신이 안됩니다. \n\n 단, 수임일이 1주일 미경과건은 갯수제한에서 제외됩니다.");
							}else if(data == 5){
								alert("한화손해는 10일 이내에 중간보고서가 제출 되어야 결재상신이 가능합니다.");
							}else if(data == 6){
								alert("흥국손해는 10일 이내에 중간보고서가 제출 되어야 결재상신이 가능합니다.");
							}else if(data == 7){
								alert("LIG는 15일 이내에 중간보고서가 제출 되어야 결재상신이 가능합니다.");
							}else if(data == 8){
								alert("결재자 정보가 없습니다. 관리자에게 문의하세요.");
							}else if(data == 9){								
								//alert("종결 파일이 없습니다.\n- '종결' 혹은 '손사' 단어를 포함한 파일명으로 올려주십시오.");
								alert("종결 파일이 없습니다.\n- 종결보고서 파일을 올려주십시오.");
							}else if(data == 10){		//보고서 상태여부 실시간 확인로직 추가 (20250403 결재버그 수정)
								alert("보고서가 종결상태입니다.\n보고서 상태 확인 후 다시 시도해주세요.");
								location.reload();
							}else{
								if(action == 'end19'){
									alert("정상처리 되었습니다.\n AIA생명보험 담당자의 종결이 남았습니다.");
								}else if(action =='end') {
									alert("종결하였습니다.");									
								}else if(action =='returnRpt'){
									alert("반려 하였습니다.");
								}else if(action =='return_x'){
									alert("반려건을 재결재 올렸습니다.");
								}else if(action =='submit_x'){
									alert("상신 취소 하였습니다.");
								}else if(action =='report_supp'){
									alert("보완 요청 하였습니다.");
								}else if(action =='report_supp_ok'){
									alert("보완 완료 하였습니다.");
								}else if(action =='report_del'){
									alert("보고서를 삭제 하였습니다.");
									window.opener.location.reload();
									window.close();
								}else if(action =='un_lock'){
									alert("보고서를 잠금을 해제 하였습니다.");
								}else if(action =='site_submit'){
									alert("현장조사보고서를 상신하였습니다.");
								}else if(action == 'site_submit_x'){
									alert("현장조사보고서 상신을 취소하였습니다.");
								}else if(action == 'site_end'){
									alert("현장조사보고서를 결재하였습니다.");
								}else if(action == 'site_e_x'){
									alert("현장조사보고서 결재를 취소하였습니다.");								
								}
								
								location.reload();								
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}
			);//post
		}
		/* 보고서 결재 동작 끝 */
		
		
		//손해사정서 동의 첨부파일 갯수 셋팅
		function chkIssueFile(){
			
			var url = "./reportIssueChkAttachFile";					
			
			var param = {};
			param.suim_rpt_no = $("#suimRptNo").val(); 

            $.ajax({
                type: "POST",
                url: url,
                data: param,
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                dataType: "html",
                async: false,
                timeout: 20000,
                success: function(data){                	
                	$("#reportIssueAttachCnt").val(data);                	
                }                
            });
		}

        function fnPopUpMMS(suimRptNo, type){
            var cw=screen.availWidth;
            var ch=screen.availHeight;
            var sw=480; //띄울 창의 넓이
            var sh=650;  //띄울 창의 높이
            var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
            var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
            window.open('/suim_mms_write?suim_rpt_no='+suimRptNo+'&type='+type,'simpleMMS','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
        }
        
        function showTemplate(){        	
        	$("#template-action-dialog").dialog({
				height: 600,
				width: 750,
				closeOnEscape : true,
				draggable : true,				
				title: "보험사 문서서식 다운로드",
				buttons:{					
					"닫기" : function(){
						$(this).dialog("close");
					}
				},
				modal: true,
				overlay:{ opacity: 0., background: '#000000'}
			});
        }
        
      	//서식다운로드
		function fnTemplateDown(p_tkey){			
			$('#filedownForm [name="tkey"]').val(p_tkey);
			$('#filedownForm').submit();			
		}
      	
		//보험사 공지사항
		function doShowInsuNoti( p_type, p_id ){			
			
			var url = "./suimPtnrNoticePopAjax";
			
			var param = {};
			param.type = p_type;
			param.id = p_id;
			
			$.ajax({
				type: "POST",
				url: url,
				data: param,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				timeout: 20000,
				dataType: "HTML", 
				success: function(data){			
					$("#popup-insu-notice").html();
					$("#popup-insu-notice").html(data);					
						$("#popup-insu-notice").dialog({
							height: 700,
							width: 600,
							closeOnEscape : true,
							draggable : true,
							title: "보험사공지사항",					
							modal: true,												
							buttons:{
								"오늘하루열지않기" : function(){
									setCookieTodayInsuNoti();									
									$(this).dialog("close");
									
								},
								"닫기" : function(){
									$(this).dialog("close");
								}
							},
							overlay:{ opacity: 0., background: '#000000'}
						});		
				},
				error: function(e){
				    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
				}
			});
			
		}
		
		//보험사 공지 하루동안 열지않기 쿠기생성
		function setCookieTodayInsuNoti(){			
			var name = "insuNotiPop_"+${suimVO.ptnr_id};				//보험사 기준으로 변경
			var value = "done";
			var expiredays = 1;
			var todayDate = new Date();
		    todayDate.setDate( todayDate.getDate() + expiredays );
		    document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"		    
		}
		
		//보험사 공지 쿠키 가져오기
		function getCookieTodayInsuNoti() {
		    var cookiedata = document.cookie;		    
		    var cookieName = "insuNotiPop_"+${suimVO.ptnr_id};				//보험사 기준으로 변경
		    if ( cookiedata.indexOf(cookieName+"=done") < 0 ){	    	
				return true; 		//팝업을 표시한다.
		    }else {	    	
				return false;		//팝업을 표시하지 않는다. (하루열지 않기)
		    }
		}
		
		//손해사정서 모바일 발송내용 모달창으로 보이기
		function showMobileContent( p_serial_no ){
			
			var url = "./suimIssueMobilePopAjax";
			
			var param = {};
			param.serial_no = p_serial_no;
			
			$.ajax({
				type: "POST",
				url: url,
				data: param,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				timeout: 20000,
				dataType: "HTML", 
				success: function(data){			
					$("#popup-issue-mobile").html();
					$("#popup-issue-mobile").html(data);					
						$("#popup-issue-mobile").dialog({
							height: 800,
							width: 600,
							closeOnEscape : true,
							draggable : true,
							title: "손해사정서 발송내용",					
							modal: true,												
							buttons:{								
								"닫기" : function(){
									$(this).dialog("close");
								}
							},
							overlay:{ opacity: 0., background: '#000000'}
						});		
				},
				error: function(e){
				    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
				}
			});			
		}
		
		//손해사정서 이메일 발송내용 모달창으로 보이기
		function showEmailContent( p_serial_no ){
			
			var url = "./suimIssueEmailPopAjax";
			
			var param = {};
			param.serial_no = p_serial_no;
			
			$.ajax({
				type: "POST",
				url: url,
				data: param,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				timeout: 20000,
				dataType: "HTML", 
				success: function(data){
					$("#popup-issue-email").html();
					$("#popup-issue-email").html(data);					
						$("#popup-issue-email").dialog({
							height: 900,
							width: 850,
							closeOnEscape : true,
							draggable : true,
							title: "손해사정서 발송내용",					
							modal: true,												
							buttons:{								
								"닫기" : function(){
									$(this).dialog("close");
								}
							},
							overlay:{ opacity: 0., background: '#000000'}
						});		
				},
				error: function(e){
				    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
				}
			});
			
		}		
	</script>
</head>

<body>
	<input type="hidden" name="gbNoForPop" id="gbNoForPop" value="1" />
	<input type="hidden" name="ptnrNoForPop" id="ptnrNoForPop" value="${suimVO.ptnr_id}" />
	<input type="hidden" name="smNoForPop" id="smNoForPop" value="${suimVO.suim_rpt_no}" />
	<input type="hidden" name="tmNoForPop" id="tmNoForPop" value="${suimVO.team_id}" />
	
	<!-- 종결구분값 추가 -->
	<input type="hidden" name="suimRptType1Close12Val" id="suimRptType1Close12Val" value="${suimVO.suimRptType1Close12}" />
	
	<!-- 롯데 단순보고서 지연일수 계산용 -->
	<input type="hidden" id='suimRptState' value="${suimVO.suimRptState}"/>
	<input type="hidden" id="regDate" value="${suimVO.reg_date}" />
	<input type="hidden" id="closeDate" value="${suimVO.closeDate}" />
	<input type="hidden" id="ptnrName" value="${suimVO.ptnr_name}" />
	
	<input type="hidden" id='suimRptType' value="${suimVO.suim_rpt_type1}"/>
	<input type="hidden" id='minwonFlag' value="${suimVO.minwonFlag}"/>
	<input type="hidden" id='moralFlag' value="${suimVO.moralFlag}"/>
	
	<!-- 손해사정동의첨부파일 체크 -->
	<input type="hidden" id="reportIssueAttachCnt" value="0"/>
	
	
	<!-- header --><!--2016.01.14.rjh.수정.교체.-->
	<div id="headerpop_mbr">
		<div class="inner clear_v2">
			<h1>
				<img src="./resources/wm_img/common/logo.gif" height="40" alt="top - TRUST OBLIGATION PASSION" />
			</h1>
			<div style="text-align:center;padding-top:10px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
				<font color="white"><b><span style="font-size:11pt;"> 수임건 정보</span></b></font>
			</div>
		</div>
	</div>
	<!-- //header -->

	<!-- center -->
	<div id ="container">
		<div class="contetnsPop">
			<div class="center_cnt">
				<div class="centercnt_bot1_5">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<!-- <li class="on" id="rptBase"><a href="#">보고서 기본정보</a></li> -->
								<li id="rptBase"><a href="#">보고서 기본정보</a></li>
								
								<%-- 메리츠 중간보고서 추가 by top3009 --%>
								<c:if test="${middle_report_16 eq 1}">
									<li id="rptMidWrite"><a href="#" >중간 보고서 작성</a></li>
								</c:if>
								
								<c:if test="${suimVO.suim_rpt_type1 eq 3 or  suimVO.suim_rpt_type1 eq 4}">
									<li id="rptWrite"><a href="#" >보고서 작성</a></li>
								</c:if>
								
 								<li id="rptResultSend"><a href="#" >손해사정서 교부</a></li> 
								
																
								<c:if test="${mbrVo_Session.user_no != null && ( mbrVo_Session.user_state == 9 || mbrVo_Session.user_no == '215' || mbrVo_Session.user_no == '1265')}">
									<li id="logResult"><a href="#">Todo : 로그 열람</a></li>
								</c:if>
							</ul>
						</div>

						<div class="guestcnt6">
							
							<div class= "tableStyle6">
								<input type="hidden" id = "suimRptNo" value= "${suimVO.suim_rpt_no}"/>
								<input type="hidden" id = "suimRptTopTm" value= "${suimVO.team_id}"/>
								<input type="hidden" id = "suimRptPtnrDeptTm" value= "${suimVO.ptnr_dept_id}"/>
								<input type="hidden" id = "moralFlagForSubmit" value= "${suimVO.moralFlag}"/>
								
								<table align="center" style = "margin-top:10px;" >
								
									<colgroup>
										<col width="20%">
										<col width="30%">
										<col width="20%">
										<col width="30%">
									</colgroup>
                                    <tr>
                                    	<c:choose>
                                    		<c:when test="${empty suimVO.ptnr_url and empty suimVO.ptnr_homepage}">
                                    			<td colspan="4" height="30" style="background-color: #e7f5ff"><span style="font-size: 20px;"><b>1. 보고서 기본정보</b></span></td>		
                                    		</c:when>
                                    		<c:otherwise>
                                    			<td colspan="2" height="30" style="background-color: #e7f5ff"><span style="font-size: 20px;"><b>1. 보고서 기본정보</b></span></td>
		                                        <td colspan="2" height="30" style="background-color: #e7f5ff;text-align:right;padding-right:5px;">
		                                        	<a href="javascript:doShowInsuNoti(${suimVO.suim_rpt_type1},${suimVO.ptnr_id});"><input type="button" value="공지사항" class="buttonAssistanceDocu" title="보험사공지" style="background-color:#FFA500;"></a>
		                                        	<!-- 보험사 양식 시작 -->
		                                        	<c:if test="${templateList.size() > 0}">
		                                        		<a href="javascript:showTemplate();"><input type="button" value="문서서식" class="buttonAssistanceDocu" title="서식다운로드"></a>
		                                        	</c:if>
		                                        	<!-- 보험사 양식 끝 -->		                                        	
		                                        	<c:if test="${!empty suimVO.ptnr_url}">
		                                        		<a href="${suimVO.ptnr_url}" target="_blank"><input type="button" value="PRM" class="buttonAssistance" title="PRM 링크연결"></a>
		                                        	</c:if>
		                                        	<c:if test="${!empty suimVO.ptnr_homepage}">
		                                        		<a href="${suimVO.ptnr_homepage}" target="_blank"><input type="button" value="홈페이지" class="buttonAssistanceEmail"  title="홈페이지 링크연결"></a>
		                                        	</c:if>
		                                        </td>
                                    		</c:otherwise>
                                    	</c:choose>     
                                    </tr>
									<tr>
										<td align="left" style="border-right:0px;">
										<!-- 보고서 상태 값 변경 관리 시작 -->										
											<c:choose>
												<c:when test="${suimVO.suimRptState eq '2' or suimVO.suimRptState eq '3'}">
													<c:if test="${suimVO.lockFlag eq 1}">
														<c:choose>															
															<c:when test="${mbrAuthVo_Session.mbr_pms_5 eq '1'}">
															
																<!-- 종결 후 바로 lock 이 걸리도록 수정되어 15일 조건 해제후 적용 버튼 20241008 -->
																<c:if test="${suimVO.suimRptState eq '2'}">
																	<img src="./resources/ls_img/report/icon_lock.gif" onclick="action_report('un_lock');" style="cursor:pointer;"/>
																</c:if>																
																<!-- 위임 취소 후 바로 lock 이 걸리도록 수정되어 15일 조건 해제후 적용 버튼 20241008 -->
																<c:if test="${suimVO.suimRptState eq '3'}">
																	<img src="./resources/ls_img/report/icon_lock.gif" onclick="action_report('un_lock');" style="cursor:pointer;"/>
																</c:if>
																<c:if test="${suimVO.suimRptState eq '4'}">
																	<img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;"/>
																</c:if>
															
																<!-- 종결 후 15일 이 지난 건 락 해제 버튼 -->
																<%-- <c:if test="${suimVO.suimRptState eq '2' and is15DaysOutClose eq true }">
																	<img src="./resources/ls_img/report/icon_lock.gif" onclick="action_report('un_lock');" style="cursor:pointer;"/>
																</c:if>
																<c:if test="${suimVO.suimRptState eq '2' and is15DaysOutClose eq false }">
																	<img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;"/>
																</c:if>
																<!-- 위임 취소 후 15일 이 지난 건 락 해제 버튼 -->
																<c:if test="${suimVO.suimRptState eq '3' and is15DaysOutCancel eq true}">
																	<img src="./resources/ls_img/report/icon_lock.gif" onclick="action_report('un_lock');" style="cursor:pointer;"/>
																</c:if>
																<c:if test="${suimVO.suimRptState eq '4' and is15DaysOutCancel eq false}">
																	<img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;"/>
																</c:if> --%>
															</c:when>
															<c:otherwise>
																<!-- 전산 권한 : 보고서 잠금 해제 없으면 -->
																<img src="./resources/ls_img/report/icon_lock.gif"/>
															</c:otherwise>
														</c:choose>
													</c:if>
													<c:if test="${suimVO.lockFlag eq 0}">
														<img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;"/>				
													</c:if>
												</c:when>
												<c:otherwise>
													<img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;"/>											
												</c:otherwise>
											</c:choose>
											
											<%-- Todo : 세금계산서 발행
											if($ig[tax_invoice]=='1' && $inv[tax_no]){?> <a href="../ls_tax/p_tax.php?iid=<?=$inv[iid]?>" 
											onclick="NewPopUp(this.href,'Invoice_Tax','700','500','yes','center');return false" 
											onfocus='this.blur()'><img src="img/btn_tax.gif" width="100" height="18" border="0"></a><?}?> --%>
											
											<!-- 아래 현대해상 주석 부분 운영 상 버그 같아 보임 : 조건이 항상 false -->
											<!-- //4종 현대해상 락 해재 시작
											$unlock_ig_id_14=mktime(0,0,0,6,1,2014);
											$unlock_ig_id_14_now=Time();
											//if($ig[ig_id]=='14' && $unlock_ig_id_14>$unlock_ig_id_14_now){
											if($ig[ig_id]=='14' && ($row[report_type]=='3' or $row[report_type]=='4') && $unlock_ig_id_14>$unlock_ig_id_14_now){
													$lock_check_a="<img src='../ls_report/img/dotte.gif' border=0>";
													$lock_check='';
											}
											//4종 현대해상 락 해재 끝 -->
											
											<b> 보고서 기본 정보 </b>
										</td>
										
										
										
										<td align="right" colspan="3" style="border-left:0px;padding-right: 5px;">
											<c:choose>
												<c:when test="${suimVO.delDate < 0 }">
													<font color="red"><b>※ 삭제된 보고서 입니다.</b></font>
												</c:when>
												
												<c:when test="${suimVO.suimRptState eq '31'}">
													<!-- 위임취소 프로세스 추가 170801 -->
													<c:choose>    
														<c:when test="${suimVO.closeAuthYN eq '1' or mbrVo.user_no eq suimVO.user_no}">
															<c:if test="${suimVO.rptCancelApprovalAuthYN eq '1'}">
															<%-- 종결권한에서 위임취소 결재권한으로 별도 분리 by top3009 (20240725) --%>
															<%-- <c:if test="${suimVO.closeAuthYN eq '1'}"> --%>
																<img src="./resources/ne_img/btn/btn_aprv_cancel.gif" onclick="fnRptCancelApproval();" style="cursor:pointer;"/>
															</c:if>
															<img src="./resources/ne_img/btn/btn_mod_cancel.gif" onclick="fnRptCancelMod();" style="cursor:pointer;"/>
															<img src="./resources/ne_img/btn/btn_reqcancel_cancel.gif" onclick="fnRptCancelDel();" style="cursor:pointer;"/>
														</c:when>
														
														<c:otherwise>
															<img src="./resources/ne_img/btn/btn_ing_cancel.gif" style="cursor:pointer; margin-top:3px;"/>
														</c:otherwise>
													</c:choose>
												</c:when>
												
												<c:otherwise>
													<c:if test="${suimVO.editYN > 0}">
														<!-- 결재하기 -->
														<c:if test="${suimVO.suimRptState eq '0'}"> <!-- $_a_work5_w -->
															<!-- 스피드는 바로 종결 170719 by lds -->
															<%-- <c:choose>
																<c:when test="${suimVO.suimRptType1 eq '14'}">
																	<img src="./resources/ls_img/report/btn_rch_2.gif" border=0 onclick="action_report('end');" style="cursor:pointer;"/>
																</c:when>
																<c:otherwise>
																	<img src="./resources/ls_img/report/btn_rch_1.gif" onclick="action_report('submit');" style="cursor:pointer;"/>
																</c:otherwise>
															</c:choose> --%>
															<img src="./resources/ls_img/report/btn_rch_1.gif" onclick="action_report('submit');" style="cursor:pointer;"/>
														</c:if>
														<!-- 결재취소하기 -->
														<c:if test="${suimVO.suimRptState eq '1'}"> <!-- $_a_work6_w -->
															<img src="./resources/ls_img/report/btn_rch_1x.gif" onclick="action_report('submit_x');" style="cursor:pointer;"/>
														</c:if>
														<!-- 반려건인지 확인 -->
														<c:if test="${suimVO.suimRptState eq '11'}"> 
															<img src="./resources/ls_img/report/btn_rch_return_x.gif" onclick="action_report('return_x');" style="cursor:pointer;"/>												
															<img src="./resources/ls_img/report/btn_rch_1x.gif" onclick="action_report('submit_x');" style="cursor:pointer;"/>
														</c:if>																										
													</c:if>

													<!-- 종결하기 -->
													<c:if test="${suimVO.suimRptState eq '1'}"> <!-- 건상태가 진행중이면 -->
														<c:if test="${suimVO.ptnr_id eq '19' and suimVO.suimRptAprvUserNo eq mbrVo.user_no }"> <!-- AIA보험사이면 --> <!-- ($member[user_id]=='top0906' or $member[user_id]=='top3126' or $member[user_id]=='top0034' or $member[user_id]=='top1858' or $member[user_id]=='top0259' or $member[user_id]=='top3990' or $member[no]=='1') -->
															<img src="./resources/ls_img/report/btn_rch_return.gif" onclick="action_report('returnRpt');" style="cursor:pointer;"/>
															<img src="./resources/ls_img/report/btn_rch_19_2.gif" onclick="action_report('end19');" style="cursor:pointer;"/>
															<!-- <a href='../ls_report/pop_end.php?rid=$row[rid]&action_mode=edite' onclick=\"NewPopUp(this.href,'Pop_end','530','510','yes','center');return false\" onfocus='this.blur()'><img src="./resources/ls_img/report/btn_rch_19_2.gif" border=0></a> -->
														</c:if>
														<c:if test="${suimVO.ptnr_id ne '19' and suimVO.closeAuthYN eq '1'}">
															<img src="./resources/ls_img/report/btn_rch_return.gif" border=0 onclick="action_report('returnRpt');" style="cursor:pointer;"/>
															<img src="./resources/ls_img/report/btn_rch_2.gif" border=0 onclick="action_report('end');" style="cursor:pointer;"/>
														</c:if>
													</c:if>
													
													<!-- 종결취소하기 -->
													<c:if test="${suimVO.suimRptState eq '2' and mbrAuthVo_Session.mbr_pms_4 eq '1'}">
														<img src="./resources/ls_img/report/btn_rch_2x.gif" border=0 onclick="action_report('submit_e_x');" style="cursor:pointer;"/>
													</c:if>	
													
													<!-- 보고서 보완요청 : AIA -->
													<c:if test="${ suimVO.ptnr_id eq '19' and suimVO.suimRptState eq '2' and mbrVo.user_no eq suimVO.user_no and suimVO.ptnrMbrSanction eq '1'}"> <!-- $row[supplement_check]<1 -->
													<!-- $member[no]=='1' or $member[user_id]=='top0034' or $member[user_id]=='top1858' or $member[user_id]=='top0259' or $member[user_id]=='top3126' or $member[user_id]=='top3990' or $member[user_id]=='top0906' -->
														<img src="./resources/ls_img/report/btn_rch_supp.gif" border=0 onclick="action_report('report_supp');" style="cursor:pointer;"/>											
													</c:if>
													
													<!-- 보고서 보완완료 : AIA -->
													<c:if test="${ suimVO.ptnr_id eq '19' and suimVO.suimRptState eq '2' and mbrVo.user_no eq suimVO.user_no and suimVO.ptnrMbrSanction eq '2'}"> <!-- $row[supplement_check]>0 -->
													<!-- $member[no]=='1' or $member[user_id]=='top0034' or $member[user_id]=='top1858' or $member[user_id]=='top0259' or $member[user_id]=='top3126' or $member[user_id]=='top3990' or $member[user_id]=='top0906' -->
														<img src="./resources/ls_img/report/btn_rch_supp_ok.gif" border=0 onclick="action_report('report_supp_ok');" style="cursor:pointer;"/>
													</c:if>
													
													<!-- 위임취소하기 -->
													<!-- 위임취소 프로세스 개발 - 1종만 적용 -> 전체적용 170810 -->
													<c:if test="${suimVO.editYN > 0 or mbrVo.user_no eq suimVO.user_no}">
														<c:choose>
															<c:when test="${suimVO.suimRptState eq '0' or suimVO.suimRptState eq '1'}">
																<img src="./resources/ls_img/report/btn_rch_3.gif" border=0 onclick="fnRptCancelIns();" style="cursor:pointer;"/>
															</c:when>
															<%-- <c:when test="${suimVO.suimRptState eq '2' and suimVO.team_id eq '7'}"> --%>
															<c:when test="${suimVO.suimRptState eq '2' and (suimVO.team_id eq '7' or suimVO.team_id eq '20240516')}">
																<!-- 종결 시, 재경팀만 가능하게 변경 180108 -->
																<!-- 재경팀이 재경팀, 재경관리파트로 나뉘어 코드 추가 240522 -->
																<img src="./resources/ls_img/report/btn_rch_3.gif" border=0 onclick="fnRptCancelIns();" style="cursor:pointer;"/>
															</c:when>																													
														</c:choose>
													</c:if>
														
														
														<!-- 
														<c:choose>
															<c:when test="${suimVO.suim_rpt_type1 eq '3' or suimVO.suim_rpt_type1 eq '4'}">
																<img src="./resources/ls_img/report/btn_rch_3.gif" border=0 onclick="action_report('cancel')" style="cursor:pointer;"/>	
															</c:when>
															<c:otherwise>
																<img src="./resources/ls_img/report/btn_rch_3.gif" border=0 onclick="fnRptCancelIns();" style="cursor:pointer;"/>
															</c:otherwise>
														</c:choose>
														 -->
													
													<!-- 위임취소하기를 취소하기 -->
													<!-- 위임취소 프로세스 개발 - 1종만 적용 -> 전체적용 170810 -->
													<!-- 170321, mbrVo.team_id_main eq suimVO.team_id 제외 -->
													<c:if test="${suimVO.suimRptState eq '3' and mbrAuthVo_Session.mbr_pms_4 eq '1'}">
														<img src="./resources/ls_img/report/btn_rch_3x.gif" border=0 onclick="fnRptCancelRestore();" style="cursor:pointer;"/>
														<!-- 
														<c:choose>
															<c:when test="${suimVO.suim_rpt_type1 eq '3' or suimVO.suim_rpt_type1 eq '4'}">
																<img src="./resources/ls_img/report/btn_rch_3x.gif" border=0 onclick="action_report('cancel_x');" style="cursor:pointer;"/>
															</c:when>
															<c:otherwise>
																<img src="./resources/ls_img/report/btn_rch_3x.gif" border=0 onclick="fnRptCancelRestore();" style="cursor:pointer;"/>
															</c:otherwise>
														</c:choose>
														 -->
													</c:if>
													
													<!-- 보고서 삭제하기 -->
													<c:if test="${suimVO.suimRptState ne '2' and mbrAuthVo_Session.mbr_pms_3 eq '1' and mbrVo.team_id_main eq suimVO.team_id }">
														<img src="./resources/ls_img/report/btn_report_del.gif" border=0 onclick="action_report('report_del');" style="cursor:pointer;"/>
													</c:if>
													
													<!-- 세금계산서 발행 -->
													<c:if test="${mbrVo.team_id_main eq suimVO.team_id and suimInvVO.taxNo ne null and suimInvVO.taxNo ne '' and suimVO.issueTaxInvoice eq 1}">
														<img src="./resources/ls_img/report/btn_tax.gif" border=0 onclick="taxPop('${suimInvVO.rptInvNo}');" style="cursor:pointer;"/>
													</c:if>
												</c:otherwise>
											</c:choose>
											
												
										</td>
										<!-- 보고서 상태 값 변경 관리 끝 -->
									</tr>
									<tr>
										<td bgcolor="#E7ECF1"><b>ㆍ접수번호</b></td>
										<td colspan="3">
											<c:out value="${suimVO.getSuim_accept_no()}"/>
											<img id = "printRptDoc" style = "cursor:pointer;" src="./resources/ls_img/icon_print_info.gif"/>
											<c:if test="${suimVO.suimRptState eq '0' or suimVO.suimRptState eq '11'}">
												<c:if test="${suimVO.editYN > 0}">
													<img style = "cursor:pointer; float:right; margin-right:5px;" src="./resources/ls_img/btn_edite.gif" onclick="rptBscUdtPage('${suimVO.suim_rpt_no}');"/>																						
												</c:if>
											</c:if>
											
											<!-- 종결 후 수정 -->
											<c:if test="${ endModFlag > 0 && suimVO.suimRptState eq '2'}">
<%-- 											<c:if test="${ (mbrAuthVo_Session.mbr_pms_1 eq '1' or endModFlag > 0) && suimVO.suimRptState eq '2'}"> --%>
												<img style = "cursor:pointer; float:right; margin-right:5px;" src="./resources/ne_img/btn/btn_end_mod.jpg" onclick="rptBscUdtPage('${suimVO.suim_rpt_no}');"/>
											</c:if>
											<!-- 종결 후 수정 -->
										</td>
									</tr>
									
								<c:if test="${suimVO.suim_rpt_type1 eq '3' or suimVO.suim_rpt_type1 eq '4'}">
									<tr>
										<td bgcolor="#E7ECF1"><b>ㆍ보고서양식</b></td>
										<td colspan="3">
										<c:choose>
											<c:when test="${suimVO.suim_rpt_type2 eq '1'}">
												일반 보고서												
											</c:when>	
											<c:when test="${suimVO.suim_rpt_type2 eq '6'}">
												농협 보고서												
											</c:when>	
											<c:when test="${suimVO.suim_rpt_type2 eq '9'}">
												롯데 보고서												
											</c:when>	
											<c:when test="${suimVO.suim_rpt_type2 eq '16'}">
												메리츠 보고서												
											</c:when>	
											<c:when test="${suimVO.suim_rpt_type2 eq '17'}">
												흥국화재 보고서												
											</c:when>	
											<c:when test="${suimVO.suim_rpt_type2 eq '1700'}">
												흥국화재 의료비 보고서												
											</c:when>
											<c:when test="${suimVO.suim_rpt_type2 eq '1001'}">
												단순 보고서											
											</c:when>	
											<c:when test="${suimVO.suim_rpt_type2 eq '3001'}">
												건설공제 보고서											
											</c:when>												
										</c:choose>
										</td>
									</tr>
								</c:if>
								
									<tr>
										<c:choose>
											<c:when test="${suimVO.registrant != 0}">
												<td bgcolor="#E7ECF1"><b>ㆍ현재상태</b></td>
												<td>${suimVO.suimRptStateVal}</td>
												<td bgcolor="#E7ECF1"><b>ㆍ수임 등록자</b></td>
												<td>${suimVO.registrant_nm}</td>
											</c:when>
											<c:otherwise>
												<td bgcolor="#E7ECF1"><b>ㆍ현재상태</b></td>
												<td colspan="3">${suimVO.suimRptStateVal}</td>
											</c:otherwise>
										</c:choose>										
									</tr>
									
									<c:if test="${suimVO.suimRptState eq '31' or suimVO.suimRptState eq '3'}">
										<tr>
											<td bgcolor="#E7ECF1"><b>ㆍ위임취소 사유</b></td>
											<td colspan="3">
												<c:choose>
													<c:when test="${rptCancel.cancelGubun eq '1'}"><b>[단순위임취소]</b><br/></c:when>
													<c:when test="${rptCancel.cancelGubun eq '2'}"><b>[서면→일반전환건]</b><br/></c:when>
													<c:otherwise></c:otherwise>
												</c:choose>
												${fn:replace(fn:replace(fn:escapeXml(rptCancel.cancelReason) , CRLF , '<br>'), ' ', '&nbsp;')}
											</td>
										</tr>
									</c:if>
									
									<tr>
										<td bgcolor="#E7ECF1"><b>ㆍ필수업무프로세스 </b></td>
										<td colspan="3">
											<c:if test="${suimVO.pendncyTrgetAt eq '1'}">대상</c:if>
											<c:if test="${suimVO.pendncyTrgetAt eq '2'}">비대상</c:if>
											<c:if test="${suimVO.pendncyTrgetAt eq '3'}">과정관리</c:if>
											<c:if test="${suimVO.pendncyTrgetAt eq '4'}">현장+과정관리</c:if>
										</td>
									</tr>
									
									<c:if test="${suimVO.workloadType != 0 and suimVO.workloadType != null}">
										<tr>
											<td bgcolor="#E7ECF1" style="letter-spacing:-1px;"><b>ㆍ기준업무량 상세구분 </b></td>
											<td colspan="3">
												${suimVO.workloadTypeVal}
											</td>
										</tr>
										
										<tr>
											<td bgcolor="#E7ECF1" style="letter-spacing:-1px;"><b>ㆍ기준업무량 종결건수 </b></td>
											<td>
												${suimVO.workloadEa}
											</td>
											<td bgcolor="#E7ECF1" style="letter-spacing: -2px !important;"><b>ㆍ퇴사자(휴직자)<br/>&nbsp;&nbsp;&nbsp;미결 내첩여부 </b></td>
											<td>
							                    <c:if test="${suimVO.retirePendingFlag == 0}">해당 없음</c:if>
							                    <c:if test="${suimVO.retirePendingFlag == 1}">해당</c:if>
											</td>
										</tr>										
									</c:if>
									
									
									<tr>
										<td bgcolor="#E7ECF1"><b>ㆍ처리팀</b></td>
										<td>${suimVO.team_name}</td>
										<td bgcolor="#E7ECF1"><b>ㆍ처리 담당자</b></td>
										<td >											
											<%-- endModRptWriter (총무경리열람) 권한을 향후 종결보고서 작성인 변경 권한으로 수정해야함 --%>
											<c:choose>
												<c:when test="${suimVO.suimRptState eq '2'}">
													<c:if test="${endModRptWriter > 0}">
														<img src="./resources/ls_img/report/icon_change.gif" id="suimTmMbrPopBtn" style="cursor:pointer;" border="0" width="14" height="14">
													</c:if>
												</c:when>
												<c:otherwise>
													<c:if test="${suimVO.mbrChgYN == 1}">
														<img src="./resources/ls_img/report/icon_change.gif" id="suimTmMbrPopBtn" style="cursor:pointer;" border="0" width="14" height="14">
													</c:if>
												</c:otherwise>
											</c:choose>
											
<%-- 											<c:if test="${suimVO.mbrChgYN == 1 }"> --%>
<!-- 												<img src="./resources/ls_img/report/icon_change.gif" id="suimTmMbrPopBtn" style="cursor:pointer;" border="0" width="14" height="14"> -->
<%-- 											</c:if> --%>
											
											<c:if test="${suimVO.handphone != ''}">
												&nbsp;<img src="./resources/ls_img/report/icon_hp.gif" style="cursor:pointer;" onclick="openSMS('${suimVO.handphone}');" />
												${suimVO.handphone}
											</c:if>
<%-- 											<c:if test="${suimVO.suimRptState eq '0' and mbrVo.team_id_main eq suimVO.team_id}"> --%>
<!-- 													<img style= "cursor:pointer;" id = "rptUserNoChangeBtn" src="./resources/ls_img/btn_edit_s.gif"/> -->
<%-- 											</c:if> --%>
											<select id = "rptUserNoChange" style="display:none; ">
											</select>
											<c:if test="${suimVO.user_name ne ''}">
												<span id = "rptUserName" title="${suimVO.work_level_nm}">${suimVO.user_name}</span>
												<input type="hidden" id = "rptUserNameHidden" value = "${suimVO.user_no}"/>
											</c:if>
											<img id = "changeRptTopUserOkBtn" src="./resources/ls_img/btn_check_s.gif" title="담당자 변경" style="display:none; cursor:pointer;"/>
										</td>
									</tr>
									
									<c:if test="${suimVO.suim_rpt_type1 eq '14' and suimVO.speedOnestop eq '1'}">
										<tr>
											<td bgcolor="#E7ECF1"><b>ㆍ현장 조사 담당부서</b></td>
											<td>
												<c:choose>
													<c:when test="${suimVO.onestopTeamId == 0}">
														미지정
													</c:when>
													<c:otherwise>
														${suimVO.onestopTeamNm}
													</c:otherwise>
												</c:choose>
											</td>
											<td bgcolor="#E7ECF1"><b>ㆍ현장 조사 담당자</b></td>
											<td>
												<c:choose>
													<c:when test="${suimVO.suimRptState eq '2'}">
														<c:if test="${endModRptWriter > 0}">
															<img src="./resources/ls_img/report/icon_change.gif" id="onestopTmMbrPopBtn" style="cursor:pointer;" border="0" width="14" height="14">
														</c:if>
													</c:when>
													<c:otherwise>
														<c:if test="${suimVO.mbrChgYN == 1}">
															<img src="./resources/ls_img/report/icon_change.gif" id="onestopTmMbrPopBtn" style="cursor:pointer;" border="0" width="14" height="14">
														</c:if>
													</c:otherwise>
												</c:choose>
												
												<c:if test="${suimVO.onestopMbrHandphone != null and suimVO.onestopMbrHandphone != ''}">
													&nbsp;<img src="./resources/ls_img/report/icon_hp.gif" style="cursor:pointer;" onclick="openSMS('${suimVO.onestopMbrHandphone}');" />
													${suimVO.onestopMbrHandphone}
												</c:if>
												
												<c:choose>
													<c:when test="${suimVO.onestopMbrNo == 0}">
														담당자 미지정
													</c:when>
													<c:otherwise>
														<span id = "onestopName">${suimVO.onestopMbrNm}</span>
													</c:otherwise>
												</c:choose>
											</td>
										</tr>									
									</c:if>
									
									<tr>
										<td bgcolor="#E7ECF1"><b>ㆍ보험사</b></td>
										<td>
											<%-- <c:out value="${suimVO.getPtnr_id()}"/> --%>
											<%-- ${suimVO.ptnr_name}
											<a href="#"><img src="./resources/ls_img/icon_ig_pds.gif"/></a> --%>
											${suimVO.ptnr_name}
											<c:if test="${suimVO.ptnr_id != ''}">
												&nbsp;<img src="./resources/ls_img/report/icon_ig_pds.gif" style="cursor:pointer;" onclick="openBrdRefPtnr('${suimVO.ptnr_id}');" />
											</c:if>
										</td>
										<td bgcolor="#E7ECF1"><b>ㆍ보험사 담당자</b></td>
										<td>
											<!-- 종결 되면 일반 권한자는 수정불가능 but, 종결후수정 + 담당자변경권한 있을시 가능 -->
											<c:choose>
												<c:when test="${suimVO.suimRptState eq '2'}">
													<c:if test="${endModFlag > 0 && suimVO.ptnrMbrChgYN == 1}">
														<img src="./resources/ls_img/report/icon_change.gif" id="suimPtnrMbrPopBtn" style="cursor:pointer;" border="0" width="14" height="14">
													</c:if>
												</c:when>
												<c:otherwise>
													<c:if test="${suimVO.ptnrMbrChgYN == 1 || suimVO.user_no == mbrVo_Session.user_no}">
														<img src="./resources/ls_img/report/icon_change.gif" id="suimPtnrMbrPopBtn" style="cursor:pointer;" border="0" width="14" height="14">
													</c:if>
												</c:otherwise>
											</c:choose>
											
											<select id = "rptPtnrNoChange" style="display:none; ">
											</select>
											<c:if test="${suimVO.ptnr_mbr_nm ne ''}">
												<span id = "rptPtnrName">${suimVO.ptnr_mbr_nm}</span>												
												<input type="hidden" id = "rptPtnrNameHidden" value = "${suimVO.ptnr_mbr_no}"/>
											</c:if>
											<%-- 보험사 담당자 직위추가 시작 --%>
											<c:if test="${not empty suimVO.ptnr_mbr_position_nm}">
												${suimVO.ptnr_mbr_position_nm}
											</c:if>
											<%-- 보험사 담당자 직위추가 끝 --%>
											<img id = "changeRptTopPtnrOkBtn" src="./resources/ls_img/btn_check_s.gif" title="담당자 변경" style="display:none; cursor:pointer;"/>
											
											<c:if test="${not empty suimVO.ptnr_mbr_nm}">
												<br/>
											</c:if>
											
											<c:if test="${suimVO.ptnr_mbr_office_tel != ''}">
												&nbsp;<img src="./resources/ls_img/report/icon_hp.gif" style="cursor:pointer;" onclick="openSMS('${suimVO.ptnr_mbr_hp}');" />
												${suimVO.ptnr_mbr_office_tel}
											</c:if>
											
                                            <c:if test="${(suimVO.suim_rpt_type1 == 3 ||  suimVO.suim_rpt_type1 == 4) && suimVO.user_no == 1117}">
                                                <a href="#noloc" onclick="fnPopUpMMS('${suimVO.suim_rpt_no}','1')"><img src="/resources/ls_img/btn_sms_s.gif"></a>
                                            </c:if>											
										</td>
									</tr>
									<tr>
										<td bgcolor="#E7ECF1"><b>ㆍ보험사 담당부서</b></td>
										<td colspan="3">
											<!-- 종결된 경우는 종결시점저장된 보험사 부서팀명으로 표시 by top3009 -->											
											<c:choose>
												<c:when test="${suimVO.suimRptState eq 2}">
													${suimVO.close_ptnr_dept_nm}
													<c:if test="${suimVO.close_ptnr_tm2_nm ne ''}">(${suimVO.close_ptnr_tm2_nm})</c:if>
												</c:when>
												<c:otherwise>
													${suimVO.ptnr_dept_nm}													
													<c:if test="${suimVO.ptnr_tm2_nm ne '' and suimVO.ptnr_tm2_nm ne null}">
														(${suimVO.ptnr_tm2_nm})
													</c:if>
												</c:otherwise>
											</c:choose>
										</td>
									</tr>
									<!-- 4종 보험사 지정 및 상세구분 추가 180709 -->
									<c:if test="${suimVO.suim_rpt_type1 eq '3' or suimVO.suim_rpt_type1 eq '4'}">
										<tr>
											<td bgcolor="#E7ECF1"><b>ㆍ지정건 구분</b></td>
											<td>					
												<c:choose>
													<c:when test="${suimVO.ptnrAssignGubun eq '0'}">
														비지정
													</c:when>
													<c:when test="${suimVO.ptnrAssignGubun eq '1'}">
														지정
													</c:when>			
													<c:otherwise>
														-
													</c:otherwise>										
												</c:choose>
											</td>		
											
											<td bgcolor="#E7ECF1"><b>ㆍ보험사 상세 구분</b></td>
											<td>
												<c:choose>
													<c:when test="${suimVO.ptnrDetailGubun eq '1'}">
														원수사
													</c:when>
													<c:when test="${suimVO.ptnrDetailGubun eq '2'}">
														자회사
													</c:when>
													<c:when test="${suimVO.ptnrDetailGubun eq '3'}">
														외주사
													</c:when>			
													<c:otherwise>
														-
													</c:otherwise>										
												</c:choose>
											</td>
										</tr>
									</c:if>
									<!-- 인보험이 아닌경우만 표시한다. -->
									<c:if test="${suimVO.suim_rpt_type1 eq '11' or suimVO.suim_rpt_type1 eq '12' or suimVO.suim_rpt_type1 eq '13' or suimVO.suim_rpt_type1 eq '2'}">
										<tr>										
											<td bgcolor="#E7ECF1"><b>ㆍ부서상세 구분</b></td>
											<td>
												${suimVO.ptnr_id_sub_nm}
											</td>
											<td bgcolor="#E7ECF1"><b>ㆍ장기/일반 구분</b></td>
											<td>
												${suimVO.period_flag_nm}
											</td>
										</tr>
									</c:if>									
									<tr>
										<td bgcolor="#E7ECF1"><b>ㆍ사고번호</b></td>
										<td id = "accidentNoForEnd"><c:out value="${suimVO.getAccident_no()}"/></td>
										<td bgcolor="#E7ECF1"><b>ㆍ증권번호</b></td>
										<td id= "policyNoForEnd"><c:out value="${suimVO.getPolicy_no()}"/></td>
									</tr>
									<tr>
										<td bgcolor="#E7ECF1"><b>ㆍ보험종목</b></td>
										<td><c:out value="${suimVO.getInsurance_nm()}"/></td>
                                        <td bgcolor="#E7ECF1"><b>ㆍ보험기간</b></td>
                                        <td ><c:out value="${suimVO.insuTerm}"/></td>
									</tr>
                                    <tr>
                                        <td bgcolor="#E7ECF1"><b>ㆍ보상한도액</b></td>
                                        <td >
                                        	${suimVO.amtCompensationLimitUnit} 
                                        	<fmt:formatNumber value="${suimVO.amtCompensationLimit}" pattern="###,###,##0.##"/>
                                        	(${suimVO.compensationLimitFlag}) 
                                        	
                                       	</td>
                                        <td bgcolor="#E7ECF1"><b>ㆍ자기부담금</b></td>
                                        <td >
                                        	${suimVO.amtSelfPayUnit} 
                                        	<fmt:formatNumber value="${suimVO.amtSelfPay}" pattern="###,###,##0.##"/>
                                        	(${suimVO.selfPayFlag}) 
                                        	
                                       	</td>
                                    </tr>
                                    
                                    <tr>
                                        <td bgcolor="#E7ECF1"><b>ㆍ보험조건</b></td>
                                        <td colspan="3">${suimVO.insu_condition}</td>
									</tr>

									<tr>
										<c:choose>
											<c:when test="${suimVO.suim_rpt_type1 eq '14'}">
												<td bgcolor="#E7ECF1"><b>ㆍ처리구분</b></td>
												<td><%-- <c:out value="${suimVO.getReport_type()}"/> --%>
													${suimVO.suim_rpt_type1_nm}
													<c:if test="${suimVO.suim_rpt_type1 eq '14' and suimVO.speedOnestop eq '1'}">
														(OneStop)
													</c:if>
												</td>
												<td bgcolor="#E7ECF1"><b>ㆍ사고 유형</b></td>
												<td>
													${suimVO.speedTypeNm}
												</td>
											</c:when>
											<c:otherwise>
												<td bgcolor="#E7ECF1"><b>ㆍ처리구분</b></td>
												<td colspan="3"><%-- <c:out value="${suimVO.getReport_type()}"/> --%>
													${suimVO.suim_rpt_type1_nm}
												</td>											
											</c:otherwise>
										</c:choose>
									</tr>
									
									
									
									<tr>
										<td class="td" bgcolor="#E7ECF1"><b>ㆍ계약자</b></td>
										<td><c:out value="${suimVO.getPolicyholder_nm()}"/></td>
										<td bgcolor="#E7ECF1"><b>ㆍ연락처</b></td>
										<td>
                                            <c:out value="${suimVO.getPolicyholder_tel()}"/>
                                            
                                            <c:if test="${(suimVO.suim_rpt_type1 == 3 ||  suimVO.suim_rpt_type1 == 4) && suimVO.getPolicyholder_tel() != '' && mbrVo_Session.user_no == 1117}">
                                                <a href="#noloc" onclick="fnPopUpMMS('${suimVO.suim_rpt_no}','2')"><img src="/resources/ls_img/btn_sms_s.gif"></a>
                                            </c:if>                                            
                                            <%--
                                            <c:if test="${(suimVO.suim_rpt_type1 == 3 ||  suimVO.suim_rpt_type1 == 4) && suimVO.getPolicyholder_tel() != '' && suimVO.user_no == mbrVo_Session.user_no}">
                                                <a href="#noloc" onclick="fnPopUpMMS('${suimVO.suim_rpt_no}','2')"><img src="/resources/ls_img/btn_sms_s.gif"></a>
                                            </c:if>
                                             --%>
                                        </td>
									</tr>
<%--
									<tr>
										<td bgcolor="#E7ECF1"><b>ㆍ주민번호</b></td>
										<td><c:out value="${suimVO.getPolicyholder_ssn()}"/></td>
									</tr>
--%>
									<tr>
										<td class="td" bgcolor="#E7ECF1"><b>ㆍ피보험자</b></td>
										<td><c:out value="${suimVO.getBeneficiary_nm()}"/></td>
										<td bgcolor="#E7ECF1"><b>ㆍ연락처</b></td>
										<td>
                                            <c:out value="${suimVO.getBeneficiary_tel()}"/>
                                            
                                            <c:if test="${(suimVO.suim_rpt_type1 == 3 ||  suimVO.suim_rpt_type1 == 4) && suimVO.getPolicyholder_tel() != '' && mbrVo_Session.user_no == 1117}">
                                                <a href="#noloc" onclick="fnPopUpMMS('${suimVO.suim_rpt_no}','3')"><img src="/resources/ls_img/btn_sms_s.gif"></a>
                                            </c:if>                                             
<%--                                             <c:if test="${(suimVO.suim_rpt_type1 == 3 ||  suimVO.suim_rpt_type1 == 4) && suimVO.getBeneficiary_tel() != '' && suimVO.user_no == mbrVo_Session.user_no}"> --%>
<%--                                                 <a href="#noloc" onclick="fnPopUpMMS('${suimVO.suim_rpt_no}','3')"><img src="/resources/ls_img/btn_sms_s.gif"></a> --%>
<%--                                             </c:if> --%>
                                        </td>
									</tr>
<%--
									<tr>
										<td bgcolor="#E7ECF1"><b>ㆍ주민번호</b></td>
										<td><c:out value="${suimVO.getBeneficiary_ssn()}"/></td>
									</tr>
--%>
									<tr>
										<td bgcolor="#E7ECF1"><b>ㆍ피해자/물</b></td>
										<td><c:out value="${suimVO.getDamaged_nm()}"/></td>
										<td bgcolor="#E7ECF1"><b>ㆍ연락처</b></td>
										<td><c:out value="${suimVO.getDamaged_tel()}"/></td>
									</tr>
									<tr>
										<td bgcolor="#E7ECF1"><b>ㆍ사고일</b></td>
										<td>
										<%-- <c:out value="${suimVO.getAccident_date()}"/> --%>
										${suimVO.accident_date}
										</td>
										<td bgcolor="#E7ECF1"><b>ㆍ수임일</b></td>
										<td><c:out value="${suimVO.getReg_date()}"/></td>
									</tr>
									<%-- 일반건 전환일 시작 (보험사가 메리츠, 현대해상 인 경우만 보이도록 한다.)--%>
									<c:if test="${suimVO.ptnr_id eq 16 or suimVO.ptnr_id eq 14 }">
									<tr>
										<td bgcolor="#E7ECF1"><b>ㆍ일반전환일</b></td>
										<td colspan="3"><c:out value="${suimVO.getTrans_date()}"/></td>
									</tr>	
									</c:if>
									<%-- 일반건 전환일 끝 --%>
									<%--
                                    <tr>
										<td bgcolor="#E7ECF1"><b>ㆍ현장제출일</b></td>
										<td><c:out value=""/></td>
										<td bgcolor="#E7ECF1"><b>ㆍ중간제출일</b></td>
										<td><c:out value=""/></td>
									</tr>
									<tr>
										<td bgcolor="#E7ECF1"><b>ㆍ추정손해액</b></td>
										<td id="ed">
											<c:if test="${suimVO.getAmt_estimated_damage() != null && suimVO.getAmt_estimated_damage() ne '' && suimVO.getAmt_estimated_damage() ne '-'}">
												<fmt:formatNumber value="${suimVO.getAmt_estimated_damage()}" type="number"/> 원
											</c:if>
										</td>
										<td bgcolor="#E7ECF1"><b>ㆍ추정수수료</b></td>
										<td id="ce">
											<c:if test="${suimVO.getCommission_estimated() != null && suimVO.getCommission_estimated() ne'' && suimVO.getCommission_estimated() ne '-'}">
												<fmt:formatNumber value="${suimVO.getCommission_estimated()}" type="number"/> 원
											</c:if>
										</td>
									</tr>
									--%>
									<tr>
										<td bgcolor="#E7ECF1"><b>ㆍ사고장소</b></td>
										<td colspan="3">
										 ${suimVO.investigate_addr1} 
	
										 ${suimVO.investigate_addr2}
										 
										</td>
									</tr>
									<tr>
										<td bgcolor="#E7ECF1"><b>ㆍ사고내용</b></td>
										<td colspan="3"><c:out value="${suimVO.getAccident_facts()}"/></td>
									</tr>

								<!-- 결재자 수정은 4종건만 해당 -->	
								<c:if test="${suimVO.suim_rpt_type1 eq '3' or suimVO.suim_rpt_type1 eq '4'}">
									<tr>
										<td bgcolor="#E7ECF1"><b>ㆍ결재자</b></td>
										<td colspan="3">
											<select name="rptAprvUserNo" id="rptAprvUserNo" style="width:150px;">
												<c:if test="${suimVO.suimRptAprvUserNo ne '0'}">
													<option selected="selected" value="${suimVO.suimRptAprvUserNo}">${suimVO.suimRptAprvUserName}</option> 
												</c:if>
												<c:forEach items="${workMember}" var="workMemVO" varStatus="status">
													<c:if test="${suimVO.suimRptAprvUserNo ne workMemVO.user_no}">
														<option value="${workMemVO.user_no}">${workMemVO.user_name}</option>
													</c:if>													
												</c:forEach>
											</select>
											<img src="./resources/ls_img/report/icon_change.gif" id="rptAprvUdt" style="cursor:pointer;" border="0" width="14" height="14">
										</td>
										<%-- <td colspan="3">
											<select name="rptAprvUserNo" id="rptAprvUserNo" style="width:150px;">
												<c:if test="${suimVO.suimRptAprvUserNo ne '0'}">
													<option selected="selected" value="${suimVO.suimRptAprvUserNo}">${suimVO.suimRptAprvUserName}</option> 
												</c:if>
												<c:forEach items="${workMember}" var="workMemVO" varStatus="status">
													<c:if test="${suimVO.suimRptAprvUserNo ne workMemVO.user_no}">
														<option value="${workMemVO.user_no}">${workMemVO.user_name}</option>
													</c:if>													
												</c:forEach>
											</select>
											<img src="./resources/ls_img/report/icon_change.gif" id="rptAprvUdt" style="cursor:pointer;" border="0" width="14" height="14">
										</td> --%>
									</tr>
								</c:if>
									
								</table>

                                <%-- 진행관리 --%>
                                <c:import url="../top_suim/suim_rpt_bsc_progress.jsp"></c:import>

							    <c:if test="${authFlag eq 'success'}">
									<c:if test="${suimVO.suim_rpt_type1 eq 3 or  suimVO.suim_rpt_type1 eq 4}">
										<!-- 처리내용 확인사항 시작-->
										<c:import url="../top_suim/suim_rpt_task_chk.jsp"></c:import>
										<!-- 처리내용 확인사항 끝-->									
									</c:if>
									
									<!-- 처리내용 시작 -->
									<c:choose>
										<c:when test="${suimVO.suim_rpt_type1 eq 3 or  suimVO.suim_rpt_type1 eq 4}">
											<c:choose>
												<c:when test="${suimVO.suim_rpt_type2 eq 16}">
													<!-- 사고처리 과정표 : 인보험 16 시작-->
													<c:import url="../top_suim/suim_rpt_bsc_sago_16.jsp"></c:import>
													<!-- 사고처리 과정표 : 인보험 16 끝-->
												</c:when>
												<c:otherwise>
													<!-- 사고처리 과정표 시작-->
														<c:import url="../top_suim/suim_rpt_bsc_sago.jsp"></c:import>
													<!-- 사고처리 과정표 끝-->	
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:otherwise>
											<!-- 사고처리 과정표 시작-->
											<c:import url="../top_suim/suim_rpt_bsc_sago.jsp"></c:import>
											<!-- 사고처리 과정표 끝-->										
										</c:otherwise>
									</c:choose>
									<!-- 사고처리 끝-->

                                    <!-- 현재 진행 상황(미결사유) 시작-->
                                    <c:import url="../top_suim/suim_rpt_bsc_now.jsp"></c:import>
                                    <!-- 현재 진행 상황(미결사유) 끝-->

                                    <c:if test="${suimVO.suim_rpt_type1 ne 3 and suimVO.suim_rpt_type1 ne 4  }">
                                        <!-- 문제점 시작 -->
                                        <c:import url="../top_suim/suim_rpt_bsc_prob.jsp"></c:import>
                                        <!-- 문제점 끝 -->

                                        <!-- 향 후 처리방안 시작 -->
                                        <c:import url="../top_suim/suim_rpt_bsc_plan.jsp"></c:import>
                                        <!-- 향 후 처리방안 끝 -->
                                    </c:if>

                                    <!-- 나도 한마디 시작-->
                                    <c:import url="../top_suim/suim_rpt_bsc_memo.jsp"></c:import>
                                    <!-- 나도 한마디 끝-->

                                    <!-- 현장 조사 보고서 시작-->
									<c:import url="../top_suim/suim_rpt_bsc_site.jsp"></c:import>
									<!-- 현장 조사 보고서 끝-->
									
									<!-- 중간 손해 사정서 시작-->
									<c:import url="../top_suim/suim_rpt_bsc_interim.jsp"></c:import>
									<!-- 중간 손해 사정서 끝-->

									<!-- 진행경과보고서 시작-->
									<%--<c:import url="../top_suim/suim_rpt_bsc_progress_report.jsp"></c:import>--%>
									<!-- 진행경과보고서 끝-->

									<!-- 종결내용 시작-->
									<c:import url="../top_suim/suim_rpt_bsc_end.jsp"></c:import>
									<!-- 종결내용 끝-->
									
									<!-- 보고서 협조 시작-->
									<c:if test="${suimVO.suim_rpt_type1 == 3 || suimVO.suim_rpt_type1 == 4}">
                                        <c:import url="../top_suim/suim_rpt_bsc_help.jsp"></c:import>
                                    </c:if>
									<!-- 보고서 협조 끝-->

									<!-- 보고서 원본 파일-->
									<c:import url="../top_suim/suim_rpt_bsc_orgfile.jsp"></c:import>
									<!-- 보고서 원본 파일 끝-->
								</c:if>
								
								<!-- 위임취소 프로세스용 모달 -->
								<c:import url="../top_suim/suim_rpt_cancel_modal.jsp"></c:import>
								<!-- 위임취소 프로세스용 모달 끝-->
											
							</div>
						<br>
						
						<%-- <a style="cursor:pointer;" onclick="suimFldRptPop(<c:out value='${suimVO.getSuim_rpt_no()}'/>)">
						임시버튼 생성</a> --%>
						</div> <!-- guestcnt5 -->						
						<!-- 보고서 작성 4종의 경우-->
						<div class="guestcnt9">
							<c:if test="${suimVO.suim_rpt_type1 eq 3 or  suimVO.suim_rpt_type1 eq 4}">
							<!-- <div class="guestcnt9" style="display:none;"> -->
							
								<c:if test="${suimVO.suim_rpt_type2 eq 6}">
									<c:import url="../top_suim_print/suim_rpt_bsc_print_6.jsp"></c:import> <!-- 농협 -->
								</c:if>
								<c:if test="${suimVO.suim_rpt_type2 == 1 || suimVO.suim_rpt_type2 == 9}">  <!-- 일반 , 롯데 -->
									<%--<c:import url="../top_suim_print/suim_rpt_bsc_print_1.jsp"></c:import> <!-- 일반 -->--%>
									
									<%-- 수임일자에 따라 신규보고서로 분기한다. (여기서는 20191015 이전 보고서를 예전 포맷 이후는 최신포맷으로 보여준다.) by top3009 --%>
									<c:set var="report_reg_date" value="${fn:replace(suimVO.reg_date,'-','')}"/>
									<c:choose>
										<c:when test="${report_reg_date > 20200311}">										
											<c:import url="/reportBscInfoNew"></c:import>
										</c:when>
										<c:otherwise>
											<c:import url="/reportBscInfo"></c:import>
										</c:otherwise>
									</c:choose>
								</c:if>								
								<c:if test="${suimVO.suim_rpt_type2 == 3001}">  <!-- 건설공제 --><!-- 건설공제에 suim_rpt_type2 가 0인 경우는 기본 보고서 페이지로 보임 -->
									<div id="divPrintConstruction">
	                                    <c:import url="/constructionRptInfo"></c:import>
									</div>
								</c:if>
								<!-- 20170210 LDS -->
								<c:if test="${suimVO.suim_rpt_type2 eq 1001}">
									<c:import url="../rpt_in/suim_rpt_bsc_print_1001.jsp"></c:import> <!-- 단순 -->
								</c:if>

								<%--
								<c:if test="${suimVO.suim_rpt_type2 eq 9}">
									<c:import url="../top_suim_print/suim_rpt_bsc_print_9.jsp"></c:import> <!-- 롯데 -->
								</c:if>
								--%>
								<c:if test="${suimVO.suim_rpt_type2 eq 16}"> <!-- 메리츠 -->
<%-- 									<c:import url="../top_suim_print/suim_rpt_bsc_print_16.jsp"></c:import> --%>
									<c:import url="/meritz/reportMeritzInfo"></c:import>
								</c:if>
								<c:if test="${suimVO.suim_rpt_type2 eq 17}">
									<c:import url="../top_suim_print/suim_rpt_bsc_print_17.jsp"></c:import> <!-- 흥국 일반 -->
								</c:if>
								<c:if test="${suimVO.suim_rpt_type2 eq 1700}">
									<c:import url="../top_suim_print/suim_rpt_bsc_print_1700.jsp"></c:import> <!-- 흥국 의료 -->
								</c:if>
								<!-- suim_rpt_type2가 0인 경우(조건이 없는경우) 기본 보고서로 보이도록 조건 추가 20250520-->
								<c:if test="${suimVO.suim_rpt_type2 eq 0}">
									<c:import url="/reportBscInfoNew"></c:import>
								</c:if>							
							</c:if>
						</div> <!-- //guestcnt5 : 보고서 작성-->
						<!-- //보고서 작성 4종의 경우-->
						
						<!-- 메리츠 인보험 중간보고서 추가 by top3009-->						
						<div class="guestcnt10">
							<c:if test="${middle_report_16 eq 1}">
									<c:import url="/meritz/reportMeritzMidInfo"></c:import>
							</c:if>
						</div>
						
						<!-- 손해사정서 교부 181123 -->																	
 						<div class="guestcnt7_1">
 							<!-- 롯데인경우 추가 (ptnr_id = 9, C:재물, B:배상, T:여행자) -->
 							<!-- 삼성인경우 추가 (ptnr_id = 18, C:재물, B:배상, T:여행자) -->
 							<!-- 흥국인경우 추가 (ptnr_id = 17, C:재물, B:배상, T:인보험) -->
 							<!-- ABL인경우 추가 (ptnr_id = 41,  보험타입은 따로 없음) -->
 							<!-- 메리츠 추가 (ptnr_id = 16,  보험타입은 따로 없음) -->
 							<%-- 손해사정서 이메일 첨부파일 방식으로 변경 시작 --%>
 							<c:import url="/reportIssueEmailMain"></c:import>
 							<%-- 														 
 							<c:choose> 								
 								<c:when test="${suimVO.ptnr_id eq '9' && (suimVO.suim_rpt_type1 eq '1' || suimVO.suim_rpt_type1 eq '11' || suimVO.suim_rpt_type1 eq '12') }"> 											 							
			 							<c:import url="/reportIssueLotteJemul">							
											<c:param name="suim_rpt_type1"  value="${suimVO.suim_rpt_type1}"/>
											<c:param name="ptnr_mbr_nm"  value="${suimVO.ptnr_mbr_nm}"/>											
											<c:param name="ctype"  value="B"/>
										</c:import>													 							
 								</c:when>
 								<c:when test="${suimVO.ptnr_id eq '9' && (suimVO.suim_rpt_type1 eq '2' || suimVO.suim_rpt_type1 eq '13' ) }"> 											 							
			 							<c:import url="/reportIssueLotteJemul">							
											<c:param name="suim_rpt_type1"  value="${suimVO.suim_rpt_type1}"/>
											<c:param name="ptnr_mbr_nm"  value="${suimVO.ptnr_mbr_nm}"/>											
											<c:param name="ctype"  value="${ctype}"/>
										</c:import>		 							
 								</c:when>
 								<c:when test="${suimVO.ptnr_id eq '18' && suimVO.suim_rpt_type1 eq '2' }"> 											 							
			 							<c:import url="/reportIssueSamsungJemul">							
											<c:param name="suim_rpt_type1"  value="${suimVO.suim_rpt_type1}"/>
											<c:param name="ptnr_mbr_nm"  value="${suimVO.ptnr_mbr_nm}"/>
											<c:param name="ctype"  value="C"/>
										</c:import>		 							
 								</c:when>
 								<c:when test="${suimVO.ptnr_id eq '18' && (suimVO.suim_rpt_type1 eq '1' || suimVO.suim_rpt_type1 eq '11' || suimVO.suim_rpt_type1 eq '12') }"> 											 							
			 							<c:import url="/reportIssueSamsungJemul">							
											<c:param name="suim_rpt_type1"  value="${suimVO.suim_rpt_type1}"/>
											<c:param name="ptnr_mbr_nm"  value="${suimVO.ptnr_mbr_nm}"/>
											<c:param name="ctype"  value="B"/>
										</c:import>		 							
 								</c:when>
 								<c:when test="${suimVO.ptnr_id eq '18' && (suimVO.suim_rpt_type1 eq '3' || suimVO.suim_rpt_type1 eq '4') }"> 											 							
			 							<c:import url="/reportIssueSamsungJemul">							
											<c:param name="suim_rpt_type1"  value="${suimVO.suim_rpt_type1}"/>
											<c:param name="ptnr_mbr_nm"  value="${suimVO.ptnr_mbr_nm}"/>
											<c:param name="ctype"  value="I"/>
										</c:import>		 							
 								</c:when>
 								<c:when test="${suimVO.ptnr_id eq '17' && suimVO.suim_rpt_type1 eq '2' }"> 											 							
			 							<c:import url="/reportIssueHeungkukJemul">							
											<c:param name="suim_rpt_type1"  value="${suimVO.suim_rpt_type1}"/>
											<c:param name="ptnr_mbr_nm"  value="${suimVO.ptnr_mbr_nm}"/>
											<c:param name="ctype"  value="C"/>
										</c:import>		 							
 								</c:when>
 								<c:when test="${suimVO.ptnr_id eq '17' && (suimVO.suim_rpt_type1 eq '1' || suimVO.suim_rpt_type1 eq '11' || suimVO.suim_rpt_type1 eq '12') }"> 											 							
			 							<c:import url="/reportIssueHeungkukJemul">							
											<c:param name="suim_rpt_type1"  value="${suimVO.suim_rpt_type1}"/>
											<c:param name="ptnr_mbr_nm"  value="${suimVO.ptnr_mbr_nm}"/>
											<c:param name="ctype"  value="B"/>
										</c:import>		 							
 								</c:when>
 								<c:when test="${suimVO.ptnr_id eq '17' && (suimVO.suim_rpt_type1 eq '3' || suimVO.suim_rpt_type1 eq '4') }"> 											 							
			 							<c:import url="/reportIssueHeungkukJemul">							
											<c:param name="suim_rpt_type1"  value="${suimVO.suim_rpt_type1}"/>
											<c:param name="ptnr_mbr_nm"  value="${suimVO.ptnr_mbr_nm}"/>
											<c:param name="ctype"  value="I"/>
										</c:import>		 							
 								</c:when>
 								<c:when test="${suimVO.ptnr_id eq '41'}"> 											 							
			 							<c:import url="/reportIssueAbl">							
											<c:param name="suim_rpt_type1"  value="${suimVO.suim_rpt_type1}"/>
											<c:param name="ptnr_mbr_nm"  value="${suimVO.ptnr_mbr_nm}"/>
										</c:import>		 							
 								</c:when>
 								
 								<!-- AXA손해보험 손해사정서 추가 시작 by top3009 -->
 								<c:when test="${suimVO.ptnr_id eq '23'}"> 											 							
			 							<c:import url="/reportIssueAxa">							
											<c:param name="suim_rpt_type1"  value="${suimVO.suim_rpt_type1}"/>
											<c:param name="ptnr_mbr_nm"  value="${suimVO.ptnr_mbr_nm}"/>
										</c:import>		 							
 								</c:when>
 								<!-- AXA손해보험 손해사정서 추가 끝 by top3009 -->
 								
 								<!-- 메리츠 손해사정서 추가 시작 by top3009 -->
 								<c:when test="${suimVO.ptnr_id eq '16'}"> 											 							
			 							<c:import url="/reportIssueMeritz">							
											<c:param name="suim_rpt_type1"  value="${suimVO.suim_rpt_type1}"/>
											<c:param name="ptnr_mbr_nm"  value="${suimVO.ptnr_mbr_nm}"/>
										</c:import>		 							
 								</c:when>
 								<!-- 메리츠 손해사정서 추가 끝 by top3009 -->
 								
 								<!-- 인보험의 경우 기본 손해사정서를 별도로 처리시작 by top3009 -->
 								<c:when test="${suimVO.suim_rpt_type1 eq '3' or suimVO.suim_rpt_type1 eq '4'}"> 											 							
			 							<c:import url="/reportIssueMainPi">							
											<c:param name="suim_rpt_type1"  value="${suimVO.suim_rpt_type1}"/>
											<c:param name="ptnr_mbr_nm"  value="${suimVO.ptnr_mbr_nm}"/>
										</c:import>		 							
 								</c:when>
 								<!-- 인보험의 경우 기본 손해사정서를 별도로 처리 끝 by top3009 -->
 								
 								<!-- 기본 손해사정서 종결일자 (테스트용 20210621 이전 종결) 기준으로 신규양식 적용 --> 								
 																
 								<c:when test="${suimVO.closeDateVal < 20220825 && suimVO.suimRptState eq 2}"> 									
 									<c:import url="/reportIssueMain"> 																	
										<c:param name="suim_rpt_type1"  value="${suimVO.suim_rpt_type1}"/>
										<c:param name="ptnr_mbr_nm"  value="${suimVO.ptnr_mbr_nm}"/>
									</c:import>
 								</c:when> 								 								
 								<c:otherwise>
 									<c:import url="/reportIssueMainNew">							
										<c:param name="suim_rpt_type1"  value="${suimVO.suim_rpt_type1}"/>
										<c:param name="ptnr_mbr_nm"  value="${suimVO.ptnr_mbr_nm}"/>
									</c:import>
 								</c:otherwise>
 							</c:choose>
 							 --%>
 							<%-- 손해사정서 이메일 첨부파일 방식으로 변경 끝 --%>
 								
						</div>						
						<div class="guestcnt8_1">
							<c:import url="../top_suim/suim_rpt_bsc_dtl_log.jsp"></c:import>
						</div> <!-- //guestcnt5 : 보고서 로그-->

					</div><!-- //guest -->
				</div><!-- //bot1-3 -->
			</div>
		</div>
	</div>
	<!--//center -->

	<!-- footer -->
	<%--<c:import url="../top_main/top_pop_footer.jsp"></c:import>--%>
	<!-- //footer -->
	
	<!-- 공동수행자 사원 찾기 다이어로그 -->
	<c:import url="../util_etc/module_mbrpop_1_rptdtl.jsp"></c:import>
	<!-- 서식등록 팝업시작 -->		
		<div id="template-action-dialog" title="보험사 문서서식 다운로드" style="font-size: 15px;display:none;" align="center">
		<br/>
			<div class="tableStyle2">
				<table class="vacation-ins-table">
					<tr>
						<th width="25%">서식종류</th>
						<th width="50%">파일명</th>
						<th width="13%">등록일</th>
						<th width="12%">다운로드</th>							
					</tr>
					<c:forEach items="${templateList}" var="item" varStatus="var">
						<tr>
							<td width="30%">${item.category_name}</td>
							<td width="50%">
								<c:choose>
									<c:when test="${empty item.template_org_file}">
										<font color="blue">
											${item.nofile_content_val}
										</font>										
									</c:when>
									<c:otherwise>${item.template_org_file}</c:otherwise>
								</c:choose>							
							</td>
							<td width="10%">${item.reg_date_fmt}</td>												
							<td width="10%">					
								<c:if test="${!empty item.template_org_file}">			
								<a href="#noloc" onclick="fnTemplateDown('${item.tkey}');"><img src='./resources/ls_img/icon_disket.gif'></a>
								</c:if>
							</td>					
						</tr>		
					</c:forEach>
				</table>
			</div>
		</div>
		<!-- 서식등록 팝업끝 -->
		<form id="filedownForm" name="filedownForm" action="insuTemplateFiledown">
			<input type="hidden" id="tkey" name="tkey"/>
		</form>
		<!-- 보험사 공지사항 Modal 시작 -->
		<div id="popup-insu-notice" title="보험사 공지사항" style="font-size: 12px;display:none;">			
		</div>				
		<!-- 보험사 공지사항 Modal 끝 -->		
		<!-- 손해사정서 모바일 내용보기 Modal 시작 -->
		<div id="popup-issue-mobile" title="손해사정서 발송내용" style="font-size: 12px;display:none;">			
		</div>				
		<!-- 손해사정서 모바일 내용보기 Modal 시작 -->
		<!-- 손해사정서 이메일 내용보기 Modal 시작 -->
		<div id="popup-issue-email" title="손해사정서 발송내용" style="font-size: 12px;display:none;">			
		</div>				
		<!-- 손해사정서 이메일 내용보기 Modal 시작 -->
</body>