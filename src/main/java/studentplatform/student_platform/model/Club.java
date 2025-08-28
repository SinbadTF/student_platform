package studentplatform.student_platform.model;
//htet htet 
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
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "clubs")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Club {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @NotBlank(message = "Club name is required")
    @Size(min = 3, max = 100, message = "Club name must be between 3 and 100 characters")
    private String name;
    
    @NotBlank(message = "Description is required")
    @Size(max = 500, message = "Description cannot exceed 500 characters")
    private String description;
    
    private String meetingLocation;
    
    private String meetingSchedule;
    
    @ManyToOne
    @JoinColumn(name = "created_by_id")
    private Admin createdBy;
    
    @OneToMany(mappedBy = "club")
    private List<ClubParticipation> participants = new ArrayList<>();

    @Override
    public String toString() {
        return "Club{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", meetingLocation='" + meetingLocation + '\'' +
                ", meetingSchedule='" + meetingSchedule + '\'' +
                ", createdById=" + (createdBy != null ? createdBy.getId() : "null") +
                ", participantsCount=" + (participants != null ? participants.size() : 0) +
                '}';
    }
}