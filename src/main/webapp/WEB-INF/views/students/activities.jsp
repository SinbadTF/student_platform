<%@ include file="../layout/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

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
                                                            <div class="d-flex justify-content-between align-items-center">
                                                                <span class="badge bg-success">
                                                                    <i class="bi bi-star-fill me-1"></i>${activity.points} points
                                                                </span>
                                                                <form action="/students/activities/join/${activity.id}" method="post">
                                                                    <button type="submit" class="btn btn-primary btn-sm">
                                                                        <i class="bi bi-plus-circle me-1"></i>Join Activity
                                                                    </button>
                                                                </form>
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
</script>

<%@ include file="../layout/footer.jsp" %>