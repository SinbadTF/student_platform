package studentplatform.student_platform.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import studentplatform.student_platform.model.Staff;

import java.util.List;
import java.util.Optional;

@Repository
public interface StaffRepository extends JpaRepository<Staff, Long> {
    
    Optional<Staff> findByStaffId(String staffId);
    
    Optional<Staff> findByEmail(String email);
    
    List<Staff> findByDepartment(String department);
    
    List<Staff> findByPosition(String position);
    
    @Query("SELECT s FROM Staff s WHERE s.firstName LIKE %:keyword% OR s.lastName LIKE %:keyword%")
    List<Staff> searchByName(@Param("keyword") String keyword);
    
    Optional<Staff> findByUsername(String username);
    
    // Add this method to StaffRepository
    List<Staff> findByStatus(Staff.AccountStatus status);
}
