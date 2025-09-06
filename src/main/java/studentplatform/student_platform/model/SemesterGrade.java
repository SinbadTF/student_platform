package studentplatform.student_platform.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "semester_grades", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"student_id", "semester_id"})
})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class SemesterGrade {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn(name = "student_id")
    private Student student;
    
    @ManyToOne
    @JoinColumn(name = "semester_id")
    private Semester semester;
    
    private Double gpa;
    
    private LocalDateTime createdAt = LocalDateTime.now();
    
    private LocalDateTime updatedAt;
    
    @ManyToOne
    @JoinColumn(name = "created_by_id")
    private Admin createdBy;
    
    @ManyToOne
    @JoinColumn(name = "updated_by_id")
    private Admin updatedBy;
    
    private boolean pointsAwarded = false;
    
    // Add this field with a default value
    private boolean approved = false;
    
    /**
     * Calculate points based on GPA thresholds:
     * - GPA > 3.5: 3000 points
     * - GPA between 3.0 and 3.5: 1500 points
     * - GPA < 3.0: 1000 points
     */
    public int calculatePoints() {
        if (gpa == null) {
            return 0;
        }
        
        if (gpa > 3.5) {
            return 3000;
        } else if (gpa >= 3.0) {
            return 1500;
        } else {
            return 1000;
        }
    }
    
    @Override
    public String toString() {
        return "SemesterGrade{" +
                "id=" + id +
                ", studentId=" + (student != null ? student.getId() : "null") +
                ", semesterId=" + (semester != null ? semester.getId() : "null") +
                ", gpa=" + gpa +
                ", pointsAwarded=" + pointsAwarded +
                "}";
    }
}