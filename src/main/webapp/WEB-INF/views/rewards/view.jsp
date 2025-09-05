<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Reward</title>
</head>
<body>
    <jsp:include page="../layout/header.jsp" />
    
    <div class="container mt-4">
        <div class="row mb-3">
            <div class="col-md-8">
                <h2>Reward Details</h2>
            </div>
            <div class="col-md-4 text-right">
                <a href="/rewards" class="btn btn-secondary">Back to List</a>
                <a href="/rewards/edit/${reward.id}" class="btn btn-warning">Edit</a>
            </div>
        </div>
        
        <div class="card">
            <div class="card-header bg-info text-white">
                <h4>${reward.name}</h4>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <p><strong>ID:</strong> ${reward.id}</p>
                        <p><strong>Name:</strong> ${reward.name}</p>
                        <p><strong>Description:</strong> ${reward.description}</p>
                    </div>
                    <div class="col-md-6">
                        <p><strong>Point Value:</strong> ${reward.pointValue}</p>
                        <p><strong>Issued By:</strong> 
                            <c:if test="${reward.issuedBy != null}">
                                <a href="/staff/view/${reward.issuedBy.id}">${reward.issuedBy.firstName} ${reward.issuedBy.lastName}</a>
                            </c:if>
                        </p>
                    </div>
                </div>
            </div>
        </div>
        
    </div>
    
    <jsp:include page="../layout/footer.jsp" />
</body>
</html>