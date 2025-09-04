<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${attendance.id == null ? 'Create New Attendance Record' : 'Edit Attendance Record'} - Admin</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    
    <link href="<c:url value='/resources/css/main.css' />" rel="stylesheet">
</head>
<body>
    <jsp:include page="../../layout/header.jsp" />
    
    <div class="container mt-4">
        <div class="card">
            <div class="card-header bg-primary text-white">
                <h2><i class="bi bi-calendar-check"></i> ${attendance.id == null ? 'Create New Attendance Record' : 'Edit Attendance Record'}</h2>
            </div>
            <div class="card-body">
                <form:form action="/admin/attendances/save" method="post" modelAttribute="attendance">
                    <form:hidden path="id" />
                    
                    <div class="mb-3">
                        <label for="student" class="form-label">Student</label>
                        <select name="studentId" class="form-select" required>
                            <option value="">-- Select Student --</option>
                            <c:forEach items="${students}" var="student">
                                <option value="${student.id}" ${attendance.student != null && attendance.student.id == student.id ? 'selected' : ''}>
                                    ${student.studentId} - ${student.firstName} ${student.lastName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="month" class="form-label">Month</label>
                            <select name="month" class="form-select" required>
                                <option value="">-- Select Month --</option>
                                <c:forEach items="${months}" var="month">
                                    <option value="${month}" ${attendance.month == month ? 'selected' : ''}>
                                        ${month}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="year" class="form-label">Year</label>
                            <input type="number" name="year" class="form-control" value="${attendance.year != null ? attendance.year : currentYear}" min="2000" max="2100" required />
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="attendancePercentage" class="form-label">Attendance Percentage (%)</label>
                        <input type="number" name="attendancePercentage" class="form-control" value="${attendance.attendancePercentage}" min="0" max="100" step="0.01" required />
                        <small class="text-muted">Enter a value between 0 and 100. Points will be calculated as attendance percentage * 10.</small>
                    </div>
                    
                    <div class="mt-4">
                        <button type="submit" class="btn btn-primary">Save Attendance Record</button>
                        <a href="/admin/attendances" class="btn btn-secondary ms-2">Cancel</a>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
    
    <jsp:include page="../../layout/footer.jsp" />
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>