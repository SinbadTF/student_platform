package studentplatform.student_platform.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import studentplatform.student_platform.model.Admin;
import studentplatform.student_platform.model.Attendance;
import studentplatform.student_platform.model.Student;
import studentplatform.student_platform.repository.AttendanceRepository;
import studentplatform.student_platform.repository.StudentRepository;

import java.time.LocalDateTime;
import java.time.Month;
import java.util.List;
import java.util.Optional;

@Service
public class AttendanceService {

    private final AttendanceRepository attendanceRepository;
    private final StudentRepository studentRepository;
    private final StudentService studentService;

    @Autowired
    public AttendanceService(AttendanceRepository attendanceRepository,
                           StudentRepository studentRepository,
                           StudentService studentService) {
        this.attendanceRepository = attendanceRepository;
        this.studentRepository = studentRepository;
        this.studentService = studentService;
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

    public List<Attendance> getAttendancesByMonth(Month month) {
        return attendanceRepository.findByMonth(month);
    }

    public List<Attendance> getAttendancesByYear(Integer year) {
        return attendanceRepository.findByYear(year);
    }

    public List<Attendance> getAttendancesByMonthAndYear(Month month, Integer year) {
        return attendanceRepository.findByMonthAndYear(month, year);
    }

    public Optional<Attendance> getAttendanceByStudentAndMonthAndYear(Student student, Month month, Integer year) {
        return attendanceRepository.findByStudentAndMonthAndYear(student, month, year);
    }

    public Attendance saveAttendance(Attendance attendance) {
        return attendanceRepository.save(attendance);
    }

    public Attendance createOrUpdateAttendance(Student student, Month month, Integer year, 
                                             Double attendancePercentage, Admin admin) {
        // Check if attendance record already exists for this student, month, and year
        Optional<Attendance> existingAttendance = 
            attendanceRepository.findByStudentAndMonthAndYear(student, month, year);
        
        if (existingAttendance.isPresent()) {
            // Update existing record
            Attendance attendance = existingAttendance.get();
            attendance.setAttendancePercentage(attendancePercentage);
            attendance.setUpdatedAt(LocalDateTime.now());
            attendance.setUpdatedBy(admin);
            attendance.setPointsAwarded(false); // Reset points awarded flag to recalculate
            
            return attendanceRepository.save(attendance);
        } else {
            // Create new record
            Attendance attendance = new Attendance();
            attendance.setStudent(student);
            attendance.setMonth(month);
            attendance.setYear(year);
            attendance.setAttendancePercentage(attendancePercentage);
            attendance.setCreatedAt(LocalDateTime.now());
            attendance.setCreatedBy(admin);
            
            return attendanceRepository.save(attendance);
        }
    }

    public void deleteAttendance(Long id) {
        attendanceRepository.deleteById(id);
    }

    public void calculateAndAwardPoints() {
        // Get all attendance records that haven't had points awarded yet
        List<Attendance> pendingAttendances = attendanceRepository.findAttendancesWithoutPoints();
        
        for (Attendance attendance : pendingAttendances) {
            // Calculate points: attendance percentage * 10
            int pointsToAward = (int) Math.round(attendance.getAttendancePercentage() * 10);
            
            // Award points to student
            String reason = "Attendance points for " + attendance.getMonth() + " " + attendance.getYear();
            studentService.addPointsToStudent(attendance.getStudent().getId(), pointsToAward, reason);
            
            // Mark attendance as having points awarded
            attendance.setPointsAwarded(true);
            attendanceRepository.save(attendance);
        }
    }

    public Attendance awardPointsForAttendance(Long attendanceId) {
        return attendanceRepository.findById(attendanceId).map(attendance -> {
            if (!attendance.isPointsAwarded()) {
                // Calculate points: attendance percentage * 10
                int pointsToAward = (int) Math.round(attendance.getAttendancePercentage() * 10);
                
                // Award points to student
                String reason = "Attendance points for " + attendance.getMonth() + " " + attendance.getYear();
                studentService.addPointsToStudent(attendance.getStudent().getId(), pointsToAward, reason);
                
                // Mark attendance as having points awarded
                attendance.setPointsAwarded(true);
                return attendanceRepository.save(attendance);
            }
            return attendance;
        }).orElse(null);
    }
}