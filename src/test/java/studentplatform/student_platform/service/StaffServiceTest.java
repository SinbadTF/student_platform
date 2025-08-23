package studentplatform.student_platform.service;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import studentplatform.student_platform.model.Staff;
import studentplatform.student_platform.repository.StaffRepository;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

class StaffServiceTest {

    @Mock
    private StaffRepository staffRepository;

    @InjectMocks
    private StaffService staffService;

    private Staff staff1;
    private Staff staff2;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);

        // Create test staff members
        staff1 = new Staff();
        staff1.setId(1L);
        staff1.setStaffId("STAFF001");
        staff1.setFirstName("John");
        staff1.setLastName("Doe");
        staff1.setEmail("john.doe@university.edu");
        staff1.setDepartment("Computer Science");
        staff1.setPosition("Professor");

        staff2 = new Staff();
        staff2.setId(2L);
        staff2.setStaffId("STAFF002");
        staff2.setFirstName("Jane");
        staff2.setLastName("Smith");
        staff2.setEmail("jane.smith@university.edu");
        staff2.setDepartment("Mathematics");
        staff2.setPosition("Associate Professor");
    }

    @Test
    void getAllStaff() {
        // Arrange
        List<Staff> staffList = Arrays.asList(staff1, staff2);
        when(staffRepository.findAll()).thenReturn(staffList);

        // Act
        List<Staff> result = staffService.getAllStaff();

        // Assert
        assertEquals(2, result.size());
        assertEquals(staff1.getStaffId(), result.get(0).getStaffId());
        assertEquals(staff2.getStaffId(), result.get(1).getStaffId());
        verify(staffRepository, times(1)).findAll();
    }

    @Test
    void getStaffById() {
        // Arrange
        when(staffRepository.findById(1L)).thenReturn(Optional.of(staff1));
        when(staffRepository.findById(3L)).thenReturn(Optional.empty());

        // Act & Assert - Existing staff
        Optional<Staff> foundStaff = staffService.getStaffById(1L);
        assertTrue(foundStaff.isPresent());
        assertEquals(staff1.getStaffId(), foundStaff.get().getStaffId());

        // Act & Assert - Non-existing staff
        Optional<Staff> notFoundStaff = staffService.getStaffById(3L);
        assertFalse(notFoundStaff.isPresent());

        verify(staffRepository, times(1)).findById(1L);
        verify(staffRepository, times(1)).findById(3L);
    }

    @Test
    void saveStaff() {
        // Arrange
        when(staffRepository.save(any(Staff.class))).thenReturn(staff1);

        // Act
        Staff savedStaff = staffService.saveStaff(staff1);

        // Assert
        assertNotNull(savedStaff);
        assertEquals(staff1.getStaffId(), savedStaff.getStaffId());
        verify(staffRepository, times(1)).save(staff1);
    }

    @Test
    void deleteStaff() {
        // Arrange
        doNothing().when(staffRepository).deleteById(1L);

        // Act
        staffService.deleteStaff(1L);

        // Assert
        verify(staffRepository, times(1)).deleteById(1L);
    }
}