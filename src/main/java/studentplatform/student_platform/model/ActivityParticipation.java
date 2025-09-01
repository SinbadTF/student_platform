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
@Table(name = "activity_participations")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ActivityParticipation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "student_id")
    private Student student;

    @ManyToOne
    @JoinColumn(name = "activity_id")
    private Activity activity;

    private LocalDateTime participatedAt = LocalDateTime.now();

    @Enumerated(EnumType.STRING)
    private ParticipationStatus status = ParticipationStatus.PENDING;

    private LocalDateTime approvedAt;

    @ManyToOne
    @JoinColumn(name = "approved_by_id")
    private Admin approvedBy;

    private Integer pointsEarned;

    public enum ParticipationStatus {
        PENDING,
        APPROVED,
        REJECTED
    }

    @Override
    public String toString() {
        return "ActivityParticipation{" +
                "id=" + id +
                ", studentId=" + (student != null ? student.getId() : "null") +
                ", activityId=" + (activity != null ? activity.getId() : "null") +
                ", participatedAt=" + participatedAt +
                ", status=" + status +
                ", approvedAt=" + approvedAt +
                ", approvedById=" + (approvedBy != null ? approvedBy.getId() : "null") +
                ", pointsEarned=" + pointsEarned +
                '}';
    }
}