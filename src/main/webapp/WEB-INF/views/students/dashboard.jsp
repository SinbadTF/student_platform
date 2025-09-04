<%@ include file="../layout/student_header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!-- Modern Student Dashboard -->
<div class="container py-4">
    <!-- Welcome Banner -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card bg-primary text-white shadow-lg rounded-3 border-0" style="opacity: 0.8;">
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

    <!-- Quick Stats -->
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

    <!-- Main Features -->
    <div class="row mb-4">
        <!-- Points History with Chart -->
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

        <!-- Quick Actions and Features -->
        <div class="col-md-4">
            <!-- Lucky Spin -->
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

            <!-- Upcoming Events -->
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
                                        <small class="text-muted"><i class="bi bi-calendar me-1"></i> ${event.startTime.toLocalDate()}</small>
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

    <!-- Clubs and Activities - Improved to fill space better -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-header bg-white border-0 py-3">
                    <div class="d-flex justify-content-between align-items-center">
                        <h5 class="mb-0"><i class="bi bi-people text-info me-2"></i>Clubs & Activities</h5>
                        <div>
                            <a href="/students/activities" class="btn btn-sm btn-info text-white me-2">View Activities</a>
                            <a href="/students/clubs" class="btn btn-sm btn-outline-info">View All Clubs</a>
                        </div>
                    </div>
                </div>
                <div class="card-body p-4">
                    <div class="row">
                        <c:choose>
                            <c:when test="${not empty studentMemberships}">
                                <c:forEach items="${studentMemberships}" var="membership">
                                    <div class="col-md-6 mb-4">
                                        <div class="card border-0 shadow-sm h-100">
                                            <div class="card-header bg-info bg-opacity-10 py-3">
                                                <h5 class="mb-0 text-info">${membership.club.name}</h5>
                                            </div>
                                            <div class="card-body">
                                                <c:choose>
                                                    <c:when test="${not empty clubActivities[membership.club]}">
                                                        <div class="list-group">
                                                            <c:forEach items="${clubActivities[membership.club]}" var="activity">
                                                                <div class="list-group-item list-group-item-action d-flex align-items-center p-3 border-0 mb-2 bg-light rounded">
                                                                    <div class="flex-grow-1">
                                                                        <div class="d-flex w-100 justify-content-between">
                                                                            <h6 class="mb-1 fw-bold">${activity.title}</h6>
                                                                            <span class="badge bg-success rounded-pill">${activity.points} points</span>
                                                                        </div>
                                                                        <p class="mb-1 text-muted small">${activity.description}</p>
                                                                    </div>
                                                                    <form action="/students/activities/join/${activity.id}" method="post" class="ms-2" style="display:inline;">
                                                                        <button type="submit" class="btn btn-sm btn-outline-info">Join</button>
                                                                    </form>
                                                                </div>
                                                            </c:forEach>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="text-center py-4">
                                                            <i class="bi bi-calendar-x text-muted" style="font-size: 2rem;"></i>
                                                            <p class="mt-3">No activities available for this club</p>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="col-12 text-center py-5">
                                    <i class="bi bi-people text-muted" style="font-size: 3rem;"></i>
                                    <h5 class="mt-3">You haven't joined any clubs yet</h5>
                                    <p class="text-muted">Join clubs to participate in activities and earn points</p>
                                    <a href="/students/clubs" class="btn btn-primary mt-2">Browse Clubs</a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Available Rewards Section -->
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
                        <c:forEach items="${availableRewards}" var="reward" end="3">
                            <div class="col-md-3">
                                <div class="card h-100 border-0 shadow-sm">
                                    <div class="card-body text-center">
                                        <div class="bg-success bg-opacity-10 rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                                            <i class="bi bi-gift text-success" style="font-size: 1.5rem;"></i>
                                        </div>
                                        <h5 class="card-title">${reward.name}</h5>
                                        <p class="card-text small">${reward.description}</p>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <span class="badge bg-primary">${reward.pointValue} points</span>
                                            <form action="/students/rewards/exchange/${reward.id}" method="post" style="display:inline;">
                                                <button type="submit" class="btn btn-sm btn-outline-success">Redeem</button>
                                            </form> 
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
</div> <!-- This closes the main container -->

<!-- Chart.js for data visualization -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    // Use actual data from backend for points chart
    const ctx = document.getElementById('pointsChart').getContext('2d');
    const pointsChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: <c:out value="${pointsChartLabels}" escapeXml="false"/>,
            datasets: [{
                label: 'Points Earned',
                data: <c:out value="${pointsChartData}" escapeXml="false"/>,
                backgroundColor: 'rgba(13, 110, 253, 0.2)',
                borderColor: 'rgba(13, 110, 253, 1)',
                borderWidth: 2,
                tension: 0.3,
                fill: true
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    display: false
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            return context.parsed.y + ' points';
                        }
                    }
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: 'Points'
                    }
                }
            }
        }
    });
</script>

<%@ include file="../layout/footer.jsp" %>



