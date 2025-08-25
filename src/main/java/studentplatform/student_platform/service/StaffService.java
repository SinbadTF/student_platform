package studentplatform.student_platform.service;

import org.hibernate.Hibernate;

import org.springframework.stereotype.Service;


import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import studentplatform.student_platform.model.Staff;

import studentplatform.student_platform.repository.StaffRepository;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class StaffService {

    private final StaffRepository staffRepository;
    private final StudentService studentService;


    public List<Staff> getAllStaff() {
        return staffRepository.findAll();
    }

    public Optional<Staff> getStaffById(Long id) {
        return staffRepository.findById(id);
    }

    public Optional<Staff> getStaffByStaffId(String staffId) {
        return staffRepository.findByStaffId(staffId);
    }

    public Optional<Staff> getStaffByEmail(String email) {
        return staffRepository.findByEmail(email);
    }

    public List<Staff> getStaffByDepartment(String department) {
        return staffRepository.findByDepartment(department);
    }

    public List<Staff> getStaffByPosition(String position) {
        return staffRepository.findByPosition(position);
    }

    public List<Staff> searchStaffByName(String keyword) {
        return staffRepository.searchByName(keyword);
    }

    public Staff saveStaff(Staff staff) {
        return staffRepository.save(staff);
    }

    public void deleteStaff(Long id) {
        staffRepository.deleteById(id);
    }
    public Optional<Staff> findByStaffId(String staffId) {
    return staffRepository.findByStaffId(staffId);
}

    public boolean authStaff(String username, String password) {
        Optional<Staff> staff = this.staffRepository.findByUsername(username);
        if (staff.isPresent()) {
            // Compare the hashed password
            String hashedPassword = studentService.hashPassword(password);
            return staff.get().getPassword().equals(hashedPassword);
        }
        return false;
    }
    public Optional<Staff> findByUsername(String username) {
        return staffRepository.findByUsername(username);
    }

    // Add these methods to StaffService
    public List<Staff> findByStatus(Staff.AccountStatus status) {
        return staffRepository.findByStatus(status);
    }
    
    public void approveStaff(Long id) {
        Optional<Staff> staffOpt = staffRepository.findById(id);
        if (staffOpt.isPresent()) {
            Staff staff = staffOpt.get();
            staff.setStatus(Staff.AccountStatus.APPROVED);
            staffRepository.save(staff);
        }
    }
    
    public void rejectStaff(Long id) {
        Optional<Staff> staffOpt = staffRepository.findById(id);
        if (staffOpt.isPresent()) {
            Staff staff = staffOpt.get();
            staff.setStatus(Staff.AccountStatus.REJECTED);
            staffRepository.save(staff);
        }
    }

    public void approveRegistration(Long id) {
        Optional<Staff> staffOpt = staffRepository.findById(id);
        if (staffOpt.isPresent()) {
            Staff staff = staffOpt.get();
            staff.setStatus(Staff.AccountStatus.APPROVED);
            staffRepository.save(staff);
        }
    }

    @Transactional(readOnly = true)
    public Staff getStaffWithRewards(String username) {
        Optional<Staff> staffOpt = staffRepository.findByUsername(username);
        if (staffOpt.isPresent()) {
            Staff staff = staffOpt.get();
            // Force initialization of the rewards collection
            if (staff.getRewards() != null) {
                staff.getRewards().size();
            }
            return staff;
        }
        return null;
    }
}
