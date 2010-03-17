<%-- 
    Document   : addComment
    Created on : 2010-03-15, 21:16:21
    Author     : Mirek
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<br/><hr/><br/>

        <form:form
            id = "addCommentForm"
            action = "${pageContext.request.contextPath}/app/addComment/create"
            method = "post"
            modelAttribute = "commentObject"
            acceptCharset = "UTF-8">

            <div id = "errorContainer"></div>

            <form:input path = "post_id" name = "post_id" id = "post_id" type="hidden" value="<%= request.getParameter("id") %>" />
            <p>
                <label class="commentlabel" for = "author">Autor</label>
                <form:input path = "author" size = "22" /><br/>
                <form:errors path = "author" cssClass = "error" />
            </p>
            <p>
                <label class="commentlabel" for = "email">Email</label>
                <form:input path = "email" size = "22" type = "text"/><br/>
                <form:errors path = "email" cssClass = "error" />
            </p>
            <p>
                <label class="commentlabel" for = "content">Treść</label>
                <form:textarea path = "content" cols = "55" rows = "10" style = "background-color: white;" /><br/>
                <form:errors path = "content" cssClass = "error" />
            </p>
            <p style="margin-left: 4em;">
                <input name = "submit" id = "addComment" value = "Dodaj komentarz" type = "submit"/>
            </p>
        </form:form>

<script type="text/javascript">
    //$("#addComment").bind("click", $("#addCommentForm"), submitForm);
</script>
