package studentplatform.student_platform.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import studentplatform.student_platform.model.Activity;

import java.util.List;

@Repository
public interface ActivityRepository extends JpaRepository<Activity, Long> {

    List<Activity> findByClubId(Long clubId);

    List<Activity> findByCreatedById(Long adminId);

    List<Activity> findByTitleContainingIgnoreCase(String title);

    List<Activity> findByClubNameContainingIgnoreCase(String clubName);
}
