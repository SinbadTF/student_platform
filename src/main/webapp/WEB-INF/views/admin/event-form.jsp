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
                <form:form action="/admin/events/save" method="post" modelAttribute="event">
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
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="startTime" class="form-label">Start Time</label>
                            <form:input path="startTime" id="startTime" class="form-control datetime-picker" required="true" />
                            <form:errors path="startTime" cssClass="text-danger" />
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <label for="endTime" class="form-label">End Time</label>
                            <form:input path="endTime" id="endTime" class="form-control datetime-picker" required="true" />
                            <form:errors path="endTime" cssClass="text-danger" />
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="pointValue" class="form-label">Point Value</label>
                        <form:input path="pointValue" type="number" class="form-control" required="true" min="0" />
                        <form:errors path="pointValue" cssClass="text-danger" />
                        <small class="text-muted">Points awarded to students for participating in this event</small>
                    </div>
                    
                    <form:hidden path="createdBy" value="${sessionScope.user.id}" />
                    
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
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const startPicker = flatpickr("#startTime", {
                enableTime: true,
                dateFormat: "Y-m-d H:i",
                time_24hr: true,
                minDate: new Date(),
                onChange: function(selectedDates) {
                    if (selectedDates && selectedDates.length) {
                        endPicker.set('minDate', selectedDates[0]);
                    }
                }
            });
            const endPicker = flatpickr("#endTime", {
                enableTime: true,
                dateFormat: "Y-m-d H:i",
                time_24hr: true,
                minDate: new Date()
            });

            const form = document.querySelector('form');
            form.addEventListener('submit', function(e) {
                const start = startPicker.selectedDates[0];
                const end = endPicker.selectedDates[0];
                if (!start || !end || end < start) {
                    e.preventDefault();
                    alert('End time must be after the start time.');
                }
            });
        });
    </script>
</body>
</html>