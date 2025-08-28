<%@ include file="../layout/staff_header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Staff Dashboard -->
<div class="container py-4">
    <!-- Welcome Banner -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card bg-primary text-white shadow-lg rounded-3 border-0">
                <div class="card-body p-4">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h2 class="display-6 fw-bold">Welcome, ${staff.firstName}!</h2>
                            <p class="lead mb-0">Staff ID: ${staff.staffId}</p>
                        </div>
                        <div class="text-center">
                            <div class="bg-white rounded-circle p-3 d-inline-block">
                                <i class="bi bi-person-badge text-primary" style="font-size: 3rem;"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Actions -->
    <div class="row mb-4">
        <div class="col-md-6">
            <div class="card border-0 shadow-sm rounded-3 h-100">
                <div class="card-body text-center">
                    <div class="bg-light rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
                        <i class="bi bi-gift text-primary" style="font-size: 2rem;"></i>
                    </div>
                    <h5 class="card-title">Create Rewards</h5>
                    <p class="card-text">Create new rewards for students</p>
                    <a href="/staff/rewards/create" class="btn btn-primary">Create Reward</a>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card border-0 shadow-sm rounded-3 h-100">
                <div class="card-body text-center">
                    <div class="bg-light rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
                        <i class="bi bi-arrow-repeat text-success" style="font-size: 2rem;"></i>
                    </div>
                    <h5 class="card-title">Process Exchanges</h5>
                    <p class="card-text">Review and process student reward exchanges</p>
                    <a href="/staff/rewards/exchanges" class="btn btn-success">View Exchanges</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Pending Exchanges -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-header bg-white">
                    <h5 class="mb-0">Pending Reward Exchanges</h5>
                </div>
                <div class="card-body">
                    <c:if test="${not empty pendingExchanges}">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Student</th>
                                        <th>Reward</th>
                                        <th>Points</th>
                                        <th>Date</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${pendingExchanges}" var="exchange">
                                        <tr>
                                            <td>${exchange.student.firstName} ${exchange.student.lastName}</td>
                                            <td>${exchange.reward.name}</td>
                                            <td>${exchange.pointsSpent}</td>
                                            <td>
                                                <fmt:parseDate value="${exchange.exchangedAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                                                <fmt:formatDate value="${parsedDate}" pattern="MMM dd, yyyy" />
                                            </td>
                                            <td>
                                                <a href="/staff/rewards/exchanges" class="btn btn-sm btn-outline-primary">Process</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                    <c:if test="${empty pendingExchanges}">
                        <p class="text-center py-3">No pending exchanges to process</p>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <!-- Created Rewards -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-header bg-white d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Rewards You've Created</h5>
                    <a href="/staff/rewards/create" class="btn btn-sm btn-primary">Create New Reward</a>
                </div>
                <div class="card-body">
                    <c:if test="${not empty createdRewards}">
                        <div class="row">
                            <c:forEach items="${createdRewards}" var="reward">
                                <div class="col-md-4 mb-3">
                                    <div class="card h-100 border-0 shadow-sm">
                                        <div class="card-body">
                                            <h5 class="card-title">${reward.name}</h5>
                                            <p class="card-text small">${reward.description}</p>
                                            <div class="d-flex justify-content-between align-items-center">
                                                <span class="badge bg-primary">${reward.pointValue} points</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:if>
                    <c:if test="${empty createdRewards}">
                        <p class="text-center py-3">You haven't created any rewards yet</p>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Redemption History -->
    <div class="row">
        <div class="col-12">
            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-header bg-white">
                    <h5 class="mb-0">Redemption History</h5>
                </div>
                <div class="card-body">
                    <c:if test="${not empty fulfilledExchanges}">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Student</th>
                                        <th>Reward</th>
                                        <th>Points</th>
                                        <th>Exchanged Date</th>
                                        <th>Fulfilled Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${fulfilledExchanges}" var="exchange">
                                        <tr>
                                            <td>${exchange.student.firstName} ${exchange.student.lastName}</td>
                                            <td>${exchange.reward.name}</td>
                                            <td>${exchange.pointsSpent}</td>
                                            <td>
                                                <fmt:parseDate value="${exchange.exchangedAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                                                <fmt:formatDate value="${parsedDate}" pattern="MMM dd, yyyy" />
                                            </td>
                                            <td>
                                                <fmt:parseDate value="${exchange.fulfilledAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedFulfilledDate" type="both" />
                                                <fmt:formatDate value="${parsedFulfilledDate}" pattern="MMM dd, yyyy" />
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                    <c:if test="${empty fulfilledExchanges}">
                        <p class="text-center py-3">You haven't fulfilled any exchanges yet</p>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>