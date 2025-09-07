<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Spinwheel History - Student Platform</title>
    <!-- Google Fonts - Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link href="<c:url value='/resources/css/main.css' />" rel="stylesheet">
</head>
<body>
    <jsp:include page="../layout/student_header.jsp" />
    
    <div class="container py-4">
        <!-- Header -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h2 class="display-6 fw-bold">Spinwheel History</h2>
                        <p class="lead text-muted">Your spinwheel activity and rewards</p>
                    </div>
                    <div class="text-end">
                        <div class="badge bg-primary fs-6 p-2">
                            <i class="bi bi-star-fill me-1"></i>${student.points} Points
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Statistics -->
        <div class="row mb-4">
            <div class="col-md-4">
                <div class="card border-0 shadow-sm rounded-3 text-center">
                    <div class="card-body">
                        <i class="bi bi-arrow-repeat text-primary" style="font-size: 2rem;"></i>
                        <h4 class="mt-2 text-primary">${spinHistory.size()}</h4>
                        <p class="text-muted mb-0">Total Spins</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card border-0 shadow-sm rounded-3 text-center">
                    <div class="card-body">
                        <i class="bi bi-star text-success" style="font-size: 2rem;"></i>
                        <h4 class="mt-2 text-success">
                            <c:set var="totalPoints" value="0" />
                            <c:forEach var="history" items="${spinHistory}">
                                <c:set var="totalPoints" value="${totalPoints + history.pointsAwarded}" />
                            </c:forEach>
                            ${totalPoints}
                        </h4>
                        <p class="text-muted mb-0">Points Won</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card border-0 shadow-sm rounded-3 text-center">
                    <div class="card-body">
                        <i class="bi bi-trophy text-warning" style="font-size: 2rem;"></i>
                        <h4 class="mt-2 text-warning">
                            <c:set var="uniqueRewards" value="0" />
                            <c:forEach var="history" items="${spinHistory}">
                                <c:if test="${history.pointsAwarded > 0}">
                                    <c:set var="uniqueRewards" value="${uniqueRewards + 1}" />
                                </c:if>
                            </c:forEach>
                            ${uniqueRewards}
                        </h4>
                        <p class="text-muted mb-0">Wins</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Spin History -->
        <div class="row">
            <div class="col-12">
                <div class="card border-0 shadow-sm rounded-3">
                    <div class="card-header bg-white border-0 py-3">
                        <h5 class="mb-0"><i class="bi bi-clock-history text-info me-2"></i>Recent Spins</h5>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty spinHistory}">
                                <div class="text-center py-5">
                                    <i class="bi bi-arrow-repeat text-muted" style="font-size: 4rem;"></i>
                                    <h4 class="mt-3 text-muted">No Spin History</h4>
                                    <p class="text-muted">Start spinning to see your history here!</p>
                                    <a href="/students/spinwheel" class="btn btn-primary">
                                        <i class="bi bi-play-circle me-2"></i>Start Spinning
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Date</th>
                                                <th>Spinwheel</th>
                                                <th>Result</th>
                                                <th>Points</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="history" items="${spinHistory}">
                                                <tr>
                                                    <td>
                                                        ${history.spunAt}
                                                    </td>
                                                    <td>
                                                        <strong>${history.spinWheel.name}</strong>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty history.resultItem}">
                                                                <span class="badge bg-info">${history.resultItem.label}</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">No result</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${history.pointsAwarded > 0}">
                                                                <span class="badge bg-success">+${history.pointsAwarded} pts</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">0 pts</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${history.pointsAwarded > 0}">
                                                                <span class="badge bg-success">Won</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-secondary">No Win</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="row mt-4">
            <div class="col-12">
                <div class="card border-0 shadow-sm rounded-3">
                    <div class="card-body text-center">
                        <h5 class="mb-3">Ready for More Spins?</h5>
                        <a href="/students/spinwheel" class="btn btn-primary me-2">
                            <i class="bi bi-arrow-repeat me-2"></i>Spin Again
                        </a>
                        <a href="/students/dashboard/${student.id}" class="btn btn-outline-secondary">
                            <i class="bi bi-house me-2"></i>Dashboard
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="../layout/footer.jsp" />
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
