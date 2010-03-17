<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="blog" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Blog</title>
        <meta http-equiv="Pragma" content="no-cache" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
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
        <div id="page">

            <div id="wrap">
                <div id="topbg"> </div>
                <div id="wrap2">

                    <div id="header">
                        <div id="headercontent"><span id="sitename">Blog</span></div>
                        <div id="topnav">
                            <ul class="lavaLampWithImage" id="1">
                                <li class="current"><blog:link href="/app/home">Home</blog:link></li>
                                <li><a href="">Styles</a></li>
                                <li><a href="">Notes</a></li>
                                <li><a href="">Credits</a></li>
                            </ul>
                        </div>
                    </div>
                    <div id="content">
                        <div id="left">
                            <div id="gravatars">
                                <img src="" alt="gravatar"/>
                                <img src="" alt="gravatar"/>
                                <img src="" alt="gravatar"/>
                                <img src="" alt="gravatar"/>
                            </div>
                            <c:forEach var="curPost" items="${posts}">
                                <div class="post">
                                    <div class="postheader"> </div>

                                    <div class="postcontent">
                                        <span class="date rightalign">${curPost.createDate}</span>
                                        <div class="pt"><h2>${curPost.title}</h2></div>
                                        <pre>${curPost.content}</pre>


                                        <div>
                                            Tagi:
                                            <c:forEach var="tag" items="${curPost.tags}">
                                                ${tag.name} &nbsp;
                                            </c:forEach>
                                        </div>
                                        <div>
                                            Komentarze:<br />
                                            <c:forEach var="comment" items="${curPost.comments}">
                                                ${comment.content} Autor: ${comment.author} Dodano: ${comment.created}<br />
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <div class="postbottom">
                                        <ul class="postmeta">
                                            <li class="permalink"><a href="http://www.free-css.com/">Permalink</a></li>
                                            <li class="category_link"><a href="http://www.free-css.com/">Category</a></li>
                                            <li class="comments_link"><a href="http://www.free-css.com/">25 Komentarzy</a></li>
                                            <security:authorize ifAllGranted="ROLE_ADMIN">
                                                <li class="delete_link"><blog:link href="/app/admin/delPost?id=${curPost.id}">Usuń post</blog:link></li>
                                            </security:authorize>
                                        </ul>
                                    </div>

                                </div>
                            </c:forEach>


                        </div>
                        <div id="sidebar">
                            <h3>Kategorie</h3>
                            <ul>
                                <li class="cat-item"><a href="">Lorem Ipsum </a></li>
                            </ul>
                            <h3>Archiwum</h3>
                            <ul>
                                <li><a href="">Luty 2010</a></li>
                            </ul>
                            <h3>Linki</h3>
                            <ul>
                                <li><a href="">Themes</a></li>
                            </ul>
                            <h3>Meta</h3>
                            <ul>
                                <li><a href="">Log in</a></li>
                                <li><blog:link href="/app/admin/newPost">Dodaj post...</blog:link></li>
                            </ul>
                        </div>
                        <div class="clear"></div>
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
    $('#gravatars img').attr("src", getGravatarFor("jaroslaw.bela@gmail.com"));
    SyntaxHighlighter.config.stripBrs = true;
    SyntaxHighlighter.all();
</script>