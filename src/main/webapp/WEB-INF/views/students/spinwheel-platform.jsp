<%@ include file="../layout/student_header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container py-4">
    <!-- Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card bg-gradient text-white shadow-lg rounded-3 border-0" 
                 style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                <div class="card-body p-4">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h2 class="display-6 fw-bold">🎯 ${spinWheel.name}</h2>
                            <p class="lead mb-0">Ready to spin? Good luck!</p>
                            <c:if test="${not empty spinWheel.description}">
                                <small class="opacity-75">${spinWheel.description}</small>
                            </c:if>
                        </div>
                        <div class="text-center">
                            <div class="bg-white rounded-circle p-3 d-inline-block shadow">
                                <i class="bi bi-arrow-repeat text-primary" style="font-size: 3rem;"></i>
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
            <div class="card border-0 shadow-lg rounded-3">
                <div class="card-body text-center p-4">
                    <div id="spinwheel-container" class="position-relative mb-4">
                        <canvas id="spinwheel" width="400" height="400"></canvas>
                        <div id="spin-pointer" class="position-absolute" style="top: -15px; left: 50%; transform: translateX(-50%);">
                            <div class="triangle-up"></div>
                        </div>
                    </div>
                    
                    <div id="spin-button-container">
                        <c:choose>
                            <c:when test="${hasSpunToday}">
                                <div class="alert alert-info mb-3">
                                    <i class="bi bi-info-circle me-2"></i>
                                    You've already spun today! Come back tomorrow for another chance to win.
                                </div>
                                <button class="btn btn-secondary btn-lg px-5 py-3" disabled>
                                    <i class="bi bi-clock me-2"></i>Already Spun Today
                                </button>
                            </c:when>
                            <c:otherwise>
                                <button id="spin-button" class="btn btn-gradient btn-lg px-5 py-3 shadow">
                                    <i class="bi bi-arrow-repeat me-2"></i>SPIN THE WHEEL!
                                </button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <div id="result-container" class="mt-4" style="display: none;">
                        <div class="alert alert-success border-0 shadow-sm">
                            <h5 class="mb-2"><i class="bi bi-trophy text-warning me-2"></i>Congratulations!</h5>
                            <p id="result-text" class="mb-0 fs-5"></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Prize Items Preview -->
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-header bg-light border-0 py-3">
                    <h5 class="mb-0"><i class="bi bi-gift text-success me-2"></i>Available Prizes</h5>
                </div>
                <div class="card-body p-4">
                    <!-- Hidden data source for JS -->
                    <div id="spin-data" style="display:none;">
                        <c:forEach var="item" items="${items}">
                            <div data-item="1"
                                 data-label="<c:out value='${item.label}'/>"
                                 data-points="${item.pointValue}"
                                 data-weight="${item.probabilityWeight}"
                                 data-color="<c:out value='${item.color}'/>"
                                 data-desc="<c:out value='${item.description}'/>"></div>
                        </c:forEach>
                    </div>
                    <div class="row">
                        <c:forEach var="item" items="${items}">
                            <div class="col-md-6 col-lg-4 mb-3">
                                <div class="prize-item-card p-3 text-center" 
                                     style="border: 3px solid #007bff; border-radius: 12px;">
                                    <div class="prize-color-circle mx-auto mb-2" 
                                         style="background-color: #007bff; width: 50px; height: 50px; border-radius: 50%;"></div>
                                    <h6 class="mb-1">${item.label}</h6>
                                    <span class="badge bg-primary mb-2">${item.pointValue} pts</span>
                                    <c:if test="${not empty item.description}">
                                        <small class="text-muted d-block">${item.description}</small>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
.triangle-up {
    width: 0;
    height: 0;
    border-left: 15px solid transparent;
    border-right: 15px solid transparent;
    border-bottom: 20px solid #dc3545;
    filter: drop-shadow(0 2px 4px rgba(0,0,0,0.3));
}

.btn-gradient {
    background: linear-gradient(135deg, #ff6b6b 0%, #feca57 100%);
    border: none;
    color: white;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    transition: all 0.3s ease;
}

.btn-gradient:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(255,107,107,0.4);
    color: white;
}

.btn-gradient:active {
    transform: translateY(0);
}

.prize-item-card {
    transition: all 0.3s ease;
    background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
}

.prize-item-card:hover {
    transform: translateY(-3px);
    box-shadow: 0 8px 25px rgba(0,0,0,0.15);
}

.prize-color-circle {
    transition: all 0.3s ease;
}

.prize-item-card:hover .prize-color-circle {
    transform: scale(1.1);
}

.spinning {
    animation: spin 3s cubic-bezier(0.25, 0.46, 0.45, 0.94) forwards;
}

@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(var(--final-rotation)); }
}

#spinwheel-container {
    transition: all 0.3s ease;
}

#spinwheel-container:hover {
    transform: scale(1.02);
}

#result-container {
    animation: slideInUp 0.5s ease-out;
}

@keyframes slideInUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.alert-success {
    background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
    border: none;
    color: #155724;
}

.badge {
    font-size: 0.9rem;
    padding: 0.5rem 0.8rem;
}
</style>

<!-- JavaScript for the spinwheel (single instance, animated) -->
<script src="<c:url value='/resources/js/spinwheel.js' />"></script>
<script>
// Spinwheel data injected via DOM to avoid JS template issues
let items = [];
let wheelInstance;

function submitSpinResult() {
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = '/students/spinwheel/${spinWheel.id}/spin';
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

document.addEventListener('DOMContentLoaded', function() {
    // Build items from hidden DOM data
    const dataNodes = document.querySelectorAll('#spin-data [data-item]');
    items = Array.from(dataNodes).map(function(node) {
        return {
            label: node.getAttribute('data-label') || '',
            pointValue: parseInt(node.getAttribute('data-points') || '0', 10),
            probabilityWeight: parseFloat(node.getAttribute('data-weight') || '0'),
            color: node.getAttribute('data-color') || '#007bff',
            description: node.getAttribute('data-desc') || ''
        };
    });

    wheelInstance = new SpinWheel('spinwheel', items, {
        radius: 180,
        centerText: 'SPIN'
    });

    const spinButton = document.getElementById('spin-button');
    const resultContainer = document.getElementById('result-container');
    const resultText = document.getElementById('result-text');

    if (spinButton) {
        spinButton.addEventListener('click', async function() {
            if (!wheelInstance || wheelInstance.isSpinning) return;
            spinButton.disabled = true;
            spinButton.innerHTML = '<i class="bi bi-hourglass-split me-2"></i>Spinning...';
            resultContainer.style.display = 'none';

            const selectedItem = await wheelInstance.spin();

            resultText.innerHTML = 'You won <strong class="text-warning">' + selectedItem.pointValue + ' points</strong> with <strong class="text-primary">' + selectedItem.label + '</strong>!';
            resultContainer.style.display = 'block';
            submitSpinResult();

            spinButton.disabled = false;
            spinButton.innerHTML = '<i class="bi bi-arrow-repeat me-2"></i>SPIN THE WHEEL!';
        });
    }
});
</script>