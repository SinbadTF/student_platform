package studentplatform.student_platform.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import studentplatform.student_platform.model.Admin;
import studentplatform.student_platform.model.Club;
import studentplatform.student_platform.model.ClubParticipation;
import studentplatform.student_platform.model.ClubParticipation.ParticipationStatus;
import studentplatform.student_platform.model.Point;
import studentplatform.student_platform.model.Student;
import studentplatform.student_platform.repository.ClubParticipationRepository;
import studentplatform.student_platform.repository.ClubRepository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class ClubService {

    private final ClubRepository clubRepository;
    private final ClubParticipationRepository participationRepository;
    private final PointService pointService;

    @Autowired
    public ClubService(ClubRepository clubRepository, 
                       ClubParticipationRepository participationRepository,
                       PointService pointService) {
        this.clubRepository = clubRepository;
        this.participationRepository = participationRepository;
        this.pointService = pointService;
    }

    public List<Club> getAllClubs() {
        return clubRepository.findAll();
    }

    public Optional<Club> getClubById(Long id) {
        return clubRepository.findById(id);
    }

    public List<Club> getClubsByName(String name) {
        return clubRepository.findByName(name);
    }

    public List<Club> getClubsByAdmin(Admin admin) {
        return clubRepository.findByCreatedBy(admin);
    }

    public List<Club> searchClubsByKeyword(String keyword) {
        return clubRepository.searchByKeyword(keyword);
    }

    public Club saveClub(Club club) {
        return clubRepository.save(club);
    }

    public void deleteClub(Long id) {
        clubRepository.deleteById(id);
    }
    
    // Participation management
    public ClubParticipation joinClub(Student student, Club club) {
        // Check if student is already a member
        Optional<ClubParticipation> existingParticipation = 
            participationRepository.findByStudentAndClub(student, club);
        
        if (existingParticipation.isPresent()) {
            return existingParticipation.get();
        }
        
        // Create new participation
        ClubParticipation participation = new ClubParticipation();
        participation.setStudent(student);
        participation.setClub(club);
        participation.setJoinedAt(LocalDateTime.now());
        participation.setStatus(ParticipationStatus.PENDING);
        
        return participationRepository.save(participation);
    }
    
    public List<ClubParticipation> getPendingParticipations() {
        return participationRepository.findByStatus(ParticipationStatus.PENDING);
    }
    
    public List<ClubParticipation> getPendingParticipationsByClub(Club club) {
        return participationRepository.findByClubAndStatus(club, ParticipationStatus.PENDING);
    }
    
    public ClubParticipation approveParticipation(Long participationId, Admin admin) {
        Optional<ClubParticipation> optionalParticipation = participationRepository.findById(participationId);
        
        if (optionalParticipation.isPresent()) {
            ClubParticipation participation = optionalParticipation.get();
            participation.setStatus(ParticipationStatus.APPROVED);
            participation.setApprovedAt(LocalDateTime.now());
            participation.setApprovedBy(admin);
            
            return participationRepository.save(participation);
        }
        
        return null;
    }
    
    public ClubParticipation rejectParticipation(Long participationId, Admin admin) {
        Optional<ClubParticipation> optionalParticipation = participationRepository.findById(participationId);
        
        if (optionalParticipation.isPresent()) {
            ClubParticipation participation = optionalParticipation.get();
            participation.setStatus(ParticipationStatus.REJECTED);
            participation.setApprovedAt(LocalDateTime.now());
            participation.setApprovedBy(admin);
            
            return participationRepository.save(participation);
        }
        
        return null;
    }
    
    public Point awardPointsForParticipation(ClubParticipation participation, int pointValue, String reason) {
        if (participation.getStatus() == ParticipationStatus.APPROVED && !participation.isPointsAwarded()) {
            // Create a point record
            Point point = new Point();
            point.setValue(pointValue);
            point.setReason(reason);
            point.setIssuedAt(LocalDateTime.now());
            point.setStudent(participation.getStudent());
            // Remove or comment out the problematic line:
            // point.setIssuedBy(participation.getApprovedBy());
            
            // Save the point
            Point savedPoint = pointService.awardPointsToStudent(point);
            
            // Mark participation as having points awarded
            participation.setPointsAwarded(true);
            participationRepository.save(participation);
            
            return savedPoint;
        }
        
        return null;
    }
    
    public List<ClubParticipation> getApprovedParticipationsByStudent(Student student) {
        return participationRepository.findByStudentAndStatus(student, ParticipationStatus.APPROVED);
    }
    
    public List<ClubParticipation> getApprovedParticipationsByClub(Club club) {
        return participationRepository.findByClubAndStatus(club, ParticipationStatus.APPROVED);
    }
}