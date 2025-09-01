package studentplatform.student_platform.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import studentplatform.student_platform.model.Activity;
import studentplatform.student_platform.model.ActivityParticipation;
import studentplatform.student_platform.model.ActivityParticipation.ParticipationStatus;
import studentplatform.student_platform.model.Admin;
import studentplatform.student_platform.model.Student;
import studentplatform.student_platform.repository.ActivityParticipationRepository;
import studentplatform.student_platform.repository.ActivityRepository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class ActivityParticipationService {

    @Autowired
    private ActivityRepository activityRepository;
    
    @Autowired
    private ActivityParticipationRepository activityParticipationRepository;
    
    @Autowired
    private StudentService studentService;
    
    public ActivityParticipation participateInActivity(Student student, Activity activity) {
        // Check if student is already participating
        if (activityParticipationRepository.existsByStudentAndActivity(student, activity)) {
            throw new IllegalStateException("Student is already participating in this activity");
        }
        
        ActivityParticipation participation = new ActivityParticipation();
        participation.setStudent(student);
        participation.setActivity(activity);
        participation.setParticipatedAt(LocalDateTime.now());
        participation.setStatus(ParticipationStatus.PENDING);
        
        return activityParticipationRepository.save(participation);
    }
    
    public List<ActivityParticipation> getParticipationsByStudent(Student student) {
        return activityParticipationRepository.findByStudent(student);
    }
    
    public List<ActivityParticipation> getApprovedParticipationsByStudent(Student student) {
        return activityParticipationRepository.findApprovedParticipationsByStudent(student);
    }
    
    public List<ActivityParticipation> getParticipationsByActivity(Activity activity) {
        return activityParticipationRepository.findByActivity(activity);
    }
    
    public Optional<ActivityParticipation> getParticipationById(Long id) {
        return activityParticipationRepository.findById(id);
    }
    
    public ActivityParticipation approveParticipation(Long participationId, Admin admin) {
        ActivityParticipation participation = activityParticipationRepository.findById(participationId)
                .orElseThrow(() -> new IllegalArgumentException("Participation not found"));
        
        participation.setStatus(ParticipationStatus.APPROVED);
        participation.setApprovedAt(LocalDateTime.now());
        participation.setApprovedBy(admin);
        participation.setPointsEarned(participation.getActivity().getPoints());
        
        // Add points to student
        studentService.addPointsToStudent(participation.getStudent().getId(), participation.getPointsEarned(), null);
        
        return activityParticipationRepository.save(participation);
    }
    
    public ActivityParticipation rejectParticipation(Long participationId, Admin admin) {
        ActivityParticipation participation = activityParticipationRepository.findById(participationId)
                .orElseThrow(() -> new IllegalArgumentException("Participation not found"));
        
        participation.setStatus(ParticipationStatus.REJECTED);
        participation.setApprovedAt(LocalDateTime.now());
        participation.setApprovedBy(admin);
        
        return activityParticipationRepository.save(participation);
    }
}