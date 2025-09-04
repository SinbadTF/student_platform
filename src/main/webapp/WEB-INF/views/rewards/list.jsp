<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Rewards Management</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
    <jsp:include page="../layout/header.jsp" />
    
    <div class="container mt-4">
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <div class="row mb-3 d-flex align-items-center">
            <div class="col-md-5">
                <h2>Rewards Management</h2>
            </div>
            <div class="col-md-7">
                <div class="d-flex justify-content-end align-items-center">
                    <div class="form-check me-3">
                        <input class="form-check-input" type="checkbox" id="showInactive" 
                               ${showInactive ? 'checked' : ''} onchange="toggleInactive()">
                        <label class="form-check-label" for="showInactive">
                            Show Inactive Rewards
                        </label>
                    </div>
                    <form action="/rewards" method="get" class="form-inline">
                        <input type="hidden" name="showInactive" value="${showInactive}">
                        <div class="input-group">
                            <input type="text" name="keyword" class="form-control" 
                                   placeholder="Search rewards..." value="${param.keyword}">
                            <button class="btn btn-outline-secondary" type="submit">
                                <i class="bi bi-search"></i>
                            </button>
                        </div>
                    </form>
                </div>
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
                    <th>Created by</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="reward" items="${rewards}">
                    <tr class="${reward.active ? '' : 'table-secondary'}">
                        <td>${reward.id}</td>
                        <td>${reward.name}</td>
                        <td>${reward.description}</td>
                        <td>${reward.pointValue}</td>
                        <td>
                            <c:choose>
                                <c:when test="${reward.issuedBy != null}">
                                    <a href="/staff/view/${reward.issuedBy.id}">${reward.issuedBy.firstName} ${reward.issuedBy.lastName}</a>
                                </c:when>
                                <c:otherwise>
                                    Admin
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <span class="badge ${reward.active ? 'bg-success' : 'bg-secondary'}">
                                ${reward.active ? 'Active' : 'Inactive'}
                            </span>
                        </td>
                        <td>
                            <a href="/rewards/view/${reward.id}" class="btn btn-info btn-sm">View</a>
                            <a href="/rewards/edit/${reward.id}" class="btn btn-warning btn-sm">Edit</a>
                            <c:choose>
                                <c:when test="${reward.active}">
                                    <button onclick="confirmDelete(${reward.id}, '${reward.name}')" class="btn btn-danger btn-sm">Delete</button>
                                    <button onclick="confirmDeactivate(${reward.id}, '${reward.name}')" class="btn btn-secondary btn-sm">Deactivate</button>
                                </c:when>
                                <c:otherwise>
                                    <button onclick="confirmActivate(${reward.id}, '${reward.name}')" class="btn btn-success btn-sm">Activate</button>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                
            </tbody>
        </table>
    </div>
    
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteModalLabel">Confirm Delete</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="deleteModalBody">
                    Are you sure you want to delete this reward?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <a href="" id="deleteLink" class="btn btn-danger">Delete</a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="modal fade" id="deactivateModal" tabindex="-1" aria-labelledby="deactivateModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deactivateModalLabel">Confirm Deactivate</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="deactivateModalBody">
                    Are you sure you want to deactivate this reward?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <a href="" id="deactivateLink" class="btn btn-primary">Deactivate</a>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="../layout/footer.jsp" />
    
    <script>
        function confirmDelete(id, name) {
            document.getElementById('deleteModalBody').textContent = 'Are you sure you want to delete the reward "' + name + '"?';
            document.getElementById('deleteLink').href = '/rewards/delete/' + id;
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }
        
        function confirmDeactivate(id, name) {
            document.getElementById('deactivateModalBody').textContent = 'Are you sure you want to deactivate the reward "' + name + '"? It will no longer be available for students to redeem.';
            document.getElementById('deactivateLink').href = '/rewards/deactivate/' + id;
            new bootstrap.Modal(document.getElementById('deactivateModal')).show();
        }
        
        function confirmActivate(id, name) {
            document.getElementById('deactivateModalBody').textContent = 'Are you sure you want to activate the reward "' + name + '"? It will become available for students to redeem.';
            document.getElementById('deactivateLink').href = '/rewards/activate/' + id;
            document.getElementById('deactivateModalLabel').textContent = 'Confirm Activate';
            document.getElementById('deactivateLink').textContent = 'Activate';
            document.getElementById('deactivateLink').className = 'btn btn-success';
            new bootstrap.Modal(document.getElementById('deactivateModal')).show();
        }
        
        function toggleInactive() {
            const showInactive = document.getElementById('showInactive').checked;
            window.location.href = '/rewards?showInactive=' + showInactive;
        }
    </script>
</body>
</html>