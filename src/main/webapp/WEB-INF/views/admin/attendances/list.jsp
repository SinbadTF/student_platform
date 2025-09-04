<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Attendance Management - Admin</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    
    <link href="<c:url value='/resources/css/main.css' />" rel="stylesheet">
</head>
<body>
    <jsp:include page="../../layout/header.jsp" />
    
    <div class="container mt-4">
        <div class="row mb-3">
            <div class="col-md-6">
                <h2><i class="bi bi-calendar-check"></i> Attendance Management</h2>
            </div>
            <div class="col-md-6 text-end">
                <a href="/admin/attendances/calculate-points" class="btn btn-success me-2">
                    <i class="bi bi-calculator"></i> Award All Points
                </a>
                <a href="/admin/attendances/create" class="btn btn-primary">
                    <i class="bi bi-plus-circle"></i> Add New Attendance
                </a>
            </div>
        </div>
        
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead class="table-primary">
                            <tr>
                                <th>Student ID</th>
                                <th>Student Name</th>
                                <th>Month</th>
                                <th>Year</th>
                                <th>Attendance %</th>
                                <th>Points Awarded</th>
                                <th>Created By</th>
                                <th>Created At</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${attendances}" var="attendance">
                                <tr>
                                    <td>${attendance.student.studentId}</td>
                                    <td>${attendance.student.firstName} ${attendance.student.lastName}</td>
                                    <td>${attendance.month}</td>
                                    <td>${attendance.year}</td>
                                    <td>${attendance.attendancePercentage}%</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${attendance.pointsAwarded}">
                                                <span class="badge bg-success">Yes</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-warning text-dark">No</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${attendance.createdBy.firstName} ${attendance.createdBy.lastName}</td>
                                    <td><fmt:formatDate value="${createdAt_attendance.id}" pattern="yyyy-MM-dd HH:mm" /></td>
                                    <td>
                                        <div class="d-flex gap-2">
                                            <a href="/admin/attendances/edit/${attendance.id}" class="btn btn-sm btn-warning">
                                                <i class="bi bi-pencil"></i>
                                            </a>
                                            <c:if test="${!attendance.pointsAwarded}">
                                                <a href="/admin/attendances/award-points/${attendance.id}" class="btn btn-sm btn-success">
                                                    <i class="bi bi-award"></i> Award Points
                                                </a>
                                            </c:if>
                                            <a href="/admin/attendances/delete/${attendance.id}" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete this attendance record?')">
                                                <i class="bi bi-trash"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="../../layout/footer.jsp" />
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>