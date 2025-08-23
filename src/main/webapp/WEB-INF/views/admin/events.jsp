<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Event Management</title>
</head>
<body>
    <jsp:include page="../layout/header.jsp" />
    
    <div class="container mt-4">
        <div class="row mb-3">
            <div class="col-md-6">
                <h2>Event Management</h2>
            </div>
            <div class="col-md-6 text-right">
                <form action="/admin/events" method="get" class="form-inline justify-content-end">
                    <div class="input-group">
                        <input type="text" name="keyword" class="form-control" placeholder="Search events..." value="${param.keyword}">
                        <div class="input-group-append">
                            <button class="btn btn-outline-secondary" type="submit">Search</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        
        <a href="/admin/events/create" class="btn btn-primary mb-3">Create New Event</a>
        
        <!-- All Events Table -->
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Location</th>
                    <th>Start Time</th>
                    <th>End Time</th>
                    <th>Points</th>
                    <th>Created By</th>
                    <th>Actions</th>
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
                        <td>${event.createdBy.firstName} ${event.createdBy.lastName}</td>
                        <td>
                            <a href="/admin/events/view/${event.id}" class="btn btn-info btn-sm">View</a>
                            <a href="/admin/events/edit/${event.id}" class="btn btn-warning btn-sm">Edit</a>
                            <a href="/admin/events/delete/${event.id}" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this event?')">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
                
                <c:if test="${empty events}">
                    <tr>
                        <td colspan="8" class="text-center">No events found</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
    
    <jsp:include page="../layout/footer.jsp" />
</body>
</html>