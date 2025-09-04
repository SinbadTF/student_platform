<%@ include file="../layout/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!-- Action Buttons -->
    <div class="row">
        <div class="col-12 text-center">
            <div class="d-flex justify-content-left gap-3 flex-wrap">
              
                <a href="/students/clubs" class="btn btn-outline-primary">
                    <i class="bi bi-people me-2"></i>Back to Club
                </a>
              
            </div>
        </div>
    </div>
</div>
<!-- Welcome Member Page -->
<div class="container py-4">
    <!-- Success Banner -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card bg-success text-white shadow-lg rounded-3 border-0">
                <div class="card-body p-4 text-center">
                    <div class="mb-3">
                        <i class="bi bi-check-circle-fill" style="font-size: 4rem;"></i>
                    </div>
                    <h2 class="display-6 fw-bold">Welcome to ${club.name}!</h2>
                    <p class="lead mb-0">You have earned 100 points for joining the club</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Club Information -->
    <div class="row mb-4">
        <div class="col-md-8">
            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-header bg-white border-0 py-3">
                    <h5 class="mb-0"><i class="bi bi-info-circle text-primary me-2"></i>Club Information</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <h6 class="fw-bold text-primary">Club Name</h6>
                            <p class="mb-3">${club.name}</p>
                            
                            <h6 class="fw-bold text-primary">Description</h6>
                            <p class="mb-3">
                                <c:choose>
                                    <c:when test="${not empty club.description}">
                                        ${club.description}
                                    </c:when>
                                    <c:otherwise>
                                        <em>No description available</em>
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                        <div class="col-md-6">
                            <h6 class="fw-bold text-primary">Meeting Schedule</h6>
                            <p class="mb-3">
                                <c:choose>
                                    <c:when test="${not empty club.meetingScheduleTitle}">
                                        <i class="bi bi-calendar-event me-2"></i>${club.meetingScheduleTitle}
                                    </c:when>
                                    <c:otherwise>
                                        <em>Schedule to be announced</em>
                                    </c:otherwise>
                                </c:choose>
                            </p>
                            
                            <h6 class="fw-bold text-primary">Joined Date</h6>
                            <p class="mb-3">
                                <i class="bi bi-calendar-check me-2"></i>
                                ${formattedJoinedDate}
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-header bg-white border-0 py-3">
                    <h5 class="mb-0"><i class="bi bi-person-check text-success me-2"></i>Membership Status</h5>
                </div>
                <div class="card-body text-center">
                    <div class="bg-success bg-opacity-10 rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
                        <i class="bi bi-person-check-fill text-success" style="font-size: 2rem;"></i>
                    </div>
                    <h5 class="text-success fw-bold">Active Member</h5>
                    <p class="text-muted small">You are now an active member of this club</p>
                    
                    <div class="mt-3">
                        <span class="badge bg-success">${membership.status}</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Next Steps -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-header bg-white border-0 py-3">
                    <h5 class="mb-0"><i class="bi bi-lightbulb text-warning me-2"></i>What's Next?</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="text-center mb-3">
                                <div class="bg-primary bg-opacity-10 rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                                    <i class="bi bi-calendar-event text-primary" style="font-size: 1.5rem;"></i>
                                </div>
                                <h6 class="fw-bold">Attend Meetings</h6>
                                <p class="text-muted small">Join the club meetings and activities to stay engaged</p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="text-center mb-3">
                                <div class="bg-info bg-opacity-10 rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                                    <i class="bi bi-people text-info" style="font-size: 1.5rem;"></i>
                                </div>
                                <h6 class="fw-bold">Connect with Members</h6>
                                <p class="text-muted small">Meet other club members and build connections</p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="text-center mb-3">
                                <div class="bg-warning bg-opacity-10 rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                                    <i class="bi bi-star text-warning" style="font-size: 1.5rem;"></i>
                                </div>
                                <h6 class="fw-bold">Earn Points</h6>
                                <p class="text-muted small">Participate in activities to earn points and rewards</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Action Buttons -->
    <div class="row">
        <div class="col-12 text-center">
            <div class="d-flex justify-content-center gap-3 flex-wrap">
                <a href="/students/dashboard/${student.id}" class="btn btn-primary">
                    <i class="bi bi-house me-2"></i>Go to Dashboard
                </a>
                <a href="/students/clubs" class="btn btn-outline-primary">
                    <i class="bi bi-people me-2"></i>Back to Club
                </a>
              
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

.bg-opacity-10 {
    background-color: rgba(var(--bs-primary-rgb), 0.1) !important;
}

.text-primary {
    color: var(--bs-primary) !important;
}
</style>
