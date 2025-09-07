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
            <div class="card border-0 shadow-sm rounded-3 mb-4">
                <div class="card-body text-center p-4">
                    <h5 class="card-title">Lucky Spin</h5>
                    <p class="card-text">Try your luck and win points daily!</p>
                    
                    <!-- Sample Spinwheel UI -->
                    <div class="spinwheel-container mb-4" style="position: relative; width: 200px; height: 200px; margin: 0 auto;">
                        <div class="spinwheel" id="sampleSpinwheel" style="width: 100%; height: 100%; border-radius: 50%; border: 6px solid #fff; box-shadow: 0 0 15px rgba(0,0,0,0.3); position: relative; background: conic-gradient(#ff6b6b 0deg 60deg, #4ecdc4 60deg 120deg, #45b7d1 120deg 180deg, #96ceb4 180deg 240deg, #feca57 240deg 300deg, #ff9ff3 300deg 360deg);">
                            <!-- Sample items will be added by JavaScript -->
                        </div>
                        <button class="spin-button" id="sampleSpinButton" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 50px; height: 50px; border-radius: 50%; background: #fff; border: 3px solid #007bff; color: #007bff; font-weight: bold; z-index: 10; box-shadow: 0 4px 8px rgba(0,0,0,0.2);">
                            <i class="bi bi-play-fill"></i>
                        </button>
                    </div>
                    
                    <c:choose>
                        <c:when test="${hasSpunToday}">
                            <div class="alert alert-info mb-3">
                                <i class="bi bi-info-circle me-2"></i>
                                You've already spun today! Come back tomorrow.
                            </div>
                            <button class="btn btn-secondary" disabled>
                                <i class="bi bi-clock me-2"></i>Already Spun Today
                            </button>
                        </c:when>
                        <c:otherwise>
                            <a href="/students/spinwheel" class="btn btn-warning text-white">Go to Spinwheel</a>
                        </c:otherwise>
                    </c:choose>
                    
                    <div class="mt-2">
                        <small class="text-muted">One spin per day</small>
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
            labels: <c:out value='${pointsChartLabels}' escapeXml='false'/>,
            datasets: [{
                label: 'Points Earned',
                data: <c:out value='${pointsChartData}' escapeXml='false'/>,
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

    // Sample Spinwheel Animation (UI only)
    document.addEventListener('DOMContentLoaded', function() {
        const sampleSpinwheel = document.getElementById('sampleSpinwheel');
        const sampleSpinButton = document.getElementById('sampleSpinButton');
        
        if (sampleSpinwheel && sampleSpinButton) {
            // Add sample items to the spinwheel
            const sampleItems = [
                { label: '10 pts', color: '#ff6b6b', icon: 'bi-star' },
                { label: '25 pts', color: '#4ecdc4', icon: 'bi-gift' },
                { label: '50 pts', color: '#45b7d1', icon: 'bi-trophy' },
                { label: '100 pts', color: '#96ceb4', icon: 'bi-award' },
                { label: '5 pts', color: '#feca57', icon: 'bi-coin' },
                { label: '15 pts', color: '#ff9ff3', icon: 'bi-gem' }
            ];
            
            // Add item labels to the spinwheel
            sampleItems.forEach((item, index) => {
                const angle = (360 / sampleItems.length) * index;
                const centerAngle = angle + (360 / sampleItems.length / 2);
                const radians = (centerAngle * Math.PI) / 180;
                const radius = 70;
                const x = Math.cos(radians) * radius;
                const y = Math.sin(radians) * radius;
                
                const labelDiv = document.createElement('div');
                labelDiv.style.position = 'absolute';
                labelDiv.style.left = '50%';
                labelDiv.style.top = '50%';
                labelDiv.style.transform = `translate(${x}px, ${y}px) translate(-50%, -50%)`;
                labelDiv.style.textAlign = 'center';
                labelDiv.style.fontSize = '10px';
                labelDiv.style.fontWeight = 'bold';
                labelDiv.style.color = 'white';
                labelDiv.style.textShadow = '1px 1px 2px rgba(0,0,0,0.8)';
                labelDiv.style.pointerEvents = 'none';
                labelDiv.style.zIndex = '5';
                
                labelDiv.innerHTML = `
                    <i class="${item.icon}" style="font-size: 12px; display: block; margin-bottom: 2px;"></i>
                    <div style="font-size: 8px; line-height: 1;">${item.label}</div>
                `;
                
                sampleSpinwheel.appendChild(labelDiv);
            });
            
            // Add click animation
            sampleSpinButton.addEventListener('click', function() {
                if (sampleSpinButton.disabled) return;
                
                sampleSpinButton.disabled = true;
                sampleSpinButton.innerHTML = '<i class="bi bi-hourglass-split"></i>';
                
                // Random rotation
                const randomRotation = Math.random() * 360 + 1800;
                sampleSpinwheel.style.transition = 'transform 3s cubic-bezier(0.23, 1, 0.32, 1)';
                sampleSpinwheel.style.transform = `rotate(${randomRotation}deg)`;
                
                setTimeout(() => {
                    sampleSpinwheel.style.transition = 'none';
                    sampleSpinwheel.style.transform = 'rotate(0deg)';
                    sampleSpinButton.disabled = false;
                    sampleSpinButton.innerHTML = '<i class="bi bi-play-fill"></i>';
                }, 3000);
            });
        }
    });
</script>
