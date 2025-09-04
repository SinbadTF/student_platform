<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>${event.name}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="../layout/student_header.jsp" />
    
    <div class="container mt-4">
        <div class="card mb-4">
            <div class="card-header bg-danger text-white">
                <h3>${event.name}</h3>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-8">
                        <h5>Description</h5>
                        <p>${event.description}</p>
                        
                        <h5>Location</h5>
                        <p>${event.location}</p>
                        
                        <h5>Date & Time</h5>
                        <p><strong>Start:</strong> ${event.startTime}</p>
                        <p><strong>End:</strong> ${event.endTime}</p>
                        
                        <h5>Points</h5>
                        <p>${event.pointValue} points will be awarded for participation</p>
                        
                        <h5>Event Status</h5>
                        <c:choose>
                            <c:when test="${!hasStarted}">
                                <div class="alert alert-info">
                                    <strong>Event hasn't started yet.</strong> Join button will appear when the event begins.
                                </div>
                            </c:when>
                            <c:when test="${hasEnded}">
                                <div class="alert alert-secondary">
                                    <strong>Event has ended.</strong> Registration is no longer available.
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-success">
                                    <strong>Event is now active!</strong> Students can join during this time.
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="col-md-4 text-center">
                        <c:if test="${!isRegistered}">
                            <c:choose>
                                <c:when test="${isJoinWindow}">
                                    <form action="/events/register/${event.id}" method="post">
                                        <button type="submit" class="btn btn-success btn-lg">Join Now</button>
                                    </form>
                                    <p class="text-muted mt-2">Event is currently active</p>
                                </c:when>
                                <c:otherwise>
                                    <div class="alert alert-warning">
                                        <strong>
                                            <c:choose>
                                                <c:when test="${!hasStarted}">
                                                    Registration opens at event start time
                                                </c:when>
                                                <c:otherwise>
                                                    Registration closed at event end time
                                                </c:otherwise>
                                            </c:choose>
                                        </strong>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </c:if>
                        <c:if test="${isRegistered}">
                            <div class="alert alert-info">
                                <strong>You are already registered for this event.</strong>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
        
        <a href="/events" class="btn btn-secondary">Back to Events</a>
    </div>
    
    <jsp:include page="../layout/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


