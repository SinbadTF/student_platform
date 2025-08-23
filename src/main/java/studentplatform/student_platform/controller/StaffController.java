package studentplatform.student_platform.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import studentplatform.student_platform.model.Staff;
import studentplatform.student_platform.service.StaffService;

import jakarta.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/api/staff")
public class StaffController {

    private final StaffService staffService;

    @Autowired
    public StaffController(StaffService staffService) {
        this.staffService = staffService;
    }

    @GetMapping
    public ResponseEntity<List<Staff>> getAllStaff() {
        return ResponseEntity.ok(staffService.getAllStaff());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Staff> getStaffById(@PathVariable Long id) {
        return staffService.getStaffById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/staffId/{staffId}")
    public ResponseEntity<Staff> getStaffByStaffId(@PathVariable String staffId) {
        return staffService.getStaffByStaffId(staffId)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/email/{email}")
    public ResponseEntity<Staff> getStaffByEmail(@PathVariable String email) {
        return staffService.getStaffByEmail(email)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/department/{department}")
    public ResponseEntity<List<Staff>> getStaffByDepartment(@PathVariable String department) {
        List<Staff> staffList = staffService.getStaffByDepartment(department);
        return staffList.isEmpty() ? ResponseEntity.noContent().build() : ResponseEntity.ok(staffList);
    }

    @GetMapping("/position/{position}")
    public ResponseEntity<List<Staff>> getStaffByPosition(@PathVariable String position) {
        List<Staff> staffList = staffService.getStaffByPosition(position);
        return staffList.isEmpty() ? ResponseEntity.noContent().build() : ResponseEntity.ok(staffList);
    }

    @GetMapping("/search")
    public ResponseEntity<List<Staff>> searchStaff(@RequestParam String keyword) {
        List<Staff> staffList = staffService.searchStaffByName(keyword);
        return staffList.isEmpty() ? ResponseEntity.noContent().build() : ResponseEntity.ok(staffList);
    }

    @PostMapping
    public ResponseEntity<Staff> createStaff(@Valid @RequestBody Staff staff) {
        Staff savedStaff = staffService.saveStaff(staff);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedStaff);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Staff> updateStaff(@PathVariable Long id, @Valid @RequestBody Staff staff) {
        return staffService.getStaffById(id)
                .map(existingStaff -> {
                    staff.setId(id);
                    return ResponseEntity.ok(staffService.saveStaff(staff));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteStaff(@PathVariable Long id) {
        return staffService.getStaffById(id)
                .map(staff -> {
                    staffService.deleteStaff(id);
                    return ResponseEntity.noContent().<Void>build();
                })
                .orElse(ResponseEntity.notFound().build());
    }
}