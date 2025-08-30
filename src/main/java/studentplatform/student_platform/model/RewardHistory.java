package studentplatform.student_platform.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "reward_history")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class RewardHistory {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn(name = "student_id")
    private Student student;
    
    private String reason;
    
    private Integer pointsAwarded;
    
    private LocalDateTime awardedAt = LocalDateTime.now();
    
    @ManyToOne
    @JoinColumn(name = "awarded_by")
    private Admin awardedBy;
    
    // Constructor for quick creation
    public RewardHistory(Student student, String reason, Integer pointsAwarded, Admin awardedBy) {
        this.student = student;
        this.reason = reason;
        this.pointsAwarded = pointsAwarded;
        this.awardedBy = awardedBy;
        this.awardedAt = LocalDateTime.now();
    }
}