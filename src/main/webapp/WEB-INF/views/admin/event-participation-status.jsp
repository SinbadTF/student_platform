<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Participation Status - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link href="<c:url value='/resources/css/main.css' />" rel="stylesheet">
</head>
<body>
    <jsp:include page="../layout/header.jsp" />
    <div class="container py-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h3 class="mb-0"><i class="bi bi-info-circle me-2"></i>Event Participation Status</h3>
            <div>
                <a href="${pageContext.request.contextPath}/admin/event-participations" class="btn btn-outline-secondary">
                    <i class="bi bi-arrow-left me-1"></i>Back to Participations
                </a>
            </div>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <c:if test="${not empty status}">
            <div class="row">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <h5 class="mb-0"><i class="bi bi-people me-2"></i>Participation Statistics</h5>
                        </div>
                        <div class="card-body">
                            <div class="row text-center">
                                <div class="col-6">
                                    <div class="border-end">
                                        <h3 class="text-primary">${status.totalParticipations}</h3>
                                        <p class="text-muted mb-0">Total Participations</p>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <h3 class="text-warning">${status.pendingParticipations}</h3>
                                    <p class="text-muted mb-0">Pending</p>
                                </div>
                            </div>
                            <hr>
                            <div class="row text-center">
                                <div class="col-6">
                                    <div class="border-end">
                                        <h3 class="text-success">${status.approvedParticipations}</h3>
                                        <p class="text-muted mb-0">Approved</p>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <h3 class="text-danger">${status.notAwardedParticipations}</h3>
                                    <p class="text-muted mb-0">Not Awarded</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header bg-warning text-dark">
                            <h5 class="mb-0"><i class="bi bi-exclamation-triangle me-2"></i>Points Status</h5>
                        </div>
                        <div class="card-body">
                            <div class="text-center">
                                <h3 class="text-danger">${status.endedEventsWithPendingPoints}</h3>
                                <p class="text-muted mb-0">Ended Events with Pending Points</p>
                            </div>
                            <hr>
                            <div class="text-center">
                                <small class="text-muted">
                                    <i class="bi bi-clock me-1"></i>
                                    Current Time: ${status.currentTime}
                                </small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="row mt-4">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header bg-info text-white">
                            <h5 class="mb-0"><i class="bi bi-tools me-2"></i>Actions</h5>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-4">
                                    <form action="${pageContext.request.contextPath}/admin/trigger-event-points" method="post">
                                        <button type="submit" class="btn btn-warning w-100">
                                            <i class="bi bi-lightning me-1"></i>Trigger Point Awarding
                                        </button>
                                    </form>
                                </div>
                                <div class="col-md-4">
                                    <form action="${pageContext.request.contextPath}/admin/force-award-points" method="post">
                                        <button type="submit" class="btn btn-danger w-100" onclick="return confirm('This will force award points for ALL ended events. Are you sure?')">
                                            <i class="bi bi-exclamation-triangle me-1"></i>Force Award Points
                                        </button>
                                    </form>
                                </div>
                                <div class="col-md-4">
                                    <a href="${pageContext.request.contextPath}/admin/check-pending-points" class="btn btn-info w-100">
                                        <i class="bi bi-search me-1"></i>Check Pending Points
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
