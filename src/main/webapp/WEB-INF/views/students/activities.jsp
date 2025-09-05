<%@ include file="../layout/student_header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<!-- Custom Dialog Styles -->
<style>
    /* Custom Dialog Styles */
    .custom-dialog-overlay {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        z-index: 9999;
        overflow-y: auto;
    }
    
    .custom-dialog {
        position: relative;
        width: 80%;
        max-width: 800px;
        margin: 50px auto;
        background-color: white;
        border-radius: 8px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
        z-index: 10000;
    }
    
    .custom-dialog-header {
        padding: 15px 20px;
        background-color: var(--primary);
        color: white;
        border-top-left-radius: 8px;
        border-top-right-radius: 8px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .custom-dialog-title {
        margin: 0;
        font-size: 1.25rem;
    }
    
    .custom-dialog-close {
        background: none;
        border: none;
        color: white;
        font-size: 1.5rem;
        cursor: pointer;
    }
    
    .custom-dialog-body {
        padding: 20px;
    }
    
    .custom-dialog-footer {
        padding: 15px 20px;
        border-top: 1px solid #e9ecef;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    body.dialog-open {
        overflow: hidden;
    }
</style>

<!-- Student Activities View -->
<div class="container py-4">
    <!-- Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h2 class="display-6 fw-bold text-primary">
                        <i class="bi bi-calendar-event me-2"></i>Club Activities
                    </h2>
                    <p class="lead text-muted">Join activities from your clubs to earn points and engage with your community</p>
                </div>
                <div>
                    <a href="/students/dashboard/${student.id}" class="btn btn-outline-primary">
                        <i class="bi bi-arrow-left me-2"></i>Back to Dashboard
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Search and Filter -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-md-8">
                            <div class="input-group">
                                <span class="input-group-text bg-light border-0">
                                    <i class="bi bi-search text-muted"></i>
                                </span>
                                <input type="text" class="form-control border-0" id="searchInput" 
                                       placeholder="Search activities by title or description...">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <select class="form-select border-0" id="clubFilter">
                                <option value="all">All Clubs</option>
                                <c:forEach items="${memberships}" var="membership">
                                    <option value="${membership.club.id}">${membership.club.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Activities by Club -->
    <c:choose>
        <c:when test="${empty memberships}">
            <div class="row">
                <div class="col-12">
                    <div class="card border-0 shadow-sm rounded-3">
                        <div class="card-body text-center py-5">
                            <i class="bi bi-exclamation-circle text-warning" style="font-size: 3rem;"></i>
                            <h4 class="mt-3">You haven't joined any clubs yet</h4>
                            <p class="text-muted">Join a club to participate in their activities</p>
                            <a href="/students/clubs" class="btn btn-primary mt-2">
                                <i class="bi bi-people me-2"></i>Browse Clubs
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach items="${memberships}" var="membership">
                <div class="row mb-4 club-section" data-club-id="${membership.club.id}">
                    <div class="col-12">
                        <div class="card border-0 shadow-sm rounded-3">
                            <div class="card-header bg-white border-0 py-3">
                                <h5 class="mb-0">
                                    <i class="bi bi-people text-primary me-2"></i>${membership.club.name} Activities
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <c:choose>
                                        <c:when test="${empty clubActivities[membership.club]}">
                                            <div class="col-12 text-center py-4">
                                                <p>No activities available for this club</p>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach items="${clubActivities[membership.club]}" var="activity">
                                                <div class="col-md-4 mb-3 activity-card" data-title="${activity.title.toLowerCase()}" data-description="${activity.description.toLowerCase()}">
                                                    <div class="card h-100 border-0 shadow-sm hover-lift">
                                                        <div class="card-body p-4">
                                                            <h5 class="card-title mb-2">${activity.title}</h5>
                                                            <p class="card-text text-muted small mb-3">
                                                                <c:choose>
                                                                    <c:when test="${not empty activity.description}">
                                                                        ${activity.description}
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <em>No description available</em>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </p>
                                                            
                                                            <!-- Activity Details -->
                                                            <div class="mb-3">
                                                                <div class="row g-2">
                                                                    <c:if test="${not empty activity.clubDate}">
                                                                        <div class="col-6">
                                                                            <small class="text-muted d-flex align-items-center">
                                                                                <i class="bi bi-calendar-event me-1"></i>
                                                                                ${activity.clubDate}
                                                                            </small>
                                                                        </div>
                                                                    </c:if>
                                                                    <c:if test="${not empty activity.startTime && not empty activity.endTime}">
                                                                        <div class="col-6">
                                                                            <small class="text-muted d-flex align-items-center">
                                                                                <i class="bi bi-clock me-1"></i>
                                                                                ${activity.startTime} - ${activity.endTime}
                                                                            </small>
                                                                        </div>
                                                                    </c:if>
                                                                    <c:if test="${not empty activity.activityPlace}">
                                                                        <div class="col-12">
                                                                            <small class="text-muted d-flex align-items-center">
                                                                                <i class="bi bi-geo-alt me-1"></i>
                                                                                ${activity.activityPlace}
                                                                            </small>
                                                                        </div>
                                                                    </c:if>
                                                                </div>
                                                            </div>
                                                            
                                                            <div class="d-flex justify-content-between align-items-center">
                                                                <span class="badge bg-success">
                                                                    <i class="bi bi-star-fill me-1"></i>${activity.points} points
                                                                </span>
                                                                <div class="btn-group" role="group">
                                                                    <button type="button" class="btn btn-outline-info btn-sm show-details-btn" 
                                                                            data-activity-id="${activity.id}">
                                                                        <i class="bi bi-eye me-1"></i>Details
                                                                    </button>
                                                                    <c:choose>
                                                                        <c:when test="${joinedActivityMap[activity.id]}">
                                                                            <c:set var="plCardJoined" value="${activityJoinStatus[activity.id].primaryLabel}"/>
                                                                            <button type="button" class="btn btn-secondary btn-sm" disabled>
                                                                                <i class="bi bi-check2-circle me-1"></i>
                                                                                <c:choose>
                                                                                    <c:when test="${fn:startsWith(plCardJoined, 'Join available in') && (fn:endsWith(plCardJoined, '0s') || fn:endsWith(plCardJoined, '0m'))}">Join now</c:when>
                                                                                    <c:when test="${fn:startsWith(plCardJoined, 'Join available in')}"><c:out value="${plCardJoined}"/></c:when>
                                                                                    <c:otherwise>Already Joined</c:otherwise>
                                                                                </c:choose>
                                                                            </button>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <form action="/students/activities/join/${activity.id}" method="post" class="d-inline">
                                                                                <c:set var="plCard" value="${activityJoinStatus[activity.id].primaryLabel}"/>
                                                                                <button type="submit" class="btn btn-primary btn-sm" 
                                                                                        <c:if test="${!activityJoinStatus[activity.id].canJoin}">disabled</c:if>>
                                                                                    <i class="bi bi-plus-circle me-1"></i>
                                                                                    <c:choose>
                                                                                        <c:when test="${activityJoinStatus[activity.id].canJoin}">Join now</c:when>
                                                                                        <c:when test="${fn:startsWith(plCard, 'Join available in') && (fn:endsWith(plCard, '0s') || fn:endsWith(plCard, '0m'))}">Join now</c:when>
                                                                                        <c:when test="${fn:startsWith(plCard, 'Join available in')}"><c:out value="${plCard}"/></c:when>
                                                                                        <c:otherwise>Joined Disabled</c:otherwise>
                                                                                    </c:choose>
                                                                                </button>
                                                                            </form>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                            </div>
                                                            <div class="mt-2">
                                                                <c:choose>
                                                                    <c:when test="${joinedActivityMap[activity.id]}">
                                                                        <small class="text-muted">Already Joined</small>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <c:set var="plSmall" value="${activityJoinStatus[activity.id].primaryLabel}"/>
                                                                        <small class="text-muted">
                                                                            <c:choose>
                                                                                <c:when test="${fn:startsWith(plSmall, 'Join available in') && (fn:endsWith(plSmall, '0s') || fn:endsWith(plSmall, '0m'))}">Join now</c:when>
                                                                                <c:otherwise><c:out value="${plSmall}"/></c:otherwise>
                                                                            </c:choose>
                                                                        </small>
                                                                        <c:if test="${not empty activityJoinStatus[activity.id].secondaryLabel}">
                                                                            <small class="text-muted ms-2">
                                                                                <c:out value="${activityJoinStatus[activity.id].secondaryLabel}"/>
                                                                            </small>
                                                                        </c:if>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>

    <!-- Custom Activity Detail Dialogs -->
    <c:forEach items="${memberships}" var="membership">
        <c:if test="${not empty clubActivities[membership.club]}">
            <c:forEach items="${clubActivities[membership.club]}" var="activity">
                <!-- Custom Activity Dialog ${activity.id} -->
                <div class="custom-dialog-overlay" id="customDialog${activity.id}">
                    <div class="custom-dialog">
                        <div class="custom-dialog-header">
                            <h5 class="custom-dialog-title">
                                <i class="bi bi-calendar-event me-2"></i>${activity.title}
                            </h5>
                            <button type="button" class="custom-dialog-close" data-dialog-close="customDialog${activity.id}">&times;</button>
                        </div>
                        <div class="custom-dialog-body">
                            <div class="row">
                                <div class="col-md-8">
                                    <h6 class="text-primary mb-3">Activity Information</h6>
                                    
                                    <!-- Description -->
                                    <div class="mb-3">
                                        <label class="form-label fw-bold">Description:</label>
                                        <p class="text-muted">
                                            <c:choose>
                                                <c:when test="${not empty activity.description}">
                                                    ${activity.description}
                                                </c:when>
                                                <c:otherwise>
                                                    <em>No description available</em>
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                    </div>

                                    <!-- Club Information -->
                                    <div class="mb-3">
                                        <label class="form-label fw-bold">Club:</label>
                                        <p class="text-muted">
                                            <i class="bi bi-people me-1"></i>${activity.club != null ? activity.club.name : 'No club assigned'}
                                        </p>
                                    </div>

                                    <!-- Points -->
                                    <div class="mb-3">
                                        <label class="form-label fw-bold">Points:</label>
                                        <p class="text-muted">
                                            <span class="badge bg-success fs-6">
                                                <i class="bi bi-star-fill me-1"></i>${activity.points} points
                                            </span>
                                        </p>
                                    </div>
                                </div>
                                
                                <div class="col-md-4">
                                    <h6 class="text-primary mb-3">Event Details</h6>
                                    
                                    <!-- Date -->
                                    <div class="mb-3">
                                        <label class="form-label fw-bold">Date:</label>
                                        <p class="text-muted">
                                            <c:choose>
                                                <c:when test="${not empty activity.clubDate}">
                                                    <i class="bi bi-calendar-event me-1"></i>
                                                    ${activity.clubDate}
                                                </c:when>
                                                <c:otherwise>
                                                    <em>Not specified</em>
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                    </div>

                                    <!-- Time -->
                                    <div class="mb-3">
                                        <label class="form-label fw-bold">Time:</label>
                                        <p class="text-muted">
                                            <c:choose>
                                                <c:when test="${not empty activity.startTime && not empty activity.endTime}">
                                                    <i class="bi bi-clock me-1"></i>
                                                    ${activity.startTime} - ${activity.endTime}
                                                </c:when>
                                                <c:otherwise>
                                                    <em>Not specified</em>
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                    </div>

                                    <!-- Location -->
                                    <div class="mb-3">
                                        <label class="form-label fw-bold">Location:</label>
                                        <p class="text-muted">
                                            <c:choose>
                                                <c:when test="${not empty activity.activityPlace}">
                                                    <i class="bi bi-geo-alt me-1"></i>
                                                    ${activity.activityPlace}
                                                </c:when>
                                                <c:otherwise>
                                                    <em>Not specified</em>
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="custom-dialog-footer">
                            <div>
                                <small class="text-muted">
                                    <c:out value="${activityJoinStatus[activity.id].primaryLabel}"/>
                                </small>
                                <c:if test="${not empty activityJoinStatus[activity.id].secondaryLabel}">
                                    <small class="text-muted ms-2">
                                        <c:out value="${activityJoinStatus[activity.id].secondaryLabel}"/>
                                    </small>
                                </c:if>
                            </div>
                            <div>
                                <button type="button" class="btn btn-secondary" data-dialog-close="customDialog${activity.id}">
                                    <i class="bi bi-x-circle me-1"></i>Close
                                </button>
                                <c:choose>
                                    <c:when test="${joinedActivityMap[activity.id]}">
                                        <c:set var="plModalJoined" value="${activityJoinStatus[activity.id].primaryLabel}"/>
                                        <button type="button" class="btn btn-outline-secondary" disabled>
                                            <i class="bi bi-check2-circle me-1"></i>
                                            <c:choose>
                                                <c:when test="${fn:startsWith(plModalJoined, 'Join available in')}"><c:out value="${plModalJoined}"/></c:when>
                                                <c:otherwise>Already Joined</c:otherwise>
                                            </c:choose>
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <form action="/students/activities/join/${activity.id}" method="post" class="d-inline">
                                            <c:set var="plModal" value="${activityJoinStatus[activity.id].primaryLabel}"/>
                                            <button type="submit" class="btn btn-primary"
                                                    <c:if test="${!activityJoinStatus[activity.id].canJoin}">disabled</c:if>>
                                                <i class="bi bi-plus-circle me-1"></i>
                                                <c:choose>
                                                    <c:when test="${activityJoinStatus[activity.id].canJoin}">Join now</c:when>
                                                    <c:when test="${fn:startsWith(plModal, 'Join available in')}"><c:out value="${plModal}"/></c:when>
                                                    <c:otherwise>Joined Disabled</c:otherwise>
                                                </c:choose>
                                            </button>
                                        </form>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:if>
    </c:forEach>

    <!-- My Participations Button -->
    <div class="row mt-4">
        <div class="col-12 text-center">
            <a href="/students/activities/participations" class="btn btn-outline-primary">
                <i class="bi bi-list-check me-2"></i>View My Activity Participations
            </a>
        </div>
    </div>
</div>

<script>
    // Search functionality
    document.getElementById('searchInput').addEventListener('keyup', function() {
        const searchValue = this.value.toLowerCase();
        const activityCards = document.querySelectorAll('.activity-card');
        
        activityCards.forEach(card => {
            const title = card.getAttribute('data-title');
            const description = card.getAttribute('data-description');
            
            if (title.includes(searchValue) || description.includes(searchValue)) {
                card.style.display = '';
            } else {
                card.style.display = 'none';
            }
        });
    });
    
    // Club filter functionality
    document.getElementById('clubFilter').addEventListener('change', function() {
        const selectedClubId = this.value;
        const clubSections = document.querySelectorAll('.club-section');
        
        clubSections.forEach(section => {
            if (selectedClubId === 'all' || section.getAttribute('data-club-id') === selectedClubId) {
                section.style.display = '';
            } else {
                section.style.display = 'none';
            }
        });
    });
    
    // Custom Dialog Functionality
    document.addEventListener('DOMContentLoaded', function() {
        // Show dialog buttons
        const showButtons = document.querySelectorAll('.show-details-btn');
        showButtons.forEach(button => {
            button.addEventListener('click', function() {
                const activityId = this.getAttribute('data-activity-id');
                const dialog = document.getElementById('customDialog' + activityId);
                if (dialog) {
                    dialog.style.display = 'block';
                    document.body.classList.add('dialog-open');
                }
            });
        });
        
        // Close dialog buttons
        const closeButtons = document.querySelectorAll('[data-dialog-close]');
        closeButtons.forEach(button => {
            button.addEventListener('click', function() {
                const dialogId = this.getAttribute('data-dialog-close');
                const dialog = document.getElementById(dialogId);
                if (dialog) {
                    dialog.style.display = 'none';
                    document.body.classList.remove('dialog-open');
                }
            });
        });
        
        // Close dialog when clicking outside
        const dialogs = document.querySelectorAll('.custom-dialog-overlay');
        dialogs.forEach(dialog => {
            dialog.addEventListener('click', function(event) {
                if (event.target === this) {
                    this.style.display = 'none';
                    document.body.classList.remove('dialog-open');
                }
            });
        });
        
        // Close dialog with Escape key
        document.addEventListener('keydown', function(event) {
            if (event.key === 'Escape') {
                const openDialog = document.querySelector('.custom-dialog-overlay[style="display: block;"]');
                if (openDialog) {
                    openDialog.style.display = 'none';
                    document.body.classList.remove('dialog-open');
                }
            }
        });
    });
</script>

<%@ include file="../layout/footer.jsp" %>