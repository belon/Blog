<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="blog" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<div id="bloglist">
    <c:forEach var="curPost" items="${posts}" varStatus="status">
        <div class="blogentry">
            <div class="post" id="${curPost.id}">
                <div class="postheader"></div>
                <div class="postcontent">
                    <span class="date rightalign">${curPost.createDate}</span>
                    <div class="pt">
                        <h2>${curPost.title}</h2>
                    </div>
                    <div>
                        <pre style="font-size: 14px;">${curPost.content}</pre>
                    </div>
                    <div class="tags">
                        Tagi:
                        <c:forEach var="tag" items="${curPost.tags}">
                            ${tag.name} &nbsp;
                        </c:forEach>
                    </div>
                    <div class="comments">
                    </div>
                </div>
                <div class="postbottom">
                    <ul class="postmeta">
                        <li class="comments_link">
                            <a href="#">Pokaż komentarze</a>
                        </li>
                        <security:authorize ifAllGranted="ROLE_ADMIN">
                            <li class="permalink"><a href="#">Usuń post</a></li>
                        </security:authorize>
                    </ul>
                </div>
            </div>
        </div>
    </c:forEach>
</div>