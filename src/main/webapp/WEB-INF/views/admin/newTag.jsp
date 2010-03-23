<%-- 
    Document   : newTag
    Created on : 2010-03-23, 11:44:12
    Author     : Mirek
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <form:form id="newTagForm"
                   action="${pageContext.request.contextPath}/app/admin/newTag/create"
                   method="post"
                   modelAttribute="tagObject"
                   acceptCharset="UTF-8">

            <p>
                <label for = "name">Nazwa</label>
                <form:input path = "name" size = "20" /><br/>
                <form:errors path = "name" cssClass = "error" />
            </p>
        </form:form>
    </body>
</html>
