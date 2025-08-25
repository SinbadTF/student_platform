package studentplatform.student_platform.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import studentplatform.student_platform.model.Reward;
import studentplatform.student_platform.model.Staff;
import studentplatform.student_platform.model.Student;

import java.util.List;
import java.util.Optional;

@Repository
public interface RewardRepository extends JpaRepository<Reward, Long> {
    
    List<Reward> findByName(String name);
    
    List<Reward> findByPointValueGreaterThanEqual(Integer pointValue);
    
    List<Reward> findByPointValueLessThanEqual(Integer pointValue);
    
    List<Reward> findByIssuedBy(Staff staff);
    
   
    @Query("SELECT r FROM Reward r WHERE r.name LIKE %:keyword% OR r.description LIKE %:keyword%")
    List<Reward> searchByKeyword(@Param("keyword") String keyword);

    // Remove this line:
    // List<Reward> findByReceivedBy(Student student);
}