<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="blog" tagdir="/WEB-INF/tags" %>

<form:form action="${pageContext.request.contextPath}/app/new/create"
           method="POST" 
           modelAttribute="newObject"
           acceptCharset="UTF-8">

    <div id="errorContainer">
        <form:errors cssClass="error" path="*"/>
    </div>

    <dl class="clear">
        <dt>Title</dt>
        <dd><form:input path="title"/><br/></dd>
        <dt>Content</dt>
        <dd>
            <form:textarea path="content"
                           cols="50"
                           rows="5"/>
        </dd>

        <dd>
            <input id="ok"
                   class="submit"
                   type="submit"
                   value="Create"/>
        </dd>
    </dl>

</form:form>