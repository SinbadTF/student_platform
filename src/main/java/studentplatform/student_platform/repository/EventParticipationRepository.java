package studentplatform.student_platform.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import studentplatform.student_platform.model.Event;
import studentplatform.student_platform.model.EventParticipation;
import studentplatform.student_platform.model.EventParticipation.ParticipationStatus;
import studentplatform.student_platform.model.Student;

import java.util.List;
import java.util.Optional;

@Repository
public interface EventParticipationRepository extends JpaRepository<EventParticipation, Long> {
    
    List<EventParticipation> findByStudent(Student student);
    
    List<EventParticipation> findByEvent(Event event);
    
    List<EventParticipation> findByStatus(ParticipationStatus status);
    
    List<EventParticipation> findByEventAndStatus(Event event, ParticipationStatus status);
    
    List<EventParticipation> findByStudentAndStatus(Student student, ParticipationStatus status);
    
    Optional<EventParticipation> findByStudentAndEvent(Student student, Event event);
    
    @Query("SELECT ep FROM EventParticipation ep WHERE ep.status = :status AND ep.pointsAwarded = false")
    List<EventParticipation> findApprovedParticipationsWithoutPoints(@Param("status") ParticipationStatus status);
}