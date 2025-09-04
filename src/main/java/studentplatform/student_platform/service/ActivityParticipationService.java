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

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import org.springframework.scheduling.annotation.Scheduled;
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
    
    public List<ActivityParticipation> getParticipationsByStatus(ParticipationStatus status) {
        return activityParticipationRepository.findByStatus(status);
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

    /**
     * Scheduled task: Award points automatically for activities that have ended.
     * Runs every minute. For each participation that is still PENDING and whose activity
     * end time has passed, mark as APPROVED and credit points to the student once.
     */
    @Scheduled(fixedDelay = 60_000)
    public void awardPointsForEndedActivities() {
        try {
            // Fetch all pending participations
            List<ActivityParticipation> pending = activityParticipationRepository.findByStatus(ParticipationStatus.PENDING);
            if (pending == null || pending.isEmpty()) {
                return;
            }

            LocalDateTime now = LocalDateTime.now();
            for (ActivityParticipation participation : pending) {
                Activity activity = participation.getActivity();
                if (activity == null) {
                    continue;
                }

                try {
                    String dateStr = activity.getClubDate();
                    String endStr = activity.getEndTime();
                    if (dateStr == null || endStr == null || dateStr.isBlank() || endStr.isBlank()) {
                        continue;
                    }

                    LocalDate date = LocalDate.parse(dateStr);
                    LocalTime end = LocalTime.parse(endStr);
                    LocalDateTime endAt = LocalDateTime.of(date, end);

                    if (now.isAfter(endAt)) {
                        // Award if not yet awarded
                        Integer already = participation.getPointsEarned();
                        if (already == null || already == 0) {
                            int points = activity.getPoints() != null ? activity.getPoints() : 0;
                            participation.setStatus(ParticipationStatus.APPROVED);
                            participation.setApprovedAt(now);
                            participation.setApprovedBy(null);
                            participation.setPointsEarned(points);
                            activityParticipationRepository.save(participation);

                            if (points > 0) {
                                try {
                                    studentService.addPointsToStudent(participation.getStudent().getId(), points, "Activity completed: " + activity.getTitle());
                                } catch (Exception ignore) {}
                            }
                        }
                    }
                } catch (Exception ignore) {
                    // Ignore parsing issues and continue
                }
            }
        } catch (Exception ignoreOuter) {
            // Swallow errors to keep scheduler resilient
        }
    }
}