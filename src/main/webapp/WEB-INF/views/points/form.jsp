<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>${point.id != null ? 'Edit' : 'Award'} Points</title>
</head>
<body>
    <jsp:include page="../layout/header.jsp" />
    
    <div class="container mt-4">
        <h2>${point.id != null ? 'Edit' : 'Award'} Points</h2>
        
        <form:form action="/points/save" method="post" modelAttribute="point" class="mt-3">
            <form:hidden path="id" />
            
            <div class="form-group">
                <label for="student">Student</label>
                <form:select path="student" class="form-control" required="true">
                    <form:option value="" label="-- Select Student --" />
                    <c:forEach var="studentOption" items="${studentList}">
                        <form:option value="${studentOption.id}" label="${studentOption.firstName} ${studentOption.lastName} (${studentOption.studentId})" />
                    </c:forEach>
                </form:select>
                <form:errors path="student" cssClass="text-danger" />
            </div>
            
            <div class="form-group">
                <label for="value">Point Value</label>
                <form:input path="value" type="number" class="form-control" required="true" min="1" />
                <form:errors path="value" cssClass="text-danger" />
            </div>
            
            <div class="form-group">
                <label for="reason">Reason</label>
                <form:textarea path="reason" class="form-control" rows="3" />
                <form:errors path="reason" cssClass="text-danger" />
            </div>
            
            <div class="form-group">
                <label for="reward">Associated Reward (Optional)</label>
                <form:select path="reward" class="form-control">
                    <form:option value="" label="-- Select Reward --" />
                    <c:forEach var="rewardOption" items="${rewardList}">
                        <form:option value="${rewardOption.id}" label="${rewardOption.name} (${rewardOption.pointValue} points)" />
                    </c:forEach>
                </form:select>
                <form:errors path="reward" cssClass="text-danger" />
            </div>
            
            <div class="form-group">
                <label for="issuedBy">Issued By</label>
                <form:select path="issuedBy" class="form-control" required="true">
                    <form:option value="" label="-- Select Staff --" />
                    <c:forEach var="staffMember" items="${staffList}">
                        <form:option value="${staffMember.id}" label="${staffMember.firstName} ${staffMember.lastName}" />
                    </c:forEach>
                </form:select>
                <form:errors path="issuedBy" cssClass="text-danger" />
            </div>
            
            <button type="submit" class="btn btn-primary">Save</button>
            <a href="/points" class="btn btn-secondary">Cancel</a>
        </form:form>
    </div>
    
    <jsp:include page="../layout/footer.jsp" />
</body>
</html>