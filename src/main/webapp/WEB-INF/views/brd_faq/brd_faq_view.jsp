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
                                <li class="on"><a href="#noloc">FAQ 글보기</a></li>
                            </ul>
                        </div>
                        <div class="guestcnt4" style="display:block;">
                            <div class="tableStyle2">
                                <table>
                                    <colgroup>
                                        <col width="20%">
                                        <col width="30%">
                                        <col width="20%">
                                        <col width="30%">
                                    </colgroup>
                                    <tr>
                                        <th>제목</th>
                                        <td colspan="3" style="text-align: left; padding-left: 5px;"><c:out value="${faqVo.title}"/></td>
                                    </tr>
                                    <tr>
                                        <th>작성일</th>
                                        <td style="text-align: left; padding-left: 5px;"><c:out value="${faqVo.regDate}"/></td>
                                        <th>분류</th>
                                        <td style="text-align: left; padding-left: 5px;">
                                            <c:forEach  var="item" items="${codeList}" varStatus="status">
                                                <c:if test="${faqVo.faqType == item.col_cd}">${item.col_val}</c:if>
                                            </c:forEach>
                                            <%--<c:choose>--%>
                                                <%--<c:when test="${faqVo.faqType == '0'}">인트라넷</c:when>--%>
                                                <%--<c:when test="${faqVo.faqType == '1'}">PRM</c:when>--%>
                                                <%--<c:when test="${faqVo.faqType == '2'}">보안</c:when>--%>
                                                <%--<c:when test="${faqVo.faqType == '3'}">기타</c:when>--%>
                                            <%--</c:choose>--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>베스트여부</th>
                                        <td style="text-align: left; padding-left: 5px;">
                                            <c:choose>
                                                <c:when test="${faqVo.bestAt == 'Y'}">예</c:when>
                                                <c:when test="${faqVo.bestAt == 'N'}">아니요</c:when>
                                            </c:choose>
                                        </td>
                                        <th>사용여부</th>
                                        <td style="text-align: left; padding-left: 5px;">
                                            <c:choose>
                                                <c:when test="${faqVo.useAt == 'Y'}">예</c:when>
                                                <c:when test="${faqVo.useAt == 'N'}">아니요</c:when>
                                            </c:choose>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>내용</th>
                                        <td colspan="3" style="text-align: left; padding-left: 5px;">
                                            ${faqVo.contents}
                                            <%--${fn:replace(faqVo.contents , CRLF , '<br>')}--%>
                                            <%--${fn:replace(fn:replace(fn:escapeXml(faqVo.contents) , CRLF , '<br>'), ' ', '&nbsp;')}--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th><font color="blue">첨부파일</font></th>
                                        <td colspan="3" style="text-align: left; padding-left: 5px;">
                                            <c:forEach  var="item" items="${fileList}" varStatus="status">
                                                <u><a href="/brd_faq_file_down?file_no=${item.fileNo}"><font color="blue">${item.orignlFileNm}</font></a></u><br>
                                            </c:forEach>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <p style="text-align:center;margin-top:10px;">
                                <a id="btn_list" href="#noloc"><img src="./resources/ls_img/ls_board/btn_list.gif" /></a>
                                <c:if test="${mbrVo_Session.user_no == faqVo.regUserNo || mbrVo_Session.user_state == 9}">
                                    <a id="btn_modify" href="#noloc"><img src="./resources/ls_img/ls_board/btn_modify.gif" /></a>
                                    <a id="btn_delete" href="#noloc"><img src="./resources/ls_img/ls_board/btn_del.gif"/></a>
                                </c:if>
                            </p>
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
        <c:if test="${mbrVo_Session.user_no == faqVo.regUserNo || mbrVo_Session.user_state == 9}">
        $("#btn_modify").on("click", function () {
            fnModify();
        });
        $("#btn_delete").on("click", function () {
            fnDelete();
        });
        </c:if>
    }

    function fnList() {
        location.href = "./brd_faq_list";
    }

    <c:if test="${mbrVo_Session.user_no == faqVo.regUserNo || mbrVo_Session.user_state == 9}">
    function fnModify() {
        var frm = document.getElementById("newFrm");
        frm.action = "/brd_faq_edit";
        //frm.method = "get";
        frm.submit();
    }

    function fnDelete() {
        if (confirm("삭제하시겠습니까?")){
            var frm = document.getElementById("newFrm");
            frm.action = "/brd_faq_delete";
            //frm.method = "post";
            frm.submit();
        }
    }
    </c:if>

</script>


<form id="newFrm" name="newFrm">
    <input type="hidden" id="faq_no" name="faq_no" value="${faqVo.faqNo}">
</form>
</body>
</html>
