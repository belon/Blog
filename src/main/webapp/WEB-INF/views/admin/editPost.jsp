<%-- 
    Document   : editPost
    Created on : 2010-03-18, 11:01:39
    Author     : Mirek
--%>

<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="blog" tagdir="/WEB-INF/tags" %>

<div class = "post">
    <div class = "postheader"></div>
    <div class = "postcontent">
        <h2 class="pt">Edycja posta</h2>
        <div class = "comments">
            <div id = "commentop"></div>
            <div class = "commentcontent">
                <form:form id = "editPostForm"
                           action = "${pageContext.request.contextPath}/app/admin/editPost/update?id=${post.id}"
                           method = "post"
                           modelAttribute = "post"
                           acceptCharset = "UTF-8">

                    <div id = "errorContainer"></div>

                    <div class = "tagss">
                        <p>
                            <label for = "tags">Tagi</label>
                            <form:select path = "tagIds"
                                         items = "${tags}"
                                         itemValue = "id"
                                         itemLabel = "name"
                                         multiple = "true"
                                         size = "5"
                                         style = "min-width: 100px;"
                                         tabindex = "3"/>
                        </p>
                    </div>

                    <div>
                        <p>
                            <label for = "title">Tytuł</label>
                            <form:input path = "title" value = "${post.title}" size = "40" tabindex = "1" /><br/>
                            <form:errors path = "title" cssClass = "error" />
                        </p>

                        <p>
                            <label for = "author">Autor</label>
                            <form:input path = "author" value = "${post.author}" size = "25" tabindex = "2" /><br/>
                            <form:errors path = "author" cssClass = "error" />
                        </p>
                    </div>

                    <p>
                        <label for = "content">Treść</label>
                        <textarea id = "content" name = "content" cols = "68" rows = "15" tabindex = "4" style="background-color:white" >${post.content}</textarea>
                        <form:errors path = "content" cssClass = "error" />
                    </p>

                    <p>
                        <input id = "ok"
                               class = "submit"
                               type = "submit"
                               value = "Wyślij"
                               tabindex = "5"/>

                        <input id = "ok-ajax"
                               class = "submit"
                               type = "submit"
                               value = "Wyślij (ajax)"
                               tabindex = "5" />
                    </p>

                </form:form>
            </div>
            <div id = "commentbtm"></div>
        </div>
    </div>
</div>

<script type="text/javascript">
    //$("#ok-ajax").bind("click", $("form"), submitForm);
</script>