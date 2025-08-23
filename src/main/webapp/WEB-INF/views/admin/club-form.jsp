<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${club.id == null ? 'Create New Club' : 'Edit Club'} - Admin</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Custom CSS -->
    <link href="<c:url value='/static/css/main.css' />" rel="stylesheet">
</head>
<body>
    <jsp:include page="../layout/header.jsp" />
    
    <div class="container mt-4">
        <div class="card">
            <div class="card-header bg-primary text-white">
                <h2><i class="bi bi-people-fill"></i> ${club.id == null ? 'Create New Club' : 'Edit Club'}</h2>
            </div>
            <div class="card-body">
                <form:form action="/admin/clubs/save" method="post" modelAttribute="club">
                    <form:hidden path="id" />
                    
                    <div class="mb-3">
                        <label for="name" class="form-label">Club Name</label>
                        <form:input path="name" class="form-control" required="true" />
                        <form:errors path="name" cssClass="text-danger" />
                    </div>
                    
                    <div class="mb-3">
                        <label for="description" class="form-label">Description</label>
                        <form:textarea path="description" class="form-control" rows="4" required="true" />
                        <form:errors path="description" cssClass="text-danger" />
                    </div>
                    
                    <div class="mb-3">
                        <label for="meetingLocation" class="form-label">Meeting Location</label>
                        <form:input path="meetingLocation" class="form-control" />
                        <form:errors path="meetingLocation" cssClass="text-danger" />
                    </div>
                    
                    <div class="mb-3">
                        <label for="meetingSchedule" class="form-label">Meeting Schedule</label>
                        <form:input path="meetingSchedule" class="form-control" />
                        <form:errors path="meetingSchedule" cssClass="text-danger" />
                    </div>
                    
                    <form:hidden path="createdBy" value="${sessionScope.user.id}" />
                    
                    <div class="mt-4">
                        <button type="submit" class="btn btn-primary">Save Club</button>
                        <a href="/admin/clubs" class="btn btn-secondary ms-2">Cancel</a>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
    
    <jsp:include page="../layout/footer.jsp" />
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>