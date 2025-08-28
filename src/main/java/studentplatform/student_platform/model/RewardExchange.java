package studentplatform.student_platform.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "reward_exchanges")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class RewardExchange {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn(name = "student_id")
    private Student student;
    
    @ManyToOne
    @JoinColumn(name = "reward_id")
    private Reward reward;
    
    @ManyToOne
    @JoinColumn(name = "fulfilled_by")
    private Staff fulfilledBy;
    
    private Integer pointsSpent;
    
    private LocalDateTime exchangedAt = LocalDateTime.now();
    
    private LocalDateTime fulfilledAt;
    
    private String status = "REDEEMED"; // REDEEMED, FULFILLED
    
    private String deliveryDetails;

    public void setDeliveryDetails(String deliveryDetails) {
        this.deliveryDetails = deliveryDetails;
    }

    public void setFulfilledAt(LocalDateTime now) {
        this.fulfilledAt = now;
    }

    public void setFulfilledBy(Staff staff) {
        this.fulfilledBy = staff;
    }

    @Override
    public String toString() {
        return "RewardExchange{" +
                "id=" + id +
                ", studentId=" + (student != null ? student.getId() : "null") +
                ", rewardId=" + (reward != null ? reward.getId() : "null") +
                ", fulfilledById=" + (fulfilledBy != null ? fulfilledBy.getId() : "null") +
                ", pointsSpent=" + pointsSpent +
                ", exchangedAt=" + exchangedAt +
                ", fulfilledAt=" + fulfilledAt +
                ", status='" + status + '\'' +
                ", deliveryDetails='" + deliveryDetails + '\'' +
                '}';
    }
}