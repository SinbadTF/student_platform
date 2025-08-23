package studentplatform.student_platform.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PastOrPresent;
import jakarta.validation.constraints.Positive;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "points")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Point {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @NotNull(message = "Point value is required")
    @Positive(message = "Point value must be positive")
    private Integer value;
    
    private String reason;
    
    @PastOrPresent(message = "Issue date cannot be in the future")
    private LocalDateTime issuedAt = LocalDateTime.now();
    
    @ManyToOne
    @JoinColumn(name = "student_id")
    private Student student;
    
    @ManyToOne
    @JoinColumn(name = "reward_id")
    private Reward reward;
    
    @ManyToOne
    @JoinColumn(name = "issued_by_id")
    private Staff issuedBy;
}