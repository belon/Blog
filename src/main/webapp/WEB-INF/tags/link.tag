<%@tag dynamic-attributes="attrs" description="basket"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@attribute name="href" required="true" type="java.lang.String"%>
<a href="<c:url value="${href}"/>"<c:forEach var="attr" items="${attrs}"> ${attr.key}="${attr.value}"</c:forEach>><jsp:doBody /></a>
