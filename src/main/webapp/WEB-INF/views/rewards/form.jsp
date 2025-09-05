<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>${reward.id != null ? 'Edit' : 'Add'} Reward</title>
</head>
<body>
    <jsp:include page="../layout/header.jsp" />
    
    <div class="container mt-4">
        <h2>${reward.id != null ? 'Edit' : 'Add'} Reward</h2>
        
        <form:form action="/rewards/save" method="post" modelAttribute="reward" class="mt-3">
            <form:hidden path="id" />
            
            <div class="form-group">
                <label for="name">Name</label>
                <form:input path="name" class="form-control" required="true" />
                <form:errors path="name" cssClass="text-danger" />
            </div>
            
            <div class="form-group">
                <label for="description">Description</label>
                <form:textarea path="description" class="form-control" rows="3" />
                <form:errors path="description" cssClass="text-danger" />
            </div>
            
            <div class="form-group">
                <label for="pointValue">Point Value</label>
                <form:input path="pointValue" type="number" class="form-control" required="true" min="1" />
                <form:errors path="pointValue" cssClass="text-danger" />
            </div>
            
            <div class="form-group">
                <label for="issuedBy">Created By</label>
                <form:select path="issuedBy" class="form-control">
                    <form:option value="" label="-- Select Staff --" />
                    <c:forEach var="staffMember" items="${staffList}">
                        <form:option value="${staffMember.id}" label="${staffMember.firstName} ${staffMember.lastName}" />
                    </c:forEach>
                    <c:if test="${not empty adminList}">
                        <form:option value="-1" label="Admin" />
                    </c:if>
                </form:select>
                <form:errors path="issuedBy" cssClass="text-danger" />
            </div>
            
            <button type="submit" class="btn btn-primary">Save</button>
            <a href="/rewards" class="btn btn-secondary">Cancel</a>
        </form:form>
    </div>
    
    <jsp:include page="../layout/footer.jsp" />
</body>
</html>