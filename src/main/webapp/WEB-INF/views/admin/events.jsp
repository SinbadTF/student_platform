<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Event Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link href="<c:url value='/resources/css/main.css' />" rel="stylesheet">
    <style>
        .empty-state { padding: 3rem 1rem; border: 2px dashed #e9ecef; border-radius: .5rem; background: #fafafa; }
    </style>
    </head>
<body>
    <jsp:include page="../layout/header.jsp" />

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2 class="mb-0"><i class="bi bi-calendar-event text-warning"></i> Event Management</h2>
            <div>
                <a href="/admin/check-pending-points" class="btn btn-outline-secondary me-2" onclick="return confirm('Check for events that should award points?')">
                    <i class="bi bi-clock"></i> Check Pending
                </a>
                <a href="/admin/check-student-points" class="btn btn-secondary me-2" onclick="return confirm('Check all student points status?')">
                    <i class="bi bi-search"></i> Check Points
                </a>
                <a href="/admin/manual-award-points" class="btn btn-info me-2" onclick="return confirm('Manually trigger point awarding for ended events?')">
                    <i class="bi bi-currency-dollar"></i> Award Points
                </a>
                <a href="/admin/events/create" class="btn btn-warning"><i class="bi bi-plus-lg"></i> Create New Event</a>
            </div>
        </div>

        <c:choose>
            <c:when test="${not empty events}">
                <div class="table-responsive">
                    <table class="table table-striped align-middle">
                        <thead>
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Name</th>
                                <th scope="col">Location</th>
                                <th scope="col">Start</th>
                                <th scope="col">End</th>
                                <th scope="col">Points</th>
                                <th scope="col" class="text-end">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="event" items="${events}">
                                <tr>
                                    <td>${event.id}</td>
                                    <td>${event.name}</td>
                                    <td>${event.location}</td>
                                    <td>${event.startTime}</td>
                                    <td>${event.endTime}</td>
                                    <td>${event.pointValue}</td>
                                    <td class="text-end">
                                        <a href="/admin/events/view/${event.id}" class="btn btn-sm btn-outline-info">View</a>
                                        <a href="/admin/events/edit/${event.id}" class="btn btn-sm btn-outline-warning ms-1">Edit</a>
                                        <a href="/admin/events/delete/${event.id}" class="btn btn-sm btn-outline-danger ms-1" onclick="return confirm('Delete this event?');">Delete</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state text-center">
                    <div class="mb-2"><i class="bi bi-calendar-x" style="font-size: 3rem; color: #adb5bd;"></i></div>
                    <h5 class="mb-2">No events yet</h5>
                    <p class="text-muted mb-3">Create your first event to get started.</p>
                    <a href="/admin/events/create" class="btn btn-warning"><i class="bi bi-plus-lg"></i> Create New Event</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <jsp:include page="../layout/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>


