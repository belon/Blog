<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="blog" tagdir="/WEB-INF/tags" %>

<div id="bloglist">
    <c:forEach var="curPost" items="${posts}">
        <div class="blogentry">
            <div class="post" id="${curPost.id}">
                <div class="postheader"></div>
                <div class="postcontent">
                    <span class="date rightalign">${curPost.createDate}</span>
                    <span class="pt">
                        <h2>${curPost.title}</h2>
                    </span>
                    <p>
                        ${curPost.content}
                    </p>
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
                        <li class="comments_link">Pokaż komentarze</li>
                    </ul>
                </div>
            </div>
        </div>
    </c:forEach>
</div>