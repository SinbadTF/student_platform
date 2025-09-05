<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${event.id == null ? 'Create New Event' : 'Edit Event'} - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link href="<c:url value='/static/css/main.css' />" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
</head>
<body>
    <jsp:include page="../layout/header.jsp" />
    
    <div class="container mt-4">
        <div class="card">
            <div class="card-header bg-warning text-dark">
                <h2><i class="bi bi-calendar-event"></i> ${event.id == null ? 'Create New Event' : 'Edit Event'}</h2>
            </div>
            <div class="card-body">
                <form:form action="/admin/events/save" method="post" modelAttribute="event" id="eventForm">
                    <form:hidden path="id" />
                    
                    <div class="mb-3">
                        <label for="name" class="form-label">Event Name</label>
                        <form:input path="name" class="form-control" required="true" />
                        <form:errors path="name" cssClass="text-danger" />
                    </div>
                    
                    <div class="mb-3">
                        <label for="description" class="form-label">Description</label>
                        <form:textarea path="description" class="form-control" rows="4" required="true" />
                        <form:errors path="description" cssClass="text-danger" />
                    </div>
                    
                    <div class="mb-3">
                        <label for="location" class="form-label">Location</label>
                        <form:input path="location" class="form-control" required="true" />
                        <form:errors path="location" cssClass="text-danger" />
                    </div>
                    
                    <!-- Date and Time (mirror activity-form.jsp) -->
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label for="eventDate" class="form-label">Event Date *</label>
                            <input type="date" class="form-control" id="eventDate" name="eventDate"
                                   value="${event.startTime != null ? event.startTime.toLocalDate() : ''}" required>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="startTimeOnly" class="form-label">Start Time *</label>
                            <input type="time" class="form-control" id="startTimeOnly" name="startTimeOnly"
                                   value="${event.startTime != null ? event.startTime.toLocalTime() : ''}" required>
                            <form:errors path="startTime" cssClass="text-danger small" />
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="endTimeOnly" class="form-label">End Time *</label>
                            <input type="time" class="form-control" id="endTimeOnly" name="endTimeOnly"
                                   value="${event.endTime != null ? event.endTime.toLocalTime() : ''}" required>
                            <form:errors path="endTime" cssClass="text-danger small" />
                        </div>
                    </div>
                    
                    <!-- Hidden fields to bind to LocalDateTime -->
                    <form:hidden path="startTime" id="startTime" />
                    <form:hidden path="endTime" id="endTime" />
                    
                    <div class="mb-3">
                        <label for="pointValue" class="form-label">Point Value</label>
                        <form:input path="pointValue" type="number" class="form-control" required="true" min="0" />
                        <form:errors path="pointValue" cssClass="text-danger" />
                        <small class="text-muted">Points awarded to students for participating in this event</small>
                    </div>
                    
                    <form:hidden path="createdBy.id" value="${sessionScope.user.id}" />
                    
                    <div class="mt-4">
                        <button type="submit" class="btn btn-warning">Save Event</button>
                        <a href="/admin/events" class="btn btn-secondary ms-2">Cancel</a>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
    
    <jsp:include page="../layout/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('eventForm').addEventListener('submit', function(e) {
            var name = document.querySelector('[name="name"]').value.trim();
            var location = document.querySelector('[name="location"]').value.trim();
            var pointValue = document.querySelector('[name="pointValue"]').value;
            var eventDate = document.getElementById('eventDate').value;
            var startTime = document.getElementById('startTimeOnly').value;
            var endTime = document.getElementById('endTimeOnly').value;
            
            if (name === '') {
                e.preventDefault();
                alert('Please enter an event name');
                return false;
            }
            if (location === '') {
                e.preventDefault();
                alert('Please enter a location');
                return false;
            }
            if (pointValue === '' || pointValue < 0) {
                e.preventDefault();
                alert('Please enter valid points (0 or greater)');
                return false;
            }
            if (eventDate === '') {
                e.preventDefault();
                alert('Please select an event date');
                return false;
            }
            if (startTime === '') {
                e.preventDefault();
                alert('Please select a start time');
                return false;
            }
            if (endTime === '') {
                e.preventDefault();
                alert('Please select an end time');
                return false;
            }
            if (startTime >= endTime) {
                e.preventDefault();
                alert('End time must be after start time');
                return false;
            }
            // Combine for backend binding (yyyy-MM-dd HH:mm)
            document.getElementById('startTime').value = eventDate + ' ' + startTime.substring(0,5);
            document.getElementById('endTime').value = eventDate + ' ' + endTime.substring(0,5);
            return true;
        });
    </script>
</body>
</html>