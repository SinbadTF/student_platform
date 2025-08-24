package studentplatform.student_platform.service;

import org.springframework.beans.factory.annotation.Autowired;
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
    // Replace PointService with StudentService
    private final StudentService studentService;

    @Autowired
    public EventService(EventRepository eventRepository, 
                        EventParticipationRepository participationRepository,
                        // Replace PointService with StudentService
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

    public List<Event> getEventsByName(String name) {
        return eventRepository.findByName(name);
    }

    public List<Event> getEventsByAdmin(Admin admin) {
        return eventRepository.findByCreatedBy(admin);
    }
    

    public List<Event> searchEventsByKeyword(String keyword) {
        return eventRepository.searchByKeyword(keyword);
    }

    public Event saveEvent(Event event) {
        return eventRepository.save(event);
    }

    public void deleteEvent(Long id) {
        eventRepository.deleteById(id);
    }
    
    // Participation management
    public EventParticipation registerForEvent(Student student, Event event) {
        // Check if student is already registered
        Optional<EventParticipation> existingParticipation = 
            participationRepository.findByStudentAndEvent(student, event);
        
        if (existingParticipation.isPresent()) {
            return existingParticipation.get();
        }
        
        // Create new participation
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
        Optional<EventParticipation> optionalParticipation = participationRepository.findById(participationId);
        
        if (optionalParticipation.isPresent()) {
            EventParticipation participation = optionalParticipation.get();
            participation.setStatus(ParticipationStatus.APPROVED);
            participation.setApprovedAt(LocalDateTime.now());
            participation.setApprovedBy(admin);
            
            return participationRepository.save(participation);
        }
        
        return null;
    }
    
    public EventParticipation rejectParticipation(Long participationId, Admin admin) {
        Optional<EventParticipation> optionalParticipation = participationRepository.findById(participationId);
        
        if (optionalParticipation.isPresent()) {
            EventParticipation participation = optionalParticipation.get();
            participation.setStatus(ParticipationStatus.REJECTED);
            participation.setApprovedAt(LocalDateTime.now());
            participation.setApprovedBy(admin);
            
            return participationRepository.save(participation);
        }
        
        return null;
    }
    
    // Update this method to use StudentService instead of PointService
    public void awardPointsForParticipation(EventParticipation participation) {
        if (participation.getStatus() == ParticipationStatus.APPROVED && !participation.isPointsAwarded()) {
            Event event = participation.getEvent();
            
            // Use StudentService to add points directly
            Student student = participation.getStudent();
            studentService.addPointsToStudent(
                student.getId(), 
                event.getPointValue(), 
                "Participation in event: " + event.getName()
            );
            
            // Mark participation as having points awarded
            participation.setPointsAwarded(true);
            participationRepository.save(participation);
        }
    }

    public Object approveParticipationsByEvent(Event event) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'approveParticipationsByEvent'");
    }
}