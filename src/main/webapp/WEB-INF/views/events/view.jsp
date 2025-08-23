<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>${event.name}</title>
</head>
<body>
    <jsp:include page="../layout/header.jsp" />
    
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
                        <p><strong>Start:</strong> <fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${event.startTime}" /></p>
                        <p><strong>End:</strong> <fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${event.endTime}" /></p>
                        
                        <h5>Points</h5>
                        <p>${event.pointValue} points will be awarded for participation</p>
                        
                        <h5>Created By</h5>
                        <p>${event.createdBy.firstName} ${event.createdBy.lastName}</p>
                    </div>
                    <div class="col-md-4 text-center">
                        <c:if test="${!isRegistered}">
                            <form action="/events/register/${event.id}" method="post">
                                <button type="submit" class="btn btn-success btn-lg">Register for Event</button>
                            </form>
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
</body>
</html>