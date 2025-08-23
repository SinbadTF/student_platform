<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account Pending - Student Platform</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Custom CSS -->
    <link href="<c:url value='/static/css/main.css' />" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container">
        <div class="row justify-content-center mt-5">
            <div class="col-md-8">
                <div class="card shadow-sm">
                    <div class="card-header bg-warning text-dark text-center">
                        <h3><i class="bi bi-clock-history"></i> Account Pending Approval</h3>
                    </div>
                    <div class="card-body p-4 text-center">
                        <c:if test="${not empty message}">
                            <div class="alert alert-info">${message}</div>
                        </c:if>
                        
                        <div class="mb-4">
                            <i class="bi bi-hourglass-split text-warning" style="font-size: 4rem;"></i>
                        </div>
                        
                        <h4>Your account registration is pending administrator approval</h4>
                        <p class="lead">Thank you for registering with the Student Platform. Your account is currently under review.</p>
                        <p>An administrator will verify your information and approve your account soon. Please check back later.</p>
                        
                        <div class="mt-4">
                            <a href="/login" class="btn btn-primary">Return to Login</a>
                        </div>
                    </div>
                    <div class="card-footer text-center text-muted">
                        <small>If you have any questions, please contact the system administrator.</small>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>