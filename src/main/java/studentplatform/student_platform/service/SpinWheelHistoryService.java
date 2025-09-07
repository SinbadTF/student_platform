package studentplatform.student_platform.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import studentplatform.student_platform.model.SpinWheel;
import studentplatform.student_platform.model.SpinWheelHistory;
import studentplatform.student_platform.model.SpinWheelItem;
import studentplatform.student_platform.model.Student;
import studentplatform.student_platform.repository.SpinWheelHistoryRepository;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class SpinWheelHistoryService {

    private final SpinWheelHistoryRepository spinWheelHistoryRepository;
    private final StudentService studentService;

    @Autowired
    public SpinWheelHistoryService(SpinWheelHistoryRepository spinWheelHistoryRepository, 
                                   StudentService studentService) {
        this.spinWheelHistoryRepository = spinWheelHistoryRepository;
        this.studentService = studentService;
    }

    public SpinWheelHistory recordSpin(Student student, SpinWheel spinWheel, SpinWheelItem resultItem) {
        SpinWheelHistory history = new SpinWheelHistory();
        history.setStudent(student);
        history.setSpinWheel(spinWheel);
        history.setResultItem(resultItem);
        history.setPointsAwarded(resultItem.getPointValue());
        history.setSpunAt(LocalDateTime.now());
        
        SpinWheelHistory savedHistory = spinWheelHistoryRepository.save(history);
        
        // Award points to the student
        studentService.addPoints(student.getId(), resultItem.getPointValue());
        
        return savedHistory;
    }

    public boolean hasStudentSpunToday(Student student) {
        LocalDate today = LocalDate.now();
        LocalDateTime startOfDay = today.atStartOfDay();
        LocalDateTime endOfDay = today.plusDays(1).atStartOfDay();
        
        List<SpinWheelHistory> todaySpins = spinWheelHistoryRepository
            .findByStudentAndSpunAtBetween(student, startOfDay, endOfDay);
        
        return !todaySpins.isEmpty();
    }
    
    public boolean hasStudentSpunSpinWheelToday(Student student, SpinWheel spinWheel) {
        LocalDate today = LocalDate.now();
        LocalDateTime startOfDay = today.atStartOfDay();
        LocalDateTime endOfDay = today.plusDays(1).atStartOfDay();
        
        List<SpinWheelHistory> todaySpins = spinWheelHistoryRepository
            .findByStudentAndSpinWheelAndSpunAtBetween(student, spinWheel, startOfDay, endOfDay);
        
        return !todaySpins.isEmpty();
    }
    
    public int getTodaySpinCount(Student student, SpinWheel spinWheel) {
        LocalDate today = LocalDate.now();
        LocalDateTime startOfDay = today.atStartOfDay();
        LocalDateTime endOfDay = today.plusDays(1).atStartOfDay();
        
        List<SpinWheelHistory> todaySpins = spinWheelHistoryRepository
            .findByStudentAndSpinWheelAndSpunAtBetween(student, spinWheel, startOfDay, endOfDay);
        return todaySpins != null ? todaySpins.size() : 0;
    }

    // (restored) No cooldown logic in original code

    public List<SpinWheelHistory> getHistoryByStudent(Student student) {
        return spinWheelHistoryRepository.findByStudentOrderBySpunAtDesc(student);
    }

    public List<SpinWheelHistory> getHistoryBySpinWheel(SpinWheel spinWheel) {
        return spinWheelHistoryRepository.findBySpinWheelOrderBySpunAtDesc(spinWheel);
    }

    public Optional<SpinWheelHistory> getHistoryById(Long id) {
        return spinWheelHistoryRepository.findById(id);
    }

    public List<SpinWheelHistory> getAllHistory() {
        return spinWheelHistoryRepository.findAll();
    }
    
    public void deleteSpinWheelHistory(Long id) {
        Optional<SpinWheelHistory> historyOpt = spinWheelHistoryRepository.findById(id);
        if (historyOpt.isPresent()) {
            SpinWheelHistory history = historyOpt.get();
            
            // Deduct points from student before deleting history
            studentService.deductPoints(history.getStudent().getId(), history.getPointsAwarded());
            
            // Delete the history record
            spinWheelHistoryRepository.deleteById(id);
        }
    }
    
    public void deleteAllHistoryBySpinWheel(Long spinWheelId) {
        // Get all history records for this spinwheel
        List<SpinWheelHistory> histories = spinWheelHistoryRepository.findBySpinWheelOrderBySpunAtDesc(
            new SpinWheel() {{ setId(spinWheelId); }}
        );
        
        // Deduct points for each history record before deleting
        for (SpinWheelHistory history : histories) {
            studentService.deductPoints(history.getStudent().getId(), history.getPointsAwarded());
        }
        
        // Delete all history records for this spinwheel
        spinWheelHistoryRepository.deleteAll(histories);
    }
    
    public void deleteAllHistoryByStudent(Long studentId) {
        // Get all history records for this student
        List<SpinWheelHistory> histories = spinWheelHistoryRepository.findByStudent(
            new Student() {{ setId(studentId); }}
        );
        
        // Deduct points for each history record before deleting
        for (SpinWheelHistory history : histories) {
            studentService.deductPoints(history.getStudent().getId(), history.getPointsAwarded());
        }
        
        // Delete all history records for this student
        spinWheelHistoryRepository.deleteAll(histories);
    }
}