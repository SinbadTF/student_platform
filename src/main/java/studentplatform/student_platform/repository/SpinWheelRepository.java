package studentplatform.student_platform.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import studentplatform.student_platform.model.SpinWheel;
import studentplatform.student_platform.model.Admin;

import java.util.List;

@Repository
public interface SpinWheelRepository extends JpaRepository<SpinWheel, Long> {
    
    List<SpinWheel> findByName(String name);
    
    List<SpinWheel> findByCreatedBy(Admin admin);
    
    List<SpinWheel> findByActiveTrue();
}