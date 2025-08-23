<%@ include file="layout/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container">
    <!-- Welcome Section -->
    <div class="jumbotron bg-light my-4 p-4 shadow-sm">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h1 class="display-4">Welcome to Student Platform</h1>
                <p class="lead">A comprehensive platform for managing student rewards and recognition</p>
            </div>
            <div class="col-md-4 text-center">
                <img src="<c:url value='/static/images/logo.png' />" alt="Logo" class="img-fluid" style="max-height: 150px;">
            </div>
        </div>
    </div>
    
    <!-- Quick Stats -->
    <div class="row mb-4">
        <div class="col-md-3">
            <div class="card bg-primary text-white shadow">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-white-50">Total Students</h6>
                            <h2 class="mb-0">${studentCount != null ? studentCount : '0'}</h2>
                        </div>
                        <i class="bi bi-people-fill fa-2x text-white-50"></i>
                    </div>
                </div>
                <div class="card-footer d-flex align-items-center justify-content-between">
                    <a href="/students" class="text-white stretched-link">View Details</a>
                    <div class="text-white"><i class="bi bi-arrow-right"></i></div>
                </div>
            </div>
        </div>
        
        <div class="col-md-3">
            <div class="card bg-success text-white shadow">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-white-50">Staff Members</h6>
                            <h2 class="mb-0">${staffCount != null ? staffCount : '0'}</h2>
                        </div>
                        <i class="bi bi-person-badge-fill fa-2x text-white-50"></i>
                    </div>
                </div>
                <div class="card-footer d-flex align-items-center justify-content-between">
                    <a href="/staff" class="text-white stretched-link">View Details</a>
                    <div class="text-white"><i class="bi bi-arrow-right"></i></div>
                </div>
            </div>
        </div>
        
        <div class="col-md-3">
            <div class="card bg-info text-white shadow">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-white-50">Available Rewards</h6>
                            <h2 class="mb-0">${rewardCount != null ? rewardCount : '0'}</h2>
                        </div>
                        <i class="bi bi-award-fill fa-2x text-white-50"></i>
                    </div>
                </div>
                <div class="card-footer d-flex align-items-center justify-content-between">
                    <a href="/rewards" class="text-white stretched-link">View Details</a>
                    <div class="text-white"><i class="bi bi-arrow-right"></i></div>
                </div>
            </div>
        </div>
        
        <div class="col-md-3">
            <div class="card bg-warning text-white shadow">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-white-50">Points Awarded</h6>
                            <h2 class="mb-0">${pointCount != null ? pointCount : '0'}</h2>
                        </div>
                        <i class="bi bi-star-fill fa-2x text-white-50"></i>
                    </div>
                </div>
                <div class="card-footer d-flex align-items-center justify-content-between">
                    <a href="/points" class="text-white stretched-link">View Details</a>
                    <div class="text-white"><i class="bi bi-arrow-right"></i></div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Main Navigation Cards -->
    <div class="row mt-4">
        <div class="col-md-3">
            <div class="card shadow-sm h-100">
                <div class="card-body text-center">
                    <i class="bi bi-people-fill text-primary" style="font-size: 3rem;"></i>
                    <h5 class="card-title mt-3">Students</h5>
                    <p class="card-text">Manage student profiles and information</p>
                    <a href="/students" class="btn btn-primary">View Students</a>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card shadow-sm h-100">
                <div class="card-body text-center">
                    <i class="bi bi-person-badge-fill text-success" style="font-size: 3rem;"></i>
                    <h5 class="card-title mt-3">Staff</h5>
                    <p class="card-text">Manage staff profiles and information</p>
                    <a href="/staff" class="btn btn-success">View Staff</a>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card shadow-sm h-100">
                <div class="card-body text-center">
                    <i class="bi bi-award-fill text-info" style="font-size: 3rem;"></i>
                    <h5 class="card-title mt-3">Rewards</h5>
                    <p class="card-text">Manage available rewards for students</p>
                    <a href="/rewards" class="btn btn-info text-white">View Rewards</a>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card shadow-sm h-100">
                <div class="card-body text-center">
                    <i class="bi bi-star-fill text-warning" style="font-size: 3rem;"></i>
                    <h5 class="card-title mt-3">Points</h5>
                    <p class="card-text">Track and manage student points</p>
                    <a href="/points" class="btn btn-warning text-white">View Points</a>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Recent Activity Section -->
    <div class="row mt-4">
        <div class="col-12">
            <div class="card shadow-sm">
                <div class="card-header bg-light">
                    <h5 class="mb-0">Quick Actions</h5>
                </div>
                <div class="card-body">
                    <div class="row text-center">
                        <div class="col-md-3">
                            <a href="/students/create" class="btn btn-outline-primary btn-lg w-100 mb-2">
                                <i class="bi bi-person-plus-fill"></i> Add New Student
                            </a>
                        </div>
                        <div class="col-md-3">
                            <a href="/staff/create" class="btn btn-outline-success btn-lg w-100 mb-2">
                                <i class="bi bi-person-plus-fill"></i> Add New Staff
                            </a>
                        </div>
                        <div class="col-md-3">
                            <a href="/rewards/create" class="btn btn-outline-info btn-lg w-100 mb-2">
                                <i class="bi bi-plus-circle-fill"></i> Create New Reward
                            </a>
                        </div>
                        <div class="col-md-3">
                            <a href="/points/create" class="btn btn-outline-warning btn-lg w-100 mb-2">
                                <i class="bi bi-plus-circle-fill"></i> Award Points
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="layout/footer.jsp" %>