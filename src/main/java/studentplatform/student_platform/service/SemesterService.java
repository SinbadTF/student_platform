package studentplatform.student_platform.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import studentplatform.student_platform.model.Semester;
import studentplatform.student_platform.repository.SemesterRepository;

import java.util.List;
import java.util.Optional;


@Service
public class SemesterService {
    @Autowired
    private SemesterRepository semesterRepository;
    
   
    
    public Semester createOrUpdateSemester(String name, Integer year, boolean active) { // Change to String
        Optional<Semester> existingSemester = semesterRepository.findByNameAndYear(name, year);
        
        if (existingSemester.isPresent()) {
            Semester semester = existingSemester.get();
            semester.setActive(active);
            return semesterRepository.save(semester);
        } else {
            Semester semester = new Semester();
            semester.setName(name);
            semester.setYear(year);
            semester.setActive(active);
            return semesterRepository.save(semester);
        }
    }



    public Optional<Semester> getSemesterByName(String name) {
        return semesterRepository.findByName(name);
    }

    public Optional<Semester> getSemesterByNameAndYear(String name, Integer year) {
        return semesterRepository.findByNameAndYear(name, year);
    }
    public List<Semester> getAllSemesters() {
        return semesterRepository.findAll();
    }


    public Optional<Semester> getSemesterById(Long id) {
        return semesterRepository.findById(id);
    }
    public Semester saveSemester(Semester semester) {
        return semesterRepository.save(semester);
    }
    public void deleteSemester(Long id) {
        semesterRepository.deleteById(id);
    }
}