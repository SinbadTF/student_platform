<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Spinwheel Item - Admin</title>
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
                        <h2 class="display-6 fw-bold">Add Spinwheel Item</h2>
                        <p class="lead text-muted">Add a new reward item to "${spinWheel.name}"</p>
                    </div>
                    <div>
                        <a href="/admin/dashboard" class="btn btn-outline-primary me-2">
                            <i class="bi bi-speedometer2 me-2"></i>Dashboard
                        </a>
                        <a href="/admin/spinwheels/edit/${spinWheel.id}" class="btn btn-outline-secondary">
                            <i class="bi bi-arrow-left me-2"></i>Back to Spinwheel
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
                <!-- Item Form -->
                <div class="card border-0 shadow-sm rounded-3">
                    <div class="card-header bg-white border-0 py-3">
                        <h5 class="mb-0"><i class="bi bi-plus-circle text-primary me-2"></i>Reward Item Configuration</h5>
                    </div>
                    <div class="card-body">
                        <form method="post" action="/admin/spinwheels/items/save" id="itemForm">
                            <input type="hidden" name="spinWheel.id" value="${spinWheel.id}">
                            
                            <!-- Basic Information -->
                            <div class="row mb-4">
                                <div class="col-12">
                                    <h6 class="text-primary mb-3"><i class="bi bi-info-circle me-2"></i>Item Information</h6>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="label" class="form-label">Reward Name <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" id="label" name="label" 
                                               required maxlength="50" placeholder="e.g., Point Name">
                                        <div class="form-text">Short, catchy name for the item</div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="itemType" class="form-label">Item Type</label>
                                        <select class="form-select" id="itemType" name="itemType">
                                            <option value="POINTS">Points</option>
                                            </select>
                                        <div class="form-text">Category of the item</div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="mb-4">
                                <label for="description" class="form-label">Description</label>
                                <textarea class="form-control" id="description" name="description" rows="3" 
                                          placeholder="Describe what the student will receive..."></textarea>
                                <div class="form-text">Detailed description of the item</div>
                            </div>

                            <!-- Item Value -->
                            <div class="row mb-4">
                                <div class="col-12">
                                    <h6 class="text-primary mb-3"><i class="bi bi-star me-2"></i>Item Value</h6>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="pointValue" class="form-label">Point Value <span class="text-danger">*</span></label>
                                        <div class="input-group">
                                            <input type="number" class="form-control" id="pointValue" name="pointValue" 
                                                   required min="1" placeholder="10">
                                            <span class="input-group-text">points</span>
                                        </div>
                                        <div class="form-text">Points awarded when this item is won</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Probability Settings -->
                            <div class="row mb-4">
                                <div class="col-12">
                                    <h6 class="text-primary mb-3"><i class="bi bi-percent me-2"></i>Win Probability</h6>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="probabilityWeight" class="form-label">Probability Weight <span class="text-danger">*</span></label>
                                        <div class="input-group">
                                            <input type="number" class="form-control" id="probabilityWeight" name="probabilityWeight" 
                                                   required min="1" value="1" placeholder="1">
                                            <span class="input-group-text">weight</span>
                                        </div>
                                        <div class="form-text">Higher weight = higher chance of winning</div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Win Chance</label>
                                        <div class="form-control-plaintext">
                                            <span id="winChance" class="badge bg-info fs-6 px-3 py-2">
                                                Calculating...
                                            </span>
                                        </div>
                                        <div class="form-text">Estimated win percentage based on probability weight</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Visual Settings -->
                            <div class="row mb-4">
                                <div class="col-12">
                                    <h6 class="text-primary mb-3"><i class="bi bi-palette me-2"></i>Visual Settings</h6>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="itemColor" class="form-label">Item Color</label>
                                        <div class="input-group">
                                            <input type="color" class="form-control form-control-color" id="itemColor" 
                                                   name="itemColor" value="#007bff" title="Choose item color">
                                            <span class="input-group-text">#007bff</span>
                                        </div>
                                        <div class="form-text">Color for this item on the spinwheel</div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="icon" class="form-label">Icon</label>
                                        <select class="form-select" id="icon" name="icon">
                                            <option value="bi-star">⭐ Star</option>
                                            
                                            <option value="bi-coin">🪙 Coin</option>
                                            <option value="bi-trophy">🏆 Trophy</option>
                                            <option value="bi-gem">💎 Gem</option>
                                            <option value="bi-gift">🎁 Gift</option>
                                        </select>
                                        <div class="form-text">Icon to display with this item</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Item Preview -->
                            <div class="row mb-4">
                                <div class="col-12">
                                    <h6 class="text-primary mb-3"><i class="bi bi-eye me-2"></i>Preview</h6>
                                    <div class="text-center">
                                        <div class="item-preview" id="itemPreview" style="width: 120px; height: 120px; margin: 0 auto; border-radius: 50%; background: #007bff; border: 4px solid #fff; box-shadow: 0 0 15px rgba(0,0,0,0.3); display: flex; flex-direction: column; align-items: center; justify-content: center; color: white; font-weight: bold;">
                                            <i class="bi bi-star" style="font-size: 2rem;"></i>
                                            <span style="font-size: 0.8rem; margin-top: 5px;">10 pts</span>
                                        </div>
                                        <p class="text-muted mt-2">This is how the item will appear on the spinwheel</p>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Form Actions -->
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <a href="/admin/dashboard" class="btn btn-outline-primary me-2">
                                        <i class="bi bi-speedometer2 me-2"></i>Dashboard
                                    </a>
                                    <a href="/admin/spinwheels/edit/${spinWheel.id}" class="btn btn-outline-secondary">
                                        <i class="bi bi-arrow-left me-2"></i>Cancel
                                    </a>
                                </div>
                                <button type="submit" class="btn btn-primary btn-lg">
                                    <i class="bi bi-check-circle me-2"></i>Add Item
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <!-- Help & Tips -->
                <div class="card border-0 shadow-sm rounded-3">
                    <div class="card-header bg-white border-0 py-3">
                        <h5 class="mb-0"><i class="bi bi-lightbulb text-warning me-2"></i>Tips & Guidelines</h5>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <h6 class="text-primary">Probability Weights & Win Chances</h6>
                            <ul class="list-unstyled small">
                                <li><span class="badge bg-danger me-2">1</span> Very Rare (10%)</li>
                                <li><span class="badge bg-warning me-2">2</span> Rare (20%)</li>
                                <li><span class="badge bg-info me-2">3</span> Common (30%)</li>
                                <li><span class="badge bg-success me-2">4</span> Very Common (40%)</li>
                            </ul>
                        </div>
                        
                        <div class="mb-3">
                            <h6 class="text-primary">Item Types</h6>
                            <ul class="list-unstyled small">
                                <li><i class="bi bi-star text-warning me-2"></i><strong>Points:</strong> Virtual currency rewards</li>
                            </ul>
                        </div>
                        
                        <div class="mb-3">
                            <h6 class="text-primary">Point Values</h6>
                            <ul class="list-unstyled small">
                                <li><i class="bi bi-star text-warning me-2"></i>Small: 1-10 points</li>
                                <li><i class="bi bi-star-fill text-warning me-2"></i>Medium: 11-50 points</li>
                                <li><i class="bi bi-gem text-primary me-2"></i>Large: 51-100 points</li>
                                <li><i class="bi bi-trophy text-success me-2"></i>Grand: 100+ points</li>
                            </ul>
                        </div>

                        <div class="alert alert-info">
                            <i class="bi bi-info-circle me-2"></i>
                            <strong>Pro Tip:</strong> Balance your items! Mix high-value rare items with common low-value ones to keep students engaged.
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
        // Live preview and calculations
        function updatePreview() {
            const label = document.getElementById('label').value || 'Reward';
            const pointValue = document.getElementById('pointValue').value || '10';
            const itemColor = document.getElementById('itemColor').value;
            const icon = document.getElementById('icon').value;
            
            // Update preview
            const preview = document.getElementById('itemPreview');
            preview.style.background = itemColor;
            preview.innerHTML = `
                <i class="${icon}" style="font-size: 2rem;"></i>
                <span style="font-size: 0.8rem; margin-top: 5px;">${pointValue} pts</span>
            `;
            
            // Update color display
            document.querySelector('#itemColor').nextElementSibling.textContent = itemColor;
        }
        
                 function calculateWinChance() {
             const weight = parseInt(document.getElementById('probabilityWeight').value) || 1;
             const totalWeight = 10; // This would be calculated from all items in the spinwheel
             const percentage = Math.round((weight / totalWeight) * 100);
             
             const winChance = document.getElementById('winChance');
             
             // Update badge color and content based on percentage
             winChance.className = 'badge ';
             if (percentage <= 10) {
                 winChance.className += 'bg-danger';
                 winChance.innerHTML = `🔴 ${percentage}% - Very Rare - Low chance of winning`;
             } else if (percentage <= 25) {
                 winChance.className += 'bg-warning';
                 winChance.innerHTML = `🟡 ${percentage}% - Rare - Moderate chance of winning`;
             } else if (percentage <= 50) {
                 winChance.className += 'bg-info';
                 winChance.innerHTML = `🔵 ${percentage}% - Common - Good chance of winning`;
             } else {
                 winChance.className += 'bg-success';
                 winChance.innerHTML = `🟢 ${percentage}% - Very Common - High chance of winning`;
             }
         }
        
        // Event listeners
        document.getElementById('label').addEventListener('input', updatePreview);
        document.getElementById('pointValue').addEventListener('input', updatePreview);
        document.getElementById('itemColor').addEventListener('input', updatePreview);
        document.getElementById('icon').addEventListener('change', updatePreview);
        document.getElementById('probabilityWeight').addEventListener('input', calculateWinChance);
        
        // Initialize
        updatePreview();
        calculateWinChance();
    </script>
</body>
</html>
