package studentplatform.student_platform.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Entity
@Table(name = "semesters", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"name", "year"})
})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Semester {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    private String name;
    
    private Integer year;
    @Column(name = "is_active")
    private boolean active = false;
   
  
    
    // Constants for semester names
    public static final String FIRST_SEMESTER = "First Semester";
    public static final String SECOND_SEMESTER = "Second Semester";
    
    // Helper method to get all available semester names
    public static String[] getAllSemesterNames() {
        return new String[] {FIRST_SEMESTER, SECOND_SEMESTER};
    }
    
    @Override
    public String toString() {
        return name + " " + year;
    }
}