package studentplatform.student_platform.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import studentplatform.student_platform.model.Admin;

import java.util.Optional;

public interface AdminRepository extends JpaRepository<Admin, Long> {
    Optional<Admin> findByUsername(String username);
    Optional<Admin> findByEmail(String email);
    Optional<Admin> findByAdminId(String adminId);
}