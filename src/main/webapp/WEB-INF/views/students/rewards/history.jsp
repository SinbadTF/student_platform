<%@ include file="../../layout/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container py-4">
    <!-- Page Header -->
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

    <!-- Exchange History Table -->
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
                                            <button type="button" class="btn btn-sm btn-outline-info" 
                                                    data-bs-toggle="modal" 
                                                    data-bs-target="#exchangeModal${exchange.id}">
                                                View Details
                                            </button>
                                            
                                            <!-- Exchange Details Modal -->
                                            <div class="modal fade" id="exchangeModal${exchange.id}" tabindex="-1" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">Exchange Details</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="mb-3">
                                                                <h6>Reward Information</h6>
                                                                <p><strong>Name:</strong> ${exchange.reward.name}</p>
                                                                <p><strong>Description:</strong> ${exchange.reward.description}</p>
                                                                <p><strong>Points:</strong> ${exchange.pointsSpent}</p>
                                                            </div>
                                                            <div class="mb-3">
                                                                <h6>Exchange Information</h6>
                                                                <p><strong>Status:</strong> ${exchange.status}</p>
                                                                <p><strong>Exchange Date:</strong> 
                                                                    <fmt:formatDate value="${parsedDate}" pattern="MMM dd, yyyy h:mm a" />
                                                                </p>
                                                                <c:if test="${exchange.status == 'FULFILLED'}">
                                                                    <p><strong>Fulfilled By:</strong> 
                                                                        ${exchange.fulfilledBy.firstName} ${exchange.fulfilledBy.lastName}
                                                                    </p>
                                                                    <p><strong>Fulfilled Date:</strong>
                                                                        <fmt:parseDate value="${exchange.fulfilledAt}" pattern="yyyy-MM-dd'T'HH:mm" var="fulfilledDate" type="both" />
                                                                        <fmt:formatDate value="${fulfilledDate}" pattern="MMM dd, yyyy h:mm a" />
                                                                    </p>
                                                                </c:if>
                                                            </div>
                                                            <c:if test="${not empty exchange.deliveryDetails}">
                                                                <div class="mb-3">
                                                                    <h6>Delivery Details</h6>
                                                                    <p>${exchange.deliveryDetails}</p>
                                                                </div>
                                                            </c:if>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                            <c:if test="${exchange.status == 'REDEEMED'}">
                                                                <form action="/students/rewards/cancel/${exchange.id}" method="post">
                                                                    <button type="submit" class="btn btn-danger">Cancel Exchange</button>
                                                                </form>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
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

    <!-- Navigation -->
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

<%@ include file="../../layout/footer.jsp" %>