package studentplatform.student_platform.controller;

import java.time.LocalDateTime;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.Duration;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.time.format.TextStyle;
import java.util.LinkedHashMap;
import java.util.Locale;
import java.util.Map;
import java.util.HashMap;
import java.time.Month;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import studentplatform.student_platform.model.Reward;
import studentplatform.student_platform.model.RewardExchange;
import studentplatform.student_platform.model.Staff;
import studentplatform.student_platform.model.Student;

import studentplatform.student_platform.service.AdminService;
import studentplatform.student_platform.service.RewardService;
import studentplatform.student_platform.service.RewardExchangeService;
import studentplatform.student_platform.service.StaffService;
import studentplatform.student_platform.service.StudentService;
import studentplatform.student_platform.util.DateTimeUtil;
import studentplatform.student_platform.model.Admin;
import studentplatform.student_platform.model.Attendance;
import studentplatform.student_platform.model.Club;
import studentplatform.student_platform.model.ClubMembership;
import studentplatform.student_platform.model.Event;
import studentplatform.student_platform.model.Activity;
import studentplatform.student_platform.model.ActivityParticipation;
import studentplatform.student_platform.model.EventParticipation;


import studentplatform.student_platform.service.AttendanceService;
import studentplatform.student_platform.service.ClubService;
import studentplatform.student_platform.service.ActivityParticipationService;
import studentplatform.student_platform.service.EventService;
import studentplatform.student_platform.service.ClubService;
import studentplatform.student_platform.service.ActivityService;



@Controller
public class WebController {

    private final StudentService studentService;
    private final StaffService staffService;
    private final RewardService rewardService;
    private final RewardExchangeService rewardExchangeService;
    private final AdminService adminService;

    private final EventService eventService;
    private final ClubService clubService;
    private final ActivityService activityService;
    private final ActivityParticipationService activityParticipationService;

    private final AttendanceService attendanceService;

    
    @Autowired
    public WebController(StudentService studentService, StaffService staffService, 
                         RewardService rewardService, RewardExchangeService rewardExchangeService,
                         AdminService adminService,
                         EventService eventService, ClubService clubService, ActivityService activityService,
                         ActivityParticipationService activityParticipationService,
                         AttendanceService attendanceService) {

        this.studentService = studentService;
        this.staffService = staffService;
        this.rewardService = rewardService;
        this.rewardExchangeService = rewardExchangeService;
        this.adminService = adminService;
        this.eventService = eventService;

        this.clubService = clubService;
        this.activityService = activityService;
        this.activityParticipationService = activityParticipationService;

        this.attendanceService = attendanceService;

    }

    // Update the home method
    @GetMapping("/")
    public String home(Model model, HttpSession session) {
        // Check if user is logged in
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        
        // Add counts for dashboard statistics
        model.addAttribute("studentCount", studentService.getAllStudents().size());
        model.addAttribute("staffCount", staffService.getAllStaff().size());
        model.addAttribute("rewardCount", rewardService.getAllRewards().size());
        model.addAttribute("eventCount", eventService.getAllEvents().size());
   
        return "login";
    }
    
    // Student Management
    @GetMapping("/students")
    public String students(Model model, @RequestParam(required = false) String keyword) {
        if (keyword != null && !keyword.isEmpty()) {
            model.addAttribute("students", studentService.searchStudentsByName(keyword));
        } else {
            model.addAttribute("students", studentService.getAllStudents());
        }
        return "students/list";
    }
    
    @GetMapping("/students/create")
    public String createStudentForm(Model model) {
        Student student = new Student();
        student.initializeNewStudent(); // Initialize default values
        model.addAttribute("student", student);
        return "students/form";
    }
    
    @GetMapping("/students/edit/{id}")
    public String editStudentForm(@PathVariable Long id, Model model) {
        return studentService.getStudentById(id)
                .map(student -> {
                    model.addAttribute("student", student);
                    return "students/form";
                })
                .orElse("redirect:/students");
    }
    
    @PostMapping("/students/save")
    public String saveStudent(@Valid @ModelAttribute("student") Student student, BindingResult result) {
        if (result.hasErrors()) {
            return "students/form";
        }
        studentService.saveStudent(student);
        return "redirect:/students";
    }
    
    @GetMapping("/students/view/{id}")
    public String viewStudent(@PathVariable Long id, Model model) {
        return studentService.getStudentById(id)
                .map(student -> {
                    model.addAttribute("student", student);
                    return "students/view";
                })
                .orElse("redirect:/students");
    }
    
    @GetMapping("/students/delete/{id}")
    public String deleteStudent(@PathVariable Long id, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        studentService.deleteStudent(id);
        return "redirect:/students";
    }
    
    // Staff Management
    @GetMapping("/staff")
    public String staff(Model model, @RequestParam(required = false) String keyword) {
        if (keyword != null && !keyword.isEmpty()) {
            model.addAttribute("staff", staffService.searchStaffByName(keyword));
        } else {
            model.addAttribute("staff", staffService.getAllStaff());
        }
        return "staff/list";
    }
    
    @GetMapping("/staff/create")
    public String createStaffForm(Model model) {
        model.addAttribute("staff", new Staff());
        return "staff/form";
    }
    
    @GetMapping("/staff/edit/{id}")
    public String editStaffForm(@PathVariable Long id, Model model) {
        return staffService.getStaffById(id)
                .map(staff -> {
                    model.addAttribute("staff", staff);
                    return "staff/form";
                })
                .orElse("redirect:/staff");
    }
    
    @PostMapping("/staff/save")
    public String saveStaff(@Valid @ModelAttribute("staff") Staff staff, BindingResult result) {
        if (result.hasErrors()) {
            return "staff/form";
        }
        staffService.saveStaff(staff);
        return "redirect:/staff";
    }
    
    @GetMapping("/staff/view/{id}")
    public String viewStaff(@PathVariable Long id, Model model) {
        return staffService.getStaffById(id)
                .map(staff -> {
                    model.addAttribute("staff", staff);
                    return "staff/view";
                })
                .orElse("redirect:/staff");
    }
    
    @GetMapping("/staff/delete/{id}")
    public String deleteStaff(@PathVariable Long id, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        staffService.deleteStaff(id);
        return "redirect:/staff";
    }
    
    // Rewards Management
    @GetMapping("/rewards")
    public String rewards(Model model, @RequestParam(required = false) String keyword, 
                         @RequestParam(required = false) Boolean showInactive) {
        List<Reward> rewardsList;
        
        if (keyword != null && !keyword.isEmpty()) {
            rewardsList = rewardService.searchRewardsByKeyword(keyword);
        } else if (showInactive != null && showInactive) {
            rewardsList = rewardService.getAllRewards();
        } else {
            rewardsList = rewardService.getActiveRewards();
        }
        
        model.addAttribute("rewards", rewardsList);
        model.addAttribute("showInactive", showInactive != null && showInactive);
        return "rewards/list";
    }
    
    @GetMapping("/rewards/create")
    public String createRewardForm(Model model) {
        model.addAttribute("reward", new Reward());
        model.addAttribute("staffList", staffService.getAllStaff());
        return "rewards/form";
    }
    
