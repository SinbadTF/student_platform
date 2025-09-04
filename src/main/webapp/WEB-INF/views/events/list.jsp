<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Events</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="../layout/student_header.jsp" />
    
    <div class="container mt-4">
        <div class="d-flex justify-content-between mb-3">
            <h2>Events</h2>
        </div>
        
        <div class="row">
            <c:forEach var="event" items="${events}">
                <div class="col-md-4 mb-4">
                    <div class="card h-100">
                        <div class="card-body">
                            <h5 class="card-title">${event.name}</h5>
                            <p class="card-text">${event.description}</p>
                            <p class="card-text"><strong>Location:</strong> ${event.location}</p>
                            <p class="card-text"><strong>Start:</strong> ${event.startTime}</p>
                            <p class="card-text"><strong>End:</strong> ${event.endTime}</p>
                            <p class="card-text"><strong>Points:</strong> ${event.pointValue}</p>
                        </div>
                        <div class="card-footer bg-transparent">
                            <div class="d-flex justify-content-between align-items-center">
                                <a href="/events/view/${event.id}" class="btn btn-primary">View Details</a>
                                
                                <c:set var="eventStatus" value="${eventTimeStatus[event.id]}" />
                                <c:if test="${not empty eventStatus}">
                                    <c:if test="${eventStatus.isJoinWindow}">
                                        <form action="/events/register/${event.id}" method="post" class="d-inline">
                                            <button type="submit" class="btn btn-success">Join Now</button>
                                        </form>
                                    </c:if>
                                    <c:if test="${!eventStatus.isJoinWindow}">
                                        <small class="text-muted">
                                            <c:choose>
                                                <c:when test="${!eventStatus.hasStarted}">Not started yet</c:when>
                                                <c:otherwise>Event ended</c:otherwise>
                                            </c:choose>
                                        </small>
                                    </c:if>
                                </c:if>
                                <c:if test="${empty eventStatus}">
                                    <small class="text-muted">Time info unavailable</small>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
            
            <c:if test="${empty events}">
                <div class="col-12 text-center">
                    <p>No events available</p>
                </div>
            </c:if>
        </div>
    </div>
    
    <jsp:include page="../layout/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


