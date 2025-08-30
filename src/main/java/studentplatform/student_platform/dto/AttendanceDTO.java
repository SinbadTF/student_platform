package studentplatform.student_platform.dto;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import java.time.YearMonth;

public class AttendanceDTO {
    private Long id;
    
    @NotNull(message = "Student ID is required")
    private Long studentId;
    
    @NotNull(message = "Month is required")
    private YearMonth month;
    
    @NotNull(message = "Attendance percentage is required")
    @Min(value = 0, message = "Percentage cannot be less than 0")
    @Max(value = 100, message = "Percentage cannot be more than 100")
    private Integer percentage;
    
    private Boolean approved;
    private Long approvedById;
    private Integer awardedPoints;

    public AttendanceDTO() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getStudentId() {
        return studentId;
    }

    public void setStudentId(Long studentId) {
        this.studentId = studentId;
    }

    public YearMonth getMonth() {
        return month;
    }

    public void setMonth(YearMonth month) {
        this.month = month;
    }

    public Integer getPercentage() {
        return percentage;
    }

    public void setPercentage(Integer percentage) {
        this.percentage = percentage;
    }

    public Boolean getApproved() {
        return approved;
    }

    public void setApproved(Boolean approved) {
        this.approved = approved;
    }

    public Long getApprovedById() {
        return approvedById;
    }

    public void setApprovedById(Long approvedById) {
        this.approvedById = approvedById;
    }

    public Integer getAwardedPoints() {
        return awardedPoints;
    }

    public void setAwardedPoints(Integer awardedPoints) {
        this.awardedPoints = awardedPoints;
    }
}