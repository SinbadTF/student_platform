package studentplatform.student_platform.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;

import studentplatform.student_platform.model.Admin;
import studentplatform.student_platform.model.Point;
import studentplatform.student_platform.model.Reward;
import studentplatform.student_platform.model.Staff;
import studentplatform.student_platform.model.Student;
import studentplatform.student_platform.repository.PointRepository;
import studentplatform.student_platform.repository.RewardRepository;
import studentplatform.student_platform.repository.StaffRepository;
import studentplatform.student_platform.repository.StudentRepository;
import studentplatform.student_platform.repository.AdminRepository;
import studentplatform.student_platform.service.StudentService;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;

@Configuration
public class DataInitializer {

    private final AdminRepository adminRepository;

    private final StudentService studentService;

    DataInitializer(AdminRepository adminRepository, StudentService studentService) {
        this.adminRepository = adminRepository;
        this.studentService = studentService;
    }

    @Bean
    @Profile("!prod") // Only run in non-production environments
    public CommandLineRunner initData(
            @Autowired StudentRepository studentRepository,
            @Autowired StaffRepository staffRepository,
            @Autowired RewardRepository rewardRepository,
            @Autowired PointRepository pointRepository) {
        
        return args -> {
            // Check if data already exists
            if (studentRepository.count() > 0) {
                System.out.println("Database already has data, skipping initialization");
                return;
            }
            
            System.out.println("Initializing database with sample data...");
            
            
            
            // Create students with username and password
            // Student student1 = new Student();
            // student1.setStudentId("STU001");
            // student1.setFirstName("Alice");
            // student1.setLastName("Johnson");
            // student1.setEmail("alice.johnson@university.edu");
            // student1.setDepartment("Computer Science");
            // student1.setYear(2);
            // student1.setUsername("alice");  // Add username
            // String StuHashedPassword = this.studentService.hashPassword("student1pass");
            // student1.setPassword(StuHashedPassword);  // Add password (will be hashed later)
            
            // Student student2 = new Student();
            // student2.setStudentId("STU002");
            // student2.setFirstName("Bob");
            // student2.setLastName("Williams");
            // student2.setEmail("bob.williams@university.edu");
            // student2.setDepartment("Mathematics");
            // student2.setYear(3);
            // student2.setUsername("boob");  // Add username
            // student2.setPassword("student2pass");  // Add password
            
            // Student student3 = new Student();
            // student3.setStudentId("STU003");
            // student3.setFirstName("Charlie");
            // student3.setLastName("Brown");
            // student3.setEmail("charlie.brown@university.edu");
            // student3.setDepartment("Physics");
            // student3.setYear(1);
            // student3.setUsername("charlie");  // Add username
            // student3.setPassword("student3pass");  // Add password
            
            // List<Student> studentList = Arrays.asList(student1, student2, student3);
            // studentRepository.saveAll(studentList);
            
            // // Create staff members with username and password
            // Staff staff1 = new Staff();
            // staff1.setStaffId("STAFF001");
            // staff1.setFirstName("John");
            // staff1.setLastName("Doe");
            // staff1.setEmail("john.doe@university.edu");
            // staff1.setDepartment("Computer Science");
            // staff1.setPosition("Professor");
            // staff1.setUsername("john");  // Add username
            // staff1.setPassword("staff1pass");  // Add password
            
            // Staff staff2 = new Staff();
            // staff2.setStaffId("STAFF002");
            // staff2.setFirstName("Jane");
            // staff2.setLastName("Smith");
            // staff2.setEmail("jane.smith@university.edu");
            // staff2.setDepartment("Mathematics");
            // staff2.setPosition("Associate Professor");
            // staff2.setUsername("jane");  // Add username
            // staff2.setPassword("staff2pass");  // Add password
            
            // List<Staff> staffList = Arrays.asList(staff1, staff2);
            // staffRepository.saveAll(staffList);
            
            // Create admin
            Admin admin = new Admin();
            admin.setAdminId("ADMIN001");
            admin.setFirstName("Admin");
            admin.setLastName("User");
            admin.setEmail("admin@university.edu");
            admin.setUsername("admin");
            String AdminHashedPassword = this.studentService.hashPassword("admin123");
            admin.setPassword(AdminHashedPassword); 
            
            adminRepository.save(admin);
            
            
            // Create rewards
            Reward reward1 = new Reward();
            reward1.setName("Academic Excellence");
            reward1.setDescription("Awarded for outstanding academic performance");
            reward1.setPointValue(100);
            // reward1.setIssuedBy(staff1);
            
            Reward reward2 = new Reward();
            reward2.setName("Community Service");
            reward2.setDescription("Awarded for exceptional contribution to community");
            reward2.setPointValue(75);
            // reward2.setIssuedBy(staff2);
            
            Reward reward3 = new Reward();
            reward3.setName("Innovation Award");
            reward3.setDescription("Awarded for innovative project or solution");
            reward3.setPointValue(150);
            // reward3.setIssuedBy(staff1);
            
            List<Reward> rewardList = Arrays.asList(reward1, reward2, reward3);
            rewardRepository.saveAll(rewardList);
            
            // Create points
            Point point1 = new Point();
            point1.setValue(100);
            point1.setReason("First place in coding competition");
            point1.setIssuedAt(LocalDateTime.now().minusDays(30));
            // point1.setStudent(student1);
            point1.setReward(reward1);
            // point1.setIssuedBy(staff1);
            
            Point point2 = new Point();
            point2.setValue(75);
            point2.setReason("Volunteer work at local shelter");
            point2.setIssuedAt(LocalDateTime.now().minusDays(15));
            // point2.setStudent(student2);
            point2.setReward(reward2);
            // point2.setIssuedBy(staff2);
            
            Point point3 = new Point();
            point3.setValue(150);
            point3.setReason("Innovative solution for campus sustainability");
            point3.setIssuedAt(LocalDateTime.now().minusDays(7));
            // point3.setStudent(student3);
            point3.setReward(reward3);
            // point3.setIssuedBy(staff1);
            
            List<Point> pointList = Arrays.asList(point1, point2, point3);
            pointRepository.saveAll(pointList);
            
            System.out.println("Sample data initialization complete!");
        };
    }
}