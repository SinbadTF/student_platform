<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Clubs</title>
</head>
<body>
    <jsp:include page="../layout/header.jsp" />
    
    <div class="container mt-4">
        <div class="row mb-3">
            <div class="col-md-6">
                <h2>Clubs</h2>
            </div>
            <div class="col-md-6 text-right">
                <form action="/clubs" method="get" class="form-inline justify-content-end">
                    <div class="input-group">
                        <input type="text" name="keyword" class="form-control" placeholder="Search clubs..." value="${param.keyword}">
                        <div class="input-group-append">
                            <button class="btn btn-outline-secondary" type="submit">Search</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        
        <div class="row">
            <c:forEach var="club" items="${clubs}">
                <div class="col-md-4 mb-4">
                    <div class="card h-100">
                        <div class="card-body">
                            <h5 class="card-title">${club.name}</h5>
                            <p class="card-text">${club.description}</p>
                            <p class="card-text"><small class="text-muted">Meeting: ${club.meetingLocation}, ${club.meetingSchedule}</small></p>
                        </div>
                        <div class="card-footer bg-transparent">
                            <a href="/clubs/view/${club.id}" class="btn btn-primary">View Details</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
            
            <c:if test="${empty clubs}">
                <div class="col-12 text-center">
                    <p>No clubs available</p>
                </div>
            </c:if>
        </div>
    </div>
    
    <jsp:include page="../layout/footer.jsp" />
</body>
</html>