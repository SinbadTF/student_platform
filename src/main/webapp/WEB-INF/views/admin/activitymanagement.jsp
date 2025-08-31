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
        <div class="flex-grow-1 p-4">
            <div class="container-fluid">
                <!-- Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="mb-0">Activities Management</h2>
                    <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addActivityModal">
                        <i class="bi bi-plus-circle me-2"></i>Add New Activity
                    </button>
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
                                                    <td>${activity.description != null ? activity.description : 'No description available'}</td>
                                                    <td>
                                                        <button class="btn btn-sm btn-outline-success me-1" title="Edit">
                                                            <i class="bi bi-pencil"></i>
                                                        </button>
                                                        <button class="btn btn-sm btn-outline-danger" title="Delete">
                                                            <i class="bi bi-trash"></i>
                                                        </button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="5" class="text-center py-4">
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

    <!-- Add Activity Modal -->
    <div class="modal fade" id="addActivityModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Activity</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form action="${pageContext.request.contextPath}/admin/activities/create" method="post" id="createActivityForm">
                        <div class="mb-3">
                            <label for="activityTitle" class="form-label">Activity Title</label>
                            <input type="text" class="form-control" id="activityTitle" name="title" placeholder="Enter activity title" required>
                        </div>
                        <div class="mb-3">
                            <label for="activityClub" class="form-label">Club</label>
                            <select class="form-select" id="activityClub" name="club.id" required>
                                <option value="">Select Club</option>
                                <c:forEach var="club" items="${clubs}">
                                    <option value="${club.id}">${club.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="activityPoints" class="form-label">Points</label>
                            <input type="number" class="form-control" id="activityPoints" name="points" min="1" placeholder="Enter points" required>
                        </div>
                        <div class="mb-3">
                            <label for="activityDescription" class="form-label">Description</label>
                            <textarea class="form-control" id="activityDescription" name="description" rows="3" placeholder="Enter activity description" required></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" form="createActivityForm" class="btn btn-success">Add Activity</button>
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
            // Show success message
            document.addEventListener('DOMContentLoaded', function() {
                var successAlert = document.createElement('div');
                successAlert.className = 'alert alert-success alert-dismissible fade show position-fixed';
                successAlert.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 300px;';
                successAlert.innerHTML = '<i class="bi bi-check-circle me-2"></i>${success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button>';
                document.body.appendChild(successAlert);
                
                // Auto remove after 5 seconds
                setTimeout(function() {
                    if (successAlert.parentNode) {
                        successAlert.remove();
                    }
                }, 5000);
            });
        </c:if>
        
        <c:if test="${not empty error}">
            // Show error message
            document.addEventListener('DOMContentLoaded', function() {
                var errorAlert = document.createElement('div');
                errorAlert.className = 'alert alert-danger alert-dismissible fade show position-fixed';
                errorAlert.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 300px;';
                errorAlert.innerHTML = '<i class="bi bi-exclamation-triangle me-2"></i>${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button>';
                document.body.appendChild(errorAlert);
                
                // Auto remove after 5 seconds
                setTimeout(function() {
                    if (errorAlert.parentNode) {
                        errorAlert.remove();
                    }
                }, 5000);
            });
        </c:if>
        
        // Form validation
        document.getElementById('createActivityForm').addEventListener('submit', function(e) {
            var activityTitle = document.getElementById('activityTitle').value.trim();
            var activityClub = document.getElementById('activityClub').value;
            var activityPoints = document.getElementById('activityPoints').value;
            
            if (activityTitle === '') {
                e.preventDefault();
                alert('Please enter an activity title');
                return false;
            }
            
            if (activityClub === '') {
                e.preventDefault();
                alert('Please select a club');
                return false;
            }
            
            if (activityPoints === '' || activityPoints <= 0) {
                e.preventDefault();
                alert('Please enter valid points (greater than 0)');
                return false;
            }
        });
        
        // Clear form when modal is closed
        document.getElementById('addActivityModal').addEventListener('hidden.bs.modal', function() {
            document.getElementById('createActivityForm').reset();
        });
    </script>
</body>
</html>
