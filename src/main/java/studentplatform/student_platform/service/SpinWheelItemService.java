package studentplatform.student_platform.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import studentplatform.student_platform.model.SpinWheel;
import studentplatform.student_platform.model.SpinWheelItem;
import studentplatform.student_platform.repository.SpinWheelItemRepository;

import java.util.List;
import java.util.Optional;

@Service
public class SpinWheelItemService {

    private final SpinWheelItemRepository spinWheelItemRepository;

    @Autowired
    public SpinWheelItemService(SpinWheelItemRepository spinWheelItemRepository) {
        this.spinWheelItemRepository = spinWheelItemRepository;
    }

    public List<SpinWheelItem> getItemsBySpinWheel(SpinWheel spinWheel) {
        return spinWheelItemRepository.findBySpinWheel(spinWheel);
    }

    public Optional<SpinWheelItem> getSpinWheelItemById(Long id) {
        return spinWheelItemRepository.findById(id);
    }

    public SpinWheelItem saveSpinWheelItem(SpinWheelItem item) {
        item.setUpdatedAt(java.time.LocalDateTime.now());
        return spinWheelItemRepository.save(item);
    }

    public void deleteSpinWheelItem(Long id) {
        spinWheelItemRepository.deleteById(id);
    }

    public List<SpinWheelItem> getAllSpinWheelItems() {
        return spinWheelItemRepository.findAll();
    }
}