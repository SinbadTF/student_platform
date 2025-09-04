<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${activity.id != null ? 'Edit' : 'Add'} Activity - Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
        <div class="flex-grow-1" style="margin-left: 300px; padding-left: 1px;">
            <div class="container-fluid py-4">
                <!-- Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="mb-0">${activity.id != null ? 'Edit' : 'Add'} Activity</h2>
                    <a href="${pageContext.request.contextPath}/admin/activitymanagement" class="btn btn-outline-secondary">
                        <i class="bi bi-arrow-left me-2"></i>Back to Activities
                    </a>
                </div>

                <!-- Form -->
                <div class="card">
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/admin/activities/${activity.id != null ? 'update' : 'create'}" method="post" id="activityForm">
                            <c:if test="${activity.id != null}">
                                <input type="hidden" name="id" value="${activity.id}">
                            </c:if>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="title" class="form-label">Activity Title *</label>
                                        <input type="text" class="form-control" id="title" name="title" 
                                               value="${activity.title != null ? activity.title : ''}" 
                                               placeholder="Enter activity title" required>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="club" class="form-label">Club *</label>
                                        <select class="form-select" id="club" name="club.id" required>
                                            <option value="">Select a club</option>
                                            <c:forEach var="club" items="${clubs}">
                                                <option value="${club.id}" 
                                                        ${activity.club != null && activity.club.id == club.id ? 'selected' : ''}>
                                                    ${club.name}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="points" class="form-label">Points *</label>
                                        <input type="number" class="form-control" id="points" name="points" 
                                               value="${activity.points != null ? activity.points : ''}" 
                                               placeholder="Enter points value" min="1" required>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="description" class="form-label">Description</label>
                                        <textarea class="form-control" id="description" name="description" 
                                                  rows="3" placeholder="Enter activity description">${activity.description != null ? activity.description : ''}</textarea>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label for="clubDate" class="form-label">Club Date *</label>
                                        <input type="date" class="form-control" id="clubDate" name="clubDate" 
                                               value="${activity.clubDate != null ? activity.clubDate : ''}" 
                                               required>
                                    </div>
                                </div>
                                
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label for="startTime" class="form-label">Start Time *</label>
                                        <input type="time" class="form-control" id="startTime" name="startTime" 
                                               value="${activity.startTime != null ? activity.startTime : ''}" 
                                               required>
                                    </div>
                                </div>
                                
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label for="endTime" class="form-label">End Time *</label>
                                        <input type="time" class="form-control" id="endTime" name="endTime" 
                                               value="${activity.endTime != null ? activity.endTime : ''}" 
                                               required>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="mb-3">
                                        <label for="activityPlace" class="form-label">Activity Place *</label>
                                        <input type="text" class="form-control" id="activityPlace" name="activityPlace" 
                                               value="${activity.activityPlace != null ? activity.activityPlace : ''}" 
                                               placeholder="e.g., Room 101, Auditorium, Gym" required>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="d-flex justify-content-end gap-2">
                                <a href="${pageContext.request.contextPath}/admin/activitymanagement" class="btn btn-secondary">
                                    Cancel
                                </a>
                                <button type="submit" class="btn btn-success">
                                    <i class="bi bi-check-circle me-2"></i>${activity.id != null ? 'Update' : 'Create'} Activity
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Form Validation -->
    <script>
        document.getElementById('activityForm').addEventListener('submit', function(e) {
            var title = document.getElementById('title').value.trim();
            var club = document.getElementById('club').value;
            var points = document.getElementById('points').value;
            var clubDate = document.getElementById('clubDate').value;
            var startTime = document.getElementById('startTime').value;
            var endTime = document.getElementById('endTime').value;
            var activityPlace = document.getElementById('activityPlace').value.trim();
            
            if (title === '') {
                e.preventDefault();
                alert('Please enter an activity title');
                return false;
            }
            
            if (club === '') {
                e.preventDefault();
                alert('Please select a club');
                return false;
            }
            
            if (points === '' || points <= 0) {
                e.preventDefault();
                alert('Please enter valid points (must be greater than 0)');
                return false;
            }
            
            if (clubDate === '') {
                e.preventDefault();
                alert('Please select a club date');
                return false;
            }
            
            if (startTime === '') {
                e.preventDefault();
                alert('Please select a start time');
                return false;
            }
            
            if (endTime === '') {
                e.preventDefault();
                alert('Please select an end time');
                return false;
            }
            
            if (activityPlace === '') {
                e.preventDefault();
                alert('Please enter an activity place');
                return false;
            }
            
            // Validate that end time is after start time
            if (startTime >= endTime) {
                e.preventDefault();
                alert('End time must be after start time');
                return false;
            }
            
            return true;
        });
    </script>
</body>
</html>
