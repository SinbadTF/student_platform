package studentplatform.student_platform.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.YearMonth;

@Entity
@Table(name = "attendances", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"student_id", "month"})
})
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Attendance {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn(name = "student_id")
    @NotNull(message = "Student is required")
    private Student student;
    
    @NotNull(message = "Month is required")
    private YearMonth month;
    
    @Min(value = 0, message = "Percentage must be at least 0")
    @Max(value = 100, message = "Percentage cannot exceed 100")
    private Integer percentage;
    
    private boolean approved = false;
    
    @ManyToOne
    @JoinColumn(name = "approved_by")
    private Admin approvedBy;
    
    private Integer awardedPoints;
    
    // Helper method to determine points based on attendance percentage
   public static int calculatePointsToAward(double percentage) {
    if (percentage < 80) return 0;
    if (percentage < 90) return 30;
    if (percentage < 100) return 40;
    return 50;
}

}