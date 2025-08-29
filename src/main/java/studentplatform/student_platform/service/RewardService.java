package studentplatform.student_platform.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import studentplatform.student_platform.model.Reward;
import studentplatform.student_platform.model.Staff;

import studentplatform.student_platform.repository.RewardRepository;
import studentplatform.student_platform.repository.RewardExchangeRepository;
import studentplatform.student_platform.model.RewardExchange;

import java.util.List;
import java.util.Optional;

@Service
public class RewardService {

    private final RewardRepository rewardRepository;
    private final RewardExchangeRepository rewardExchangeRepository;


    public RewardService(RewardRepository rewardRepository, RewardExchangeRepository rewardExchangeRepository) {
        this.rewardRepository = rewardRepository;
        this.rewardExchangeRepository = rewardExchangeRepository;
    }

    public void deactivateReward(Long id) {
        Optional<Reward> rewardOpt = rewardRepository.findById(id);
        if (rewardOpt.isPresent()) {
            Reward reward = rewardOpt.get();
            reward.setActive(false);
            rewardRepository.save(reward);
        }
    }

    public void activateReward(Long id) {
        Optional<Reward> rewardOpt = rewardRepository.findById(id);
        if (rewardOpt.isPresent()) {
            Reward reward = rewardOpt.get();
            reward.setActive(true);
            rewardRepository.save(reward);
        }
    }

    // Update getAllRewards to filter by active status
    public List<Reward> getAllRewards() {
        return rewardRepository.findAll();
    }

    // Add method to get only active rewards
    public List<Reward> getActiveRewards() {
        return rewardRepository.findByActiveTrue();
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

    public void deleteReward(Long id) throws IllegalStateException {
        Optional<Reward> rewardOpt = rewardRepository.findById(id);
        if (rewardOpt.isPresent()) {
            Reward reward = rewardOpt.get();
            // Check if there are any reward exchanges for this reward
            List<RewardExchange> exchanges = rewardExchangeRepository.findByReward(reward);
            if (!exchanges.isEmpty()) {
                throw new IllegalStateException("Cannot delete reward: It has been exchanged by students. Please deactivate it instead.");
            }
            rewardRepository.deleteById(id);
        }
    }

    public List<Reward> getRewardsByStaff(Staff staff) {
        return rewardRepository.findByIssuedBy(staff);
    }
}