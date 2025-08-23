package studentplatform.student_platform.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.format.FormatterRegistry;
import org.springframework.format.datetime.standard.DateTimeFormatterRegistrar;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.time.format.DateTimeFormatter;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Autowired
    private AuthInterceptor authInterceptor;
    
    @Autowired
    private LocalDateTimeConverter localDateTimeConverter;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // Map webapp resources
        registry.addResourceHandler("/resources/**")
                .addResourceLocations("/resources/");
                
        // Map classpath static resources
        registry.addResourceHandler("/static/**")
                .addResourceLocations("classpath:/static/");
                
        // Map swagger UI resources
        registry.addResourceHandler("/swagger-ui/**")
                .addResourceLocations("classpath:/META-INF/resources/webjars/springdoc-openapi-ui/")
                .resourceChain(false);
    }
    
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(authInterceptor);
    }
    
    @Override
    public void addFormatters(FormatterRegistry registry) {
        // Register the LocalDateTime to Date converter
        registry.addConverter(localDateTimeConverter);
        
        // Keep the existing formatter registration
        DateTimeFormatterRegistrar registrar = new DateTimeFormatterRegistrar();
        registrar.setDateTimeFormatter(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
        registrar.registerFormatters(registry);
    }
}
