package studentplatform.student_platform.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import studentplatform.student_platform.model.RewardExchange;
import studentplatform.student_platform.model.Student;
import studentplatform.student_platform.model.Reward;
import studentplatform.student_platform.model.Staff;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface RewardExchangeRepository extends JpaRepository<RewardExchange, Long> {
    
    List<RewardExchange> findByStudent(Student student);
    
    List<RewardExchange> findByReward(Reward reward);
    
    List<RewardExchange> findByStatus(String status);
    
    List<RewardExchange> findByFulfilledBy(Staff staff);
    
    List<RewardExchange> findByExchangedAtBetween(LocalDateTime start, LocalDateTime end);
    
    List<RewardExchange> findByStudentAndStatus(Student student, String status);
    
    @Query("SELECT SUM(re.pointsSpent) FROM RewardExchange re WHERE re.student = :student")
    Integer getTotalPointsSpentByStudent(@Param("student") Student student);
    
    @Query("SELECT re FROM RewardExchange re WHERE re.student = :student ORDER BY re.exchangedAt DESC")
    List<RewardExchange> findRecentExchangesByStudent(@Param("student") Student student);
}