<%@ include file="../layout/student_header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container py-4">
    <!-- Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card bg-primary text-white shadow-lg rounded-3 border-0">
                <div class="card-body p-4">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h2 class="display-6 fw-bold">📊 Spin History</h2>
                            <p class="lead mb-0">Track your lucky spins and rewards earned</p>
                        </div>
                        <div class="text-center">
                            <div class="bg-white rounded-circle p-3 d-inline-block">
                                <i class="bi bi-clock-history text-primary" style="font-size: 3rem;"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Statistics -->
    <div class="row mb-4">
        <div class="col-md-4">
            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-body text-center">
                    <div class="bg-primary bg-opacity-10 rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
                        <i class="bi bi-arrow-repeat text-primary" style="font-size: 2rem;"></i>
                    </div>
                    <h5 class="card-title">Total Spins</h5>
                    <h2 class="display-6 fw-bold text-primary">${history.size()}</h2>
                    <p class="text-muted mb-0">Lifetime spins</p>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-body text-center">
                    <div class="bg-success bg-opacity-10 rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
                        <i class="bi bi-star-fill text-success" style="font-size: 2rem;"></i>
                    </div>
                    <h5 class="card-title">Total Points Won</h5>
                    <h2 class="display-6 fw-bold text-success">
                        <c:set var="totalPoints" value="0" />
                        <c:forEach var="spin" items="${history}">
                            <c:set var="totalPoints" value="${totalPoints + spin.pointsAwarded}" />
                        </c:forEach>
                        ${totalPoints}
                    </h2>
                    <p class="text-muted mb-0">From all spins</p>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-body text-center">
                    <div class="bg-warning bg-opacity-10 rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
                        <i class="bi bi-trophy text-warning" style="font-size: 2rem;"></i>
                    </div>
                    <h5 class="card-title">Best Win</h5>
                    <h2 class="display-6 fw-bold text-warning">
                        <c:set var="bestWin" value="0" />
                        <c:forEach var="spin" items="${history}">
                            <c:if test="${spin.pointsAwarded > bestWin}">
                                <c:set var="bestWin" value="${spin.pointsAwarded}" />
                            </c:if>
                        </c:forEach>
                        ${bestWin}
                    </h2>
                    <p class="text-muted mb-0">Highest points in one spin</p>
                </div>
            </div>
        </div>
    </div>
    <!-- History List -->
    <div class="row">
        <div class="col-12">
            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-header bg-white border-0 py-3">
                    <div class="d-flex justify-content-between align-items-center">
                        <h5 class="mb-0"><i class="bi bi-list-ul text-primary me-2"></i>Spin History</h5>
                        <a href="/students/spinwheel" class="btn btn-primary btn-sm">
                            <i class="bi bi-arrow-repeat me-2"></i>Spin Again
                        </a>
                    </div>
                </div>
                <div class="card-body p-0">
                    <c:choose>
                        <c:when test="${empty history}">
                            <div class="text-center py-5">
                                <div class="bg-light rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
                                    <i class="bi bi-arrow-repeat text-muted" style="font-size: 2rem;"></i>
                                </div>
                                <h5 class="text-muted">No Spins Yet</h5>
                                <p class="text-muted">Start spinning to see your history here!</p>
                                <a href="/students/spinwheel" class="btn btn-primary">
                                    <i class="bi bi-arrow-repeat me-2"></i>Try Your First Spin
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-hover mb-0">
                                    <thead class="table-light">
                                        <tr>
                                            <th>Date & Time</th>
                                            <th>Spinwheel</th>
                                            <th>Result</th>
                                            <th>Points Won</th>
                                            <th>Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="spin" items="${history}">
                                            <tr>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <div class="bg-primary bg-opacity-10 rounded-circle p-2 me-3">
                                                            <i class="bi bi-calendar-event text-primary"></i>
                                                        </div>
                                                        <div>
                                                            <h6 class="mb-0">
                                                                <fmt:formatDate value="${spin.spunAt}" pattern="MMM dd, yyyy"/>
                                                            </h6>
                                                            <small class="text-muted">
                                                                <fmt:formatDate value="${spin.spunAt}" pattern="HH:mm"/>
                                                            </small>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div>
                                                        <h6 class="mb-0">${spin.spinWheel.name}</h6>
                                                        <c:if test="${not empty spin.spinWheel.description}">
                                                            <small class="text-muted">${spin.spinWheel.description}</small>
                                                        </c:if>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <div class="rounded-circle me-2 d-flex align-items-center justify-content-center" 
                                                             style="width: 30px; height: 30px; background-color: ${spin.resultItem.color != null ? spin.resultItem.color : '#007bff'};">
                                                            <i class="bi bi-star-fill text-white" style="font-size: 0.8rem;"></i>
                                                        </div>
                                                        <div>
                                                            <h6 class="mb-0">${spin.resultItem.label}</h6>
                                                            <c:if test="${not empty spin.resultItem.description}">
                                                                <small class="text-muted">${spin.resultItem.description}</small>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <span class="badge bg-success fs-6">+${spin.pointsAwarded}</span>
                                                </td>
                                                <td>
                                                    <span class="badge bg-success">Completed</span>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <!-- Recent Activity Chart -->
    <c:if test="${history.size() > 1}">
        <div class="row mt-4">
            <div class="col-12">
                <div class="card border-0 shadow-sm rounded-3">
                    <div class="card-header bg-white border-0 py-3">
                        <h6 class="mb-0"><i class="bi bi-graph-up text-info me-2"></i>Points Earned Over Time</h6>
                    </div>
                    <div class="card-body">
                        <canvas id="pointsChart" width="400" height="200"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </c:if>
</div>

<!-- Chart.js for the points chart -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
// Prepare data for the chart
const historyData = [
    <c:forEach var="spin" items="${history}" varStatus="status">
    {
        date: '${spin.spunAt}',
        points: ${spin.pointsAwarded},
        label: '${spin.resultItem.label}'
    }<c:if test="${!status.last}">,</c:if>
    </c:forEach>
];

// Sort by date (oldest first)
historyData.sort((a, b) => new Date(a.date) - new Date(b.date));
// Create chart if there's data
if (historyData.length > 1) {
    const ctx = document.getElementById('pointsChart').getContext('2d');
    
    new Chart(ctx, {
        type: 'line',
        data: {
            labels: historyData.map(item => {
                const date = new Date(item.date);
                return date.toLocaleDateString('en-US', { month: 'short', day: 'numeric' });
            }),
            datasets: [{
                label: 'Points Won',
                data: historyData.map(item => item.points),
                borderColor: '#007bff',
                backgroundColor: 'rgba(0, 123, 255, 0.1)',
                borderWidth: 3,
                fill: true,
                tension: 0.4,
                pointBackgroundColor: '#007bff',
                pointBorderColor: '#fff',
                pointBorderWidth: 2,
                pointRadius: 6
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false
                },
                tooltip: {
                    callbacks: {
                        afterLabel: function(context) {
                            const index = context.dataIndex;
                            return 'Won: ' + historyData[index].label;
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
                        text: 'Date'
                    }
                }
            }
        }
    });
}
</script>