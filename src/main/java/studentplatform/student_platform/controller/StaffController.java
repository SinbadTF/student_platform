package studentplatform.student_platform.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

import studentplatform.student_platform.model.Reward;
import studentplatform.student_platform.model.RewardExchange;
import studentplatform.student_platform.model.Staff;
import studentplatform.student_platform.service.RewardExchangeService;
import studentplatform.student_platform.service.RewardService;
import studentplatform.student_platform.service.StaffService;

import java.time.LocalDateTime;
import java.util.List;

@Controller
@RequestMapping("/staff")
public class StaffController {

    private final StaffService staffService;
    private final RewardService rewardService;
    private final RewardExchangeService rewardExchangeService;

    @Autowired
    public StaffController(StaffService staffService, RewardService rewardService, 
                          RewardExchangeService rewardExchangeService) {
        this.staffService = staffService;
        this.rewardService = rewardService;
        this.rewardExchangeService = rewardExchangeService;
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model, HttpSession session) {
        Staff staff = (Staff) session.getAttribute("user");
        if (staff == null) {
            return "redirect:/login";
        }
        
        // Get rewards created by this staff member
        List<Reward> createdRewards = rewardService.getRewardsByStaff(staff);
        model.addAttribute("createdRewards", createdRewards);
        
        // Get pending reward exchanges for staff to process
        List<RewardExchange> pendingExchanges = rewardExchangeService.getExchangesByStatus("REDEEMED");
        model.addAttribute("pendingExchanges", pendingExchanges);
        
        // Get fulfilled exchanges by this staff member
        List<RewardExchange> fulfilledExchanges = rewardExchangeService.getExchangesFulfilledByStaff(staff);
        model.addAttribute("fulfilledExchanges", fulfilledExchanges);
        
        model.addAttribute("staff", staff);
        return "staff/dashboard";
    }
    
    @GetMapping("/rewards/create")
    public String createRewardForm(Model model, HttpSession session) {
        Staff staff = (Staff) session.getAttribute("user");
        if (staff == null) {
            return "redirect:/login";
        }
        
        model.addAttribute("reward", new Reward());
        model.addAttribute("staff", staff);
        return "staff/rewards/form";
    }
    
    @PostMapping("/rewards/save")
    public String saveReward(@Valid @ModelAttribute("reward") Reward reward, 
                           BindingResult result, 
                           HttpSession session,
                           RedirectAttributes redirectAttributes) {
        Staff staff = (Staff) session.getAttribute("user");
        if (staff == null) {
            return "redirect:/login";
        }
        
        if (result.hasErrors()) {
            return "staff/rewards/form";
        }
        
        reward.setIssuedBy(staff);
        rewardService.saveReward(reward);
        redirectAttributes.addFlashAttribute("success", "Reward created successfully!");
        return "redirect:/staff/dashboard";
    }
    
    @GetMapping("/rewards/exchanges")
    public String viewExchanges(Model model, HttpSession session) {
        Staff staff = (Staff) session.getAttribute("user");
        if (staff == null) {
            return "redirect:/login";
        }
        
        List<RewardExchange> pendingExchanges = rewardExchangeService.getExchangesByStatus("REDEEMED");
        model.addAttribute("pendingExchanges", pendingExchanges);
        model.addAttribute("staff", staff);
        return "staff/rewards/exchanges";
    }
    
    @PostMapping("/rewards/fulfill/{exchangeId}")
    public String fulfillReward(@PathVariable Long exchangeId,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {
        Staff staff = (Staff) session.getAttribute("user");
        if (staff == null) {
            return "redirect:/login";
        }
        
        try {
            rewardExchangeService.fulfillReward(exchangeId, staff);
            redirectAttributes.addFlashAttribute("success", "Reward exchange fulfilled successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error fulfilling reward: " + e.getMessage());
        }
        
        return "redirect:/staff/rewards/exchanges";
    }
}