<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>		
<script>
$(document).ready(function(){
	
	//등록일 기준 정렬
	$("#regdate_order").on("click",function(){
		var reg_set = $("#regdate_order_set").val();
		
		if( reg_set == 'desc' ){
			$("#regdate_order_set").val('asc');
		}else{
			$("#regdate_order_set").val('desc');
		}
		
		$("#name_order_set").val('');
		$("#team_order_set").val('');
		
		//검색 호출
		fnSearch();
		
	});
	
	//이름 기준 정렬
	$("#name_order").on("click",function(){
		
		var name_set = $("#name_order_set").val();
		
		if( name_set == 'desc' ){
			$("#name_order_set").val('asc');
		}else{
			$("#name_order_set").val('desc');
		}
		
		$("#regdate_order_set").val('');
		$("#team_order_set").val('');
		
		//검색 호출
		fnSearch();
		
	});
	
	//부서 기준 정렬
	$("#team_order").on("click",function(){
		
		var team_set = $("#team_order_set").val();		
		
		if( team_set == 'desc' ){
			$("#team_order_set").val('asc');
		}else{
			$("#team_order_set").val('desc');
		}
		
		$("#regdate_order_set").val('');
		$("#name_order_set").val('');
		
		//검색 호출
		fnSearch();
	});
	
	//엑셀다운로드 파라미터 초기화
	$("#doExcelDown").val("0");
	$("#searchFrm").attr("action","card_manage_main");
	
	//조회갯수 설정
	$("#total_cnt").text(${cardList.size()});
	
	//등록페이지 클릭
	$("#btn-equipment-list-ins").on("click", function () {		
		fnCardIns();
    });
	
	//장비일괄 삭제
	$("#delete_all").on("click",function(){
		//체크된 갯수확인
		var nChk = $("input:checkbox[name=chk_ckey]:checked").length;
		
		if( nChk < 1 ){
			alert("일괄삭제 할 장비를 체크해주세요.");
			return;
		}		
		
		//체크된 serial_no 를 가져온다.
		var arraySerial = new Array();
		
		$("input:checkbox[name=chk_ckey]:checked").each(function(){
			arraySerial.push($(this).val());
		});
		
		fnEquipmentDeleteAll( arraySerial );
		
	});
	
	//장비일괄 폐기
	$("#close_all").on("click",function(){
		//체크된 갯수확인
		var nChk = $("input:checkbox[name=chk_ckey]:checked").length;
		
		if( nChk < 1 ){
			alert("일괄폐기 할 장비를 체크해주세요.");
			return;
		}		
		
		//체크된 serial_no 를 가져온다.
		var arraySerial = new Array();
		
		$("input:checkbox[name=chk_ckey]:checked").each(function(){
			arraySerial.push($(this).val());
		});
		
		fnEquipmentCloseAll( arraySerial );
		
	});
	
	//장비일괄 수정
	$("#modify_all").on("click",function(){
		//체크된 갯수확인
		var nChk = $("input:checkbox[name=chk_ckey]:checked").length;
		
		if( nChk < 1 ){
			alert("일괄수정 할 장비를 체크해주세요.");
			return;
		}		
		
		//체크된 serial_no 를 가져온다.
		var arraySerial = new Array();
		
		$("input:checkbox[name=chk_ckey]:checked").each(function(){
			arraySerial.push($(this).val());
		});
		
		fnEquipmentModAll( arraySerial );
		
	});
	
	//장비 라벨 출력
	$("#btn-label-print").on("click",function(){
		
		//체크된 갯수확인
		var nChk = $("input:checkbox[name=chk_ckey]:checked").length;
		
		if( nChk < 1 ){
			alert("라벨 출력 할 카드를 체크해주세요.");
			return;
		}else if( nChk > 16 ){
			alert("최대 라벨 출력 가능 개수는 16개입니다.");
			return;
		}
		
		//체크된 serial_no 개수를 모달창에 Set 해준다.
		$("#chkCkey").text(nChk);
		$("#chkCkeyVal").val(nChk);
		
		//체크된 serial_no 를 가져온다.
		var arrayCkey = new Array();
		
		$("input:checkbox[name=chk_ckey]:checked").each(function(){
			arrayCkey.push($(this).val());
		});
		
		fnCardLabelPrint( arrayCkey );
		
	});
	
	//수정페이지 클릭
	$(".btn-card-mod").on("click", function () {		
		var ckey = $(this).attr("data-card-no");
		
		if( ckey == 'is_del' ){
			alert('삭제된 카드는 수정이 불가능합니다.');
			return;
		}else{
			fnCardMod( ckey );
		}
						
	});
	
	//팀동기화
	$("#teamSync").click( function(){		
		var sUrl = "equipment_team_sync";
		var param = {};
		
		if(confirm("사용자 기준 팀정보를 동기화 하시겠습니까?")){
			$.ajax({
				type: "POST",
	   	        url: sUrl,
	   	        data: param,
	   	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	   	        timeout: 20000,
	   	        async: false,
	   	        dataType: "html", 
	   	        success: function(data){	   	        	
	   	        	if (data == 1){
						alert("동기화를 완료 하였습니다.");						
	   	        	}
	   	        },
				error: function(e){
				    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
				}
			});
		}		
	});
	
		
	//상세보기 클릭
	$(".btn-card-view").on("click", function () {		
		
		var sUrl = "card_manage_modal_detail";
		
		var ckey = $(this).attr("data-card-no");
		var param = {};
		param.ckey = ckey;		
		
		$.ajax({
			type: "POST",
			url: sUrl,
			data: param,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			timeout: 20000,
			dataType: "HTML", 
			success: function(data){
				$("#card-detail-dialog").html();				
				$("#card-detail-dialog").html(data);
					$("#card-detail-dialog").dialog({
						height: 650,
						width: 800,
						closeOnEscape : true,
						draggable : true,
						title: "카드 정보 상세",
						buttons:{							
							"닫기" : function(){
								$(this).dialog("close");
							}
						},
						modal: true,
						overlay:{ opacity: 0., background: '#000000'}
					});		
			},
			error: function(e){
			    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
			}
		});
		
	});
	
	//검색 셀렉트 박스 셋팅
	$("#srchGubunMain").select2();
	$("#srchCardTypeMain").select2();
	$("#tmSearchMain").select2();
	$("#srchCardStateMain").select2();
	$("#srchUserNoMain").select2();
	$("#srchCardZoneMain").select2();
	$("#srchCardNoMain").focus();
	
	//전체체크박스
	$("#check_all").click( function(){		
		if( $("#check_all").prop("checked") ){			
			$("input[name=chk_ckey]").prop("checked",true);
		}else{			
			$("input[name=chk_ckey]").prop("checked",false);
		}		
	});
	
	//삭제장비 체크박스 여부
	$("#del_view").change(function(){		
		
		if( $('input:checkbox[id="del_view"]').is(":checked") ){			
			$("#del_view_val").val(1);			
		}else{			
			$("#del_view_val").val(0);			
		}		
		fnSearch();
	});
	
	//퇴사자장 비 체크박스 여부
	$("#out_view").change(function(){		
		
		if( $('input:checkbox[id="out_view"]').is(":checked") ){			
			$("#out_view_val").val(1);			
		}else{			
			$("#out_view_val").val(0);			
		}		
		fnSearch();
	});
	
});

