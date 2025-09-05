<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Details - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link href="<c:url value='/resources/css/main.css' />" rel="stylesheet">
</head>
<body>
    <jsp:include page="../layout/header.jsp" />

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2 class="mb-0">${event.name}</h2>
            <div>
                <a href="${pageContext.request.contextPath}/admin/events/edit/${event.id}" class="btn btn-warning">Edit</a>
                <a href="${pageContext.request.contextPath}/admin/events" class="btn btn-secondary ms-2">Back</a>
            </div>
        </div>

        <div class="row g-3">
            <div class="col-lg-8">
                <div class="card mb-3">
                    <div class="card-body">
                        <p class="mb-2"><strong>Description:</strong> ${event.description}</p>
                        <p class="mb-2"><strong>Location:</strong> ${event.location}</p>
                        <p class="mb-2"><strong>Start:</strong> ${event.startTime}</p>
                        <p class="mb-2"><strong>End:</strong> ${event.endTime}</p>
                        <p class="mb-0"><strong>Points:</strong> ${event.pointValue}</p>
                    </div>
                </div>

                

    <jsp:include page="../layout/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


