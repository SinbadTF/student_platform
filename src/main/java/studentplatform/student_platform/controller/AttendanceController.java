package studentplatform.student_platform.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import studentplatform.student_platform.dto.AttendanceDTO;
import studentplatform.student_platform.exception.ResourceNotFoundException;
import studentplatform.student_platform.mapper.AttendanceMapper;
import studentplatform.student_platform.model.Admin;
import studentplatform.student_platform.model.Attendance;
import studentplatform.student_platform.model.Student;
import studentplatform.student_platform.service.AdminService;
import studentplatform.student_platform.service.AttendanceService;
import studentplatform.student_platform.service.StudentService;

import jakarta.validation.Valid;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.List;

@RestController
@RequestMapping("/api/attendances")
public class AttendanceController {

    private final AttendanceService attendanceService;
    private final StudentService studentService;
    private final AdminService adminService;

    @Autowired
    public AttendanceController(AttendanceService attendanceService, 
                              StudentService studentService,
                              AdminService adminService) {
        this.attendanceService = attendanceService;
        this.studentService = studentService;
        this.adminService = adminService;
    }

    @GetMapping
    public ResponseEntity<List<AttendanceDTO>> getAllAttendances() {
        List<AttendanceDTO> attendanceDTOs = attendanceService.getAllAttendances().stream()
                .map(AttendanceMapper::toDTO)
                .toList();
        return ResponseEntity.ok(attendanceDTOs);
    }

    @GetMapping("/{id}")
    public ResponseEntity<AttendanceDTO> getAttendanceById(@PathVariable Long id) {
        return attendanceService.getAttendanceById(id)
                .map(attendance -> ResponseEntity.ok(AttendanceMapper.toDTO(attendance)))
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/student/{studentId}")
    public ResponseEntity<List<AttendanceDTO>> getAttendancesByStudent(@PathVariable Long studentId) {
        try {
            List<AttendanceDTO> attendanceDTOs = attendanceService.getAttendancesByStudentId(studentId).stream()
                    .map(AttendanceMapper::toDTO)
                    .toList();
            return ResponseEntity.ok(attendanceDTOs);
        } catch (ResourceNotFoundException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/month/{yearMonth}")
    public ResponseEntity<List<AttendanceDTO>> getAttendancesByMonth(@PathVariable String yearMonth) {
        try {
            YearMonth month = YearMonth.parse(yearMonth, DateTimeFormatter.ofPattern("yyyy-MM"));
            List<AttendanceDTO> attendanceDTOs = attendanceService.getAttendancesByMonth(month).stream()
                    .map(AttendanceMapper::toDTO)
                    .toList();
            return ResponseEntity.ok(attendanceDTOs);
        } catch (DateTimeParseException e) {
            return ResponseEntity.badRequest().build();
        }
    }

    @GetMapping("/pending")
    public ResponseEntity<List<AttendanceDTO>> getPendingAttendances() {
        List<AttendanceDTO> pendingAttendanceDTOs = attendanceService.getPendingAttendances().stream()
                .map(AttendanceMapper::toDTO)
                .toList();
        return ResponseEntity.ok(pendingAttendanceDTOs);
    }

    @PostMapping
    public ResponseEntity<?> createAttendance(@Valid @RequestBody AttendanceDTO attendanceDTO) {
        try {
            Student student = studentService.getStudentById(attendanceDTO.getStudentId())
                    .orElseThrow(() -> new ResourceNotFoundException("Student not found with id: " + attendanceDTO.getStudentId()));
            
            Attendance attendance = new Attendance();
            attendance.setStudent(student);
            attendance.setMonth(attendanceDTO.getMonth());
            attendance.setPercentage(attendanceDTO.getPercentage());
            attendance.setApproved(false);
            
            Attendance savedAttendance = attendanceService.saveAttendance(attendance);
            return ResponseEntity.status(HttpStatus.CREATED).body(AttendanceMapper.toDTO(savedAttendance));
        } catch (ResourceNotFoundException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        } catch (IllegalStateException e) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body(e.getMessage());
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateAttendance(@PathVariable Long id, @Valid @RequestBody AttendanceDTO attendanceDTO) {
        try {
            return attendanceService.getAttendanceById(id)
                    .map(existingAttendance -> {
                        Student student = studentService.getStudentById(attendanceDTO.getStudentId())
                                .orElseThrow(() -> new ResourceNotFoundException("Student not found with id: " + attendanceDTO.getStudentId()));
                        
                        existingAttendance.setStudent(student);
                        existingAttendance.setMonth(attendanceDTO.getMonth());
                        existingAttendance.setPercentage(attendanceDTO.getPercentage());
                        
                        try {
                            Attendance updatedAttendance = attendanceService.saveAttendance(existingAttendance);
                            return ResponseEntity.ok(AttendanceMapper.toDTO(updatedAttendance));
                        } catch (IllegalStateException e) {
                            return ResponseEntity.status(HttpStatus.CONFLICT).body(e.getMessage());
                        }
                    })
                    .orElse(ResponseEntity.notFound().build());
        } catch (ResourceNotFoundException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    @PostMapping("/{id}/approve")
    public ResponseEntity<?> approveAttendance(@PathVariable Long id, @RequestParam Long adminId) {
        try {
            Admin admin = adminService.getAdminById(adminId)
                    .orElseThrow(() -> new ResourceNotFoundException("Admin not found with id: " + adminId));
            
            Attendance approvedAttendance = attendanceService.approveAttendance(id, admin);
            return ResponseEntity.ok(AttendanceMapper.toDTO(approvedAttendance));
        } catch (ResourceNotFoundException e) {
            return ResponseEntity.notFound().build();
        } catch (IllegalStateException e) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body(e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteAttendance(@PathVariable Long id) {
        return attendanceService.getAttendanceById(id)
                .map(attendance -> {
                    attendanceService.deleteAttendance(id);
                    return ResponseEntity.noContent().<Void>build();
                })
                .orElse(ResponseEntity.notFound().build());
    }
}