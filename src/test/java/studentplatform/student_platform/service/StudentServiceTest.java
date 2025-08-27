package studentplatform.student_platform.service;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import studentplatform.student_platform.model.Student;
import studentplatform.student_platform.repository.StudentRepository;
import studentplatform.student_platform.repository.RewardRepository;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

class StudentServiceTest {

    @Mock
    private StudentRepository studentRepository;
    
    @Mock
    private RewardRepository rewardRepository;

    @InjectMocks
    private StudentService studentService;

    private Student student1;
    private Student student2;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        
        // Create test student objects
        student1 = new Student();
        student1.setId(1L);
        student1.setStudentId("STU001");
        student1.setFirstName("Alice");
        student1.setLastName("Johnson");
        student1.setEmail("alice.johnson@university.edu");
        student1.setDepartment("Computer Science");
        
        student2 = new Student();
        student2.setId(2L);
        student2.setStudentId("STU002");
        student2.setFirstName("Bob");
        student2.setLastName("Smith");
        student2.setEmail("bob.smith@university.edu");
        student2.setDepartment("Mathematics");
    }
    
    @Test
    void getAllStudents() {
        // Arrange
        List<Student> students = Arrays.asList(student1, student2);
        when(studentRepository.findAll()).thenReturn(students);

        // Act
        List<Student> result = studentService.getAllStudents();

        // Assert
        assertEquals(2, result.size());
        assertEquals(student1.getStudentId(), result.get(0).getStudentId());
        assertEquals(student2.getStudentId(), result.get(1).getStudentId());
        verify(studentRepository, times(1)).findAll();
    }

    @Test
    void getStudentById() {
        // Arrange
        when(studentRepository.findById(1L)).thenReturn(Optional.of(student1));
        when(studentRepository.findById(3L)).thenReturn(Optional.empty());

        // Act & Assert - Existing student
        Optional<Student> foundStudent = studentService.getStudentById(1L);
        assertTrue(foundStudent.isPresent());
        assertEquals(student1.getStudentId(), foundStudent.get().getStudentId());

        // Act & Assert - Non-existing student
        Optional<Student> notFoundStudent = studentService.getStudentById(3L);
        assertFalse(notFoundStudent.isPresent());

        verify(studentRepository, times(1)).findById(1L);
        verify(studentRepository, times(1)).findById(3L);
    }

    

    @Test
    void getStudentByEmail() {
        // Arrange
        when(studentRepository.findByEmail("alice.johnson@university.edu")).thenReturn(Optional.of(student1));
        when(studentRepository.findByEmail("nonexistent@university.edu")).thenReturn(Optional.empty());

        // Act & Assert - Existing student
        Optional<Student> foundStudent = studentService.getStudentByEmail("alice.johnson@university.edu");
        assertTrue(foundStudent.isPresent());
        assertEquals("Alice", foundStudent.get().getFirstName());

        // Act & Assert - Non-existing student
        Optional<Student> notFoundStudent = studentService.getStudentByEmail("nonexistent@university.edu");
        assertFalse(notFoundStudent.isPresent());

        verify(studentRepository, times(1)).findByEmail("alice.johnson@university.edu");
        verify(studentRepository, times(1)).findByEmail("nonexistent@university.edu");
    }

    @Test
    void getStudentsByDepartment() {
        // Arrange
        List<Student> csStudents = Arrays.asList(student1);
        when(studentRepository.findByDepartment("Computer Science")).thenReturn(csStudents);
        when(studentRepository.findByDepartment("Physics")).thenReturn(Arrays.asList());

        // Act & Assert - Existing department
        List<Student> foundStudents = studentService.getStudentsByDepartment("Computer Science");
        assertEquals(1, foundStudents.size());
        assertEquals("Alice", foundStudents.get(0).getFirstName());

        // Act & Assert - Department with no students
        List<Student> emptyList = studentService.getStudentsByDepartment("Physics");
        assertTrue(emptyList.isEmpty());

        verify(studentRepository, times(1)).findByDepartment("Computer Science");
        verify(studentRepository, times(1)).findByDepartment("Physics");
    }

    @Test
    void saveStudent() {
        // Arrange
        when(studentRepository.save(any(Student.class))).thenReturn(student1);

        // Act
        Student savedStudent = studentService.saveStudent(student1);

        // Assert
        assertNotNull(savedStudent);
        assertEquals(student1.getStudentId(), savedStudent.getStudentId());
        verify(studentRepository, times(1)).save(student1);
    }

    @Test
    void deleteStudent() {
        // Arrange
        doNothing().when(studentRepository).deleteById(1L);

        // Act
        studentService.deleteStudent(1L);

        // Assert
        verify(studentRepository, times(1)).deleteById(1L);
    }
}