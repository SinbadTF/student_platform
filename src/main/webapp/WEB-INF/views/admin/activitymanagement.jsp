<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Activities Management - Admin Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link href="<c:url value='/resources/css/main.css' />" rel="stylesheet">
</head>
<body>
    <jsp:include page="../layout/header.jsp" />
    
    <div class="d-flex">
        <!-- Left Sidebar -->
        <div class="bg-dark text-white" style="width: 250px; min-height: 100vh;">
            <div class="p-3">
                <h5 class="text-white mb-4">
                    <i class="bi bi-trophy me-2"></i>ClubPoints Admin
                </h5>
                <p class="text-muted small mb-4">Administration Dashboard</p>
                
                                <nav class="nav flex-column">
                    <a class="nav-link text-white-50 mb-2" href="${pageContext.request.contextPath}/admin/clubs">
                        <i class="bi bi-people me-2"></i>Club Dashboard
                    </a>
                    <a class="nav-link text-white-50 mb-2" href="${pageContext.request.contextPath}/admin/clubmanagement">
                        <i class="bi bi-gear me-2"></i>Club Management
                    </a>
                    <a class="nav-link text-white mb-2 active" href="${pageContext.request.contextPath}/admin/activitymanagement">
                        <i class="bi bi-calendar me-2"></i>Activity Management
                    </a>
                    <a class="nav-link text-white-50 mb-2" href="${pageContext.request.contextPath}/admin/studentmonitoring">
                        <i class="bi bi-mortarboard me-2"></i>Student Monitoring
                    </a>
                </nav>
            </div>
        </div>

        <!-- Main Content -->
        <div class="flex-grow-1 p-4">
            <div class="container-fluid">
                <!-- Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="mb-0">Activities Management</h2>
                    <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addActivityModal">
                        <i class="bi bi-plus-circle me-2"></i>Add New Activity
                    </button>
                </div>

                <!-- Filter Section -->
                <div class="row mb-4">
                    <div class="col-md-4">
                        <label for="clubFilter" class="form-label">Filter by Club</label>
                        <select class="form-select" id="clubFilter">
                            <option value="">All Clubs</option>
                            <option value="Computer Science Club">Computer Science Club</option>
                            <option value="Debate Society">Debate Society</option>
                            <option value="Art Club">Art Club</option>
                            <option value="Sports Club">Sports Club</option>
                        </select>
                    </div>
                </div>

                <!-- Activities Table -->
                <div class="card">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead class="table-light">
                                    <tr>
                                        <th>ACTIVITY TITLE</th>
                                        <th>CLUB</th>
                                        <th>POINTS</th>
                                        <th>DESCRIPTION</th>
                                        <th>ACTIONS</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Coding Workshop</td>
                                        <td>Computer Science Club</td>
                                        <td><span class="badge bg-primary">50</span></td>
                                        <td>Learn basic programming concepts</td>
                                        <td>
                                            <button class="btn btn-sm btn-outline-success me-1" title="Edit">
                                                <i class="bi bi-pencil"></i>
                                            </button>
                                            <button class="btn btn-sm btn-outline-danger" title="Delete">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Web Development Bootcamp</td>
                                        <td>Computer Science Club</td>
                                        <td><span class="badge bg-primary">75</span></td>
                                        <td>Build responsive websites</td>
                                        <td>
                                            <button class="btn btn-sm btn-outline-success me-1" title="Edit">
                                                <i class="bi bi-pencil"></i>
                                            </button>
                                            <button class="btn btn-sm btn-outline-danger" title="Delete">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Debate Competition</td>
                                        <td>Debate Society</td>
                                        <td><span class="badge bg-primary">60</span></td>
                                        <td>Inter-college debate championship</td>
                                        <td>
                                            <button class="btn btn-sm btn-outline-success me-1" title="Edit">
                                                <i class="bi bi-pencil"></i>
                                            </button>
                                            <button class="btn btn-sm btn-outline-danger" title="Delete">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Public Speaking Session</td>
                                        <td>Debate Society</td>
                                        <td><span class="badge bg-primary">40</span></td>
                                        <td>Improve presentation skills</td>
                                        <td>
                                            <button class="btn btn-sm btn-outline-success me-1" title="Edit">
                                                <i class="bi bi-pencil"></i>
                                            </button>
                                            <button class="btn btn-sm btn-outline-danger" title="Delete">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Art Exhibition</td>
                                        <td>Art Club</td>
                                        <td><span class="badge bg-primary">55</span></td>
                                        <td>Showcase student artwork</td>
                                        <td>
                                            <button class="btn btn-sm btn-outline-success me-1" title="Edit">
                                                <i class="bi bi-pencil"></i>
                                            </button>
                                            <button class="btn btn-sm btn-outline-danger" title="Delete">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Painting Workshop</td>
                                        <td>Art Club</td>
                                        <td><span class="badge bg-primary">45</span></td>
                                        <td>Learn various painting techniques</td>
                                        <td>
                                            <button class="btn btn-sm btn-outline-success me-1" title="Edit">
                                                <i class="bi bi-pencil"></i>
                                            </button>
                                            <button class="btn btn-sm btn-outline-danger" title="Delete">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Add Activity Modal -->
    <div class="modal fade" id="addActivityModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Activity</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="mb-3">
                            <label for="activityTitle" class="form-label">Activity Title</label>
                            <input type="text" class="form-control" id="activityTitle" required>
                        </div>
                        <div class="mb-3">
                            <label for="activityClub" class="form-label">Club</label>
                            <select class="form-select" id="activityClub" required>
                                <option value="">Select Club</option>
                                <option value="Computer Science Club">Computer Science Club</option>
                                <option value="Debate Society">Debate Society</option>
                                <option value="Art Club">Art Club</option>
                                <option value="Sports Club">Sports Club</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="activityPoints" class="form-label">Points</label>
                            <input type="number" class="form-control" id="activityPoints" min="1" required>
                        </div>
                        <div class="mb-3">
                            <label for="activityDescription" class="form-label">Description</label>
                            <textarea class="form-control" id="activityDescription" rows="3" required></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-success">Add Activity</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
