package studentplatform.student_platform.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

// @Component  // Commented out after first run
public class DatabaseFixer implements CommandLineRunner {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public void run(String... args) throws Exception {
        try {
            // Check if itemColor column exists
            String checkColumn = "SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS " +
                    "WHERE TABLE_SCHEMA = DATABASE() " +
                    "AND TABLE_NAME = 'spin_wheel_items' " +
                    "AND COLUMN_NAME = 'item_color'";
            
            Integer columnExists = jdbcTemplate.queryForObject(checkColumn, Integer.class);
            
            if (columnExists == 0) {
                System.out.println("Adding missing columns to spin_wheel_items table...");
                
                // Add item_color column
                jdbcTemplate.execute("ALTER TABLE spin_wheel_items ADD COLUMN item_color VARCHAR(7) DEFAULT '#007bff'");
                
                // Add icon column
                jdbcTemplate.execute("ALTER TABLE spin_wheel_items ADD COLUMN icon VARCHAR(50) DEFAULT 'bi-star'");
                
                // Add item_type column
                jdbcTemplate.execute("ALTER TABLE spin_wheel_items ADD COLUMN item_type VARCHAR(50) DEFAULT 'POINTS'");
                
                // Update existing records
                jdbcTemplate.execute("UPDATE spin_wheel_items SET item_color = '#007bff' WHERE item_color IS NULL");
                jdbcTemplate.execute("UPDATE spin_wheel_items SET icon = 'bi-star' WHERE icon IS NULL");
                jdbcTemplate.execute("UPDATE spin_wheel_items SET item_type = 'POINTS' WHERE item_type IS NULL");
                
                System.out.println("Database schema updated successfully!");
            } else {
                System.out.println("Database schema is already up to date.");
            }
            
        } catch (Exception e) {
            System.err.println("Error updating database schema: " + e.getMessage());
        }
    }
}
