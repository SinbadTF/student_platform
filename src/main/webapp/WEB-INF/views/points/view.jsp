<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Point Record</title>
</head>
<body>
    <jsp:include page="../layout/header.jsp" />
    
    <div class="container mt-4">
        <div class="row mb-3">
            <div class="col-md-8">
                <h2>Point Record Details</h2>
            </div>
            <div class="col-md-4 text-right">
                <a href="/points" class="btn btn-secondary">Back to List</a>
                <a href="/points/edit/${point.id}" class="btn btn-warning">Edit</a>
            </div>
        </div>
        
        <div class="card">
            <div class="card-header bg-info text-white">
                <h4>Point Record #${point.id}</h4>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <p><strong>ID:</strong> ${point.id}</p>
                        <p><strong>Student:</strong> 
                            <a href="/students/view/${point.student.id}">${point.student.firstName} ${point.student.lastName}</a>
                        </p>
                        <p><strong>Point Value:</strong> ${point.value}</p>
                        <p><strong>Reason:</strong> ${point.reason}</p>
                    </div>
                    <div class="col-md-6">
                        <p><strong>Reward:</strong> 
                            <c:if test="${point.reward != null}">
                                <a href="/rewards/view/${point.reward.id}">${point.reward.name}</a>
                            </c:if>
                            <c:if test="${point.reward == null}">
                                N/A
                            </c:if>
                        </p>
                        <p><strong>Issued By:</strong> 
                            <c:if test="${point.issuedBy != null}">
                                <a href="/staff/view/${point.issuedBy.id}">${point.issuedBy.firstName} ${point.issuedBy.lastName}</a>
                            </c:if>
                        </p>
                        <p><strong>Issued At:</strong> <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${point.issuedAt}" /></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="../layout/footer.jsp" />
</body>
</html>