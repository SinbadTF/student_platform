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
                            <a href="/students/spinwheel" class="btn btn-gradient btn-lg px-5 py-3 shadow-lg spin-button">
                                <i class="bi bi-arrow-repeat me-2"></i>Spin Now!
                                <div class="button-shine"></div>
                            </a>
                        </c:otherwise>
                    </c:choose>
                    
                    <!-- Enhanced Stats Display -->
                    <c:if test="${not empty activeSpinWheels}">
                        <div class="mt-4 pt-4 border-top">
                            <h6 class="text-muted mb-3 fw-semibold">📊 Spinwheel Stats</h6>
                            <div class="row g-3">
                                <div class="col-6">
                                    <div class="stat-card bg-primary bg-opacity-10 rounded-3 p-3 stat-card-primary">
                                        <div class="stat-icon mb-2">
                                            <i class="bi bi-circle-square text-primary"></i>
                                        </div>
                                        <h4 class="text-primary mb-1 fw-bold">${activeSpinWheels.size()}</h4>
                                        <small class="text-muted fw-medium">Available</small>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="stat-card bg-success bg-opacity-10 rounded-3 p-3 stat-card-success">
                                        <div class="stat-icon mb-2">
                                            <i class="bi bi-gift text-success"></i>
                                        </div>
                                        <h4 class="text-success mb-1 fw-bold">
                                            <c:set var="totalItems" value="0"/>
                                            <c:forEach var="wheel" items="${activeSpinWheels}">
                                                <c:set var="totalItems" value="${totalItems + wheel.items.size()}"/>
                                            </c:forEach>
                                            ${totalItems}
                                        </h4>
                                        <small class="text-muted fw-medium">Prizes</small>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Quick Preview of Available Prizes -->
                            <div class="mt-3">
                                <small class="text-muted d-block mb-2">
                                    <i class="bi bi-eye me-1"></i>Available Prizes Preview
                                </small>
                                <div class="prize-preview-container">
                                    <c:forEach var="wheel" items="${activeSpinWheels}" end="2">
                                        <c:forEach var="item" items="${wheel.items}" end="3">
                                            <div class="prize-preview-item" 
                                                 style="background-color: ${item.color != null ? item.color : '#007bff'};">
                                                <span class="prize-preview-text">${item.pointValue}pts</span>
                                            </div>
                                        </c:forEach>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    
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

    <!-- Clubs and Activities -->
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
                        
                        <c:if test="${empty clubs}">
                            <div class="col-12 text-center py-4">
                                <p>No clubs available at the moment</p>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    <!-- After the Clubs and Activities section, around line 198 -->
    
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
</div>

<!-- Chart.js for data visualization -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    // Use actual data from backend for points chart
    const ctx = document.getElementById('pointsChart').getContext('2d');
    const pointsChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: ${pointsChartLabels},
            datasets: [{
                label: 'Points Earned',
                data: ${pointsChartData},
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
                },
                x: {
                    title: {
                        display: true,
                        text: 'Month'
                    }
                }
            }
        }
    });
</script>
