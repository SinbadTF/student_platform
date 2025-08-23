<%@ include file="../layout/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2>Student Details</h2>
    <div>
        <a href="/students/dashboard/${student.id}" class="btn btn-primary me-2">View Dashboard</a>
        <a href="/students/edit/${student.id}" class="btn btn-warning me-2">Edit</a>
        <a href="/students" class="btn btn-secondary">Back to List</a>
    </div>
</div>

<div class="row">
    <div class="col-md-6">
        <div class="card mb-4">
            <div class="card-header">
                <h5>Personal Information</h5>
            </div>
            <div class="card-body">
                <table class="table">
                    <tr>
                        <th style="width: 30%">ID:</th>
                        <td>${student.id}</td>
                    </tr>
                    <tr>
                        <th>Student ID:</th>
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
        <div class="card mb-4">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5>Points History</h5>
                <a href="/points/award/${student.id}" class="btn btn-sm btn-primary">Award Points</a>
            </div>
            <div class="card-body">
                <c:if test="${not empty student.points}">
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Date</th>
                                    <th>Reward</th>
                                    <th>Points</th>
                                    <th>Issued By</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${student.points}" var="point">
                                    <tr>
                                        <td><fmt:formatDate pattern="yyyy-MM-dd" value="${point.issuedAt}" /></td>
                                        <td>${point.reward.name}</td>
                                        <td>${point.reward.pointValue}</td>
                                        <td>${point.issuedBy.firstName} ${point.issuedBy.lastName}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>
                <c:if test="${empty student.points}">
                    <p class="text-center">No points history available</p>
                </c:if>
            </div>
        </div>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>