<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${spinWheel.id == null ? 'Create' : 'Edit'} Spinwheel - Admin</title>
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
                        <h2 class="display-6 fw-bold">${spinWheel.id == null ? 'Create New' : 'Edit'} Spinwheel</h2>
                        <p class="lead text-muted">${spinWheel.id == null ? 'Set up a new spinwheel for student engagement' : 'Update spinwheel details'}</p>
                    </div>
                    <div>
                        <a href="/admin/dashboard" class="btn btn-outline-primary me-2">
                            <i class="bi bi-speedometer2 me-2"></i>Dashboard
                        </a>
                        <a href="/admin/spinwheels" class="btn btn-outline-secondary">
                            <i class="bi bi-arrow-left me-2"></i>Back to Spinwheels
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

        <div class="row">
            <div class="col-lg-8">
                <!-- Spinwheel Form -->
                <div class="card border-0 shadow-sm rounded-3">
                    <div class="card-header bg-white border-0 py-3">
                        <h5 class="mb-0"><i class="bi bi-gear text-primary me-2"></i>Spinwheel Configuration</h5>
                    </div>
                    <div class="card-body">
                        <form method="post" action="/admin/spinwheels/save" id="spinwheelForm">
                            <!-- Hidden field for ID (for updates) -->
                            <c:if test="${spinWheel.id != null}">
                                <input type="hidden" name="id" value="${spinWheel.id}">
                            </c:if>
                            
                            <!-- Basic Information -->
                            <div class="row mb-4">
                                <div class="col-12">
                                    <h6 class="text-primary mb-3"><i class="bi bi-info-circle me-2"></i>Basic Information</h6>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="name" class="form-label">Spinwheel Name <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" id="name" name="name" 
                                               value="${spinWheel.name}" required maxlength="100" 
                                               placeholder="e.g., Daily Rewards, Weekly Bonuses">
                                        <div class="form-text">Choose a catchy name for your spinwheel</div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="active" class="form-label">Status</label>
                                        <select class="form-select" id="active" name="active">
                                            <option value="true" ${spinWheel.active ? 'selected' : ''}>
                                                <i class="bi bi-check-circle text-success"></i> Active
                                            </option>
                                            <option value="false" ${!spinWheel.active ? 'selected' : ''}>
                                                <i class="bi bi-pause-circle text-warning"></i> Inactive
                                            </option>
                                        </select>
                                        <div class="form-text">Only active spinwheels are visible to students</div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="mb-4">
                                <label for="description" class="form-label">Description</label>
                                <textarea class="form-control" id="description" name="description" rows="3" 
                                          placeholder="Describe what this spinwheel is for and what students can win...">${spinWheel.description}</textarea>
                                <div class="form-text">Help students understand what they can win</div>
                            </div>

                            <!-- Visual Settings -->
                            <div class="row mb-4">
                                <div class="col-12">
                                    <h6 class="text-primary mb-3"><i class="bi bi-palette me-2"></i>Visual Settings</h6>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="primaryColor" class="form-label">Primary Color</label>
                                        <div class="input-group">
                                            <input type="color" class="form-control form-control-color" id="primaryColor" 
                                                   name="primaryColor" value="#007bff" title="Choose primary color">
                                            <span class="input-group-text">#007bff</span>
                                        </div>
                                        <div class="form-text">Main color for the spinwheel</div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="secondaryColor" class="form-label">Secondary Color</label>
                                        <div class="input-group">
                                            <input type="color" class="form-control form-control-color" id="secondaryColor" 
                                                   name="secondaryColor" value="#28a745" title="Choose secondary color">
                                            <span class="input-group-text">#28a745</span>
                                        </div>
                                        <div class="form-text">Accent color for highlights</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Spinwheel Preview -->
                            <div class="row mb-4">
                                <div class="col-12">
                                    <h6 class="text-primary mb-3"><i class="bi bi-eye me-2"></i>Preview</h6>
                                    <div class="text-center">
                                        <div class="spinwheel-preview" id="spinwheelPreview" style="width: 200px; height: 200px; margin: 0 auto; border-radius: 50%; background: conic-gradient(#007bff 0deg 60deg, #28a745 60deg 120deg, #ffc107 120deg 180deg, #dc3545 180deg 240deg, #6f42c1 240deg 300deg, #20c997 300deg 360deg); border: 8px solid #fff; box-shadow: 0 0 20px rgba(0,0,0,0.3); position: relative;">
                                            <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 40px; height: 40px; background: #fff; border-radius: 50%; border: 3px solid #007bff; display: flex; align-items: center; justify-content: center;">
                                                <i class="bi bi-play-fill text-primary"></i>
                                            </div>
                                        </div>
                                        <p class="text-muted mt-2">This is how your spinwheel will look to students</p>
                                    </div>
                                </div>
                            </div>

                            <!-- Advanced Settings -->
                            <div class="row mb-4">
                                <div class="col-12">
                                    <h6 class="text-primary mb-3"><i class="bi bi-gear-fill me-2"></i>Advanced Settings</h6>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="maxSpinsPerDay" class="form-label">Max Spins Per Day</label>
                                        <input type="number" class="form-control" id="maxSpinsPerDay" name="maxSpinsPerDay" 
                                               value="1" min="1" max="10">
                                        <div class="form-text">How many times can a student spin per day?</div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="cooldownHours" class="form-label">Cooldown Period (Hours)</label>
                                        <input type="number" class="form-control" id="cooldownHours" name="cooldownHours" 
                                               value="24" min="1" max="168">
                                        <div class="form-text">Hours between allowed spins</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Form Actions -->
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <a href="/admin/dashboard" class="btn btn-outline-primary me-2">
                                        <i class="bi bi-speedometer2 me-2"></i>Dashboard
                                    </a>
                                    <a href="/admin/spinwheels" class="btn btn-outline-secondary">
                                        <i class="bi bi-arrow-left me-2"></i>Cancel
                                    </a>
                                </div>
                                <button type="submit" class="btn btn-primary btn-lg">
                                    <i class="bi bi-check-circle me-2"></i>${spinWheel.id == null ? 'Create Spinwheel' : 'Update Spinwheel'}
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-4">
                <!-- Spinwheel Items (if editing) -->
                <c:if test="${spinWheel.id != null}">
                    <div class="card border-0 shadow-sm rounded-3">
                        <div class="card-header bg-white border-0 py-3">
                            <div class="d-flex justify-content-between align-items-center">
                                <h5 class="mb-0"><i class="bi bi-list-ul text-info me-2"></i>Spinwheel Items</h5>
                                <a href="/admin/spinwheels/${spinWheel.id}/items/create" class="btn btn-sm btn-primary">
                                    <i class="bi bi-plus"></i>Add Item
                                </a>
                            </div>
                        </div>
                        <div class="card-body">
                            <c:choose>
                                <c:when test="${empty items}">
                                    <div class="text-center py-3">
                                        <i class="bi bi-list-ul text-muted" style="font-size: 2rem;"></i>
                                        <p class="text-muted mt-2">No items yet</p>
                                        <a href="/admin/spinwheels/${spinWheel.id}/items/create" class="btn btn-sm btn-outline-primary">
                                            Add First Item
                                        </a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="list-group list-group-flush">
                                        <c:forEach var="item" items="${items}">
                                            <div class="list-group-item d-flex justify-content-between align-items-center px-0">
                                                <div>
                                                    <strong>${item.label}</strong>
                                                    <br>
                                                    <small class="text-muted">${item.pointValue} points</small>
                                                </div>
                                                <div class="btn-group btn-group-sm">
                                                    <form method="post" action="/admin/spinwheels/items/delete/${item.id}" 
                                                          style="display: inline;">
                                                        <button type="submit" class="btn btn-outline-danger btn-sm"
                                                                onclick="return confirm('Delete this item?')">
                                                            <i class="bi bi-trash"></i>
                                                        </button>
                                                    </form>
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
        </div>
    </div>
    
    <jsp:include page="../layout/footer.jsp" />
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Live preview functionality
        function updateSpinwheelPreview() {
            const primaryColor = document.getElementById('primaryColor').value;
            const secondaryColor = document.getElementById('secondaryColor').value;
            
            // Update color displays
            document.querySelector('#primaryColor').nextElementSibling.textContent = primaryColor;
            document.querySelector('#secondaryColor').nextElementSibling.textContent = secondaryColor;
            
            // Update preview with gradient
            const preview = document.getElementById('spinwheelPreview');
            preview.style.background = `conic-gradient(${primaryColor} 0deg 60deg, ${secondaryColor} 60deg 120deg, #ffc107 120deg 180deg, #dc3545 180deg 240deg, #6f42c1 240deg 300deg, #20c997 300deg 360deg)`;
        }
        
        // Form validation
        function validateForm() {
            const name = document.getElementById('name').value.trim();
            const maxSpins = document.getElementById('maxSpinsPerDay').value;
            const cooldown = document.getElementById('cooldownHours').value;
            
            if (name.length < 3) {
                alert('Spinwheel name must be at least 3 characters long.');
                return false;
            }
            
            if (parseInt(maxSpins) < 1 || parseInt(maxSpins) > 10) {
                alert('Max spins per day must be between 1 and 10.');
                return false;
            }
            
            if (parseInt(cooldown) < 1 || parseInt(cooldown) > 168) {
                alert('Cooldown period must be between 1 and 168 hours.');
                return false;
            }
            
            return true;
        }
        
        // Event listeners
        document.getElementById('primaryColor').addEventListener('input', updateSpinwheelPreview);
        document.getElementById('secondaryColor').addEventListener('input', updateSpinwheelPreview);
        document.getElementById('spinwheelForm').addEventListener('submit', function(e) {
            if (!validateForm()) {
                e.preventDefault();
            }
        });
        
        // Initialize
        updateSpinwheelPreview();

        // Local (UI-only) persistence for spin limits without backend changes
        (function() {
            try {
                var wheelIdEl = document.querySelector('input[name="id"]');
                var wheelId = wheelIdEl ? wheelIdEl.value : null;
                var maxEl = document.getElementById('maxSpinsPerDay');
                var cdEl = document.getElementById('cooldownHours');
                if (!maxEl || !cdEl) return;

                if (wheelId) {
                    var lsMax = localStorage.getItem('spinwheel:' + wheelId + ':maxSpinsPerDay');
                    var lsCd = localStorage.getItem('spinwheel:' + wheelId + ':cooldownHours');
                    if (lsMax !== null) maxEl.value = lsMax;
                    if (lsCd !== null) cdEl.value = lsCd;
                }

                document.getElementById('spinwheelForm').addEventListener('submit', function() {
                    if (wheelId) {
                        localStorage.setItem('spinwheel:' + wheelId + ':maxSpinsPerDay', maxEl.value);
                        localStorage.setItem('spinwheel:' + wheelId + ':cooldownHours', cdEl.value);
                    }
                });
            } catch (e) { /* noop */ }
        })();
    </script>
</body>
</html>
