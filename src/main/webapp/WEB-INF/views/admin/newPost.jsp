<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="blog" tagdir="/WEB-INF/tags" %>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Blog</title>
        <meta http-equiv="Pragma" content="no-cache" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="base_url" content="<c:url value="/"/>" />
        <link href="${pageContext.request.contextPath}/style/style.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/style/lavalamp.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/style/syntaxhighlighter/shCore.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/style/syntaxhighlighter/shThemeDefault.css" rel="stylesheet" type="text/css" />
        <%--<script type="text/javascript" src="${pageContext.request.contextPath}/script/jquery-1.1.3.1.min.js"></script>--%>
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/script/blog.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/script/md5.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/script/syntaxhighlighter/shCore.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/script/syntaxhighlighter/shBrushJava.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/script/jquery.easing.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/script/jquery.lavalamp.min.js"></script>
        <script type="text/javascript">
            $(function() {
                $("#1, #2, #3").lavaLamp({
                    fx: "backout",
                    speed: 700,
                    click: function(event, menuItem) {
                        return true;
                    }
                });
            });
        </script>
    </head>

    <body>
        <div id = "page">
            <div id = "wrap">
                <div id = "topbg"></div>
                    <div id = "wrap2">
                        <div id = "header">
                            <div id = "headercontent"><span id = "sitename">Blog</span></div>
                            <div id = "topnav">
                                <ul class = "lavaLampWithImage" id = "1">
                                    <li class = "current"><blog:link href = "/app/home">Home</blog:link></li>
                                    <li><a href="">Styles</a></li>
                                    <li><a href="">Notes</a></li>
                                    <li><a href="">Credits</a></li>
                                </ul>
                            </div>
                        </div>
                        <div id = "content">
                            <div id = "left">
                                <div class = "post">
                                    <div class = "postheader"></div>
                                    <div class = "postcontent">
                                        <h2>Dodawanie postów</h2>
                                         <div class = "comments">
                                             <div id = "commentop"></div>
                                             <div class = "commentcontent">
                                                 <form:form id = "newPostForm"
                                                            action = "${pageContext.request.contextPath}/app/admin/newPost/create"
                                                            method = "post"
                                                            modelAttribute = "postObject"
                                                            acceptCharset = "UTF-8">

                                                     <div id = "errorContainer"></div>

                                                     <div class = "tags">
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
                            </div>
                            <div id = "sidebar">
                            </div>
                            <div class = "clear"></div>
                        </div>
                            <div id="footer"> Copyright &copy; Yoursitename.com
                            <div class="credit"><a href="http://ramblingsoul.com">CSS Template</a> by ramblingsoul</div>
                            </div>
                    </div>
                        <div id="btmbg"> </div>
            </div>
        </div>
    </body>
</html>

<script type="text/javascript">
    $("#ok-ajax").bind("click", $("form"), submitForm);
</script>