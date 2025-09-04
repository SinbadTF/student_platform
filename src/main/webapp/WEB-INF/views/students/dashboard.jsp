<%@ include file="../layout/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Modern Student Dashboard -->
<div class="container py-4">
    <!-- Welcome Banner -->
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
            <div class="card border-0 shadow-lg rounded-3 mb-4 overflow-hidden spinwheel-card">
                <div class="card-header bg-gradient text-white border-0 py-3" 
                     style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                    <div class="d-flex align-items-center">
                        <div class="bg-white bg-opacity-25 rounded-circle p-2 me-3 spin-icon">
                            <i class="bi bi-arrow-repeat text-white" style="font-size: 1.5rem;"></i>
                        </div>
                        <h5 class="mb-0">🎯 Lucky Spin</h5>
                    </div>
                </div>
                <div class="card-body text-center p-4">
                    <!-- Animated Spinwheel Icon -->
                    <div class="spinwheel-icon-container mb-4">
                        <div class="bg-gradient rounded-circle mx-auto d-flex align-items-center justify-content-center shadow-lg spinwheel-main-icon" 
                             style="width: 120px; height: 120px; background: linear-gradient(135deg, #ff6b6b 0%, #feca57 100%);">
                            <i class="bi bi-arrow-repeat text-white spin-icon-large"></i>
                        </div>
                        <div class="spinwheel-glow"></div>
                    </div>
                    
                    <h5 class="card-title fw-bold text-primary mb-2">Daily Rewards</h5>
                    <p class="card-text text-muted mb-4">Try your luck and win exciting points daily!</p>
                    
                    <c:choose>
                        <c:when test="${hasSpunToday}">
                            <div class="alert alert-info mb-4 border-0 spin-alert">
                                <div class="d-flex align-items-center">
                                    <div class="alert-icon me-3">
                                        <i class="bi bi-info-circle text-info"></i>
                                    </div>
                                    <div class="text-start">
                                        <strong>Already Spun Today!</strong><br>
                                        <small>Come back tomorrow for another chance to win.</small>
                                    </div>
                                </div>
                            </div>
                            <button class="btn btn-secondary btn-lg px-4 py-2" disabled>
                                <i class="bi bi-clock me-2"></i>Already Spun Today
                            </button>
                        </c:when>
                        <c:otherwise>
                            <c:choose>
                                <c:when test="${selectedSpinWheel != null}">
                                    <a href="/students/spinwheel/${selectedSpinWheel.id}" class="btn btn-gradient btn-lg px-5 py-3 shadow-lg spin-button">
                                        <i class="bi bi-arrow-repeat me-2"></i>Spin Now!
                                        <div class="button-shine"></div>
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn btn-secondary btn-lg px-4 py-2" disabled>
                                        <i class="bi bi-slash-circle me-2"></i>Spin Unavailable
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </c:otherwise>
                    </c:choose>
                    
                    <!-- Show a compact spinwheel UI even if spinning is unavailable -->
                    <div class="mt-4 pt-4 border-top">
                        <h6 class="text-muted mb-3 fw-semibold">📊 Today's Wheel Preview</h6>
                        <div class="row align-items-start g-3">
                            <div class="col-12 col-sm-6 d-flex justify-content-center position-relative">
                                <canvas id="miniSpinwheel" width="220" height="220"></canvas>
                                <c:if test="${hasSpunToday}">
                                    <div class="position-absolute d-flex align-items-center justify-content-center"
                                         style="inset: 0; background: rgba(255,255,255,0.6); border-radius: 8px;">
                                        <span class="badge bg-secondary">Spin available tomorrow</span>
                                    </div>
                                </c:if>
                            </div>
                            <div class="col-12 col-sm-6">
                                <div class="card border-0 shadow-sm">
                                    <div class="card-header bg-white border-0 py-2">
                                        <strong>Cycle Items</strong>
                                    </div>
                                    <div class="card-body p-2">
                                        <c:choose>
                                            <c:when test="${not empty selectedSpinWheelItems}">
                                                <ul class="list-group list-group-flush small">
                                                    <c:forEach var="it" items="${selectedSpinWheelItems}" end="7">
                                                        <li class="list-group-item d-flex justify-content-between align-items-center">
                                                            <div class="d-flex align-items-center">
                                                                <span class="me-2 rounded-circle" style="display:inline-block;width:14px;height:14px;background:#007bff;"></span>
                                                                <span class="fw-semibold"><c:out value='${it.label}'/></span>
                                                            </div>
                                                            <div>
                                                                <span class="badge bg-primary me-1">${it.pointValue} pts</span>
                                                                <span class="badge bg-light text-muted">w:${it.probabilityWeight}</span>
                                                            </div>
                                                        </li>
                                                    </c:forEach>
                                                </ul>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="text-muted">No items configured yet.</div>
                                            </c:otherwise>
                                        </c:choose>
                                        <div class="mt-2 text-end">
                                            <a href="/students/spinwheel" class="btn btn-sm btn-outline-primary">Open Spinwheel</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="mini-spin-data" style="display:none;">
                            <c:forEach var="item" items="${selectedSpinWheelItems}" end="7">
                                <div data-item="1"
                                     data-label="<c:out value='${item.label}'/>"
                                     data-points="${item.pointValue}"
                                     data-weight="${item.probabilityWeight}"
                                     data-color="<c:out value='${item.color}'/>"
                                     data-desc="<c:out value='${item.description}'/>"></div>
                            </c:forEach>
                        </div>
                    </div>
                    
                    <!-- Daily Limit Info -->
                    <div class="mt-4 pt-3 border-top">
                        <div class="d-flex align-items-center justify-content-center text-muted">
                            <i class="bi bi-calendar-check me-2 text-primary"></i>
                            <small class="fw-medium">One spin per day • Resets at midnight</small>
                        </div>
                    </div>
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
                            <a href="/students/activities" class="btn btn-sm btn-info text-white me-2">Join Activities</a>
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
                                                                    <a href="/students/activities/join/${activity.id}" class="btn btn-sm btn-outline-info ms-2">Join</a>
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




