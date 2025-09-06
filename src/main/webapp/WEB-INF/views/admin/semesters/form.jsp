<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${semester.id == null ? 'Create' : 'Edit'} Semester - Student Platform</title>
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
    <jsp:include page="../../layout/header.jsp" />
    
    <div class="container py-4">
        <div class="row mb-4">
            <div class="col-12">
                <div class="card shadow-sm rounded-3 border-0">
                    <div class="card-body p-4">
                        <h2 class="card-title mb-4">${semester.id == null ? 'Create' : 'Edit'} Semester</h2>
                        
                        <!-- Add this right after the <h2> tag and before the form -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                ${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>
                        
                        <form action="<c:url value='/admin/semesters/save' />" method="post">
                            <input type="hidden" name="id" value="${semester.id}" />
                            
                            <div class="mb-3">
                                <label for="name" class="form-label">Semester Name</label>
                                <select name="name" id="name" class="form-select" required>
                                    <option value="" selected disabled>Select Semester</option>
                                    <c:forEach items="${semesterNames}" var="semesterName">
                                        <option value="${semesterName}" ${semester.name == semesterName ? 'selected' : ''}>
                                            ${semesterName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div class="mb-3">
                                <label for="year" class="form-label">Year</label>
                                <input type="number" class="form-control" id="year" name="year" 
                                       value="${semester.year}" required min="2000" max="2100">
                            </div>
                            
                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" id="active" name="active" 
                                       ${semester.active ? 'checked' : ''}>
                                <label class="form-check-label" for="active">Active</label>
                            </div>
                            
                            <div class="d-flex justify-content-between">
                                <a href="<c:url value='/admin/semesters' />" class="btn btn-secondary">
                                    <i class="bi bi-arrow-left"></i> Back
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="bi bi-save"></i> Save
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>