package studentplatform.student_platform.config;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class AuthInterceptor implements HandlerInterceptor {

    // Define URL patterns and required roles
    private final Map<String, List<String>> protectedUrls = new HashMap<>();
    
    public AuthInterceptor() {
        // URLs accessible by ADMIN only
        protectedUrls.put("/admin/", Arrays.asList("ADMIN"));
        
        // URLs accessible by STAFF and ADMIN
        protectedUrls.put("/staff/", Arrays.asList("STAFF", "ADMIN"));
        protectedUrls.put("/rewards/create", Arrays.asList("STAFF", "ADMIN"));
        protectedUrls.put("/rewards/edit/", Arrays.asList("STAFF", "ADMIN"));
        protectedUrls.put("/points/create", Arrays.asList("STAFF", "ADMIN"));
        
        // URLs accessible by all authenticated users
        protectedUrls.put("/students/", Arrays.asList("STUDENT", "STAFF", "ADMIN"));
        protectedUrls.put("/rewards/", Arrays.asList("STUDENT", "STAFF", "ADMIN"));
        protectedUrls.put("/points/", Arrays.asList("STUDENT", "STAFF", "ADMIN"));
    }
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String requestURI = request.getRequestURI();
        
        // Allow access to login page, registration, and static resources
        if (requestURI.equals("/login") || requestURI.equals("/") || requestURI.startsWith("/static/") || requestURI.equals("/register")) {
            return true;
        }
        
        // Check if user is authenticated
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("/login");
            return false;
        }
        
        // Get user role from session
        String userRole = (String) session.getAttribute("userRole");
        
        // Check if user account is pending (redirect to pending page)
        Boolean isPending = (Boolean) session.getAttribute("isPending");
        if (isPending != null && isPending && !requestURI.equals("/pending")) {
            response.sendRedirect("/pending");
            return false;
        }
        
        // Check if URL is protected
        for (Map.Entry<String, List<String>> entry : protectedUrls.entrySet()) {
            if (requestURI.startsWith(entry.getKey())) {
                // Check if user has required role
                if (!entry.getValue().contains(userRole)) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
                    return false;
                }
                break;
            }
        }
        
        return true;
    }
}