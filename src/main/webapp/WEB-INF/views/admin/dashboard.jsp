<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Student Platform</title>
    <!-- Google Fonts - Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
   
    <link href="<c:url value='/resources/css/main.css' />" rel="stylesheet">
</head>
<body>
    <jsp:include page="../layout/header.jsp" />
    
    <div class="container py-4">
        <!-- Welcome Banner -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card bg-primary text-white shadow-lg rounded-3 border-0" style="opacity: 0.8;">
                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h2 class="display-6 fw-bold">Admin Dashboard</h2>
                                <p class="lead mb-0">Manage all aspects of the Student Platform</p>
                            </div>
                            <div class="text-center">
                                <div class="bg-white rounded-circle p-3 d-inline-block">
                                    <i class="bi bi-speedometer2 text-primary" style="font-size: 3rem;"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Stats Overview -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="card border-0 shadow-sm rounded-3 h-100">
                    <div class="card-body text-center">
                        <div class="bg-light rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
                            <i class="bi bi-people-fill text-primary" style="font-size: 2rem;"></i>
                        </div>
                        <h5 class="card-title">Students</h5>
                        <h2 class="display-6 fw-bold text-primary">${studentCount != null ? studentCount : 0}</h2>
                        <a href="/students" class="btn btn-sm btn-outline-primary mt-2">Manage</a>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card border-0 shadow-sm rounded-3 h-100">
                    <div class="card-body text-center">
                        <div class="bg-light rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
                            <i class="bi bi-person-badge text-success" style="font-size: 2rem;"></i>
                        </div>
                        <h5 class="card-title">Staff</h5>
                        <h2 class="display-6 fw-bold text-success">${staffCount != null ? staffCount : 0}</h2>
                        <a href="/staff" class="btn btn-sm btn-outline-success mt-2">Manage</a>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card border-0 shadow-sm rounded-3 h-100">
                    <div class="card-body text-center">
                        <div class="bg-light rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
                            <i class="bi bi-award text-info" style="font-size: 2rem;"></i>
                        </div>
                        <h5 class="card-title">Rewards</h5>
                        <h2 class="display-6 fw-bold text-info">${rewardCount != null ? rewardCount : 0}</h2>
                        <a href="/rewards" class="btn btn-sm btn-outline-info mt-2">Manage</a>
                    </div>
                </div>
            </div>
        
     
            <div class="col-md-3">
                <div class="card border-0 shadow-sm rounded-3 h-100">
                    <div class="card-body text-center">
                        <div class="bg-light rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
                            <i class="bi bi-people-fill text-primary" style="font-size: 2rem;"></i>
                        </div>
                        <h5 class="card-title">Attendance</h5>
                        <h2 class="display-6 fw-bold text-primary">${attendanceCount != null ? attendanceCount : 0}</h2>
                        <a href="${pageContext.request.contextPath}/admin/attendances" 
                        class="btn btn-sm btn-outline-primary mt-2">Manage</a>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Quick Actions -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card border-0 shadow-sm rounded-3">
                    <div class="card-header bg-white border-0 py-3">
                        <h5 class="mb-0"><i class="bi bi-lightning-charge text-primary me-2"></i> Quick Actions</h5>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-4">
                                <div class="card h-100 border-0 shadow-sm">
                                    <div class="card-body text-center">
                                        <i class="bi bi-people-fill text-primary" style="font-size: 2rem;"></i>
                                        <h5 class="mt-3">Manage Students</h5>
                                        <p>View, add, edit, or delete student records</p>
                                        <a href="/students" class="btn btn-primary">Student Management</a>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-md-4">
                                <div class="card h-100 border-0 shadow-sm">
                                    <div class="card-body text-center">
                                        <i class="bi bi-person-badge text-success" style="font-size: 2rem;"></i>
                                        <h5 class="mt-3">Manage Staff</h5>
                                        <p>View, add, edit, or delete staff records</p>
                                        <a href="/staff" class="btn btn-success">Staff Management</a>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-md-4">
                                <div class="card h-100 border-0 shadow-sm">
                                    <div class="card-body text-center">
                                        <i class="bi bi-award text-info" style="font-size: 2rem;"></i>
                                        <h5 class="mt-3">Manage Rewards</h5>
                                        <p>View, add, edit, or delete reward records</p>
                                        <a href="/rewards" class="btn btn-info text-white">Reward Management</a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card h-100 border-0 shadow-sm">
                                    <div class="card-body text-center">
                                        <i class="bi bi-calendar-event text-warning" style="font-size: 2rem;"></i>
                                        <h5 class="mt-3">Manage Events</h5>
                                        <p>View, add, edit, or delete event records</p>
                                        <a href="/admin/events" class="btn btn-warning">Event Management</a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card h-100 border-0 shadow-sm">
                                    <div class="card-body text-center">
                                        <i class="bi bi-people-fill text-primary" style="font-size: 2rem;"></i>
                                        <h5 class="mt-3">Manage Clubs</h5>
                                        <p>View, add, edit, or delete club records</p>
                                        <a href="${pageContext.request.contextPath}/admin/clubs" class="btn btn-primary">Club Management</a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card h-100 border-0 shadow-sm">
                                    <div class="card-body text-center">
                                        <i class="bi bi-calendar-check text-danger" style="font-size: 2rem;"></i>
                                        <h5 class="mt-3">Manage Attendance</h5>
                                        <p>View, add, edit, or delete attendance records</p>
                                        <a href="/admin/attendances" class="btn btn-danger">Attendance Management</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Pending Approvals -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card border-0 shadow-sm rounded-3">
                    <div class="card-header bg-white border-0 py-3">
                        <h5 class="mb-0"><i class="bi bi-hourglass-split text-warning me-2"></i> Pending Approvals</h5>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="card h-100 border-0 shadow-sm">
                                    <div class="card-body">
                                        <div class="d-flex align-items-center mb-3">
                                            <div class="bg-warning bg-opacity-25 rounded-circle p-2 me-3">
                                                <i class="bi bi-person-plus text-warning"></i>
                                            </div>
                                            <h5 class="mb-0">Student Registrations</h5>
                                        </div>
                                        <p>Review and approve/reject pending student account registrations</p>
                                        <a href="/admin/pending-students" class="btn btn-warning">View Pending Students</a>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="card h-100 border-0 shadow-sm">
                                    <div class="card-body">
                                        <div class="d-flex align-items-center mb-3">
                                            <div class="bg-warning bg-opacity-25 rounded-circle p-2 me-3">
                                                <i class="bi bi-person-badge text-warning"></i>
                                            </div>
                                            <h5 class="mb-0">Staff Registrations</h5>
                                        </div>
                                        <p>Review and approve/reject pending staff account registrations</p>
                                        <a href="/admin/pending-staff" class="btn btn-warning">View Pending Staff</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Participation Management 
        <div class="row mb-4">
            <div class="col-12">
                <div class="card border-0 shadow-sm rounded-3">
                    <div class="card-header bg-white border-0 py-3">
                        <h5 class="mb-0"><i class="bi bi-check-circle text-info me-2"></i> Participation Management</h5>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="card h-100 border-0 shadow-sm">
                                    <div class="card-body">
                                        <div class="d-flex align-items-center mb-3">
                                            <div class="bg-info bg-opacity-25 rounded-circle p-2 me-3">
                                                <i class="bi bi-people-fill text-info"></i>
                                            </div>
                                            <h5 class="mb-0">Club Participations</h5>
                                        </div>
                                        <p>Review and approve/reject pending club participation requests</p>
                                        <a href="/admin/club-participations" class="btn btn-info text-white">View Club Participations</a>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="card h-100 border-0 shadow-sm">
                                    <div class="card-body">
                                        <div class="d-flex align-items-center mb-3">
                                            <div class="bg-info bg-opacity-25 rounded-circle p-2 me-3">
                                                <i class="bi bi-calendar-event text-info"></i>
                                            </div>
                                            <h5 class="mb-0">Event Participations</h5>
                                        </div>
                                        <p>Review and approve/reject pending event participation requests</p>
                                        <a href="/admin/event-participations" class="btn btn-info text-white">View Event Participations</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
      
    </div>-->
    
    <jsp:include page="../layout/footer.jsp" />
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>