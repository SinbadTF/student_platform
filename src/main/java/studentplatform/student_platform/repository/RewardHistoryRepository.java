package studentplatform.student_platform.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import studentplatform.student_platform.model.RewardHistory;
import studentplatform.student_platform.model.Student;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface RewardHistoryRepository extends JpaRepository<RewardHistory, Long> {
    
    List<RewardHistory> findByStudent(Student student);
    
    List<RewardHistory> findByStudentOrderByAwardedAtDesc(Student student);
    
    List<RewardHistory> findByReasonContaining(String keyword);
    
    List<RewardHistory> findByAwardedAtBetween(LocalDateTime start, LocalDateTime end);
    
    @Query("SELECT rh FROM RewardHistory rh WHERE rh.student.id = :studentId")
    List<RewardHistory> findByStudentId(@Param("studentId") Long studentId);
    
    @Query("SELECT rh FROM RewardHistory rh WHERE rh.student.id = :studentId AND rh.reason LIKE %:reason%")
    List<RewardHistory> findByStudentIdAndReasonContaining(
            @Param("studentId") Long studentId, 
            @Param("reason") String reason);
    
    @Query("SELECT SUM(rh.pointsAwarded) FROM RewardHistory rh WHERE rh.student.id = :studentId")
    Integer getTotalPointsAwardedToStudent(@Param("studentId") Long studentId);
}