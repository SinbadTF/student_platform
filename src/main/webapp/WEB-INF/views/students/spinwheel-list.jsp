<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Spinwheels - Student Platform</title>
    <!-- Google Fonts - Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link href="<c:url value='/resources/css/main.css' />" rel="stylesheet">
</head>
<body>
    <jsp:include page="../layout/student_header.jsp" />
    
    <div class="container py-4">
        <!-- Header -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h2 class="display-6 fw-bold">Spinwheels</h2>
                        <p class="lead text-muted">Spin the wheel and win points!</p>
                    </div>
                    <div class="text-end">
                        <div class="badge bg-primary fs-6 p-2">
                            <i class="bi bi-star-fill me-1"></i>${student.points} Points
                        </div>
                        </div>
                        <a href="/students/dashboard/${student.id}" class="btn btn-outline-secondary btn-sm">
                            <i class="bi bi-house me-1"></i> Dashboard
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Available Spinwheels -->
        <div class="row">
            <c:choose>
                <c:when test="${empty spinWheels}">
                    <div class="col-12">
                        <div class="card border-0 shadow-sm rounded-3">
                            <div class="card-body text-center py-5">
                                <i class="bi bi-arrow-repeat text-muted" style="font-size: 4rem;"></i>
                                <h4 class="mt-3 text-muted">No Active Spinwheels</h4>
                                <p class="text-muted">Check back later for new spinwheels!</p>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                
                    <c:forEach var="spinWheel" items="${spinWheels}">
                        <div class="col-lg-4 col-md-6 mb-4">
                            <div class="card border-0 shadow-sm rounded-3 h-100">
                                <div class="card-body d-flex flex-column">
                                    <!-- Sample Spinwheel UI -->
                    <div class="spinwheel-container mb-4" style="position: relative; width: 200px; height: 200px; margin: 0 auto;">
                        <div class="spinwheel" id="sampleSpinwheel" style="width: 100%; height: 100%; border-radius: 50%; border: 6px solid #fff; box-shadow: 0 0 15px rgba(0,0,0,0.3); position: relative; background: conic-gradient(#ff6b6b 0deg 60deg, #4ecdc4 60deg 120deg, #45b7d1 120deg 180deg, #96ceb4 180deg 240deg, #feca57 240deg 300deg, #ff9ff3 300deg 360deg);">
                            <!-- Sample items will be added by JavaScript -->
                        </div>
                        <button class="spin-button" id="sampleSpinButton" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 50px; height: 50px; border-radius: 50%; background: #fff; border: 3px solid #007bff; color: #007bff; font-weight: bold; z-index: 10; box-shadow: 0 4px 8px rgba(0,0,0,0.2);">
                            <i class="bi bi-play-fill"></i>
                        </button>
                    </div>
                                    </div>
                                    
                                    <h5 class="card-title text-center">${spinWheel.name}</h5>
                                    
                                    <c:if test="${not empty spinWheel.description}">
                                        <p class="card-text text-muted text-center">${spinWheel.description}</p>
                                    </c:if>
                                    
                                    <div class="text-center mb-3">
                                        <span class="badge bg-info">${spinWheel.items.size()} items</span>
                                    </div>
                                    
                                    <div class="mt-auto">
                                        <a href="/students/spinwheel/${spinWheel.id}" class="btn btn-primary w-100">
                                            <i class="bi bi-play-circle me-2"></i>Spin Now!
                                        </a>
                                    </div>
                                </div>
                        
                        </div>
                    </c:forEach>
                
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <jsp:include page="../layout/footer.jsp" />
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>