package studentplatform.student_platform.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import studentplatform.student_platform.model.Point;
import studentplatform.student_platform.model.Reward;
import studentplatform.student_platform.model.Staff;
import studentplatform.student_platform.model.Student;
import studentplatform.student_platform.repository.PointRepository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class PointService {

    private final PointRepository pointRepository;

    @Autowired
    public PointService(PointRepository pointRepository) {
        this.pointRepository = pointRepository;
    }

    public List<Point> getAllPoints() {
        return pointRepository.findAll();
    }

    public Optional<Point> getPointById(Long id) {
        return pointRepository.findById(id);
    }

    public List<Point> getPointsByStudent(Student student) {
        return pointRepository.findByStudent(student);
    }

    public List<Point> getPointsByReward(Reward reward) {
        return pointRepository.findByReward(reward);
    }

    public List<Point> getPointsByStaff(Staff staff) {
        return pointRepository.findByIssuedBy(staff);
    }

    public List<Point> getPointsByDateRange(LocalDateTime start, LocalDateTime end) {
        return pointRepository.findByIssuedAtBetween(start, end);
    }

    public Integer getTotalPointsByStudentId(Long studentId) {
        return pointRepository.getTotalPointsByStudentId(studentId);
    }

    public List<Point> getRecentPointsByStudentId(Long studentId) {
        return pointRepository.findRecentPointsByStudentId(studentId);
    }
    
    public List<Point> searchPoints(String keyword) {
        return pointRepository.searchPoints(keyword);
    }

    public Point awardPointsToStudent(Point point) {
        return pointRepository.save(point);
    }

    public Point savePoint(Point point) {
        return pointRepository.save(point);
    }

    public void deletePoint(Long id) {
        pointRepository.deleteById(id);
    }

    public PointRepository getPointRepository() {
        return pointRepository;
    }
       
}