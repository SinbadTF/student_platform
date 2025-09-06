package studentplatform.student_platform.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import studentplatform.student_platform.model.Admin;
import studentplatform.student_platform.model.Semester;
import studentplatform.student_platform.model.SemesterGrade;
import studentplatform.student_platform.model.Student;
import studentplatform.student_platform.repository.SemesterGradeRepository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class SemesterGradeService {

    private final SemesterGradeRepository semesterGradeRepository;
    private final StudentService studentService;

    @Autowired
    public SemesterGradeService(SemesterGradeRepository semesterGradeRepository,
                               StudentService studentService) {
        this.semesterGradeRepository = semesterGradeRepository;
        this.studentService = studentService;
    }

    public List<SemesterGrade> getAllSemesterGrades() {
        return semesterGradeRepository.findAll();
    }

    public Optional<SemesterGrade> getSemesterGradeById(Long id) {
        return semesterGradeRepository.findById(id);
    }

    public List<SemesterGrade> getSemesterGradesByStudent(Student student) {
        return semesterGradeRepository.findByStudent(student);
    }

    public List<SemesterGrade> getSemesterGradesBySemester(Semester semester) {
        return semesterGradeRepository.findBySemester(semester);
    }

    public Optional<SemesterGrade> getSemesterGradeByStudentAndSemester(Student student, Semester semester) {
        return semesterGradeRepository.findByStudentAndSemester(student, semester);
    }

    public SemesterGrade saveSemesterGrade(SemesterGrade semesterGrade) {
        return semesterGradeRepository.save(semesterGrade);
    }

    public SemesterGrade createOrUpdateSemesterGrade(Student student, Semester semester, 
                                                   Double gpa, Admin admin) {
        // Check if grade record already exists for this student and semester
        Optional<SemesterGrade> existingGrade = 
            semesterGradeRepository.findByStudentAndSemester(student, semester);
        
        if (existingGrade.isPresent()) {
            // Update existing record
            SemesterGrade grade = existingGrade.get();
            grade.setGpa(gpa);
            grade.setUpdatedAt(LocalDateTime.now());
            grade.setUpdatedBy(admin);
            grade.setPointsAwarded(false); // Reset points awarded flag to recalculate
            
            return semesterGradeRepository.save(grade);
        } else {
            // Create new record
            SemesterGrade grade = new SemesterGrade();
            grade.setStudent(student);
            grade.setSemester(semester);
            grade.setGpa(gpa);
            grade.setCreatedAt(LocalDateTime.now());
            grade.setCreatedBy(admin);
            
            return semesterGradeRepository.save(grade);
        }
    }

    public void deleteSemesterGrade(Long id) {
        semesterGradeRepository.deleteById(id);
    }

    public void calculateAndAwardPoints() {
        // Get all grade records that haven't had points awarded yet
        List<SemesterGrade> pendingGrades = semesterGradeRepository.findGradesWithoutPoints();
        
        for (SemesterGrade grade : pendingGrades) {
            // Calculate points based on GPA thresholds
            int pointsToAward = grade.calculatePoints();
            
            // Award points to student
            String reason = "GPA points for " + grade.getSemester().toString();
            studentService.addPointsToStudent(grade.getStudent().getId(), pointsToAward, reason);
            
            // Mark grade as having points awarded
            grade.setPointsAwarded(true);
            semesterGradeRepository.save(grade);
        }
    }

    public SemesterGrade awardPointsForGrade(Long gradeId) {
        return semesterGradeRepository.findById(gradeId).map(grade -> {
            if (!grade.isPointsAwarded()) {
                // Calculate points based on GPA thresholds
                int pointsToAward = grade.calculatePoints();
                
                // Award points to student
                String reason = "GPA points for " + grade.getSemester().toString();
                studentService.addPointsToStudent(grade.getStudent().getId(), pointsToAward, reason);
                
                // Mark grade as having points awarded
                grade.setPointsAwarded(true);
                return semesterGradeRepository.save(grade);
            }
            return grade;
        }).orElse(null);
    }
}