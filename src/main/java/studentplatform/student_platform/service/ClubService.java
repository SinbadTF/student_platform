package studentplatform.student_platform.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import studentplatform.student_platform.model.Club;
import studentplatform.student_platform.model.Admin;
import studentplatform.student_platform.model.Student;
import studentplatform.student_platform.model.ClubMembership;
import studentplatform.student_platform.model.Activity;
import studentplatform.student_platform.repository.ClubRepository;
import studentplatform.student_platform.repository.ClubMembershipRepository;
import studentplatform.student_platform.repository.ActivityRepository;
import studentplatform.student_platform.repository.ActivityParticipationRepository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class ClubService {
    
    @Autowired
    private ClubRepository clubRepository;
    
    @Autowired
    private ClubMembershipRepository clubMembershipRepository;
    
    @Autowired
    private ActivityRepository activityRepository;
    
    @Autowired
    private ActivityParticipationRepository activityParticipationRepository;
    
    public Club createClub(Club club, Admin admin) {
        club.setCreatedBy(admin);
        return clubRepository.save(club);
    }
    
    public List<Club> getAllClubs() {
        return clubRepository.findAll();
    }
    
    public List<Club> getClubsByAdmin(Admin admin) {
        return clubRepository.findByCreatedById(admin.getId());
    }
    
    public Optional<Club> getClubById(Long id) {
        return clubRepository.findById(id);
    }
    
    public List<Club> getClubsByMeetingScheduleTitle(String meetingScheduleTitle) {
        return clubRepository.findByMeetingScheduleTitleContainingIgnoreCase(meetingScheduleTitle);
    }
    
    public List<Club> searchClubsByName(String name) {
        return clubRepository.findByNameContainingIgnoreCase(name);
    }
    
    public Club updateClub(Club club) {
        return clubRepository.save(club);
    }
    
    @org.springframework.transaction.annotation.Transactional
    public void deleteClub(Long id) {
        Optional<Club> clubOpt = clubRepository.findById(id);
        if (clubOpt.isPresent()) {
            Club club = clubOpt.get();
            
            // First, delete all activities associated with this club
            List<Activity> activities = activityRepository.findByClubId(club.getId());
            for (Activity activity : activities) {
                // Delete all participations for each activity
                activityParticipationRepository.deleteByActivity(activity);
            }
            activityRepository.deleteAll(activities);
            
            // Then, delete all club memberships for this club
            List<ClubMembership> memberships = clubMembershipRepository.findByClub(club);
            clubMembershipRepository.deleteAll(memberships);
            
            // Finally delete the club
            clubRepository.deleteById(id);
        } else {
            clubRepository.deleteById(id);
        }
    }
    
    // Club Membership Methods
    public ClubMembership joinClub(Student student, Club club) {
        // Check if student already has an active membership
        Optional<ClubMembership> existingMembership = clubMembershipRepository.findByStudentAndClub(student, club);
        
        if (existingMembership.isPresent()) {
            ClubMembership membership = existingMembership.get();
            
            // If membership exists but is inactive, reactivate it
            if (membership.getStatus() == ClubMembership.MembershipStatus.INACTIVE) {
                membership.setStatus(ClubMembership.MembershipStatus.ACTIVE);
                membership.setJoinedAt(LocalDateTime.now()); // Update join date
                return clubMembershipRepository.save(membership);
            } else if (membership.getStatus() == ClubMembership.MembershipStatus.ACTIVE) {
                // If already active, throw error
                throw new IllegalStateException("Student is already a member of this club");
            }
        }
        
        // Create new membership if none exists
        ClubMembership membership = new ClubMembership();
        membership.setStudent(student);
        membership.setClub(club);
        membership.setJoinedAt(LocalDateTime.now());
        membership.setStatus(ClubMembership.MembershipStatus.ACTIVE);
        
        return clubMembershipRepository.save(membership);
    }
    
    public List<ClubMembership> getMembershipsByStudent(Student student) {
        return clubMembershipRepository.findByStudent(student);
    }
    
    public List<ClubMembership> getActiveMembershipsByStudent(Student student) {
        return clubMembershipRepository.findActiveMembershipsByStudent(student);
    }
    
    public List<ClubMembership> getMembershipsByClub(Club club) {
        return clubMembershipRepository.findByClub(club);
    }
    
    public List<ClubMembership> getActiveMembershipsByClub(Club club) {
        return clubMembershipRepository.findActiveMembershipsByClub(club);
    }
    
    public Optional<ClubMembership> getMembershipByStudentAndClub(Student student, Club club) {
        return clubMembershipRepository.findByStudentAndClub(student, club);
    }
    
    public boolean isStudentMemberOfClub(Student student, Club club) {
        Optional<ClubMembership> membershipOpt = clubMembershipRepository.findByStudentAndClub(student, club);
        return membershipOpt.isPresent() && membershipOpt.get().getStatus() == ClubMembership.MembershipStatus.ACTIVE;
    }
    
    public Optional<ClubMembership> getMembershipById(Long id) {
        return clubMembershipRepository.findById(id);
    }
    
    public void quitClub(Student student, Club club) {
        Optional<ClubMembership> membershipOpt = clubMembershipRepository.findByStudentAndClub(student, club);
        if (membershipOpt.isPresent()) {
            ClubMembership membership = membershipOpt.get();
            // Set status to INACTIVE instead of deleting to maintain history
            membership.setStatus(ClubMembership.MembershipStatus.INACTIVE);
            clubMembershipRepository.save(membership);
        } else {
            throw new IllegalStateException("Student is not a member of this club");
        }
    }
}
