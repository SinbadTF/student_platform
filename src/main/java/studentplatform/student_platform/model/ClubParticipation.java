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
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "club_participations")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ClubParticipation {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn(name = "student_id")
    private Student student;
    
    @ManyToOne
    @JoinColumn(name = "club_id")
    private Club club;
    
    private LocalDateTime joinedAt = LocalDateTime.now();
    
    @Enumerated(EnumType.STRING)
    private ParticipationStatus status = ParticipationStatus.PENDING;
    
    private LocalDateTime approvedAt;
    
    @ManyToOne
    @JoinColumn(name = "approved_by_id")
    private Admin approvedBy;
    
    private boolean pointsAwarded = false;
    
    public enum ParticipationStatus {
        PENDING,
        APPROVED,
        REJECTED
    }
}