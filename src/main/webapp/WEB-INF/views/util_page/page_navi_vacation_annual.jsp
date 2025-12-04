<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: icwking
  Date: 2015. 9. 22.
  Time: 오후 6:42
  To change this template use File | Settings | File Templates.
--%>
<c:set var="beginIdx" value="${param.beginIdx}" />
<c:set var="endIdx" value="${param.endIdx}" />
<c:set var="totalPageCnt" value="${param.totalPageCnt}" />
<c:set var="currentIdx" value="${param.currentIdx}" />




<c:set var="firstIdx" value="1" />
<c:set var="lastIdx" value="${totalPageCnt}" />
<c:set var="prevIdx" value="${currentIdx - 1}" />
<c:set var="nextIdx" value="${currentIdx + 1}" />

<%--
${param.beginIdx} <BR/>
${param.endIdx} <BR/>
${param.totalPageCnt} <BR/>
${param.currentIdx} <BR/>
${lastIdx} <BR/>
${prevIdx} <BR/>
${nextIdx} <BR/>
--%>
<ul class="pagination no-margin">
    <c:choose>
        <c:when test="${currentIdx == 1}">
            <li class="disabled"><a href="#">처음</a></li>
            <li class="disabled"><a href="#">이전</a></li>
        </c:when>
        <c:otherwise>
            <li><a href="#" onclick="fnGoAnnualPage(${firstIdx});">처음</a></li>
            <li><a href="#" onclick="fnGoAnnualPage(${prevIdx});">이전</a></li>
        </c:otherwise>
    </c:choose>
    <c:forEach var="idx" begin="${beginIdx}" end="${endIdx}">
        <c:choose>
            <c:when test="${idx == currentIdx}">
                <li class="active"><a href="#"><c:out value="${idx}" /></a></li>
            </c:when>
            <c:otherwise>
                <li><a href="#" onclick="fnGoAnnualPage(${idx})"><c:out value="${idx}" /></a></li>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    <c:choose>
        <c:when test="${currentIdx == lastIdx}">
            <li class="disabled"><a href="#">다음</a></li>
            <li class="disabled"><a href="#">마지막</a></li>
        </c:when>
        <c:otherwise>
            <li><a href="#" onclick="fnGoAnnualPage(${nextIdx})">다음</a></li>
            <li><a href="#" onclick="fnGoAnnualPage(${lastIdx})">마지막</a></li>
        </c:otherwise>
    </c:choose>
</ul>


