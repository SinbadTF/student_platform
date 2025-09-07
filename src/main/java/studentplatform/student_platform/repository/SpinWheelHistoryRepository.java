package studentplatform.student_platform.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import studentplatform.student_platform.model.SpinWheel;
import studentplatform.student_platform.model.SpinWheelHistory;
import studentplatform.student_platform.model.Student;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface SpinWheelHistoryRepository extends JpaRepository<SpinWheelHistory, Long> {
    List<SpinWheelHistory> findByStudentOrderBySpunAtDesc(Student student);
    List<SpinWheelHistory> findBySpinWheelOrderBySpunAtDesc(SpinWheel spinWheel);
    List<SpinWheelHistory> findByStudentAndSpunAtBetween(Student student, LocalDateTime start, LocalDateTime end);
    List<SpinWheelHistory> findByStudentAndSpinWheelAndSpunAtBetween(Student student, SpinWheel spinWheel, LocalDateTime start, LocalDateTime end);
    List<SpinWheelHistory> findByStudent(Student student);
    // (restored) No cooldown query in original code
}