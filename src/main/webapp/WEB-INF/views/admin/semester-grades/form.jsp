<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${semesterGrade.id == null ? 'Create' : 'Edit'} Semester Grade - Student Platform</title>
    <!-- Google Fonts - Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Select2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <link href="<c:url value='/resources/css/main.css' />" rel="stylesheet">
    <style>
        .card-header-custom {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            border-radius: var(--border-radius) var(--border-radius) 0 0;
            padding: 1.5rem;
        }
        
        .form-label {
            font-weight: 500;
            margin-bottom: 0.5rem;
            color: var(--dark);
        }
        
        .form-control, .form-select {
            padding: 0.75rem 1rem;
            border-radius: var(--border-radius);
            border: 1px solid var(--gray-light);
            transition: all 0.3s ease;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.02);
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 0.25rem rgba(61, 115, 229, 0.15);
        }
        
        .select2-container--bootstrap-5 .select2-selection {
            padding: 0.75rem 1rem;
            height: auto;
            border-radius: var(--border-radius);
            border: 1px solid var(--gray-light);
        }
        
        .select2-container--bootstrap-5 .select2-selection--single .select2-selection__rendered {
            padding: 0;
        }
        
        .points-info {
            background-color: rgba(61, 115, 229, 0.05);
            border-radius: var(--border-radius);
            padding: 1rem;
            margin-top: 0.5rem;
        }
        
        .points-info ul {
            margin-bottom: 0;
            padding-left: 1.5rem;
        }
        
        .points-info li {
            margin-bottom: 0.25rem;
        }
        
        .points-info li:last-child {
            margin-bottom: 0;
        }
        
        .gpa-high {
            color: var(--success);
            font-weight: 600;
        }
        
        .gpa-medium {
            color: var(--warning);
            font-weight: 600;
        }
        
        .gpa-low {
            color: var(--danger);
            font-weight: 600;
        }
        
        .btn {
            padding: 0.75rem 1.5rem;
            font-weight: 500;
            border-radius: var(--border-radius);
            transition: all 0.3s ease;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            border: none;
            box-shadow: 0 4px 10px rgba(61, 115, 229, 0.25);
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(61, 115, 229, 0.35);
        }
        
        .btn-secondary {
            background: var(--light);
            color: var(--dark);
            border: 1px solid var(--gray-light);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        }
        
        .btn-secondary:hover {
            background: var(--gray-light);
            transform: translateY(-2px);
            box-shadow: 0 6px 10px rgba(0, 0, 0, 0.08);
        }
        
        .btn i {
            margin-right: 0.5rem;
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
                                <h2 class="mb-1"><i class="bi bi-mortarboard-fill"></i> ${semesterGrade.id == null ? 'Create' : 'Edit'} Semester Grade</h2>
                                <p class="mb-0 text-white-50">Enter student semester performance details</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row">
            <div class="col-lg-8 mx-auto">
                <div class="card shadow-sm rounded-3 border-0">
                    <div class="card-body p-4 p-lg-5">
                        <form action="<c:url value='/admin/semester-grades/save' />" method="post" class="needs-validation" novalidate>
                            <input type="hidden" name="id" value="${semesterGrade.id}" />
                            
                            <div class="mb-4">
                                <label for="studentId" class="form-label"><i class="bi bi-person-badge me-2"></i>Student</label>
                                <select name="studentId" id="studentId" class="form-select select2" required>
                                    <option value="" selected disabled>Select Student</option>
                                    <c:forEach items="${students}" var="student">
                                        <option value="${student.id}" ${semesterGrade.student.id == student.id ? 'selected' : ''}>
                                            ${student.studentId} - ${student.firstName} ${student.lastName}
                                        </option>
                                    </c:forEach>
                                </select>
                                <div class="invalid-feedback">Please select a student</div>
                            </div>
                            
                            <div class="mb-4">
                                <label for="semesterId" class="form-label"><i class="bi bi-calendar3 me-2"></i>Semester</label>
                                <select name="semesterId" id="semesterId" class="form-select select2" required>
                                    <option value="" selected disabled>Select Semester</option>
                                    <c:forEach items="${semesters}" var="semester">
                                        <option value="${semester.id}" ${semesterGrade.semester.id == semester.id ? 'selected' : ''}>
                                            ${semester.name} ${semester.year}
                                        </option>
                                    </c:forEach>
                                </select>
                                <div class="invalid-feedback">Please select a semester</div>
                            </div>
                            
                            <div class="mb-4">
                                <label for="gpa" class="form-label"><i class="bi bi-graph-up me-2"></i>GPA</label>
                                <input type="number" class="form-control" id="gpa" name="gpa" 
                                       value="${semesterGrade.gpa}" required min="0" max="4.0" step="0.01">
                                <div class="invalid-feedback">Please enter a valid GPA between 0 and 4.0</div>
                                
                                <div class="points-info mt-3">
                                    <h6 class="mb-2"><i class="bi bi-info-circle-fill me-2"></i>Points Awarded:</h6>
                                    <ul>
                                        <li>GPA <span class="gpa-high">> 3.5</span>: <strong>3000 points</strong></li>
                                        <li>GPA <span class="gpa-medium">3.0 - 3.5</span>: <strong>1500 points</strong></li>
                                        <li>GPA <span class="gpa-low">< 3.0</span>: <strong>1000 points</strong></li>
                                    </ul>
                                </div>
                            </div>
                            
                            <hr class="my-4">
                            
                            <div class="d-flex justify-content-between">
                                <a href="<c:url value='/admin/semester-grades' />" class="btn btn-secondary">
                                    <i class="bi bi-arrow-left"></i> Back to List
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="bi bi-save"></i> ${semesterGrade.id == null ? 'Create' : 'Update'} Grade
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Select2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    
    <script>
        $(document).ready(function() {
            // Initialize Select2
            $('.select2').select2({
                theme: 'bootstrap-5',
                width: '100%',
                dropdownParent: $('body')
            });
            
            // Form validation
            (function() {
                'use strict';
                
                // Fetch all forms we want to apply validation to
                var forms = document.querySelectorAll('.needs-validation');
                
                // Loop over them and prevent submission
                Array.prototype.slice.call(forms).forEach(function(form) {
                    form.addEventListener('submit', function(event) {
                        if (!form.checkValidity()) {
                            event.preventDefault();
                            event.stopPropagation();
                        }
                        
                        form.classList.add('was-validated');
                    }, false);
                });
            })();
            
            // GPA input styling based on value
            $('#gpa').on('input', function() {
                var gpa = parseFloat($(this).val());
                $(this).removeClass('is-valid is-invalid');
                
                if (gpa > 4.0 || gpa < 0 || isNaN(gpa)) {
                    $(this).addClass('is-invalid');
                } else {
                    $(this).addClass('is-valid');
                }
            });
        });
    </script>
</body>
</html>