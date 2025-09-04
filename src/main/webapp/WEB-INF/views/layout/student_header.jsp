<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Platform - Rewards Catalog</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link href="<c:url value='/resources/css/main.css?v=${System.currentTimeMillis()}' />" rel="stylesheet">
    <style>
        .logo-container {
            display: inline-flex;
            align-items: center;
        }
        .logo-img {
            height: 90px; 
            margin-right: 10px;
            opacity: 0.9; 
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
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <div class="navbar-brand logo-container" href="/students/dashboard">
                <img src="<c:url value='/resources/images/university_logo.png' />" alt="University Logo" class="logo-img">
            </div>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="/students/profile">My Profile</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/students/rewards/catalog">Available Rewards</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/students/rewards/history">My Redemptions</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/students/clubs">Clubs</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/events">Events</a>
                    </li>
                </ul>
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                            <i class="bi bi-person-circle"></i> ${student.firstName} ${student.lastName}
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="/students/profile">My Profile</a></li>
                            <li><a class="dropdown-item" href="/logout">Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="container mt-4">