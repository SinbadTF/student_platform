<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Club Management</title>
</head>
<body>
    <jsp:include page="../layout/header.jsp" />
    
    <div class="container mt-4">
        <div class="row mb-3">
            <div class="col-md-6">
                <h2>Club Management</h2>
            </div>
            <div class="col-md-6 text-right">
                <form action="/admin/clubs" method="get" class="form-inline justify-content-end">
                    <div class="input-group">
                        <input type="text" name="keyword" class="form-control" placeholder="Search clubs..." value="${param.keyword}">
                        <div class="input-group-append">
                            <button class="btn btn-outline-secondary" type="submit">Search</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        
        <a href="/admin/clubs/create" class="btn btn-primary mb-3">Create New Club</a>
        
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Meeting Details</th>
                    <th>Created By</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="club" items="${clubs}">
                    <tr>
                        <td>${club.id}</td>
                        <td>${club.name}</td>
                        <td>${club.description}</td>
                        <td>${club.createdBy.firstName} ${club.createdBy.lastName}</td>
                        <td>
                            <a href="/admin/clubs/view/${club.id}" class="btn btn-info btn-sm">View</a>
                            <a href="/admin/clubs/edit/${club.id}" class="btn btn-warning btn-sm">Edit</a>
                            <a href="/admin/clubs/delete/${club.id}" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this club?')">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
                
                <c:if test="${empty clubs}">
                    <tr>
                        <td colspan="6" class="text-center">No clubs found</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
    
    <jsp:include page="../layout/footer.jsp" />
</body>
</html>