function goMain(){	
	location.href="./card_manage_main?viewType=Total";	
}

function doDownload(){
	
	$("#doExcelDown").val("1");
    var frm = document.getElementById("searchFrm");
    frm.action = "./card_manage_list";
    
    frm.submit();
}

function getToday(){
	var date = new Date();
	var year = date.getFullYear();
	var month = ("0" + (1 + date.getMonth())).slice(-2);
	var day = ("0" + date.getDate()).slice(-2);
	return year + "-" + month + "-" + day;
}

function fnSearch(){
	$("#doExcelDown").val("0");
    var frm = document.getElementById("searchFrm");
    frm.action = "./card_manage_main";    
    frm.submit();
}
</script>
	<div class= "tableStyle2" style="border-top: 0px;">
		<!-- search-box -->
		<form id="searchFrm">			
			<input type="hidden" id="doExcelDown" name="doExcelDown" value="0"/>
			<input type="hidden" id="regdate_order_set" name="regdate_order_set" value="${regdate_order_set}">
			<input type="hidden" id="name_order_set" name="name_order_set" value="${name_order_set}">
			<input type="hidden" id="team_order_set" name="team_order_set" value="${team_order_set}">
			<input type="hidden" id="del_view_val" name="del_view_val" value="${del_view_val}">
			<input type="hidden" id="out_view_val" name="out_view_val" value="${out_view_val}">
			<input type="hidden" id="viewType" name="viewType" value="Total">
			<div style="float: right;padding-bottom:5px;">
				<div style="text-align: right;">
					<img alt="Exceldownload" src="/resources/ls_img/ls_invoice/btn_excel.gif" onclick="javascript:doDownload();" style="cursor:pointer;">&nbsp;
				</div>
			</div>												
			<div id="search-box"  align="center">
				<!-- 검색 창 시작 -->				
				<table style="width: 100%;height:60px;" align="center">
					<tr>
						<th width="60px;">구 분</th>
						<td width="100px;">
							<select id="srchGubunMain" name="srchGubunMain" style="width: 80px;">
								<option value="9" <c:if test="${srchGubunMain eq '9'}">selected</c:if> >- 전체 -</option>
								<option value="1" <c:if test="${srchGubunMain eq '1'}">selected</c:if> >물보험</option>
								<option value="4" <c:if test="${srchGubunMain eq '4'}">selected</c:if> >인보험</option>								
							</select>
						</td>
						<th width="60px;">부 서 명</th>
						<td width="180px;">
							<select id="tmSearchMain" name="tmSearchMain" style="width:160px;text-align:left;">
								<option value="" <c:if test="${empty tmSearchMain}">selected</c:if> > - 전체 - </option>
								<option value="9999" <c:if test="${tmSearchMain eq 9999}">selected</c:if> > - 미지정 - </option>
								<c:forEach items="${teamList}" var = "teamVo">
									<option value="${teamVo.teamId}"
										<c:if test="${tmSearchMain eq teamVo.teamId}">selected</c:if>>
										<c:if test="${teamVo.teamLevel == 1}">&nbsp;└</c:if>
										<c:if test="${teamVo.teamLevel == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
										${teamVo.teamName}
									</option>
								</c:forEach>
							</select>
						</td>
						<th width="60px;">이 름</th>
						<td width="150px;">
							<select id="srchUserNoMain" name="srchUserNoMain" style="width:130px;text-align:left;">
								<option value="" <c:if test="${empty srchUserNoMain}">selected</c:if> > - 전체 - </option>
								<option value="0" <c:if test="${srchUserNoMain eq '0'}">selected</c:if> > - 미등록 - </option>
								<option value="99999" <c:if test="${srchUserNoMain eq '99999'}">selected</c:if> > - 공용 - </option>								
								<c:forEach items="${memberList}" var="item" >
									<option value="${item.userNo}" <c:if test="${srchUserNoMain == item.userNo}">selected</c:if> >${item.userName}</option>									
								</c:forEach>										
							</select>
						</td>
						<th width="60px;">사용지점</th>
						<td width="100px;">
							<select id="srchCardZoneMain" name="srchCardZoneMain" style="width:80px;text-align:left;">
								<option value="" <c:if test="${empty srchCardZoneMain}">selected</c:if> > - 전체 - </option>
								<c:forEach items="${cardZoneList}" var="item" >
									<option value="${item.col_cd}" <c:if test="${srchCardZoneMain eq item.col_cd}">selected</c:if> >${item.col_val}</option>									
								</c:forEach>										
							</select>
						</td>
						<th width="60px;">카드상태</th>
						<td width="100px;">
							<select id="srchCardStateMain" name="srchCardStateMain" style="width:80px;text-align:left;">
								<option value="" <c:if test="${empty srchCardStateMain}">selected</c:if> > - 전체 - </option>
								<c:forEach items="${cardStateList}" var="item" >
									<option value="${item.col_cd}" <c:if test="${srchCardStateMain eq item.col_cd}">selected</c:if> >${item.col_val}</option>									
								</c:forEach>										
							</select>
						</td>
						<th width="60px;">등록일</th>
						<td width="180px;">
							<input type="text" class="classCalendar" id="regSdate" name="regSdate" style="width:60px;" value="${regSdate}"/> ~
							<input type="text" class="classCalendar" id="regEdate" name="regEdate" style="width:60px;" value="${regEdate}"/> 
						</td>						
						<td>
							<a href="#noloc" class="btn-vacation-aprv" id="btn-search" onclick='javascript:goMain();' style="width:50px;">초기화</a>							
						</td>
					</tr>
					<tr>
						<th width="60px;">카드종류</th>
						<td width="100px;">
							<select id="srchCardTypeMain" name="srchCardTypeMain" style="width:80px;text-align:left;">
								<option value="" <c:if test="${empty srchCardTypeMain}">selected</c:if> > - 전체 - </option>
								<c:forEach items="${cardTypeList}" var="item" >
									<option value="${item.col_cd}" <c:if test="${srchCardTypeMain eq item.col_cd}">selected</c:if> >${item.col_val}</option>									
								</c:forEach>										
							</select>
						</td>
						<th width="60px;">카드번호</th>
						<td width="180px;">
							<input type="text" id="srchCardNoMain" name="srchCardNoMain" maxlength="30" style="width:160px;" value="${srchCardNoMain}"> 
						</td>												
						<th width="60px;">카드별칭</th>
						<td width="150px;"><input type="text" id="srchCardUidMain" name="srchCardUidMain" maxlength="30" style="width:140px;" value="${srchCardUidMain}"></td>
						<th width="60px;">시리얼</th>
						<td width="100px;">
							<input type="text" id="srchCardSerialNo" name="srchCardSerialNo" maxlength="30" style="width:90px;" value="${srchCardSerialNo}">
						</td>						
						<th width="60px;">메모</th>
						<td width="100px;">
							<input type="text" id="srchCardMemoMain" name="srchCardMemoMain" maxlength="30" style="width:90px;" value="${srchCardMemoMain}">
						</td>
						<th>수정일</th>
						<td>
							<input type="text" class="classCalendar" id="modSdate" name="modSdate" style="width:60px;" value="${modSdate}"/> ~
							<input type="text" class="classCalendar" id="modEdate" name="modEdate" style="width:60px;" value="${modEdate}"/>
						</td>
						<td>
							<a href="#noloc" class="btn-vacation-aprv" id="btn-search" style="background:#CEE3F6;width:50px;" onclick='javascript:fnSearch();'>검 색</a>
						</td>
					</tr>
				</table>
				<!-- 검색 창 끝 -->				
				<br/>
			</div> 
		</form>									
		<div style="float: right;padding-bottom:5px;">
			<div style="text-align: right;">
				<input type="checkbox" id="out_view" name="out_view" <c:if test="${out_view_val eq 1}">checked</c:if> /> <b><font color="blue">퇴사자 카드만 표시</font></b>&nbsp;				
				<input type="checkbox" id="del_view" name="del_view" <c:if test="${del_view_val eq 1}">checked</c:if> /> <b><font color="red">삭제 카드 포함</font></b>&nbsp;
				<!-- <a href="#noloc" class="btn-vacation-list-ins" id="delete_all">일괄 삭제</a>&nbsp;
				<a href="#noloc" class="btn-vacation-list-ins" id="close_all">일괄 폐기</a>&nbsp;
				<a href="#noloc" class="btn-vacation-list-ins" id="modify_all">일괄 수정</a>&nbsp; -->				
				<a href="#noloc" class="btn-vacation-list-ins" id="btn-equipment-list-ins">카드 등록</a>
				<a href="#noloc" class="btn-vacation-list-ins" style="background:#F3E2A9;" id="btn-label-print">라벨 관리</a>				
			</div>
		</div>
		<div>																	
		<table>									
			<thead>
				<tr>
					<th width="10px;"><input type="checkbox" id="check_all"></th>											
					<th width="15px;">No.</th>
					<th width="30px;">센터명</th>
					<th width="30px;">
						<c:choose>
							<c:when test="${team_order_set eq 'asc'}">
								<span id="team_order" style="cursor:pointer;color:blue;">부서명 &#9652;</span>
							</c:when>
							<c:when test="${team_order_set eq 'desc'}">
								<span id="team_order" style="cursor:pointer;color:blue;">부서명 &#9662;</span>
							</c:when>
							<c:otherwise><span id="team_order" style="cursor:pointer;">부서명</span></c:otherwise>
						</c:choose>						
					</th>
					<th width="15px;">구분</th>
					<th width="35px;">
						<c:choose>
							<c:when test="${name_order_set eq 'asc'}">
								<span id="name_order" style="cursor:pointer;color:blue;">이름 (별칭) &#9652;</span>
							</c:when>
							<c:when test="${name_order_set eq 'desc'}">
								<span id="name_order" style="cursor:pointer;color:blue;">이름 (별칭) &#9662;</span>
							</c:when>
							<c:otherwise><span id="name_order" style="cursor:pointer;">이름 (별칭)</span></c:otherwise>
						</c:choose>						
					</th>
					<th width="18px;">카드종류</th>
					<th width="40px;">카드번호</th>
					<th width="40px;">카드시리얼</th>
					<th width="15px;">상태</th>
					<th width="20px;">
						<c:choose>
							<c:when test="${regdate_order_set eq 'asc'}">
								<span id="regdate_order" style="cursor:pointer;color:blue;">등록일 &#9652;</span>
							</c:when>
							<c:when test="${regdate_order_set eq 'desc'}">
								<span id="regdate_order" style="cursor:pointer;color:blue;">등록일 &#9662;</span>
							</c:when>
							<c:otherwise><span id="regdate_order" style="cursor:pointer;">등록일</span></c:otherwise>
						</c:choose>
					</th>
					<th width="20px;">수정일</th>
					<th width="15px;">사용지점</th>					
					<th width="38px;">기능</th>					
				</tr>
			</thead>
		</table>
		</div>
		<div style="height: 620px; overflow-x: hidden !important; overflow-y: auto;">
		<table>	
			<colgroup>
				<col style="width:10px;"><!-- 체크박스 -->
				<col style="width:15px;"><!-- No -->
				<col style="width:30px;"><!-- 센터명 -->
				<col style="width:30px;"><!-- 부서명 -->
				<col style="width:15px;"><!-- 구분 -->
				<col style="width:35px;"><!-- 이름 -->
				<col style="width:18px;"><!-- 카드종류 -->
				<col style="width:40px;"><!-- 카드번호 -->
				<col style="width:40px;"><!-- 카드시리얼번호 -->				
				<col style="width:15px;"><!-- 상태 -->
				<col style="width:20px;"><!-- 등록일 -->
				<col style="width:20px;"><!-- 수정일 -->
				<col style="width:15px;"><!-- 사용지점 -->
				<!-- 기능 -->
				<c:choose>
					<c:when test="${cardList.size() > 20}"><col style="width:35px;"></c:when>
					<c:otherwise><col style="width:38px;"></c:otherwise>
				</c:choose>
			</colgroup>		
			<tbody>
				<c:choose>
					<c:when test="${cardList.size() != 0}">
						<c:set var="totalSize" value="${cardList.size()}"/>
						<c:forEach items="${cardList}" var="item" varStatus="status">
							<c:choose>
								<c:when test="${item.is_del eq 1}"><tr style="background-color:#CCCCCC"></c:when>
								<c:otherwise><tr></c:otherwise>
							</c:choose>
								<td><input type="checkbox" name="chk_ckey" id="chk_ckey" value="${item.ckey}"/></td>														
								<td class="td-overflow-none">${totalSize - status.index}</td>														
								<td class="td-overflow-none">${item.center_name}</td>
								<td class="td-overflow-none">
									<c:choose>
										<c:when test="${empty item.team_name}">미지정</c:when>
										<c:otherwise>${item.team_name}</c:otherwise>
									</c:choose>
								</td>
								<td class="td-overflow-none"> 
									<c:choose>
										<c:when test="${empty item.team_type}">-</c:when>
										<c:when test="${item.team_type eq 0 or item.team_type eq 1}">물보험</c:when>
										<c:when test="${item.team_type eq 4}">인보험</c:when>										
									</c:choose>								
								</td>
								<td class="td-overflow-none">
									<c:if test="${not empty item.user_name}">${item.user_name}</c:if>
									<c:if test="${not empty item.card_uid}">(${item.card_uid})</c:if>									
								</td>
								<td class="td-overflow-none">${item.card_type_nm}</td>
								<td class="td-overflow-none">${item.card_number}</td>
								<td class="td-overflow-none">${item.card_serial_no}</td>
								<td class="td-overflow-none">${item.card_state_nm}</td>
								<td class="td-overflow-none">${item.reg_date}</td>
								<td class="td-overflow-none">${item.mod_date}</td>
								<td class="td-overflow-none">${item.card_zone_nm}</td>
								<td class="td-overflow-none">
									<a href="#noloc" class="btn-card-view" data-card-no="${item.ckey}" style="width:35px;">보기</a>&nbsp;
									<c:choose>
										<c:when test="${item.is_del eq 1}">
											<a href="#noloc" class="btn-card-mod" data-card-no="is_del" style="width:35px;">수정</a>
										</c:when>
										<c:otherwise>
											<a href="#noloc" class="btn-card-mod" data-card-no="${item.ckey}" style="width:35px;">수정</a>
										</c:otherwise>
									</c:choose>																	
								</td>								
							</tr>							
						</c:forEach>													
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="14">
								검색된 카드가 없습니다.
							</td>
						</tr>
					</c:otherwise>
				</c:choose>				
			</tbody>
		</table>
		</div>
	</div>	