package studentplatform.student_platform.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import studentplatform.student_platform.model.Semester;
import studentplatform.student_platform.model.SemesterGrade;
import studentplatform.student_platform.model.Student;

import java.util.List;
import java.util.Optional;

@Repository
public interface SemesterGradeRepository extends JpaRepository<SemesterGrade, Long> {
    List<SemesterGrade> findByStudent(Student student);
    List<SemesterGrade> findBySemester(Semester semester);
    Optional<SemesterGrade> findByStudentAndSemester(Student student, Semester semester);
    
    @Query("SELECT sg FROM SemesterGrade sg WHERE sg.pointsAwarded = false")
    List<SemesterGrade> findGradesWithoutPoints();
}