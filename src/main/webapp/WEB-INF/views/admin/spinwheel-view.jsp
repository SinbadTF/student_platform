<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Spinwheel Details - Admin</title>
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
                        <h2 class="display-6 fw-bold">${spinWheel.name}</h2>
                        <p class="lead text-muted">Spinwheel Details and Management</p>
                    </div>
                    <div>
                        <a href="/admin/dashboard" class="btn btn-outline-primary me-2">
                            <i class="bi bi-speedometer2 me-2"></i>Dashboard
                        </a>
                        <a href="/admin/spinwheels/edit/${spinWheel.id}" class="btn btn-outline-primary me-2">
                            <i class="bi bi-pencil me-2"></i>Edit
                        </a>
                        <a href="/admin/spinwheels" class="btn btn-outline-secondary">
                            <i class="bi bi-arrow-left me-2"></i>Back to List
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-8">
                <!-- Spinwheel Information -->
                <div class="card border-0 shadow-sm rounded-3 mb-4">
                    <div class="card-header bg-white border-0 py-3">
                        <h5 class="mb-0"><i class="bi bi-info-circle text-primary me-2"></i>Spinwheel Information</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <dl class="row">
                                    <dt class="col-sm-4">Name:</dt>
                                    <dd class="col-sm-8">${spinWheel.name}</dd>
                                    
                                    <dt class="col-sm-4">Status:</dt>
                                    <dd class="col-sm-8">
                                        <c:choose>
                                            <c:when test="${spinWheel.active}">
                                                <span class="badge bg-success">Active</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">Inactive</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </dd>
                                    
                                    <dt class="col-sm-4">Created:</dt>
                                    <dd class="col-sm-8">
                                        ${spinWheel.createdAt}
                                    </dd>
                                </dl>
                            </div>
                            <div class="col-md-6">
                                <dl class="row">
                                    <dt class="col-sm-4">Updated:</dt>
                                    <dd class="col-sm-8">
                                        ${spinWheel.updatedAt}
                                    </dd>
                                    
                                    <dt class="col-sm-4">Items:</dt>
                                    <dd class="col-sm-8">
                                        <span class="badge bg-info">${fn:length(spinWheel.items)} items</span>
                                    </dd>
                                    
                                    <dt class="col-sm-4">Created By:</dt>
                                    <dd class="col-sm-8">${spinWheel.createdBy.username}</dd>
                                </dl>
                            </div>
                        </div>
                        
                        <c:if test="${not empty spinWheel.description}">
                            <div class="mt-3">
                                <h6>Description:</h6>
                                <p class="text-muted">${spinWheel.description}</p>
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- Spinwheel Items -->
                <div class="card border-0 shadow-sm rounded-3">
                    <div class="card-header bg-white border-0 py-3">
                        <div class="d-flex justify-content-between align-items-center">
                            <h5 class="mb-0"><i class="bi bi-list-ul text-info me-2"></i>Spinwheel Items</h5>
                            <a href="/admin/spinwheels/${spinWheel.id}/items/create" class="btn btn-sm btn-primary">
                                <i class="bi bi-plus me-2"></i>Add Item
                            </a>
                        </div>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty spinWheel.items}">
                                <div class="text-center py-4">
                                    <i class="bi bi-list-ul text-muted" style="font-size: 3rem;"></i>
                                    <h5 class="mt-3 text-muted">No Items Yet</h5>
                                    <p class="text-muted">Add items to make this spinwheel functional.</p>
                                    <a href="/admin/spinwheels/${spinWheel.id}/items/create" class="btn btn-primary">
                                        <i class="bi bi-plus-circle me-2"></i>Add First Item
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Label</th>
                                                <th>Description</th>
                                                <th>Points</th>
                                                <th>Weight</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="item" items="${spinWheel.items}">
                                                <tr>
                                                    <td><strong>${item.label}</strong></td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty item.description}">
                                                                ${item.description}
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">No description</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-success">${item.pointValue} pts</span>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-info">${item.probabilityWeight}</span>
                                                    </td>
                                                    <td>
                                                        <form method="post" action="/admin/spinwheels/items/delete/${item.id}" 
                                                              style="display: inline;">
                                                            <button type="submit" class="btn btn-sm btn-outline-danger"
                                                                    onclick="return confirm('Delete this item?')">
                                                                <i class="bi bi-trash"></i>
                                                            </button>
                                                        </form>
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
            
            <div class="col-lg-4">
                <!-- Spinwheel Preview -->
                <div class="card border-0 shadow-sm rounded-3 mb-4">
                    <div class="card-header bg-white border-0 py-3">
                        <h5 class="mb-0"><i class="bi bi-eye text-primary me-2"></i>Spinwheel Preview</h5>
                    </div>
                    <div class="card-body text-center">
                        <c:choose>
                            <c:when test="${empty spinWheel.items}">
                                <div class="py-4">
                                    <i class="bi bi-arrow-repeat text-muted" style="font-size: 4rem;"></i>
                                    <h6 class="mt-3 text-muted">No Items Yet</h6>
                                    <p class="text-muted small">Add items to see preview</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="spinwheel-preview-container">
                                    <div class="spinwheel-preview" id="spinwheelPreview" style="width: 200px; height: 200px; margin: 0 auto; border-radius: 50%; border: 8px solid #fff; box-shadow: 0 0 20px rgba(0,0,0,0.3); position: relative; overflow: hidden;">
                                        <!-- Items will be rendered here by JavaScript -->
                                    </div>
                                    <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 40px; height: 40px; background: #fff; border-radius: 50%; border: 3px solid #007bff; display: flex; align-items: center; justify-content: center; z-index: 10;">
                                        <i class="bi bi-play-fill text-primary"></i>
                                    </div>
                                </div>
                                <p class="text-muted mt-3 small">This is how students will see your spinwheel</p>

                                <!-- Embed items as JSON for safe JS consumption -->
                                <script type="application/json" id="preview-items-data">
                                    [
                                        <c:forEach var="item" items="${spinWheel.items}" varStatus="status">
                                        {
                                            "label": "<c:out value='${item.label}'/>",
                                            "pointValue": <c:out value='${item.pointValue}'/>,
                                            "probabilityWeight": <c:out value='${item.probabilityWeight}'/>,
                                            "itemColor": "<c:out value='${item.itemColor}'/>",
                                            "icon": "<c:out value='${item.icon}'/>"
                                        }<c:if test="${!status.last}">,</c:if>
                                        </c:forEach>
                                    ]
                                </script>
                                
                                <!-- Item Legend -->
                                <div class="mt-3">
                                    <h6 class="text-primary">Items:</h6>
                                    <div class="row g-2">
                                        <c:forEach var="item" items="${spinWheel.items}" varStatus="status">
                                            <div class="col-6">
                                                <div class="d-flex align-items-center">
                                                    <div class="item-color-preview me-2" style="width: 20px; height: 20px; border-radius: 50%; border: 2px solid #fff; box-shadow: 0 0 5px rgba(0,0,0,0.3);" data-color="<c:out value='${item.itemColor}' default='#007bff'/>"></div>
                                                    <div class="text-start">
                                                        <div class="fw-bold small">${item.label}</div>
                                                        <div class="text-muted" style="font-size: 0.7rem;">${item.pointValue} pts</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="card border-0 shadow-sm rounded-3 mb-4">
                    <div class="card-header bg-white border-0 py-3">
                        <h5 class="mb-0"><i class="bi bi-lightning-charge text-warning me-2"></i>Quick Actions</h5>
                    </div>
                    <div class="card-body">
                        <div class="d-grid gap-2">
                            <a href="/admin/spinwheels/edit/${spinWheel.id}" class="btn btn-outline-primary">
                                <i class="bi bi-pencil me-2"></i>Edit Spinwheel
                            </a>
                            <a href="/admin/spinwheels/${spinWheel.id}/items/create" class="btn btn-outline-success">
                                <i class="bi bi-plus-circle me-2"></i>Add Item
                            </a>
                            <c:choose>
                                <c:when test="${spinWheel.active}">
                                    <form method="post" action="/admin/spinwheels/deactivate/${spinWheel.id}">
                                        <button type="submit" class="btn btn-outline-warning w-100"
                                                onclick="return confirm('Deactivate this spinwheel?')">
                                            <i class="bi bi-pause me-2"></i>Deactivate
                                        </button>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <form method="post" action="/admin/spinwheels/activate/${spinWheel.id}">
                                        <button type="submit" class="btn btn-outline-success w-100">
                                            <i class="bi bi-play me-2"></i>Activate
                                        </button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                            <form method="post" action="/admin/spinwheels/delete/${spinWheel.id}">
                                <button type="submit" class="btn btn-outline-danger w-100"
                                        onclick="return confirm('Delete this spinwheel? This action cannot be undone.')">
                                    <i class="bi bi-trash me-2"></i>Delete Spinwheel
                                </button>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Statistics -->
                <div class="card border-0 shadow-sm rounded-3">
                    <div class="card-header bg-white border-0 py-3">
                        <h5 class="mb-0"><i class="bi bi-graph-up text-info me-2"></i>Statistics</h5>
                    </div>
                    <div class="card-body">
                        <div class="row text-center">
                            <div class="col-6">
                                <div class="border-end">
                                    <h4 class="text-primary">${fn:length(spinWheel.items)}</h4>
                                    <small class="text-muted">Total Items</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <h4 class="text-success">
                                    <c:set var="totalPoints" value="0" />
                                    <c:forEach var="item" items="${spinWheel.items}">
                                        <c:set var="totalPoints" value="${totalPoints + item.pointValue}" />
                                    </c:forEach>
                                    ${totalPoints}
                                </h4>
                                <small class="text-muted">Max Points</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="../layout/footer.jsp" />
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Render spinwheel preview with actual items
        function renderSpinwheelPreview() {
            const preview = document.getElementById('spinwheelPreview');
            if (!preview) return;
            
            // Get items data from embedded JSON to avoid JSP/JS parsing issues
            const items = JSON.parse(document.getElementById('preview-items-data').textContent).map(function(it){
                return {
                    label: it.label,
                    pointValue: it.pointValue,
                    probabilityWeight: it.probabilityWeight,
                    itemColor: (it.itemColor && it.itemColor.trim() !== '') ? it.itemColor : '#007bff',
                    icon: (it.icon && it.icon.trim() !== '') ? it.icon : 'bi-star'
                };
            });
            
            if (items.length === 0) return;
            
            // Calculate angles for each item
            const totalWeight = items.reduce((sum, item) => sum + item.probabilityWeight, 0);
            let currentAngle = 0;
            
            // Create conic gradient
            let gradientParts = [];
            items.forEach((item, index) => {
                const angle = (item.probabilityWeight / totalWeight) * 360;
                const startAngle = currentAngle;
                const endAngle = currentAngle + angle;
                
                gradientParts.push(`${item.itemColor} ${startAngle}deg ${endAngle}deg`);
                currentAngle = endAngle;
            });
            
            // Apply gradient
            preview.style.background = `conic-gradient(${gradientParts.join(', ')})`;
            
            // Add item labels and icons
            preview.innerHTML = '';
            currentAngle = 0;
            items.forEach((item, index) => {
                const angle = (item.probabilityWeight / totalWeight) * 360;
                const centerAngle = currentAngle + (angle / 2);
                const radians = (centerAngle * Math.PI) / 180;
                
                // Calculate position for label (closer to center)
                const radius = 60; // Distance from center (smaller for preview)
                const x = Math.cos(radians) * radius;
                const y = Math.sin(radians) * radius;
                
                const labelDiv = document.createElement('div');
                labelDiv.style.position = 'absolute';
                labelDiv.style.left = '50%';
                labelDiv.style.top = '50%';
                labelDiv.style.transform = `translate(${x}px, ${y}px) translate(-50%, -50%)`;
                labelDiv.style.textAlign = 'center';
                labelDiv.style.fontSize = '8px';
                labelDiv.style.fontWeight = 'bold';
                labelDiv.style.color = 'white';
                labelDiv.style.textShadow = '1px 1px 2px rgba(0,0,0,0.8)';
                labelDiv.style.pointerEvents = 'none';
                labelDiv.style.zIndex = '5';
                
                labelDiv.innerHTML = `
                    <i class="${item.icon}" style="font-size: 10px; display: block; margin-bottom: 1px;"></i>
                    <div style="font-size: 6px; line-height: 1;">${item.label}</div>
                    <div style="font-size: 5px; opacity: 0.9;">${item.pointValue}pts</div>
                `;
                
                preview.appendChild(labelDiv);
                currentAngle += angle;
            });
        }
        
        // Initialize when page loads
        document.addEventListener('DOMContentLoaded', function() {
            try {
                renderSpinwheelPreview();
            } catch (error) {
                console.error('Error initializing spinwheel preview:', error);
                // Fallback: show a simple message
                const preview = document.getElementById('spinwheelPreview');
                if (preview) {
                    preview.innerHTML = '<div style="display: flex; align-items: center; justify-content: center; height: 100%; color: white; font-weight: bold;">Preview Loading...</div>';
                }
            }
        });
    </script>
</body>
</html>
