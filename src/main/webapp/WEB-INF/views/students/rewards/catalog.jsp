<%@ include file="../../layout/student_header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- Add custom CSS for consistent point badge styling -->
<style>
    .points-badge {
        min-width: 120px;
        display: inline-flex;
        justify-content: center;
        align-items: center;
        height: 38px; /* Fixed height for all badges */
    }
</style>

<div class="container py-4">
    <!-- Page Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card bg-primary text-white shadow-lg rounded-3 border-0">
                <div class="card-body p-4">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h2 class="display-6 fw-bold">Rewards Catalog</h2>
                            <p class="lead mb-0">Exchange your points for exciting rewards!</p>
                        </div>
                        <div class="text-center">
                            <div class="bg-white rounded-circle p-3 d-inline-block">
                                <i class="bi bi-gift text-primary" style="font-size: 3rem;"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Points Status -->
    <div class="row mb-4">
        <div class="col-md-6 offset-md-3">
            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-body text-center">
                    <h5 class="card-title">Your Current Points</h5>
                    <h2 class="display-4 fw-bold text-primary">${student.points}</h2>
                    <p class="text-muted">Use your points to redeem rewards below</p>
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

    <!-- Rewards Grid -->
    <div class="row">
        <c:forEach items="${rewards}" var="reward">
            <div class="col-md-4 mb-4">
                <div class="card h-100 border-0 shadow-sm hover-shadow">
                    <div class="card-body">
                        <h5 class="card-title">${reward.name}</h5>
                        <p class="card-text">${reward.description}</p>
                        <div class="d-flex justify-content-between align-items-center mt-3">
                            <span class="badge bg-primary rounded-pill fs-6 points-badge">
                                <i class="bi bi-star-fill me-1"></i> ${reward.pointValue} points
                            </span>
                            <c:choose>
                                <c:when test="${student.points >= reward.pointValue}">
                                    <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#confirmRedeemModal${reward.id}">
                                        <i class="bi bi-cart-plus"></i> Redeem
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn btn-secondary" disabled>
                                        <i class="bi bi-lock"></i> Not Enough Points
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
        
        <c:if test="${empty rewards}">
            <div class="col-12 text-center py-5">
                <div class="alert alert-info">
                    <i class="bi bi-info-circle me-2"></i> No rewards available at the moment.
                </div>
            </div>
        </c:if>
    </div>

    <!-- Navigation -->
    <div class="row mt-4">
        <div class="col-12 text-center">
            <a href="/students/rewards/history" class="btn btn-outline-primary">
                <i class="bi bi-clock-history"></i> View Exchange History
            </a>
            <a href="/students/dashboard/${student.id}" class="btn btn-outline-secondary ms-2">
                <i class="bi bi-house"></i> Back to Dashboard
            </a>
        </div>
    </div>
</div>

<!-- Modal Dialogs for Reward Redemption -->
<c:forEach items="${rewards}" var="reward">
    <div class="modal fade" id="confirmRedeemModal${reward.id}" tabindex="-1" aria-labelledby="confirmRedeemModalLabel${reward.id}" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirmRedeemModalLabel${reward.id}">Confirm Redemption</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to redeem <strong>${reward.name}</strong>?</p>
                    <p>This will cost <strong>${reward.pointValue} points</strong>.</p>
                    <p>Your current points: <strong>${student.points}</strong></p>
                    <p>Points after redemption: <strong>${student.points - reward.pointValue}</strong></p>
                    
                    
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <form action="/students/rewards/exchange/${reward.id}" method="post" style="display:inline;">
                        <input type="hidden" name="deliveryDetails" id="hiddenDeliveryDetails${reward.id}">
                        <button type="submit" class="btn btn-success" onclick="copyDeliveryDetails(${reward.id})">Confirm Redemption</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</c:forEach>

<script>
    function copyDeliveryDetails(rewardId) {
        const textareaValue = document.getElementById('deliveryDetails' + rewardId).value;
        document.getElementById('hiddenDeliveryDetails' + rewardId).value = textareaValue;
    }
</script>

<%@ include file="../../layout/footer.jsp" %>