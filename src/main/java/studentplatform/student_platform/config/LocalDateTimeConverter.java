package studentplatform.student_platform.config;

import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Component
public class LocalDateTimeConverter implements Converter<String, LocalDateTime> {

    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

    @Override
    public LocalDateTime convert(String source) {
        if (source == null) {
            return null;
        }
        String trimmed = source.trim();
        if (trimmed.isEmpty()) {
            return null;
        }
        return LocalDateTime.parse(trimmed, FORMATTER);
    }
}