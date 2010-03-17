<%-- 
    Document   : addComment
    Created on : 2010-03-15, 21:16:21
    Author     : Mirek
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<br/>
        <form:form
            id = "addCommentForm"
            action = "${pageContext.request.contextPath}/app/addComment/create"
            method = "post"
            modelAttribute = "commentObject"
            acceptCharset = "UTF-8">

            <div id = "errorContainer"></div>

            <form:input path = "post_id" name = "post_id" id = "post_id" type="hidden" value="<%= request.getParameter("id") %>" />

            <p>
                <label for = "author">Autor</label>
                <form:input path = "author" size = "22" tabindex="1" />
                <form:errors path = "author" cssClass = "error" />
            </p>
            <p>
                <label for = "email">Email</label>
                <form:input path = "email" size = "22" tabindex = "2" type = "text"/>
                <form:errors path = "email" cssClass = "error" />
            </p>
            <p>
                <label for = "content">Treść</label>
                <form:textarea path = "content" cols = "40" rows = "10" tabindex = "3" />
                <form:errors path = "content" cssClass = "error" />
            </p>
            <p>
                <input name = "submit" id = "addComment" tabindex = "4" value = "Dodaj komentarz" type = "submit"/>
            </p>
        </form:form>

<script type="text/javascript">
    //$("#addComment").bind("click", $("#addCommentForm"), submitForm);
</script>
