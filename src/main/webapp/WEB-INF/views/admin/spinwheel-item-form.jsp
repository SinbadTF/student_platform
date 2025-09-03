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
    <style>
        .color-preview {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            border: 3px solid #dee2e6;
            display: inline-block;
            margin-right: 15px;
            transition: all 0.3s ease;
        }
        .color-preview:hover {
            transform: scale(1.1);
            border-color: #007bff;
        }
        .probability-slider {
            width: 100%;
        }
        .probability-value {
            font-size: 1.2rem;
            font-weight: bold;
            color: #007bff;
        }
        .color-suggestion {
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .color-suggestion:hover {
            transform: scale(1.1);
        }
        .form-section {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
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
                                <c:when test="${item.id == null}">
                                    Add New Prize Item
                                </c:when>
                                <c:otherwise>
                                    Edit Prize Item
                                </c:otherwise>
                            </c:choose>
                        </h2>
                        <p class="lead mb-0">
                            <c:choose>
                                <c:when test="${item.id == null}">
                                    Create an exciting reward for the "${spinWheel.name}" spinwheel
                                </c:when>
                                <c:otherwise>
                                    Modify the "${item.label}" item in "${spinWheel.name}"
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                    <a href="/admin/spinwheels/edit/${spinWheel.id}" class="btn btn-outline-secondary">
                        <i class="bi bi-arrow-left me-2"></i>Back to Spinwheel
                    </a>
                </div>
            </div>
        </div>

        <!-- Form -->
        <div class="row">
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm rounded-3">
                    <div class="card-header bg-white border-0 py-3">
                        <h5 class="mb-0">
                            <i class="bi bi-gift text-success me-2"></i>
                            Item Details
                        </h5>
                    </div>
                    <div class="card-body p-4">
                        <form action="/admin/spinwheels/items/save" method="post">
                            <c:if test="${item.id != null}">
                                <input type="hidden" name="id" value="${item.id}" />
                            </c:if>
                            <input type="hidden" name="spinWheel.id" value="${spinWheel.id}" />
                            
                            <!-- Basic Information Section -->
                            <div class="form-section">
                                <h6 class="text-primary mb-3"><i class="bi bi-info-circle me-2"></i>Basic Information</h6>
                                
                                <div class="row">
                                    <div class="col-md-8">
                                        <div class="mb-3">
                                            <label for="label" class="form-label">Item Label <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control" id="label" name="label" 
                                                   value="${item.label}" required 
                                                   placeholder="Enter item label (e.g., 50 Points, Free Coffee, Special Reward)">
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
                            </div>

                            <!-- Probability & Color Section -->
                            <div class="form-section">
                                <h6 class="text-primary mb-3"><i class="bi bi-sliders me-2"></i>Probability & Visual Settings</h6>
                                
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="probabilityWeight" class="form-label">Probability Weight <span class="text-danger">*</span></label>
                                            <div class="d-flex align-items-center">
                                                <input type="range" class="form-range probability-slider me-3" id="probabilityWeight" 
                                                       name="probabilityWeight" min="1" max="20" 
                                                       value="${item.probabilityWeight != null ? item.probabilityWeight : 1}"
                                                       oninput="updateProbabilityValue(this.value)">
                                                <span class="probability-value" id="probabilityValue">
                                                    ${item.probabilityWeight != null ? item.probabilityWeight : 1}
                                                </span>
                                            </div>
                                            <div class="form-text">
                                                <span id="probabilityDescription">Higher number = higher chance of winning</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="color" class="form-label">Color</label>
                                            <div class="d-flex align-items-center mb-2">
                                                <input type="color" class="form-control form-control-color me-3" id="color" name="color"
                                                       value="${item.color != null ? item.color : '#007bff'}" 
                                                       title="Choose a color for this segment"
                                                       onchange="updateColorPreview(this.value)">
                                                <div class="color-preview" id="colorPreview" 
                                                     style="background-color: ${item.color != null ? item.color : '#007bff'}"></div>
                                            </div>
                                            <div class="form-text">Color for the wheel segment (optional)</div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Color Suggestions -->
                                <div class="mb-3">
                                    <label class="form-label">Color Suggestions</label>
                                    <div class="d-flex flex-wrap gap-2">
                                        <div class="color-suggestion" onclick="setColor('#ff6b6b')" title="Coral Red">
                                            <div class="color-preview" style="background-color: #ff6b6b;"></div>
                                        </div>
                                        <div class="color-suggestion" onclick="setColor('#4ecdc4')" title="Turquoise">
                                            <div class="color-preview" style="background-color: #4ecdc4;"></div>
                                        </div>
                                        <div class="color-suggestion" onclick="setColor('#45b7d1')" title="Sky Blue">
                                            <div class="color-preview" style="background-color: #45b7d1;"></div>
                                        </div>
                                        <div class="color-suggestion" onclick="setColor('#96ceb4')" title="Mint Green">
                                            <div class="color-preview" style="background-color: #96ceb4;"></div>
                                        </div>
                                        <div class="color-suggestion" onclick="setColor('#feca57')" title="Golden Yellow">
                                            <div class="color-preview" style="background-color: #feca57;"></div>
                                        </div>
                                        <div class="color-suggestion" onclick="setColor('#ff9ff3')" title="Pink">
                                            <div class="color-preview" style="background-color: #ff9ff3;"></div>
                                        </div>
                                        <div class="color-suggestion" onclick="setColor('#a8e6cf')" title="Light Green">
                                            <div class="color-preview" style="background-color: #a8e6cf;"></div>
                                        </div>
                                        <div class="color-suggestion" onclick="setColor('#dcedc1')" title="Lime">
                                            <div class="color-preview" style="background-color: #dcedc1;"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                <a href="/admin/spinwheels/edit/${spinWheel.id}" class="btn btn-outline-secondary me-md-2">Cancel</a>
                                <button type="submit" class="btn btn-success">
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
            </div>

            <!-- Tips and Guidelines -->
            <div class="col-lg-4">
                <div class="card border-0 shadow-sm rounded-3 mb-4">
                    <div class="card-header bg-gradient text-white" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                        <h6 class="mb-0"><i class="bi bi-lightbulb me-2"></i>Engagement Tips</h6>
                    </div>
                    <div class="card-body">
                        <h6 class="text-primary mb-3">🎯 Point Value Strategy</h6>
                        <ul class="list-unstyled mb-3">
                            <li class="mb-2"><i class="bi bi-1-circle text-info me-2"></i><strong>5-25 pts:</strong> Daily engagement rewards</li>
                            <li class="mb-2"><i class="bi bi-2-circle text-info me-2"></i><strong>50-100 pts:</strong> Weekly goal rewards</li>
                            <li class="mb-2"><i class="bi bi-3-circle text-info me-2"></i><strong>200+ pts:</strong> Special achievement rewards</li>
                        </ul>

                        <h6 class="text-primary mb-3">⚖️ Probability Weight Guide</h6>
                        <ul class="list-unstyled mb-3">
                            <li class="mb-2"><i class="bi bi-1-circle text-success me-2"></i><strong>Weight 1:</strong> Rare (5% chance)</li>
                            <li class="mb-2"><i class="bi bi-2-circle text-warning me-2"></i><strong>Weight 2-3:</strong> Uncommon (15% chance)</li>
                            <li class="mb-2"><i class="bi bi-3-circle text-info me-2"></i><strong>Weight 5-10:</strong> Common (80% chance)</li>
                        </ul>

                        <h6 class="text-primary mb-3">🎨 Color Psychology</h6>
                        <ul class="list-unstyled mb-3">
                            <li class="mb-2"><i class="bi bi-palette text-danger me-2"></i><strong>Red:</strong> Energy, excitement</li>
                            <li class="mb-2"><i class="bi bi-palette text-primary me-2"></i><strong>Blue:</strong> Trust, stability</li>
                            <li class="mb-2"><i class="bi bi-palette text-success me-2"></i><strong>Green:</strong> Growth, success</li>
                            <li class="mb-2"><i class="bi bi-palette text-warning me-2"></i><strong>Yellow:</strong> Joy, optimism</li>
                        </ul>

                        <h6 class="text-primary mb-3">📝 Label Best Practices</h6>
                        <ul class="list-unstyled">
                            <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>Keep labels short & exciting</li>
                            <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>Use action words (Win, Get, Earn)</li>
                            <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>Make rewards feel valuable</li>
                            <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>Avoid technical jargon</li>
                        </ul>
                    </div>
                </div>

                <!-- Quick Preview -->
                <div class="card border-0 shadow-sm rounded-3">
                    <div class="card-header bg-light border-0 py-3">
                        <h6 class="mb-0"><i class="bi bi-eye text-info me-2"></i>Quick Preview</h6>
                    </div>
                    <div class="card-body text-center">
                        <div class="bg-light rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 120px; height: 120px;">
                            <div class="color-preview" id="previewColor" 
                                 style="background-color: ${item.color != null ? item.color : '#007bff'}; width: 80px; height: 80px;"></div>
                        </div>
                        <h6 id="previewLabel">${item.label != null ? item.label : 'Item Label'}</h6>
                        <span class="badge bg-primary" id="previewPoints">${item.pointValue != null ? item.pointValue : 0} pts</span>
                        <div class="mt-2">
                            <small class="text-muted">Weight: <span id="previewWeight">${item.probabilityWeight != null ? item.probabilityWeight : 1}</span></small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function updateProbabilityValue(value) {
            document.getElementById('probabilityValue').textContent = value;
            updateProbabilityDescription(value);
            updatePreview();
        }
        
        function updateProbabilityDescription(value) {
            const desc = document.getElementById('probabilityDescription');
            if (value <= 2) {
                desc.innerHTML = '<span class="text-danger">Rare reward (5% chance)</span>';
            } else if (value <= 5) {
                desc.innerHTML = '<span class="text-warning">Uncommon reward (15% chance)</span>';
            } else {
                desc.innerHTML = '<span class="text-success">Common reward (80% chance)</span>';
            }
        }
        
        function updateColorPreview(color) {
            document.getElementById('colorPreview').style.backgroundColor = color;
            updatePreview();
        }
        
        function setColor(color) {
            document.getElementById('color').value = color;
            updateColorPreview(color);
        }
        
        function updatePreview() {
            const label = document.getElementById('label').value || 'Item Label';
            const points = document.getElementById('pointValue').value || 0;
            const weight = document.getElementById('probabilityWeight').value || 1;
            const color = document.getElementById('color').value || '#007bff';
            
            document.getElementById('previewLabel').textContent = label;
            document.getElementById('previewPoints').textContent = points + ' pts';
            document.getElementById('previewWeight').textContent = weight;
            document.getElementById('previewColor').style.backgroundColor = color;
        }
        
        // Initialize
        document.addEventListener('DOMContentLoaded', function() {
            updateProbabilityDescription(document.getElementById('probabilityWeight').value);
            updatePreview();
            
            // Add event listeners for real-time preview
            document.getElementById('label').addEventListener('input', updatePreview);
            document.getElementById('pointValue').addEventListener('input', updatePreview);
        });
    </script>
</body>
</html>