<%@ include file="../../layout/header.jsp" %>
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
                            <h2 class="display-6 fw-bold">Manage Reward Exchanges</h2>
                            <p class="lead mb-0">Process student reward redemptions</p>
                        </div>
                        <div class="text-center">
                            <div class="bg-white rounded-circle p-3 d-inline-block">
                                <i class="bi bi-check2-circle text-success" style="font-size: 3rem;"></i>
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

    <!-- Pending Exchanges -->
    <div class="card border-0 shadow-sm rounded-3 mb-4">
        <div class="card-header bg-white py-3">
            <h5 class="mb-0"><i class="bi bi-hourglass-split text-warning me-2"></i> Pending Exchanges</h5>
        </div>
        <div class="card-body">
            <c:choose>
                <c:when test="${not empty pendingExchanges}">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead class="table-light">
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
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <i class="bi bi-person-circle text-primary me-2"></i>
                                                <span>${exchange.student.firstName} ${exchange.student.lastName}</span>
                                                <small class="text-muted ms-2">(${exchange.student.studentId})</small>
                                            </div>
                                        </td>
                                        <td>${exchange.reward.name}</td>
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
                                            <form action="/staff/rewards/fulfill/${exchange.id}" method="post">
                                                <button type="submit" class="btn btn-sm btn-success">Approve</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-4">
                        <i class="bi bi-check-circle text-success" style="font-size: 2rem;"></i>
                        <h5 class="mt-3">No Pending Exchanges</h5>
                        <p class="text-muted">All reward exchanges have been processed.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Navigation -->
    <div class="row mt-4">
        <div class="col-12 text-center">
            <a href="/staff/dashboard" class="btn btn-outline-secondary">
                <i class="bi bi-house"></i> Back to Dashboard
            </a>
        </div>
    </div>
</div>

<%@ include file="../../layout/footer.jsp" %>