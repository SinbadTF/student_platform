package studentplatform.student_platform.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import studentplatform.student_platform.model.Admin;
import studentplatform.student_platform.model.Event;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface EventRepository extends JpaRepository<Event, Long> {
    
    List<Event> findByName(String name);
    
    List<Event> findByCreatedBy(Admin admin);
    
    List<Event> findByStartTimeAfter(LocalDateTime dateTime);
    
    List<Event> findByEndTimeBefore(LocalDateTime dateTime);
    
    List<Event> findByStartTimeBetween(LocalDateTime start, LocalDateTime end);
    
    @Query("SELECT e FROM Event e WHERE LOWER(e.name) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
           "OR LOWER(e.description) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
           "OR LOWER(e.location) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    List<Event> searchByKeyword(@Param("keyword") String keyword);

    
}