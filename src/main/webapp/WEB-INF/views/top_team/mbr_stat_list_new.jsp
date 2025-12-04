<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css?v=20170411111520" />
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/><!-- calendar -->
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/><!-- calendar -->
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/><!-- calendar -->
	
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
    <script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
    <script src="./resources/ne_js/calendar.js?v=20170321111520"></script><!-- calendar -->

    <script src="./resources/wm_js/common.js"></script>
    <script src="./resources/cmm/js/common.js"></script>

	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>
	
	<script>
		$(document).ready(function(){
			if('${mbrAuthVo_Session.user_no}' == null || ('${mbrAuthVo_Session.mbr_pms_14}' == 0 && '${mbrAuthVo_Session.mbr_pms_15}' == 0)){
				window.location.assign("./logout");
			}		
			
			$.ajaxSetup({cache:false});
			
			//탭값 확인 후 활성화 탭 선택
			var selTab = '${tab}';
			
			//근무자 탭을 활성화 한다.
			if( 'work' == selTab ){
				workTabClick();
			}
			
		});//$(document).ready
		
		//사원검색입력창에 엔터키눌렀을때 action
		function enterKey(){
			if(event.keyCode == 13){
				doMemberSearch();				
			}
		}
		
		function clearSearchForm(){
			$("#ustat").val("10");
			$("#cid").val("0");
			$("#tid").val("0");
			$("#searchStr").val("");
		}
		
		//근무자 탭 활성화 
		function workTabClick(){
			$("#searchTab").attr("class","");
			$("#workTab").attr("class","on");
			$("#standbyTab").attr("class","");
			$("#retireTab").attr("class","");
			$("#tabMenu").val("work");
			$("#outOrder").val("");
			
			$("#searchBox").hide();
			$("#standbyExcelDown").hide();
			$("#workExcelDown").show();
			$("#retireExcelDown").hide();
			
			clearSearchForm();						
			doMemberSearch();
		}
		
		//사원검색 탭 활성화
		function searchTabClick(){			
			$("#searchTab").attr("class","on");
			$("#workTab").attr("class","");
			$("#standbyTab").attr("class","");
			$("#retireTab").attr("class","");
			
			$("#tabMenu").val("search");
			$("#outOrder").val("");
						
			//검색창 기본셋팅 값 설정
			$("#ustat").select2();
			$("#cid").select2();
			$("#tid").select2();
			
			$("#ustat").val(0);
			$("#ustat").trigger("change");			
			
			$("#searchBox").show();			
			$("#searchStr").focus();
			
			$("#workExcelDown").hide();
			$("#standbyExcelDown").hide();
			$("#retireExcelDown").hide();
			$("#search_member_list").html("");			
		}
		
		//발령대기자 탭 활성화
		function standbyTabClick(){
			$("#searchTab").attr("class","");
			$("#workTab").attr("class","");
			$("#standbyTab").attr("class","on");
			$("#retireTab").attr("class","");
			$("#tabMenu").val("standby");
			$("#outOrder").val("");
			
			$("#searchBox").hide();
			$("#workExcelDown").hide();
			$("#standbyExcelDown").show();
			$("#retireExcelDown").hide();
			clearSearchForm();
			doMemberSearch();
		}
		
		//퇴사자 탭 활성화
		function retireTabClick(){
			$("#searchTab").attr("class","");
			$("#workTab").attr("class","");
			$("#standbyTab").attr("class","");
			$("#retireTab").attr("class","on");
			$("#tabMenu").val("retire");
			
			$("#searchBox").hide();
			$("#workExcelDown").hide();
			$("#standbyExcelDown").hide();
			$("#retireExcelDown").show();
			
			clearSearchForm();
			//퇴사탭선택시 퇴사일 정렬상태로 불러온다.
			$("#outOrder").val("ASC");
			
			doMemberSearch();
		}
		
				
		function popMbrDetail(user_no){
			
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			
			var sw=1500; //띄울 창의 넓이
			var sh=900;  //띄울 창의 높이

			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치

			window.open('popMbrDetail?user_no='+user_no,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',scrollbars=yes,resizable=yes');
			
		}
		
		//카드 등록
		function popCardAdd( p_user_no, p_team_id ){						
			
			//등록폼 초기화
			$("#srchUserNo option:eq(0)").prop('selected', true);
			$("#tmSearch option:eq(0)").prop('selected', true);
			$("#srchCardType option:eq(0)").prop('selected', true);
			$("#srchCardState option:eq(0)").prop('selected', true);
			$("#srchCardZone option:eq(0)").prop('selected', true);
			$("#reg_date").val('');
			$("#card_number").val('');
			$("#card_uid").val('');
			$("#card_memo").val('');
			
			$("#srchUserNo").val(p_user_no);
			$("#srchUserNo").trigger("change");
			
			$("#tmSearch").val(p_team_id);
			$("#tmSearch").trigger("change");
			
			$("#card-action-dialog").dialog({
				height: 550,
				width: 800,
				closeOnEscape : true,
				draggable : true,
				appendTo : "#cardActionFrm",
				title: "카드 등록",
				buttons:{
					"카드 등록" : function(){
						var action = popCardAction('I');		//등록
						if (action){
							$(this).dialog("close");
						}						
					},
					"취소" : function(){
						$(this).dialog("close");
					}
				},
				modal: true,
				overlay:{ opacity: 0., background: '#000000'}
			});
			
			$("#srchUserNo").select2({
				dropdownParent: $("#card-action-dialog")	
			});
			
			$("#tmSearch").select2({
				dropdownParent: $("#card-action-dialog")	
			});
			
			$("#srchCardType").select2({
				dropdownParent: $("#card-action-dialog")	
			});
			
			$("#srchCardState").select2({
				dropdownParent: $("#card-action-dialog")	
			});
			
			$("#srchCardZone").select2({
				dropdownParent: $("#card-action-dialog")	
			});			
			
		}
		
		//퇴사자 카드 수정폼
		function popCardMod( p_ckey ){
			
			var sUrl = "get_card_info";
			
			var param = {};
			param.ckey = p_ckey;
			
			$.ajax({
		        type: "POST",
		        url: sUrl,
		        data: param,		         
		        dataType: "JSON", 
		        success: function(data){
	        		
	        		//수정폼 설정
	        		$("#ckey_val").val(data.ckey);
	    			$("#srchUserNo").val(data.user_no);
	    			$("#tmSearch").val(data.team_id);
	    			$("#srchCardType").val(data.card_type);
	    			$("#srchCardState").val(data.card_state);
	    			$("#srchCardZone").val(data.card_zone);
	    			$("#reg_date").val(data.reg_date);	    			
	    			$("#card_number").val(data.card_number);	    			
	    			$("#card_memo").val(data.card_memo);
	    			$("#card_uid").val(data.card_uid);
	        		
	    			$("#card-action-dialog").dialog({
	    				height: 550,
	    				width: 800,
	    				closeOnEscape : true,
	    				draggable : true,
	    				appendTo : "#cardActionFrm",
	    				title: "카드 수정",
	    				buttons:{
	    					"카드 삭제" : function(){
	    						var action = popCardAction('D');		//삭제
	    						if (action){
	    							$(this).dialog("close");
	    						}
	    					},
	    					"카드 수정" : function(){
	    						var action = popCardAction('U');		//수정
	    						if (action){
	    							$(this).dialog("close");
	    						}
	    					},
	    					"취소" : function(){
	    						$(this).dialog("close");
	    					}
	    				},
	    				modal: true,
	    				overlay:{ opacity: 0., background: '#000000'}
	    			});
	    			
	    			$("#srchUserNo").select2({
	    				dropdownParent: $("#card-action-dialog")	
	    			});
	    			
	    			$("#tmSearch").select2({
	    				dropdownParent: $("#card-action-dialog")	
	    			});
	    			
	    			$("#srchCardType").select2({
	    				dropdownParent: $("#card-action-dialog")	
	    			});
	    			
	    			$("#srchCardState").select2({
	    				dropdownParent: $("#card-action-dialog")	
	    			});
	    			
	    			$("#srchCardZone").select2({
	    				dropdownParent: $("#card-action-dialog")	
	    			});
	    			
		        },
		        error: function(e){
		            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		        }
		    });
		}
		
		//카드 정보조회
		function popCardDetail( p_ckey ){			
			
			var sUrl = "card_manage_modal_detail";
			
			var ckey = p_ckey;
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
		}
		
		//팀이름 정렬
		function doOrderTeamName( p_order ){			
			$("#teamNameOrder").val(p_order);
			doMemberSearch();
		}
		
		//직위정렬
		function doOrderLevel( p_order ){			
			$("#levelOrder").val(p_order);			
			doMemberSearch();
		}
		
		//직책정렬
		function doOrderWork( p_order ){			
			$("#workOrder").val(p_order);			
			doMemberSearch();
			
		}
		
		//이름정렬
		function doOrderUserName( p_order ){
			$("#userNameOrder").val(p_order);
			doMemberSearch();
		}
		
		//입사일 정렬
		function doOrderJoin( p_order ){
			$("#joinOrder").val(p_order);
			doMemberSearch();
		}
		
		//퇴사일 정렬
		function doOrderOut( p_order ){
			$("#outOrder").val(p_order);
			doMemberSearch();
		}
		
		function doExcelDown(){
			var searchVal =  sqlRemoveText( $("#searchStr").val() );
			var ustatVal = $("#ustat").val();
			var cidVal = $("#cid").val();
			var tidVal = $("#tid").val();
			
			var teamNameOrderVal = $("#teamNameOrder").val();
			var levelOrderVal = $("#levelOrder").val();
			var workOrderVal = $("#workOrder").val();
			var userNameOrderVal = $("#userNameOrder").val();
			var joinOrderVal = $("#joinOrder").val();
			var outOrderVal = $("#outOrder").val();
			
			$("#downSearchStr").val(searchVal);
			$("#downUstat").val(ustatVal);
			$("#downCid").val(cidVal);
			$("#downTid").val(tidVal);				
			
			$("#excelTopMemberForm").submit();
		}
		
		function doMemberSearch(){
			
			$("#top_loading").show();
			
			var p_tab = $("#tabMenu").val();
			
			var ustatVal = "";
			var searchVal =  "";			
			var cidVal = "";
			var tidVal = "";			
			
			//근무자 탭으로 검색
			if( 'work' == p_tab ){
				ustatVal = "0";
			}else if( 'standby' == p_tab ){
				ustatVal = "2";
			}else if( 'retire' == p_tab ){
				ustatVal = "1";
			}else{
				ustatVal = $("#ustat").val();	
			}
			
			if( 'search' == p_tab ){
				searchVal = sqlRemoveText( $("#searchStr").val() );			
				cidVal = $("#cid").val();
				tidVal = $("#tid").val();
			}else{
				searchVal = "";
				cidVal = "";
				tidVal = "";
			}
			
			//정렬은 기존데로 변경한다.
			var teamNameOrderVal = $("#teamNameOrder").val();
			var levelOrderVal = $("#levelOrder").val();
			var workOrderVal = $("#workOrder").val();
			var userNameOrderVal = $("#userNameOrder").val();
			var joinOrderVal = $("#joinOrder").val();
			var outOrderVal = $("#outOrder").val();
			
			var param = {};
			param.tab = p_tab;
			param.searchStr = searchVal;
			param.ustat = ustatVal;
			param.cid = cidVal;
			param.tid = tidVal;
			param.teamOrder = teamNameOrderVal;
			param.levelOrder = levelOrderVal;
			param.workOrder = workOrderVal;
			param.userNameOrder = userNameOrderVal;
			param.joinOrder = joinOrderVal;
			param.outOrder = outOrderVal;
			
			$.ajax({
				type : "post",					
				url : "topMemberSearchAjax",
				data : param,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				dataType: "html",
				timeout: 20000,
				cache:false,
				success : function(data){					
					$("#search_member_list").html(data);
					$("#top_loading").hide();
				},
				error: function (request, status, error) {
					$("#top_loading").hide();
					console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);						
				}
			});
		}
		
	</script>
	
	<style>
		.tableStyle2 td {letter-spacing: 0;}
		.btn-vacation-aprv {
			font-weight:bold;
			text-decoration:none;
			font-family:Arial;
			text-indent:0px;
			line-height:0px;
			-moz-border-radius:5px;
			-webkit-border-radius:5px;
			border-radius:5px;
			text-align:center;
			vertical-align:middle;
			display:inline-block;
			font-size:12px;
			color:#696969  !important;
			width:60px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #eeeeee;
		}
		
		.buttonAssistanceMember{
			width:100px;
			height:25px;
		    background-color:#2E7EE8;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		    font-weight:bold;
	    }
		
		/* 모달창 셀렉트 박스 */
		.select2-container--default{
			text-align : left;
			font-color:#444;
			font-size:12px;
		}
	</style>
