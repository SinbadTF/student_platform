<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pending Staff Registrations - Student Platform</title>
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
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2><i class="bi bi-hourglass-split"></i> Pending Staff Registrations</h2>
            <a href="/admin/dashboard" class="btn btn-outline-primary"><i class="bi bi-arrow-left"></i> Back to Dashboard</a>
        </div>
        <hr>
        
        <c:if test="${empty pendingStaff}">
            <div class="alert alert-info">
                <i class="bi bi-info-circle"></i> There are no pending staff registrations at this time.
            </div>
        </c:if>
        
        <c:if test="${not empty pendingStaff}">
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-success">
                        <tr>
                            <th>Username</th>
                            <th>Staff ID</th>
                            <th>Email</th>
                            <th>Registration Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${pendingStaff}" var="staff">
                            <tr>
                                <td>${staff.username}</td>
                                <td>${staff.staffId}</td>
                                <td>${staff.email}</td>
                                <td><!-- Add registration date if available --></td>
                                <td>
                                    <div class="d-flex gap-2">
                                        <form action="/admin/approve-staff/${staff.id}" method="post" style="display:inline;">
                                            <button type="submit" class="btn btn-success btn-sm">
                                                <i class="bi bi-check-circle"></i> Approve
                                            </button>
                                        </form>
                                        <form action="/admin/reject-staff/${staff.id}" method="post" style="display:inline;">
                                            <button type="submit" class="btn btn-danger btn-sm">
                                                <i class="bi bi-x-circle"></i> Reject
                                            </button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
    </div>
    
    <jsp:include page="../layout/footer.jsp" />
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>