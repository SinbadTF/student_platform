<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../layout/header.jsp" />

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="mb-0">${event.name}</h2>
        <div>
            <a href="${pageContext.request.contextPath}/events" class="btn btn-secondary ms-2">Back</a>
        </div>
    </div>

    <div class="row g-3">
        <div class="col-lg-8">
            <div class="card mb-3">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-8">
                            <h6 class="text-primary mb-3">Event Information</h6>
                            
                            <!-- Description -->
                            <div class="mb-3">
                                <label class="form-label fw-bold">Description:</label>
                                <p class="text-muted">
                                    <c:choose>
                                        <c:when test="${not empty event.description}">
                                            ${event.description}
                                        </c:when>
                                        <c:otherwise>
                                            <em>No description available</em>
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                            
                            <!-- Location -->
                            <div class="mb-3">
                                <label class="form-label fw-bold">Location:</label>
                                <p class="text-muted">
                                    <c:choose>
                                        <c:when test="${not empty event.location}">
                                            <i class="bi bi-geo-alt me-1"></i>${event.location}
                                        </c:when>
                                        <c:otherwise>
                                            <em>Not specified</em>
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                            
                            <!-- Points -->
                            <div class="mb-3">
                                <label class="form-label fw-bold">Points:</label>
                                <p class="text-muted">
                                    <span class="badge bg-success fs-6">
                                        <i class="bi bi-star-fill me-1"></i>${event.pointValue} points
                                    </span>
                                </p>
                            </div>
                        </div>
                        
                        <div class="col-md-4">
                            <h6 class="text-primary mb-3">Event Details</h6>
                            
                            <!-- Date -->
                            <div class="mb-3">
                                <label class="form-label fw-bold">Date:</label>
                                <p class="text-muted">
                                    <c:choose>
                                        <c:when test="${not empty event.startTime}">
                                            <i class="bi bi-calendar-event me-1"></i>
                                            ${event.startTime.toLocalDate()}
                                        </c:when>
                                        <c:otherwise>
                                            <em>Not specified</em>
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>

                            <!-- Time -->
                            <div class="mb-3">
                                <label class="form-label fw-bold">Time:</label>
                                <p class="text-muted">
                                    <c:choose>
                                        <c:when test="${not empty event.startTime && not empty event.endTime}">
                                            <i class="bi bi-clock me-1"></i>
                                            ${event.startTime.toLocalTime()} - ${event.endTime.toLocalTime()}
                                        </c:when>
                                        <c:otherwise>
                                            <em>Not specified</em>
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-footer d-flex justify-content-between align-items-center">
                    <div>
                        <c:choose>
                            <c:when test="${isJoinWindow}">
                                <span class="badge bg-success">Registration Open</span>
                            </c:when>
                            <c:when test="${hasEnded}">
                                <span class="badge bg-secondary">Event Ended</span>
                            </c:when>
                            <c:when test="${!hasStarted}">
                                <span class="badge bg-warning text-dark">Upcoming Event</span>
                            </c:when>
                        </c:choose>
                    </div>
                    <div>
                        <c:choose>
                            <c:when test="${isRegistered}">
                                <button type="button" class="btn btn-outline-success" disabled>
                                    <i class="bi bi-check-circle me-1"></i>Already Registered
                                </button>
                            </c:when>
                            <c:when test="${isJoinWindow}">
                                <form action="${pageContext.request.contextPath}/events/register/${event.id}" method="post" class="d-inline">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="bi bi-plus-circle me-1"></i>Join Event
                                    </button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <button type="button" class="btn btn-outline-secondary" disabled>
                                    <i class="bi bi-clock me-1"></i>
                                    <c:choose>
                                        <c:when test="${hasEnded}">Registration Closed</c:when>
                                        <c:otherwise>Registration Not Open Yet</c:otherwise>
                                    </c:choose>
                                </button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>