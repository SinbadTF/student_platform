package studentplatform.student_platform.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import studentplatform.student_platform.exception.ResourceNotFoundException;
import studentplatform.student_platform.model.Admin;
import studentplatform.student_platform.model.Attendance;
import studentplatform.student_platform.model.RewardHistory;
import studentplatform.student_platform.model.Student;
import studentplatform.student_platform.repository.AttendanceRepository;
import studentplatform.student_platform.repository.RewardHistoryRepository;

import java.time.YearMonth;
import java.util.List;
import java.util.Optional;

@Service
public class AttendanceService {

    private final AttendanceRepository attendanceRepository;
    private final StudentService studentService;
    private final RewardHistoryRepository rewardHistoryRepository;

    @Autowired
    public AttendanceService(AttendanceRepository attendanceRepository, 
                           StudentService studentService,
                           RewardHistoryRepository rewardHistoryRepository) {
        this.attendanceRepository = attendanceRepository;
        this.studentService = studentService;
        this.rewardHistoryRepository = rewardHistoryRepository;
    }

    public List<Attendance> getAllAttendances() {
        return attendanceRepository.findAll();
    }

    public Optional<Attendance> getAttendanceById(Long id) {
        return attendanceRepository.findById(id);
    }

    public List<Attendance> getAttendancesByStudent(Student student) {
        return attendanceRepository.findByStudent(student);
    }

    public List<Attendance> getAttendancesByStudentId(Long studentId) {
        Student student = studentService.getStudentById(studentId)
                .orElseThrow(() -> new ResourceNotFoundException("Student not found with id: " + studentId));
        return attendanceRepository.findByStudent(student);
    }

    public Optional<Attendance> getAttendanceByStudentAndMonth(Student student, YearMonth month) {
        return attendanceRepository.findByStudentAndMonth(student, month);
    }

    public List<Attendance> getAttendancesByMonth(YearMonth month) {
        return attendanceRepository.findByMonth(month);
    }

    public List<Attendance> getPendingAttendances() {
        return attendanceRepository.findByApproved(false);
    }

    public Attendance saveAttendance(Attendance attendance) {
        // Check if there's already an attendance record for this student and month
        if (attendance.getId() == null && 
            attendanceRepository.existsByStudentAndMonth(attendance.getStudent(), attendance.getMonth())) {
            throw new IllegalStateException("Attendance record already exists for this student and month");
        }
        return attendanceRepository.save(attendance);
    }

    @Transactional
    public Attendance approveAttendance(Long attendanceId, Admin admin) {
        Attendance attendance = attendanceRepository.findById(attendanceId)
                .orElseThrow(() -> new ResourceNotFoundException("Attendance not found with id: " + attendanceId));
        
        if (attendance.isApproved()) {
            throw new IllegalStateException("Attendance is already approved");
        }
        
        // Calculate points based on attendance percentage
       int pointsToAward = Attendance.calculatePointsToAward(attendance.getPercentage());

        if (pointsToAward > 0) {
            // Update attendance record
            attendance.setApproved(true);
            attendance.setApprovedBy(admin);
            attendance.setAwardedPoints(pointsToAward);
            
            // Update student points
            Student student = attendance.getStudent();
            Integer currentPoints = student.getPoints() != null ? student.getPoints() : 0;
            student.setPoints(currentPoints + pointsToAward);
            studentService.saveStudent(student);
            
            // Create reward history record
            String reason = "Attendance Reward for - " + attendance.getMonth().toString();
            RewardHistory rewardHistory = new RewardHistory(student, reason, pointsToAward, admin);
            rewardHistoryRepository.save(rewardHistory);
            
            return attendanceRepository.save(attendance);
        } else {
            // Just approve without awarding points
            attendance.setApproved(true);
            attendance.setApprovedBy(admin);
            attendance.setAwardedPoints(0);
            return attendanceRepository.save(attendance);
        }
    }

    public void deleteAttendance(Long id) {
        attendanceRepository.deleteById(id);
    }
    
    public boolean existsByStudentAndMonth(Student student, YearMonth month) {
        return attendanceRepository.existsByStudentAndMonth(student, month);
    }
}