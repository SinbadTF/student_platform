package studentplatform.student_platform.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import studentplatform.student_platform.model.Admin;
import studentplatform.student_platform.model.SpinWheel;
import studentplatform.student_platform.repository.SpinWheelRepository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class SpinWheelService {

    private final SpinWheelRepository spinWheelRepository;

    @Autowired
    public SpinWheelService(SpinWheelRepository spinWheelRepository) {
        this.spinWheelRepository = spinWheelRepository;
    }

    public List<SpinWheel> getAllSpinWheels() {
        return spinWheelRepository.findAll();
    }

    public List<SpinWheel> getActiveSpinWheels() {
        return spinWheelRepository.findByActiveTrue();
    }

    public Optional<SpinWheel> getSpinWheelById(Long id) {
        return spinWheelRepository.findById(id);
    }

    public List<SpinWheel> getSpinWheelsByName(String name) {
        return spinWheelRepository.findByName(name);
    }

    public List<SpinWheel> getSpinWheelsByAdmin(Admin admin) {
        return spinWheelRepository.findByCreatedBy(admin);
    }

    public SpinWheel saveSpinWheel(SpinWheel spinWheel) {
        if (spinWheel.getCreatedAt() == null) {
            spinWheel.setCreatedAt(LocalDateTime.now());
        }
        spinWheel.setUpdatedAt(LocalDateTime.now());
        return spinWheelRepository.save(spinWheel);
    }

    public void activateSpinWheel(Long id) {
        Optional<SpinWheel> spinWheelOpt = spinWheelRepository.findById(id);
        if (spinWheelOpt.isPresent()) {
            SpinWheel spinWheel = spinWheelOpt.get();
            spinWheel.setActive(true);
            spinWheel.setUpdatedAt(LocalDateTime.now());
            spinWheelRepository.save(spinWheel);
        }
    }

    public void deactivateSpinWheel(Long id) {
        Optional<SpinWheel> spinWheelOpt = spinWheelRepository.findById(id);
        if (spinWheelOpt.isPresent()) {
            SpinWheel spinWheel = spinWheelOpt.get();
            spinWheel.setActive(false);
            spinWheel.setUpdatedAt(LocalDateTime.now());
            spinWheelRepository.save(spinWheel);
        }
    }

    public void deleteSpinWheel(Long id) {
        spinWheelRepository.deleteById(id);
    }
}