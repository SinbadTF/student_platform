package studentplatform.student_platform.util;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

public class DateTimeUtil {

    /**
     * Converts a LocalDateTime object to a java.util.Date object
     * 
     * @param localDateTime the LocalDateTime to convert
     * @return a java.util.Date object
     */
    public static Date toDate(LocalDateTime localDateTime) {
        if (localDateTime == null) {
            return null;
        }
        return Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant());
    }
}