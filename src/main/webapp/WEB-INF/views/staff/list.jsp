<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../layout/header.jsp" />

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Staff Management</h2>
        <a href="/staff/create" class="btn btn-primary">Add New Staff</a>
    </div>
    
    <div class="card mb-4">
        <div class="card-body">
            <form action="/staff" method="get" class="d-flex">
                <input type="text" name="keyword" class="form-control me-2" placeholder="Search by name..." value="${param.keyword}">
                <button type="submit" class="btn btn-outline-primary">Search</button>
            </form>
        </div>
    </div>

    <div class="card">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Staff ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Department</th>
                            <th>Position</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="staffMember" items="${staff}">
    <tr>
        <td>${staffMember.staffId}</td>
        <td>${staffMember.firstName} ${staffMember.lastName}</td>
        <td>${staffMember.email}</td>
        <td>${staffMember.department}</td>
        <td>${staffMember.position}</td>
        <td>
            <a href="/staff/view/${staffMember.id}" class="btn btn-sm btn-info">View</a>
            <a href="/staff/edit/${staffMember.id}" class="btn btn-sm btn-warning">Edit</a>
            <button onclick="confirmDelete(${staffMember.id}, '${staffMember.firstName} ${staffMember.lastName}')" class="btn btn-sm btn-danger">Delete</button>
        </td>
    </tr>
</c:forEach>
                        <c:if test="${empty staff}">
                            <tr>
                                <td colspan="6" class="text-center">No staff members found</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteModalLabel">Confirm Delete</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="deleteModalBody">
                Are you sure you want to delete this staff member?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <a href="#" id="confirmDeleteBtn" class="btn btn-danger">Delete</a>
            </div>
        </div>
    </div>
</div>

<script>
    function confirmDelete(id, name) {
        document.getElementById('deleteModalBody').textContent = `Are you sure you want to delete ${name}?`;
        document.getElementById('confirmDeleteBtn').href = `/staff/delete/${id}`;
        new bootstrap.Modal(document.getElementById('deleteModal')).show();
    }
</script>

<jsp:include page="../layout/footer.jsp" />