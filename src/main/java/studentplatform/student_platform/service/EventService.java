package studentplatform.student_platform.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import studentplatform.student_platform.model.Admin;
import studentplatform.student_platform.model.Event;
import studentplatform.student_platform.model.EventParticipation;
import studentplatform.student_platform.model.EventParticipation.ParticipationStatus;
import studentplatform.student_platform.model.Student;
import studentplatform.student_platform.repository.EventParticipationRepository;
import studentplatform.student_platform.repository.EventRepository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class EventService {

    private final EventRepository eventRepository;
    private final EventParticipationRepository participationRepository;
    private final StudentService studentService;

    @Autowired
    public EventService(EventRepository eventRepository,
                        EventParticipationRepository participationRepository,
                        StudentService studentService) {
        this.eventRepository = eventRepository;
        this.participationRepository = participationRepository;
        this.studentService = studentService;
    }

    public List<Event> getAllEvents() {
        return eventRepository.findAll();
    }

    public Optional<Event> getEventById(Long id) {
        return eventRepository.findById(id);
    }

    public Event saveEvent(Event event) {
        return eventRepository.save(event);
    }

    public void deleteEvent(Long id) {
        eventRepository.deleteById(id);
    }

    // Participation management
    public EventParticipation registerForEvent(Student student, Event event) {
        LocalDateTime now = LocalDateTime.now();
        
        // Check if event times are valid
        if (event.getStartTime() == null || event.getEndTime() == null) {
            return null;
        }
        
        if (now.isBefore(event.getStartTime()) || now.isAfter(event.getEndTime())) {
            return null;
        }

        Optional<EventParticipation> existing = participationRepository.findByStudentAndEvent(student, event);
        if (existing.isPresent()) {
            return existing.get();
        }

        EventParticipation participation = new EventParticipation();
        participation.setStudent(student);
        participation.setEvent(event);
        participation.setRegisteredAt(LocalDateTime.now());
        participation.setStatus(ParticipationStatus.PENDING);
        return participationRepository.save(participation);
    }

    public List<EventParticipation> getPendingParticipations() {
        return participationRepository.findByStatus(ParticipationStatus.PENDING);
    }

    public List<EventParticipation> getPendingParticipationsByEvent(Event event) {
        return participationRepository.findByEventAndStatus(event, ParticipationStatus.PENDING);
    }

    public EventParticipation approveParticipation(Long participationId, Admin admin) {
        return participationRepository.findById(participationId).map(p -> {
            p.setStatus(ParticipationStatus.APPROVED);
            p.setApprovedAt(LocalDateTime.now());
            p.setApprovedBy(admin);
            return participationRepository.save(p);
        }).orElse(null);
    }

    public EventParticipation rejectParticipation(Long participationId, Admin admin) {
        return participationRepository.findById(participationId).map(p -> {
            p.setStatus(ParticipationStatus.REJECTED);
            p.setApprovedAt(LocalDateTime.now());
            p.setApprovedBy(admin);
            return participationRepository.save(p);
        }).orElse(null);
    }

    public Object approveParticipationsByEvent(Event event) {
        // Return approved participations list; kept signature for compatibility with view usage
        return participationRepository.findByEventAndStatus(event, ParticipationStatus.APPROVED);
    }

    public void awardPointsForParticipation(EventParticipation participation) {
        System.out.println("Attempting to award points for participation " + participation.getId());
        System.out.println("Status: " + participation.getStatus() + ", Points already awarded: " + participation.isPointsAwarded());
        
        if (participation.getStatus() == ParticipationStatus.APPROVED && !participation.isPointsAwarded()) {
            Event event = participation.getEvent();
            Student student = participation.getStudent();
            
            System.out.println("Awarding " + event.getPointValue() + " points to student " + student.getId() + " (" + student.getUsername() + ")");
            System.out.println("Student current points: " + student.getPoints());
            
            // Award points to student
            Student updatedStudent = studentService.addPointsToStudent(student.getId(), event.getPointValue(), "Participation in event: " + event.getName());
            
            if (updatedStudent != null) {
                System.out.println("Student points updated successfully. New total: " + updatedStudent.getPoints());
                
                // Verify the points were actually saved by re-fetching from database
                Student verifyStudent = studentService.getStudentById(updatedStudent.getId()).orElse(null);
                if (verifyStudent != null) {
                    System.out.println("Database verification - Student points: " + verifyStudent.getPoints());
                    if (verifyStudent.getPoints().equals(updatedStudent.getPoints())) {
                        System.out.println("✅ Database update confirmed - Points successfully saved!");
                    } else {
                        System.err.println("❌ Database update failed - Points mismatch!");
                    }
                }
                
                // Mark participation as points awarded
                participation.setPointsAwarded(true);
                participationRepository.save(participation);
                System.out.println("Participation marked as points awarded");
            } else {
                System.err.println("Failed to update student points");
            }
        } else {
            if (participation.getStatus() != ParticipationStatus.APPROVED) {
                System.out.println("Participation not approved. Status: " + participation.getStatus());
            }
            if (participation.isPointsAwarded()) {
                System.out.println("Points already awarded for this participation");
            }
        }
    }

    // Manual method to trigger point awarding (for testing)
    public void manuallyAwardPointsForEndedEvents() {
        System.out.println("=== Manual Point Awarding Triggered ===");
        awardPointsForEndedEvents();
    }
    
    // Method to check current point status for all students
    public void checkAllStudentPoints() {
        System.out.println("=== Checking All Student Points ===");
        List<EventParticipation> allParticipations = participationRepository.findAll();
        
        for (EventParticipation p : allParticipations) {
            if (p.getEvent() != null && p.getStudent() != null) {
                System.out.println("Participation ID: " + p.getId());
                System.out.println("  Event: " + p.getEvent().getName() + " (Points: " + p.getEvent().getPointValue() + ")");
                System.out.println("  Student: " + p.getStudent().getUsername());
                System.out.println("  Status: " + p.getStatus());
                System.out.println("  Points Awarded: " + p.isPointsAwarded());
                System.out.println("  Student Current Points: " + p.getStudent().getPoints());
                System.out.println("  ---");
            }
        }
        System.out.println("=== End of Student Points Check ===");
    }
    
    // Method to check for events that should have awarded points
    public void checkPendingPointAwards() {
        System.out.println("=== Checking for Pending Point Awards ===");
        LocalDateTime now = LocalDateTime.now();
        
        List<EventParticipation> approvedWithoutPoints = 
                participationRepository.findApprovedParticipationsWithoutPoints(ParticipationStatus.APPROVED);
        
        System.out.println("Found " + approvedWithoutPoints.size() + " approved participations without points");
        
        for (EventParticipation p : approvedWithoutPoints) {
            Event event = p.getEvent();
            if (event != null && event.getEndTime() != null) {
                boolean eventEnded = event.getEndTime().isBefore(now) || event.getEndTime().isEqual(now);
                System.out.println("Participation " + p.getId() + " for event '" + event.getName() + "'");
                System.out.println("  Event end time: " + event.getEndTime());
                System.out.println("  Current time: " + now);
                System.out.println("  Event ended: " + eventEnded);
                System.out.println("  Should award points: " + (eventEnded ? "YES" : "NO"));
                System.out.println("  ---");
            }
        }
        System.out.println("=== End of Pending Point Awards Check ===");
    }
    
    // Run every 60 seconds to award points after events end
    @Scheduled(fixedDelay = 60000)
    public void awardPointsForEndedEvents() {
        try {
            LocalDateTime now = LocalDateTime.now();
            System.out.println("=== Scheduled Task Running at: " + now + " ===");
            
            List<EventParticipation> approvedWithoutPoints =
                    participationRepository.findApprovedParticipationsWithoutPoints(ParticipationStatus.APPROVED);
            
            System.out.println("Found " + approvedWithoutPoints.size() + " approved participations without points");
            
            for (EventParticipation p : approvedWithoutPoints) {
                try {
                    Event event = p.getEvent();
                    System.out.println("Checking participation " + p.getId() + " for event: " + 
                                    (event != null ? event.getName() : "NULL") + 
                                    ", Event end time: " + (event != null ? event.getEndTime() : "NULL") +
                                    ", Current time: " + now +
                                    ", Points awarded: " + p.isPointsAwarded());
                    
                    if (event != null && event.getEndTime() != null && !p.isPointsAwarded()
                            && (event.getEndTime().isBefore(now) || event.getEndTime().isEqual(now))) {
                        System.out.println("Awarding points for participation " + p.getId());
                        awardPointsForParticipation(p);
                        System.out.println("Points awarded successfully for participation " + p.getId());
                    } else {
                        if (event == null) {
                            System.out.println("Event is null for participation " + p.getId());
                        } else if (event.getEndTime() == null) {
                            System.out.println("Event end time is null for event " + event.getName());
                        } else if (p.isPointsAwarded()) {
                            System.out.println("Points already awarded for participation " + p.getId());
                        } else if (!event.getEndTime().isBefore(now) && !event.getEndTime().isEqual(now)) {
                            System.out.println("Event has not ended yet for participation " + p.getId());
                        }
                    }
                } catch (Exception e) {
                    // Log individual participation processing errors but continue with others
                    System.err.println("Error processing participation " + p.getId() + ": " + e.getMessage());
                    e.printStackTrace();
                }
            }
            System.out.println("=== Scheduled Task Completed ===");
        } catch (Exception e) {
            // Log overall scheduled task errors
            System.err.println("Error in awardPointsForEndedEvents: " + e.getMessage());
            e.printStackTrace();
        }
    }
}


