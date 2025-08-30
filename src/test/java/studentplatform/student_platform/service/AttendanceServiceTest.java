package studentplatform.student_platform.service;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.transaction.annotation.Transactional;
import studentplatform.student_platform.exception.ResourceNotFoundException;
import studentplatform.student_platform.model.Admin;
import studentplatform.student_platform.model.Attendance;
import studentplatform.student_platform.model.RewardHistory;
import studentplatform.student_platform.model.Student;
import studentplatform.student_platform.repository.AttendanceRepository;
import studentplatform.student_platform.repository.RewardHistoryRepository;

import java.time.YearMonth;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

class AttendanceServiceTest {

    @Mock
    private AttendanceRepository attendanceRepository;

    @Mock
    private StudentService studentService;

    @Mock
    private RewardHistoryRepository rewardHistoryRepository;

    @InjectMocks
    private AttendanceService attendanceService;

    private Student student;
    private Admin admin;
    private Attendance attendance;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);

        student = new Student();
        student.setId(1L);
        student.setFirstName("John");
        student.setLastName("Doe");
        student.setPoints(100);

        admin = new Admin();
        admin.setId(1L);
        admin.setFirstName("Admin");
        admin.setLastName("User");

        attendance = new Attendance();
        attendance.setId(1L);
        attendance.setStudent(student);
        attendance.setMonth(YearMonth.now());
        attendance.setPercentage(90);
        attendance.setApproved(false);
    }

    @Test
    void getAllAttendances() {
        when(attendanceRepository.findAll()).thenReturn(Arrays.asList(attendance));

        List<Attendance> result = attendanceService.getAllAttendances();

        assertEquals(1, result.size());
        assertEquals(attendance, result.get(0));
    }

    @Test
    void getAttendanceById() {
        when(attendanceRepository.findById(1L)).thenReturn(Optional.of(attendance));

        Optional<Attendance> result = attendanceService.getAttendanceById(1L);

        assertTrue(result.isPresent());
        assertEquals(attendance, result.get());
    }

    @Test
    void getAttendancesByStudentId() {
        when(studentService.getStudentById(1L)).thenReturn(Optional.of(student));
        when(attendanceRepository.findByStudent(student)).thenReturn(Arrays.asList(attendance));

        List<Attendance> result = attendanceService.getAttendancesByStudentId(1L);

        assertEquals(1, result.size());
        assertEquals(attendance, result.get(0));
    }

    @Test
    void getAttendancesByStudentId_StudentNotFound() {
        when(studentService.getStudentById(1L)).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> {
            attendanceService.getAttendancesByStudentId(1L);
        });
    }

    @Test
    void getAttendancesByMonth() {
        YearMonth month = YearMonth.now();
        when(attendanceRepository.findByMonth(month)).thenReturn(Arrays.asList(attendance));

        List<Attendance> result = attendanceService.getAttendancesByMonth(month);

        assertEquals(1, result.size());
        assertEquals(attendance, result.get(0));
    }

    @Test
    void getPendingAttendances() {
        when(attendanceRepository.findByApproved(false)).thenReturn(Arrays.asList(attendance));

        List<Attendance> result = attendanceService.getPendingAttendances();

        assertEquals(1, result.size());
        assertEquals(attendance, result.get(0));
    }

    @Test
    void saveAttendance() {
        when(attendanceRepository.save(any(Attendance.class))).thenReturn(attendance);

        Attendance result = attendanceService.saveAttendance(attendance);

        assertEquals(attendance, result);
        verify(attendanceRepository, times(1)).save(attendance);
    }

    @Test
    void saveAttendance_DuplicateRecord() {
        when(attendanceRepository.existsByStudentAndMonth(student, attendance.getMonth())).thenReturn(true);

        assertThrows(IllegalStateException.class, () -> {
            attendanceService.saveAttendance(attendance);
        });
    }

    @Test
    void approveAttendance() {
        // Setup
        attendance.setPercentage(90); // 90% attendance should award 40 points
        when(attendanceRepository.findById(1L)).thenReturn(Optional.of(attendance));
        when(attendanceRepository.save(any(Attendance.class))).thenReturn(attendance);
        when(rewardHistoryRepository.save(any(RewardHistory.class))).thenAnswer(invocation -> invocation.getArgument(0));
        
        // Execute
        Attendance result = attendanceService.approveAttendance(1L, admin);

        // Verify
        assertTrue(result.isApproved());
        assertEquals(admin, result.getApprovedBy());
        assertEquals(40, result.getAwardedPoints()); // 90% should award 40 points
        
        // Verify student points were updated
        verify(studentService, times(1)).addPointsToStudent(student, 40);
        
        // Verify reward history was created
        verify(rewardHistoryRepository, times(1)).save(any(RewardHistory.class));
    }

    @Test
    void approveAttendance_AttendanceNotFound() {
        when(attendanceRepository.findById(1L)).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> {
            attendanceService.approveAttendance(1L, admin);
        });
    }

    @Test
    void approveAttendance_AlreadyApproved() {
        attendance.setApproved(true);
        when(attendanceRepository.findById(1L)).thenReturn(Optional.of(attendance));

        assertThrows(IllegalStateException.class, () -> {
            attendanceService.approveAttendance(1L, admin);
        });
    }

    @Test
    void deleteAttendance() {
        attendanceService.deleteAttendance(1L);
        verify(attendanceRepository, times(1)).deleteById(1L);
    }

    @Test
    void calculatePointsToAward() {
        // Test different percentage ranges
        assertEquals(0, Attendance.calculatePointsToAward(79.0)); // Below 80%

        assertEquals(30, Attendance.calculatePointsToAward(80)); // Exactly 80%

        assertEquals(30, Attendance.calculatePointsToAward(85)); // Between 80% and 90%

        assertEquals(40, Attendance.calculatePointsToAward(90)); // Exactly 90%

        assertEquals(40, Attendance.calculatePointsToAward(95)); // Between 90% and 100%
        
        assertEquals(50, Attendance.calculatePointsToAward((int)100.0)); // Exactly 100%
    }
}