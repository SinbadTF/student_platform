<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Platform - Staff Portal</title>
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
    <!-- Additional custom styles can be removed as they're now in main.css -->
    <style>
        .logo-container {
            display: inline-flex;
            align-items: center;
        }
        .logo-img {
            height: 80px; /* Reduced size */
            margin-right: 10px;
            opacity: 0.9; /* Slightly transparent */
            transition: opacity 0.3s ease;
        }
        .logo-img:hover {
            opacity: 1;
        }
        .navbar-brand {
            display: flex;
            align-items: center;
            font-size: 1.25rem;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-success">
        <div class="container">
            <div class="navbar-brand logo-container" href="/staff/dashboard">
                <img src="<c:url value='/resources/images/university_logo.png' />" alt="University Logo" class="logo-img">
                
            </div>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="/staff/rewards/create">Create Rewards</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/staff/rewards/exchanges">Process Exchanges</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/staff/students">Manage Students</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/staff/profile">My Profile</a>
                    </li>
                </ul>
                
                <!-- User dropdown on the right -->
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                            <i class="bi bi-person-badge"></i> ${staff.firstName} ${staff.lastName}
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="/staff/profile">My Profile</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="/logout">Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="container mt-4">