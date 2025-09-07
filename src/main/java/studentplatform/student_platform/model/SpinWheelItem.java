package studentplatform.student_platform.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PostLoad;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.time.LocalDateTime;

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
    @Size(min = 1, max = 50, message = "Item label must be between 1 and 50 characters")
    private String label;
    
    private String description;
    
    @NotNull(message = "Point value is required")
    @Positive(message = "Point value must be positive")
    private Integer pointValue;
    
    @NotNull(message = "Probability weight is required")
    @Positive(message = "Probability weight must be positive")
    private Integer probabilityWeight = 1;
    
    private String itemType = "POINTS"; // POINTS, PHONE_BILL
    
    private String itemColor = "#007bff"; // Hex color for the item
    
    private String icon = "bi-star"; // Bootstrap icon class
    
    // Getters with null safety
    public String getItemColor() {
        return itemColor != null ? itemColor : "#007bff";
    }
    
    public String getIcon() {
        return icon != null ? icon : "bi-star";
    }
    
    public String getItemType() {
        return itemType != null ? itemType : "POINTS";
    }
    
    // Setters with null safety
    public void setItemColor(String itemColor) {
        this.itemColor = (itemColor != null && !itemColor.trim().isEmpty()) ? itemColor : "#007bff";
    }
    
    public void setIcon(String icon) {
        this.icon = (icon != null && !icon.trim().isEmpty()) ? icon : "bi-star";
    }
    
    public void setItemType(String itemType) {
        this.itemType = (itemType != null && !itemType.trim().isEmpty()) ? itemType : "POINTS";
    }
    
    @PostLoad
    public void initializeDefaults() {
        if (itemColor == null || itemColor.trim().isEmpty()) {
            itemColor = "#007bff";
        }
        if (icon == null || icon.trim().isEmpty()) {
            icon = "bi-star";
        }
        if (itemType == null || itemType.trim().isEmpty()) {
            itemType = "POINTS";
        }
    }
    
    @ManyToOne
    @JoinColumn(name = "spin_wheel_id")
    private SpinWheel spinWheel;
    
    private LocalDateTime createdAt = LocalDateTime.now();
    
    private LocalDateTime updatedAt = LocalDateTime.now();
    
    @Override
    public String toString() {
        return "SpinWheelItem{" +
                "id=" + id +
                ", label='" + label + '\'' +
                ", description='" + description + '\'' +
                ", pointValue=" + pointValue +
                ", probabilityWeight=" + probabilityWeight +
                ", itemType='" + itemType + '\'' +
                ", itemColor='" + itemColor + '\'' +
                ", icon='" + icon + '\'' +
                ", spinWheelId=" + (spinWheel != null ? spinWheel.getId() : "null") +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}