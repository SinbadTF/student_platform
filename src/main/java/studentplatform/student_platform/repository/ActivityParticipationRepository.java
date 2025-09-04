package studentplatform.student_platform.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import studentplatform.student_platform.model.Activity;
import studentplatform.student_platform.model.ActivityParticipation;
import studentplatform.student_platform.model.ActivityParticipation.ParticipationStatus;
import studentplatform.student_platform.model.Student;

import java.util.List;

@Repository
public interface ActivityParticipationRepository extends JpaRepository<ActivityParticipation, Long> {

    List<ActivityParticipation> findByStudent(Student student);

    List<ActivityParticipation> findByActivity(Activity activity);
    
    void deleteByActivity(Activity activity);

    List<ActivityParticipation> findByStatus(ParticipationStatus status);

    List<ActivityParticipation> findByActivityAndStatus(Activity activity, ParticipationStatus status);

    List<ActivityParticipation> findByStudentAndStatus(Student student, ParticipationStatus status);

    boolean existsByStudentAndActivity(Student student, Activity activity);

    @Query("SELECT ap FROM ActivityParticipation ap WHERE ap.student = :student AND ap.status = 'APPROVED'")
    List<ActivityParticipation> findApprovedParticipationsByStudent(@Param("student") Student student);
}