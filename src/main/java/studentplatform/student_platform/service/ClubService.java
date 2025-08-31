package studentplatform.student_platform.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import studentplatform.student_platform.model.Club;
import studentplatform.student_platform.model.Admin;
import studentplatform.student_platform.repository.ClubRepository;

import java.util.List;
import java.util.Optional;

@Service
public class ClubService {
    
    @Autowired
    private ClubRepository clubRepository;
    
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
    
    public void deleteClub(Long id) {
        clubRepository.deleteById(id);
    }
}
