package studentplatform.student_platform.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import studentplatform.student_platform.model.Reward;
import studentplatform.student_platform.model.Staff;
import studentplatform.student_platform.service.RewardService;
import studentplatform.student_platform.service.StaffService;

import jakarta.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/api/rewards")
public class RewardController {

    private final RewardService rewardService;
    private final StaffService staffService;

    @Autowired
    public RewardController(RewardService rewardService, StaffService staffService) {
        this.rewardService = rewardService;
        this.staffService = staffService;
    }

    @GetMapping
    public ResponseEntity<List<Reward>> getAllRewards() {
        return ResponseEntity.ok(rewardService.getAllRewards());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Reward> getRewardById(@PathVariable Long id) {
        return rewardService.getRewardById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/name/{name}")
    public ResponseEntity<List<Reward>> getRewardsByName(@PathVariable String name) {
        List<Reward> rewards = rewardService.getRewardsByName(name);
        return rewards.isEmpty() ? ResponseEntity.noContent().build() : ResponseEntity.ok(rewards);
    }

    @GetMapping("/min-points/{points}")
    public ResponseEntity<List<Reward>> getRewardsWithMinimumPoints(@PathVariable Integer points) {
        List<Reward> rewards = rewardService.getRewardsWithMinimumPoints(points);
        return rewards.isEmpty() ? ResponseEntity.noContent().build() : ResponseEntity.ok(rewards);
    }

    @GetMapping("/max-points/{points}")
    public ResponseEntity<List<Reward>> getRewardsWithMaximumPoints(@PathVariable Integer points) {
        List<Reward> rewards = rewardService.getRewardsWithMaximumPoints(points);
        return rewards.isEmpty() ? ResponseEntity.noContent().build() : ResponseEntity.ok(rewards);
    }

    @GetMapping("/staff/{staffId}")
    public ResponseEntity<? extends Object> getRewardsByStaff(@PathVariable Long staffId) {
        return staffService.getStaffById(staffId)
                .map(staff -> {
                    List<Reward> rewards = rewardService.getRewardsByStaff(staff);
                    return rewards.isEmpty() ? ResponseEntity.noContent().build() : ResponseEntity.ok(rewards);
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/search")
    public ResponseEntity<List<Reward>> searchRewards(@RequestParam String keyword) {
        List<Reward> rewards = rewardService.searchRewardsByKeyword(keyword);
        return rewards.isEmpty() ? ResponseEntity.noContent().build() : ResponseEntity.ok(rewards);
    }

    @PostMapping
    public ResponseEntity<Reward> createReward(@Valid @RequestBody Reward reward) {
        Reward savedReward = rewardService.saveReward(reward);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedReward);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Reward> updateReward(@PathVariable Long id, @Valid @RequestBody Reward reward) {
        return rewardService.getRewardById(id)
                .map(existingReward -> {
                    reward.setId(id);
                    return ResponseEntity.ok(rewardService.saveReward(reward));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteReward(@PathVariable Long id) {
        return rewardService.getRewardById(id)
                .map(reward -> {
                    rewardService.deleteReward(id);
                    return ResponseEntity.noContent().<Void>build();
                })
                .orElse(ResponseEntity.notFound().build());
    }
}