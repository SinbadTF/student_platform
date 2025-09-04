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
import java.time.Month;

@Entity
@Table(name = "attendances")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Attendance {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn(name = "student_id")
    private Student student;
    
    @Enumerated(EnumType.STRING)
    private Month month;
    
    private Integer year;
    
    private Double attendancePercentage;
    
    private LocalDateTime createdAt = LocalDateTime.now();
    
    private LocalDateTime updatedAt;
    
    @ManyToOne
    @JoinColumn(name = "created_by_id")
    private Admin createdBy;
    
    @ManyToOne
    @JoinColumn(name = "updated_by_id")
    private Admin updatedBy;
    
    private boolean pointsAwarded = false;
    
    private boolean approved = false;
    
    @Override
    public String toString() {
        return "Attendance{" +
                "id=" + id +
                ", studentId=" + (student != null ? student.getId() : "null") +
                ", month=" + month +
                ", year=" + year +
                ", attendancePercentage=" + attendancePercentage +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                ", createdById=" + (createdBy != null ? createdBy.getId() : "null") +
                ", updatedById=" + (updatedBy != null ? updatedBy.getId() : "null") +
                ", pointsAwarded=" + pointsAwarded +
                ", approved=" + approved +
                "}";
    }
}