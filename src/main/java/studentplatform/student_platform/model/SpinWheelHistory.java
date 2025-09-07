package studentplatform.student_platform.model;

import jakarta.persistence.Entity;
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
@Table(name = "spin_wheel_history")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class SpinWheelHistory {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn(name = "student_id")
    private Student student;
    
    @ManyToOne
    @JoinColumn(name = "spin_wheel_id")
    private SpinWheel spinWheel;
    
    @ManyToOne
    @JoinColumn(name = "spin_wheel_item_id")
    private SpinWheelItem resultItem;
    
    // Points awarded from this spin
    private Integer pointsAwarded;
    
    // When the spin occurred
    private LocalDateTime spunAt = LocalDateTime.now();
    
    @Override
    public String toString() {
        return "SpinWheelHistory{" +
                "id=" + id +
                ", studentId=" + (student != null ? student.getId() : "null") +
                ", spinWheelId=" + (spinWheel != null ? spinWheel.getId() : "null") +
                ", resultItemId=" + (resultItem != null ? resultItem.getId() : "null") +
                ", pointsAwarded=" + pointsAwarded +
                ", spunAt=" + spunAt +
                '}';
    }
}