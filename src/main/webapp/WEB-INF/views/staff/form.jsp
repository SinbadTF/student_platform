<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<jsp:include page="../layout/header.jsp" />

<div class="container mt-4">
    <div class="card">
        <div class="card-header">
            <h2>${staff.id == null ? 'Add New Staff' : 'Edit Staff'}</h2>
        </div>
        <div class="card-body">
            <form:form action="/staff/save" method="post" modelAttribute="staff">
                <form:hidden path="id" />
                
                <div class="mb-3">
                    <label for="staffId" class="form-label">Staff ID</label>
                    <form:input path="staffId" class="form-control" required="true" />
                    <form:errors path="staffId" cssClass="text-danger" />
                </div>
                
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="firstName" class="form-label">First Name</label>
                        <form:input path="firstName" class="form-control" required="true" />
                        <form:errors path="firstName" cssClass="text-danger" />
                    </div>
                    <div class="col-md-6">
                        <label for="lastName" class="form-label">Last Name</label>
                        <form:input path="lastName" class="form-control" required="true" />
                        <form:errors path="lastName" cssClass="text-danger" />
                    </div>
                </div>
                
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <form:input path="email" type="email" class="form-control" required="true" />
                    <form:errors path="email" cssClass="text-danger" />
                </div>
                
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="department" class="form-label">Department</label>
                        <form:select path="department" class="form-select">
                            <form:option value="" label="-- Select Department --" />
                            <form:option value="Computer Science" label="Computer Science" />
                            <form:option value="Engineering" label="Engineering" />
                            <form:option value="Business" label="Business" />
                            <form:option value="Arts" label="Arts" />
                            <form:option value="Science" label="Science" />
                            <form:option value="Administration" label="Administration" />
                        </form:select>
                    </div>
                    <div class="col-md-6">
                        <label for="position" class="form-label">Position</label>
                        <form:select path="position" class="form-select">
                            <form:option value="" label="-- Select Position --" />
                            <form:option value="Professor" label="Professor" />
                            <form:option value="Associate Professor" label="Associate Professor" />
                            <form:option value="Assistant Professor" label="Assistant Professor" />
                            <form:option value="Lecturer" label="Lecturer" />
                            <form:option value="Administrator" label="Administrator" />
                            <form:option value="Staff" label="Staff" />
                        </form:select>
                    </div>
                </div>
                
                <div class="d-flex justify-content-between mt-4">
                    <a href="/staff" class="btn btn-secondary">Cancel</a>
                    <button type="submit" class="btn btn-primary">Save</button>
                </div>
            </form:form>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp" />