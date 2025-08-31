<%@ include file="../layout/student_header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container py-4">
    <!-- Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card bg-warning text-dark shadow-lg rounded-3 border-0">
                <div class="card-body p-4">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h2 class="display-6 fw-bold">🎯 ${spinWheel.name}</h2>
                            <p class="lead mb-0">Ready to spin? Good luck!</p>
                        </div>
                        <div class="text-center">
                            <div class="bg-white rounded-circle p-3 d-inline-block">
                                <i class="bi bi-arrow-repeat text-warning" style="font-size: 3rem;"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Spinwheel Display -->
    <div class="row justify-content-center mb-4">
        <div class="col-lg-8">
            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-body text-center p-4">
                    <div id="spinwheel-container" class="position-relative mb-4">
                        <canvas id="spinwheel" width="400" height="400"></canvas>
                        <div id="spin-pointer" class="position-absolute" style="top: -10px; left: 50%; transform: translateX(-50%);">
                            <div class="triangle-up"></div>
                        </div>
                    </div>
                    
                    <div id="spin-button-container">
                        <button id="spin-button" class="btn btn-warning btn-lg px-5 py-3">
                            <i class="bi bi-arrow-repeat me-2"></i>SPIN THE WHEEL!
                        </button>
                    </div>
                    
                    <div id="result-container" class="mt-4" style="display: none;">
                        <div class="alert alert-success">
                            <h4 class="alert-heading">🎉 Congratulations!</h4>
                            <p id="result-text" class="mb-0"></p>
                        </div>
                        <a href="/students/spinwheel" class="btn btn-primary">
                            <i class="bi bi-arrow-left me-2"></i>Back to Spinwheels
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Wheel Items Preview -->
    <div class="row">
        <div class="col-12">
            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-header bg-white border-0 py-3">
                    <h5 class="mb-0"><i class="bi bi-list-ul text-primary me-2"></i>Wheel Items</h5>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <c:forEach var="item" items="${items}">
                            <div class="col-md-4 col-lg-3">
                                <div class="card h-100 border-0 shadow-sm">
                                    <div class="card-body text-center p-3">
                                        <div class="rounded-circle mx-auto mb-2 d-flex align-items-center justify-content-center" 
                                             style="width: 40px; height: 40px; background-color: ${item.color != null ? item.color : '#007bff'};">
                                            <i class="bi bi-star-fill text-white"></i>
                                        </div>
                                        <h6 class="card-title mb-1">${item.label}</h6>
                                        <span class="badge bg-warning text-dark">${item.pointValue} pts</span>
                                        <c:if test="${not empty item.description}">
                                            <small class="text-muted d-block mt-1">${item.description}</small>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- CSS for the spinwheel -->
<style>
.triangle-up {
    width: 0;
    height: 0;
    border-left: 15px solid transparent;
    border-right: 15px solid transparent;
    border-bottom: 30px solid #dc3545;
}

#spinwheel-container {
    display: inline-block;
}

#spinwheel {
    border-radius: 50%;
    box-shadow: 0 0 20px rgba(0,0,0,0.1);
}

.spinning {
    animation: spin 3s cubic-bezier(0.25, 0.46, 0.45, 0.94) forwards;
}

@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(var(--final-rotation)); }
}
</style>

<!-- JavaScript for the spinwheel -->
<script>
// Spinwheel data
const items = [
    <c:forEach var="item" items="${items}" varStatus="status">
    {
        label: '${item.label}',
        pointValue: ${item.pointValue},
        probabilityWeight: ${item.probabilityWeight},
        color: '${item.color != null ? item.color : "#007bff"}',
        description: '${item.description != null ? item.description : ""}'
    }<c:if test="${!status.last}">,</c:if>
    </c:forEach>
];

