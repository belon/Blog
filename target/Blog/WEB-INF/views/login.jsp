<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib tagdir="/WEB-INF/tags" prefix="hood"%>


<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Pragma" content="no-cache" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    </head>

    <body>
        <c:if test="${not empty param.login_error}">
            <div class="errors">
                <p>
		Der Login-Versuch war nicht erfolgreich, bitte versuchen Sie es erneut.
                </p><p>
		Grund: ${sessionScope['SPRING_SECURITY_LAST_EXCEPTION'].localizedMessage}
                </p>
            </div>
        </c:if>
        <form name="f" action="<c:url value="/app/login/process" />" method="post">

            <table>
                <tr>
                    <td>
                        <label for="j_username">Nazwa użytkownika</label>
                    </td>
                    <td>
                        <input id="j_username"
                               name="j_username"
                               type="text"
                               <c:if test="${not empty param.login_error}"> value="${sessionScope['SPRING_SECURITY_LAST_USERNAME']}"</c:if> />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="j_password">Hasło</label>
                    </td>
                    <td>
                        <input id="j_password" name="j_password" type="password" />
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        <input id="rememberMe"
                               type="checkbox"
                               name="_spring_security_remember_me"
                               id="remember_me" />
                        <label for="rememberMe">Zapamiętaj</label>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        <input type="submit" name="submit" value="Login"/>
                    </td>
                </tr>
            </table>
        </form>
    </body>
</html>