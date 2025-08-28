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
@Table(name = "event_participations")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class EventParticipation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "student_id")
    private Student student;

    @ManyToOne
    @JoinColumn(name = "event_id")
    private Event event;

    private LocalDateTime registeredAt = LocalDateTime.now();

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

    @Override
    public String toString() {
        return "EventParticipation{" +
                "id=" + id +
                ", studentId=" + (student != null ? student.getId() : "null") +
                ", eventId=" + (event != null ? event.getId() : "null") +
                ", registeredAt=" + registeredAt +
                ", status=" + status +
                ", approvedAt=" + approvedAt +
                ", approvedById=" + (approvedBy != null ? approvedBy.getId() : "null") +
                ", pointsAwarded=" + pointsAwarded +
                '}';
    }
}


