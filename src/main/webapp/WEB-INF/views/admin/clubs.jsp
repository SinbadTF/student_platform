<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Club Management - Admin Dashboard</title>
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
                    <a class="nav-link text-white mb-2 active" 
                    href="${pageContext.request.contextPath}/admin/clubs">
                    <i class="bi bi-trophy me-2"></i>Club Dashboard
                 </a>
                    <a class="nav-link text-white-50 mb-2" 
                    href="${pageContext.request.contextPath}/admin/clubmanagement">
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
            <div class="container-fluid py-4">
        <!-- Header -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h2 class="mb-1"><i class="bi bi-trophy text-primary me-2"></i>Club Dashboard</h2>
                        <p class="text-muted mb-0">Manage all clubs and their activities</p>
                    </div>
                    <div>
                        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-secondary">
                            <i class="bi bi-arrow-left me-2"></i>Back to Dashboard
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Stats Cards -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="card border-0 shadow-sm">
                    <div class="card-body text-center">
                        <div class="bg-primary bg-opacity-10 rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                            <i class="bi bi-people-fill text-primary" style="font-size: 1.5rem;"></i>
                        </div>
                        <h4 class="fw-bold text-primary">${clubs != null ? clubs.size() : 0}</h4>
                        <p class="text-muted mb-0">Total Clubs</p>
                    </div>
                </div>
            </div>
   
    

        <!-- Actions Bar -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card border-0 shadow-sm">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h5 class="mb-0">Club Actions</h5>
                            </div>
                            <div>
                                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addClubModal">
                                    <i class="bi bi-plus-circle me-2"></i>Add New Club
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Clubs Table -->
        <div class="row">
            <div class="col-12">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white border-0 py-3">
                        <h5 class="mb-0"><i class="bi bi-list-ul me-2"></i>All Clubs</h5>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${clubs != null && !clubs.isEmpty()}">
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Club Name</th>
                                                <th>Description</th>
                                                <th>Meeting Schedule</th>
                                                <th>Members</th>
                                                <th>Status</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="club" items="${clubs}">
                                                <tr>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <div class="bg-primary bg-opacity-10 rounded-circle p-2 me-3">
                                                                <i class="bi bi-people-fill text-primary"></i>
                                                            </div>
                                                            <div>
                                                                <h6 class="mb-0">${club.name}</h6>
                                                                <small class="text-muted">ID: ${club.id}</small>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <p class="mb-0 text-truncate" style="max-width: 200px;">
                                                            ${club.description != null ? club.description : 'No description available'}
                                                        </p>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-info">${club.meetingScheduleTitle != null ? club.meetingScheduleTitle : 'No schedule set'}</span>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-primary">
                                                            <c:choose>
                                                                <c:when test="${not empty clubService}">
                                                                    ${clubService.getActiveMembershipsByClub(club).size()}
                                                                </c:when>
                                                                <c:otherwise>0</c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-success">Active</span>
                                                    </td>
                                                    <td>
                                                        <div class="btn-group" role="group">
                                                            <a href="${pageContext.request.contextPath}/admin/clubs/edit/${club.id}" 
                                                               class="btn btn-sm btn-outline-warning" title="Edit">
                                                                <i class="bi bi-pencil"></i>
                                                            </a>
                                                            <button class="btn btn-sm btn-outline-danger" title="Delete" 
                                                                    data-club-id="${club.id}" data-name="${fn:escapeXml(club.name)}" onclick="confirmDelete(this)">
                                                                <i class="bi bi-trash"></i>
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-5">
                                    <div class="bg-light rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
                                        <i class="bi bi-people text-muted" style="font-size: 2rem;"></i>
                                    </div>
                                    <h5 class="text-muted">No Clubs Found</h5>
                                    <p class="text-muted">Start by adding your first club to the system.</p>
                                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addClubModal">
                                        <i class="bi bi-plus-circle me-2"></i>Add First Club
                                    </button>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            </div>
        </div>
    </div>

    <!-- Add Club Modal -->
    <div class="modal fade" id="addClubModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Club</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form action="${pageContext.request.contextPath}/admin/clubs/create" method="post" id="createClubForm">
                        <div class="mb-3">
                            <label for="clubName" class="form-label">Club Name</label>
                            <input type="text" class="form-control" id="clubName" name="name" placeholder="Enter club name" required>
                        </div>
                        <div class="mb-3">
                            <label for="clubDescription" class="form-label">Description</label>
                            <textarea class="form-control" id="clubDescription" name="description" rows="3" placeholder="Enter club description"></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="clubMeetingSchedule" class="form-label">Meeting Schedule Title</label>
                            <input type="text" class="form-control" id="clubMeetingSchedule" name="meetingScheduleTitle" placeholder="e.g., Every Monday 2:00 PM, Weekly Friday 3:30 PM">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" form="createClubForm" class="btn btn-primary">Create Club</button>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="../layout/footer.jsp" />
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Success/Error Message Display -->
    <c:if test="${not empty success}">
        <div id="flash-success" class="alert alert-success alert-dismissible fade show position-fixed" style="top: 20px; right: 20px; z-index: 9999; min-width: 300px;">
            <i class="bi bi-check-circle me-2"></i><c:out value='${success}'/>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <script>
            setTimeout(function() {
                var el = document.getElementById('flash-success');
                if (el && el.parentNode) { el.remove(); }
            }, 5000);
        </script>
    </c:if>
    
    <c:if test="${not empty error}">
        <div id="flash-error" class="alert alert-danger alert-dismissible fade show position-fixed" style="top: 20px; right: 20px; z-index: 9999; min-width: 300px;">
            <i class="bi bi-exclamation-triangle me-2"></i><c:out value='${error}'/>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <script>
            setTimeout(function() {
                var el = document.getElementById('flash-error');
                if (el && el.parentNode) { el.remove(); }
            }, 5000);
        </script>
    </c:if>

    <script>
        // Form validation
        document.getElementById('createClubForm').addEventListener('submit', function(e) {
            var clubName = document.getElementById('clubName').value.trim();
            if (clubName === '') {
                e.preventDefault();
                alert('Please enter a club name');
                return false;
            }
        });
        
        // Clear form when modal is closed
        document.getElementById('addClubModal').addEventListener('hidden.bs.modal', function() {
            document.getElementById('createClubForm').reset();
        });
        
        // Delete confirmation function
        function confirmDelete(buttonEl) {
            var clubId = buttonEl.getAttribute('data-club-id');
            var clubName = buttonEl.getAttribute('data-name');
            if (confirm('Are you sure you want to delete the club "' + clubName + '"? This action cannot be undone.')) {
                // Create and submit delete form
                var form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/admin/clubs/delete/' + clubId;
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html>
