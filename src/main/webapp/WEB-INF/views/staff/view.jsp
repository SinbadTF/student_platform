<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="../layout/header.jsp" />

<div class="container mt-4">
    <div class="card mb-4">
        <div class="card-header">
            <div class="d-flex justify-content-between align-items-center">
                <h2>Staff Details</h2>
                <div>
                    <a href="/staff" class="btn btn-secondary me-2">Back to List</a>
                    <a href="/staff/edit/${staff.id}" class="btn btn-warning">Edit</a>
                </div>
            </div>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <h4>Personal Information</h4>
                    <table class="table">
                        <tr>
                            <th style="width: 30%">Staff ID:</th>
                            <td>${staff.staffId}</td>
                        </tr>
                        <tr>
                            <th>Name:</th>
                            <td>${staff.firstName} ${staff.lastName}</td>
                        </tr>
                        <tr>
                            <th>Email:</th>
                            <td>${staff.email}</td>
                        </tr>
                    </table>
                </div>
                <div class="col-md-6">
                    <h4>Professional Information</h4>
                    <table class="table">
                        <tr>
                            <th style="width: 30%">Department:</th>
                            <td>${staff.department}</td>
                        </tr>
                        <tr>
                            <th>Position:</th>
                            <td>${staff.position}</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <div class="card">
        <div class="card-header">
            <h4>Rewards Issued</h4>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Reward ID</th>
                            <th>Student</th>
                            <th>Points</th>
                            <th>Reason</th>
                            <th>Date Issued</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${staff.rewardsIssued}" var="reward">
                            <tr>
                                <td>${reward.id}</td>
                                <td>${reward.student.firstName} ${reward.student.lastName}</td>
                                <td>${reward.points}</td>
                                <td>${reward.reason}</td>
                                <td><fmt:formatDate value="${reward.dateIssued}" pattern="yyyy-MM-dd" /></td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty staff.rewardsIssued}">
                            <tr>
                                <td colspan="5" class="text-center">No rewards issued yet</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp" />