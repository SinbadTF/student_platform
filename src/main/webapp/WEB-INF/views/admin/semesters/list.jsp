<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Semesters - Student Platform</title>
    <!-- Google Fonts - Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css">
    <!-- Additional DataTables Extensions -->
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.2.2/css/buttons.bootstrap5.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.2.9/css/responsive.bootstrap5.min.css">
    <link href="<c:url value='/resources/css/main.css' />" rel="stylesheet">
    <style>
        .card-header-custom {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            border-radius: var(--border-radius) var(--border-radius) 0 0;
            padding: 1.5rem;
        }
        .status-badge {
            font-size: 0.85rem;
            padding: 0.35rem 0.65rem;
            border-radius: 50rem;
        }
        .table-container {
            border-radius: var(--border-radius);
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        }
        .action-btn {
            width: 32px;
            height: 32px;
            padding: 0;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            margin: 0 0.15rem;
            transition: all 0.2s;
        }
        .action-btn:hover {
            transform: translateY(-3px);
        }
        .semester-year {
            font-weight: 600;
            color: var(--primary);
        }
        .add-btn {
            padding: 0.5rem 1.25rem;
            border-radius: var(--border-radius);
            font-weight: 500;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .add-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15);
        }
        .table thead th {
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
        }
    </style>
</head>
<body>
    <jsp:include page="../../layout/header.jsp" />
    
    <div class="container py-5">
        <!-- Page Header -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card border-0 shadow-sm">
                    <div class="card-header-custom">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h2 class="mb-1"><i class="bi bi-calendar3"></i> Semesters</h2>
                                <p class="mb-0 text-white-50">Manage academic semesters</p>
                            </div>
                            <a href="<c:url value='/admin/semesters/new' />" class="btn btn-light add-btn">
                                <i class="bi bi-plus-lg me-2"></i> Add Semester
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Flash Message -->
        <c:if test="${not empty message}">
            <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i> ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        
        <!-- Semesters Table -->
        <div class="card shadow-sm rounded-3 border-0">
            <div class="card-body p-0">
                <div class="table-container">
                    <table id="semestersTable" class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th width="5%">ID</th>
                                <th width="25%">Name</th>
                                <th width="20%">Year</th>
                                <th width="20%">Status</th>
                                <th width="15%" class="text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${semesters}" var="semester">
                                <tr>
                                    <td>${semester.id}</td>
                                    <td><strong>${semester.name}</strong></td>
                                    <td>${semester.year}</td>
                                    <td>
                                        <span class="badge ${semester.active ? 'bg-success' : 'bg-secondary'}">
                                            <i class="bi ${semester.active ? 'bi-check-circle-fill' : 'bi-dash-circle-fill'} me-1"></i>
                                            ${semester.active ? 'Active' : 'Inactive'}
                                        </span>
                                    </td>
                                    <td class="text-center">
                                        <div class="btn-group btn-group-sm" role="group">
                                            <a href="<c:url value='/admin/semesters/edit/${semester.id}' />" class="btn btn-outline-primary">
                                                <i class="bi bi-pencil-fill"></i>
                                            </a>
                                            <a href="<c:url value='/admin/semesters/delete/${semester.id}' />" class="btn btn-outline-danger"
                                               onclick="return confirm('Are you sure you want to delete this semester?')">
                                                <i class="bi bi-trash-fill"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
    <!-- DataTables Extensions -->
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/dataTables.buttons.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.bootstrap5.min.js"></script>
    <script src="https://cdn.datatables.net/responsive/2.2.9/js/dataTables.responsive.min.js"></script>
    <script src="https://cdn.datatables.net/responsive/2.2.9/js/responsive.bootstrap5.min.js"></script>
    
    <script>
        $(document).ready(function() {
            $('#semestersTable').DataTable({
                order: [[0, 'desc']],
                pageLength: 10,
                responsive: true,
                columnDefs: [
                    { orderable: false, targets: [3, 4] } // Disable sorting for Status and Actions columns
                ],
                language: {
                    search: "<i class='bi bi-search'></i> _INPUT_",
                    searchPlaceholder: "Search semesters...",
                    lengthMenu: "", // Remove "Show X entries" text
                    info: "", // Remove the "Showing X to Y of Z entries" text
                    infoEmpty: "",
                    infoFiltered: "",
                    paginate: {
                        previous: "",
                        next: ""
                    }
                },
                dom: '<"row"<"col-sm-12"f>>rt' // Remove length changing control
            });
        });
    </script>
</body>
</html>
<style>
    /* Table Styling */
    .table-container {
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
    }
    
    .table {
        margin-bottom: 0;
    }
    
    .table thead {
        background-color: #f8f9fa;
    }
    
    .table thead th {
        font-weight: 600;
        text-transform: uppercase;
        font-size: 0.85rem;
        letter-spacing: 0.5px;
        padding: 1rem;
        border-bottom: 2px solid #e9ecef;
    }
    
    .table tbody td {
        padding: 0.85rem 1rem;
        vertical-align: middle;
    }
    
    .table-striped tbody tr:nth-of-type(odd) {
        background-color: rgba(0, 0, 0, 0.02);
    }
    
    .table-hover tbody tr:hover {
        background-color: rgba(61, 115, 229, 0.05);
    }
    
    /* Status Badge */
    .badge {
        font-size: 0.85rem;
        padding: 0.35rem 0.65rem;
        border-radius: 50rem;
        font-weight: 500;
    }
    
    /* Action Buttons */
    .btn-group-sm > .btn {
        padding: 0.25rem 0.5rem;
        border-radius: 0.25rem;
        transition: all 0.2s;
    }
    
    .btn-group-sm > .btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
</style>