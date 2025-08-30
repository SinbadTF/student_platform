<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pending Student Registrations - Student Platform</title>
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
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2><i class="bi bi-hourglass-split"></i> Pending Student Registrations</h2>
            <a href="/admin/dashboard" class="btn btn-outline-primary"><i class="bi bi-arrow-left"></i> Back to Dashboard</a>
        </div>
        <hr>
        
        <!-- Add error and success message display -->
        <c:if test="${not empty error}">  
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle-fill"></i> ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty success}">  
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle-fill"></i> ${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        
        <c:if test="${empty pendingStudents}">
            <div class="alert alert-info">
                <i class="bi bi-info-circle"></i> There are no pending student registrations at this time.
            </div>
        </c:if>
        
        <c:if test="${not empty pendingStudents}">
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-primary">
                        <tr>
                            <th>Username</th>
                            <th>Student ID</th>
                            <th>Email</th>
                            <th>Registration Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${pendingStudents}" var="student">
                            <tr>
                                <td>${student.username}</td>
                                <td>${student.studentId}</td>
                                <td>${student.email}</td>
                                <td><!-- Add registration date if available --></td>
                                <td>
                                    <div class="d-flex gap-2">
                                        <button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#editStudentModal${student.id}">
                                            <i class="bi bi-pencil"></i> Edit & Approve
                                        </button>
                                        <form action="/admin/reject-student/${student.id}" method="post" style="display:inline;">
                                            <input type="hidden" name="studentId" value="${student.studentId}">
                                            <button type="submit" class="btn btn-danger btn-sm">
                                                <i class="bi bi-x-circle"></i> Reject
                                            </button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                            
                            <!-- Edit Student Modal -->
                            <div class="modal fade" id="editStudentModal${student.id}" tabindex="-1" aria-labelledby="editStudentModalLabel${student.id}" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="editStudentModalLabel${student.id}">Edit Student Information</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <form action="/admin/approve-student/${student.id}" method="post" id="approveForm${student.id}" onsubmit="return validateStudentId(${student.id})">
                                            <div class="modal-body">
                                                <div class="mb-3">
                                                    <label for="username${student.id}" class="form-label">Username</label>
                                                    <input type="text" class="form-control" id="username${student.id}" value="${student.username}" readonly>
                                                </div>
                                                <div class="mb-3">
                                                    <label for="email${student.id}" class="form-label">Email</label>
                                                    <input type="email" class="form-control" id="email${student.id}" value="${student.email}" readonly>
                                                </div>
                                                <div class="mb-3">
                                                    <label for="studentId${student.id}" class="form-label">Student ID <span class="text-danger">*</span></label>
                                                    <input type="text" class="form-control" id="studentId${student.id}" name="studentId" value="${student.studentId}" required>
                                                    <div class="form-text">Format: TNT-**** (e.g., TNT-1234)</div>
                                                    <div class="invalid-feedback" id="studentIdFeedback${student.id}">
                                                        Student ID must follow the format TNT-**** (e.g., TNT-1234)
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                <button type="submit" class="btn btn-success">
                                                    <i class="bi bi-check-circle"></i> Save & Approve
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
    </div>
    
    <jsp:include page="../layout/footer.jsp" />
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Validation Script -->
    <script>
        function validateStudentId(studentId) {
            const studentIdInput = document.getElementById('studentId' + studentId);
            const studentIdValue = studentIdInput.value.trim();
            const studentIdPattern = /^TNT-\d{4}$/;
            
            if (!studentIdPattern.test(studentIdValue)) {
                studentIdInput.classList.add('is-invalid');
                document.getElementById('studentIdFeedback' + studentId).style.display = 'block';
                return false;
            }
            
            studentIdInput.classList.remove('is-invalid');
            document.getElementById('studentIdFeedback' + studentId).style.display = 'none';
            return true;
        }
    </script>
</body>
</html>