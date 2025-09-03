package studentplatform.student_platform.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import studentplatform.student_platform.model.SpinWheel;
import studentplatform.student_platform.model.SpinWheelItem;
import studentplatform.student_platform.repository.SpinWheelItemRepository;

import java.util.List;
import java.util.Optional;
import java.util.Random;

@Service
public class SpinWheelItemService {

    private final SpinWheelItemRepository spinWheelItemRepository;
    private final Random random = new Random();

    @Autowired
    public SpinWheelItemService(SpinWheelItemRepository spinWheelItemRepository) {
        this.spinWheelItemRepository = spinWheelItemRepository;
    }

    public List<SpinWheelItem> getAllSpinWheelItems() {
        return spinWheelItemRepository.findAll();
    }

    public List<SpinWheelItem> getItemsBySpinWheel(SpinWheel spinWheel) {
        return spinWheelItemRepository.findBySpinWheel(spinWheel);
    }

    public List<SpinWheelItem> getItemsBySpinWheelSortedByWeight(SpinWheel spinWheel) {
        return spinWheelItemRepository.findBySpinWheelOrderByProbabilityWeightDesc(spinWheel);
    }

    public Optional<SpinWheelItem> getSpinWheelItemById(Long id) {
        return spinWheelItemRepository.findById(id);
    }

    public SpinWheelItem saveSpinWheelItem(SpinWheelItem spinWheelItem) {
        return spinWheelItemRepository.save(spinWheelItem);
    }

    public void deleteSpinWheelItem(Long id) {
        spinWheelItemRepository.deleteById(id);
    }

    /**
     * Selects a random item from the spin wheel based on probability weights
     * Items with higher weights have a higher chance of being selected
     */
    public SpinWheelItem spinWheel(SpinWheel spinWheel) {
        List<SpinWheelItem> items = getItemsBySpinWheel(spinWheel);
        if (items.isEmpty()) {
            throw new IllegalStateException("Spin wheel has no items");
        }

        // Calculate total weight
        int totalWeight = items.stream()
                .mapToInt(SpinWheelItem::getProbabilityWeight)
                .sum();

        // Get a random value between 0 and totalWeight
        int randomValue = random.nextInt(totalWeight);

        // Find the selected item based on weight
        int currentWeight = 0;
        for (SpinWheelItem item : items) {
            currentWeight += item.getProbabilityWeight();
            if (randomValue < currentWeight) {
                return item;
            }
        }

        // Fallback (should never happen if weights are positive)
        return items.get(items.size() - 1);
    }
}