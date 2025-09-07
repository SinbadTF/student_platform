<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Spinwheel Management - Admin</title>
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
        <!-- Header -->
        <div class="row mb-4">
            <div class="col-12">
                                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h2 class="display-6 fw-bold">Spinwheel Management</h2>
                            <p class="lead text-muted">Create and manage spinwheels for student engagement</p>
                        </div>
                        <div>
                            <a href="/admin/dashboard" class="btn btn-outline-primary me-2">
                                <i class="bi bi-speedometer2 me-2"></i>Dashboard
                            </a>
                            <a href="/admin/spinwheels/create" class="btn btn-primary">
                                <i class="bi bi-plus-circle me-2"></i>Create New Spinwheel
                            </a>
                        </div>
                    </div>
            </div>
        </div>

        <!-- Flash Messages -->
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle me-2"></i>${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle me-2"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Spinwheels List -->
        <div class="row">
            <div class="col-12">
                <div class="card border-0 shadow-sm rounded-3">
                    <div class="card-header bg-white border-0 py-3">
                        <h5 class="mb-0"><i class="bi bi-arrow-repeat text-primary me-2"></i>Spinwheels</h5>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty spinWheels}">
                                <div class="text-center py-5">
                                    <i class="bi bi-arrow-repeat text-muted" style="font-size: 4rem;"></i>
                                    <h4 class="mt-3 text-muted">No Spinwheels Found</h4>
                                    <p class="text-muted">Create your first spinwheel to get started.</p>
                                    <a href="/admin/spinwheels/create" class="btn btn-primary">
                                        <i class="bi bi-plus-circle me-2"></i>Create Spinwheel
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Name</th>
                                                <th>Description</th>
                                                <th>Status</th>
                                                <th>Items</th>
                                                <th>Created</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="spinWheel" items="${spinWheels}">
                                                <tr>
                                                    <td>
                                                        <strong>${spinWheel.name}</strong>
                                                    </td>
                                                    <td>
                                                        <span class="text-muted">${spinWheel.description}</span>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${spinWheel.active}">
                                                                <span class="badge bg-success">Active</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-secondary">Inactive</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-info">${spinWheel.items.size()} items</span>
                                                    </td>
                                                    <td>
                                                        ${spinWheel.createdAt}
                                                    </td>
                                                    <td>
                                                        <div class="btn-group" role="group">
                                                            <a href="/admin/spinwheels/edit/${spinWheel.id}" 
                                                               class="btn btn-sm btn-outline-primary">
                                                                <i class="bi bi-pencil"></i>
                                                            </a>
                                                            <c:choose>
                                                                <c:when test="${spinWheel.active}">
                                                                    <form method="post" action="/admin/spinwheels/deactivate/${spinWheel.id}" 
                                                                          style="display: inline;">
                                                                        <button type="submit" class="btn btn-sm btn-outline-warning"
                                                                                onclick="return confirm('Are you sure you want to deactivate this spinwheel?')">
                                                                            <i class="bi bi-pause"></i>
                                                                        </button>
                                                                    </form>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <form method="post" action="/admin/spinwheels/activate/${spinWheel.id}" 
                                                                          style="display: inline;">
                                                                        <button type="submit" class="btn btn-sm btn-outline-success">
                                                                            <i class="bi bi-play"></i>
                                                                        </button>
                                                                    </form>
                                                                </c:otherwise>
                                                            </c:choose>
                                                            <form method="post" action="/admin/spinwheels/delete/${spinWheel.id}" 
                                                                  style="display: inline;">
                                                                <button type="submit" class="btn btn-sm btn-outline-danger"
                                                                        onclick="return confirm('Are you sure you want to delete this spinwheel? This action cannot be undone.')">
                                                                    <i class="bi bi-trash"></i>
                                                                </button>
                                                            </form>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:otherwise>
                        </c:choose>
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
