<%@ include file="../layout/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<style>
    .event-card {
        transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
    }
    
    .event-card:hover {
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

<!-- Student Events View -->
<div class="container py-4">
    <!-- Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h2 class="display-6 fw-bold text-primary">
                        <i class="bi bi-calendar-event me-2"></i>Events
                    </h2>
                    <p class="lead text-muted">Join events to earn points and engage with your community</p>
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
                                       placeholder="Search events by name or description...">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <select class="form-select border-0" id="statusFilter">
                                <option value="all">All Events</option>
                                <option value="upcoming">Upcoming</option>
                                <option value="ongoing">Ongoing</option>
                                <option value="ended">Ended</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Events List -->
    <div class="row">
        <c:choose>
            <c:when test="${empty events}">
                <div class="col-12">
                    <div class="card border-0 shadow-sm rounded-3">
                        <div class="card-body text-center py-5">
                            <i class="bi bi-calendar-x text-warning" style="font-size: 3rem;"></i>
                            <h4 class="mt-3">No events available</h4>
                            <p class="text-muted">Check back later for upcoming events</p>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach items="${events}" var="event">
                    <div class="col-md-6 col-lg-4 mb-4 event-card" data-name="${event.name.toLowerCase()}" data-description="${event.description.toLowerCase()}" data-status="${eventStatus[event.id].status}">
                        <div class="card h-100 border-0 shadow-sm hover-lift">
                            <div class="card-body p-4">
                                <h5 class="card-title mb-2">${event.name}</h5>
                                <p class="card-text text-muted small mb-3">
                                    <c:choose>
                                        <c:when test="${not empty event.description}">
                                            ${event.description}
                                        </c:when>
                                        <c:otherwise>
                                            <em>No description available</em>
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                                
                                <!-- Event Details -->
                                <div class="mb-3">
                                    <div class="row g-2">
                                        <c:if test="${not empty event.startTime}">
                                            <div class="col-6">
                                                <small class="text-muted d-flex align-items-center">
                                                    <i class="bi bi-calendar-event me-1"></i>
                                                    ${event.startTime.toLocalDate()}
                                                </small>
                                            </div>
                                        </c:if>
                                        <c:if test="${not empty event.startTime && not empty event.endTime}">
                                            <div class="col-6">
                                                <small class="text-muted d-flex align-items-center">
                                                    <i class="bi bi-clock me-1"></i>
                                                    ${event.startTime.toLocalTime()} - ${event.endTime.toLocalTime()}
                                                </small>
                                            </div>
                                        </c:if>
                                        <c:if test="${not empty event.location}">
                                            <div class="col-12">
                                                <small class="text-muted d-flex align-items-center">
                                                    <i class="bi bi-geo-alt me-1"></i>
                                                    ${event.location}
                                                </small>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                                
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="badge bg-success">
                                        <i class="bi bi-star-fill me-1"></i>${event.pointValue} points
                                    </span>
                                    <div class="btn-group" role="group">
                                        <button type="button" class="btn btn-outline-info btn-sm" 
                                                data-bs-toggle="modal" data-bs-target="#eventModal${event.id}">
                                            <i class="bi bi-eye me-1"></i>Details
                                        </button>
                                        <c:choose>
                                            <c:when test="${joinedEventMap[event.id]}">
                                                <button type="button" class="btn btn-secondary btn-sm" disabled>
                                                    <i class="bi bi-check2-circle me-1"></i>Already Joined
                                                </button>
                                            </c:when>
                                            <c:when test="${eventJoinStatus[event.id].canJoin}">
                                                <form action="/events/register/${event.id}" method="post" class="d-inline">
                                                    <button type="submit" class="btn btn-primary btn-sm">
                                                        <i class="bi bi-plus-circle me-1"></i>Join
                                                    </button>
                                                </form>
                                            </c:when>
                                            <c:otherwise>
                                                <button type="button" class="btn btn-secondary btn-sm" disabled>
                                                    <i class="bi bi-clock me-1"></i>
                                                    <c:out value="${eventJoinStatus[event.id].primaryLabel}"/>
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="mt-2">
                                    <small class="text-muted">
                                        <c:out value="${eventJoinStatus[event.id].primaryLabel}"/>
                                    </small>
                                    <c:if test="${not empty eventJoinStatus[event.id].secondaryLabel}">
                                        <small class="text-muted ms-2">
                                            <c:out value="${eventJoinStatus[event.id].secondaryLabel}"/>
                                        </small>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Event Detail Modals -->
    <c:forEach items="${events}" var="event">
        <!-- Event Modal ${event.id} -->
        <div class="modal fade" id="eventModal${event.id}" tabindex="-1" aria-labelledby="eventModalLabel${event.id}" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title" id="eventModalLabel${event.id}">
                            <i class="bi bi-calendar-event me-2"></i>${event.name}
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-8">
                                <h6 class="text-primary mb-3">Event Information</h6>
                                
                                <!-- Description -->
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Description:</label>
                                    <p class="text-muted">
                                        <c:choose>
                                            <c:when test="${not empty event.description}">
                                                ${event.description}
                                            </c:when>
                                            <c:otherwise>
                                                <em>No description available</em>
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>

                                <!-- Location -->
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Location:</label>
                                    <p class="text-muted">
                                        <i class="bi bi-geo-alt me-1"></i>
                                        <c:choose>
                                            <c:when test="${not empty event.location}">
                                                ${event.location}
                                            </c:when>
                                            <c:otherwise>
                                                <em>Not specified</em>
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>

                                <!-- Points -->
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Points:</label>
                                    <p class="text-muted">
                                        <span class="badge bg-success fs-6">
                                            <i class="bi bi-star-fill me-1"></i>${event.pointValue} points
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
                                            <c:when test="${not empty event.startTime}">
                                                <i class="bi bi-calendar-event me-1"></i>
                                                ${event.startTime.toLocalDate()}
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
                                            <c:when test="${not empty event.startTime && not empty event.endTime}">
                                                <i class="bi bi-clock me-1"></i>
                                                ${event.startTime.toLocalTime()} - ${event.endTime.toLocalTime()}
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
                                <c:out value="${eventJoinStatus[event.id].primaryLabel}"/>
                            </small>
                            <c:if test="${not empty eventJoinStatus[event.id].secondaryLabel}">
                                <small class="text-muted ms-2">
                                    <c:out value="${eventJoinStatus[event.id].secondaryLabel}"/>
                                </small>
                            </c:if>
                        </div>
                        <div>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                <i class="bi bi-x-circle me-1"></i>Close
                            </button>
                            <c:choose>
                                <c:when test="${eventJoinStatus[event.id].canJoin}">
                                    <form action="/events/register/${event.id}" method="post" class="d-inline">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="bi bi-plus-circle me-1"></i>Join Event
                                        </button>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <button type="button" class="btn btn-outline-secondary" disabled>
                                        <i class="bi bi-clock me-1"></i>
                                        <c:out value="${eventJoinStatus[event.id].primaryLabel}"/>
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>

    <!-- My Event Participations Button -->
    <div class="row mt-4">
        <div class="col-12 text-center">
            <a href="/students/eventparticipation" class="btn btn-outline-primary">
                <i class="bi bi-calendar-check me-2"></i>View My Event Participations
            </a>
        </div>
    </div>
</div>

<script>
    // Search functionality
    document.getElementById('searchInput').addEventListener('keyup', function() {
        const searchValue = this.value.toLowerCase();
        const eventCards = document.querySelectorAll('.event-card');
        
        eventCards.forEach(card => {
            const name = card.getAttribute('data-name');
            const description = card.getAttribute('data-description');
            
            if (name.includes(searchValue) || description.includes(searchValue)) {
                card.style.display = '';
            } else {
                card.style.display = 'none';
            }
        });
    });
    
    // Status filter functionality
    document.getElementById('statusFilter').addEventListener('change', function() {
        const selectedStatus = this.value;
        const eventCards = document.querySelectorAll('.event-card');
        
        eventCards.forEach(card => {
            const status = card.getAttribute('data-status');
            
            if (selectedStatus === 'all' || status === selectedStatus) {
                card.style.display = '';
            } else {
                card.style.display = 'none';
            }
        });
    });
</script>

<%@ include file="../layout/footer.jsp" %>
