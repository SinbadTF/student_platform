<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>${club.name}</title>
</head>
<body>
    <jsp:include page="../layout/header.jsp" />
    
    <div class="container mt-4">
        <div class="card mb-4">
            <div class="card-header bg-primary text-white">
                <h3>${club.name}</h3>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-8">
                        <h5>Description</h5>
                        <p>${club.description}</p>
                        
                        <h5>Meeting Details</h5>
                        <p>${club.meetingLocation}, ${club.meetingSchedule}</p>
                        
                        <h5>Created By</h5>
                        <p>${club.createdBy.firstName} ${club.createdBy.lastName}</p>
                    </div>
                    <div class="col-md-4 text-center">
                        <c:if test="${!isJoined}">
                            <form action="/clubs/join/${club.id}" method="post">
                                <button type="submit" class="btn btn-success btn-lg">Join Club</button>
                            </form>
                        </c:if>
                        <c:if test="${isJoined}">
                            <div class="alert alert-info">
                                <strong>You have already joined this club.</strong>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
        
        <a href="/clubs" class="btn btn-secondary">Back to Clubs</a>
    </div>
    
    <jsp:include page="../layout/footer.jsp" />
</body>
</html>