<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="blog" tagdir="/WEB-INF/tags" %>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Pragma" content="no-cache" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="base_url" content="<c:url value="/"/>" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/style/style.css" type="text/css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/style/jquery.tooltip.css" type="text/css"/>
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/script/jquery.tooltip.pack.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/script/blog.js"></script>
    </head>

    <body>
        <form id="delPostForm" action="${pageContext.request.contextPath}/app/admin/delPost/ok"
              method="POST">
            <input type="hidden" value="${post.id}" name="id"/>
            <p>
                Czy na pewno chcesz usunąć post zatytułowany &quot;<c:out value="${post.title}"/>&quot;?
            </p>
            <br/><hr/><br/>
            <p style="text-align: center;">
                <input id="ok"
                       type="submit"
                       name="ok"
                       value="Tak"/>
                <input id="cancel"
                       type="submit"
                       name="cancel"
                       value="Nie"/>
            </p>
        </form>
    </body>
</html>
