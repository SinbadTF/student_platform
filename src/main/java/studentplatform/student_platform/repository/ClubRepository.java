package studentplatform.student_platform.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import studentplatform.student_platform.model.Club;

import java.util.List;

@Repository
public interface ClubRepository extends JpaRepository<Club, Long> {
    
    List<Club> findByCreatedById(Long adminId);
    
    List<Club> findByMeetingScheduleTitleContainingIgnoreCase(String meetingScheduleTitle);
    
    List<Club> findByNameContainingIgnoreCase(String name);
}
