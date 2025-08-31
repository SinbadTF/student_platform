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
@Table(name = "club_memberships")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ClubMembership {

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
    private MembershipStatus status = MembershipStatus.ACTIVE;

    private LocalDateTime approvedAt;

    @ManyToOne
    @JoinColumn(name = "approved_by_id")
    private Admin approvedBy;

    public enum MembershipStatus {
        PENDING,
        ACTIVE,
        INACTIVE,
        SUSPENDED
    }

    @Override
    public String toString() {
        return "ClubMembership{" +
                "id=" + id +
                ", studentId=" + (student != null ? student.getId() : "null") +
                ", clubId=" + (club != null ? club.getId() : "null") +
                ", joinedAt=" + joinedAt +
                ", status=" + status +
                ", approvedAt=" + approvedAt +
                ", approvedById=" + (approvedBy != null ? approvedBy.getId() : "null") +
                '}';
    }
}
