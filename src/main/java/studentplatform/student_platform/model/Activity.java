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
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Entity
@Table(name = "activities")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Activity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Activity title is required")
    @Size(min = 3, max = 100, message = "Activity title must be between 3 and 100 characters")
    private String title;

    @Size(max = 500, message = "Description cannot exceed 500 characters")
    private String description;

    @NotNull(message = "Points are required")
    private Integer points;

    @ManyToOne
    @JoinColumn(name = "club_id")
    private Club club;

    @ManyToOne
    @JoinColumn(name = "created_by_id")
    private Admin createdBy;

    @NotBlank(message = "Club date is required")
    @jakarta.persistence.Column(name = "club_date")
    private String clubDate;

    @NotBlank(message = "Start time is required")
    @jakarta.persistence.Column(name = "start_time")
    private String startTime;

    @NotBlank(message = "End time is required")
    @jakarta.persistence.Column(name = "end_time")
    private String endTime;

    @NotBlank(message = "Activity place is required")
    @Size(max = 200, message = "Activity place cannot exceed 200 characters")
    @jakarta.persistence.Column(name = "activity_place")
    private String activityPlace;

    @Override
    public String toString() {
        return "Activity{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", points=" + points +
                ", clubId=" + (club != null ? club.getId() : "null") +
                ", createdById=" + (createdBy != null ? createdBy.getId() : "null") +
                ", clubDate='" + clubDate + '\'' +
                ", startTime='" + startTime + '\'' +
                ", endTime='" + endTime + '\'' +
                ", activityPlace='" + activityPlace + '\'' +
                '}';
    }
}
