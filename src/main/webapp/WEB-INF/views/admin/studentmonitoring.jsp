<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Monitoring - Admin Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link href="<c:url value='/resources/css/main.css' />" rel="stylesheet">
</head>
<body>
    <jsp:include page="../layout/header.jsp" />
    
    <div class="d-flex">
        <!-- Left Sidebar -->
        <div class="bg-dark text-white" style="width: 250px; min-height: 100vh;">
            <div class="p-3">
                <h5 class="text-white mb-4">
                    <i class="bi bi-trophy me-2"></i>ClubPoints Admin
                </h5>
                <p class="text-muted small mb-4">Administration Dashboard</p>
                
                <nav class="nav flex-column">
                    <a class="nav-link text-white-50 mb-2" href="${pageContext.request.contextPath}/admin/clubs">
                        <i class="bi bi-people me-2"></i>Club Dashboard
                    </a>
                    <a class="nav-link text-white-50 mb-2" href="${pageContext.request.contextPath}/admin/clubmanagement">
                        <i class="bi bi-gear me-2"></i>Club Management
                    </a>
                    <a class="nav-link text-white-50 mb-2" href="${pageContext.request.contextPath}/admin/activitymanagement">
                        <i class="bi bi-calendar me-2"></i>Activity Management
                    </a>
                    <a class="nav-link text-white mb-2 active" href="${pageContext.request.contextPath}/admin/studentmonitoring">
                        <i class="bi bi-mortarboard me-2"></i>Student Monitoring
                    </a>
                </nav>
            </div>
        </div>

        <!-- Main Content -->
        <div class="flex-grow-1 p-4">
            <div class="container-fluid">
                <!-- Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="mb-0">Student Monitoring</h2>
                    <div class="d-flex align-items-center">
                        <div class="input-group me-3" style="width: 300px;">
                            <span class="input-group-text">
                                <i class="bi bi-search"></i>
                            </span>
                            <input type="text" class="form-control" placeholder="Search...">
                        </div>
                        <div class="dropdown">
                            <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                <i class="bi bi-person-circle"></i>
                            </button>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="#">Profile</a></li>
                                <li><a class="dropdown-item" href="#">Settings</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="#">Logout</a></li>
                            </ul>
                        </div>
                    </div>
                </div>

                <!-- Student Monitoring Section -->
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title mb-4">Student Monitoring</h5>
                        
                        <!-- Filter Section -->
                        <div class="row mb-4">
                            <div class="col-md-4">
                                <label for="clubFilter" class="form-label">Select Club</label>
                                <select class="form-select" id="clubFilter">
                                    <option value="">All Clubs</option>
                                    <option value="Computer Science Club">Computer Science Club</option>
                                    <option value="Debate Society">Debate Society</option>
                                    <option value="Art Club">Art Club</option>
                                    <option value="Sports Club">Sports Club</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label for="studentSearch" class="form-label">Search Student</label>
                                <input type="text" class="form-control" id="studentSearch" placeholder="Search by name or ID...">
                            </div>
                        </div>

                        <!-- Students Table -->
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead class="table-light">
                                    <tr>
                                        <th>STUDENT ID</th>
                                        <th>NAME</th>
                                        <th>CLUB</th>
                                        <th>ACTIVITIES</th>
                                        <th>TOTAL POINTS</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><strong>S001</strong></td>
                                        <td>John Doe</td>
                                        <td>Computer Science Club, Debate Society</td>
                                        <td><span class="badge bg-primary">2</span></td>
                                        <td><span class="badge bg-success">110</span></td>
                                    </tr>
                                    <tr>
                                        <td><strong>S002</strong></td>
                                        <td>Jane Smith</td>
                                        <td>Computer Science Club, Art Club</td>
                                        <td><span class="badge bg-primary">2</span></td>
                                        <td><span class="badge bg-success">130</span></td>
                                    </tr>
                                    <tr>
                                        <td><strong>S003</strong></td>
                                        <td>Mike Johnson</td>
                                        <td>Debate Society, Sports Club</td>
                                        <td><span class="badge bg-primary">2</span></td>
                                        <td><span class="badge bg-success">100</span></td>
                                    </tr>
                                    <tr>
                                        <td><strong>S004</strong></td>
                                        <td>Sarah Wilson</td>
                                        <td>Computer Science Club</td>
                                        <td><span class="badge bg-primary">2</span></td>
                                        <td><span class="badge bg-success">125</span></td>
                                    </tr>
                                    <tr>
                                        <td><strong>S005</strong></td>
                                        <td>David Brown</td>
                                        <td>Art Club, Sports Club</td>
                                        <td><span class="badge bg-primary">1</span></td>
                                        <td><span class="badge bg-success">85</span></td>
                                    </tr>
                                    <tr>
                                        <td><strong>S006</strong></td>
                                        <td>Emily Davis</td>
                                        <td>Debate Society</td>
                                        <td><span class="badge bg-primary">3</span></td>
                                        <td><span class="badge bg-success">150</span></td>
                                    </tr>
                                    <tr>
                                        <td><strong>S007</strong></td>
                                        <td>Robert Miller</td>
                                        <td>Computer Science Club, Art Club, Sports Club</td>
                                        <td><span class="badge bg-primary">3</span></td>
                                        <td><span class="badge bg-success">175</span></td>
                                    </tr>
                                    <tr>
                                        <td><strong>S008</strong></td>
                                        <td>Lisa Garcia</td>
                                        <td>Art Club</td>
                                        <td><span class="badge bg-primary">1</span></td>
                                        <td><span class="badge bg-success">95</span></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <!-- Pagination -->
                        <nav aria-label="Student table pagination" class="mt-4">
                            <ul class="pagination justify-content-center">
                                <li class="page-item disabled">
                                    <a class="page-link" href="#" tabindex="-1">Previous</a>
                                </li>
                                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                <li class="page-item"><a class="page-link" href="#">2</a></li>
                                <li class="page-item"><a class="page-link" href="#">3</a></li>
                                <li class="page-item">
                                    <a class="page-link" href="#">Next</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
