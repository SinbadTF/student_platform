<%@ include file="../layout/student_header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<div class="container py-4">
    <div class="row mb-4">
        <div class="col-12">
            <div class="card bg-primary text-white shadow-lg rounded-3 border-0">
                <div class="card-body p-4">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h2 class="display-6 fw-bold">Welcome, ${student.firstName}!</h2>
                            <p class="lead mb-0">Student ID: ${student.studentId} | Department: ${student.department}</p>
                        </div>
                        <div class="text-center">
                            <div class="bg-white rounded-circle p-3 d-inline-block">
                                <i class="bi bi-person-circle text-primary" style="font-size: 3rem;"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row mb-4">
        <div class="col-md-3">
            <div class="card border-0 shadow-sm rounded-3 h-100">
                <div class="card-body text-center">
                    <div class="bg-light rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
                        <i class="bi bi-star-fill text-warning" style="font-size: 2rem;"></i>
                    </div>
                    <h5 class="card-title">Total Points</h5>
                    <h2 class="display-6 fw-bold text-primary">${student.points}</h2>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card border-0 shadow-sm rounded-3 h-100">
                <div class="card-body text-center">
                    <div class="bg-light rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
                        <i class="bi bi-award-fill text-success" style="font-size: 2rem;"></i>
                    </div>
                    <h5 class="card-title">Rewards Earned</h5>
                    <h2 class="display-6 fw-bold text-success">${rewardsCount}</h2>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card border-0 shadow-sm rounded-3 h-100">
                <div class="card-body text-center">
                    <div class="bg-light rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
                        <i class="bi bi-people-fill text-info" style="font-size: 2rem;"></i>
                    </div>
                    <h5 class="card-title">Club Participation</h5>
                    <h2 class="display-6 fw-bold text-info">${clubsCount}</h2>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card border-0 shadow-sm rounded-3 h-100">
                <div class="card-body text-center">
                    <div class="bg-light rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
                        <i class="bi bi-calendar-event-fill text-danger" style="font-size: 2rem;"></i>
                    </div>
                    <h5 class="card-title">Events Attended</h5>
                    <h2 class="display-6 fw-bold text-danger">${eventsCount}</h2>
                </div>
            </div>
        </div>
    </div>

    <div class="row mb-4">
        <div class="col-md-8">
            <div class="card border-0 shadow-sm rounded-3 mb-4">
                <div class="card-header bg-white border-0 py-3">
                    <div class="d-flex justify-content-between align-items-center">
                        <h5 class="mb-0"><i class="bi bi-graph-up text-primary me-2"></i> Points Summary</h5>
                    </div>
                </div>
                <div class="card-body">
                    <canvas id="pointsChart" width="400" height="200"></canvas>
                    <div class="text-center mt-4">
                        <h5>Current Points: ${student.points}</h5>
                        <p class="text-muted">Keep participating in activities to earn more points!</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card border-0 shadow-sm rounded-3 mb-4">
                <div class="card-body text-center p-4">
                    <div class="bg-warning bg-opacity-25 rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 100px; height: 100px;">
                        <i class="bi bi-arrow-repeat text-warning" style="font-size: 3rem;"></i>
                    </div>
                    <h5 class="card-title">Lucky Spin</h5>
                    <p class="card-text">Try your luck and win rewards!</p>
                    <a href="/students/lucky-spin" class="btn btn-warning text-white">Spin Now</a>
                </div>
            </div>

            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-header bg-white border-0 py-3">
                    <h5 class="mb-0"><i class="bi bi-calendar-event text-danger me-2"></i> Upcoming Events</h5>
                </div>
                <div class="card-body">
                    <ul class="list-group list-group-flush">
                        <c:forEach items="${upcomingEvents}" var="event" end="2">
                            <li class="list-group-item px-0 py-3 border-bottom">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="mb-1">${event.name}</h6>
                                        <small class="text-muted"><i class="bi bi-calendar me-1"></i> <fmt:formatDate pattern="MMM dd, yyyy" value="${event.date}" /></small>
                                    </div>
                                    <a href="/events/participate/${event.id}" class="btn btn-sm btn-outline-primary">Join</a>
                                </div>
                            </li>
                        </c:forEach>
                        <c:if test="${empty upcomingEvents}">
                            <li class="list-group-item px-0 py-3 text-center">
                                No upcoming events
                            </li>
                        </c:if>
                    </ul>
                    <div class="text-center mt-3">
                        <a href="/events" class="btn btn-sm btn-outline-secondary">View All Events</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-12">
            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-header bg-white border-0 py-3">
                    <div class="d-flex justify-content-between align-items-center">
                        <h5 class="mb-0"><i class="bi bi-people text-info me-2"></i> Clubs & Activities</h5>
                        <a href="/clubs" class="btn btn-sm btn-outline-info">View All</a>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row">
                        <c:forEach items="${clubs}" var="club" end="3">
                            <div class="col-md-3">
                                <div class="card h-100 border-0 shadow-sm">
                                    <div class="card-body text-center">
                                        <div class="bg-info bg-opacity-10 rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                                            <i class="bi ${club.icon} text-info" style="font-size: 1.5rem;"></i>
                                        </div>
                                        <h5 class="card-title">${club.name}</h5>
                                        <p class="card-text small">${club.description}</p>
                                        <c:choose>
                                            <c:when test="${club.joined}">
                                                <span class="badge bg-success">Joined</span>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="/clubs/join/${club.id}" class="btn btn-sm btn-outline-info">Join Club</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        <c:if test="${empty clubs}">
                            <div class="col-12 text-center py-4">
                                <p>No clubs available at the moment</p>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row mt-4">
        <div class="col-12">
            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-header bg-white border-0 py-3">
                    <div class="d-flex justify-content-between align-items-center">
                        <h5 class="mb-0"><i class="bi bi-gift text-success me-2"></i> Available Rewards</h5>
                        <a href="/students/rewards/catalog" class="btn btn-sm btn-outline-success">View All Rewards</a>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row">
                        <c:forEach items="${availableRewards}" var="reward" varStatus="status">
                            <div class="col-md-4 mb-4">
                                <div class="card h-100 border-0 shadow-sm">
                                    <div class="card-body text-center">
                                        <div class="bg-success bg-opacity-10 rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                                            <i class="bi bi-gift text-success" style="font-size: 1.5rem;"></i>
                                        </div>
                                        <h5 class="card-title">${reward.name}</h5>
                                        <p class="card-text small">${reward.description}</p>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <span class="badge bg-primary">${reward.pointValue} points</span>
                                            <button type="button" class="btn btn-sm btn-outline-success" data-bs-toggle="modal" data-bs-target="#confirmRedeemModal${reward.id}">Redeem</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        <c:if test="${empty availableRewards}">
                            <div class="col-12 text-center py-4">
                                <p>No rewards available for your current points (${student.points})</p>
                                <a href="/students/rewards/catalog" class="btn btn-sm btn-outline-primary">View All Rewards</a>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div> <c:forEach items="${availableRewards}" var="reward" varStatus="status">
    <div class="modal fade" id="confirmRedeemModal${reward.id}" tabindex="-1" aria-labelledby="confirmRedeemModalLabel${reward.id}" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirmRedeemModalLabel${reward.id}">Confirm Redemption</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to redeem <strong>${reward.name}</strong>?</p>
                    <p>This will cost <strong>${reward.pointValue} points</strong>.</p>
                    <p>Your current points: <strong>${student.points}</strong></p>
                    <p>Points after redemption: <strong>${student.points - reward.pointValue}</strong></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <form action="/students/rewards/exchange/${reward.id}" method="post" style="display:inline;">
                        <button type="submit" class="btn btn-success">Confirm Redemption</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</c:forEach>

<%@ include file="../layout/footer.jsp" %>