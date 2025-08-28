<%@ include file="../layout/student_header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container py-4">
    <!-- Page Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card bg-success text-white shadow-lg rounded-3 border-0">
                <div class="card-body p-4">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h2 class="display-6 fw-bold">Rewards Catalog</h2>
                            <p class="lead mb-0">Your Points: <span class="badge bg-white text-success">${student.points}</span></p>
                        </div>
                        <div class="text-center">
                            <div class="bg-white rounded-circle p-3 d-inline-block">
                                <i class="bi bi-gift text-success" style="font-size: 3rem;"></i>
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
            ${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Rewards Filter -->
    <div class="row mb-4">
        <div class="col-md-6">
            <div class="btn-group" role="group">
                <a href="/students/rewards/catalog" class="btn ${filter == null ? 'btn-primary' : 'btn-outline-primary'}">All Rewards</a>
                <a href="/students/rewards/catalog?filter=available" class="btn ${filter == 'available' ? 'btn-primary' : 'btn-outline-primary'}">Available for Me</a>
            </div>
        </div>
        <div class="col-md-6">
            <form action="/students/rewards/catalog" method="get" class="d-flex">
                <input type="text" name="search" class="form-control me-2" placeholder="Search rewards..." value="${search}">
                <button type="submit" class="btn btn-outline-primary">Search</button>
            </form>
        </div>
    </div>

    <!-- Rewards Grid -->
    <div class="row">
        <c:forEach items="${rewards}" var="reward">
            <div class="col-md-4 mb-4">
                <div class="card h-100 ${student.points >= reward.pointValue ? '' : 'bg-light'}">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <h5 class="card-title">${reward.name}</h5>
                            <span class="badge bg-primary">${reward.pointValue} points</span>
                        </div>
                        <p class="card-text">${reward.description}</p>
                        <c:if test="${not empty reward.issuedBy}">
                            <p class="card-text"><small class="text-muted">Issued by: ${reward.issuedBy.firstName} ${reward.issuedBy.lastName}</small></p>
                        </c:if>
                    </div>
                    <div class="card-footer bg-transparent border-top-0">
                        <div class="d-grid">
                            <c:choose>
                                <c:when test="${student.points >= reward.pointValue}">
                                    <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#redeemModal${reward.id}">
                                        Redeem Reward
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn btn-outline-secondary" disabled>
                                        Need ${reward.pointValue - student.points} more points
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <!-- Redeem Modal -->
                <div class="modal fade" id="redeemModal${reward.id}" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Confirm Reward Redemption</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <p>Are you sure you want to redeem <strong>${reward.name}</strong> for <strong>${reward.pointValue} points</strong>?</p>
                                <p>Your current points: <strong>${student.points}</strong></p>
                                <p>Points after redemption: <strong>${student.points - reward.pointValue}</strong></p>
                                
                                <form action="/students/rewards/exchange/${reward.id}" method="post" id="redeemForm${reward.id}">
                                    <div class="mb-3">
                                        <label for="deliveryDetails" class="form-label">Delivery Details (Optional)</label>
                                        <textarea class="form-control" id="deliveryDetails" name="deliveryDetails" rows="3" 
                                                  placeholder="Enter any delivery or special instructions..."></textarea>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" form="redeemForm${reward.id}" class="btn btn-success">Confirm Redemption</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
        
        <c:if test="${empty rewards}">
            <div class="col-12 text-center py-5">
                <i class="bi bi-search text-muted" style="font-size: 3rem;"></i>
                <h4 class="mt-3">No rewards found</h4>
                <p class="text-muted">Try adjusting your search or filter criteria</p>
                <a href="/students/rewards/catalog" class="btn btn-outline-primary mt-2">View All Rewards</a>
            </div>
        </c:if>
    </div>

    <!-- Exchange History Link -->
    <div class="row mt-4">
        <div class="col-12 text-center">
            <a href="/students/rewards/history" class="btn btn-outline-primary">
                <i class="bi bi-clock-history"></i> View My Reward Exchange History
            </a>
            <a href="/students/dashboard" class="btn btn-outline-secondary ms-2">
                <i class="bi bi-house"></i> Back to Dashboard
            </a>
        </div>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>