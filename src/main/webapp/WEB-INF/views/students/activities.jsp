<%@ include file="../layout/student_header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<style>
    .activity-card {
        transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
    }
    
    .activity-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 25px rgba(0,0,0,0.15) !important;
    }
    
    .hover-lift {
        transition: all 0.3s ease;
    }
    
    .hover-lift:hover {
        transform: translateY(-3px);
        box-shadow: 0 10px 30px rgba(0,0,0,0.1);
    }
    
    .btn-group .btn {
        border-radius: 0.375rem;
    }
    
    .btn-group .btn:first-child {
        border-top-right-radius: 0;
        border-bottom-right-radius: 0;
    }
    
    .btn-group .btn:last-child {
        border-top-left-radius: 0;
        border-bottom-left-radius: 0;
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
                    <a href="${pageContext.request.contextPath}/students/dashboard/${student.id}" class="btn btn-outline-primary">
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
                            <a href="${pageContext.request.contextPath}/students/clubs" class="btn btn-primary mt-2">
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
                                                                    <button type="button" class="btn btn-outline-info btn-sm" 
                                                                            data-bs-toggle="modal" data-bs-target="#activityModal-${activity.id}">
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
                                                                            <form action="${pageContext.request.contextPath}/students/activities/join/${activity.id}" method="post" class="d-inline">
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

    <!-- Activity Detail Modals -->
    <c:forEach items="${memberships}" var="membership">
        <c:if test="${not empty clubActivities[membership.club]}">
            <c:forEach items="${clubActivities[membership.club]}" var="activity">
                <!-- Activity Modal ${activity.id} -->
                <div class="modal fade" id="activityModal-${activity.id}" tabindex="-1" aria-labelledby="activityModalLabel-${activity.id}" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header bg-primary text-white">
                                <h5 class="modal-title" id="activityModalLabel-${activity.id}">
                                    <i class="bi bi-calendar-event me-2"></i>${activity.title}
                                </h5>
                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
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
                            <div class="modal-footer d-flex justify-content-between align-items-center">
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
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
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

    // Ensure modals are appended to body to avoid parent stacking/overflow issues
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.modal').forEach(function(modal) {
            if (modal.parentElement !== document.body) {
                document.body.appendChild(modal);
            }
        });
    });
</script>

<%@ include file="../layout/footer.jsp" %>