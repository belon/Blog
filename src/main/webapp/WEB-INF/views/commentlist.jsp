<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="blog" tagdir="/WEB-INF/tags" %>

<div class="commentlist">
    <c:forEach var="comment" items="${comments}">
        <div>Komentarz: ${comment.content}</div>
    </c:forEach>
</div>

<%@include file="addComment.jsp" %>