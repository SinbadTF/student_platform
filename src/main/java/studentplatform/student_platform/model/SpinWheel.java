package studentplatform.student_platform.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "spin_wheels")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class SpinWheel {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @NotBlank(message = "Spin wheel name is required")
    @Size(min = 3, max = 100, message = "Spin wheel name must be between 3 and 100 characters")
    private String name;
    
    private String description;
    
    private LocalDateTime createdAt = LocalDateTime.now();
    
    private LocalDateTime updatedAt = LocalDateTime.now();
    
    @ManyToOne
    @JoinColumn(name = "created_by_id")
    private Admin createdBy;
    
    // Whether this spin wheel is currently active
    private boolean active = true;
    
    @OneToMany(mappedBy = "spinWheel")
    private List<SpinWheelItem> items = new ArrayList<>();
    
    @Override
    public String toString() {
        return "SpinWheel{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                ", createdById=" + (createdBy != null ? createdBy.getId() : "null") +
                ", active=" + active +
                ", itemsCount=" + (items != null ? items.size() : 0) +
                '}';
    }
}