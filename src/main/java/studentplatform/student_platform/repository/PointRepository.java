package studentplatform.student_platform.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import studentplatform.student_platform.model.Point;
import studentplatform.student_platform.model.Reward;
import studentplatform.student_platform.model.Staff;
import studentplatform.student_platform.model.Student;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface PointRepository extends JpaRepository<Point, Long> {
    
    List<Point> findByStudent(Student student);
    
    List<Point> findByReward(Reward reward);
    
    List<Point> findByIssuedBy(Staff staff);
    
    List<Point> findByIssuedAtBetween(LocalDateTime start, LocalDateTime end);
    
    @Query("SELECT SUM(p.value) FROM Point p WHERE p.student.id = :studentId")
    Integer getTotalPointsByStudentId(@Param("studentId") Long studentId);
    
    @Query("SELECT p FROM Point p WHERE p.student.id = :studentId ORDER BY p.issuedAt DESC")
    List<Point> findRecentPointsByStudentId(@Param("studentId") Long studentId);
    
    @Query("SELECT p FROM Point p WHERE LOWER(p.reason) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
           "OR LOWER(p.student.firstName) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
           "OR LOWER(p.student.lastName) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
           "OR LOWER(p.issuedBy.firstName) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
           "OR LOWER(p.issuedBy.lastName) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
           "OR LOWER(COALESCE(p.reward.name, '')) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    List<Point> searchPoints(@Param("keyword") String keyword);
}