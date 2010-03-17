<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib tagdir="/WEB-INF/tags" prefix="hood"%>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Pragma" content="no-cache" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <link href="${pageContext.request.contextPath}/style/style.css" rel="stylesheet" type="text/css" />
    </head>

    <body>
        <div class="post">
            <div class="postheader"></div>
            <div class="postcontent">
                <h2 class="pt">Logowanie</h2>
                <div class="comments">
                    <div class="commentop"></div>
                    <div class="commentcontent">
                        <form name="f" action="<c:url value="/app/login/process" />" method="post">

                            <div id="loginError" class="errors" style="display: none; visibility: hidden;">
                                <h3>Próba logowania nie powiodła się, proszę spróbować ponownie.</h3>
                                <h3>Powód: ${sessionScope['SPRING_SECURITY_LAST_EXCEPTION'].localizedMessage}</h3>
                            </div>
                            
                            <p>
                                <label for="j_username">Nazwa użytkownika</label>
                                <input id="j_username"
                                       name="j_username"
                                       type="text"
                                       size="30"
                                       <c:if test="${not empty param.login_error}"> value="${sessionScope['SPRING_SECURITY_LAST_USERNAME']}"</c:if> />
                            </p>
                            <p>
                                <label for="j_password">Hasło</label>
                                <input id="j_password" name="j_password" type="password" />
                            </p>
                            <p>
                                <input id="rememberMe"
                                       type="checkbox"
                                       name="_spring_security_remember_me"
                                       id="remember_me"/>
                                <label for="rememberMe" style="display:inline;">Zapamiętaj</label>
                            </p>
                            <p>
                                <input type="submit" name="submit" value="Zaloguj" />
                            </p>
                        </form>
                    </div>
                    <div id = "commentbtm"></div>
                </div>
            </div>
        </div>
    </body>
</html>