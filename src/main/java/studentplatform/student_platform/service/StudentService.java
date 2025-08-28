package studentplatform.student_platform.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import studentplatform.student_platform.controller.string;
import studentplatform.student_platform.model.Reward;
import studentplatform.student_platform.model.Student;
import studentplatform.student_platform.repository.StudentRepository;
import studentplatform.student_platform.repository.RewardRepository;

import java.util.List;
import java.util.Optional;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@Service
public class StudentService {

    private final StudentRepository studentRepository;
    private final RewardRepository rewardRepository; // Added field

    @Autowired
    public StudentService(StudentRepository studentRepository, RewardRepository rewardRepository) { // Added parameter
        this.studentRepository = studentRepository;
        this.rewardRepository = rewardRepository; // Initialize field
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

    // New methods for managing points
    public Integer getStudentPoints(Long studentId) {
        return studentRepository.findById(studentId)
                .map(Student::getPoints)
                .orElse(0);
    }
    
    public Student addPointsToStudent(Long studentId, Integer pointsToAdd, String reason) {
        System.out.println("=== Adding points to student ===");
        System.out.println("Student ID: " + studentId);
        System.out.println("Points to add: " + pointsToAdd);
        System.out.println("Reason: " + reason);
        
        Optional<Student> studentOpt = studentRepository.findById(studentId);
        if (studentOpt.isPresent()) {
            Student student = studentOpt.get();
            Integer currentPoints = student.getPoints() != null ? student.getPoints() : 0;
            System.out.println("Student: " + student.getUsername() + " (ID: " + student.getId() + ")");
            System.out.println("Current points: " + currentPoints);
            System.out.println("New total will be: " + (currentPoints + pointsToAdd));
            
            student.setPoints(currentPoints + pointsToAdd);
            Student savedStudent = studentRepository.save(student);
            
            System.out.println("Student saved to database. New points: " + savedStudent.getPoints());
            System.out.println("=== Points added successfully ===");
            
            return savedStudent;
        } else {
            System.err.println("Student not found with ID: " + studentId);
            return null;
        }
    }
    
    public Student setStudentPoints(Long studentId, Integer points) {
        Optional<Student> studentOpt = studentRepository.findById(studentId);
        if (studentOpt.isPresent()) {
            Student student = studentOpt.get();
            student.setPoints(points);
            return studentRepository.save(student);
        }
        return null;
    }
    
    // Add these methods for reward exchange functionality
    // Fix the method to use findById instead of findRewardById
    public boolean hasEnoughPointsForReward(Long studentId, Long rewardId) {
        Optional<Student> studentOpt = studentRepository.findById(studentId);
        Optional<Reward> rewardOpt = rewardRepository.findById(rewardId); // Changed from findRewardById to findById
        
        if (studentOpt.isPresent() && rewardOpt.isPresent()) {
            Student student = studentOpt.get();
            Reward reward = rewardOpt.get();
            return student.getPoints() >= reward.getPointValue();
        }
        return false;
    }
    
    public Student deductPointsForReward(Long studentId, Integer pointsToDeduct) {
        Optional<Student> studentOpt = studentRepository.findById(studentId);
        if (studentOpt.isPresent()) {
            Student student = studentOpt.get();
            Integer currentPoints = student.getPoints() != null ? student.getPoints() : 0;
            
            if (currentPoints >= pointsToDeduct) {
                student.setPoints(currentPoints - pointsToDeduct);
                return studentRepository.save(student);
            } else {
                throw new IllegalStateException("Student does not have enough points");
            }
        }
        return null;
    }
    
    public List<Reward> getAvailableRewardsForStudent(Long studentId) {
        Optional<Student> studentOpt = studentRepository.findById(studentId);
        if (studentOpt.isPresent()) {
            Student student = studentOpt.get();
            Integer points = student.getPoints() != null ? student.getPoints() : 0;
            return rewardRepository.findByPointValueLessThanEqual(points);
        }
        return List.of();
    }
}