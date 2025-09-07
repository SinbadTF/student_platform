<%@ include file="../layout/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Student Activity Participations View -->
<div class="container py-4">
    <!-- Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h2 class="display-6 fw-bold text-primary">
                        <i class="bi bi-list-check me-2"></i>My Activity Participations
                    </h2>
                    <p class="lead text-muted">Track your activity participation status and points earned</p>
                    
                </div>
                <div>
                    <a href="/students/activities" class="btn btn-outline-primary">
                        <i class="bi bi-arrow-left me-2"></i>Back to Activities
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Participations List -->
    <div class="row">
        <div class="col-12">
            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-body">
                    <c:choose>
                        <c:when test="${empty participations}">
                            <div class="text-center py-5">
                                <i class="bi bi-calendar-x text-muted" style="font-size: 3rem;"></i>
                                <h4 class="mt-3">No activity participations yet</h4>
                                <p class="text-muted">Join club activities to see them listed here</p>
                                <a href="/students/activities" class="btn btn-primary mt-2">
                                    <i class="bi bi-calendar-plus me-2"></i>Browse Activities
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>Activity</th>
                                            <th>Club</th>
                                            <th>Participated On</th>
                                            <th>Status</th>
                                            <th>Points</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${participations}" var="participation">
                                            <tr>
                                                <td>${participation.activity.title}</td>
                                                <td>${participation.activity.club.name}</td>
                                                <td>
                                                    <fmt:parseDate value="${participation.participatedAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                                                    <fmt:formatDate value="${parsedDate}" pattern="MMM dd, yyyy" />
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${participation.status == 'APPROVED'}">
                                                            <span class="badge bg-success">Approved</span>
                                                        </c:when>
                                                        <c:when test="${participation.status == 'REJECTED'}">
                                                            <span class="badge bg-danger">Rejected</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-warning text-dark">Pending</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${participation.status == 'APPROVED'}">
                                                            <span class="text-success fw-bold">+${participation.pointsEarned}</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-muted">--</span>
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
</div>

<%@ include file="../layout/footer.jsp" %>