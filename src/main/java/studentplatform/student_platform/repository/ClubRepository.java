package studentplatform.student_platform.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import studentplatform.student_platform.model.Admin;
import studentplatform.student_platform.model.Club;

import java.util.List;

@Repository
public interface ClubRepository extends JpaRepository<Club, Long> {
    
    List<Club> findByName(String name);
    
    List<Club> findByCreatedBy(Admin admin);
    
    @Query("SELECT c FROM Club c WHERE LOWER(c.name) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
           "OR LOWER(c.description) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    List<Club> searchByKeyword(@Param("keyword") String keyword);
}