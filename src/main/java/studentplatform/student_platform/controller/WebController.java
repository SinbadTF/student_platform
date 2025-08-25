package studentplatform.student_platform.controller;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.time.format.TextStyle;
import java.util.LinkedHashMap;
import java.util.Locale;
import java.util.Map;

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
import org.springframework.transaction.annotation.Transactional;
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

import studentplatform.student_platform.model.Admin;
import studentplatform.student_platform.model.Club;
import studentplatform.student_platform.model.Event;
import studentplatform.student_platform.model.ClubParticipation;
import studentplatform.student_platform.service.ClubService;
import studentplatform.student_platform.service.EventService;



@Controller
public class WebController {

    private final StudentService studentService;
    private final StaffService staffService;
    private final RewardService rewardService;
    private final RewardExchangeService rewardExchangeService;
    private final AdminService adminService;
    private final ClubService clubService;
    private final EventService eventService;
    
    @Autowired
    public WebController(StudentService studentService, StaffService staffService, 
                         RewardService rewardService, RewardExchangeService rewardExchangeService,
                         AdminService adminService, ClubService clubService,
                         EventService eventService) {
        this.studentService = studentService;
        this.staffService = staffService;
        this.rewardService = rewardService;
        this.rewardExchangeService = rewardExchangeService;
        this.adminService = adminService;
        this.clubService = clubService;
        this.eventService = eventService;
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
        // Remove or update this line to use student points instead
        // model.addAttribute("pointCount", pointService.getAllPoints().size());
        
        return "home";
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
    public String deleteStudent(@PathVariable Long id) {
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
    public String deleteStaff(@PathVariable Long id) {
        staffService.deleteStaff(id);
        return "redirect:/staff";
    }
    
    // Rewards Management
    @GetMapping("/rewards")
    public String rewards(Model model, @RequestParam(required = false) String keyword) {
        if (keyword != null && !keyword.isEmpty()) {
            model.addAttribute("rewards", rewardService.searchRewardsByKeyword(keyword));
        } else {
            model.addAttribute("rewards", rewardService.getAllRewards());
        }
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
    public String deleteReward(@PathVariable Long id) {
        rewardService.deleteReward(id);
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
    public String approveStudentRegistration(@RequestParam String studentId) {
        studentService.approveRegistration(studentId);
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
                                     @RequestParam String entityId,
                                     Model model) {
        
        // Validate passwords match
        if (!password.equals(confirmPassword)) {
            model.addAttribute("error", "Passwords do not match");
            return "register";
        }
        
        // Check if username already exists in either Student or Staff
        if (role.equals("STUDENT")) {
            if (studentService.findByUsername(username).isPresent()) {
                model.addAttribute("error", "Username already exists");
                return "register";
            }
            
            // Create new student with pending status
            Student student = new Student();
            student.setUsername(username);
            String Stuhashpasword=studentService.hashPassword(password);
            student.setPassword(Stuhashpasword); 
            student.setEmail(email);
            student.setStudentId((entityId)); // Store the requested ID
            student.setStatus(Student.AccountStatus.PENDING);
            
            // Set default values for required fields
            student.setFirstName("Pending");
            student.setLastName("Approval");
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
            staff.setStaffId(entityId); // Store the requested ID
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
    
    // Admin Club Management
    @GetMapping("/admin/clubs")
    public String adminClubs(Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        model.addAttribute("clubs", clubService.getAllClubs());
        return "admin/clubs";
    }
    
    @GetMapping("/admin/clubs/create")
    public String createClubForm(Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        model.addAttribute("club", new Club());
        return "admin/club-form";
    }
    
    @PostMapping("/admin/clubs/save")
    public String saveClub(@Valid @ModelAttribute("club") Club club, BindingResult result, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        if (result.hasErrors()) {
            return "admin/club-form";
        }
        
        clubService.saveClub(club);
        return "redirect:/admin/clubs";
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
                    return "admin/club-form";
                })
                .orElse("redirect:/admin/clubs");
    }
    
    @GetMapping("/admin/clubs/view/{id}")
    public String viewClub(@PathVariable Long id, Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        return clubService.getClubById(id)
                .map(club -> {
                    model.addAttribute("club", club);
                    model.addAttribute("pendingParticipations", clubService.getPendingParticipationsByClub(club));
                    model.addAttribute("approvedParticipations", clubService.getApprovedParticipationsByClub(club));
                    return "admin/club-view";
                })
                .orElse("redirect:/admin/clubs");
    }
    
    @GetMapping("/admin/clubs/delete/{id}")
    public String deleteClub(@PathVariable Long id, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        clubService.deleteClub(id);
        return "redirect:/admin/clubs";
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
    
    // Admin Participation Management
    @GetMapping("/admin/club-participations")
    public String clubParticipations(Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        model.addAttribute("pendingParticipations", clubService.getPendingParticipations());
        return "admin/club-participations";
    }
    
    @GetMapping("/admin/event-participations")
    public String eventParticipations(Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        model.addAttribute("pendingParticipations", eventService.getPendingParticipations());
        return "admin/event-participations";
    }
    
    @PostMapping("/admin/approve-club-participation/{id}")
    public String approveClubParticipation(@PathVariable Long id, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        clubService.approveParticipation(id, admin);
        return "redirect:/admin/club-participations";
    }
    
    @PostMapping("/admin/reject-club-participation/{id}")
    public String rejectClubParticipation(@PathVariable Long id, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        clubService.rejectParticipation(id, admin);
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
    
    // Award points for club participation
    @PostMapping("/admin/award-club-points/{id}")
    public String awardClubPoints(@PathVariable Long id,
                                 @RequestParam("pointValue") int pointValue,
                                 @RequestParam("reason") String reason,
                                 HttpSession session) {
        Admin admin = (Admin) session.getAttribute("user");
        if (admin == null) {
            return "redirect:/login";
        }
        
        clubService.getClubById(id).ifPresent(club -> {
            // Get all approved participations for this club
            List<ClubParticipation> participations = clubService.getPendingParticipationsByClub(club);
            for (ClubParticipation participation : participations) {
                if (participation.getStatus() == ClubParticipation.ParticipationStatus.APPROVED && 
                    !participation.isPointsAwarded()) {
                    clubService.awardPointsForParticipation(participation, pointValue, reason);
                }
            }
        });
        
        return "redirect:/admin/clubs/view/" + id;
    }
    
    // Student Club and Event Interface
    @GetMapping("/clubs")
    public String studentClubs(Model model) {
        model.addAttribute("clubs", clubService.getAllClubs());
        return "clubs/list";
    }
    
    @GetMapping("/events")
    public String studentEvents(Model model) {
        model.addAttribute("events", eventService.getAllEvents());
        return "events/list";
    }
    
    @GetMapping("/clubs/view/{id}")
    public String viewClubForStudent(@PathVariable Long id, Model model, HttpSession session) {
        Student student = (Student) session.getAttribute("user");
        if (student == null) {
            return "redirect:/login";
        }
        
        return clubService.getClubById(id)
                .map(club -> {
                    model.addAttribute("club", club);
                    // Check if student is already a member
                    model.addAttribute("isJoined", clubService.getPendingParticipationsByClub(club).stream()
                            .anyMatch(p -> p.getStudent().getId().equals(student.getId())));
                    return "clubs/view";
                })
                .orElse("redirect:/clubs");
    }
    
    @GetMapping("/events/view/{id}")
    public String viewEventForStudent(@PathVariable Long id, Model model, HttpSession session) {
        Student student = (Student) session.getAttribute("user");
        if (student == null) {
            return "redirect:/login";
        }
        
        return eventService.getEventById(id)
                .map(event -> {
                    model.addAttribute("event", event);
                    // Check if student is already registered
                    model.addAttribute("isRegistered", eventService.getPendingParticipationsByEvent(event).stream()
                            .anyMatch(p -> p.getStudent().getId().equals(student.getId())));
                    return "events/view";
                })
                .orElse("redirect:/events");
    }
    
    @PostMapping("/clubs/join/{id}")
    public String joinClub(@PathVariable Long id, HttpSession session) {
        Student student = (Student) session.getAttribute("user");
        if (student == null) {
            return "redirect:/login";
        }
        
        clubService.getClubById(id).ifPresent(club -> {
            clubService.joinClub(student, club);
        });
        
        return "redirect:/clubs/view/" + id;
    }
    
    @PostMapping("/events/register/{id}")
    public String registerForEvent(@PathVariable Long id, HttpSession session) {
        Student student = (Student) session.getAttribute("user");
        if (student == null) {
            return "redirect:/login";
        }
        
        eventService.getEventById(id).ifPresent(event -> {
            eventService.registerForEvent(student, event);
        });
        
        return "redirect:/events/view/" + id;
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
                    List<Reward> availableRewards = rewardService.getAllRewards().stream()
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
                    
                    model.addAttribute("chartLabels", new ArrayList<>(monthlyPoints.keySet()));
                    model.addAttribute("chartData", new ArrayList<>(monthlyPoints.values()));
                    
                    // Placeholder for clubs and events (to be implemented)
                    model.addAttribute("clubsCount", 0);
                    model.addAttribute("eventsCount", 0);
                    model.addAttribute("clubs", new ArrayList<>());
                    model.addAttribute("upcomingEvents", new ArrayList<>());
                    
                    return "students/dashboard";
                })
                .orElse("redirect:/students");
    }


        
       
    // Reward Catalog - Show available rewards that students can exchange points for
    @GetMapping("/students/rewards/catalog")
    public String rewardCatalog(Model model, HttpSession session) {
        Student student = (Student) session.getAttribute("user");
        if (student == null) {
            return "redirect:/login";
        }
        
        // Get all available rewards
        List<Reward> allRewards = rewardService.getAllRewards();
        
        // Add student's current points to the model
        model.addAttribute("student", student);
        model.addAttribute("rewards", allRewards);
        
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
    
    
    
}