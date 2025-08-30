package studentplatform.student_platform.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import studentplatform.student_platform.model.RewardExchange;
import studentplatform.student_platform.model.Reward;
import studentplatform.student_platform.model.Student;
import studentplatform.student_platform.model.Staff;
import studentplatform.student_platform.repository.RewardExchangeRepository;
import studentplatform.student_platform.exception.ResourceNotFoundException;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class RewardExchangeService {

    private final RewardExchangeRepository exchangeRepository;
    private final StudentService studentService;
    private final RewardService rewardService;

    @Autowired
    public RewardExchangeService(RewardExchangeRepository exchangeRepository, 
                                StudentService studentService,
                                RewardService rewardService) {
        this.exchangeRepository = exchangeRepository;
        this.studentService = studentService;
        this.rewardService = rewardService;
    }

    public List<RewardExchange> getAllExchanges() {
        return exchangeRepository.findAll();
    }

    public Optional<RewardExchange> getExchangeById(Long id) {
        return exchangeRepository.findById(id);
    }

    public List<RewardExchange> getExchangesByStudent(Student student) {
        return exchangeRepository.findByStudent(student);
    }

    public List<RewardExchange> getExchangesByReward(Reward reward) {
        return exchangeRepository.findByReward(reward);
    }

    public List<RewardExchange> getExchangesByStatus(String status) {
        return exchangeRepository.findByStatus(status);
    }

    public Integer getTotalPointsSpentByStudent(Student student) {
        Integer total = exchangeRepository.getTotalPointsSpentByStudent(student);
        return total != null ? total : 0;
    }

    public List<RewardExchange> getRecentExchangesByStudent(Student student) {
        return exchangeRepository.findRecentExchangesByStudent(student);
    }

    public RewardExchange exchangeReward(Long studentId, Long rewardId) {
        Student student = studentService.getStudentById(studentId)
                .orElseThrow(() -> new ResourceNotFoundException("Student not found with id: " + studentId));
        
        Reward reward = rewardService.getRewardById(rewardId)
                .orElseThrow(() -> new ResourceNotFoundException("Reward not found with id: " + rewardId));
        
        // Check if student has enough points
        if (student.getPoints() < reward.getPointValue()) {
            throw new IllegalStateException("Student does not have enough points for this reward");
        }
        
        // Deduct points from student
        student.setPoints(student.getPoints() - reward.getPointValue());
        studentService.saveStudent(student);
        
        // Create exchange record
        RewardExchange exchange = new RewardExchange();
        exchange.setStudent(student);
        exchange.setReward(reward);
        exchange.setPointsSpent(reward.getPointValue());
        exchange.setExchangedAt(LocalDateTime.now());
        exchange.setStatus("REDEEMED");
        
        return exchangeRepository.save(exchange);
    }

    public RewardExchange fulfillReward(Long exchangeId, Staff staff) {
        RewardExchange exchange = exchangeRepository.findById(exchangeId)
                .orElseThrow(() -> new ResourceNotFoundException("Exchange not found with id: " + exchangeId));
        
        exchange.setStatus("FULFILLED");
        exchange.setFulfilledBy(staff);
        exchange.setFulfilledAt(LocalDateTime.now());
        
        return exchangeRepository.save(exchange);
    }

    public RewardExchange cancelExchange(Long exchangeId) {
        RewardExchange exchange = exchangeRepository.findById(exchangeId)
                .orElseThrow(() -> new ResourceNotFoundException("Exchange not found with id: " + exchangeId));
        
        // Only allow cancellation if not already fulfilled
        if (!exchange.getStatus().equals("FULFILLED")) {
            // Refund points to student
            Student student = exchange.getStudent();
            student.setPoints(student.getPoints() + exchange.getPointsSpent());
            studentService.saveStudent(student);
            
            exchange.setStatus("CANCELLED");
            return exchangeRepository.save(exchange);
        } else {
            throw new IllegalStateException("Cannot cancel a fulfilled exchange");
        }
    }

    public RewardExchange updateDeliveryDetails(Long exchangeId, String deliveryDetails) {
        RewardExchange exchange = exchangeRepository.findById(exchangeId)
                .orElseThrow(() -> new ResourceNotFoundException("Exchange not found with id: " + exchangeId));
        
        exchange.setDeliveryDetails(deliveryDetails);
        return exchangeRepository.save(exchange);
    }
    

    public List<RewardExchange> getPendingExchanges() {
        return exchangeRepository.findByStatus("REDEEMED");
    }

    public List<RewardExchange> getFulfilledExchanges() {
        return exchangeRepository.findByStatus("FULFILLED");
    }

    public void cancelRewardExchange(Long exchangeId) {
        RewardExchange exchange = exchangeRepository.findById(exchangeId)
                .orElseThrow(() -> new ResourceNotFoundException("Exchange not found with id: " + exchangeId));
        
        // Only allow cancellation if not already fulfilled
        if (!exchange.getStatus().equals("FULFILLED")) {
            // Refund points to student
            Student student = exchange.getStudent();
            student.setPoints(student.getPoints() + exchange.getPointsSpent());
            studentService.saveStudent(student);
            
            exchange.setStatus("CANCELLED");
            exchangeRepository.save(exchange);
        } else {
            throw new IllegalStateException("Cannot cancel a fulfilled exchange");
        }
    }

    public List<RewardExchange> getExchangesFulfilledByStaff(Staff staff) {
        return exchangeRepository.findByFulfilledBy(staff);
    }
}