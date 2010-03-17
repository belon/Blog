<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="blog" tagdir="/WEB-INF/tags" %>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Blog</title>
        <meta http-equiv="Pragma" content="no-cache" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="base_url" content="<c:url value="/"/>" />
        <link href="${pageContext.request.contextPath}/style/style.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/style/lavalamp.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/style/ui-lightness/style.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/script/jquery.easing.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/script/jquery.lavalamp.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/script/jquery-ui.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/script/index.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/script/blog.js"></script>
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
                            <div id="blogcontent">

                            </div>
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