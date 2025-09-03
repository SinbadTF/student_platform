<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${spinWheel.id == null ? 'Create' : 'Edit'} Spinwheel - Admin Dashboard</title>
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
        .color-preview {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            border: 2px solid #dee2e6;
            display: inline-block;
            margin-right: 10px;
        }
        .item-card {
            border: 2px solid #e9ecef;
            border-radius: 12px;
            transition: all 0.3s ease;
        }
        .item-card:hover {
            border-color: #007bff;
            box-shadow: 0 4px 12px rgba(0,123,255,0.15);
        }
        .probability-badge {
            font-size: 0.8rem;
            padding: 0.25rem 0.5rem;
        }
        .points-badge {
            font-size: 0.9rem;
            padding: 0.35rem 0.7rem;
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
                        <h2 class="display-6 fw-bold">
                            <c:choose>
                                <c:when test="${spinWheel.id == null}">
                                    Create New Spinwheel
                                </c:when>
                                <c:otherwise>
                                    Edit Spinwheel: ${spinWheel.name}
                                </c:otherwise>
                            </c:choose>
                        </h2>
                        <p class="lead mb-0">
                            <c:choose>
                                <c:when test="${spinWheel.id == null}">
                                    Set up a new spinwheel to engage students with exciting rewards
                                </c:when>
                                <c:otherwise>
                                    Modify spinwheel settings and manage prize items
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                    <a href="/admin/spinwheels" class="btn btn-outline-secondary">
                        <i class="bi bi-arrow-left me-2"></i>Back to Spinwheels
                    </a>
                </div>
            </div>
        </div>

        <!-- Form -->
        <div class="row">
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm rounded-3 mb-4">
                    <div class="card-header bg-white border-0 py-3">
                        <h5 class="mb-0">
                            <i class="bi bi-circle-square text-primary me-2"></i>
                            Spinwheel Details
                        </h5>
                    </div>
                    <div class="card-body p-4">
                        <form action="/admin/spinwheels/save" method="post" th:object="${spinWheel}">
                            <c:if test="${spinWheel.id != null}">
                                <input type="hidden" name="id" value="${spinWheel.id}" />
                            </c:if>
                            
                            <div class="mb-3">
                                <label for="name" class="form-label">Spinwheel Name <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="name" name="name" 
                                       value="${spinWheel.name}" required 
                                       placeholder="Enter spinwheel name (e.g., Daily Rewards, Weekly Prizes)">
                                <div class="form-text">Choose a descriptive name that students will recognize</div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="description" class="form-label">Description</label>
                                <textarea class="form-control" id="description" name="description" rows="3" 
                                          placeholder="Optional description of what this spinwheel offers">${spinWheel.description}</textarea>
                                <div class="form-text">Provide additional context about the spinwheel's purpose</div>
                            </div>
                            
                            <div class="mb-3">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="active" name="active" 
                                           <c:if test="${spinWheel.active}">checked</c:if>>
                                    <label class="form-check-label" for="active">
                                        Active
                                    </label>
                                </div>
                                <div class="form-text">Active spinwheels are available for students to use</div>
                            </div>
                            
                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                <a href="/admin/spinwheels" class="btn btn-outline-secondary me-md-2">Cancel</a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="bi bi-check-circle me-2"></i>
                                    <c:choose>
                                        <c:when test="${spinWheel.id == null}">
                                            Create Spinwheel
                                        </c:when>
                                        <c:otherwise>
                                            Update Spinwheel
                                        </c:otherwise>
                                    </c:choose>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Prize Items Management -->
                <c:if test="${spinWheel.id != null}">
                    <div class="card border-0 shadow-sm rounded-3">
                        <div class="card-header bg-white border-0 py-3">
                            <div class="d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">
                                    <i class="bi bi-gift text-success me-2"></i>
                                    Prize Items
                                </h5>
                                <a href="/admin/spinwheels/${spinWheel.id}/items/create" class="btn btn-success">
                                    <i class="bi bi-plus-circle me-2"></i>Add New Item
                                </a>
                            </div>
                        </div>
                        <div class="card-body p-4">
                            <c:choose>
                                <c:when test="${empty items}">
                                    <div class="text-center py-4">
                                        <div class="bg-light rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
                                            <i class="bi bi-gift text-muted" style="font-size: 2rem;"></i>
                                        </div>
                                        <h6 class="text-muted">No Prize Items Yet</h6>
                                        <p class="text-muted mb-3">Add exciting rewards to make your spinwheel engaging!</p>
                                        <a href="/admin/spinwheels/${spinWheel.id}/items/create" class="btn btn-success">
                                            <i class="bi bi-plus-circle me-2"></i>Add First Item
                                        </a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="row">
                                        <c:forEach var="item" items="${items}">
                                            <div class="col-md-6 mb-3">
                                                <div class="item-card p-3">
                                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                                        <div class="d-flex align-items-center">
                                                            <div class="color-preview" style="background-color: ${item.color != null ? item.color : '#007bff'}"></div>
                                                            <div>
                                                                <h6 class="mb-1">${item.label}</h6>
                                                                <c:if test="${not empty item.description}">
                                                                    <small class="text-muted">${item.description}</small>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                        <div class="text-end">
                                                            <span class="badge bg-primary points-badge">${item.pointValue} pts</span>
                                                            <span class="badge bg-info probability-badge">Weight: ${item.probabilityWeight}</span>
                                                        </div>
                                                    </div>
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <small class="text-muted">
                                                            <i class="bi bi-palette me-1"></i>${item.color != null ? item.color : '#007bff'}
                                                        </small>
                                                        <div class="btn-group btn-group-sm">
                                                            <a href="/admin/spinwheels/items/edit/${item.id}" class="btn btn-outline-primary btn-sm">
                                                                <i class="bi bi-pencil"></i>
                                                            </a>
                                                            <form action="/admin/spinwheels/items/delete/${item.id}" method="post" style="display: inline;" 
                                                                  onsubmit="return confirm('Are you sure you want to delete this item?')">
                                                                <button type="submit" class="btn btn-outline-danger btn-sm">
                                                                    <i class="bi bi-trash"></i>
                                                                </button>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:if>
            </div>

            <!-- Tips and Guidelines -->
            <div class="col-lg-4">
                <div class="card border-0 shadow-sm rounded-3 mb-4">
                    <div class="card-header bg-gradient text-white" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                        <h6 class="mb-0"><i class="bi bi-lightbulb me-2"></i>Engagement Tips</h6>
                    </div>
                    <div class="card-body">
                        <h6 class="text-primary mb-3">🎯 Mix High & Low Point Rewards</h6>
                        <ul class="list-unstyled mb-3">
                            <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>5-25 pts: Daily engagement</li>
                            <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>50-100 pts: Weekly goals</li>
                            <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>200+ pts: Special achievements</li>
                        </ul>

                        <h6 class="text-primary mb-3">🎨 Use Attractive Colors</h6>
                        <div class="row mb-3">
                            <div class="col-4 text-center">
                                <div class="color-preview mx-auto" style="background-color: #ff6b6b;"></div>
                                <small class="d-block text-muted">#ff6b6b</small>
                            </div>
                            <div class="col-4 text-center">
                                <div class="color-preview mx-auto" style="background-color: #4ecdc4;"></div>
                                <small class="d-block text-muted">#4ecdc4</small>
                            </div>
                            <div class="col-4 text-center">
                                <div class="color-preview mx-auto" style="background-color: #45b7d1;"></div>
                                <small class="d-block text-muted">#45b7d1</small>
                            </div>
                        </div>

                        <h6 class="text-primary mb-3">⚖️ Probability Weights</h6>
                        <ul class="list-unstyled mb-3">
                            <li class="mb-2"><i class="bi bi-1-circle text-info me-2"></i>Weight 1: Rare (5%)</li>
                            <li class="mb-2"><i class="bi bi-2-circle text-info me-2"></i>Weight 2-3: Uncommon (15%)</li>
                            <li class="mb-2"><i class="bi bi-3-circle text-info me-2"></i>Weight 5-10: Common (80%)</li>
                        </ul>

                        <h6 class="text-primary mb-3">📝 Clear Descriptions</h6>
                        <ul class="list-unstyled">
                            <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>Keep labels short & exciting</li>
                            <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>Use action words</li>
                            <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>Make rewards feel valuable</li>
                        </ul>
                    </div>
                </div>

                <!-- Quick Stats -->
                <c:if test="${not empty items}">
                    <div class="card border-0 shadow-sm rounded-3">
                        <div class="card-header bg-light border-0 py-3">
                            <h6 class="mb-0"><i class="bi bi-graph-up text-success me-2"></i>Quick Stats</h6>
                        </div>
                        <div class="card-body">
                            <div class="row text-center">
                                <div class="col-6 mb-3">
                                    <div class="bg-primary bg-opacity-10 rounded p-2">
                                        <h5 class="text-primary mb-1">${items.size()}</h5>
                                        <small class="text-muted">Total Items</small>
                                    </div>
                                </div>
                                <div class="col-6 mb-3">
                                    <div class="bg-success bg-opacity-10 rounded p-2">
                                        <h5 class="text-success mb-1">
                                            <c:set var="totalWeight" value="0"/>
                                            <c:forEach var="item" items="${items}">
                                                <c:set var="totalWeight" value="${totalWeight + item.probabilityWeight}"/>
                                            </c:forEach>
                                            ${totalWeight}
                                        </h5>
                                        <small class="text-muted">Total Weight</small>
                                    </div>
                                </div>
                            </div>
                            <div class="text-center">
                                <small class="text-muted">Higher total weight = more balanced distribution</small>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>