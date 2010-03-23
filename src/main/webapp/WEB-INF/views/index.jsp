<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="blog" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Blog</title>
        <meta http-equiv="Pragma" content="no-cache" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="base_url" content="<c:url value="/"/>" />
        <c:if test="${not empty param.login_error}">
            <meta name="showLoginForm" content="true" />
        </c:if>
        <link href="${pageContext.request.contextPath}/style/style.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/style/lavalamp.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/style/ui-lightness/style.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/style/syntaxhighlighter/shCore.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/style/syntaxhighlighter/shThemeDefault.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/script/jquery.easing.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/script/jquery.lavalamp.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/script/jquery-ui.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/script/index.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/script/blog.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/script/md5.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/script/paginator.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/script/syntaxhighlighter/shCore.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/script/syntaxhighlighter/shBrushJava.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/script/jquery.validate.js"></script>
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
                                <li class="current"><blog:link href="/app/index">Home</blog:link></li>
                                <li><a href="#">Styles</a></li>
                                <li><a href="#">Notes</a></li>
                                <li><a href="#">Credits</a></li>
                            </ul>
                        </div>
                    </div>

                    <div id="content">
                        <div id="left">
                            <div id="blogcontent">

                            </div>
                        </div>
                        <div id="sidebar">
                            <h3>Archiwum</h3>
                            <ul>
                                <li class="cat-item"><a href="#">Luty 2010</a></li>
                            </ul>
                            <h3>Admin</h3>
                            <ul>
                                <% if(!request.isUserInRole("ROLE_ADMIN")) { %>
                                    <li class="cat-item"><blog:link id="loginForm" href="#">Zaloguj się</blog:link></li>
                                <% } %>
                                <security:authorize ifAllGranted="ROLE_ADMIN">
                                    <li class="cat-item"><blog:link href="/app/logout">Wyloguj</blog:link></li>
                                    <li class="cat-item"><blog:link id="addPost" href="#">Dodaj post</blog:link></li>
                                </security:authorize>
                            </ul>
                            <h3>Tagi</h3>
                            <div id="tagStatistic">
                            </div>
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