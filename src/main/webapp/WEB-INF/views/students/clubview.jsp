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
                            <button class="btn btn-outline-primary btn-sm" 
                                    onclick="showClubDetails('${club.id}', '${club.name}', '${club.description}', '${club.meetingScheduleTitle}')">
                                <i class="bi bi-eye me-1"></i>View Details
                            </button>
                            <c:choose>
                                <c:when test="${membershipStatus[club.id] == true}">
                                    <button class="btn btn-secondary btn-sm" disabled>
                                        <i class="bi bi-check-circle me-1"></i>Already Joined
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <form action="/students/clubs/join/${club.id}" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to join ${club.name}?')">
                                        <button type="submit" class="btn btn-success btn-sm">
                                            <i class="bi bi-plus-circle me-1"></i>Join Club
                                        </button>
                                    </form>
                                </c:otherwise>
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

<!-- Club Details Modal -->
<div class="modal fade" id="clubDetailsModal" tabindex="-1" aria-labelledby="clubDetailsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content border-0 shadow">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="clubDetailsModalLabel">
                    <i class="bi bi-people-fill me-2"></i>Club Details
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4">
                <div class="row">
                    <div class="col-md-8">
                        <h4 id="modalClubName" class="fw-bold mb-3"></h4>
                        <p id="modalClubDescription" class="text-muted mb-3"></p>
                        <div id="modalClubSchedule" class="mb-3"></div>
                    </div>
                    <div class="col-md-4 text-center">
                        <div class="bg-primary bg-opacity-10 rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 100px; height: 100px;">
                            <i class="bi bi-people-fill text-primary" style="font-size: 3rem;"></i>
                        </div>
                        <div id="modalJoinSection">
                            <form action="/students/clubs/join/" method="post" id="modalJoinForm" onsubmit="return confirm('Are you sure you want to join this club?')">
                                <button type="submit" class="btn btn-success w-100" id="modalJoinButton">
                                    <i class="bi bi-plus-circle me-2"></i>Join This Club
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
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

// Show club details in modal
function showClubDetails(clubId, name, description, schedule) {
    document.getElementById('modalClubName').textContent = name;
    document.getElementById('modalClubDescription').textContent = description || 'No description available';
    
    const scheduleElement = document.getElementById('modalClubSchedule');
    if (schedule && schedule.trim() !== '') {
        scheduleElement.innerHTML = `
            <div class="alert alert-info">
                <i class="bi bi-calendar-event me-2"></i>
                <strong>Meeting Schedule:</strong> ${schedule}
            </div>
        `;
    } else {
        scheduleElement.innerHTML = '';
    }
    
    // Check if student is already a member of this club
    const isAlreadyMember = checkIfAlreadyMember(clubId);
    
    // Update the modal join section based on membership status
    const modalJoinSection = document.getElementById('modalJoinSection');
    if (isAlreadyMember) {
        modalJoinSection.innerHTML = `
            <button class="btn btn-secondary w-100" disabled>
                <i class="bi bi-check-circle me-2"></i>Already Joined
            </button>
        `;
    } else {
        modalJoinSection.innerHTML = `
            <form action="/students/clubs/join/${clubId}" method="post" onsubmit="return confirm('Are you sure you want to join this club?')">
                <button type="submit" class="btn btn-success w-100">
                    <i class="bi bi-plus-circle me-2"></i>Join This Club
                </button>
            </form>
        `;
    }
    
    new bootstrap.Modal(document.getElementById('clubDetailsModal')).show();
}

// Function to check if student is already a member (this will be populated by server-side data)
function checkIfAlreadyMember(clubId) {
    // This will be populated with server-side data
    const membershipStatus = window.clubMemberships || {};
    return membershipStatus[clubId] || false;
}

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
