<%@ include file="../layout/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2>Student Management</h2>
    
</div>

<div class="card">
    <div class="card-header">
        <div class="row">
            <div class="col-md-6">
                <h5>Students List</h5>
            </div>
            <div class="col-md-6">
                <form action="/students" method="get" class="d-flex">
                    <input type="text" name="keyword" class="form-control me-2" placeholder="Search by name...">
                    <button type="submit" class="btn btn-outline-secondary">Search</button>
                </form>
            </div>
        </div>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Student ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Department</th>
                        <th>Year</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${students}" var="student">
                        <tr>
                            <td>${student.id}</td>
                            <td>${student.studentId}</td>
                            <td>${student.firstName} ${student.lastName}</td>
                            <td>${student.email}</td>
                            <td>${student.department}</td>
                            <td>${student.year}</td>
                            <td>
                                <div class="btn-group" role="group">
                                    <a href="/students/view/${student.id}" class="btn btn-sm btn-info">View</a>
                                    <a href="/students/edit/${student.id}" class="btn btn-sm btn-warning">Edit</a>
                                    <button onclick="confirmDelete(${student.id}, '${student.firstName} ${student.lastName}')" class="btn btn-sm btn-danger">Delete</button>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    
                    <c:if test="${empty students}">
                        <tr>
                            <td colspan="7" class="text-center">No students found</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
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
                <!-- Content will be set dynamically -->
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
        document.getElementById('deleteModalBody').textContent = `Are you sure you want to delete student ${name}?`;
        document.getElementById('confirmDeleteBtn').href = `/students/delete/${id}`;
        new bootstrap.Modal(document.getElementById('deleteModal')).show();
    }
</script>

<%@ include file="../layout/footer.jsp" %>