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
        <div class="bg-dark text-white position-fixed" style="width: 300px; min-height: 100vh; left: 0; top: 0; z-index: 1000;">
            <div class="p-3">
                <h5 class="text-white mb-4">
                    <i class="bi bi-trophy me-2"></i>ClubPoints Admin
                </h5>
                <p class="text-muted small mb-4">Administration Dashboard</p>
                
                <nav class="nav flex-column">
                    <a class="nav-link text-white-50 mb-2" href="${pageContext.request.contextPath}/admin/clubs">
                        <i class="bi bi-trophy me-2"></i>Club Dashboard
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
       <div class="flex-grow-1" style="margin-left: 300px; padding-left: 20px;">
        <div class="container-fluid py-4">
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h2 class="mb-1"><i class="bi bi-gear text-primary me-2"></i>Studet Monitoring</h2>
                                <p class="text-muted mb-0">Advanced student monitoring and settings</p>
                            </div>
                            <div>
                              <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-secondary">
                            <i class="bi bi-arrow-left me-2"></i>Back to Dashboard
                        </a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="d-flex justify-content-between align-items-center mb-4">
                    
                    <div class="d-flex align-items-center">
                        <div class="input-group me-3" style="width: 300px;">
                          
             
                        </div>
                       <!---- <div class="dropdown">
                            <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                <i class="bi bi-person-circle"></i>
                            </button>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="#">Profile</a></li>
                                <li><a class="dropdown-item" href="#">Settings</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="#">Logout</a></li>
                            </ul>
                        </div>-->
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
            <c:forEach var="club" items="${clubs}">
                <option value="${club.name}">${club.name}</option>
            </c:forEach>
        </select>
    </div>
    <div class="col-md-4">
        <label for="studentSearchFilter" class="form-label">Search Student</label>
        <input type="text" class="form-control" id="studentSearchFilter" placeholder="Search by name or ID...">
    </div>
    <div class="col-md-4 d-flex align-items-end justify-content-end">
        <a href="${pageContext.request.contextPath}/admin/activity-participations" class="btn btn-info">
            <i class="bi bi-check-circle"></i>Activity Approval
        </a>
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
                                    <c:forEach var="membership" items="${activeMemberships}">
                                        <tr>
                                            <td><strong><c:out value="${membership.student.studentId}"/></strong></td>
                                            <td>
                                                <c:out value="${membership.student.firstName}"/>
                                                <c:out value=" ${membership.student.lastName}"/>
                                            </td>
                                            <td><c:out value="${membership.club.name}"/></td>
                                            <td>
                                                <span class="badge bg-primary">
                                                    <c:out value="${activityCounts[membership.student.id] != null ? activityCounts[membership.student.id] : 0}"/>
                                                </span>
                                            </td>
                                            <td>
                                                <span class="badge bg-success">
                                                    <c:out value="${membership.student.points}"/>
                                                </span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty activeMemberships}">
                                        <tr>
                                            <td colspan="5" class="text-center text-muted">No active memberships found.</td>
                                        </tr>
                                    </c:if>
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
    
    <script>
    // Filter functionality
    document.addEventListener('DOMContentLoaded', function() {
        const clubFilter = document.getElementById('clubFilter');
        const studentSearchFilter = document.getElementById('studentSearchFilter');
        const tableRows = document.querySelectorAll('tbody tr');
        
        function filterTable() {
            const selectedClub = clubFilter.value.toLowerCase();
            const searchTerm = studentSearchFilter.value.toLowerCase();
            
            tableRows.forEach(row => {
                if (row.cells.length < 5) return; // Skip empty state row
                
                const clubName = row.cells[2].textContent.toLowerCase();
                const studentName = row.cells[1].textContent.toLowerCase();
                const studentId = row.cells[0].textContent.toLowerCase();
                
                const clubMatch = selectedClub === '' || clubName.includes(selectedClub);
                const searchMatch = searchTerm === '' || 
                    studentName.includes(searchTerm) || 
                    studentId.includes(searchTerm);
                
                if (clubMatch && searchMatch) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }
        
        // Add event listeners
        clubFilter.addEventListener('change', filterTable);
        studentSearchFilter.addEventListener('input', filterTable);
    });
    </script>
</body>
</html>
