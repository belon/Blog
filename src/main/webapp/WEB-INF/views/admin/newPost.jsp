<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="blog" tagdir="/WEB-INF/tags" %>


<div class = "post">
    <div class = "postheader"></div>
    <div class = "postcontent">
        <h2 class="pt">Dodawanie postów</h2>
        <div class = "comments">
            <div id = "commentop"></div>
            <div class = "commentcontent">
                <form:form id = "newPostForm"
                           action = "${pageContext.request.contextPath}/app/admin/newPost/create"
                           method = "post"
                           modelAttribute = "postObject"
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
                            <form:input path = "title" size = "40" tabindex = "1" /><br/>
                            <form:errors path = "title" cssClass = "error" />
                        </p>

                        <p>
                            <label for = "author">Autor</label>
                            <form:input path = "author" size = "25" tabindex = "2" /><br/>
                            <form:errors path = "author" cssClass = "error" />
                        </p>
                    </div>

                    <p>
                        <label for = "content">Treść</label>
                        <form:textarea path = "content" cols = "68" rows = "15" tabindex = "4" style="background-color:white"/>
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
    $("#ok-ajax").bind("click", $("form"), submitForm);
</script>