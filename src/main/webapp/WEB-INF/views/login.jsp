<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Student Platform</title>
    <!-- Google Fonts - Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Custom CSS -->
    <link href="<c:url value='/resources/css/main.css' />" rel="stylesheet">
    <style>
        .logo-container {
            text-align: center;
            margin-bottom: 15px;
        }
        .logo-img {
            height: 85px; 
            opacity: 0.95; 
            transition: all 0.3s ease;
        }
        .logo-img:hover {
            opacity: 1;
            transform: scale(1.05);
        }
        .auth-card {
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }
        .auth-header {
            padding: 1.5rem;
        }
    </style>
</head>
<body class="bg-light">
    <div class="container">
        <div class="row justify-content-center align-items-center" style="min-height: 100vh;">
            <div class="col-md-5 animate-fade-in">
                <div class="card auth-card border-0">
                    <div class="card-header auth-header bg-primary text-white text-center border-0">
                        <div class="logo-container justify-content-center">
                            <img src="<c:url value='/resources/images/university_logo.png' />" alt="University Logo" class="logo-img">
                        </div>
                        <h3 class="mb-0">Student Platform Login</h3>
                    </div>
                    <div class="card-body p-4">
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger rounded-3">${error}</div>
                        </c:if>
                        <c:if test="${not empty message}">
                            <div class="alert alert-success rounded-3">${message}</div>
                        </c:if>
                        
                        <form action="/login" method="post" class="mt-2">
                            <div class="mb-3">
                                <label for="username" class="form-label">Username</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="bi bi-person"></i></span>
                                    <input type="text" class="form-control" id="username" name="username" placeholder="Enter your username" required>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="password" class="form-label">Password</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="bi bi-lock"></i></span>
                                    <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
                                </div>
                            </div>
                            <div class="mb-4">
                                <label for="role" class="form-label">Login As</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="bi bi-person-badge"></i></span>
                                    <select class="form-select" id="role" name="role" required>
                                        <option value="" selected disabled>Select Role</option>
                                        <option value="STUDENT">Student</option>
                                        <option value="STAFF">Staff</option>
                                        <option value="ADMIN">Admin</option>
                                    </select>
                                </div>
                            </div>
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary btn-lg">Login <i class="bi bi-box-arrow-in-right ms-2"></i></button>
                            </div>
                        </form>
                        <div class="text-center mt-4">
                            <p>Don't have an account? <a href="/register" class="text-primary fw-bold">Register here</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>