    @GetMapping("/rewards/edit/{id}")
    public String editRewardForm(@PathVariable Long id, Model model) {
        return rewardService.getRewardById(id)
                .map(reward -> {
                    model.addAttribute("reward", reward);
                    model.addAttribute("staffList", staffService.getAllStaff());
                    return "rewards/form";
                })
                .orElse("redirect:/rewards");
    }
    
    @PostMapping("/rewards/save")
    public String saveReward(@Valid @ModelAttribute("reward") Reward reward, BindingResult result) {
        if (result.hasErrors()) {
            return "rewards/form";
        }
        rewardService.saveReward(reward);
        return "redirect:/rewards";
    }
    
    @GetMapping("/rewards/view/{id}")
    public String viewReward(@PathVariable Long id, Model model) {
        return rewardService.getRewardById(id)
                .map(reward -> {
                    model.addAttribute("reward", reward);
                    return "rewards/view";
                })
                .orElse("redirect:/rewards");
    }
    
    @GetMapping("/rewards/delete/{id}")
    public String deleteReward(@PathVariable Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        try {
            rewardService.deleteReward(id);
            redirectAttributes.addFlashAttribute("success", "Reward deleted successfully.");
        } catch (IllegalStateException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/rewards";
    }
    
    @GetMapping("/rewards/deactivate/{id}")
    public String deactivateReward(@PathVariable Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        rewardService.deactivateReward(id);
        redirectAttributes.addFlashAttribute("success", "Reward deactivated successfully.");
        return "redirect:/rewards";
    }
    
    @GetMapping("/rewards/activate/{id}")
    public String activateReward(@PathVariable Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        rewardService.activateReward(id);
        redirectAttributes.addFlashAttribute("success", "Reward activated successfully.");
        return "redirect:/rewards";
    }
    
    // Points Management
   
    
    
    // Admin Dashboard
    @GetMapping("/admin/dashboard")
    public String adminDashboard(Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        // Add counts for dashboard statistics
        model.addAttribute("studentCount", studentService.getAllStudents().size());
        model.addAttribute("staffCount", staffService.getAllStaff().size());
        model.addAttribute("rewardCount", rewardService.getAllRewards().size());
        
        // Add pending registrations count
        model.addAttribute("pendingStudentCount", studentService.findByStatus(Student.AccountStatus.PENDING).size());
        model.addAttribute("pendingStaffCount", staffService.findByStatus(Staff.AccountStatus.PENDING).size());
        
        return "admin/dashboard";
    }
    
    // Pending Student Registrations
    @GetMapping("/admin/pending-students")
    public String pendingStudents(Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        model.addAttribute("pendingStudents", studentService.findByStatus(Student.AccountStatus.PENDING));
        return "admin/pending-students";
    }
    
    // Approve Student Registration
    @PostMapping("/admin/approve-student/{id}")
    public String approveStudentRegistration(@PathVariable Long id, @RequestParam String studentId, RedirectAttributes redirectAttributes) {
        // Validate student ID format
        if (!studentId.matches("TNT-\\d{4}")) {
            redirectAttributes.addFlashAttribute("error", "Invalid Student ID format. Must be TNT-**** (e.g., TNT-1234)");
            return "redirect:/admin/pending-students";
        }
        
        try {
            // Update student ID and approve registration
            studentService.updateStudentIdAndApprove(id, studentId);
            redirectAttributes.addFlashAttribute("success", "Student approved successfully with ID: " + studentId);
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error approving student: " + e.getMessage());
        }
        
        return "redirect:/admin/pending-students";
    }
    
    // Reject Student Registration
    @PostMapping("/admin/reject-student/{id}")
    public String rejectStudentRegistration(@RequestParam String studentId) {  
        studentService.rejectRegistration(studentId);
        return "redirect:/admin/pending-students";
    }
    
    // Pending Staff Registrations
    @GetMapping("/admin/pending-staff")
    public String pendingStaff(Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        model.addAttribute("pendingStaff", staffService.findByStatus(Staff.AccountStatus.PENDING));
        return "admin/pending-staff";
    }
    
    // Approve Staff Registration
    @PostMapping("/admin/approve-staff/{id}")
    public String approveStaffRegistration(@PathVariable Long id) {
        staffService.approveRegistration(id);
        return "redirect:/admin/pending-staff";
    }
    
    // Reject Staff Registration
    @PostMapping("/admin/reject-staff/{id}")
    public String rejectStaffRegistration(@PathVariable Long id) {
        staffService.rejectStaff(id);
        return "redirect:/admin/pending-staff";
    }
    
    // Pending Account Page
    @GetMapping("/pending")
    public String pendingAccount() {
        return "pending";
    }
    
    @GetMapping("/register")
    public String registerPage(Model model) {
        return "register";
    }
    
    @PostMapping("/register")
    public String processRegistration(@RequestParam String username,
                                     @RequestParam String email,
                                     @RequestParam String password,
                                     @RequestParam String confirmPassword,
                                     @RequestParam String role,
                                     Model model) {
        
        
        if (!password.equals(confirmPassword)) {
            model.addAttribute("error", "Passwords do not match");
            return "register";
        }
        
        if (role.equals("STUDENT")) {
            if (studentService.findByUsername(username).isPresent()) {
                model.addAttribute("error", "Username already exists");
                return "register";
            }
            
            Student student = new Student();
            student.setUsername(username);
            String Stuhashpasword=studentService.hashPassword(password);
            student.setPassword(Stuhashpasword); 
            student.setEmail(email);
            student.setStatus(Student.AccountStatus.PENDING);
            
           
            student.setFirstName("Pending");
            student.setLastName("Pending");
            student.setDepartment("Pending");
            student.setYear(1);
            
            studentService.saveStudent(student);
            
        } else if (role.equals("STAFF")) {
            if (staffService.findByUsername(username).isPresent()) {
                model.addAttribute("error", "Username already exists");
                return "register";
            }
            
            // Create new staff with pending status
            Staff staff = new Staff();
            staff.setUsername(username);
            String Staffhashpasword=studentService.hashPassword(password);
            staff.setPassword(Staffhashpasword); 
            staff.setEmail(email);
            staff.setStatus(Staff.AccountStatus.PENDING);
            
            // Set default values for required fields
            staff.setFirstName("Pending");
            staff.setLastName("Approval");
            staff.setDepartment("Pending");
            staff.setPosition("Pending");
            
            staffService.saveStaff(staff);
        } else {
            model.addAttribute("error", "Invalid role selected");
            return "register";
        }
        
        model.addAttribute("message", "Registration successful! Your account is pending approval by an administrator.");
        return "login";
    }
    
    @GetMapping("/login")
    public String loginPage(Model model) {
        return "login";
    }
    
    @PostMapping("/login")
    public String processLogin(@RequestParam String username, 
                              @RequestParam String password,
                              @RequestParam String role,
                              HttpSession session,
                              Model model) {
        
        if(role.equals("STUDENT")) {
            Optional<Student> studentOpt = studentService.findByUsername(username);
            if(studentOpt.isPresent()) {
                Student student = studentOpt.get();
                
                // Check if account is pending or rejected
                if (student.getStatus() == Student.AccountStatus.PENDING) {
                    model.addAttribute("message", "Your account is pending approval.");
                    return "pending";
                } else if (student.getStatus() == Student.AccountStatus.REJECTED) {
                    model.addAttribute("error", "Your registration has been rejected.");
                    return "login";
                }
                
                // Continue with authentication
                if(studentService.authStudent(username, password)) {
                    session.setAttribute("user", student);
                    session.setAttribute("userId", student.getId());
                    session.setAttribute("userRole", "STUDENT");
                    return "redirect:/students/dashboard/" + student.getId();
                }
            }
        } else if(role.equals("STAFF")) {
            Optional<Staff> staffOpt = staffService.findByUsername(username);
            if(staffOpt.isPresent()) {
                Staff staff = staffOpt.get();
                
                // Check if account is pending or rejected
                if (staff.getStatus() == Staff.AccountStatus.PENDING) {
                    model.addAttribute("message", "Your account is pending approval.");
                    return "pending";
                } else if (staff.getStatus() == Staff.AccountStatus.REJECTED) {
                    model.addAttribute("error", "Your registration has been rejected.");
                    return "login";
                }
                
                // Continue with authentication
                if(staffService.authStaff(username, password)) {
                    Staff staffWithRewards = staffService.getStaffWithRewards(username);
                    session.setAttribute("user", staffWithRewards);
                    session.setAttribute("userId", staffWithRewards.getId());
                    session.setAttribute("userRole", "STAFF");
                    return "redirect:/staff/dashboard";
                }
            }
        } else if(role.equals("ADMIN")) {
            // Admin authentication (assuming you have an AdminService)
            if(adminService.authAdmin(username, password)) {
                Optional<Admin> adminOpt = adminService.findByUsername(username);
                if(adminOpt.isPresent()) {
                    Admin admin = adminOpt.get();
                    session.setAttribute("user", admin);
                    session.setAttribute("userId", admin.getId());
                    session.setAttribute("userRole", "ADMIN");
                    return "redirect:/admin/dashboard";
                }
            }
        }
        
        model.addAttribute("error", "Invalid username, password, or role");
        return "login";
    }
    
    @GetMapping("/logout")
    public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
        session.invalidate();
        redirectAttributes.addFlashAttribute("message", "You have been logged out successfully");
        return "redirect:/login";
    }
    


