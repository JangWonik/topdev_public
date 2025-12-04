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
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
    <title>${title_Session}</title>
    <link rel="stylesheet" type="text/css" href="/resources/wm_css/style.css?v=201706291320" />
    <script src="/resources/jquery/jquery.min_1_12.js"></script>
    <script src="/resources/wm_js/common.js"></script>
    <style type="text/css">
    /*BestList*/
    	 .numberlist{
    		width:880px;
    	}
    	.numberlist ol{
    					counter-reset: li;
    					list-style: none;
    					*list-style: decimal;
    					font: 13px 'trebuchet MS','locida sans';
    					padding: -0;
    					margin-bottom: 1.5em;
     					margin-top: -2.0%
    					
    	}
    	.numberlist ol ol{
    	
                margin: 0 0 0 2em;
            }
        .numberlist a{
                position: relative;
                display: block;
                padding: .4em .4em .4em 2em;
                *padding: .1em;
                margin: .1em 5;
                background: #FFF;
                color: #444;
                text-decoration: none;
                -moz-border-radius: .3em;
                -webkit-border-radius: .3em;
                border-radius: .3em;
            }
        .numberlist a:hover{
                background: #cbe7f8;
                text-decoration:underline;
                
            }
		.numberlist a:before{
		                content: counter(li);
		                counter-increment: li;
		                position: absolute;
		                left: -0.5em;
		                top: 50%;
		                margin-top: -1.3em;
		                background: #5690c0;
		                height: 1.7em;
		                width: 1.7em;
		                line-height: 2em;
		                border: .4em solid #fff;
		                text-align: center;
		                font-weight: bold;
		                -moz-border-radius: 2em;
		                -webkit-border-radius: 2em;
		                border-radius: 2em;
		                color:#FFF;
		            }
            
           
    	
        .search_area{
            /*background-color: yellow;*/
            /*border: 1px solid red;*/
            width: 100%;
            height: 45px;
        }

        .search_box{
            display:inline-table;
            float: left;
            width: 300px;
            height: 45px;
            margin-top: -3.2%;
        }

        .search_box .content {
            display: table-cell;
            vertical-align: middle;
            text-align: center;
        }
        .search_box .content_right {
            display: table-cell;
            vertical-align: middle;
            text-align: right;
            
        }
    </style>
</head>
<body>

<div id="wrapper"><!-- wrapper -->
    <!-- skipnavi --><!-- header -->
    <c:import url="../top_main/top_main_menu.jsp"></c:import>
    <!-- //skipnavi --><!-- //header -->

    <div id="container">    <!-- container -->
        <div class="contetns">  <!-- contetns -->
            <c:import url="/top_main_left"></c:import>
            <div class="center_cnt" > <!-- centercnt_top -->
                <div class="centercnt_bot1-2" style="height:720px;"> <!-- centercnt_bot -->
                    <div class="guest" >
                   
                        <div class="search_area">
                            <div class="search_box1" style="width: 50%;">
                                <div class="content">
                                    &nbsp;
                                </div>
                            </div>

                            <div class="search_box" style="float: right">
                                <div class="content_right">
                                	<c:if test="${mbrVo_Session.user_state == 9 || mbrAuthVo_Session.mbr_pms_26 == 1}">
                           		         <a href="./brd_guide_write"><img src="/resources/ls_img/ls_board/btn_write.gif" /></a>                                	
                                	</c:if>
                                </div>
                            </div>
                        </div>

						<div class="search_box" style="float: right">
                        	<div class="content_right">
								<form id="srchFrm" name="srchFrm" method="get" action="/brd_guide_list" onsubmit="return fnSearch();">
									<input type="hidden" id="guide_type" name="guide_type" value="${srchArg.guide_type}">
									<input type="hidden" id="pageIdx" name="pageIdx"/>
									<input type="text" id="keyword" name="keyword" style="width: 60%;" value="${srchArg.keyword}">
									<input type="image" id="btn_search" style="width:56px;height:26px;"src="./resources/wm_img/common/bg_btnbg01.gif">
								</form>
							</div>
						</div>                        
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">사내규정 · 지침</a></li>
							</ul>
						</div> 
                        <div class="guestcnt4" style="display:block;" >
                            <div class="tableStyle2">
                                <table >
                                    <colgroup>
                                        <col width="10%">
                                        <col width="45%">
                                        <col width="5%">
                                        <col width="15%">
                                        <col width="15%">
                                        <col width="10%">
                                    </colgroup>
                                    <tr>
                                        <th>번호</th>
                                        <th>제목</th>
                                        <th>첨부</th>
                                        <th>작성자</th>
                                        <th>작성일</th>
                                        <th>조회</th>
                                    </tr>
                                    <c:forEach  var="item" items="${list}" varStatus="status">
                                        <tr>
                                            <td><a href="/brd_guide_view?guide_no=${item.guideNo}">${item.guideNo}</a></td>
                                            <td style="text-align: left;padding-left: 5px;"><a href="/brd_guide_view?guide_no=${item.guideNo}">
	                                            <c:if test="${item.guideType == 0}">[ 전 체 ] <c:out value="${item.title}"/></c:if>
	                                            <c:if test="${item.guideType == 1}"><font color=red>[ 1 종 ] </font><c:out value="${item.title}"/></c:if>
	                                            <c:if test="${item.guideType == 4}"><font color=blue>[ 4 종 ] </font><c:out value="${item.title}"/></c:if></a>
                                            </td>
                                            <td>
	                                            <c:if test="${item.fileCnt > 0}">
	                                            	<img alt="" src="./resources/ls_img/ls_board/icon_disket.gif">
	                                            </c:if>
                                            </td>
                                            <td>${item.userName}</td>
                                            <td>${item.regDate}</td>
                                            <td>${item.viewCnt}</td>
                                        </tr>
                                    </c:forEach>
                                </table>
                            </div>
                                <div class="pagingWrap">
                                    <%--<div class="pageContent">--%>
                                        <c:import url="/page_navi">
                                            <c:param name="beginIdx" value="${pageInfo.firstPageNoOnPageList}"/>
                                            <c:param name="endIdx" value="${pageInfo.lastPageNoOnPageList}"/>
                                            <c:param name="currentIdx" value="${pageInfo.currentPageNo}"/>
                                            <c:param name="totalPageCnt" value="${pageInfo.totalPageCount}"/>
                                        </c:import>
                                    <%--</div>--%>
                                </div>
                        </div>
                    </div>
                </div> <!-- centercnt_bot -->
<%--                 <c:import url="../top_main/top_main_banner.jsp"></c:import> --%>
            </div> <!-- centercnt_top -->
        </div>  <!-- contetns -->
    </div>  <!-- container -->

    <!-- footer -->
    <c:import url="../top_main/top_main_footer.jsp"></c:import>
    <!-- //footer -->
</div><!-- wrapper -->
<script type="text/javascript">
    $(document).ready(function () {
        _initButton();
    });
    //버튼 이벤트
    function _initButton() {
        $("#btn_search").on("click", function () {
            fnSearch();
        });
    }

    function fnSearch() {
        $("#guide_type").val("-1");
        var frm = document.getElementById("srchFrm");
        frm.submit();
    }

    function fnSetType(m) {
        $("#guide_type").val(m);
        var frm = document.getElementById("srchFrm");
        frm.submit();
    }

    function fnGoPage(pageIdx) {
        var frm = document.getElementById("srchFrm");
        frm.method = "get";
        frm.action = "./brd_guide_list";
        $("#pageIdx").val(pageIdx);
        frm.submit();
    }

</script>
</body>
</html>
