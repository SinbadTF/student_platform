package studentplatform.student_platform.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import studentplatform.student_platform.model.Attendance;
import studentplatform.student_platform.model.Student;

import java.time.YearMonth;
import java.util.List;
import java.util.Optional;

@Repository
public interface AttendanceRepository extends JpaRepository<Attendance, Long> {
    
    List<Attendance> findByStudent(Student student);
    
    List<Attendance> findByApproved(boolean approved);
    
    List<Attendance> findByStudentAndApproved(Student student, boolean approved);
    
    Optional<Attendance> findByStudentAndMonth(Student student, YearMonth month);
    
    @Query("SELECT a FROM Attendance a WHERE a.student.id = :studentId AND a.month = :month")
    Optional<Attendance> findByStudentIdAndMonth(@Param("studentId") Long studentId, @Param("month") YearMonth month);
    
    @Query("SELECT a FROM Attendance a WHERE a.month = :month")
    List<Attendance> findByMonth(@Param("month") YearMonth month);
    
    @Query("SELECT a FROM Attendance a WHERE a.percentage >= :minPercentage")
    List<Attendance> findByPercentageGreaterThanEqual(@Param("minPercentage") Integer minPercentage);
    
    @Query("SELECT a FROM Attendance a WHERE a.student.id = :studentId AND a.month BETWEEN :startMonth AND :endMonth")
    List<Attendance> findByStudentIdAndMonthBetween(
            @Param("studentId") Long studentId,
            @Param("startMonth") YearMonth startMonth,
            @Param("endMonth") YearMonth endMonth);
    
    boolean existsByStudentAndMonth(Student student, YearMonth month);
}