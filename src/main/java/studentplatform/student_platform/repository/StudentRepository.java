package studentplatform.student_platform.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;


import studentplatform.student_platform.model.Student;

import java.util.List;
import java.util.Optional;

@Repository
public interface StudentRepository extends JpaRepository<Student, Long> {
    
    Optional<Student> findByStudentId(String studentId);
    
    Optional<Student> findByEmail(String email);

    Optional<Student> findByUsername(String username);
    
    
    List<Student> findByDepartment(String department);
    
    List<Student> findByYear(int year);
    
    @Query("SELECT s FROM Student s WHERE s.firstName LIKE %:keyword% OR s.lastName LIKE %:keyword%")
    List<Student> searchByName(@Param("keyword") String keyword);
    
    List<Student> findByStatus(Student.AccountStatus status);

    
}