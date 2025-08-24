package studentplatform.student_platform.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;

import studentplatform.student_platform.model.Admin;
// Remove Point import
import studentplatform.student_platform.model.Reward;
// Remove PointRepository import
import studentplatform.student_platform.repository.RewardRepository;
import studentplatform.student_platform.repository.StaffRepository;
import studentplatform.student_platform.repository.StudentRepository;
import studentplatform.student_platform.repository.AdminRepository;
import studentplatform.student_platform.service.StudentService;

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
            @Autowired RewardRepository rewardRepository) {
        // Remove PointRepository parameter
        
        return args -> {
            // Check if data already exists
            if (studentRepository.count() > 0) {
                System.out.println("Database already has data, skipping initialization");
                return;
            }
            
            System.out.println("Initializing database with sample data...");
            
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
            
            Reward reward2 = new Reward();
            reward2.setName("Community Service");
            reward2.setDescription("Awarded for exceptional contribution to community");
            reward2.setPointValue(75);
            
            Reward reward3 = new Reward();
            reward3.setName("Innovation Award");
            reward3.setDescription("Awarded for innovative project or solution");
            reward3.setPointValue(150);
            
            List<Reward> rewardList = Arrays.asList(reward1, reward2, reward3);
            rewardRepository.saveAll(rewardList);
            
            // Remove Point creation and initialization
            
            System.out.println("Sample data initialization complete!");
        };
    }
}