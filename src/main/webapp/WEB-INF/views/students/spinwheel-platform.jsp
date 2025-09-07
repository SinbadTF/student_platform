<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${spinWheel.name} - Spinwheel</title>
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
        .spinwheel-container {
            position: relative;
            width: 300px;
            height: 300px;
            margin: 0 auto;
        }
        .spinwheel {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            border: 8px solid #fff;
            box-shadow: 0 0 20px rgba(0,0,0,0.3);
            position: relative;
            transition: transform 3s cubic-bezier(0.23, 1, 0.32, 1);
        }
        .spinwheel-item {
            position: absolute;
            width: 50%;
            height: 50%;
            transform-origin: 100% 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            color: white;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.5);
        }
        .spin-button {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: #fff;
            border: 4px solid #007bff;
            color: #007bff;
            font-weight: bold;
            z-index: 10;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }
        .result-modal .modal-content {
            border: none;
            border-radius: 15px;
        }
        .result-icon {
            font-size: 4rem;
            color: #28a745;
        }
    </style>
</head>
<body>
    <jsp:include page="../layout/student_header.jsp" />
    
    <div class="container py-4">
        <!-- Header -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h2 class="display-6 fw-bold">${spinWheel.name}</h2>
                        <p class="lead text-muted">${spinWheel.description}</p>
                    </div>
                    <div class="text-end">
                        <div class="badge bg-primary fs-6 p-2 me-2">
                            <i class="bi bi-star-fill me-1"></i>${student.points} Points
                        </div>
                        <a href="/students/dashboard/${student.id}" class="btn btn-outline-secondary btn-sm">
                            <i class="bi bi-house me-1"></i>Dashboard
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

        <div class="row justify-content-center">
            <div class="col-lg-8">
                <!-- Spinwheel -->
                <div class="card border-0 shadow-sm rounded-3">
                    <div class="card-body text-center py-5">
                        <c:choose>
                            <c:when test="${hasSpunToday}">
                                <div class="text-center">
                                    <i class="bi bi-hourglass-split text-warning" style="font-size: 4rem;"></i>
                                    <h4 class="mt-3 text-warning">Already Spun Today!</h4>
                                    <p class="text-muted">You can spin again at the specified time. Come back for more chances to win!</p>
                                    <a href="/students/spinwheel" class="btn btn-outline-primary">
                                        <i class="bi bi-arrow-left me-2"></i>Back to Spinwheels
                                    </a>
                                </div>
                            </c:when>
                            <c:when test="${empty items}">
                                <div class="text-center">
                                    <i class="bi bi-exclamation-triangle text-warning" style="font-size: 4rem;"></i>
                                    <h4 class="mt-3 text-warning">No Items Available</h4>
                                    <p class="text-muted">This spinwheel doesn't have any items yet.</p>
                                    <a href="/students/spinwheel" class="btn btn-outline-primary">
                                        <i class="bi bi-arrow-left me-2"></i>Back to Spinwheels
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="spinwheel-container mb-4" style="position: relative; width: 200px; height: 200px; margin: 0 auto;">
                                    <div class="spinwheel" id="spinwheel" style="width: 100%; height: 100%; border-radius: 50%; border: 6px solid #fff; box-shadow: 0 0 15px rgba(0,0,0,0.3); position: relative; background: conic-gradient(#ff6b6b 0deg 60deg, #4ecdc4 60deg 120deg, #45b7d1 120deg 180deg, #96ceb4 180deg 240deg, #feca57 240deg 300deg, #ff9ff3 300deg 360deg);">
                                        <!-- Sample items will be added by JavaScript -->
                                    </div>
                                    <button class="spin-button" id="spinButton" onclick="spinWheel()" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 50px; height: 50px; border-radius: 50%; background: #fff; border: 3px solid #007bff; color: #007bff; font-weight: bold; z-index: 10; box-shadow: 0 4px 8px rgba(0,0,0,0.2);">
                                        <i class="bi bi-play-fill"></i>
                                    </button>
                                </div>
                                
                                <div class="mt-4">
                                    <form method="post" action="/students/spinwheel/${spinWheel.id}/spin" id="spinForm" style="display: none;">
                                        <button type="submit" class="btn btn-success btn-lg me-2">
                                            <i class="bi bi-check-circle me-2"></i>Confirm Spin!
                                        </button>

                                    </form>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Items List -->
                <c:if test="${not empty items}">
                    <div class="card border-0 shadow-sm rounded-3 mt-4">
                        <div class="card-header bg-white border-0 py-3">
                            <h5 class="mb-0"><i class="bi bi-list-ul text-info me-2"></i>Possible Rewards</h5>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <c:forEach var="item" items="${items}" varStatus="status">
                                    <div class="col-md-6 mb-3">
                                        <div class="d-flex align-items-center p-3 border rounded">
                                            <div class="rounded-circle me-3 d-flex align-items-center justify-content-center item-icon" 
                                                 style="width: 40px; height: 40px;"
                                                 data-color="<c:out value='${item.itemColor}'/>"
                                                 data-index="${status.index}">
                                                <i class="<c:out value='${item.icon}'/> text-white"></i>
                                            </div>
                                            <div>
                                                <strong>${item.label}</strong>
                                                <br>
                                                <small class="text-muted">${item.pointValue} points</small>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <!-- Result Modal -->
    <div class="modal fade result-modal" id="resultModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-body text-center py-5">
                    <div class="result-icon">
                        <i class="bi bi-trophy-fill"></i>
                    </div>
                    <h3 class="mt-3">Congratulations!</h3>
                    <p class="lead">You won <strong id="resultPoints">0</strong> points!</p>
                    <p class="text-muted" id="resultItem">with your spin!</p>
                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal">
                        Awesome!
                    </button>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="../layout/footer.jsp" />
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Debug information (hidden in production) -->
    <c:if test="${not empty items}">
        <div class="alert alert-info" style="display:none">
            <strong>Debug Info:</strong> Found ${items.size()} items
            <c:forEach var="item" items="${items}" varStatus="status">
                <br>Item ${status.index + 1}: ${item.label} - Color: ${item.itemColor} - Icon: ${item.icon}
            </c:forEach>
        </div>
    </c:if>

    <!-- Items data as JSON -->
    <script type="application/json" id="items-data">
        [
            <c:forEach var="item" items="${items}" varStatus="status">
            {
                "id": <c:out value='${item.id}'/>,
                "label": "<c:out value='${item.label}' escapeXml='false'/>",
                "pointValue": <c:out value='${item.pointValue}'/>,
                "probabilityWeight": <c:out value='${item.probabilityWeight}'/>,
                "itemColor": "<c:out value='${item.itemColor}' escapeXml='false'/>",
                "icon": "<c:out value='${item.icon}' escapeXml='false'/>"
            }<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ]
    </script>
    
    <script>
        // Items data from server with safe defaults
        const items = JSON.parse(document.getElementById('items-data').textContent).map(function(it){
            return {
                id: it.id,
                label: it.label,
                pointValue: it.pointValue,
                probabilityWeight: it.probabilityWeight,
                itemColor: (it.itemColor && it.itemColor.trim() !== '') ? it.itemColor : '#007bff',
                icon: (it.icon && it.icon.trim() !== '') ? it.icon : 'bi-star'
            };
        });
        
        let isSpinning = false;
        let currentRotation = 0;
        
        function renderSpinwheel() {
            const spinwheel = document.getElementById('spinwheel');
            if (!spinwheel || items.length === 0) {
                console.log('Cannot render spinwheel: missing element or no items');
                return;
            }
            
            console.log('Rendering spinwheel with', items.length, 'items');
            
            // Calculate weights inversely proportional to points (lower points = bigger slice)
            const computedWeights = items.map(function(item){
                var pts = Number(item.pointValue);
                if (!isFinite(pts) || pts <= 0) return 1; // fallback equal weight when missing/zero
                return 1 / pts;
            });
            let totalWeight = computedWeights.reduce(function(a,b){ return a + b; }, 0);
            if (!isFinite(totalWeight) || totalWeight <= 0) {
                totalWeight = items.length; // fallback to equal distribution
                for (var i = 0; i < computedWeights.length; i++) computedWeights[i] = 1;
            }
            let currentAngle = 0;
            
            // Create conic gradient
            let gradientParts = [];
            items.forEach((item, index) => {
                const weight = computedWeights[index] || 1;
                const angle = (weight / totalWeight) * 360;
                const startAngle = currentAngle;
                const endAngle = currentAngle + angle;
                
                const color = item.itemColor || '#007bff';
                gradientParts.push(`${color} ${startAngle}deg ${endAngle}deg`);
                currentAngle = endAngle;
            });
            
            // Apply gradient
            spinwheel.style.background = `conic-gradient(${gradientParts.join(', ')})`;
            
            // Add item labels and icons
            spinwheel.innerHTML = '';
            currentAngle = 0;
            items.forEach((item, index) => {
                const weight = computedWeights[index] || 1;
                const angle = (weight / totalWeight) * 360;
                const centerAngle = currentAngle + (angle / 2);
                const radians = (centerAngle * Math.PI) / 180;
                
                // Calculate position for label (closer to center)
                const radius = 100; // Distance from center
                const x = Math.cos(radians) * radius;
                const y = Math.sin(radians) * radius;
                
                const labelDiv = document.createElement('div');
                labelDiv.style.position = 'absolute';
                labelDiv.style.left = '50%';
                labelDiv.style.top = '50%';
                labelDiv.style.transform = `translate(${x}px, ${y}px) translate(-50%, -50%)`;
                labelDiv.style.textAlign = 'center';
                labelDiv.style.fontSize = '11px';
                labelDiv.style.fontWeight = 'bold';
                labelDiv.style.color = 'white';
                labelDiv.style.textShadow = '1px 1px 2px rgba(0,0,0,0.8)';
                labelDiv.style.pointerEvents = 'none';
                labelDiv.style.zIndex = '5';
                
                const icon = item.icon || 'bi-star';
                const label = item.label || 'Item';
                const points = item.pointValue || 0;
                
                labelDiv.innerHTML = `
                    <i class="${icon}" style="font-size: 16px; display: block; margin-bottom: 3px;"></i>
                    <div style="font-size: 9px; line-height: 1.2;">${label}</div>
                    <div style="font-size: 8px; opacity: 0.9;">${points}pts</div>
                `;
                
                spinwheel.appendChild(labelDiv);
                currentAngle += angle;
            });
            
            console.log('Spinwheel rendered successfully');
        }
        
        function spinWheel() {
            if (isSpinning) return;
            
            const spinwheel = document.getElementById('spinwheel');
            const spinButton = document.getElementById('spinButton');
            const spinForm = document.getElementById('spinForm');
            const wheelId = '${spinWheel.id}';
            const studentId = '${student.id}';
            const todayKey = 'spinwheel:' + wheelId + ':student:' + studentId + ':date';
            const countKey = 'spinwheel:' + wheelId + ':student:' + studentId + ':count';
            const maxKey = 'spinwheel:' + wheelId + ':maxSpinsPerDay';
            const cdKey = 'spinwheel:' + wheelId + ':cooldownHours';

            try {
                // UI-only enforcement using values stored from admin form
                var storedDate = localStorage.getItem(todayKey);
                var todayStr = new Date().toISOString().slice(0,10);
                if (storedDate !== todayStr) {
                    localStorage.setItem(todayKey, todayStr);
                    localStorage.setItem(countKey, '0');
                }
                var count = parseInt(localStorage.getItem(countKey) || '0', 10);
                var max = parseInt(localStorage.getItem(maxKey) || '1', 10);
                
                // Debug logging
                console.log('Spin check - Student:', studentId, 'Count:', count, 'Max:', max, 'WheelId:', wheelId);
                console.log('localStorage maxSpinsPerDay:', localStorage.getItem(maxKey));
                
                if (count >= max) {
                    alert('You have reached the maximum spins for today. (' + count + '/' + max + ')');
                    return;
                }
                var lastSpinTs = parseInt(localStorage.getItem('spinwheel:' + wheelId + ':student:' + studentId + ':lastTs') || '0', 10);
                var cooldownH = parseInt(localStorage.getItem(cdKey) || '0', 10);
                if (cooldownH > 0 && lastSpinTs > 0) {
                    var msSince = Date.now() - lastSpinTs;
                    var msNeeded = cooldownH * 3600000;
                    if (msSince < msNeeded) {
                        var minsLeft = Math.ceil((msNeeded - msSince) / 60000);
                        alert('Please wait ' + minsLeft + ' minutes before spinning again.');
                        return;
                    }
                }
            } catch (e) { 
                console.error('Error checking spin limits:', e);
            }
            
            isSpinning = true;
            
            // Disable button and show spinning state
            spinButton.disabled = true;
            spinButton.innerHTML = '<i class="bi bi-hourglass-split"></i>';
            spinButton.style.animation = 'spin 1s linear infinite';
            
            // Random rotation (multiple full rotations + random angle)
            const randomRotation = Math.random() * 360 + 1800; // 5+ full rotations
            currentRotation += randomRotation;
            
            // Add spinning animation
            spinwheel.style.transition = 'transform 4s cubic-bezier(0.23, 1, 0.32, 1)';
            spinwheel.style.transform = `rotate(${currentRotation}deg)`;
            
            // Show form after animation
            setTimeout(() => {
                spinForm.style.display = 'block';
                spinButton.style.animation = 'none';
                isSpinning = false;
                try {
                    var c = parseInt(localStorage.getItem(countKey) || '0', 10);
                    localStorage.setItem(countKey, String(c + 1));
                    localStorage.setItem('spinwheel:' + wheelId + ':student:' + studentId + ':lastTs', String(Date.now()));
                } catch (e) { /* noop */ }
            }, 4000);
        }
        
        // Function to reset spinwheel for next spin
        function resetSpinwheel() {
            const spinwheel = document.getElementById('spinwheel');
            const spinButton = document.getElementById('spinButton');
            const spinForm = document.getElementById('spinForm');
            
            if (spinwheel) {
                // Reset rotation without animation
                spinwheel.style.transition = 'none';
                spinwheel.style.transform = 'rotate(0deg)';
                currentRotation = 0;
            }
            
            if (spinButton) {
                spinButton.disabled = false;
                spinButton.innerHTML = '<i class="bi bi-play-fill"></i>';
                spinButton.style.animation = 'none';
            }
            
            if (spinForm) {
                spinForm.style.display = 'none';
            }
            
            isSpinning = false;
        }
        
        // Add CSS animation for spinning button
        const style = document.createElement('style');
        style.textContent = `
            @keyframes spin {
                from { transform: translate(-50%, -50%) rotate(0deg); }
                to { transform: translate(-50%, -50%) rotate(360deg); }
            }
        `;
        document.head.appendChild(style);
        
        // Initialize spinwheel when page loads
        document.addEventListener('DOMContentLoaded', function() {
            try {
                // Set background colors for item icons
                document.querySelectorAll('.item-icon').forEach(function(icon) {
                    const color = icon.getAttribute('data-color');
                    if (color) {
                        icon.style.backgroundColor = color;
                    }
                });
                
                // Initialize spin limits from admin form
                initializeSpinLimits();
                
                renderSpinwheel();
            } catch (error) {
                console.error('Error initializing spinwheel:', error);
                // Fallback: show a simple message
                const spinwheel = document.getElementById('spinwheel');
                if (spinwheel) {
                    spinwheel.innerHTML = '<div style="display: flex; align-items: center; justify-content: center; height: 100%; color: white; font-weight: bold;">Loading...</div>';
                }
            }
        });
        
        // Initialize spin limits from admin form
        function initializeSpinLimits() {
            try {
                const wheelId = '${spinWheel.id}';
                const studentId = '${student.id}';
                const maxKey = 'spinwheel:' + wheelId + ':maxSpinsPerDay';
                const cdKey = 'spinwheel:' + wheelId + ':cooldownHours';
                
                // Check if values exist in localStorage, if not set defaults
                if (!localStorage.getItem(maxKey)) {
                    localStorage.setItem(maxKey, '1'); // Default 1 spin per day
                    console.log('Set default maxSpinsPerDay to 1 for wheel', wheelId);
                }
                if (!localStorage.getItem(cdKey)) {
                    localStorage.setItem(cdKey, '24'); // Default 24 hours cooldown
                    console.log('Set default cooldownHours to 24 for wheel', wheelId);
                }
                
                // Sync with admin form values if they exist
                syncWithAdminForm(wheelId);
                
                console.log('Spin limits initialized for student', studentId, '- Max:', localStorage.getItem(maxKey), 'Cooldown:', localStorage.getItem(cdKey));
            } catch (e) {
                console.error('Error initializing spin limits:', e);
            }
        }
        
        // Sync with admin form values
        function syncWithAdminForm(wheelId) {
            try {
                // Check if admin has set values for this wheel
                const adminMaxKey = 'spinwheel:' + wheelId + ':maxSpinsPerDay';
                const adminCdKey = 'spinwheel:' + wheelId + ':cooldownHours';
                
                // If admin values exist, use them
                const adminMax = localStorage.getItem(adminMaxKey);
                const adminCd = localStorage.getItem(adminCdKey);
                
                if (adminMax !== null) {
                    localStorage.setItem(adminMaxKey, adminMax);
                    console.log('Synced maxSpinsPerDay from admin:', adminMax);
                }
                if (adminCd !== null) {
                    localStorage.setItem(adminCdKey, adminCd);
                    console.log('Synced cooldownHours from admin:', adminCd);
                }
            } catch (e) {
                console.error('Error syncing with admin form:', e);
            }
        }

    </script>
    
    <!-- Result modal script -->
    <c:if test="${not empty spunItem}">
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('resultPoints').textContent = '<c:out value="${spunItem.pointValue}" escapeXml="false"/>';
            document.getElementById('resultItem').textContent = 'with <c:out value="${spunItem.label}" escapeXml="false"/>!';
            new bootstrap.Modal(document.getElementById('resultModal')).show();
        });
    </script>
    </c:if>
</body>
</html>