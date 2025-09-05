<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/student_header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2><i class="bi bi-person-circle"></i> My Profile</h2>
        <button class="btn btn-primary" type="button" data-bs-toggle="collapse" data-bs-target="#editProfileForm" aria-expanded="false" aria-controls="editProfileForm">
            <i class="bi bi-pencil"></i> Edit Profile
        </button>
    </div>
    
    <!-- Alert Messages -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle-fill"></i> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle-fill"></i> ${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Edit Profile Form -->
    <div class="collapse mb-4" id="editProfileForm">
        <div class="card shadow-sm">
            <div class="card-header bg-primary text-white">
                <h5><i class="bi bi-pencil-square"></i> Edit Profile</h5>
            </div>
            <div class="card-body">
                <form action="/students/profile/update" method="post">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="firstName" class="form-label">First Name</label>
                                <input type="text" class="form-control" id="firstName" name="firstName" value="${student.firstName}" required>
                            </div>
                            <div class="mb-3">
                                <label for="lastName" class="form-label">Last Name</label>
                                <input type="text" class="form-control" id="lastName" name="lastName" value="${student.lastName}" required>
                            </div>
                            <div class="mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" name="email" value="${student.email}" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="department" class="form-label">Department</label>
                                <input type="text" class="form-control" id="department" name="department" value="${student.department}" required>
                            </div>
                            <div class="mb-3">
                                <label for="year" class="form-label">Year</label>
                                <input type="number" class="form-control" id="year" name="year" value="${student.year}" min="1" max="6" required>
                            </div>
                        </div>
                    </div>
                    
                    <hr class="my-4">
                    <h5>Change Password (Optional)</h5>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="currentPassword" class="form-label">Current Password</label>
                                <input type="password" class="form-control" id="currentPassword" name="currentPassword">
                                <div class="form-text">Leave blank if you don't want to change your password</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="newPassword" class="form-label">New Password</label>
                                <input type="password" class="form-control" id="newPassword" name="newPassword">
                                <div class="form-text">Password must be at least 6 characters</div>
                            </div>
                            <div class="mb-3">
                                <label for="confirmPassword" class="form-label">Confirm New Password</label>
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword">
                            </div>
                        </div>
                    </div>
                    
                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                        <button type="button" class="btn btn-secondary" data-bs-toggle="collapse" data-bs-target="#editProfileForm">Cancel</button>
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-6">
            <div class="card mb-4 shadow-sm">
                <div class="card-header bg-primary text-white">
                    <h5><i class="bi bi-info-circle"></i> Personal Information</h5>
                </div>
                <div class="card-body">
                    <table class="table">
                        <tr>
                            <th style="width: 30%">Student ID:</th>
                            <td>${student.studentId}</td>
                        </tr>
                        <tr>
                            <th>Name:</th>
                            <td>${student.firstName} ${student.lastName}</td>
                        </tr>
                        <tr>
                            <th>Email:</th>
                            <td>${student.email}</td>
                        </tr>
                        <tr>
                            <th>Department:</th>
                            <td>${student.department}</td>
                        </tr>
                        <tr>
                            <th>Year:</th>
                            <td>${student.year}</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        
        <div class="col-md-6">
            <div class="card mb-4 shadow-sm">
                <div class="card-header bg-primary text-white">
                    <h5><i class="bi bi-star-fill"></i> Points Summary</h5>
                </div>
                <div class="card-body">
                    <div class="text-center">
                        <h3 class="display-4">${student.points}</h3>
                        <p class="text-muted">Total Points</p>
                    </div>
                </div>
            </div>
            
            <div class="card mb-4 shadow-sm">
                <div class="card-header bg-primary text-white">
                    <h5><i class="bi bi-activity"></i> Account Status</h5>
                </div>
                <div class="card-body">
                    <div class="text-center">
                        <h5 class="mb-3">
                            <span class="badge ${student.status == 'APPROVED' ? 'bg-success' : 'bg-warning'}">
                                ${student.status}
                            </span>
                        </h5>
                        <p class="text-muted">Your account is currently ${student.status == 'APPROVED' ? 'active and in good standing' : 'pending approval'}</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>