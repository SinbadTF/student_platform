package studentplatform.student_platform.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import studentplatform.student_platform.model.Student;
import studentplatform.student_platform.model.SpinWheelHistory;
import studentplatform.student_platform.service.SpinWheelHistoryService;
import studentplatform.student_platform.service.StudentService;

import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Optional;

@Controller
public class SpinWheelHistoryController {

    private final SpinWheelHistoryService spinWheelHistoryService;
    private final StudentService studentService;

    @Autowired
    public SpinWheelHistoryController(SpinWheelHistoryService spinWheelHistoryService, StudentService studentService) {
        this.spinWheelHistoryService = spinWheelHistoryService;
        this.studentService = studentService;
    }

    @GetMapping("/students/spinwheel-history")
    public String spinwheelHistory(Model model, HttpSession session) {
        Student student = (Student) session.getAttribute("user");
        if (student == null) {
            return "redirect:/login";
        }

        // Get student's spinwheel history
        List<SpinWheelHistory> spinHistory = spinWheelHistoryService.getHistoryByStudent(student);
        
        model.addAttribute("student", student);
        model.addAttribute("spinHistory", spinHistory);
        
        return "students/spinwheel-history";
    }

    @GetMapping("/students/spinwheel-history/{studentId}")
    public String spinwheelHistoryById(@PathVariable Long studentId, Model model, HttpSession session) {
        Student currentStudent = (Student) session.getAttribute("user");
        if (currentStudent == null) {
            return "redirect:/login";
        }

        // Verify the student is accessing their own history
        if (!currentStudent.getId().equals(studentId)) {
            return "redirect:/students/spinwheel-history";
        }

        Optional<Student> studentOpt = studentService.getStudentById(studentId);
        if (studentOpt.isPresent()) {
            Student student = studentOpt.get();
            List<SpinWheelHistory> spinHistory = spinWheelHistoryService.getHistoryByStudent(student);
            
            model.addAttribute("student", student);
            model.addAttribute("spinHistory", spinHistory);
            
            return "students/spinwheel-history";
        }
        
        return "redirect:/students/spinwheel-history";
    }
}