<script>
// Render mini spinwheel preview on dashboard
document.addEventListener('DOMContentLoaded', function() {
    const canvas = document.getElementById('miniSpinwheel');
    if (!canvas) return;
    const dataNodes = document.querySelectorAll('#mini-spin-data [data-item]');
    const items = Array.from(dataNodes).map(function(node) {
        return {
            label: node.getAttribute('data-label') || '',
            pointValue: parseInt(node.getAttribute('data-points') || '0', 10),
            probabilityWeight: parseFloat(node.getAttribute('data-weight') || '0'),
            color: node.getAttribute('data-color') || '#007bff',
            description: node.getAttribute('data-desc') || ''
        };
    });
    if (items.length === 0) return;

    // Lightweight draw without interaction
    const ctx = canvas.getContext('2d');
    const cx = canvas.width / 2;
    const cy = canvas.height / 2;
    const radius = Math.min(cx, cy) - 6;
    const totalWeight = items.reduce((s, it) => s + (it.probabilityWeight || 1), 0) || items.length;
    let startAngle = -Math.PI / 2;

    items.forEach(function(it) {
        const weight = (it.probabilityWeight || 1);
        const slice = (weight / totalWeight) * Math.PI * 2;
        const endAngle = startAngle + slice;
        ctx.beginPath();
        ctx.moveTo(cx, cy);
        ctx.arc(cx, cy, radius, startAngle, endAngle);
        ctx.closePath();
        ctx.fillStyle = it.color || '#007bff';
        ctx.fill();

        // label
        const mid = (startAngle + endAngle) / 2;
        const tx = cx + Math.cos(mid) * radius * 0.6;
        const ty = cy + Math.sin(mid) * radius * 0.6;
        ctx.fillStyle = '#fff';
        ctx.font = 'bold 12px Inter, Arial';
        ctx.textAlign = 'center';
        ctx.textBaseline = 'middle';
        ctx.fillText((it.pointValue || 0) + ' pts', tx, ty);
        startAngle = endAngle;
    });

    // pointer
    ctx.fillStyle = '#dc3545';
    ctx.beginPath();
    ctx.moveTo(cx, cy - radius - 4);
    ctx.lineTo(cx - 10, cy - radius + 16);
    ctx.lineTo(cx + 10, cy - radius + 16);
    ctx.closePath();
    ctx.fill();
});
</script>