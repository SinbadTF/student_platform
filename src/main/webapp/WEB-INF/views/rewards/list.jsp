<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Rewards Management</title>
</head>
<body>
    <jsp:include page="../layout/header.jsp" />
    
    <div class="container mt-4">
        <div class="row mb-3">
            <div class="col-md-6">
                <h2>Rewards Management</h2>
            </div>
            <div class="col-md-6 text-right">
                <form action="/rewards" method="get" class="form-inline justify-content-end">
                    <div class="input-group">
                        <input type="text" name="keyword" class="form-control" placeholder="Search rewards..." value="${param.keyword}">
                        <div class="input-group-append">
                            <button class="btn btn-outline-secondary" type="submit">Search</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        
        <a href="/rewards/create" class="btn btn-primary mb-3">Add New Reward</a>
        
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Point Value</th>
                    <th>Issued By</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="reward" items="${rewards}">
                    <tr>
                        <td>${reward.id}</td>
                        <td>${reward.name}</td>
                        <td>${reward.description}</td>
                        <td>${reward.pointValue}</td>
                        <td>${reward.issuedBy != null ? reward.issuedBy.firstName : ''} ${reward.issuedBy != null ? reward.issuedBy.lastName : ''}</td>
                        <td>
                            <a href="/rewards/view/${reward.id}" class="btn btn-info btn-sm">View</a>
                            <a href="/rewards/edit/${reward.id}" class="btn btn-warning btn-sm">Edit</a>
                            <button onclick="confirmDelete(${reward.id}, '${reward.name}')" class="btn btn-danger btn-sm">Delete</button>
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
                    Are you sure you want to delete this reward?
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
        function confirmDelete(id, name) {
            document.getElementById('deleteModalBody').textContent = 'Are you sure you want to delete the reward "' + name + '"?';
            document.getElementById('deleteLink').href = '/rewards/delete/' + id;
            $('#deleteModal').modal('show');
        }
    </script>
</body>
</html>