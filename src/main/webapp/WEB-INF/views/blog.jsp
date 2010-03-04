<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="blog" tagdir="/WEB-INF/tags" %>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Pragma" content="no-cache" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    </head>

    <body>
        <div id="page">
            <div>
                <c:forEach var="curPost" items="${posts}">
                    <h1>${curPost.title}</h1>
                    <h3>${curPost.content}</h3>
                </c:forEach>
            </div>
            <div>
                <ul>
                    <li>
                        <blog:link href="/app/new">Dodaj post...</blog:link>
                    </li>
                </ul>
            </div>
        </div>
    </body>
</html>