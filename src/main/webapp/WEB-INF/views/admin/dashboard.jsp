<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Student Platform</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
   
    <link href="<c:url value='/resources/css/main.css' />" rel="stylesheet">
</head>
<body>
    <jsp:include page="../layout/header.jsp" />
    
    <div class="container mt-4">
        <h2><i class="bi bi-speedometer2"></i> Admin Dashboard</h2>
        <hr>
        
        <div class="row mt-4">
            <div class="col-md-4">
                <div class="card mb-4">
                    <div class="card-body text-center">
                        <i class="bi bi-people-fill text-primary" style="font-size: 3rem;"></i>
                        <h4 class="mt-3">Manage Students</h4>
                        <p>View, add, edit, or delete student records</p>
                        <a href="/students" class="btn btn-outline-primary">Student Management</a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="card mb-4">
                    <div class="card-body text-center">
                        <i class="bi bi-person-badge text-success" style="font-size: 3rem;"></i>
                        <h4 class="mt-3">Manage Staff</h4>
                        <p>View, add, edit, or delete staff records</p>
                        <a href="/staff" class="btn btn-outline-success">Staff Management</a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="card mb-4">
                    <div class="card-body text-center">
                        <i class="bi bi-award text-info" style="font-size: 3rem;"></i>
                        <h4 class="mt-3">Manage Rewards</h4>
                        <p>View, add, edit, or delete reward records</p>
                        <a href="/rewards" class="btn btn-outline-info">Reward Management</a>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- New row for Club and Event Management -->
        <div class="row mt-2">
            <div class="col-md-6">
                <div class="card mb-4">
                    <div class="card-body text-center">
                        <i class="bi bi-people-fill text-danger" style="font-size: 3rem;"></i>
                        <h4 class="mt-3">Manage Clubs</h4>
                        <p>View, add, edit, or delete club records</p>
                        <a href="/admin/clubs" class="btn btn-outline-danger">Club Management</a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-6">
                <div class="card mb-4">
                    <div class="card-body text-center">
                        <i class="bi bi-calendar-event text-warning" style="font-size: 3rem;"></i>
                        <h4 class="mt-3">Manage Events</h4>
                        <p>View, add, edit, or delete event records</p>
                        <a href="/admin/events" class="btn btn-outline-warning">Event Management</a>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row mt-2">
            <div class="col-md-6">
                <div class="card mb-4">
                    <div class="card-header bg-warning text-dark">
                        <h5><i class="bi bi-hourglass-split"></i> Pending Student Registrations</h5>
                    </div>
                    <div class="card-body">
                        <p>Review and approve/reject pending student account registrations</p>
                        <a href="/admin/pending-students" class="btn btn-warning">View Pending Students</a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-6">
                <div class="card mb-4">
                    <div class="card-header bg-warning text-dark">
                        <h5><i class="bi bi-hourglass-split"></i> Pending Staff Registrations</h5>
                    </div>
                    <div class="card-body">
                        <p>Review and approve/reject pending staff account registrations</p>
                        <a href="/admin/pending-staff" class="btn btn-warning">View Pending Staff</a>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- New row for Club and Event Participations -->
        <div class="row mt-2">
            <div class="col-md-6">
                <div class="card mb-4">
                    <div class="card-header bg-info text-white">
                        <h5><i class="bi bi-check-circle"></i> Club Participations</h5>
                    </div>
                    <div class="card-body">
                        <p>Review and approve/reject pending club participation requests</p>
                        <a href="/admin/club-participations" class="btn btn-info">View Club Participations</a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-6">
                <div class="card mb-4">
                    <div class="card-header bg-info text-white">
                        <h5><i class="bi bi-check-circle"></i> Event Participations</h5>
                    </div>
                    <div class="card-body">
                        <p>Review and approve/reject pending event participation requests</p>
                        <a href="/admin/event-participations" class="btn btn-info">View Event Participations</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="../layout/footer.jsp" />
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>