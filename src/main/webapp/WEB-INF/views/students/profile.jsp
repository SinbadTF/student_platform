<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/student_header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2><i class="bi bi-person-circle"></i> My Profile</h2>
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