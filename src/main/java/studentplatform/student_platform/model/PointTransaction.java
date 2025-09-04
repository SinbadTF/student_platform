package studentplatform.student_platform.model;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "point_transactions")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class PointTransaction {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn(name = "student_id")
    private Student student;
    
    private Integer pointsAmount; // Positive for earned, negative for spent
    
    private Integer pointsBalance; // Balance after transaction
    
    private String reason; // Description of why points were added/deducted
    
    @Enumerated(EnumType.STRING)
    private TransactionType type; // EARNED or SPENT
    
    private LocalDateTime transactionDate = LocalDateTime.now();
    
    @ManyToOne
    @JoinColumn(name = "created_by_admin_id")
    private Admin createdByAdmin; // If an admin created this transaction
    
    @ManyToOne
    @JoinColumn(name = "created_by_staff_id")
    private Staff createdByStaff; // If a staff member created this transaction
    
    @Enumerated(EnumType.STRING)
    private SourceType sourceType; // EVENT, CLUB, ATTENDANCE, REWARD_EXCHANGE, MANUAL
    
    private Long sourceId; // ID of the source entity (event, club, etc.)
    
    public enum TransactionType {
        EARNED,
        SPENT
    }
    
    public enum SourceType {
        EVENT,
        CLUB,
        ATTENDANCE,
        REWARD_EXCHANGE,
        MANUAL
    }
    
    @Override
    public String toString() {
        return "PointTransaction{" +
                "id=" + id +
                ", studentId=" + (student != null ? student.getId() : "null") +
                ", pointsAmount=" + pointsAmount +
                ", pointsBalance=" + pointsBalance +
                ", reason='" + reason + '\'' +
                ", type=" + type +
                ", transactionDate=" + transactionDate +
                ", sourceType=" + sourceType +
                ", sourceId=" + sourceId +
                '}';
    }
}