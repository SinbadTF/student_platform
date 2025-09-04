<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Activity Participations - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link href="<c:url value='/resources/css/main.css' />" rel="stylesheet">
</head>
<body>
    <jsp:include page="../layout/header.jsp" />
    <div class="container py-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h3 class="mb-0"><i class="bi bi-people me-2"></i>Activity Participations</h3>
            <a href="${pageContext.request.contextPath}/admin/studentmonitoring" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-left me-1"></i>Back
            </a>
        </div>

        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <div class="row">
            <div class="col-lg-6 mb-4">
                <div class="card">
                    <div class="card-header bg-white">
                        <strong>Pending Participations</strong>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-sm align-middle">
                                <thead>
                                    <tr>
                                        <th>Student</th>
                                        <th>Activity</th>
                                        <th>Points</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="p" items="${pendingParticipations}">
                                        <tr>
                                            <td>
                                                <div class="small fw-semibold">${p.student.firstName} ${p.student.lastName}</div>
                                                <div class="text-muted small">${p.student.studentId}</div>
                                            </td>
                                            <td>
                                                <div class="small">${p.activity.title}</div>
                                                <div class="text-muted small">${p.activity.club != null ? p.activity.club.name : 'No club'}</div>
                                            </td>
                                            <td>${p.activity.points}</td>
                                            <td>
                                                <form action="${pageContext.request.contextPath}/admin/approve-activity-participation/${p.id}" method="post" style="display:inline;">
                                                    <button type="submit" class="btn btn-sm btn-success"><i class="bi bi-check2"></i></button>
                                                </form>
                                                <form action="${pageContext.request.contextPath}/admin/reject-activity-participation/${p.id}" method="post" style="display:inline;">
                                                    <button type="submit" class="btn btn-sm btn-outline-danger"><i class="bi bi-x"></i></button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty pendingParticipations}">
                                        <tr><td colspan="4" class="text-center text-muted">No pending participations</td></tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 mb-4">
                <div class="card">
                    <div class="card-header bg-white">
                        <strong>Recently Approved</strong>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-sm align-middle">
                                <thead>
                                    <tr>
                                        <th>Student</th>
                                        <th>Activity</th>
                                        <th>Points</th>
                                        <th>Approved At</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="p" items="${approvedParticipations}">
                                        <tr>
                                            <td>
                                                <div class="small fw-semibold">${p.student.firstName} ${p.student.lastName}</div>
                                                <div class="text-muted small">${p.student.studentId}</div>
                                            </td>
                                            <td>
                                                <div class="small">${p.activity.title}</div>
                                                <div class="text-muted small">${p.activity.club != null ? p.activity.club.name : 'No club'}</div>
                                            </td>
                                            <td>${p.pointsEarned}</td>
                                            <td><span class="small text-muted">${p.approvedAt}</span></td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty approvedParticipations}">
                                        <tr><td colspan="4" class="text-center text-muted">No approved items</td></tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


