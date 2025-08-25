package studentplatform.student_platform.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import studentplatform.student_platform.model.Reward;
import studentplatform.student_platform.model.Staff;
import studentplatform.student_platform.model.Student;
import studentplatform.student_platform.repository.RewardRepository;

import java.util.List;
import java.util.Optional;

@Service
public class RewardService {

    private final RewardRepository rewardRepository;

    @Autowired
    public RewardService(RewardRepository rewardRepository) {
        this.rewardRepository = rewardRepository;
    }

    public List<Reward> getAllRewards() {
        return rewardRepository.findAll();
    }

    public Optional<Reward> getRewardById(Long id) {
        return rewardRepository.findById(id);
    }

    public List<Reward> getRewardsByName(String name) {
        return rewardRepository.findByName(name);
    }

    public List<Reward> getRewardsWithMinimumPoints(Integer pointValue) {
        return rewardRepository.findByPointValueGreaterThanEqual(pointValue);
    }

    public List<Reward> getRewardsWithMaximumPoints(Integer pointValue) {
        return rewardRepository.findByPointValueLessThanEqual(pointValue);
    }



    public List<Reward> searchRewardsByKeyword(String keyword) {
        return rewardRepository.searchByKeyword(keyword);
    }

    public Reward saveReward(Reward reward) {
        return rewardRepository.save(reward);
    }

    public void deleteReward(Long id) {
        rewardRepository.deleteById(id);
    }

    // Remove this method:
    // public List<Reward> getRewardsByStudent(Student student) {
    //     return rewardRepository.findByReceivedBy(student);
    // }

    public List<Reward> getRewardsByStaff(Staff staff) {
        return rewardRepository.findByIssuedBy(staff);
    }
}