let isSpinning = false;
let currentRotation = 0;
// Initialize the spinwheel
function initSpinwheel() {
    const canvas = document.getElementById('spinwheel');
    const ctx = canvas.getContext('2d');
    const centerX = canvas.width / 2;
    const centerY = canvas.height / 2;
    const radius = 180;
    
    // Calculate total weight
    const totalWeight = items.reduce((sum, item) => sum + item.probabilityWeight, 0);
    
    // Draw segments
    let currentAngle = 0;
    items.forEach((item, index) => {
        const segmentAngle = (item.probabilityWeight / totalWeight) * 2 * Math.PI;
        
        // Draw segment
        ctx.beginPath();
        ctx.moveTo(centerX, centerY);
        ctx.arc(centerX, centerY, radius, currentAngle, currentAngle + segmentAngle);
        ctx.closePath();
        ctx.fillStyle = item.color;
        ctx.fill();
        ctx.strokeStyle = '#fff';
        ctx.lineWidth = 2;
        ctx.stroke();
        
        // Draw text
        ctx.save();
        ctx.translate(centerX, centerY);
        ctx.rotate(currentAngle + segmentAngle / 2);
        ctx.textAlign = 'center';
        ctx.fillStyle = '#fff';
        ctx.font = 'bold 14px Arial';
        ctx.fillText(item.label, radius * 0.7, 0);
        
        // Draw points
        ctx.font = '12px Arial';
        ctx.fillText(item.pointValue + ' pts', radius * 0.5, 20);
        ctx.restore();
        
        currentAngle += segmentAngle;
    });
    
    // Draw center circle
    ctx.beginPath();
    ctx.arc(centerX, centerY, 30, 0, 2 * Math.PI);
    ctx.fillStyle = '#fff';
    ctx.fill();
    ctx.strokeStyle = '#dc3545';
    ctx.lineWidth = 3;
    ctx.stroke();
    
    // Draw center text
    ctx.fillStyle = '#dc3545';
    ctx.font = 'bold 16px Arial';
    ctx.textAlign = 'center';
    ctx.fillText('SPIN', centerX, centerY + 5);
}

// Spin the wheel
function spinWheel() {
    if (isSpinning) return;
    
    isSpinning = true;
    const spinButton = document.getElementById('spin-button');
    const spinContainer = document.getElementById('spinwheel-container');
    const resultContainer = document.getElementById('result-container');
    
    // Disable spin button
    spinButton.disabled = true;
    spinButton.innerHTML = '<i class="bi bi-hourglass-split me-2"></i>Spinning...';
    
    // Hide result container
    resultContainer.style.display = 'none';
    
    // Calculate random result based on probability weights
    const totalWeight = items.reduce((sum, item) => sum + item.probabilityWeight, 0);
    let random = Math.random() * totalWeight;
    let selectedItem = null;
    let selectedIndex = 0;
    
    for (let i = 0; i < items.length; i++) {
        random -= items[i].probabilityWeight;
        if (random <= 0) {
            selectedItem = items[i];
            selectedIndex = i;
            break;
        }
    }
    
    // Calculate final rotation to land on selected item
    const segmentAngle = (2 * Math.PI) / items.length;
    const targetAngle = selectedIndex * segmentAngle + segmentAngle / 2;
    const finalRotation = 360 * 5 + (360 - (targetAngle * 180 / Math.PI)); // 5 full rotations + offset
    
    // Apply spinning animation
    spinContainer.style.setProperty('--final-rotation', finalRotation + 'deg');
    spinContainer.classList.add('spinning');
    
    // After animation completes, show result
    setTimeout(() => {
        isSpinning = false;
        spinContainer.classList.remove('spinning');
        
        // Show result
        document.getElementById('result-text').innerHTML = 
            You won <strong>${selectedItem.pointValue} points</strong> with <strong>${selectedItem.label}</strong>!;
        resultContainer.style.display = 'block';
        
        // Submit the result to the server
        submitSpinResult(selectedItem);
        
        // Reset button
        spinButton.disabled = false;
        spinButton.innerHTML = '<i class="bi bi-arrow-repeat me-2"></i>SPIN THE WHEEL!';
    }, 3000);
}
// Submit spin result to server
function submitSpinResult(selectedItem) {
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = '/students/spinwheel/${spinWheel.id}/spin';
    
    // Add CSRF token if needed
    const csrfToken = document.querySelector('meta[name="_csrf"]');
    if (csrfToken) {
        const csrfInput = document.createElement('input');
        csrfInput.type = 'hidden';
        csrfInput.name = '_csrf';
        csrfInput.value = csrfToken.content;
        form.appendChild(csrfInput);
    }
    
    document.body.appendChild(form);
    form.submit();
}

// Event listeners
document.addEventListener('DOMContentLoaded', function() {
    initSpinwheel();
    
    document.getElementById('spin-button').addEventListener('click', spinWheel);
});
</script>