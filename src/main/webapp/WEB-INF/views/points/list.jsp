<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Points Management</title>
</head>
<body>
    <jsp:include page="../layout/header.jsp" />
    
    <div class="container mt-4">
        <div class="row mb-3">
            <div class="col-md-6">
                <h2>Points Management</h2>
            </div>
            <div class="col-md-6 text-right">
                <button class="btn btn-outline-primary mb-2" type="button" data-bs-toggle="collapse" data-bs-target="#advancedSearch" aria-expanded="false" aria-controls="advancedSearch">
                    Advanced Search
                </button>
            </div>
        </div>
        
        <div class="collapse mb-3" id="advancedSearch">
            <div class="card card-body">
                <form action="/points" method="get" id="searchForm">
                    <div class="row">
                        <div class="col-md-3 mb-2">
                            <label for="keyword">Keyword</label>
                            <input type="text" name="keyword" id="keyword" class="form-control" placeholder="Search..." value="${param.keyword}">
                        </div>
                        <div class="col-md-3 mb-2">
                            <label for="studentName">Student Name</label>
                            <input type="text" name="studentName" id="studentName" class="form-control" placeholder="Student name..." value="${param.studentName}">
                        </div>
                        <div class="col-md-3 mb-2">
                            <label for="minValue">Min Points</label>
                            <input type="number" name="minValue" id="minValue" class="form-control" placeholder="Min value" value="${param.minValue}">
                        </div>
                        <div class="col-md-3 mb-2">
                            <label for="maxValue">Max Points</label>
                            <input type="number" name="maxValue" id="maxValue" class="form-control" placeholder="Max value" value="${param.maxValue}">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3 mb-2">
                            <label for="reason">Reason</label>
                            <input type="text" name="reason" id="reason" class="form-control" placeholder="Reason..." value="${param.reason}">
                        </div>
                        <div class="col-md-3 mb-2">
                            <label for="startDate">Start Date</label>
                            <input type="date" name="startDate" id="startDate" class="form-control" value="${param.startDate}">
                        </div>
                        <div class="col-md-3 mb-2">
                            <label for="endDate">End Date</label>
                            <input type="date" name="endDate" id="endDate" class="form-control" value="${param.endDate}">
                        </div>
                        <div class="col-md-3 d-flex align-items-end">
                            <button type="submit" class="btn btn-primary me-2">Search</button>
                            <button type="button" id="resetSearch" class="btn btn-secondary">Reset</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        
        <div class="row mb-3">
            <div class="col-md-6">
                <a href="/points/create" class="btn btn-primary">Award New Points</a>
            </div>
            <div class="col-md-6 text-right">
                <div class="input-group">
                    <input type="text" id="tableFilter" class="form-control" placeholder="Filter results...">
                    <div class="input-group-append">
                        <span class="input-group-text"><i class="bi bi-search"></i></span>
                    </div>
                </div>
            </div>
        </div>
        
        <table class="table table-striped" id="pointsTable">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Student</th>
                    <th>Value</th>
                    <th>Reason</th>
                    <th>Reward</th>
                    <th>Issued By</th>
                    <th>Issued At</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="point" items="${points}">
                    <tr>
                        <td>${point.id}</td>
                        <td>${point.student.firstName} ${point.student.lastName}</td>
                        <td>${point.value}</td>
                        <td>${point.reason}</td>
                        <td>${point.reward != null ? point.reward.name : 'N/A'}</td>
                        <td>${point.issuedBy != null ? point.issuedBy.firstName : ''} ${point.issuedBy != null ? point.issuedBy.lastName : ''}</td>
                        <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${point.issuedAt}" /></td>
                        <td>
                            <a href="/points/view/${point.id}" class="btn btn-info btn-sm">View</a>
                            <a href="/points/edit/${point.id}" class="btn btn-warning btn-sm">Edit</a>
                            <button onclick="confirmDelete(${point.id})" class="btn btn-danger btn-sm">Delete</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteModalLabel">Confirm Delete</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" id="deleteModalBody">
                    Are you sure you want to delete this point record?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <a href="" id="deleteLink" class="btn btn-danger">Delete</a>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="../layout/footer.jsp" />
    
    <script>
        function confirmDelete(id) {
            document.getElementById('deleteModalBody').textContent = 'Are you sure you want to delete this point record?';
            document.getElementById('deleteLink').href = '/points/delete/' + id;
            $('#deleteModal').modal('show');
        }
    </script>
</body>
</html>