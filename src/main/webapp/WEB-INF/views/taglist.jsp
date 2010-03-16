<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="blog" tagdir="/WEB-INF/tags" %>

<div id="taglist">
    <c:forEach var="curTag" items="${tags}">
        <c:choose>
            <c:when test="${curTag.count > 0 && curTag.count < 5}">
                <a id="${curTag.id}" href="#" class="tag_link" style="font-size: 1em;">${curTag.name}</a>
            </c:when>
            <c:when test="${curTag.count >= 5 && curTag.count < 10}">
                <a id="${curTag.id}" href="#" class="tag_link" style="font-size: 1.5em;">${curTag.name}</a>
            </c:when>
            <c:when test="${curTag.count >= 10 && curTag.count < 15}">
                <a id="${curTag.id}" href="#" class="tag_link" style="font-size: 2em;">${curTag.name}</a>
            </c:when>
            <c:when test="${curTag.count >= 15 && curTag.count < 20}">
                <a id="${curTag.id}" href="#" class="tag_link" style="font-size: 2.5em;">${curTag.name}</a>
            </c:when>
            <c:when test="${curTag.count >= 20 && curTag.count < 25}">
                <a id="${curTag.id}" href="#" class="tag_link" style="font-size: 3em;">${curTag.name}</a>
            </c:when>
            <c:otherwise>
                <a id="${curTag.id}" href="#" class="tag_link" style="font-size: 3.5em;">${curTag.name}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>
</div>