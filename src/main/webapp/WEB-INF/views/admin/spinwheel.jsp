<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Spinwheel Management - Admin Dashboard</title>
    <!-- Google Fonts - Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link href="<c:url value='/resources/css/main.css' />" rel="stylesheet">
    <style>
        .stats-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 8px 25px rgba(102,126,234,0.3);
        }
        .stats-card h3 {
            color: white;
            margin-bottom: 10px;
        }
        .stats-card .stat-item {
            background: rgba(255,255,255,0.1);
            border-radius: 10px;
            padding: 15px;
            margin: 10px 0;
            backdrop-filter: blur(10px);
        }
        .spinwheel-card {
            transition: all 0.3s ease;
            border-radius: 15px;
            overflow: hidden;
        }
        .spinwheel-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.15);
        }
        .status-badge {
            font-size: 0.8rem;
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-weight: 500;
        }
        .engagement-meter {
            height: 8px;
            border-radius: 4px;
            background: #e9ecef;
            overflow: hidden;
        }
        .engagement-fill {
            height: 100%;
            background: linear-gradient(90deg, #28a745 0%, #20c997 100%);
            transition: width 0.3s ease;
        }
    </style>
</head>
<body>
    <jsp:include page="../layout/header.jsp" />
    
    <div class="container py-4">
        <!-- Header -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h2 class="display-6 fw-bold">🎯 Spinwheel Management</h2>
                        <p class="lead mb-0">Create and manage spinwheels for student engagement</p>
                    </div>
                    <a href="/admin/spinwheels/create" class="btn btn-primary btn-lg shadow">
                        <i class="bi bi-plus-circle me-2"></i>Create New Spinwheel
                    </a>
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

        <!-- Statistics Overview -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="stats-card text-center">
                    <div class="bg-white bg-opacity-25 rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                        <i class="bi bi-circle-square text-white" style="font-size: 1.5rem;"></i>
                    </div>
                    <h3>${spinWheels.size()}</h3>
                    <p class="mb-0">Total Spinwheels</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card text-center">
                    <div class="bg-white bg-opacity-25 rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                        <i class="bi bi-play-circle text-white" style="font-size: 1.5rem;"></i>
                    </div>
                    <h3>
                        <c:set var="activeCount" value="0"/>
                        <c:forEach var="wheel" items="${spinWheels}">
                            <c:if test="${wheel.active}">
                                <c:set var="activeCount" value="${activeCount + 1}"/>
                            </c:if>
                        </c:forEach>
                        ${activeCount}
                    </h3>
                    <p class="mb-0">Active Spinwheels</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card text-center">
                    <div class="bg-white bg-opacity-25 rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                        <i class="bi bi-gift text-white" style="font-size: 1.5rem;"></i>
                    </div>
                    <h3>
                        <c:set var="totalItems" value="0"/>
                        <c:forEach var="wheel" items="${spinWheels}">
                            <c:set var="totalItems" value="${totalItems + wheel.items.size()}"/>
                        </c:forEach>
                        ${totalItems}
                    </h3>
                    <p class="mb-0">Total Prize Items</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card text-center">
                    <div class="bg-white bg-opacity-25 rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                        <i class="bi bi-graph-up text-white" style="font-size: 1.5rem;"></i>
                    </div>
                    <h3>
                        <c:set var="totalWeight" value="0"/>
                        <c:forEach var="wheel" items="${spinWheels}">
                            <c:forEach var="item" items="${wheel.items}">
                                <c:set var="totalWeight" value="${totalWeight + item.probabilityWeight}"/>
                            </c:forEach>
                        </c:forEach>
                        ${totalWeight}
                    </h3>
                    <p class="mb-0">Total Weight</p>
                </div>
            </div>
        </div>

        <!-- Spinwheels List -->
        <div class="row">
            <div class="col-12">
                <div class="card border-0 shadow-lg rounded-3">
                    <div class="card-header bg-white border-0 py-3">
                        <h5 class="mb-0"><i class="bi bi-circle-square text-primary me-2"></i>All Spinwheels</h5>
                    </div>
                    <div class="card-body p-0">
                        <c:choose>
                            <c:when test="${empty spinWheels}">
                                <div class="text-center py-5">
                                    <div class="bg-light rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
                                        <i class="bi bi-circle-square text-muted" style="font-size: 2rem;"></i>
                                    </div>
                                    <h5 class="text-muted">No Spinwheels Created Yet</h5>
                                    <p class="text-muted">Create your first spinwheel to start engaging students!</p>
                                    <a href="/admin/spinwheels/create" class="btn btn-primary">
                                        <i class="bi bi-plus-circle me-2"></i>Create First Spinwheel
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-hover mb-0">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Spinwheel</th>
                                                <th>Items</th>
                                                <th>Status</th>
                                                <th>Engagement</th>
                                                <th>Created</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="spinWheel" items="${spinWheels}">
                                                <tr>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <div class="bg-primary bg-opacity-10 rounded-circle p-2 me-3">
                                                                <i class="bi bi-circle-square text-primary"></i>
                                                            </div>
                                                            <div>
                                                                <h6 class="mb-0">${spinWheel.name}</h6>
                                                                <small class="text-muted">
                                                                    <c:if test="${not empty spinWheel.description}">
                                                                        ${spinWheel.description}
                                                                    </c:if>
                                                                    <c:if test="${empty spinWheel.description}">
                                                                        No description
                                                                    </c:if>
                                                                </small>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <span class="badge bg-info me-2">${spinWheel.items.size()} items</span>
                                                            <c:if test="${spinWheel.items.size() > 0}">
                                                                <small class="text-muted">
                                                                    <c:set var="avgWeight" value="0"/>
                                                                    <c:forEach var="item" items="${spinWheel.items}">
                                                                        <c:set var="avgWeight" value="${avgWeight + item.probabilityWeight}"/>
                                                                    </c:forEach>
                                                                    <c:set var="avgWeight" value="${avgWeight / spinWheel.items.size()}"/>
                                                                    Avg weight: <fmt:formatNumber value="${avgWeight}" maxFractionDigits="1"/>
                                                                </small>
                                                            </c:if>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${spinWheel.active}">
                                                                <span class="status-badge bg-success text-white">Active</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="status-badge bg-secondary text-white">Inactive</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <c:set var="engagementLevel" value="0"/>
                                                            <c:if test="${spinWheel.items.size() >= 3}">
                                                                <c:set var="engagementLevel" value="60"/>
                                                            </c:if>
                                                            <c:if test="${spinWheel.items.size() >= 5}">
                                                                <c:set var="engagementLevel" value="80"/>
                                                            </c:if>
                                                            <c:if test="${spinWheel.items.size() >= 8}">
                                                                <c:set var="engagementLevel" value="100"/>
                                                            </c:if>
                                                            <div class="engagement-meter me-2" style="width: 60px;">
                                                                <div class="engagement-fill" style="width: 0%;" data-width="${engagementLevel}"></div>
                                                            </div>
                                                            <small class="text-muted">${engagementLevel}%</small>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <small class="text-muted">
                                                            <fmt:formatDate value="${spinWheel.createdAt}" pattern="MMM dd, yyyy"/>
                                                        </small>
                                                    </td>
                                                    <td>
                                                        <div class="btn-group btn-group-sm">
                                                            <a href="/admin/spinwheels/edit/${spinWheel.id}" class="btn btn-outline-primary">
                                                                <i class="bi bi-pencil"></i>
                                                            </a>
                                                            <a href="/admin/spinwheels/view/${spinWheel.id}" class="btn btn-outline-info">
                                                                <i class="bi bi-eye"></i>
                                                            </a>
                                                            <c:choose>
                                                                <c:when test="${spinWheel.active}">
                                                                    <form action="/admin/spinwheels/deactivate/${spinWheel.id}" method="post" style="display: inline;">
                                                                        <button type="submit" class="btn btn-outline-warning" 
                                                                                onclick="return confirm('Deactivate this spinwheel?')">
                                                                            <i class="bi bi-pause"></i>
                                                                        </button>
                                                                    </form>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <form action="/admin/spinwheels/activate/${spinWheel.id}" method="post" style="display: inline;">
                                                                        <button type="submit" class="btn btn-outline-success">
                                                                            <i class="bi bi-play"></i>
                                                                        </button>
                                                                    </form>
                                                                </c:otherwise>
                                                            </c:choose>
                                                            <form action="/admin/spinwheels/delete/${spinWheel.id}" method="post" style="display: inline;">
                                                                <button type="submit" class="btn btn-outline-danger" 
                                                                        onclick="return confirm('Are you sure you want to delete this spinwheel?')">
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

        <!-- Engagement Tips -->
        <div class="row mt-4">
            <div class="col-12">
                <div class="card border-0 shadow-sm rounded-3">
                    <div class="card-header bg-gradient text-white border-0 py-3" 
                         style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                        <h6 class="mb-0"><i class="bi bi-lightbulb me-2"></i>Engagement Tips</h6>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="text-center p-3">
                                    <div class="bg-primary bg-opacity-10 rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                                        <i class="bi bi-1-circle text-primary" style="font-size: 1.5rem;"></i>
                                    </div>
                                    <h6 class="text-primary">Create Variety</h6>
                                    <p class="text-muted small">Mix high and low point rewards to keep students engaged</p>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="text-center p-3">
                                    <div class="bg-success bg-opacity-10 rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                                        <i class="bi bi-2-circle text-success" style="font-size: 1.5rem;"></i>
                                    </div>
                                    <h6 class="text-success">Use Colors</h6>
                                    <p class="text-muted small">Attractive colors make the spinwheel more appealing</p>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="text-center p-3">
                                    <div class="bg-warning bg-opacity-10 rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                                        <i class="bi bi-3-circle text-warning" style="font-size: 1.5rem;"></i>
                                    </div>
                                    <h6 class="text-warning">Balance Probabilities</h6>
                                    <p class="text-muted small">Set appropriate weights for fair and exciting gameplay</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>