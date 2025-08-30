package studentplatform.student_platform.mapper;

import studentplatform.student_platform.dto.AttendanceDTO;
import studentplatform.student_platform.model.Attendance;
import studentplatform.student_platform.model.Admin;
import studentplatform.student_platform.model.Student;

public class AttendanceMapper {

    public static AttendanceDTO toDTO(Attendance attendance) {
        if (attendance == null) {
            return null;
        }
        
        AttendanceDTO dto = new AttendanceDTO();
        dto.setId(attendance.getId());
        dto.setStudentId(attendance.getStudent().getId());
        dto.setMonth(attendance.getMonth());
        dto.setPercentage(attendance.getPercentage());
        dto.setApproved(attendance.isApproved());
        
        if (attendance.getApprovedBy() != null) {
            dto.setApprovedById(attendance.getApprovedBy().getId());
        }
        
        dto.setAwardedPoints(attendance.getAwardedPoints());
        
        return dto;
    }

    public static Attendance toEntity(AttendanceDTO dto, Student student, Admin approvedBy) {
        if (dto == null) {
            return null;
        }
        
        Attendance attendance = new Attendance();
        attendance.setId(dto.getId());
        attendance.setStudent(student);
        attendance.setMonth(dto.getMonth());
        attendance.setPercentage(dto.getPercentage());
        attendance.setApproved(dto.getApproved());
        attendance.setApprovedBy(approvedBy);
        attendance.setAwardedPoints(dto.getAwardedPoints());
        
        return attendance;
    }
}