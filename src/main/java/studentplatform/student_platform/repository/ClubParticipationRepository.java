package studentplatform.student_platform.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import studentplatform.student_platform.model.Club;
import studentplatform.student_platform.model.ClubParticipation;
import studentplatform.student_platform.model.ClubParticipation.ParticipationStatus;
import studentplatform.student_platform.model.Student;

import java.util.List;
import java.util.Optional;

@Repository
public interface ClubParticipationRepository extends JpaRepository<ClubParticipation, Long> {
    
    List<ClubParticipation> findByStudent(Student student);
    
    List<ClubParticipation> findByClub(Club club);
    
    List<ClubParticipation> findByStatus(ParticipationStatus status);
    
    List<ClubParticipation> findByClubAndStatus(Club club, ParticipationStatus status);
    
    List<ClubParticipation> findByStudentAndStatus(Student student, ParticipationStatus status);
    
    Optional<ClubParticipation> findByStudentAndClub(Student student, Club club);
    
    @Query("SELECT cp FROM ClubParticipation cp WHERE cp.status = :status AND cp.pointsAwarded = false")
    List<ClubParticipation> findApprovedParticipationsWithoutPoints(@Param("status") ParticipationStatus status);
}