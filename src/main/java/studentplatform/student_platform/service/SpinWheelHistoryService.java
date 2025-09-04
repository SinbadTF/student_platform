package studentplatform.student_platform.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import studentplatform.student_platform.model.SpinWheel;
import studentplatform.student_platform.model.SpinWheelHistory;
import studentplatform.student_platform.model.SpinWheelItem;
import studentplatform.student_platform.model.Student;
import studentplatform.student_platform.repository.SpinWheelHistoryRepository;
import studentplatform.student_platform.service.StudentService;
import studentplatform.student_platform.model.PointTransaction;
import studentplatform.student_platform.repository.PointTransactionRepository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class SpinWheelHistoryService {

    private final SpinWheelHistoryRepository spinWheelHistoryRepository;
    private final StudentService studentService;
    private final PointTransactionRepository pointTransactionRepository;

    @Autowired
    public SpinWheelHistoryService(SpinWheelHistoryRepository spinWheelHistoryRepository, 
                                   StudentService studentService,
                                   PointTransactionRepository pointTransactionRepository) {
        this.spinWheelHistoryRepository = spinWheelHistoryRepository;
        this.studentService = studentService;
        this.pointTransactionRepository = pointTransactionRepository;
    }

    public List<SpinWheelHistory> getAllSpinHistory() {
        return spinWheelHistoryRepository.findAll();
    }

    public List<SpinWheelHistory> getHistoryByStudent(Student student) {
        return spinWheelHistoryRepository.findByStudent(student);
    }

    public List<SpinWheelHistory> getHistoryBySpinWheel(SpinWheel spinWheel) {
        return spinWheelHistoryRepository.findBySpinWheel(spinWheel);
    }

    public List<SpinWheelHistory> getRecentSpinsByStudent(Student student) {
        return spinWheelHistoryRepository.findRecentSpinsByStudent(student);
    }

    public Optional<SpinWheelHistory> getLastSpinByStudent(Student student) {
        return spinWheelHistoryRepository.findFirstByStudentOrderBySpunAtDesc(student);
    }

    public boolean hasStudentSpunToday(Student student) {
        return spinWheelHistoryRepository.hasStudentSpunToday(student);
    }

    /**
     * Records a new spin result and awards points to the student
     */
    public SpinWheelHistory recordSpin(Student student, SpinWheel spinWheel, SpinWheelItem resultItem) {
        // Check if student has already spun today
        if (hasStudentSpunToday(student)) {
            throw new IllegalStateException("Student has already spun the wheel today");
        }

        // Create spin history record
        SpinWheelHistory history = new SpinWheelHistory();
        history.setStudent(student);
        history.setSpinWheel(spinWheel);
        history.setResultItem(resultItem);
        history.setPointsAwarded(resultItem.getPointValue());
        history.setSpunAt(LocalDateTime.now());

        // Save the history record
        SpinWheelHistory savedHistory = spinWheelHistoryRepository.save(history);

        // Award points to student and record a transaction
        Integer current = student.getPoints() != null ? student.getPoints() : 0;
        Integer awarded = resultItem.getPointValue();
        Integer newBalance = current + awarded;
        student.setPoints(newBalance);
        studentService.saveStudent(student);

        PointTransaction tx = new PointTransaction();
        tx.setStudent(student);
        tx.setPointsAmount(awarded);
        tx.setPointsBalance(newBalance);
        tx.setReason("SpinWheel: " + (resultItem.getLabel() != null ? resultItem.getLabel() : "Reward"));
        tx.setType(PointTransaction.TransactionType.EARNED);
        tx.setSourceType(PointTransaction.SourceType.MANUAL);
        tx.setSourceId(spinWheel.getId());
        pointTransactionRepository.save(tx);

        return savedHistory;
    }

    public SpinWheelHistory saveSpinWheelHistory(SpinWheelHistory history) {
        return spinWheelHistoryRepository.save(history);
    }
}
