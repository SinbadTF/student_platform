package studentplatform.student_platform.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import studentplatform.student_platform.model.Admin;
import studentplatform.student_platform.repository.AdminRepository;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.Optional;

@Service
public class AdminService {

    @Autowired
    private AdminRepository adminRepository;
    
    public Optional<Admin> findByUsername(String username) {
        return adminRepository.findByUsername(username);
    }
    
    public Optional<Admin> findByAdminId(String adminId) {
        return adminRepository.findByAdminId(adminId);
    }
    
    public Optional<Admin> getAdminById(Long id) {
        return adminRepository.findById(id);
    }
    
    // Add method to get all admins
    public List<Admin> getAllAdmins() {
        return adminRepository.findAll();
    }
    
    public Admin saveAdmin(Admin admin) {
        // Hash the password before saving
        admin.setPassword(hashPassword(admin.getPassword()));
        return adminRepository.save(admin);
    }
    
    public boolean authAdmin(String username, String password) {
        Optional<Admin> adminOpt = findByUsername(username);
        if (adminOpt.isPresent()) {
            // Compare the hashed password
            String hashedPassword = hashPassword(password);
            return adminOpt.get().getPassword().equals(hashedPassword);
        }
        return false;
    }
    
    // Simple SHA-256 hashing (in a real app, use BCrypt or similar)
    private String hashPassword(String password) {
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
}