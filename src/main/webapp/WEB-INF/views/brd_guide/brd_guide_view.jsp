<%--
  Created by IntelliJ IDEA.
  User: kohyeonseok
  Date: 2017. 6. 28.
  Time: 오전 9:18
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("CR", "\r"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
    <title>${title_Session}</title>
    <link rel="stylesheet" type="text/css" href="/resources/wm_css/style.css" />
    <script src="/resources/jquery/jquery.min_1_12.js"></script>
    <script src="/resources/wm_js/common.js"></script>
    <script src="/resources/ckeditor/ckeditor.js"></script>
    <style>
		.ignoreBrd td{
			border : 1px solid #000 !important;
		}
		
		.buttonMini{
			width:40px;
			height:20px;
		    background-color:#CEE3F6;
		    color:#666;
		    text-align: center;
			border-radius:5px;
		    font-size: 11px;
		    cursor: pointer;
		    text-decoration:none;
		    border: solid 1px grey;		    
		}
		
		.buttonMiniPrint{
			width:80px;
			height:20px;
		    background-color:#e1e1e1;
		    color:#666;
		    text-align: center;
			border-radius:5px;
		    font-size: 11px;
		    cursor: pointer;
		    text-decoration:none;
		    border: solid 1px grey;		    
		}
	</style>
</head>
<body>
<div id="wrapper"><!-- wrapper -->
    <!-- skipnavi --><!-- header -->
    <c:import url="../top_main/top_main_menu.jsp"></c:import>
    <!-- contents -->
    <div id="container">
        <div class="contetns">
            <!-- left_cnt -->
            <c:import url="/top_main_left"></c:import>
            <!-- //left_cnt -->
            <!-- centercnt_top -->
            <div class="center_cnt">
                <!-- centercnt_bot -->
                <div class="centercnt_bot1-2">

                    <div class="guest">
                        <div class="guestTap">
                            <ul>
                                <li class="on"><a href="#noloc">사내규정 · 지침</a></li>
                            </ul>
                        </div>
                        <div class="guestcnt4" style="display:block;">
                            <input type="hidden" id="guide_no" name="guide_no" value="${guideVo.guideNo}">
   							<input type="hidden" id="reg_user_no" name="reg_user_no" value="${guideVo.regUserNo}">
                            <div class="tableStyle2">
                                <table>
                                    <colgroup>
                                        <col width="15%">
                                        <col width="25%">
                                        <col width="15%">
                                        <col width="25%">
                                        <col width="10%">
                                        <col width="10%">
                                    </colgroup>
                                    <tr>
                                    	<th>작성자</th>
                                    	<td style="text-align: left; padding-left: 5px;"><c:out value="${guideVo.userName}"></c:out></td>
                                        <th>작성일</th>
                                        <td style="text-align: left; padding-left: 5px;"><c:out value="${guideVo.regDate}"/></td>
                                        <th>분류</th>
                                        <td style="text-align: center;">
                                            <c:choose>
                                            	<c:when test="${guideVo.guideType == '0'}"><input class="buttonMini" value="전체"></c:when>
                                            	<c:when test="${guideVo.guideType == '1'}"><input class="buttonMini" value="1종" style="background-color:#F6CECE;"></c:when>
                                            	<c:when test="${guideVo.guideType == '4'}"><input class="buttonMini" value="4종" style="background-color:#D8F6CE;"></c:when>
                                            </c:choose>                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>제목</th>
                                        <td colspan="4" style="text-align: left; padding-left: 5px;"><c:out value="${guideVo.title}"/></td>
                                        <td><a href="javascript:boardPrintPop(${guideVo.guideNo});"><input class="buttonMiniPrint" type="button" value="인쇄하기"></a></td>                                        
                                    </tr>

                                    <tr>
                                        <th>내용</th>
                                        <td colspan="5" style="text-align: left; padding-left: 5px;">
                                            ${guideVo.contents}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th><font color="blue">첨부파일</font></th>
                                        <td colspan="5" style="text-align: left; padding-left: 5px;">
                                            <c:forEach  var="item" items="${fileList}" varStatus="status">
                                                <u><a href="/brd_guide_file_down?file_no=${item.fileNo}"><font color="blue">${item.orignlFileNm}</font></a></u>
                                                <br>
                                            </c:forEach>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <p style="text-align:right;margin-top:10px;">
								<c:if test="${mbrVo_Session.user_no == guideVo.regUserNo || mbrVo_Session.user_state == 9 ||tmpAuthSessionVO.mbr_pms_26 == 1}">																
									<a href="#noloc" class="btn-vacation-aprv" id="btn_modify" style="background:#CEE3F6;">수정</a>
									<a href="#noloc" class="btn-vacation-aprv" id="btn_delete" style="background:#F6CED8;">삭제</a>
								</c:if>								
								<a href="#noloc" class="btn-vacation-aprv" id="btn_list">목록</a>								
							</p>
                            
                            <br />
                            <!-- memo -->
                            <input type="hidden" id="targetStr" value="guide" />
							<input type="hidden" id="linkNo" value="${guideVo.guideNo}" />
							<c:import url="../brd_common/board_memo_1.jsp"></c:import>
							<!-- //memo -->
                        </div>
                    </div>

                </div>
                <!-- banner -->
                <c:import url="../top_main/top_main_banner.jsp"></c:import>
                <!-- //banner -->
            </div>
        </div>
    </div>
    <!-- footer -->
    <c:import url="../top_main/top_main_footer.jsp"></c:import>
    <!-- //footer -->
</div>
<script type="text/javascript">
    $(document).ready(function () {
        _initButton();
    });

    //버튼 이벤트
    function _initButton() {
        $("#btn_list").on("click", function () {
            fnList();
        });
        <c:if test="${mbrVo_Session.user_no == guideVo.regUserNo || mbrVo_Session.user_state == 9 ||tmpAuthSessionVO.mbr_pms_26 == 1}">
        $("#btn_modify").on("click", function () {
            fnModify();
        });
        $("#btn_delete").on("click", function () {
            fnDelete();
        });
        </c:if>
    }

    function fnList() {        
        location.href = "./brdGuideBoardList?boardSrcType=${searchVO.boardSrcType}&boardSrcWord=${searchVO.boardSrcWord}&titleSearch=${searchVO.titleSearch}&reqPgNo=${reqPgNo}";        
    }

    <c:if test="${mbrVo_Session.user_no == guideVo.regUserNo || mbrVo_Session.user_state == 9 ||tmpAuthSessionVO.mbr_pms_26 == 1}">
    function fnModify() {
        var frm = document.getElementById("newFrm");
        frm.action = "/brd_guide_edit";
        frm.submit();
    }

    function fnDelete() {
        if (confirm("삭제하시겠습니까?")){
            var frm = document.getElementById("newFrm");
            frm.action = "/brd_guide_delete";
            frm.submit();
        }
    }
    </c:if>
    
	function boardPrintPop(guideNo){
		var cw=screen.availWidth;
		var ch=screen.availHeight;
		var sw=1010; //띄울 창의 넓이
		var sh=740;  //띄울 창의 높이
		var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
		var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
		window.open('./BoardGuidePrint?guide_no='+guideNo,'top','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
	}

</script>
<form id="newFrm" name="newFrm">
	<input type="hidden" id="guide_no" name="guide_no" value="${guideVo.guideNo }">
	<input type="hidden" name="boardSrcType" value="${searchVO.boardSrcType}">
	<input type="hidden" name="boardSrcWord" value="${searchVO.boardSrcWord}">
	<input type="hidden" id="titleSearch" name="titleSearch" value="${searchVO.titleSearch}" />
	<input type="hidden" name="reqPgNo" value="${reqPgNo}">
</form>

</body>
</html>
