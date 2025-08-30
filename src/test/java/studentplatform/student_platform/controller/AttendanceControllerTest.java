package studentplatform.student_platform.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import studentplatform.student_platform.dto.AttendanceDTO;
import studentplatform.student_platform.exception.ResourceNotFoundException;
import studentplatform.student_platform.mapper.AttendanceMapper;
import studentplatform.student_platform.model.Admin;
import studentplatform.student_platform.model.Attendance;
import studentplatform.student_platform.model.Student;
import studentplatform.student_platform.service.AdminService;
import studentplatform.student_platform.service.AttendanceService;
import studentplatform.student_platform.service.StudentService;

import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.Optional;

import static org.hamcrest.Matchers.hasSize;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

class AttendanceControllerTest {

    private MockMvc mockMvc;

    @Mock
    private AttendanceService attendanceService;

    @Mock
    private StudentService studentService;

    @Mock
    private AdminService adminService;

    @InjectMocks
    private AttendanceController attendanceController;

    private ObjectMapper objectMapper;
    private Student student;
    private Admin admin;
    private Attendance attendance;
    private AttendanceDTO attendanceDTO;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        mockMvc = MockMvcBuilders.standaloneSetup(attendanceController).build();

        objectMapper = new ObjectMapper();
        objectMapper.registerModule(new JavaTimeModule());

        student = new Student();
        student.setId(1L);
        student.setFirstName("John");
        student.setLastName("Doe");

        admin = new Admin();
        admin.setId(1L);
        admin.setFirstName("Admin");
        admin.setLastName("User");

        attendance = new Attendance();
        attendance.setId(1L);
        attendance.setStudent(student);
        attendance.setMonth(YearMonth.now());
        attendance.setPercentage(90);
        attendance.setApproved(false);

        attendanceDTO = new AttendanceDTO();
        attendanceDTO.setId(1L);
        attendanceDTO.setStudentId(1L);
        attendanceDTO.setMonth(YearMonth.now());
        attendanceDTO.setPercentage(90);
        attendanceDTO.setApproved(false);
    }

    @Test
    void getAllAttendances() throws Exception {
        when(attendanceService.getAllAttendances()).thenReturn(Arrays.asList(attendance));

        mockMvc.perform(get("/api/attendances"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(1)));
    }

    @Test
    void getAttendanceById() throws Exception {
        when(attendanceService.getAttendanceById(1L)).thenReturn(Optional.of(attendance));

        mockMvc.perform(get("/api/attendances/1"))
                .andExpect(status().isOk());
    }

    @Test
    void getAttendanceById_NotFound() throws Exception {
        when(attendanceService.getAttendanceById(1L)).thenReturn(Optional.empty());

        mockMvc.perform(get("/api/attendances/1"))
                .andExpect(status().isNotFound());
    }

    @Test
    void getAttendancesByStudent() throws Exception {
        when(attendanceService.getAttendancesByStudentId(1L)).thenReturn(Arrays.asList(attendance));

        mockMvc.perform(get("/api/attendances/student/1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(1)));
    }

    @Test
    void getAttendancesByStudent_NotFound() throws Exception {
        when(attendanceService.getAttendancesByStudentId(1L)).thenThrow(new ResourceNotFoundException("Student not found"));

        mockMvc.perform(get("/api/attendances/student/1"))
                .andExpect(status().isNotFound());
    }

    @Test
    void getAttendancesByMonth() throws Exception {
        YearMonth month = YearMonth.now();
        String monthStr = month.format(DateTimeFormatter.ofPattern("yyyy-MM"));
        
        when(attendanceService.getAttendancesByMonth(month)).thenReturn(Arrays.asList(attendance));

        mockMvc.perform(get("/api/attendances/month/" + monthStr))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(1)));
    }

    @Test
    void getPendingAttendances() throws Exception {
        when(attendanceService.getPendingAttendances()).thenReturn(Arrays.asList(attendance));

        mockMvc.perform(get("/api/attendances/pending"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(1)));
    }

    @Test
    void createAttendance() throws Exception {
        when(studentService.getStudentById(1L)).thenReturn(Optional.of(student));
        when(attendanceService.saveAttendance(any(Attendance.class))).thenReturn(attendance);

        mockMvc.perform(post("/api/attendances")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(attendanceDTO)))
                .andExpect(status().isCreated());
    }

    @Test
    void createAttendance_StudentNotFound() throws Exception {
        when(studentService.getStudentById(1L)).thenReturn(Optional.empty());

        mockMvc.perform(post("/api/attendances")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(attendanceDTO)))
                .andExpect(status().isNotFound());
    }

    @Test
    void updateAttendance() throws Exception {
        when(attendanceService.getAttendanceById(1L)).thenReturn(Optional.of(attendance));
        when(studentService.getStudentById(1L)).thenReturn(Optional.of(student));
        when(attendanceService.saveAttendance(any(Attendance.class))).thenReturn(attendance);

        mockMvc.perform(put("/api/attendances/1")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(attendanceDTO)))
                .andExpect(status().isOk());
    }

    @Test
    void approveAttendance() throws Exception {
        when(adminService.getAdminById(1L)).thenReturn(Optional.of(admin));
        when(attendanceService.approveAttendance(eq(1L), any(Admin.class))).thenReturn(attendance);

        mockMvc.perform(post("/api/attendances/1/approve?adminId=1"))
                .andExpect(status().isOk());
    }

    @Test
    void approveAttendance_AdminNotFound() throws Exception {
        when(adminService.getAdminById(1L)).thenReturn(Optional.empty());

        mockMvc.perform(post("/api/attendances/1/approve?adminId=1"))
                .andExpect(status().isNotFound());
    }

    @Test
    void deleteAttendance() throws Exception {
        when(attendanceService.getAttendanceById(1L)).thenReturn(Optional.of(attendance));

        mockMvc.perform(delete("/api/attendances/1"))
                .andExpect(status().isNoContent());
    }

    @Test
    void deleteAttendance_NotFound() throws Exception {
        when(attendanceService.getAttendanceById(1L)).thenReturn(Optional.empty());

        mockMvc.perform(delete("/api/attendances/1"))
                .andExpect(status().isNotFound());
    }
}