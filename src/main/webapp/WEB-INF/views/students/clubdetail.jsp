<%@ include file="../layout/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<!-- Club Detail View -->
<div class="container py-4">
    <!-- Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h2 class="display-6 fw-bold text-primary">
                        <i class="bi bi-people-fill me-2"></i>Club Details
                    </h2>
                    <p class="lead text-muted">Learn more about this club and its community</p>
                </div>
                <div>
                    <a href="/students/clubs" class="btn btn-outline-primary">
                        <i class="bi bi-arrow-left me-2"></i>Back to Clubs
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Success/Error Messages -->
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle me-2"></i>${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle me-2"></i>${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Club Information Card -->
    <div class="row mb-4">
        <div class="col-lg-8">
            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-body p-4">
                    <div class="d-flex align-items-center mb-4">
                        <div class="bg-primary bg-opacity-10 rounded-circle p-4 me-4">
                            <i class="fa-solid fa-dumbbell text-primary" style="font-size: 2.5rem;"></i>
                        </div>
                        <div>
                            <h3 class="card-title mb-2 fw-bold">${club.name}</h3>
                            <p class="text-muted mb-0">
                                <i class="bi bi-calendar-event me-2"></i>
                                <c:choose>
                                    <c:when test="${not empty club.createdDate}">
                                        Created on <fmt:formatDate value="${club.createdDate}" pattern="MMMM dd, yyyy"/>
                                    </c:when>
                                    <c:otherwise>
                                        Club information available
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                    </div>
                    
                    <div class="mb-4">
                        <h5 class="fw-bold mb-3">About This Club</h5>
                        <p class="card-text text-muted">
                            <c:choose>
                                <c:when test="${not empty club.description}">
                                    ${club.description}
                                </c:when>
                                <c:otherwise>
                                    <em>No description available for this club.</em>
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                    
                    <c:if test="${not empty club.meetingScheduleTitle}">
                        <div class="mb-4">
                            <h5 class="fw-bold mb-3">Meeting Schedule</h5>
                            <div class="alert alert-info border-0">
                                <i class="bi bi-calendar-event me-2"></i>
                                <strong>Schedule:</strong> ${club.meetingScheduleTitle}
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
        
        <!-- Join Club Card -->
        <div class="col-lg-4">
            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-body p-4">
                    <h5 class="fw-bold mb-3">Join This Club</h5>
                    
                                         <c:choose>
                         <c:when test="${membershipStatus == true}">
                             <div class="text-center">
                                 <div class="bg-success bg-opacity-10 rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
                                     <i class="bi bi-check-circle text-success" style="font-size: 2rem;"></i>
                                 </div>
                                 <h6 class="text-success fw-bold">Already a Member!</h6>
                                 <p class="text-muted small">You're already part of this amazing community.</p>
                                 <div class="d-grid gap-2">
                                     <button class="btn btn-secondary w-100" disabled>
                                         <i class="bi bi-check-circle me-2"></i>Member
                                     </button>
                                     <form action="/students/clubs/quit/${club.id}" method="post" onsubmit="return confirm('Are you sure you want to quit ${club.name}? This action cannot be undone.')">
                                         <button type="submit" class="btn btn-danger w-100">
                                             <i class="bi bi-box-arrow-right me-2"></i>Quit Club
                                         </button>
                                     </form>
                                 </div>
                             </div>
                         </c:when>
                         <c:when test="${canRejoin == true}">
                             <div class="text-center">
                                 <div class="bg-warning bg-opacity-10 rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
                                     <i class="bi bi-arrow-clockwise text-warning" style="font-size: 2rem;"></i>
                                 </div>
                                 <h6 class="text-warning fw-bold">Rejoin This Club</h6>
                                 <p class="text-muted small">You were previously a member. Ready to come back?</p>
                                 <form action="/students/clubs/join/${club.id}" method="post" onsubmit="return confirm('Are you sure you want to rejoin ${club.name}?')">
                                     <button type="submit" class="btn btn-warning w-100">
                                         <i class="bi bi-arrow-clockwise me-2"></i>Rejoin Club
                                     </button>
                                 </form>
                             </div>
                         </c:when>
                         <c:otherwise>
                             <div class="text-center">
                                 <div class="bg-primary bg-opacity-10 rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
                                     <i class="bi bi-people-fill text-primary" style="font-size: 2rem;"></i>
                                 </div>
                                 <p class="text-muted small mb-3">Ready to join this community?</p>
                                 <form action="/students/clubs/join/${club.id}" method="post" onsubmit="return confirm('Are you sure you want to join ${club.name}?')">
                                     <button type="submit" class="btn btn-success w-100">
                                         <i class="bi bi-plus-circle me-2"></i>Join Club
                                     </button>
                                 </form>
                             </div>
                         </c:otherwise>
                     </c:choose>
                </div>
            </div>
        </div>
    </div>

    <!-- Club Rules Section -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-header bg-light border-0">
                    <h5 class="mb-0 fw-bold">
                        <i class="bi bi-shield-check me-2 text-primary"></i>Club Rules & Guidelines
                    </h5>
                </div>
                <div class="card-body p-4">
                    <div class="row">
                        <div class="col-md-6">
                            <h6 class="fw-bold text-primary mb-3">General Rules</h6>
                            <ul class="list-unstyled">
                                <li class="mb-2">
                                    <i class="bi bi-check-circle-fill text-success me-2"></i>
                                   100 points will be earned for joining. 
                                </li>
                                <li class="mb-2">
                                    <i class="bi bi-check-circle-fill text-success me-2"></i>
                                  100 points will be reduced once you quit the club.
                                </li>
                                <li class="mb-2">
                                    <i class="bi bi-check-circle-fill text-success me-2"></i>
                                    Respect all club members and maintain a positive environment
                                </li>
                                <li class="mb-2">
                                    <i class="bi bi-check-circle-fill text-success me-2"></i>
                                    Attend meetings regularly and participate actively
                                </li>
                                <li class="mb-2">
                                    <i class="bi bi-check-circle-fill text-success me-2"></i>
                                    Follow the club's meeting schedule and be punctual
                                </li>
                                <li class="mb-2">
                                    <i class="bi bi-check-circle-fill text-success me-2"></i>
                                    Contribute constructively to club discussions and activities
                                </li>
                              
                            </ul>
                        </div>
                        <div class="col-md-6">
                            <h6 class="fw-bold text-primary mb-3">Code of Conduct</h6>
                            <ul class="list-unstyled">
                                <li class="mb-2">
                                    <i class="bi bi-check-circle-fill text-success me-2"></i>
                                    No discrimination or harassment of any kind
                                </li>
                                <li class="mb-2">
                                    <i class="bi bi-check-circle-fill text-success me-2"></i>
                                    Use appropriate language and behavior
                                </li>
                                <li class="mb-2">
                                    <i class="bi bi-check-circle-fill text-success me-2"></i>
                                    Respect club property and facilities
                                </li>
                                <li class="mb-2">
                                    <i class="bi bi-check-circle-fill text-success me-2"></i>
                                    Report any concerns to club administrators
                                </li>
                                <li class="mb-2">
                                    <i class="bi bi-check-circle-fill text-success me-2"></i>
                                    Follow university policies and regulations
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Club Admin Information -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-header bg-light border-0">
                    <h5 class="mb-0 fw-bold">
                        <i class="bi bi-person-badge me-2 text-primary"></i>Club Administration
                    </h5>
                </div>
                <div class="card-body p-4">
                    <div class="row">
                        <c:choose>
                            <c:when test="${not empty club.createdBy}">
                                <div class="col-md-6">
                                    <h6 class="fw-bold text-primary mb-3">Club Creator</h6>
                                    <div class="d-flex align-items-center">
                                        <div class="bg-primary bg-opacity-10 rounded-circle p-3 me-3">
                                            <i class="bi bi-person-fill text-primary" style="font-size: 1.5rem;"></i>
                                        </div>
                                        <div>
                                            <p class="mb-1 fw-bold">${club.createdBy.name}</p>
                                            <p class="text-muted small mb-0">Club Administrator</p>
                                            <p class="text-muted small mb-0">${club.createdBy.email}</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <h6 class="fw-bold text-primary mb-3">Contact Information</h6>
                                    <div class="d-flex align-items-center mb-2">
                                        <i class="bi bi-envelope text-muted me-2"></i>
                                        <span>${club.createdBy.email}</span>
                                    </div>
                                    <div class="d-flex align-items-center mb-2">
                                        <i class="bi bi-telephone text-muted me-2"></i>
                                        <span>${club.createdBy.phone != null ? club.createdBy.phone : 'Not provided'}</span>
                                    </div>
                                    <div class="d-flex align-items-center">
                                        <i class="bi bi-geo-alt text-muted me-2"></i>
                                        <span>${club.createdBy.department != null ? club.createdBy.department : 'Not specified'}</span>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="col-12">
                                    <div class="text-center">
                                        <div class="bg-light rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
                                            <i class="bi bi-person-fill text-muted" style="font-size: 2rem;"></i>
                                        </div>
                                        <h6 class="text-muted">Administrator Information</h6>
                                        <p class="text-muted small">Administrator details not available</p>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Additional Information -->
    <div class="row">
        <div class="col-12">
            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-header bg-light border-0">
                    <h5 class="mb-0 fw-bold">
                        <i class="bi bi-info-circle me-2 text-primary"></i>Additional Information
                    </h5>
                </div>
                <div class="card-body p-4">
                    <div class="row">
                        <div class="col-md-4 text-center mb-3">
                            <div class="bg-light rounded-circle mx-auto mb-2 d-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                                <i class="bi bi-calendar-check text-primary" style="font-size: 1.5rem;"></i>
                            </div>
                            <h6 class="fw-bold">Meeting Frequency</h6>
                            <p class="text-muted small">Regular weekly meetings</p>
                        </div>
                        <div class="col-md-4 text-center mb-3">
                            <div class="bg-light rounded-circle mx-auto mb-2 d-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                                <i class="bi bi-clock text-primary" style="font-size: 1.5rem;"></i>
                            </div>
                            <h6 class="fw-bold">Duration</h6>
                            <p class="text-muted small">1-2 hours per session</p>
                        </div>
                        <div class="col-md-4 text-center mb-3">
                            <div class="bg-light rounded-circle mx-auto mb-2 d-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                                <i class="bi bi-people text-primary" style="font-size: 1.5rem;"></i>
                            </div>
                            <h6 class="fw-bold">Membership</h6>
                            <p class="text-muted small">Open to all students</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
.card {
    transition: all 0.3s ease;
}

.card:hover {
    transform: translateY(-2px);
    box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15) !important;
}

.bg-primary {
    background-color: #0d6efd !important;
}

.text-primary {
    color: #0d6efd !important;
}

.btn-primary {
    background-color: #0d6efd;
    border-color: #0d6efd;
}

.btn-primary:hover {
    background-color: #0b5ed7;
    border-color: #0a58ca;
}

.rounded-3 {
    border-radius: 0.75rem !important;
}

.btn-danger {
    background-color: #dc3545;
    border-color: #dc3545;
}

.btn-danger:hover {
    background-color: #c82333;
    border-color: #bd2130;
}

.btn-warning {
    background-color: #ffc107;
    border-color: #ffc107;
    color: #000;
}

.btn-warning:hover {
    background-color: #e0a800;
    border-color: #d39e00;
    color: #000;
}

.d-grid.gap-2 {
    gap: 0.5rem !important;
}
</style>
