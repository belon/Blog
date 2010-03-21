<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="blog" tagdir="/WEB-INF/tags" %>

<div class="commentlist">
    <div id="commentop"></div>
    <h2>Komentarze</h2>
        <div class="commentcontent">
            <ol>
                <c:forEach var="comment" items="${comments}" varStatus="loopStatus">
                    <li class="${loopStatus.index % 2 == 0 ? 'even' : 'odd'}">
                        <img src="${comment.email}" width="40" height="40" alt="Gravatar" class="gravatar" align="left" style="margin-right: 5px;margin-bottom:5px" />
                        <em>Autor: </em>${comment.author} <em>, dodano: </em>${comment.created}
                    <p>${comment.content}</p></li>
                </c:forEach>
            </ol>
    </div>
    <a href="#" onclick="return false;" class="addcomment">Dodaj komentarz</a>
    <div id="commentbtm"></div>
</div>

<%--<%@include file="addComment.jsp" %>--%>