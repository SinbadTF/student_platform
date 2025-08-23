<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Events</title>
</head>
<body>
    <jsp:include page="../layout/header.jsp" />
    
    <div class="container mt-4">
        <div class="row mb-3">
            <div class="col-md-6">
                <h2>Events</h2>
            </div>
            <div class="col-md-6 text-right">
                <form action="/events" method="get" class="form-inline justify-content-end">
                    <div class="input-group">
                        <input type="text" name="keyword" class="form-control" placeholder="Search events..." value="${param.keyword}">
                        <div class="input-group-append">
                            <button class="btn btn-outline-secondary" type="submit">Search</button>
                        </div>
                    </div>
                </form>
            </div>
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
                            <a href="/events/view/${event.id}" class="btn btn-primary">View Details</a>
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
</body>
</html>