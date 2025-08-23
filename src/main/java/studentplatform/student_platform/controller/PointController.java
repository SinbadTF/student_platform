package studentplatform.student_platform.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import studentplatform.student_platform.model.Point;
import studentplatform.student_platform.model.Reward;
import studentplatform.student_platform.model.Staff;
import studentplatform.student_platform.model.Student;
import studentplatform.student_platform.service.PointService;
import studentplatform.student_platform.service.RewardService;
import studentplatform.student_platform.service.StaffService;
import studentplatform.student_platform.service.StudentService;

import jakarta.validation.Valid;
import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api/points")
public class PointController {

    private final PointService pointService;
    private final StudentService studentService;
    private final RewardService rewardService;
    private final StaffService staffService;

    @Autowired
    public PointController(PointService pointService, StudentService studentService,
                          RewardService rewardService, StaffService staffService) {
        this.pointService = pointService;
        this.studentService = studentService;
        this.rewardService = rewardService;
        this.staffService = staffService;
    }

    @GetMapping
    public ResponseEntity<List<Point>> getAllPoints() {
        return ResponseEntity.ok(pointService.getAllPoints());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Point> getPointById(@PathVariable Long id) {
        return pointService.getPointById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/student/{studentId}")
    public ResponseEntity<? extends Object> getPointsByStudent(@PathVariable Long studentId) {
        return studentService.getStudentById(studentId)
                .map(student -> {
                    List<Point> points = pointService.getPointsByStudent(student);
                    return points.isEmpty() ? ResponseEntity.noContent().build() : ResponseEntity.ok(points);
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/reward/{rewardId}")
    public ResponseEntity<? extends Object> getPointsByReward(@PathVariable Long rewardId) {
        return rewardService.getRewardById(rewardId)
                .map(reward -> {
                    List<Point> points = pointService.getPointsByReward(reward);
                    return points.isEmpty() ? ResponseEntity.noContent().build() : ResponseEntity.ok(points);
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/staff/{staffId}")
    public ResponseEntity<? extends Object> getPointsByStaff(@PathVariable Long staffId) {
        return staffService.getStaffById(staffId)
                .map(staff -> {
                    List<Point> points = pointService.getPointsByStaff(staff);
                    return points.isEmpty() ? ResponseEntity.noContent().build() : ResponseEntity.ok(points);
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/date-range")
    public ResponseEntity<List<Point>> getPointsByDateRange(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime start,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime end) {
        List<Point> points = pointService.getPointsByDateRange(start, end);
        return points.isEmpty() ? ResponseEntity.noContent().build() : ResponseEntity.ok(points);
    }

    @GetMapping("/student/{studentId}/total")
    public ResponseEntity<Integer> getTotalPointsByStudentId(@PathVariable Long studentId) {
        Integer totalPoints = pointService.getTotalPointsByStudentId(studentId);
        return totalPoints != null ? ResponseEntity.ok(totalPoints) : ResponseEntity.ok(0);
    }

    @GetMapping("/student/{studentId}/recent")
    public ResponseEntity<List<Point>> getRecentPointsByStudentId(@PathVariable Long studentId) {
        List<Point> points = pointService.getRecentPointsByStudentId(studentId);
        return points.isEmpty() ? ResponseEntity.noContent().build() : ResponseEntity.ok(points);
    }

    @PostMapping("/award")
    public ResponseEntity<Point> awardPointsToStudent(@Valid @RequestBody Point point) {
        // Validate that student, reward, and staff exist
        Student student = point.getStudent();
        Reward reward = point.getReward();
        Staff staff = point.getIssuedBy();
        
        if (student == null || student.getId() == null || 
            reward == null || reward.getId() == null || 
            staff == null || staff.getId() == null) {
            return ResponseEntity.badRequest().build();
        }
        
        // Set the current time if not provided
        if (point.getIssuedAt() == null) {
            point.setIssuedAt(LocalDateTime.now());
        }
        
        Point savedPoint = pointService.awardPointsToStudent(point);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedPoint);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Point> updatePoint(@PathVariable Long id, @Valid @RequestBody Point point) {
        return pointService.getPointById(id)
                .map(existingPoint -> {
                    point.setId(id);
                    return ResponseEntity.ok(pointService.savePoint(point));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletePoint(@PathVariable Long id) {
        return pointService.getPointById(id)
                .map(point -> {
                    pointService.deletePoint(id);
                    return ResponseEntity.noContent().<Void>build();
                })
                .orElse(ResponseEntity.notFound().build());
    }
}