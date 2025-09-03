<%@ include file="../layout/student_header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container py-4">
    <!-- Enhanced Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card bg-gradient text-white shadow-lg rounded-3 border-0 overflow-hidden" 
                 style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                <div class="card-body p-4">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h2 class="display-6 fw-bold mb-2">🎯 Lucky Spinwheels</h2>
                            <p class="lead mb-0 opacity-90">Try your luck and win points daily!</p>
                            <small class="opacity-75">Choose from available spinwheels below</small>
                        </div>
                        <div class="text-center">
                            <div class="bg-white rounded-circle p-4 d-inline-block shadow-lg spinwheel-header-icon">
                                <i class="bi bi-arrow-repeat text-primary" style="font-size: 3rem;"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Flash Messages -->
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle me-2"></i>${success}
            <button type="button" class="btn btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle me-2"></i>${error}
            <button type="button" class="btn btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Available Spinwheels -->
    <div class="row">
        <c:forEach items="${spinWheels}" var="spinWheel">
            <div class="col-md-6 col-lg-4 mb-4">
                <div class="card border-0 shadow-lg rounded-3 h-100 spinwheel-card-hover">
                    <div class="card-body text-center p-4">
                        <!-- Enhanced Spinwheel Icon -->
                        <div class="spinwheel-card-icon mb-4">
                            <div class="bg-gradient rounded-circle mx-auto d-flex align-items-center justify-content-center shadow-lg" 
                                 style="width: 100px; height: 100px; background: linear-gradient(135deg, #ff6b6b 0%, #feca57 100%);">
                                <i class="bi bi-arrow-repeat text-white spinwheel-icon" style="font-size: 2.5rem;"></i>
                            </div>
                            <div class="spinwheel-card-glow"></div>
                        </div>
                        
                        <h5 class="card-title fw-bold text-primary mb-2">${spinWheel.name}</h5>
                        <c:if test="${not empty spinWheel.description}">
                            <p class="card-text text-muted mb-3">${spinWheel.description}</p>
                        </c:if>
                        
                        <!-- Prize Preview -->
                        <div class="prize-preview-section mb-3">
                            <small class="text-muted d-block mb-2">
                                <i class="bi bi-gift me-1"></i>Available Prizes
                            </small>
                            <div class="prize-preview-container">
                                <c:forEach var="item" items="${spinWheel.items}" end="4">
                                    <div class="prize-preview-item" 
                                         style="background-color: ${item.color != null ? item.color : '#007bff'};">
                                        <span class="prize-preview-text">${item.pointValue}pts</span>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        
                        <!-- Check if student has spun today -->
                        <c:choose>
                            <c:when test="${spinWheelHistoryService.hasStudentSpunToday(student)}">
                                <div class="alert alert-info mb-3 border-0 spin-alert">
                                    <div class="d-flex align-items-center">
                                        <div class="alert-icon me-2">
                                            <i class="bi bi-info-circle text-info"></i>
                                        </div>
                                        <div class="text-start">
                                            <strong>Already Spun Today!</strong><br>
                                            <small>Come back tomorrow for another chance.</small>
                                        </div>
                                    </div>
                                </div>
                                <button class="btn btn-secondary btn-lg px-4 py-2" disabled>
                                    <i class="bi bi-clock me-2"></i>Already Spun Today
                                </button>
                            </c:when>
                            <c:otherwise>
                                <a href="/students/spinwheel/${spinWheel.id}" class="btn btn-gradient btn-lg px-4 py-2 shadow-lg spin-button">
                                    <i class="bi bi-arrow-repeat me-2"></i>Spin Now!
                                    <div class="button-shine"></div>
                                </a>
                            </c:otherwise>
                        </c:choose>
                        
                        <!-- Quick Stats -->
                        <div class="mt-3 pt-3 border-top">
                            <div class="row text-center">
                                <div class="col-6">
                                    <div class="stat-mini bg-primary bg-opacity-10 rounded p-2">
                                        <h6 class="text-primary mb-1">${spinWheel.items.size()}</h6>
                                        <small class="text-muted">Prizes</small>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="stat-mini bg-success bg-opacity-10 rounded p-2">
                                        <h6 class="text-success mb-1">
                                            <c:set var="totalWeight" value="0"/>
                                            <c:forEach var="item" items="${spinWheel.items}">
                                                <c:set var="totalWeight" value="${totalWeight + item.probabilityWeight}"/>
                                            </c:forEach>
                                            ${totalWeight}
                                        </h6>
                                        <small class="text-muted">Weight</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- Empty State -->
    <c:if test="${empty spinWheels}">
        <div class="row justify-content-center">
            <div class="col-md-6 text-center">
                <div class="card border-0 shadow-sm rounded-3">
                    <div class="card-body py-5">
                        <div class="bg-light rounded-circle mx-auto mb-4 d-flex align-items-center justify-content-center" style="width: 100px; height: 100px;">
                            <i class="bi bi-circle-square text-muted" style="font-size: 3rem;"></i>
                        </div>
                        <h5 class="text-muted mb-3">No Spinwheels Available</h5>
                        <p class="text-muted mb-4">Check back later for exciting spinwheel opportunities!</p>
                        <div class="bg-primary bg-opacity-10 rounded p-3 d-inline-block">
                            <small class="text-primary">
                                <i class="bi bi-info-circle me-1"></i>
                                Spinwheels are created by administrators
                            </small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:if>
