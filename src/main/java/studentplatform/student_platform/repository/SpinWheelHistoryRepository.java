package studentplatform.student_platform.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import studentplatform.student_platform.model.SpinWheelHistory;
import studentplatform.student_platform.model.Student;
import studentplatform.student_platform.model.SpinWheel;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface SpinWheelHistoryRepository extends JpaRepository<SpinWheelHistory, Long> {
    
    List<SpinWheelHistory> findByStudent(Student student);
    
    List<SpinWheelHistory> findBySpinWheel(SpinWheel spinWheel);
    
    List<SpinWheelHistory> findByStudentAndSpunAtBetween(Student student, LocalDateTime start, LocalDateTime end);
    
    @Query("SELECT COUNT(swh) > 0 FROM SpinWheelHistory swh WHERE swh.student = :student AND DATE(swh.spunAt) = CURRENT_DATE")
    boolean hasStudentSpunToday(@Param("student") Student student);
    
    @Query("SELECT swh FROM SpinWheelHistory swh WHERE swh.student = :student ORDER BY swh.spunAt DESC")
    List<SpinWheelHistory> findRecentSpinsByStudent(@Param("student") Student student);
    
    Optional<SpinWheelHistory> findFirstByStudentOrderBySpunAtDesc(Student student);
}