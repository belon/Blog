<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="blog" tagdir="/WEB-INF/tags" %>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Pragma" content="no-cache" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="base_url" content="<c:url value="/"/>" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/style/blog.css" type="text/css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/style/jquery.tooltip.css" type="text/css"/>
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/script/jquery.tooltip.pack.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/script/blog.js"></script>
    </head>

    <body>
        <form:form id="newPostForm"
                   action="${pageContext.request.contextPath}/app/admin/newPost/create"
                   method="POST"
                   modelAttribute="postObject"
                   acceptCharset="UTF-8">

            <div id="errorContainer"></div>

            <dl class="clear">
                <dt>Tytuł</dt>
                <dd>
                    <form:input path="title"/><br/>
                    <form:errors path="title" cssClass="error"/>
                </dd>
                <dt>Author</dt>
                <dd>
                    <form:input path="author"/><br/>
                    <form:errors path="author" cssClass="error"/>
                </dd>
                <dt>Content</dt>
                <dd>
                    <form:textarea path="content"
                                   cols="50"
                                   rows="5"/>
                    <form:errors path="content" cssClass="error"/>
                </dd>

                <dd>
                    <input id="ok"
                           class="submit"
                           type="submit"
                           value="Dodaj"/>
                    <input id="ok-ajax"
                           class="submit"
                           type="submit"
                           value="Dodaj ajax"/>
                </dd>
            </dl>
        </form:form>
    </body>
</html>

<script type="text/javascript">
    $("#ok-ajax").bind("click", $("form"), submitForm);
</script>