</div>

<style>
/* Enhanced Spinwheel List Styles */
.spinwheel-card-hover {
    transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
    border-radius: 20px;
    overflow: hidden;
    position: relative;
}

.spinwheel-card-hover:hover {
    transform: translateY(-8px);
    box-shadow: 0 20px 40px rgba(102,126,234,0.3);
}

.spinwheel-card-hover::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 4px;
    background: linear-gradient(90deg, #667eea, #764ba2, #ff6b6b, #feca57);
    background-size: 200% 100%;
    animation: gradientShift 3s ease infinite;
}

/* Enhanced Header Icon */
.spinwheel-header-icon {
    transition: all 0.3s ease;
    animation: float 3s ease-in-out infinite;
}

@keyframes float {
    0%, 100% { transform: translateY(0px); }
    50% { transform: translateY(-10px); }
}

/* Spinwheel Card Icon */
.spinwheel-card-icon {
    position: relative;
    display: inline-block;
}

.spinwheel-card-icon .bg-gradient {
    transition: all 0.3s ease;
    position: relative;
    z-index: 2;
}

.spinwheel-card-hover:hover .spinwheel-card-icon .bg-gradient {
    transform: scale(1.05) rotate(5deg);
    box-shadow: 0 15px 35px rgba(255,107,107,0.4);
}

.spinwheel-icon {
    transition: all 0.3s ease;
}

.spinwheel-card-hover:hover .spinwheel-icon {
    transform: rotate(180deg);
}

.spinwheel-card-glow {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 120px;
    height: 120px;
    background: radial-gradient(circle, rgba(255,107,107,0.2) 0%, transparent 70%);
    border-radius: 50%;
    z-index: 1;
    animation: glowPulse 2s ease-in-out infinite alternate;
}

/* Enhanced Prize Preview */
.prize-preview-section {
    background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
    border-radius: 15px;
    padding: 15px;
    border: 1px solid rgba(0,0,0,0.05);
}

.prize-preview-container {
    display: flex;
    flex-wrap: wrap;
    gap: 8px;
    justify-content: center;
}

.prize-preview-item {
    width: 35px;
    height: 35px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.3s ease;
    cursor: pointer;
    box-shadow: 0 2px 8px rgba(0,0,0,0.2);
}

.prize-preview-item:hover {
    transform: scale(1.2) rotate(5deg);
    box-shadow: 0 4px 15px rgba(0,0,0,0.3);
}

.prize-preview-text {
    color: white;
    font-size: 0.6rem;
    font-weight: 600;
    text-shadow: 0 1px 2px rgba(0,0,0,0.5);
}

/* Enhanced Stats */
.stat-mini {
    transition: all 0.3s ease;
    border: 1px solid rgba(0,0,0,0.05);
}

.stat-mini:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}

/* Enhanced Alert */
.spin-alert {
    background: linear-gradient(135deg, #d1ecf1 0%, #bee5eb 100%);
    border-radius: 15px;
    border: none;
    box-shadow: 0 4px 15px rgba(23,162,184,0.2);
}

.alert-icon {
    font-size: 1.2rem;
    animation: bounce 2s infinite;
}

/* Responsive Design */
@media (max-width: 768px) {
    .spinwheel-card-icon .bg-gradient {
        width: 80px !important;
        height: 80px !important;
    }
    
    .spinwheel-icon {
        font-size: 2rem !important;
    }
    
    .spinwheel-card-glow {
        width: 100px;
        height: 100px;
    }
    
    .prize-preview-item {
        width: 30px;
        height: 30px;
    }
    
    .prize-preview-text {
        font-size: 0.5rem;
    }
}
</style>
