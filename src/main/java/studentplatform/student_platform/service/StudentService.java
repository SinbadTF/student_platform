package studentplatform.student_platform.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import studentplatform.student_platform.controller.string;
import studentplatform.student_platform.model.Student;
import studentplatform.student_platform.repository.StudentRepository;

import java.util.List;
import java.util.Optional;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@Service
public class StudentService {

    private final StudentRepository studentRepository;

    @Autowired
    public StudentService(StudentRepository studentRepository) {
        this.studentRepository = studentRepository;
    }

    public boolean authStudent(String username, String password) {

        Optional<Student> student = this.studentRepository.findByUsername(username);

        if (student.isPresent()) {
            // Compare the hashed password
            String hashedPassword = hashPassword(password);
            return student.get().getPassword().equals(hashedPassword);
        }
        return false;

    }

    public Optional<Student> findByUsername(String username) {
        return studentRepository.findByUsername(username);
    }

    public List<Student> getAllStudents() {
        return studentRepository.findAll();
    }

    public Optional<Student> getStudentById(Long id) {
        return studentRepository.findById(id);
    }



    public Optional<Student> getStudentByEmail(String email) {
        return studentRepository.findByEmail(email);
    }

    public List<Student> getStudentsByDepartment(String department) {
        return studentRepository.findByDepartment(department);
    }

    public List<Student> getStudentsByYear(int year) {
        return studentRepository.findByYear(year);
    }

    public List<Student> searchStudentsByName(String keyword) {
        return studentRepository.searchByName(keyword);
    }

    public Student saveStudent(Student student) {
        return studentRepository.save(student);
    }

    public Optional<Student> getStudentByStudentId(String studentId) {
        return studentRepository.findByStudentId(studentId);
    }

    public void deleteStudent(Long id) {
        studentRepository.deleteById(id);
    }
    public Optional<Student> findByStudentId(String studentId) {
    return studentRepository.findByStudentId(studentId);
}


public String hashPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();
            
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }

    // Add these methods to StudentService
    public List<Student> findByStatus(Student.AccountStatus status) {
        return studentRepository.findByStatus(status);
    }
    
    

    public void approveRegistration(String studentId) {
        Optional<Student> studentOpt = studentRepository.findByStudentId(studentId);
        if (studentOpt.isPresent()) {
            Student student = studentOpt.get();
            student.setStatus(Student.AccountStatus.APPROVED);
            studentRepository.save(student);
        }
    }

    public void rejectRegistration(String studentId) {
        Optional<Student> studentOpt = studentRepository.findByStudentId(studentId);
        if (studentOpt.isPresent()) {
            Student student = studentOpt.get();
            student.setStatus(Student.AccountStatus.REJECTED);
            studentRepository.save(student);
        }
    }

    


    
}