<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Student Platform</title>
    <!-- Google Fonts - Inter and Poppins -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Custom CSS -->
    <link href="<c:url value='/resources/css/main.css' />" rel="stylesheet">
    <style>
        :root {
            --primary: #4361ee;      /* Modern blue */
            --primary-light: #4895ef; /* Lighter blue */
            --secondary: #3f37c9;    /* Deep purple-blue */
            --accent: #4cc9f0;       /* Cyan accent */
            --light-bg: #f8f9fa;     /* Light background */
            --white: #ffffff;        /* Pure white */
            --gray-100: #f8f9fa;     /* Very light gray */
            --gray-200: #e9ecef;     /* Light gray */
            --gray-300: #dee2e6;     /* Medium light gray */
            --gray-800: #343a40;     /* Dark gray for text */
        }
        
        body {
            background-color: var(--light-bg);
            font-family: 'Inter', sans-serif;
            color: var(--gray-800);
        }
        
        .register-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, var(--gray-100) 0%, var(--white) 100%);
            position: relative;
            overflow: hidden;
        }
        
        /* Modern pattern background */
        .register-container::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: 
                radial-gradient(circle at 25% 25%, rgba(67, 97, 238, 0.03) 1%, transparent 5%),
                radial-gradient(circle at 75% 75%, rgba(76, 201, 240, 0.03) 1%, transparent 5%);
            background-size: 60px 60px;
            opacity: 0.8;
            z-index: 0;
        }
        
        .logo-container {
            text-align: center;
            margin-bottom: 1.5rem;
        }
        
        .logo-img {
            height: 90px; 
            opacity: 1; 
            transition: all 0.3s ease;
            filter: drop-shadow(0 4px 6px rgba(0, 0, 0, 0.1));
        }
        
        .logo-img:hover {
            transform: scale(1.05);
            filter: drop-shadow(0 6px 8px rgba(0, 0, 0, 0.15));
        }
        
        .auth-card {
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.1);
            background-color: var(--white);
            position: relative;
            z-index: 1;
            width: 100%;
            max-width: 550px; /* Slightly larger than login for more fields */
            border: none;
        }
        
        .auth-header {
            padding: 2.5rem 2rem 2rem; /* Increased padding */
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            position: relative;
        }
        
        .auth-header::after {
            content: "";
            position: absolute;
            bottom: -20px;
            left: 0;
            right: 0;
            height: 40px;
            background-color: var(--white);
            border-radius: 50% 50% 0 0 / 100% 100% 0 0;
            z-index: 1;
        }
        
        .card-body {
            padding: 2.5rem; /* Increased from 2rem */
            position: relative;
            z-index: 2;
        }
        
        .form-label {
            font-weight: 500;
            font-size: 1rem; /* Increased from 0.9rem */
            color: var(--gray-800);
            margin-bottom: 0.5rem;
        }
        
        .form-control, .form-select {
            padding: 0.85rem 1.2rem; /* Increased padding */
            border-radius: 12px; /* Increased from 10px */
            border: 1px solid var(--gray-200);
            background-color: var(--gray-100);
            transition: all 0.3s ease;
            font-size: 1rem; /* Increased from 0.95rem */
            height: auto; /* Ensure height is calculated from content */
        }
        
        .form-control:focus, .form-select:focus {
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.15);
            border-color: var(--primary-light);
            background-color: var(--white);
        }
        
        .input-group-text {
            border-radius: 12px 0 0 12px; /* Increased from 10px */
            border: 1px solid var(--gray-200);
            background-color: var(--gray-100);
            color: var(--primary);
            padding: 0.85rem 1.2rem; /* Match form control padding */
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            border: none;
            border-radius: 12px; /* Increased from 10px */
            padding: 0.85rem 1.5rem; /* Increased padding */
            font-weight: 600;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 15px rgba(67, 97, 238, 0.2);
            transition: all 0.3s ease;
            font-size: 1.1rem; /* Increased font size */
        }
        
        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(67, 97, 238, 0.3);
            background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
        }
        
        .text-primary {
            color: var(--primary) !important;
        }
        
        /* Floating elements animation */
        @keyframes float {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
            100% { transform: translateY(0px); }
        }
        
        .floating-element {
            position: absolute;
            opacity: 0.05;
            z-index: 0;
        }
        
        .floating-element:nth-child(1) {
            top: 10%;
            left: 10%;
            font-size: 80px;
            animation: float 8s ease-in-out infinite;
        }
        
        .floating-element:nth-child(2) {
            top: 20%;
            right: 15%;
            font-size: 60px;
            animation: float 9s ease-in-out infinite 1s;
        }
        
        .floating-element:nth-child(3) {
            bottom: 15%;
            left: 15%;
            font-size: 70px;
            animation: float 7s ease-in-out infinite 0.5s;
        }
        
        /* Add spacing between form elements */
        .mb-3 {
            margin-bottom: 1.5rem !important; /* Increased from default */
        }
        
        .mb-4 {
            margin-bottom: 2rem !important; /* Increased from default */
        }
        
        /* Make the register button larger */
        .btn-lg {
            padding: 1rem 2rem; /* Increased padding */
        }
        
        /* Improve responsive design */
        @media (max-width: 576px) {
            .auth-card {
                max-width: 100%;
                margin: 1rem;
            }
            
            .card-body {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="register-container">
        <!-- Floating elements for modern look -->
        <div class="floating-element"><i class="bi bi-mortarboard"></i></div>
        <div class="floating-element"><i class="bi bi-book"></i></div>
        <div class="floating-element"><i class="bi bi-award"></i></div>
        
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-12 animate-fade-in">
                    <div class="auth-card">
                        <div class="card-header auth-header text-white text-center border-0">
                            <div class="logo-container justify-content-center">
                                <img src="<c:url value='/resources/images/university_logo.png' />" alt="University Logo" class="logo-img">
                            </div>
                            <h2 class="mb-0">Create New Account</h2> <!-- Changed from h3 to h2 for larger text -->
                        </div>
                        <div class="card-body">
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger rounded-3">${error}</div>
                            </c:if>
                            
                            <form action="/register" method="post" class="mt-3"> <!-- Increased margin top -->
                                <div class="mb-3">
                                    <label for="username" class="form-label">Username</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-person"></i></span>
                                        <input type="text" class="form-control" id="username" name="username" placeholder="Choose a username" required>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="email" class="form-label">Email</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                                        <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email" required>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="password" class="form-label">Password</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-lock"></i></span>
                                        <input type="password" class="form-control" id="password" name="password" placeholder="Create a password" required>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="confirmPassword" class="form-label">Confirm Password</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm your password" required>
                                    </div>
                                </div>
                                <div class="mb-4">
                                    <label for="role" class="form-label">Register As</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-person-badge"></i></span>
                                        <select class="form-select" id="role" name="role" required>
                                            <option value="" selected disabled>Select Role</option>
                                            <option value="STUDENT">Student</option>
                                            <option value="STAFF">Staff</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn btn-primary btn-lg">Register <i class="bi bi-check-circle ms-2"></i></button>
                                </div>
                            </form>
                            <div class="text-center mt-4">
                                <p class="mb-0 fs-5">Already have an account? <a href="/login" class="text-primary fw-bold">Login here</a></p> <!-- Increased font size -->
                            </div>
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