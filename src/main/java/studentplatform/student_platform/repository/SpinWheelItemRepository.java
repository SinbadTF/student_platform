package studentplatform.student_platform.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import studentplatform.student_platform.model.SpinWheel;
import studentplatform.student_platform.model.SpinWheelItem;

import java.util.List;

@Repository
public interface SpinWheelItemRepository extends JpaRepository<SpinWheelItem, Long> {
    List<SpinWheelItem> findBySpinWheel(SpinWheel spinWheel);
    List<SpinWheelItem> findBySpinWheelId(Long spinWheelId);
}