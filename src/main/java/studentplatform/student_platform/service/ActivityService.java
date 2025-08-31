package studentplatform.student_platform.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import studentplatform.student_platform.model.Activity;
import studentplatform.student_platform.model.Admin;
import studentplatform.student_platform.model.Club;
import studentplatform.student_platform.repository.ActivityRepository;
import studentplatform.student_platform.repository.ClubRepository;

import java.util.List;
import java.util.Optional;

@Service
public class ActivityService {

    @Autowired
    private ActivityRepository activityRepository;

    @Autowired
    private ClubRepository clubRepository;

    public Activity createActivity(Activity activity, Admin admin) {
        activity.setCreatedBy(admin);
        return activityRepository.save(activity);
    }

    public List<Activity> getAllActivities() {
        return activityRepository.findAll();
    }

    public List<Activity> getActivitiesByClub(Club club) {
        return activityRepository.findByClubId(club.getId());
    }

    public List<Activity> getActivitiesByAdmin(Admin admin) {
        return activityRepository.findByCreatedById(admin.getId());
    }

    public Optional<Activity> getActivityById(Long id) {
        return activityRepository.findById(id);
    }

    public List<Activity> searchActivitiesByTitle(String title) {
        return activityRepository.findByTitleContainingIgnoreCase(title);
    }

    public Activity updateActivity(Activity activity) {
        return activityRepository.save(activity);
    }

    public void deleteActivity(Long id) {
        activityRepository.deleteById(id);
    }

    public Optional<Club> getClubById(Long clubId) {
        return clubRepository.findById(clubId);
    }
}
