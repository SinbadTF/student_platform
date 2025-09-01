<%@ include file="../layout/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">


<!-- Student Clubs View -->
<div class="container py-4">
    <!-- Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h2 class="display-6 fw-bold text-primary">
                        <i class="bi bi-people-fill me-2"></i>Available Clubs
                    </h2>
                    <p class="lead text-muted">Discover amazing communities and join clubs that match your interest</p>
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
                                       placeholder="Search clubs by name or description...">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <select class="form-select border-0" id="sortSelect">
                                <option value="name">Sort by Name</option>
                                <option value="description">Sort by Description</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Clubs Grid -->
    <div class="row" id="clubsContainer">
        <c:forEach items="${clubs}" var="club">
            <div class="col-lg-4 col-md-6 mb-4 club-card" data-name="${club.name.toLowerCase()}" data-description="${club.description.toLowerCase()}">
                <div class="card h-100 border-0 shadow-sm rounded-3 hover-lift">
                    <div class="card-body p-4">
                        <div class="d-flex align-items-center mb-3">
                            <div class="bg-primary bg-opacity-10 rounded-circle p-3 me-3">
                                <i class="fa-solid fa-dumbbell text-primary" style="font-size: 1.5rem;"></i>
                            </div>
                            <div>
                                <h5 class="card-title mb-1 fw-bold">${club.name}</h5>
                               
                            </div>
                        </div>
                        
                        <p class="card-text text-muted mb-3">
                            <c:choose>
                                <c:when test="${not empty club.description}">
                                    ${club.description}
                                </c:when>
                                <c:otherwise>
                                    <em>No description available</em>
                                </c:otherwise>
                            </c:choose>
                        </p>
                        
                        <c:if test="${not empty club.meetingScheduleTitle}">
                            <div class="mb-3">
                                <span class="badge bg-info bg-opacity-10 text-info">
                                    <i class="bi bi-calendar-event me-1"></i>
                                    ${club.meetingScheduleTitle}
                                </span>
                            </div>
                        </c:if>
                        
                        <div class="d-flex justify-content-between align-items-center">
                            <a href="/students/clubs/detail/${club.id}" class="btn btn-outline-primary btn-sm">
                                <i class="bi bi-eye me-1"></i>View Details
                            </a>
                            <c:choose>
                                <c:when test="${membershipStatus[club.id] == true}">
                                    <button class="btn btn-secondary btn-sm" disabled>
                                        <i class="bi bi-check-circle me-1"></i>Already Joined
                                    </button>
                                </c:when>
                           
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
        
        <c:if test="${empty clubs}">
            <div class="col-12">
                <div class="card border-0 shadow-sm rounded-3">
                    <div class="card-body text-center py-5">
                        <div class="bg-light rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
                            <i class="bi bi-people text-muted" style="font-size: 2rem;"></i>
                        </div>
                        <h5 class="text-muted">No Clubs Available</h5>
                        <p class="text-muted">There are currently no clubs available. Check back later!</p>
                        <a href="/students/dashboard" class="btn btn-primary">
                            <i class="bi bi-arrow-left me-2"></i>Back to Dashboard
                        </a>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
</div>



<script>
// Club membership status data (populated from server)
window.clubMemberships = {};
<c:forEach items="${clubs}" var="club">
    window.clubMemberships['${club.id}'] = ${membershipStatus[club.id]};
</c:forEach>

// Search functionality
document.getElementById('searchInput').addEventListener('input', function() {
    const searchTerm = this.value.toLowerCase();
    const clubCards = document.querySelectorAll('.club-card');
    
    clubCards.forEach(card => {
        const name = card.dataset.name;
        const description = card.dataset.description;
        
        if (name.includes(searchTerm) || description.includes(searchTerm)) {
            card.style.display = 'block';
        } else {
            card.style.display = 'none';
        }
    });
});

// Sort functionality
document.getElementById('sortSelect').addEventListener('change', function() {
    const sortBy = this.value;
    const container = document.getElementById('clubsContainer');
    const cards = Array.from(container.querySelectorAll('.club-card'));
    
    cards.sort((a, b) => {
        const aValue = a.dataset[sortBy];
        const bValue = b.dataset[sortBy];
        return aValue.localeCompare(bValue);
    });
    
    cards.forEach(card => container.appendChild(card));
});



// Add hover effect to cards
document.addEventListener('DOMContentLoaded', function() {
    const cards = document.querySelectorAll('.club-card .card');
    cards.forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-5px)';
            this.style.transition = 'transform 0.3s ease';
        });
        
        card.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0)';
        });
    });
});
</script>

<style>
.hover-lift:hover {
    transform: translateY(-5px);
    transition: transform 0.3s ease;
}

.card {
    transition: all 0.3s ease;
}

.input-group-text {
    background-color: #f8f9fa !important;
}

.form-control:focus, .form-select:focus {
    box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.25);
    border-color: #86b7fe;
}
</style>
