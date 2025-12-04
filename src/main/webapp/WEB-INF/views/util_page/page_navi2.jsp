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
<div class="paging">
    <c:choose>
        <c:when test="${currentIdx == 1}">
            <a href="#noloc"><<</a>
            <a href="#noloc"><</a>
        </c:when>
        <c:otherwise>
            <a href="#noloc" onclick="fnGoPage(${firstIdx});"><<</a>
            <a href="#noloc" onclick="fnGoPage(${prevIdx});"><</a>
        </c:otherwise>
    </c:choose>
    <c:forEach var="idx" begin="${beginIdx}" end="${endIdx}">
        <c:choose>
            <c:when test="${idx == currentIdx}">
                <a href="#noloc" class="on"><c:out value="${idx}" /></a>
            </c:when>
            <c:otherwise>
                <a href="#noloc" onclick="fnGoPage(${idx})"><c:out value="${idx}" /></a>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    <c:choose>
        <c:when test="${currentIdx == lastIdx}">
            <a href="#noloc">></a>
            <a href="#noloc">>></a>
        </c:when>
        <c:otherwise>
            <a href="#noloc" onclick="fnGoPage(${nextIdx})">></a>
            <a href="#noloc" onclick="fnGoPage(${lastIdx})">>></a>
        </c:otherwise>
    </c:choose>
</div>


