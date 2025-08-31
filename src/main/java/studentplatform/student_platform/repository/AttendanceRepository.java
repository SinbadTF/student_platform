package studentplatform.student_platform.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import studentplatform.student_platform.model.Attendance;
import studentplatform.student_platform.model.Student;

import java.time.Month;
import java.util.List;
import java.util.Optional;

@Repository
public interface AttendanceRepository extends JpaRepository<Attendance, Long> {
    
    List<Attendance> findByStudent(Student student);
    
    List<Attendance> findByMonth(Month month);
    
    List<Attendance> findByYear(Integer year);
    
    List<Attendance> findByMonthAndYear(Month month, Integer year);
    
    Optional<Attendance> findByStudentAndMonthAndYear(Student student, Month month, Integer year);
    
    @Query("SELECT a FROM Attendance a WHERE a.pointsAwarded = false")
    List<Attendance> findAttendancesWithoutPoints();
}