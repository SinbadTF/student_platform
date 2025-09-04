package studentplatform.student_platform.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import studentplatform.student_platform.model.Club;
import studentplatform.student_platform.model.ClubMembership;
import studentplatform.student_platform.model.ClubMembership.MembershipStatus;
import studentplatform.student_platform.model.Student;

import java.util.List;
import java.util.Optional;

@Repository
public interface ClubMembershipRepository extends JpaRepository<ClubMembership, Long> {

    List<ClubMembership> findByStudent(Student student);

    List<ClubMembership> findByClub(Club club);

    List<ClubMembership> findByStatus(MembershipStatus status);

    List<ClubMembership> findByClubAndStatus(Club club, MembershipStatus status);

    List<ClubMembership> findByStudentAndStatus(Student student, MembershipStatus status);

    Optional<ClubMembership> findByStudentAndClub(Student student, Club club);

    @Query("SELECT cm FROM ClubMembership cm WHERE cm.student = :student AND cm.status = 'ACTIVE'")
    List<ClubMembership> findActiveMembershipsByStudent(@Param("student") Student student);

    @Query("SELECT cm FROM ClubMembership cm WHERE cm.club = :club AND cm.status = 'ACTIVE'")
    List<ClubMembership> findActiveMembershipsByClub(@Param("club") Club club);

    boolean existsByStudentAndClub(Student student, Club club);
}
