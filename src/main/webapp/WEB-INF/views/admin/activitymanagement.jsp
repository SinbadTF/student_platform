<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Activities Management - Admin Dashboard</title>
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
                    <a class="nav-link text-white mb-2 active" href="${pageContext.request.contextPath}/admin/activitymanagement">
                        <i class="bi bi-calendar me-2"></i>Activity Management
                    </a>
                    <a class="nav-link text-white-50 mb-2" href="${pageContext.request.contextPath}/admin/studentmonitoring">
                        <i class="bi bi-mortarboard me-2"></i>Student Monitoring
                    </a>
                </nav>
            </div>
        </div>

          <!-- Main Content -->
          <div class="flex-grow-1" style="margin-left: 300px; padding-left: 1px;">
            <div class="container-fluid py-4">
                <!-- Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="mb-0"><i class="bi bi-calendar text-primary me-2"></i>Activities Management</h2>
                    <a href="${pageContext.request.contextPath}/admin/activities/create" class="btn btn-success">
                        <i class="bi bi-plus-circle me-2"></i>Add New Activity
                    </a>
                </div>

                <!-- Filter Section -->
                <div class="row mb-4">
                    <div class="col-md-4">
                        <label for="clubFilter" class="form-label">Filter by Club</label>
                        <select class="form-select" id="clubFilter">
                            <option value="">All Clubs</option>
                            <option value="Computer Science Club">Computer Science Club</option>
                            <option value="Debate Society">Debate Society</option>
                            <option value="Art Club">Art Club</option>
                            <option value="Sports Club">Sports Club</option>
                        </select>
                    </div>
                </div>

                <!-- Activities Table -->
                <div class="card">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead class="table-light">
                                    <tr>
                                        <th>ACTIVITY TITLE</th>
                                        <th>CLUB</th>
                                        <th>POINTS</th>
                                        <th>DATE</th>
                                        <th>TIME</th>
                                        <th>PLACE</th>
                                        <th>DESCRIPTION</th>
                                        <th>ACTIONS</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${activities != null && !activities.isEmpty()}">
                                            <c:forEach var="activity" items="${activities}">
                                                <tr>
                                                    <td>${activity.title}</td>
                                                    <td>${activity.club != null ? activity.club.name : 'No club assigned'}</td>
                                                    <td><span class="badge bg-primary">${activity.points}</span></td>
                                                    <td>${activity.clubDate != null ? activity.clubDate : 'Not set'}</td>
                                                    <td>
                                                        <c:if test="${activity.startTime != null && activity.endTime != null}">
                                                            ${activity.startTime} - ${activity.endTime}
                                                        </c:if>
                                                        <c:if test="${activity.startTime == null || activity.endTime == null}">
                                                            Not set
                                                        </c:if>
                                                    </td>
                                                    <td>${activity.activityPlace != null ? activity.activityPlace : 'Not set'}</td>
                                                    <td>${activity.description != null ? activity.description : 'No description available'}</td>
                                                    <td>
                                                        <a href="/admin/activities/edit/${activity.id}" class="btn btn-sm btn-outline-success me-1" title="Edit">
                                                            <i class="bi bi-pencil"></i>
                                                        </a>
                                                        <a href="/admin/activities/delete/${activity.id}" class="btn btn-sm btn-outline-danger" title="Delete"
                                                           onclick="return confirm('Are you sure you want to delete the activity &quot;${activity.title}&quot;? This action cannot be undone.')">
                                                            <i class="bi bi-trash"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="8" class="text-center py-4">
                                                    <i class="bi bi-calendar-event text-muted" style="font-size: 2rem;"></i>
                                                    <h6 class="text-muted mt-2">No activities found</h6>
                                                    <p class="text-muted">Create your first activity to get started!</p>
                                                </td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>



    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Success/Error Message Display -->
    <script>
        // Check for flash messages
        <c:if test="${not empty success}">
            document.addEventListener('DOMContentLoaded', function() {
                var successAlert = document.createElement('div');
                successAlert.className = 'alert alert-success alert-dismissible fade show position-fixed';
                successAlert.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 300px;';
                successAlert.innerHTML = '<i class="bi bi-check-circle me-2"></i>${success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button>';
                document.body.appendChild(successAlert);
                
                setTimeout(function() {
                    if (successAlert.parentNode) {
                        successAlert.remove();
                    }
                }, 5000);
            });
        </c:if>
        
        <c:if test="${not empty error}">
            document.addEventListener('DOMContentLoaded', function() {
                var errorAlert = document.createElement('div');
                errorAlert.className = 'alert alert-danger alert-dismissible fade show position-fixed';
                errorAlert.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 300px;';
                errorAlert.innerHTML = '<i class="bi bi-exclamation-triangle me-2"></i>${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button>';
                document.body.appendChild(errorAlert);
                
                setTimeout(function() {
                    if (errorAlert.parentNode) {
                        errorAlert.remove();
                    }
                }, 5000);
            });
        </c:if>
    </script>
</body>
</html>
