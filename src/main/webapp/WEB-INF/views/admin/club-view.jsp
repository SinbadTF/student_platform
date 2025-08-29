<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${club.name} - Admin View</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Custom CSS -->
    <link href="<c:url value='/resources/css/main.css' />" rel="stylesheet">
</head>
<body>
    <jsp:include page="../layout/header.jsp" />
    
    <div class="container mt-4">
        <div class="card mb-4">
            <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                <h2><i class="bi bi-people-fill"></i> ${club.name}</h2>
                <div>
                    <a href="/admin/clubs/edit/${club.id}" class="btn btn-light"><i class="bi bi-pencil"></i> Edit</a>
                    <a href="/admin/clubs/delete/${club.id}" class="btn btn-danger ms-2" onclick="return confirm('Are you sure you want to delete this club?')"><i class="bi bi-trash"></i> Delete</a>
                </div>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <h4>Club Details</h4>
                        <table class="table table-bordered">
                            <tr>
                                <th width="30%">Name</th>
                                <td>${club.name}</td>
                            </tr>
                            <tr>
                                <th>Description</th>
                                <td>${club.description}</td>
                            </tr>
                            <tr>
                                <th>Meeting Location</th>
                                <td>${club.meetingLocation}</td>
                            </tr>
                            <tr>
                                <th>Meeting Schedule</th>
                                <td>${club.meetingSchedule}</td>
                            </tr>
                            <tr>
                                <th>Created By</th>
                                <td>${club.createdBy.firstName} ${club.createdBy.lastName}</td>
                            </tr>
                        </table>
                    </div>
                    
                    <div class="col-md-6">
                        <h4>Club Statistics</h4>
                        <div class="row text-center">
                            <div class="col-6">
                                <div class="card bg-light mb-3">
                                    <div class="card-body">
                                        <h3>${approvedParticipations.size()}</h3>
                                        <p class="mb-0">Active Members</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="card bg-light mb-3">
                                    <div class="card-body">
                                        <h3>${pendingParticipations.size()}</h3>
                                        <p class="mb-0">Pending Requests</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Award Points Form -->
                        <div class="card mt-3">
                            <div class="card-header bg-success text-white">
                                <h5>Award Points to Members</h5>
                            </div>
                            <div class="card-body">
                                <form action="/admin/award-club-points/${club.id}" method="post">
                                    <div class="mb-3">
                                        <label for="pointValue" class="form-label">Point Value</label>
                                        <input type="number" name="pointValue" id="pointValue" class="form-control" required min="1" value="10">
                                    </div>
                                    <div class="mb-3">
                                        <label for="reason" class="form-label">Reason</label>
                                        <input type="text" name="reason" id="reason" class="form-control" required placeholder="e.g., Active participation">
                                    </div>
                                    <button type="submit" class="btn btn-success">Award Points</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Pending Participation Requests -->
                <div class="mt-4">
                    <h4>Pending Participation Requests</h4>
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Student</th>
                                <th>Student ID</th>
                                <th>Department</th>
                                <th>Joined At</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="participation" items="${pendingParticipations}">
                                <tr>
                                    <td>${participation.student.firstName} ${participation.student.lastName}</td>
                                    <td>${participation.student.studentId}</td>
                                    <td>${participation.student.department}</td>
                                    <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${participation.joinedAt}" /></td>
                                    <td>
                                        <form action="/admin/approve-club-participation/${participation.id}" method="post" style="display:inline;">
                                            <button type="submit" class="btn btn-success btn-sm">Approve</button>
                                        </form>
                                        <form action="/admin/reject-club-participation/${participation.id}" method="post" style="display:inline;">
                                            <button type="submit" class="btn btn-danger btn-sm">Reject</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty pendingParticipations}">
                                <tr>
                                    <td colspan="5" class="text-center">No pending participation requests</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
                
                <!-- Approved Members -->
                <div class="mt-4">
                    <h4>Approved Members</h4>
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Student</th>
                                <th>Student ID</th>
                                <th>Department</th>
                                <th>Joined At</th>
                                <th>Approved At</th>
                                <th>Points Awarded</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="participation" items="${approvedParticipations}">
                                <tr>
                                    <td>${participation.student.firstName} ${participation.student.lastName}</td>
                                    <td>${participation.student.studentId}</td>
                                    <td>${participation.student.department}</td>
                                    <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${participation.joinedAt}" /></td>
                                    <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${participation.approvedAt}" /></td>
                                    <td>${participation.pointsAwarded ? 'Yes' : 'No'}</td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty approvedParticipations}">
                                <tr>
                                    <td colspan="6" class="text-center">No approved members</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
        <a href="/admin/clubs" class="btn btn-secondary">Back to Clubs</a>
    </div>
    
    <jsp:include page="../layout/footer.jsp" />
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>