package studentplatform.student_platform;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.jdbc.core.JdbcTemplate;

import static org.junit.jupiter.api.Assertions.assertNotNull;

@SpringBootTest
class StudentPlatformApplicationTests {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Test
	void contextLoads() {
	}

	@Test
	void testDatabaseConnection() {
		assertNotNull(jdbcTemplate);
		Integer result = jdbcTemplate.queryForObject("SELECT 1", Integer.class);
		assertNotNull(result);
	}
}
