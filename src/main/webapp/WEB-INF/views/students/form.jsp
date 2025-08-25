<%@ include file="../layout/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2>${student.id != null ? 'Edit' : 'Add'} Student</h2>
    <a href="/students" class="btn btn-secondary">Back to List</a>
</div>

<div class="card">
    <div class="card-body">
        <form:form action="/students/save" method="post" modelAttribute="student">
            <form:hidden path="id" />
            <!-- Add hidden field for points to preserve value when updating -->
            <form:hidden path="points" />
            <!-- Add hidden field for status to preserve value when updating -->
            <form:hidden path="status" />
            
            <div class="mb-3 row">
                <label for="studentId" class="col-sm-2 col-form-label">Student ID</label>
                <div class="col-sm-10">
                    <form:input path="studentId" class="form-control" required="true" />
                    <form:errors path="studentId" cssClass="text-danger" />
                </div>
            </div>
            
            <div class="mb-3 row">
                <label for="firstName" class="col-sm-2 col-form-label">First Name</label>
                <div class="col-sm-10">
                    <form:input path="firstName" class="form-control" required="true" />
                    <form:errors path="firstName" cssClass="text-danger" />
                </div>
            </div>
            
            <div class="mb-3 row">
                <label for="lastName" class="col-sm-2 col-form-label">Last Name</label>
                <div class="col-sm-10">
                    <form:input path="lastName" class="form-control" required="true" />
                    <form:errors path="lastName" cssClass="text-danger" />
                </div>
            </div>
            
            <div class="mb-3 row">
                <label for="email" class="col-sm-2 col-form-label">Email</label>
                <div class="col-sm-10">
                    <form:input path="email" type="email" class="form-control" required="true" />
                    <form:errors path="email" cssClass="text-danger" />
                </div>
            </div>
            
            <div class="mb-3 row">
                <label for="department" class="col-sm-2 col-form-label">Department</label>
                <div class="col-sm-10">
                    <form:select path="department" class="form-select">
                        <form:option value="" label="-- Select Department --" />
                        <form:option value="Computer Science" label="Computer Science" />
                        <form:option value="Engineering" label="Engineering" />
                        <form:option value="Business" label="Business" />
                        <form:option value="Arts" label="Arts" />
                        <form:option value="Science" label="Science" />
                    </form:select>
                    <form:errors path="department" cssClass="text-danger" />
                </div>
            </div>
            
            <div class="mb-3 row">
                <label for="year" class="col-sm-2 col-form-label">Year</label>
                <div class="col-sm-10">
                    <form:select path="year" class="form-select">
                        <form:option value="1" label="Year 1" />
                        <form:option value="2" label="Year 2" />
                        <form:option value="3" label="Year 3" />
                        <form:option value="4" label="Year 4" />
                    </form:select>
                    <form:errors path="year" cssClass="text-danger" />
                </div>
            </div>
            
            <!-- Add username field -->
            <div class="mb-3 row">
                <label for="username" class="col-sm-2 col-form-label">Username</label>
                <div class="col-sm-10">
                    <form:input path="username" class="form-control" required="true" />
                    <form:errors path="username" cssClass="text-danger" />
                </div>
            </div>
            
            <!-- Add password field -->
            <div class="mb-3 row">
                <label for="password" class="col-sm-2 col-form-label">Password</label>
                <div class="col-sm-10">
                    <form:input path="password" type="password" class="form-control" required="true" />
                    <form:errors path="password" cssClass="text-danger" />
                </div>
            </div>
            
            <div class="mb-3 row">
                <div class="col-sm-10 offset-sm-2">
                    <button type="submit" class="btn btn-primary">Save</button>
                    <a href="/students" class="btn btn-secondary">Cancel</a>
                </div>
            </div>
        </form:form>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>