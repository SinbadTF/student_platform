<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${item.id == null ? 'Add' : 'Edit'} Item - ${spinWheel.name}</title>
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
                        <h2 class="display-6 fw-bold">
                            <c:choose>
                                <c:when test="${item.id == null}">
                                    Add New Item
                                </c:when>
                                <c:otherwise>
                                    Edit Item: ${item.label}
                                </c:otherwise>
                            </c:choose>
                        </h2>
                        <p class="lead mb-0">Spinwheel: ${spinWheel.name}</p>
                    </div>
                    <a href="/admin/spinwheels/view/${spinWheel.id}" class="btn btn-outline-secondary">
                        <i class="bi bi-arrow-left me-2"></i>Back to Spinwheel
                    </a>
                </div>
            </div>
        </div>
        <!-- Form -->
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm rounded-3">
                    <div class="card-header bg-white border-0 py-3">
                        <h5 class="mb-0">
                            <i class="bi bi-list-ul text-primary me-2"></i>
                            Item Details
                        </h5>
                    </div>
                    <div class="card-body p-4">
                        <form action="/admin/spinwheels/${spinWheel.id}/items/save" method="post">
                            <c:if test="${item.id != null}">
                                <input type="hidden" name="id" value="${item.id}" />
                            </c:if>
                            
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="mb-3">
                                        <label for="label" class="form-label">Item Label <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" id="label" name="label" 
                                               value="${item.label}" required 
                                               placeholder="Enter item label (e.g., 50 Points, Free Coffee)">
                                        <div class="form-text">This is what students will see when they spin</div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label for="pointValue" class="form-label">Point Value <span class="text-danger">*</span></label>
                                        <input type="number" class="form-control" id="pointValue" name="pointValue" 
                                               value="${item.pointValue}" required min="0" 
                                               placeholder="0">
                                        <div class="form-text">Points awarded when this item is won</div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="description" class="form-label">Description</label>
                                <textarea class="form-control" id="description" name="description" rows="2" 
                                          placeholder="Optional description of the reward">${item.description}</textarea>
                                <div class="form-text">Additional details about what this reward offers</div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="probabilityWeight" class="form-label">Probability Weight <span class="text-danger">*</span></label>
                                        <input type="number" class="form-control" id="probabilityWeight" name="probabilityWeight" 
                                               value="${item.probabilityWeight}" required min="1" 
                                               placeholder="1">
                                        <div class="form-text">Higher number = higher chance of winning</div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="color" class="form-label">Color</label>
                                        <input type="color" class="form-control form-control-color" id="color" name="color"
                                        value="${item.color != null ? item.color : '#007bff'}" 
                                               title="Choose a color for this segment">
                                        <div class="form-text">Color for the wheel segment (optional)</div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                <a href="/admin/spinwheels/view/${spinWheel.id}" class="btn btn-outline-secondary me-md-2">Cancel</a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="bi bi-check-circle me-2"></i>
                                    <c:choose>
                                        <c:when test="${item.id == null}">
                                            Add Item
                                        </c:when>
                                        <c:otherwise>
                                            Update Item
                                        </c:otherwise>
                                    </c:choose>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
                
                <!-- Help Section -->
                <div class="card border-0 shadow-sm rounded-3 mt-4">
                    <div class="card-header bg-light border-0 py-3">
                        <h6 class="mb-0"><i class="bi bi-info-circle text-info me-2"></i>Tips for Creating Items</h6>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <h6>Probability Weights:</h6>
                                <ul class="mb-0">
                                    <li><strong>1x:</strong> Common rewards (low points)</li>
                                    <li><strong>2-3x:</strong> Medium rewards</li>
                                    <li><strong>5-10x:</strong> Rare rewards (high points)</li>
                                </ul>
                            </div>
                            <div class="col-md-6">
                                <h6>Point Values:</h6>
                                <ul class="mb-0">
                                    <li><strong>5-25:</strong> Small daily rewards</li>
                                    <li><strong>50-100:</strong> Medium weekly rewards</li>
                                    <li><strong>200+:</strong> Special achievement rewards</li>
                                </ul>
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