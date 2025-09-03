package studentplatform.student_platform.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Entity
@Table(name = "spin_wheel_items")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class SpinWheelItem {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @NotBlank(message = "Item label is required")
    @Size(max = 100, message = "Item label cannot exceed 100 characters")
    private String label;
    
    private String description;
    
    // The value in points that this item is worth
    @NotNull(message = "Point value is required")
    private Integer pointValue;
    
    // Probability weight for this item (higher number = higher chance)
    @NotNull(message = "Probability weight is required")
    @Positive(message = "Probability weight must be positive")
    private Integer probabilityWeight = 1;
    
    // Color for the segment on the wheel (in hex format: #RRGGBB)
    private String color;
    
    @ManyToOne
    @JoinColumn(name = "spin_wheel_id")
    private SpinWheel spinWheel;
    
    @Override
    public String toString() {
        return "SpinWheelItem{" +
                "id=" + id +
                ", label='" + label + '\'' +
                ", description='" + description + '\'' +
                ", pointValue=" + pointValue +
                ", probabilityWeight=" + probabilityWeight +
                ", color='" + color + '\'' +
                ", spinWheelId=" + (spinWheel != null ? spinWheel.getId() : "null") +
                '}';
    }
}