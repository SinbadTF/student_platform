<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Error</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/main.css'/>"/>
    <style>
        .error-container { max-width: 720px; margin: 60px auto; padding: 24px; border: 1px solid #eee; border-radius: 8px; background: #fff; }
        .error-title { font-size: 20px; margin-bottom: 12px; }
        .error-details { color: #666; }
        .back-link { display: inline-block; margin-top: 16px; }
    </style>
    </head>
<body>
<div class="error-container">
    <div class="error-title">Something went wrong</div>
    <div class="error-details">
        <p>Status: <strong><c:out value="${status}"/></strong></p>
        <p>Message: <strong><c:out value="${message}"/></strong></p>
        <p>Path: <strong><c:out value="${path}"/></strong></p>
    </div>
    <a class="back-link" href="javascript:history.back()">Go Back</a>
    <span> | </span>
    <a class="back-link" href="<c:url value='/'/>">Home</a>
 </div>
</body>
</html>