    @GetMapping("/admin/clubs")
    public String adminClubs(Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        model.addAttribute("clubs", clubService.getAllClubs());
        // Expose service so JSP can compute active member counts per club
        model.addAttribute("clubService", clubService);
        return "admin/clubs";
    }

    @GetMapping("/admin/clubmanagement")
    public String adminClubManagement(Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        model.addAttribute("clubs", clubService.getAllClubs());
        return "admin/clubmanagement";
    }
    
    @PostMapping("/admin/clubs/create")
    public String createClub(@Valid @ModelAttribute("club") Club club, BindingResult result, 
                           HttpSession session, RedirectAttributes redirectAttributes) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        if (result.hasErrors()) {
            redirectAttributes.addFlashAttribute("error", "Please check the form data");
            return "redirect:/admin/clubmanagement";
        }
        
        try {
            clubService.createClub(club, admin);
            redirectAttributes.addFlashAttribute("success", "Club created successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to create club: " + e.getMessage());
        }
        
        return "redirect:/admin/clubmanagement";
    }
    
    @GetMapping("/admin/clubs/edit/{id}")
    public String editClubForm(@PathVariable Long id, Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        return clubService.getClubById(id)
                .map(club -> {
                    model.addAttribute("club", club);
                    return "admin/club-edit";
                })
                .orElse("redirect:/admin/clubmanagement");
    }
    
    @PostMapping("/admin/clubs/update/{id}")
    public String updateClub(@PathVariable Long id, @Valid @ModelAttribute("club") Club club, 
                           BindingResult result, HttpSession session, RedirectAttributes redirectAttributes) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        if (result.hasErrors()) {
            redirectAttributes.addFlashAttribute("error", "Please check the form data");
            return "redirect:/admin/clubs/edit/" + id;
        }
        
        try {
            club.setId(id);
            club.setCreatedBy(admin);
            clubService.updateClub(club);
            redirectAttributes.addFlashAttribute("success", "Club updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to update club: " + e.getMessage());
        }
        
        return "redirect:/admin/clubmanagement";
    }
    
    @PostMapping("/admin/clubs/delete/{id}")
    public String deleteClub(@PathVariable Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        System.out.println("=== DELETE CLUB REQUEST ===");
        System.out.println("Club ID: " + id);
        
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            System.out.println("No admin in session, redirecting to login");
            return "redirect:/login";
        }
        
        System.out.println("Admin: " + admin.getUsername() + " (ID: " + admin.getId() + ")");
        
        try {
            System.out.println("Attempting to delete club...");
            clubService.deleteClub(id);
            System.out.println("Club deleted successfully");
            redirectAttributes.addFlashAttribute("success", "Club deleted successfully!");
        } catch (Exception e) {
            System.err.println("Error deleting club: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Failed to delete club: " + e.getMessage());
        }
        
        return "redirect:/admin/clubmanagement";
    }

    @GetMapping("/admin/activitymanagement")
    public String adminActivityManagement(Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        model.addAttribute("clubs", clubService.getAllClubs());
        model.addAttribute("activities", activityService.getAllActivities());
        return "admin/activitymanagement";
    }

    @GetMapping("/admin/activities/create")
    public String createActivityForm(Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        model.addAttribute("activity", new Activity());
        model.addAttribute("clubs", clubService.getAllClubs());
        return "admin/activity-form";
    }

    @GetMapping("/admin/activities/edit/{id}")
    public String editActivityForm(@PathVariable Long id, Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        return activityService.getActivityById(id)
                .map(activity -> {
                    model.addAttribute("activity", activity);
                    model.addAttribute("clubs", clubService.getAllClubs());
                    return "admin/activity-form";
                })
                .orElse("redirect:/admin/activitymanagement");
    }

    @PostMapping("/admin/activities/create")
    public String createActivity(@Valid @ModelAttribute("activity") Activity activity, BindingResult result, 
                               HttpSession session, RedirectAttributes redirectAttributes) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        if (result.hasErrors()) {
            redirectAttributes.addFlashAttribute("error", "Please check the form data");
            return "redirect:/admin/activities/create";
        }
        
        try {
            // Set the club if clubId is provided
            if (activity.getClub() != null && activity.getClub().getId() != null) {
                Optional<Club> club = clubService.getClubById(activity.getClub().getId());
                if (club.isPresent()) {
                    activity.setClub(club.get());
                }
            }
            
            activityService.createActivity(activity, admin);
            redirectAttributes.addFlashAttribute("success", "Activity created successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to create activity: " + e.getMessage());
        }
        
        return "redirect:/admin/activitymanagement";
    }

    @PostMapping("/admin/activities/update")
    public String updateActivity(@Valid @ModelAttribute("activity") Activity activity, BindingResult result, 
                               HttpSession session, RedirectAttributes redirectAttributes) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        if (result.hasErrors()) {
            redirectAttributes.addFlashAttribute("error", "Please check the form data");
            return "redirect:/admin/activities/edit/" + activity.getId();
        }
        
        try {
            // Set the club if clubId is provided
            if (activity.getClub() != null && activity.getClub().getId() != null) {
                Optional<Club> club = clubService.getClubById(activity.getClub().getId());
                if (club.isPresent()) {
                    activity.setClub(club.get());
                }
            }
            
            activityService.updateActivity(activity);
            redirectAttributes.addFlashAttribute("success", "Activity updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to update activity: " + e.getMessage());
        }
        
        return "redirect:/admin/activitymanagement";
    }

    @GetMapping("/admin/activities/delete/{id}")
    public String deleteActivity(@PathVariable Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        try {
            activityService.deleteActivity(id);
            redirectAttributes.addFlashAttribute("success", "Activity deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete activity: " + e.getMessage());
        }
        
        return "redirect:/admin/activitymanagement";
    }

    @GetMapping("/admin/studentmonitoring")
    public String adminStudentMonitoring(Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        // Clubs list
        List<Club> clubs = clubService.getAllClubs();
        model.addAttribute("clubs", clubs);

        // Collect all active memberships across clubs
        List<ClubMembership> activeMemberships = new ArrayList<>();
        for (Club club : clubs) {
            try {
                activeMemberships.addAll(clubService.getActiveMembershipsByClub(club));
            } catch (Exception e) {
                System.err.println("Error loading active memberships for club " + club.getId() + ": " + e.getMessage());
            }
        }
        model.addAttribute("activeMemberships", activeMemberships);

        // Pre-compute activity participation counts per student
        Map<Long, Integer> activityCounts = new HashMap<>();
        for (ClubMembership membership : activeMemberships) {
            try {
                Student mStudent = membership.getStudent();
                if (mStudent != null) {
                    int count = activityParticipationService.getParticipationsByStudent(mStudent).size();
                    activityCounts.put(mStudent.getId(), count);
                }
            } catch (Exception e) {
                // continue on errors
            }
        }
        model.addAttribute("activityCounts", activityCounts);
        return "admin/studentmonitoring";
    }

    @GetMapping("/admin/test-links")
    public String testLinks(Model model) {
        return "admin/test-links";
    }
    
    
            
          @GetMapping("/admin/events")
    public String adminEvents(Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        // Add all events to the model instead of separating them
        model.addAttribute("events", eventService.getAllEvents());
        
        return "admin/events";
    }
    
    @GetMapping("/admin/events/create")
    public String createEventForm(Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        model.addAttribute("event", new Event());
        return "admin/event-form";
    }
    
    @PostMapping("/admin/events/save")
    public String saveEvent(@Valid @ModelAttribute("event") Event event, BindingResult result, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        if (result.hasErrors()) {
            return "admin/event-form";
        }
        
        eventService.saveEvent(event);
        return "redirect:/admin/events";
    }
    
    @GetMapping("/admin/events/edit/{id}")
    public String editEventForm(@PathVariable Long id, Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        return eventService.getEventById(id)
                .map(event -> {
                    model.addAttribute("event", event);
                    return "admin/event-form";
                })
                .orElse("redirect:/admin/events");
    }
    
    @GetMapping("/admin/events/view/{id}")
    public String viewEvent(@PathVariable Long id, Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        return eventService.getEventById(id)
                .map(event -> {
                    model.addAttribute("event", event);
                    model.addAttribute("pendingParticipations", eventService.getPendingParticipationsByEvent(event));
                    model.addAttribute("approvedParticipations", eventService.approveParticipationsByEvent(event));
                    return "admin/event-view";
                })
                .orElse("redirect:/admin/events");
    }
    
    @GetMapping("/admin/events/delete/{id}")
    public String deleteEvent(@PathVariable Long id, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        eventService.deleteEvent(id);
        return "redirect:/admin/events";
    }
    
    
  
    
    @PostMapping("/admin/reject-club-participation/{id}")
    public String rejectClubParticipation(@PathVariable Long id, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        // TODO: Implement when ClubService is available
        // clubService.rejectParticipation(id, admin);
        return "redirect:/admin/club-participations";
    }
    
    @PostMapping("/admin/approve-event-participation/{id}")
    public String approveEventParticipation(@PathVariable Long id, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        eventService.approveParticipation(id, admin);
        return "redirect:/admin/event-participations";
    }
    
    @PostMapping("/admin/reject-event-participation/{id}")
    public String rejectEventParticipation(@PathVariable Long id, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        eventService.rejectParticipation(id, admin);
        return "redirect:/admin/event-participations";
    }
    
    // Activity participations moderation (Admin)
    @GetMapping("/admin/activity-participations")
    public String adminActivityParticipations(Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        try {
            List<ActivityParticipation> pending = activityParticipationService.getParticipationsByStatus(ActivityParticipation.ParticipationStatus.PENDING);
            List<ActivityParticipation> approved = activityParticipationService.getParticipationsByStatus(ActivityParticipation.ParticipationStatus.APPROVED);
            model.addAttribute("pendingParticipations", pending);
            model.addAttribute("approvedParticipations", approved);
        } catch (Exception e) {
            model.addAttribute("pendingParticipations", new ArrayList<>());
            model.addAttribute("approvedParticipations", new ArrayList<>());
        }
        return "admin/activity-participations";
    }

    @PostMapping("/admin/approve-activity-participation/{id}")
    public String approveActivityParticipation(@PathVariable Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        try {
            activityParticipationService.approveParticipation(id, admin);
            redirectAttributes.addFlashAttribute("success", "Participation approved and points awarded.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/activity-participations";
    }

    @PostMapping("/admin/reject-activity-participation/{id}")
    public String rejectActivityParticipation(@PathVariable Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        try {
            activityParticipationService.rejectParticipation(id, admin);
            redirectAttributes.addFlashAttribute("success", "Participation rejected.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/activity-participations";
    }


    // Student Club and Event Interface
    @GetMapping("/clubs")
    public String studentClubs(Model model) {
        model.addAttribute("clubs", clubService.getAllClubs());
        return "clubs/list";
    }
    
    @GetMapping("/students/clubs")
    public String studentClubsView(Model model, HttpSession session) {
        Student student = (Student) session.getAttribute("user");
        if (student == null) {
            return "redirect:/login";
        }
        List<Club> clubs = clubService.getAllClubs();
        model.addAttribute("clubs", clubs);
        model.addAttribute("student", student);
        model.addAttribute("clubService", clubService);

        // Build membership status map for UI and determine if student reached membership limit
        Map<Long, Boolean> membershipStatus = new HashMap<>();
        int activeMembershipCount = clubService.getActiveMembershipsByStudent(student).size();
        boolean hasReachedLimit = activeMembershipCount >= 2;
        for (Club club : clubs) {
            boolean isMember = clubService.isStudentMemberOfClub(student, club);
            membershipStatus.put(club.getId(), isMember);
        }
        model.addAttribute("membershipStatus", membershipStatus);
        model.addAttribute("hasReachedLimit", hasReachedLimit);
        return "students/clubview";
    }
    
    @GetMapping("/students/debug")
    public String debugPage(Model model, HttpSession session) {
        Student student = (Student) session.getAttribute("user");
        if (student == null) {
            return "redirect:/login";
        }
        
        // Test database connection
        try {
            List<Club> clubs = clubService.getAllClubs();
            System.out.println("Found " + clubs.size() + " clubs in database");
            model.addAttribute("clubs", clubs);
        } catch (Exception e) {
            System.err.println("Error getting clubs: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("clubs", new ArrayList<>());
        }
        
        model.addAttribute("student", student);
        return "students/debug";
    }
    
    @PostMapping("/students/clubs/join/{clubId}")
    public String joinClub(@PathVariable Long clubId, HttpSession session, RedirectAttributes redirectAttributes) {
        System.out.println("=== JOIN CLUB REQUEST ===");
        System.out.println("Club ID: " + clubId);
        
        Student student = (Student) session.getAttribute("user");
        if (student == null) {
            System.out.println("No student in session, redirecting to login");
            return "redirect:/login";
        }
        
        System.out.println("Student: " + student.getUsername() + " (ID: " + student.getId() + ")");
        
        try {
            Optional<Club> clubOpt = clubService.getClubById(clubId);
            if (clubOpt.isPresent()) {
                Club club = clubOpt.get();
                System.out.println("Club found: " + club.getName() + " (ID: " + club.getId() + ")");
                
                // Check if student is already a member of this club
                boolean isAlreadyMember = clubService.isStudentMemberOfClub(student, club);
                System.out.println("Is already member: " + isAlreadyMember);
                
                if (isAlreadyMember) {
                    System.out.println("Student is already a member, redirecting with error");
                    redirectAttributes.addFlashAttribute("error", "You are already a member of this club!");
                    return "redirect:/students/clubs";
                }

                // Enforce maximum of two active club memberships per student
                int activeMembershipCount = clubService.getActiveMembershipsByStudent(student).size();
                if (activeMembershipCount >= 2) {
                    System.out.println("Student reached max club limit (2), blocking join");
                    redirectAttributes.addFlashAttribute("error", "You can join at most 2 clubs.");
                    return "redirect:/students/clubs";
                }
                
                // Join the club
                System.out.println("Joining club...");
                ClubMembership membership = clubService.joinClub(student, club);
                System.out.println("Membership created with ID: " + membership.getId());
                
                // Award points for joining
                try {
                    studentService.addPointsToStudent(student.getId(), 100, "Joined club: " + club.getName());
                    redirectAttributes.addFlashAttribute("success", "Joined " + club.getName() + " and earned 100 points!");
                } catch (Exception pointsEx) {
                    System.err.println("Error awarding points on join: " + pointsEx.getMessage());
                }
                
                // Redirect to member page
                String redirectUrl = "redirect:/students/clubs/member/" + membership.getId();
                System.out.println("Redirecting to: " + redirectUrl);
                return redirectUrl;
            } else {
                System.out.println("Club not found for ID: " + clubId);
                redirectAttributes.addFlashAttribute("error", "Club not found!");
                return "redirect:/students/clubs";
            }
        } catch (Exception e) {
            System.err.println("Error joining club: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Error joining club: " + e.getMessage());
            return "redirect:/students/clubs";
        }
    }
    
    @PostMapping("/students/clubs/quit/{clubId}")
    public String quitClub(@PathVariable Long clubId, HttpSession session, RedirectAttributes redirectAttributes) {
        System.out.println("=== QUIT CLUB REQUEST ===");
        System.out.println("Club ID: " + clubId);
        
        Student student = (Student) session.getAttribute("user");
        if (student == null) {
            System.out.println("No student in session, redirecting to login");
            return "redirect:/login";
        }
        
        System.out.println("Student: " + student.getUsername() + " (ID: " + student.getId() + ")");
        
        try {
            Optional<Club> clubOpt = clubService.getClubById(clubId);
            if (clubOpt.isPresent()) {
                Club club = clubOpt.get();
                System.out.println("Club found: " + club.getName() + " (ID: " + club.getId() + ")");
                
                // Check if student is actually a member
                boolean isMember = clubService.isStudentMemberOfClub(student, club);
                System.out.println("Is member: " + isMember);
                
                if (!isMember) {
                    System.out.println("Student is not a member, redirecting with error");
                    redirectAttributes.addFlashAttribute("error", "You are not a member of this club!");
                    return "redirect:/students/clubs";
                }

                // Prevent leaving if student has 0 points (no points to reduce)
                Integer currentPoints = studentService.getStudentPoints(student.getId());
                if (currentPoints != null && currentPoints == 0) {
                    System.out.println("Student has 0 points; blocking leave action");
                    redirectAttributes.addFlashAttribute("error", "You cannot leave the club. Your current points must be > 0.");
                    return "redirect:/students/clubs";
                }
                
                // Quit the club
                System.out.println("Quitting club...");
                clubService.quitClub(student, club);
                System.out.println("Student successfully quit the club");
                
                // Subtract fixed 100 points for leaving
                try {
                    studentService.addPointsToStudent(student.getId(), -100, "Left club: " + club.getName());
                    redirectAttributes.addFlashAttribute("success", "Left " + club.getName() + " and 100 points were deducted.");
                } catch (Exception pointsEx) {
                    System.err.println("Error deducting points on leave: " + pointsEx.getMessage());
                }
                
                redirectAttributes.addFlashAttribute("success", "You have successfully quit " + club.getName());
                return "redirect:/students/clubs";
            } else {
                System.out.println("Club not found for ID: " + clubId);
                redirectAttributes.addFlashAttribute("error", "Club not found!");
                return "redirect:/students/clubs";
            }
        } catch (Exception e) {
            System.err.println("Error quitting club: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Error quitting club: " + e.getMessage());
            return "redirect:/students/clubs";
        }
    }
    
    @GetMapping("/students/clubs/member/{membershipId}")
    public String memberPage(@PathVariable Long membershipId, Model model, HttpSession session) {
        System.out.println("=== MEMBER PAGE REQUEST ===");
        System.out.println("Membership ID: " + membershipId);
        
        Student student = (Student) session.getAttribute("user");
        if (student == null) {
            System.out.println("No student in session, redirecting to login");
            return "redirect:/login";
        }
        
        System.out.println("Student: " + student.getUsername() + " (ID: " + student.getId() + ")");
        
        try {
            Optional<ClubMembership> membershipOpt = clubService.getMembershipById(membershipId);
            if (membershipOpt.isPresent()) {
                ClubMembership membership = membershipOpt.get();
                Club club = membership.getClub();
                
                System.out.println("Membership found: " + membership.getId());
                System.out.println("Club: " + club.getName());
                
                // Format the joined date for display
                String formattedJoinedDate = membership.getJoinedAt().format(java.time.format.DateTimeFormatter.ofPattern("MMMM dd, yyyy 'at' hh:mm a"));
                
                model.addAttribute("membership", membership);
                model.addAttribute("club", club);
                model.addAttribute("student", student);
                model.addAttribute("formattedJoinedDate", formattedJoinedDate);
                
                System.out.println("Returning member.jsp");
                return "students/member";
            } else {
                System.err.println("Membership not found for ID: " + membershipId);
                return "redirect:/students/clubs";
            }
        } catch (Exception e) {
            System.err.println("Error loading member page: " + e.getMessage());
            e.printStackTrace();
            return "redirect:/students/clubs";
        }
    }
    
    @GetMapping("/students/clubs/detail/{clubId}")
    public String clubDetail(@PathVariable Long clubId, Model model, HttpSession session) {
        System.out.println("=== CLUB DETAIL PAGE REQUEST ===");
        System.out.println("Club ID: " + clubId);
        
        Student student = (Student) session.getAttribute("user");
        if (student == null) {
            System.out.println("No student in session, redirecting to login");
            return "redirect:/login";
        }
        
        System.out.println("Student: " + student.getUsername() + " (ID: " + student.getId() + ")");
        
        try {
            Optional<Club> clubOpt = clubService.getClubById(clubId);
            if (clubOpt.isPresent()) {
                Club club = clubOpt.get();
                
                System.out.println("Club found: " + club.getName());
                
                // Check if student has any membership (active or inactive) for this club
                Optional<ClubMembership> membershipOpt = clubService.getMembershipByStudentAndClub(student, club);
                boolean hasAnyMembership = membershipOpt.isPresent();
                boolean isActiveMember = clubService.isStudentMemberOfClub(student, club);
                
                model.addAttribute("club", club);
                model.addAttribute("student", student);
                model.addAttribute("membershipStatus", isActiveMember);
                model.addAttribute("hasAnyMembership", hasAnyMembership);
                model.addAttribute("canRejoin", hasAnyMembership && !isActiveMember);
                
                System.out.println("Returning clubdetail.jsp");
                return "students/clubdetail";
            } else {
                System.err.println("Club not found for ID: " + clubId);
                return "redirect:/students/clubs";
            }
        } catch (Exception e) {
            System.err.println("Error loading club detail page: " + e.getMessage());
            e.printStackTrace();
            return "redirect:/students/clubs";
        }
    }
    
    @GetMapping("/events")
    public String studentEvents(Model model) {
        try {
            List<Event> events = eventService.getAllEvents();
            LocalDateTime now = LocalDateTime.now();
            
            // Create a map to store event time status
            Map<Long, Map<String, Object>> eventTimeStatus = new HashMap<>();
            
            events.forEach(event -> {
                try {
                    if (event.getStartTime() != null && event.getEndTime() != null) {
                        boolean isJoinWindow = !now.isBefore(event.getStartTime()) && now.isBefore(event.getEndTime());
                        boolean hasStarted = !now.isBefore(event.getStartTime());
                        boolean hasEnded = now.isAfter(event.getEndTime());
                        
                        Map<String, Object> status = new HashMap<>();
                        status.put("isJoinWindow", isJoinWindow);
                        status.put("hasStarted", hasStarted);
                        status.put("hasEnded", hasEnded);
                        eventTimeStatus.put(event.getId(), status);
                    }
                } catch (Exception e) {
                    // Log error for individual event but continue processing others
                    System.err.println("Error processing event " + event.getId() + ": " + e.getMessage());
                }
            });
            
            model.addAttribute("events", events);
            model.addAttribute("eventTimeStatus", eventTimeStatus);
            model.addAttribute("currentTime", now);
            return "events/list";
        } catch (Exception e) {
            // Log overall error and return empty state
            System.err.println("Error loading events: " + e.getMessage());
            model.addAttribute("events", new ArrayList<>());
            model.addAttribute("eventTimeStatus", new HashMap<>());
            model.addAttribute("currentTime", LocalDateTime.now());
            return "events/list";
        }
    }
    

    
    @GetMapping("/events/view/{id}")
    public String viewEventForStudent(@PathVariable Long id, Model model, HttpSession session) {
        try {
            Student student = (Student) session.getAttribute("user");
            if (student == null) {
                return "redirect:/login";
            }
            
            return eventService.getEventById(id)
                    .map(event -> {
                        try {
                            model.addAttribute("event", event);
                            
                            // Check time window and registration state with proper null checks
                            LocalDateTime now = LocalDateTime.now();
                            boolean isJoinWindow = false;
                            boolean hasStarted = false;
                            boolean hasEnded = false;
                            
                            if (event.getStartTime() != null && event.getEndTime() != null) {
                                hasStarted = !now.isBefore(event.getStartTime());
                                hasEnded = now.isAfter(event.getEndTime());
                                isJoinWindow = hasStarted && !hasEnded;
                            }
                            
                            model.addAttribute("isJoinWindow", isJoinWindow);
                            model.addAttribute("hasStarted", hasStarted);
                            model.addAttribute("hasEnded", hasEnded);
                            model.addAttribute("currentTime", now);
                            model.addAttribute("isRegistered", eventService.getPendingParticipationsByEvent(event).stream()
                                    .anyMatch(p -> p.getStudent().getId().equals(student.getId())));
                            return "events/view";
                        } catch (Exception e) {
                            System.err.println("Error processing event " + event.getId() + ": " + e.getMessage());
                            return "redirect:/events";
                        }
                    })
                    .orElse("redirect:/events");
        } catch (Exception e) {
            System.err.println("Error viewing event " + id + ": " + e.getMessage());
            return "redirect:/events";
        }
    }
    

    @PostMapping("/events/register/{id}")
    public String registerForEvent(@PathVariable Long id, HttpSession session) {
        Student student = (Student) session.getAttribute("user");
        if (student == null) {
            return "redirect:/login";
        }
        
        eventService.getEventById(id).ifPresent(event -> {
            EventParticipation participation = eventService.registerForEvent(student, event);
            // If outside window, registration will return null; simply ignore
        });
        
        return "redirect:/events/view/" + id;
    }
    
    // Manual trigger for point awarding (for testing)
    @GetMapping("/admin/manual-award-points")
    public String manualAwardPoints(HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        eventService.manuallyAwardPointsForEndedEvents();
        return "redirect:/admin/events";
    }
    
    // Check all student points (for debugging)
    @GetMapping("/admin/check-student-points")
    public String checkStudentPoints(HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        eventService.checkAllStudentPoints();
        return "redirect:/admin/events";
    }
    
    // Check pending point awards (for debugging)
    @GetMapping("/admin/check-pending-points")
    public String checkPendingPointAwards(HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        eventService.checkPendingPointAwards();
        return "redirect:/admin/events";
    }
    
    // Update student dashboard to include clubs and events
    @GetMapping("/students/dashboard/{id}")
    public String studentDashboard(@PathVariable Long id, Model model) {
        return studentService.getStudentById(id)
                .map(student -> {
                    model.addAttribute("student", student);
                    
                    // Get student's reward exchanges
                    List<RewardExchange> recentExchanges = rewardExchangeService.getRecentExchangesByStudent(student);
                    model.addAttribute("recentExchanges", recentExchanges);
                    
                    // Get available rewards based on student's points
                    // Changed from getAllRewards() to getActiveRewards() to only show active rewards
                    List<Reward> availableRewards = rewardService.getActiveRewards().stream()
                            .filter(reward -> student.getPoints() >= reward.getPointValue())
                            .collect(Collectors.toList());
                    model.addAttribute("availableRewards", availableRewards);
                    
                    // Calculate total points spent on rewards
                    Integer totalPointsSpent = rewardExchangeService.getTotalPointsSpentByStudent(student);
                    model.addAttribute("totalPointsSpent", totalPointsSpent);
                    
                    // Prepare data for points history chart
                    Map<String, Integer> monthlyPoints = new LinkedHashMap<>();
                    LocalDateTime sixMonthsAgo = LocalDateTime.now().minusMonths(6);
                    
                    // Initialize with last 6 months
                    for (int i = 5; i >= 0; i--) {
                        LocalDateTime month = LocalDateTime.now().minusMonths(i);
                        String monthLabel = month.getMonth().getDisplayName(TextStyle.SHORT, Locale.ENGLISH);
                        monthlyPoints.put(monthLabel, 0);
                    }
                    
                    model.addAttribute("pointsChartLabels", new ArrayList<>(monthlyPoints.keySet()));
                    model.addAttribute("pointsChartData", new ArrayList<>(monthlyPoints.values()));
                    
                    // Add clubs and events data
                    List<Club> clubs = clubService.getAllClubs();
                    List<ClubMembership> studentMemberships = clubService.getActiveMembershipsByStudent(student);
                    model.addAttribute("clubsCount", studentMemberships.size());
                    model.addAttribute("eventsCount", eventService.getAllEvents().size());
                    model.addAttribute("clubs", clubs);
                    
                    // Get club-specific activities for student's joined clubs
                    Map<Club, List<Activity>> clubActivities = new HashMap<>();
                    for (ClubMembership membership : studentMemberships) {
                        Club club = membership.getClub();
                        List<Activity> activities = activityService.getActivitiesByClub(club);
                        clubActivities.put(club, activities);
                    }
                    model.addAttribute("clubActivities", clubActivities);
                    model.addAttribute("studentMemberships", studentMemberships);
                    
                    // Format events with formatted dates for JSP compatibility
                    List<Event> events = eventService.getAllEvents();
                    model.addAttribute("upcomingEvents", events);
                    
                    // Add rewards count
                    model.addAttribute("rewardsCount", availableRewards.size());
                    
                    return "students/dashboard";
                })
                .orElse("redirect:/students");
    }

    @GetMapping("/students/rewards/catalog")
    public String rewardCatalog(Model model, HttpSession session, 
                                @RequestParam(required = false) String search, 
                                @RequestParam(required = false) String filter) {
        Student student = (Student) session.getAttribute("user");
        if (student == null) {
            return "redirect:/login";
        }
        
        List<Reward> rewards;
        
        if (search != null && !search.isEmpty()) {
            rewards = rewardService.searchRewardsByKeyword(search);
        } else if ("available".equals(filter)) {
            rewards = rewardService.getActiveRewards().stream()
                .filter(reward -> student.getPoints() >= reward.getPointValue())
                .collect(Collectors.toList());
        } else {
            rewards = rewardService.getActiveRewards();
        }
        
        model.addAttribute("student", student);
        model.addAttribute("rewards", rewards);
        model.addAttribute("search", search);
        model.addAttribute("filter", filter);
        
        return "students/rewards/catalog";
    }
    
    // Exchange a reward
    @PostMapping("/students/rewards/exchange/{rewardId}")
    public String exchangeReward(@PathVariable Long rewardId, HttpSession session, RedirectAttributes redirectAttributes) {
        Student student = (Student) session.getAttribute("user");
        if (student == null) {
            return "redirect:/login";
        }
        
        try {
            // Check if student has enough points
            if (!studentService.hasEnoughPointsForReward(student.getId(), rewardId)) {
                redirectAttributes.addFlashAttribute("error", "You don't have enough points for this reward.");
                return "redirect:/students/rewards/catalog";
            }
            
            // Process the exchange
            RewardExchange exchange = rewardExchangeService.exchangeReward(student.getId(), rewardId);
            redirectAttributes.addFlashAttribute("success", "Reward exchanged successfully!");
            
            // Update the student in the session with the latest data from the database
            Student updatedStudent = studentService.getStudentById(student.getId()).orElse(student);
            session.setAttribute("user", updatedStudent);
            
            return "redirect:/students/rewards/history";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error exchanging reward: " + e.getMessage());
            return "redirect:/students/rewards/catalog";
        }
    }
    
    // View exchange history
    @GetMapping("/students/rewards/history")
    public String rewardExchangeHistory(Model model, HttpSession session) {
        Student student = (Student) session.getAttribute("user");
        if (student == null) {
            return "redirect:/login";
        }
        
        // Get student's exchange history
        List<RewardExchange> exchanges = rewardExchangeService.getExchangesByStudent(student);
        
        model.addAttribute("student", student);
        model.addAttribute("exchanges", exchanges);
        
        return "students/rewards/history";
    }
    


    @GetMapping("/students/profile")
    public String studentProfile(Model model, HttpSession session) {
    Student student = (Student) session.getAttribute("user");
    if (student == null) {
        return "redirect:/login";
    }
    
    model.addAttribute("student", student);
    return "students/profile";
}

    @GetMapping("/students/activities")
    public String studentActivitiesView(Model model, HttpSession session) {
        Student student = (Student) session.getAttribute("user");
        if (student == null) {
            return "redirect:/login";
        }
        // Refresh student from DB to ensure latest points and details
        Student freshStudent = studentService.getStudentById(student.getId()).orElse(student);
        session.setAttribute("user", freshStudent);
        
        // Get student's club memberships
        List<ClubMembership> memberships = clubService.getActiveMembershipsByStudent(freshStudent);
        
        // Get activities for each club the student is a member of
        Map<Club, List<Activity>> clubActivities = new HashMap<>();
        Map<Long, Map<String, Object>> activityJoinStatus = new HashMap<>();
        Map<Long, Boolean> joinedActivityMap = new HashMap<>();

        // Build a quick lookup of activities the student has already joined (any status)
        try {
            List<ActivityParticipation> myParticipations = activityParticipationService.getParticipationsByStudent(freshStudent);
            for (ActivityParticipation p : myParticipations) {
                if (p.getActivity() != null) {
                    joinedActivityMap.put(p.getActivity().getId(), true);
                }
            }
        } catch (Exception ignored) {
        }
        for (ClubMembership membership : memberships) {
            Club club = membership.getClub();
            List<Activity> activities = activityService.getActivitiesByClub(club);
            clubActivities.put(club, activities);
            // Compute join window status per activity
            for (Activity activity : activities) {
                Map<String, Object> status = new HashMap<>();
                boolean canJoin = false;
                String primaryLabel = "Join Closed";
                String secondaryLabel = null;
                try {
                    // Expecting formats: yyyy-MM-dd and HH:mm
                    DateTimeFormatter dateFmt = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                    DateTimeFormatter timeFmt = DateTimeFormatter.ofPattern("HH:mm");
                    LocalDate date = LocalDate.parse(activity.getClubDate(), dateFmt);
                    LocalTime start = LocalTime.parse(activity.getStartTime(), timeFmt);
                    LocalTime end = LocalTime.parse(activity.getEndTime(), timeFmt);
                    LocalDateTime startWindow = LocalDateTime.of(date, start).minusMinutes(30);
                    LocalDateTime endJoinDeadline = LocalDateTime.of(date, end).minusMinutes(30);
                    LocalDateTime now = LocalDateTime.now();
//Available minutes calculate
                    if (now.isBefore(startWindow)) {
                        Duration untilOpen = Duration.between(now, startWindow).plusMinutes(1);
                        primaryLabel = "Join available in " + formatDurationShort(untilOpen);
                        canJoin = false;
                    } else if (!now.isAfter(endJoinDeadline)) {
                        // In join window
                        Duration untilClose = Duration.between(now, endJoinDeadline);
                        primaryLabel = "Join now";
                        secondaryLabel = "Join closes in " + formatDurationShort(untilClose);
                        canJoin = true;
                    } else {
                        // After deadline
                        primaryLabel = "Join Disabled";
                        canJoin = false;
                    }
                } catch (Exception e) {
                    // If parsing fails, keep defaults (closed)
                    primaryLabel = "Join Didabled";
                    canJoin = false;
                }

                status.put("canJoin", canJoin);
                status.put("primaryLabel", primaryLabel);
                status.put("secondaryLabel", secondaryLabel);
                activityJoinStatus.put(activity.getId(), status);
            }
        }
        
        model.addAttribute("student", freshStudent);
        model.addAttribute("memberships", memberships);
        model.addAttribute("clubActivities", clubActivities);
        model.addAttribute("activityJoinStatus", activityJoinStatus);
        model.addAttribute("joinedActivityMap", joinedActivityMap);
        
        return "students/activities";
    }

    private String formatDurationShort(Duration duration) {
        long totalSeconds = duration.getSeconds();
        if (totalSeconds < 0) totalSeconds = 0;
        long hours = totalSeconds / 3600;
        long minutes = (totalSeconds % 3600) / 60;
        if (hours > 0 && minutes > 0) {
            return hours + "h " + minutes + "m";
        } else if (hours > 0) {
            return hours + "h";
        } else {
            return minutes + "m";
        }
    }
    
    @PostMapping("/students/activities/join/{activityId}")
    public String joinActivity(@PathVariable Long activityId, HttpSession session, RedirectAttributes redirectAttributes) {
        Student student = (Student) session.getAttribute("user");
        if (student == null) {
            return "redirect:/login";
        }
        
        try {
            Optional<Activity> activityOpt = activityService.getActivityById(activityId);
            if (activityOpt.isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Activity not found");
                return "redirect:/students/activities";
            }
            
            Activity activity = activityOpt.get();
            
            // Check if student is a member of the club that offers this activity
            Club activityClub = activity.getClub();
            if (activityClub != null) {
                boolean isMember = clubService.getActiveMembershipsByStudent(student).stream()
                        .anyMatch(m -> m.getClub().getId().equals(activityClub.getId()));
                
                if (!isMember) {
                    redirectAttributes.addFlashAttribute("error", "You must be a member of " + activityClub.getName() + " to join this activity");
                    return "redirect:/students/activities";
                }
            }
            
            // Join the activity
            activityParticipationService.participateInActivity(student, activity);
            redirectAttributes.addFlashAttribute("success", "Successfully joined the activity. Waiting for approval.");
            
        } catch (IllegalStateException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to join activity: " + e.getMessage());
        }
        
        return "redirect:/students/activities";
    }
    
    @GetMapping("/students/activities/participations")
    public String studentParticipations(Model model, HttpSession session) {
        Student student = (Student) session.getAttribute("user");
        if (student == null) {
            return "redirect:/login";
        }
        
        List<ActivityParticipation> participations = activityParticipationService.getParticipationsByStudent(student);
        model.addAttribute("student", student);
        model.addAttribute("participations", participations);
        
        return "students/participations";
    }

    // Admin Attendance Management
    @GetMapping("/admin/attendances")
    public String attendances(Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        List<Attendance> attendances = attendanceService.getAllAttendances();
        
        // Convert LocalDateTime to Date for JSP compatibility
        attendances.forEach(attendance -> {
            if (attendance.getCreatedAt() != null) {
                model.addAttribute("createdAt_" + attendance.getId(), 
                    DateTimeUtil.toDate(attendance.getCreatedAt()));
            }
            if (attendance.getUpdatedAt() != null) {
                model.addAttribute("updatedAt_" + attendance.getId(), 
                    DateTimeUtil.toDate(attendance.getUpdatedAt()));
            }
        });
        
        model.addAttribute("attendances", attendances);
        return "admin/attendances/list";
    }
    
    @GetMapping("/admin/attendances/create")
    public String createAttendanceForm(Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        model.addAttribute("attendance", new Attendance());
        model.addAttribute("students", studentService.getAllStudents());
        model.addAttribute("months", Month.values());
        model.addAttribute("currentYear", java.time.LocalDate.now().getYear());
        return "admin/attendances/form";
    }
    
    @PostMapping("/admin/attendances/save")
    public String saveAttendance(@RequestParam("studentId") Long studentId,
                               @RequestParam("month") Month month,
                               @RequestParam("year") Integer year,
                               @RequestParam("attendancePercentage") Double attendancePercentage,
                               HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        // Validate attendance percentage (0-100)
        if (attendancePercentage < 0 || attendancePercentage > 100) {
            return "redirect:/admin/attendances/create?error=Invalid attendance percentage";
        }
        
        // Get student
        Optional<Student> studentOpt = studentService.getStudentById(studentId);
        if (!studentOpt.isPresent()) {
            return "redirect:/admin/attendances/create?error=Student not found";
        }
        
        // Create or update attendance record
        attendanceService.createOrUpdateAttendance(
            studentOpt.get(), month, year, attendancePercentage, admin);
        
        return "redirect:/admin/attendances";
    }
    
    @GetMapping("/admin/attendances/edit/{id}")
    public String editAttendanceForm(@PathVariable Long id, Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        return attendanceService.getAttendanceById(id)
                .map(attendance -> {
                    model.addAttribute("attendance", attendance);
                    model.addAttribute("students", studentService.getAllStudents());
                    model.addAttribute("months", Month.values());
                    model.addAttribute("currentYear", java.time.LocalDate.now().getYear());
                    return "admin/attendances/form";
                })
                .orElse("redirect:/admin/attendances");
    }
    
    @GetMapping("/admin/attendances/delete/{id}")
    public String deleteAttendance(@PathVariable Long id, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        attendanceService.deleteAttendance(id);
        return "redirect:/admin/attendances";
    }
    
    @GetMapping("/admin/attendances/award-points/{id}")
    public String awardAttendancePoints(@PathVariable Long id, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        attendanceService.awardPointsForAttendance(id);
        return "redirect:/admin/attendances";
    }
    
    @GetMapping("/admin/attendances/calculate-points")
    public String calculateAttendancePoints(HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        attendanceService.calculateAndAwardPoints();
        return "redirect:/admin/attendances";
    }
}