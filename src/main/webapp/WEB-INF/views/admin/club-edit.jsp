<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Club - Admin Dashboard</title>
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
                    <a class="nav-link text-white mb-2 active" href="${pageContext.request.contextPath}/admin/clubmanagement">
                        <i class="bi bi-gear me-2"></i>Club Management
                    </a>
                    <a class="nav-link text-white-50 mb-2" href="${pageContext.request.contextPath}/admin/activitymanagement">
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
        <div class="container-fluid py-4">                <!-- Header -->
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h2 class="mb-1"><i class="bi bi-pencil-square text-primary me-2"></i>Edit Club</h2>
                                <p class="text-muted mb-0">Update club information</p>
                            </div>
                            <div>
                                <a href="${pageContext.request.contextPath}/admin/clubmanagement" class="btn btn-outline-secondary">
                                    <i class="bi bi-arrow-left me-2"></i>Back to Club Management
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Edit Club Form -->
                <div class="row">
                    <div class="col-12">
                        <div class="card border-0 shadow-sm">
                            <div class="card-header bg-white border-0 py-3">
                                <h5 class="mb-0"><i class="bi bi-edit me-2"></i>Edit Club: ${club.name}</h5>
                            </div>
                            <div class="card-body">
                                <form action="${pageContext.request.contextPath}/admin/clubs/update/${club.id}" method="post" id="editClubForm">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="clubName" class="form-label">Club Name</label>
                                                <input type="text" class="form-control" id="clubName" name="name" 
                                                       value="${club.name}" placeholder="Enter club name" required>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="clubMeetingSchedule" class="form-label">Meeting Schedule Title</label>
                                                <input type="text" class="form-control" id="clubMeetingSchedule" name="meetingScheduleTitle" 
                                                       value="${club.meetingScheduleTitle}" placeholder="e.g., Every Monday 2:00 PM, Weekly Friday 3:30 PM">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="clubDescription" class="form-label">Description</label>
                                        <textarea class="form-control" id="clubDescription" name="description" rows="4" 
                                                  placeholder="Enter club description">${club.description}</textarea>
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <a href="${pageContext.request.contextPath}/admin/clubmanagement" class="btn btn-secondary">
                                            <i class="bi bi-x-circle me-2"></i>Cancel
                                        </a>
                                        <button type="submit" class="btn btn-primary">
                                            <i class="bi bi-check-circle me-2"></i>Update Club
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="../layout/footer.jsp" />
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Form validation -->
    <script>
        document.getElementById('editClubForm').addEventListener('submit', function(e) {
            var clubName = document.getElementById('clubName').value.trim();
            if (clubName === '') {
                e.preventDefault();
                alert('Please enter a club name');
                return false;
            }
        });
    </script>
</body>
</html>