</head>

<body>

<!-- wrapper -->
<div id="wrapper">
	<!-- skipnavi --><!-- header -->
	<c:import url="../top_main/top_main_menu.jsp"></c:import>
	<!-- //skipnavi --><!-- //header -->
	
	<!-- contents -->
	<div id="container">
		<div class="contetns">
			<!-- centercnt_top -->
			<div class="center_cnt_1300_ds">
				<!-- centercnt_bot -->
				<div class="centercnt_1300_bot1-2_ds">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li id="searchTab" onclick="javascript:searchTabClick();"><a href="#">사원 검색</a></li>								
								<li id="workTab" onclick="javascript:workTabClick();"><a href="#">근무자</a></li>
								<li id="standbyTab" onclick="javascript:standbyTabClick();"><a href="#">발령대기자</a></li>
								<li id="retireTab" onclick="javascript:retireTabClick();"><a href="#">퇴사자</a></li>
							</ul>
							
							<!-- 엑셀 다운을 위한 폼 -->
							<form name="excelTopMemberForm" id="excelTopMemberForm" action="excelTopMemberNew" method="GET">
								<input type="hidden" id="gubun" name="gubun" />
								<input type="hidden" id="tabMenu" name="tabMenu"/>
								<input type="hidden" id="teamNameOrder" name="teamNameOrder"/>
								<input type="hidden" id="levelOrder" name="levelOrder"/>
								<input type="hidden" id="workOrder" name="workOrder"/>
								<input type="hidden" id="userNameOrder" name="userNameOrder"/>
								<input type="hidden" id="joinOrder" name="joinOrder"/>
								<input type="hidden" id="outOrder" name="outOrder"/>								
								<input type="hidden" id="downSearchStr" name="downSearchStr"/>
								<input type="hidden" id="downUstat" name="downUstat"/>
								<input type="hidden" id="downCid" name="downCid"/>
								<input type="hidden" id="downTid" name="downTid"/>								
							</form>
						</div>						
						
						<!-- 검색 탭 -->
						<div id="searchBox" style="overflow:hidden;padding:5px 0 5px 0;">
							<!-- 검색 테이블 시작-->
							<div class= "tableStyle2" style="border-top:0px;">
								<table>
									<thead>
										<tr>
											<th width="10%">재직상태</th>
											<th width="25%">센터명</th>
											<th width="25%">팀명</th>
											<th width="25%">검색어 (이름 or 전화번호 or 아이디)</th>
											<th width="15%">-</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>
												<select id="ustat" name="ustat" style="width:95%;">
													<option value="10" selected>전체</option>
													<option value="0">근무자</option>
													<option value="3">휴직자</option>
													<option value="2">발령대기자</option>
													<option value="1">퇴사자</option>
													<option value="9">SA</option>
												</select>
											</td>
											<td>
												<select id="cid" name="cid" style="width:95%;text-align:left;">
													<option value="0"> - 전체 - </option>													
													<c:forEach items="${centerList}" var="centerVo">
														<option value="${centerVo.teamCenter}">${centerVo.centerName}</option>
													</c:forEach>
												</select>
											</td>
											<td>
												<select id="tid" name="tid" style="width:95%;">
													<option value="0" selected>전체</option>
													<c:forEach items="${teamList}" var = "teamVo">
														<option value="${teamVo.team_id}">
															<c:if test="${teamVo.team_level == 1}">&nbsp;└</c:if>
															<c:if test="${teamVo.team_level == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
															${teamVo.team_name}
														</option>
													</c:forEach>
												</select>
											</td>
											<td>
												<input type="text" id="searchStr" name="searchStr" size="50" onkeydown="javascript:enterKey();" style="width:95%;"/>
											</td>											
											<td>	
												<c:choose>
													<c:when test="${mbrVo_Session.user_state eq 9}">
														<input title="검색" class="buttonAssistanceMember" type="button" value="검 색" style="width:80px;" onclick="javascrip:doMemberSearch();">&nbsp;
														<input title="엑셀다운" class="buttonAssistanceMember" type="button" value="엑셀다운" style="width:90px;background-color:#31B404;" onclick="javascript:doExcelDown();">
													</c:when>
													<c:otherwise>
														<input title="검색" class="buttonAssistanceMember" type="button" value="검  색" style="width:150px;" onclick="javascrip:doMemberSearch();">														
													</c:otherwise>
												</c:choose>
											</td>
										</tr>
									</tbody>
								</table>
								<!-- 검색 테이블 끝-->								
							</div><!-- //tableStyle2 -->
						</div>
						<!-- 근무자엑셀다운, 대기자엑셀다운, 퇴사자엑셀다운에서 엑셀다운으로 통일 -->
						<div id="workExcelDown" style="display:none;overflow:hidden;padding:5px 0 5px 0;text-align:right;">						
							<input title="엑셀다운" class="buttonAssistanceMember" type="button" value="엑셀다운" style="width:80px;background-color:#31B404;" onclick="javascript:doExcelDown();">
						</div>
						<div id="standbyExcelDown" style="display:none;overflow:hidden;padding:5px 0 5px 0;text-align:right;">						
							<input title="엑셀다운" class="buttonAssistanceMember" type="button" value="엑셀다운" style="width:80px;background-color:#31B404;" onclick="javascript:doExcelDown();">
						</div>
						<div id="retireExcelDown" style="display:none;overflow:hidden;padding:5px 0 5px 0;text-align:right;">						
							<input title="엑셀다운" class="buttonAssistanceMember" type="button" value="엑셀다운" style="width:80px;background-color:#31B404;" onclick="javascript:doExcelDown();">
						</div>
						<!-- 사용자 검색시작 -->
						<div id="search_member_list"></div>
						<!-- 사용자 검색 끝 -->
						
							</div>				
						</div><!-- //guestcnt4 -->						
					</div>
				</div>
				
				<!-- 카드 Action Modal 시작 -->
				<c:import url="/card_manage_modal"></c:import>
				<!-- 카드 Action Modal 끝 -->
				
				<div id="card-detail-dialog" title="상세 보기" style="font-size: 15px;display:none;" align="center"></div>
				<!-- //centercnt_bot -->								

			</div>
			<!-- //center_cnt -->
		</div>		
	<!-- //contents -->

	<!-- footer -->
	<c:import url="../top_main/top_main_footer.jsp"></c:import>
	<!-- //footer -->

<!-- //wrapper -->

</body>
</html>
