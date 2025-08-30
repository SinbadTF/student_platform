<script>
    document.addEventListener('DOMContentLoaded', function () {
        const modal = document.getElementById('exchangeDetailsModal');
        if (modal) {
            modal.addEventListener('show.bs.modal', function (event) {
                // Button that triggered the modal
                const button = event.relatedTarget;

                // Extract info from data-bs-* attributes
                const exchangeId = button.getAttribute('data-exchange-id');
                const rewardName = button.getAttribute('data-exchange-name');
                const rewardDescription = button.getAttribute('data-exchange-description');
                const rewardPoints = button.getAttribute('data-exchange-points');
                const exchangeStatus = button.getAttribute('data-exchange-status');
                const exchangeDate = button.getAttribute('data-exchange-date');
                const fulfilledBy = button.getAttribute('data-fulfilled-by');
                const fulfilledDate = button.getAttribute('data-fulfilled-date');
                const deliveryDetails = button.getAttribute('data-delivery-details');

                // Update the modal's content
                modal.querySelector('#modal-reward-name').textContent = rewardName;
                modal.querySelector('#modal-reward-description').textContent = rewardDescription;
                modal.querySelector('#modal-reward-points').textContent = rewardPoints;
                modal.querySelector('#modal-exchange-status').textContent = exchangeStatus;
                modal.querySelector('#modal-exchange-date').textContent = exchangeDate;

                // Handle fulfilled details
                const fulfilledDetailsDiv = modal.querySelector('#modal-fulfilled-details');
                if (exchangeStatus === 'FULFILLED') {
                    fulfilledDetailsDiv.style.display = 'block';
                    modal.querySelector('#modal-fulfilled-by').textContent = fulfilledBy;
                    modal.querySelector('#modal-fulfilled-date').textContent = fulfilledDate;
                } else {
                    fulfilledDetailsDiv.style.display = 'none';
                }

                // Handle delivery details
                const deliveryDetailsContainer = modal.querySelector('#modal-delivery-details-container');
                if (deliveryDetails && deliveryDetails.length > 0) {
                    deliveryDetailsContainer.style.display = 'block';
                    modal.querySelector('#modal-delivery-details').textContent = deliveryDetails;
                } else {
                    deliveryDetailsContainer.style.display = 'none';
                }

                
            });
        }
    });
</script>
<%@ include file="../../layout/student_header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container py-4">
    <div class="row mb-4">
        <div class="col-12">
            <div class="card bg-info text-white shadow-lg rounded-3 border-0">
                <div class="card-body p-4">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h2 class="display-6 fw-bold">Reward Exchange History</h2>
                            <p class="lead mb-0">Track all your reward redemptions</p>
                        </div>
                        <div class="text-center">
                            <div class="bg-white rounded-circle p-3 d-inline-block">
                                <i class="bi bi-clock-history text-info" style="font-size: 3rem;"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

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

    <div class="card border-0 shadow-sm rounded-3">
        <div class="card-body">
            <c:choose>
                <c:when test="${not empty exchanges}">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>Reward</th>
                                    <th>Points Spent</th>
                                    <th>Date</th>
                                    <th>Status</th>
                                    <th>Details</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${exchanges}" var="exchange">
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <i class="bi bi-gift text-primary me-2"></i>
                                                <span>${exchange.reward.name}</span>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="badge bg-primary rounded-pill">
                                                ${exchange.pointsSpent} points
                                            </span>
                                        </td>
                                        <td>
                                            <fmt:parseDate value="${exchange.exchangedAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                                            <fmt:formatDate value="${parsedDate}" pattern="MMM dd, yyyy h:mm a" />
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${exchange.status == 'REDEEMED'}">
                                                    <span class="badge bg-warning text-dark">Processing</span>
                                                </c:when>
                                                <c:when test="${exchange.status == 'FULFILLED'}">
                                                    <span class="badge bg-success">Fulfilled</span>
                                                </c:when>
                                                <c:when test="${exchange.status == 'CANCELLED'}">
                                                    <span class="badge bg-danger">Cancelled</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary">${exchange.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <button type="button" 
                                                    class="btn btn-sm btn-outline-info view-details-btn" 
                                                    data-bs-toggle="modal" 
                                                    data-bs-target="#exchangeDetailsModal"
                                                    data-exchange-id="${exchange.id}"
                                                    data-exchange-name="${exchange.reward.name}"
                                                    data-exchange-description="${exchange.reward.description}"
                                                    data-exchange-points="${exchange.pointsSpent}"
                                                    data-exchange-status="${exchange.status}"
                                                    data-exchange-date="<fmt:formatDate value="${parsedDate}" pattern="MMM dd, yyyy h:mm a" />"
                                                    data-fulfilled-by="${exchange.fulfilledBy.firstName} ${exchange.fulfilledBy.lastName}"
                                                    data-fulfilled-date="<c:if test="${exchange.status == 'FULFILLED'}"><fmt:parseDate value="${exchange.fulfilledAt}" pattern="yyyy-MM-dd'T'HH:mm" var="fulfilledDate" type="both" /><fmt:formatDate value="${fulfilledDate}" pattern="MMM dd, yyyy h:mm a" /></c:if>"
                                                    data-delivery-details="${exchange.deliveryDetails}">
                                                View Details
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-5">
                        <i class="bi bi-inbox text-muted" style="font-size: 3rem;"></i>
                        <h5 class="mt-3">No Exchange History</h5>
                        <p class="text-muted">You haven't exchanged any rewards yet.</p>
                        <a href="/students/rewards/catalog" class="btn btn-primary mt-2">
                            <i class="bi bi-gift"></i> Browse Rewards
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="row mt-4">
        <div class="col-12 text-center">
            <a href="/students/rewards/catalog" class="btn btn-outline-primary">
                <i class="bi bi-gift"></i> Browse Rewards
            </a>
            <a href="/students/dashboard/${student.id}" class="btn btn-outline-secondary ms-2">
                <i class="bi bi-house"></i> Back to Dashboard
            </a>
        </div>
    </div>
</div>

<div class="modal fade" id="exchangeDetailsModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Exchange Details</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <h6>Reward Information</h6>
                    <p><strong>Name:</strong> <span id="modal-reward-name"></span></p>
                    <p><strong>Description:</strong> <span id="modal-reward-description"></span></p>
                    <p><strong>Points:</strong> <span id="modal-reward-points"></span></p>
                </div>
                <div class="mb-3">
                    <h6>Exchange Information</h6>
                    <p><strong>Status:</strong> <span id="modal-exchange-status"></span></p>
                    <p><strong>Exchange Date:</strong> <span id="modal-exchange-date"></span></p>
                    <div id="modal-fulfilled-details" style="display: none;">
                        <p><strong>Fulfilled By:</strong> <span id="modal-fulfilled-by"></span></p>
                        <p><strong>Fulfilled Date:</strong> <span id="modal-fulfilled-date"></span></p>
                    </div>
                </div>
                <div id="modal-delivery-details-container" class="mb-3" style="display: none;">
                    <h6>Delivery Details</h6>
                    <p id="modal-delivery-details"></p>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                
            </div>
        </div>
    </div>
</div>

<%@ include file="../../layout/footer.jsp" %>